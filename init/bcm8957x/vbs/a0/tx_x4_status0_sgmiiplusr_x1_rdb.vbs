

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


'' @REGISTER : TX_X4_STATUS0_SGMIIPLUSR_X1_encode_status_0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' cl49_t_type_coded                          [15:12]          get_cl49_t_type_coded
''                                                             set_cl49_t_type_coded
''                                                             read_cl49_t_type_coded
''                                                             write_cl49_t_type_coded
''---------------------------------------------------------------------------------
'' cl49_tx_fault_det                          [11:11]          get_cl49_tx_fault_det
''                                                             set_cl49_tx_fault_det
''                                                             read_cl49_tx_fault_det
''                                                             write_cl49_tx_fault_det
''---------------------------------------------------------------------------------
'' cl49_ltxsm_state                           [10:3]           get_cl49_ltxsm_state
''                                                             set_cl49_ltxsm_state
''                                                             read_cl49_ltxsm_state
''                                                             write_cl49_ltxsm_state
''---------------------------------------------------------------------------------
'' cl49_txsm_state                            [2:0]            get_cl49_txsm_state
''                                                             set_cl49_txsm_state
''                                                             read_cl49_txsm_state
''                                                             write_cl49_txsm_state
''---------------------------------------------------------------------------------
Class REGISTER_TX_X4_STATUS0_SGMIIPLUSR_X1_encode_status_0
    Private write_cl49_t_type_coded_value
    Private read_cl49_t_type_coded_value
    Private flag_cl49_t_type_coded
    Private write_cl49_tx_fault_det_value
    Private read_cl49_tx_fault_det_value
    Private flag_cl49_tx_fault_det
    Private write_cl49_ltxsm_state_value
    Private read_cl49_ltxsm_state_value
    Private flag_cl49_ltxsm_state
    Private write_cl49_txsm_state_value
    Private read_cl49_txsm_state_value
    Private flag_cl49_txsm_state

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H0
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_cl49_t_type_coded
        get_cl49_t_type_coded = read_cl49_t_type_coded_value
    End Property

    Property Let set_cl49_t_type_coded(aData)
        write_cl49_t_type_coded_value = aData
        flag_cl49_t_type_coded        = &H1
    End Property

    Property Get read_cl49_t_type_coded
        read
        read_cl49_t_type_coded = read_cl49_t_type_coded_value
    End Property

    Property Let write_cl49_t_type_coded(aData)
        set_cl49_t_type_coded = aData
        write
    End Property

    Property Get get_cl49_tx_fault_det
        get_cl49_tx_fault_det = read_cl49_tx_fault_det_value
    End Property

    Property Let set_cl49_tx_fault_det(aData)
        write_cl49_tx_fault_det_value = aData
        flag_cl49_tx_fault_det        = &H1
    End Property

    Property Get read_cl49_tx_fault_det
        read
        read_cl49_tx_fault_det = read_cl49_tx_fault_det_value
    End Property

    Property Let write_cl49_tx_fault_det(aData)
        set_cl49_tx_fault_det = aData
        write
    End Property

    Property Get get_cl49_ltxsm_state
        get_cl49_ltxsm_state = read_cl49_ltxsm_state_value
    End Property

    Property Let set_cl49_ltxsm_state(aData)
        write_cl49_ltxsm_state_value = aData
        flag_cl49_ltxsm_state        = &H1
    End Property

    Property Get read_cl49_ltxsm_state
        read
        read_cl49_ltxsm_state = read_cl49_ltxsm_state_value
    End Property

    Property Let write_cl49_ltxsm_state(aData)
        set_cl49_ltxsm_state = aData
        write
    End Property

    Property Get get_cl49_txsm_state
        get_cl49_txsm_state = read_cl49_txsm_state_value
    End Property

    Property Let set_cl49_txsm_state(aData)
        write_cl49_txsm_state_value = aData
        flag_cl49_txsm_state        = &H1
    End Property

    Property Get read_cl49_txsm_state
        read
        read_cl49_txsm_state = read_cl49_txsm_state_value
    End Property

    Property Let write_cl49_txsm_state(aData)
        set_cl49_txsm_state = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_cl49_t_type_coded_value = rightShift(data_low, 12) and &Hf
        read_cl49_tx_fault_det_value = rightShift(data_low, 11) and &H1
        read_cl49_ltxsm_state_value = rightShift(data_low, 3) and &Hff
        cl49_txsm_state_mask = &H7
        if data_low > LONG_MAX then
            if cl49_txsm_state_mask = mask then
                read_cl49_txsm_state_value = data_low
            else
                read_cl49_txsm_state_value = (data_low - H8000_0000) and cl49_txsm_state_mask
            end If
        else
            read_cl49_txsm_state_value = data_low and cl49_txsm_state_mask
        end If

    End Sub

    Sub write
        If flag_cl49_t_type_coded = &H0 or flag_cl49_tx_fault_det = &H0 or flag_cl49_ltxsm_state = &H0 or flag_cl49_txsm_state = &H0 Then read
        If flag_cl49_t_type_coded = &H0 Then write_cl49_t_type_coded_value = get_cl49_t_type_coded
        If flag_cl49_tx_fault_det = &H0 Then write_cl49_tx_fault_det_value = get_cl49_tx_fault_det
        If flag_cl49_ltxsm_state = &H0 Then write_cl49_ltxsm_state_value = get_cl49_ltxsm_state
        If flag_cl49_txsm_state = &H0 Then write_cl49_txsm_state_value = get_cl49_txsm_state

        regValue = leftShift((write_cl49_t_type_coded_value and &Hf), 12) + leftShift((write_cl49_tx_fault_det_value and &H1), 11) + leftShift((write_cl49_ltxsm_state_value and &Hff), 3) + leftShift((write_cl49_txsm_state_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_cl49_t_type_coded_value = rightShift(data_low, 12) and &Hf
        read_cl49_tx_fault_det_value = rightShift(data_low, 11) and &H1
        read_cl49_ltxsm_state_value = rightShift(data_low, 3) and &Hff
        cl49_txsm_state_mask = &H7
        if data_low > LONG_MAX then
            if cl49_txsm_state_mask = mask then
                read_cl49_txsm_state_value = data_low
            else
                read_cl49_txsm_state_value = (data_low - H8000_0000) and cl49_txsm_state_mask
            end If
        else
            read_cl49_txsm_state_value = data_low and cl49_txsm_state_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_cl49_t_type_coded_value = &H0
        flag_cl49_t_type_coded        = &H0
        write_cl49_tx_fault_det_value = &H0
        flag_cl49_tx_fault_det        = &H0
        write_cl49_ltxsm_state_value = &H0
        flag_cl49_ltxsm_state        = &H0
        write_cl49_txsm_state_value = &H0
        flag_cl49_txsm_state        = &H0
    End Sub
End Class


'' @REGISTER : TX_X4_STATUS0_SGMIIPLUSR_X1_pcs_status_sgmiiplusr_x1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' tx_gbox_afrst_stky                         [11:11]          get_tx_gbox_afrst_stky
''                                                             set_tx_gbox_afrst_stky
''                                                             read_tx_gbox_afrst_stky
''                                                             write_tx_gbox_afrst_stky
''---------------------------------------------------------------------------------
'' TGOEDL                                     [10:10]          get_TGOEDL
''                                                             set_TGOEDL
''                                                             read_TGOEDL
''                                                             write_TGOEDL
''---------------------------------------------------------------------------------
'' TGUEDL                                     [9:9]            get_TGUEDL
''                                                             set_TGUEDL
''                                                             read_TGUEDL
''                                                             write_TGUEDL
''---------------------------------------------------------------------------------
'' tx_LOCAL_FAULT                             [8:8]            get_tx_LOCAL_FAULT
''                                                             set_tx_LOCAL_FAULT
''                                                             read_tx_LOCAL_FAULT
''                                                             write_tx_LOCAL_FAULT
''---------------------------------------------------------------------------------
'' tx_REMOTE_FAULT                            [7:7]            get_tx_REMOTE_FAULT
''                                                             set_tx_REMOTE_FAULT
''                                                             read_tx_REMOTE_FAULT
''                                                             write_tx_REMOTE_FAULT
''---------------------------------------------------------------------------------
'' tx_LINK_INTERRUPT                          [6:6]            get_tx_LINK_INTERRUPT
''                                                             set_tx_LINK_INTERRUPT
''                                                             read_tx_LINK_INTERRUPT
''                                                             write_tx_LINK_INTERRUPT
''---------------------------------------------------------------------------------
'' tx_LPI_RECEIVED                            [5:5]            get_tx_LPI_RECEIVED
''                                                             set_tx_LPI_RECEIVED
''                                                             read_tx_LPI_RECEIVED
''                                                             write_tx_LPI_RECEIVED
''---------------------------------------------------------------------------------
'' LINK_INTERRUPT_LH                          [4:4]            get_LINK_INTERRUPT_LH
''                                                             set_LINK_INTERRUPT_LH
''                                                             read_LINK_INTERRUPT_LH
''                                                             write_LINK_INTERRUPT_LH
''---------------------------------------------------------------------------------
'' LOCAL_FAULT_LH                             [3:3]            get_LOCAL_FAULT_LH
''                                                             set_LOCAL_FAULT_LH
''                                                             read_LOCAL_FAULT_LH
''                                                             write_LOCAL_FAULT_LH
''---------------------------------------------------------------------------------
'' REMOTE_FAULT_LH                            [2:2]            get_REMOTE_FAULT_LH
''                                                             set_REMOTE_FAULT_LH
''                                                             read_REMOTE_FAULT_LH
''                                                             write_REMOTE_FAULT_LH
''---------------------------------------------------------------------------------
'' RESERVED_ORDERED_SET_LH                    [1:1]            get_RESERVED_ORDERED_SET_LH
''                                                             set_RESERVED_ORDERED_SET_LH
''                                                             read_RESERVED_ORDERED_SET_LH
''                                                             write_RESERVED_ORDERED_SET_LH
''---------------------------------------------------------------------------------
'' LPI_RECEIVED_LH                            [0:0]            get_LPI_RECEIVED_LH
''                                                             set_LPI_RECEIVED_LH
''                                                             read_LPI_RECEIVED_LH
''                                                             write_LPI_RECEIVED_LH
''---------------------------------------------------------------------------------
Class REGISTER_TX_X4_STATUS0_SGMIIPLUSR_X1_pcs_status_sgmiiplusr_x1
    Private write_tx_gbox_afrst_stky_value
    Private read_tx_gbox_afrst_stky_value
    Private flag_tx_gbox_afrst_stky
    Private write_TGOEDL_value
    Private read_TGOEDL_value
    Private flag_TGOEDL
    Private write_TGUEDL_value
    Private read_TGUEDL_value
    Private flag_TGUEDL
    Private write_tx_LOCAL_FAULT_value
    Private read_tx_LOCAL_FAULT_value
    Private flag_tx_LOCAL_FAULT
    Private write_tx_REMOTE_FAULT_value
    Private read_tx_REMOTE_FAULT_value
    Private flag_tx_REMOTE_FAULT
    Private write_tx_LINK_INTERRUPT_value
    Private read_tx_LINK_INTERRUPT_value
    Private flag_tx_LINK_INTERRUPT
    Private write_tx_LPI_RECEIVED_value
    Private read_tx_LPI_RECEIVED_value
    Private flag_tx_LPI_RECEIVED
    Private write_LINK_INTERRUPT_LH_value
    Private read_LINK_INTERRUPT_LH_value
    Private flag_LINK_INTERRUPT_LH
    Private write_LOCAL_FAULT_LH_value
    Private read_LOCAL_FAULT_LH_value
    Private flag_LOCAL_FAULT_LH
    Private write_REMOTE_FAULT_LH_value
    Private read_REMOTE_FAULT_LH_value
    Private flag_REMOTE_FAULT_LH
    Private write_RESERVED_ORDERED_SET_LH_value
    Private read_RESERVED_ORDERED_SET_LH_value
    Private flag_RESERVED_ORDERED_SET_LH
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
        offset = &H2
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_tx_gbox_afrst_stky
        get_tx_gbox_afrst_stky = read_tx_gbox_afrst_stky_value
    End Property

    Property Let set_tx_gbox_afrst_stky(aData)
        write_tx_gbox_afrst_stky_value = aData
        flag_tx_gbox_afrst_stky        = &H1
    End Property

    Property Get read_tx_gbox_afrst_stky
        read
        read_tx_gbox_afrst_stky = read_tx_gbox_afrst_stky_value
    End Property

    Property Let write_tx_gbox_afrst_stky(aData)
        set_tx_gbox_afrst_stky = aData
        write
    End Property

    Property Get get_TGOEDL
        get_TGOEDL = read_TGOEDL_value
    End Property

    Property Let set_TGOEDL(aData)
        write_TGOEDL_value = aData
        flag_TGOEDL        = &H1
    End Property

    Property Get read_TGOEDL
        read
        read_TGOEDL = read_TGOEDL_value
    End Property

    Property Let write_TGOEDL(aData)
        set_TGOEDL = aData
        write
    End Property

    Property Get get_TGUEDL
        get_TGUEDL = read_TGUEDL_value
    End Property

    Property Let set_TGUEDL(aData)
        write_TGUEDL_value = aData
        flag_TGUEDL        = &H1
    End Property

    Property Get read_TGUEDL
        read
        read_TGUEDL = read_TGUEDL_value
    End Property

    Property Let write_TGUEDL(aData)
        set_TGUEDL = aData
        write
    End Property

    Property Get get_tx_LOCAL_FAULT
        get_tx_LOCAL_FAULT = read_tx_LOCAL_FAULT_value
    End Property

    Property Let set_tx_LOCAL_FAULT(aData)
        write_tx_LOCAL_FAULT_value = aData
        flag_tx_LOCAL_FAULT        = &H1
    End Property

    Property Get read_tx_LOCAL_FAULT
        read
        read_tx_LOCAL_FAULT = read_tx_LOCAL_FAULT_value
    End Property

    Property Let write_tx_LOCAL_FAULT(aData)
        set_tx_LOCAL_FAULT = aData
        write
    End Property

    Property Get get_tx_REMOTE_FAULT
        get_tx_REMOTE_FAULT = read_tx_REMOTE_FAULT_value
    End Property

    Property Let set_tx_REMOTE_FAULT(aData)
        write_tx_REMOTE_FAULT_value = aData
        flag_tx_REMOTE_FAULT        = &H1
    End Property

    Property Get read_tx_REMOTE_FAULT
        read
        read_tx_REMOTE_FAULT = read_tx_REMOTE_FAULT_value
    End Property

    Property Let write_tx_REMOTE_FAULT(aData)
        set_tx_REMOTE_FAULT = aData
        write
    End Property

    Property Get get_tx_LINK_INTERRUPT
        get_tx_LINK_INTERRUPT = read_tx_LINK_INTERRUPT_value
    End Property

    Property Let set_tx_LINK_INTERRUPT(aData)
        write_tx_LINK_INTERRUPT_value = aData
        flag_tx_LINK_INTERRUPT        = &H1
    End Property

    Property Get read_tx_LINK_INTERRUPT
        read
        read_tx_LINK_INTERRUPT = read_tx_LINK_INTERRUPT_value
    End Property

    Property Let write_tx_LINK_INTERRUPT(aData)
        set_tx_LINK_INTERRUPT = aData
        write
    End Property

    Property Get get_tx_LPI_RECEIVED
        get_tx_LPI_RECEIVED = read_tx_LPI_RECEIVED_value
    End Property

    Property Let set_tx_LPI_RECEIVED(aData)
        write_tx_LPI_RECEIVED_value = aData
        flag_tx_LPI_RECEIVED        = &H1
    End Property

    Property Get read_tx_LPI_RECEIVED
        read
        read_tx_LPI_RECEIVED = read_tx_LPI_RECEIVED_value
    End Property

    Property Let write_tx_LPI_RECEIVED(aData)
        set_tx_LPI_RECEIVED = aData
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

    Property Get get_RESERVED_ORDERED_SET_LH
        get_RESERVED_ORDERED_SET_LH = read_RESERVED_ORDERED_SET_LH_value
    End Property

    Property Let set_RESERVED_ORDERED_SET_LH(aData)
        write_RESERVED_ORDERED_SET_LH_value = aData
        flag_RESERVED_ORDERED_SET_LH        = &H1
    End Property

    Property Get read_RESERVED_ORDERED_SET_LH
        read
        read_RESERVED_ORDERED_SET_LH = read_RESERVED_ORDERED_SET_LH_value
    End Property

    Property Let write_RESERVED_ORDERED_SET_LH(aData)
        set_RESERVED_ORDERED_SET_LH = aData
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
        read_tx_gbox_afrst_stky_value = rightShift(data_low, 11) and &H1
        read_TGOEDL_value = rightShift(data_low, 10) and &H1
        read_TGUEDL_value = rightShift(data_low, 9) and &H1
        read_tx_LOCAL_FAULT_value = rightShift(data_low, 8) and &H1
        read_tx_REMOTE_FAULT_value = rightShift(data_low, 7) and &H1
        read_tx_LINK_INTERRUPT_value = rightShift(data_low, 6) and &H1
        read_tx_LPI_RECEIVED_value = rightShift(data_low, 5) and &H1
        read_LINK_INTERRUPT_LH_value = rightShift(data_low, 4) and &H1
        read_LOCAL_FAULT_LH_value = rightShift(data_low, 3) and &H1
        read_REMOTE_FAULT_LH_value = rightShift(data_low, 2) and &H1
        read_RESERVED_ORDERED_SET_LH_value = rightShift(data_low, 1) and &H1
        LPI_RECEIVED_LH_mask = &H1
        if data_low > LONG_MAX then
            if LPI_RECEIVED_LH_mask = mask then
                read_LPI_RECEIVED_LH_value = data_low
            else
                read_LPI_RECEIVED_LH_value = (data_low - H8000_0000) and LPI_RECEIVED_LH_mask
            end If
        else
            read_LPI_RECEIVED_LH_value = data_low and LPI_RECEIVED_LH_mask
        end If

    End Sub

    Sub write
        If flag_tx_gbox_afrst_stky = &H0 or flag_TGOEDL = &H0 or flag_TGUEDL = &H0 or flag_tx_LOCAL_FAULT = &H0 or flag_tx_REMOTE_FAULT = &H0 or flag_tx_LINK_INTERRUPT = &H0 or flag_tx_LPI_RECEIVED = &H0 or flag_LINK_INTERRUPT_LH = &H0 or flag_LOCAL_FAULT_LH = &H0 or flag_REMOTE_FAULT_LH = &H0 or flag_RESERVED_ORDERED_SET_LH = &H0 or flag_LPI_RECEIVED_LH = &H0 Then read
        If flag_tx_gbox_afrst_stky = &H0 Then write_tx_gbox_afrst_stky_value = get_tx_gbox_afrst_stky
        If flag_TGOEDL = &H0 Then write_TGOEDL_value = get_TGOEDL
        If flag_TGUEDL = &H0 Then write_TGUEDL_value = get_TGUEDL
        If flag_tx_LOCAL_FAULT = &H0 Then write_tx_LOCAL_FAULT_value = get_tx_LOCAL_FAULT
        If flag_tx_REMOTE_FAULT = &H0 Then write_tx_REMOTE_FAULT_value = get_tx_REMOTE_FAULT
        If flag_tx_LINK_INTERRUPT = &H0 Then write_tx_LINK_INTERRUPT_value = get_tx_LINK_INTERRUPT
        If flag_tx_LPI_RECEIVED = &H0 Then write_tx_LPI_RECEIVED_value = get_tx_LPI_RECEIVED
        If flag_LINK_INTERRUPT_LH = &H0 Then write_LINK_INTERRUPT_LH_value = get_LINK_INTERRUPT_LH
        If flag_LOCAL_FAULT_LH = &H0 Then write_LOCAL_FAULT_LH_value = get_LOCAL_FAULT_LH
        If flag_REMOTE_FAULT_LH = &H0 Then write_REMOTE_FAULT_LH_value = get_REMOTE_FAULT_LH
        If flag_RESERVED_ORDERED_SET_LH = &H0 Then write_RESERVED_ORDERED_SET_LH_value = get_RESERVED_ORDERED_SET_LH
        If flag_LPI_RECEIVED_LH = &H0 Then write_LPI_RECEIVED_LH_value = get_LPI_RECEIVED_LH

        regValue = leftShift((write_tx_gbox_afrst_stky_value and &H1), 11) + leftShift((write_TGOEDL_value and &H1), 10) + leftShift((write_TGUEDL_value and &H1), 9) + leftShift((write_tx_LOCAL_FAULT_value and &H1), 8) + leftShift((write_tx_REMOTE_FAULT_value and &H1), 7) + leftShift((write_tx_LINK_INTERRUPT_value and &H1), 6) + leftShift((write_tx_LPI_RECEIVED_value and &H1), 5) + leftShift((write_LINK_INTERRUPT_LH_value and &H1), 4) + leftShift((write_LOCAL_FAULT_LH_value and &H1), 3) + leftShift((write_REMOTE_FAULT_LH_value and &H1), 2) + leftShift((write_RESERVED_ORDERED_SET_LH_value and &H1), 1) + leftShift((write_LPI_RECEIVED_LH_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_tx_gbox_afrst_stky_value = rightShift(data_low, 11) and &H1
        read_TGOEDL_value = rightShift(data_low, 10) and &H1
        read_TGUEDL_value = rightShift(data_low, 9) and &H1
        read_tx_LOCAL_FAULT_value = rightShift(data_low, 8) and &H1
        read_tx_REMOTE_FAULT_value = rightShift(data_low, 7) and &H1
        read_tx_LINK_INTERRUPT_value = rightShift(data_low, 6) and &H1
        read_tx_LPI_RECEIVED_value = rightShift(data_low, 5) and &H1
        read_LINK_INTERRUPT_LH_value = rightShift(data_low, 4) and &H1
        read_LOCAL_FAULT_LH_value = rightShift(data_low, 3) and &H1
        read_REMOTE_FAULT_LH_value = rightShift(data_low, 2) and &H1
        read_RESERVED_ORDERED_SET_LH_value = rightShift(data_low, 1) and &H1
        LPI_RECEIVED_LH_mask = &H1
        if data_low > LONG_MAX then
            if LPI_RECEIVED_LH_mask = mask then
                read_LPI_RECEIVED_LH_value = data_low
            else
                read_LPI_RECEIVED_LH_value = (data_low - H8000_0000) and LPI_RECEIVED_LH_mask
            end If
        else
            read_LPI_RECEIVED_LH_value = data_low and LPI_RECEIVED_LH_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_tx_gbox_afrst_stky_value = &H0
        flag_tx_gbox_afrst_stky        = &H0
        write_TGOEDL_value = &H0
        flag_TGOEDL        = &H0
        write_TGUEDL_value = &H0
        flag_TGUEDL        = &H0
        write_tx_LOCAL_FAULT_value = &H0
        flag_tx_LOCAL_FAULT        = &H0
        write_tx_REMOTE_FAULT_value = &H0
        flag_tx_REMOTE_FAULT        = &H0
        write_tx_LINK_INTERRUPT_value = &H0
        flag_tx_LINK_INTERRUPT        = &H0
        write_tx_LPI_RECEIVED_value = &H0
        flag_tx_LPI_RECEIVED        = &H0
        write_LINK_INTERRUPT_LH_value = &H0
        flag_LINK_INTERRUPT_LH        = &H0
        write_LOCAL_FAULT_LH_value = &H0
        flag_LOCAL_FAULT_LH        = &H0
        write_REMOTE_FAULT_LH_value = &H0
        flag_REMOTE_FAULT_LH        = &H0
        write_RESERVED_ORDERED_SET_LH_value = &H0
        flag_RESERVED_ORDERED_SET_LH        = &H0
        write_LPI_RECEIVED_LH_value = &H0
        flag_LPI_RECEIVED_LH        = &H0
    End Sub
End Class


'' @REGISTER : TX_X4_STATUS0_SGMIIPLUSR_X1_cl127_word_encode_status_sgmiiplusr_x1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TWSICL                                     [7:7]            get_TWSICL
''                                                             set_TWSICL
''                                                             read_TWSICL
''                                                             write_TWSICL
''---------------------------------------------------------------------------------
'' TWSDCL                                     [6:6]            get_TWSDCL
''                                                             set_TWSDCL
''                                                             read_TWSDCL
''                                                             write_TWSDCL
''---------------------------------------------------------------------------------
'' TWSSCL                                     [5:5]            get_TWSSCL
''                                                             set_TWSSCL
''                                                             read_TWSSCL
''                                                             write_TWSSCL
''---------------------------------------------------------------------------------
'' TWSECL                                     [4:4]            get_TWSECL
''                                                             set_TWSECL
''                                                             read_TWSECL
''                                                             write_TWSECL
''---------------------------------------------------------------------------------
'' TWSICH                                     [3:3]            get_TWSICH
''                                                             set_TWSICH
''                                                             read_TWSICH
''                                                             write_TWSICH
''---------------------------------------------------------------------------------
'' TWSDCH                                     [2:2]            get_TWSDCH
''                                                             set_TWSDCH
''                                                             read_TWSDCH
''                                                             write_TWSDCH
''---------------------------------------------------------------------------------
'' TWSSCH                                     [1:1]            get_TWSSCH
''                                                             set_TWSSCH
''                                                             read_TWSSCH
''                                                             write_TWSSCH
''---------------------------------------------------------------------------------
'' TWSECH                                     [0:0]            get_TWSECH
''                                                             set_TWSECH
''                                                             read_TWSECH
''                                                             write_TWSECH
''---------------------------------------------------------------------------------
Class REGISTER_TX_X4_STATUS0_SGMIIPLUSR_X1_cl127_word_encode_status_sgmiiplusr_x1
    Private write_TWSICL_value
    Private read_TWSICL_value
    Private flag_TWSICL
    Private write_TWSDCL_value
    Private read_TWSDCL_value
    Private flag_TWSDCL
    Private write_TWSSCL_value
    Private read_TWSSCL_value
    Private flag_TWSSCL
    Private write_TWSECL_value
    Private read_TWSECL_value
    Private flag_TWSECL
    Private write_TWSICH_value
    Private read_TWSICH_value
    Private flag_TWSICH
    Private write_TWSDCH_value
    Private read_TWSDCH_value
    Private flag_TWSDCH
    Private write_TWSSCH_value
    Private read_TWSSCH_value
    Private flag_TWSSCH
    Private write_TWSECH_value
    Private read_TWSECH_value
    Private flag_TWSECH

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

    Property Get get_TWSICL
        get_TWSICL = read_TWSICL_value
    End Property

    Property Let set_TWSICL(aData)
        write_TWSICL_value = aData
        flag_TWSICL        = &H1
    End Property

    Property Get read_TWSICL
        read
        read_TWSICL = read_TWSICL_value
    End Property

    Property Let write_TWSICL(aData)
        set_TWSICL = aData
        write
    End Property

    Property Get get_TWSDCL
        get_TWSDCL = read_TWSDCL_value
    End Property

    Property Let set_TWSDCL(aData)
        write_TWSDCL_value = aData
        flag_TWSDCL        = &H1
    End Property

    Property Get read_TWSDCL
        read
        read_TWSDCL = read_TWSDCL_value
    End Property

    Property Let write_TWSDCL(aData)
        set_TWSDCL = aData
        write
    End Property

    Property Get get_TWSSCL
        get_TWSSCL = read_TWSSCL_value
    End Property

    Property Let set_TWSSCL(aData)
        write_TWSSCL_value = aData
        flag_TWSSCL        = &H1
    End Property

    Property Get read_TWSSCL
        read
        read_TWSSCL = read_TWSSCL_value
    End Property

    Property Let write_TWSSCL(aData)
        set_TWSSCL = aData
        write
    End Property

    Property Get get_TWSECL
        get_TWSECL = read_TWSECL_value
    End Property

    Property Let set_TWSECL(aData)
        write_TWSECL_value = aData
        flag_TWSECL        = &H1
    End Property

    Property Get read_TWSECL
        read
        read_TWSECL = read_TWSECL_value
    End Property

    Property Let write_TWSECL(aData)
        set_TWSECL = aData
        write
    End Property

    Property Get get_TWSICH
        get_TWSICH = read_TWSICH_value
    End Property

    Property Let set_TWSICH(aData)
        write_TWSICH_value = aData
        flag_TWSICH        = &H1
    End Property

    Property Get read_TWSICH
        read
        read_TWSICH = read_TWSICH_value
    End Property

    Property Let write_TWSICH(aData)
        set_TWSICH = aData
        write
    End Property

    Property Get get_TWSDCH
        get_TWSDCH = read_TWSDCH_value
    End Property

    Property Let set_TWSDCH(aData)
        write_TWSDCH_value = aData
        flag_TWSDCH        = &H1
    End Property

    Property Get read_TWSDCH
        read
        read_TWSDCH = read_TWSDCH_value
    End Property

    Property Let write_TWSDCH(aData)
        set_TWSDCH = aData
        write
    End Property

    Property Get get_TWSSCH
        get_TWSSCH = read_TWSSCH_value
    End Property

    Property Let set_TWSSCH(aData)
        write_TWSSCH_value = aData
        flag_TWSSCH        = &H1
    End Property

    Property Get read_TWSSCH
        read
        read_TWSSCH = read_TWSSCH_value
    End Property

    Property Let write_TWSSCH(aData)
        set_TWSSCH = aData
        write
    End Property

    Property Get get_TWSECH
        get_TWSECH = read_TWSECH_value
    End Property

    Property Let set_TWSECH(aData)
        write_TWSECH_value = aData
        flag_TWSECH        = &H1
    End Property

    Property Get read_TWSECH
        read
        read_TWSECH = read_TWSECH_value
    End Property

    Property Let write_TWSECH(aData)
        set_TWSECH = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TWSICL_value = rightShift(data_low, 7) and &H1
        read_TWSDCL_value = rightShift(data_low, 6) and &H1
        read_TWSSCL_value = rightShift(data_low, 5) and &H1
        read_TWSECL_value = rightShift(data_low, 4) and &H1
        read_TWSICH_value = rightShift(data_low, 3) and &H1
        read_TWSDCH_value = rightShift(data_low, 2) and &H1
        read_TWSSCH_value = rightShift(data_low, 1) and &H1
        TWSECH_mask = &H1
        if data_low > LONG_MAX then
            if TWSECH_mask = mask then
                read_TWSECH_value = data_low
            else
                read_TWSECH_value = (data_low - H8000_0000) and TWSECH_mask
            end If
        else
            read_TWSECH_value = data_low and TWSECH_mask
        end If

    End Sub

    Sub write
        If flag_TWSICL = &H0 or flag_TWSDCL = &H0 or flag_TWSSCL = &H0 or flag_TWSECL = &H0 or flag_TWSICH = &H0 or flag_TWSDCH = &H0 or flag_TWSSCH = &H0 or flag_TWSECH = &H0 Then read
        If flag_TWSICL = &H0 Then write_TWSICL_value = get_TWSICL
        If flag_TWSDCL = &H0 Then write_TWSDCL_value = get_TWSDCL
        If flag_TWSSCL = &H0 Then write_TWSSCL_value = get_TWSSCL
        If flag_TWSECL = &H0 Then write_TWSECL_value = get_TWSECL
        If flag_TWSICH = &H0 Then write_TWSICH_value = get_TWSICH
        If flag_TWSDCH = &H0 Then write_TWSDCH_value = get_TWSDCH
        If flag_TWSSCH = &H0 Then write_TWSSCH_value = get_TWSSCH
        If flag_TWSECH = &H0 Then write_TWSECH_value = get_TWSECH

        regValue = leftShift((write_TWSICL_value and &H1), 7) + leftShift((write_TWSDCL_value and &H1), 6) + leftShift((write_TWSSCL_value and &H1), 5) + leftShift((write_TWSECL_value and &H1), 4) + leftShift((write_TWSICH_value and &H1), 3) + leftShift((write_TWSDCH_value and &H1), 2) + leftShift((write_TWSSCH_value and &H1), 1) + leftShift((write_TWSECH_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TWSICL_value = rightShift(data_low, 7) and &H1
        read_TWSDCL_value = rightShift(data_low, 6) and &H1
        read_TWSSCL_value = rightShift(data_low, 5) and &H1
        read_TWSECL_value = rightShift(data_low, 4) and &H1
        read_TWSICH_value = rightShift(data_low, 3) and &H1
        read_TWSDCH_value = rightShift(data_low, 2) and &H1
        read_TWSSCH_value = rightShift(data_low, 1) and &H1
        TWSECH_mask = &H1
        if data_low > LONG_MAX then
            if TWSECH_mask = mask then
                read_TWSECH_value = data_low
            else
                read_TWSECH_value = (data_low - H8000_0000) and TWSECH_mask
            end If
        else
            read_TWSECH_value = data_low and TWSECH_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TWSICL_value = &H0
        flag_TWSICL        = &H0
        write_TWSDCL_value = &H0
        flag_TWSDCL        = &H0
        write_TWSSCL_value = &H0
        flag_TWSSCL        = &H0
        write_TWSECL_value = &H0
        flag_TWSECL        = &H0
        write_TWSICH_value = &H0
        flag_TWSICH        = &H0
        write_TWSDCH_value = &H0
        flag_TWSDCH        = &H0
        write_TWSSCH_value = &H0
        flag_TWSSCH        = &H0
        write_TWSECH_value = &H0
        flag_TWSECH        = &H0
    End Sub
End Class


'' @REGISTER : TX_X4_STATUS0_SGMIIPLUSR_X1_blockaddress
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
Class REGISTER_TX_X4_STATUS0_SGMIIPLUSR_X1_blockaddress
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

Class TX_X4_STATUS0_SGMIIPLUSR_X1_INSTANCE

    Public encode_status_0
    Public pcs_status_sgmiiplusr_x1
    Public cl127_word_encode_status_sgmiiplusr_x1
    Public blockaddress


    Public default function Init(aBaseAddr)
        Set encode_status_0 = (New REGISTER_TX_X4_STATUS0_SGMIIPLUSR_X1_encode_status_0)(aBaseAddr, 16)
        Set pcs_status_sgmiiplusr_x1 = (New REGISTER_TX_X4_STATUS0_SGMIIPLUSR_X1_pcs_status_sgmiiplusr_x1)(aBaseAddr, 16)
        Set cl127_word_encode_status_sgmiiplusr_x1 = (New REGISTER_TX_X4_STATUS0_SGMIIPLUSR_X1_cl127_word_encode_status_sgmiiplusr_x1)(aBaseAddr, 16)
        Set blockaddress = (New REGISTER_TX_X4_STATUS0_SGMIIPLUSR_X1_blockaddress)(aBaseAddr, 16)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set TX_X4_STATUS0_SGMIIPLUSR_X1 = CreateObject("System.Collections.ArrayList")
TX_X4_STATUS0_SGMIIPLUSR_X1.Add ((New TX_X4_STATUS0_SGMIIPLUSR_X1_INSTANCE)(&H4aed8880))


