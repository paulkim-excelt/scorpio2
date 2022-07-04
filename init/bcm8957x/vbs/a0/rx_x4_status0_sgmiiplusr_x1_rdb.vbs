

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


'' @REGISTER : RX_X4_STATUS0_SGMIIPLUSR_X1_barrel_shifter_state_sgmiiplusr_x1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' shift_ammount                              [7:0]            get_shift_ammount
''                                                             set_shift_ammount
''                                                             read_shift_ammount
''                                                             write_shift_ammount
''---------------------------------------------------------------------------------
Class REGISTER_RX_X4_STATUS0_SGMIIPLUSR_X1_barrel_shifter_state_sgmiiplusr_x1
    Private write_shift_ammount_value
    Private read_shift_ammount_value
    Private flag_shift_ammount

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

    Property Get get_shift_ammount
        get_shift_ammount = read_shift_ammount_value
    End Property

    Property Let set_shift_ammount(aData)
        write_shift_ammount_value = aData
        flag_shift_ammount        = &H1
    End Property

    Property Get read_shift_ammount
        read
        read_shift_ammount = read_shift_ammount_value
    End Property

    Property Let write_shift_ammount(aData)
        set_shift_ammount = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        shift_ammount_mask = &Hff
        if data_low > LONG_MAX then
            if shift_ammount_mask = mask then
                read_shift_ammount_value = data_low
            else
                read_shift_ammount_value = (data_low - H8000_0000) and shift_ammount_mask
            end If
        else
            read_shift_ammount_value = data_low and shift_ammount_mask
        end If

    End Sub

    Sub write
        If flag_shift_ammount = &H0 Then read
        If flag_shift_ammount = &H0 Then write_shift_ammount_value = get_shift_ammount

        regValue = leftShift((write_shift_ammount_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        shift_ammount_mask = &Hff
        if data_low > LONG_MAX then
            if shift_ammount_mask = mask then
                read_shift_ammount_value = data_low
            else
                read_shift_ammount_value = (data_low - H8000_0000) and shift_ammount_mask
            end If
        else
            read_shift_ammount_value = data_low and shift_ammount_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_shift_ammount_value = &H0
        flag_shift_ammount        = &H0
    End Sub
End Class


'' @REGISTER : RX_X4_STATUS0_SGMIIPLUSR_X1_cl49_lock_fsm_status
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' lsm_his_state                              [4:2]            get_lsm_his_state
''                                                             set_lsm_his_state
''                                                             read_lsm_his_state
''                                                             write_lsm_his_state
''---------------------------------------------------------------------------------
'' lsm_curr_state                             [1:0]            get_lsm_curr_state
''                                                             set_lsm_curr_state
''                                                             read_lsm_curr_state
''                                                             write_lsm_curr_state
''---------------------------------------------------------------------------------
Class REGISTER_RX_X4_STATUS0_SGMIIPLUSR_X1_cl49_lock_fsm_status
    Private write_lsm_his_state_value
    Private read_lsm_his_state_value
    Private flag_lsm_his_state
    Private write_lsm_curr_state_value
    Private read_lsm_curr_state_value
    Private flag_lsm_curr_state

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

    Property Get get_lsm_his_state
        get_lsm_his_state = read_lsm_his_state_value
    End Property

    Property Let set_lsm_his_state(aData)
        write_lsm_his_state_value = aData
        flag_lsm_his_state        = &H1
    End Property

    Property Get read_lsm_his_state
        read
        read_lsm_his_state = read_lsm_his_state_value
    End Property

    Property Let write_lsm_his_state(aData)
        set_lsm_his_state = aData
        write
    End Property

    Property Get get_lsm_curr_state
        get_lsm_curr_state = read_lsm_curr_state_value
    End Property

    Property Let set_lsm_curr_state(aData)
        write_lsm_curr_state_value = aData
        flag_lsm_curr_state        = &H1
    End Property

    Property Get read_lsm_curr_state
        read
        read_lsm_curr_state = read_lsm_curr_state_value
    End Property

    Property Let write_lsm_curr_state(aData)
        set_lsm_curr_state = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_lsm_his_state_value = rightShift(data_low, 2) and &H7
        lsm_curr_state_mask = &H3
        if data_low > LONG_MAX then
            if lsm_curr_state_mask = mask then
                read_lsm_curr_state_value = data_low
            else
                read_lsm_curr_state_value = (data_low - H8000_0000) and lsm_curr_state_mask
            end If
        else
            read_lsm_curr_state_value = data_low and lsm_curr_state_mask
        end If

    End Sub

    Sub write
        If flag_lsm_his_state = &H0 or flag_lsm_curr_state = &H0 Then read
        If flag_lsm_his_state = &H0 Then write_lsm_his_state_value = get_lsm_his_state
        If flag_lsm_curr_state = &H0 Then write_lsm_curr_state_value = get_lsm_curr_state

        regValue = leftShift((write_lsm_his_state_value and &H7), 2) + leftShift((write_lsm_curr_state_value and &H3), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_lsm_his_state_value = rightShift(data_low, 2) and &H7
        lsm_curr_state_mask = &H3
        if data_low > LONG_MAX then
            if lsm_curr_state_mask = mask then
                read_lsm_curr_state_value = data_low
            else
                read_lsm_curr_state_value = (data_low - H8000_0000) and lsm_curr_state_mask
            end If
        else
            read_lsm_curr_state_value = data_low and lsm_curr_state_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_lsm_his_state_value = &H0
        flag_lsm_his_state        = &H0
        write_lsm_curr_state_value = &H0
        flag_lsm_curr_state        = &H0
    End Sub
End Class


'' @REGISTER : RX_X4_STATUS0_SGMIIPLUSR_X1_decode_status_0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' cl49_r_type_coded                          [15:12]          get_cl49_r_type_coded
''                                                             set_cl49_r_type_coded
''                                                             read_cl49_r_type_coded
''                                                             write_cl49_r_type_coded
''---------------------------------------------------------------------------------
'' C49RHS                                     [10:3]           get_C49RHS
''                                                             set_C49RHS
''                                                             read_C49RHS
''                                                             write_C49RHS
''---------------------------------------------------------------------------------
'' C49RCS                                     [2:0]            get_C49RCS
''                                                             set_C49RCS
''                                                             read_C49RCS
''                                                             write_C49RCS
''---------------------------------------------------------------------------------
Class REGISTER_RX_X4_STATUS0_SGMIIPLUSR_X1_decode_status_0
    Private write_cl49_r_type_coded_value
    Private read_cl49_r_type_coded_value
    Private flag_cl49_r_type_coded
    Private write_C49RHS_value
    Private read_C49RHS_value
    Private flag_C49RHS
    Private write_C49RCS_value
    Private read_C49RCS_value
    Private flag_C49RCS

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

    Property Get get_cl49_r_type_coded
        get_cl49_r_type_coded = read_cl49_r_type_coded_value
    End Property

    Property Let set_cl49_r_type_coded(aData)
        write_cl49_r_type_coded_value = aData
        flag_cl49_r_type_coded        = &H1
    End Property

    Property Get read_cl49_r_type_coded
        read
        read_cl49_r_type_coded = read_cl49_r_type_coded_value
    End Property

    Property Let write_cl49_r_type_coded(aData)
        set_cl49_r_type_coded = aData
        write
    End Property

    Property Get get_C49RHS
        get_C49RHS = read_C49RHS_value
    End Property

    Property Let set_C49RHS(aData)
        write_C49RHS_value = aData
        flag_C49RHS        = &H1
    End Property

    Property Get read_C49RHS
        read
        read_C49RHS = read_C49RHS_value
    End Property

    Property Let write_C49RHS(aData)
        set_C49RHS = aData
        write
    End Property

    Property Get get_C49RCS
        get_C49RCS = read_C49RCS_value
    End Property

    Property Let set_C49RCS(aData)
        write_C49RCS_value = aData
        flag_C49RCS        = &H1
    End Property

    Property Get read_C49RCS
        read
        read_C49RCS = read_C49RCS_value
    End Property

    Property Let write_C49RCS(aData)
        set_C49RCS = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_cl49_r_type_coded_value = rightShift(data_low, 12) and &Hf
        read_C49RHS_value = rightShift(data_low, 3) and &Hff
        C49RCS_mask = &H7
        if data_low > LONG_MAX then
            if C49RCS_mask = mask then
                read_C49RCS_value = data_low
            else
                read_C49RCS_value = (data_low - H8000_0000) and C49RCS_mask
            end If
        else
            read_C49RCS_value = data_low and C49RCS_mask
        end If

    End Sub

    Sub write
        If flag_cl49_r_type_coded = &H0 or flag_C49RHS = &H0 or flag_C49RCS = &H0 Then read
        If flag_cl49_r_type_coded = &H0 Then write_cl49_r_type_coded_value = get_cl49_r_type_coded
        If flag_C49RHS = &H0 Then write_C49RHS_value = get_C49RHS
        If flag_C49RCS = &H0 Then write_C49RCS_value = get_C49RCS

        regValue = leftShift((write_cl49_r_type_coded_value and &Hf), 12) + leftShift((write_C49RHS_value and &Hff), 3) + leftShift((write_C49RCS_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_cl49_r_type_coded_value = rightShift(data_low, 12) and &Hf
        read_C49RHS_value = rightShift(data_low, 3) and &Hff
        C49RCS_mask = &H7
        if data_low > LONG_MAX then
            if C49RCS_mask = mask then
                read_C49RCS_value = data_low
            else
                read_C49RCS_value = (data_low - H8000_0000) and C49RCS_mask
            end If
        else
            read_C49RCS_value = data_low and C49RCS_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_cl49_r_type_coded_value = &H0
        flag_cl49_r_type_coded        = &H0
        write_C49RHS_value = &H0
        flag_C49RHS        = &H0
        write_C49RCS_value = &H0
        flag_C49RCS        = &H0
    End Sub
End Class


'' @REGISTER : RX_X4_STATUS0_SGMIIPLUSR_X1_decode_status_1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' C49BHS                                     [9:5]            get_C49BHS
''                                                             set_C49BHS
''                                                             read_C49BHS
''                                                             write_C49BHS
''---------------------------------------------------------------------------------
'' C49BCS                                     [4:0]            get_C49BCS
''                                                             set_C49BCS
''                                                             read_C49BCS
''                                                             write_C49BCS
''---------------------------------------------------------------------------------
Class REGISTER_RX_X4_STATUS0_SGMIIPLUSR_X1_decode_status_1
    Private write_C49BHS_value
    Private read_C49BHS_value
    Private flag_C49BHS
    Private write_C49BCS_value
    Private read_C49BCS_value
    Private flag_C49BCS

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &He
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_C49BHS
        get_C49BHS = read_C49BHS_value
    End Property

    Property Let set_C49BHS(aData)
        write_C49BHS_value = aData
        flag_C49BHS        = &H1
    End Property

    Property Get read_C49BHS
        read
        read_C49BHS = read_C49BHS_value
    End Property

    Property Let write_C49BHS(aData)
        set_C49BHS = aData
        write
    End Property

    Property Get get_C49BCS
        get_C49BCS = read_C49BCS_value
    End Property

    Property Let set_C49BCS(aData)
        write_C49BCS_value = aData
        flag_C49BCS        = &H1
    End Property

    Property Get read_C49BCS
        read
        read_C49BCS = read_C49BCS_value
    End Property

    Property Let write_C49BCS(aData)
        set_C49BCS = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_C49BHS_value = rightShift(data_low, 5) and &H1f
        C49BCS_mask = &H1f
        if data_low > LONG_MAX then
            if C49BCS_mask = mask then
                read_C49BCS_value = data_low
            else
                read_C49BCS_value = (data_low - H8000_0000) and C49BCS_mask
            end If
        else
            read_C49BCS_value = data_low and C49BCS_mask
        end If

    End Sub

    Sub write
        If flag_C49BHS = &H0 or flag_C49BCS = &H0 Then read
        If flag_C49BHS = &H0 Then write_C49BHS_value = get_C49BHS
        If flag_C49BCS = &H0 Then write_C49BCS_value = get_C49BCS

        regValue = leftShift((write_C49BHS_value and &H1f), 5) + leftShift((write_C49BCS_value and &H1f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_C49BHS_value = rightShift(data_low, 5) and &H1f
        C49BCS_mask = &H1f
        if data_low > LONG_MAX then
            if C49BCS_mask = mask then
                read_C49BCS_value = data_low
            else
                read_C49BCS_value = (data_low - H8000_0000) and C49BCS_mask
            end If
        else
            read_C49BCS_value = data_low and C49BCS_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_C49BHS_value = &H0
        flag_C49BHS        = &H0
        write_C49BCS_value = &H0
        flag_C49BCS        = &H0
    End Sub
End Class


'' @REGISTER : RX_X4_STATUS0_SGMIIPLUSR_X1_decode_status_2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' sync66ErrCount                             [15:8]           get_sync66ErrCount
''                                                             set_sync66ErrCount
''                                                             read_sync66ErrCount
''                                                             write_sync66ErrCount
''---------------------------------------------------------------------------------
'' kcode66ErrCount                            [7:0]            get_kcode66ErrCount
''                                                             set_kcode66ErrCount
''                                                             read_kcode66ErrCount
''                                                             write_kcode66ErrCount
''---------------------------------------------------------------------------------
Class REGISTER_RX_X4_STATUS0_SGMIIPLUSR_X1_decode_status_2
    Private write_sync66ErrCount_value
    Private read_sync66ErrCount_value
    Private flag_sync66ErrCount
    Private write_kcode66ErrCount_value
    Private read_kcode66ErrCount_value
    Private flag_kcode66ErrCount

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H10
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_sync66ErrCount
        get_sync66ErrCount = read_sync66ErrCount_value
    End Property

    Property Let set_sync66ErrCount(aData)
        write_sync66ErrCount_value = aData
        flag_sync66ErrCount        = &H1
    End Property

    Property Get read_sync66ErrCount
        read
        read_sync66ErrCount = read_sync66ErrCount_value
    End Property

    Property Let write_sync66ErrCount(aData)
        set_sync66ErrCount = aData
        write
    End Property

    Property Get get_kcode66ErrCount
        get_kcode66ErrCount = read_kcode66ErrCount_value
    End Property

    Property Let set_kcode66ErrCount(aData)
        write_kcode66ErrCount_value = aData
        flag_kcode66ErrCount        = &H1
    End Property

    Property Get read_kcode66ErrCount
        read
        read_kcode66ErrCount = read_kcode66ErrCount_value
    End Property

    Property Let write_kcode66ErrCount(aData)
        set_kcode66ErrCount = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_sync66ErrCount_value = rightShift(data_low, 8) and &Hff
        kcode66ErrCount_mask = &Hff
        if data_low > LONG_MAX then
            if kcode66ErrCount_mask = mask then
                read_kcode66ErrCount_value = data_low
            else
                read_kcode66ErrCount_value = (data_low - H8000_0000) and kcode66ErrCount_mask
            end If
        else
            read_kcode66ErrCount_value = data_low and kcode66ErrCount_mask
        end If

    End Sub

    Sub write
        If flag_sync66ErrCount = &H0 or flag_kcode66ErrCount = &H0 Then read
        If flag_sync66ErrCount = &H0 Then write_sync66ErrCount_value = get_sync66ErrCount
        If flag_kcode66ErrCount = &H0 Then write_kcode66ErrCount_value = get_kcode66ErrCount

        regValue = leftShift((write_sync66ErrCount_value and &Hff), 8) + leftShift((write_kcode66ErrCount_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_sync66ErrCount_value = rightShift(data_low, 8) and &Hff
        kcode66ErrCount_mask = &Hff
        if data_low > LONG_MAX then
            if kcode66ErrCount_mask = mask then
                read_kcode66ErrCount_value = data_low
            else
                read_kcode66ErrCount_value = (data_low - H8000_0000) and kcode66ErrCount_mask
            end If
        else
            read_kcode66ErrCount_value = data_low and kcode66ErrCount_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_sync66ErrCount_value = &H0
        flag_sync66ErrCount        = &H0
        write_kcode66ErrCount_value = &H0
        flag_kcode66ErrCount        = &H0
    End Sub
End Class


'' @REGISTER : RX_X4_STATUS0_SGMIIPLUSR_X1_decode_status_3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' RGOEDL                                     [11:11]          get_RGOEDL
''                                                             set_RGOEDL
''                                                             read_RGOEDL
''                                                             write_RGOEDL
''---------------------------------------------------------------------------------
'' RGUEDL                                     [10:10]          get_RGUEDL
''                                                             set_RGUEDL
''                                                             read_RGUEDL
''                                                             write_RGUEDL
''---------------------------------------------------------------------------------
'' C49EB                                      [9:2]            get_C49EB
''                                                             set_C49EB
''                                                             read_C49EB
''                                                             write_C49EB
''---------------------------------------------------------------------------------
Class REGISTER_RX_X4_STATUS0_SGMIIPLUSR_X1_decode_status_3
    Private write_RGOEDL_value
    Private read_RGOEDL_value
    Private flag_RGOEDL
    Private write_RGUEDL_value
    Private read_RGUEDL_value
    Private flag_RGUEDL
    Private write_C49EB_value
    Private read_C49EB_value
    Private flag_C49EB

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H12
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_RGOEDL
        get_RGOEDL = read_RGOEDL_value
    End Property

    Property Let set_RGOEDL(aData)
        write_RGOEDL_value = aData
        flag_RGOEDL        = &H1
    End Property

    Property Get read_RGOEDL
        read
        read_RGOEDL = read_RGOEDL_value
    End Property

    Property Let write_RGOEDL(aData)
        set_RGOEDL = aData
        write
    End Property

    Property Get get_RGUEDL
        get_RGUEDL = read_RGUEDL_value
    End Property

    Property Let set_RGUEDL(aData)
        write_RGUEDL_value = aData
        flag_RGUEDL        = &H1
    End Property

    Property Get read_RGUEDL
        read
        read_RGUEDL = read_RGUEDL_value
    End Property

    Property Let write_RGUEDL(aData)
        set_RGUEDL = aData
        write
    End Property

    Property Get get_C49EB
        get_C49EB = read_C49EB_value
    End Property

    Property Let set_C49EB(aData)
        write_C49EB_value = aData
        flag_C49EB        = &H1
    End Property

    Property Get read_C49EB
        read
        read_C49EB = read_C49EB_value
    End Property

    Property Let write_C49EB(aData)
        set_C49EB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_RGOEDL_value = rightShift(data_low, 11) and &H1
        read_RGUEDL_value = rightShift(data_low, 10) and &H1
        read_C49EB_value = rightShift(data_low, 2) and &Hff

    End Sub

    Sub write
        If flag_RGOEDL = &H0 or flag_RGUEDL = &H0 or flag_C49EB = &H0 Then read
        If flag_RGOEDL = &H0 Then write_RGOEDL_value = get_RGOEDL
        If flag_RGUEDL = &H0 Then write_RGUEDL_value = get_RGUEDL
        If flag_C49EB = &H0 Then write_C49EB_value = get_C49EB

        regValue = leftShift((write_RGOEDL_value and &H1), 11) + leftShift((write_RGUEDL_value and &H1), 10) + leftShift((write_C49EB_value and &Hff), 2)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_RGOEDL_value = rightShift(data_low, 11) and &H1
        read_RGUEDL_value = rightShift(data_low, 10) and &H1
        read_C49EB_value = rightShift(data_low, 2) and &Hff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_RGOEDL_value = &H0
        flag_RGOEDL        = &H0
        write_RGUEDL_value = &H0
        flag_RGUEDL        = &H0
        write_C49EB_value = &H0
        flag_C49EB        = &H0
    End Sub
End Class


'' @REGISTER : RX_X4_STATUS0_SGMIIPLUSR_X1_syncacq_status_0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' C36SSCPL                                   [3:0]            get_C36SSCPL
''                                                             set_C36SSCPL
''                                                             read_C36SSCPL
''                                                             write_C36SSCPL
''---------------------------------------------------------------------------------
Class REGISTER_RX_X4_STATUS0_SGMIIPLUSR_X1_syncacq_status_0
    Private write_C36SSCPL_value
    Private read_C36SSCPL_value
    Private flag_C36SSCPL

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_C36SSCPL
        get_C36SSCPL = read_C36SSCPL_value
    End Property

    Property Let set_C36SSCPL(aData)
        write_C36SSCPL_value = aData
        flag_C36SSCPL        = &H1
    End Property

    Property Get read_C36SSCPL
        read
        read_C36SSCPL = read_C36SSCPL_value
    End Property

    Property Let write_C36SSCPL(aData)
        set_C36SSCPL = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        C36SSCPL_mask = &Hf
        if data_low > LONG_MAX then
            if C36SSCPL_mask = mask then
                read_C36SSCPL_value = data_low
            else
                read_C36SSCPL_value = (data_low - H8000_0000) and C36SSCPL_mask
            end If
        else
            read_C36SSCPL_value = data_low and C36SSCPL_mask
        end If

    End Sub

    Sub write
        If flag_C36SSCPL = &H0 Then read
        If flag_C36SSCPL = &H0 Then write_C36SSCPL_value = get_C36SSCPL

        regValue = leftShift((write_C36SSCPL_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        C36SSCPL_mask = &Hf
        if data_low > LONG_MAX then
            if C36SSCPL_mask = mask then
                read_C36SSCPL_value = data_low
            else
                read_C36SSCPL_value = (data_low - H8000_0000) and C36SSCPL_mask
            end If
        else
            read_C36SSCPL_value = data_low and C36SSCPL_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_C36SSCPL_value = &H0
        flag_C36SSCPL        = &H0
    End Sub
End Class


'' @REGISTER : RX_X4_STATUS0_SGMIIPLUSR_X1_syncacq_status_1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' C36SHSPL                                   [12:0]           get_C36SHSPL
''                                                             set_C36SHSPL
''                                                             read_C36SHSPL
''                                                             write_C36SHSPL
''---------------------------------------------------------------------------------
Class REGISTER_RX_X4_STATUS0_SGMIIPLUSR_X1_syncacq_status_1
    Private write_C36SHSPL_value
    Private read_C36SHSPL_value
    Private flag_C36SHSPL

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1a
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_C36SHSPL
        get_C36SHSPL = read_C36SHSPL_value
    End Property

    Property Let set_C36SHSPL(aData)
        write_C36SHSPL_value = aData
        flag_C36SHSPL        = &H1
    End Property

    Property Get read_C36SHSPL
        read
        read_C36SHSPL = read_C36SHSPL_value
    End Property

    Property Let write_C36SHSPL(aData)
        set_C36SHSPL = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        C36SHSPL_mask = &H1fff
        if data_low > LONG_MAX then
            if C36SHSPL_mask = mask then
                read_C36SHSPL_value = data_low
            else
                read_C36SHSPL_value = (data_low - H8000_0000) and C36SHSPL_mask
            end If
        else
            read_C36SHSPL_value = data_low and C36SHSPL_mask
        end If

    End Sub

    Sub write
        If flag_C36SHSPL = &H0 Then read
        If flag_C36SHSPL = &H0 Then write_C36SHSPL_value = get_C36SHSPL

        regValue = leftShift((write_C36SHSPL_value and &H1fff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        C36SHSPL_mask = &H1fff
        if data_low > LONG_MAX then
            if C36SHSPL_mask = mask then
                read_C36SHSPL_value = data_low
            else
                read_C36SHSPL_value = (data_low - H8000_0000) and C36SHSPL_mask
            end If
        else
            read_C36SHSPL_value = data_low and C36SHSPL_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_C36SHSPL_value = &H0
        flag_C36SHSPL        = &H0
    End Sub
End Class


'' @REGISTER : RX_X4_STATUS0_SGMIIPLUSR_X1_bercount
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' BER_count_per_ln                           [7:0]            get_BER_count_per_ln
''                                                             set_BER_count_per_ln
''                                                             read_BER_count_per_ln
''                                                             write_BER_count_per_ln
''---------------------------------------------------------------------------------
Class REGISTER_RX_X4_STATUS0_SGMIIPLUSR_X1_bercount
    Private write_BER_count_per_ln_value
    Private read_BER_count_per_ln_value
    Private flag_BER_count_per_ln

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_BER_count_per_ln
        get_BER_count_per_ln = read_BER_count_per_ln_value
    End Property

    Property Let set_BER_count_per_ln(aData)
        write_BER_count_per_ln_value = aData
        flag_BER_count_per_ln        = &H1
    End Property

    Property Get read_BER_count_per_ln
        read
        read_BER_count_per_ln = read_BER_count_per_ln_value
    End Property

    Property Let write_BER_count_per_ln(aData)
        set_BER_count_per_ln = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        BER_count_per_ln_mask = &Hff
        if data_low > LONG_MAX then
            if BER_count_per_ln_mask = mask then
                read_BER_count_per_ln_value = data_low
            else
                read_BER_count_per_ln_value = (data_low - H8000_0000) and BER_count_per_ln_mask
            end If
        else
            read_BER_count_per_ln_value = data_low and BER_count_per_ln_mask
        end If

    End Sub

    Sub write
        If flag_BER_count_per_ln = &H0 Then read
        If flag_BER_count_per_ln = &H0 Then write_BER_count_per_ln_value = get_BER_count_per_ln

        regValue = leftShift((write_BER_count_per_ln_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        BER_count_per_ln_mask = &Hff
        if data_low > LONG_MAX then
            if BER_count_per_ln_mask = mask then
                read_BER_count_per_ln_value = data_low
            else
                read_BER_count_per_ln_value = (data_low - H8000_0000) and BER_count_per_ln_mask
            end If
        else
            read_BER_count_per_ln_value = data_low and BER_count_per_ln_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_BER_count_per_ln_value = &H0
        flag_BER_count_per_ln        = &H0
    End Sub
End Class


'' @REGISTER : RX_X4_STATUS0_SGMIIPLUSR_X1_blockaddress
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
Class REGISTER_RX_X4_STATUS0_SGMIIPLUSR_X1_blockaddress
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

Class RX_X4_STATUS0_SGMIIPLUSR_X1_INSTANCE

    Public barrel_shifter_state_sgmiiplusr_x1
    Public cl49_lock_fsm_status
    Public decode_status_0
    Public decode_status_1
    Public decode_status_2
    Public decode_status_3
    Public syncacq_status_0
    Public syncacq_status_1
    Public bercount
    Public blockaddress


    Public default function Init(aBaseAddr)
        Set barrel_shifter_state_sgmiiplusr_x1 = (New REGISTER_RX_X4_STATUS0_SGMIIPLUSR_X1_barrel_shifter_state_sgmiiplusr_x1)(aBaseAddr, 16)
        Set cl49_lock_fsm_status = (New REGISTER_RX_X4_STATUS0_SGMIIPLUSR_X1_cl49_lock_fsm_status)(aBaseAddr, 16)
        Set decode_status_0 = (New REGISTER_RX_X4_STATUS0_SGMIIPLUSR_X1_decode_status_0)(aBaseAddr, 16)
        Set decode_status_1 = (New REGISTER_RX_X4_STATUS0_SGMIIPLUSR_X1_decode_status_1)(aBaseAddr, 16)
        Set decode_status_2 = (New REGISTER_RX_X4_STATUS0_SGMIIPLUSR_X1_decode_status_2)(aBaseAddr, 16)
        Set decode_status_3 = (New REGISTER_RX_X4_STATUS0_SGMIIPLUSR_X1_decode_status_3)(aBaseAddr, 16)
        Set syncacq_status_0 = (New REGISTER_RX_X4_STATUS0_SGMIIPLUSR_X1_syncacq_status_0)(aBaseAddr, 16)
        Set syncacq_status_1 = (New REGISTER_RX_X4_STATUS0_SGMIIPLUSR_X1_syncacq_status_1)(aBaseAddr, 16)
        Set bercount = (New REGISTER_RX_X4_STATUS0_SGMIIPLUSR_X1_bercount)(aBaseAddr, 16)
        Set blockaddress = (New REGISTER_RX_X4_STATUS0_SGMIIPLUSR_X1_blockaddress)(aBaseAddr, 16)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set RX_X4_STATUS0_SGMIIPLUSR_X1 = CreateObject("System.Collections.ArrayList")
RX_X4_STATUS0_SGMIIPLUSR_X1.Add ((New RX_X4_STATUS0_SGMIIPLUSR_X1_INSTANCE)(&H4aed88c0))


