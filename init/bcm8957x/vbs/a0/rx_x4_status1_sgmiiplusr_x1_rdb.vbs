

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


'' @REGISTER : RX_X4_STATUS1_SGMIIPLUSR_X1_pcs_latched_status_1_sgmiiplusr_x1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LOCAL_FAULT_LH                             [15:15]          get_LOCAL_FAULT_LH
''                                                             set_LOCAL_FAULT_LH
''                                                             read_LOCAL_FAULT_LH
''                                                             write_LOCAL_FAULT_LH
''---------------------------------------------------------------------------------
'' REMOTE_FAULT_LH                            [14:14]          get_REMOTE_FAULT_LH
''                                                             set_REMOTE_FAULT_LH
''                                                             read_REMOTE_FAULT_LH
''                                                             write_REMOTE_FAULT_LH
''---------------------------------------------------------------------------------
'' LINK_INTERRUPT_LH                          [13:13]          get_LINK_INTERRUPT_LH
''                                                             set_LINK_INTERRUPT_LH
''                                                             read_LINK_INTERRUPT_LH
''                                                             write_LINK_INTERRUPT_LH
''---------------------------------------------------------------------------------
'' LPI_RECEIVED_LH                            [3:3]            get_LPI_RECEIVED_LH
''                                                             set_LPI_RECEIVED_LH
''                                                             read_LPI_RECEIVED_LH
''                                                             write_LPI_RECEIVED_LH
''---------------------------------------------------------------------------------
Class REGISTER_RX_X4_STATUS1_SGMIIPLUSR_X1_pcs_latched_status_1_sgmiiplusr_x1
    Private write_LOCAL_FAULT_LH_value
    Private read_LOCAL_FAULT_LH_value
    Private flag_LOCAL_FAULT_LH
    Private write_REMOTE_FAULT_LH_value
    Private read_REMOTE_FAULT_LH_value
    Private flag_REMOTE_FAULT_LH
    Private write_LINK_INTERRUPT_LH_value
    Private read_LINK_INTERRUPT_LH_value
    Private flag_LINK_INTERRUPT_LH
    Private write_LPI_RECEIVED_LH_value
    Private read_LPI_RECEIVED_LH_value
    Private flag_LPI_RECEIVED_LH

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H4
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_LOCAL_FAULT_LH
        get_LOCAL_FAULT_LH = read_LOCAL_FAULT_LH_value
    End Property

    Property Let set_LOCAL_FAULT_LH(aData)
        write_LOCAL_FAULT_LH_value = aData
        flag_LOCAL_FAULT_LH        = &H1
    End Property

    Property Get read_LOCAL_FAULT_LH
        read
        read_LOCAL_FAULT_LH = read_LOCAL_FAULT_LH_value
    End Property

    Property Let write_LOCAL_FAULT_LH(aData)
        set_LOCAL_FAULT_LH = aData
        write
    End Property

    Property Get get_REMOTE_FAULT_LH
        get_REMOTE_FAULT_LH = read_REMOTE_FAULT_LH_value
    End Property

    Property Let set_REMOTE_FAULT_LH(aData)
        write_REMOTE_FAULT_LH_value = aData
        flag_REMOTE_FAULT_LH        = &H1
    End Property

    Property Get read_REMOTE_FAULT_LH
        read
        read_REMOTE_FAULT_LH = read_REMOTE_FAULT_LH_value
    End Property

    Property Let write_REMOTE_FAULT_LH(aData)
        set_REMOTE_FAULT_LH = aData
        write
    End Property

    Property Get get_LINK_INTERRUPT_LH
        get_LINK_INTERRUPT_LH = read_LINK_INTERRUPT_LH_value
    End Property

    Property Let set_LINK_INTERRUPT_LH(aData)
        write_LINK_INTERRUPT_LH_value = aData
        flag_LINK_INTERRUPT_LH        = &H1
    End Property

    Property Get read_LINK_INTERRUPT_LH
        read
        read_LINK_INTERRUPT_LH = read_LINK_INTERRUPT_LH_value
    End Property

    Property Let write_LINK_INTERRUPT_LH(aData)
        set_LINK_INTERRUPT_LH = aData
        write
    End Property

    Property Get get_LPI_RECEIVED_LH
        get_LPI_RECEIVED_LH = read_LPI_RECEIVED_LH_value
    End Property

    Property Let set_LPI_RECEIVED_LH(aData)
        write_LPI_RECEIVED_LH_value = aData
        flag_LPI_RECEIVED_LH        = &H1
    End Property

    Property Get read_LPI_RECEIVED_LH
        read
        read_LPI_RECEIVED_LH = read_LPI_RECEIVED_LH_value
    End Property

    Property Let write_LPI_RECEIVED_LH(aData)
        set_LPI_RECEIVED_LH = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LOCAL_FAULT_LH_value = rightShift(data_low, 15) and &H1
        read_REMOTE_FAULT_LH_value = rightShift(data_low, 14) and &H1
        read_LINK_INTERRUPT_LH_value = rightShift(data_low, 13) and &H1
        read_LPI_RECEIVED_LH_value = rightShift(data_low, 3) and &H1

    End Sub

    Sub write
        If flag_LOCAL_FAULT_LH = &H0 or flag_REMOTE_FAULT_LH = &H0 or flag_LINK_INTERRUPT_LH = &H0 or flag_LPI_RECEIVED_LH = &H0 Then read
        If flag_LOCAL_FAULT_LH = &H0 Then write_LOCAL_FAULT_LH_value = get_LOCAL_FAULT_LH
        If flag_REMOTE_FAULT_LH = &H0 Then write_REMOTE_FAULT_LH_value = get_REMOTE_FAULT_LH
        If flag_LINK_INTERRUPT_LH = &H0 Then write_LINK_INTERRUPT_LH_value = get_LINK_INTERRUPT_LH
        If flag_LPI_RECEIVED_LH = &H0 Then write_LPI_RECEIVED_LH_value = get_LPI_RECEIVED_LH

        regValue = leftShift((write_LOCAL_FAULT_LH_value and &H1), 15) + leftShift((write_REMOTE_FAULT_LH_value and &H1), 14) + leftShift((write_LINK_INTERRUPT_LH_value and &H1), 13) + leftShift((write_LPI_RECEIVED_LH_value and &H1), 3)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LOCAL_FAULT_LH_value = rightShift(data_low, 15) and &H1
        read_REMOTE_FAULT_LH_value = rightShift(data_low, 14) and &H1
        read_LINK_INTERRUPT_LH_value = rightShift(data_low, 13) and &H1
        read_LPI_RECEIVED_LH_value = rightShift(data_low, 3) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LOCAL_FAULT_LH_value = &H0
        flag_LOCAL_FAULT_LH        = &H0
        write_REMOTE_FAULT_LH_value = &H0
        flag_REMOTE_FAULT_LH        = &H0
        write_LINK_INTERRUPT_LH_value = &H0
        flag_LINK_INTERRUPT_LH        = &H0
        write_LPI_RECEIVED_LH_value = &H0
        flag_LPI_RECEIVED_LH        = &H0
    End Sub
End Class


'' @REGISTER : RX_X4_STATUS1_SGMIIPLUSR_X1_pcs_latched_status_0_sgmiiplusr_x1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' HI_BER_LH                                  [11:11]          get_HI_BER_LH
''                                                             set_HI_BER_LH
''                                                             read_HI_BER_LH
''                                                             write_HI_BER_LH
''---------------------------------------------------------------------------------
'' HI_BER_LL                                  [10:10]          get_HI_BER_LL
''                                                             set_HI_BER_LL
''                                                             read_HI_BER_LL
''                                                             write_HI_BER_LL
''---------------------------------------------------------------------------------
'' LINK_STATUS_LH                             [9:9]            get_LINK_STATUS_LH
''                                                             set_LINK_STATUS_LH
''                                                             read_LINK_STATUS_LH
''                                                             write_LINK_STATUS_LH
''---------------------------------------------------------------------------------
'' LINK_STATUS_LL                             [8:8]            get_LINK_STATUS_LL
''                                                             set_LINK_STATUS_LL
''                                                             read_LINK_STATUS_LL
''                                                             write_LINK_STATUS_LL
''---------------------------------------------------------------------------------
'' SYNC_STATUS_LH                             [7:7]            get_SYNC_STATUS_LH
''                                                             set_SYNC_STATUS_LH
''                                                             read_SYNC_STATUS_LH
''                                                             write_SYNC_STATUS_LH
''---------------------------------------------------------------------------------
'' SYNC_STATUS_LL                             [6:6]            get_SYNC_STATUS_LL
''                                                             set_SYNC_STATUS_LL
''                                                             read_SYNC_STATUS_LL
''                                                             write_SYNC_STATUS_LL
''---------------------------------------------------------------------------------
Class REGISTER_RX_X4_STATUS1_SGMIIPLUSR_X1_pcs_latched_status_0_sgmiiplusr_x1
    Private write_HI_BER_LH_value
    Private read_HI_BER_LH_value
    Private flag_HI_BER_LH
    Private write_HI_BER_LL_value
    Private read_HI_BER_LL_value
    Private flag_HI_BER_LL
    Private write_LINK_STATUS_LH_value
    Private read_LINK_STATUS_LH_value
    Private flag_LINK_STATUS_LH
    Private write_LINK_STATUS_LL_value
    Private read_LINK_STATUS_LL_value
    Private flag_LINK_STATUS_LL
    Private write_SYNC_STATUS_LH_value
    Private read_SYNC_STATUS_LH_value
    Private flag_SYNC_STATUS_LH
    Private write_SYNC_STATUS_LL_value
    Private read_SYNC_STATUS_LL_value
    Private flag_SYNC_STATUS_LL

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H6
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_HI_BER_LH
        get_HI_BER_LH = read_HI_BER_LH_value
    End Property

    Property Let set_HI_BER_LH(aData)
        write_HI_BER_LH_value = aData
        flag_HI_BER_LH        = &H1
    End Property

    Property Get read_HI_BER_LH
        read
        read_HI_BER_LH = read_HI_BER_LH_value
    End Property

    Property Let write_HI_BER_LH(aData)
        set_HI_BER_LH = aData
        write
    End Property

    Property Get get_HI_BER_LL
        get_HI_BER_LL = read_HI_BER_LL_value
    End Property

    Property Let set_HI_BER_LL(aData)
        write_HI_BER_LL_value = aData
        flag_HI_BER_LL        = &H1
    End Property

    Property Get read_HI_BER_LL
        read
        read_HI_BER_LL = read_HI_BER_LL_value
    End Property

    Property Let write_HI_BER_LL(aData)
        set_HI_BER_LL = aData
        write
    End Property

    Property Get get_LINK_STATUS_LH
        get_LINK_STATUS_LH = read_LINK_STATUS_LH_value
    End Property

    Property Let set_LINK_STATUS_LH(aData)
        write_LINK_STATUS_LH_value = aData
        flag_LINK_STATUS_LH        = &H1
    End Property

    Property Get read_LINK_STATUS_LH
        read
        read_LINK_STATUS_LH = read_LINK_STATUS_LH_value
    End Property

    Property Let write_LINK_STATUS_LH(aData)
        set_LINK_STATUS_LH = aData
        write
    End Property

    Property Get get_LINK_STATUS_LL
        get_LINK_STATUS_LL = read_LINK_STATUS_LL_value
    End Property

    Property Let set_LINK_STATUS_LL(aData)
        write_LINK_STATUS_LL_value = aData
        flag_LINK_STATUS_LL        = &H1
    End Property

    Property Get read_LINK_STATUS_LL
        read
        read_LINK_STATUS_LL = read_LINK_STATUS_LL_value
    End Property

    Property Let write_LINK_STATUS_LL(aData)
        set_LINK_STATUS_LL = aData
        write
    End Property

    Property Get get_SYNC_STATUS_LH
        get_SYNC_STATUS_LH = read_SYNC_STATUS_LH_value
    End Property

    Property Let set_SYNC_STATUS_LH(aData)
        write_SYNC_STATUS_LH_value = aData
        flag_SYNC_STATUS_LH        = &H1
    End Property

    Property Get read_SYNC_STATUS_LH
        read
        read_SYNC_STATUS_LH = read_SYNC_STATUS_LH_value
    End Property

    Property Let write_SYNC_STATUS_LH(aData)
        set_SYNC_STATUS_LH = aData
        write
    End Property

    Property Get get_SYNC_STATUS_LL
        get_SYNC_STATUS_LL = read_SYNC_STATUS_LL_value
    End Property

    Property Let set_SYNC_STATUS_LL(aData)
        write_SYNC_STATUS_LL_value = aData
        flag_SYNC_STATUS_LL        = &H1
    End Property

    Property Get read_SYNC_STATUS_LL
        read
        read_SYNC_STATUS_LL = read_SYNC_STATUS_LL_value
    End Property

    Property Let write_SYNC_STATUS_LL(aData)
        set_SYNC_STATUS_LL = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_HI_BER_LH_value = rightShift(data_low, 11) and &H1
        read_HI_BER_LL_value = rightShift(data_low, 10) and &H1
        read_LINK_STATUS_LH_value = rightShift(data_low, 9) and &H1
        read_LINK_STATUS_LL_value = rightShift(data_low, 8) and &H1
        read_SYNC_STATUS_LH_value = rightShift(data_low, 7) and &H1
        read_SYNC_STATUS_LL_value = rightShift(data_low, 6) and &H1

    End Sub

    Sub write
        If flag_HI_BER_LH = &H0 or flag_HI_BER_LL = &H0 or flag_LINK_STATUS_LH = &H0 or flag_LINK_STATUS_LL = &H0 or flag_SYNC_STATUS_LH = &H0 or flag_SYNC_STATUS_LL = &H0 Then read
        If flag_HI_BER_LH = &H0 Then write_HI_BER_LH_value = get_HI_BER_LH
        If flag_HI_BER_LL = &H0 Then write_HI_BER_LL_value = get_HI_BER_LL
        If flag_LINK_STATUS_LH = &H0 Then write_LINK_STATUS_LH_value = get_LINK_STATUS_LH
        If flag_LINK_STATUS_LL = &H0 Then write_LINK_STATUS_LL_value = get_LINK_STATUS_LL
        If flag_SYNC_STATUS_LH = &H0 Then write_SYNC_STATUS_LH_value = get_SYNC_STATUS_LH
        If flag_SYNC_STATUS_LL = &H0 Then write_SYNC_STATUS_LL_value = get_SYNC_STATUS_LL

        regValue = leftShift((write_HI_BER_LH_value and &H1), 11) + leftShift((write_HI_BER_LL_value and &H1), 10) + leftShift((write_LINK_STATUS_LH_value and &H1), 9) + leftShift((write_LINK_STATUS_LL_value and &H1), 8) + leftShift((write_SYNC_STATUS_LH_value and &H1), 7) + leftShift((write_SYNC_STATUS_LL_value and &H1), 6)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_HI_BER_LH_value = rightShift(data_low, 11) and &H1
        read_HI_BER_LL_value = rightShift(data_low, 10) and &H1
        read_LINK_STATUS_LH_value = rightShift(data_low, 9) and &H1
        read_LINK_STATUS_LL_value = rightShift(data_low, 8) and &H1
        read_SYNC_STATUS_LH_value = rightShift(data_low, 7) and &H1
        read_SYNC_STATUS_LL_value = rightShift(data_low, 6) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_HI_BER_LH_value = &H0
        flag_HI_BER_LH        = &H0
        write_HI_BER_LL_value = &H0
        flag_HI_BER_LL        = &H0
        write_LINK_STATUS_LH_value = &H0
        flag_LINK_STATUS_LH        = &H0
        write_LINK_STATUS_LL_value = &H0
        flag_LINK_STATUS_LL        = &H0
        write_SYNC_STATUS_LH_value = &H0
        flag_SYNC_STATUS_LH        = &H0
        write_SYNC_STATUS_LL_value = &H0
        flag_SYNC_STATUS_LL        = &H0
    End Sub
End Class


'' @REGISTER : RX_X4_STATUS1_SGMIIPLUSR_X1_pcs_live_status_sgmiiplusr_x1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LOCAL_FAULT                                [8:8]            get_LOCAL_FAULT
''                                                             set_LOCAL_FAULT
''                                                             read_LOCAL_FAULT
''                                                             write_LOCAL_FAULT
''---------------------------------------------------------------------------------
'' REMOTE_FAULT                               [7:7]            get_REMOTE_FAULT
''                                                             set_REMOTE_FAULT
''                                                             read_REMOTE_FAULT
''                                                             write_REMOTE_FAULT
''---------------------------------------------------------------------------------
'' LINK_INTERRUPT                             [6:6]            get_LINK_INTERRUPT
''                                                             set_LINK_INTERRUPT
''                                                             read_LINK_INTERRUPT
''                                                             write_LINK_INTERRUPT
''---------------------------------------------------------------------------------
'' LPI_RECEIVED                               [5:5]            get_LPI_RECEIVED
''                                                             set_LPI_RECEIVED
''                                                             read_LPI_RECEIVED
''                                                             write_LPI_RECEIVED
''---------------------------------------------------------------------------------
'' HI_BER                                     [2:2]            get_HI_BER
''                                                             set_HI_BER
''                                                             read_HI_BER
''                                                             write_HI_BER
''---------------------------------------------------------------------------------
'' LINK_STATUS                                [1:1]            get_LINK_STATUS
''                                                             set_LINK_STATUS
''                                                             read_LINK_STATUS
''                                                             write_LINK_STATUS
''---------------------------------------------------------------------------------
'' SYNC_STATUS                                [0:0]            get_SYNC_STATUS
''                                                             set_SYNC_STATUS
''                                                             read_SYNC_STATUS
''                                                             write_SYNC_STATUS
''---------------------------------------------------------------------------------
Class REGISTER_RX_X4_STATUS1_SGMIIPLUSR_X1_pcs_live_status_sgmiiplusr_x1
    Private write_LOCAL_FAULT_value
    Private read_LOCAL_FAULT_value
    Private flag_LOCAL_FAULT
    Private write_REMOTE_FAULT_value
    Private read_REMOTE_FAULT_value
    Private flag_REMOTE_FAULT
    Private write_LINK_INTERRUPT_value
    Private read_LINK_INTERRUPT_value
    Private flag_LINK_INTERRUPT
    Private write_LPI_RECEIVED_value
    Private read_LPI_RECEIVED_value
    Private flag_LPI_RECEIVED
    Private write_HI_BER_value
    Private read_HI_BER_value
    Private flag_HI_BER
    Private write_LINK_STATUS_value
    Private read_LINK_STATUS_value
    Private flag_LINK_STATUS
    Private write_SYNC_STATUS_value
    Private read_SYNC_STATUS_value
    Private flag_SYNC_STATUS

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H8
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_LOCAL_FAULT
        get_LOCAL_FAULT = read_LOCAL_FAULT_value
    End Property

    Property Let set_LOCAL_FAULT(aData)
        write_LOCAL_FAULT_value = aData
        flag_LOCAL_FAULT        = &H1
    End Property

    Property Get read_LOCAL_FAULT
        read
        read_LOCAL_FAULT = read_LOCAL_FAULT_value
    End Property

    Property Let write_LOCAL_FAULT(aData)
        set_LOCAL_FAULT = aData
        write
    End Property

    Property Get get_REMOTE_FAULT
        get_REMOTE_FAULT = read_REMOTE_FAULT_value
    End Property

    Property Let set_REMOTE_FAULT(aData)
        write_REMOTE_FAULT_value = aData
        flag_REMOTE_FAULT        = &H1
    End Property

    Property Get read_REMOTE_FAULT
        read
        read_REMOTE_FAULT = read_REMOTE_FAULT_value
    End Property

    Property Let write_REMOTE_FAULT(aData)
        set_REMOTE_FAULT = aData
        write
    End Property

    Property Get get_LINK_INTERRUPT
        get_LINK_INTERRUPT = read_LINK_INTERRUPT_value
    End Property

    Property Let set_LINK_INTERRUPT(aData)
        write_LINK_INTERRUPT_value = aData
        flag_LINK_INTERRUPT        = &H1
    End Property

    Property Get read_LINK_INTERRUPT
        read
        read_LINK_INTERRUPT = read_LINK_INTERRUPT_value
    End Property

    Property Let write_LINK_INTERRUPT(aData)
        set_LINK_INTERRUPT = aData
        write
    End Property

    Property Get get_LPI_RECEIVED
        get_LPI_RECEIVED = read_LPI_RECEIVED_value
    End Property

    Property Let set_LPI_RECEIVED(aData)
        write_LPI_RECEIVED_value = aData
        flag_LPI_RECEIVED        = &H1
    End Property

    Property Get read_LPI_RECEIVED
        read
        read_LPI_RECEIVED = read_LPI_RECEIVED_value
    End Property

    Property Let write_LPI_RECEIVED(aData)
        set_LPI_RECEIVED = aData
        write
    End Property

    Property Get get_HI_BER
        get_HI_BER = read_HI_BER_value
    End Property

    Property Let set_HI_BER(aData)
        write_HI_BER_value = aData
        flag_HI_BER        = &H1
    End Property

    Property Get read_HI_BER
        read
        read_HI_BER = read_HI_BER_value
    End Property

    Property Let write_HI_BER(aData)
        set_HI_BER = aData
        write
    End Property

    Property Get get_LINK_STATUS
        get_LINK_STATUS = read_LINK_STATUS_value
    End Property

    Property Let set_LINK_STATUS(aData)
        write_LINK_STATUS_value = aData
        flag_LINK_STATUS        = &H1
    End Property

    Property Get read_LINK_STATUS
        read
        read_LINK_STATUS = read_LINK_STATUS_value
    End Property

    Property Let write_LINK_STATUS(aData)
        set_LINK_STATUS = aData
        write
    End Property

    Property Get get_SYNC_STATUS
        get_SYNC_STATUS = read_SYNC_STATUS_value
    End Property

    Property Let set_SYNC_STATUS(aData)
        write_SYNC_STATUS_value = aData
        flag_SYNC_STATUS        = &H1
    End Property

    Property Get read_SYNC_STATUS
        read
        read_SYNC_STATUS = read_SYNC_STATUS_value
    End Property

    Property Let write_SYNC_STATUS(aData)
        set_SYNC_STATUS = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LOCAL_FAULT_value = rightShift(data_low, 8) and &H1
        read_REMOTE_FAULT_value = rightShift(data_low, 7) and &H1
        read_LINK_INTERRUPT_value = rightShift(data_low, 6) and &H1
        read_LPI_RECEIVED_value = rightShift(data_low, 5) and &H1
        read_HI_BER_value = rightShift(data_low, 2) and &H1
        read_LINK_STATUS_value = rightShift(data_low, 1) and &H1
        SYNC_STATUS_mask = &H1
        if data_low > LONG_MAX then
            if SYNC_STATUS_mask = mask then
                read_SYNC_STATUS_value = data_low
            else
                read_SYNC_STATUS_value = (data_low - H8000_0000) and SYNC_STATUS_mask
            end If
        else
            read_SYNC_STATUS_value = data_low and SYNC_STATUS_mask
        end If

    End Sub

    Sub write
        If flag_LOCAL_FAULT = &H0 or flag_REMOTE_FAULT = &H0 or flag_LINK_INTERRUPT = &H0 or flag_LPI_RECEIVED = &H0 or flag_HI_BER = &H0 or flag_LINK_STATUS = &H0 or flag_SYNC_STATUS = &H0 Then read
        If flag_LOCAL_FAULT = &H0 Then write_LOCAL_FAULT_value = get_LOCAL_FAULT
        If flag_REMOTE_FAULT = &H0 Then write_REMOTE_FAULT_value = get_REMOTE_FAULT
        If flag_LINK_INTERRUPT = &H0 Then write_LINK_INTERRUPT_value = get_LINK_INTERRUPT
        If flag_LPI_RECEIVED = &H0 Then write_LPI_RECEIVED_value = get_LPI_RECEIVED
        If flag_HI_BER = &H0 Then write_HI_BER_value = get_HI_BER
        If flag_LINK_STATUS = &H0 Then write_LINK_STATUS_value = get_LINK_STATUS
        If flag_SYNC_STATUS = &H0 Then write_SYNC_STATUS_value = get_SYNC_STATUS

        regValue = leftShift((write_LOCAL_FAULT_value and &H1), 8) + leftShift((write_REMOTE_FAULT_value and &H1), 7) + leftShift((write_LINK_INTERRUPT_value and &H1), 6) + leftShift((write_LPI_RECEIVED_value and &H1), 5) + leftShift((write_HI_BER_value and &H1), 2) + leftShift((write_LINK_STATUS_value and &H1), 1) + leftShift((write_SYNC_STATUS_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LOCAL_FAULT_value = rightShift(data_low, 8) and &H1
        read_REMOTE_FAULT_value = rightShift(data_low, 7) and &H1
        read_LINK_INTERRUPT_value = rightShift(data_low, 6) and &H1
        read_LPI_RECEIVED_value = rightShift(data_low, 5) and &H1
        read_HI_BER_value = rightShift(data_low, 2) and &H1
        read_LINK_STATUS_value = rightShift(data_low, 1) and &H1
        SYNC_STATUS_mask = &H1
        if data_low > LONG_MAX then
            if SYNC_STATUS_mask = mask then
                read_SYNC_STATUS_value = data_low
            else
                read_SYNC_STATUS_value = (data_low - H8000_0000) and SYNC_STATUS_mask
            end If
        else
            read_SYNC_STATUS_value = data_low and SYNC_STATUS_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LOCAL_FAULT_value = &H0
        flag_LOCAL_FAULT        = &H0
        write_REMOTE_FAULT_value = &H0
        flag_REMOTE_FAULT        = &H0
        write_LINK_INTERRUPT_value = &H0
        flag_LINK_INTERRUPT        = &H0
        write_LPI_RECEIVED_value = &H0
        flag_LPI_RECEIVED        = &H0
        write_HI_BER_value = &H0
        flag_HI_BER        = &H0
        write_LINK_STATUS_value = &H0
        flag_LINK_STATUS        = &H0
        write_SYNC_STATUS_value = &H0
        flag_SYNC_STATUS        = &H0
    End Sub
End Class


'' @REGISTER : RX_X4_STATUS1_SGMIIPLUSR_X1_pcs_osr_speed_sgmiiplusr_x1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' pmd_rx_dme_en                              [11:11]          get_pmd_rx_dme_en
''                                                             set_pmd_rx_dme_en
''                                                             read_pmd_rx_dme_en
''                                                             write_pmd_rx_dme_en
''---------------------------------------------------------------------------------
'' pmd_tx_disable                             [10:10]          get_pmd_tx_disable
''                                                             set_pmd_tx_disable
''                                                             read_pmd_tx_disable
''                                                             write_pmd_tx_disable
''---------------------------------------------------------------------------------
'' pmd_osr_mode                               [9:6]            get_pmd_osr_mode
''                                                             set_pmd_osr_mode
''                                                             read_pmd_osr_mode
''                                                             write_pmd_osr_mode
''---------------------------------------------------------------------------------
'' r_ll_0_actual_speed                        [5:0]            get_r_ll_0_actual_speed
''                                                             set_r_ll_0_actual_speed
''                                                             read_r_ll_0_actual_speed
''                                                             write_r_ll_0_actual_speed
''---------------------------------------------------------------------------------
Class REGISTER_RX_X4_STATUS1_SGMIIPLUSR_X1_pcs_osr_speed_sgmiiplusr_x1
    Private write_pmd_rx_dme_en_value
    Private read_pmd_rx_dme_en_value
    Private flag_pmd_rx_dme_en
    Private write_pmd_tx_disable_value
    Private read_pmd_tx_disable_value
    Private flag_pmd_tx_disable
    Private write_pmd_osr_mode_value
    Private read_pmd_osr_mode_value
    Private flag_pmd_osr_mode
    Private write_r_ll_0_actual_speed_value
    Private read_r_ll_0_actual_speed_value
    Private flag_r_ll_0_actual_speed

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Ha
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_pmd_rx_dme_en
        get_pmd_rx_dme_en = read_pmd_rx_dme_en_value
    End Property

    Property Let set_pmd_rx_dme_en(aData)
        write_pmd_rx_dme_en_value = aData
        flag_pmd_rx_dme_en        = &H1
    End Property

    Property Get read_pmd_rx_dme_en
        read
        read_pmd_rx_dme_en = read_pmd_rx_dme_en_value
    End Property

    Property Let write_pmd_rx_dme_en(aData)
        set_pmd_rx_dme_en = aData
        write
    End Property

    Property Get get_pmd_tx_disable
        get_pmd_tx_disable = read_pmd_tx_disable_value
    End Property

    Property Let set_pmd_tx_disable(aData)
        write_pmd_tx_disable_value = aData
        flag_pmd_tx_disable        = &H1
    End Property

    Property Get read_pmd_tx_disable
        read
        read_pmd_tx_disable = read_pmd_tx_disable_value
    End Property

    Property Let write_pmd_tx_disable(aData)
        set_pmd_tx_disable = aData
        write
    End Property

    Property Get get_pmd_osr_mode
        get_pmd_osr_mode = read_pmd_osr_mode_value
    End Property

    Property Let set_pmd_osr_mode(aData)
        write_pmd_osr_mode_value = aData
        flag_pmd_osr_mode        = &H1
    End Property

    Property Get read_pmd_osr_mode
        read
        read_pmd_osr_mode = read_pmd_osr_mode_value
    End Property

    Property Let write_pmd_osr_mode(aData)
        set_pmd_osr_mode = aData
        write
    End Property

    Property Get get_r_ll_0_actual_speed
        get_r_ll_0_actual_speed = read_r_ll_0_actual_speed_value
    End Property

    Property Let set_r_ll_0_actual_speed(aData)
        write_r_ll_0_actual_speed_value = aData
        flag_r_ll_0_actual_speed        = &H1
    End Property

    Property Get read_r_ll_0_actual_speed
        read
        read_r_ll_0_actual_speed = read_r_ll_0_actual_speed_value
    End Property

    Property Let write_r_ll_0_actual_speed(aData)
        set_r_ll_0_actual_speed = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_pmd_rx_dme_en_value = rightShift(data_low, 11) and &H1
        read_pmd_tx_disable_value = rightShift(data_low, 10) and &H1
        read_pmd_osr_mode_value = rightShift(data_low, 6) and &Hf
        r_ll_0_actual_speed_mask = &H3f
        if data_low > LONG_MAX then
            if r_ll_0_actual_speed_mask = mask then
                read_r_ll_0_actual_speed_value = data_low
            else
                read_r_ll_0_actual_speed_value = (data_low - H8000_0000) and r_ll_0_actual_speed_mask
            end If
        else
            read_r_ll_0_actual_speed_value = data_low and r_ll_0_actual_speed_mask
        end If

    End Sub

    Sub write
        If flag_pmd_rx_dme_en = &H0 or flag_pmd_tx_disable = &H0 or flag_pmd_osr_mode = &H0 or flag_r_ll_0_actual_speed = &H0 Then read
        If flag_pmd_rx_dme_en = &H0 Then write_pmd_rx_dme_en_value = get_pmd_rx_dme_en
        If flag_pmd_tx_disable = &H0 Then write_pmd_tx_disable_value = get_pmd_tx_disable
        If flag_pmd_osr_mode = &H0 Then write_pmd_osr_mode_value = get_pmd_osr_mode
        If flag_r_ll_0_actual_speed = &H0 Then write_r_ll_0_actual_speed_value = get_r_ll_0_actual_speed

        regValue = leftShift((write_pmd_rx_dme_en_value and &H1), 11) + leftShift((write_pmd_tx_disable_value and &H1), 10) + leftShift((write_pmd_osr_mode_value and &Hf), 6) + leftShift((write_r_ll_0_actual_speed_value and &H3f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_pmd_rx_dme_en_value = rightShift(data_low, 11) and &H1
        read_pmd_tx_disable_value = rightShift(data_low, 10) and &H1
        read_pmd_osr_mode_value = rightShift(data_low, 6) and &Hf
        r_ll_0_actual_speed_mask = &H3f
        if data_low > LONG_MAX then
            if r_ll_0_actual_speed_mask = mask then
                read_r_ll_0_actual_speed_value = data_low
            else
                read_r_ll_0_actual_speed_value = (data_low - H8000_0000) and r_ll_0_actual_speed_mask
            end If
        else
            read_r_ll_0_actual_speed_value = data_low and r_ll_0_actual_speed_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_pmd_rx_dme_en_value = &H0
        flag_pmd_rx_dme_en        = &H0
        write_pmd_tx_disable_value = &H0
        flag_pmd_tx_disable        = &H0
        write_pmd_osr_mode_value = &H0
        flag_pmd_osr_mode        = &H0
        write_r_ll_0_actual_speed_value = &H0
        flag_r_ll_0_actual_speed        = &H0
    End Sub
End Class


'' @REGISTER : RX_X4_STATUS1_SGMIIPLUSR_X1_cl127_word_decode_status_sgmiiplusr_x1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' RWAWS                                      [15:15]          get_RWAWS
''                                                             set_RWAWS
''                                                             read_RWAWS
''                                                             write_RWAWS
''---------------------------------------------------------------------------------
'' RWADS                                      [14:14]          get_RWADS
''                                                             set_RWADS
''                                                             read_RWADS
''                                                             write_RWADS
''---------------------------------------------------------------------------------
'' RWAIS                                      [13:13]          get_RWAIS
''                                                             set_RWAIS
''                                                             read_RWAIS
''                                                             write_RWAIS
''---------------------------------------------------------------------------------
'' RWADS1                                     [12:12]          get_RWADS1
''                                                             set_RWADS1
''                                                             read_RWADS1
''                                                             write_RWADS1
''---------------------------------------------------------------------------------
'' RWASD                                      [11:11]          get_RWASD
''                                                             set_RWASD
''                                                             read_RWASD
''                                                             write_RWASD
''---------------------------------------------------------------------------------
'' RWAID                                      [10:10]          get_RWAID
''                                                             set_RWAID
''                                                             read_RWAID
''                                                             write_RWAID
''---------------------------------------------------------------------------------
'' RWASD1                                     [9:9]            get_RWASD1
''                                                             set_RWASD1
''                                                             read_RWASD1
''                                                             write_RWASD1
''---------------------------------------------------------------------------------
'' RWABHL                                     [8:8]            get_RWABHL
''                                                             set_RWABHL
''                                                             read_RWABHL
''                                                             write_RWABHL
''---------------------------------------------------------------------------------
'' RDSICL                                     [7:7]            get_RDSICL
''                                                             set_RDSICL
''                                                             read_RDSICL
''                                                             write_RDSICL
''---------------------------------------------------------------------------------
'' RDSDCL                                     [6:6]            get_RDSDCL
''                                                             set_RDSDCL
''                                                             read_RDSDCL
''                                                             write_RDSDCL
''---------------------------------------------------------------------------------
'' RDSSCL                                     [5:5]            get_RDSSCL
''                                                             set_RDSSCL
''                                                             read_RDSSCL
''                                                             write_RDSSCL
''---------------------------------------------------------------------------------
'' RDSECL                                     [4:4]            get_RDSECL
''                                                             set_RDSECL
''                                                             read_RDSECL
''                                                             write_RDSECL
''---------------------------------------------------------------------------------
'' RDSICH                                     [3:3]            get_RDSICH
''                                                             set_RDSICH
''                                                             read_RDSICH
''                                                             write_RDSICH
''---------------------------------------------------------------------------------
'' RDSDCH                                     [2:2]            get_RDSDCH
''                                                             set_RDSDCH
''                                                             read_RDSDCH
''                                                             write_RDSDCH
''---------------------------------------------------------------------------------
'' RDSSCH                                     [1:1]            get_RDSSCH
''                                                             set_RDSSCH
''                                                             read_RDSSCH
''                                                             write_RDSSCH
''---------------------------------------------------------------------------------
'' RDSECH                                     [0:0]            get_RDSECH
''                                                             set_RDSECH
''                                                             read_RDSECH
''                                                             write_RDSECH
''---------------------------------------------------------------------------------
Class REGISTER_RX_X4_STATUS1_SGMIIPLUSR_X1_cl127_word_decode_status_sgmiiplusr_x1
    Private write_RWAWS_value
    Private read_RWAWS_value
    Private flag_RWAWS
    Private write_RWADS_value
    Private read_RWADS_value
    Private flag_RWADS
    Private write_RWAIS_value
    Private read_RWAIS_value
    Private flag_RWAIS
    Private write_RWADS1_value
    Private read_RWADS1_value
    Private flag_RWADS1
    Private write_RWASD_value
    Private read_RWASD_value
    Private flag_RWASD
    Private write_RWAID_value
    Private read_RWAID_value
    Private flag_RWAID
    Private write_RWASD1_value
    Private read_RWASD1_value
    Private flag_RWASD1
    Private write_RWABHL_value
    Private read_RWABHL_value
    Private flag_RWABHL
    Private write_RDSICL_value
    Private read_RDSICL_value
    Private flag_RDSICL
    Private write_RDSDCL_value
    Private read_RDSDCL_value
    Private flag_RDSDCL
    Private write_RDSSCL_value
    Private read_RDSSCL_value
    Private flag_RDSSCL
    Private write_RDSECL_value
    Private read_RDSECL_value
    Private flag_RDSECL
    Private write_RDSICH_value
    Private read_RDSICH_value
    Private flag_RDSICH
    Private write_RDSDCH_value
    Private read_RDSDCH_value
    Private flag_RDSDCH
    Private write_RDSSCH_value
    Private read_RDSSCH_value
    Private flag_RDSSCH
    Private write_RDSECH_value
    Private read_RDSECH_value
    Private flag_RDSECH

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hc
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_RWAWS
        get_RWAWS = read_RWAWS_value
    End Property

    Property Let set_RWAWS(aData)
        write_RWAWS_value = aData
        flag_RWAWS        = &H1
    End Property

    Property Get read_RWAWS
        read
        read_RWAWS = read_RWAWS_value
    End Property

    Property Let write_RWAWS(aData)
        set_RWAWS = aData
        write
    End Property

    Property Get get_RWADS
        get_RWADS = read_RWADS_value
    End Property

    Property Let set_RWADS(aData)
        write_RWADS_value = aData
        flag_RWADS        = &H1
    End Property

    Property Get read_RWADS
        read
        read_RWADS = read_RWADS_value
    End Property

    Property Let write_RWADS(aData)
        set_RWADS = aData
        write
    End Property

    Property Get get_RWAIS
        get_RWAIS = read_RWAIS_value
    End Property

    Property Let set_RWAIS(aData)
        write_RWAIS_value = aData
        flag_RWAIS        = &H1
    End Property

    Property Get read_RWAIS
        read
        read_RWAIS = read_RWAIS_value
    End Property

    Property Let write_RWAIS(aData)
        set_RWAIS = aData
        write
    End Property

    Property Get get_RWADS1
        get_RWADS1 = read_RWADS1_value
    End Property

    Property Let set_RWADS1(aData)
        write_RWADS1_value = aData
        flag_RWADS1        = &H1
    End Property

    Property Get read_RWADS1
        read
        read_RWADS1 = read_RWADS1_value
    End Property

    Property Let write_RWADS1(aData)
        set_RWADS1 = aData
        write
    End Property

    Property Get get_RWASD
        get_RWASD = read_RWASD_value
    End Property

    Property Let set_RWASD(aData)
        write_RWASD_value = aData
        flag_RWASD        = &H1
    End Property

    Property Get read_RWASD
        read
        read_RWASD = read_RWASD_value
    End Property

    Property Let write_RWASD(aData)
        set_RWASD = aData
        write
    End Property

    Property Get get_RWAID
        get_RWAID = read_RWAID_value
    End Property

    Property Let set_RWAID(aData)
        write_RWAID_value = aData
        flag_RWAID        = &H1
    End Property

    Property Get read_RWAID
        read
        read_RWAID = read_RWAID_value
    End Property

    Property Let write_RWAID(aData)
        set_RWAID = aData
        write
    End Property

    Property Get get_RWASD1
        get_RWASD1 = read_RWASD1_value
    End Property

    Property Let set_RWASD1(aData)
        write_RWASD1_value = aData
        flag_RWASD1        = &H1
    End Property

    Property Get read_RWASD1
        read
        read_RWASD1 = read_RWASD1_value
    End Property

    Property Let write_RWASD1(aData)
        set_RWASD1 = aData
        write
    End Property

    Property Get get_RWABHL
        get_RWABHL = read_RWABHL_value
    End Property

    Property Let set_RWABHL(aData)
        write_RWABHL_value = aData
        flag_RWABHL        = &H1
    End Property

    Property Get read_RWABHL
        read
        read_RWABHL = read_RWABHL_value
    End Property

    Property Let write_RWABHL(aData)
        set_RWABHL = aData
        write
    End Property

    Property Get get_RDSICL
        get_RDSICL = read_RDSICL_value
    End Property

    Property Let set_RDSICL(aData)
        write_RDSICL_value = aData
        flag_RDSICL        = &H1
    End Property

    Property Get read_RDSICL
        read
        read_RDSICL = read_RDSICL_value
    End Property

    Property Let write_RDSICL(aData)
        set_RDSICL = aData
        write
    End Property

    Property Get get_RDSDCL
        get_RDSDCL = read_RDSDCL_value
    End Property

    Property Let set_RDSDCL(aData)
        write_RDSDCL_value = aData
        flag_RDSDCL        = &H1
    End Property

    Property Get read_RDSDCL
        read
        read_RDSDCL = read_RDSDCL_value
    End Property

    Property Let write_RDSDCL(aData)
        set_RDSDCL = aData
        write
    End Property

    Property Get get_RDSSCL
        get_RDSSCL = read_RDSSCL_value
    End Property

    Property Let set_RDSSCL(aData)
        write_RDSSCL_value = aData
        flag_RDSSCL        = &H1
    End Property

    Property Get read_RDSSCL
        read
        read_RDSSCL = read_RDSSCL_value
    End Property

    Property Let write_RDSSCL(aData)
        set_RDSSCL = aData
        write
    End Property

    Property Get get_RDSECL
        get_RDSECL = read_RDSECL_value
    End Property

    Property Let set_RDSECL(aData)
        write_RDSECL_value = aData
        flag_RDSECL        = &H1
    End Property

    Property Get read_RDSECL
        read
        read_RDSECL = read_RDSECL_value
    End Property

    Property Let write_RDSECL(aData)
        set_RDSECL = aData
        write
    End Property

    Property Get get_RDSICH
        get_RDSICH = read_RDSICH_value
    End Property

    Property Let set_RDSICH(aData)
        write_RDSICH_value = aData
        flag_RDSICH        = &H1
    End Property

    Property Get read_RDSICH
        read
        read_RDSICH = read_RDSICH_value
    End Property

    Property Let write_RDSICH(aData)
        set_RDSICH = aData
        write
    End Property

    Property Get get_RDSDCH
        get_RDSDCH = read_RDSDCH_value
    End Property

    Property Let set_RDSDCH(aData)
        write_RDSDCH_value = aData
        flag_RDSDCH        = &H1
    End Property

    Property Get read_RDSDCH
        read
        read_RDSDCH = read_RDSDCH_value
    End Property

    Property Let write_RDSDCH(aData)
        set_RDSDCH = aData
        write
    End Property

    Property Get get_RDSSCH
        get_RDSSCH = read_RDSSCH_value
    End Property

    Property Let set_RDSSCH(aData)
        write_RDSSCH_value = aData
        flag_RDSSCH        = &H1
    End Property

    Property Get read_RDSSCH
        read
        read_RDSSCH = read_RDSSCH_value
    End Property

    Property Let write_RDSSCH(aData)
        set_RDSSCH = aData
        write
    End Property

    Property Get get_RDSECH
        get_RDSECH = read_RDSECH_value
    End Property

    Property Let set_RDSECH(aData)
        write_RDSECH_value = aData
        flag_RDSECH        = &H1
    End Property

    Property Get read_RDSECH
        read
        read_RDSECH = read_RDSECH_value
    End Property

    Property Let write_RDSECH(aData)
        set_RDSECH = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_RWAWS_value = rightShift(data_low, 15) and &H1
        read_RWADS_value = rightShift(data_low, 14) and &H1
        read_RWAIS_value = rightShift(data_low, 13) and &H1
        read_RWADS1_value = rightShift(data_low, 12) and &H1
        read_RWASD_value = rightShift(data_low, 11) and &H1
        read_RWAID_value = rightShift(data_low, 10) and &H1
        read_RWASD1_value = rightShift(data_low, 9) and &H1
        read_RWABHL_value = rightShift(data_low, 8) and &H1
        read_RDSICL_value = rightShift(data_low, 7) and &H1
        read_RDSDCL_value = rightShift(data_low, 6) and &H1
        read_RDSSCL_value = rightShift(data_low, 5) and &H1
        read_RDSECL_value = rightShift(data_low, 4) and &H1
        read_RDSICH_value = rightShift(data_low, 3) and &H1
        read_RDSDCH_value = rightShift(data_low, 2) and &H1
        read_RDSSCH_value = rightShift(data_low, 1) and &H1
        RDSECH_mask = &H1
        if data_low > LONG_MAX then
            if RDSECH_mask = mask then
                read_RDSECH_value = data_low
            else
                read_RDSECH_value = (data_low - H8000_0000) and RDSECH_mask
            end If
        else
            read_RDSECH_value = data_low and RDSECH_mask
        end If

    End Sub

    Sub write
        If flag_RWAWS = &H0 or flag_RWADS = &H0 or flag_RWAIS = &H0 or flag_RWADS1 = &H0 or flag_RWASD = &H0 or flag_RWAID = &H0 or flag_RWASD1 = &H0 or flag_RWABHL = &H0 or flag_RDSICL = &H0 or flag_RDSDCL = &H0 or flag_RDSSCL = &H0 or flag_RDSECL = &H0 or flag_RDSICH = &H0 or flag_RDSDCH = &H0 or flag_RDSSCH = &H0 or flag_RDSECH = &H0 Then read
        If flag_RWAWS = &H0 Then write_RWAWS_value = get_RWAWS
        If flag_RWADS = &H0 Then write_RWADS_value = get_RWADS
        If flag_RWAIS = &H0 Then write_RWAIS_value = get_RWAIS
        If flag_RWADS1 = &H0 Then write_RWADS1_value = get_RWADS1
        If flag_RWASD = &H0 Then write_RWASD_value = get_RWASD
        If flag_RWAID = &H0 Then write_RWAID_value = get_RWAID
        If flag_RWASD1 = &H0 Then write_RWASD1_value = get_RWASD1
        If flag_RWABHL = &H0 Then write_RWABHL_value = get_RWABHL
        If flag_RDSICL = &H0 Then write_RDSICL_value = get_RDSICL
        If flag_RDSDCL = &H0 Then write_RDSDCL_value = get_RDSDCL
        If flag_RDSSCL = &H0 Then write_RDSSCL_value = get_RDSSCL
        If flag_RDSECL = &H0 Then write_RDSECL_value = get_RDSECL
        If flag_RDSICH = &H0 Then write_RDSICH_value = get_RDSICH
        If flag_RDSDCH = &H0 Then write_RDSDCH_value = get_RDSDCH
        If flag_RDSSCH = &H0 Then write_RDSSCH_value = get_RDSSCH
        If flag_RDSECH = &H0 Then write_RDSECH_value = get_RDSECH

        regValue = leftShift((write_RWAWS_value and &H1), 15) + leftShift((write_RWADS_value and &H1), 14) + leftShift((write_RWAIS_value and &H1), 13) + leftShift((write_RWADS1_value and &H1), 12) + leftShift((write_RWASD_value and &H1), 11) + leftShift((write_RWAID_value and &H1), 10) + leftShift((write_RWASD1_value and &H1), 9) + leftShift((write_RWABHL_value and &H1), 8) + leftShift((write_RDSICL_value and &H1), 7) + leftShift((write_RDSDCL_value and &H1), 6) + leftShift((write_RDSSCL_value and &H1), 5) + leftShift((write_RDSECL_value and &H1), 4) + leftShift((write_RDSICH_value and &H1), 3) + leftShift((write_RDSDCH_value and &H1), 2) + leftShift((write_RDSSCH_value and &H1), 1) + leftShift((write_RDSECH_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_RWAWS_value = rightShift(data_low, 15) and &H1
        read_RWADS_value = rightShift(data_low, 14) and &H1
        read_RWAIS_value = rightShift(data_low, 13) and &H1
        read_RWADS1_value = rightShift(data_low, 12) and &H1
        read_RWASD_value = rightShift(data_low, 11) and &H1
        read_RWAID_value = rightShift(data_low, 10) and &H1
        read_RWASD1_value = rightShift(data_low, 9) and &H1
        read_RWABHL_value = rightShift(data_low, 8) and &H1
        read_RDSICL_value = rightShift(data_low, 7) and &H1
        read_RDSDCL_value = rightShift(data_low, 6) and &H1
        read_RDSSCL_value = rightShift(data_low, 5) and &H1
        read_RDSECL_value = rightShift(data_low, 4) and &H1
        read_RDSICH_value = rightShift(data_low, 3) and &H1
        read_RDSDCH_value = rightShift(data_low, 2) and &H1
        read_RDSSCH_value = rightShift(data_low, 1) and &H1
        RDSECH_mask = &H1
        if data_low > LONG_MAX then
            if RDSECH_mask = mask then
                read_RDSECH_value = data_low
            else
                read_RDSECH_value = (data_low - H8000_0000) and RDSECH_mask
            end If
        else
            read_RDSECH_value = data_low and RDSECH_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_RWAWS_value = &H0
        flag_RWAWS        = &H0
        write_RWADS_value = &H0
        flag_RWADS        = &H0
        write_RWAIS_value = &H0
        flag_RWAIS        = &H0
        write_RWADS1_value = &H0
        flag_RWADS1        = &H0
        write_RWASD_value = &H0
        flag_RWASD        = &H0
        write_RWAID_value = &H0
        flag_RWAID        = &H0
        write_RWASD1_value = &H0
        flag_RWASD1        = &H0
        write_RWABHL_value = &H0
        flag_RWABHL        = &H0
        write_RDSICL_value = &H0
        flag_RDSICL        = &H0
        write_RDSDCL_value = &H0
        flag_RDSDCL        = &H0
        write_RDSSCL_value = &H0
        flag_RDSSCL        = &H0
        write_RDSECL_value = &H0
        flag_RDSECL        = &H0
        write_RDSICH_value = &H0
        flag_RDSICH        = &H0
        write_RDSDCH_value = &H0
        flag_RDSDCH        = &H0
        write_RDSSCH_value = &H0
        flag_RDSSCH        = &H0
        write_RDSECH_value = &H0
        flag_RDSECH        = &H0
    End Sub
End Class


'' @REGISTER : RX_X4_STATUS1_SGMIIPLUSR_X1_blockaddress
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' BlockAddress                               [14:4]           get_BlockAddress
''                                                             set_BlockAddress
''                                                             read_BlockAddress
''                                                             write_BlockAddress
''---------------------------------------------------------------------------------
Class REGISTER_RX_X4_STATUS1_SGMIIPLUSR_X1_blockaddress
    Private write_BlockAddress_value
    Private read_BlockAddress_value
    Private flag_BlockAddress

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1e
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_BlockAddress
        get_BlockAddress = read_BlockAddress_value
    End Property

    Property Let set_BlockAddress(aData)
        write_BlockAddress_value = aData
        flag_BlockAddress        = &H1
    End Property

    Property Get read_BlockAddress
        read
        read_BlockAddress = read_BlockAddress_value
    End Property

    Property Let write_BlockAddress(aData)
        set_BlockAddress = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_BlockAddress_value = rightShift(data_low, 4) and &H7ff

    End Sub

    Sub write
        If flag_BlockAddress = &H0 Then read
        If flag_BlockAddress = &H0 Then write_BlockAddress_value = get_BlockAddress

        regValue = leftShift((write_BlockAddress_value and &H7ff), 4)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_BlockAddress_value = rightShift(data_low, 4) and &H7ff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_BlockAddress_value = &H0
        flag_BlockAddress        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class RX_X4_STATUS1_SGMIIPLUSR_X1_INSTANCE

    Public pcs_latched_status_1_sgmiiplusr_x1
    Public pcs_latched_status_0_sgmiiplusr_x1
    Public pcs_live_status_sgmiiplusr_x1
    Public pcs_osr_speed_sgmiiplusr_x1
    Public cl127_word_decode_status_sgmiiplusr_x1
    Public blockaddress


    Public default function Init(aBaseAddr)
        Set pcs_latched_status_1_sgmiiplusr_x1 = (New REGISTER_RX_X4_STATUS1_SGMIIPLUSR_X1_pcs_latched_status_1_sgmiiplusr_x1)(aBaseAddr, 16)
        Set pcs_latched_status_0_sgmiiplusr_x1 = (New REGISTER_RX_X4_STATUS1_SGMIIPLUSR_X1_pcs_latched_status_0_sgmiiplusr_x1)(aBaseAddr, 16)
        Set pcs_live_status_sgmiiplusr_x1 = (New REGISTER_RX_X4_STATUS1_SGMIIPLUSR_X1_pcs_live_status_sgmiiplusr_x1)(aBaseAddr, 16)
        Set pcs_osr_speed_sgmiiplusr_x1 = (New REGISTER_RX_X4_STATUS1_SGMIIPLUSR_X1_pcs_osr_speed_sgmiiplusr_x1)(aBaseAddr, 16)
        Set cl127_word_decode_status_sgmiiplusr_x1 = (New REGISTER_RX_X4_STATUS1_SGMIIPLUSR_X1_cl127_word_decode_status_sgmiiplusr_x1)(aBaseAddr, 16)
        Set blockaddress = (New REGISTER_RX_X4_STATUS1_SGMIIPLUSR_X1_blockaddress)(aBaseAddr, 16)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set RX_X4_STATUS1_SGMIIPLUSR_X1 = CreateObject("System.Collections.ArrayList")
RX_X4_STATUS1_SGMIIPLUSR_X1.Add ((New RX_X4_STATUS1_SGMIIPLUSR_X1_INSTANCE)(&H4aed88e0))


