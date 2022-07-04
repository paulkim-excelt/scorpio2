

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


'' @REGISTER : RX_DFE1__SGMIIPCIE_X1_lmtcalcontrol0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' lmtcal_max_adj                             [15:11]          get_lmtcal_max_adj
''                                                             set_lmtcal_max_adj
''                                                             read_lmtcal_max_adj
''                                                             write_lmtcal_max_adj
''---------------------------------------------------------------------------------
'' lmtcal_intv_time                           [10:0]           get_lmtcal_intv_time
''                                                             set_lmtcal_intv_time
''                                                             read_lmtcal_intv_time
''                                                             write_lmtcal_intv_time
''---------------------------------------------------------------------------------
Class REGISTER_RX_DFE1__SGMIIPCIE_X1_lmtcalcontrol0
    Private write_lmtcal_max_adj_value
    Private read_lmtcal_max_adj_value
    Private flag_lmtcal_max_adj
    Private write_lmtcal_intv_time_value
    Private read_lmtcal_intv_time_value
    Private flag_lmtcal_intv_time

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

    Property Get get_lmtcal_max_adj
        get_lmtcal_max_adj = read_lmtcal_max_adj_value
    End Property

    Property Let set_lmtcal_max_adj(aData)
        write_lmtcal_max_adj_value = aData
        flag_lmtcal_max_adj        = &H1
    End Property

    Property Get read_lmtcal_max_adj
        read
        read_lmtcal_max_adj = read_lmtcal_max_adj_value
    End Property

    Property Let write_lmtcal_max_adj(aData)
        set_lmtcal_max_adj = aData
        write
    End Property

    Property Get get_lmtcal_intv_time
        get_lmtcal_intv_time = read_lmtcal_intv_time_value
    End Property

    Property Let set_lmtcal_intv_time(aData)
        write_lmtcal_intv_time_value = aData
        flag_lmtcal_intv_time        = &H1
    End Property

    Property Get read_lmtcal_intv_time
        read
        read_lmtcal_intv_time = read_lmtcal_intv_time_value
    End Property

    Property Let write_lmtcal_intv_time(aData)
        set_lmtcal_intv_time = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_lmtcal_max_adj_value = rightShift(data_low, 11) and &H1f
        lmtcal_intv_time_mask = &H7ff
        if data_low > LONG_MAX then
            if lmtcal_intv_time_mask = mask then
                read_lmtcal_intv_time_value = data_low
            else
                read_lmtcal_intv_time_value = (data_low - H8000_0000) and lmtcal_intv_time_mask
            end If
        else
            read_lmtcal_intv_time_value = data_low and lmtcal_intv_time_mask
        end If

    End Sub

    Sub write
        If flag_lmtcal_max_adj = &H0 or flag_lmtcal_intv_time = &H0 Then read
        If flag_lmtcal_max_adj = &H0 Then write_lmtcal_max_adj_value = get_lmtcal_max_adj
        If flag_lmtcal_intv_time = &H0 Then write_lmtcal_intv_time_value = get_lmtcal_intv_time

        regValue = leftShift((write_lmtcal_max_adj_value and &H1f), 11) + leftShift((write_lmtcal_intv_time_value and &H7ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_lmtcal_max_adj_value = rightShift(data_low, 11) and &H1f
        lmtcal_intv_time_mask = &H7ff
        if data_low > LONG_MAX then
            if lmtcal_intv_time_mask = mask then
                read_lmtcal_intv_time_value = data_low
            else
                read_lmtcal_intv_time_value = (data_low - H8000_0000) and lmtcal_intv_time_mask
            end If
        else
            read_lmtcal_intv_time_value = data_low and lmtcal_intv_time_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_lmtcal_max_adj_value = &H0
        flag_lmtcal_max_adj        = &H0
        write_lmtcal_intv_time_value = &H0
        flag_lmtcal_intv_time        = &H0
    End Sub
End Class


'' @REGISTER : RX_DFE1__SGMIIPCIE_X1_lmtcalcontrol1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' lmtcal_falling_edge_en                     [15:15]          get_lmtcal_falling_edge_en
''                                                             set_lmtcal_falling_edge_en
''                                                             read_lmtcal_falling_edge_en
''                                                             write_lmtcal_falling_edge_en
''---------------------------------------------------------------------------------
'' lmtcal_rising_edge_en                      [14:14]          get_lmtcal_rising_edge_en
''                                                             set_lmtcal_rising_edge_en
''                                                             read_lmtcal_rising_edge_en
''                                                             write_lmtcal_rising_edge_en
''---------------------------------------------------------------------------------
'' lmtcal_kp                                  [13:12]          get_lmtcal_kp
''                                                             set_lmtcal_kp
''                                                             read_lmtcal_kp
''                                                             write_lmtcal_kp
''---------------------------------------------------------------------------------
'' lmtcal_adj_dir                             [11:11]          get_lmtcal_adj_dir
''                                                             set_lmtcal_adj_dir
''                                                             read_lmtcal_adj_dir
''                                                             write_lmtcal_adj_dir
''---------------------------------------------------------------------------------
'' lmtcal_init_time                           [10:0]           get_lmtcal_init_time
''                                                             set_lmtcal_init_time
''                                                             read_lmtcal_init_time
''                                                             write_lmtcal_init_time
''---------------------------------------------------------------------------------
Class REGISTER_RX_DFE1__SGMIIPCIE_X1_lmtcalcontrol1
    Private write_lmtcal_falling_edge_en_value
    Private read_lmtcal_falling_edge_en_value
    Private flag_lmtcal_falling_edge_en
    Private write_lmtcal_rising_edge_en_value
    Private read_lmtcal_rising_edge_en_value
    Private flag_lmtcal_rising_edge_en
    Private write_lmtcal_kp_value
    Private read_lmtcal_kp_value
    Private flag_lmtcal_kp
    Private write_lmtcal_adj_dir_value
    Private read_lmtcal_adj_dir_value
    Private flag_lmtcal_adj_dir
    Private write_lmtcal_init_time_value
    Private read_lmtcal_init_time_value
    Private flag_lmtcal_init_time

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

    Property Get get_lmtcal_falling_edge_en
        get_lmtcal_falling_edge_en = read_lmtcal_falling_edge_en_value
    End Property

    Property Let set_lmtcal_falling_edge_en(aData)
        write_lmtcal_falling_edge_en_value = aData
        flag_lmtcal_falling_edge_en        = &H1
    End Property

    Property Get read_lmtcal_falling_edge_en
        read
        read_lmtcal_falling_edge_en = read_lmtcal_falling_edge_en_value
    End Property

    Property Let write_lmtcal_falling_edge_en(aData)
        set_lmtcal_falling_edge_en = aData
        write
    End Property

    Property Get get_lmtcal_rising_edge_en
        get_lmtcal_rising_edge_en = read_lmtcal_rising_edge_en_value
    End Property

    Property Let set_lmtcal_rising_edge_en(aData)
        write_lmtcal_rising_edge_en_value = aData
        flag_lmtcal_rising_edge_en        = &H1
    End Property

    Property Get read_lmtcal_rising_edge_en
        read
        read_lmtcal_rising_edge_en = read_lmtcal_rising_edge_en_value
    End Property

    Property Let write_lmtcal_rising_edge_en(aData)
        set_lmtcal_rising_edge_en = aData
        write
    End Property

    Property Get get_lmtcal_kp
        get_lmtcal_kp = read_lmtcal_kp_value
    End Property

    Property Let set_lmtcal_kp(aData)
        write_lmtcal_kp_value = aData
        flag_lmtcal_kp        = &H1
    End Property

    Property Get read_lmtcal_kp
        read
        read_lmtcal_kp = read_lmtcal_kp_value
    End Property

    Property Let write_lmtcal_kp(aData)
        set_lmtcal_kp = aData
        write
    End Property

    Property Get get_lmtcal_adj_dir
        get_lmtcal_adj_dir = read_lmtcal_adj_dir_value
    End Property

    Property Let set_lmtcal_adj_dir(aData)
        write_lmtcal_adj_dir_value = aData
        flag_lmtcal_adj_dir        = &H1
    End Property

    Property Get read_lmtcal_adj_dir
        read
        read_lmtcal_adj_dir = read_lmtcal_adj_dir_value
    End Property

    Property Let write_lmtcal_adj_dir(aData)
        set_lmtcal_adj_dir = aData
        write
    End Property

    Property Get get_lmtcal_init_time
        get_lmtcal_init_time = read_lmtcal_init_time_value
    End Property

    Property Let set_lmtcal_init_time(aData)
        write_lmtcal_init_time_value = aData
        flag_lmtcal_init_time        = &H1
    End Property

    Property Get read_lmtcal_init_time
        read
        read_lmtcal_init_time = read_lmtcal_init_time_value
    End Property

    Property Let write_lmtcal_init_time(aData)
        set_lmtcal_init_time = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_lmtcal_falling_edge_en_value = rightShift(data_low, 15) and &H1
        read_lmtcal_rising_edge_en_value = rightShift(data_low, 14) and &H1
        read_lmtcal_kp_value = rightShift(data_low, 12) and &H3
        read_lmtcal_adj_dir_value = rightShift(data_low, 11) and &H1
        lmtcal_init_time_mask = &H7ff
        if data_low > LONG_MAX then
            if lmtcal_init_time_mask = mask then
                read_lmtcal_init_time_value = data_low
            else
                read_lmtcal_init_time_value = (data_low - H8000_0000) and lmtcal_init_time_mask
            end If
        else
            read_lmtcal_init_time_value = data_low and lmtcal_init_time_mask
        end If

    End Sub

    Sub write
        If flag_lmtcal_falling_edge_en = &H0 or flag_lmtcal_rising_edge_en = &H0 or flag_lmtcal_kp = &H0 or flag_lmtcal_adj_dir = &H0 or flag_lmtcal_init_time = &H0 Then read
        If flag_lmtcal_falling_edge_en = &H0 Then write_lmtcal_falling_edge_en_value = get_lmtcal_falling_edge_en
        If flag_lmtcal_rising_edge_en = &H0 Then write_lmtcal_rising_edge_en_value = get_lmtcal_rising_edge_en
        If flag_lmtcal_kp = &H0 Then write_lmtcal_kp_value = get_lmtcal_kp
        If flag_lmtcal_adj_dir = &H0 Then write_lmtcal_adj_dir_value = get_lmtcal_adj_dir
        If flag_lmtcal_init_time = &H0 Then write_lmtcal_init_time_value = get_lmtcal_init_time

        regValue = leftShift((write_lmtcal_falling_edge_en_value and &H1), 15) + leftShift((write_lmtcal_rising_edge_en_value and &H1), 14) + leftShift((write_lmtcal_kp_value and &H3), 12) + leftShift((write_lmtcal_adj_dir_value and &H1), 11) + leftShift((write_lmtcal_init_time_value and &H7ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_lmtcal_falling_edge_en_value = rightShift(data_low, 15) and &H1
        read_lmtcal_rising_edge_en_value = rightShift(data_low, 14) and &H1
        read_lmtcal_kp_value = rightShift(data_low, 12) and &H3
        read_lmtcal_adj_dir_value = rightShift(data_low, 11) and &H1
        lmtcal_init_time_mask = &H7ff
        if data_low > LONG_MAX then
            if lmtcal_init_time_mask = mask then
                read_lmtcal_init_time_value = data_low
            else
                read_lmtcal_init_time_value = (data_low - H8000_0000) and lmtcal_init_time_mask
            end If
        else
            read_lmtcal_init_time_value = data_low and lmtcal_init_time_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_lmtcal_falling_edge_en_value = &H0
        flag_lmtcal_falling_edge_en        = &H0
        write_lmtcal_rising_edge_en_value = &H0
        flag_lmtcal_rising_edge_en        = &H0
        write_lmtcal_kp_value = &H0
        flag_lmtcal_kp        = &H0
        write_lmtcal_adj_dir_value = &H0
        flag_lmtcal_adj_dir        = &H0
        write_lmtcal_init_time_value = &H0
        flag_lmtcal_init_time        = &H0
    End Sub
End Class


'' @REGISTER : RX_DFE1__SGMIIPCIE_X1_lmtcalcontrol2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' lmtcal_pd_polarity                         [15:15]          get_lmtcal_pd_polarity
''                                                             set_lmtcal_pd_polarity
''                                                             read_lmtcal_pd_polarity
''                                                             write_lmtcal_pd_polarity
''---------------------------------------------------------------------------------
'' lmtcal_acc_time                            [14:4]           get_lmtcal_acc_time
''                                                             set_lmtcal_acc_time
''                                                             read_lmtcal_acc_time
''                                                             write_lmtcal_acc_time
''---------------------------------------------------------------------------------
'' lmtcal_en_ovrd                             [3:3]            get_lmtcal_en_ovrd
''                                                             set_lmtcal_en_ovrd
''                                                             read_lmtcal_en_ovrd
''                                                             write_lmtcal_en_ovrd
''---------------------------------------------------------------------------------
'' lmtcal_en_ovrd_val                         [2:2]            get_lmtcal_en_ovrd_val
''                                                             set_lmtcal_en_ovrd_val
''                                                             read_lmtcal_en_ovrd_val
''                                                             write_lmtcal_en_ovrd_val
''---------------------------------------------------------------------------------
'' lmtcal_done_ovrd                           [1:1]            get_lmtcal_done_ovrd
''                                                             set_lmtcal_done_ovrd
''                                                             read_lmtcal_done_ovrd
''                                                             write_lmtcal_done_ovrd
''---------------------------------------------------------------------------------
'' lmtcal_done_ovrd_val                       [0:0]            get_lmtcal_done_ovrd_val
''                                                             set_lmtcal_done_ovrd_val
''                                                             read_lmtcal_done_ovrd_val
''                                                             write_lmtcal_done_ovrd_val
''---------------------------------------------------------------------------------
Class REGISTER_RX_DFE1__SGMIIPCIE_X1_lmtcalcontrol2
    Private write_lmtcal_pd_polarity_value
    Private read_lmtcal_pd_polarity_value
    Private flag_lmtcal_pd_polarity
    Private write_lmtcal_acc_time_value
    Private read_lmtcal_acc_time_value
    Private flag_lmtcal_acc_time
    Private write_lmtcal_en_ovrd_value
    Private read_lmtcal_en_ovrd_value
    Private flag_lmtcal_en_ovrd
    Private write_lmtcal_en_ovrd_val_value
    Private read_lmtcal_en_ovrd_val_value
    Private flag_lmtcal_en_ovrd_val
    Private write_lmtcal_done_ovrd_value
    Private read_lmtcal_done_ovrd_value
    Private flag_lmtcal_done_ovrd
    Private write_lmtcal_done_ovrd_val_value
    Private read_lmtcal_done_ovrd_val_value
    Private flag_lmtcal_done_ovrd_val

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

    Property Get get_lmtcal_pd_polarity
        get_lmtcal_pd_polarity = read_lmtcal_pd_polarity_value
    End Property

    Property Let set_lmtcal_pd_polarity(aData)
        write_lmtcal_pd_polarity_value = aData
        flag_lmtcal_pd_polarity        = &H1
    End Property

    Property Get read_lmtcal_pd_polarity
        read
        read_lmtcal_pd_polarity = read_lmtcal_pd_polarity_value
    End Property

    Property Let write_lmtcal_pd_polarity(aData)
        set_lmtcal_pd_polarity = aData
        write
    End Property

    Property Get get_lmtcal_acc_time
        get_lmtcal_acc_time = read_lmtcal_acc_time_value
    End Property

    Property Let set_lmtcal_acc_time(aData)
        write_lmtcal_acc_time_value = aData
        flag_lmtcal_acc_time        = &H1
    End Property

    Property Get read_lmtcal_acc_time
        read
        read_lmtcal_acc_time = read_lmtcal_acc_time_value
    End Property

    Property Let write_lmtcal_acc_time(aData)
        set_lmtcal_acc_time = aData
        write
    End Property

    Property Get get_lmtcal_en_ovrd
        get_lmtcal_en_ovrd = read_lmtcal_en_ovrd_value
    End Property

    Property Let set_lmtcal_en_ovrd(aData)
        write_lmtcal_en_ovrd_value = aData
        flag_lmtcal_en_ovrd        = &H1
    End Property

    Property Get read_lmtcal_en_ovrd
        read
        read_lmtcal_en_ovrd = read_lmtcal_en_ovrd_value
    End Property

    Property Let write_lmtcal_en_ovrd(aData)
        set_lmtcal_en_ovrd = aData
        write
    End Property

    Property Get get_lmtcal_en_ovrd_val
        get_lmtcal_en_ovrd_val = read_lmtcal_en_ovrd_val_value
    End Property

    Property Let set_lmtcal_en_ovrd_val(aData)
        write_lmtcal_en_ovrd_val_value = aData
        flag_lmtcal_en_ovrd_val        = &H1
    End Property

    Property Get read_lmtcal_en_ovrd_val
        read
        read_lmtcal_en_ovrd_val = read_lmtcal_en_ovrd_val_value
    End Property

    Property Let write_lmtcal_en_ovrd_val(aData)
        set_lmtcal_en_ovrd_val = aData
        write
    End Property

    Property Get get_lmtcal_done_ovrd
        get_lmtcal_done_ovrd = read_lmtcal_done_ovrd_value
    End Property

    Property Let set_lmtcal_done_ovrd(aData)
        write_lmtcal_done_ovrd_value = aData
        flag_lmtcal_done_ovrd        = &H1
    End Property

    Property Get read_lmtcal_done_ovrd
        read
        read_lmtcal_done_ovrd = read_lmtcal_done_ovrd_value
    End Property

    Property Let write_lmtcal_done_ovrd(aData)
        set_lmtcal_done_ovrd = aData
        write
    End Property

    Property Get get_lmtcal_done_ovrd_val
        get_lmtcal_done_ovrd_val = read_lmtcal_done_ovrd_val_value
    End Property

    Property Let set_lmtcal_done_ovrd_val(aData)
        write_lmtcal_done_ovrd_val_value = aData
        flag_lmtcal_done_ovrd_val        = &H1
    End Property

    Property Get read_lmtcal_done_ovrd_val
        read
        read_lmtcal_done_ovrd_val = read_lmtcal_done_ovrd_val_value
    End Property

    Property Let write_lmtcal_done_ovrd_val(aData)
        set_lmtcal_done_ovrd_val = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_lmtcal_pd_polarity_value = rightShift(data_low, 15) and &H1
        read_lmtcal_acc_time_value = rightShift(data_low, 4) and &H7ff
        read_lmtcal_en_ovrd_value = rightShift(data_low, 3) and &H1
        read_lmtcal_en_ovrd_val_value = rightShift(data_low, 2) and &H1
        read_lmtcal_done_ovrd_value = rightShift(data_low, 1) and &H1
        lmtcal_done_ovrd_val_mask = &H1
        if data_low > LONG_MAX then
            if lmtcal_done_ovrd_val_mask = mask then
                read_lmtcal_done_ovrd_val_value = data_low
            else
                read_lmtcal_done_ovrd_val_value = (data_low - H8000_0000) and lmtcal_done_ovrd_val_mask
            end If
        else
            read_lmtcal_done_ovrd_val_value = data_low and lmtcal_done_ovrd_val_mask
        end If

    End Sub

    Sub write
        If flag_lmtcal_pd_polarity = &H0 or flag_lmtcal_acc_time = &H0 or flag_lmtcal_en_ovrd = &H0 or flag_lmtcal_en_ovrd_val = &H0 or flag_lmtcal_done_ovrd = &H0 or flag_lmtcal_done_ovrd_val = &H0 Then read
        If flag_lmtcal_pd_polarity = &H0 Then write_lmtcal_pd_polarity_value = get_lmtcal_pd_polarity
        If flag_lmtcal_acc_time = &H0 Then write_lmtcal_acc_time_value = get_lmtcal_acc_time
        If flag_lmtcal_en_ovrd = &H0 Then write_lmtcal_en_ovrd_value = get_lmtcal_en_ovrd
        If flag_lmtcal_en_ovrd_val = &H0 Then write_lmtcal_en_ovrd_val_value = get_lmtcal_en_ovrd_val
        If flag_lmtcal_done_ovrd = &H0 Then write_lmtcal_done_ovrd_value = get_lmtcal_done_ovrd
        If flag_lmtcal_done_ovrd_val = &H0 Then write_lmtcal_done_ovrd_val_value = get_lmtcal_done_ovrd_val

        regValue = leftShift((write_lmtcal_pd_polarity_value and &H1), 15) + leftShift((write_lmtcal_acc_time_value and &H7ff), 4) + leftShift((write_lmtcal_en_ovrd_value and &H1), 3) + leftShift((write_lmtcal_en_ovrd_val_value and &H1), 2) + leftShift((write_lmtcal_done_ovrd_value and &H1), 1) + leftShift((write_lmtcal_done_ovrd_val_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_lmtcal_pd_polarity_value = rightShift(data_low, 15) and &H1
        read_lmtcal_acc_time_value = rightShift(data_low, 4) and &H7ff
        read_lmtcal_en_ovrd_value = rightShift(data_low, 3) and &H1
        read_lmtcal_en_ovrd_val_value = rightShift(data_low, 2) and &H1
        read_lmtcal_done_ovrd_value = rightShift(data_low, 1) and &H1
        lmtcal_done_ovrd_val_mask = &H1
        if data_low > LONG_MAX then
            if lmtcal_done_ovrd_val_mask = mask then
                read_lmtcal_done_ovrd_val_value = data_low
            else
                read_lmtcal_done_ovrd_val_value = (data_low - H8000_0000) and lmtcal_done_ovrd_val_mask
            end If
        else
            read_lmtcal_done_ovrd_val_value = data_low and lmtcal_done_ovrd_val_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_lmtcal_pd_polarity_value = &H0
        flag_lmtcal_pd_polarity        = &H0
        write_lmtcal_acc_time_value = &H0
        flag_lmtcal_acc_time        = &H0
        write_lmtcal_en_ovrd_value = &H0
        flag_lmtcal_en_ovrd        = &H0
        write_lmtcal_en_ovrd_val_value = &H0
        flag_lmtcal_en_ovrd_val        = &H0
        write_lmtcal_done_ovrd_value = &H0
        flag_lmtcal_done_ovrd        = &H0
        write_lmtcal_done_ovrd_val_value = &H0
        flag_lmtcal_done_ovrd_val        = &H0
    End Sub
End Class


'' @REGISTER : RX_DFE1__SGMIIPCIE_X1_lmtcalcontrol3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' recal_pos_thres                            [15:0]           get_recal_pos_thres
''                                                             set_recal_pos_thres
''                                                             read_recal_pos_thres
''                                                             write_recal_pos_thres
''---------------------------------------------------------------------------------
Class REGISTER_RX_DFE1__SGMIIPCIE_X1_lmtcalcontrol3
    Private write_recal_pos_thres_value
    Private read_recal_pos_thres_value
    Private flag_recal_pos_thres

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

    Property Get get_recal_pos_thres
        get_recal_pos_thres = read_recal_pos_thres_value
    End Property

    Property Let set_recal_pos_thres(aData)
        write_recal_pos_thres_value = aData
        flag_recal_pos_thres        = &H1
    End Property

    Property Get read_recal_pos_thres
        read
        read_recal_pos_thres = read_recal_pos_thres_value
    End Property

    Property Let write_recal_pos_thres(aData)
        set_recal_pos_thres = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        recal_pos_thres_mask = &Hffff
        if data_low > LONG_MAX then
            if recal_pos_thres_mask = mask then
                read_recal_pos_thres_value = data_low
            else
                read_recal_pos_thres_value = (data_low - H8000_0000) and recal_pos_thres_mask
            end If
        else
            read_recal_pos_thres_value = data_low and recal_pos_thres_mask
        end If

    End Sub

    Sub write
        If flag_recal_pos_thres = &H0 Then read
        If flag_recal_pos_thres = &H0 Then write_recal_pos_thres_value = get_recal_pos_thres

        regValue = leftShift((write_recal_pos_thres_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        recal_pos_thres_mask = &Hffff
        if data_low > LONG_MAX then
            if recal_pos_thres_mask = mask then
                read_recal_pos_thres_value = data_low
            else
                read_recal_pos_thres_value = (data_low - H8000_0000) and recal_pos_thres_mask
            end If
        else
            read_recal_pos_thres_value = data_low and recal_pos_thres_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_recal_pos_thres_value = &H0
        flag_recal_pos_thres        = &H0
    End Sub
End Class


'' @REGISTER : RX_DFE1__SGMIIPCIE_X1_lmtcalcontrol4
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' recal_neg_thres                            [15:0]           get_recal_neg_thres
''                                                             set_recal_neg_thres
''                                                             read_recal_neg_thres
''                                                             write_recal_neg_thres
''---------------------------------------------------------------------------------
Class REGISTER_RX_DFE1__SGMIIPCIE_X1_lmtcalcontrol4
    Private write_recal_neg_thres_value
    Private read_recal_neg_thres_value
    Private flag_recal_neg_thres

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

    Property Get get_recal_neg_thres
        get_recal_neg_thres = read_recal_neg_thres_value
    End Property

    Property Let set_recal_neg_thres(aData)
        write_recal_neg_thres_value = aData
        flag_recal_neg_thres        = &H1
    End Property

    Property Get read_recal_neg_thres
        read
        read_recal_neg_thres = read_recal_neg_thres_value
    End Property

    Property Let write_recal_neg_thres(aData)
        set_recal_neg_thres = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        recal_neg_thres_mask = &Hffff
        if data_low > LONG_MAX then
            if recal_neg_thres_mask = mask then
                read_recal_neg_thres_value = data_low
            else
                read_recal_neg_thres_value = (data_low - H8000_0000) and recal_neg_thres_mask
            end If
        else
            read_recal_neg_thres_value = data_low and recal_neg_thres_mask
        end If

    End Sub

    Sub write
        If flag_recal_neg_thres = &H0 Then read
        If flag_recal_neg_thres = &H0 Then write_recal_neg_thres_value = get_recal_neg_thres

        regValue = leftShift((write_recal_neg_thres_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        recal_neg_thres_mask = &Hffff
        if data_low > LONG_MAX then
            if recal_neg_thres_mask = mask then
                read_recal_neg_thres_value = data_low
            else
                read_recal_neg_thres_value = (data_low - H8000_0000) and recal_neg_thres_mask
            end If
        else
            read_recal_neg_thres_value = data_low and recal_neg_thres_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_recal_neg_thres_value = &H0
        flag_recal_neg_thres        = &H0
    End Sub
End Class


'' @REGISTER : RX_DFE1__SGMIIPCIE_X1_lmtcalcontrol5
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' lmtcal_cont_acc_time                       [11:1]           get_lmtcal_cont_acc_time
''                                                             set_lmtcal_cont_acc_time
''                                                             read_lmtcal_cont_acc_time
''                                                             write_lmtcal_cont_acc_time
''---------------------------------------------------------------------------------
'' cont_lmtcal_en                             [0:0]            get_cont_lmtcal_en
''                                                             set_cont_lmtcal_en
''                                                             read_cont_lmtcal_en
''                                                             write_cont_lmtcal_en
''---------------------------------------------------------------------------------
Class REGISTER_RX_DFE1__SGMIIPCIE_X1_lmtcalcontrol5
    Private write_lmtcal_cont_acc_time_value
    Private read_lmtcal_cont_acc_time_value
    Private flag_lmtcal_cont_acc_time
    Private write_cont_lmtcal_en_value
    Private read_cont_lmtcal_en_value
    Private flag_cont_lmtcal_en

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

    Property Get get_lmtcal_cont_acc_time
        get_lmtcal_cont_acc_time = read_lmtcal_cont_acc_time_value
    End Property

    Property Let set_lmtcal_cont_acc_time(aData)
        write_lmtcal_cont_acc_time_value = aData
        flag_lmtcal_cont_acc_time        = &H1
    End Property

    Property Get read_lmtcal_cont_acc_time
        read
        read_lmtcal_cont_acc_time = read_lmtcal_cont_acc_time_value
    End Property

    Property Let write_lmtcal_cont_acc_time(aData)
        set_lmtcal_cont_acc_time = aData
        write
    End Property

    Property Get get_cont_lmtcal_en
        get_cont_lmtcal_en = read_cont_lmtcal_en_value
    End Property

    Property Let set_cont_lmtcal_en(aData)
        write_cont_lmtcal_en_value = aData
        flag_cont_lmtcal_en        = &H1
    End Property

    Property Get read_cont_lmtcal_en
        read
        read_cont_lmtcal_en = read_cont_lmtcal_en_value
    End Property

    Property Let write_cont_lmtcal_en(aData)
        set_cont_lmtcal_en = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_lmtcal_cont_acc_time_value = rightShift(data_low, 1) and &H7ff
        cont_lmtcal_en_mask = &H1
        if data_low > LONG_MAX then
            if cont_lmtcal_en_mask = mask then
                read_cont_lmtcal_en_value = data_low
            else
                read_cont_lmtcal_en_value = (data_low - H8000_0000) and cont_lmtcal_en_mask
            end If
        else
            read_cont_lmtcal_en_value = data_low and cont_lmtcal_en_mask
        end If

    End Sub

    Sub write
        If flag_lmtcal_cont_acc_time = &H0 or flag_cont_lmtcal_en = &H0 Then read
        If flag_lmtcal_cont_acc_time = &H0 Then write_lmtcal_cont_acc_time_value = get_lmtcal_cont_acc_time
        If flag_cont_lmtcal_en = &H0 Then write_cont_lmtcal_en_value = get_cont_lmtcal_en

        regValue = leftShift((write_lmtcal_cont_acc_time_value and &H7ff), 1) + leftShift((write_cont_lmtcal_en_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_lmtcal_cont_acc_time_value = rightShift(data_low, 1) and &H7ff
        cont_lmtcal_en_mask = &H1
        if data_low > LONG_MAX then
            if cont_lmtcal_en_mask = mask then
                read_cont_lmtcal_en_value = data_low
            else
                read_cont_lmtcal_en_value = (data_low - H8000_0000) and cont_lmtcal_en_mask
            end If
        else
            read_cont_lmtcal_en_value = data_low and cont_lmtcal_en_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_lmtcal_cont_acc_time_value = &H0
        flag_lmtcal_cont_acc_time        = &H0
        write_cont_lmtcal_en_value = &H0
        flag_cont_lmtcal_en        = &H0
    End Sub
End Class


'' @REGISTER : RX_DFE1__SGMIIPCIE_X1_lmtcalcontrol6
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' lmtcal_interval_time                       [11:7]           get_lmtcal_interval_time
''                                                             set_lmtcal_interval_time
''                                                             read_lmtcal_interval_time
''                                                             write_lmtcal_interval_time
''---------------------------------------------------------------------------------
'' rx_lmtoff_ovrd                             [6:6]            get_rx_lmtoff_ovrd
''                                                             set_rx_lmtoff_ovrd
''                                                             read_rx_lmtoff_ovrd
''                                                             write_rx_lmtoff_ovrd
''---------------------------------------------------------------------------------
'' rx_lmtoff_ovrd_val                         [5:0]            get_rx_lmtoff_ovrd_val
''                                                             set_rx_lmtoff_ovrd_val
''                                                             read_rx_lmtoff_ovrd_val
''                                                             write_rx_lmtoff_ovrd_val
''---------------------------------------------------------------------------------
Class REGISTER_RX_DFE1__SGMIIPCIE_X1_lmtcalcontrol6
    Private write_lmtcal_interval_time_value
    Private read_lmtcal_interval_time_value
    Private flag_lmtcal_interval_time
    Private write_rx_lmtoff_ovrd_value
    Private read_rx_lmtoff_ovrd_value
    Private flag_rx_lmtoff_ovrd
    Private write_rx_lmtoff_ovrd_val_value
    Private read_rx_lmtoff_ovrd_val_value
    Private flag_rx_lmtoff_ovrd_val

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

    Property Get get_lmtcal_interval_time
        get_lmtcal_interval_time = read_lmtcal_interval_time_value
    End Property

    Property Let set_lmtcal_interval_time(aData)
        write_lmtcal_interval_time_value = aData
        flag_lmtcal_interval_time        = &H1
    End Property

    Property Get read_lmtcal_interval_time
        read
        read_lmtcal_interval_time = read_lmtcal_interval_time_value
    End Property

    Property Let write_lmtcal_interval_time(aData)
        set_lmtcal_interval_time = aData
        write
    End Property

    Property Get get_rx_lmtoff_ovrd
        get_rx_lmtoff_ovrd = read_rx_lmtoff_ovrd_value
    End Property

    Property Let set_rx_lmtoff_ovrd(aData)
        write_rx_lmtoff_ovrd_value = aData
        flag_rx_lmtoff_ovrd        = &H1
    End Property

    Property Get read_rx_lmtoff_ovrd
        read
        read_rx_lmtoff_ovrd = read_rx_lmtoff_ovrd_value
    End Property

    Property Let write_rx_lmtoff_ovrd(aData)
        set_rx_lmtoff_ovrd = aData
        write
    End Property

    Property Get get_rx_lmtoff_ovrd_val
        get_rx_lmtoff_ovrd_val = read_rx_lmtoff_ovrd_val_value
    End Property

    Property Let set_rx_lmtoff_ovrd_val(aData)
        write_rx_lmtoff_ovrd_val_value = aData
        flag_rx_lmtoff_ovrd_val        = &H1
    End Property

    Property Get read_rx_lmtoff_ovrd_val
        read
        read_rx_lmtoff_ovrd_val = read_rx_lmtoff_ovrd_val_value
    End Property

    Property Let write_rx_lmtoff_ovrd_val(aData)
        set_rx_lmtoff_ovrd_val = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_lmtcal_interval_time_value = rightShift(data_low, 7) and &H1f
        read_rx_lmtoff_ovrd_value = rightShift(data_low, 6) and &H1
        rx_lmtoff_ovrd_val_mask = &H3f
        if data_low > LONG_MAX then
            if rx_lmtoff_ovrd_val_mask = mask then
                read_rx_lmtoff_ovrd_val_value = data_low
            else
                read_rx_lmtoff_ovrd_val_value = (data_low - H8000_0000) and rx_lmtoff_ovrd_val_mask
            end If
        else
            read_rx_lmtoff_ovrd_val_value = data_low and rx_lmtoff_ovrd_val_mask
        end If

    End Sub

    Sub write
        If flag_lmtcal_interval_time = &H0 or flag_rx_lmtoff_ovrd = &H0 or flag_rx_lmtoff_ovrd_val = &H0 Then read
        If flag_lmtcal_interval_time = &H0 Then write_lmtcal_interval_time_value = get_lmtcal_interval_time
        If flag_rx_lmtoff_ovrd = &H0 Then write_rx_lmtoff_ovrd_value = get_rx_lmtoff_ovrd
        If flag_rx_lmtoff_ovrd_val = &H0 Then write_rx_lmtoff_ovrd_val_value = get_rx_lmtoff_ovrd_val

        regValue = leftShift((write_lmtcal_interval_time_value and &H1f), 7) + leftShift((write_rx_lmtoff_ovrd_value and &H1), 6) + leftShift((write_rx_lmtoff_ovrd_val_value and &H3f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_lmtcal_interval_time_value = rightShift(data_low, 7) and &H1f
        read_rx_lmtoff_ovrd_value = rightShift(data_low, 6) and &H1
        rx_lmtoff_ovrd_val_mask = &H3f
        if data_low > LONG_MAX then
            if rx_lmtoff_ovrd_val_mask = mask then
                read_rx_lmtoff_ovrd_val_value = data_low
            else
                read_rx_lmtoff_ovrd_val_value = (data_low - H8000_0000) and rx_lmtoff_ovrd_val_mask
            end If
        else
            read_rx_lmtoff_ovrd_val_value = data_low and rx_lmtoff_ovrd_val_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_lmtcal_interval_time_value = &H0
        flag_lmtcal_interval_time        = &H0
        write_rx_lmtoff_ovrd_value = &H0
        flag_rx_lmtoff_ovrd        = &H0
        write_rx_lmtoff_ovrd_val_value = &H0
        flag_rx_lmtoff_ovrd_val        = &H0
    End Sub
End Class


'' @REGISTER : RX_DFE1__SGMIIPCIE_X1_lmtcalstatus0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' rx_lmtoff                                  [15:10]          get_rx_lmtoff
''                                                             set_rx_lmtoff
''                                                             read_rx_lmtoff
''                                                             write_rx_lmtoff
''---------------------------------------------------------------------------------
'' lmtcal_valid                               [9:9]            get_lmtcal_valid
''                                                             set_lmtcal_valid
''                                                             read_lmtcal_valid
''                                                             write_lmtcal_valid
''---------------------------------------------------------------------------------
'' lmtcal_done                                [8:8]            get_lmtcal_done
''                                                             set_lmtcal_done
''                                                             read_lmtcal_done
''                                                             write_lmtcal_done
''---------------------------------------------------------------------------------
'' lmtcal_adj_cnt                             [7:3]            get_lmtcal_adj_cnt
''                                                             set_lmtcal_adj_cnt
''                                                             read_lmtcal_adj_cnt
''                                                             write_lmtcal_adj_cnt
''---------------------------------------------------------------------------------
'' lmtcal_state                               [2:0]            get_lmtcal_state
''                                                             set_lmtcal_state
''                                                             read_lmtcal_state
''                                                             write_lmtcal_state
''---------------------------------------------------------------------------------
Class REGISTER_RX_DFE1__SGMIIPCIE_X1_lmtcalstatus0
    Private write_rx_lmtoff_value
    Private read_rx_lmtoff_value
    Private flag_rx_lmtoff
    Private write_lmtcal_valid_value
    Private read_lmtcal_valid_value
    Private flag_lmtcal_valid
    Private write_lmtcal_done_value
    Private read_lmtcal_done_value
    Private flag_lmtcal_done
    Private write_lmtcal_adj_cnt_value
    Private read_lmtcal_adj_cnt_value
    Private flag_lmtcal_adj_cnt
    Private write_lmtcal_state_value
    Private read_lmtcal_state_value
    Private flag_lmtcal_state

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

    Property Get get_rx_lmtoff
        get_rx_lmtoff = read_rx_lmtoff_value
    End Property

    Property Let set_rx_lmtoff(aData)
        write_rx_lmtoff_value = aData
        flag_rx_lmtoff        = &H1
    End Property

    Property Get read_rx_lmtoff
        read
        read_rx_lmtoff = read_rx_lmtoff_value
    End Property

    Property Let write_rx_lmtoff(aData)
        set_rx_lmtoff = aData
        write
    End Property

    Property Get get_lmtcal_valid
        get_lmtcal_valid = read_lmtcal_valid_value
    End Property

    Property Let set_lmtcal_valid(aData)
        write_lmtcal_valid_value = aData
        flag_lmtcal_valid        = &H1
    End Property

    Property Get read_lmtcal_valid
        read
        read_lmtcal_valid = read_lmtcal_valid_value
    End Property

    Property Let write_lmtcal_valid(aData)
        set_lmtcal_valid = aData
        write
    End Property

    Property Get get_lmtcal_done
        get_lmtcal_done = read_lmtcal_done_value
    End Property

    Property Let set_lmtcal_done(aData)
        write_lmtcal_done_value = aData
        flag_lmtcal_done        = &H1
    End Property

    Property Get read_lmtcal_done
        read
        read_lmtcal_done = read_lmtcal_done_value
    End Property

    Property Let write_lmtcal_done(aData)
        set_lmtcal_done = aData
        write
    End Property

    Property Get get_lmtcal_adj_cnt
        get_lmtcal_adj_cnt = read_lmtcal_adj_cnt_value
    End Property

    Property Let set_lmtcal_adj_cnt(aData)
        write_lmtcal_adj_cnt_value = aData
        flag_lmtcal_adj_cnt        = &H1
    End Property

    Property Get read_lmtcal_adj_cnt
        read
        read_lmtcal_adj_cnt = read_lmtcal_adj_cnt_value
    End Property

    Property Let write_lmtcal_adj_cnt(aData)
        set_lmtcal_adj_cnt = aData
        write
    End Property

    Property Get get_lmtcal_state
        get_lmtcal_state = read_lmtcal_state_value
    End Property

    Property Let set_lmtcal_state(aData)
        write_lmtcal_state_value = aData
        flag_lmtcal_state        = &H1
    End Property

    Property Get read_lmtcal_state
        read
        read_lmtcal_state = read_lmtcal_state_value
    End Property

    Property Let write_lmtcal_state(aData)
        set_lmtcal_state = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_rx_lmtoff_value = rightShift(data_low, 10) and &H3f
        read_lmtcal_valid_value = rightShift(data_low, 9) and &H1
        read_lmtcal_done_value = rightShift(data_low, 8) and &H1
        read_lmtcal_adj_cnt_value = rightShift(data_low, 3) and &H1f
        lmtcal_state_mask = &H7
        if data_low > LONG_MAX then
            if lmtcal_state_mask = mask then
                read_lmtcal_state_value = data_low
            else
                read_lmtcal_state_value = (data_low - H8000_0000) and lmtcal_state_mask
            end If
        else
            read_lmtcal_state_value = data_low and lmtcal_state_mask
        end If

    End Sub

    Sub write
        If flag_rx_lmtoff = &H0 or flag_lmtcal_valid = &H0 or flag_lmtcal_done = &H0 or flag_lmtcal_adj_cnt = &H0 or flag_lmtcal_state = &H0 Then read
        If flag_rx_lmtoff = &H0 Then write_rx_lmtoff_value = get_rx_lmtoff
        If flag_lmtcal_valid = &H0 Then write_lmtcal_valid_value = get_lmtcal_valid
        If flag_lmtcal_done = &H0 Then write_lmtcal_done_value = get_lmtcal_done
        If flag_lmtcal_adj_cnt = &H0 Then write_lmtcal_adj_cnt_value = get_lmtcal_adj_cnt
        If flag_lmtcal_state = &H0 Then write_lmtcal_state_value = get_lmtcal_state

        regValue = leftShift((write_rx_lmtoff_value and &H3f), 10) + leftShift((write_lmtcal_valid_value and &H1), 9) + leftShift((write_lmtcal_done_value and &H1), 8) + leftShift((write_lmtcal_adj_cnt_value and &H1f), 3) + leftShift((write_lmtcal_state_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_rx_lmtoff_value = rightShift(data_low, 10) and &H3f
        read_lmtcal_valid_value = rightShift(data_low, 9) and &H1
        read_lmtcal_done_value = rightShift(data_low, 8) and &H1
        read_lmtcal_adj_cnt_value = rightShift(data_low, 3) and &H1f
        lmtcal_state_mask = &H7
        if data_low > LONG_MAX then
            if lmtcal_state_mask = mask then
                read_lmtcal_state_value = data_low
            else
                read_lmtcal_state_value = (data_low - H8000_0000) and lmtcal_state_mask
            end If
        else
            read_lmtcal_state_value = data_low and lmtcal_state_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_rx_lmtoff_value = &H0
        flag_rx_lmtoff        = &H0
        write_lmtcal_valid_value = &H0
        flag_lmtcal_valid        = &H0
        write_lmtcal_done_value = &H0
        flag_lmtcal_done        = &H0
        write_lmtcal_adj_cnt_value = &H0
        flag_lmtcal_adj_cnt        = &H0
        write_lmtcal_state_value = &H0
        flag_lmtcal_state        = &H0
    End Sub
End Class


'' @REGISTER : RX_DFE1__SGMIIPCIE_X1_lmtcalstatus1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' lmtcal_acc                                 [15:0]           get_lmtcal_acc
''                                                             set_lmtcal_acc
''                                                             read_lmtcal_acc
''                                                             write_lmtcal_acc
''---------------------------------------------------------------------------------
Class REGISTER_RX_DFE1__SGMIIPCIE_X1_lmtcalstatus1
    Private write_lmtcal_acc_value
    Private read_lmtcal_acc_value
    Private flag_lmtcal_acc

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

    Property Get get_lmtcal_acc
        get_lmtcal_acc = read_lmtcal_acc_value
    End Property

    Property Let set_lmtcal_acc(aData)
        write_lmtcal_acc_value = aData
        flag_lmtcal_acc        = &H1
    End Property

    Property Get read_lmtcal_acc
        read
        read_lmtcal_acc = read_lmtcal_acc_value
    End Property

    Property Let write_lmtcal_acc(aData)
        set_lmtcal_acc = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        lmtcal_acc_mask = &Hffff
        if data_low > LONG_MAX then
            if lmtcal_acc_mask = mask then
                read_lmtcal_acc_value = data_low
            else
                read_lmtcal_acc_value = (data_low - H8000_0000) and lmtcal_acc_mask
            end If
        else
            read_lmtcal_acc_value = data_low and lmtcal_acc_mask
        end If

    End Sub

    Sub write
        If flag_lmtcal_acc = &H0 Then read
        If flag_lmtcal_acc = &H0 Then write_lmtcal_acc_value = get_lmtcal_acc

        regValue = leftShift((write_lmtcal_acc_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        lmtcal_acc_mask = &Hffff
        if data_low > LONG_MAX then
            if lmtcal_acc_mask = mask then
                read_lmtcal_acc_value = data_low
            else
                read_lmtcal_acc_value = (data_low - H8000_0000) and lmtcal_acc_mask
            end If
        else
            read_lmtcal_acc_value = data_low and lmtcal_acc_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_lmtcal_acc_value = &H0
        flag_lmtcal_acc        = &H0
    End Sub
End Class


'' @REGISTER : RX_DFE1__SGMIIPCIE_X1_lmtcalstatus2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' recal_ind                                  [0:0]            get_recal_ind
''                                                             set_recal_ind
''                                                             read_recal_ind
''                                                             write_recal_ind
''---------------------------------------------------------------------------------
Class REGISTER_RX_DFE1__SGMIIPCIE_X1_lmtcalstatus2
    Private write_recal_ind_value
    Private read_recal_ind_value
    Private flag_recal_ind

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

    Property Get get_recal_ind
        get_recal_ind = read_recal_ind_value
    End Property

    Property Let set_recal_ind(aData)
        write_recal_ind_value = aData
        flag_recal_ind        = &H1
    End Property

    Property Get read_recal_ind
        read
        read_recal_ind = read_recal_ind_value
    End Property

    Property Let write_recal_ind(aData)
        set_recal_ind = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        recal_ind_mask = &H1
        if data_low > LONG_MAX then
            if recal_ind_mask = mask then
                read_recal_ind_value = data_low
            else
                read_recal_ind_value = (data_low - H8000_0000) and recal_ind_mask
            end If
        else
            read_recal_ind_value = data_low and recal_ind_mask
        end If

    End Sub

    Sub write
        If flag_recal_ind = &H0 Then read
        If flag_recal_ind = &H0 Then write_recal_ind_value = get_recal_ind

        regValue = leftShift((write_recal_ind_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        recal_ind_mask = &H1
        if data_low > LONG_MAX then
            if recal_ind_mask = mask then
                read_recal_ind_value = data_low
            else
                read_recal_ind_value = (data_low - H8000_0000) and recal_ind_mask
            end If
        else
            read_recal_ind_value = data_low and recal_ind_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_recal_ind_value = &H0
        flag_recal_ind        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class RX_DFE1__SGMIIPCIE_X1_INSTANCE

    Public lmtcalcontrol0
    Public lmtcalcontrol1
    Public lmtcalcontrol2
    Public lmtcalcontrol3
    Public lmtcalcontrol4
    Public lmtcalcontrol5
    Public lmtcalcontrol6
    Public lmtcalstatus0
    Public lmtcalstatus1
    Public lmtcalstatus2


    Public default function Init(aBaseAddr)
        Set lmtcalcontrol0 = (New REGISTER_RX_DFE1__SGMIIPCIE_X1_lmtcalcontrol0)(aBaseAddr, 16)
        Set lmtcalcontrol1 = (New REGISTER_RX_DFE1__SGMIIPCIE_X1_lmtcalcontrol1)(aBaseAddr, 16)
        Set lmtcalcontrol2 = (New REGISTER_RX_DFE1__SGMIIPCIE_X1_lmtcalcontrol2)(aBaseAddr, 16)
        Set lmtcalcontrol3 = (New REGISTER_RX_DFE1__SGMIIPCIE_X1_lmtcalcontrol3)(aBaseAddr, 16)
        Set lmtcalcontrol4 = (New REGISTER_RX_DFE1__SGMIIPCIE_X1_lmtcalcontrol4)(aBaseAddr, 16)
        Set lmtcalcontrol5 = (New REGISTER_RX_DFE1__SGMIIPCIE_X1_lmtcalcontrol5)(aBaseAddr, 16)
        Set lmtcalcontrol6 = (New REGISTER_RX_DFE1__SGMIIPCIE_X1_lmtcalcontrol6)(aBaseAddr, 16)
        Set lmtcalstatus0 = (New REGISTER_RX_DFE1__SGMIIPCIE_X1_lmtcalstatus0)(aBaseAddr, 16)
        Set lmtcalstatus1 = (New REGISTER_RX_DFE1__SGMIIPCIE_X1_lmtcalstatus1)(aBaseAddr, 16)
        Set lmtcalstatus2 = (New REGISTER_RX_DFE1__SGMIIPCIE_X1_lmtcalstatus2)(aBaseAddr, 16)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set RX_DFE1__SGMIIPCIE_X1 = CreateObject("System.Collections.ArrayList")
RX_DFE1__SGMIIPCIE_X1.Add ((New RX_DFE1__SGMIIPCIE_X1_INSTANCE)(&H4adee200))


