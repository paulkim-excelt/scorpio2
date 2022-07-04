

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


'' @REGISTER : RX3__SGMIIPCIE_X1_control0
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
Class REGISTER_RX3__SGMIIPCIE_X1_control0
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


'' @REGISTER : RX3__SGMIIPCIE_X1_control1
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
Class REGISTER_RX3__SGMIIPCIE_X1_control1
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


'' @REGISTER : RX3__SGMIIPCIE_X1_control2
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
Class REGISTER_RX3__SGMIIPCIE_X1_control2
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


'' @REGISTER : RX3__SGMIIPCIE_X1_control3
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
Class REGISTER_RX3__SGMIIPCIE_X1_control3
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


'' @REGISTER : RX3__SGMIIPCIE_X1_control4
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
Class REGISTER_RX3__SGMIIPCIE_X1_control4
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


'' @REGISTER : RX3__SGMIIPCIE_X1_control5
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
Class REGISTER_RX3__SGMIIPCIE_X1_control5
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


'' @REGISTER : RX3__SGMIIPCIE_X1_control6
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
Class REGISTER_RX3__SGMIIPCIE_X1_control6
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


'' @REGISTER : RX3__SGMIIPCIE_X1_control7
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
Class REGISTER_RX3__SGMIIPCIE_X1_control7
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
        If flag_cal_state_ovrd = &H0 or flag_slcal_en_ovrd = &H0 or flag_slcal_en_ovrd_val = &H0 or flag_slcal_acc_opt = &H0 or flag_slcal_pol = &H0 or flag_slcal_valid_ovrd = &H0 or flag_slcal_valid_ovrd_val = &H0 Then read
        If flag_cal_state_ovrd = &H0 Then write_cal_state_ovrd_value = get_cal_state_ovrd
        If flag_slcal_en_ovrd = &H0 Then write_slcal_en_ovrd_value = get_slcal_en_ovrd
        If flag_slcal_en_ovrd_val = &H0 Then write_slcal_en_ovrd_val_value = get_slcal_en_ovrd_val
        If flag_slcal_acc_opt = &H0 Then write_slcal_acc_opt_value = get_slcal_acc_opt
        If flag_slcal_pol = &H0 Then write_slcal_pol_value = get_slcal_pol
        If flag_slcal_valid_ovrd = &H0 Then write_slcal_valid_ovrd_value = get_slcal_valid_ovrd
        If flag_slcal_valid_ovrd_val = &H0 Then write_slcal_valid_ovrd_val_value = get_slcal_valid_ovrd_val

        regValue = leftShift((write_cal_state_ovrd_value and &H1), 15) + leftShift((write_slcal_en_ovrd_value and &H1), 14) + leftShift((write_slcal_en_ovrd_val_value and &H1), 13) + leftShift((write_slcal_acc_opt_value and &H3), 11) + leftShift((write_slcal_pol_value and &H1), 10) + leftShift((write_slcal_valid_ovrd_value and &H1), 1) + leftShift((write_slcal_valid_ovrd_val_value and &H1), 0)
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
        write_slcal_valid_ovrd_value = &H0
        flag_slcal_valid_ovrd        = &H0
        write_slcal_valid_ovrd_val_value = &H0
        flag_slcal_valid_ovrd_val        = &H0
    End Sub
End Class


'' @REGISTER : RX3__SGMIIPCIE_X1_control8
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' slicer_data_sel                            [15:15]          get_slicer_data_sel
''                                                             set_slicer_data_sel
''                                                             read_slicer_data_sel
''                                                             write_slicer_data_sel
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
Class REGISTER_RX3__SGMIIPCIE_X1_control8
    Private write_slicer_data_sel_value
    Private read_slicer_data_sel_value
    Private flag_slicer_data_sel
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

    Property Get get_slicer_data_sel
        get_slicer_data_sel = read_slicer_data_sel_value
    End Property

    Property Let set_slicer_data_sel(aData)
        write_slicer_data_sel_value = aData
        flag_slicer_data_sel        = &H1
    End Property

    Property Get read_slicer_data_sel
        read
        read_slicer_data_sel = read_slicer_data_sel_value
    End Property

    Property Let write_slicer_data_sel(aData)
        set_slicer_data_sel = aData
        write
    End Property

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
        read_slicer_data_sel_value = rightShift(data_low, 15) and &H1
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
        If flag_slicer_data_sel = &H0 or flag_rx_sloff2_ovrd = &H0 or flag_rx_sloff2_ovrd_val = &H0 or flag_rx_sloff1_ovrd = &H0 or flag_rx_sloff1_ovrd_val = &H0 or flag_rx_sloff0_ovrd = &H0 or flag_rx_sloff0_ovrd_val = &H0 Then read
        If flag_slicer_data_sel = &H0 Then write_slicer_data_sel_value = get_slicer_data_sel
        If flag_rx_sloff2_ovrd = &H0 Then write_rx_sloff2_ovrd_value = get_rx_sloff2_ovrd
        If flag_rx_sloff2_ovrd_val = &H0 Then write_rx_sloff2_ovrd_val_value = get_rx_sloff2_ovrd_val
        If flag_rx_sloff1_ovrd = &H0 Then write_rx_sloff1_ovrd_value = get_rx_sloff1_ovrd
        If flag_rx_sloff1_ovrd_val = &H0 Then write_rx_sloff1_ovrd_val_value = get_rx_sloff1_ovrd_val
        If flag_rx_sloff0_ovrd = &H0 Then write_rx_sloff0_ovrd_value = get_rx_sloff0_ovrd
        If flag_rx_sloff0_ovrd_val = &H0 Then write_rx_sloff0_ovrd_val_value = get_rx_sloff0_ovrd_val

        regValue = leftShift((write_slicer_data_sel_value and &H1), 15) + leftShift((write_rx_sloff2_ovrd_value and &H1), 14) + leftShift((write_rx_sloff2_ovrd_val_value and &Hf), 10) + leftShift((write_rx_sloff1_ovrd_value and &H1), 9) + leftShift((write_rx_sloff1_ovrd_val_value and &Hf), 5) + leftShift((write_rx_sloff0_ovrd_value and &H1), 4) + leftShift((write_rx_sloff0_ovrd_val_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_slicer_data_sel_value = rightShift(data_low, 15) and &H1
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
        write_slicer_data_sel_value = &H0
        flag_slicer_data_sel        = &H0
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


'' @REGISTER : RX3__SGMIIPCIE_X1_control9
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
Class REGISTER_RX3__SGMIIPCIE_X1_control9
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


'' @REGISTER : RX3__SGMIIPCIE_X1_control10
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
Class REGISTER_RX3__SGMIIPCIE_X1_control10
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
        offset = &H14
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


'' @REGISTER : RX3__SGMIIPCIE_X1_control11
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' recal_ind_clr                              [15:15]          get_recal_ind_clr
''                                                             set_recal_ind_clr
''                                                             read_recal_ind_clr
''                                                             write_recal_ind_clr
''---------------------------------------------------------------------------------
'' slcal_init_time                            [14:7]           get_slcal_init_time
''                                                             set_slcal_init_time
''                                                             read_slcal_init_time
''                                                             write_slcal_init_time
''---------------------------------------------------------------------------------
'' pm_RxSlicerCalByp                          [1:1]            get_pm_RxSlicerCalByp
''                                                             set_pm_RxSlicerCalByp
''                                                             read_pm_RxSlicerCalByp
''                                                             write_pm_RxSlicerCalByp
''---------------------------------------------------------------------------------
'' pm_RxLimitAmpCalByp                        [0:0]            get_pm_RxLimitAmpCalByp
''                                                             set_pm_RxLimitAmpCalByp
''                                                             read_pm_RxLimitAmpCalByp
''                                                             write_pm_RxLimitAmpCalByp
''---------------------------------------------------------------------------------
Class REGISTER_RX3__SGMIIPCIE_X1_control11
    Private write_recal_ind_clr_value
    Private read_recal_ind_clr_value
    Private flag_recal_ind_clr
    Private write_slcal_init_time_value
    Private read_slcal_init_time_value
    Private flag_slcal_init_time
    Private write_pm_RxSlicerCalByp_value
    Private read_pm_RxSlicerCalByp_value
    Private flag_pm_RxSlicerCalByp
    Private write_pm_RxLimitAmpCalByp_value
    Private read_pm_RxLimitAmpCalByp_value
    Private flag_pm_RxLimitAmpCalByp

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H16
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_recal_ind_clr
        get_recal_ind_clr = read_recal_ind_clr_value
    End Property

    Property Let set_recal_ind_clr(aData)
        write_recal_ind_clr_value = aData
        flag_recal_ind_clr        = &H1
    End Property

    Property Get read_recal_ind_clr
        read
        read_recal_ind_clr = read_recal_ind_clr_value
    End Property

    Property Let write_recal_ind_clr(aData)
        set_recal_ind_clr = aData
        write
    End Property

    Property Get get_slcal_init_time
        get_slcal_init_time = read_slcal_init_time_value
    End Property

    Property Let set_slcal_init_time(aData)
        write_slcal_init_time_value = aData
        flag_slcal_init_time        = &H1
    End Property

    Property Get read_slcal_init_time
        read
        read_slcal_init_time = read_slcal_init_time_value
    End Property

    Property Let write_slcal_init_time(aData)
        set_slcal_init_time = aData
        write
    End Property

    Property Get get_pm_RxSlicerCalByp
        get_pm_RxSlicerCalByp = read_pm_RxSlicerCalByp_value
    End Property

    Property Let set_pm_RxSlicerCalByp(aData)
        write_pm_RxSlicerCalByp_value = aData
        flag_pm_RxSlicerCalByp        = &H1
    End Property

    Property Get read_pm_RxSlicerCalByp
        read
        read_pm_RxSlicerCalByp = read_pm_RxSlicerCalByp_value
    End Property

    Property Let write_pm_RxSlicerCalByp(aData)
        set_pm_RxSlicerCalByp = aData
        write
    End Property

    Property Get get_pm_RxLimitAmpCalByp
        get_pm_RxLimitAmpCalByp = read_pm_RxLimitAmpCalByp_value
    End Property

    Property Let set_pm_RxLimitAmpCalByp(aData)
        write_pm_RxLimitAmpCalByp_value = aData
        flag_pm_RxLimitAmpCalByp        = &H1
    End Property

    Property Get read_pm_RxLimitAmpCalByp
        read
        read_pm_RxLimitAmpCalByp = read_pm_RxLimitAmpCalByp_value
    End Property

    Property Let write_pm_RxLimitAmpCalByp(aData)
        set_pm_RxLimitAmpCalByp = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_recal_ind_clr_value = rightShift(data_low, 15) and &H1
        read_slcal_init_time_value = rightShift(data_low, 7) and &Hff
        read_pm_RxSlicerCalByp_value = rightShift(data_low, 1) and &H1
        pm_RxLimitAmpCalByp_mask = &H1
        if data_low > LONG_MAX then
            if pm_RxLimitAmpCalByp_mask = mask then
                read_pm_RxLimitAmpCalByp_value = data_low
            else
                read_pm_RxLimitAmpCalByp_value = (data_low - H8000_0000) and pm_RxLimitAmpCalByp_mask
            end If
        else
            read_pm_RxLimitAmpCalByp_value = data_low and pm_RxLimitAmpCalByp_mask
        end If

    End Sub

    Sub write
        If flag_recal_ind_clr = &H0 or flag_slcal_init_time = &H0 or flag_pm_RxSlicerCalByp = &H0 or flag_pm_RxLimitAmpCalByp = &H0 Then read
        If flag_recal_ind_clr = &H0 Then write_recal_ind_clr_value = get_recal_ind_clr
        If flag_slcal_init_time = &H0 Then write_slcal_init_time_value = get_slcal_init_time
        If flag_pm_RxSlicerCalByp = &H0 Then write_pm_RxSlicerCalByp_value = get_pm_RxSlicerCalByp
        If flag_pm_RxLimitAmpCalByp = &H0 Then write_pm_RxLimitAmpCalByp_value = get_pm_RxLimitAmpCalByp

        regValue = leftShift((write_recal_ind_clr_value and &H1), 15) + leftShift((write_slcal_init_time_value and &Hff), 7) + leftShift((write_pm_RxSlicerCalByp_value and &H1), 1) + leftShift((write_pm_RxLimitAmpCalByp_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_recal_ind_clr_value = rightShift(data_low, 15) and &H1
        read_slcal_init_time_value = rightShift(data_low, 7) and &Hff
        read_pm_RxSlicerCalByp_value = rightShift(data_low, 1) and &H1
        pm_RxLimitAmpCalByp_mask = &H1
        if data_low > LONG_MAX then
            if pm_RxLimitAmpCalByp_mask = mask then
                read_pm_RxLimitAmpCalByp_value = data_low
            else
                read_pm_RxLimitAmpCalByp_value = (data_low - H8000_0000) and pm_RxLimitAmpCalByp_mask
            end If
        else
            read_pm_RxLimitAmpCalByp_value = data_low and pm_RxLimitAmpCalByp_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_recal_ind_clr_value = &H0
        flag_recal_ind_clr        = &H0
        write_slcal_init_time_value = &H0
        flag_slcal_init_time        = &H0
        write_pm_RxSlicerCalByp_value = &H0
        flag_pm_RxSlicerCalByp        = &H0
        write_pm_RxLimitAmpCalByp_value = &H0
        flag_pm_RxLimitAmpCalByp        = &H0
    End Sub
End Class


'' @REGISTER : RX3__SGMIIPCIE_X1_slicerstat
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' rx_slicer_calvalid                         [12:12]          get_rx_slicer_calvalid
''                                                             set_rx_slicer_calvalid
''                                                             read_rx_slicer_calvalid
''                                                             write_rx_slicer_calvalid
''---------------------------------------------------------------------------------
'' rx_sloff2                                  [11:8]           get_rx_sloff2
''                                                             set_rx_sloff2
''                                                             read_rx_sloff2
''                                                             write_rx_sloff2
''---------------------------------------------------------------------------------
'' rx_sloff1                                  [7:4]            get_rx_sloff1
''                                                             set_rx_sloff1
''                                                             read_rx_sloff1
''                                                             write_rx_sloff1
''---------------------------------------------------------------------------------
'' rx_sloff0                                  [3:0]            get_rx_sloff0
''                                                             set_rx_sloff0
''                                                             read_rx_sloff0
''                                                             write_rx_sloff0
''---------------------------------------------------------------------------------
Class REGISTER_RX3__SGMIIPCIE_X1_slicerstat
    Private write_rx_slicer_calvalid_value
    Private read_rx_slicer_calvalid_value
    Private flag_rx_slicer_calvalid
    Private write_rx_sloff2_value
    Private read_rx_sloff2_value
    Private flag_rx_sloff2
    Private write_rx_sloff1_value
    Private read_rx_sloff1_value
    Private flag_rx_sloff1
    Private write_rx_sloff0_value
    Private read_rx_sloff0_value
    Private flag_rx_sloff0

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

    Property Get get_rx_slicer_calvalid
        get_rx_slicer_calvalid = read_rx_slicer_calvalid_value
    End Property

    Property Let set_rx_slicer_calvalid(aData)
        write_rx_slicer_calvalid_value = aData
        flag_rx_slicer_calvalid        = &H1
    End Property

    Property Get read_rx_slicer_calvalid
        read
        read_rx_slicer_calvalid = read_rx_slicer_calvalid_value
    End Property

    Property Let write_rx_slicer_calvalid(aData)
        set_rx_slicer_calvalid = aData
        write
    End Property

    Property Get get_rx_sloff2
        get_rx_sloff2 = read_rx_sloff2_value
    End Property

    Property Let set_rx_sloff2(aData)
        write_rx_sloff2_value = aData
        flag_rx_sloff2        = &H1
    End Property

    Property Get read_rx_sloff2
        read
        read_rx_sloff2 = read_rx_sloff2_value
    End Property

    Property Let write_rx_sloff2(aData)
        set_rx_sloff2 = aData
        write
    End Property

    Property Get get_rx_sloff1
        get_rx_sloff1 = read_rx_sloff1_value
    End Property

    Property Let set_rx_sloff1(aData)
        write_rx_sloff1_value = aData
        flag_rx_sloff1        = &H1
    End Property

    Property Get read_rx_sloff1
        read
        read_rx_sloff1 = read_rx_sloff1_value
    End Property

    Property Let write_rx_sloff1(aData)
        set_rx_sloff1 = aData
        write
    End Property

    Property Get get_rx_sloff0
        get_rx_sloff0 = read_rx_sloff0_value
    End Property

    Property Let set_rx_sloff0(aData)
        write_rx_sloff0_value = aData
        flag_rx_sloff0        = &H1
    End Property

    Property Get read_rx_sloff0
        read
        read_rx_sloff0 = read_rx_sloff0_value
    End Property

    Property Let write_rx_sloff0(aData)
        set_rx_sloff0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_rx_slicer_calvalid_value = rightShift(data_low, 12) and &H1
        read_rx_sloff2_value = rightShift(data_low, 8) and &Hf
        read_rx_sloff1_value = rightShift(data_low, 4) and &Hf
        rx_sloff0_mask = &Hf
        if data_low > LONG_MAX then
            if rx_sloff0_mask = mask then
                read_rx_sloff0_value = data_low
            else
                read_rx_sloff0_value = (data_low - H8000_0000) and rx_sloff0_mask
            end If
        else
            read_rx_sloff0_value = data_low and rx_sloff0_mask
        end If

    End Sub

    Sub write
        If flag_rx_slicer_calvalid = &H0 or flag_rx_sloff2 = &H0 or flag_rx_sloff1 = &H0 or flag_rx_sloff0 = &H0 Then read
        If flag_rx_slicer_calvalid = &H0 Then write_rx_slicer_calvalid_value = get_rx_slicer_calvalid
        If flag_rx_sloff2 = &H0 Then write_rx_sloff2_value = get_rx_sloff2
        If flag_rx_sloff1 = &H0 Then write_rx_sloff1_value = get_rx_sloff1
        If flag_rx_sloff0 = &H0 Then write_rx_sloff0_value = get_rx_sloff0

        regValue = leftShift((write_rx_slicer_calvalid_value and &H1), 12) + leftShift((write_rx_sloff2_value and &Hf), 8) + leftShift((write_rx_sloff1_value and &Hf), 4) + leftShift((write_rx_sloff0_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_rx_slicer_calvalid_value = rightShift(data_low, 12) and &H1
        read_rx_sloff2_value = rightShift(data_low, 8) and &Hf
        read_rx_sloff1_value = rightShift(data_low, 4) and &Hf
        rx_sloff0_mask = &Hf
        if data_low > LONG_MAX then
            if rx_sloff0_mask = mask then
                read_rx_sloff0_value = data_low
            else
                read_rx_sloff0_value = (data_low - H8000_0000) and rx_sloff0_mask
            end If
        else
            read_rx_sloff0_value = data_low and rx_sloff0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_rx_slicer_calvalid_value = &H0
        flag_rx_slicer_calvalid        = &H0
        write_rx_sloff2_value = &H0
        flag_rx_sloff2        = &H0
        write_rx_sloff1_value = &H0
        flag_rx_sloff1        = &H0
        write_rx_sloff0_value = &H0
        flag_rx_sloff0        = &H0
    End Sub
End Class


'' @REGISTER : RX3__SGMIIPCIE_X1_blockaddress
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
Class REGISTER_RX3__SGMIIPCIE_X1_blockaddress
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

Class RX3__SGMIIPCIE_X1_INSTANCE

    Public control0
    Public control1
    Public control2
    Public control3
    Public control4
    Public control5
    Public control6
    Public control7
    Public control8
    Public control9
    Public control10
    Public control11
    Public slicerstat
    Public blockaddress


    Public default function Init(aBaseAddr)
        Set control0 = (New REGISTER_RX3__SGMIIPCIE_X1_control0)(aBaseAddr, 16)
        Set control1 = (New REGISTER_RX3__SGMIIPCIE_X1_control1)(aBaseAddr, 16)
        Set control2 = (New REGISTER_RX3__SGMIIPCIE_X1_control2)(aBaseAddr, 16)
        Set control3 = (New REGISTER_RX3__SGMIIPCIE_X1_control3)(aBaseAddr, 16)
        Set control4 = (New REGISTER_RX3__SGMIIPCIE_X1_control4)(aBaseAddr, 16)
        Set control5 = (New REGISTER_RX3__SGMIIPCIE_X1_control5)(aBaseAddr, 16)
        Set control6 = (New REGISTER_RX3__SGMIIPCIE_X1_control6)(aBaseAddr, 16)
        Set control7 = (New REGISTER_RX3__SGMIIPCIE_X1_control7)(aBaseAddr, 16)
        Set control8 = (New REGISTER_RX3__SGMIIPCIE_X1_control8)(aBaseAddr, 16)
        Set control9 = (New REGISTER_RX3__SGMIIPCIE_X1_control9)(aBaseAddr, 16)
        Set control10 = (New REGISTER_RX3__SGMIIPCIE_X1_control10)(aBaseAddr, 16)
        Set control11 = (New REGISTER_RX3__SGMIIPCIE_X1_control11)(aBaseAddr, 16)
        Set slicerstat = (New REGISTER_RX3__SGMIIPCIE_X1_slicerstat)(aBaseAddr, 16)
        Set blockaddress = (New REGISTER_RX3__SGMIIPCIE_X1_blockaddress)(aBaseAddr, 16)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set RX3__SGMIIPCIE_X1 = CreateObject("System.Collections.ArrayList")
RX3__SGMIIPCIE_X1.Add ((New RX3__SGMIIPCIE_X1_INSTANCE)(&H4add0900))


