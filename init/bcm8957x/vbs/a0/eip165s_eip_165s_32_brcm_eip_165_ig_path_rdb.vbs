

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


'' @REGISTER : EIP165S_EIP_165S_32_BRCM_EIP_165_IG_PATH_ig_status
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TX_LP_IDLE                                 [16:16]          get_TX_LP_IDLE
''                                                             set_TX_LP_IDLE
''                                                             read_TX_LP_IDLE
''                                                             write_TX_LP_IDLE
''---------------------------------------------------------------------------------
'' TX_CRC_ERR                                 [17:17]          get_TX_CRC_ERR
''                                                             set_TX_CRC_ERR
''                                                             read_TX_CRC_ERR
''                                                             write_TX_CRC_ERR
''---------------------------------------------------------------------------------
'' TX_PKT_ERR                                 [18:18]          get_TX_PKT_ERR
''                                                             set_TX_PKT_ERR
''                                                             read_TX_PKT_ERR
''                                                             write_TX_PKT_ERR
''---------------------------------------------------------------------------------
'' RX_LP_IDLE                                 [24:24]          get_RX_LP_IDLE
''                                                             set_RX_LP_IDLE
''                                                             read_RX_LP_IDLE
''                                                             write_RX_LP_IDLE
''---------------------------------------------------------------------------------
'' RX_CRC_ERR                                 [25:25]          get_RX_CRC_ERR
''                                                             set_RX_CRC_ERR
''                                                             read_RX_CRC_ERR
''                                                             write_RX_CRC_ERR
''---------------------------------------------------------------------------------
'' RX_PKT_ERR                                 [26:26]          get_RX_PKT_ERR
''                                                             set_RX_PKT_ERR
''                                                             read_RX_PKT_ERR
''                                                             write_RX_PKT_ERR
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_165S_32_BRCM_EIP_165_IG_PATH_ig_status
    Private write_TX_LP_IDLE_value
    Private read_TX_LP_IDLE_value
    Private flag_TX_LP_IDLE
    Private write_TX_CRC_ERR_value
    Private read_TX_CRC_ERR_value
    Private flag_TX_CRC_ERR
    Private write_TX_PKT_ERR_value
    Private read_TX_PKT_ERR_value
    Private flag_TX_PKT_ERR
    Private write_RX_LP_IDLE_value
    Private read_RX_LP_IDLE_value
    Private flag_RX_LP_IDLE
    Private write_RX_CRC_ERR_value
    Private read_RX_CRC_ERR_value
    Private flag_RX_CRC_ERR
    Private write_RX_PKT_ERR_value
    Private read_RX_PKT_ERR_value
    Private flag_RX_PKT_ERR

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H20fe0
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_TX_LP_IDLE
        get_TX_LP_IDLE = read_TX_LP_IDLE_value
    End Property

    Property Let set_TX_LP_IDLE(aData)
        write_TX_LP_IDLE_value = aData
        flag_TX_LP_IDLE        = &H1
    End Property

    Property Get read_TX_LP_IDLE
        read
        read_TX_LP_IDLE = read_TX_LP_IDLE_value
    End Property

    Property Let write_TX_LP_IDLE(aData)
        set_TX_LP_IDLE = aData
        write
    End Property

    Property Get get_TX_CRC_ERR
        get_TX_CRC_ERR = read_TX_CRC_ERR_value
    End Property

    Property Let set_TX_CRC_ERR(aData)
        write_TX_CRC_ERR_value = aData
        flag_TX_CRC_ERR        = &H1
    End Property

    Property Get read_TX_CRC_ERR
        read
        read_TX_CRC_ERR = read_TX_CRC_ERR_value
    End Property

    Property Let write_TX_CRC_ERR(aData)
        set_TX_CRC_ERR = aData
        write
    End Property

    Property Get get_TX_PKT_ERR
        get_TX_PKT_ERR = read_TX_PKT_ERR_value
    End Property

    Property Let set_TX_PKT_ERR(aData)
        write_TX_PKT_ERR_value = aData
        flag_TX_PKT_ERR        = &H1
    End Property

    Property Get read_TX_PKT_ERR
        read
        read_TX_PKT_ERR = read_TX_PKT_ERR_value
    End Property

    Property Let write_TX_PKT_ERR(aData)
        set_TX_PKT_ERR = aData
        write
    End Property

    Property Get get_RX_LP_IDLE
        get_RX_LP_IDLE = read_RX_LP_IDLE_value
    End Property

    Property Let set_RX_LP_IDLE(aData)
        write_RX_LP_IDLE_value = aData
        flag_RX_LP_IDLE        = &H1
    End Property

    Property Get read_RX_LP_IDLE
        read
        read_RX_LP_IDLE = read_RX_LP_IDLE_value
    End Property

    Property Let write_RX_LP_IDLE(aData)
        set_RX_LP_IDLE = aData
        write
    End Property

    Property Get get_RX_CRC_ERR
        get_RX_CRC_ERR = read_RX_CRC_ERR_value
    End Property

    Property Let set_RX_CRC_ERR(aData)
        write_RX_CRC_ERR_value = aData
        flag_RX_CRC_ERR        = &H1
    End Property

    Property Get read_RX_CRC_ERR
        read
        read_RX_CRC_ERR = read_RX_CRC_ERR_value
    End Property

    Property Let write_RX_CRC_ERR(aData)
        set_RX_CRC_ERR = aData
        write
    End Property

    Property Get get_RX_PKT_ERR
        get_RX_PKT_ERR = read_RX_PKT_ERR_value
    End Property

    Property Let set_RX_PKT_ERR(aData)
        write_RX_PKT_ERR_value = aData
        flag_RX_PKT_ERR        = &H1
    End Property

    Property Get read_RX_PKT_ERR
        read
        read_RX_PKT_ERR = read_RX_PKT_ERR_value
    End Property

    Property Let write_RX_PKT_ERR(aData)
        set_RX_PKT_ERR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TX_LP_IDLE_value = rightShift(data_low, 16) and &H1
        read_TX_CRC_ERR_value = rightShift(data_low, 17) and &H1
        read_TX_PKT_ERR_value = rightShift(data_low, 18) and &H1
        read_RX_LP_IDLE_value = rightShift(data_low, 24) and &H1
        read_RX_CRC_ERR_value = rightShift(data_low, 25) and &H1
        read_RX_PKT_ERR_value = rightShift(data_low, 26) and &H1

    End Sub

    Sub write
        If flag_TX_LP_IDLE = &H0 or flag_TX_CRC_ERR = &H0 or flag_TX_PKT_ERR = &H0 or flag_RX_LP_IDLE = &H0 or flag_RX_CRC_ERR = &H0 or flag_RX_PKT_ERR = &H0 Then read
        If flag_TX_LP_IDLE = &H0 Then write_TX_LP_IDLE_value = get_TX_LP_IDLE
        If flag_TX_CRC_ERR = &H0 Then write_TX_CRC_ERR_value = get_TX_CRC_ERR
        If flag_TX_PKT_ERR = &H0 Then write_TX_PKT_ERR_value = get_TX_PKT_ERR
        If flag_RX_LP_IDLE = &H0 Then write_RX_LP_IDLE_value = get_RX_LP_IDLE
        If flag_RX_CRC_ERR = &H0 Then write_RX_CRC_ERR_value = get_RX_CRC_ERR
        If flag_RX_PKT_ERR = &H0 Then write_RX_PKT_ERR_value = get_RX_PKT_ERR

        regValue = leftShift((write_TX_LP_IDLE_value and &H1), 16) + leftShift((write_TX_CRC_ERR_value and &H1), 17) + leftShift((write_TX_PKT_ERR_value and &H1), 18) + leftShift((write_RX_LP_IDLE_value and &H1), 24) + leftShift((write_RX_CRC_ERR_value and &H1), 25) + leftShift((write_RX_PKT_ERR_value and &H1), 26)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TX_LP_IDLE_value = rightShift(data_low, 16) and &H1
        read_TX_CRC_ERR_value = rightShift(data_low, 17) and &H1
        read_TX_PKT_ERR_value = rightShift(data_low, 18) and &H1
        read_RX_LP_IDLE_value = rightShift(data_low, 24) and &H1
        read_RX_CRC_ERR_value = rightShift(data_low, 25) and &H1
        read_RX_PKT_ERR_value = rightShift(data_low, 26) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TX_LP_IDLE_value = &H0
        flag_TX_LP_IDLE        = &H0
        write_TX_CRC_ERR_value = &H0
        flag_TX_CRC_ERR        = &H0
        write_TX_PKT_ERR_value = &H0
        flag_TX_PKT_ERR        = &H0
        write_RX_LP_IDLE_value = &H0
        flag_RX_LP_IDLE        = &H0
        write_RX_CRC_ERR_value = &H0
        flag_RX_CRC_ERR        = &H0
        write_RX_PKT_ERR_value = &H0
        flag_RX_PKT_ERR        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_165S_32_BRCM_EIP_165_IG_PATH_ig_ctrl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' IRTO                                       [15:0]           get_IRTO
''                                                             set_IRTO
''                                                             read_IRTO
''                                                             write_IRTO
''---------------------------------------------------------------------------------
'' CLASS_DROP                                 [17:16]          get_CLASS_DROP
''                                                             set_CLASS_DROP
''                                                             read_CLASS_DROP
''                                                             write_CLASS_DROP
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_165S_32_BRCM_EIP_165_IG_PATH_ig_ctrl
    Private write_IRTO_value
    Private read_IRTO_value
    Private flag_IRTO
    Private write_CLASS_DROP_value
    Private read_CLASS_DROP_value
    Private flag_CLASS_DROP

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H20fe4
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_IRTO
        get_IRTO = read_IRTO_value
    End Property

    Property Let set_IRTO(aData)
        write_IRTO_value = aData
        flag_IRTO        = &H1
    End Property

    Property Get read_IRTO
        read
        read_IRTO = read_IRTO_value
    End Property

    Property Let write_IRTO(aData)
        set_IRTO = aData
        write
    End Property

    Property Get get_CLASS_DROP
        get_CLASS_DROP = read_CLASS_DROP_value
    End Property

    Property Let set_CLASS_DROP(aData)
        write_CLASS_DROP_value = aData
        flag_CLASS_DROP        = &H1
    End Property

    Property Get read_CLASS_DROP
        read
        read_CLASS_DROP = read_CLASS_DROP_value
    End Property

    Property Let write_CLASS_DROP(aData)
        set_CLASS_DROP = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        IRTO_mask = &Hffff
        if data_low > LONG_MAX then
            if IRTO_mask = mask then
                read_IRTO_value = data_low
            else
                read_IRTO_value = (data_low - H8000_0000) and IRTO_mask
            end If
        else
            read_IRTO_value = data_low and IRTO_mask
        end If
        read_CLASS_DROP_value = rightShift(data_low, 16) and &H3

    End Sub

    Sub write
        If flag_IRTO = &H0 or flag_CLASS_DROP = &H0 Then read
        If flag_IRTO = &H0 Then write_IRTO_value = get_IRTO
        If flag_CLASS_DROP = &H0 Then write_CLASS_DROP_value = get_CLASS_DROP

        regValue = leftShift((write_IRTO_value and &Hffff), 0) + leftShift((write_CLASS_DROP_value and &H3), 16)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        IRTO_mask = &Hffff
        if data_low > LONG_MAX then
            if IRTO_mask = mask then
                read_IRTO_value = data_low
            else
                read_IRTO_value = (data_low - H8000_0000) and IRTO_mask
            end If
        else
            read_IRTO_value = data_low and IRTO_mask
        end If
        read_CLASS_DROP_value = rightShift(data_low, 16) and &H3

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_IRTO_value = &H0
        flag_IRTO        = &H0
        write_CLASS_DROP_value = &H0
        flag_CLASS_DROP        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class EIP165S_EIP_165S_32_BRCM_EIP_165_IG_PATH_INSTANCE

    Public ig_status
    Public ig_ctrl


    Public default function Init(aBaseAddr)
        Set ig_status = (New REGISTER_EIP165S_EIP_165S_32_BRCM_EIP_165_IG_PATH_ig_status)(aBaseAddr, 32)
        Set ig_ctrl = (New REGISTER_EIP165S_EIP_165S_32_BRCM_EIP_165_IG_PATH_ig_ctrl)(aBaseAddr, 32)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set EIP165S_EIP_165S_32_BRCM_EIP_165_IG_PATH = CreateObject("System.Collections.ArrayList")
EIP165S_EIP_165S_32_BRCM_EIP_165_IG_PATH.Add ((New EIP165S_EIP_165S_32_BRCM_EIP_165_IG_PATH_INSTANCE)(&H4d010000))
EIP165S_EIP_165S_32_BRCM_EIP_165_IG_PATH.Add ((New EIP165S_EIP_165S_32_BRCM_EIP_165_IG_PATH_INSTANCE)(&H4d110000))
EIP165S_EIP_165S_32_BRCM_EIP_165_IG_PATH.Add ((New EIP165S_EIP_165S_32_BRCM_EIP_165_IG_PATH_INSTANCE)(&H4d210000))
EIP165S_EIP_165S_32_BRCM_EIP_165_IG_PATH.Add ((New EIP165S_EIP_165S_32_BRCM_EIP_165_IG_PATH_INSTANCE)(&H4d310000))
EIP165S_EIP_165S_32_BRCM_EIP_165_IG_PATH.Add ((New EIP165S_EIP_165S_32_BRCM_EIP_165_IG_PATH_INSTANCE)(&H4d410000))
EIP165S_EIP_165S_32_BRCM_EIP_165_IG_PATH.Add ((New EIP165S_EIP_165S_32_BRCM_EIP_165_IG_PATH_INSTANCE)(&H4d510000))


