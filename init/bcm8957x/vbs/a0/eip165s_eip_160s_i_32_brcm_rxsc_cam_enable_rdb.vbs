

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


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_ENABLE_rxsc_entry_enable1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' enable_15_31                               [15:0]           get_enable_15_31
''                                                             set_enable_15_31
''                                                             read_enable_15_31
''                                                             write_enable_15_31
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_ENABLE_rxsc_entry_enable1
    Private write_enable_15_31_value
    Private read_enable_15_31_value
    Private flag_enable_15_31

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3600
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_enable_15_31
        get_enable_15_31 = read_enable_15_31_value
    End Property

    Property Let set_enable_15_31(aData)
        write_enable_15_31_value = aData
        flag_enable_15_31        = &H1
    End Property

    Property Get read_enable_15_31
        read
        read_enable_15_31 = read_enable_15_31_value
    End Property

    Property Let write_enable_15_31(aData)
        set_enable_15_31 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        enable_15_31_mask = &Hffff
        if data_low > LONG_MAX then
            if enable_15_31_mask = mask then
                read_enable_15_31_value = data_low
            else
                read_enable_15_31_value = (data_low - H8000_0000) and enable_15_31_mask
            end If
        else
            read_enable_15_31_value = data_low and enable_15_31_mask
        end If

    End Sub

    Sub write
        If flag_enable_15_31 = &H0 Then read
        If flag_enable_15_31 = &H0 Then write_enable_15_31_value = get_enable_15_31

        regValue = leftShift((write_enable_15_31_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        enable_15_31_mask = &Hffff
        if data_low > LONG_MAX then
            if enable_15_31_mask = mask then
                read_enable_15_31_value = data_low
            else
                read_enable_15_31_value = (data_low - H8000_0000) and enable_15_31_mask
            end If
        else
            read_enable_15_31_value = data_low and enable_15_31_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_enable_15_31_value = &H0
        flag_enable_15_31        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_ENABLE_rxsc_cam_enable_ctrl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' sc_index_set                               [3:0]            get_sc_index_set
''                                                             set_sc_index_set
''                                                             read_sc_index_set
''                                                             write_sc_index_set
''---------------------------------------------------------------------------------
'' set_enable                                 [14:14]          get_set_enable
''                                                             set_set_enable
''                                                             read_set_enable
''                                                             write_set_enable
''---------------------------------------------------------------------------------
'' set_all                                    [15:15]          get_set_all
''                                                             set_set_all
''                                                             read_set_all
''                                                             write_set_all
''---------------------------------------------------------------------------------
'' sc_index_clear                             [19:16]          get_sc_index_clear
''                                                             set_sc_index_clear
''                                                             read_sc_index_clear
''                                                             write_sc_index_clear
''---------------------------------------------------------------------------------
'' clear_enable                               [30:30]          get_clear_enable
''                                                             set_clear_enable
''                                                             read_clear_enable
''                                                             write_clear_enable
''---------------------------------------------------------------------------------
'' clear_all                                  [31:31]          get_clear_all
''                                                             set_clear_all
''                                                             read_clear_all
''                                                             write_clear_all
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_ENABLE_rxsc_cam_enable_ctrl
    Private write_sc_index_set_value
    Private read_sc_index_set_value
    Private flag_sc_index_set
    Private write_set_enable_value
    Private read_set_enable_value
    Private flag_set_enable
    Private write_set_all_value
    Private read_set_all_value
    Private flag_set_all
    Private write_sc_index_clear_value
    Private read_sc_index_clear_value
    Private flag_sc_index_clear
    Private write_clear_enable_value
    Private read_clear_enable_value
    Private flag_clear_enable
    Private write_clear_all_value
    Private read_clear_all_value
    Private flag_clear_all

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3700
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_sc_index_set
        get_sc_index_set = read_sc_index_set_value
    End Property

    Property Let set_sc_index_set(aData)
        write_sc_index_set_value = aData
        flag_sc_index_set        = &H1
    End Property

    Property Get read_sc_index_set
        read
        read_sc_index_set = read_sc_index_set_value
    End Property

    Property Let write_sc_index_set(aData)
        set_sc_index_set = aData
        write
    End Property

    Property Get get_set_enable
        get_set_enable = read_set_enable_value
    End Property

    Property Let set_set_enable(aData)
        write_set_enable_value = aData
        flag_set_enable        = &H1
    End Property

    Property Get read_set_enable
        read
        read_set_enable = read_set_enable_value
    End Property

    Property Let write_set_enable(aData)
        set_set_enable = aData
        write
    End Property

    Property Get get_set_all
        get_set_all = read_set_all_value
    End Property

    Property Let set_set_all(aData)
        write_set_all_value = aData
        flag_set_all        = &H1
    End Property

    Property Get read_set_all
        read
        read_set_all = read_set_all_value
    End Property

    Property Let write_set_all(aData)
        set_set_all = aData
        write
    End Property

    Property Get get_sc_index_clear
        get_sc_index_clear = read_sc_index_clear_value
    End Property

    Property Let set_sc_index_clear(aData)
        write_sc_index_clear_value = aData
        flag_sc_index_clear        = &H1
    End Property

    Property Get read_sc_index_clear
        read
        read_sc_index_clear = read_sc_index_clear_value
    End Property

    Property Let write_sc_index_clear(aData)
        set_sc_index_clear = aData
        write
    End Property

    Property Get get_clear_enable
        get_clear_enable = read_clear_enable_value
    End Property

    Property Let set_clear_enable(aData)
        write_clear_enable_value = aData
        flag_clear_enable        = &H1
    End Property

    Property Get read_clear_enable
        read
        read_clear_enable = read_clear_enable_value
    End Property

    Property Let write_clear_enable(aData)
        set_clear_enable = aData
        write
    End Property

    Property Get get_clear_all
        get_clear_all = read_clear_all_value
    End Property

    Property Let set_clear_all(aData)
        write_clear_all_value = aData
        flag_clear_all        = &H1
    End Property

    Property Get read_clear_all
        read
        read_clear_all = read_clear_all_value
    End Property

    Property Let write_clear_all(aData)
        set_clear_all = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        sc_index_set_mask = &Hf
        if data_low > LONG_MAX then
            if sc_index_set_mask = mask then
                read_sc_index_set_value = data_low
            else
                read_sc_index_set_value = (data_low - H8000_0000) and sc_index_set_mask
            end If
        else
            read_sc_index_set_value = data_low and sc_index_set_mask
        end If
        read_set_enable_value = rightShift(data_low, 14) and &H1
        read_set_all_value = rightShift(data_low, 15) and &H1
        read_sc_index_clear_value = rightShift(data_low, 16) and &Hf
        read_clear_enable_value = rightShift(data_low, 30) and &H1
        read_clear_all_value = rightShift(data_low, 31) and &H1

    End Sub

    Sub write
        If flag_sc_index_set = &H0 or flag_set_enable = &H0 or flag_set_all = &H0 or flag_sc_index_clear = &H0 or flag_clear_enable = &H0 or flag_clear_all = &H0 Then read
        If flag_sc_index_set = &H0 Then write_sc_index_set_value = get_sc_index_set
        If flag_set_enable = &H0 Then write_set_enable_value = get_set_enable
        If flag_set_all = &H0 Then write_set_all_value = get_set_all
        If flag_sc_index_clear = &H0 Then write_sc_index_clear_value = get_sc_index_clear
        If flag_clear_enable = &H0 Then write_clear_enable_value = get_clear_enable
        If flag_clear_all = &H0 Then write_clear_all_value = get_clear_all

        regValue = leftShift((write_sc_index_set_value and &Hf), 0) + leftShift((write_set_enable_value and &H1), 14) + leftShift((write_set_all_value and &H1), 15) + leftShift((write_sc_index_clear_value and &Hf), 16) + leftShift((write_clear_enable_value and &H1), 30) + leftShift((write_clear_all_value and &H1), 31)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        sc_index_set_mask = &Hf
        if data_low > LONG_MAX then
            if sc_index_set_mask = mask then
                read_sc_index_set_value = data_low
            else
                read_sc_index_set_value = (data_low - H8000_0000) and sc_index_set_mask
            end If
        else
            read_sc_index_set_value = data_low and sc_index_set_mask
        end If
        read_set_enable_value = rightShift(data_low, 14) and &H1
        read_set_all_value = rightShift(data_low, 15) and &H1
        read_sc_index_clear_value = rightShift(data_low, 16) and &Hf
        read_clear_enable_value = rightShift(data_low, 30) and &H1
        read_clear_all_value = rightShift(data_low, 31) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_sc_index_set_value = &H0
        flag_sc_index_set        = &H0
        write_set_enable_value = &H0
        flag_set_enable        = &H0
        write_set_all_value = &H0
        flag_set_all        = &H0
        write_sc_index_clear_value = &H0
        flag_sc_index_clear        = &H0
        write_clear_enable_value = &H0
        flag_clear_enable        = &H0
        write_clear_all_value = &H0
        flag_clear_all        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_ENABLE_INSTANCE

    Public rxsc_entry_enable1
    Public rxsc_cam_enable_ctrl


    Public default function Init(aBaseAddr)
        Set rxsc_entry_enable1 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_ENABLE_rxsc_entry_enable1)(aBaseAddr, 32)
        Set rxsc_cam_enable_ctrl = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_ENABLE_rxsc_cam_enable_ctrl)(aBaseAddr, 32)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_ENABLE = CreateObject("System.Collections.ArrayList")
EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_ENABLE.Add ((New EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_ENABLE_INSTANCE)(&H4d010000))
EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_ENABLE.Add ((New EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_ENABLE_INSTANCE)(&H4d110000))
EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_ENABLE.Add ((New EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_ENABLE_INSTANCE)(&H4d210000))
EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_ENABLE.Add ((New EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_ENABLE_INSTANCE)(&H4d310000))
EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_ENABLE.Add ((New EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_ENABLE_INSTANCE)(&H4d410000))
EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_ENABLE.Add ((New EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_ENABLE_INSTANCE)(&H4d510000))


