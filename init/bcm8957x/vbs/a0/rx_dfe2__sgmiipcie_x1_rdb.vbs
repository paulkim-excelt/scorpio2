

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


'' @REGISTER : RX_DFE2__SGMIIPCIE_X1_slcalcontrol0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' cal_state_ovrd                             [15:15]          get_cal_state_ovrd
''                                                             set_cal_state_ovrd
''                                                             read_cal_state_ovrd
''                                                             write_cal_state_ovrd
''---------------------------------------------------------------------------------
'' slcal_en_ovrd                              [14:14]          get_slcal_en_ovrd
''                                                             set_slcal_en_ovrd
''                                                             read_slcal_en_ovrd
''                                                             write_slcal_en_ovrd
''---------------------------------------------------------------------------------
'' slcal_en_ovrd_val                          [13:13]          get_slcal_en_ovrd_val
''                                                             set_slcal_en_ovrd_val
''                                                             read_slcal_en_ovrd_val
''                                                             write_slcal_en_ovrd_val
''---------------------------------------------------------------------------------
'' slcal_acc_opt                              [12:11]          get_slcal_acc_opt
''                                                             set_slcal_acc_opt
''                                                             read_slcal_acc_opt
''                                                             write_slcal_acc_opt
''---------------------------------------------------------------------------------
'' slcal_pol                                  [10:10]          get_slcal_pol
''                                                             set_slcal_pol
''                                                             read_slcal_pol
''                                                             write_slcal_pol
''---------------------------------------------------------------------------------
'' slcal_settle_time                          [9:2]            get_slcal_settle_time
''                                                             set_slcal_settle_time
''                                                             read_slcal_settle_time
''                                                             write_slcal_settle_time
''---------------------------------------------------------------------------------
'' slcal_valid_ovrd                           [1:1]            get_slcal_valid_ovrd
''                                                             set_slcal_valid_ovrd
''                                                             read_slcal_valid_ovrd
''                                                             write_slcal_valid_ovrd
''---------------------------------------------------------------------------------
'' slcal_valid_ovrd_val                       [0:0]            get_slcal_valid_ovrd_val
''                                                             set_slcal_valid_ovrd_val
''                                                             read_slcal_valid_ovrd_val
''                                                             write_slcal_valid_ovrd_val
''---------------------------------------------------------------------------------
Class REGISTER_RX_DFE2__SGMIIPCIE_X1_slcalcontrol0
    Private write_cal_state_ovrd_value
    Private read_cal_state_ovrd_value
    Private flag_cal_state_ovrd
    Private write_slcal_en_ovrd_value
    Private read_slcal_en_ovrd_value
    Private flag_slcal_en_ovrd
    Private write_slcal_en_ovrd_val_value
    Private read_slcal_en_ovrd_val_value
    Private flag_slcal_en_ovrd_val
    Private write_slcal_acc_opt_value
    Private read_slcal_acc_opt_value
    Private flag_slcal_acc_opt
    Private write_slcal_pol_value
    Private read_slcal_pol_value
    Private flag_slcal_pol
    Private write_slcal_settle_time_value
    Private read_slcal_settle_time_value
    Private flag_slcal_settle_time
    Private write_slcal_valid_ovrd_value
    Private read_slcal_valid_ovrd_value
    Private flag_slcal_valid_ovrd
    Private write_slcal_valid_ovrd_val_value
    Private read_slcal_valid_ovrd_val_value
    Private flag_slcal_valid_ovrd_val

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

    Property Get get_cal_state_ovrd
        get_cal_state_ovrd = read_cal_state_ovrd_value
    End Property

    Property Let set_cal_state_ovrd(aData)
        write_cal_state_ovrd_value = aData
        flag_cal_state_ovrd        = &H1
    End Property

    Property Get read_cal_state_ovrd
        read
        read_cal_state_ovrd = read_cal_state_ovrd_value
    End Property

    Property Let write_cal_state_ovrd(aData)
        set_cal_state_ovrd = aData
        write
    End Property

    Property Get get_slcal_en_ovrd
        get_slcal_en_ovrd = read_slcal_en_ovrd_value
    End Property

    Property Let set_slcal_en_ovrd(aData)
        write_slcal_en_ovrd_value = aData
        flag_slcal_en_ovrd        = &H1
    End Property

    Property Get read_slcal_en_ovrd
        read
        read_slcal_en_ovrd = read_slcal_en_ovrd_value
    End Property

    Property Let write_slcal_en_ovrd(aData)
        set_slcal_en_ovrd = aData
        write
    End Property

    Property Get get_slcal_en_ovrd_val
        get_slcal_en_ovrd_val = read_slcal_en_ovrd_val_value
    End Property

    Property Let set_slcal_en_ovrd_val(aData)
        write_slcal_en_ovrd_val_value = aData
        flag_slcal_en_ovrd_val        = &H1
    End Property

    Property Get read_slcal_en_ovrd_val
        read
        read_slcal_en_ovrd_val = read_slcal_en_ovrd_val_value
    End Property

    Property Let write_slcal_en_ovrd_val(aData)
        set_slcal_en_ovrd_val = aData
        write
    End Property

    Property Get get_slcal_acc_opt
        get_slcal_acc_opt = read_slcal_acc_opt_value
    End Property

    Property Let set_slcal_acc_opt(aData)
        write_slcal_acc_opt_value = aData
        flag_slcal_acc_opt        = &H1
    End Property

    Property Get read_slcal_acc_opt
        read
        read_slcal_acc_opt = read_slcal_acc_opt_value
    End Property

    Property Let write_slcal_acc_opt(aData)
        set_slcal_acc_opt = aData
        write
    End Property

    Property Get get_slcal_pol
        get_slcal_pol = read_slcal_pol_value
    End Property

    Property Let set_slcal_pol(aData)
        write_slcal_pol_value = aData
        flag_slcal_pol        = &H1
    End Property

    Property Get read_slcal_pol
        read
        read_slcal_pol = read_slcal_pol_value
    End Property

    Property Let write_slcal_pol(aData)
        set_slcal_pol = aData
        write
    End Property

    Property Get get_slcal_settle_time
        get_slcal_settle_time = read_slcal_settle_time_value
    End Property

    Property Let set_slcal_settle_time(aData)
        write_slcal_settle_time_value = aData
        flag_slcal_settle_time        = &H1
    End Property

    Property Get read_slcal_settle_time
        read
        read_slcal_settle_time = read_slcal_settle_time_value
    End Property

    Property Let write_slcal_settle_time(aData)
        set_slcal_settle_time = aData
        write
    End Property

    Property Get get_slcal_valid_ovrd
        get_slcal_valid_ovrd = read_slcal_valid_ovrd_value
    End Property

    Property Let set_slcal_valid_ovrd(aData)
        write_slcal_valid_ovrd_value = aData
        flag_slcal_valid_ovrd        = &H1
    End Property

    Property Get read_slcal_valid_ovrd
        read
        read_slcal_valid_ovrd = read_slcal_valid_ovrd_value
    End Property

    Property Let write_slcal_valid_ovrd(aData)
        set_slcal_valid_ovrd = aData
        write
    End Property

    Property Get get_slcal_valid_ovrd_val
        get_slcal_valid_ovrd_val = read_slcal_valid_ovrd_val_value
    End Property

    Property Let set_slcal_valid_ovrd_val(aData)
        write_slcal_valid_ovrd_val_value = aData
        flag_slcal_valid_ovrd_val        = &H1
    End Property

    Property Get read_slcal_valid_ovrd_val
        read
        read_slcal_valid_ovrd_val = read_slcal_valid_ovrd_val_value
    End Property

    Property Let write_slcal_valid_ovrd_val(aData)
        set_slcal_valid_ovrd_val = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_cal_state_ovrd_value = rightShift(data_low, 15) and &H1
        read_slcal_en_ovrd_value = rightShift(data_low, 14) and &H1
        read_slcal_en_ovrd_val_value = rightShift(data_low, 13) and &H1
        read_slcal_acc_opt_value = rightShift(data_low, 11) and &H3
        read_slcal_pol_value = rightShift(data_low, 10) and &H1
        read_slcal_settle_time_value = rightShift(data_low, 2) and &Hff
        read_slcal_valid_ovrd_value = rightShift(data_low, 1) and &H1
        slcal_valid_ovrd_val_mask = &H1
        if data_low > LONG_MAX then
            if slcal_valid_ovrd_val_mask = mask then
                read_slcal_valid_ovrd_val_value = data_low
            else
                read_slcal_valid_ovrd_val_value = (data_low - H8000_0000) and slcal_valid_ovrd_val_mask
            end If
        else
            read_slcal_valid_ovrd_val_value = data_low and slcal_valid_ovrd_val_mask
        end If

    End Sub

    Sub write
        If flag_cal_state_ovrd = &H0 or flag_slcal_en_ovrd = &H0 or flag_slcal_en_ovrd_val = &H0 or flag_slcal_acc_opt = &H0 or flag_slcal_pol = &H0 or flag_slcal_settle_time = &H0 or flag_slcal_valid_ovrd = &H0 or flag_slcal_valid_ovrd_val = &H0 Then read
        If flag_cal_state_ovrd = &H0 Then write_cal_state_ovrd_value = get_cal_state_ovrd
        If flag_slcal_en_ovrd = &H0 Then write_slcal_en_ovrd_value = get_slcal_en_ovrd
        If flag_slcal_en_ovrd_val = &H0 Then write_slcal_en_ovrd_val_value = get_slcal_en_ovrd_val
        If flag_slcal_acc_opt = &H0 Then write_slcal_acc_opt_value = get_slcal_acc_opt
        If flag_slcal_pol = &H0 Then write_slcal_pol_value = get_slcal_pol
        If flag_slcal_settle_time = &H0 Then write_slcal_settle_time_value = get_slcal_settle_time
        If flag_slcal_valid_ovrd = &H0 Then write_slcal_valid_ovrd_value = get_slcal_valid_ovrd
        If flag_slcal_valid_ovrd_val = &H0 Then write_slcal_valid_ovrd_val_value = get_slcal_valid_ovrd_val

        regValue = leftShift((write_cal_state_ovrd_value and &H1), 15) + leftShift((write_slcal_en_ovrd_value and &H1), 14) + leftShift((write_slcal_en_ovrd_val_value and &H1), 13) + leftShift((write_slcal_acc_opt_value and &H3), 11) + leftShift((write_slcal_pol_value and &H1), 10) + leftShift((write_slcal_settle_time_value and &Hff), 2) + leftShift((write_slcal_valid_ovrd_value and &H1), 1) + leftShift((write_slcal_valid_ovrd_val_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_cal_state_ovrd_value = rightShift(data_low, 15) and &H1
        read_slcal_en_ovrd_value = rightShift(data_low, 14) and &H1
        read_slcal_en_ovrd_val_value = rightShift(data_low, 13) and &H1
        read_slcal_acc_opt_value = rightShift(data_low, 11) and &H3
        read_slcal_pol_value = rightShift(data_low, 10) and &H1
        read_slcal_settle_time_value = rightShift(data_low, 2) and &Hff
        read_slcal_valid_ovrd_value = rightShift(data_low, 1) and &H1
        slcal_valid_ovrd_val_mask = &H1
        if data_low > LONG_MAX then
            if slcal_valid_ovrd_val_mask = mask then
                read_slcal_valid_ovrd_val_value = data_low
            else
                read_slcal_valid_ovrd_val_value = (data_low - H8000_0000) and slcal_valid_ovrd_val_mask
            end If
        else
            read_slcal_valid_ovrd_val_value = data_low and slcal_valid_ovrd_val_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_cal_state_ovrd_value = &H0
        flag_cal_state_ovrd        = &H0
        write_slcal_en_ovrd_value = &H0
        flag_slcal_en_ovrd        = &H0
        write_slcal_en_ovrd_val_value = &H0
        flag_slcal_en_ovrd_val        = &H0
        write_slcal_acc_opt_value = &H0
        flag_slcal_acc_opt        = &H0
        write_slcal_pol_value = &H0
        flag_slcal_pol        = &H0
        write_slcal_settle_time_value = &H0
        flag_slcal_settle_time        = &H0
        write_slcal_valid_ovrd_value = &H0
        flag_slcal_valid_ovrd        = &H0
        write_slcal_valid_ovrd_val_value = &H0
        flag_slcal_valid_ovrd_val        = &H0
    End Sub
End Class


'' @REGISTER : RX_DFE2__SGMIIPCIE_X1_slcalcontrol1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' rx_sloff2_ovrd                             [14:14]          get_rx_sloff2_ovrd
''                                                             set_rx_sloff2_ovrd
''                                                             read_rx_sloff2_ovrd
''                                                             write_rx_sloff2_ovrd
''---------------------------------------------------------------------------------
'' rx_sloff2_ovrd_val                         [13:10]          get_rx_sloff2_ovrd_val
''                                                             set_rx_sloff2_ovrd_val
''                                                             read_rx_sloff2_ovrd_val
''                                                             write_rx_sloff2_ovrd_val
''---------------------------------------------------------------------------------
'' rx_sloff1_ovrd                             [9:9]            get_rx_sloff1_ovrd
''                                                             set_rx_sloff1_ovrd
''                                                             read_rx_sloff1_ovrd
''                                                             write_rx_sloff1_ovrd
''---------------------------------------------------------------------------------
'' rx_sloff1_ovrd_val                         [8:5]            get_rx_sloff1_ovrd_val
''                                                             set_rx_sloff1_ovrd_val
''                                                             read_rx_sloff1_ovrd_val
''                                                             write_rx_sloff1_ovrd_val
''---------------------------------------------------------------------------------
'' rx_sloff0_ovrd                             [4:4]            get_rx_sloff0_ovrd
''                                                             set_rx_sloff0_ovrd
''                                                             read_rx_sloff0_ovrd
''                                                             write_rx_sloff0_ovrd
''---------------------------------------------------------------------------------
'' rx_sloff0_ovrd_val                         [3:0]            get_rx_sloff0_ovrd_val
''                                                             set_rx_sloff0_ovrd_val
''                                                             read_rx_sloff0_ovrd_val
''                                                             write_rx_sloff0_ovrd_val
''---------------------------------------------------------------------------------
Class REGISTER_RX_DFE2__SGMIIPCIE_X1_slcalcontrol1
    Private write_rx_sloff2_ovrd_value
    Private read_rx_sloff2_ovrd_value
    Private flag_rx_sloff2_ovrd
    Private write_rx_sloff2_ovrd_val_value
    Private read_rx_sloff2_ovrd_val_value
    Private flag_rx_sloff2_ovrd_val
    Private write_rx_sloff1_ovrd_value
    Private read_rx_sloff1_ovrd_value
    Private flag_rx_sloff1_ovrd
    Private write_rx_sloff1_ovrd_val_value
    Private read_rx_sloff1_ovrd_val_value
    Private flag_rx_sloff1_ovrd_val
    Private write_rx_sloff0_ovrd_value
    Private read_rx_sloff0_ovrd_value
    Private flag_rx_sloff0_ovrd
    Private write_rx_sloff0_ovrd_val_value
    Private read_rx_sloff0_ovrd_val_value
    Private flag_rx_sloff0_ovrd_val

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

    Property Get get_rx_sloff2_ovrd
        get_rx_sloff2_ovrd = read_rx_sloff2_ovrd_value
    End Property

    Property Let set_rx_sloff2_ovrd(aData)
        write_rx_sloff2_ovrd_value = aData
        flag_rx_sloff2_ovrd        = &H1
    End Property

    Property Get read_rx_sloff2_ovrd
        read
        read_rx_sloff2_ovrd = read_rx_sloff2_ovrd_value
    End Property

    Property Let write_rx_sloff2_ovrd(aData)
        set_rx_sloff2_ovrd = aData
        write
    End Property

    Property Get get_rx_sloff2_ovrd_val
        get_rx_sloff2_ovrd_val = read_rx_sloff2_ovrd_val_value
    End Property

    Property Let set_rx_sloff2_ovrd_val(aData)
        write_rx_sloff2_ovrd_val_value = aData
        flag_rx_sloff2_ovrd_val        = &H1
    End Property

    Property Get read_rx_sloff2_ovrd_val
        read
        read_rx_sloff2_ovrd_val = read_rx_sloff2_ovrd_val_value
    End Property

    Property Let write_rx_sloff2_ovrd_val(aData)
        set_rx_sloff2_ovrd_val = aData
        write
    End Property

    Property Get get_rx_sloff1_ovrd
        get_rx_sloff1_ovrd = read_rx_sloff1_ovrd_value
    End Property

    Property Let set_rx_sloff1_ovrd(aData)
        write_rx_sloff1_ovrd_value = aData
        flag_rx_sloff1_ovrd        = &H1
    End Property

    Property Get read_rx_sloff1_ovrd
        read
        read_rx_sloff1_ovrd = read_rx_sloff1_ovrd_value
    End Property

    Property Let write_rx_sloff1_ovrd(aData)
        set_rx_sloff1_ovrd = aData
        write
    End Property

    Property Get get_rx_sloff1_ovrd_val
        get_rx_sloff1_ovrd_val = read_rx_sloff1_ovrd_val_value
    End Property

    Property Let set_rx_sloff1_ovrd_val(aData)
        write_rx_sloff1_ovrd_val_value = aData
        flag_rx_sloff1_ovrd_val        = &H1
    End Property

    Property Get read_rx_sloff1_ovrd_val
        read
        read_rx_sloff1_ovrd_val = read_rx_sloff1_ovrd_val_value
    End Property

    Property Let write_rx_sloff1_ovrd_val(aData)
        set_rx_sloff1_ovrd_val = aData
        write
    End Property

    Property Get get_rx_sloff0_ovrd
        get_rx_sloff0_ovrd = read_rx_sloff0_ovrd_value
    End Property

    Property Let set_rx_sloff0_ovrd(aData)
        write_rx_sloff0_ovrd_value = aData
        flag_rx_sloff0_ovrd        = &H1
    End Property

    Property Get read_rx_sloff0_ovrd
        read
        read_rx_sloff0_ovrd = read_rx_sloff0_ovrd_value
    End Property

    Property Let write_rx_sloff0_ovrd(aData)
        set_rx_sloff0_ovrd = aData
        write
    End Property

    Property Get get_rx_sloff0_ovrd_val
        get_rx_sloff0_ovrd_val = read_rx_sloff0_ovrd_val_value
    End Property

    Property Let set_rx_sloff0_ovrd_val(aData)
        write_rx_sloff0_ovrd_val_value = aData
        flag_rx_sloff0_ovrd_val        = &H1
    End Property

    Property Get read_rx_sloff0_ovrd_val
        read
        read_rx_sloff0_ovrd_val = read_rx_sloff0_ovrd_val_value
    End Property

    Property Let write_rx_sloff0_ovrd_val(aData)
        set_rx_sloff0_ovrd_val = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_rx_sloff2_ovrd_value = rightShift(data_low, 14) and &H1
        read_rx_sloff2_ovrd_val_value = rightShift(data_low, 10) and &Hf
        read_rx_sloff1_ovrd_value = rightShift(data_low, 9) and &H1
        read_rx_sloff1_ovrd_val_value = rightShift(data_low, 5) and &Hf
        read_rx_sloff0_ovrd_value = rightShift(data_low, 4) and &H1
        rx_sloff0_ovrd_val_mask = &Hf
        if data_low > LONG_MAX then
            if rx_sloff0_ovrd_val_mask = mask then
                read_rx_sloff0_ovrd_val_value = data_low
            else
                read_rx_sloff0_ovrd_val_value = (data_low - H8000_0000) and rx_sloff0_ovrd_val_mask
            end If
        else
            read_rx_sloff0_ovrd_val_value = data_low and rx_sloff0_ovrd_val_mask
        end If

    End Sub

    Sub write
        If flag_rx_sloff2_ovrd = &H0 or flag_rx_sloff2_ovrd_val = &H0 or flag_rx_sloff1_ovrd = &H0 or flag_rx_sloff1_ovrd_val = &H0 or flag_rx_sloff0_ovrd = &H0 or flag_rx_sloff0_ovrd_val = &H0 Then read
        If flag_rx_sloff2_ovrd = &H0 Then write_rx_sloff2_ovrd_value = get_rx_sloff2_ovrd
        If flag_rx_sloff2_ovrd_val = &H0 Then write_rx_sloff2_ovrd_val_value = get_rx_sloff2_ovrd_val
        If flag_rx_sloff1_ovrd = &H0 Then write_rx_sloff1_ovrd_value = get_rx_sloff1_ovrd
        If flag_rx_sloff1_ovrd_val = &H0 Then write_rx_sloff1_ovrd_val_value = get_rx_sloff1_ovrd_val
        If flag_rx_sloff0_ovrd = &H0 Then write_rx_sloff0_ovrd_value = get_rx_sloff0_ovrd
        If flag_rx_sloff0_ovrd_val = &H0 Then write_rx_sloff0_ovrd_val_value = get_rx_sloff0_ovrd_val

        regValue = leftShift((write_rx_sloff2_ovrd_value and &H1), 14) + leftShift((write_rx_sloff2_ovrd_val_value and &Hf), 10) + leftShift((write_rx_sloff1_ovrd_value and &H1), 9) + leftShift((write_rx_sloff1_ovrd_val_value and &Hf), 5) + leftShift((write_rx_sloff0_ovrd_value and &H1), 4) + leftShift((write_rx_sloff0_ovrd_val_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_rx_sloff2_ovrd_value = rightShift(data_low, 14) and &H1
        read_rx_sloff2_ovrd_val_value = rightShift(data_low, 10) and &Hf
        read_rx_sloff1_ovrd_value = rightShift(data_low, 9) and &H1
        read_rx_sloff1_ovrd_val_value = rightShift(data_low, 5) and &Hf
        read_rx_sloff0_ovrd_value = rightShift(data_low, 4) and &H1
        rx_sloff0_ovrd_val_mask = &Hf
        if data_low > LONG_MAX then
            if rx_sloff0_ovrd_val_mask = mask then
                read_rx_sloff0_ovrd_val_value = data_low
            else
                read_rx_sloff0_ovrd_val_value = (data_low - H8000_0000) and rx_sloff0_ovrd_val_mask
            end If
        else
            read_rx_sloff0_ovrd_val_value = data_low and rx_sloff0_ovrd_val_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_rx_sloff2_ovrd_value = &H0
        flag_rx_sloff2_ovrd        = &H0
        write_rx_sloff2_ovrd_val_value = &H0
        flag_rx_sloff2_ovrd_val        = &H0
        write_rx_sloff1_ovrd_value = &H0
        flag_rx_sloff1_ovrd        = &H0
        write_rx_sloff1_ovrd_val_value = &H0
        flag_rx_sloff1_ovrd_val        = &H0
        write_rx_sloff0_ovrd_value = &H0
        flag_rx_sloff0_ovrd        = &H0
        write_rx_sloff0_ovrd_val_value = &H0
        flag_rx_sloff0_ovrd_val        = &H0
    End Sub
End Class


'' @REGISTER : RX_DFE2__SGMIIPCIE_X1_slcalcontrol2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' cal_state_ovrd_val                         [15:13]          get_cal_state_ovrd_val
''                                                             set_cal_state_ovrd_val
''                                                             read_cal_state_ovrd_val
''                                                             write_cal_state_ovrd_val
''---------------------------------------------------------------------------------
'' rx_slicer_calvalid_ovrd                    [12:12]          get_rx_slicer_calvalid_ovrd
''                                                             set_rx_slicer_calvalid_ovrd
''                                                             read_rx_slicer_calvalid_ovrd
''                                                             write_rx_slicer_calvalid_ovrd
''---------------------------------------------------------------------------------
'' rx_slicer_calvalid_ovrd_val                [11:11]          get_rx_slicer_calvalid_ovrd_val
''                                                             set_rx_slicer_calvalid_ovrd_val
''                                                             read_rx_slicer_calvalid_ovrd_val
''                                                             write_rx_slicer_calvalid_ovrd_val
''---------------------------------------------------------------------------------
'' slcal_up_thres                             [10:0]           get_slcal_up_thres
''                                                             set_slcal_up_thres
''                                                             read_slcal_up_thres
''                                                             write_slcal_up_thres
''---------------------------------------------------------------------------------
Class REGISTER_RX_DFE2__SGMIIPCIE_X1_slcalcontrol2
    Private write_cal_state_ovrd_val_value
    Private read_cal_state_ovrd_val_value
    Private flag_cal_state_ovrd_val
    Private write_rx_slicer_calvalid_ovrd_value
    Private read_rx_slicer_calvalid_ovrd_value
    Private flag_rx_slicer_calvalid_ovrd
    Private write_rx_slicer_calvalid_ovrd_val_value
    Private read_rx_slicer_calvalid_ovrd_val_value
    Private flag_rx_slicer_calvalid_ovrd_val
    Private write_slcal_up_thres_value
    Private read_slcal_up_thres_value
    Private flag_slcal_up_thres

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

    Property Get get_cal_state_ovrd_val
        get_cal_state_ovrd_val = read_cal_state_ovrd_val_value
    End Property

    Property Let set_cal_state_ovrd_val(aData)
        write_cal_state_ovrd_val_value = aData
        flag_cal_state_ovrd_val        = &H1
    End Property

    Property Get read_cal_state_ovrd_val
        read
        read_cal_state_ovrd_val = read_cal_state_ovrd_val_value
    End Property

    Property Let write_cal_state_ovrd_val(aData)
        set_cal_state_ovrd_val = aData
        write
    End Property

    Property Get get_rx_slicer_calvalid_ovrd
        get_rx_slicer_calvalid_ovrd = read_rx_slicer_calvalid_ovrd_value
    End Property

    Property Let set_rx_slicer_calvalid_ovrd(aData)
        write_rx_slicer_calvalid_ovrd_value = aData
        flag_rx_slicer_calvalid_ovrd        = &H1
    End Property

    Property Get read_rx_slicer_calvalid_ovrd
        read
        read_rx_slicer_calvalid_ovrd = read_rx_slicer_calvalid_ovrd_value
    End Property

    Property Let write_rx_slicer_calvalid_ovrd(aData)
        set_rx_slicer_calvalid_ovrd = aData
        write
    End Property

    Property Get get_rx_slicer_calvalid_ovrd_val
        get_rx_slicer_calvalid_ovrd_val = read_rx_slicer_calvalid_ovrd_val_value
    End Property

    Property Let set_rx_slicer_calvalid_ovrd_val(aData)
        write_rx_slicer_calvalid_ovrd_val_value = aData
        flag_rx_slicer_calvalid_ovrd_val        = &H1
    End Property

    Property Get read_rx_slicer_calvalid_ovrd_val
        read
        read_rx_slicer_calvalid_ovrd_val = read_rx_slicer_calvalid_ovrd_val_value
    End Property

    Property Let write_rx_slicer_calvalid_ovrd_val(aData)
        set_rx_slicer_calvalid_ovrd_val = aData
        write
    End Property

    Property Get get_slcal_up_thres
        get_slcal_up_thres = read_slcal_up_thres_value
    End Property

    Property Let set_slcal_up_thres(aData)
        write_slcal_up_thres_value = aData
        flag_slcal_up_thres        = &H1
    End Property

    Property Get read_slcal_up_thres
        read
        read_slcal_up_thres = read_slcal_up_thres_value
    End Property

    Property Let write_slcal_up_thres(aData)
        set_slcal_up_thres = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_cal_state_ovrd_val_value = rightShift(data_low, 13) and &H7
        read_rx_slicer_calvalid_ovrd_value = rightShift(data_low, 12) and &H1
        read_rx_slicer_calvalid_ovrd_val_value = rightShift(data_low, 11) and &H1
        slcal_up_thres_mask = &H7ff
        if data_low > LONG_MAX then
            if slcal_up_thres_mask = mask then
                read_slcal_up_thres_value = data_low
            else
                read_slcal_up_thres_value = (data_low - H8000_0000) and slcal_up_thres_mask
            end If
        else
            read_slcal_up_thres_value = data_low and slcal_up_thres_mask
        end If

    End Sub

    Sub write
        If flag_cal_state_ovrd_val = &H0 or flag_rx_slicer_calvalid_ovrd = &H0 or flag_rx_slicer_calvalid_ovrd_val = &H0 or flag_slcal_up_thres = &H0 Then read
        If flag_cal_state_ovrd_val = &H0 Then write_cal_state_ovrd_val_value = get_cal_state_ovrd_val
        If flag_rx_slicer_calvalid_ovrd = &H0 Then write_rx_slicer_calvalid_ovrd_value = get_rx_slicer_calvalid_ovrd
        If flag_rx_slicer_calvalid_ovrd_val = &H0 Then write_rx_slicer_calvalid_ovrd_val_value = get_rx_slicer_calvalid_ovrd_val
        If flag_slcal_up_thres = &H0 Then write_slcal_up_thres_value = get_slcal_up_thres

        regValue = leftShift((write_cal_state_ovrd_val_value and &H7), 13) + leftShift((write_rx_slicer_calvalid_ovrd_value and &H1), 12) + leftShift((write_rx_slicer_calvalid_ovrd_val_value and &H1), 11) + leftShift((write_slcal_up_thres_value and &H7ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_cal_state_ovrd_val_value = rightShift(data_low, 13) and &H7
        read_rx_slicer_calvalid_ovrd_value = rightShift(data_low, 12) and &H1
        read_rx_slicer_calvalid_ovrd_val_value = rightShift(data_low, 11) and &H1
        slcal_up_thres_mask = &H7ff
        if data_low > LONG_MAX then
            if slcal_up_thres_mask = mask then
                read_slcal_up_thres_value = data_low
            else
                read_slcal_up_thres_value = (data_low - H8000_0000) and slcal_up_thres_mask
            end If
        else
            read_slcal_up_thres_value = data_low and slcal_up_thres_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_cal_state_ovrd_val_value = &H0
        flag_cal_state_ovrd_val        = &H0
        write_rx_slicer_calvalid_ovrd_value = &H0
        flag_rx_slicer_calvalid_ovrd        = &H0
        write_rx_slicer_calvalid_ovrd_val_value = &H0
        flag_rx_slicer_calvalid_ovrd_val        = &H0
        write_slcal_up_thres_value = &H0
        flag_slcal_up_thres        = &H0
    End Sub
End Class


'' @REGISTER : RX_DFE2__SGMIIPCIE_X1_slcalcontrol3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' slicer_interval_time                       [15:11]          get_slicer_interval_time
''                                                             set_slicer_interval_time
''                                                             read_slicer_interval_time
''                                                             write_slicer_interval_time
''---------------------------------------------------------------------------------
'' slcal_dn_thres                             [10:0]           get_slcal_dn_thres
''                                                             set_slcal_dn_thres
''                                                             read_slcal_dn_thres
''                                                             write_slcal_dn_thres
''---------------------------------------------------------------------------------
Class REGISTER_RX_DFE2__SGMIIPCIE_X1_slcalcontrol3
    Private write_slicer_interval_time_value
    Private read_slicer_interval_time_value
    Private flag_slicer_interval_time
    Private write_slcal_dn_thres_value
    Private read_slcal_dn_thres_value
    Private flag_slcal_dn_thres

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

    Property Get get_slicer_interval_time
        get_slicer_interval_time = read_slicer_interval_time_value
    End Property

    Property Let set_slicer_interval_time(aData)
        write_slicer_interval_time_value = aData
        flag_slicer_interval_time        = &H1
    End Property

    Property Get read_slicer_interval_time
        read
        read_slicer_interval_time = read_slicer_interval_time_value
    End Property

    Property Let write_slicer_interval_time(aData)
        set_slicer_interval_time = aData
        write
    End Property

    Property Get get_slcal_dn_thres
        get_slcal_dn_thres = read_slcal_dn_thres_value
    End Property

    Property Let set_slcal_dn_thres(aData)
        write_slcal_dn_thres_value = aData
        flag_slcal_dn_thres        = &H1
    End Property

    Property Get read_slcal_dn_thres
        read
        read_slcal_dn_thres = read_slcal_dn_thres_value
    End Property

    Property Let write_slcal_dn_thres(aData)
        set_slcal_dn_thres = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_slicer_interval_time_value = rightShift(data_low, 11) and &H1f
        slcal_dn_thres_mask = &H7ff
        if data_low > LONG_MAX then
            if slcal_dn_thres_mask = mask then
                read_slcal_dn_thres_value = data_low
            else
                read_slcal_dn_thres_value = (data_low - H8000_0000) and slcal_dn_thres_mask
            end If
        else
            read_slcal_dn_thres_value = data_low and slcal_dn_thres_mask
        end If

    End Sub

    Sub write
        If flag_slicer_interval_time = &H0 or flag_slcal_dn_thres = &H0 Then read
        If flag_slicer_interval_time = &H0 Then write_slicer_interval_time_value = get_slicer_interval_time
        If flag_slcal_dn_thres = &H0 Then write_slcal_dn_thres_value = get_slcal_dn_thres

        regValue = leftShift((write_slicer_interval_time_value and &H1f), 11) + leftShift((write_slcal_dn_thres_value and &H7ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_slicer_interval_time_value = rightShift(data_low, 11) and &H1f
        slcal_dn_thres_mask = &H7ff
        if data_low > LONG_MAX then
            if slcal_dn_thres_mask = mask then
                read_slcal_dn_thres_value = data_low
            else
                read_slcal_dn_thres_value = (data_low - H8000_0000) and slcal_dn_thres_mask
            end If
        else
            read_slcal_dn_thres_value = data_low and slcal_dn_thres_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_slicer_interval_time_value = &H0
        flag_slicer_interval_time        = &H0
        write_slcal_dn_thres_value = &H0
        flag_slcal_dn_thres        = &H0
    End Sub
End Class


'' @REGISTER : RX_DFE2__SGMIIPCIE_X1_slcalstatus0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' rx_sloff2_invalid                          [15:15]          get_rx_sloff2_invalid
''                                                             set_rx_sloff2_invalid
''                                                             read_rx_sloff2_invalid
''                                                             write_rx_sloff2_invalid
''---------------------------------------------------------------------------------
'' rx_sloff1_invalid                          [14:14]          get_rx_sloff1_invalid
''                                                             set_rx_sloff1_invalid
''                                                             read_rx_sloff1_invalid
''                                                             write_rx_sloff1_invalid
''---------------------------------------------------------------------------------
'' rx_sloff0_invalid                          [13:13]          get_rx_sloff0_invalid
''                                                             set_rx_sloff0_invalid
''                                                             read_rx_sloff0_invalid
''                                                             write_rx_sloff0_invalid
''---------------------------------------------------------------------------------
'' slcal_state                                [10:8]           get_slcal_state
''                                                             set_slcal_state
''                                                             read_slcal_state
''                                                             write_slcal_state
''---------------------------------------------------------------------------------
'' up_sloffx_val                              [7:4]            get_up_sloffx_val
''                                                             set_up_sloffx_val
''                                                             read_up_sloffx_val
''                                                             write_up_sloffx_val
''---------------------------------------------------------------------------------
'' dn_sloffx_val                              [3:0]            get_dn_sloffx_val
''                                                             set_dn_sloffx_val
''                                                             read_dn_sloffx_val
''                                                             write_dn_sloffx_val
''---------------------------------------------------------------------------------
Class REGISTER_RX_DFE2__SGMIIPCIE_X1_slcalstatus0
    Private write_rx_sloff2_invalid_value
    Private read_rx_sloff2_invalid_value
    Private flag_rx_sloff2_invalid
    Private write_rx_sloff1_invalid_value
    Private read_rx_sloff1_invalid_value
    Private flag_rx_sloff1_invalid
    Private write_rx_sloff0_invalid_value
    Private read_rx_sloff0_invalid_value
    Private flag_rx_sloff0_invalid
    Private write_slcal_state_value
    Private read_slcal_state_value
    Private flag_slcal_state
    Private write_up_sloffx_val_value
    Private read_up_sloffx_val_value
    Private flag_up_sloffx_val
    Private write_dn_sloffx_val_value
    Private read_dn_sloffx_val_value
    Private flag_dn_sloffx_val

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

    Property Get get_rx_sloff2_invalid
        get_rx_sloff2_invalid = read_rx_sloff2_invalid_value
    End Property

    Property Let set_rx_sloff2_invalid(aData)
        write_rx_sloff2_invalid_value = aData
        flag_rx_sloff2_invalid        = &H1
    End Property

    Property Get read_rx_sloff2_invalid
        read
        read_rx_sloff2_invalid = read_rx_sloff2_invalid_value
    End Property

    Property Let write_rx_sloff2_invalid(aData)
        set_rx_sloff2_invalid = aData
        write
    End Property

    Property Get get_rx_sloff1_invalid
        get_rx_sloff1_invalid = read_rx_sloff1_invalid_value
    End Property

    Property Let set_rx_sloff1_invalid(aData)
        write_rx_sloff1_invalid_value = aData
        flag_rx_sloff1_invalid        = &H1
    End Property

    Property Get read_rx_sloff1_invalid
        read
        read_rx_sloff1_invalid = read_rx_sloff1_invalid_value
    End Property

    Property Let write_rx_sloff1_invalid(aData)
        set_rx_sloff1_invalid = aData
        write
    End Property

    Property Get get_rx_sloff0_invalid
        get_rx_sloff0_invalid = read_rx_sloff0_invalid_value
    End Property

    Property Let set_rx_sloff0_invalid(aData)
        write_rx_sloff0_invalid_value = aData
        flag_rx_sloff0_invalid        = &H1
    End Property

    Property Get read_rx_sloff0_invalid
        read
        read_rx_sloff0_invalid = read_rx_sloff0_invalid_value
    End Property

    Property Let write_rx_sloff0_invalid(aData)
        set_rx_sloff0_invalid = aData
        write
    End Property

    Property Get get_slcal_state
        get_slcal_state = read_slcal_state_value
    End Property

    Property Let set_slcal_state(aData)
        write_slcal_state_value = aData
        flag_slcal_state        = &H1
    End Property

    Property Get read_slcal_state
        read
        read_slcal_state = read_slcal_state_value
    End Property

    Property Let write_slcal_state(aData)
        set_slcal_state = aData
        write
    End Property

    Property Get get_up_sloffx_val
        get_up_sloffx_val = read_up_sloffx_val_value
    End Property

    Property Let set_up_sloffx_val(aData)
        write_up_sloffx_val_value = aData
        flag_up_sloffx_val        = &H1
    End Property

    Property Get read_up_sloffx_val
        read
        read_up_sloffx_val = read_up_sloffx_val_value
    End Property

    Property Let write_up_sloffx_val(aData)
        set_up_sloffx_val = aData
        write
    End Property

    Property Get get_dn_sloffx_val
        get_dn_sloffx_val = read_dn_sloffx_val_value
    End Property

    Property Let set_dn_sloffx_val(aData)
        write_dn_sloffx_val_value = aData
        flag_dn_sloffx_val        = &H1
    End Property

    Property Get read_dn_sloffx_val
        read
        read_dn_sloffx_val = read_dn_sloffx_val_value
    End Property

    Property Let write_dn_sloffx_val(aData)
        set_dn_sloffx_val = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_rx_sloff2_invalid_value = rightShift(data_low, 15) and &H1
        read_rx_sloff1_invalid_value = rightShift(data_low, 14) and &H1
        read_rx_sloff0_invalid_value = rightShift(data_low, 13) and &H1
        read_slcal_state_value = rightShift(data_low, 8) and &H7
        read_up_sloffx_val_value = rightShift(data_low, 4) and &Hf
        dn_sloffx_val_mask = &Hf
        if data_low > LONG_MAX then
            if dn_sloffx_val_mask = mask then
                read_dn_sloffx_val_value = data_low
            else
                read_dn_sloffx_val_value = (data_low - H8000_0000) and dn_sloffx_val_mask
            end If
        else
            read_dn_sloffx_val_value = data_low and dn_sloffx_val_mask
        end If

    End Sub

    Sub write
        If flag_rx_sloff2_invalid = &H0 or flag_rx_sloff1_invalid = &H0 or flag_rx_sloff0_invalid = &H0 or flag_slcal_state = &H0 or flag_up_sloffx_val = &H0 or flag_dn_sloffx_val = &H0 Then read
        If flag_rx_sloff2_invalid = &H0 Then write_rx_sloff2_invalid_value = get_rx_sloff2_invalid
        If flag_rx_sloff1_invalid = &H0 Then write_rx_sloff1_invalid_value = get_rx_sloff1_invalid
        If flag_rx_sloff0_invalid = &H0 Then write_rx_sloff0_invalid_value = get_rx_sloff0_invalid
        If flag_slcal_state = &H0 Then write_slcal_state_value = get_slcal_state
        If flag_up_sloffx_val = &H0 Then write_up_sloffx_val_value = get_up_sloffx_val
        If flag_dn_sloffx_val = &H0 Then write_dn_sloffx_val_value = get_dn_sloffx_val

        regValue = leftShift((write_rx_sloff2_invalid_value and &H1), 15) + leftShift((write_rx_sloff1_invalid_value and &H1), 14) + leftShift((write_rx_sloff0_invalid_value and &H1), 13) + leftShift((write_slcal_state_value and &H7), 8) + leftShift((write_up_sloffx_val_value and &Hf), 4) + leftShift((write_dn_sloffx_val_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_rx_sloff2_invalid_value = rightShift(data_low, 15) and &H1
        read_rx_sloff1_invalid_value = rightShift(data_low, 14) and &H1
        read_rx_sloff0_invalid_value = rightShift(data_low, 13) and &H1
        read_slcal_state_value = rightShift(data_low, 8) and &H7
        read_up_sloffx_val_value = rightShift(data_low, 4) and &Hf
        dn_sloffx_val_mask = &Hf
        if data_low > LONG_MAX then
            if dn_sloffx_val_mask = mask then
                read_dn_sloffx_val_value = data_low
            else
                read_dn_sloffx_val_value = (data_low - H8000_0000) and dn_sloffx_val_mask
            end If
        else
            read_dn_sloffx_val_value = data_low and dn_sloffx_val_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_rx_sloff2_invalid_value = &H0
        flag_rx_sloff2_invalid        = &H0
        write_rx_sloff1_invalid_value = &H0
        flag_rx_sloff1_invalid        = &H0
        write_rx_sloff0_invalid_value = &H0
        flag_rx_sloff0_invalid        = &H0
        write_slcal_state_value = &H0
        flag_slcal_state        = &H0
        write_up_sloffx_val_value = &H0
        flag_up_sloffx_val        = &H0
        write_dn_sloffx_val_value = &H0
        flag_dn_sloffx_val        = &H0
    End Sub
End Class


'' @REGISTER : RX_DFE2__SGMIIPCIE_X1_slcalstatus1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' sloffx_val                                 [15:12]          get_sloffx_val
''                                                             set_sloffx_val
''                                                             read_sloffx_val
''                                                             write_sloffx_val
''---------------------------------------------------------------------------------
'' sloff2_val                                 [11:8]           get_sloff2_val
''                                                             set_sloff2_val
''                                                             read_sloff2_val
''                                                             write_sloff2_val
''---------------------------------------------------------------------------------
'' sloff1_val                                 [7:4]            get_sloff1_val
''                                                             set_sloff1_val
''                                                             read_sloff1_val
''                                                             write_sloff1_val
''---------------------------------------------------------------------------------
'' sloff0_val                                 [3:0]            get_sloff0_val
''                                                             set_sloff0_val
''                                                             read_sloff0_val
''                                                             write_sloff0_val
''---------------------------------------------------------------------------------
Class REGISTER_RX_DFE2__SGMIIPCIE_X1_slcalstatus1
    Private write_sloffx_val_value
    Private read_sloffx_val_value
    Private flag_sloffx_val
    Private write_sloff2_val_value
    Private read_sloff2_val_value
    Private flag_sloff2_val
    Private write_sloff1_val_value
    Private read_sloff1_val_value
    Private flag_sloff1_val
    Private write_sloff0_val_value
    Private read_sloff0_val_value
    Private flag_sloff0_val

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

    Property Get get_sloffx_val
        get_sloffx_val = read_sloffx_val_value
    End Property

    Property Let set_sloffx_val(aData)
        write_sloffx_val_value = aData
        flag_sloffx_val        = &H1
    End Property

    Property Get read_sloffx_val
        read
        read_sloffx_val = read_sloffx_val_value
    End Property

    Property Let write_sloffx_val(aData)
        set_sloffx_val = aData
        write
    End Property

    Property Get get_sloff2_val
        get_sloff2_val = read_sloff2_val_value
    End Property

    Property Let set_sloff2_val(aData)
        write_sloff2_val_value = aData
        flag_sloff2_val        = &H1
    End Property

    Property Get read_sloff2_val
        read
        read_sloff2_val = read_sloff2_val_value
    End Property

    Property Let write_sloff2_val(aData)
        set_sloff2_val = aData
        write
    End Property

    Property Get get_sloff1_val
        get_sloff1_val = read_sloff1_val_value
    End Property

    Property Let set_sloff1_val(aData)
        write_sloff1_val_value = aData
        flag_sloff1_val        = &H1
    End Property

    Property Get read_sloff1_val
        read
        read_sloff1_val = read_sloff1_val_value
    End Property

    Property Let write_sloff1_val(aData)
        set_sloff1_val = aData
        write
    End Property

    Property Get get_sloff0_val
        get_sloff0_val = read_sloff0_val_value
    End Property

    Property Let set_sloff0_val(aData)
        write_sloff0_val_value = aData
        flag_sloff0_val        = &H1
    End Property

    Property Get read_sloff0_val
        read
        read_sloff0_val = read_sloff0_val_value
    End Property

    Property Let write_sloff0_val(aData)
        set_sloff0_val = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_sloffx_val_value = rightShift(data_low, 12) and &Hf
        read_sloff2_val_value = rightShift(data_low, 8) and &Hf
        read_sloff1_val_value = rightShift(data_low, 4) and &Hf
        sloff0_val_mask = &Hf
        if data_low > LONG_MAX then
            if sloff0_val_mask = mask then
                read_sloff0_val_value = data_low
            else
                read_sloff0_val_value = (data_low - H8000_0000) and sloff0_val_mask
            end If
        else
            read_sloff0_val_value = data_low and sloff0_val_mask
        end If

    End Sub

    Sub write
        If flag_sloffx_val = &H0 or flag_sloff2_val = &H0 or flag_sloff1_val = &H0 or flag_sloff0_val = &H0 Then read
        If flag_sloffx_val = &H0 Then write_sloffx_val_value = get_sloffx_val
        If flag_sloff2_val = &H0 Then write_sloff2_val_value = get_sloff2_val
        If flag_sloff1_val = &H0 Then write_sloff1_val_value = get_sloff1_val
        If flag_sloff0_val = &H0 Then write_sloff0_val_value = get_sloff0_val

        regValue = leftShift((write_sloffx_val_value and &Hf), 12) + leftShift((write_sloff2_val_value and &Hf), 8) + leftShift((write_sloff1_val_value and &Hf), 4) + leftShift((write_sloff0_val_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_sloffx_val_value = rightShift(data_low, 12) and &Hf
        read_sloff2_val_value = rightShift(data_low, 8) and &Hf
        read_sloff1_val_value = rightShift(data_low, 4) and &Hf
        sloff0_val_mask = &Hf
        if data_low > LONG_MAX then
            if sloff0_val_mask = mask then
                read_sloff0_val_value = data_low
            else
                read_sloff0_val_value = (data_low - H8000_0000) and sloff0_val_mask
            end If
        else
            read_sloff0_val_value = data_low and sloff0_val_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_sloffx_val_value = &H0
        flag_sloffx_val        = &H0
        write_sloff2_val_value = &H0
        flag_sloff2_val        = &H0
        write_sloff1_val_value = &H0
        flag_sloff1_val        = &H0
        write_sloff0_val_value = &H0
        flag_sloff0_val        = &H0
    End Sub
End Class


'' @REGISTER : RX_DFE2__SGMIIPCIE_X1_emdiagcontrol
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' eom_init_shift                             [12:12]          get_eom_init_shift
''                                                             set_eom_init_shift
''                                                             read_eom_init_shift
''                                                             write_eom_init_shift
''---------------------------------------------------------------------------------
'' em_cmp_data_sel                            [11:11]          get_em_cmp_data_sel
''                                                             set_em_cmp_data_sel
''                                                             read_em_cmp_data_sel
''                                                             write_em_cmp_data_sel
''---------------------------------------------------------------------------------
'' em_phase_shift_360_ovrd                    [10:10]          get_em_phase_shift_360_ovrd
''                                                             set_em_phase_shift_360_ovrd
''                                                             read_em_phase_shift_360_ovrd
''                                                             write_em_phase_shift_360_ovrd
''---------------------------------------------------------------------------------
'' em_phase_shift_360_ovrd_val                [9:9]            get_em_phase_shift_360_ovrd_val
''                                                             set_em_phase_shift_360_ovrd_val
''                                                             read_em_phase_shift_360_ovrd_val
''                                                             write_em_phase_shift_360_ovrd_val
''---------------------------------------------------------------------------------
'' rx_interp_ctrl_cap                         [8:8]            get_rx_interp_ctrl_cap
''                                                             set_rx_interp_ctrl_cap
''                                                             read_rx_interp_ctrl_cap
''                                                             write_rx_interp_ctrl_cap
''---------------------------------------------------------------------------------
'' rx_interp_status_sel                       [6:4]            get_rx_interp_status_sel
''                                                             set_rx_interp_status_sel
''                                                             read_rx_interp_status_sel
''                                                             write_rx_interp_status_sel
''---------------------------------------------------------------------------------
'' flip_eyemon_polarity                       [3:3]            get_flip_eyemon_polarity
''                                                             set_flip_eyemon_polarity
''                                                             read_flip_eyemon_polarity
''                                                             write_flip_eyemon_polarity
''---------------------------------------------------------------------------------
'' mdio_em_err_cnt_clr                        [2:2]            get_mdio_em_err_cnt_clr
''                                                             set_mdio_em_err_cnt_clr
''                                                             read_mdio_em_err_cnt_clr
''                                                             write_mdio_em_err_cnt_clr
''---------------------------------------------------------------------------------
'' mdio_em_err_cnt_frz                        [1:1]            get_mdio_em_err_cnt_frz
''                                                             set_mdio_em_err_cnt_frz
''                                                             read_mdio_em_err_cnt_frz
''                                                             write_mdio_em_err_cnt_frz
''---------------------------------------------------------------------------------
'' mdio_em_pwrdn                              [0:0]            get_mdio_em_pwrdn
''                                                             set_mdio_em_pwrdn
''                                                             read_mdio_em_pwrdn
''                                                             write_mdio_em_pwrdn
''---------------------------------------------------------------------------------
Class REGISTER_RX_DFE2__SGMIIPCIE_X1_emdiagcontrol
    Private write_eom_init_shift_value
    Private read_eom_init_shift_value
    Private flag_eom_init_shift
    Private write_em_cmp_data_sel_value
    Private read_em_cmp_data_sel_value
    Private flag_em_cmp_data_sel
    Private write_em_phase_shift_360_ovrd_value
    Private read_em_phase_shift_360_ovrd_value
    Private flag_em_phase_shift_360_ovrd
    Private write_em_phase_shift_360_ovrd_val_value
    Private read_em_phase_shift_360_ovrd_val_value
    Private flag_em_phase_shift_360_ovrd_val
    Private write_rx_interp_ctrl_cap_value
    Private read_rx_interp_ctrl_cap_value
    Private flag_rx_interp_ctrl_cap
    Private write_rx_interp_status_sel_value
    Private read_rx_interp_status_sel_value
    Private flag_rx_interp_status_sel
    Private write_flip_eyemon_polarity_value
    Private read_flip_eyemon_polarity_value
    Private flag_flip_eyemon_polarity
    Private write_mdio_em_err_cnt_clr_value
    Private read_mdio_em_err_cnt_clr_value
    Private flag_mdio_em_err_cnt_clr
    Private write_mdio_em_err_cnt_frz_value
    Private read_mdio_em_err_cnt_frz_value
    Private flag_mdio_em_err_cnt_frz
    Private write_mdio_em_pwrdn_value
    Private read_mdio_em_pwrdn_value
    Private flag_mdio_em_pwrdn

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

    Property Get get_eom_init_shift
        get_eom_init_shift = read_eom_init_shift_value
    End Property

    Property Let set_eom_init_shift(aData)
        write_eom_init_shift_value = aData
        flag_eom_init_shift        = &H1
    End Property

    Property Get read_eom_init_shift
        read
        read_eom_init_shift = read_eom_init_shift_value
    End Property

    Property Let write_eom_init_shift(aData)
        set_eom_init_shift = aData
        write
    End Property

    Property Get get_em_cmp_data_sel
        get_em_cmp_data_sel = read_em_cmp_data_sel_value
    End Property

    Property Let set_em_cmp_data_sel(aData)
        write_em_cmp_data_sel_value = aData
        flag_em_cmp_data_sel        = &H1
    End Property

    Property Get read_em_cmp_data_sel
        read
        read_em_cmp_data_sel = read_em_cmp_data_sel_value
    End Property

    Property Let write_em_cmp_data_sel(aData)
        set_em_cmp_data_sel = aData
        write
    End Property

    Property Get get_em_phase_shift_360_ovrd
        get_em_phase_shift_360_ovrd = read_em_phase_shift_360_ovrd_value
    End Property

    Property Let set_em_phase_shift_360_ovrd(aData)
        write_em_phase_shift_360_ovrd_value = aData
        flag_em_phase_shift_360_ovrd        = &H1
    End Property

    Property Get read_em_phase_shift_360_ovrd
        read
        read_em_phase_shift_360_ovrd = read_em_phase_shift_360_ovrd_value
    End Property

    Property Let write_em_phase_shift_360_ovrd(aData)
        set_em_phase_shift_360_ovrd = aData
        write
    End Property

    Property Get get_em_phase_shift_360_ovrd_val
        get_em_phase_shift_360_ovrd_val = read_em_phase_shift_360_ovrd_val_value
    End Property

    Property Let set_em_phase_shift_360_ovrd_val(aData)
        write_em_phase_shift_360_ovrd_val_value = aData
        flag_em_phase_shift_360_ovrd_val        = &H1
    End Property

    Property Get read_em_phase_shift_360_ovrd_val
        read
        read_em_phase_shift_360_ovrd_val = read_em_phase_shift_360_ovrd_val_value
    End Property

    Property Let write_em_phase_shift_360_ovrd_val(aData)
        set_em_phase_shift_360_ovrd_val = aData
        write
    End Property

    Property Get get_rx_interp_ctrl_cap
        get_rx_interp_ctrl_cap = read_rx_interp_ctrl_cap_value
    End Property

    Property Let set_rx_interp_ctrl_cap(aData)
        write_rx_interp_ctrl_cap_value = aData
        flag_rx_interp_ctrl_cap        = &H1
    End Property

    Property Get read_rx_interp_ctrl_cap
        read
        read_rx_interp_ctrl_cap = read_rx_interp_ctrl_cap_value
    End Property

    Property Let write_rx_interp_ctrl_cap(aData)
        set_rx_interp_ctrl_cap = aData
        write
    End Property

    Property Get get_rx_interp_status_sel
        get_rx_interp_status_sel = read_rx_interp_status_sel_value
    End Property

    Property Let set_rx_interp_status_sel(aData)
        write_rx_interp_status_sel_value = aData
        flag_rx_interp_status_sel        = &H1
    End Property

    Property Get read_rx_interp_status_sel
        read
        read_rx_interp_status_sel = read_rx_interp_status_sel_value
    End Property

    Property Let write_rx_interp_status_sel(aData)
        set_rx_interp_status_sel = aData
        write
    End Property

    Property Get get_flip_eyemon_polarity
        get_flip_eyemon_polarity = read_flip_eyemon_polarity_value
    End Property

    Property Let set_flip_eyemon_polarity(aData)
        write_flip_eyemon_polarity_value = aData
        flag_flip_eyemon_polarity        = &H1
    End Property

    Property Get read_flip_eyemon_polarity
        read
        read_flip_eyemon_polarity = read_flip_eyemon_polarity_value
    End Property

    Property Let write_flip_eyemon_polarity(aData)
        set_flip_eyemon_polarity = aData
        write
    End Property

    Property Get get_mdio_em_err_cnt_clr
        get_mdio_em_err_cnt_clr = read_mdio_em_err_cnt_clr_value
    End Property

    Property Let set_mdio_em_err_cnt_clr(aData)
        write_mdio_em_err_cnt_clr_value = aData
        flag_mdio_em_err_cnt_clr        = &H1
    End Property

    Property Get read_mdio_em_err_cnt_clr
        read
        read_mdio_em_err_cnt_clr = read_mdio_em_err_cnt_clr_value
    End Property

    Property Let write_mdio_em_err_cnt_clr(aData)
        set_mdio_em_err_cnt_clr = aData
        write
    End Property

    Property Get get_mdio_em_err_cnt_frz
        get_mdio_em_err_cnt_frz = read_mdio_em_err_cnt_frz_value
    End Property

    Property Let set_mdio_em_err_cnt_frz(aData)
        write_mdio_em_err_cnt_frz_value = aData
        flag_mdio_em_err_cnt_frz        = &H1
    End Property

    Property Get read_mdio_em_err_cnt_frz
        read
        read_mdio_em_err_cnt_frz = read_mdio_em_err_cnt_frz_value
    End Property

    Property Let write_mdio_em_err_cnt_frz(aData)
        set_mdio_em_err_cnt_frz = aData
        write
    End Property

    Property Get get_mdio_em_pwrdn
        get_mdio_em_pwrdn = read_mdio_em_pwrdn_value
    End Property

    Property Let set_mdio_em_pwrdn(aData)
        write_mdio_em_pwrdn_value = aData
        flag_mdio_em_pwrdn        = &H1
    End Property

    Property Get read_mdio_em_pwrdn
        read
        read_mdio_em_pwrdn = read_mdio_em_pwrdn_value
    End Property

    Property Let write_mdio_em_pwrdn(aData)
        set_mdio_em_pwrdn = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_eom_init_shift_value = rightShift(data_low, 12) and &H1
        read_em_cmp_data_sel_value = rightShift(data_low, 11) and &H1
        read_em_phase_shift_360_ovrd_value = rightShift(data_low, 10) and &H1
        read_em_phase_shift_360_ovrd_val_value = rightShift(data_low, 9) and &H1
        read_rx_interp_ctrl_cap_value = rightShift(data_low, 8) and &H1
        read_rx_interp_status_sel_value = rightShift(data_low, 4) and &H7
        read_flip_eyemon_polarity_value = rightShift(data_low, 3) and &H1
        read_mdio_em_err_cnt_clr_value = rightShift(data_low, 2) and &H1
        read_mdio_em_err_cnt_frz_value = rightShift(data_low, 1) and &H1
        mdio_em_pwrdn_mask = &H1
        if data_low > LONG_MAX then
            if mdio_em_pwrdn_mask = mask then
                read_mdio_em_pwrdn_value = data_low
            else
                read_mdio_em_pwrdn_value = (data_low - H8000_0000) and mdio_em_pwrdn_mask
            end If
        else
            read_mdio_em_pwrdn_value = data_low and mdio_em_pwrdn_mask
        end If

    End Sub

    Sub write
        If flag_eom_init_shift = &H0 or flag_em_cmp_data_sel = &H0 or flag_em_phase_shift_360_ovrd = &H0 or flag_em_phase_shift_360_ovrd_val = &H0 or flag_rx_interp_ctrl_cap = &H0 or flag_rx_interp_status_sel = &H0 or flag_flip_eyemon_polarity = &H0 or flag_mdio_em_err_cnt_clr = &H0 or flag_mdio_em_err_cnt_frz = &H0 or flag_mdio_em_pwrdn = &H0 Then read
        If flag_eom_init_shift = &H0 Then write_eom_init_shift_value = get_eom_init_shift
        If flag_em_cmp_data_sel = &H0 Then write_em_cmp_data_sel_value = get_em_cmp_data_sel
        If flag_em_phase_shift_360_ovrd = &H0 Then write_em_phase_shift_360_ovrd_value = get_em_phase_shift_360_ovrd
        If flag_em_phase_shift_360_ovrd_val = &H0 Then write_em_phase_shift_360_ovrd_val_value = get_em_phase_shift_360_ovrd_val
        If flag_rx_interp_ctrl_cap = &H0 Then write_rx_interp_ctrl_cap_value = get_rx_interp_ctrl_cap
        If flag_rx_interp_status_sel = &H0 Then write_rx_interp_status_sel_value = get_rx_interp_status_sel
        If flag_flip_eyemon_polarity = &H0 Then write_flip_eyemon_polarity_value = get_flip_eyemon_polarity
        If flag_mdio_em_err_cnt_clr = &H0 Then write_mdio_em_err_cnt_clr_value = get_mdio_em_err_cnt_clr
        If flag_mdio_em_err_cnt_frz = &H0 Then write_mdio_em_err_cnt_frz_value = get_mdio_em_err_cnt_frz
        If flag_mdio_em_pwrdn = &H0 Then write_mdio_em_pwrdn_value = get_mdio_em_pwrdn

        regValue = leftShift((write_eom_init_shift_value and &H1), 12) + leftShift((write_em_cmp_data_sel_value and &H1), 11) + leftShift((write_em_phase_shift_360_ovrd_value and &H1), 10) + leftShift((write_em_phase_shift_360_ovrd_val_value and &H1), 9) + leftShift((write_rx_interp_ctrl_cap_value and &H1), 8) + leftShift((write_rx_interp_status_sel_value and &H7), 4) + leftShift((write_flip_eyemon_polarity_value and &H1), 3) + leftShift((write_mdio_em_err_cnt_clr_value and &H1), 2) + leftShift((write_mdio_em_err_cnt_frz_value and &H1), 1) + leftShift((write_mdio_em_pwrdn_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_eom_init_shift_value = rightShift(data_low, 12) and &H1
        read_em_cmp_data_sel_value = rightShift(data_low, 11) and &H1
        read_em_phase_shift_360_ovrd_value = rightShift(data_low, 10) and &H1
        read_em_phase_shift_360_ovrd_val_value = rightShift(data_low, 9) and &H1
        read_rx_interp_ctrl_cap_value = rightShift(data_low, 8) and &H1
        read_rx_interp_status_sel_value = rightShift(data_low, 4) and &H7
        read_flip_eyemon_polarity_value = rightShift(data_low, 3) and &H1
        read_mdio_em_err_cnt_clr_value = rightShift(data_low, 2) and &H1
        read_mdio_em_err_cnt_frz_value = rightShift(data_low, 1) and &H1
        mdio_em_pwrdn_mask = &H1
        if data_low > LONG_MAX then
            if mdio_em_pwrdn_mask = mask then
                read_mdio_em_pwrdn_value = data_low
            else
                read_mdio_em_pwrdn_value = (data_low - H8000_0000) and mdio_em_pwrdn_mask
            end If
        else
            read_mdio_em_pwrdn_value = data_low and mdio_em_pwrdn_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_eom_init_shift_value = &H0
        flag_eom_init_shift        = &H0
        write_em_cmp_data_sel_value = &H0
        flag_em_cmp_data_sel        = &H0
        write_em_phase_shift_360_ovrd_value = &H0
        flag_em_phase_shift_360_ovrd        = &H0
        write_em_phase_shift_360_ovrd_val_value = &H0
        flag_em_phase_shift_360_ovrd_val        = &H0
        write_rx_interp_ctrl_cap_value = &H0
        flag_rx_interp_ctrl_cap        = &H0
        write_rx_interp_status_sel_value = &H0
        flag_rx_interp_status_sel        = &H0
        write_flip_eyemon_polarity_value = &H0
        flag_flip_eyemon_polarity        = &H0
        write_mdio_em_err_cnt_clr_value = &H0
        flag_mdio_em_err_cnt_clr        = &H0
        write_mdio_em_err_cnt_frz_value = &H0
        flag_mdio_em_err_cnt_frz        = &H0
        write_mdio_em_pwrdn_value = &H0
        flag_mdio_em_pwrdn        = &H0
    End Sub
End Class


'' @REGISTER : RX_DFE2__SGMIIPCIE_X1_rxemerrlo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' rxem_err_lo_cnt                            [15:0]           get_rxem_err_lo_cnt
''                                                             set_rxem_err_lo_cnt
''                                                             read_rxem_err_lo_cnt
''                                                             write_rxem_err_lo_cnt
''---------------------------------------------------------------------------------
Class REGISTER_RX_DFE2__SGMIIPCIE_X1_rxemerrlo
    Private write_rxem_err_lo_cnt_value
    Private read_rxem_err_lo_cnt_value
    Private flag_rxem_err_lo_cnt

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

    Property Get get_rxem_err_lo_cnt
        get_rxem_err_lo_cnt = read_rxem_err_lo_cnt_value
    End Property

    Property Let set_rxem_err_lo_cnt(aData)
        write_rxem_err_lo_cnt_value = aData
        flag_rxem_err_lo_cnt        = &H1
    End Property

    Property Get read_rxem_err_lo_cnt
        read
        read_rxem_err_lo_cnt = read_rxem_err_lo_cnt_value
    End Property

    Property Let write_rxem_err_lo_cnt(aData)
        set_rxem_err_lo_cnt = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rxem_err_lo_cnt_mask = &Hffff
        if data_low > LONG_MAX then
            if rxem_err_lo_cnt_mask = mask then
                read_rxem_err_lo_cnt_value = data_low
            else
                read_rxem_err_lo_cnt_value = (data_low - H8000_0000) and rxem_err_lo_cnt_mask
            end If
        else
            read_rxem_err_lo_cnt_value = data_low and rxem_err_lo_cnt_mask
        end If

    End Sub

    Sub write
        If flag_rxem_err_lo_cnt = &H0 Then read
        If flag_rxem_err_lo_cnt = &H0 Then write_rxem_err_lo_cnt_value = get_rxem_err_lo_cnt

        regValue = leftShift((write_rxem_err_lo_cnt_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rxem_err_lo_cnt_mask = &Hffff
        if data_low > LONG_MAX then
            if rxem_err_lo_cnt_mask = mask then
                read_rxem_err_lo_cnt_value = data_low
            else
                read_rxem_err_lo_cnt_value = (data_low - H8000_0000) and rxem_err_lo_cnt_mask
            end If
        else
            read_rxem_err_lo_cnt_value = data_low and rxem_err_lo_cnt_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_rxem_err_lo_cnt_value = &H0
        flag_rxem_err_lo_cnt        = &H0
    End Sub
End Class


'' @REGISTER : RX_DFE2__SGMIIPCIE_X1_rxemerrhi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' rxem_err_hi_cnt                            [15:0]           get_rxem_err_hi_cnt
''                                                             set_rxem_err_hi_cnt
''                                                             read_rxem_err_hi_cnt
''                                                             write_rxem_err_hi_cnt
''---------------------------------------------------------------------------------
Class REGISTER_RX_DFE2__SGMIIPCIE_X1_rxemerrhi
    Private write_rxem_err_hi_cnt_value
    Private read_rxem_err_hi_cnt_value
    Private flag_rxem_err_hi_cnt

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

    Property Get get_rxem_err_hi_cnt
        get_rxem_err_hi_cnt = read_rxem_err_hi_cnt_value
    End Property

    Property Let set_rxem_err_hi_cnt(aData)
        write_rxem_err_hi_cnt_value = aData
        flag_rxem_err_hi_cnt        = &H1
    End Property

    Property Get read_rxem_err_hi_cnt
        read
        read_rxem_err_hi_cnt = read_rxem_err_hi_cnt_value
    End Property

    Property Let write_rxem_err_hi_cnt(aData)
        set_rxem_err_hi_cnt = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rxem_err_hi_cnt_mask = &Hffff
        if data_low > LONG_MAX then
            if rxem_err_hi_cnt_mask = mask then
                read_rxem_err_hi_cnt_value = data_low
            else
                read_rxem_err_hi_cnt_value = (data_low - H8000_0000) and rxem_err_hi_cnt_mask
            end If
        else
            read_rxem_err_hi_cnt_value = data_low and rxem_err_hi_cnt_mask
        end If

    End Sub

    Sub write
        If flag_rxem_err_hi_cnt = &H0 Then read
        If flag_rxem_err_hi_cnt = &H0 Then write_rxem_err_hi_cnt_value = get_rxem_err_hi_cnt

        regValue = leftShift((write_rxem_err_hi_cnt_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rxem_err_hi_cnt_mask = &Hffff
        if data_low > LONG_MAX then
            if rxem_err_hi_cnt_mask = mask then
                read_rxem_err_hi_cnt_value = data_low
            else
                read_rxem_err_hi_cnt_value = (data_low - H8000_0000) and rxem_err_hi_cnt_mask
            end If
        else
            read_rxem_err_hi_cnt_value = data_low and rxem_err_hi_cnt_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_rxem_err_hi_cnt_value = &H0
        flag_rxem_err_hi_cnt        = &H0
    End Sub
End Class


'' @REGISTER : RX_DFE2__SGMIIPCIE_X1_rxphsintstatus
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' rx_phs_int_sts                             [15:0]           get_rx_phs_int_sts
''                                                             set_rx_phs_int_sts
''                                                             read_rx_phs_int_sts
''                                                             write_rx_phs_int_sts
''---------------------------------------------------------------------------------
Class REGISTER_RX_DFE2__SGMIIPCIE_X1_rxphsintstatus
    Private write_rx_phs_int_sts_value
    Private read_rx_phs_int_sts_value
    Private flag_rx_phs_int_sts

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

    Property Get get_rx_phs_int_sts
        get_rx_phs_int_sts = read_rx_phs_int_sts_value
    End Property

    Property Let set_rx_phs_int_sts(aData)
        write_rx_phs_int_sts_value = aData
        flag_rx_phs_int_sts        = &H1
    End Property

    Property Get read_rx_phs_int_sts
        read
        read_rx_phs_int_sts = read_rx_phs_int_sts_value
    End Property

    Property Let write_rx_phs_int_sts(aData)
        set_rx_phs_int_sts = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rx_phs_int_sts_mask = &Hffff
        if data_low > LONG_MAX then
            if rx_phs_int_sts_mask = mask then
                read_rx_phs_int_sts_value = data_low
            else
                read_rx_phs_int_sts_value = (data_low - H8000_0000) and rx_phs_int_sts_mask
            end If
        else
            read_rx_phs_int_sts_value = data_low and rx_phs_int_sts_mask
        end If

    End Sub

    Sub write
        If flag_rx_phs_int_sts = &H0 Then read
        If flag_rx_phs_int_sts = &H0 Then write_rx_phs_int_sts_value = get_rx_phs_int_sts

        regValue = leftShift((write_rx_phs_int_sts_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rx_phs_int_sts_mask = &Hffff
        if data_low > LONG_MAX then
            if rx_phs_int_sts_mask = mask then
                read_rx_phs_int_sts_value = data_low
            else
                read_rx_phs_int_sts_value = (data_low - H8000_0000) and rx_phs_int_sts_mask
            end If
        else
            read_rx_phs_int_sts_value = data_low and rx_phs_int_sts_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_rx_phs_int_sts_value = &H0
        flag_rx_phs_int_sts        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class RX_DFE2__SGMIIPCIE_X1_INSTANCE

    Public slcalcontrol0
    Public slcalcontrol1
    Public slcalcontrol2
    Public slcalcontrol3
    Public slcalstatus0
    Public slcalstatus1
    Public emdiagcontrol
    Public rxemerrlo
    Public rxemerrhi
    Public rxphsintstatus


    Public default function Init(aBaseAddr)
        Set slcalcontrol0 = (New REGISTER_RX_DFE2__SGMIIPCIE_X1_slcalcontrol0)(aBaseAddr, 16)
        Set slcalcontrol1 = (New REGISTER_RX_DFE2__SGMIIPCIE_X1_slcalcontrol1)(aBaseAddr, 16)
        Set slcalcontrol2 = (New REGISTER_RX_DFE2__SGMIIPCIE_X1_slcalcontrol2)(aBaseAddr, 16)
        Set slcalcontrol3 = (New REGISTER_RX_DFE2__SGMIIPCIE_X1_slcalcontrol3)(aBaseAddr, 16)
        Set slcalstatus0 = (New REGISTER_RX_DFE2__SGMIIPCIE_X1_slcalstatus0)(aBaseAddr, 16)
        Set slcalstatus1 = (New REGISTER_RX_DFE2__SGMIIPCIE_X1_slcalstatus1)(aBaseAddr, 16)
        Set emdiagcontrol = (New REGISTER_RX_DFE2__SGMIIPCIE_X1_emdiagcontrol)(aBaseAddr, 16)
        Set rxemerrlo = (New REGISTER_RX_DFE2__SGMIIPCIE_X1_rxemerrlo)(aBaseAddr, 16)
        Set rxemerrhi = (New REGISTER_RX_DFE2__SGMIIPCIE_X1_rxemerrhi)(aBaseAddr, 16)
        Set rxphsintstatus = (New REGISTER_RX_DFE2__SGMIIPCIE_X1_rxphsintstatus)(aBaseAddr, 16)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set RX_DFE2__SGMIIPCIE_X1 = CreateObject("System.Collections.ArrayList")
RX_DFE2__SGMIIPCIE_X1.Add ((New RX_DFE2__SGMIIPCIE_X1_INSTANCE)(&H4adee400))


