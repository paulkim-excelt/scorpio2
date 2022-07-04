

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


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_TCAM_POLICY_tcam_policy_0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' vport_index                                [3:0]            get_vport_index
''                                                             set_vport_index
''                                                             read_vport_index
''                                                             write_vport_index
''---------------------------------------------------------------------------------
'' prio                                       [29:27]          get_prio
''                                                             set_prio
''                                                             read_prio
''                                                             write_prio
''---------------------------------------------------------------------------------
'' drop                                       [30:30]          get_drop
''                                                             set_drop
''                                                             read_drop
''                                                             write_drop
''---------------------------------------------------------------------------------
'' control_pkt                                [31:31]          get_control_pkt
''                                                             set_control_pkt
''                                                             read_control_pkt
''                                                             write_control_pkt
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_TCAM_POLICY_tcam_policy_0
    Private write_vport_index_value
    Private read_vport_index_value
    Private flag_vport_index
    Private write_prio_value
    Private read_prio_value
    Private flag_prio
    Private write_drop_value
    Private read_drop_value
    Private flag_drop
    Private write_control_pkt_value
    Private read_control_pkt_value
    Private flag_control_pkt

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3000
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_vport_index
        get_vport_index = read_vport_index_value
    End Property

    Property Let set_vport_index(aData)
        write_vport_index_value = aData
        flag_vport_index        = &H1
    End Property

    Property Get read_vport_index
        read
        read_vport_index = read_vport_index_value
    End Property

    Property Let write_vport_index(aData)
        set_vport_index = aData
        write
    End Property

    Property Get get_prio
        get_prio = read_prio_value
    End Property

    Property Let set_prio(aData)
        write_prio_value = aData
        flag_prio        = &H1
    End Property

    Property Get read_prio
        read
        read_prio = read_prio_value
    End Property

    Property Let write_prio(aData)
        set_prio = aData
        write
    End Property

    Property Get get_drop
        get_drop = read_drop_value
    End Property

    Property Let set_drop(aData)
        write_drop_value = aData
        flag_drop        = &H1
    End Property

    Property Get read_drop
        read
        read_drop = read_drop_value
    End Property

    Property Let write_drop(aData)
        set_drop = aData
        write
    End Property

    Property Get get_control_pkt
        get_control_pkt = read_control_pkt_value
    End Property

    Property Let set_control_pkt(aData)
        write_control_pkt_value = aData
        flag_control_pkt        = &H1
    End Property

    Property Get read_control_pkt
        read
        read_control_pkt = read_control_pkt_value
    End Property

    Property Let write_control_pkt(aData)
        set_control_pkt = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        vport_index_mask = &Hf
        if data_low > LONG_MAX then
            if vport_index_mask = mask then
                read_vport_index_value = data_low
            else
                read_vport_index_value = (data_low - H8000_0000) and vport_index_mask
            end If
        else
            read_vport_index_value = data_low and vport_index_mask
        end If
        read_prio_value = rightShift(data_low, 27) and &H7
        read_drop_value = rightShift(data_low, 30) and &H1
        read_control_pkt_value = rightShift(data_low, 31) and &H1

    End Sub

    Sub write
        If flag_vport_index = &H0 or flag_prio = &H0 or flag_drop = &H0 or flag_control_pkt = &H0 Then read
        If flag_vport_index = &H0 Then write_vport_index_value = get_vport_index
        If flag_prio = &H0 Then write_prio_value = get_prio
        If flag_drop = &H0 Then write_drop_value = get_drop
        If flag_control_pkt = &H0 Then write_control_pkt_value = get_control_pkt

        regValue = leftShift((write_vport_index_value and &Hf), 0) + leftShift((write_prio_value and &H7), 27) + leftShift((write_drop_value and &H1), 30) + leftShift((write_control_pkt_value and &H1), 31)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        vport_index_mask = &Hf
        if data_low > LONG_MAX then
            if vport_index_mask = mask then
                read_vport_index_value = data_low
            else
                read_vport_index_value = (data_low - H8000_0000) and vport_index_mask
            end If
        else
            read_vport_index_value = data_low and vport_index_mask
        end If
        read_prio_value = rightShift(data_low, 27) and &H7
        read_drop_value = rightShift(data_low, 30) and &H1
        read_control_pkt_value = rightShift(data_low, 31) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_vport_index_value = &H0
        flag_vport_index        = &H0
        write_prio_value = &H0
        flag_prio        = &H0
        write_drop_value = &H0
        flag_drop        = &H0
        write_control_pkt_value = &H0
        flag_control_pkt        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_TCAM_POLICY_tcam_policy_1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' vport_index                                [3:0]            get_vport_index
''                                                             set_vport_index
''                                                             read_vport_index
''                                                             write_vport_index
''---------------------------------------------------------------------------------
'' prio                                       [29:27]          get_prio
''                                                             set_prio
''                                                             read_prio
''                                                             write_prio
''---------------------------------------------------------------------------------
'' drop                                       [30:30]          get_drop
''                                                             set_drop
''                                                             read_drop
''                                                             write_drop
''---------------------------------------------------------------------------------
'' control_pkt                                [31:31]          get_control_pkt
''                                                             set_control_pkt
''                                                             read_control_pkt
''                                                             write_control_pkt
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_TCAM_POLICY_tcam_policy_1
    Private write_vport_index_value
    Private read_vport_index_value
    Private flag_vport_index
    Private write_prio_value
    Private read_prio_value
    Private flag_prio
    Private write_drop_value
    Private read_drop_value
    Private flag_drop
    Private write_control_pkt_value
    Private read_control_pkt_value
    Private flag_control_pkt

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3004
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_vport_index
        get_vport_index = read_vport_index_value
    End Property

    Property Let set_vport_index(aData)
        write_vport_index_value = aData
        flag_vport_index        = &H1
    End Property

    Property Get read_vport_index
        read
        read_vport_index = read_vport_index_value
    End Property

    Property Let write_vport_index(aData)
        set_vport_index = aData
        write
    End Property

    Property Get get_prio
        get_prio = read_prio_value
    End Property

    Property Let set_prio(aData)
        write_prio_value = aData
        flag_prio        = &H1
    End Property

    Property Get read_prio
        read
        read_prio = read_prio_value
    End Property

    Property Let write_prio(aData)
        set_prio = aData
        write
    End Property

    Property Get get_drop
        get_drop = read_drop_value
    End Property

    Property Let set_drop(aData)
        write_drop_value = aData
        flag_drop        = &H1
    End Property

    Property Get read_drop
        read
        read_drop = read_drop_value
    End Property

    Property Let write_drop(aData)
        set_drop = aData
        write
    End Property

    Property Get get_control_pkt
        get_control_pkt = read_control_pkt_value
    End Property

    Property Let set_control_pkt(aData)
        write_control_pkt_value = aData
        flag_control_pkt        = &H1
    End Property

    Property Get read_control_pkt
        read
        read_control_pkt = read_control_pkt_value
    End Property

    Property Let write_control_pkt(aData)
        set_control_pkt = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        vport_index_mask = &Hf
        if data_low > LONG_MAX then
            if vport_index_mask = mask then
                read_vport_index_value = data_low
            else
                read_vport_index_value = (data_low - H8000_0000) and vport_index_mask
            end If
        else
            read_vport_index_value = data_low and vport_index_mask
        end If
        read_prio_value = rightShift(data_low, 27) and &H7
        read_drop_value = rightShift(data_low, 30) and &H1
        read_control_pkt_value = rightShift(data_low, 31) and &H1

    End Sub

    Sub write
        If flag_vport_index = &H0 or flag_prio = &H0 or flag_drop = &H0 or flag_control_pkt = &H0 Then read
        If flag_vport_index = &H0 Then write_vport_index_value = get_vport_index
        If flag_prio = &H0 Then write_prio_value = get_prio
        If flag_drop = &H0 Then write_drop_value = get_drop
        If flag_control_pkt = &H0 Then write_control_pkt_value = get_control_pkt

        regValue = leftShift((write_vport_index_value and &Hf), 0) + leftShift((write_prio_value and &H7), 27) + leftShift((write_drop_value and &H1), 30) + leftShift((write_control_pkt_value and &H1), 31)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        vport_index_mask = &Hf
        if data_low > LONG_MAX then
            if vport_index_mask = mask then
                read_vport_index_value = data_low
            else
                read_vport_index_value = (data_low - H8000_0000) and vport_index_mask
            end If
        else
            read_vport_index_value = data_low and vport_index_mask
        end If
        read_prio_value = rightShift(data_low, 27) and &H7
        read_drop_value = rightShift(data_low, 30) and &H1
        read_control_pkt_value = rightShift(data_low, 31) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_vport_index_value = &H0
        flag_vport_index        = &H0
        write_prio_value = &H0
        flag_prio        = &H0
        write_drop_value = &H0
        flag_drop        = &H0
        write_control_pkt_value = &H0
        flag_control_pkt        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_TCAM_POLICY_tcam_policy_2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' vport_index                                [3:0]            get_vport_index
''                                                             set_vport_index
''                                                             read_vport_index
''                                                             write_vport_index
''---------------------------------------------------------------------------------
'' prio                                       [29:27]          get_prio
''                                                             set_prio
''                                                             read_prio
''                                                             write_prio
''---------------------------------------------------------------------------------
'' drop                                       [30:30]          get_drop
''                                                             set_drop
''                                                             read_drop
''                                                             write_drop
''---------------------------------------------------------------------------------
'' control_pkt                                [31:31]          get_control_pkt
''                                                             set_control_pkt
''                                                             read_control_pkt
''                                                             write_control_pkt
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_TCAM_POLICY_tcam_policy_2
    Private write_vport_index_value
    Private read_vport_index_value
    Private flag_vport_index
    Private write_prio_value
    Private read_prio_value
    Private flag_prio
    Private write_drop_value
    Private read_drop_value
    Private flag_drop
    Private write_control_pkt_value
    Private read_control_pkt_value
    Private flag_control_pkt

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3008
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_vport_index
        get_vport_index = read_vport_index_value
    End Property

    Property Let set_vport_index(aData)
        write_vport_index_value = aData
        flag_vport_index        = &H1
    End Property

    Property Get read_vport_index
        read
        read_vport_index = read_vport_index_value
    End Property

    Property Let write_vport_index(aData)
        set_vport_index = aData
        write
    End Property

    Property Get get_prio
        get_prio = read_prio_value
    End Property

    Property Let set_prio(aData)
        write_prio_value = aData
        flag_prio        = &H1
    End Property

    Property Get read_prio
        read
        read_prio = read_prio_value
    End Property

    Property Let write_prio(aData)
        set_prio = aData
        write
    End Property

    Property Get get_drop
        get_drop = read_drop_value
    End Property

    Property Let set_drop(aData)
        write_drop_value = aData
        flag_drop        = &H1
    End Property

    Property Get read_drop
        read
        read_drop = read_drop_value
    End Property

    Property Let write_drop(aData)
        set_drop = aData
        write
    End Property

    Property Get get_control_pkt
        get_control_pkt = read_control_pkt_value
    End Property

    Property Let set_control_pkt(aData)
        write_control_pkt_value = aData
        flag_control_pkt        = &H1
    End Property

    Property Get read_control_pkt
        read
        read_control_pkt = read_control_pkt_value
    End Property

    Property Let write_control_pkt(aData)
        set_control_pkt = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        vport_index_mask = &Hf
        if data_low > LONG_MAX then
            if vport_index_mask = mask then
                read_vport_index_value = data_low
            else
                read_vport_index_value = (data_low - H8000_0000) and vport_index_mask
            end If
        else
            read_vport_index_value = data_low and vport_index_mask
        end If
        read_prio_value = rightShift(data_low, 27) and &H7
        read_drop_value = rightShift(data_low, 30) and &H1
        read_control_pkt_value = rightShift(data_low, 31) and &H1

    End Sub

    Sub write
        If flag_vport_index = &H0 or flag_prio = &H0 or flag_drop = &H0 or flag_control_pkt = &H0 Then read
        If flag_vport_index = &H0 Then write_vport_index_value = get_vport_index
        If flag_prio = &H0 Then write_prio_value = get_prio
        If flag_drop = &H0 Then write_drop_value = get_drop
        If flag_control_pkt = &H0 Then write_control_pkt_value = get_control_pkt

        regValue = leftShift((write_vport_index_value and &Hf), 0) + leftShift((write_prio_value and &H7), 27) + leftShift((write_drop_value and &H1), 30) + leftShift((write_control_pkt_value and &H1), 31)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        vport_index_mask = &Hf
        if data_low > LONG_MAX then
            if vport_index_mask = mask then
                read_vport_index_value = data_low
            else
                read_vport_index_value = (data_low - H8000_0000) and vport_index_mask
            end If
        else
            read_vport_index_value = data_low and vport_index_mask
        end If
        read_prio_value = rightShift(data_low, 27) and &H7
        read_drop_value = rightShift(data_low, 30) and &H1
        read_control_pkt_value = rightShift(data_low, 31) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_vport_index_value = &H0
        flag_vport_index        = &H0
        write_prio_value = &H0
        flag_prio        = &H0
        write_drop_value = &H0
        flag_drop        = &H0
        write_control_pkt_value = &H0
        flag_control_pkt        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_TCAM_POLICY_tcam_policy_3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' vport_index                                [3:0]            get_vport_index
''                                                             set_vport_index
''                                                             read_vport_index
''                                                             write_vport_index
''---------------------------------------------------------------------------------
'' prio                                       [29:27]          get_prio
''                                                             set_prio
''                                                             read_prio
''                                                             write_prio
''---------------------------------------------------------------------------------
'' drop                                       [30:30]          get_drop
''                                                             set_drop
''                                                             read_drop
''                                                             write_drop
''---------------------------------------------------------------------------------
'' control_pkt                                [31:31]          get_control_pkt
''                                                             set_control_pkt
''                                                             read_control_pkt
''                                                             write_control_pkt
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_TCAM_POLICY_tcam_policy_3
    Private write_vport_index_value
    Private read_vport_index_value
    Private flag_vport_index
    Private write_prio_value
    Private read_prio_value
    Private flag_prio
    Private write_drop_value
    Private read_drop_value
    Private flag_drop
    Private write_control_pkt_value
    Private read_control_pkt_value
    Private flag_control_pkt

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H300c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_vport_index
        get_vport_index = read_vport_index_value
    End Property

    Property Let set_vport_index(aData)
        write_vport_index_value = aData
        flag_vport_index        = &H1
    End Property

    Property Get read_vport_index
        read
        read_vport_index = read_vport_index_value
    End Property

    Property Let write_vport_index(aData)
        set_vport_index = aData
        write
    End Property

    Property Get get_prio
        get_prio = read_prio_value
    End Property

    Property Let set_prio(aData)
        write_prio_value = aData
        flag_prio        = &H1
    End Property

    Property Get read_prio
        read
        read_prio = read_prio_value
    End Property

    Property Let write_prio(aData)
        set_prio = aData
        write
    End Property

    Property Get get_drop
        get_drop = read_drop_value
    End Property

    Property Let set_drop(aData)
        write_drop_value = aData
        flag_drop        = &H1
    End Property

    Property Get read_drop
        read
        read_drop = read_drop_value
    End Property

    Property Let write_drop(aData)
        set_drop = aData
        write
    End Property

    Property Get get_control_pkt
        get_control_pkt = read_control_pkt_value
    End Property

    Property Let set_control_pkt(aData)
        write_control_pkt_value = aData
        flag_control_pkt        = &H1
    End Property

    Property Get read_control_pkt
        read
        read_control_pkt = read_control_pkt_value
    End Property

    Property Let write_control_pkt(aData)
        set_control_pkt = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        vport_index_mask = &Hf
        if data_low > LONG_MAX then
            if vport_index_mask = mask then
                read_vport_index_value = data_low
            else
                read_vport_index_value = (data_low - H8000_0000) and vport_index_mask
            end If
        else
            read_vport_index_value = data_low and vport_index_mask
        end If
        read_prio_value = rightShift(data_low, 27) and &H7
        read_drop_value = rightShift(data_low, 30) and &H1
        read_control_pkt_value = rightShift(data_low, 31) and &H1

    End Sub

    Sub write
        If flag_vport_index = &H0 or flag_prio = &H0 or flag_drop = &H0 or flag_control_pkt = &H0 Then read
        If flag_vport_index = &H0 Then write_vport_index_value = get_vport_index
        If flag_prio = &H0 Then write_prio_value = get_prio
        If flag_drop = &H0 Then write_drop_value = get_drop
        If flag_control_pkt = &H0 Then write_control_pkt_value = get_control_pkt

        regValue = leftShift((write_vport_index_value and &Hf), 0) + leftShift((write_prio_value and &H7), 27) + leftShift((write_drop_value and &H1), 30) + leftShift((write_control_pkt_value and &H1), 31)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        vport_index_mask = &Hf
        if data_low > LONG_MAX then
            if vport_index_mask = mask then
                read_vport_index_value = data_low
            else
                read_vport_index_value = (data_low - H8000_0000) and vport_index_mask
            end If
        else
            read_vport_index_value = data_low and vport_index_mask
        end If
        read_prio_value = rightShift(data_low, 27) and &H7
        read_drop_value = rightShift(data_low, 30) and &H1
        read_control_pkt_value = rightShift(data_low, 31) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_vport_index_value = &H0
        flag_vport_index        = &H0
        write_prio_value = &H0
        flag_prio        = &H0
        write_drop_value = &H0
        flag_drop        = &H0
        write_control_pkt_value = &H0
        flag_control_pkt        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_TCAM_POLICY_tcam_policy_4
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' vport_index                                [3:0]            get_vport_index
''                                                             set_vport_index
''                                                             read_vport_index
''                                                             write_vport_index
''---------------------------------------------------------------------------------
'' prio                                       [29:27]          get_prio
''                                                             set_prio
''                                                             read_prio
''                                                             write_prio
''---------------------------------------------------------------------------------
'' drop                                       [30:30]          get_drop
''                                                             set_drop
''                                                             read_drop
''                                                             write_drop
''---------------------------------------------------------------------------------
'' control_pkt                                [31:31]          get_control_pkt
''                                                             set_control_pkt
''                                                             read_control_pkt
''                                                             write_control_pkt
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_TCAM_POLICY_tcam_policy_4
    Private write_vport_index_value
    Private read_vport_index_value
    Private flag_vport_index
    Private write_prio_value
    Private read_prio_value
    Private flag_prio
    Private write_drop_value
    Private read_drop_value
    Private flag_drop
    Private write_control_pkt_value
    Private read_control_pkt_value
    Private flag_control_pkt

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3010
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_vport_index
        get_vport_index = read_vport_index_value
    End Property

    Property Let set_vport_index(aData)
        write_vport_index_value = aData
        flag_vport_index        = &H1
    End Property

    Property Get read_vport_index
        read
        read_vport_index = read_vport_index_value
    End Property

    Property Let write_vport_index(aData)
        set_vport_index = aData
        write
    End Property

    Property Get get_prio
        get_prio = read_prio_value
    End Property

    Property Let set_prio(aData)
        write_prio_value = aData
        flag_prio        = &H1
    End Property

    Property Get read_prio
        read
        read_prio = read_prio_value
    End Property

    Property Let write_prio(aData)
        set_prio = aData
        write
    End Property

    Property Get get_drop
        get_drop = read_drop_value
    End Property

    Property Let set_drop(aData)
        write_drop_value = aData
        flag_drop        = &H1
    End Property

    Property Get read_drop
        read
        read_drop = read_drop_value
    End Property

    Property Let write_drop(aData)
        set_drop = aData
        write
    End Property

    Property Get get_control_pkt
        get_control_pkt = read_control_pkt_value
    End Property

    Property Let set_control_pkt(aData)
        write_control_pkt_value = aData
        flag_control_pkt        = &H1
    End Property

    Property Get read_control_pkt
        read
        read_control_pkt = read_control_pkt_value
    End Property

    Property Let write_control_pkt(aData)
        set_control_pkt = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        vport_index_mask = &Hf
        if data_low > LONG_MAX then
            if vport_index_mask = mask then
                read_vport_index_value = data_low
            else
                read_vport_index_value = (data_low - H8000_0000) and vport_index_mask
            end If
        else
            read_vport_index_value = data_low and vport_index_mask
        end If
        read_prio_value = rightShift(data_low, 27) and &H7
        read_drop_value = rightShift(data_low, 30) and &H1
        read_control_pkt_value = rightShift(data_low, 31) and &H1

    End Sub

    Sub write
        If flag_vport_index = &H0 or flag_prio = &H0 or flag_drop = &H0 or flag_control_pkt = &H0 Then read
        If flag_vport_index = &H0 Then write_vport_index_value = get_vport_index
        If flag_prio = &H0 Then write_prio_value = get_prio
        If flag_drop = &H0 Then write_drop_value = get_drop
        If flag_control_pkt = &H0 Then write_control_pkt_value = get_control_pkt

        regValue = leftShift((write_vport_index_value and &Hf), 0) + leftShift((write_prio_value and &H7), 27) + leftShift((write_drop_value and &H1), 30) + leftShift((write_control_pkt_value and &H1), 31)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        vport_index_mask = &Hf
        if data_low > LONG_MAX then
            if vport_index_mask = mask then
                read_vport_index_value = data_low
            else
                read_vport_index_value = (data_low - H8000_0000) and vport_index_mask
            end If
        else
            read_vport_index_value = data_low and vport_index_mask
        end If
        read_prio_value = rightShift(data_low, 27) and &H7
        read_drop_value = rightShift(data_low, 30) and &H1
        read_control_pkt_value = rightShift(data_low, 31) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_vport_index_value = &H0
        flag_vport_index        = &H0
        write_prio_value = &H0
        flag_prio        = &H0
        write_drop_value = &H0
        flag_drop        = &H0
        write_control_pkt_value = &H0
        flag_control_pkt        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_TCAM_POLICY_tcam_policy_5
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' vport_index                                [3:0]            get_vport_index
''                                                             set_vport_index
''                                                             read_vport_index
''                                                             write_vport_index
''---------------------------------------------------------------------------------
'' prio                                       [29:27]          get_prio
''                                                             set_prio
''                                                             read_prio
''                                                             write_prio
''---------------------------------------------------------------------------------
'' drop                                       [30:30]          get_drop
''                                                             set_drop
''                                                             read_drop
''                                                             write_drop
''---------------------------------------------------------------------------------
'' control_pkt                                [31:31]          get_control_pkt
''                                                             set_control_pkt
''                                                             read_control_pkt
''                                                             write_control_pkt
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_TCAM_POLICY_tcam_policy_5
    Private write_vport_index_value
    Private read_vport_index_value
    Private flag_vport_index
    Private write_prio_value
    Private read_prio_value
    Private flag_prio
    Private write_drop_value
    Private read_drop_value
    Private flag_drop
    Private write_control_pkt_value
    Private read_control_pkt_value
    Private flag_control_pkt

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3014
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_vport_index
        get_vport_index = read_vport_index_value
    End Property

    Property Let set_vport_index(aData)
        write_vport_index_value = aData
        flag_vport_index        = &H1
    End Property

    Property Get read_vport_index
        read
        read_vport_index = read_vport_index_value
    End Property

    Property Let write_vport_index(aData)
        set_vport_index = aData
        write
    End Property

    Property Get get_prio
        get_prio = read_prio_value
    End Property

    Property Let set_prio(aData)
        write_prio_value = aData
        flag_prio        = &H1
    End Property

    Property Get read_prio
        read
        read_prio = read_prio_value
    End Property

    Property Let write_prio(aData)
        set_prio = aData
        write
    End Property

    Property Get get_drop
        get_drop = read_drop_value
    End Property

    Property Let set_drop(aData)
        write_drop_value = aData
        flag_drop        = &H1
    End Property

    Property Get read_drop
        read
        read_drop = read_drop_value
    End Property

    Property Let write_drop(aData)
        set_drop = aData
        write
    End Property

    Property Get get_control_pkt
        get_control_pkt = read_control_pkt_value
    End Property

    Property Let set_control_pkt(aData)
        write_control_pkt_value = aData
        flag_control_pkt        = &H1
    End Property

    Property Get read_control_pkt
        read
        read_control_pkt = read_control_pkt_value
    End Property

    Property Let write_control_pkt(aData)
        set_control_pkt = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        vport_index_mask = &Hf
        if data_low > LONG_MAX then
            if vport_index_mask = mask then
                read_vport_index_value = data_low
            else
                read_vport_index_value = (data_low - H8000_0000) and vport_index_mask
            end If
        else
            read_vport_index_value = data_low and vport_index_mask
        end If
        read_prio_value = rightShift(data_low, 27) and &H7
        read_drop_value = rightShift(data_low, 30) and &H1
        read_control_pkt_value = rightShift(data_low, 31) and &H1

    End Sub

    Sub write
        If flag_vport_index = &H0 or flag_prio = &H0 or flag_drop = &H0 or flag_control_pkt = &H0 Then read
        If flag_vport_index = &H0 Then write_vport_index_value = get_vport_index
        If flag_prio = &H0 Then write_prio_value = get_prio
        If flag_drop = &H0 Then write_drop_value = get_drop
        If flag_control_pkt = &H0 Then write_control_pkt_value = get_control_pkt

        regValue = leftShift((write_vport_index_value and &Hf), 0) + leftShift((write_prio_value and &H7), 27) + leftShift((write_drop_value and &H1), 30) + leftShift((write_control_pkt_value and &H1), 31)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        vport_index_mask = &Hf
        if data_low > LONG_MAX then
            if vport_index_mask = mask then
                read_vport_index_value = data_low
            else
                read_vport_index_value = (data_low - H8000_0000) and vport_index_mask
            end If
        else
            read_vport_index_value = data_low and vport_index_mask
        end If
        read_prio_value = rightShift(data_low, 27) and &H7
        read_drop_value = rightShift(data_low, 30) and &H1
        read_control_pkt_value = rightShift(data_low, 31) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_vport_index_value = &H0
        flag_vport_index        = &H0
        write_prio_value = &H0
        flag_prio        = &H0
        write_drop_value = &H0
        flag_drop        = &H0
        write_control_pkt_value = &H0
        flag_control_pkt        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_TCAM_POLICY_tcam_policy_6
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' vport_index                                [3:0]            get_vport_index
''                                                             set_vport_index
''                                                             read_vport_index
''                                                             write_vport_index
''---------------------------------------------------------------------------------
'' prio                                       [29:27]          get_prio
''                                                             set_prio
''                                                             read_prio
''                                                             write_prio
''---------------------------------------------------------------------------------
'' drop                                       [30:30]          get_drop
''                                                             set_drop
''                                                             read_drop
''                                                             write_drop
''---------------------------------------------------------------------------------
'' control_pkt                                [31:31]          get_control_pkt
''                                                             set_control_pkt
''                                                             read_control_pkt
''                                                             write_control_pkt
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_TCAM_POLICY_tcam_policy_6
    Private write_vport_index_value
    Private read_vport_index_value
    Private flag_vport_index
    Private write_prio_value
    Private read_prio_value
    Private flag_prio
    Private write_drop_value
    Private read_drop_value
    Private flag_drop
    Private write_control_pkt_value
    Private read_control_pkt_value
    Private flag_control_pkt

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3018
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_vport_index
        get_vport_index = read_vport_index_value
    End Property

    Property Let set_vport_index(aData)
        write_vport_index_value = aData
        flag_vport_index        = &H1
    End Property

    Property Get read_vport_index
        read
        read_vport_index = read_vport_index_value
    End Property

    Property Let write_vport_index(aData)
        set_vport_index = aData
        write
    End Property

    Property Get get_prio
        get_prio = read_prio_value
    End Property

    Property Let set_prio(aData)
        write_prio_value = aData
        flag_prio        = &H1
    End Property

    Property Get read_prio
        read
        read_prio = read_prio_value
    End Property

    Property Let write_prio(aData)
        set_prio = aData
        write
    End Property

    Property Get get_drop
        get_drop = read_drop_value
    End Property

    Property Let set_drop(aData)
        write_drop_value = aData
        flag_drop        = &H1
    End Property

    Property Get read_drop
        read
        read_drop = read_drop_value
    End Property

    Property Let write_drop(aData)
        set_drop = aData
        write
    End Property

    Property Get get_control_pkt
        get_control_pkt = read_control_pkt_value
    End Property

    Property Let set_control_pkt(aData)
        write_control_pkt_value = aData
        flag_control_pkt        = &H1
    End Property

    Property Get read_control_pkt
        read
        read_control_pkt = read_control_pkt_value
    End Property

    Property Let write_control_pkt(aData)
        set_control_pkt = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        vport_index_mask = &Hf
        if data_low > LONG_MAX then
            if vport_index_mask = mask then
                read_vport_index_value = data_low
            else
                read_vport_index_value = (data_low - H8000_0000) and vport_index_mask
            end If
        else
            read_vport_index_value = data_low and vport_index_mask
        end If
        read_prio_value = rightShift(data_low, 27) and &H7
        read_drop_value = rightShift(data_low, 30) and &H1
        read_control_pkt_value = rightShift(data_low, 31) and &H1

    End Sub

    Sub write
        If flag_vport_index = &H0 or flag_prio = &H0 or flag_drop = &H0 or flag_control_pkt = &H0 Then read
        If flag_vport_index = &H0 Then write_vport_index_value = get_vport_index
        If flag_prio = &H0 Then write_prio_value = get_prio
        If flag_drop = &H0 Then write_drop_value = get_drop
        If flag_control_pkt = &H0 Then write_control_pkt_value = get_control_pkt

        regValue = leftShift((write_vport_index_value and &Hf), 0) + leftShift((write_prio_value and &H7), 27) + leftShift((write_drop_value and &H1), 30) + leftShift((write_control_pkt_value and &H1), 31)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        vport_index_mask = &Hf
        if data_low > LONG_MAX then
            if vport_index_mask = mask then
                read_vport_index_value = data_low
            else
                read_vport_index_value = (data_low - H8000_0000) and vport_index_mask
            end If
        else
            read_vport_index_value = data_low and vport_index_mask
        end If
        read_prio_value = rightShift(data_low, 27) and &H7
        read_drop_value = rightShift(data_low, 30) and &H1
        read_control_pkt_value = rightShift(data_low, 31) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_vport_index_value = &H0
        flag_vport_index        = &H0
        write_prio_value = &H0
        flag_prio        = &H0
        write_drop_value = &H0
        flag_drop        = &H0
        write_control_pkt_value = &H0
        flag_control_pkt        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_TCAM_POLICY_tcam_policy_7
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' vport_index                                [3:0]            get_vport_index
''                                                             set_vport_index
''                                                             read_vport_index
''                                                             write_vport_index
''---------------------------------------------------------------------------------
'' prio                                       [29:27]          get_prio
''                                                             set_prio
''                                                             read_prio
''                                                             write_prio
''---------------------------------------------------------------------------------
'' drop                                       [30:30]          get_drop
''                                                             set_drop
''                                                             read_drop
''                                                             write_drop
''---------------------------------------------------------------------------------
'' control_pkt                                [31:31]          get_control_pkt
''                                                             set_control_pkt
''                                                             read_control_pkt
''                                                             write_control_pkt
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_TCAM_POLICY_tcam_policy_7
    Private write_vport_index_value
    Private read_vport_index_value
    Private flag_vport_index
    Private write_prio_value
    Private read_prio_value
    Private flag_prio
    Private write_drop_value
    Private read_drop_value
    Private flag_drop
    Private write_control_pkt_value
    Private read_control_pkt_value
    Private flag_control_pkt

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H301c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_vport_index
        get_vport_index = read_vport_index_value
    End Property

    Property Let set_vport_index(aData)
        write_vport_index_value = aData
        flag_vport_index        = &H1
    End Property

    Property Get read_vport_index
        read
        read_vport_index = read_vport_index_value
    End Property

    Property Let write_vport_index(aData)
        set_vport_index = aData
        write
    End Property

    Property Get get_prio
        get_prio = read_prio_value
    End Property

    Property Let set_prio(aData)
        write_prio_value = aData
        flag_prio        = &H1
    End Property

    Property Get read_prio
        read
        read_prio = read_prio_value
    End Property

    Property Let write_prio(aData)
        set_prio = aData
        write
    End Property

    Property Get get_drop
        get_drop = read_drop_value
    End Property

    Property Let set_drop(aData)
        write_drop_value = aData
        flag_drop        = &H1
    End Property

    Property Get read_drop
        read
        read_drop = read_drop_value
    End Property

    Property Let write_drop(aData)
        set_drop = aData
        write
    End Property

    Property Get get_control_pkt
        get_control_pkt = read_control_pkt_value
    End Property

    Property Let set_control_pkt(aData)
        write_control_pkt_value = aData
        flag_control_pkt        = &H1
    End Property

    Property Get read_control_pkt
        read
        read_control_pkt = read_control_pkt_value
    End Property

    Property Let write_control_pkt(aData)
        set_control_pkt = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        vport_index_mask = &Hf
        if data_low > LONG_MAX then
            if vport_index_mask = mask then
                read_vport_index_value = data_low
            else
                read_vport_index_value = (data_low - H8000_0000) and vport_index_mask
            end If
        else
            read_vport_index_value = data_low and vport_index_mask
        end If
        read_prio_value = rightShift(data_low, 27) and &H7
        read_drop_value = rightShift(data_low, 30) and &H1
        read_control_pkt_value = rightShift(data_low, 31) and &H1

    End Sub

    Sub write
        If flag_vport_index = &H0 or flag_prio = &H0 or flag_drop = &H0 or flag_control_pkt = &H0 Then read
        If flag_vport_index = &H0 Then write_vport_index_value = get_vport_index
        If flag_prio = &H0 Then write_prio_value = get_prio
        If flag_drop = &H0 Then write_drop_value = get_drop
        If flag_control_pkt = &H0 Then write_control_pkt_value = get_control_pkt

        regValue = leftShift((write_vport_index_value and &Hf), 0) + leftShift((write_prio_value and &H7), 27) + leftShift((write_drop_value and &H1), 30) + leftShift((write_control_pkt_value and &H1), 31)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        vport_index_mask = &Hf
        if data_low > LONG_MAX then
            if vport_index_mask = mask then
                read_vport_index_value = data_low
            else
                read_vport_index_value = (data_low - H8000_0000) and vport_index_mask
            end If
        else
            read_vport_index_value = data_low and vport_index_mask
        end If
        read_prio_value = rightShift(data_low, 27) and &H7
        read_drop_value = rightShift(data_low, 30) and &H1
        read_control_pkt_value = rightShift(data_low, 31) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_vport_index_value = &H0
        flag_vport_index        = &H0
        write_prio_value = &H0
        flag_prio        = &H0
        write_drop_value = &H0
        flag_drop        = &H0
        write_control_pkt_value = &H0
        flag_control_pkt        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_TCAM_POLICY_tcam_policy_8
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' vport_index                                [3:0]            get_vport_index
''                                                             set_vport_index
''                                                             read_vport_index
''                                                             write_vport_index
''---------------------------------------------------------------------------------
'' prio                                       [29:27]          get_prio
''                                                             set_prio
''                                                             read_prio
''                                                             write_prio
''---------------------------------------------------------------------------------
'' drop                                       [30:30]          get_drop
''                                                             set_drop
''                                                             read_drop
''                                                             write_drop
''---------------------------------------------------------------------------------
'' control_pkt                                [31:31]          get_control_pkt
''                                                             set_control_pkt
''                                                             read_control_pkt
''                                                             write_control_pkt
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_TCAM_POLICY_tcam_policy_8
    Private write_vport_index_value
    Private read_vport_index_value
    Private flag_vport_index
    Private write_prio_value
    Private read_prio_value
    Private flag_prio
    Private write_drop_value
    Private read_drop_value
    Private flag_drop
    Private write_control_pkt_value
    Private read_control_pkt_value
    Private flag_control_pkt

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3020
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_vport_index
        get_vport_index = read_vport_index_value
    End Property

    Property Let set_vport_index(aData)
        write_vport_index_value = aData
        flag_vport_index        = &H1
    End Property

    Property Get read_vport_index
        read
        read_vport_index = read_vport_index_value
    End Property

    Property Let write_vport_index(aData)
        set_vport_index = aData
        write
    End Property

    Property Get get_prio
        get_prio = read_prio_value
    End Property

    Property Let set_prio(aData)
        write_prio_value = aData
        flag_prio        = &H1
    End Property

    Property Get read_prio
        read
        read_prio = read_prio_value
    End Property

    Property Let write_prio(aData)
        set_prio = aData
        write
    End Property

    Property Get get_drop
        get_drop = read_drop_value
    End Property

    Property Let set_drop(aData)
        write_drop_value = aData
        flag_drop        = &H1
    End Property

    Property Get read_drop
        read
        read_drop = read_drop_value
    End Property

    Property Let write_drop(aData)
        set_drop = aData
        write
    End Property

    Property Get get_control_pkt
        get_control_pkt = read_control_pkt_value
    End Property

    Property Let set_control_pkt(aData)
        write_control_pkt_value = aData
        flag_control_pkt        = &H1
    End Property

    Property Get read_control_pkt
        read
        read_control_pkt = read_control_pkt_value
    End Property

    Property Let write_control_pkt(aData)
        set_control_pkt = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        vport_index_mask = &Hf
        if data_low > LONG_MAX then
            if vport_index_mask = mask then
                read_vport_index_value = data_low
            else
                read_vport_index_value = (data_low - H8000_0000) and vport_index_mask
            end If
        else
            read_vport_index_value = data_low and vport_index_mask
        end If
        read_prio_value = rightShift(data_low, 27) and &H7
        read_drop_value = rightShift(data_low, 30) and &H1
        read_control_pkt_value = rightShift(data_low, 31) and &H1

    End Sub

    Sub write
        If flag_vport_index = &H0 or flag_prio = &H0 or flag_drop = &H0 or flag_control_pkt = &H0 Then read
        If flag_vport_index = &H0 Then write_vport_index_value = get_vport_index
        If flag_prio = &H0 Then write_prio_value = get_prio
        If flag_drop = &H0 Then write_drop_value = get_drop
        If flag_control_pkt = &H0 Then write_control_pkt_value = get_control_pkt

        regValue = leftShift((write_vport_index_value and &Hf), 0) + leftShift((write_prio_value and &H7), 27) + leftShift((write_drop_value and &H1), 30) + leftShift((write_control_pkt_value and &H1), 31)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        vport_index_mask = &Hf
        if data_low > LONG_MAX then
            if vport_index_mask = mask then
                read_vport_index_value = data_low
            else
                read_vport_index_value = (data_low - H8000_0000) and vport_index_mask
            end If
        else
            read_vport_index_value = data_low and vport_index_mask
        end If
        read_prio_value = rightShift(data_low, 27) and &H7
        read_drop_value = rightShift(data_low, 30) and &H1
        read_control_pkt_value = rightShift(data_low, 31) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_vport_index_value = &H0
        flag_vport_index        = &H0
        write_prio_value = &H0
        flag_prio        = &H0
        write_drop_value = &H0
        flag_drop        = &H0
        write_control_pkt_value = &H0
        flag_control_pkt        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_TCAM_POLICY_tcam_policy_9
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' vport_index                                [3:0]            get_vport_index
''                                                             set_vport_index
''                                                             read_vport_index
''                                                             write_vport_index
''---------------------------------------------------------------------------------
'' prio                                       [29:27]          get_prio
''                                                             set_prio
''                                                             read_prio
''                                                             write_prio
''---------------------------------------------------------------------------------
'' drop                                       [30:30]          get_drop
''                                                             set_drop
''                                                             read_drop
''                                                             write_drop
''---------------------------------------------------------------------------------
'' control_pkt                                [31:31]          get_control_pkt
''                                                             set_control_pkt
''                                                             read_control_pkt
''                                                             write_control_pkt
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_TCAM_POLICY_tcam_policy_9
    Private write_vport_index_value
    Private read_vport_index_value
    Private flag_vport_index
    Private write_prio_value
    Private read_prio_value
    Private flag_prio
    Private write_drop_value
    Private read_drop_value
    Private flag_drop
    Private write_control_pkt_value
    Private read_control_pkt_value
    Private flag_control_pkt

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3024
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_vport_index
        get_vport_index = read_vport_index_value
    End Property

    Property Let set_vport_index(aData)
        write_vport_index_value = aData
        flag_vport_index        = &H1
    End Property

    Property Get read_vport_index
        read
        read_vport_index = read_vport_index_value
    End Property

    Property Let write_vport_index(aData)
        set_vport_index = aData
        write
    End Property

    Property Get get_prio
        get_prio = read_prio_value
    End Property

    Property Let set_prio(aData)
        write_prio_value = aData
        flag_prio        = &H1
    End Property

    Property Get read_prio
        read
        read_prio = read_prio_value
    End Property

    Property Let write_prio(aData)
        set_prio = aData
        write
    End Property

    Property Get get_drop
        get_drop = read_drop_value
    End Property

    Property Let set_drop(aData)
        write_drop_value = aData
        flag_drop        = &H1
    End Property

    Property Get read_drop
        read
        read_drop = read_drop_value
    End Property

    Property Let write_drop(aData)
        set_drop = aData
        write
    End Property

    Property Get get_control_pkt
        get_control_pkt = read_control_pkt_value
    End Property

    Property Let set_control_pkt(aData)
        write_control_pkt_value = aData
        flag_control_pkt        = &H1
    End Property

    Property Get read_control_pkt
        read
        read_control_pkt = read_control_pkt_value
    End Property

    Property Let write_control_pkt(aData)
        set_control_pkt = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        vport_index_mask = &Hf
        if data_low > LONG_MAX then
            if vport_index_mask = mask then
                read_vport_index_value = data_low
            else
                read_vport_index_value = (data_low - H8000_0000) and vport_index_mask
            end If
        else
            read_vport_index_value = data_low and vport_index_mask
        end If
        read_prio_value = rightShift(data_low, 27) and &H7
        read_drop_value = rightShift(data_low, 30) and &H1
        read_control_pkt_value = rightShift(data_low, 31) and &H1

    End Sub

    Sub write
        If flag_vport_index = &H0 or flag_prio = &H0 or flag_drop = &H0 or flag_control_pkt = &H0 Then read
        If flag_vport_index = &H0 Then write_vport_index_value = get_vport_index
        If flag_prio = &H0 Then write_prio_value = get_prio
        If flag_drop = &H0 Then write_drop_value = get_drop
        If flag_control_pkt = &H0 Then write_control_pkt_value = get_control_pkt

        regValue = leftShift((write_vport_index_value and &Hf), 0) + leftShift((write_prio_value and &H7), 27) + leftShift((write_drop_value and &H1), 30) + leftShift((write_control_pkt_value and &H1), 31)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        vport_index_mask = &Hf
        if data_low > LONG_MAX then
            if vport_index_mask = mask then
                read_vport_index_value = data_low
            else
                read_vport_index_value = (data_low - H8000_0000) and vport_index_mask
            end If
        else
            read_vport_index_value = data_low and vport_index_mask
        end If
        read_prio_value = rightShift(data_low, 27) and &H7
        read_drop_value = rightShift(data_low, 30) and &H1
        read_control_pkt_value = rightShift(data_low, 31) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_vport_index_value = &H0
        flag_vport_index        = &H0
        write_prio_value = &H0
        flag_prio        = &H0
        write_drop_value = &H0
        flag_drop        = &H0
        write_control_pkt_value = &H0
        flag_control_pkt        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_TCAM_POLICY_tcam_policy_10
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' vport_index                                [3:0]            get_vport_index
''                                                             set_vport_index
''                                                             read_vport_index
''                                                             write_vport_index
''---------------------------------------------------------------------------------
'' prio                                       [29:27]          get_prio
''                                                             set_prio
''                                                             read_prio
''                                                             write_prio
''---------------------------------------------------------------------------------
'' drop                                       [30:30]          get_drop
''                                                             set_drop
''                                                             read_drop
''                                                             write_drop
''---------------------------------------------------------------------------------
'' control_pkt                                [31:31]          get_control_pkt
''                                                             set_control_pkt
''                                                             read_control_pkt
''                                                             write_control_pkt
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_TCAM_POLICY_tcam_policy_10
    Private write_vport_index_value
    Private read_vport_index_value
    Private flag_vport_index
    Private write_prio_value
    Private read_prio_value
    Private flag_prio
    Private write_drop_value
    Private read_drop_value
    Private flag_drop
    Private write_control_pkt_value
    Private read_control_pkt_value
    Private flag_control_pkt

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3028
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_vport_index
        get_vport_index = read_vport_index_value
    End Property

    Property Let set_vport_index(aData)
        write_vport_index_value = aData
        flag_vport_index        = &H1
    End Property

    Property Get read_vport_index
        read
        read_vport_index = read_vport_index_value
    End Property

    Property Let write_vport_index(aData)
        set_vport_index = aData
        write
    End Property

    Property Get get_prio
        get_prio = read_prio_value
    End Property

    Property Let set_prio(aData)
        write_prio_value = aData
        flag_prio        = &H1
    End Property

    Property Get read_prio
        read
        read_prio = read_prio_value
    End Property

    Property Let write_prio(aData)
        set_prio = aData
        write
    End Property

    Property Get get_drop
        get_drop = read_drop_value
    End Property

    Property Let set_drop(aData)
        write_drop_value = aData
        flag_drop        = &H1
    End Property

    Property Get read_drop
        read
        read_drop = read_drop_value
    End Property

    Property Let write_drop(aData)
        set_drop = aData
        write
    End Property

    Property Get get_control_pkt
        get_control_pkt = read_control_pkt_value
    End Property

    Property Let set_control_pkt(aData)
        write_control_pkt_value = aData
        flag_control_pkt        = &H1
    End Property

    Property Get read_control_pkt
        read
        read_control_pkt = read_control_pkt_value
    End Property

    Property Let write_control_pkt(aData)
        set_control_pkt = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        vport_index_mask = &Hf
        if data_low > LONG_MAX then
            if vport_index_mask = mask then
                read_vport_index_value = data_low
            else
                read_vport_index_value = (data_low - H8000_0000) and vport_index_mask
            end If
        else
            read_vport_index_value = data_low and vport_index_mask
        end If
        read_prio_value = rightShift(data_low, 27) and &H7
        read_drop_value = rightShift(data_low, 30) and &H1
        read_control_pkt_value = rightShift(data_low, 31) and &H1

    End Sub

    Sub write
        If flag_vport_index = &H0 or flag_prio = &H0 or flag_drop = &H0 or flag_control_pkt = &H0 Then read
        If flag_vport_index = &H0 Then write_vport_index_value = get_vport_index
        If flag_prio = &H0 Then write_prio_value = get_prio
        If flag_drop = &H0 Then write_drop_value = get_drop
        If flag_control_pkt = &H0 Then write_control_pkt_value = get_control_pkt

        regValue = leftShift((write_vport_index_value and &Hf), 0) + leftShift((write_prio_value and &H7), 27) + leftShift((write_drop_value and &H1), 30) + leftShift((write_control_pkt_value and &H1), 31)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        vport_index_mask = &Hf
        if data_low > LONG_MAX then
            if vport_index_mask = mask then
                read_vport_index_value = data_low
            else
                read_vport_index_value = (data_low - H8000_0000) and vport_index_mask
            end If
        else
            read_vport_index_value = data_low and vport_index_mask
        end If
        read_prio_value = rightShift(data_low, 27) and &H7
        read_drop_value = rightShift(data_low, 30) and &H1
        read_control_pkt_value = rightShift(data_low, 31) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_vport_index_value = &H0
        flag_vport_index        = &H0
        write_prio_value = &H0
        flag_prio        = &H0
        write_drop_value = &H0
        flag_drop        = &H0
        write_control_pkt_value = &H0
        flag_control_pkt        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_TCAM_POLICY_tcam_policy_11
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' vport_index                                [3:0]            get_vport_index
''                                                             set_vport_index
''                                                             read_vport_index
''                                                             write_vport_index
''---------------------------------------------------------------------------------
'' prio                                       [29:27]          get_prio
''                                                             set_prio
''                                                             read_prio
''                                                             write_prio
''---------------------------------------------------------------------------------
'' drop                                       [30:30]          get_drop
''                                                             set_drop
''                                                             read_drop
''                                                             write_drop
''---------------------------------------------------------------------------------
'' control_pkt                                [31:31]          get_control_pkt
''                                                             set_control_pkt
''                                                             read_control_pkt
''                                                             write_control_pkt
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_TCAM_POLICY_tcam_policy_11
    Private write_vport_index_value
    Private read_vport_index_value
    Private flag_vport_index
    Private write_prio_value
    Private read_prio_value
    Private flag_prio
    Private write_drop_value
    Private read_drop_value
    Private flag_drop
    Private write_control_pkt_value
    Private read_control_pkt_value
    Private flag_control_pkt

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H302c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_vport_index
        get_vport_index = read_vport_index_value
    End Property

    Property Let set_vport_index(aData)
        write_vport_index_value = aData
        flag_vport_index        = &H1
    End Property

    Property Get read_vport_index
        read
        read_vport_index = read_vport_index_value
    End Property

    Property Let write_vport_index(aData)
        set_vport_index = aData
        write
    End Property

    Property Get get_prio
        get_prio = read_prio_value
    End Property

    Property Let set_prio(aData)
        write_prio_value = aData
        flag_prio        = &H1
    End Property

    Property Get read_prio
        read
        read_prio = read_prio_value
    End Property

    Property Let write_prio(aData)
        set_prio = aData
        write
    End Property

    Property Get get_drop
        get_drop = read_drop_value
    End Property

    Property Let set_drop(aData)
        write_drop_value = aData
        flag_drop        = &H1
    End Property

    Property Get read_drop
        read
        read_drop = read_drop_value
    End Property

    Property Let write_drop(aData)
        set_drop = aData
        write
    End Property

    Property Get get_control_pkt
        get_control_pkt = read_control_pkt_value
    End Property

    Property Let set_control_pkt(aData)
        write_control_pkt_value = aData
        flag_control_pkt        = &H1
    End Property

    Property Get read_control_pkt
        read
        read_control_pkt = read_control_pkt_value
    End Property

    Property Let write_control_pkt(aData)
        set_control_pkt = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        vport_index_mask = &Hf
        if data_low > LONG_MAX then
            if vport_index_mask = mask then
                read_vport_index_value = data_low
            else
                read_vport_index_value = (data_low - H8000_0000) and vport_index_mask
            end If
        else
            read_vport_index_value = data_low and vport_index_mask
        end If
        read_prio_value = rightShift(data_low, 27) and &H7
        read_drop_value = rightShift(data_low, 30) and &H1
        read_control_pkt_value = rightShift(data_low, 31) and &H1

    End Sub

    Sub write
        If flag_vport_index = &H0 or flag_prio = &H0 or flag_drop = &H0 or flag_control_pkt = &H0 Then read
        If flag_vport_index = &H0 Then write_vport_index_value = get_vport_index
        If flag_prio = &H0 Then write_prio_value = get_prio
        If flag_drop = &H0 Then write_drop_value = get_drop
        If flag_control_pkt = &H0 Then write_control_pkt_value = get_control_pkt

        regValue = leftShift((write_vport_index_value and &Hf), 0) + leftShift((write_prio_value and &H7), 27) + leftShift((write_drop_value and &H1), 30) + leftShift((write_control_pkt_value and &H1), 31)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        vport_index_mask = &Hf
        if data_low > LONG_MAX then
            if vport_index_mask = mask then
                read_vport_index_value = data_low
            else
                read_vport_index_value = (data_low - H8000_0000) and vport_index_mask
            end If
        else
            read_vport_index_value = data_low and vport_index_mask
        end If
        read_prio_value = rightShift(data_low, 27) and &H7
        read_drop_value = rightShift(data_low, 30) and &H1
        read_control_pkt_value = rightShift(data_low, 31) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_vport_index_value = &H0
        flag_vport_index        = &H0
        write_prio_value = &H0
        flag_prio        = &H0
        write_drop_value = &H0
        flag_drop        = &H0
        write_control_pkt_value = &H0
        flag_control_pkt        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_TCAM_POLICY_tcam_policy_12
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' vport_index                                [3:0]            get_vport_index
''                                                             set_vport_index
''                                                             read_vport_index
''                                                             write_vport_index
''---------------------------------------------------------------------------------
'' prio                                       [29:27]          get_prio
''                                                             set_prio
''                                                             read_prio
''                                                             write_prio
''---------------------------------------------------------------------------------
'' drop                                       [30:30]          get_drop
''                                                             set_drop
''                                                             read_drop
''                                                             write_drop
''---------------------------------------------------------------------------------
'' control_pkt                                [31:31]          get_control_pkt
''                                                             set_control_pkt
''                                                             read_control_pkt
''                                                             write_control_pkt
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_TCAM_POLICY_tcam_policy_12
    Private write_vport_index_value
    Private read_vport_index_value
    Private flag_vport_index
    Private write_prio_value
    Private read_prio_value
    Private flag_prio
    Private write_drop_value
    Private read_drop_value
    Private flag_drop
    Private write_control_pkt_value
    Private read_control_pkt_value
    Private flag_control_pkt

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3030
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_vport_index
        get_vport_index = read_vport_index_value
    End Property

    Property Let set_vport_index(aData)
        write_vport_index_value = aData
        flag_vport_index        = &H1
    End Property

    Property Get read_vport_index
        read
        read_vport_index = read_vport_index_value
    End Property

    Property Let write_vport_index(aData)
        set_vport_index = aData
        write
    End Property

    Property Get get_prio
        get_prio = read_prio_value
    End Property

    Property Let set_prio(aData)
        write_prio_value = aData
        flag_prio        = &H1
    End Property

    Property Get read_prio
        read
        read_prio = read_prio_value
    End Property

    Property Let write_prio(aData)
        set_prio = aData
        write
    End Property

    Property Get get_drop
        get_drop = read_drop_value
    End Property

    Property Let set_drop(aData)
        write_drop_value = aData
        flag_drop        = &H1
    End Property

    Property Get read_drop
        read
        read_drop = read_drop_value
    End Property

    Property Let write_drop(aData)
        set_drop = aData
        write
    End Property

    Property Get get_control_pkt
        get_control_pkt = read_control_pkt_value
    End Property

    Property Let set_control_pkt(aData)
        write_control_pkt_value = aData
        flag_control_pkt        = &H1
    End Property

    Property Get read_control_pkt
        read
        read_control_pkt = read_control_pkt_value
    End Property

    Property Let write_control_pkt(aData)
        set_control_pkt = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        vport_index_mask = &Hf
        if data_low > LONG_MAX then
            if vport_index_mask = mask then
                read_vport_index_value = data_low
            else
                read_vport_index_value = (data_low - H8000_0000) and vport_index_mask
            end If
        else
            read_vport_index_value = data_low and vport_index_mask
        end If
        read_prio_value = rightShift(data_low, 27) and &H7
        read_drop_value = rightShift(data_low, 30) and &H1
        read_control_pkt_value = rightShift(data_low, 31) and &H1

    End Sub

    Sub write
        If flag_vport_index = &H0 or flag_prio = &H0 or flag_drop = &H0 or flag_control_pkt = &H0 Then read
        If flag_vport_index = &H0 Then write_vport_index_value = get_vport_index
        If flag_prio = &H0 Then write_prio_value = get_prio
        If flag_drop = &H0 Then write_drop_value = get_drop
        If flag_control_pkt = &H0 Then write_control_pkt_value = get_control_pkt

        regValue = leftShift((write_vport_index_value and &Hf), 0) + leftShift((write_prio_value and &H7), 27) + leftShift((write_drop_value and &H1), 30) + leftShift((write_control_pkt_value and &H1), 31)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        vport_index_mask = &Hf
        if data_low > LONG_MAX then
            if vport_index_mask = mask then
                read_vport_index_value = data_low
            else
                read_vport_index_value = (data_low - H8000_0000) and vport_index_mask
            end If
        else
            read_vport_index_value = data_low and vport_index_mask
        end If
        read_prio_value = rightShift(data_low, 27) and &H7
        read_drop_value = rightShift(data_low, 30) and &H1
        read_control_pkt_value = rightShift(data_low, 31) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_vport_index_value = &H0
        flag_vport_index        = &H0
        write_prio_value = &H0
        flag_prio        = &H0
        write_drop_value = &H0
        flag_drop        = &H0
        write_control_pkt_value = &H0
        flag_control_pkt        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_TCAM_POLICY_tcam_policy_13
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' vport_index                                [3:0]            get_vport_index
''                                                             set_vport_index
''                                                             read_vport_index
''                                                             write_vport_index
''---------------------------------------------------------------------------------
'' prio                                       [29:27]          get_prio
''                                                             set_prio
''                                                             read_prio
''                                                             write_prio
''---------------------------------------------------------------------------------
'' drop                                       [30:30]          get_drop
''                                                             set_drop
''                                                             read_drop
''                                                             write_drop
''---------------------------------------------------------------------------------
'' control_pkt                                [31:31]          get_control_pkt
''                                                             set_control_pkt
''                                                             read_control_pkt
''                                                             write_control_pkt
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_TCAM_POLICY_tcam_policy_13
    Private write_vport_index_value
    Private read_vport_index_value
    Private flag_vport_index
    Private write_prio_value
    Private read_prio_value
    Private flag_prio
    Private write_drop_value
    Private read_drop_value
    Private flag_drop
    Private write_control_pkt_value
    Private read_control_pkt_value
    Private flag_control_pkt

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3034
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_vport_index
        get_vport_index = read_vport_index_value
    End Property

    Property Let set_vport_index(aData)
        write_vport_index_value = aData
        flag_vport_index        = &H1
    End Property

    Property Get read_vport_index
        read
        read_vport_index = read_vport_index_value
    End Property

    Property Let write_vport_index(aData)
        set_vport_index = aData
        write
    End Property

    Property Get get_prio
        get_prio = read_prio_value
    End Property

    Property Let set_prio(aData)
        write_prio_value = aData
        flag_prio        = &H1
    End Property

    Property Get read_prio
        read
        read_prio = read_prio_value
    End Property

    Property Let write_prio(aData)
        set_prio = aData
        write
    End Property

    Property Get get_drop
        get_drop = read_drop_value
    End Property

    Property Let set_drop(aData)
        write_drop_value = aData
        flag_drop        = &H1
    End Property

    Property Get read_drop
        read
        read_drop = read_drop_value
    End Property

    Property Let write_drop(aData)
        set_drop = aData
        write
    End Property

    Property Get get_control_pkt
        get_control_pkt = read_control_pkt_value
    End Property

    Property Let set_control_pkt(aData)
        write_control_pkt_value = aData
        flag_control_pkt        = &H1
    End Property

    Property Get read_control_pkt
        read
        read_control_pkt = read_control_pkt_value
    End Property

    Property Let write_control_pkt(aData)
        set_control_pkt = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        vport_index_mask = &Hf
        if data_low > LONG_MAX then
            if vport_index_mask = mask then
                read_vport_index_value = data_low
            else
                read_vport_index_value = (data_low - H8000_0000) and vport_index_mask
            end If
        else
            read_vport_index_value = data_low and vport_index_mask
        end If
        read_prio_value = rightShift(data_low, 27) and &H7
        read_drop_value = rightShift(data_low, 30) and &H1
        read_control_pkt_value = rightShift(data_low, 31) and &H1

    End Sub

    Sub write
        If flag_vport_index = &H0 or flag_prio = &H0 or flag_drop = &H0 or flag_control_pkt = &H0 Then read
        If flag_vport_index = &H0 Then write_vport_index_value = get_vport_index
        If flag_prio = &H0 Then write_prio_value = get_prio
        If flag_drop = &H0 Then write_drop_value = get_drop
        If flag_control_pkt = &H0 Then write_control_pkt_value = get_control_pkt

        regValue = leftShift((write_vport_index_value and &Hf), 0) + leftShift((write_prio_value and &H7), 27) + leftShift((write_drop_value and &H1), 30) + leftShift((write_control_pkt_value and &H1), 31)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        vport_index_mask = &Hf
        if data_low > LONG_MAX then
            if vport_index_mask = mask then
                read_vport_index_value = data_low
            else
                read_vport_index_value = (data_low - H8000_0000) and vport_index_mask
            end If
        else
            read_vport_index_value = data_low and vport_index_mask
        end If
        read_prio_value = rightShift(data_low, 27) and &H7
        read_drop_value = rightShift(data_low, 30) and &H1
        read_control_pkt_value = rightShift(data_low, 31) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_vport_index_value = &H0
        flag_vport_index        = &H0
        write_prio_value = &H0
        flag_prio        = &H0
        write_drop_value = &H0
        flag_drop        = &H0
        write_control_pkt_value = &H0
        flag_control_pkt        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_TCAM_POLICY_tcam_policy_14
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' vport_index                                [3:0]            get_vport_index
''                                                             set_vport_index
''                                                             read_vport_index
''                                                             write_vport_index
''---------------------------------------------------------------------------------
'' prio                                       [29:27]          get_prio
''                                                             set_prio
''                                                             read_prio
''                                                             write_prio
''---------------------------------------------------------------------------------
'' drop                                       [30:30]          get_drop
''                                                             set_drop
''                                                             read_drop
''                                                             write_drop
''---------------------------------------------------------------------------------
'' control_pkt                                [31:31]          get_control_pkt
''                                                             set_control_pkt
''                                                             read_control_pkt
''                                                             write_control_pkt
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_TCAM_POLICY_tcam_policy_14
    Private write_vport_index_value
    Private read_vport_index_value
    Private flag_vport_index
    Private write_prio_value
    Private read_prio_value
    Private flag_prio
    Private write_drop_value
    Private read_drop_value
    Private flag_drop
    Private write_control_pkt_value
    Private read_control_pkt_value
    Private flag_control_pkt

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3038
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_vport_index
        get_vport_index = read_vport_index_value
    End Property

    Property Let set_vport_index(aData)
        write_vport_index_value = aData
        flag_vport_index        = &H1
    End Property

    Property Get read_vport_index
        read
        read_vport_index = read_vport_index_value
    End Property

    Property Let write_vport_index(aData)
        set_vport_index = aData
        write
    End Property

    Property Get get_prio
        get_prio = read_prio_value
    End Property

    Property Let set_prio(aData)
        write_prio_value = aData
        flag_prio        = &H1
    End Property

    Property Get read_prio
        read
        read_prio = read_prio_value
    End Property

    Property Let write_prio(aData)
        set_prio = aData
        write
    End Property

    Property Get get_drop
        get_drop = read_drop_value
    End Property

    Property Let set_drop(aData)
        write_drop_value = aData
        flag_drop        = &H1
    End Property

    Property Get read_drop
        read
        read_drop = read_drop_value
    End Property

    Property Let write_drop(aData)
        set_drop = aData
        write
    End Property

    Property Get get_control_pkt
        get_control_pkt = read_control_pkt_value
    End Property

    Property Let set_control_pkt(aData)
        write_control_pkt_value = aData
        flag_control_pkt        = &H1
    End Property

    Property Get read_control_pkt
        read
        read_control_pkt = read_control_pkt_value
    End Property

    Property Let write_control_pkt(aData)
        set_control_pkt = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        vport_index_mask = &Hf
        if data_low > LONG_MAX then
            if vport_index_mask = mask then
                read_vport_index_value = data_low
            else
                read_vport_index_value = (data_low - H8000_0000) and vport_index_mask
            end If
        else
            read_vport_index_value = data_low and vport_index_mask
        end If
        read_prio_value = rightShift(data_low, 27) and &H7
        read_drop_value = rightShift(data_low, 30) and &H1
        read_control_pkt_value = rightShift(data_low, 31) and &H1

    End Sub

    Sub write
        If flag_vport_index = &H0 or flag_prio = &H0 or flag_drop = &H0 or flag_control_pkt = &H0 Then read
        If flag_vport_index = &H0 Then write_vport_index_value = get_vport_index
        If flag_prio = &H0 Then write_prio_value = get_prio
        If flag_drop = &H0 Then write_drop_value = get_drop
        If flag_control_pkt = &H0 Then write_control_pkt_value = get_control_pkt

        regValue = leftShift((write_vport_index_value and &Hf), 0) + leftShift((write_prio_value and &H7), 27) + leftShift((write_drop_value and &H1), 30) + leftShift((write_control_pkt_value and &H1), 31)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        vport_index_mask = &Hf
        if data_low > LONG_MAX then
            if vport_index_mask = mask then
                read_vport_index_value = data_low
            else
                read_vport_index_value = (data_low - H8000_0000) and vport_index_mask
            end If
        else
            read_vport_index_value = data_low and vport_index_mask
        end If
        read_prio_value = rightShift(data_low, 27) and &H7
        read_drop_value = rightShift(data_low, 30) and &H1
        read_control_pkt_value = rightShift(data_low, 31) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_vport_index_value = &H0
        flag_vport_index        = &H0
        write_prio_value = &H0
        flag_prio        = &H0
        write_drop_value = &H0
        flag_drop        = &H0
        write_control_pkt_value = &H0
        flag_control_pkt        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_TCAM_POLICY_tcam_policy_15
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' vport_index                                [3:0]            get_vport_index
''                                                             set_vport_index
''                                                             read_vport_index
''                                                             write_vport_index
''---------------------------------------------------------------------------------
'' prio                                       [29:27]          get_prio
''                                                             set_prio
''                                                             read_prio
''                                                             write_prio
''---------------------------------------------------------------------------------
'' drop                                       [30:30]          get_drop
''                                                             set_drop
''                                                             read_drop
''                                                             write_drop
''---------------------------------------------------------------------------------
'' control_pkt                                [31:31]          get_control_pkt
''                                                             set_control_pkt
''                                                             read_control_pkt
''                                                             write_control_pkt
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_TCAM_POLICY_tcam_policy_15
    Private write_vport_index_value
    Private read_vport_index_value
    Private flag_vport_index
    Private write_prio_value
    Private read_prio_value
    Private flag_prio
    Private write_drop_value
    Private read_drop_value
    Private flag_drop
    Private write_control_pkt_value
    Private read_control_pkt_value
    Private flag_control_pkt

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H303c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_vport_index
        get_vport_index = read_vport_index_value
    End Property

    Property Let set_vport_index(aData)
        write_vport_index_value = aData
        flag_vport_index        = &H1
    End Property

    Property Get read_vport_index
        read
        read_vport_index = read_vport_index_value
    End Property

    Property Let write_vport_index(aData)
        set_vport_index = aData
        write
    End Property

    Property Get get_prio
        get_prio = read_prio_value
    End Property

    Property Let set_prio(aData)
        write_prio_value = aData
        flag_prio        = &H1
    End Property

    Property Get read_prio
        read
        read_prio = read_prio_value
    End Property

    Property Let write_prio(aData)
        set_prio = aData
        write
    End Property

    Property Get get_drop
        get_drop = read_drop_value
    End Property

    Property Let set_drop(aData)
        write_drop_value = aData
        flag_drop        = &H1
    End Property

    Property Get read_drop
        read
        read_drop = read_drop_value
    End Property

    Property Let write_drop(aData)
        set_drop = aData
        write
    End Property

    Property Get get_control_pkt
        get_control_pkt = read_control_pkt_value
    End Property

    Property Let set_control_pkt(aData)
        write_control_pkt_value = aData
        flag_control_pkt        = &H1
    End Property

    Property Get read_control_pkt
        read
        read_control_pkt = read_control_pkt_value
    End Property

    Property Let write_control_pkt(aData)
        set_control_pkt = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        vport_index_mask = &Hf
        if data_low > LONG_MAX then
            if vport_index_mask = mask then
                read_vport_index_value = data_low
            else
                read_vport_index_value = (data_low - H8000_0000) and vport_index_mask
            end If
        else
            read_vport_index_value = data_low and vport_index_mask
        end If
        read_prio_value = rightShift(data_low, 27) and &H7
        read_drop_value = rightShift(data_low, 30) and &H1
        read_control_pkt_value = rightShift(data_low, 31) and &H1

    End Sub

    Sub write
        If flag_vport_index = &H0 or flag_prio = &H0 or flag_drop = &H0 or flag_control_pkt = &H0 Then read
        If flag_vport_index = &H0 Then write_vport_index_value = get_vport_index
        If flag_prio = &H0 Then write_prio_value = get_prio
        If flag_drop = &H0 Then write_drop_value = get_drop
        If flag_control_pkt = &H0 Then write_control_pkt_value = get_control_pkt

        regValue = leftShift((write_vport_index_value and &Hf), 0) + leftShift((write_prio_value and &H7), 27) + leftShift((write_drop_value and &H1), 30) + leftShift((write_control_pkt_value and &H1), 31)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        vport_index_mask = &Hf
        if data_low > LONG_MAX then
            if vport_index_mask = mask then
                read_vport_index_value = data_low
            else
                read_vport_index_value = (data_low - H8000_0000) and vport_index_mask
            end If
        else
            read_vport_index_value = data_low and vport_index_mask
        end If
        read_prio_value = rightShift(data_low, 27) and &H7
        read_drop_value = rightShift(data_low, 30) and &H1
        read_control_pkt_value = rightShift(data_low, 31) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_vport_index_value = &H0
        flag_vport_index        = &H0
        write_prio_value = &H0
        flag_prio        = &H0
        write_drop_value = &H0
        flag_drop        = &H0
        write_control_pkt_value = &H0
        flag_control_pkt        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_TCAM_POLICY_tcam_policy_16
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' vport_index                                [3:0]            get_vport_index
''                                                             set_vport_index
''                                                             read_vport_index
''                                                             write_vport_index
''---------------------------------------------------------------------------------
'' prio                                       [29:27]          get_prio
''                                                             set_prio
''                                                             read_prio
''                                                             write_prio
''---------------------------------------------------------------------------------
'' drop                                       [30:30]          get_drop
''                                                             set_drop
''                                                             read_drop
''                                                             write_drop
''---------------------------------------------------------------------------------
'' control_pkt                                [31:31]          get_control_pkt
''                                                             set_control_pkt
''                                                             read_control_pkt
''                                                             write_control_pkt
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_TCAM_POLICY_tcam_policy_16
    Private write_vport_index_value
    Private read_vport_index_value
    Private flag_vport_index
    Private write_prio_value
    Private read_prio_value
    Private flag_prio
    Private write_drop_value
    Private read_drop_value
    Private flag_drop
    Private write_control_pkt_value
    Private read_control_pkt_value
    Private flag_control_pkt

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3040
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_vport_index
        get_vport_index = read_vport_index_value
    End Property

    Property Let set_vport_index(aData)
        write_vport_index_value = aData
        flag_vport_index        = &H1
    End Property

    Property Get read_vport_index
        read
        read_vport_index = read_vport_index_value
    End Property

    Property Let write_vport_index(aData)
        set_vport_index = aData
        write
    End Property

    Property Get get_prio
        get_prio = read_prio_value
    End Property

    Property Let set_prio(aData)
        write_prio_value = aData
        flag_prio        = &H1
    End Property

    Property Get read_prio
        read
        read_prio = read_prio_value
    End Property

    Property Let write_prio(aData)
        set_prio = aData
        write
    End Property

    Property Get get_drop
        get_drop = read_drop_value
    End Property

    Property Let set_drop(aData)
        write_drop_value = aData
        flag_drop        = &H1
    End Property

    Property Get read_drop
        read
        read_drop = read_drop_value
    End Property

    Property Let write_drop(aData)
        set_drop = aData
        write
    End Property

    Property Get get_control_pkt
        get_control_pkt = read_control_pkt_value
    End Property

    Property Let set_control_pkt(aData)
        write_control_pkt_value = aData
        flag_control_pkt        = &H1
    End Property

    Property Get read_control_pkt
        read
        read_control_pkt = read_control_pkt_value
    End Property

    Property Let write_control_pkt(aData)
        set_control_pkt = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        vport_index_mask = &Hf
        if data_low > LONG_MAX then
            if vport_index_mask = mask then
                read_vport_index_value = data_low
            else
                read_vport_index_value = (data_low - H8000_0000) and vport_index_mask
            end If
        else
            read_vport_index_value = data_low and vport_index_mask
        end If
        read_prio_value = rightShift(data_low, 27) and &H7
        read_drop_value = rightShift(data_low, 30) and &H1
        read_control_pkt_value = rightShift(data_low, 31) and &H1

    End Sub

    Sub write
        If flag_vport_index = &H0 or flag_prio = &H0 or flag_drop = &H0 or flag_control_pkt = &H0 Then read
        If flag_vport_index = &H0 Then write_vport_index_value = get_vport_index
        If flag_prio = &H0 Then write_prio_value = get_prio
        If flag_drop = &H0 Then write_drop_value = get_drop
        If flag_control_pkt = &H0 Then write_control_pkt_value = get_control_pkt

        regValue = leftShift((write_vport_index_value and &Hf), 0) + leftShift((write_prio_value and &H7), 27) + leftShift((write_drop_value and &H1), 30) + leftShift((write_control_pkt_value and &H1), 31)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        vport_index_mask = &Hf
        if data_low > LONG_MAX then
            if vport_index_mask = mask then
                read_vport_index_value = data_low
            else
                read_vport_index_value = (data_low - H8000_0000) and vport_index_mask
            end If
        else
            read_vport_index_value = data_low and vport_index_mask
        end If
        read_prio_value = rightShift(data_low, 27) and &H7
        read_drop_value = rightShift(data_low, 30) and &H1
        read_control_pkt_value = rightShift(data_low, 31) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_vport_index_value = &H0
        flag_vport_index        = &H0
        write_prio_value = &H0
        flag_prio        = &H0
        write_drop_value = &H0
        flag_drop        = &H0
        write_control_pkt_value = &H0
        flag_control_pkt        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_TCAM_POLICY_tcam_policy_17
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' vport_index                                [3:0]            get_vport_index
''                                                             set_vport_index
''                                                             read_vport_index
''                                                             write_vport_index
''---------------------------------------------------------------------------------
'' prio                                       [29:27]          get_prio
''                                                             set_prio
''                                                             read_prio
''                                                             write_prio
''---------------------------------------------------------------------------------
'' drop                                       [30:30]          get_drop
''                                                             set_drop
''                                                             read_drop
''                                                             write_drop
''---------------------------------------------------------------------------------
'' control_pkt                                [31:31]          get_control_pkt
''                                                             set_control_pkt
''                                                             read_control_pkt
''                                                             write_control_pkt
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_TCAM_POLICY_tcam_policy_17
    Private write_vport_index_value
    Private read_vport_index_value
    Private flag_vport_index
    Private write_prio_value
    Private read_prio_value
    Private flag_prio
    Private write_drop_value
    Private read_drop_value
    Private flag_drop
    Private write_control_pkt_value
    Private read_control_pkt_value
    Private flag_control_pkt

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3044
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_vport_index
        get_vport_index = read_vport_index_value
    End Property

    Property Let set_vport_index(aData)
        write_vport_index_value = aData
        flag_vport_index        = &H1
    End Property

    Property Get read_vport_index
        read
        read_vport_index = read_vport_index_value
    End Property

    Property Let write_vport_index(aData)
        set_vport_index = aData
        write
    End Property

    Property Get get_prio
        get_prio = read_prio_value
    End Property

    Property Let set_prio(aData)
        write_prio_value = aData
        flag_prio        = &H1
    End Property

    Property Get read_prio
        read
        read_prio = read_prio_value
    End Property

    Property Let write_prio(aData)
        set_prio = aData
        write
    End Property

    Property Get get_drop
        get_drop = read_drop_value
    End Property

    Property Let set_drop(aData)
        write_drop_value = aData
        flag_drop        = &H1
    End Property

    Property Get read_drop
        read
        read_drop = read_drop_value
    End Property

    Property Let write_drop(aData)
        set_drop = aData
        write
    End Property

    Property Get get_control_pkt
        get_control_pkt = read_control_pkt_value
    End Property

    Property Let set_control_pkt(aData)
        write_control_pkt_value = aData
        flag_control_pkt        = &H1
    End Property

    Property Get read_control_pkt
        read
        read_control_pkt = read_control_pkt_value
    End Property

    Property Let write_control_pkt(aData)
        set_control_pkt = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        vport_index_mask = &Hf
        if data_low > LONG_MAX then
            if vport_index_mask = mask then
                read_vport_index_value = data_low
            else
                read_vport_index_value = (data_low - H8000_0000) and vport_index_mask
            end If
        else
            read_vport_index_value = data_low and vport_index_mask
        end If
        read_prio_value = rightShift(data_low, 27) and &H7
        read_drop_value = rightShift(data_low, 30) and &H1
        read_control_pkt_value = rightShift(data_low, 31) and &H1

    End Sub

    Sub write
        If flag_vport_index = &H0 or flag_prio = &H0 or flag_drop = &H0 or flag_control_pkt = &H0 Then read
        If flag_vport_index = &H0 Then write_vport_index_value = get_vport_index
        If flag_prio = &H0 Then write_prio_value = get_prio
        If flag_drop = &H0 Then write_drop_value = get_drop
        If flag_control_pkt = &H0 Then write_control_pkt_value = get_control_pkt

        regValue = leftShift((write_vport_index_value and &Hf), 0) + leftShift((write_prio_value and &H7), 27) + leftShift((write_drop_value and &H1), 30) + leftShift((write_control_pkt_value and &H1), 31)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        vport_index_mask = &Hf
        if data_low > LONG_MAX then
            if vport_index_mask = mask then
                read_vport_index_value = data_low
            else
                read_vport_index_value = (data_low - H8000_0000) and vport_index_mask
            end If
        else
            read_vport_index_value = data_low and vport_index_mask
        end If
        read_prio_value = rightShift(data_low, 27) and &H7
        read_drop_value = rightShift(data_low, 30) and &H1
        read_control_pkt_value = rightShift(data_low, 31) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_vport_index_value = &H0
        flag_vport_index        = &H0
        write_prio_value = &H0
        flag_prio        = &H0
        write_drop_value = &H0
        flag_drop        = &H0
        write_control_pkt_value = &H0
        flag_control_pkt        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_TCAM_POLICY_tcam_policy_18
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' vport_index                                [3:0]            get_vport_index
''                                                             set_vport_index
''                                                             read_vport_index
''                                                             write_vport_index
''---------------------------------------------------------------------------------
'' prio                                       [29:27]          get_prio
''                                                             set_prio
''                                                             read_prio
''                                                             write_prio
''---------------------------------------------------------------------------------
'' drop                                       [30:30]          get_drop
''                                                             set_drop
''                                                             read_drop
''                                                             write_drop
''---------------------------------------------------------------------------------
'' control_pkt                                [31:31]          get_control_pkt
''                                                             set_control_pkt
''                                                             read_control_pkt
''                                                             write_control_pkt
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_TCAM_POLICY_tcam_policy_18
    Private write_vport_index_value
    Private read_vport_index_value
    Private flag_vport_index
    Private write_prio_value
    Private read_prio_value
    Private flag_prio
    Private write_drop_value
    Private read_drop_value
    Private flag_drop
    Private write_control_pkt_value
    Private read_control_pkt_value
    Private flag_control_pkt

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3048
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_vport_index
        get_vport_index = read_vport_index_value
    End Property

    Property Let set_vport_index(aData)
        write_vport_index_value = aData
        flag_vport_index        = &H1
    End Property

    Property Get read_vport_index
        read
        read_vport_index = read_vport_index_value
    End Property

    Property Let write_vport_index(aData)
        set_vport_index = aData
        write
    End Property

    Property Get get_prio
        get_prio = read_prio_value
    End Property

    Property Let set_prio(aData)
        write_prio_value = aData
        flag_prio        = &H1
    End Property

    Property Get read_prio
        read
        read_prio = read_prio_value
    End Property

    Property Let write_prio(aData)
        set_prio = aData
        write
    End Property

    Property Get get_drop
        get_drop = read_drop_value
    End Property

    Property Let set_drop(aData)
        write_drop_value = aData
        flag_drop        = &H1
    End Property

    Property Get read_drop
        read
        read_drop = read_drop_value
    End Property

    Property Let write_drop(aData)
        set_drop = aData
        write
    End Property

    Property Get get_control_pkt
        get_control_pkt = read_control_pkt_value
    End Property

    Property Let set_control_pkt(aData)
        write_control_pkt_value = aData
        flag_control_pkt        = &H1
    End Property

    Property Get read_control_pkt
        read
        read_control_pkt = read_control_pkt_value
    End Property

    Property Let write_control_pkt(aData)
        set_control_pkt = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        vport_index_mask = &Hf
        if data_low > LONG_MAX then
            if vport_index_mask = mask then
                read_vport_index_value = data_low
            else
                read_vport_index_value = (data_low - H8000_0000) and vport_index_mask
            end If
        else
            read_vport_index_value = data_low and vport_index_mask
        end If
        read_prio_value = rightShift(data_low, 27) and &H7
        read_drop_value = rightShift(data_low, 30) and &H1
        read_control_pkt_value = rightShift(data_low, 31) and &H1

    End Sub

    Sub write
        If flag_vport_index = &H0 or flag_prio = &H0 or flag_drop = &H0 or flag_control_pkt = &H0 Then read
        If flag_vport_index = &H0 Then write_vport_index_value = get_vport_index
        If flag_prio = &H0 Then write_prio_value = get_prio
        If flag_drop = &H0 Then write_drop_value = get_drop
        If flag_control_pkt = &H0 Then write_control_pkt_value = get_control_pkt

        regValue = leftShift((write_vport_index_value and &Hf), 0) + leftShift((write_prio_value and &H7), 27) + leftShift((write_drop_value and &H1), 30) + leftShift((write_control_pkt_value and &H1), 31)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        vport_index_mask = &Hf
        if data_low > LONG_MAX then
            if vport_index_mask = mask then
                read_vport_index_value = data_low
            else
                read_vport_index_value = (data_low - H8000_0000) and vport_index_mask
            end If
        else
            read_vport_index_value = data_low and vport_index_mask
        end If
        read_prio_value = rightShift(data_low, 27) and &H7
        read_drop_value = rightShift(data_low, 30) and &H1
        read_control_pkt_value = rightShift(data_low, 31) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_vport_index_value = &H0
        flag_vport_index        = &H0
        write_prio_value = &H0
        flag_prio        = &H0
        write_drop_value = &H0
        flag_drop        = &H0
        write_control_pkt_value = &H0
        flag_control_pkt        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_TCAM_POLICY_tcam_policy_19
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' vport_index                                [3:0]            get_vport_index
''                                                             set_vport_index
''                                                             read_vport_index
''                                                             write_vport_index
''---------------------------------------------------------------------------------
'' prio                                       [29:27]          get_prio
''                                                             set_prio
''                                                             read_prio
''                                                             write_prio
''---------------------------------------------------------------------------------
'' drop                                       [30:30]          get_drop
''                                                             set_drop
''                                                             read_drop
''                                                             write_drop
''---------------------------------------------------------------------------------
'' control_pkt                                [31:31]          get_control_pkt
''                                                             set_control_pkt
''                                                             read_control_pkt
''                                                             write_control_pkt
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_TCAM_POLICY_tcam_policy_19
    Private write_vport_index_value
    Private read_vport_index_value
    Private flag_vport_index
    Private write_prio_value
    Private read_prio_value
    Private flag_prio
    Private write_drop_value
    Private read_drop_value
    Private flag_drop
    Private write_control_pkt_value
    Private read_control_pkt_value
    Private flag_control_pkt

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H304c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_vport_index
        get_vport_index = read_vport_index_value
    End Property

    Property Let set_vport_index(aData)
        write_vport_index_value = aData
        flag_vport_index        = &H1
    End Property

    Property Get read_vport_index
        read
        read_vport_index = read_vport_index_value
    End Property

    Property Let write_vport_index(aData)
        set_vport_index = aData
        write
    End Property

    Property Get get_prio
        get_prio = read_prio_value
    End Property

    Property Let set_prio(aData)
        write_prio_value = aData
        flag_prio        = &H1
    End Property

    Property Get read_prio
        read
        read_prio = read_prio_value
    End Property

    Property Let write_prio(aData)
        set_prio = aData
        write
    End Property

    Property Get get_drop
        get_drop = read_drop_value
    End Property

    Property Let set_drop(aData)
        write_drop_value = aData
        flag_drop        = &H1
    End Property

    Property Get read_drop
        read
        read_drop = read_drop_value
    End Property

    Property Let write_drop(aData)
        set_drop = aData
        write
    End Property

    Property Get get_control_pkt
        get_control_pkt = read_control_pkt_value
    End Property

    Property Let set_control_pkt(aData)
        write_control_pkt_value = aData
        flag_control_pkt        = &H1
    End Property

    Property Get read_control_pkt
        read
        read_control_pkt = read_control_pkt_value
    End Property

    Property Let write_control_pkt(aData)
        set_control_pkt = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        vport_index_mask = &Hf
        if data_low > LONG_MAX then
            if vport_index_mask = mask then
                read_vport_index_value = data_low
            else
                read_vport_index_value = (data_low - H8000_0000) and vport_index_mask
            end If
        else
            read_vport_index_value = data_low and vport_index_mask
        end If
        read_prio_value = rightShift(data_low, 27) and &H7
        read_drop_value = rightShift(data_low, 30) and &H1
        read_control_pkt_value = rightShift(data_low, 31) and &H1

    End Sub

    Sub write
        If flag_vport_index = &H0 or flag_prio = &H0 or flag_drop = &H0 or flag_control_pkt = &H0 Then read
        If flag_vport_index = &H0 Then write_vport_index_value = get_vport_index
        If flag_prio = &H0 Then write_prio_value = get_prio
        If flag_drop = &H0 Then write_drop_value = get_drop
        If flag_control_pkt = &H0 Then write_control_pkt_value = get_control_pkt

        regValue = leftShift((write_vport_index_value and &Hf), 0) + leftShift((write_prio_value and &H7), 27) + leftShift((write_drop_value and &H1), 30) + leftShift((write_control_pkt_value and &H1), 31)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        vport_index_mask = &Hf
        if data_low > LONG_MAX then
            if vport_index_mask = mask then
                read_vport_index_value = data_low
            else
                read_vport_index_value = (data_low - H8000_0000) and vport_index_mask
            end If
        else
            read_vport_index_value = data_low and vport_index_mask
        end If
        read_prio_value = rightShift(data_low, 27) and &H7
        read_drop_value = rightShift(data_low, 30) and &H1
        read_control_pkt_value = rightShift(data_low, 31) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_vport_index_value = &H0
        flag_vport_index        = &H0
        write_prio_value = &H0
        flag_prio        = &H0
        write_drop_value = &H0
        flag_drop        = &H0
        write_control_pkt_value = &H0
        flag_control_pkt        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_TCAM_POLICY_tcam_policy_20
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' vport_index                                [3:0]            get_vport_index
''                                                             set_vport_index
''                                                             read_vport_index
''                                                             write_vport_index
''---------------------------------------------------------------------------------
'' prio                                       [29:27]          get_prio
''                                                             set_prio
''                                                             read_prio
''                                                             write_prio
''---------------------------------------------------------------------------------
'' drop                                       [30:30]          get_drop
''                                                             set_drop
''                                                             read_drop
''                                                             write_drop
''---------------------------------------------------------------------------------
'' control_pkt                                [31:31]          get_control_pkt
''                                                             set_control_pkt
''                                                             read_control_pkt
''                                                             write_control_pkt
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_TCAM_POLICY_tcam_policy_20
    Private write_vport_index_value
    Private read_vport_index_value
    Private flag_vport_index
    Private write_prio_value
    Private read_prio_value
    Private flag_prio
    Private write_drop_value
    Private read_drop_value
    Private flag_drop
    Private write_control_pkt_value
    Private read_control_pkt_value
    Private flag_control_pkt

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3050
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_vport_index
        get_vport_index = read_vport_index_value
    End Property

    Property Let set_vport_index(aData)
        write_vport_index_value = aData
        flag_vport_index        = &H1
    End Property

    Property Get read_vport_index
        read
        read_vport_index = read_vport_index_value
    End Property

    Property Let write_vport_index(aData)
        set_vport_index = aData
        write
    End Property

    Property Get get_prio
        get_prio = read_prio_value
    End Property

    Property Let set_prio(aData)
        write_prio_value = aData
        flag_prio        = &H1
    End Property

    Property Get read_prio
        read
        read_prio = read_prio_value
    End Property

    Property Let write_prio(aData)
        set_prio = aData
        write
    End Property

    Property Get get_drop
        get_drop = read_drop_value
    End Property

    Property Let set_drop(aData)
        write_drop_value = aData
        flag_drop        = &H1
    End Property

    Property Get read_drop
        read
        read_drop = read_drop_value
    End Property

    Property Let write_drop(aData)
        set_drop = aData
        write
    End Property

    Property Get get_control_pkt
        get_control_pkt = read_control_pkt_value
    End Property

    Property Let set_control_pkt(aData)
        write_control_pkt_value = aData
        flag_control_pkt        = &H1
    End Property

    Property Get read_control_pkt
        read
        read_control_pkt = read_control_pkt_value
    End Property

    Property Let write_control_pkt(aData)
        set_control_pkt = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        vport_index_mask = &Hf
        if data_low > LONG_MAX then
            if vport_index_mask = mask then
                read_vport_index_value = data_low
            else
                read_vport_index_value = (data_low - H8000_0000) and vport_index_mask
            end If
        else
            read_vport_index_value = data_low and vport_index_mask
        end If
        read_prio_value = rightShift(data_low, 27) and &H7
        read_drop_value = rightShift(data_low, 30) and &H1
        read_control_pkt_value = rightShift(data_low, 31) and &H1

    End Sub

    Sub write
        If flag_vport_index = &H0 or flag_prio = &H0 or flag_drop = &H0 or flag_control_pkt = &H0 Then read
        If flag_vport_index = &H0 Then write_vport_index_value = get_vport_index
        If flag_prio = &H0 Then write_prio_value = get_prio
        If flag_drop = &H0 Then write_drop_value = get_drop
        If flag_control_pkt = &H0 Then write_control_pkt_value = get_control_pkt

        regValue = leftShift((write_vport_index_value and &Hf), 0) + leftShift((write_prio_value and &H7), 27) + leftShift((write_drop_value and &H1), 30) + leftShift((write_control_pkt_value and &H1), 31)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        vport_index_mask = &Hf
        if data_low > LONG_MAX then
            if vport_index_mask = mask then
                read_vport_index_value = data_low
            else
                read_vport_index_value = (data_low - H8000_0000) and vport_index_mask
            end If
        else
            read_vport_index_value = data_low and vport_index_mask
        end If
        read_prio_value = rightShift(data_low, 27) and &H7
        read_drop_value = rightShift(data_low, 30) and &H1
        read_control_pkt_value = rightShift(data_low, 31) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_vport_index_value = &H0
        flag_vport_index        = &H0
        write_prio_value = &H0
        flag_prio        = &H0
        write_drop_value = &H0
        flag_drop        = &H0
        write_control_pkt_value = &H0
        flag_control_pkt        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_TCAM_POLICY_tcam_policy_21
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' vport_index                                [3:0]            get_vport_index
''                                                             set_vport_index
''                                                             read_vport_index
''                                                             write_vport_index
''---------------------------------------------------------------------------------
'' prio                                       [29:27]          get_prio
''                                                             set_prio
''                                                             read_prio
''                                                             write_prio
''---------------------------------------------------------------------------------
'' drop                                       [30:30]          get_drop
''                                                             set_drop
''                                                             read_drop
''                                                             write_drop
''---------------------------------------------------------------------------------
'' control_pkt                                [31:31]          get_control_pkt
''                                                             set_control_pkt
''                                                             read_control_pkt
''                                                             write_control_pkt
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_TCAM_POLICY_tcam_policy_21
    Private write_vport_index_value
    Private read_vport_index_value
    Private flag_vport_index
    Private write_prio_value
    Private read_prio_value
    Private flag_prio
    Private write_drop_value
    Private read_drop_value
    Private flag_drop
    Private write_control_pkt_value
    Private read_control_pkt_value
    Private flag_control_pkt

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3054
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_vport_index
        get_vport_index = read_vport_index_value
    End Property

    Property Let set_vport_index(aData)
        write_vport_index_value = aData
        flag_vport_index        = &H1
    End Property

    Property Get read_vport_index
        read
        read_vport_index = read_vport_index_value
    End Property

    Property Let write_vport_index(aData)
        set_vport_index = aData
        write
    End Property

    Property Get get_prio
        get_prio = read_prio_value
    End Property

    Property Let set_prio(aData)
        write_prio_value = aData
        flag_prio        = &H1
    End Property

    Property Get read_prio
        read
        read_prio = read_prio_value
    End Property

    Property Let write_prio(aData)
        set_prio = aData
        write
    End Property

    Property Get get_drop
        get_drop = read_drop_value
    End Property

    Property Let set_drop(aData)
        write_drop_value = aData
        flag_drop        = &H1
    End Property

    Property Get read_drop
        read
        read_drop = read_drop_value
    End Property

    Property Let write_drop(aData)
        set_drop = aData
        write
    End Property

    Property Get get_control_pkt
        get_control_pkt = read_control_pkt_value
    End Property

    Property Let set_control_pkt(aData)
        write_control_pkt_value = aData
        flag_control_pkt        = &H1
    End Property

    Property Get read_control_pkt
        read
        read_control_pkt = read_control_pkt_value
    End Property

    Property Let write_control_pkt(aData)
        set_control_pkt = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        vport_index_mask = &Hf
        if data_low > LONG_MAX then
            if vport_index_mask = mask then
                read_vport_index_value = data_low
            else
                read_vport_index_value = (data_low - H8000_0000) and vport_index_mask
            end If
        else
            read_vport_index_value = data_low and vport_index_mask
        end If
        read_prio_value = rightShift(data_low, 27) and &H7
        read_drop_value = rightShift(data_low, 30) and &H1
        read_control_pkt_value = rightShift(data_low, 31) and &H1

    End Sub

    Sub write
        If flag_vport_index = &H0 or flag_prio = &H0 or flag_drop = &H0 or flag_control_pkt = &H0 Then read
        If flag_vport_index = &H0 Then write_vport_index_value = get_vport_index
        If flag_prio = &H0 Then write_prio_value = get_prio
        If flag_drop = &H0 Then write_drop_value = get_drop
        If flag_control_pkt = &H0 Then write_control_pkt_value = get_control_pkt

        regValue = leftShift((write_vport_index_value and &Hf), 0) + leftShift((write_prio_value and &H7), 27) + leftShift((write_drop_value and &H1), 30) + leftShift((write_control_pkt_value and &H1), 31)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        vport_index_mask = &Hf
        if data_low > LONG_MAX then
            if vport_index_mask = mask then
                read_vport_index_value = data_low
            else
                read_vport_index_value = (data_low - H8000_0000) and vport_index_mask
            end If
        else
            read_vport_index_value = data_low and vport_index_mask
        end If
        read_prio_value = rightShift(data_low, 27) and &H7
        read_drop_value = rightShift(data_low, 30) and &H1
        read_control_pkt_value = rightShift(data_low, 31) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_vport_index_value = &H0
        flag_vport_index        = &H0
        write_prio_value = &H0
        flag_prio        = &H0
        write_drop_value = &H0
        flag_drop        = &H0
        write_control_pkt_value = &H0
        flag_control_pkt        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_TCAM_POLICY_tcam_policy_22
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' vport_index                                [3:0]            get_vport_index
''                                                             set_vport_index
''                                                             read_vport_index
''                                                             write_vport_index
''---------------------------------------------------------------------------------
'' prio                                       [29:27]          get_prio
''                                                             set_prio
''                                                             read_prio
''                                                             write_prio
''---------------------------------------------------------------------------------
'' drop                                       [30:30]          get_drop
''                                                             set_drop
''                                                             read_drop
''                                                             write_drop
''---------------------------------------------------------------------------------
'' control_pkt                                [31:31]          get_control_pkt
''                                                             set_control_pkt
''                                                             read_control_pkt
''                                                             write_control_pkt
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_TCAM_POLICY_tcam_policy_22
    Private write_vport_index_value
    Private read_vport_index_value
    Private flag_vport_index
    Private write_prio_value
    Private read_prio_value
    Private flag_prio
    Private write_drop_value
    Private read_drop_value
    Private flag_drop
    Private write_control_pkt_value
    Private read_control_pkt_value
    Private flag_control_pkt

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3058
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_vport_index
        get_vport_index = read_vport_index_value
    End Property

    Property Let set_vport_index(aData)
        write_vport_index_value = aData
        flag_vport_index        = &H1
    End Property

    Property Get read_vport_index
        read
        read_vport_index = read_vport_index_value
    End Property

    Property Let write_vport_index(aData)
        set_vport_index = aData
        write
    End Property

    Property Get get_prio
        get_prio = read_prio_value
    End Property

    Property Let set_prio(aData)
        write_prio_value = aData
        flag_prio        = &H1
    End Property

    Property Get read_prio
        read
        read_prio = read_prio_value
    End Property

    Property Let write_prio(aData)
        set_prio = aData
        write
    End Property

    Property Get get_drop
        get_drop = read_drop_value
    End Property

    Property Let set_drop(aData)
        write_drop_value = aData
        flag_drop        = &H1
    End Property

    Property Get read_drop
        read
        read_drop = read_drop_value
    End Property

    Property Let write_drop(aData)
        set_drop = aData
        write
    End Property

    Property Get get_control_pkt
        get_control_pkt = read_control_pkt_value
    End Property

    Property Let set_control_pkt(aData)
        write_control_pkt_value = aData
        flag_control_pkt        = &H1
    End Property

    Property Get read_control_pkt
        read
        read_control_pkt = read_control_pkt_value
    End Property

    Property Let write_control_pkt(aData)
        set_control_pkt = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        vport_index_mask = &Hf
        if data_low > LONG_MAX then
            if vport_index_mask = mask then
                read_vport_index_value = data_low
            else
                read_vport_index_value = (data_low - H8000_0000) and vport_index_mask
            end If
        else
            read_vport_index_value = data_low and vport_index_mask
        end If
        read_prio_value = rightShift(data_low, 27) and &H7
        read_drop_value = rightShift(data_low, 30) and &H1
        read_control_pkt_value = rightShift(data_low, 31) and &H1

    End Sub

    Sub write
        If flag_vport_index = &H0 or flag_prio = &H0 or flag_drop = &H0 or flag_control_pkt = &H0 Then read
        If flag_vport_index = &H0 Then write_vport_index_value = get_vport_index
        If flag_prio = &H0 Then write_prio_value = get_prio
        If flag_drop = &H0 Then write_drop_value = get_drop
        If flag_control_pkt = &H0 Then write_control_pkt_value = get_control_pkt

        regValue = leftShift((write_vport_index_value and &Hf), 0) + leftShift((write_prio_value and &H7), 27) + leftShift((write_drop_value and &H1), 30) + leftShift((write_control_pkt_value and &H1), 31)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        vport_index_mask = &Hf
        if data_low > LONG_MAX then
            if vport_index_mask = mask then
                read_vport_index_value = data_low
            else
                read_vport_index_value = (data_low - H8000_0000) and vport_index_mask
            end If
        else
            read_vport_index_value = data_low and vport_index_mask
        end If
        read_prio_value = rightShift(data_low, 27) and &H7
        read_drop_value = rightShift(data_low, 30) and &H1
        read_control_pkt_value = rightShift(data_low, 31) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_vport_index_value = &H0
        flag_vport_index        = &H0
        write_prio_value = &H0
        flag_prio        = &H0
        write_drop_value = &H0
        flag_drop        = &H0
        write_control_pkt_value = &H0
        flag_control_pkt        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_TCAM_POLICY_tcam_policy_23
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' vport_index                                [3:0]            get_vport_index
''                                                             set_vport_index
''                                                             read_vport_index
''                                                             write_vport_index
''---------------------------------------------------------------------------------
'' prio                                       [29:27]          get_prio
''                                                             set_prio
''                                                             read_prio
''                                                             write_prio
''---------------------------------------------------------------------------------
'' drop                                       [30:30]          get_drop
''                                                             set_drop
''                                                             read_drop
''                                                             write_drop
''---------------------------------------------------------------------------------
'' control_pkt                                [31:31]          get_control_pkt
''                                                             set_control_pkt
''                                                             read_control_pkt
''                                                             write_control_pkt
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_TCAM_POLICY_tcam_policy_23
    Private write_vport_index_value
    Private read_vport_index_value
    Private flag_vport_index
    Private write_prio_value
    Private read_prio_value
    Private flag_prio
    Private write_drop_value
    Private read_drop_value
    Private flag_drop
    Private write_control_pkt_value
    Private read_control_pkt_value
    Private flag_control_pkt

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H305c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_vport_index
        get_vport_index = read_vport_index_value
    End Property

    Property Let set_vport_index(aData)
        write_vport_index_value = aData
        flag_vport_index        = &H1
    End Property

    Property Get read_vport_index
        read
        read_vport_index = read_vport_index_value
    End Property

    Property Let write_vport_index(aData)
        set_vport_index = aData
        write
    End Property

    Property Get get_prio
        get_prio = read_prio_value
    End Property

    Property Let set_prio(aData)
        write_prio_value = aData
        flag_prio        = &H1
    End Property

    Property Get read_prio
        read
        read_prio = read_prio_value
    End Property

    Property Let write_prio(aData)
        set_prio = aData
        write
    End Property

    Property Get get_drop
        get_drop = read_drop_value
    End Property

    Property Let set_drop(aData)
        write_drop_value = aData
        flag_drop        = &H1
    End Property

    Property Get read_drop
        read
        read_drop = read_drop_value
    End Property

    Property Let write_drop(aData)
        set_drop = aData
        write
    End Property

    Property Get get_control_pkt
        get_control_pkt = read_control_pkt_value
    End Property

    Property Let set_control_pkt(aData)
        write_control_pkt_value = aData
        flag_control_pkt        = &H1
    End Property

    Property Get read_control_pkt
        read
        read_control_pkt = read_control_pkt_value
    End Property

    Property Let write_control_pkt(aData)
        set_control_pkt = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        vport_index_mask = &Hf
        if data_low > LONG_MAX then
            if vport_index_mask = mask then
                read_vport_index_value = data_low
            else
                read_vport_index_value = (data_low - H8000_0000) and vport_index_mask
            end If
        else
            read_vport_index_value = data_low and vport_index_mask
        end If
        read_prio_value = rightShift(data_low, 27) and &H7
        read_drop_value = rightShift(data_low, 30) and &H1
        read_control_pkt_value = rightShift(data_low, 31) and &H1

    End Sub

    Sub write
        If flag_vport_index = &H0 or flag_prio = &H0 or flag_drop = &H0 or flag_control_pkt = &H0 Then read
        If flag_vport_index = &H0 Then write_vport_index_value = get_vport_index
        If flag_prio = &H0 Then write_prio_value = get_prio
        If flag_drop = &H0 Then write_drop_value = get_drop
        If flag_control_pkt = &H0 Then write_control_pkt_value = get_control_pkt

        regValue = leftShift((write_vport_index_value and &Hf), 0) + leftShift((write_prio_value and &H7), 27) + leftShift((write_drop_value and &H1), 30) + leftShift((write_control_pkt_value and &H1), 31)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        vport_index_mask = &Hf
        if data_low > LONG_MAX then
            if vport_index_mask = mask then
                read_vport_index_value = data_low
            else
                read_vport_index_value = (data_low - H8000_0000) and vport_index_mask
            end If
        else
            read_vport_index_value = data_low and vport_index_mask
        end If
        read_prio_value = rightShift(data_low, 27) and &H7
        read_drop_value = rightShift(data_low, 30) and &H1
        read_control_pkt_value = rightShift(data_low, 31) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_vport_index_value = &H0
        flag_vport_index        = &H0
        write_prio_value = &H0
        flag_prio        = &H0
        write_drop_value = &H0
        flag_drop        = &H0
        write_control_pkt_value = &H0
        flag_control_pkt        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_TCAM_POLICY_tcam_policy_24
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' vport_index                                [3:0]            get_vport_index
''                                                             set_vport_index
''                                                             read_vport_index
''                                                             write_vport_index
''---------------------------------------------------------------------------------
'' prio                                       [29:27]          get_prio
''                                                             set_prio
''                                                             read_prio
''                                                             write_prio
''---------------------------------------------------------------------------------
'' drop                                       [30:30]          get_drop
''                                                             set_drop
''                                                             read_drop
''                                                             write_drop
''---------------------------------------------------------------------------------
'' control_pkt                                [31:31]          get_control_pkt
''                                                             set_control_pkt
''                                                             read_control_pkt
''                                                             write_control_pkt
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_TCAM_POLICY_tcam_policy_24
    Private write_vport_index_value
    Private read_vport_index_value
    Private flag_vport_index
    Private write_prio_value
    Private read_prio_value
    Private flag_prio
    Private write_drop_value
    Private read_drop_value
    Private flag_drop
    Private write_control_pkt_value
    Private read_control_pkt_value
    Private flag_control_pkt

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3060
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_vport_index
        get_vport_index = read_vport_index_value
    End Property

    Property Let set_vport_index(aData)
        write_vport_index_value = aData
        flag_vport_index        = &H1
    End Property

    Property Get read_vport_index
        read
        read_vport_index = read_vport_index_value
    End Property

    Property Let write_vport_index(aData)
        set_vport_index = aData
        write
    End Property

    Property Get get_prio
        get_prio = read_prio_value
    End Property

    Property Let set_prio(aData)
        write_prio_value = aData
        flag_prio        = &H1
    End Property

    Property Get read_prio
        read
        read_prio = read_prio_value
    End Property

    Property Let write_prio(aData)
        set_prio = aData
        write
    End Property

    Property Get get_drop
        get_drop = read_drop_value
    End Property

    Property Let set_drop(aData)
        write_drop_value = aData
        flag_drop        = &H1
    End Property

    Property Get read_drop
        read
        read_drop = read_drop_value
    End Property

    Property Let write_drop(aData)
        set_drop = aData
        write
    End Property

    Property Get get_control_pkt
        get_control_pkt = read_control_pkt_value
    End Property

    Property Let set_control_pkt(aData)
        write_control_pkt_value = aData
        flag_control_pkt        = &H1
    End Property

    Property Get read_control_pkt
        read
        read_control_pkt = read_control_pkt_value
    End Property

    Property Let write_control_pkt(aData)
        set_control_pkt = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        vport_index_mask = &Hf
        if data_low > LONG_MAX then
            if vport_index_mask = mask then
                read_vport_index_value = data_low
            else
                read_vport_index_value = (data_low - H8000_0000) and vport_index_mask
            end If
        else
            read_vport_index_value = data_low and vport_index_mask
        end If
        read_prio_value = rightShift(data_low, 27) and &H7
        read_drop_value = rightShift(data_low, 30) and &H1
        read_control_pkt_value = rightShift(data_low, 31) and &H1

    End Sub

    Sub write
        If flag_vport_index = &H0 or flag_prio = &H0 or flag_drop = &H0 or flag_control_pkt = &H0 Then read
        If flag_vport_index = &H0 Then write_vport_index_value = get_vport_index
        If flag_prio = &H0 Then write_prio_value = get_prio
        If flag_drop = &H0 Then write_drop_value = get_drop
        If flag_control_pkt = &H0 Then write_control_pkt_value = get_control_pkt

        regValue = leftShift((write_vport_index_value and &Hf), 0) + leftShift((write_prio_value and &H7), 27) + leftShift((write_drop_value and &H1), 30) + leftShift((write_control_pkt_value and &H1), 31)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        vport_index_mask = &Hf
        if data_low > LONG_MAX then
            if vport_index_mask = mask then
                read_vport_index_value = data_low
            else
                read_vport_index_value = (data_low - H8000_0000) and vport_index_mask
            end If
        else
            read_vport_index_value = data_low and vport_index_mask
        end If
        read_prio_value = rightShift(data_low, 27) and &H7
        read_drop_value = rightShift(data_low, 30) and &H1
        read_control_pkt_value = rightShift(data_low, 31) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_vport_index_value = &H0
        flag_vport_index        = &H0
        write_prio_value = &H0
        flag_prio        = &H0
        write_drop_value = &H0
        flag_drop        = &H0
        write_control_pkt_value = &H0
        flag_control_pkt        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_TCAM_POLICY_tcam_policy_25
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' vport_index                                [3:0]            get_vport_index
''                                                             set_vport_index
''                                                             read_vport_index
''                                                             write_vport_index
''---------------------------------------------------------------------------------
'' prio                                       [29:27]          get_prio
''                                                             set_prio
''                                                             read_prio
''                                                             write_prio
''---------------------------------------------------------------------------------
'' drop                                       [30:30]          get_drop
''                                                             set_drop
''                                                             read_drop
''                                                             write_drop
''---------------------------------------------------------------------------------
'' control_pkt                                [31:31]          get_control_pkt
''                                                             set_control_pkt
''                                                             read_control_pkt
''                                                             write_control_pkt
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_TCAM_POLICY_tcam_policy_25
    Private write_vport_index_value
    Private read_vport_index_value
    Private flag_vport_index
    Private write_prio_value
    Private read_prio_value
    Private flag_prio
    Private write_drop_value
    Private read_drop_value
    Private flag_drop
    Private write_control_pkt_value
    Private read_control_pkt_value
    Private flag_control_pkt

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3064
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_vport_index
        get_vport_index = read_vport_index_value
    End Property

    Property Let set_vport_index(aData)
        write_vport_index_value = aData
        flag_vport_index        = &H1
    End Property

    Property Get read_vport_index
        read
        read_vport_index = read_vport_index_value
    End Property

    Property Let write_vport_index(aData)
        set_vport_index = aData
        write
    End Property

    Property Get get_prio
        get_prio = read_prio_value
    End Property

    Property Let set_prio(aData)
        write_prio_value = aData
        flag_prio        = &H1
    End Property

    Property Get read_prio
        read
        read_prio = read_prio_value
    End Property

    Property Let write_prio(aData)
        set_prio = aData
        write
    End Property

    Property Get get_drop
        get_drop = read_drop_value
    End Property

    Property Let set_drop(aData)
        write_drop_value = aData
        flag_drop        = &H1
    End Property

    Property Get read_drop
        read
        read_drop = read_drop_value
    End Property

    Property Let write_drop(aData)
        set_drop = aData
        write
    End Property

    Property Get get_control_pkt
        get_control_pkt = read_control_pkt_value
    End Property

    Property Let set_control_pkt(aData)
        write_control_pkt_value = aData
        flag_control_pkt        = &H1
    End Property

    Property Get read_control_pkt
        read
        read_control_pkt = read_control_pkt_value
    End Property

    Property Let write_control_pkt(aData)
        set_control_pkt = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        vport_index_mask = &Hf
        if data_low > LONG_MAX then
            if vport_index_mask = mask then
                read_vport_index_value = data_low
            else
                read_vport_index_value = (data_low - H8000_0000) and vport_index_mask
            end If
        else
            read_vport_index_value = data_low and vport_index_mask
        end If
        read_prio_value = rightShift(data_low, 27) and &H7
        read_drop_value = rightShift(data_low, 30) and &H1
        read_control_pkt_value = rightShift(data_low, 31) and &H1

    End Sub

    Sub write
        If flag_vport_index = &H0 or flag_prio = &H0 or flag_drop = &H0 or flag_control_pkt = &H0 Then read
        If flag_vport_index = &H0 Then write_vport_index_value = get_vport_index
        If flag_prio = &H0 Then write_prio_value = get_prio
        If flag_drop = &H0 Then write_drop_value = get_drop
        If flag_control_pkt = &H0 Then write_control_pkt_value = get_control_pkt

        regValue = leftShift((write_vport_index_value and &Hf), 0) + leftShift((write_prio_value and &H7), 27) + leftShift((write_drop_value and &H1), 30) + leftShift((write_control_pkt_value and &H1), 31)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        vport_index_mask = &Hf
        if data_low > LONG_MAX then
            if vport_index_mask = mask then
                read_vport_index_value = data_low
            else
                read_vport_index_value = (data_low - H8000_0000) and vport_index_mask
            end If
        else
            read_vport_index_value = data_low and vport_index_mask
        end If
        read_prio_value = rightShift(data_low, 27) and &H7
        read_drop_value = rightShift(data_low, 30) and &H1
        read_control_pkt_value = rightShift(data_low, 31) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_vport_index_value = &H0
        flag_vport_index        = &H0
        write_prio_value = &H0
        flag_prio        = &H0
        write_drop_value = &H0
        flag_drop        = &H0
        write_control_pkt_value = &H0
        flag_control_pkt        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_TCAM_POLICY_tcam_policy_26
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' vport_index                                [3:0]            get_vport_index
''                                                             set_vport_index
''                                                             read_vport_index
''                                                             write_vport_index
''---------------------------------------------------------------------------------
'' prio                                       [29:27]          get_prio
''                                                             set_prio
''                                                             read_prio
''                                                             write_prio
''---------------------------------------------------------------------------------
'' drop                                       [30:30]          get_drop
''                                                             set_drop
''                                                             read_drop
''                                                             write_drop
''---------------------------------------------------------------------------------
'' control_pkt                                [31:31]          get_control_pkt
''                                                             set_control_pkt
''                                                             read_control_pkt
''                                                             write_control_pkt
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_TCAM_POLICY_tcam_policy_26
    Private write_vport_index_value
    Private read_vport_index_value
    Private flag_vport_index
    Private write_prio_value
    Private read_prio_value
    Private flag_prio
    Private write_drop_value
    Private read_drop_value
    Private flag_drop
    Private write_control_pkt_value
    Private read_control_pkt_value
    Private flag_control_pkt

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3068
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_vport_index
        get_vport_index = read_vport_index_value
    End Property

    Property Let set_vport_index(aData)
        write_vport_index_value = aData
        flag_vport_index        = &H1
    End Property

    Property Get read_vport_index
        read
        read_vport_index = read_vport_index_value
    End Property

    Property Let write_vport_index(aData)
        set_vport_index = aData
        write
    End Property

    Property Get get_prio
        get_prio = read_prio_value
    End Property

    Property Let set_prio(aData)
        write_prio_value = aData
        flag_prio        = &H1
    End Property

    Property Get read_prio
        read
        read_prio = read_prio_value
    End Property

    Property Let write_prio(aData)
        set_prio = aData
        write
    End Property

    Property Get get_drop
        get_drop = read_drop_value
    End Property

    Property Let set_drop(aData)
        write_drop_value = aData
        flag_drop        = &H1
    End Property

    Property Get read_drop
        read
        read_drop = read_drop_value
    End Property

    Property Let write_drop(aData)
        set_drop = aData
        write
    End Property

    Property Get get_control_pkt
        get_control_pkt = read_control_pkt_value
    End Property

    Property Let set_control_pkt(aData)
        write_control_pkt_value = aData
        flag_control_pkt        = &H1
    End Property

    Property Get read_control_pkt
        read
        read_control_pkt = read_control_pkt_value
    End Property

    Property Let write_control_pkt(aData)
        set_control_pkt = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        vport_index_mask = &Hf
        if data_low > LONG_MAX then
            if vport_index_mask = mask then
                read_vport_index_value = data_low
            else
                read_vport_index_value = (data_low - H8000_0000) and vport_index_mask
            end If
        else
            read_vport_index_value = data_low and vport_index_mask
        end If
        read_prio_value = rightShift(data_low, 27) and &H7
        read_drop_value = rightShift(data_low, 30) and &H1
        read_control_pkt_value = rightShift(data_low, 31) and &H1

    End Sub

    Sub write
        If flag_vport_index = &H0 or flag_prio = &H0 or flag_drop = &H0 or flag_control_pkt = &H0 Then read
        If flag_vport_index = &H0 Then write_vport_index_value = get_vport_index
        If flag_prio = &H0 Then write_prio_value = get_prio
        If flag_drop = &H0 Then write_drop_value = get_drop
        If flag_control_pkt = &H0 Then write_control_pkt_value = get_control_pkt

        regValue = leftShift((write_vport_index_value and &Hf), 0) + leftShift((write_prio_value and &H7), 27) + leftShift((write_drop_value and &H1), 30) + leftShift((write_control_pkt_value and &H1), 31)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        vport_index_mask = &Hf
        if data_low > LONG_MAX then
            if vport_index_mask = mask then
                read_vport_index_value = data_low
            else
                read_vport_index_value = (data_low - H8000_0000) and vport_index_mask
            end If
        else
            read_vport_index_value = data_low and vport_index_mask
        end If
        read_prio_value = rightShift(data_low, 27) and &H7
        read_drop_value = rightShift(data_low, 30) and &H1
        read_control_pkt_value = rightShift(data_low, 31) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_vport_index_value = &H0
        flag_vport_index        = &H0
        write_prio_value = &H0
        flag_prio        = &H0
        write_drop_value = &H0
        flag_drop        = &H0
        write_control_pkt_value = &H0
        flag_control_pkt        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_TCAM_POLICY_tcam_policy_27
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' vport_index                                [3:0]            get_vport_index
''                                                             set_vport_index
''                                                             read_vport_index
''                                                             write_vport_index
''---------------------------------------------------------------------------------
'' prio                                       [29:27]          get_prio
''                                                             set_prio
''                                                             read_prio
''                                                             write_prio
''---------------------------------------------------------------------------------
'' drop                                       [30:30]          get_drop
''                                                             set_drop
''                                                             read_drop
''                                                             write_drop
''---------------------------------------------------------------------------------
'' control_pkt                                [31:31]          get_control_pkt
''                                                             set_control_pkt
''                                                             read_control_pkt
''                                                             write_control_pkt
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_TCAM_POLICY_tcam_policy_27
    Private write_vport_index_value
    Private read_vport_index_value
    Private flag_vport_index
    Private write_prio_value
    Private read_prio_value
    Private flag_prio
    Private write_drop_value
    Private read_drop_value
    Private flag_drop
    Private write_control_pkt_value
    Private read_control_pkt_value
    Private flag_control_pkt

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H306c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_vport_index
        get_vport_index = read_vport_index_value
    End Property

    Property Let set_vport_index(aData)
        write_vport_index_value = aData
        flag_vport_index        = &H1
    End Property

    Property Get read_vport_index
        read
        read_vport_index = read_vport_index_value
    End Property

    Property Let write_vport_index(aData)
        set_vport_index = aData
        write
    End Property

    Property Get get_prio
        get_prio = read_prio_value
    End Property

    Property Let set_prio(aData)
        write_prio_value = aData
        flag_prio        = &H1
    End Property

    Property Get read_prio
        read
        read_prio = read_prio_value
    End Property

    Property Let write_prio(aData)
        set_prio = aData
        write
    End Property

    Property Get get_drop
        get_drop = read_drop_value
    End Property

    Property Let set_drop(aData)
        write_drop_value = aData
        flag_drop        = &H1
    End Property

    Property Get read_drop
        read
        read_drop = read_drop_value
    End Property

    Property Let write_drop(aData)
        set_drop = aData
        write
    End Property

    Property Get get_control_pkt
        get_control_pkt = read_control_pkt_value
    End Property

    Property Let set_control_pkt(aData)
        write_control_pkt_value = aData
        flag_control_pkt        = &H1
    End Property

    Property Get read_control_pkt
        read
        read_control_pkt = read_control_pkt_value
    End Property

    Property Let write_control_pkt(aData)
        set_control_pkt = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        vport_index_mask = &Hf
        if data_low > LONG_MAX then
            if vport_index_mask = mask then
                read_vport_index_value = data_low
            else
                read_vport_index_value = (data_low - H8000_0000) and vport_index_mask
            end If
        else
            read_vport_index_value = data_low and vport_index_mask
        end If
        read_prio_value = rightShift(data_low, 27) and &H7
        read_drop_value = rightShift(data_low, 30) and &H1
        read_control_pkt_value = rightShift(data_low, 31) and &H1

    End Sub

    Sub write
        If flag_vport_index = &H0 or flag_prio = &H0 or flag_drop = &H0 or flag_control_pkt = &H0 Then read
        If flag_vport_index = &H0 Then write_vport_index_value = get_vport_index
        If flag_prio = &H0 Then write_prio_value = get_prio
        If flag_drop = &H0 Then write_drop_value = get_drop
        If flag_control_pkt = &H0 Then write_control_pkt_value = get_control_pkt

        regValue = leftShift((write_vport_index_value and &Hf), 0) + leftShift((write_prio_value and &H7), 27) + leftShift((write_drop_value and &H1), 30) + leftShift((write_control_pkt_value and &H1), 31)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        vport_index_mask = &Hf
        if data_low > LONG_MAX then
            if vport_index_mask = mask then
                read_vport_index_value = data_low
            else
                read_vport_index_value = (data_low - H8000_0000) and vport_index_mask
            end If
        else
            read_vport_index_value = data_low and vport_index_mask
        end If
        read_prio_value = rightShift(data_low, 27) and &H7
        read_drop_value = rightShift(data_low, 30) and &H1
        read_control_pkt_value = rightShift(data_low, 31) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_vport_index_value = &H0
        flag_vport_index        = &H0
        write_prio_value = &H0
        flag_prio        = &H0
        write_drop_value = &H0
        flag_drop        = &H0
        write_control_pkt_value = &H0
        flag_control_pkt        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_TCAM_POLICY_tcam_policy_28
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' vport_index                                [3:0]            get_vport_index
''                                                             set_vport_index
''                                                             read_vport_index
''                                                             write_vport_index
''---------------------------------------------------------------------------------
'' prio                                       [29:27]          get_prio
''                                                             set_prio
''                                                             read_prio
''                                                             write_prio
''---------------------------------------------------------------------------------
'' drop                                       [30:30]          get_drop
''                                                             set_drop
''                                                             read_drop
''                                                             write_drop
''---------------------------------------------------------------------------------
'' control_pkt                                [31:31]          get_control_pkt
''                                                             set_control_pkt
''                                                             read_control_pkt
''                                                             write_control_pkt
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_TCAM_POLICY_tcam_policy_28
    Private write_vport_index_value
    Private read_vport_index_value
    Private flag_vport_index
    Private write_prio_value
    Private read_prio_value
    Private flag_prio
    Private write_drop_value
    Private read_drop_value
    Private flag_drop
    Private write_control_pkt_value
    Private read_control_pkt_value
    Private flag_control_pkt

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3070
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_vport_index
        get_vport_index = read_vport_index_value
    End Property

    Property Let set_vport_index(aData)
        write_vport_index_value = aData
        flag_vport_index        = &H1
    End Property

    Property Get read_vport_index
        read
        read_vport_index = read_vport_index_value
    End Property

    Property Let write_vport_index(aData)
        set_vport_index = aData
        write
    End Property

    Property Get get_prio
        get_prio = read_prio_value
    End Property

    Property Let set_prio(aData)
        write_prio_value = aData
        flag_prio        = &H1
    End Property

    Property Get read_prio
        read
        read_prio = read_prio_value
    End Property

    Property Let write_prio(aData)
        set_prio = aData
        write
    End Property

    Property Get get_drop
        get_drop = read_drop_value
    End Property

    Property Let set_drop(aData)
        write_drop_value = aData
        flag_drop        = &H1
    End Property

    Property Get read_drop
        read
        read_drop = read_drop_value
    End Property

    Property Let write_drop(aData)
        set_drop = aData
        write
    End Property

    Property Get get_control_pkt
        get_control_pkt = read_control_pkt_value
    End Property

    Property Let set_control_pkt(aData)
        write_control_pkt_value = aData
        flag_control_pkt        = &H1
    End Property

    Property Get read_control_pkt
        read
        read_control_pkt = read_control_pkt_value
    End Property

    Property Let write_control_pkt(aData)
        set_control_pkt = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        vport_index_mask = &Hf
        if data_low > LONG_MAX then
            if vport_index_mask = mask then
                read_vport_index_value = data_low
            else
                read_vport_index_value = (data_low - H8000_0000) and vport_index_mask
            end If
        else
            read_vport_index_value = data_low and vport_index_mask
        end If
        read_prio_value = rightShift(data_low, 27) and &H7
        read_drop_value = rightShift(data_low, 30) and &H1
        read_control_pkt_value = rightShift(data_low, 31) and &H1

    End Sub

    Sub write
        If flag_vport_index = &H0 or flag_prio = &H0 or flag_drop = &H0 or flag_control_pkt = &H0 Then read
        If flag_vport_index = &H0 Then write_vport_index_value = get_vport_index
        If flag_prio = &H0 Then write_prio_value = get_prio
        If flag_drop = &H0 Then write_drop_value = get_drop
        If flag_control_pkt = &H0 Then write_control_pkt_value = get_control_pkt

        regValue = leftShift((write_vport_index_value and &Hf), 0) + leftShift((write_prio_value and &H7), 27) + leftShift((write_drop_value and &H1), 30) + leftShift((write_control_pkt_value and &H1), 31)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        vport_index_mask = &Hf
        if data_low > LONG_MAX then
            if vport_index_mask = mask then
                read_vport_index_value = data_low
            else
                read_vport_index_value = (data_low - H8000_0000) and vport_index_mask
            end If
        else
            read_vport_index_value = data_low and vport_index_mask
        end If
        read_prio_value = rightShift(data_low, 27) and &H7
        read_drop_value = rightShift(data_low, 30) and &H1
        read_control_pkt_value = rightShift(data_low, 31) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_vport_index_value = &H0
        flag_vport_index        = &H0
        write_prio_value = &H0
        flag_prio        = &H0
        write_drop_value = &H0
        flag_drop        = &H0
        write_control_pkt_value = &H0
        flag_control_pkt        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_TCAM_POLICY_tcam_policy_29
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' vport_index                                [3:0]            get_vport_index
''                                                             set_vport_index
''                                                             read_vport_index
''                                                             write_vport_index
''---------------------------------------------------------------------------------
'' prio                                       [29:27]          get_prio
''                                                             set_prio
''                                                             read_prio
''                                                             write_prio
''---------------------------------------------------------------------------------
'' drop                                       [30:30]          get_drop
''                                                             set_drop
''                                                             read_drop
''                                                             write_drop
''---------------------------------------------------------------------------------
'' control_pkt                                [31:31]          get_control_pkt
''                                                             set_control_pkt
''                                                             read_control_pkt
''                                                             write_control_pkt
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_TCAM_POLICY_tcam_policy_29
    Private write_vport_index_value
    Private read_vport_index_value
    Private flag_vport_index
    Private write_prio_value
    Private read_prio_value
    Private flag_prio
    Private write_drop_value
    Private read_drop_value
    Private flag_drop
    Private write_control_pkt_value
    Private read_control_pkt_value
    Private flag_control_pkt

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3074
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_vport_index
        get_vport_index = read_vport_index_value
    End Property

    Property Let set_vport_index(aData)
        write_vport_index_value = aData
        flag_vport_index        = &H1
    End Property

    Property Get read_vport_index
        read
        read_vport_index = read_vport_index_value
    End Property

    Property Let write_vport_index(aData)
        set_vport_index = aData
        write
    End Property

    Property Get get_prio
        get_prio = read_prio_value
    End Property

    Property Let set_prio(aData)
        write_prio_value = aData
        flag_prio        = &H1
    End Property

    Property Get read_prio
        read
        read_prio = read_prio_value
    End Property

    Property Let write_prio(aData)
        set_prio = aData
        write
    End Property

    Property Get get_drop
        get_drop = read_drop_value
    End Property

    Property Let set_drop(aData)
        write_drop_value = aData
        flag_drop        = &H1
    End Property

    Property Get read_drop
        read
        read_drop = read_drop_value
    End Property

    Property Let write_drop(aData)
        set_drop = aData
        write
    End Property

    Property Get get_control_pkt
        get_control_pkt = read_control_pkt_value
    End Property

    Property Let set_control_pkt(aData)
        write_control_pkt_value = aData
        flag_control_pkt        = &H1
    End Property

    Property Get read_control_pkt
        read
        read_control_pkt = read_control_pkt_value
    End Property

    Property Let write_control_pkt(aData)
        set_control_pkt = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        vport_index_mask = &Hf
        if data_low > LONG_MAX then
            if vport_index_mask = mask then
                read_vport_index_value = data_low
            else
                read_vport_index_value = (data_low - H8000_0000) and vport_index_mask
            end If
        else
            read_vport_index_value = data_low and vport_index_mask
        end If
        read_prio_value = rightShift(data_low, 27) and &H7
        read_drop_value = rightShift(data_low, 30) and &H1
        read_control_pkt_value = rightShift(data_low, 31) and &H1

    End Sub

    Sub write
        If flag_vport_index = &H0 or flag_prio = &H0 or flag_drop = &H0 or flag_control_pkt = &H0 Then read
        If flag_vport_index = &H0 Then write_vport_index_value = get_vport_index
        If flag_prio = &H0 Then write_prio_value = get_prio
        If flag_drop = &H0 Then write_drop_value = get_drop
        If flag_control_pkt = &H0 Then write_control_pkt_value = get_control_pkt

        regValue = leftShift((write_vport_index_value and &Hf), 0) + leftShift((write_prio_value and &H7), 27) + leftShift((write_drop_value and &H1), 30) + leftShift((write_control_pkt_value and &H1), 31)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        vport_index_mask = &Hf
        if data_low > LONG_MAX then
            if vport_index_mask = mask then
                read_vport_index_value = data_low
            else
                read_vport_index_value = (data_low - H8000_0000) and vport_index_mask
            end If
        else
            read_vport_index_value = data_low and vport_index_mask
        end If
        read_prio_value = rightShift(data_low, 27) and &H7
        read_drop_value = rightShift(data_low, 30) and &H1
        read_control_pkt_value = rightShift(data_low, 31) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_vport_index_value = &H0
        flag_vport_index        = &H0
        write_prio_value = &H0
        flag_prio        = &H0
        write_drop_value = &H0
        flag_drop        = &H0
        write_control_pkt_value = &H0
        flag_control_pkt        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_TCAM_POLICY_tcam_policy_30
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' vport_index                                [3:0]            get_vport_index
''                                                             set_vport_index
''                                                             read_vport_index
''                                                             write_vport_index
''---------------------------------------------------------------------------------
'' prio                                       [29:27]          get_prio
''                                                             set_prio
''                                                             read_prio
''                                                             write_prio
''---------------------------------------------------------------------------------
'' drop                                       [30:30]          get_drop
''                                                             set_drop
''                                                             read_drop
''                                                             write_drop
''---------------------------------------------------------------------------------
'' control_pkt                                [31:31]          get_control_pkt
''                                                             set_control_pkt
''                                                             read_control_pkt
''                                                             write_control_pkt
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_TCAM_POLICY_tcam_policy_30
    Private write_vport_index_value
    Private read_vport_index_value
    Private flag_vport_index
    Private write_prio_value
    Private read_prio_value
    Private flag_prio
    Private write_drop_value
    Private read_drop_value
    Private flag_drop
    Private write_control_pkt_value
    Private read_control_pkt_value
    Private flag_control_pkt

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3078
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_vport_index
        get_vport_index = read_vport_index_value
    End Property

    Property Let set_vport_index(aData)
        write_vport_index_value = aData
        flag_vport_index        = &H1
    End Property

    Property Get read_vport_index
        read
        read_vport_index = read_vport_index_value
    End Property

    Property Let write_vport_index(aData)
        set_vport_index = aData
        write
    End Property

    Property Get get_prio
        get_prio = read_prio_value
    End Property

    Property Let set_prio(aData)
        write_prio_value = aData
        flag_prio        = &H1
    End Property

    Property Get read_prio
        read
        read_prio = read_prio_value
    End Property

    Property Let write_prio(aData)
        set_prio = aData
        write
    End Property

    Property Get get_drop
        get_drop = read_drop_value
    End Property

    Property Let set_drop(aData)
        write_drop_value = aData
        flag_drop        = &H1
    End Property

    Property Get read_drop
        read
        read_drop = read_drop_value
    End Property

    Property Let write_drop(aData)
        set_drop = aData
        write
    End Property

    Property Get get_control_pkt
        get_control_pkt = read_control_pkt_value
    End Property

    Property Let set_control_pkt(aData)
        write_control_pkt_value = aData
        flag_control_pkt        = &H1
    End Property

    Property Get read_control_pkt
        read
        read_control_pkt = read_control_pkt_value
    End Property

    Property Let write_control_pkt(aData)
        set_control_pkt = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        vport_index_mask = &Hf
        if data_low > LONG_MAX then
            if vport_index_mask = mask then
                read_vport_index_value = data_low
            else
                read_vport_index_value = (data_low - H8000_0000) and vport_index_mask
            end If
        else
            read_vport_index_value = data_low and vport_index_mask
        end If
        read_prio_value = rightShift(data_low, 27) and &H7
        read_drop_value = rightShift(data_low, 30) and &H1
        read_control_pkt_value = rightShift(data_low, 31) and &H1

    End Sub

    Sub write
        If flag_vport_index = &H0 or flag_prio = &H0 or flag_drop = &H0 or flag_control_pkt = &H0 Then read
        If flag_vport_index = &H0 Then write_vport_index_value = get_vport_index
        If flag_prio = &H0 Then write_prio_value = get_prio
        If flag_drop = &H0 Then write_drop_value = get_drop
        If flag_control_pkt = &H0 Then write_control_pkt_value = get_control_pkt

        regValue = leftShift((write_vport_index_value and &Hf), 0) + leftShift((write_prio_value and &H7), 27) + leftShift((write_drop_value and &H1), 30) + leftShift((write_control_pkt_value and &H1), 31)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        vport_index_mask = &Hf
        if data_low > LONG_MAX then
            if vport_index_mask = mask then
                read_vport_index_value = data_low
            else
                read_vport_index_value = (data_low - H8000_0000) and vport_index_mask
            end If
        else
            read_vport_index_value = data_low and vport_index_mask
        end If
        read_prio_value = rightShift(data_low, 27) and &H7
        read_drop_value = rightShift(data_low, 30) and &H1
        read_control_pkt_value = rightShift(data_low, 31) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_vport_index_value = &H0
        flag_vport_index        = &H0
        write_prio_value = &H0
        flag_prio        = &H0
        write_drop_value = &H0
        flag_drop        = &H0
        write_control_pkt_value = &H0
        flag_control_pkt        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_TCAM_POLICY_tcam_policy_31
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' vport_index                                [3:0]            get_vport_index
''                                                             set_vport_index
''                                                             read_vport_index
''                                                             write_vport_index
''---------------------------------------------------------------------------------
'' prio                                       [29:27]          get_prio
''                                                             set_prio
''                                                             read_prio
''                                                             write_prio
''---------------------------------------------------------------------------------
'' drop                                       [30:30]          get_drop
''                                                             set_drop
''                                                             read_drop
''                                                             write_drop
''---------------------------------------------------------------------------------
'' control_pkt                                [31:31]          get_control_pkt
''                                                             set_control_pkt
''                                                             read_control_pkt
''                                                             write_control_pkt
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_TCAM_POLICY_tcam_policy_31
    Private write_vport_index_value
    Private read_vport_index_value
    Private flag_vport_index
    Private write_prio_value
    Private read_prio_value
    Private flag_prio
    Private write_drop_value
    Private read_drop_value
    Private flag_drop
    Private write_control_pkt_value
    Private read_control_pkt_value
    Private flag_control_pkt

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H307c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_vport_index
        get_vport_index = read_vport_index_value
    End Property

    Property Let set_vport_index(aData)
        write_vport_index_value = aData
        flag_vport_index        = &H1
    End Property

    Property Get read_vport_index
        read
        read_vport_index = read_vport_index_value
    End Property

    Property Let write_vport_index(aData)
        set_vport_index = aData
        write
    End Property

    Property Get get_prio
        get_prio = read_prio_value
    End Property

    Property Let set_prio(aData)
        write_prio_value = aData
        flag_prio        = &H1
    End Property

    Property Get read_prio
        read
        read_prio = read_prio_value
    End Property

    Property Let write_prio(aData)
        set_prio = aData
        write
    End Property

    Property Get get_drop
        get_drop = read_drop_value
    End Property

    Property Let set_drop(aData)
        write_drop_value = aData
        flag_drop        = &H1
    End Property

    Property Get read_drop
        read
        read_drop = read_drop_value
    End Property

    Property Let write_drop(aData)
        set_drop = aData
        write
    End Property

    Property Get get_control_pkt
        get_control_pkt = read_control_pkt_value
    End Property

    Property Let set_control_pkt(aData)
        write_control_pkt_value = aData
        flag_control_pkt        = &H1
    End Property

    Property Get read_control_pkt
        read
        read_control_pkt = read_control_pkt_value
    End Property

    Property Let write_control_pkt(aData)
        set_control_pkt = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        vport_index_mask = &Hf
        if data_low > LONG_MAX then
            if vport_index_mask = mask then
                read_vport_index_value = data_low
            else
                read_vport_index_value = (data_low - H8000_0000) and vport_index_mask
            end If
        else
            read_vport_index_value = data_low and vport_index_mask
        end If
        read_prio_value = rightShift(data_low, 27) and &H7
        read_drop_value = rightShift(data_low, 30) and &H1
        read_control_pkt_value = rightShift(data_low, 31) and &H1

    End Sub

    Sub write
        If flag_vport_index = &H0 or flag_prio = &H0 or flag_drop = &H0 or flag_control_pkt = &H0 Then read
        If flag_vport_index = &H0 Then write_vport_index_value = get_vport_index
        If flag_prio = &H0 Then write_prio_value = get_prio
        If flag_drop = &H0 Then write_drop_value = get_drop
        If flag_control_pkt = &H0 Then write_control_pkt_value = get_control_pkt

        regValue = leftShift((write_vport_index_value and &Hf), 0) + leftShift((write_prio_value and &H7), 27) + leftShift((write_drop_value and &H1), 30) + leftShift((write_control_pkt_value and &H1), 31)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        vport_index_mask = &Hf
        if data_low > LONG_MAX then
            if vport_index_mask = mask then
                read_vport_index_value = data_low
            else
                read_vport_index_value = (data_low - H8000_0000) and vport_index_mask
            end If
        else
            read_vport_index_value = data_low and vport_index_mask
        end If
        read_prio_value = rightShift(data_low, 27) and &H7
        read_drop_value = rightShift(data_low, 30) and &H1
        read_control_pkt_value = rightShift(data_low, 31) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_vport_index_value = &H0
        flag_vport_index        = &H0
        write_prio_value = &H0
        flag_prio        = &H0
        write_drop_value = &H0
        flag_drop        = &H0
        write_control_pkt_value = &H0
        flag_control_pkt        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class EIP165S_EIP_160S_I_32_BRCM_TCAM_POLICY_INSTANCE

    Public tcam_policy_0
    Public tcam_policy_1
    Public tcam_policy_2
    Public tcam_policy_3
    Public tcam_policy_4
    Public tcam_policy_5
    Public tcam_policy_6
    Public tcam_policy_7
    Public tcam_policy_8
    Public tcam_policy_9
    Public tcam_policy_10
    Public tcam_policy_11
    Public tcam_policy_12
    Public tcam_policy_13
    Public tcam_policy_14
    Public tcam_policy_15
    Public tcam_policy_16
    Public tcam_policy_17
    Public tcam_policy_18
    Public tcam_policy_19
    Public tcam_policy_20
    Public tcam_policy_21
    Public tcam_policy_22
    Public tcam_policy_23
    Public tcam_policy_24
    Public tcam_policy_25
    Public tcam_policy_26
    Public tcam_policy_27
    Public tcam_policy_28
    Public tcam_policy_29
    Public tcam_policy_30
    Public tcam_policy_31


    Public default function Init(aBaseAddr)
        Set tcam_policy_0 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_TCAM_POLICY_tcam_policy_0)(aBaseAddr, 32)
        Set tcam_policy_1 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_TCAM_POLICY_tcam_policy_1)(aBaseAddr, 32)
        Set tcam_policy_2 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_TCAM_POLICY_tcam_policy_2)(aBaseAddr, 32)
        Set tcam_policy_3 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_TCAM_POLICY_tcam_policy_3)(aBaseAddr, 32)
        Set tcam_policy_4 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_TCAM_POLICY_tcam_policy_4)(aBaseAddr, 32)
        Set tcam_policy_5 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_TCAM_POLICY_tcam_policy_5)(aBaseAddr, 32)
        Set tcam_policy_6 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_TCAM_POLICY_tcam_policy_6)(aBaseAddr, 32)
        Set tcam_policy_7 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_TCAM_POLICY_tcam_policy_7)(aBaseAddr, 32)
        Set tcam_policy_8 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_TCAM_POLICY_tcam_policy_8)(aBaseAddr, 32)
        Set tcam_policy_9 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_TCAM_POLICY_tcam_policy_9)(aBaseAddr, 32)
        Set tcam_policy_10 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_TCAM_POLICY_tcam_policy_10)(aBaseAddr, 32)
        Set tcam_policy_11 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_TCAM_POLICY_tcam_policy_11)(aBaseAddr, 32)
        Set tcam_policy_12 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_TCAM_POLICY_tcam_policy_12)(aBaseAddr, 32)
        Set tcam_policy_13 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_TCAM_POLICY_tcam_policy_13)(aBaseAddr, 32)
        Set tcam_policy_14 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_TCAM_POLICY_tcam_policy_14)(aBaseAddr, 32)
        Set tcam_policy_15 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_TCAM_POLICY_tcam_policy_15)(aBaseAddr, 32)
        Set tcam_policy_16 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_TCAM_POLICY_tcam_policy_16)(aBaseAddr, 32)
        Set tcam_policy_17 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_TCAM_POLICY_tcam_policy_17)(aBaseAddr, 32)
        Set tcam_policy_18 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_TCAM_POLICY_tcam_policy_18)(aBaseAddr, 32)
        Set tcam_policy_19 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_TCAM_POLICY_tcam_policy_19)(aBaseAddr, 32)
        Set tcam_policy_20 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_TCAM_POLICY_tcam_policy_20)(aBaseAddr, 32)
        Set tcam_policy_21 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_TCAM_POLICY_tcam_policy_21)(aBaseAddr, 32)
        Set tcam_policy_22 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_TCAM_POLICY_tcam_policy_22)(aBaseAddr, 32)
        Set tcam_policy_23 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_TCAM_POLICY_tcam_policy_23)(aBaseAddr, 32)
        Set tcam_policy_24 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_TCAM_POLICY_tcam_policy_24)(aBaseAddr, 32)
        Set tcam_policy_25 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_TCAM_POLICY_tcam_policy_25)(aBaseAddr, 32)
        Set tcam_policy_26 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_TCAM_POLICY_tcam_policy_26)(aBaseAddr, 32)
        Set tcam_policy_27 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_TCAM_POLICY_tcam_policy_27)(aBaseAddr, 32)
        Set tcam_policy_28 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_TCAM_POLICY_tcam_policy_28)(aBaseAddr, 32)
        Set tcam_policy_29 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_TCAM_POLICY_tcam_policy_29)(aBaseAddr, 32)
        Set tcam_policy_30 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_TCAM_POLICY_tcam_policy_30)(aBaseAddr, 32)
        Set tcam_policy_31 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_TCAM_POLICY_tcam_policy_31)(aBaseAddr, 32)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set EIP165S_EIP_160S_I_32_BRCM_TCAM_POLICY = CreateObject("System.Collections.ArrayList")
EIP165S_EIP_160S_I_32_BRCM_TCAM_POLICY.Add ((New EIP165S_EIP_160S_I_32_BRCM_TCAM_POLICY_INSTANCE)(&H4d010000))
EIP165S_EIP_160S_I_32_BRCM_TCAM_POLICY.Add ((New EIP165S_EIP_160S_I_32_BRCM_TCAM_POLICY_INSTANCE)(&H4d110000))
EIP165S_EIP_160S_I_32_BRCM_TCAM_POLICY.Add ((New EIP165S_EIP_160S_I_32_BRCM_TCAM_POLICY_INSTANCE)(&H4d210000))
EIP165S_EIP_160S_I_32_BRCM_TCAM_POLICY.Add ((New EIP165S_EIP_160S_I_32_BRCM_TCAM_POLICY_INSTANCE)(&H4d310000))
EIP165S_EIP_160S_I_32_BRCM_TCAM_POLICY.Add ((New EIP165S_EIP_160S_I_32_BRCM_TCAM_POLICY_INSTANCE)(&H4d410000))
EIP165S_EIP_160S_I_32_BRCM_TCAM_POLICY.Add ((New EIP165S_EIP_160S_I_32_BRCM_TCAM_POLICY_INSTANCE)(&H4d510000))


