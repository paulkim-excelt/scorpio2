

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


'' @REGISTER : GPV_ASIB_fn_mod2_m7_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' fn_mode2                                   [0:0]            get_fn_mode2
''                                                             set_fn_mode2
''                                                             read_fn_mode2
''                                                             write_fn_mode2
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_fn_mod2_m7_m
    Private write_fn_mode2_value
    Private read_fn_mode2_value
    Private flag_fn_mode2

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H24
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_fn_mode2
        get_fn_mode2 = read_fn_mode2_value
    End Property

    Property Let set_fn_mode2(aData)
        write_fn_mode2_value = aData
        flag_fn_mode2        = &H1
    End Property

    Property Get read_fn_mode2
        read
        read_fn_mode2 = read_fn_mode2_value
    End Property

    Property Let write_fn_mode2(aData)
        set_fn_mode2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        fn_mode2_mask = &H1
        if data_low > LONG_MAX then
            if fn_mode2_mask = mask then
                read_fn_mode2_value = data_low
            else
                read_fn_mode2_value = (data_low - H8000_0000) and fn_mode2_mask
            end If
        else
            read_fn_mode2_value = data_low and fn_mode2_mask
        end If

    End Sub

    Sub write
        If flag_fn_mode2 = &H0 Then read
        If flag_fn_mode2 = &H0 Then write_fn_mode2_value = get_fn_mode2

        regValue = leftShift((write_fn_mode2_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        fn_mode2_mask = &H1
        if data_low > LONG_MAX then
            if fn_mode2_mask = mask then
                read_fn_mode2_value = data_low
            else
                read_fn_mode2_value = (data_low - H8000_0000) and fn_mode2_mask
            end If
        else
            read_fn_mode2_value = data_low and fn_mode2_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_fn_mode2_value = &H0
        flag_fn_mode2        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_read_qos_m7_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' read_qos                                   [3:0]            get_read_qos
''                                                             set_read_qos
''                                                             read_read_qos
''                                                             write_read_qos
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_read_qos_m7_m
    Private write_read_qos_value
    Private read_read_qos_value
    Private flag_read_qos

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H100
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_read_qos
        get_read_qos = read_read_qos_value
    End Property

    Property Let set_read_qos(aData)
        write_read_qos_value = aData
        flag_read_qos        = &H1
    End Property

    Property Get read_read_qos
        read
        read_read_qos = read_read_qos_value
    End Property

    Property Let write_read_qos(aData)
        set_read_qos = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_qos_mask = &Hf
        if data_low > LONG_MAX then
            if read_qos_mask = mask then
                read_read_qos_value = data_low
            else
                read_read_qos_value = (data_low - H8000_0000) and read_qos_mask
            end If
        else
            read_read_qos_value = data_low and read_qos_mask
        end If

    End Sub

    Sub write
        If flag_read_qos = &H0 Then read
        If flag_read_qos = &H0 Then write_read_qos_value = get_read_qos

        regValue = leftShift((write_read_qos_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_qos_mask = &Hf
        if data_low > LONG_MAX then
            if read_qos_mask = mask then
                read_read_qos_value = data_low
            else
                read_read_qos_value = (data_low - H8000_0000) and read_qos_mask
            end If
        else
            read_read_qos_value = data_low and read_qos_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_read_qos_value = &H0
        flag_read_qos        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_write_qos_m7_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' write_qos                                  [3:0]            get_write_qos
''                                                             set_write_qos
''                                                             read_write_qos
''                                                             write_write_qos
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_write_qos_m7_m
    Private write_write_qos_value
    Private read_write_qos_value
    Private flag_write_qos

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H104
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_write_qos
        get_write_qos = read_write_qos_value
    End Property

    Property Let set_write_qos(aData)
        write_write_qos_value = aData
        flag_write_qos        = &H1
    End Property

    Property Get read_write_qos
        read
        read_write_qos = read_write_qos_value
    End Property

    Property Let write_write_qos(aData)
        set_write_qos = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        write_qos_mask = &Hf
        if data_low > LONG_MAX then
            if write_qos_mask = mask then
                read_write_qos_value = data_low
            else
                read_write_qos_value = (data_low - H8000_0000) and write_qos_mask
            end If
        else
            read_write_qos_value = data_low and write_qos_mask
        end If

    End Sub

    Sub write
        If flag_write_qos = &H0 Then read
        If flag_write_qos = &H0 Then write_write_qos_value = get_write_qos

        regValue = leftShift((write_write_qos_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        write_qos_mask = &Hf
        if data_low > LONG_MAX then
            if write_qos_mask = mask then
                read_write_qos_value = data_low
            else
                read_write_qos_value = (data_low - H8000_0000) and write_qos_mask
            end If
        else
            read_write_qos_value = data_low and write_qos_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_write_qos_value = &H0
        flag_write_qos        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_fn_mod_m7_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' fn_mod                                     [1:0]            get_fn_mod
''                                                             set_fn_mod
''                                                             read_fn_mod
''                                                             write_fn_mod
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_fn_mod_m7_m
    Private write_fn_mod_value
    Private read_fn_mod_value
    Private flag_fn_mod

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H108
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_fn_mod
        get_fn_mod = read_fn_mod_value
    End Property

    Property Let set_fn_mod(aData)
        write_fn_mod_value = aData
        flag_fn_mod        = &H1
    End Property

    Property Get read_fn_mod
        read
        read_fn_mod = read_fn_mod_value
    End Property

    Property Let write_fn_mod(aData)
        set_fn_mod = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        fn_mod_mask = &H3
        if data_low > LONG_MAX then
            if fn_mod_mask = mask then
                read_fn_mod_value = data_low
            else
                read_fn_mod_value = (data_low - H8000_0000) and fn_mod_mask
            end If
        else
            read_fn_mod_value = data_low and fn_mod_mask
        end If

    End Sub

    Sub write
        If flag_fn_mod = &H0 Then read
        If flag_fn_mod = &H0 Then write_fn_mod_value = get_fn_mod

        regValue = leftShift((write_fn_mod_value and &H3), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        fn_mod_mask = &H3
        if data_low > LONG_MAX then
            if fn_mod_mask = mask then
                read_fn_mod_value = data_low
            else
                read_fn_mod_value = (data_low - H8000_0000) and fn_mod_mask
            end If
        else
            read_fn_mod_value = data_low and fn_mod_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_fn_mod_value = &H0
        flag_fn_mod        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_qos_cntl_m7_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mode_ar_fc                                 [20:20]          get_mode_ar_fc
''                                                             set_mode_ar_fc
''                                                             read_mode_ar_fc
''                                                             write_mode_ar_fc
''---------------------------------------------------------------------------------
'' mode_aw_fc                                 [16:16]          get_mode_aw_fc
''                                                             set_mode_aw_fc
''                                                             read_mode_aw_fc
''                                                             write_mode_aw_fc
''---------------------------------------------------------------------------------
'' en_awar_ot                                 [7:7]            get_en_awar_ot
''                                                             set_en_awar_ot
''                                                             read_en_awar_ot
''                                                             write_en_awar_ot
''---------------------------------------------------------------------------------
'' en_ar_ot                                   [6:6]            get_en_ar_ot
''                                                             set_en_ar_ot
''                                                             read_en_ar_ot
''                                                             write_en_ar_ot
''---------------------------------------------------------------------------------
'' en_aw_ot                                   [5:5]            get_en_aw_ot
''                                                             set_en_aw_ot
''                                                             read_en_aw_ot
''                                                             write_en_aw_ot
''---------------------------------------------------------------------------------
'' en_ar_fc                                   [4:4]            get_en_ar_fc
''                                                             set_en_ar_fc
''                                                             read_en_ar_fc
''                                                             write_en_ar_fc
''---------------------------------------------------------------------------------
'' en_aw_fc                                   [3:3]            get_en_aw_fc
''                                                             set_en_aw_fc
''                                                             read_en_aw_fc
''                                                             write_en_aw_fc
''---------------------------------------------------------------------------------
'' en_awar_rate                               [2:2]            get_en_awar_rate
''                                                             set_en_awar_rate
''                                                             read_en_awar_rate
''                                                             write_en_awar_rate
''---------------------------------------------------------------------------------
'' en_ar_rate                                 [1:1]            get_en_ar_rate
''                                                             set_en_ar_rate
''                                                             read_en_ar_rate
''                                                             write_en_ar_rate
''---------------------------------------------------------------------------------
'' en_aw_rate                                 [0:0]            get_en_aw_rate
''                                                             set_en_aw_rate
''                                                             read_en_aw_rate
''                                                             write_en_aw_rate
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_qos_cntl_m7_m
    Private write_mode_ar_fc_value
    Private read_mode_ar_fc_value
    Private flag_mode_ar_fc
    Private write_mode_aw_fc_value
    Private read_mode_aw_fc_value
    Private flag_mode_aw_fc
    Private write_en_awar_ot_value
    Private read_en_awar_ot_value
    Private flag_en_awar_ot
    Private write_en_ar_ot_value
    Private read_en_ar_ot_value
    Private flag_en_ar_ot
    Private write_en_aw_ot_value
    Private read_en_aw_ot_value
    Private flag_en_aw_ot
    Private write_en_ar_fc_value
    Private read_en_ar_fc_value
    Private flag_en_ar_fc
    Private write_en_aw_fc_value
    Private read_en_aw_fc_value
    Private flag_en_aw_fc
    Private write_en_awar_rate_value
    Private read_en_awar_rate_value
    Private flag_en_awar_rate
    Private write_en_ar_rate_value
    Private read_en_ar_rate_value
    Private flag_en_ar_rate
    Private write_en_aw_rate_value
    Private read_en_aw_rate_value
    Private flag_en_aw_rate

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H10c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mode_ar_fc
        get_mode_ar_fc = read_mode_ar_fc_value
    End Property

    Property Let set_mode_ar_fc(aData)
        write_mode_ar_fc_value = aData
        flag_mode_ar_fc        = &H1
    End Property

    Property Get read_mode_ar_fc
        read
        read_mode_ar_fc = read_mode_ar_fc_value
    End Property

    Property Let write_mode_ar_fc(aData)
        set_mode_ar_fc = aData
        write
    End Property

    Property Get get_mode_aw_fc
        get_mode_aw_fc = read_mode_aw_fc_value
    End Property

    Property Let set_mode_aw_fc(aData)
        write_mode_aw_fc_value = aData
        flag_mode_aw_fc        = &H1
    End Property

    Property Get read_mode_aw_fc
        read
        read_mode_aw_fc = read_mode_aw_fc_value
    End Property

    Property Let write_mode_aw_fc(aData)
        set_mode_aw_fc = aData
        write
    End Property

    Property Get get_en_awar_ot
        get_en_awar_ot = read_en_awar_ot_value
    End Property

    Property Let set_en_awar_ot(aData)
        write_en_awar_ot_value = aData
        flag_en_awar_ot        = &H1
    End Property

    Property Get read_en_awar_ot
        read
        read_en_awar_ot = read_en_awar_ot_value
    End Property

    Property Let write_en_awar_ot(aData)
        set_en_awar_ot = aData
        write
    End Property

    Property Get get_en_ar_ot
        get_en_ar_ot = read_en_ar_ot_value
    End Property

    Property Let set_en_ar_ot(aData)
        write_en_ar_ot_value = aData
        flag_en_ar_ot        = &H1
    End Property

    Property Get read_en_ar_ot
        read
        read_en_ar_ot = read_en_ar_ot_value
    End Property

    Property Let write_en_ar_ot(aData)
        set_en_ar_ot = aData
        write
    End Property

    Property Get get_en_aw_ot
        get_en_aw_ot = read_en_aw_ot_value
    End Property

    Property Let set_en_aw_ot(aData)
        write_en_aw_ot_value = aData
        flag_en_aw_ot        = &H1
    End Property

    Property Get read_en_aw_ot
        read
        read_en_aw_ot = read_en_aw_ot_value
    End Property

    Property Let write_en_aw_ot(aData)
        set_en_aw_ot = aData
        write
    End Property

    Property Get get_en_ar_fc
        get_en_ar_fc = read_en_ar_fc_value
    End Property

    Property Let set_en_ar_fc(aData)
        write_en_ar_fc_value = aData
        flag_en_ar_fc        = &H1
    End Property

    Property Get read_en_ar_fc
        read
        read_en_ar_fc = read_en_ar_fc_value
    End Property

    Property Let write_en_ar_fc(aData)
        set_en_ar_fc = aData
        write
    End Property

    Property Get get_en_aw_fc
        get_en_aw_fc = read_en_aw_fc_value
    End Property

    Property Let set_en_aw_fc(aData)
        write_en_aw_fc_value = aData
        flag_en_aw_fc        = &H1
    End Property

    Property Get read_en_aw_fc
        read
        read_en_aw_fc = read_en_aw_fc_value
    End Property

    Property Let write_en_aw_fc(aData)
        set_en_aw_fc = aData
        write
    End Property

    Property Get get_en_awar_rate
        get_en_awar_rate = read_en_awar_rate_value
    End Property

    Property Let set_en_awar_rate(aData)
        write_en_awar_rate_value = aData
        flag_en_awar_rate        = &H1
    End Property

    Property Get read_en_awar_rate
        read
        read_en_awar_rate = read_en_awar_rate_value
    End Property

    Property Let write_en_awar_rate(aData)
        set_en_awar_rate = aData
        write
    End Property

    Property Get get_en_ar_rate
        get_en_ar_rate = read_en_ar_rate_value
    End Property

    Property Let set_en_ar_rate(aData)
        write_en_ar_rate_value = aData
        flag_en_ar_rate        = &H1
    End Property

    Property Get read_en_ar_rate
        read
        read_en_ar_rate = read_en_ar_rate_value
    End Property

    Property Let write_en_ar_rate(aData)
        set_en_ar_rate = aData
        write
    End Property

    Property Get get_en_aw_rate
        get_en_aw_rate = read_en_aw_rate_value
    End Property

    Property Let set_en_aw_rate(aData)
        write_en_aw_rate_value = aData
        flag_en_aw_rate        = &H1
    End Property

    Property Get read_en_aw_rate
        read
        read_en_aw_rate = read_en_aw_rate_value
    End Property

    Property Let write_en_aw_rate(aData)
        set_en_aw_rate = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_mode_ar_fc_value = rightShift(data_low, 20) and &H1
        read_mode_aw_fc_value = rightShift(data_low, 16) and &H1
        read_en_awar_ot_value = rightShift(data_low, 7) and &H1
        read_en_ar_ot_value = rightShift(data_low, 6) and &H1
        read_en_aw_ot_value = rightShift(data_low, 5) and &H1
        read_en_ar_fc_value = rightShift(data_low, 4) and &H1
        read_en_aw_fc_value = rightShift(data_low, 3) and &H1
        read_en_awar_rate_value = rightShift(data_low, 2) and &H1
        read_en_ar_rate_value = rightShift(data_low, 1) and &H1
        en_aw_rate_mask = &H1
        if data_low > LONG_MAX then
            if en_aw_rate_mask = mask then
                read_en_aw_rate_value = data_low
            else
                read_en_aw_rate_value = (data_low - H8000_0000) and en_aw_rate_mask
            end If
        else
            read_en_aw_rate_value = data_low and en_aw_rate_mask
        end If

    End Sub

    Sub write
        If flag_mode_ar_fc = &H0 or flag_mode_aw_fc = &H0 or flag_en_awar_ot = &H0 or flag_en_ar_ot = &H0 or flag_en_aw_ot = &H0 or flag_en_ar_fc = &H0 or flag_en_aw_fc = &H0 or flag_en_awar_rate = &H0 or flag_en_ar_rate = &H0 or flag_en_aw_rate = &H0 Then read
        If flag_mode_ar_fc = &H0 Then write_mode_ar_fc_value = get_mode_ar_fc
        If flag_mode_aw_fc = &H0 Then write_mode_aw_fc_value = get_mode_aw_fc
        If flag_en_awar_ot = &H0 Then write_en_awar_ot_value = get_en_awar_ot
        If flag_en_ar_ot = &H0 Then write_en_ar_ot_value = get_en_ar_ot
        If flag_en_aw_ot = &H0 Then write_en_aw_ot_value = get_en_aw_ot
        If flag_en_ar_fc = &H0 Then write_en_ar_fc_value = get_en_ar_fc
        If flag_en_aw_fc = &H0 Then write_en_aw_fc_value = get_en_aw_fc
        If flag_en_awar_rate = &H0 Then write_en_awar_rate_value = get_en_awar_rate
        If flag_en_ar_rate = &H0 Then write_en_ar_rate_value = get_en_ar_rate
        If flag_en_aw_rate = &H0 Then write_en_aw_rate_value = get_en_aw_rate

        regValue = leftShift((write_mode_ar_fc_value and &H1), 20) + leftShift((write_mode_aw_fc_value and &H1), 16) + leftShift((write_en_awar_ot_value and &H1), 7) + leftShift((write_en_ar_ot_value and &H1), 6) + leftShift((write_en_aw_ot_value and &H1), 5) + leftShift((write_en_ar_fc_value and &H1), 4) + leftShift((write_en_aw_fc_value and &H1), 3) + leftShift((write_en_awar_rate_value and &H1), 2) + leftShift((write_en_ar_rate_value and &H1), 1) + leftShift((write_en_aw_rate_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_mode_ar_fc_value = rightShift(data_low, 20) and &H1
        read_mode_aw_fc_value = rightShift(data_low, 16) and &H1
        read_en_awar_ot_value = rightShift(data_low, 7) and &H1
        read_en_ar_ot_value = rightShift(data_low, 6) and &H1
        read_en_aw_ot_value = rightShift(data_low, 5) and &H1
        read_en_ar_fc_value = rightShift(data_low, 4) and &H1
        read_en_aw_fc_value = rightShift(data_low, 3) and &H1
        read_en_awar_rate_value = rightShift(data_low, 2) and &H1
        read_en_ar_rate_value = rightShift(data_low, 1) and &H1
        en_aw_rate_mask = &H1
        if data_low > LONG_MAX then
            if en_aw_rate_mask = mask then
                read_en_aw_rate_value = data_low
            else
                read_en_aw_rate_value = (data_low - H8000_0000) and en_aw_rate_mask
            end If
        else
            read_en_aw_rate_value = data_low and en_aw_rate_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mode_ar_fc_value = &H0
        flag_mode_ar_fc        = &H0
        write_mode_aw_fc_value = &H0
        flag_mode_aw_fc        = &H0
        write_en_awar_ot_value = &H0
        flag_en_awar_ot        = &H0
        write_en_ar_ot_value = &H0
        flag_en_ar_ot        = &H0
        write_en_aw_ot_value = &H0
        flag_en_aw_ot        = &H0
        write_en_ar_fc_value = &H0
        flag_en_ar_fc        = &H0
        write_en_aw_fc_value = &H0
        flag_en_aw_fc        = &H0
        write_en_awar_rate_value = &H0
        flag_en_awar_rate        = &H0
        write_en_ar_rate_value = &H0
        flag_en_ar_rate        = &H0
        write_en_aw_rate_value = &H0
        flag_en_aw_rate        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_max_ot_m7_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ar_max_oti                                 [29:24]          get_ar_max_oti
''                                                             set_ar_max_oti
''                                                             read_ar_max_oti
''                                                             write_ar_max_oti
''---------------------------------------------------------------------------------
'' ar_max_otf                                 [23:16]          get_ar_max_otf
''                                                             set_ar_max_otf
''                                                             read_ar_max_otf
''                                                             write_ar_max_otf
''---------------------------------------------------------------------------------
'' aw_max_oti                                 [13:8]           get_aw_max_oti
''                                                             set_aw_max_oti
''                                                             read_aw_max_oti
''                                                             write_aw_max_oti
''---------------------------------------------------------------------------------
'' en_ar_ot                                   [7:0]            get_en_ar_ot
''                                                             set_en_ar_ot
''                                                             read_en_ar_ot
''                                                             write_en_ar_ot
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_max_ot_m7_m
    Private write_ar_max_oti_value
    Private read_ar_max_oti_value
    Private flag_ar_max_oti
    Private write_ar_max_otf_value
    Private read_ar_max_otf_value
    Private flag_ar_max_otf
    Private write_aw_max_oti_value
    Private read_aw_max_oti_value
    Private flag_aw_max_oti
    Private write_en_ar_ot_value
    Private read_en_ar_ot_value
    Private flag_en_ar_ot

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H110
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ar_max_oti
        get_ar_max_oti = read_ar_max_oti_value
    End Property

    Property Let set_ar_max_oti(aData)
        write_ar_max_oti_value = aData
        flag_ar_max_oti        = &H1
    End Property

    Property Get read_ar_max_oti
        read
        read_ar_max_oti = read_ar_max_oti_value
    End Property

    Property Let write_ar_max_oti(aData)
        set_ar_max_oti = aData
        write
    End Property

    Property Get get_ar_max_otf
        get_ar_max_otf = read_ar_max_otf_value
    End Property

    Property Let set_ar_max_otf(aData)
        write_ar_max_otf_value = aData
        flag_ar_max_otf        = &H1
    End Property

    Property Get read_ar_max_otf
        read
        read_ar_max_otf = read_ar_max_otf_value
    End Property

    Property Let write_ar_max_otf(aData)
        set_ar_max_otf = aData
        write
    End Property

    Property Get get_aw_max_oti
        get_aw_max_oti = read_aw_max_oti_value
    End Property

    Property Let set_aw_max_oti(aData)
        write_aw_max_oti_value = aData
        flag_aw_max_oti        = &H1
    End Property

    Property Get read_aw_max_oti
        read
        read_aw_max_oti = read_aw_max_oti_value
    End Property

    Property Let write_aw_max_oti(aData)
        set_aw_max_oti = aData
        write
    End Property

    Property Get get_en_ar_ot
        get_en_ar_ot = read_en_ar_ot_value
    End Property

    Property Let set_en_ar_ot(aData)
        write_en_ar_ot_value = aData
        flag_en_ar_ot        = &H1
    End Property

    Property Get read_en_ar_ot
        read
        read_en_ar_ot = read_en_ar_ot_value
    End Property

    Property Let write_en_ar_ot(aData)
        set_en_ar_ot = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ar_max_oti_value = rightShift(data_low, 24) and &H3f
        read_ar_max_otf_value = rightShift(data_low, 16) and &Hff
        read_aw_max_oti_value = rightShift(data_low, 8) and &H3f
        en_ar_ot_mask = &Hff
        if data_low > LONG_MAX then
            if en_ar_ot_mask = mask then
                read_en_ar_ot_value = data_low
            else
                read_en_ar_ot_value = (data_low - H8000_0000) and en_ar_ot_mask
            end If
        else
            read_en_ar_ot_value = data_low and en_ar_ot_mask
        end If

    End Sub

    Sub write
        If flag_ar_max_oti = &H0 or flag_ar_max_otf = &H0 or flag_aw_max_oti = &H0 or flag_en_ar_ot = &H0 Then read
        If flag_ar_max_oti = &H0 Then write_ar_max_oti_value = get_ar_max_oti
        If flag_ar_max_otf = &H0 Then write_ar_max_otf_value = get_ar_max_otf
        If flag_aw_max_oti = &H0 Then write_aw_max_oti_value = get_aw_max_oti
        If flag_en_ar_ot = &H0 Then write_en_ar_ot_value = get_en_ar_ot

        regValue = leftShift((write_ar_max_oti_value and &H3f), 24) + leftShift((write_ar_max_otf_value and &Hff), 16) + leftShift((write_aw_max_oti_value and &H3f), 8) + leftShift((write_en_ar_ot_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ar_max_oti_value = rightShift(data_low, 24) and &H3f
        read_ar_max_otf_value = rightShift(data_low, 16) and &Hff
        read_aw_max_oti_value = rightShift(data_low, 8) and &H3f
        en_ar_ot_mask = &Hff
        if data_low > LONG_MAX then
            if en_ar_ot_mask = mask then
                read_en_ar_ot_value = data_low
            else
                read_en_ar_ot_value = (data_low - H8000_0000) and en_ar_ot_mask
            end If
        else
            read_en_ar_ot_value = data_low and en_ar_ot_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ar_max_oti_value = &H0
        flag_ar_max_oti        = &H0
        write_ar_max_otf_value = &H0
        flag_ar_max_otf        = &H0
        write_aw_max_oti_value = &H0
        flag_aw_max_oti        = &H0
        write_en_ar_ot_value = &H0
        flag_en_ar_ot        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_max_comb_ot_m7_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' awar_max_oti                               [14:8]           get_awar_max_oti
''                                                             set_awar_max_oti
''                                                             read_awar_max_oti
''                                                             write_awar_max_oti
''---------------------------------------------------------------------------------
'' awar_max_otf                               [7:0]            get_awar_max_otf
''                                                             set_awar_max_otf
''                                                             read_awar_max_otf
''                                                             write_awar_max_otf
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_max_comb_ot_m7_m
    Private write_awar_max_oti_value
    Private read_awar_max_oti_value
    Private flag_awar_max_oti
    Private write_awar_max_otf_value
    Private read_awar_max_otf_value
    Private flag_awar_max_otf

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H114
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_awar_max_oti
        get_awar_max_oti = read_awar_max_oti_value
    End Property

    Property Let set_awar_max_oti(aData)
        write_awar_max_oti_value = aData
        flag_awar_max_oti        = &H1
    End Property

    Property Get read_awar_max_oti
        read
        read_awar_max_oti = read_awar_max_oti_value
    End Property

    Property Let write_awar_max_oti(aData)
        set_awar_max_oti = aData
        write
    End Property

    Property Get get_awar_max_otf
        get_awar_max_otf = read_awar_max_otf_value
    End Property

    Property Let set_awar_max_otf(aData)
        write_awar_max_otf_value = aData
        flag_awar_max_otf        = &H1
    End Property

    Property Get read_awar_max_otf
        read
        read_awar_max_otf = read_awar_max_otf_value
    End Property

    Property Let write_awar_max_otf(aData)
        set_awar_max_otf = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_awar_max_oti_value = rightShift(data_low, 8) and &H7f
        awar_max_otf_mask = &Hff
        if data_low > LONG_MAX then
            if awar_max_otf_mask = mask then
                read_awar_max_otf_value = data_low
            else
                read_awar_max_otf_value = (data_low - H8000_0000) and awar_max_otf_mask
            end If
        else
            read_awar_max_otf_value = data_low and awar_max_otf_mask
        end If

    End Sub

    Sub write
        If flag_awar_max_oti = &H0 or flag_awar_max_otf = &H0 Then read
        If flag_awar_max_oti = &H0 Then write_awar_max_oti_value = get_awar_max_oti
        If flag_awar_max_otf = &H0 Then write_awar_max_otf_value = get_awar_max_otf

        regValue = leftShift((write_awar_max_oti_value and &H7f), 8) + leftShift((write_awar_max_otf_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_awar_max_oti_value = rightShift(data_low, 8) and &H7f
        awar_max_otf_mask = &Hff
        if data_low > LONG_MAX then
            if awar_max_otf_mask = mask then
                read_awar_max_otf_value = data_low
            else
                read_awar_max_otf_value = (data_low - H8000_0000) and awar_max_otf_mask
            end If
        else
            read_awar_max_otf_value = data_low and awar_max_otf_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_awar_max_oti_value = &H0
        flag_awar_max_oti        = &H0
        write_awar_max_otf_value = &H0
        flag_awar_max_otf        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_aw_p_m7_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' aw_p                                       [31:24]          get_aw_p
''                                                             set_aw_p
''                                                             read_aw_p
''                                                             write_aw_p
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_aw_p_m7_m
    Private write_aw_p_value
    Private read_aw_p_value
    Private flag_aw_p

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H118
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_aw_p
        get_aw_p = read_aw_p_value
    End Property

    Property Let set_aw_p(aData)
        write_aw_p_value = aData
        flag_aw_p        = &H1
    End Property

    Property Get read_aw_p
        read
        read_aw_p = read_aw_p_value
    End Property

    Property Let write_aw_p(aData)
        set_aw_p = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_aw_p_value = rightShift(data_low, 24) and &Hff

    End Sub

    Sub write
        If flag_aw_p = &H0 Then read
        If flag_aw_p = &H0 Then write_aw_p_value = get_aw_p

        regValue = leftShift((write_aw_p_value and &Hff), 24)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_aw_p_value = rightShift(data_low, 24) and &Hff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_aw_p_value = &H0
        flag_aw_p        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_aw_b_m7_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' aw_b                                       [15:0]           get_aw_b
''                                                             set_aw_b
''                                                             read_aw_b
''                                                             write_aw_b
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_aw_b_m7_m
    Private write_aw_b_value
    Private read_aw_b_value
    Private flag_aw_b

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H11c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_aw_b
        get_aw_b = read_aw_b_value
    End Property

    Property Let set_aw_b(aData)
        write_aw_b_value = aData
        flag_aw_b        = &H1
    End Property

    Property Get read_aw_b
        read
        read_aw_b = read_aw_b_value
    End Property

    Property Let write_aw_b(aData)
        set_aw_b = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        aw_b_mask = &Hffff
        if data_low > LONG_MAX then
            if aw_b_mask = mask then
                read_aw_b_value = data_low
            else
                read_aw_b_value = (data_low - H8000_0000) and aw_b_mask
            end If
        else
            read_aw_b_value = data_low and aw_b_mask
        end If

    End Sub

    Sub write
        If flag_aw_b = &H0 Then read
        If flag_aw_b = &H0 Then write_aw_b_value = get_aw_b

        regValue = leftShift((write_aw_b_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        aw_b_mask = &Hffff
        if data_low > LONG_MAX then
            if aw_b_mask = mask then
                read_aw_b_value = data_low
            else
                read_aw_b_value = (data_low - H8000_0000) and aw_b_mask
            end If
        else
            read_aw_b_value = data_low and aw_b_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_aw_b_value = &H0
        flag_aw_b        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_aw_r_m7_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' aw_r                                       [31:20]          get_aw_r
''                                                             set_aw_r
''                                                             read_aw_r
''                                                             write_aw_r
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_aw_r_m7_m
    Private write_aw_r_value
    Private read_aw_r_value
    Private flag_aw_r

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H120
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_aw_r
        get_aw_r = read_aw_r_value
    End Property

    Property Let set_aw_r(aData)
        write_aw_r_value = aData
        flag_aw_r        = &H1
    End Property

    Property Get read_aw_r
        read
        read_aw_r = read_aw_r_value
    End Property

    Property Let write_aw_r(aData)
        set_aw_r = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_aw_r_value = rightShift(data_low, 20) and &Hfff

    End Sub

    Sub write
        If flag_aw_r = &H0 Then read
        If flag_aw_r = &H0 Then write_aw_r_value = get_aw_r

        regValue = leftShift((write_aw_r_value and &Hfff), 20)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_aw_r_value = rightShift(data_low, 20) and &Hfff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_aw_r_value = &H0
        flag_aw_r        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_ar_p_m7_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ar_p                                       [31:24]          get_ar_p
''                                                             set_ar_p
''                                                             read_ar_p
''                                                             write_ar_p
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_ar_p_m7_m
    Private write_ar_p_value
    Private read_ar_p_value
    Private flag_ar_p

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H124
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ar_p
        get_ar_p = read_ar_p_value
    End Property

    Property Let set_ar_p(aData)
        write_ar_p_value = aData
        flag_ar_p        = &H1
    End Property

    Property Get read_ar_p
        read
        read_ar_p = read_ar_p_value
    End Property

    Property Let write_ar_p(aData)
        set_ar_p = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ar_p_value = rightShift(data_low, 24) and &Hff

    End Sub

    Sub write
        If flag_ar_p = &H0 Then read
        If flag_ar_p = &H0 Then write_ar_p_value = get_ar_p

        regValue = leftShift((write_ar_p_value and &Hff), 24)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ar_p_value = rightShift(data_low, 24) and &Hff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ar_p_value = &H0
        flag_ar_p        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_ar_b_m7_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ar_b                                       [15:0]           get_ar_b
''                                                             set_ar_b
''                                                             read_ar_b
''                                                             write_ar_b
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_ar_b_m7_m
    Private write_ar_b_value
    Private read_ar_b_value
    Private flag_ar_b

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H128
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ar_b
        get_ar_b = read_ar_b_value
    End Property

    Property Let set_ar_b(aData)
        write_ar_b_value = aData
        flag_ar_b        = &H1
    End Property

    Property Get read_ar_b
        read
        read_ar_b = read_ar_b_value
    End Property

    Property Let write_ar_b(aData)
        set_ar_b = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ar_b_mask = &Hffff
        if data_low > LONG_MAX then
            if ar_b_mask = mask then
                read_ar_b_value = data_low
            else
                read_ar_b_value = (data_low - H8000_0000) and ar_b_mask
            end If
        else
            read_ar_b_value = data_low and ar_b_mask
        end If

    End Sub

    Sub write
        If flag_ar_b = &H0 Then read
        If flag_ar_b = &H0 Then write_ar_b_value = get_ar_b

        regValue = leftShift((write_ar_b_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ar_b_mask = &Hffff
        if data_low > LONG_MAX then
            if ar_b_mask = mask then
                read_ar_b_value = data_low
            else
                read_ar_b_value = (data_low - H8000_0000) and ar_b_mask
            end If
        else
            read_ar_b_value = data_low and ar_b_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ar_b_value = &H0
        flag_ar_b        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_ar_r_m7_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ar_r                                       [31:20]          get_ar_r
''                                                             set_ar_r
''                                                             read_ar_r
''                                                             write_ar_r
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_ar_r_m7_m
    Private write_ar_r_value
    Private read_ar_r_value
    Private flag_ar_r

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H12c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ar_r
        get_ar_r = read_ar_r_value
    End Property

    Property Let set_ar_r(aData)
        write_ar_r_value = aData
        flag_ar_r        = &H1
    End Property

    Property Get read_ar_r
        read
        read_ar_r = read_ar_r_value
    End Property

    Property Let write_ar_r(aData)
        set_ar_r = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ar_r_value = rightShift(data_low, 20) and &Hfff

    End Sub

    Sub write
        If flag_ar_r = &H0 Then read
        If flag_ar_r = &H0 Then write_ar_r_value = get_ar_r

        regValue = leftShift((write_ar_r_value and &Hfff), 20)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ar_r_value = rightShift(data_low, 20) and &Hfff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ar_r_value = &H0
        flag_ar_r        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_target_fc_m7_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ar_tgt_latency                             [27:16]          get_ar_tgt_latency
''                                                             set_ar_tgt_latency
''                                                             read_ar_tgt_latency
''                                                             write_ar_tgt_latency
''---------------------------------------------------------------------------------
'' aw_tgt_latency                             [11:0]           get_aw_tgt_latency
''                                                             set_aw_tgt_latency
''                                                             read_aw_tgt_latency
''                                                             write_aw_tgt_latency
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_target_fc_m7_m
    Private write_ar_tgt_latency_value
    Private read_ar_tgt_latency_value
    Private flag_ar_tgt_latency
    Private write_aw_tgt_latency_value
    Private read_aw_tgt_latency_value
    Private flag_aw_tgt_latency

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H130
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ar_tgt_latency
        get_ar_tgt_latency = read_ar_tgt_latency_value
    End Property

    Property Let set_ar_tgt_latency(aData)
        write_ar_tgt_latency_value = aData
        flag_ar_tgt_latency        = &H1
    End Property

    Property Get read_ar_tgt_latency
        read
        read_ar_tgt_latency = read_ar_tgt_latency_value
    End Property

    Property Let write_ar_tgt_latency(aData)
        set_ar_tgt_latency = aData
        write
    End Property

    Property Get get_aw_tgt_latency
        get_aw_tgt_latency = read_aw_tgt_latency_value
    End Property

    Property Let set_aw_tgt_latency(aData)
        write_aw_tgt_latency_value = aData
        flag_aw_tgt_latency        = &H1
    End Property

    Property Get read_aw_tgt_latency
        read
        read_aw_tgt_latency = read_aw_tgt_latency_value
    End Property

    Property Let write_aw_tgt_latency(aData)
        set_aw_tgt_latency = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ar_tgt_latency_value = rightShift(data_low, 16) and &Hfff
        aw_tgt_latency_mask = &Hfff
        if data_low > LONG_MAX then
            if aw_tgt_latency_mask = mask then
                read_aw_tgt_latency_value = data_low
            else
                read_aw_tgt_latency_value = (data_low - H8000_0000) and aw_tgt_latency_mask
            end If
        else
            read_aw_tgt_latency_value = data_low and aw_tgt_latency_mask
        end If

    End Sub

    Sub write
        If flag_ar_tgt_latency = &H0 or flag_aw_tgt_latency = &H0 Then read
        If flag_ar_tgt_latency = &H0 Then write_ar_tgt_latency_value = get_ar_tgt_latency
        If flag_aw_tgt_latency = &H0 Then write_aw_tgt_latency_value = get_aw_tgt_latency

        regValue = leftShift((write_ar_tgt_latency_value and &Hfff), 16) + leftShift((write_aw_tgt_latency_value and &Hfff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ar_tgt_latency_value = rightShift(data_low, 16) and &Hfff
        aw_tgt_latency_mask = &Hfff
        if data_low > LONG_MAX then
            if aw_tgt_latency_mask = mask then
                read_aw_tgt_latency_value = data_low
            else
                read_aw_tgt_latency_value = (data_low - H8000_0000) and aw_tgt_latency_mask
            end If
        else
            read_aw_tgt_latency_value = data_low and aw_tgt_latency_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ar_tgt_latency_value = &H0
        flag_ar_tgt_latency        = &H0
        write_aw_tgt_latency_value = &H0
        flag_aw_tgt_latency        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_ki_fc_m7_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ar_ki                                      [10:8]           get_ar_ki
''                                                             set_ar_ki
''                                                             read_ar_ki
''                                                             write_ar_ki
''---------------------------------------------------------------------------------
'' aw_ki                                      [2:0]            get_aw_ki
''                                                             set_aw_ki
''                                                             read_aw_ki
''                                                             write_aw_ki
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_ki_fc_m7_m
    Private write_ar_ki_value
    Private read_ar_ki_value
    Private flag_ar_ki
    Private write_aw_ki_value
    Private read_aw_ki_value
    Private flag_aw_ki

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H134
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ar_ki
        get_ar_ki = read_ar_ki_value
    End Property

    Property Let set_ar_ki(aData)
        write_ar_ki_value = aData
        flag_ar_ki        = &H1
    End Property

    Property Get read_ar_ki
        read
        read_ar_ki = read_ar_ki_value
    End Property

    Property Let write_ar_ki(aData)
        set_ar_ki = aData
        write
    End Property

    Property Get get_aw_ki
        get_aw_ki = read_aw_ki_value
    End Property

    Property Let set_aw_ki(aData)
        write_aw_ki_value = aData
        flag_aw_ki        = &H1
    End Property

    Property Get read_aw_ki
        read
        read_aw_ki = read_aw_ki_value
    End Property

    Property Let write_aw_ki(aData)
        set_aw_ki = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ar_ki_value = rightShift(data_low, 8) and &H7
        aw_ki_mask = &H7
        if data_low > LONG_MAX then
            if aw_ki_mask = mask then
                read_aw_ki_value = data_low
            else
                read_aw_ki_value = (data_low - H8000_0000) and aw_ki_mask
            end If
        else
            read_aw_ki_value = data_low and aw_ki_mask
        end If

    End Sub

    Sub write
        If flag_ar_ki = &H0 or flag_aw_ki = &H0 Then read
        If flag_ar_ki = &H0 Then write_ar_ki_value = get_ar_ki
        If flag_aw_ki = &H0 Then write_aw_ki_value = get_aw_ki

        regValue = leftShift((write_ar_ki_value and &H7), 8) + leftShift((write_aw_ki_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ar_ki_value = rightShift(data_low, 8) and &H7
        aw_ki_mask = &H7
        if data_low > LONG_MAX then
            if aw_ki_mask = mask then
                read_aw_ki_value = data_low
            else
                read_aw_ki_value = (data_low - H8000_0000) and aw_ki_mask
            end If
        else
            read_aw_ki_value = data_low and aw_ki_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ar_ki_value = &H0
        flag_ar_ki        = &H0
        write_aw_ki_value = &H0
        flag_aw_ki        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_qos_range_m7_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ar_max_qos                                 [27:24]          get_ar_max_qos
''                                                             set_ar_max_qos
''                                                             read_ar_max_qos
''                                                             write_ar_max_qos
''---------------------------------------------------------------------------------
'' ar_min_qos                                 [19:16]          get_ar_min_qos
''                                                             set_ar_min_qos
''                                                             read_ar_min_qos
''                                                             write_ar_min_qos
''---------------------------------------------------------------------------------
'' aw_max_qos                                 [11:8]           get_aw_max_qos
''                                                             set_aw_max_qos
''                                                             read_aw_max_qos
''                                                             write_aw_max_qos
''---------------------------------------------------------------------------------
'' aw_min_qos                                 [3:0]            get_aw_min_qos
''                                                             set_aw_min_qos
''                                                             read_aw_min_qos
''                                                             write_aw_min_qos
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_qos_range_m7_m
    Private write_ar_max_qos_value
    Private read_ar_max_qos_value
    Private flag_ar_max_qos
    Private write_ar_min_qos_value
    Private read_ar_min_qos_value
    Private flag_ar_min_qos
    Private write_aw_max_qos_value
    Private read_aw_max_qos_value
    Private flag_aw_max_qos
    Private write_aw_min_qos_value
    Private read_aw_min_qos_value
    Private flag_aw_min_qos

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H138
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ar_max_qos
        get_ar_max_qos = read_ar_max_qos_value
    End Property

    Property Let set_ar_max_qos(aData)
        write_ar_max_qos_value = aData
        flag_ar_max_qos        = &H1
    End Property

    Property Get read_ar_max_qos
        read
        read_ar_max_qos = read_ar_max_qos_value
    End Property

    Property Let write_ar_max_qos(aData)
        set_ar_max_qos = aData
        write
    End Property

    Property Get get_ar_min_qos
        get_ar_min_qos = read_ar_min_qos_value
    End Property

    Property Let set_ar_min_qos(aData)
        write_ar_min_qos_value = aData
        flag_ar_min_qos        = &H1
    End Property

    Property Get read_ar_min_qos
        read
        read_ar_min_qos = read_ar_min_qos_value
    End Property

    Property Let write_ar_min_qos(aData)
        set_ar_min_qos = aData
        write
    End Property

    Property Get get_aw_max_qos
        get_aw_max_qos = read_aw_max_qos_value
    End Property

    Property Let set_aw_max_qos(aData)
        write_aw_max_qos_value = aData
        flag_aw_max_qos        = &H1
    End Property

    Property Get read_aw_max_qos
        read
        read_aw_max_qos = read_aw_max_qos_value
    End Property

    Property Let write_aw_max_qos(aData)
        set_aw_max_qos = aData
        write
    End Property

    Property Get get_aw_min_qos
        get_aw_min_qos = read_aw_min_qos_value
    End Property

    Property Let set_aw_min_qos(aData)
        write_aw_min_qos_value = aData
        flag_aw_min_qos        = &H1
    End Property

    Property Get read_aw_min_qos
        read
        read_aw_min_qos = read_aw_min_qos_value
    End Property

    Property Let write_aw_min_qos(aData)
        set_aw_min_qos = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ar_max_qos_value = rightShift(data_low, 24) and &Hf
        read_ar_min_qos_value = rightShift(data_low, 16) and &Hf
        read_aw_max_qos_value = rightShift(data_low, 8) and &Hf
        aw_min_qos_mask = &Hf
        if data_low > LONG_MAX then
            if aw_min_qos_mask = mask then
                read_aw_min_qos_value = data_low
            else
                read_aw_min_qos_value = (data_low - H8000_0000) and aw_min_qos_mask
            end If
        else
            read_aw_min_qos_value = data_low and aw_min_qos_mask
        end If

    End Sub

    Sub write
        If flag_ar_max_qos = &H0 or flag_ar_min_qos = &H0 or flag_aw_max_qos = &H0 or flag_aw_min_qos = &H0 Then read
        If flag_ar_max_qos = &H0 Then write_ar_max_qos_value = get_ar_max_qos
        If flag_ar_min_qos = &H0 Then write_ar_min_qos_value = get_ar_min_qos
        If flag_aw_max_qos = &H0 Then write_aw_max_qos_value = get_aw_max_qos
        If flag_aw_min_qos = &H0 Then write_aw_min_qos_value = get_aw_min_qos

        regValue = leftShift((write_ar_max_qos_value and &Hf), 24) + leftShift((write_ar_min_qos_value and &Hf), 16) + leftShift((write_aw_max_qos_value and &Hf), 8) + leftShift((write_aw_min_qos_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ar_max_qos_value = rightShift(data_low, 24) and &Hf
        read_ar_min_qos_value = rightShift(data_low, 16) and &Hf
        read_aw_max_qos_value = rightShift(data_low, 8) and &Hf
        aw_min_qos_mask = &Hf
        if data_low > LONG_MAX then
            if aw_min_qos_mask = mask then
                read_aw_min_qos_value = data_low
            else
                read_aw_min_qos_value = (data_low - H8000_0000) and aw_min_qos_mask
            end If
        else
            read_aw_min_qos_value = data_low and aw_min_qos_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ar_max_qos_value = &H0
        flag_ar_max_qos        = &H0
        write_ar_min_qos_value = &H0
        flag_ar_min_qos        = &H0
        write_aw_max_qos_value = &H0
        flag_aw_max_qos        = &H0
        write_aw_min_qos_value = &H0
        flag_aw_min_qos        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_fn_mod2_amac_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' fn_mode2                                   [0:0]            get_fn_mode2
''                                                             set_fn_mode2
''                                                             read_fn_mode2
''                                                             write_fn_mode2
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_fn_mod2_amac_m
    Private write_fn_mode2_value
    Private read_fn_mode2_value
    Private flag_fn_mode2

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1024
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_fn_mode2
        get_fn_mode2 = read_fn_mode2_value
    End Property

    Property Let set_fn_mode2(aData)
        write_fn_mode2_value = aData
        flag_fn_mode2        = &H1
    End Property

    Property Get read_fn_mode2
        read
        read_fn_mode2 = read_fn_mode2_value
    End Property

    Property Let write_fn_mode2(aData)
        set_fn_mode2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        fn_mode2_mask = &H1
        if data_low > LONG_MAX then
            if fn_mode2_mask = mask then
                read_fn_mode2_value = data_low
            else
                read_fn_mode2_value = (data_low - H8000_0000) and fn_mode2_mask
            end If
        else
            read_fn_mode2_value = data_low and fn_mode2_mask
        end If

    End Sub

    Sub write
        If flag_fn_mode2 = &H0 Then read
        If flag_fn_mode2 = &H0 Then write_fn_mode2_value = get_fn_mode2

        regValue = leftShift((write_fn_mode2_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        fn_mode2_mask = &H1
        if data_low > LONG_MAX then
            if fn_mode2_mask = mask then
                read_fn_mode2_value = data_low
            else
                read_fn_mode2_value = (data_low - H8000_0000) and fn_mode2_mask
            end If
        else
            read_fn_mode2_value = data_low and fn_mode2_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_fn_mode2_value = &H0
        flag_fn_mode2        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_read_qos_amac_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' read_qos                                   [3:0]            get_read_qos
''                                                             set_read_qos
''                                                             read_read_qos
''                                                             write_read_qos
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_read_qos_amac_m
    Private write_read_qos_value
    Private read_read_qos_value
    Private flag_read_qos

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1100
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_read_qos
        get_read_qos = read_read_qos_value
    End Property

    Property Let set_read_qos(aData)
        write_read_qos_value = aData
        flag_read_qos        = &H1
    End Property

    Property Get read_read_qos
        read
        read_read_qos = read_read_qos_value
    End Property

    Property Let write_read_qos(aData)
        set_read_qos = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_qos_mask = &Hf
        if data_low > LONG_MAX then
            if read_qos_mask = mask then
                read_read_qos_value = data_low
            else
                read_read_qos_value = (data_low - H8000_0000) and read_qos_mask
            end If
        else
            read_read_qos_value = data_low and read_qos_mask
        end If

    End Sub

    Sub write
        If flag_read_qos = &H0 Then read
        If flag_read_qos = &H0 Then write_read_qos_value = get_read_qos

        regValue = leftShift((write_read_qos_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_qos_mask = &Hf
        if data_low > LONG_MAX then
            if read_qos_mask = mask then
                read_read_qos_value = data_low
            else
                read_read_qos_value = (data_low - H8000_0000) and read_qos_mask
            end If
        else
            read_read_qos_value = data_low and read_qos_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_read_qos_value = &H0
        flag_read_qos        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_write_qos_amac_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' write_qos                                  [3:0]            get_write_qos
''                                                             set_write_qos
''                                                             read_write_qos
''                                                             write_write_qos
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_write_qos_amac_m
    Private write_write_qos_value
    Private read_write_qos_value
    Private flag_write_qos

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1104
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_write_qos
        get_write_qos = read_write_qos_value
    End Property

    Property Let set_write_qos(aData)
        write_write_qos_value = aData
        flag_write_qos        = &H1
    End Property

    Property Get read_write_qos
        read
        read_write_qos = read_write_qos_value
    End Property

    Property Let write_write_qos(aData)
        set_write_qos = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        write_qos_mask = &Hf
        if data_low > LONG_MAX then
            if write_qos_mask = mask then
                read_write_qos_value = data_low
            else
                read_write_qos_value = (data_low - H8000_0000) and write_qos_mask
            end If
        else
            read_write_qos_value = data_low and write_qos_mask
        end If

    End Sub

    Sub write
        If flag_write_qos = &H0 Then read
        If flag_write_qos = &H0 Then write_write_qos_value = get_write_qos

        regValue = leftShift((write_write_qos_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        write_qos_mask = &Hf
        if data_low > LONG_MAX then
            if write_qos_mask = mask then
                read_write_qos_value = data_low
            else
                read_write_qos_value = (data_low - H8000_0000) and write_qos_mask
            end If
        else
            read_write_qos_value = data_low and write_qos_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_write_qos_value = &H0
        flag_write_qos        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_fn_mod_amac_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' fn_mod                                     [1:0]            get_fn_mod
''                                                             set_fn_mod
''                                                             read_fn_mod
''                                                             write_fn_mod
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_fn_mod_amac_m
    Private write_fn_mod_value
    Private read_fn_mod_value
    Private flag_fn_mod

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1108
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_fn_mod
        get_fn_mod = read_fn_mod_value
    End Property

    Property Let set_fn_mod(aData)
        write_fn_mod_value = aData
        flag_fn_mod        = &H1
    End Property

    Property Get read_fn_mod
        read
        read_fn_mod = read_fn_mod_value
    End Property

    Property Let write_fn_mod(aData)
        set_fn_mod = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        fn_mod_mask = &H3
        if data_low > LONG_MAX then
            if fn_mod_mask = mask then
                read_fn_mod_value = data_low
            else
                read_fn_mod_value = (data_low - H8000_0000) and fn_mod_mask
            end If
        else
            read_fn_mod_value = data_low and fn_mod_mask
        end If

    End Sub

    Sub write
        If flag_fn_mod = &H0 Then read
        If flag_fn_mod = &H0 Then write_fn_mod_value = get_fn_mod

        regValue = leftShift((write_fn_mod_value and &H3), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        fn_mod_mask = &H3
        if data_low > LONG_MAX then
            if fn_mod_mask = mask then
                read_fn_mod_value = data_low
            else
                read_fn_mod_value = (data_low - H8000_0000) and fn_mod_mask
            end If
        else
            read_fn_mod_value = data_low and fn_mod_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_fn_mod_value = &H0
        flag_fn_mod        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_qos_cntl_amac_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mode_ar_fc                                 [20:20]          get_mode_ar_fc
''                                                             set_mode_ar_fc
''                                                             read_mode_ar_fc
''                                                             write_mode_ar_fc
''---------------------------------------------------------------------------------
'' mode_aw_fc                                 [16:16]          get_mode_aw_fc
''                                                             set_mode_aw_fc
''                                                             read_mode_aw_fc
''                                                             write_mode_aw_fc
''---------------------------------------------------------------------------------
'' en_awar_ot                                 [7:7]            get_en_awar_ot
''                                                             set_en_awar_ot
''                                                             read_en_awar_ot
''                                                             write_en_awar_ot
''---------------------------------------------------------------------------------
'' en_ar_ot                                   [6:6]            get_en_ar_ot
''                                                             set_en_ar_ot
''                                                             read_en_ar_ot
''                                                             write_en_ar_ot
''---------------------------------------------------------------------------------
'' en_aw_ot                                   [5:5]            get_en_aw_ot
''                                                             set_en_aw_ot
''                                                             read_en_aw_ot
''                                                             write_en_aw_ot
''---------------------------------------------------------------------------------
'' en_ar_fc                                   [4:4]            get_en_ar_fc
''                                                             set_en_ar_fc
''                                                             read_en_ar_fc
''                                                             write_en_ar_fc
''---------------------------------------------------------------------------------
'' en_aw_fc                                   [3:3]            get_en_aw_fc
''                                                             set_en_aw_fc
''                                                             read_en_aw_fc
''                                                             write_en_aw_fc
''---------------------------------------------------------------------------------
'' en_awar_rate                               [2:2]            get_en_awar_rate
''                                                             set_en_awar_rate
''                                                             read_en_awar_rate
''                                                             write_en_awar_rate
''---------------------------------------------------------------------------------
'' en_ar_rate                                 [1:1]            get_en_ar_rate
''                                                             set_en_ar_rate
''                                                             read_en_ar_rate
''                                                             write_en_ar_rate
''---------------------------------------------------------------------------------
'' en_aw_rate                                 [0:0]            get_en_aw_rate
''                                                             set_en_aw_rate
''                                                             read_en_aw_rate
''                                                             write_en_aw_rate
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_qos_cntl_amac_m
    Private write_mode_ar_fc_value
    Private read_mode_ar_fc_value
    Private flag_mode_ar_fc
    Private write_mode_aw_fc_value
    Private read_mode_aw_fc_value
    Private flag_mode_aw_fc
    Private write_en_awar_ot_value
    Private read_en_awar_ot_value
    Private flag_en_awar_ot
    Private write_en_ar_ot_value
    Private read_en_ar_ot_value
    Private flag_en_ar_ot
    Private write_en_aw_ot_value
    Private read_en_aw_ot_value
    Private flag_en_aw_ot
    Private write_en_ar_fc_value
    Private read_en_ar_fc_value
    Private flag_en_ar_fc
    Private write_en_aw_fc_value
    Private read_en_aw_fc_value
    Private flag_en_aw_fc
    Private write_en_awar_rate_value
    Private read_en_awar_rate_value
    Private flag_en_awar_rate
    Private write_en_ar_rate_value
    Private read_en_ar_rate_value
    Private flag_en_ar_rate
    Private write_en_aw_rate_value
    Private read_en_aw_rate_value
    Private flag_en_aw_rate

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H110c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mode_ar_fc
        get_mode_ar_fc = read_mode_ar_fc_value
    End Property

    Property Let set_mode_ar_fc(aData)
        write_mode_ar_fc_value = aData
        flag_mode_ar_fc        = &H1
    End Property

    Property Get read_mode_ar_fc
        read
        read_mode_ar_fc = read_mode_ar_fc_value
    End Property

    Property Let write_mode_ar_fc(aData)
        set_mode_ar_fc = aData
        write
    End Property

    Property Get get_mode_aw_fc
        get_mode_aw_fc = read_mode_aw_fc_value
    End Property

    Property Let set_mode_aw_fc(aData)
        write_mode_aw_fc_value = aData
        flag_mode_aw_fc        = &H1
    End Property

    Property Get read_mode_aw_fc
        read
        read_mode_aw_fc = read_mode_aw_fc_value
    End Property

    Property Let write_mode_aw_fc(aData)
        set_mode_aw_fc = aData
        write
    End Property

    Property Get get_en_awar_ot
        get_en_awar_ot = read_en_awar_ot_value
    End Property

    Property Let set_en_awar_ot(aData)
        write_en_awar_ot_value = aData
        flag_en_awar_ot        = &H1
    End Property

    Property Get read_en_awar_ot
        read
        read_en_awar_ot = read_en_awar_ot_value
    End Property

    Property Let write_en_awar_ot(aData)
        set_en_awar_ot = aData
        write
    End Property

    Property Get get_en_ar_ot
        get_en_ar_ot = read_en_ar_ot_value
    End Property

    Property Let set_en_ar_ot(aData)
        write_en_ar_ot_value = aData
        flag_en_ar_ot        = &H1
    End Property

    Property Get read_en_ar_ot
        read
        read_en_ar_ot = read_en_ar_ot_value
    End Property

    Property Let write_en_ar_ot(aData)
        set_en_ar_ot = aData
        write
    End Property

    Property Get get_en_aw_ot
        get_en_aw_ot = read_en_aw_ot_value
    End Property

    Property Let set_en_aw_ot(aData)
        write_en_aw_ot_value = aData
        flag_en_aw_ot        = &H1
    End Property

    Property Get read_en_aw_ot
        read
        read_en_aw_ot = read_en_aw_ot_value
    End Property

    Property Let write_en_aw_ot(aData)
        set_en_aw_ot = aData
        write
    End Property

    Property Get get_en_ar_fc
        get_en_ar_fc = read_en_ar_fc_value
    End Property

    Property Let set_en_ar_fc(aData)
        write_en_ar_fc_value = aData
        flag_en_ar_fc        = &H1
    End Property

    Property Get read_en_ar_fc
        read
        read_en_ar_fc = read_en_ar_fc_value
    End Property

    Property Let write_en_ar_fc(aData)
        set_en_ar_fc = aData
        write
    End Property

    Property Get get_en_aw_fc
        get_en_aw_fc = read_en_aw_fc_value
    End Property

    Property Let set_en_aw_fc(aData)
        write_en_aw_fc_value = aData
        flag_en_aw_fc        = &H1
    End Property

    Property Get read_en_aw_fc
        read
        read_en_aw_fc = read_en_aw_fc_value
    End Property

    Property Let write_en_aw_fc(aData)
        set_en_aw_fc = aData
        write
    End Property

    Property Get get_en_awar_rate
        get_en_awar_rate = read_en_awar_rate_value
    End Property

    Property Let set_en_awar_rate(aData)
        write_en_awar_rate_value = aData
        flag_en_awar_rate        = &H1
    End Property

    Property Get read_en_awar_rate
        read
        read_en_awar_rate = read_en_awar_rate_value
    End Property

    Property Let write_en_awar_rate(aData)
        set_en_awar_rate = aData
        write
    End Property

    Property Get get_en_ar_rate
        get_en_ar_rate = read_en_ar_rate_value
    End Property

    Property Let set_en_ar_rate(aData)
        write_en_ar_rate_value = aData
        flag_en_ar_rate        = &H1
    End Property

    Property Get read_en_ar_rate
        read
        read_en_ar_rate = read_en_ar_rate_value
    End Property

    Property Let write_en_ar_rate(aData)
        set_en_ar_rate = aData
        write
    End Property

    Property Get get_en_aw_rate
        get_en_aw_rate = read_en_aw_rate_value
    End Property

    Property Let set_en_aw_rate(aData)
        write_en_aw_rate_value = aData
        flag_en_aw_rate        = &H1
    End Property

    Property Get read_en_aw_rate
        read
        read_en_aw_rate = read_en_aw_rate_value
    End Property

    Property Let write_en_aw_rate(aData)
        set_en_aw_rate = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_mode_ar_fc_value = rightShift(data_low, 20) and &H1
        read_mode_aw_fc_value = rightShift(data_low, 16) and &H1
        read_en_awar_ot_value = rightShift(data_low, 7) and &H1
        read_en_ar_ot_value = rightShift(data_low, 6) and &H1
        read_en_aw_ot_value = rightShift(data_low, 5) and &H1
        read_en_ar_fc_value = rightShift(data_low, 4) and &H1
        read_en_aw_fc_value = rightShift(data_low, 3) and &H1
        read_en_awar_rate_value = rightShift(data_low, 2) and &H1
        read_en_ar_rate_value = rightShift(data_low, 1) and &H1
        en_aw_rate_mask = &H1
        if data_low > LONG_MAX then
            if en_aw_rate_mask = mask then
                read_en_aw_rate_value = data_low
            else
                read_en_aw_rate_value = (data_low - H8000_0000) and en_aw_rate_mask
            end If
        else
            read_en_aw_rate_value = data_low and en_aw_rate_mask
        end If

    End Sub

    Sub write
        If flag_mode_ar_fc = &H0 or flag_mode_aw_fc = &H0 or flag_en_awar_ot = &H0 or flag_en_ar_ot = &H0 or flag_en_aw_ot = &H0 or flag_en_ar_fc = &H0 or flag_en_aw_fc = &H0 or flag_en_awar_rate = &H0 or flag_en_ar_rate = &H0 or flag_en_aw_rate = &H0 Then read
        If flag_mode_ar_fc = &H0 Then write_mode_ar_fc_value = get_mode_ar_fc
        If flag_mode_aw_fc = &H0 Then write_mode_aw_fc_value = get_mode_aw_fc
        If flag_en_awar_ot = &H0 Then write_en_awar_ot_value = get_en_awar_ot
        If flag_en_ar_ot = &H0 Then write_en_ar_ot_value = get_en_ar_ot
        If flag_en_aw_ot = &H0 Then write_en_aw_ot_value = get_en_aw_ot
        If flag_en_ar_fc = &H0 Then write_en_ar_fc_value = get_en_ar_fc
        If flag_en_aw_fc = &H0 Then write_en_aw_fc_value = get_en_aw_fc
        If flag_en_awar_rate = &H0 Then write_en_awar_rate_value = get_en_awar_rate
        If flag_en_ar_rate = &H0 Then write_en_ar_rate_value = get_en_ar_rate
        If flag_en_aw_rate = &H0 Then write_en_aw_rate_value = get_en_aw_rate

        regValue = leftShift((write_mode_ar_fc_value and &H1), 20) + leftShift((write_mode_aw_fc_value and &H1), 16) + leftShift((write_en_awar_ot_value and &H1), 7) + leftShift((write_en_ar_ot_value and &H1), 6) + leftShift((write_en_aw_ot_value and &H1), 5) + leftShift((write_en_ar_fc_value and &H1), 4) + leftShift((write_en_aw_fc_value and &H1), 3) + leftShift((write_en_awar_rate_value and &H1), 2) + leftShift((write_en_ar_rate_value and &H1), 1) + leftShift((write_en_aw_rate_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_mode_ar_fc_value = rightShift(data_low, 20) and &H1
        read_mode_aw_fc_value = rightShift(data_low, 16) and &H1
        read_en_awar_ot_value = rightShift(data_low, 7) and &H1
        read_en_ar_ot_value = rightShift(data_low, 6) and &H1
        read_en_aw_ot_value = rightShift(data_low, 5) and &H1
        read_en_ar_fc_value = rightShift(data_low, 4) and &H1
        read_en_aw_fc_value = rightShift(data_low, 3) and &H1
        read_en_awar_rate_value = rightShift(data_low, 2) and &H1
        read_en_ar_rate_value = rightShift(data_low, 1) and &H1
        en_aw_rate_mask = &H1
        if data_low > LONG_MAX then
            if en_aw_rate_mask = mask then
                read_en_aw_rate_value = data_low
            else
                read_en_aw_rate_value = (data_low - H8000_0000) and en_aw_rate_mask
            end If
        else
            read_en_aw_rate_value = data_low and en_aw_rate_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mode_ar_fc_value = &H0
        flag_mode_ar_fc        = &H0
        write_mode_aw_fc_value = &H0
        flag_mode_aw_fc        = &H0
        write_en_awar_ot_value = &H0
        flag_en_awar_ot        = &H0
        write_en_ar_ot_value = &H0
        flag_en_ar_ot        = &H0
        write_en_aw_ot_value = &H0
        flag_en_aw_ot        = &H0
        write_en_ar_fc_value = &H0
        flag_en_ar_fc        = &H0
        write_en_aw_fc_value = &H0
        flag_en_aw_fc        = &H0
        write_en_awar_rate_value = &H0
        flag_en_awar_rate        = &H0
        write_en_ar_rate_value = &H0
        flag_en_ar_rate        = &H0
        write_en_aw_rate_value = &H0
        flag_en_aw_rate        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_max_ot_amac_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ar_max_oti                                 [29:24]          get_ar_max_oti
''                                                             set_ar_max_oti
''                                                             read_ar_max_oti
''                                                             write_ar_max_oti
''---------------------------------------------------------------------------------
'' ar_max_otf                                 [23:16]          get_ar_max_otf
''                                                             set_ar_max_otf
''                                                             read_ar_max_otf
''                                                             write_ar_max_otf
''---------------------------------------------------------------------------------
'' aw_max_oti                                 [13:8]           get_aw_max_oti
''                                                             set_aw_max_oti
''                                                             read_aw_max_oti
''                                                             write_aw_max_oti
''---------------------------------------------------------------------------------
'' en_ar_ot                                   [7:0]            get_en_ar_ot
''                                                             set_en_ar_ot
''                                                             read_en_ar_ot
''                                                             write_en_ar_ot
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_max_ot_amac_m
    Private write_ar_max_oti_value
    Private read_ar_max_oti_value
    Private flag_ar_max_oti
    Private write_ar_max_otf_value
    Private read_ar_max_otf_value
    Private flag_ar_max_otf
    Private write_aw_max_oti_value
    Private read_aw_max_oti_value
    Private flag_aw_max_oti
    Private write_en_ar_ot_value
    Private read_en_ar_ot_value
    Private flag_en_ar_ot

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1110
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ar_max_oti
        get_ar_max_oti = read_ar_max_oti_value
    End Property

    Property Let set_ar_max_oti(aData)
        write_ar_max_oti_value = aData
        flag_ar_max_oti        = &H1
    End Property

    Property Get read_ar_max_oti
        read
        read_ar_max_oti = read_ar_max_oti_value
    End Property

    Property Let write_ar_max_oti(aData)
        set_ar_max_oti = aData
        write
    End Property

    Property Get get_ar_max_otf
        get_ar_max_otf = read_ar_max_otf_value
    End Property

    Property Let set_ar_max_otf(aData)
        write_ar_max_otf_value = aData
        flag_ar_max_otf        = &H1
    End Property

    Property Get read_ar_max_otf
        read
        read_ar_max_otf = read_ar_max_otf_value
    End Property

    Property Let write_ar_max_otf(aData)
        set_ar_max_otf = aData
        write
    End Property

    Property Get get_aw_max_oti
        get_aw_max_oti = read_aw_max_oti_value
    End Property

    Property Let set_aw_max_oti(aData)
        write_aw_max_oti_value = aData
        flag_aw_max_oti        = &H1
    End Property

    Property Get read_aw_max_oti
        read
        read_aw_max_oti = read_aw_max_oti_value
    End Property

    Property Let write_aw_max_oti(aData)
        set_aw_max_oti = aData
        write
    End Property

    Property Get get_en_ar_ot
        get_en_ar_ot = read_en_ar_ot_value
    End Property

    Property Let set_en_ar_ot(aData)
        write_en_ar_ot_value = aData
        flag_en_ar_ot        = &H1
    End Property

    Property Get read_en_ar_ot
        read
        read_en_ar_ot = read_en_ar_ot_value
    End Property

    Property Let write_en_ar_ot(aData)
        set_en_ar_ot = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ar_max_oti_value = rightShift(data_low, 24) and &H3f
        read_ar_max_otf_value = rightShift(data_low, 16) and &Hff
        read_aw_max_oti_value = rightShift(data_low, 8) and &H3f
        en_ar_ot_mask = &Hff
        if data_low > LONG_MAX then
            if en_ar_ot_mask = mask then
                read_en_ar_ot_value = data_low
            else
                read_en_ar_ot_value = (data_low - H8000_0000) and en_ar_ot_mask
            end If
        else
            read_en_ar_ot_value = data_low and en_ar_ot_mask
        end If

    End Sub

    Sub write
        If flag_ar_max_oti = &H0 or flag_ar_max_otf = &H0 or flag_aw_max_oti = &H0 or flag_en_ar_ot = &H0 Then read
        If flag_ar_max_oti = &H0 Then write_ar_max_oti_value = get_ar_max_oti
        If flag_ar_max_otf = &H0 Then write_ar_max_otf_value = get_ar_max_otf
        If flag_aw_max_oti = &H0 Then write_aw_max_oti_value = get_aw_max_oti
        If flag_en_ar_ot = &H0 Then write_en_ar_ot_value = get_en_ar_ot

        regValue = leftShift((write_ar_max_oti_value and &H3f), 24) + leftShift((write_ar_max_otf_value and &Hff), 16) + leftShift((write_aw_max_oti_value and &H3f), 8) + leftShift((write_en_ar_ot_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ar_max_oti_value = rightShift(data_low, 24) and &H3f
        read_ar_max_otf_value = rightShift(data_low, 16) and &Hff
        read_aw_max_oti_value = rightShift(data_low, 8) and &H3f
        en_ar_ot_mask = &Hff
        if data_low > LONG_MAX then
            if en_ar_ot_mask = mask then
                read_en_ar_ot_value = data_low
            else
                read_en_ar_ot_value = (data_low - H8000_0000) and en_ar_ot_mask
            end If
        else
            read_en_ar_ot_value = data_low and en_ar_ot_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ar_max_oti_value = &H0
        flag_ar_max_oti        = &H0
        write_ar_max_otf_value = &H0
        flag_ar_max_otf        = &H0
        write_aw_max_oti_value = &H0
        flag_aw_max_oti        = &H0
        write_en_ar_ot_value = &H0
        flag_en_ar_ot        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_max_comb_ot_amac_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' awar_max_oti                               [14:8]           get_awar_max_oti
''                                                             set_awar_max_oti
''                                                             read_awar_max_oti
''                                                             write_awar_max_oti
''---------------------------------------------------------------------------------
'' awar_max_otf                               [7:0]            get_awar_max_otf
''                                                             set_awar_max_otf
''                                                             read_awar_max_otf
''                                                             write_awar_max_otf
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_max_comb_ot_amac_m
    Private write_awar_max_oti_value
    Private read_awar_max_oti_value
    Private flag_awar_max_oti
    Private write_awar_max_otf_value
    Private read_awar_max_otf_value
    Private flag_awar_max_otf

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1114
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_awar_max_oti
        get_awar_max_oti = read_awar_max_oti_value
    End Property

    Property Let set_awar_max_oti(aData)
        write_awar_max_oti_value = aData
        flag_awar_max_oti        = &H1
    End Property

    Property Get read_awar_max_oti
        read
        read_awar_max_oti = read_awar_max_oti_value
    End Property

    Property Let write_awar_max_oti(aData)
        set_awar_max_oti = aData
        write
    End Property

    Property Get get_awar_max_otf
        get_awar_max_otf = read_awar_max_otf_value
    End Property

    Property Let set_awar_max_otf(aData)
        write_awar_max_otf_value = aData
        flag_awar_max_otf        = &H1
    End Property

    Property Get read_awar_max_otf
        read
        read_awar_max_otf = read_awar_max_otf_value
    End Property

    Property Let write_awar_max_otf(aData)
        set_awar_max_otf = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_awar_max_oti_value = rightShift(data_low, 8) and &H7f
        awar_max_otf_mask = &Hff
        if data_low > LONG_MAX then
            if awar_max_otf_mask = mask then
                read_awar_max_otf_value = data_low
            else
                read_awar_max_otf_value = (data_low - H8000_0000) and awar_max_otf_mask
            end If
        else
            read_awar_max_otf_value = data_low and awar_max_otf_mask
        end If

    End Sub

    Sub write
        If flag_awar_max_oti = &H0 or flag_awar_max_otf = &H0 Then read
        If flag_awar_max_oti = &H0 Then write_awar_max_oti_value = get_awar_max_oti
        If flag_awar_max_otf = &H0 Then write_awar_max_otf_value = get_awar_max_otf

        regValue = leftShift((write_awar_max_oti_value and &H7f), 8) + leftShift((write_awar_max_otf_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_awar_max_oti_value = rightShift(data_low, 8) and &H7f
        awar_max_otf_mask = &Hff
        if data_low > LONG_MAX then
            if awar_max_otf_mask = mask then
                read_awar_max_otf_value = data_low
            else
                read_awar_max_otf_value = (data_low - H8000_0000) and awar_max_otf_mask
            end If
        else
            read_awar_max_otf_value = data_low and awar_max_otf_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_awar_max_oti_value = &H0
        flag_awar_max_oti        = &H0
        write_awar_max_otf_value = &H0
        flag_awar_max_otf        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_aw_p_amac_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' aw_p                                       [31:24]          get_aw_p
''                                                             set_aw_p
''                                                             read_aw_p
''                                                             write_aw_p
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_aw_p_amac_m
    Private write_aw_p_value
    Private read_aw_p_value
    Private flag_aw_p

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1118
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_aw_p
        get_aw_p = read_aw_p_value
    End Property

    Property Let set_aw_p(aData)
        write_aw_p_value = aData
        flag_aw_p        = &H1
    End Property

    Property Get read_aw_p
        read
        read_aw_p = read_aw_p_value
    End Property

    Property Let write_aw_p(aData)
        set_aw_p = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_aw_p_value = rightShift(data_low, 24) and &Hff

    End Sub

    Sub write
        If flag_aw_p = &H0 Then read
        If flag_aw_p = &H0 Then write_aw_p_value = get_aw_p

        regValue = leftShift((write_aw_p_value and &Hff), 24)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_aw_p_value = rightShift(data_low, 24) and &Hff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_aw_p_value = &H0
        flag_aw_p        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_aw_b_amac_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' aw_b                                       [15:0]           get_aw_b
''                                                             set_aw_b
''                                                             read_aw_b
''                                                             write_aw_b
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_aw_b_amac_m
    Private write_aw_b_value
    Private read_aw_b_value
    Private flag_aw_b

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H111c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_aw_b
        get_aw_b = read_aw_b_value
    End Property

    Property Let set_aw_b(aData)
        write_aw_b_value = aData
        flag_aw_b        = &H1
    End Property

    Property Get read_aw_b
        read
        read_aw_b = read_aw_b_value
    End Property

    Property Let write_aw_b(aData)
        set_aw_b = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        aw_b_mask = &Hffff
        if data_low > LONG_MAX then
            if aw_b_mask = mask then
                read_aw_b_value = data_low
            else
                read_aw_b_value = (data_low - H8000_0000) and aw_b_mask
            end If
        else
            read_aw_b_value = data_low and aw_b_mask
        end If

    End Sub

    Sub write
        If flag_aw_b = &H0 Then read
        If flag_aw_b = &H0 Then write_aw_b_value = get_aw_b

        regValue = leftShift((write_aw_b_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        aw_b_mask = &Hffff
        if data_low > LONG_MAX then
            if aw_b_mask = mask then
                read_aw_b_value = data_low
            else
                read_aw_b_value = (data_low - H8000_0000) and aw_b_mask
            end If
        else
            read_aw_b_value = data_low and aw_b_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_aw_b_value = &H0
        flag_aw_b        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_aw_r_amac_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' aw_r                                       [31:20]          get_aw_r
''                                                             set_aw_r
''                                                             read_aw_r
''                                                             write_aw_r
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_aw_r_amac_m
    Private write_aw_r_value
    Private read_aw_r_value
    Private flag_aw_r

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1120
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_aw_r
        get_aw_r = read_aw_r_value
    End Property

    Property Let set_aw_r(aData)
        write_aw_r_value = aData
        flag_aw_r        = &H1
    End Property

    Property Get read_aw_r
        read
        read_aw_r = read_aw_r_value
    End Property

    Property Let write_aw_r(aData)
        set_aw_r = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_aw_r_value = rightShift(data_low, 20) and &Hfff

    End Sub

    Sub write
        If flag_aw_r = &H0 Then read
        If flag_aw_r = &H0 Then write_aw_r_value = get_aw_r

        regValue = leftShift((write_aw_r_value and &Hfff), 20)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_aw_r_value = rightShift(data_low, 20) and &Hfff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_aw_r_value = &H0
        flag_aw_r        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_ar_p_amac_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ar_p                                       [31:24]          get_ar_p
''                                                             set_ar_p
''                                                             read_ar_p
''                                                             write_ar_p
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_ar_p_amac_m
    Private write_ar_p_value
    Private read_ar_p_value
    Private flag_ar_p

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1124
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ar_p
        get_ar_p = read_ar_p_value
    End Property

    Property Let set_ar_p(aData)
        write_ar_p_value = aData
        flag_ar_p        = &H1
    End Property

    Property Get read_ar_p
        read
        read_ar_p = read_ar_p_value
    End Property

    Property Let write_ar_p(aData)
        set_ar_p = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ar_p_value = rightShift(data_low, 24) and &Hff

    End Sub

    Sub write
        If flag_ar_p = &H0 Then read
        If flag_ar_p = &H0 Then write_ar_p_value = get_ar_p

        regValue = leftShift((write_ar_p_value and &Hff), 24)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ar_p_value = rightShift(data_low, 24) and &Hff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ar_p_value = &H0
        flag_ar_p        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_ar_b_amac_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ar_b                                       [15:0]           get_ar_b
''                                                             set_ar_b
''                                                             read_ar_b
''                                                             write_ar_b
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_ar_b_amac_m
    Private write_ar_b_value
    Private read_ar_b_value
    Private flag_ar_b

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1128
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ar_b
        get_ar_b = read_ar_b_value
    End Property

    Property Let set_ar_b(aData)
        write_ar_b_value = aData
        flag_ar_b        = &H1
    End Property

    Property Get read_ar_b
        read
        read_ar_b = read_ar_b_value
    End Property

    Property Let write_ar_b(aData)
        set_ar_b = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ar_b_mask = &Hffff
        if data_low > LONG_MAX then
            if ar_b_mask = mask then
                read_ar_b_value = data_low
            else
                read_ar_b_value = (data_low - H8000_0000) and ar_b_mask
            end If
        else
            read_ar_b_value = data_low and ar_b_mask
        end If

    End Sub

    Sub write
        If flag_ar_b = &H0 Then read
        If flag_ar_b = &H0 Then write_ar_b_value = get_ar_b

        regValue = leftShift((write_ar_b_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ar_b_mask = &Hffff
        if data_low > LONG_MAX then
            if ar_b_mask = mask then
                read_ar_b_value = data_low
            else
                read_ar_b_value = (data_low - H8000_0000) and ar_b_mask
            end If
        else
            read_ar_b_value = data_low and ar_b_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ar_b_value = &H0
        flag_ar_b        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_ar_r_amac_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ar_r                                       [31:20]          get_ar_r
''                                                             set_ar_r
''                                                             read_ar_r
''                                                             write_ar_r
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_ar_r_amac_m
    Private write_ar_r_value
    Private read_ar_r_value
    Private flag_ar_r

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H112c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ar_r
        get_ar_r = read_ar_r_value
    End Property

    Property Let set_ar_r(aData)
        write_ar_r_value = aData
        flag_ar_r        = &H1
    End Property

    Property Get read_ar_r
        read
        read_ar_r = read_ar_r_value
    End Property

    Property Let write_ar_r(aData)
        set_ar_r = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ar_r_value = rightShift(data_low, 20) and &Hfff

    End Sub

    Sub write
        If flag_ar_r = &H0 Then read
        If flag_ar_r = &H0 Then write_ar_r_value = get_ar_r

        regValue = leftShift((write_ar_r_value and &Hfff), 20)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ar_r_value = rightShift(data_low, 20) and &Hfff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ar_r_value = &H0
        flag_ar_r        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_target_fc_amac_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ar_tgt_latency                             [27:16]          get_ar_tgt_latency
''                                                             set_ar_tgt_latency
''                                                             read_ar_tgt_latency
''                                                             write_ar_tgt_latency
''---------------------------------------------------------------------------------
'' aw_tgt_latency                             [11:0]           get_aw_tgt_latency
''                                                             set_aw_tgt_latency
''                                                             read_aw_tgt_latency
''                                                             write_aw_tgt_latency
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_target_fc_amac_m
    Private write_ar_tgt_latency_value
    Private read_ar_tgt_latency_value
    Private flag_ar_tgt_latency
    Private write_aw_tgt_latency_value
    Private read_aw_tgt_latency_value
    Private flag_aw_tgt_latency

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1130
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ar_tgt_latency
        get_ar_tgt_latency = read_ar_tgt_latency_value
    End Property

    Property Let set_ar_tgt_latency(aData)
        write_ar_tgt_latency_value = aData
        flag_ar_tgt_latency        = &H1
    End Property

    Property Get read_ar_tgt_latency
        read
        read_ar_tgt_latency = read_ar_tgt_latency_value
    End Property

    Property Let write_ar_tgt_latency(aData)
        set_ar_tgt_latency = aData
        write
    End Property

    Property Get get_aw_tgt_latency
        get_aw_tgt_latency = read_aw_tgt_latency_value
    End Property

    Property Let set_aw_tgt_latency(aData)
        write_aw_tgt_latency_value = aData
        flag_aw_tgt_latency        = &H1
    End Property

    Property Get read_aw_tgt_latency
        read
        read_aw_tgt_latency = read_aw_tgt_latency_value
    End Property

    Property Let write_aw_tgt_latency(aData)
        set_aw_tgt_latency = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ar_tgt_latency_value = rightShift(data_low, 16) and &Hfff
        aw_tgt_latency_mask = &Hfff
        if data_low > LONG_MAX then
            if aw_tgt_latency_mask = mask then
                read_aw_tgt_latency_value = data_low
            else
                read_aw_tgt_latency_value = (data_low - H8000_0000) and aw_tgt_latency_mask
            end If
        else
            read_aw_tgt_latency_value = data_low and aw_tgt_latency_mask
        end If

    End Sub

    Sub write
        If flag_ar_tgt_latency = &H0 or flag_aw_tgt_latency = &H0 Then read
        If flag_ar_tgt_latency = &H0 Then write_ar_tgt_latency_value = get_ar_tgt_latency
        If flag_aw_tgt_latency = &H0 Then write_aw_tgt_latency_value = get_aw_tgt_latency

        regValue = leftShift((write_ar_tgt_latency_value and &Hfff), 16) + leftShift((write_aw_tgt_latency_value and &Hfff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ar_tgt_latency_value = rightShift(data_low, 16) and &Hfff
        aw_tgt_latency_mask = &Hfff
        if data_low > LONG_MAX then
            if aw_tgt_latency_mask = mask then
                read_aw_tgt_latency_value = data_low
            else
                read_aw_tgt_latency_value = (data_low - H8000_0000) and aw_tgt_latency_mask
            end If
        else
            read_aw_tgt_latency_value = data_low and aw_tgt_latency_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ar_tgt_latency_value = &H0
        flag_ar_tgt_latency        = &H0
        write_aw_tgt_latency_value = &H0
        flag_aw_tgt_latency        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_ki_fc_amac_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ar_ki                                      [10:8]           get_ar_ki
''                                                             set_ar_ki
''                                                             read_ar_ki
''                                                             write_ar_ki
''---------------------------------------------------------------------------------
'' aw_ki                                      [2:0]            get_aw_ki
''                                                             set_aw_ki
''                                                             read_aw_ki
''                                                             write_aw_ki
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_ki_fc_amac_m
    Private write_ar_ki_value
    Private read_ar_ki_value
    Private flag_ar_ki
    Private write_aw_ki_value
    Private read_aw_ki_value
    Private flag_aw_ki

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1134
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ar_ki
        get_ar_ki = read_ar_ki_value
    End Property

    Property Let set_ar_ki(aData)
        write_ar_ki_value = aData
        flag_ar_ki        = &H1
    End Property

    Property Get read_ar_ki
        read
        read_ar_ki = read_ar_ki_value
    End Property

    Property Let write_ar_ki(aData)
        set_ar_ki = aData
        write
    End Property

    Property Get get_aw_ki
        get_aw_ki = read_aw_ki_value
    End Property

    Property Let set_aw_ki(aData)
        write_aw_ki_value = aData
        flag_aw_ki        = &H1
    End Property

    Property Get read_aw_ki
        read
        read_aw_ki = read_aw_ki_value
    End Property

    Property Let write_aw_ki(aData)
        set_aw_ki = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ar_ki_value = rightShift(data_low, 8) and &H7
        aw_ki_mask = &H7
        if data_low > LONG_MAX then
            if aw_ki_mask = mask then
                read_aw_ki_value = data_low
            else
                read_aw_ki_value = (data_low - H8000_0000) and aw_ki_mask
            end If
        else
            read_aw_ki_value = data_low and aw_ki_mask
        end If

    End Sub

    Sub write
        If flag_ar_ki = &H0 or flag_aw_ki = &H0 Then read
        If flag_ar_ki = &H0 Then write_ar_ki_value = get_ar_ki
        If flag_aw_ki = &H0 Then write_aw_ki_value = get_aw_ki

        regValue = leftShift((write_ar_ki_value and &H7), 8) + leftShift((write_aw_ki_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ar_ki_value = rightShift(data_low, 8) and &H7
        aw_ki_mask = &H7
        if data_low > LONG_MAX then
            if aw_ki_mask = mask then
                read_aw_ki_value = data_low
            else
                read_aw_ki_value = (data_low - H8000_0000) and aw_ki_mask
            end If
        else
            read_aw_ki_value = data_low and aw_ki_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ar_ki_value = &H0
        flag_ar_ki        = &H0
        write_aw_ki_value = &H0
        flag_aw_ki        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_qos_range_amac_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ar_max_qos                                 [27:24]          get_ar_max_qos
''                                                             set_ar_max_qos
''                                                             read_ar_max_qos
''                                                             write_ar_max_qos
''---------------------------------------------------------------------------------
'' ar_min_qos                                 [19:16]          get_ar_min_qos
''                                                             set_ar_min_qos
''                                                             read_ar_min_qos
''                                                             write_ar_min_qos
''---------------------------------------------------------------------------------
'' aw_max_qos                                 [11:8]           get_aw_max_qos
''                                                             set_aw_max_qos
''                                                             read_aw_max_qos
''                                                             write_aw_max_qos
''---------------------------------------------------------------------------------
'' aw_min_qos                                 [3:0]            get_aw_min_qos
''                                                             set_aw_min_qos
''                                                             read_aw_min_qos
''                                                             write_aw_min_qos
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_qos_range_amac_m
    Private write_ar_max_qos_value
    Private read_ar_max_qos_value
    Private flag_ar_max_qos
    Private write_ar_min_qos_value
    Private read_ar_min_qos_value
    Private flag_ar_min_qos
    Private write_aw_max_qos_value
    Private read_aw_max_qos_value
    Private flag_aw_max_qos
    Private write_aw_min_qos_value
    Private read_aw_min_qos_value
    Private flag_aw_min_qos

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1138
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ar_max_qos
        get_ar_max_qos = read_ar_max_qos_value
    End Property

    Property Let set_ar_max_qos(aData)
        write_ar_max_qos_value = aData
        flag_ar_max_qos        = &H1
    End Property

    Property Get read_ar_max_qos
        read
        read_ar_max_qos = read_ar_max_qos_value
    End Property

    Property Let write_ar_max_qos(aData)
        set_ar_max_qos = aData
        write
    End Property

    Property Get get_ar_min_qos
        get_ar_min_qos = read_ar_min_qos_value
    End Property

    Property Let set_ar_min_qos(aData)
        write_ar_min_qos_value = aData
        flag_ar_min_qos        = &H1
    End Property

    Property Get read_ar_min_qos
        read
        read_ar_min_qos = read_ar_min_qos_value
    End Property

    Property Let write_ar_min_qos(aData)
        set_ar_min_qos = aData
        write
    End Property

    Property Get get_aw_max_qos
        get_aw_max_qos = read_aw_max_qos_value
    End Property

    Property Let set_aw_max_qos(aData)
        write_aw_max_qos_value = aData
        flag_aw_max_qos        = &H1
    End Property

    Property Get read_aw_max_qos
        read
        read_aw_max_qos = read_aw_max_qos_value
    End Property

    Property Let write_aw_max_qos(aData)
        set_aw_max_qos = aData
        write
    End Property

    Property Get get_aw_min_qos
        get_aw_min_qos = read_aw_min_qos_value
    End Property

    Property Let set_aw_min_qos(aData)
        write_aw_min_qos_value = aData
        flag_aw_min_qos        = &H1
    End Property

    Property Get read_aw_min_qos
        read
        read_aw_min_qos = read_aw_min_qos_value
    End Property

    Property Let write_aw_min_qos(aData)
        set_aw_min_qos = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ar_max_qos_value = rightShift(data_low, 24) and &Hf
        read_ar_min_qos_value = rightShift(data_low, 16) and &Hf
        read_aw_max_qos_value = rightShift(data_low, 8) and &Hf
        aw_min_qos_mask = &Hf
        if data_low > LONG_MAX then
            if aw_min_qos_mask = mask then
                read_aw_min_qos_value = data_low
            else
                read_aw_min_qos_value = (data_low - H8000_0000) and aw_min_qos_mask
            end If
        else
            read_aw_min_qos_value = data_low and aw_min_qos_mask
        end If

    End Sub

    Sub write
        If flag_ar_max_qos = &H0 or flag_ar_min_qos = &H0 or flag_aw_max_qos = &H0 or flag_aw_min_qos = &H0 Then read
        If flag_ar_max_qos = &H0 Then write_ar_max_qos_value = get_ar_max_qos
        If flag_ar_min_qos = &H0 Then write_ar_min_qos_value = get_ar_min_qos
        If flag_aw_max_qos = &H0 Then write_aw_max_qos_value = get_aw_max_qos
        If flag_aw_min_qos = &H0 Then write_aw_min_qos_value = get_aw_min_qos

        regValue = leftShift((write_ar_max_qos_value and &Hf), 24) + leftShift((write_ar_min_qos_value and &Hf), 16) + leftShift((write_aw_max_qos_value and &Hf), 8) + leftShift((write_aw_min_qos_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ar_max_qos_value = rightShift(data_low, 24) and &Hf
        read_ar_min_qos_value = rightShift(data_low, 16) and &Hf
        read_aw_max_qos_value = rightShift(data_low, 8) and &Hf
        aw_min_qos_mask = &Hf
        if data_low > LONG_MAX then
            if aw_min_qos_mask = mask then
                read_aw_min_qos_value = data_low
            else
                read_aw_min_qos_value = (data_low - H8000_0000) and aw_min_qos_mask
            end If
        else
            read_aw_min_qos_value = data_low and aw_min_qos_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ar_max_qos_value = &H0
        flag_ar_max_qos        = &H0
        write_ar_min_qos_value = &H0
        flag_ar_min_qos        = &H0
        write_aw_max_qos_value = &H0
        flag_aw_max_qos        = &H0
        write_aw_min_qos_value = &H0
        flag_aw_min_qos        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_read_qos_ser_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' read_qos                                   [3:0]            get_read_qos
''                                                             set_read_qos
''                                                             read_read_qos
''                                                             write_read_qos
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_read_qos_ser_m
    Private write_read_qos_value
    Private read_read_qos_value
    Private flag_read_qos

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H2100
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_read_qos
        get_read_qos = read_read_qos_value
    End Property

    Property Let set_read_qos(aData)
        write_read_qos_value = aData
        flag_read_qos        = &H1
    End Property

    Property Get read_read_qos
        read
        read_read_qos = read_read_qos_value
    End Property

    Property Let write_read_qos(aData)
        set_read_qos = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_qos_mask = &Hf
        if data_low > LONG_MAX then
            if read_qos_mask = mask then
                read_read_qos_value = data_low
            else
                read_read_qos_value = (data_low - H8000_0000) and read_qos_mask
            end If
        else
            read_read_qos_value = data_low and read_qos_mask
        end If

    End Sub

    Sub write
        If flag_read_qos = &H0 Then read
        If flag_read_qos = &H0 Then write_read_qos_value = get_read_qos

        regValue = leftShift((write_read_qos_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_qos_mask = &Hf
        if data_low > LONG_MAX then
            if read_qos_mask = mask then
                read_read_qos_value = data_low
            else
                read_read_qos_value = (data_low - H8000_0000) and read_qos_mask
            end If
        else
            read_read_qos_value = data_low and read_qos_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_read_qos_value = &H0
        flag_read_qos        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_write_qos_ser_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' write_qos                                  [3:0]            get_write_qos
''                                                             set_write_qos
''                                                             read_write_qos
''                                                             write_write_qos
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_write_qos_ser_m
    Private write_write_qos_value
    Private read_write_qos_value
    Private flag_write_qos

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H2104
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_write_qos
        get_write_qos = read_write_qos_value
    End Property

    Property Let set_write_qos(aData)
        write_write_qos_value = aData
        flag_write_qos        = &H1
    End Property

    Property Get read_write_qos
        read
        read_write_qos = read_write_qos_value
    End Property

    Property Let write_write_qos(aData)
        set_write_qos = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        write_qos_mask = &Hf
        if data_low > LONG_MAX then
            if write_qos_mask = mask then
                read_write_qos_value = data_low
            else
                read_write_qos_value = (data_low - H8000_0000) and write_qos_mask
            end If
        else
            read_write_qos_value = data_low and write_qos_mask
        end If

    End Sub

    Sub write
        If flag_write_qos = &H0 Then read
        If flag_write_qos = &H0 Then write_write_qos_value = get_write_qos

        regValue = leftShift((write_write_qos_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        write_qos_mask = &Hf
        if data_low > LONG_MAX then
            if write_qos_mask = mask then
                read_write_qos_value = data_low
            else
                read_write_qos_value = (data_low - H8000_0000) and write_qos_mask
            end If
        else
            read_write_qos_value = data_low and write_qos_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_write_qos_value = &H0
        flag_write_qos        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_fn_mod_ser_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' fn_mod                                     [1:0]            get_fn_mod
''                                                             set_fn_mod
''                                                             read_fn_mod
''                                                             write_fn_mod
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_fn_mod_ser_m
    Private write_fn_mod_value
    Private read_fn_mod_value
    Private flag_fn_mod

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H2108
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_fn_mod
        get_fn_mod = read_fn_mod_value
    End Property

    Property Let set_fn_mod(aData)
        write_fn_mod_value = aData
        flag_fn_mod        = &H1
    End Property

    Property Get read_fn_mod
        read
        read_fn_mod = read_fn_mod_value
    End Property

    Property Let write_fn_mod(aData)
        set_fn_mod = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        fn_mod_mask = &H3
        if data_low > LONG_MAX then
            if fn_mod_mask = mask then
                read_fn_mod_value = data_low
            else
                read_fn_mod_value = (data_low - H8000_0000) and fn_mod_mask
            end If
        else
            read_fn_mod_value = data_low and fn_mod_mask
        end If

    End Sub

    Sub write
        If flag_fn_mod = &H0 Then read
        If flag_fn_mod = &H0 Then write_fn_mod_value = get_fn_mod

        regValue = leftShift((write_fn_mod_value and &H3), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        fn_mod_mask = &H3
        if data_low > LONG_MAX then
            if fn_mod_mask = mask then
                read_fn_mod_value = data_low
            else
                read_fn_mod_value = (data_low - H8000_0000) and fn_mod_mask
            end If
        else
            read_fn_mod_value = data_low and fn_mod_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_fn_mod_value = &H0
        flag_fn_mod        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_qos_cntl_ser_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mode_ar_fc                                 [20:20]          get_mode_ar_fc
''                                                             set_mode_ar_fc
''                                                             read_mode_ar_fc
''                                                             write_mode_ar_fc
''---------------------------------------------------------------------------------
'' mode_aw_fc                                 [16:16]          get_mode_aw_fc
''                                                             set_mode_aw_fc
''                                                             read_mode_aw_fc
''                                                             write_mode_aw_fc
''---------------------------------------------------------------------------------
'' en_awar_ot                                 [7:7]            get_en_awar_ot
''                                                             set_en_awar_ot
''                                                             read_en_awar_ot
''                                                             write_en_awar_ot
''---------------------------------------------------------------------------------
'' en_ar_ot                                   [6:6]            get_en_ar_ot
''                                                             set_en_ar_ot
''                                                             read_en_ar_ot
''                                                             write_en_ar_ot
''---------------------------------------------------------------------------------
'' en_aw_ot                                   [5:5]            get_en_aw_ot
''                                                             set_en_aw_ot
''                                                             read_en_aw_ot
''                                                             write_en_aw_ot
''---------------------------------------------------------------------------------
'' en_ar_fc                                   [4:4]            get_en_ar_fc
''                                                             set_en_ar_fc
''                                                             read_en_ar_fc
''                                                             write_en_ar_fc
''---------------------------------------------------------------------------------
'' en_aw_fc                                   [3:3]            get_en_aw_fc
''                                                             set_en_aw_fc
''                                                             read_en_aw_fc
''                                                             write_en_aw_fc
''---------------------------------------------------------------------------------
'' en_awar_rate                               [2:2]            get_en_awar_rate
''                                                             set_en_awar_rate
''                                                             read_en_awar_rate
''                                                             write_en_awar_rate
''---------------------------------------------------------------------------------
'' en_ar_rate                                 [1:1]            get_en_ar_rate
''                                                             set_en_ar_rate
''                                                             read_en_ar_rate
''                                                             write_en_ar_rate
''---------------------------------------------------------------------------------
'' en_aw_rate                                 [0:0]            get_en_aw_rate
''                                                             set_en_aw_rate
''                                                             read_en_aw_rate
''                                                             write_en_aw_rate
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_qos_cntl_ser_m
    Private write_mode_ar_fc_value
    Private read_mode_ar_fc_value
    Private flag_mode_ar_fc
    Private write_mode_aw_fc_value
    Private read_mode_aw_fc_value
    Private flag_mode_aw_fc
    Private write_en_awar_ot_value
    Private read_en_awar_ot_value
    Private flag_en_awar_ot
    Private write_en_ar_ot_value
    Private read_en_ar_ot_value
    Private flag_en_ar_ot
    Private write_en_aw_ot_value
    Private read_en_aw_ot_value
    Private flag_en_aw_ot
    Private write_en_ar_fc_value
    Private read_en_ar_fc_value
    Private flag_en_ar_fc
    Private write_en_aw_fc_value
    Private read_en_aw_fc_value
    Private flag_en_aw_fc
    Private write_en_awar_rate_value
    Private read_en_awar_rate_value
    Private flag_en_awar_rate
    Private write_en_ar_rate_value
    Private read_en_ar_rate_value
    Private flag_en_ar_rate
    Private write_en_aw_rate_value
    Private read_en_aw_rate_value
    Private flag_en_aw_rate

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H210c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mode_ar_fc
        get_mode_ar_fc = read_mode_ar_fc_value
    End Property

    Property Let set_mode_ar_fc(aData)
        write_mode_ar_fc_value = aData
        flag_mode_ar_fc        = &H1
    End Property

    Property Get read_mode_ar_fc
        read
        read_mode_ar_fc = read_mode_ar_fc_value
    End Property

    Property Let write_mode_ar_fc(aData)
        set_mode_ar_fc = aData
        write
    End Property

    Property Get get_mode_aw_fc
        get_mode_aw_fc = read_mode_aw_fc_value
    End Property

    Property Let set_mode_aw_fc(aData)
        write_mode_aw_fc_value = aData
        flag_mode_aw_fc        = &H1
    End Property

    Property Get read_mode_aw_fc
        read
        read_mode_aw_fc = read_mode_aw_fc_value
    End Property

    Property Let write_mode_aw_fc(aData)
        set_mode_aw_fc = aData
        write
    End Property

    Property Get get_en_awar_ot
        get_en_awar_ot = read_en_awar_ot_value
    End Property

    Property Let set_en_awar_ot(aData)
        write_en_awar_ot_value = aData
        flag_en_awar_ot        = &H1
    End Property

    Property Get read_en_awar_ot
        read
        read_en_awar_ot = read_en_awar_ot_value
    End Property

    Property Let write_en_awar_ot(aData)
        set_en_awar_ot = aData
        write
    End Property

    Property Get get_en_ar_ot
        get_en_ar_ot = read_en_ar_ot_value
    End Property

    Property Let set_en_ar_ot(aData)
        write_en_ar_ot_value = aData
        flag_en_ar_ot        = &H1
    End Property

    Property Get read_en_ar_ot
        read
        read_en_ar_ot = read_en_ar_ot_value
    End Property

    Property Let write_en_ar_ot(aData)
        set_en_ar_ot = aData
        write
    End Property

    Property Get get_en_aw_ot
        get_en_aw_ot = read_en_aw_ot_value
    End Property

    Property Let set_en_aw_ot(aData)
        write_en_aw_ot_value = aData
        flag_en_aw_ot        = &H1
    End Property

    Property Get read_en_aw_ot
        read
        read_en_aw_ot = read_en_aw_ot_value
    End Property

    Property Let write_en_aw_ot(aData)
        set_en_aw_ot = aData
        write
    End Property

    Property Get get_en_ar_fc
        get_en_ar_fc = read_en_ar_fc_value
    End Property

    Property Let set_en_ar_fc(aData)
        write_en_ar_fc_value = aData
        flag_en_ar_fc        = &H1
    End Property

    Property Get read_en_ar_fc
        read
        read_en_ar_fc = read_en_ar_fc_value
    End Property

    Property Let write_en_ar_fc(aData)
        set_en_ar_fc = aData
        write
    End Property

    Property Get get_en_aw_fc
        get_en_aw_fc = read_en_aw_fc_value
    End Property

    Property Let set_en_aw_fc(aData)
        write_en_aw_fc_value = aData
        flag_en_aw_fc        = &H1
    End Property

    Property Get read_en_aw_fc
        read
        read_en_aw_fc = read_en_aw_fc_value
    End Property

    Property Let write_en_aw_fc(aData)
        set_en_aw_fc = aData
        write
    End Property

    Property Get get_en_awar_rate
        get_en_awar_rate = read_en_awar_rate_value
    End Property

    Property Let set_en_awar_rate(aData)
        write_en_awar_rate_value = aData
        flag_en_awar_rate        = &H1
    End Property

    Property Get read_en_awar_rate
        read
        read_en_awar_rate = read_en_awar_rate_value
    End Property

    Property Let write_en_awar_rate(aData)
        set_en_awar_rate = aData
        write
    End Property

    Property Get get_en_ar_rate
        get_en_ar_rate = read_en_ar_rate_value
    End Property

    Property Let set_en_ar_rate(aData)
        write_en_ar_rate_value = aData
        flag_en_ar_rate        = &H1
    End Property

    Property Get read_en_ar_rate
        read
        read_en_ar_rate = read_en_ar_rate_value
    End Property

    Property Let write_en_ar_rate(aData)
        set_en_ar_rate = aData
        write
    End Property

    Property Get get_en_aw_rate
        get_en_aw_rate = read_en_aw_rate_value
    End Property

    Property Let set_en_aw_rate(aData)
        write_en_aw_rate_value = aData
        flag_en_aw_rate        = &H1
    End Property

    Property Get read_en_aw_rate
        read
        read_en_aw_rate = read_en_aw_rate_value
    End Property

    Property Let write_en_aw_rate(aData)
        set_en_aw_rate = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_mode_ar_fc_value = rightShift(data_low, 20) and &H1
        read_mode_aw_fc_value = rightShift(data_low, 16) and &H1
        read_en_awar_ot_value = rightShift(data_low, 7) and &H1
        read_en_ar_ot_value = rightShift(data_low, 6) and &H1
        read_en_aw_ot_value = rightShift(data_low, 5) and &H1
        read_en_ar_fc_value = rightShift(data_low, 4) and &H1
        read_en_aw_fc_value = rightShift(data_low, 3) and &H1
        read_en_awar_rate_value = rightShift(data_low, 2) and &H1
        read_en_ar_rate_value = rightShift(data_low, 1) and &H1
        en_aw_rate_mask = &H1
        if data_low > LONG_MAX then
            if en_aw_rate_mask = mask then
                read_en_aw_rate_value = data_low
            else
                read_en_aw_rate_value = (data_low - H8000_0000) and en_aw_rate_mask
            end If
        else
            read_en_aw_rate_value = data_low and en_aw_rate_mask
        end If

    End Sub

    Sub write
        If flag_mode_ar_fc = &H0 or flag_mode_aw_fc = &H0 or flag_en_awar_ot = &H0 or flag_en_ar_ot = &H0 or flag_en_aw_ot = &H0 or flag_en_ar_fc = &H0 or flag_en_aw_fc = &H0 or flag_en_awar_rate = &H0 or flag_en_ar_rate = &H0 or flag_en_aw_rate = &H0 Then read
        If flag_mode_ar_fc = &H0 Then write_mode_ar_fc_value = get_mode_ar_fc
        If flag_mode_aw_fc = &H0 Then write_mode_aw_fc_value = get_mode_aw_fc
        If flag_en_awar_ot = &H0 Then write_en_awar_ot_value = get_en_awar_ot
        If flag_en_ar_ot = &H0 Then write_en_ar_ot_value = get_en_ar_ot
        If flag_en_aw_ot = &H0 Then write_en_aw_ot_value = get_en_aw_ot
        If flag_en_ar_fc = &H0 Then write_en_ar_fc_value = get_en_ar_fc
        If flag_en_aw_fc = &H0 Then write_en_aw_fc_value = get_en_aw_fc
        If flag_en_awar_rate = &H0 Then write_en_awar_rate_value = get_en_awar_rate
        If flag_en_ar_rate = &H0 Then write_en_ar_rate_value = get_en_ar_rate
        If flag_en_aw_rate = &H0 Then write_en_aw_rate_value = get_en_aw_rate

        regValue = leftShift((write_mode_ar_fc_value and &H1), 20) + leftShift((write_mode_aw_fc_value and &H1), 16) + leftShift((write_en_awar_ot_value and &H1), 7) + leftShift((write_en_ar_ot_value and &H1), 6) + leftShift((write_en_aw_ot_value and &H1), 5) + leftShift((write_en_ar_fc_value and &H1), 4) + leftShift((write_en_aw_fc_value and &H1), 3) + leftShift((write_en_awar_rate_value and &H1), 2) + leftShift((write_en_ar_rate_value and &H1), 1) + leftShift((write_en_aw_rate_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_mode_ar_fc_value = rightShift(data_low, 20) and &H1
        read_mode_aw_fc_value = rightShift(data_low, 16) and &H1
        read_en_awar_ot_value = rightShift(data_low, 7) and &H1
        read_en_ar_ot_value = rightShift(data_low, 6) and &H1
        read_en_aw_ot_value = rightShift(data_low, 5) and &H1
        read_en_ar_fc_value = rightShift(data_low, 4) and &H1
        read_en_aw_fc_value = rightShift(data_low, 3) and &H1
        read_en_awar_rate_value = rightShift(data_low, 2) and &H1
        read_en_ar_rate_value = rightShift(data_low, 1) and &H1
        en_aw_rate_mask = &H1
        if data_low > LONG_MAX then
            if en_aw_rate_mask = mask then
                read_en_aw_rate_value = data_low
            else
                read_en_aw_rate_value = (data_low - H8000_0000) and en_aw_rate_mask
            end If
        else
            read_en_aw_rate_value = data_low and en_aw_rate_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mode_ar_fc_value = &H0
        flag_mode_ar_fc        = &H0
        write_mode_aw_fc_value = &H0
        flag_mode_aw_fc        = &H0
        write_en_awar_ot_value = &H0
        flag_en_awar_ot        = &H0
        write_en_ar_ot_value = &H0
        flag_en_ar_ot        = &H0
        write_en_aw_ot_value = &H0
        flag_en_aw_ot        = &H0
        write_en_ar_fc_value = &H0
        flag_en_ar_fc        = &H0
        write_en_aw_fc_value = &H0
        flag_en_aw_fc        = &H0
        write_en_awar_rate_value = &H0
        flag_en_awar_rate        = &H0
        write_en_ar_rate_value = &H0
        flag_en_ar_rate        = &H0
        write_en_aw_rate_value = &H0
        flag_en_aw_rate        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_max_ot_ser_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ar_max_oti                                 [29:24]          get_ar_max_oti
''                                                             set_ar_max_oti
''                                                             read_ar_max_oti
''                                                             write_ar_max_oti
''---------------------------------------------------------------------------------
'' ar_max_otf                                 [23:16]          get_ar_max_otf
''                                                             set_ar_max_otf
''                                                             read_ar_max_otf
''                                                             write_ar_max_otf
''---------------------------------------------------------------------------------
'' aw_max_oti                                 [13:8]           get_aw_max_oti
''                                                             set_aw_max_oti
''                                                             read_aw_max_oti
''                                                             write_aw_max_oti
''---------------------------------------------------------------------------------
'' en_ar_ot                                   [7:0]            get_en_ar_ot
''                                                             set_en_ar_ot
''                                                             read_en_ar_ot
''                                                             write_en_ar_ot
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_max_ot_ser_m
    Private write_ar_max_oti_value
    Private read_ar_max_oti_value
    Private flag_ar_max_oti
    Private write_ar_max_otf_value
    Private read_ar_max_otf_value
    Private flag_ar_max_otf
    Private write_aw_max_oti_value
    Private read_aw_max_oti_value
    Private flag_aw_max_oti
    Private write_en_ar_ot_value
    Private read_en_ar_ot_value
    Private flag_en_ar_ot

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H2110
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ar_max_oti
        get_ar_max_oti = read_ar_max_oti_value
    End Property

    Property Let set_ar_max_oti(aData)
        write_ar_max_oti_value = aData
        flag_ar_max_oti        = &H1
    End Property

    Property Get read_ar_max_oti
        read
        read_ar_max_oti = read_ar_max_oti_value
    End Property

    Property Let write_ar_max_oti(aData)
        set_ar_max_oti = aData
        write
    End Property

    Property Get get_ar_max_otf
        get_ar_max_otf = read_ar_max_otf_value
    End Property

    Property Let set_ar_max_otf(aData)
        write_ar_max_otf_value = aData
        flag_ar_max_otf        = &H1
    End Property

    Property Get read_ar_max_otf
        read
        read_ar_max_otf = read_ar_max_otf_value
    End Property

    Property Let write_ar_max_otf(aData)
        set_ar_max_otf = aData
        write
    End Property

    Property Get get_aw_max_oti
        get_aw_max_oti = read_aw_max_oti_value
    End Property

    Property Let set_aw_max_oti(aData)
        write_aw_max_oti_value = aData
        flag_aw_max_oti        = &H1
    End Property

    Property Get read_aw_max_oti
        read
        read_aw_max_oti = read_aw_max_oti_value
    End Property

    Property Let write_aw_max_oti(aData)
        set_aw_max_oti = aData
        write
    End Property

    Property Get get_en_ar_ot
        get_en_ar_ot = read_en_ar_ot_value
    End Property

    Property Let set_en_ar_ot(aData)
        write_en_ar_ot_value = aData
        flag_en_ar_ot        = &H1
    End Property

    Property Get read_en_ar_ot
        read
        read_en_ar_ot = read_en_ar_ot_value
    End Property

    Property Let write_en_ar_ot(aData)
        set_en_ar_ot = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ar_max_oti_value = rightShift(data_low, 24) and &H3f
        read_ar_max_otf_value = rightShift(data_low, 16) and &Hff
        read_aw_max_oti_value = rightShift(data_low, 8) and &H3f
        en_ar_ot_mask = &Hff
        if data_low > LONG_MAX then
            if en_ar_ot_mask = mask then
                read_en_ar_ot_value = data_low
            else
                read_en_ar_ot_value = (data_low - H8000_0000) and en_ar_ot_mask
            end If
        else
            read_en_ar_ot_value = data_low and en_ar_ot_mask
        end If

    End Sub

    Sub write
        If flag_ar_max_oti = &H0 or flag_ar_max_otf = &H0 or flag_aw_max_oti = &H0 or flag_en_ar_ot = &H0 Then read
        If flag_ar_max_oti = &H0 Then write_ar_max_oti_value = get_ar_max_oti
        If flag_ar_max_otf = &H0 Then write_ar_max_otf_value = get_ar_max_otf
        If flag_aw_max_oti = &H0 Then write_aw_max_oti_value = get_aw_max_oti
        If flag_en_ar_ot = &H0 Then write_en_ar_ot_value = get_en_ar_ot

        regValue = leftShift((write_ar_max_oti_value and &H3f), 24) + leftShift((write_ar_max_otf_value and &Hff), 16) + leftShift((write_aw_max_oti_value and &H3f), 8) + leftShift((write_en_ar_ot_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ar_max_oti_value = rightShift(data_low, 24) and &H3f
        read_ar_max_otf_value = rightShift(data_low, 16) and &Hff
        read_aw_max_oti_value = rightShift(data_low, 8) and &H3f
        en_ar_ot_mask = &Hff
        if data_low > LONG_MAX then
            if en_ar_ot_mask = mask then
                read_en_ar_ot_value = data_low
            else
                read_en_ar_ot_value = (data_low - H8000_0000) and en_ar_ot_mask
            end If
        else
            read_en_ar_ot_value = data_low and en_ar_ot_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ar_max_oti_value = &H0
        flag_ar_max_oti        = &H0
        write_ar_max_otf_value = &H0
        flag_ar_max_otf        = &H0
        write_aw_max_oti_value = &H0
        flag_aw_max_oti        = &H0
        write_en_ar_ot_value = &H0
        flag_en_ar_ot        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_max_comb_ot_ser_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' awar_max_oti                               [14:8]           get_awar_max_oti
''                                                             set_awar_max_oti
''                                                             read_awar_max_oti
''                                                             write_awar_max_oti
''---------------------------------------------------------------------------------
'' awar_max_otf                               [7:0]            get_awar_max_otf
''                                                             set_awar_max_otf
''                                                             read_awar_max_otf
''                                                             write_awar_max_otf
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_max_comb_ot_ser_m
    Private write_awar_max_oti_value
    Private read_awar_max_oti_value
    Private flag_awar_max_oti
    Private write_awar_max_otf_value
    Private read_awar_max_otf_value
    Private flag_awar_max_otf

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H2114
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_awar_max_oti
        get_awar_max_oti = read_awar_max_oti_value
    End Property

    Property Let set_awar_max_oti(aData)
        write_awar_max_oti_value = aData
        flag_awar_max_oti        = &H1
    End Property

    Property Get read_awar_max_oti
        read
        read_awar_max_oti = read_awar_max_oti_value
    End Property

    Property Let write_awar_max_oti(aData)
        set_awar_max_oti = aData
        write
    End Property

    Property Get get_awar_max_otf
        get_awar_max_otf = read_awar_max_otf_value
    End Property

    Property Let set_awar_max_otf(aData)
        write_awar_max_otf_value = aData
        flag_awar_max_otf        = &H1
    End Property

    Property Get read_awar_max_otf
        read
        read_awar_max_otf = read_awar_max_otf_value
    End Property

    Property Let write_awar_max_otf(aData)
        set_awar_max_otf = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_awar_max_oti_value = rightShift(data_low, 8) and &H7f
        awar_max_otf_mask = &Hff
        if data_low > LONG_MAX then
            if awar_max_otf_mask = mask then
                read_awar_max_otf_value = data_low
            else
                read_awar_max_otf_value = (data_low - H8000_0000) and awar_max_otf_mask
            end If
        else
            read_awar_max_otf_value = data_low and awar_max_otf_mask
        end If

    End Sub

    Sub write
        If flag_awar_max_oti = &H0 or flag_awar_max_otf = &H0 Then read
        If flag_awar_max_oti = &H0 Then write_awar_max_oti_value = get_awar_max_oti
        If flag_awar_max_otf = &H0 Then write_awar_max_otf_value = get_awar_max_otf

        regValue = leftShift((write_awar_max_oti_value and &H7f), 8) + leftShift((write_awar_max_otf_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_awar_max_oti_value = rightShift(data_low, 8) and &H7f
        awar_max_otf_mask = &Hff
        if data_low > LONG_MAX then
            if awar_max_otf_mask = mask then
                read_awar_max_otf_value = data_low
            else
                read_awar_max_otf_value = (data_low - H8000_0000) and awar_max_otf_mask
            end If
        else
            read_awar_max_otf_value = data_low and awar_max_otf_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_awar_max_oti_value = &H0
        flag_awar_max_oti        = &H0
        write_awar_max_otf_value = &H0
        flag_awar_max_otf        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_aw_p_ser_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' aw_p                                       [31:24]          get_aw_p
''                                                             set_aw_p
''                                                             read_aw_p
''                                                             write_aw_p
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_aw_p_ser_m
    Private write_aw_p_value
    Private read_aw_p_value
    Private flag_aw_p

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H2118
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_aw_p
        get_aw_p = read_aw_p_value
    End Property

    Property Let set_aw_p(aData)
        write_aw_p_value = aData
        flag_aw_p        = &H1
    End Property

    Property Get read_aw_p
        read
        read_aw_p = read_aw_p_value
    End Property

    Property Let write_aw_p(aData)
        set_aw_p = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_aw_p_value = rightShift(data_low, 24) and &Hff

    End Sub

    Sub write
        If flag_aw_p = &H0 Then read
        If flag_aw_p = &H0 Then write_aw_p_value = get_aw_p

        regValue = leftShift((write_aw_p_value and &Hff), 24)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_aw_p_value = rightShift(data_low, 24) and &Hff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_aw_p_value = &H0
        flag_aw_p        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_aw_b_ser_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' aw_b                                       [15:0]           get_aw_b
''                                                             set_aw_b
''                                                             read_aw_b
''                                                             write_aw_b
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_aw_b_ser_m
    Private write_aw_b_value
    Private read_aw_b_value
    Private flag_aw_b

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H211c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_aw_b
        get_aw_b = read_aw_b_value
    End Property

    Property Let set_aw_b(aData)
        write_aw_b_value = aData
        flag_aw_b        = &H1
    End Property

    Property Get read_aw_b
        read
        read_aw_b = read_aw_b_value
    End Property

    Property Let write_aw_b(aData)
        set_aw_b = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        aw_b_mask = &Hffff
        if data_low > LONG_MAX then
            if aw_b_mask = mask then
                read_aw_b_value = data_low
            else
                read_aw_b_value = (data_low - H8000_0000) and aw_b_mask
            end If
        else
            read_aw_b_value = data_low and aw_b_mask
        end If

    End Sub

    Sub write
        If flag_aw_b = &H0 Then read
        If flag_aw_b = &H0 Then write_aw_b_value = get_aw_b

        regValue = leftShift((write_aw_b_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        aw_b_mask = &Hffff
        if data_low > LONG_MAX then
            if aw_b_mask = mask then
                read_aw_b_value = data_low
            else
                read_aw_b_value = (data_low - H8000_0000) and aw_b_mask
            end If
        else
            read_aw_b_value = data_low and aw_b_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_aw_b_value = &H0
        flag_aw_b        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_aw_r_ser_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' aw_r                                       [31:20]          get_aw_r
''                                                             set_aw_r
''                                                             read_aw_r
''                                                             write_aw_r
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_aw_r_ser_m
    Private write_aw_r_value
    Private read_aw_r_value
    Private flag_aw_r

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H2120
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_aw_r
        get_aw_r = read_aw_r_value
    End Property

    Property Let set_aw_r(aData)
        write_aw_r_value = aData
        flag_aw_r        = &H1
    End Property

    Property Get read_aw_r
        read
        read_aw_r = read_aw_r_value
    End Property

    Property Let write_aw_r(aData)
        set_aw_r = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_aw_r_value = rightShift(data_low, 20) and &Hfff

    End Sub

    Sub write
        If flag_aw_r = &H0 Then read
        If flag_aw_r = &H0 Then write_aw_r_value = get_aw_r

        regValue = leftShift((write_aw_r_value and &Hfff), 20)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_aw_r_value = rightShift(data_low, 20) and &Hfff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_aw_r_value = &H0
        flag_aw_r        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_ar_p_ser_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ar_p                                       [31:24]          get_ar_p
''                                                             set_ar_p
''                                                             read_ar_p
''                                                             write_ar_p
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_ar_p_ser_m
    Private write_ar_p_value
    Private read_ar_p_value
    Private flag_ar_p

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H2124
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ar_p
        get_ar_p = read_ar_p_value
    End Property

    Property Let set_ar_p(aData)
        write_ar_p_value = aData
        flag_ar_p        = &H1
    End Property

    Property Get read_ar_p
        read
        read_ar_p = read_ar_p_value
    End Property

    Property Let write_ar_p(aData)
        set_ar_p = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ar_p_value = rightShift(data_low, 24) and &Hff

    End Sub

    Sub write
        If flag_ar_p = &H0 Then read
        If flag_ar_p = &H0 Then write_ar_p_value = get_ar_p

        regValue = leftShift((write_ar_p_value and &Hff), 24)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ar_p_value = rightShift(data_low, 24) and &Hff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ar_p_value = &H0
        flag_ar_p        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_ar_b_ser_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ar_b                                       [15:0]           get_ar_b
''                                                             set_ar_b
''                                                             read_ar_b
''                                                             write_ar_b
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_ar_b_ser_m
    Private write_ar_b_value
    Private read_ar_b_value
    Private flag_ar_b

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H2128
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ar_b
        get_ar_b = read_ar_b_value
    End Property

    Property Let set_ar_b(aData)
        write_ar_b_value = aData
        flag_ar_b        = &H1
    End Property

    Property Get read_ar_b
        read
        read_ar_b = read_ar_b_value
    End Property

    Property Let write_ar_b(aData)
        set_ar_b = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ar_b_mask = &Hffff
        if data_low > LONG_MAX then
            if ar_b_mask = mask then
                read_ar_b_value = data_low
            else
                read_ar_b_value = (data_low - H8000_0000) and ar_b_mask
            end If
        else
            read_ar_b_value = data_low and ar_b_mask
        end If

    End Sub

    Sub write
        If flag_ar_b = &H0 Then read
        If flag_ar_b = &H0 Then write_ar_b_value = get_ar_b

        regValue = leftShift((write_ar_b_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ar_b_mask = &Hffff
        if data_low > LONG_MAX then
            if ar_b_mask = mask then
                read_ar_b_value = data_low
            else
                read_ar_b_value = (data_low - H8000_0000) and ar_b_mask
            end If
        else
            read_ar_b_value = data_low and ar_b_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ar_b_value = &H0
        flag_ar_b        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_ar_r_ser_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ar_r                                       [31:20]          get_ar_r
''                                                             set_ar_r
''                                                             read_ar_r
''                                                             write_ar_r
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_ar_r_ser_m
    Private write_ar_r_value
    Private read_ar_r_value
    Private flag_ar_r

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H212c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ar_r
        get_ar_r = read_ar_r_value
    End Property

    Property Let set_ar_r(aData)
        write_ar_r_value = aData
        flag_ar_r        = &H1
    End Property

    Property Get read_ar_r
        read
        read_ar_r = read_ar_r_value
    End Property

    Property Let write_ar_r(aData)
        set_ar_r = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ar_r_value = rightShift(data_low, 20) and &Hfff

    End Sub

    Sub write
        If flag_ar_r = &H0 Then read
        If flag_ar_r = &H0 Then write_ar_r_value = get_ar_r

        regValue = leftShift((write_ar_r_value and &Hfff), 20)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ar_r_value = rightShift(data_low, 20) and &Hfff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ar_r_value = &H0
        flag_ar_r        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_target_fc_ser_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ar_tgt_latency                             [27:16]          get_ar_tgt_latency
''                                                             set_ar_tgt_latency
''                                                             read_ar_tgt_latency
''                                                             write_ar_tgt_latency
''---------------------------------------------------------------------------------
'' aw_tgt_latency                             [11:0]           get_aw_tgt_latency
''                                                             set_aw_tgt_latency
''                                                             read_aw_tgt_latency
''                                                             write_aw_tgt_latency
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_target_fc_ser_m
    Private write_ar_tgt_latency_value
    Private read_ar_tgt_latency_value
    Private flag_ar_tgt_latency
    Private write_aw_tgt_latency_value
    Private read_aw_tgt_latency_value
    Private flag_aw_tgt_latency

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H2130
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ar_tgt_latency
        get_ar_tgt_latency = read_ar_tgt_latency_value
    End Property

    Property Let set_ar_tgt_latency(aData)
        write_ar_tgt_latency_value = aData
        flag_ar_tgt_latency        = &H1
    End Property

    Property Get read_ar_tgt_latency
        read
        read_ar_tgt_latency = read_ar_tgt_latency_value
    End Property

    Property Let write_ar_tgt_latency(aData)
        set_ar_tgt_latency = aData
        write
    End Property

    Property Get get_aw_tgt_latency
        get_aw_tgt_latency = read_aw_tgt_latency_value
    End Property

    Property Let set_aw_tgt_latency(aData)
        write_aw_tgt_latency_value = aData
        flag_aw_tgt_latency        = &H1
    End Property

    Property Get read_aw_tgt_latency
        read
        read_aw_tgt_latency = read_aw_tgt_latency_value
    End Property

    Property Let write_aw_tgt_latency(aData)
        set_aw_tgt_latency = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ar_tgt_latency_value = rightShift(data_low, 16) and &Hfff
        aw_tgt_latency_mask = &Hfff
        if data_low > LONG_MAX then
            if aw_tgt_latency_mask = mask then
                read_aw_tgt_latency_value = data_low
            else
                read_aw_tgt_latency_value = (data_low - H8000_0000) and aw_tgt_latency_mask
            end If
        else
            read_aw_tgt_latency_value = data_low and aw_tgt_latency_mask
        end If

    End Sub

    Sub write
        If flag_ar_tgt_latency = &H0 or flag_aw_tgt_latency = &H0 Then read
        If flag_ar_tgt_latency = &H0 Then write_ar_tgt_latency_value = get_ar_tgt_latency
        If flag_aw_tgt_latency = &H0 Then write_aw_tgt_latency_value = get_aw_tgt_latency

        regValue = leftShift((write_ar_tgt_latency_value and &Hfff), 16) + leftShift((write_aw_tgt_latency_value and &Hfff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ar_tgt_latency_value = rightShift(data_low, 16) and &Hfff
        aw_tgt_latency_mask = &Hfff
        if data_low > LONG_MAX then
            if aw_tgt_latency_mask = mask then
                read_aw_tgt_latency_value = data_low
            else
                read_aw_tgt_latency_value = (data_low - H8000_0000) and aw_tgt_latency_mask
            end If
        else
            read_aw_tgt_latency_value = data_low and aw_tgt_latency_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ar_tgt_latency_value = &H0
        flag_ar_tgt_latency        = &H0
        write_aw_tgt_latency_value = &H0
        flag_aw_tgt_latency        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_ki_fc_ser_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ar_ki                                      [10:8]           get_ar_ki
''                                                             set_ar_ki
''                                                             read_ar_ki
''                                                             write_ar_ki
''---------------------------------------------------------------------------------
'' aw_ki                                      [2:0]            get_aw_ki
''                                                             set_aw_ki
''                                                             read_aw_ki
''                                                             write_aw_ki
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_ki_fc_ser_m
    Private write_ar_ki_value
    Private read_ar_ki_value
    Private flag_ar_ki
    Private write_aw_ki_value
    Private read_aw_ki_value
    Private flag_aw_ki

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H2134
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ar_ki
        get_ar_ki = read_ar_ki_value
    End Property

    Property Let set_ar_ki(aData)
        write_ar_ki_value = aData
        flag_ar_ki        = &H1
    End Property

    Property Get read_ar_ki
        read
        read_ar_ki = read_ar_ki_value
    End Property

    Property Let write_ar_ki(aData)
        set_ar_ki = aData
        write
    End Property

    Property Get get_aw_ki
        get_aw_ki = read_aw_ki_value
    End Property

    Property Let set_aw_ki(aData)
        write_aw_ki_value = aData
        flag_aw_ki        = &H1
    End Property

    Property Get read_aw_ki
        read
        read_aw_ki = read_aw_ki_value
    End Property

    Property Let write_aw_ki(aData)
        set_aw_ki = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ar_ki_value = rightShift(data_low, 8) and &H7
        aw_ki_mask = &H7
        if data_low > LONG_MAX then
            if aw_ki_mask = mask then
                read_aw_ki_value = data_low
            else
                read_aw_ki_value = (data_low - H8000_0000) and aw_ki_mask
            end If
        else
            read_aw_ki_value = data_low and aw_ki_mask
        end If

    End Sub

    Sub write
        If flag_ar_ki = &H0 or flag_aw_ki = &H0 Then read
        If flag_ar_ki = &H0 Then write_ar_ki_value = get_ar_ki
        If flag_aw_ki = &H0 Then write_aw_ki_value = get_aw_ki

        regValue = leftShift((write_ar_ki_value and &H7), 8) + leftShift((write_aw_ki_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ar_ki_value = rightShift(data_low, 8) and &H7
        aw_ki_mask = &H7
        if data_low > LONG_MAX then
            if aw_ki_mask = mask then
                read_aw_ki_value = data_low
            else
                read_aw_ki_value = (data_low - H8000_0000) and aw_ki_mask
            end If
        else
            read_aw_ki_value = data_low and aw_ki_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ar_ki_value = &H0
        flag_ar_ki        = &H0
        write_aw_ki_value = &H0
        flag_aw_ki        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_qos_range_ser_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ar_max_qos                                 [27:24]          get_ar_max_qos
''                                                             set_ar_max_qos
''                                                             read_ar_max_qos
''                                                             write_ar_max_qos
''---------------------------------------------------------------------------------
'' ar_min_qos                                 [19:16]          get_ar_min_qos
''                                                             set_ar_min_qos
''                                                             read_ar_min_qos
''                                                             write_ar_min_qos
''---------------------------------------------------------------------------------
'' aw_max_qos                                 [11:8]           get_aw_max_qos
''                                                             set_aw_max_qos
''                                                             read_aw_max_qos
''                                                             write_aw_max_qos
''---------------------------------------------------------------------------------
'' aw_min_qos                                 [3:0]            get_aw_min_qos
''                                                             set_aw_min_qos
''                                                             read_aw_min_qos
''                                                             write_aw_min_qos
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_qos_range_ser_m
    Private write_ar_max_qos_value
    Private read_ar_max_qos_value
    Private flag_ar_max_qos
    Private write_ar_min_qos_value
    Private read_ar_min_qos_value
    Private flag_ar_min_qos
    Private write_aw_max_qos_value
    Private read_aw_max_qos_value
    Private flag_aw_max_qos
    Private write_aw_min_qos_value
    Private read_aw_min_qos_value
    Private flag_aw_min_qos

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H2138
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ar_max_qos
        get_ar_max_qos = read_ar_max_qos_value
    End Property

    Property Let set_ar_max_qos(aData)
        write_ar_max_qos_value = aData
        flag_ar_max_qos        = &H1
    End Property

    Property Get read_ar_max_qos
        read
        read_ar_max_qos = read_ar_max_qos_value
    End Property

    Property Let write_ar_max_qos(aData)
        set_ar_max_qos = aData
        write
    End Property

    Property Get get_ar_min_qos
        get_ar_min_qos = read_ar_min_qos_value
    End Property

    Property Let set_ar_min_qos(aData)
        write_ar_min_qos_value = aData
        flag_ar_min_qos        = &H1
    End Property

    Property Get read_ar_min_qos
        read
        read_ar_min_qos = read_ar_min_qos_value
    End Property

    Property Let write_ar_min_qos(aData)
        set_ar_min_qos = aData
        write
    End Property

    Property Get get_aw_max_qos
        get_aw_max_qos = read_aw_max_qos_value
    End Property

    Property Let set_aw_max_qos(aData)
        write_aw_max_qos_value = aData
        flag_aw_max_qos        = &H1
    End Property

    Property Get read_aw_max_qos
        read
        read_aw_max_qos = read_aw_max_qos_value
    End Property

    Property Let write_aw_max_qos(aData)
        set_aw_max_qos = aData
        write
    End Property

    Property Get get_aw_min_qos
        get_aw_min_qos = read_aw_min_qos_value
    End Property

    Property Let set_aw_min_qos(aData)
        write_aw_min_qos_value = aData
        flag_aw_min_qos        = &H1
    End Property

    Property Get read_aw_min_qos
        read
        read_aw_min_qos = read_aw_min_qos_value
    End Property

    Property Let write_aw_min_qos(aData)
        set_aw_min_qos = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ar_max_qos_value = rightShift(data_low, 24) and &Hf
        read_ar_min_qos_value = rightShift(data_low, 16) and &Hf
        read_aw_max_qos_value = rightShift(data_low, 8) and &Hf
        aw_min_qos_mask = &Hf
        if data_low > LONG_MAX then
            if aw_min_qos_mask = mask then
                read_aw_min_qos_value = data_low
            else
                read_aw_min_qos_value = (data_low - H8000_0000) and aw_min_qos_mask
            end If
        else
            read_aw_min_qos_value = data_low and aw_min_qos_mask
        end If

    End Sub

    Sub write
        If flag_ar_max_qos = &H0 or flag_ar_min_qos = &H0 or flag_aw_max_qos = &H0 or flag_aw_min_qos = &H0 Then read
        If flag_ar_max_qos = &H0 Then write_ar_max_qos_value = get_ar_max_qos
        If flag_ar_min_qos = &H0 Then write_ar_min_qos_value = get_ar_min_qos
        If flag_aw_max_qos = &H0 Then write_aw_max_qos_value = get_aw_max_qos
        If flag_aw_min_qos = &H0 Then write_aw_min_qos_value = get_aw_min_qos

        regValue = leftShift((write_ar_max_qos_value and &Hf), 24) + leftShift((write_ar_min_qos_value and &Hf), 16) + leftShift((write_aw_max_qos_value and &Hf), 8) + leftShift((write_aw_min_qos_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ar_max_qos_value = rightShift(data_low, 24) and &Hf
        read_ar_min_qos_value = rightShift(data_low, 16) and &Hf
        read_aw_max_qos_value = rightShift(data_low, 8) and &Hf
        aw_min_qos_mask = &Hf
        if data_low > LONG_MAX then
            if aw_min_qos_mask = mask then
                read_aw_min_qos_value = data_low
            else
                read_aw_min_qos_value = (data_low - H8000_0000) and aw_min_qos_mask
            end If
        else
            read_aw_min_qos_value = data_low and aw_min_qos_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ar_max_qos_value = &H0
        flag_ar_max_qos        = &H0
        write_ar_min_qos_value = &H0
        flag_ar_min_qos        = &H0
        write_aw_max_qos_value = &H0
        flag_aw_max_qos        = &H0
        write_aw_min_qos_value = &H0
        flag_aw_min_qos        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_fn_mod_ahb_pcie_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' fn_mod_ahb                                 [1:0]            get_fn_mod_ahb
''                                                             set_fn_mod_ahb
''                                                             read_fn_mod_ahb
''                                                             write_fn_mod_ahb
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_fn_mod_ahb_pcie_m
    Private write_fn_mod_ahb_value
    Private read_fn_mod_ahb_value
    Private flag_fn_mod_ahb

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

    Property Get get_fn_mod_ahb
        get_fn_mod_ahb = read_fn_mod_ahb_value
    End Property

    Property Let set_fn_mod_ahb(aData)
        write_fn_mod_ahb_value = aData
        flag_fn_mod_ahb        = &H1
    End Property

    Property Get read_fn_mod_ahb
        read
        read_fn_mod_ahb = read_fn_mod_ahb_value
    End Property

    Property Let write_fn_mod_ahb(aData)
        set_fn_mod_ahb = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        fn_mod_ahb_mask = &H3
        if data_low > LONG_MAX then
            if fn_mod_ahb_mask = mask then
                read_fn_mod_ahb_value = data_low
            else
                read_fn_mod_ahb_value = (data_low - H8000_0000) and fn_mod_ahb_mask
            end If
        else
            read_fn_mod_ahb_value = data_low and fn_mod_ahb_mask
        end If

    End Sub

    Sub write
        If flag_fn_mod_ahb = &H0 Then read
        If flag_fn_mod_ahb = &H0 Then write_fn_mod_ahb_value = get_fn_mod_ahb

        regValue = leftShift((write_fn_mod_ahb_value and &H3), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        fn_mod_ahb_mask = &H3
        if data_low > LONG_MAX then
            if fn_mod_ahb_mask = mask then
                read_fn_mod_ahb_value = data_low
            else
                read_fn_mod_ahb_value = (data_low - H8000_0000) and fn_mod_ahb_mask
            end If
        else
            read_fn_mod_ahb_value = data_low and fn_mod_ahb_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_fn_mod_ahb_value = &H0
        flag_fn_mod_ahb        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_read_qos_pcie_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' read_qos                                   [3:0]            get_read_qos
''                                                             set_read_qos
''                                                             read_read_qos
''                                                             write_read_qos
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_read_qos_pcie_m
    Private write_read_qos_value
    Private read_read_qos_value
    Private flag_read_qos

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3100
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_read_qos
        get_read_qos = read_read_qos_value
    End Property

    Property Let set_read_qos(aData)
        write_read_qos_value = aData
        flag_read_qos        = &H1
    End Property

    Property Get read_read_qos
        read
        read_read_qos = read_read_qos_value
    End Property

    Property Let write_read_qos(aData)
        set_read_qos = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_qos_mask = &Hf
        if data_low > LONG_MAX then
            if read_qos_mask = mask then
                read_read_qos_value = data_low
            else
                read_read_qos_value = (data_low - H8000_0000) and read_qos_mask
            end If
        else
            read_read_qos_value = data_low and read_qos_mask
        end If

    End Sub

    Sub write
        If flag_read_qos = &H0 Then read
        If flag_read_qos = &H0 Then write_read_qos_value = get_read_qos

        regValue = leftShift((write_read_qos_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_qos_mask = &Hf
        if data_low > LONG_MAX then
            if read_qos_mask = mask then
                read_read_qos_value = data_low
            else
                read_read_qos_value = (data_low - H8000_0000) and read_qos_mask
            end If
        else
            read_read_qos_value = data_low and read_qos_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_read_qos_value = &H0
        flag_read_qos        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_write_qos_pcie_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' write_qos                                  [3:0]            get_write_qos
''                                                             set_write_qos
''                                                             read_write_qos
''                                                             write_write_qos
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_write_qos_pcie_m
    Private write_write_qos_value
    Private read_write_qos_value
    Private flag_write_qos

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3104
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_write_qos
        get_write_qos = read_write_qos_value
    End Property

    Property Let set_write_qos(aData)
        write_write_qos_value = aData
        flag_write_qos        = &H1
    End Property

    Property Get read_write_qos
        read
        read_write_qos = read_write_qos_value
    End Property

    Property Let write_write_qos(aData)
        set_write_qos = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        write_qos_mask = &Hf
        if data_low > LONG_MAX then
            if write_qos_mask = mask then
                read_write_qos_value = data_low
            else
                read_write_qos_value = (data_low - H8000_0000) and write_qos_mask
            end If
        else
            read_write_qos_value = data_low and write_qos_mask
        end If

    End Sub

    Sub write
        If flag_write_qos = &H0 Then read
        If flag_write_qos = &H0 Then write_write_qos_value = get_write_qos

        regValue = leftShift((write_write_qos_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        write_qos_mask = &Hf
        if data_low > LONG_MAX then
            if write_qos_mask = mask then
                read_write_qos_value = data_low
            else
                read_write_qos_value = (data_low - H8000_0000) and write_qos_mask
            end If
        else
            read_write_qos_value = data_low and write_qos_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_write_qos_value = &H0
        flag_write_qos        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_fn_mod_pcie_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' fn_mod                                     [1:0]            get_fn_mod
''                                                             set_fn_mod
''                                                             read_fn_mod
''                                                             write_fn_mod
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_fn_mod_pcie_m
    Private write_fn_mod_value
    Private read_fn_mod_value
    Private flag_fn_mod

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3108
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_fn_mod
        get_fn_mod = read_fn_mod_value
    End Property

    Property Let set_fn_mod(aData)
        write_fn_mod_value = aData
        flag_fn_mod        = &H1
    End Property

    Property Get read_fn_mod
        read
        read_fn_mod = read_fn_mod_value
    End Property

    Property Let write_fn_mod(aData)
        set_fn_mod = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        fn_mod_mask = &H3
        if data_low > LONG_MAX then
            if fn_mod_mask = mask then
                read_fn_mod_value = data_low
            else
                read_fn_mod_value = (data_low - H8000_0000) and fn_mod_mask
            end If
        else
            read_fn_mod_value = data_low and fn_mod_mask
        end If

    End Sub

    Sub write
        If flag_fn_mod = &H0 Then read
        If flag_fn_mod = &H0 Then write_fn_mod_value = get_fn_mod

        regValue = leftShift((write_fn_mod_value and &H3), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        fn_mod_mask = &H3
        if data_low > LONG_MAX then
            if fn_mod_mask = mask then
                read_fn_mod_value = data_low
            else
                read_fn_mod_value = (data_low - H8000_0000) and fn_mod_mask
            end If
        else
            read_fn_mod_value = data_low and fn_mod_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_fn_mod_value = &H0
        flag_fn_mod        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_qos_cntl_pcie_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mode_ar_fc                                 [20:20]          get_mode_ar_fc
''                                                             set_mode_ar_fc
''                                                             read_mode_ar_fc
''                                                             write_mode_ar_fc
''---------------------------------------------------------------------------------
'' mode_aw_fc                                 [16:16]          get_mode_aw_fc
''                                                             set_mode_aw_fc
''                                                             read_mode_aw_fc
''                                                             write_mode_aw_fc
''---------------------------------------------------------------------------------
'' en_awar_ot                                 [7:7]            get_en_awar_ot
''                                                             set_en_awar_ot
''                                                             read_en_awar_ot
''                                                             write_en_awar_ot
''---------------------------------------------------------------------------------
'' en_ar_ot                                   [6:6]            get_en_ar_ot
''                                                             set_en_ar_ot
''                                                             read_en_ar_ot
''                                                             write_en_ar_ot
''---------------------------------------------------------------------------------
'' en_aw_ot                                   [5:5]            get_en_aw_ot
''                                                             set_en_aw_ot
''                                                             read_en_aw_ot
''                                                             write_en_aw_ot
''---------------------------------------------------------------------------------
'' en_ar_fc                                   [4:4]            get_en_ar_fc
''                                                             set_en_ar_fc
''                                                             read_en_ar_fc
''                                                             write_en_ar_fc
''---------------------------------------------------------------------------------
'' en_aw_fc                                   [3:3]            get_en_aw_fc
''                                                             set_en_aw_fc
''                                                             read_en_aw_fc
''                                                             write_en_aw_fc
''---------------------------------------------------------------------------------
'' en_awar_rate                               [2:2]            get_en_awar_rate
''                                                             set_en_awar_rate
''                                                             read_en_awar_rate
''                                                             write_en_awar_rate
''---------------------------------------------------------------------------------
'' en_ar_rate                                 [1:1]            get_en_ar_rate
''                                                             set_en_ar_rate
''                                                             read_en_ar_rate
''                                                             write_en_ar_rate
''---------------------------------------------------------------------------------
'' en_aw_rate                                 [0:0]            get_en_aw_rate
''                                                             set_en_aw_rate
''                                                             read_en_aw_rate
''                                                             write_en_aw_rate
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_qos_cntl_pcie_m
    Private write_mode_ar_fc_value
    Private read_mode_ar_fc_value
    Private flag_mode_ar_fc
    Private write_mode_aw_fc_value
    Private read_mode_aw_fc_value
    Private flag_mode_aw_fc
    Private write_en_awar_ot_value
    Private read_en_awar_ot_value
    Private flag_en_awar_ot
    Private write_en_ar_ot_value
    Private read_en_ar_ot_value
    Private flag_en_ar_ot
    Private write_en_aw_ot_value
    Private read_en_aw_ot_value
    Private flag_en_aw_ot
    Private write_en_ar_fc_value
    Private read_en_ar_fc_value
    Private flag_en_ar_fc
    Private write_en_aw_fc_value
    Private read_en_aw_fc_value
    Private flag_en_aw_fc
    Private write_en_awar_rate_value
    Private read_en_awar_rate_value
    Private flag_en_awar_rate
    Private write_en_ar_rate_value
    Private read_en_ar_rate_value
    Private flag_en_ar_rate
    Private write_en_aw_rate_value
    Private read_en_aw_rate_value
    Private flag_en_aw_rate

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H310c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mode_ar_fc
        get_mode_ar_fc = read_mode_ar_fc_value
    End Property

    Property Let set_mode_ar_fc(aData)
        write_mode_ar_fc_value = aData
        flag_mode_ar_fc        = &H1
    End Property

    Property Get read_mode_ar_fc
        read
        read_mode_ar_fc = read_mode_ar_fc_value
    End Property

    Property Let write_mode_ar_fc(aData)
        set_mode_ar_fc = aData
        write
    End Property

    Property Get get_mode_aw_fc
        get_mode_aw_fc = read_mode_aw_fc_value
    End Property

    Property Let set_mode_aw_fc(aData)
        write_mode_aw_fc_value = aData
        flag_mode_aw_fc        = &H1
    End Property

    Property Get read_mode_aw_fc
        read
        read_mode_aw_fc = read_mode_aw_fc_value
    End Property

    Property Let write_mode_aw_fc(aData)
        set_mode_aw_fc = aData
        write
    End Property

    Property Get get_en_awar_ot
        get_en_awar_ot = read_en_awar_ot_value
    End Property

    Property Let set_en_awar_ot(aData)
        write_en_awar_ot_value = aData
        flag_en_awar_ot        = &H1
    End Property

    Property Get read_en_awar_ot
        read
        read_en_awar_ot = read_en_awar_ot_value
    End Property

    Property Let write_en_awar_ot(aData)
        set_en_awar_ot = aData
        write
    End Property

    Property Get get_en_ar_ot
        get_en_ar_ot = read_en_ar_ot_value
    End Property

    Property Let set_en_ar_ot(aData)
        write_en_ar_ot_value = aData
        flag_en_ar_ot        = &H1
    End Property

    Property Get read_en_ar_ot
        read
        read_en_ar_ot = read_en_ar_ot_value
    End Property

    Property Let write_en_ar_ot(aData)
        set_en_ar_ot = aData
        write
    End Property

    Property Get get_en_aw_ot
        get_en_aw_ot = read_en_aw_ot_value
    End Property

    Property Let set_en_aw_ot(aData)
        write_en_aw_ot_value = aData
        flag_en_aw_ot        = &H1
    End Property

    Property Get read_en_aw_ot
        read
        read_en_aw_ot = read_en_aw_ot_value
    End Property

    Property Let write_en_aw_ot(aData)
        set_en_aw_ot = aData
        write
    End Property

    Property Get get_en_ar_fc
        get_en_ar_fc = read_en_ar_fc_value
    End Property

    Property Let set_en_ar_fc(aData)
        write_en_ar_fc_value = aData
        flag_en_ar_fc        = &H1
    End Property

    Property Get read_en_ar_fc
        read
        read_en_ar_fc = read_en_ar_fc_value
    End Property

    Property Let write_en_ar_fc(aData)
        set_en_ar_fc = aData
        write
    End Property

    Property Get get_en_aw_fc
        get_en_aw_fc = read_en_aw_fc_value
    End Property

    Property Let set_en_aw_fc(aData)
        write_en_aw_fc_value = aData
        flag_en_aw_fc        = &H1
    End Property

    Property Get read_en_aw_fc
        read
        read_en_aw_fc = read_en_aw_fc_value
    End Property

    Property Let write_en_aw_fc(aData)
        set_en_aw_fc = aData
        write
    End Property

    Property Get get_en_awar_rate
        get_en_awar_rate = read_en_awar_rate_value
    End Property

    Property Let set_en_awar_rate(aData)
        write_en_awar_rate_value = aData
        flag_en_awar_rate        = &H1
    End Property

    Property Get read_en_awar_rate
        read
        read_en_awar_rate = read_en_awar_rate_value
    End Property

    Property Let write_en_awar_rate(aData)
        set_en_awar_rate = aData
        write
    End Property

    Property Get get_en_ar_rate
        get_en_ar_rate = read_en_ar_rate_value
    End Property

    Property Let set_en_ar_rate(aData)
        write_en_ar_rate_value = aData
        flag_en_ar_rate        = &H1
    End Property

    Property Get read_en_ar_rate
        read
        read_en_ar_rate = read_en_ar_rate_value
    End Property

    Property Let write_en_ar_rate(aData)
        set_en_ar_rate = aData
        write
    End Property

    Property Get get_en_aw_rate
        get_en_aw_rate = read_en_aw_rate_value
    End Property

    Property Let set_en_aw_rate(aData)
        write_en_aw_rate_value = aData
        flag_en_aw_rate        = &H1
    End Property

    Property Get read_en_aw_rate
        read
        read_en_aw_rate = read_en_aw_rate_value
    End Property

    Property Let write_en_aw_rate(aData)
        set_en_aw_rate = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_mode_ar_fc_value = rightShift(data_low, 20) and &H1
        read_mode_aw_fc_value = rightShift(data_low, 16) and &H1
        read_en_awar_ot_value = rightShift(data_low, 7) and &H1
        read_en_ar_ot_value = rightShift(data_low, 6) and &H1
        read_en_aw_ot_value = rightShift(data_low, 5) and &H1
        read_en_ar_fc_value = rightShift(data_low, 4) and &H1
        read_en_aw_fc_value = rightShift(data_low, 3) and &H1
        read_en_awar_rate_value = rightShift(data_low, 2) and &H1
        read_en_ar_rate_value = rightShift(data_low, 1) and &H1
        en_aw_rate_mask = &H1
        if data_low > LONG_MAX then
            if en_aw_rate_mask = mask then
                read_en_aw_rate_value = data_low
            else
                read_en_aw_rate_value = (data_low - H8000_0000) and en_aw_rate_mask
            end If
        else
            read_en_aw_rate_value = data_low and en_aw_rate_mask
        end If

    End Sub

    Sub write
        If flag_mode_ar_fc = &H0 or flag_mode_aw_fc = &H0 or flag_en_awar_ot = &H0 or flag_en_ar_ot = &H0 or flag_en_aw_ot = &H0 or flag_en_ar_fc = &H0 or flag_en_aw_fc = &H0 or flag_en_awar_rate = &H0 or flag_en_ar_rate = &H0 or flag_en_aw_rate = &H0 Then read
        If flag_mode_ar_fc = &H0 Then write_mode_ar_fc_value = get_mode_ar_fc
        If flag_mode_aw_fc = &H0 Then write_mode_aw_fc_value = get_mode_aw_fc
        If flag_en_awar_ot = &H0 Then write_en_awar_ot_value = get_en_awar_ot
        If flag_en_ar_ot = &H0 Then write_en_ar_ot_value = get_en_ar_ot
        If flag_en_aw_ot = &H0 Then write_en_aw_ot_value = get_en_aw_ot
        If flag_en_ar_fc = &H0 Then write_en_ar_fc_value = get_en_ar_fc
        If flag_en_aw_fc = &H0 Then write_en_aw_fc_value = get_en_aw_fc
        If flag_en_awar_rate = &H0 Then write_en_awar_rate_value = get_en_awar_rate
        If flag_en_ar_rate = &H0 Then write_en_ar_rate_value = get_en_ar_rate
        If flag_en_aw_rate = &H0 Then write_en_aw_rate_value = get_en_aw_rate

        regValue = leftShift((write_mode_ar_fc_value and &H1), 20) + leftShift((write_mode_aw_fc_value and &H1), 16) + leftShift((write_en_awar_ot_value and &H1), 7) + leftShift((write_en_ar_ot_value and &H1), 6) + leftShift((write_en_aw_ot_value and &H1), 5) + leftShift((write_en_ar_fc_value and &H1), 4) + leftShift((write_en_aw_fc_value and &H1), 3) + leftShift((write_en_awar_rate_value and &H1), 2) + leftShift((write_en_ar_rate_value and &H1), 1) + leftShift((write_en_aw_rate_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_mode_ar_fc_value = rightShift(data_low, 20) and &H1
        read_mode_aw_fc_value = rightShift(data_low, 16) and &H1
        read_en_awar_ot_value = rightShift(data_low, 7) and &H1
        read_en_ar_ot_value = rightShift(data_low, 6) and &H1
        read_en_aw_ot_value = rightShift(data_low, 5) and &H1
        read_en_ar_fc_value = rightShift(data_low, 4) and &H1
        read_en_aw_fc_value = rightShift(data_low, 3) and &H1
        read_en_awar_rate_value = rightShift(data_low, 2) and &H1
        read_en_ar_rate_value = rightShift(data_low, 1) and &H1
        en_aw_rate_mask = &H1
        if data_low > LONG_MAX then
            if en_aw_rate_mask = mask then
                read_en_aw_rate_value = data_low
            else
                read_en_aw_rate_value = (data_low - H8000_0000) and en_aw_rate_mask
            end If
        else
            read_en_aw_rate_value = data_low and en_aw_rate_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mode_ar_fc_value = &H0
        flag_mode_ar_fc        = &H0
        write_mode_aw_fc_value = &H0
        flag_mode_aw_fc        = &H0
        write_en_awar_ot_value = &H0
        flag_en_awar_ot        = &H0
        write_en_ar_ot_value = &H0
        flag_en_ar_ot        = &H0
        write_en_aw_ot_value = &H0
        flag_en_aw_ot        = &H0
        write_en_ar_fc_value = &H0
        flag_en_ar_fc        = &H0
        write_en_aw_fc_value = &H0
        flag_en_aw_fc        = &H0
        write_en_awar_rate_value = &H0
        flag_en_awar_rate        = &H0
        write_en_ar_rate_value = &H0
        flag_en_ar_rate        = &H0
        write_en_aw_rate_value = &H0
        flag_en_aw_rate        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_max_ot_pcie_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ar_max_oti                                 [29:24]          get_ar_max_oti
''                                                             set_ar_max_oti
''                                                             read_ar_max_oti
''                                                             write_ar_max_oti
''---------------------------------------------------------------------------------
'' ar_max_otf                                 [23:16]          get_ar_max_otf
''                                                             set_ar_max_otf
''                                                             read_ar_max_otf
''                                                             write_ar_max_otf
''---------------------------------------------------------------------------------
'' aw_max_oti                                 [13:8]           get_aw_max_oti
''                                                             set_aw_max_oti
''                                                             read_aw_max_oti
''                                                             write_aw_max_oti
''---------------------------------------------------------------------------------
'' en_ar_ot                                   [7:0]            get_en_ar_ot
''                                                             set_en_ar_ot
''                                                             read_en_ar_ot
''                                                             write_en_ar_ot
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_max_ot_pcie_m
    Private write_ar_max_oti_value
    Private read_ar_max_oti_value
    Private flag_ar_max_oti
    Private write_ar_max_otf_value
    Private read_ar_max_otf_value
    Private flag_ar_max_otf
    Private write_aw_max_oti_value
    Private read_aw_max_oti_value
    Private flag_aw_max_oti
    Private write_en_ar_ot_value
    Private read_en_ar_ot_value
    Private flag_en_ar_ot

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3110
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ar_max_oti
        get_ar_max_oti = read_ar_max_oti_value
    End Property

    Property Let set_ar_max_oti(aData)
        write_ar_max_oti_value = aData
        flag_ar_max_oti        = &H1
    End Property

    Property Get read_ar_max_oti
        read
        read_ar_max_oti = read_ar_max_oti_value
    End Property

    Property Let write_ar_max_oti(aData)
        set_ar_max_oti = aData
        write
    End Property

    Property Get get_ar_max_otf
        get_ar_max_otf = read_ar_max_otf_value
    End Property

    Property Let set_ar_max_otf(aData)
        write_ar_max_otf_value = aData
        flag_ar_max_otf        = &H1
    End Property

    Property Get read_ar_max_otf
        read
        read_ar_max_otf = read_ar_max_otf_value
    End Property

    Property Let write_ar_max_otf(aData)
        set_ar_max_otf = aData
        write
    End Property

    Property Get get_aw_max_oti
        get_aw_max_oti = read_aw_max_oti_value
    End Property

    Property Let set_aw_max_oti(aData)
        write_aw_max_oti_value = aData
        flag_aw_max_oti        = &H1
    End Property

    Property Get read_aw_max_oti
        read
        read_aw_max_oti = read_aw_max_oti_value
    End Property

    Property Let write_aw_max_oti(aData)
        set_aw_max_oti = aData
        write
    End Property

    Property Get get_en_ar_ot
        get_en_ar_ot = read_en_ar_ot_value
    End Property

    Property Let set_en_ar_ot(aData)
        write_en_ar_ot_value = aData
        flag_en_ar_ot        = &H1
    End Property

    Property Get read_en_ar_ot
        read
        read_en_ar_ot = read_en_ar_ot_value
    End Property

    Property Let write_en_ar_ot(aData)
        set_en_ar_ot = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ar_max_oti_value = rightShift(data_low, 24) and &H3f
        read_ar_max_otf_value = rightShift(data_low, 16) and &Hff
        read_aw_max_oti_value = rightShift(data_low, 8) and &H3f
        en_ar_ot_mask = &Hff
        if data_low > LONG_MAX then
            if en_ar_ot_mask = mask then
                read_en_ar_ot_value = data_low
            else
                read_en_ar_ot_value = (data_low - H8000_0000) and en_ar_ot_mask
            end If
        else
            read_en_ar_ot_value = data_low and en_ar_ot_mask
        end If

    End Sub

    Sub write
        If flag_ar_max_oti = &H0 or flag_ar_max_otf = &H0 or flag_aw_max_oti = &H0 or flag_en_ar_ot = &H0 Then read
        If flag_ar_max_oti = &H0 Then write_ar_max_oti_value = get_ar_max_oti
        If flag_ar_max_otf = &H0 Then write_ar_max_otf_value = get_ar_max_otf
        If flag_aw_max_oti = &H0 Then write_aw_max_oti_value = get_aw_max_oti
        If flag_en_ar_ot = &H0 Then write_en_ar_ot_value = get_en_ar_ot

        regValue = leftShift((write_ar_max_oti_value and &H3f), 24) + leftShift((write_ar_max_otf_value and &Hff), 16) + leftShift((write_aw_max_oti_value and &H3f), 8) + leftShift((write_en_ar_ot_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ar_max_oti_value = rightShift(data_low, 24) and &H3f
        read_ar_max_otf_value = rightShift(data_low, 16) and &Hff
        read_aw_max_oti_value = rightShift(data_low, 8) and &H3f
        en_ar_ot_mask = &Hff
        if data_low > LONG_MAX then
            if en_ar_ot_mask = mask then
                read_en_ar_ot_value = data_low
            else
                read_en_ar_ot_value = (data_low - H8000_0000) and en_ar_ot_mask
            end If
        else
            read_en_ar_ot_value = data_low and en_ar_ot_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ar_max_oti_value = &H0
        flag_ar_max_oti        = &H0
        write_ar_max_otf_value = &H0
        flag_ar_max_otf        = &H0
        write_aw_max_oti_value = &H0
        flag_aw_max_oti        = &H0
        write_en_ar_ot_value = &H0
        flag_en_ar_ot        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_max_comb_ot_pcie_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' awar_max_oti                               [14:8]           get_awar_max_oti
''                                                             set_awar_max_oti
''                                                             read_awar_max_oti
''                                                             write_awar_max_oti
''---------------------------------------------------------------------------------
'' awar_max_otf                               [7:0]            get_awar_max_otf
''                                                             set_awar_max_otf
''                                                             read_awar_max_otf
''                                                             write_awar_max_otf
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_max_comb_ot_pcie_m
    Private write_awar_max_oti_value
    Private read_awar_max_oti_value
    Private flag_awar_max_oti
    Private write_awar_max_otf_value
    Private read_awar_max_otf_value
    Private flag_awar_max_otf

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3114
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_awar_max_oti
        get_awar_max_oti = read_awar_max_oti_value
    End Property

    Property Let set_awar_max_oti(aData)
        write_awar_max_oti_value = aData
        flag_awar_max_oti        = &H1
    End Property

    Property Get read_awar_max_oti
        read
        read_awar_max_oti = read_awar_max_oti_value
    End Property

    Property Let write_awar_max_oti(aData)
        set_awar_max_oti = aData
        write
    End Property

    Property Get get_awar_max_otf
        get_awar_max_otf = read_awar_max_otf_value
    End Property

    Property Let set_awar_max_otf(aData)
        write_awar_max_otf_value = aData
        flag_awar_max_otf        = &H1
    End Property

    Property Get read_awar_max_otf
        read
        read_awar_max_otf = read_awar_max_otf_value
    End Property

    Property Let write_awar_max_otf(aData)
        set_awar_max_otf = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_awar_max_oti_value = rightShift(data_low, 8) and &H7f
        awar_max_otf_mask = &Hff
        if data_low > LONG_MAX then
            if awar_max_otf_mask = mask then
                read_awar_max_otf_value = data_low
            else
                read_awar_max_otf_value = (data_low - H8000_0000) and awar_max_otf_mask
            end If
        else
            read_awar_max_otf_value = data_low and awar_max_otf_mask
        end If

    End Sub

    Sub write
        If flag_awar_max_oti = &H0 or flag_awar_max_otf = &H0 Then read
        If flag_awar_max_oti = &H0 Then write_awar_max_oti_value = get_awar_max_oti
        If flag_awar_max_otf = &H0 Then write_awar_max_otf_value = get_awar_max_otf

        regValue = leftShift((write_awar_max_oti_value and &H7f), 8) + leftShift((write_awar_max_otf_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_awar_max_oti_value = rightShift(data_low, 8) and &H7f
        awar_max_otf_mask = &Hff
        if data_low > LONG_MAX then
            if awar_max_otf_mask = mask then
                read_awar_max_otf_value = data_low
            else
                read_awar_max_otf_value = (data_low - H8000_0000) and awar_max_otf_mask
            end If
        else
            read_awar_max_otf_value = data_low and awar_max_otf_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_awar_max_oti_value = &H0
        flag_awar_max_oti        = &H0
        write_awar_max_otf_value = &H0
        flag_awar_max_otf        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_aw_p_pcie_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' aw_p                                       [31:24]          get_aw_p
''                                                             set_aw_p
''                                                             read_aw_p
''                                                             write_aw_p
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_aw_p_pcie_m
    Private write_aw_p_value
    Private read_aw_p_value
    Private flag_aw_p

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3118
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_aw_p
        get_aw_p = read_aw_p_value
    End Property

    Property Let set_aw_p(aData)
        write_aw_p_value = aData
        flag_aw_p        = &H1
    End Property

    Property Get read_aw_p
        read
        read_aw_p = read_aw_p_value
    End Property

    Property Let write_aw_p(aData)
        set_aw_p = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_aw_p_value = rightShift(data_low, 24) and &Hff

    End Sub

    Sub write
        If flag_aw_p = &H0 Then read
        If flag_aw_p = &H0 Then write_aw_p_value = get_aw_p

        regValue = leftShift((write_aw_p_value and &Hff), 24)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_aw_p_value = rightShift(data_low, 24) and &Hff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_aw_p_value = &H0
        flag_aw_p        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_aw_b_pcie_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' aw_b                                       [15:0]           get_aw_b
''                                                             set_aw_b
''                                                             read_aw_b
''                                                             write_aw_b
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_aw_b_pcie_m
    Private write_aw_b_value
    Private read_aw_b_value
    Private flag_aw_b

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H311c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_aw_b
        get_aw_b = read_aw_b_value
    End Property

    Property Let set_aw_b(aData)
        write_aw_b_value = aData
        flag_aw_b        = &H1
    End Property

    Property Get read_aw_b
        read
        read_aw_b = read_aw_b_value
    End Property

    Property Let write_aw_b(aData)
        set_aw_b = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        aw_b_mask = &Hffff
        if data_low > LONG_MAX then
            if aw_b_mask = mask then
                read_aw_b_value = data_low
            else
                read_aw_b_value = (data_low - H8000_0000) and aw_b_mask
            end If
        else
            read_aw_b_value = data_low and aw_b_mask
        end If

    End Sub

    Sub write
        If flag_aw_b = &H0 Then read
        If flag_aw_b = &H0 Then write_aw_b_value = get_aw_b

        regValue = leftShift((write_aw_b_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        aw_b_mask = &Hffff
        if data_low > LONG_MAX then
            if aw_b_mask = mask then
                read_aw_b_value = data_low
            else
                read_aw_b_value = (data_low - H8000_0000) and aw_b_mask
            end If
        else
            read_aw_b_value = data_low and aw_b_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_aw_b_value = &H0
        flag_aw_b        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_aw_r_pcie_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' aw_r                                       [31:20]          get_aw_r
''                                                             set_aw_r
''                                                             read_aw_r
''                                                             write_aw_r
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_aw_r_pcie_m
    Private write_aw_r_value
    Private read_aw_r_value
    Private flag_aw_r

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3120
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_aw_r
        get_aw_r = read_aw_r_value
    End Property

    Property Let set_aw_r(aData)
        write_aw_r_value = aData
        flag_aw_r        = &H1
    End Property

    Property Get read_aw_r
        read
        read_aw_r = read_aw_r_value
    End Property

    Property Let write_aw_r(aData)
        set_aw_r = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_aw_r_value = rightShift(data_low, 20) and &Hfff

    End Sub

    Sub write
        If flag_aw_r = &H0 Then read
        If flag_aw_r = &H0 Then write_aw_r_value = get_aw_r

        regValue = leftShift((write_aw_r_value and &Hfff), 20)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_aw_r_value = rightShift(data_low, 20) and &Hfff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_aw_r_value = &H0
        flag_aw_r        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_ar_p_pcie_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ar_p                                       [31:24]          get_ar_p
''                                                             set_ar_p
''                                                             read_ar_p
''                                                             write_ar_p
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_ar_p_pcie_m
    Private write_ar_p_value
    Private read_ar_p_value
    Private flag_ar_p

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3124
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ar_p
        get_ar_p = read_ar_p_value
    End Property

    Property Let set_ar_p(aData)
        write_ar_p_value = aData
        flag_ar_p        = &H1
    End Property

    Property Get read_ar_p
        read
        read_ar_p = read_ar_p_value
    End Property

    Property Let write_ar_p(aData)
        set_ar_p = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ar_p_value = rightShift(data_low, 24) and &Hff

    End Sub

    Sub write
        If flag_ar_p = &H0 Then read
        If flag_ar_p = &H0 Then write_ar_p_value = get_ar_p

        regValue = leftShift((write_ar_p_value and &Hff), 24)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ar_p_value = rightShift(data_low, 24) and &Hff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ar_p_value = &H0
        flag_ar_p        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_ar_b_pcie_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ar_b                                       [15:0]           get_ar_b
''                                                             set_ar_b
''                                                             read_ar_b
''                                                             write_ar_b
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_ar_b_pcie_m
    Private write_ar_b_value
    Private read_ar_b_value
    Private flag_ar_b

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3128
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ar_b
        get_ar_b = read_ar_b_value
    End Property

    Property Let set_ar_b(aData)
        write_ar_b_value = aData
        flag_ar_b        = &H1
    End Property

    Property Get read_ar_b
        read
        read_ar_b = read_ar_b_value
    End Property

    Property Let write_ar_b(aData)
        set_ar_b = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ar_b_mask = &Hffff
        if data_low > LONG_MAX then
            if ar_b_mask = mask then
                read_ar_b_value = data_low
            else
                read_ar_b_value = (data_low - H8000_0000) and ar_b_mask
            end If
        else
            read_ar_b_value = data_low and ar_b_mask
        end If

    End Sub

    Sub write
        If flag_ar_b = &H0 Then read
        If flag_ar_b = &H0 Then write_ar_b_value = get_ar_b

        regValue = leftShift((write_ar_b_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ar_b_mask = &Hffff
        if data_low > LONG_MAX then
            if ar_b_mask = mask then
                read_ar_b_value = data_low
            else
                read_ar_b_value = (data_low - H8000_0000) and ar_b_mask
            end If
        else
            read_ar_b_value = data_low and ar_b_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ar_b_value = &H0
        flag_ar_b        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_ar_r_pcie_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ar_r                                       [31:20]          get_ar_r
''                                                             set_ar_r
''                                                             read_ar_r
''                                                             write_ar_r
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_ar_r_pcie_m
    Private write_ar_r_value
    Private read_ar_r_value
    Private flag_ar_r

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H312c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ar_r
        get_ar_r = read_ar_r_value
    End Property

    Property Let set_ar_r(aData)
        write_ar_r_value = aData
        flag_ar_r        = &H1
    End Property

    Property Get read_ar_r
        read
        read_ar_r = read_ar_r_value
    End Property

    Property Let write_ar_r(aData)
        set_ar_r = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ar_r_value = rightShift(data_low, 20) and &Hfff

    End Sub

    Sub write
        If flag_ar_r = &H0 Then read
        If flag_ar_r = &H0 Then write_ar_r_value = get_ar_r

        regValue = leftShift((write_ar_r_value and &Hfff), 20)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ar_r_value = rightShift(data_low, 20) and &Hfff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ar_r_value = &H0
        flag_ar_r        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_target_fc_pcie_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ar_tgt_latency                             [27:16]          get_ar_tgt_latency
''                                                             set_ar_tgt_latency
''                                                             read_ar_tgt_latency
''                                                             write_ar_tgt_latency
''---------------------------------------------------------------------------------
'' aw_tgt_latency                             [11:0]           get_aw_tgt_latency
''                                                             set_aw_tgt_latency
''                                                             read_aw_tgt_latency
''                                                             write_aw_tgt_latency
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_target_fc_pcie_m
    Private write_ar_tgt_latency_value
    Private read_ar_tgt_latency_value
    Private flag_ar_tgt_latency
    Private write_aw_tgt_latency_value
    Private read_aw_tgt_latency_value
    Private flag_aw_tgt_latency

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3130
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ar_tgt_latency
        get_ar_tgt_latency = read_ar_tgt_latency_value
    End Property

    Property Let set_ar_tgt_latency(aData)
        write_ar_tgt_latency_value = aData
        flag_ar_tgt_latency        = &H1
    End Property

    Property Get read_ar_tgt_latency
        read
        read_ar_tgt_latency = read_ar_tgt_latency_value
    End Property

    Property Let write_ar_tgt_latency(aData)
        set_ar_tgt_latency = aData
        write
    End Property

    Property Get get_aw_tgt_latency
        get_aw_tgt_latency = read_aw_tgt_latency_value
    End Property

    Property Let set_aw_tgt_latency(aData)
        write_aw_tgt_latency_value = aData
        flag_aw_tgt_latency        = &H1
    End Property

    Property Get read_aw_tgt_latency
        read
        read_aw_tgt_latency = read_aw_tgt_latency_value
    End Property

    Property Let write_aw_tgt_latency(aData)
        set_aw_tgt_latency = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ar_tgt_latency_value = rightShift(data_low, 16) and &Hfff
        aw_tgt_latency_mask = &Hfff
        if data_low > LONG_MAX then
            if aw_tgt_latency_mask = mask then
                read_aw_tgt_latency_value = data_low
            else
                read_aw_tgt_latency_value = (data_low - H8000_0000) and aw_tgt_latency_mask
            end If
        else
            read_aw_tgt_latency_value = data_low and aw_tgt_latency_mask
        end If

    End Sub

    Sub write
        If flag_ar_tgt_latency = &H0 or flag_aw_tgt_latency = &H0 Then read
        If flag_ar_tgt_latency = &H0 Then write_ar_tgt_latency_value = get_ar_tgt_latency
        If flag_aw_tgt_latency = &H0 Then write_aw_tgt_latency_value = get_aw_tgt_latency

        regValue = leftShift((write_ar_tgt_latency_value and &Hfff), 16) + leftShift((write_aw_tgt_latency_value and &Hfff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ar_tgt_latency_value = rightShift(data_low, 16) and &Hfff
        aw_tgt_latency_mask = &Hfff
        if data_low > LONG_MAX then
            if aw_tgt_latency_mask = mask then
                read_aw_tgt_latency_value = data_low
            else
                read_aw_tgt_latency_value = (data_low - H8000_0000) and aw_tgt_latency_mask
            end If
        else
            read_aw_tgt_latency_value = data_low and aw_tgt_latency_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ar_tgt_latency_value = &H0
        flag_ar_tgt_latency        = &H0
        write_aw_tgt_latency_value = &H0
        flag_aw_tgt_latency        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_ki_fc_pcie_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ar_ki                                      [10:8]           get_ar_ki
''                                                             set_ar_ki
''                                                             read_ar_ki
''                                                             write_ar_ki
''---------------------------------------------------------------------------------
'' aw_ki                                      [2:0]            get_aw_ki
''                                                             set_aw_ki
''                                                             read_aw_ki
''                                                             write_aw_ki
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_ki_fc_pcie_m
    Private write_ar_ki_value
    Private read_ar_ki_value
    Private flag_ar_ki
    Private write_aw_ki_value
    Private read_aw_ki_value
    Private flag_aw_ki

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3134
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ar_ki
        get_ar_ki = read_ar_ki_value
    End Property

    Property Let set_ar_ki(aData)
        write_ar_ki_value = aData
        flag_ar_ki        = &H1
    End Property

    Property Get read_ar_ki
        read
        read_ar_ki = read_ar_ki_value
    End Property

    Property Let write_ar_ki(aData)
        set_ar_ki = aData
        write
    End Property

    Property Get get_aw_ki
        get_aw_ki = read_aw_ki_value
    End Property

    Property Let set_aw_ki(aData)
        write_aw_ki_value = aData
        flag_aw_ki        = &H1
    End Property

    Property Get read_aw_ki
        read
        read_aw_ki = read_aw_ki_value
    End Property

    Property Let write_aw_ki(aData)
        set_aw_ki = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ar_ki_value = rightShift(data_low, 8) and &H7
        aw_ki_mask = &H7
        if data_low > LONG_MAX then
            if aw_ki_mask = mask then
                read_aw_ki_value = data_low
            else
                read_aw_ki_value = (data_low - H8000_0000) and aw_ki_mask
            end If
        else
            read_aw_ki_value = data_low and aw_ki_mask
        end If

    End Sub

    Sub write
        If flag_ar_ki = &H0 or flag_aw_ki = &H0 Then read
        If flag_ar_ki = &H0 Then write_ar_ki_value = get_ar_ki
        If flag_aw_ki = &H0 Then write_aw_ki_value = get_aw_ki

        regValue = leftShift((write_ar_ki_value and &H7), 8) + leftShift((write_aw_ki_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ar_ki_value = rightShift(data_low, 8) and &H7
        aw_ki_mask = &H7
        if data_low > LONG_MAX then
            if aw_ki_mask = mask then
                read_aw_ki_value = data_low
            else
                read_aw_ki_value = (data_low - H8000_0000) and aw_ki_mask
            end If
        else
            read_aw_ki_value = data_low and aw_ki_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ar_ki_value = &H0
        flag_ar_ki        = &H0
        write_aw_ki_value = &H0
        flag_aw_ki        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_qos_range_pcie_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ar_max_qos                                 [27:24]          get_ar_max_qos
''                                                             set_ar_max_qos
''                                                             read_ar_max_qos
''                                                             write_ar_max_qos
''---------------------------------------------------------------------------------
'' ar_min_qos                                 [19:16]          get_ar_min_qos
''                                                             set_ar_min_qos
''                                                             read_ar_min_qos
''                                                             write_ar_min_qos
''---------------------------------------------------------------------------------
'' aw_max_qos                                 [11:8]           get_aw_max_qos
''                                                             set_aw_max_qos
''                                                             read_aw_max_qos
''                                                             write_aw_max_qos
''---------------------------------------------------------------------------------
'' aw_min_qos                                 [3:0]            get_aw_min_qos
''                                                             set_aw_min_qos
''                                                             read_aw_min_qos
''                                                             write_aw_min_qos
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_qos_range_pcie_m
    Private write_ar_max_qos_value
    Private read_ar_max_qos_value
    Private flag_ar_max_qos
    Private write_ar_min_qos_value
    Private read_ar_min_qos_value
    Private flag_ar_min_qos
    Private write_aw_max_qos_value
    Private read_aw_max_qos_value
    Private flag_aw_max_qos
    Private write_aw_min_qos_value
    Private read_aw_min_qos_value
    Private flag_aw_min_qos

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3138
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ar_max_qos
        get_ar_max_qos = read_ar_max_qos_value
    End Property

    Property Let set_ar_max_qos(aData)
        write_ar_max_qos_value = aData
        flag_ar_max_qos        = &H1
    End Property

    Property Get read_ar_max_qos
        read
        read_ar_max_qos = read_ar_max_qos_value
    End Property

    Property Let write_ar_max_qos(aData)
        set_ar_max_qos = aData
        write
    End Property

    Property Get get_ar_min_qos
        get_ar_min_qos = read_ar_min_qos_value
    End Property

    Property Let set_ar_min_qos(aData)
        write_ar_min_qos_value = aData
        flag_ar_min_qos        = &H1
    End Property

    Property Get read_ar_min_qos
        read
        read_ar_min_qos = read_ar_min_qos_value
    End Property

    Property Let write_ar_min_qos(aData)
        set_ar_min_qos = aData
        write
    End Property

    Property Get get_aw_max_qos
        get_aw_max_qos = read_aw_max_qos_value
    End Property

    Property Let set_aw_max_qos(aData)
        write_aw_max_qos_value = aData
        flag_aw_max_qos        = &H1
    End Property

    Property Get read_aw_max_qos
        read
        read_aw_max_qos = read_aw_max_qos_value
    End Property

    Property Let write_aw_max_qos(aData)
        set_aw_max_qos = aData
        write
    End Property

    Property Get get_aw_min_qos
        get_aw_min_qos = read_aw_min_qos_value
    End Property

    Property Let set_aw_min_qos(aData)
        write_aw_min_qos_value = aData
        flag_aw_min_qos        = &H1
    End Property

    Property Get read_aw_min_qos
        read
        read_aw_min_qos = read_aw_min_qos_value
    End Property

    Property Let write_aw_min_qos(aData)
        set_aw_min_qos = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ar_max_qos_value = rightShift(data_low, 24) and &Hf
        read_ar_min_qos_value = rightShift(data_low, 16) and &Hf
        read_aw_max_qos_value = rightShift(data_low, 8) and &Hf
        aw_min_qos_mask = &Hf
        if data_low > LONG_MAX then
            if aw_min_qos_mask = mask then
                read_aw_min_qos_value = data_low
            else
                read_aw_min_qos_value = (data_low - H8000_0000) and aw_min_qos_mask
            end If
        else
            read_aw_min_qos_value = data_low and aw_min_qos_mask
        end If

    End Sub

    Sub write
        If flag_ar_max_qos = &H0 or flag_ar_min_qos = &H0 or flag_aw_max_qos = &H0 or flag_aw_min_qos = &H0 Then read
        If flag_ar_max_qos = &H0 Then write_ar_max_qos_value = get_ar_max_qos
        If flag_ar_min_qos = &H0 Then write_ar_min_qos_value = get_ar_min_qos
        If flag_aw_max_qos = &H0 Then write_aw_max_qos_value = get_aw_max_qos
        If flag_aw_min_qos = &H0 Then write_aw_min_qos_value = get_aw_min_qos

        regValue = leftShift((write_ar_max_qos_value and &Hf), 24) + leftShift((write_ar_min_qos_value and &Hf), 16) + leftShift((write_aw_max_qos_value and &Hf), 8) + leftShift((write_aw_min_qos_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ar_max_qos_value = rightShift(data_low, 24) and &Hf
        read_ar_min_qos_value = rightShift(data_low, 16) and &Hf
        read_aw_max_qos_value = rightShift(data_low, 8) and &Hf
        aw_min_qos_mask = &Hf
        if data_low > LONG_MAX then
            if aw_min_qos_mask = mask then
                read_aw_min_qos_value = data_low
            else
                read_aw_min_qos_value = (data_low - H8000_0000) and aw_min_qos_mask
            end If
        else
            read_aw_min_qos_value = data_low and aw_min_qos_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ar_max_qos_value = &H0
        flag_ar_max_qos        = &H0
        write_ar_min_qos_value = &H0
        flag_ar_min_qos        = &H0
        write_aw_max_qos_value = &H0
        flag_aw_max_qos        = &H0
        write_aw_min_qos_value = &H0
        flag_aw_min_qos        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_fn_mod2_hsm_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' fn_mode2                                   [0:0]            get_fn_mode2
''                                                             set_fn_mode2
''                                                             read_fn_mode2
''                                                             write_fn_mode2
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_fn_mod2_hsm_m
    Private write_fn_mode2_value
    Private read_fn_mode2_value
    Private flag_fn_mode2

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H4024
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_fn_mode2
        get_fn_mode2 = read_fn_mode2_value
    End Property

    Property Let set_fn_mode2(aData)
        write_fn_mode2_value = aData
        flag_fn_mode2        = &H1
    End Property

    Property Get read_fn_mode2
        read
        read_fn_mode2 = read_fn_mode2_value
    End Property

    Property Let write_fn_mode2(aData)
        set_fn_mode2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        fn_mode2_mask = &H1
        if data_low > LONG_MAX then
            if fn_mode2_mask = mask then
                read_fn_mode2_value = data_low
            else
                read_fn_mode2_value = (data_low - H8000_0000) and fn_mode2_mask
            end If
        else
            read_fn_mode2_value = data_low and fn_mode2_mask
        end If

    End Sub

    Sub write
        If flag_fn_mode2 = &H0 Then read
        If flag_fn_mode2 = &H0 Then write_fn_mode2_value = get_fn_mode2

        regValue = leftShift((write_fn_mode2_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        fn_mode2_mask = &H1
        if data_low > LONG_MAX then
            if fn_mode2_mask = mask then
                read_fn_mode2_value = data_low
            else
                read_fn_mode2_value = (data_low - H8000_0000) and fn_mode2_mask
            end If
        else
            read_fn_mode2_value = data_low and fn_mode2_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_fn_mode2_value = &H0
        flag_fn_mode2        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_fn_mod_ahb_hsm_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' fn_mod_ahb                                 [1:0]            get_fn_mod_ahb
''                                                             set_fn_mod_ahb
''                                                             read_fn_mod_ahb
''                                                             write_fn_mod_ahb
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_fn_mod_ahb_hsm_m
    Private write_fn_mod_ahb_value
    Private read_fn_mod_ahb_value
    Private flag_fn_mod_ahb

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H4028
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_fn_mod_ahb
        get_fn_mod_ahb = read_fn_mod_ahb_value
    End Property

    Property Let set_fn_mod_ahb(aData)
        write_fn_mod_ahb_value = aData
        flag_fn_mod_ahb        = &H1
    End Property

    Property Get read_fn_mod_ahb
        read
        read_fn_mod_ahb = read_fn_mod_ahb_value
    End Property

    Property Let write_fn_mod_ahb(aData)
        set_fn_mod_ahb = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        fn_mod_ahb_mask = &H3
        if data_low > LONG_MAX then
            if fn_mod_ahb_mask = mask then
                read_fn_mod_ahb_value = data_low
            else
                read_fn_mod_ahb_value = (data_low - H8000_0000) and fn_mod_ahb_mask
            end If
        else
            read_fn_mod_ahb_value = data_low and fn_mod_ahb_mask
        end If

    End Sub

    Sub write
        If flag_fn_mod_ahb = &H0 Then read
        If flag_fn_mod_ahb = &H0 Then write_fn_mod_ahb_value = get_fn_mod_ahb

        regValue = leftShift((write_fn_mod_ahb_value and &H3), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        fn_mod_ahb_mask = &H3
        if data_low > LONG_MAX then
            if fn_mod_ahb_mask = mask then
                read_fn_mod_ahb_value = data_low
            else
                read_fn_mod_ahb_value = (data_low - H8000_0000) and fn_mod_ahb_mask
            end If
        else
            read_fn_mod_ahb_value = data_low and fn_mod_ahb_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_fn_mod_ahb_value = &H0
        flag_fn_mod_ahb        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_read_qos_hsm_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' read_qos                                   [3:0]            get_read_qos
''                                                             set_read_qos
''                                                             read_read_qos
''                                                             write_read_qos
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_read_qos_hsm_m
    Private write_read_qos_value
    Private read_read_qos_value
    Private flag_read_qos

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H4100
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_read_qos
        get_read_qos = read_read_qos_value
    End Property

    Property Let set_read_qos(aData)
        write_read_qos_value = aData
        flag_read_qos        = &H1
    End Property

    Property Get read_read_qos
        read
        read_read_qos = read_read_qos_value
    End Property

    Property Let write_read_qos(aData)
        set_read_qos = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_qos_mask = &Hf
        if data_low > LONG_MAX then
            if read_qos_mask = mask then
                read_read_qos_value = data_low
            else
                read_read_qos_value = (data_low - H8000_0000) and read_qos_mask
            end If
        else
            read_read_qos_value = data_low and read_qos_mask
        end If

    End Sub

    Sub write
        If flag_read_qos = &H0 Then read
        If flag_read_qos = &H0 Then write_read_qos_value = get_read_qos

        regValue = leftShift((write_read_qos_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_qos_mask = &Hf
        if data_low > LONG_MAX then
            if read_qos_mask = mask then
                read_read_qos_value = data_low
            else
                read_read_qos_value = (data_low - H8000_0000) and read_qos_mask
            end If
        else
            read_read_qos_value = data_low and read_qos_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_read_qos_value = &H0
        flag_read_qos        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_write_qos_hsm_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' write_qos                                  [3:0]            get_write_qos
''                                                             set_write_qos
''                                                             read_write_qos
''                                                             write_write_qos
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_write_qos_hsm_m
    Private write_write_qos_value
    Private read_write_qos_value
    Private flag_write_qos

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H4104
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_write_qos
        get_write_qos = read_write_qos_value
    End Property

    Property Let set_write_qos(aData)
        write_write_qos_value = aData
        flag_write_qos        = &H1
    End Property

    Property Get read_write_qos
        read
        read_write_qos = read_write_qos_value
    End Property

    Property Let write_write_qos(aData)
        set_write_qos = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        write_qos_mask = &Hf
        if data_low > LONG_MAX then
            if write_qos_mask = mask then
                read_write_qos_value = data_low
            else
                read_write_qos_value = (data_low - H8000_0000) and write_qos_mask
            end If
        else
            read_write_qos_value = data_low and write_qos_mask
        end If

    End Sub

    Sub write
        If flag_write_qos = &H0 Then read
        If flag_write_qos = &H0 Then write_write_qos_value = get_write_qos

        regValue = leftShift((write_write_qos_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        write_qos_mask = &Hf
        if data_low > LONG_MAX then
            if write_qos_mask = mask then
                read_write_qos_value = data_low
            else
                read_write_qos_value = (data_low - H8000_0000) and write_qos_mask
            end If
        else
            read_write_qos_value = data_low and write_qos_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_write_qos_value = &H0
        flag_write_qos        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_fn_mod_hsm_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' fn_mod                                     [1:0]            get_fn_mod
''                                                             set_fn_mod
''                                                             read_fn_mod
''                                                             write_fn_mod
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_fn_mod_hsm_m
    Private write_fn_mod_value
    Private read_fn_mod_value
    Private flag_fn_mod

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H4108
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_fn_mod
        get_fn_mod = read_fn_mod_value
    End Property

    Property Let set_fn_mod(aData)
        write_fn_mod_value = aData
        flag_fn_mod        = &H1
    End Property

    Property Get read_fn_mod
        read
        read_fn_mod = read_fn_mod_value
    End Property

    Property Let write_fn_mod(aData)
        set_fn_mod = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        fn_mod_mask = &H3
        if data_low > LONG_MAX then
            if fn_mod_mask = mask then
                read_fn_mod_value = data_low
            else
                read_fn_mod_value = (data_low - H8000_0000) and fn_mod_mask
            end If
        else
            read_fn_mod_value = data_low and fn_mod_mask
        end If

    End Sub

    Sub write
        If flag_fn_mod = &H0 Then read
        If flag_fn_mod = &H0 Then write_fn_mod_value = get_fn_mod

        regValue = leftShift((write_fn_mod_value and &H3), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        fn_mod_mask = &H3
        if data_low > LONG_MAX then
            if fn_mod_mask = mask then
                read_fn_mod_value = data_low
            else
                read_fn_mod_value = (data_low - H8000_0000) and fn_mod_mask
            end If
        else
            read_fn_mod_value = data_low and fn_mod_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_fn_mod_value = &H0
        flag_fn_mod        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_qos_cntl_hsm_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mode_ar_fc                                 [20:20]          get_mode_ar_fc
''                                                             set_mode_ar_fc
''                                                             read_mode_ar_fc
''                                                             write_mode_ar_fc
''---------------------------------------------------------------------------------
'' mode_aw_fc                                 [16:16]          get_mode_aw_fc
''                                                             set_mode_aw_fc
''                                                             read_mode_aw_fc
''                                                             write_mode_aw_fc
''---------------------------------------------------------------------------------
'' en_awar_ot                                 [7:7]            get_en_awar_ot
''                                                             set_en_awar_ot
''                                                             read_en_awar_ot
''                                                             write_en_awar_ot
''---------------------------------------------------------------------------------
'' en_ar_ot                                   [6:6]            get_en_ar_ot
''                                                             set_en_ar_ot
''                                                             read_en_ar_ot
''                                                             write_en_ar_ot
''---------------------------------------------------------------------------------
'' en_aw_ot                                   [5:5]            get_en_aw_ot
''                                                             set_en_aw_ot
''                                                             read_en_aw_ot
''                                                             write_en_aw_ot
''---------------------------------------------------------------------------------
'' en_ar_fc                                   [4:4]            get_en_ar_fc
''                                                             set_en_ar_fc
''                                                             read_en_ar_fc
''                                                             write_en_ar_fc
''---------------------------------------------------------------------------------
'' en_aw_fc                                   [3:3]            get_en_aw_fc
''                                                             set_en_aw_fc
''                                                             read_en_aw_fc
''                                                             write_en_aw_fc
''---------------------------------------------------------------------------------
'' en_awar_rate                               [2:2]            get_en_awar_rate
''                                                             set_en_awar_rate
''                                                             read_en_awar_rate
''                                                             write_en_awar_rate
''---------------------------------------------------------------------------------
'' en_ar_rate                                 [1:1]            get_en_ar_rate
''                                                             set_en_ar_rate
''                                                             read_en_ar_rate
''                                                             write_en_ar_rate
''---------------------------------------------------------------------------------
'' en_aw_rate                                 [0:0]            get_en_aw_rate
''                                                             set_en_aw_rate
''                                                             read_en_aw_rate
''                                                             write_en_aw_rate
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_qos_cntl_hsm_m
    Private write_mode_ar_fc_value
    Private read_mode_ar_fc_value
    Private flag_mode_ar_fc
    Private write_mode_aw_fc_value
    Private read_mode_aw_fc_value
    Private flag_mode_aw_fc
    Private write_en_awar_ot_value
    Private read_en_awar_ot_value
    Private flag_en_awar_ot
    Private write_en_ar_ot_value
    Private read_en_ar_ot_value
    Private flag_en_ar_ot
    Private write_en_aw_ot_value
    Private read_en_aw_ot_value
    Private flag_en_aw_ot
    Private write_en_ar_fc_value
    Private read_en_ar_fc_value
    Private flag_en_ar_fc
    Private write_en_aw_fc_value
    Private read_en_aw_fc_value
    Private flag_en_aw_fc
    Private write_en_awar_rate_value
    Private read_en_awar_rate_value
    Private flag_en_awar_rate
    Private write_en_ar_rate_value
    Private read_en_ar_rate_value
    Private flag_en_ar_rate
    Private write_en_aw_rate_value
    Private read_en_aw_rate_value
    Private flag_en_aw_rate

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H410c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mode_ar_fc
        get_mode_ar_fc = read_mode_ar_fc_value
    End Property

    Property Let set_mode_ar_fc(aData)
        write_mode_ar_fc_value = aData
        flag_mode_ar_fc        = &H1
    End Property

    Property Get read_mode_ar_fc
        read
        read_mode_ar_fc = read_mode_ar_fc_value
    End Property

    Property Let write_mode_ar_fc(aData)
        set_mode_ar_fc = aData
        write
    End Property

    Property Get get_mode_aw_fc
        get_mode_aw_fc = read_mode_aw_fc_value
    End Property

    Property Let set_mode_aw_fc(aData)
        write_mode_aw_fc_value = aData
        flag_mode_aw_fc        = &H1
    End Property

    Property Get read_mode_aw_fc
        read
        read_mode_aw_fc = read_mode_aw_fc_value
    End Property

    Property Let write_mode_aw_fc(aData)
        set_mode_aw_fc = aData
        write
    End Property

    Property Get get_en_awar_ot
        get_en_awar_ot = read_en_awar_ot_value
    End Property

    Property Let set_en_awar_ot(aData)
        write_en_awar_ot_value = aData
        flag_en_awar_ot        = &H1
    End Property

    Property Get read_en_awar_ot
        read
        read_en_awar_ot = read_en_awar_ot_value
    End Property

    Property Let write_en_awar_ot(aData)
        set_en_awar_ot = aData
        write
    End Property

    Property Get get_en_ar_ot
        get_en_ar_ot = read_en_ar_ot_value
    End Property

    Property Let set_en_ar_ot(aData)
        write_en_ar_ot_value = aData
        flag_en_ar_ot        = &H1
    End Property

    Property Get read_en_ar_ot
        read
        read_en_ar_ot = read_en_ar_ot_value
    End Property

    Property Let write_en_ar_ot(aData)
        set_en_ar_ot = aData
        write
    End Property

    Property Get get_en_aw_ot
        get_en_aw_ot = read_en_aw_ot_value
    End Property

    Property Let set_en_aw_ot(aData)
        write_en_aw_ot_value = aData
        flag_en_aw_ot        = &H1
    End Property

    Property Get read_en_aw_ot
        read
        read_en_aw_ot = read_en_aw_ot_value
    End Property

    Property Let write_en_aw_ot(aData)
        set_en_aw_ot = aData
        write
    End Property

    Property Get get_en_ar_fc
        get_en_ar_fc = read_en_ar_fc_value
    End Property

    Property Let set_en_ar_fc(aData)
        write_en_ar_fc_value = aData
        flag_en_ar_fc        = &H1
    End Property

    Property Get read_en_ar_fc
        read
        read_en_ar_fc = read_en_ar_fc_value
    End Property

    Property Let write_en_ar_fc(aData)
        set_en_ar_fc = aData
        write
    End Property

    Property Get get_en_aw_fc
        get_en_aw_fc = read_en_aw_fc_value
    End Property

    Property Let set_en_aw_fc(aData)
        write_en_aw_fc_value = aData
        flag_en_aw_fc        = &H1
    End Property

    Property Get read_en_aw_fc
        read
        read_en_aw_fc = read_en_aw_fc_value
    End Property

    Property Let write_en_aw_fc(aData)
        set_en_aw_fc = aData
        write
    End Property

    Property Get get_en_awar_rate
        get_en_awar_rate = read_en_awar_rate_value
    End Property

    Property Let set_en_awar_rate(aData)
        write_en_awar_rate_value = aData
        flag_en_awar_rate        = &H1
    End Property

    Property Get read_en_awar_rate
        read
        read_en_awar_rate = read_en_awar_rate_value
    End Property

    Property Let write_en_awar_rate(aData)
        set_en_awar_rate = aData
        write
    End Property

    Property Get get_en_ar_rate
        get_en_ar_rate = read_en_ar_rate_value
    End Property

    Property Let set_en_ar_rate(aData)
        write_en_ar_rate_value = aData
        flag_en_ar_rate        = &H1
    End Property

    Property Get read_en_ar_rate
        read
        read_en_ar_rate = read_en_ar_rate_value
    End Property

    Property Let write_en_ar_rate(aData)
        set_en_ar_rate = aData
        write
    End Property

    Property Get get_en_aw_rate
        get_en_aw_rate = read_en_aw_rate_value
    End Property

    Property Let set_en_aw_rate(aData)
        write_en_aw_rate_value = aData
        flag_en_aw_rate        = &H1
    End Property

    Property Get read_en_aw_rate
        read
        read_en_aw_rate = read_en_aw_rate_value
    End Property

    Property Let write_en_aw_rate(aData)
        set_en_aw_rate = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_mode_ar_fc_value = rightShift(data_low, 20) and &H1
        read_mode_aw_fc_value = rightShift(data_low, 16) and &H1
        read_en_awar_ot_value = rightShift(data_low, 7) and &H1
        read_en_ar_ot_value = rightShift(data_low, 6) and &H1
        read_en_aw_ot_value = rightShift(data_low, 5) and &H1
        read_en_ar_fc_value = rightShift(data_low, 4) and &H1
        read_en_aw_fc_value = rightShift(data_low, 3) and &H1
        read_en_awar_rate_value = rightShift(data_low, 2) and &H1
        read_en_ar_rate_value = rightShift(data_low, 1) and &H1
        en_aw_rate_mask = &H1
        if data_low > LONG_MAX then
            if en_aw_rate_mask = mask then
                read_en_aw_rate_value = data_low
            else
                read_en_aw_rate_value = (data_low - H8000_0000) and en_aw_rate_mask
            end If
        else
            read_en_aw_rate_value = data_low and en_aw_rate_mask
        end If

    End Sub

    Sub write
        If flag_mode_ar_fc = &H0 or flag_mode_aw_fc = &H0 or flag_en_awar_ot = &H0 or flag_en_ar_ot = &H0 or flag_en_aw_ot = &H0 or flag_en_ar_fc = &H0 or flag_en_aw_fc = &H0 or flag_en_awar_rate = &H0 or flag_en_ar_rate = &H0 or flag_en_aw_rate = &H0 Then read
        If flag_mode_ar_fc = &H0 Then write_mode_ar_fc_value = get_mode_ar_fc
        If flag_mode_aw_fc = &H0 Then write_mode_aw_fc_value = get_mode_aw_fc
        If flag_en_awar_ot = &H0 Then write_en_awar_ot_value = get_en_awar_ot
        If flag_en_ar_ot = &H0 Then write_en_ar_ot_value = get_en_ar_ot
        If flag_en_aw_ot = &H0 Then write_en_aw_ot_value = get_en_aw_ot
        If flag_en_ar_fc = &H0 Then write_en_ar_fc_value = get_en_ar_fc
        If flag_en_aw_fc = &H0 Then write_en_aw_fc_value = get_en_aw_fc
        If flag_en_awar_rate = &H0 Then write_en_awar_rate_value = get_en_awar_rate
        If flag_en_ar_rate = &H0 Then write_en_ar_rate_value = get_en_ar_rate
        If flag_en_aw_rate = &H0 Then write_en_aw_rate_value = get_en_aw_rate

        regValue = leftShift((write_mode_ar_fc_value and &H1), 20) + leftShift((write_mode_aw_fc_value and &H1), 16) + leftShift((write_en_awar_ot_value and &H1), 7) + leftShift((write_en_ar_ot_value and &H1), 6) + leftShift((write_en_aw_ot_value and &H1), 5) + leftShift((write_en_ar_fc_value and &H1), 4) + leftShift((write_en_aw_fc_value and &H1), 3) + leftShift((write_en_awar_rate_value and &H1), 2) + leftShift((write_en_ar_rate_value and &H1), 1) + leftShift((write_en_aw_rate_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_mode_ar_fc_value = rightShift(data_low, 20) and &H1
        read_mode_aw_fc_value = rightShift(data_low, 16) and &H1
        read_en_awar_ot_value = rightShift(data_low, 7) and &H1
        read_en_ar_ot_value = rightShift(data_low, 6) and &H1
        read_en_aw_ot_value = rightShift(data_low, 5) and &H1
        read_en_ar_fc_value = rightShift(data_low, 4) and &H1
        read_en_aw_fc_value = rightShift(data_low, 3) and &H1
        read_en_awar_rate_value = rightShift(data_low, 2) and &H1
        read_en_ar_rate_value = rightShift(data_low, 1) and &H1
        en_aw_rate_mask = &H1
        if data_low > LONG_MAX then
            if en_aw_rate_mask = mask then
                read_en_aw_rate_value = data_low
            else
                read_en_aw_rate_value = (data_low - H8000_0000) and en_aw_rate_mask
            end If
        else
            read_en_aw_rate_value = data_low and en_aw_rate_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mode_ar_fc_value = &H0
        flag_mode_ar_fc        = &H0
        write_mode_aw_fc_value = &H0
        flag_mode_aw_fc        = &H0
        write_en_awar_ot_value = &H0
        flag_en_awar_ot        = &H0
        write_en_ar_ot_value = &H0
        flag_en_ar_ot        = &H0
        write_en_aw_ot_value = &H0
        flag_en_aw_ot        = &H0
        write_en_ar_fc_value = &H0
        flag_en_ar_fc        = &H0
        write_en_aw_fc_value = &H0
        flag_en_aw_fc        = &H0
        write_en_awar_rate_value = &H0
        flag_en_awar_rate        = &H0
        write_en_ar_rate_value = &H0
        flag_en_ar_rate        = &H0
        write_en_aw_rate_value = &H0
        flag_en_aw_rate        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_max_ot_hsm_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ar_max_oti                                 [29:24]          get_ar_max_oti
''                                                             set_ar_max_oti
''                                                             read_ar_max_oti
''                                                             write_ar_max_oti
''---------------------------------------------------------------------------------
'' ar_max_otf                                 [23:16]          get_ar_max_otf
''                                                             set_ar_max_otf
''                                                             read_ar_max_otf
''                                                             write_ar_max_otf
''---------------------------------------------------------------------------------
'' aw_max_oti                                 [13:8]           get_aw_max_oti
''                                                             set_aw_max_oti
''                                                             read_aw_max_oti
''                                                             write_aw_max_oti
''---------------------------------------------------------------------------------
'' en_ar_ot                                   [7:0]            get_en_ar_ot
''                                                             set_en_ar_ot
''                                                             read_en_ar_ot
''                                                             write_en_ar_ot
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_max_ot_hsm_m
    Private write_ar_max_oti_value
    Private read_ar_max_oti_value
    Private flag_ar_max_oti
    Private write_ar_max_otf_value
    Private read_ar_max_otf_value
    Private flag_ar_max_otf
    Private write_aw_max_oti_value
    Private read_aw_max_oti_value
    Private flag_aw_max_oti
    Private write_en_ar_ot_value
    Private read_en_ar_ot_value
    Private flag_en_ar_ot

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H4110
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ar_max_oti
        get_ar_max_oti = read_ar_max_oti_value
    End Property

    Property Let set_ar_max_oti(aData)
        write_ar_max_oti_value = aData
        flag_ar_max_oti        = &H1
    End Property

    Property Get read_ar_max_oti
        read
        read_ar_max_oti = read_ar_max_oti_value
    End Property

    Property Let write_ar_max_oti(aData)
        set_ar_max_oti = aData
        write
    End Property

    Property Get get_ar_max_otf
        get_ar_max_otf = read_ar_max_otf_value
    End Property

    Property Let set_ar_max_otf(aData)
        write_ar_max_otf_value = aData
        flag_ar_max_otf        = &H1
    End Property

    Property Get read_ar_max_otf
        read
        read_ar_max_otf = read_ar_max_otf_value
    End Property

    Property Let write_ar_max_otf(aData)
        set_ar_max_otf = aData
        write
    End Property

    Property Get get_aw_max_oti
        get_aw_max_oti = read_aw_max_oti_value
    End Property

    Property Let set_aw_max_oti(aData)
        write_aw_max_oti_value = aData
        flag_aw_max_oti        = &H1
    End Property

    Property Get read_aw_max_oti
        read
        read_aw_max_oti = read_aw_max_oti_value
    End Property

    Property Let write_aw_max_oti(aData)
        set_aw_max_oti = aData
        write
    End Property

    Property Get get_en_ar_ot
        get_en_ar_ot = read_en_ar_ot_value
    End Property

    Property Let set_en_ar_ot(aData)
        write_en_ar_ot_value = aData
        flag_en_ar_ot        = &H1
    End Property

    Property Get read_en_ar_ot
        read
        read_en_ar_ot = read_en_ar_ot_value
    End Property

    Property Let write_en_ar_ot(aData)
        set_en_ar_ot = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ar_max_oti_value = rightShift(data_low, 24) and &H3f
        read_ar_max_otf_value = rightShift(data_low, 16) and &Hff
        read_aw_max_oti_value = rightShift(data_low, 8) and &H3f
        en_ar_ot_mask = &Hff
        if data_low > LONG_MAX then
            if en_ar_ot_mask = mask then
                read_en_ar_ot_value = data_low
            else
                read_en_ar_ot_value = (data_low - H8000_0000) and en_ar_ot_mask
            end If
        else
            read_en_ar_ot_value = data_low and en_ar_ot_mask
        end If

    End Sub

    Sub write
        If flag_ar_max_oti = &H0 or flag_ar_max_otf = &H0 or flag_aw_max_oti = &H0 or flag_en_ar_ot = &H0 Then read
        If flag_ar_max_oti = &H0 Then write_ar_max_oti_value = get_ar_max_oti
        If flag_ar_max_otf = &H0 Then write_ar_max_otf_value = get_ar_max_otf
        If flag_aw_max_oti = &H0 Then write_aw_max_oti_value = get_aw_max_oti
        If flag_en_ar_ot = &H0 Then write_en_ar_ot_value = get_en_ar_ot

        regValue = leftShift((write_ar_max_oti_value and &H3f), 24) + leftShift((write_ar_max_otf_value and &Hff), 16) + leftShift((write_aw_max_oti_value and &H3f), 8) + leftShift((write_en_ar_ot_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ar_max_oti_value = rightShift(data_low, 24) and &H3f
        read_ar_max_otf_value = rightShift(data_low, 16) and &Hff
        read_aw_max_oti_value = rightShift(data_low, 8) and &H3f
        en_ar_ot_mask = &Hff
        if data_low > LONG_MAX then
            if en_ar_ot_mask = mask then
                read_en_ar_ot_value = data_low
            else
                read_en_ar_ot_value = (data_low - H8000_0000) and en_ar_ot_mask
            end If
        else
            read_en_ar_ot_value = data_low and en_ar_ot_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ar_max_oti_value = &H0
        flag_ar_max_oti        = &H0
        write_ar_max_otf_value = &H0
        flag_ar_max_otf        = &H0
        write_aw_max_oti_value = &H0
        flag_aw_max_oti        = &H0
        write_en_ar_ot_value = &H0
        flag_en_ar_ot        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_max_comb_ot_hsm_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' awar_max_oti                               [14:8]           get_awar_max_oti
''                                                             set_awar_max_oti
''                                                             read_awar_max_oti
''                                                             write_awar_max_oti
''---------------------------------------------------------------------------------
'' awar_max_otf                               [7:0]            get_awar_max_otf
''                                                             set_awar_max_otf
''                                                             read_awar_max_otf
''                                                             write_awar_max_otf
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_max_comb_ot_hsm_m
    Private write_awar_max_oti_value
    Private read_awar_max_oti_value
    Private flag_awar_max_oti
    Private write_awar_max_otf_value
    Private read_awar_max_otf_value
    Private flag_awar_max_otf

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H4114
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_awar_max_oti
        get_awar_max_oti = read_awar_max_oti_value
    End Property

    Property Let set_awar_max_oti(aData)
        write_awar_max_oti_value = aData
        flag_awar_max_oti        = &H1
    End Property

    Property Get read_awar_max_oti
        read
        read_awar_max_oti = read_awar_max_oti_value
    End Property

    Property Let write_awar_max_oti(aData)
        set_awar_max_oti = aData
        write
    End Property

    Property Get get_awar_max_otf
        get_awar_max_otf = read_awar_max_otf_value
    End Property

    Property Let set_awar_max_otf(aData)
        write_awar_max_otf_value = aData
        flag_awar_max_otf        = &H1
    End Property

    Property Get read_awar_max_otf
        read
        read_awar_max_otf = read_awar_max_otf_value
    End Property

    Property Let write_awar_max_otf(aData)
        set_awar_max_otf = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_awar_max_oti_value = rightShift(data_low, 8) and &H7f
        awar_max_otf_mask = &Hff
        if data_low > LONG_MAX then
            if awar_max_otf_mask = mask then
                read_awar_max_otf_value = data_low
            else
                read_awar_max_otf_value = (data_low - H8000_0000) and awar_max_otf_mask
            end If
        else
            read_awar_max_otf_value = data_low and awar_max_otf_mask
        end If

    End Sub

    Sub write
        If flag_awar_max_oti = &H0 or flag_awar_max_otf = &H0 Then read
        If flag_awar_max_oti = &H0 Then write_awar_max_oti_value = get_awar_max_oti
        If flag_awar_max_otf = &H0 Then write_awar_max_otf_value = get_awar_max_otf

        regValue = leftShift((write_awar_max_oti_value and &H7f), 8) + leftShift((write_awar_max_otf_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_awar_max_oti_value = rightShift(data_low, 8) and &H7f
        awar_max_otf_mask = &Hff
        if data_low > LONG_MAX then
            if awar_max_otf_mask = mask then
                read_awar_max_otf_value = data_low
            else
                read_awar_max_otf_value = (data_low - H8000_0000) and awar_max_otf_mask
            end If
        else
            read_awar_max_otf_value = data_low and awar_max_otf_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_awar_max_oti_value = &H0
        flag_awar_max_oti        = &H0
        write_awar_max_otf_value = &H0
        flag_awar_max_otf        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_aw_p_hsm_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' aw_p                                       [31:24]          get_aw_p
''                                                             set_aw_p
''                                                             read_aw_p
''                                                             write_aw_p
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_aw_p_hsm_m
    Private write_aw_p_value
    Private read_aw_p_value
    Private flag_aw_p

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H4118
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_aw_p
        get_aw_p = read_aw_p_value
    End Property

    Property Let set_aw_p(aData)
        write_aw_p_value = aData
        flag_aw_p        = &H1
    End Property

    Property Get read_aw_p
        read
        read_aw_p = read_aw_p_value
    End Property

    Property Let write_aw_p(aData)
        set_aw_p = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_aw_p_value = rightShift(data_low, 24) and &Hff

    End Sub

    Sub write
        If flag_aw_p = &H0 Then read
        If flag_aw_p = &H0 Then write_aw_p_value = get_aw_p

        regValue = leftShift((write_aw_p_value and &Hff), 24)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_aw_p_value = rightShift(data_low, 24) and &Hff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_aw_p_value = &H0
        flag_aw_p        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_aw_b_hsm_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' aw_b                                       [15:0]           get_aw_b
''                                                             set_aw_b
''                                                             read_aw_b
''                                                             write_aw_b
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_aw_b_hsm_m
    Private write_aw_b_value
    Private read_aw_b_value
    Private flag_aw_b

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H411c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_aw_b
        get_aw_b = read_aw_b_value
    End Property

    Property Let set_aw_b(aData)
        write_aw_b_value = aData
        flag_aw_b        = &H1
    End Property

    Property Get read_aw_b
        read
        read_aw_b = read_aw_b_value
    End Property

    Property Let write_aw_b(aData)
        set_aw_b = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        aw_b_mask = &Hffff
        if data_low > LONG_MAX then
            if aw_b_mask = mask then
                read_aw_b_value = data_low
            else
                read_aw_b_value = (data_low - H8000_0000) and aw_b_mask
            end If
        else
            read_aw_b_value = data_low and aw_b_mask
        end If

    End Sub

    Sub write
        If flag_aw_b = &H0 Then read
        If flag_aw_b = &H0 Then write_aw_b_value = get_aw_b

        regValue = leftShift((write_aw_b_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        aw_b_mask = &Hffff
        if data_low > LONG_MAX then
            if aw_b_mask = mask then
                read_aw_b_value = data_low
            else
                read_aw_b_value = (data_low - H8000_0000) and aw_b_mask
            end If
        else
            read_aw_b_value = data_low and aw_b_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_aw_b_value = &H0
        flag_aw_b        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_aw_r_hsm_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' aw_r                                       [31:20]          get_aw_r
''                                                             set_aw_r
''                                                             read_aw_r
''                                                             write_aw_r
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_aw_r_hsm_m
    Private write_aw_r_value
    Private read_aw_r_value
    Private flag_aw_r

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H4120
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_aw_r
        get_aw_r = read_aw_r_value
    End Property

    Property Let set_aw_r(aData)
        write_aw_r_value = aData
        flag_aw_r        = &H1
    End Property

    Property Get read_aw_r
        read
        read_aw_r = read_aw_r_value
    End Property

    Property Let write_aw_r(aData)
        set_aw_r = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_aw_r_value = rightShift(data_low, 20) and &Hfff

    End Sub

    Sub write
        If flag_aw_r = &H0 Then read
        If flag_aw_r = &H0 Then write_aw_r_value = get_aw_r

        regValue = leftShift((write_aw_r_value and &Hfff), 20)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_aw_r_value = rightShift(data_low, 20) and &Hfff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_aw_r_value = &H0
        flag_aw_r        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_ar_p_hsm_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ar_p                                       [31:24]          get_ar_p
''                                                             set_ar_p
''                                                             read_ar_p
''                                                             write_ar_p
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_ar_p_hsm_m
    Private write_ar_p_value
    Private read_ar_p_value
    Private flag_ar_p

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H4124
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ar_p
        get_ar_p = read_ar_p_value
    End Property

    Property Let set_ar_p(aData)
        write_ar_p_value = aData
        flag_ar_p        = &H1
    End Property

    Property Get read_ar_p
        read
        read_ar_p = read_ar_p_value
    End Property

    Property Let write_ar_p(aData)
        set_ar_p = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ar_p_value = rightShift(data_low, 24) and &Hff

    End Sub

    Sub write
        If flag_ar_p = &H0 Then read
        If flag_ar_p = &H0 Then write_ar_p_value = get_ar_p

        regValue = leftShift((write_ar_p_value and &Hff), 24)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ar_p_value = rightShift(data_low, 24) and &Hff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ar_p_value = &H0
        flag_ar_p        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_ar_b_hsm_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ar_b                                       [15:0]           get_ar_b
''                                                             set_ar_b
''                                                             read_ar_b
''                                                             write_ar_b
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_ar_b_hsm_m
    Private write_ar_b_value
    Private read_ar_b_value
    Private flag_ar_b

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H4128
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ar_b
        get_ar_b = read_ar_b_value
    End Property

    Property Let set_ar_b(aData)
        write_ar_b_value = aData
        flag_ar_b        = &H1
    End Property

    Property Get read_ar_b
        read
        read_ar_b = read_ar_b_value
    End Property

    Property Let write_ar_b(aData)
        set_ar_b = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ar_b_mask = &Hffff
        if data_low > LONG_MAX then
            if ar_b_mask = mask then
                read_ar_b_value = data_low
            else
                read_ar_b_value = (data_low - H8000_0000) and ar_b_mask
            end If
        else
            read_ar_b_value = data_low and ar_b_mask
        end If

    End Sub

    Sub write
        If flag_ar_b = &H0 Then read
        If flag_ar_b = &H0 Then write_ar_b_value = get_ar_b

        regValue = leftShift((write_ar_b_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ar_b_mask = &Hffff
        if data_low > LONG_MAX then
            if ar_b_mask = mask then
                read_ar_b_value = data_low
            else
                read_ar_b_value = (data_low - H8000_0000) and ar_b_mask
            end If
        else
            read_ar_b_value = data_low and ar_b_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ar_b_value = &H0
        flag_ar_b        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_ar_r_hsm_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ar_r                                       [31:20]          get_ar_r
''                                                             set_ar_r
''                                                             read_ar_r
''                                                             write_ar_r
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_ar_r_hsm_m
    Private write_ar_r_value
    Private read_ar_r_value
    Private flag_ar_r

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H412c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ar_r
        get_ar_r = read_ar_r_value
    End Property

    Property Let set_ar_r(aData)
        write_ar_r_value = aData
        flag_ar_r        = &H1
    End Property

    Property Get read_ar_r
        read
        read_ar_r = read_ar_r_value
    End Property

    Property Let write_ar_r(aData)
        set_ar_r = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ar_r_value = rightShift(data_low, 20) and &Hfff

    End Sub

    Sub write
        If flag_ar_r = &H0 Then read
        If flag_ar_r = &H0 Then write_ar_r_value = get_ar_r

        regValue = leftShift((write_ar_r_value and &Hfff), 20)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ar_r_value = rightShift(data_low, 20) and &Hfff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ar_r_value = &H0
        flag_ar_r        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_target_fc_hsm_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ar_tgt_latency                             [27:16]          get_ar_tgt_latency
''                                                             set_ar_tgt_latency
''                                                             read_ar_tgt_latency
''                                                             write_ar_tgt_latency
''---------------------------------------------------------------------------------
'' aw_tgt_latency                             [11:0]           get_aw_tgt_latency
''                                                             set_aw_tgt_latency
''                                                             read_aw_tgt_latency
''                                                             write_aw_tgt_latency
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_target_fc_hsm_m
    Private write_ar_tgt_latency_value
    Private read_ar_tgt_latency_value
    Private flag_ar_tgt_latency
    Private write_aw_tgt_latency_value
    Private read_aw_tgt_latency_value
    Private flag_aw_tgt_latency

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H4130
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ar_tgt_latency
        get_ar_tgt_latency = read_ar_tgt_latency_value
    End Property

    Property Let set_ar_tgt_latency(aData)
        write_ar_tgt_latency_value = aData
        flag_ar_tgt_latency        = &H1
    End Property

    Property Get read_ar_tgt_latency
        read
        read_ar_tgt_latency = read_ar_tgt_latency_value
    End Property

    Property Let write_ar_tgt_latency(aData)
        set_ar_tgt_latency = aData
        write
    End Property

    Property Get get_aw_tgt_latency
        get_aw_tgt_latency = read_aw_tgt_latency_value
    End Property

    Property Let set_aw_tgt_latency(aData)
        write_aw_tgt_latency_value = aData
        flag_aw_tgt_latency        = &H1
    End Property

    Property Get read_aw_tgt_latency
        read
        read_aw_tgt_latency = read_aw_tgt_latency_value
    End Property

    Property Let write_aw_tgt_latency(aData)
        set_aw_tgt_latency = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ar_tgt_latency_value = rightShift(data_low, 16) and &Hfff
        aw_tgt_latency_mask = &Hfff
        if data_low > LONG_MAX then
            if aw_tgt_latency_mask = mask then
                read_aw_tgt_latency_value = data_low
            else
                read_aw_tgt_latency_value = (data_low - H8000_0000) and aw_tgt_latency_mask
            end If
        else
            read_aw_tgt_latency_value = data_low and aw_tgt_latency_mask
        end If

    End Sub

    Sub write
        If flag_ar_tgt_latency = &H0 or flag_aw_tgt_latency = &H0 Then read
        If flag_ar_tgt_latency = &H0 Then write_ar_tgt_latency_value = get_ar_tgt_latency
        If flag_aw_tgt_latency = &H0 Then write_aw_tgt_latency_value = get_aw_tgt_latency

        regValue = leftShift((write_ar_tgt_latency_value and &Hfff), 16) + leftShift((write_aw_tgt_latency_value and &Hfff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ar_tgt_latency_value = rightShift(data_low, 16) and &Hfff
        aw_tgt_latency_mask = &Hfff
        if data_low > LONG_MAX then
            if aw_tgt_latency_mask = mask then
                read_aw_tgt_latency_value = data_low
            else
                read_aw_tgt_latency_value = (data_low - H8000_0000) and aw_tgt_latency_mask
            end If
        else
            read_aw_tgt_latency_value = data_low and aw_tgt_latency_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ar_tgt_latency_value = &H0
        flag_ar_tgt_latency        = &H0
        write_aw_tgt_latency_value = &H0
        flag_aw_tgt_latency        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_ki_fc_hsm_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ar_ki                                      [10:8]           get_ar_ki
''                                                             set_ar_ki
''                                                             read_ar_ki
''                                                             write_ar_ki
''---------------------------------------------------------------------------------
'' aw_ki                                      [2:0]            get_aw_ki
''                                                             set_aw_ki
''                                                             read_aw_ki
''                                                             write_aw_ki
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_ki_fc_hsm_m
    Private write_ar_ki_value
    Private read_ar_ki_value
    Private flag_ar_ki
    Private write_aw_ki_value
    Private read_aw_ki_value
    Private flag_aw_ki

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H4134
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ar_ki
        get_ar_ki = read_ar_ki_value
    End Property

    Property Let set_ar_ki(aData)
        write_ar_ki_value = aData
        flag_ar_ki        = &H1
    End Property

    Property Get read_ar_ki
        read
        read_ar_ki = read_ar_ki_value
    End Property

    Property Let write_ar_ki(aData)
        set_ar_ki = aData
        write
    End Property

    Property Get get_aw_ki
        get_aw_ki = read_aw_ki_value
    End Property

    Property Let set_aw_ki(aData)
        write_aw_ki_value = aData
        flag_aw_ki        = &H1
    End Property

    Property Get read_aw_ki
        read
        read_aw_ki = read_aw_ki_value
    End Property

    Property Let write_aw_ki(aData)
        set_aw_ki = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ar_ki_value = rightShift(data_low, 8) and &H7
        aw_ki_mask = &H7
        if data_low > LONG_MAX then
            if aw_ki_mask = mask then
                read_aw_ki_value = data_low
            else
                read_aw_ki_value = (data_low - H8000_0000) and aw_ki_mask
            end If
        else
            read_aw_ki_value = data_low and aw_ki_mask
        end If

    End Sub

    Sub write
        If flag_ar_ki = &H0 or flag_aw_ki = &H0 Then read
        If flag_ar_ki = &H0 Then write_ar_ki_value = get_ar_ki
        If flag_aw_ki = &H0 Then write_aw_ki_value = get_aw_ki

        regValue = leftShift((write_ar_ki_value and &H7), 8) + leftShift((write_aw_ki_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ar_ki_value = rightShift(data_low, 8) and &H7
        aw_ki_mask = &H7
        if data_low > LONG_MAX then
            if aw_ki_mask = mask then
                read_aw_ki_value = data_low
            else
                read_aw_ki_value = (data_low - H8000_0000) and aw_ki_mask
            end If
        else
            read_aw_ki_value = data_low and aw_ki_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ar_ki_value = &H0
        flag_ar_ki        = &H0
        write_aw_ki_value = &H0
        flag_aw_ki        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_qos_range_hsm_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ar_max_qos                                 [27:24]          get_ar_max_qos
''                                                             set_ar_max_qos
''                                                             read_ar_max_qos
''                                                             write_ar_max_qos
''---------------------------------------------------------------------------------
'' ar_min_qos                                 [19:16]          get_ar_min_qos
''                                                             set_ar_min_qos
''                                                             read_ar_min_qos
''                                                             write_ar_min_qos
''---------------------------------------------------------------------------------
'' aw_max_qos                                 [11:8]           get_aw_max_qos
''                                                             set_aw_max_qos
''                                                             read_aw_max_qos
''                                                             write_aw_max_qos
''---------------------------------------------------------------------------------
'' aw_min_qos                                 [3:0]            get_aw_min_qos
''                                                             set_aw_min_qos
''                                                             read_aw_min_qos
''                                                             write_aw_min_qos
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_qos_range_hsm_m
    Private write_ar_max_qos_value
    Private read_ar_max_qos_value
    Private flag_ar_max_qos
    Private write_ar_min_qos_value
    Private read_ar_min_qos_value
    Private flag_ar_min_qos
    Private write_aw_max_qos_value
    Private read_aw_max_qos_value
    Private flag_aw_max_qos
    Private write_aw_min_qos_value
    Private read_aw_min_qos_value
    Private flag_aw_min_qos

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H4138
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ar_max_qos
        get_ar_max_qos = read_ar_max_qos_value
    End Property

    Property Let set_ar_max_qos(aData)
        write_ar_max_qos_value = aData
        flag_ar_max_qos        = &H1
    End Property

    Property Get read_ar_max_qos
        read
        read_ar_max_qos = read_ar_max_qos_value
    End Property

    Property Let write_ar_max_qos(aData)
        set_ar_max_qos = aData
        write
    End Property

    Property Get get_ar_min_qos
        get_ar_min_qos = read_ar_min_qos_value
    End Property

    Property Let set_ar_min_qos(aData)
        write_ar_min_qos_value = aData
        flag_ar_min_qos        = &H1
    End Property

    Property Get read_ar_min_qos
        read
        read_ar_min_qos = read_ar_min_qos_value
    End Property

    Property Let write_ar_min_qos(aData)
        set_ar_min_qos = aData
        write
    End Property

    Property Get get_aw_max_qos
        get_aw_max_qos = read_aw_max_qos_value
    End Property

    Property Let set_aw_max_qos(aData)
        write_aw_max_qos_value = aData
        flag_aw_max_qos        = &H1
    End Property

    Property Get read_aw_max_qos
        read
        read_aw_max_qos = read_aw_max_qos_value
    End Property

    Property Let write_aw_max_qos(aData)
        set_aw_max_qos = aData
        write
    End Property

    Property Get get_aw_min_qos
        get_aw_min_qos = read_aw_min_qos_value
    End Property

    Property Let set_aw_min_qos(aData)
        write_aw_min_qos_value = aData
        flag_aw_min_qos        = &H1
    End Property

    Property Get read_aw_min_qos
        read
        read_aw_min_qos = read_aw_min_qos_value
    End Property

    Property Let write_aw_min_qos(aData)
        set_aw_min_qos = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ar_max_qos_value = rightShift(data_low, 24) and &Hf
        read_ar_min_qos_value = rightShift(data_low, 16) and &Hf
        read_aw_max_qos_value = rightShift(data_low, 8) and &Hf
        aw_min_qos_mask = &Hf
        if data_low > LONG_MAX then
            if aw_min_qos_mask = mask then
                read_aw_min_qos_value = data_low
            else
                read_aw_min_qos_value = (data_low - H8000_0000) and aw_min_qos_mask
            end If
        else
            read_aw_min_qos_value = data_low and aw_min_qos_mask
        end If

    End Sub

    Sub write
        If flag_ar_max_qos = &H0 or flag_ar_min_qos = &H0 or flag_aw_max_qos = &H0 or flag_aw_min_qos = &H0 Then read
        If flag_ar_max_qos = &H0 Then write_ar_max_qos_value = get_ar_max_qos
        If flag_ar_min_qos = &H0 Then write_ar_min_qos_value = get_ar_min_qos
        If flag_aw_max_qos = &H0 Then write_aw_max_qos_value = get_aw_max_qos
        If flag_aw_min_qos = &H0 Then write_aw_min_qos_value = get_aw_min_qos

        regValue = leftShift((write_ar_max_qos_value and &Hf), 24) + leftShift((write_ar_min_qos_value and &Hf), 16) + leftShift((write_aw_max_qos_value and &Hf), 8) + leftShift((write_aw_min_qos_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ar_max_qos_value = rightShift(data_low, 24) and &Hf
        read_ar_min_qos_value = rightShift(data_low, 16) and &Hf
        read_aw_max_qos_value = rightShift(data_low, 8) and &Hf
        aw_min_qos_mask = &Hf
        if data_low > LONG_MAX then
            if aw_min_qos_mask = mask then
                read_aw_min_qos_value = data_low
            else
                read_aw_min_qos_value = (data_low - H8000_0000) and aw_min_qos_mask
            end If
        else
            read_aw_min_qos_value = data_low and aw_min_qos_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ar_max_qos_value = &H0
        flag_ar_max_qos        = &H0
        write_ar_min_qos_value = &H0
        flag_ar_min_qos        = &H0
        write_aw_max_qos_value = &H0
        flag_aw_max_qos        = &H0
        write_aw_min_qos_value = &H0
        flag_aw_min_qos        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_fn_mod_ahb_ind_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' fn_mod_ahb                                 [1:0]            get_fn_mod_ahb
''                                                             set_fn_mod_ahb
''                                                             read_fn_mod_ahb
''                                                             write_fn_mod_ahb
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_fn_mod_ahb_ind_m
    Private write_fn_mod_ahb_value
    Private read_fn_mod_ahb_value
    Private flag_fn_mod_ahb

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H5028
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_fn_mod_ahb
        get_fn_mod_ahb = read_fn_mod_ahb_value
    End Property

    Property Let set_fn_mod_ahb(aData)
        write_fn_mod_ahb_value = aData
        flag_fn_mod_ahb        = &H1
    End Property

    Property Get read_fn_mod_ahb
        read
        read_fn_mod_ahb = read_fn_mod_ahb_value
    End Property

    Property Let write_fn_mod_ahb(aData)
        set_fn_mod_ahb = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        fn_mod_ahb_mask = &H3
        if data_low > LONG_MAX then
            if fn_mod_ahb_mask = mask then
                read_fn_mod_ahb_value = data_low
            else
                read_fn_mod_ahb_value = (data_low - H8000_0000) and fn_mod_ahb_mask
            end If
        else
            read_fn_mod_ahb_value = data_low and fn_mod_ahb_mask
        end If

    End Sub

    Sub write
        If flag_fn_mod_ahb = &H0 Then read
        If flag_fn_mod_ahb = &H0 Then write_fn_mod_ahb_value = get_fn_mod_ahb

        regValue = leftShift((write_fn_mod_ahb_value and &H3), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        fn_mod_ahb_mask = &H3
        if data_low > LONG_MAX then
            if fn_mod_ahb_mask = mask then
                read_fn_mod_ahb_value = data_low
            else
                read_fn_mod_ahb_value = (data_low - H8000_0000) and fn_mod_ahb_mask
            end If
        else
            read_fn_mod_ahb_value = data_low and fn_mod_ahb_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_fn_mod_ahb_value = &H0
        flag_fn_mod_ahb        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_read_qos_ind_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' read_qos                                   [3:0]            get_read_qos
''                                                             set_read_qos
''                                                             read_read_qos
''                                                             write_read_qos
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_read_qos_ind_m
    Private write_read_qos_value
    Private read_read_qos_value
    Private flag_read_qos

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H5100
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_read_qos
        get_read_qos = read_read_qos_value
    End Property

    Property Let set_read_qos(aData)
        write_read_qos_value = aData
        flag_read_qos        = &H1
    End Property

    Property Get read_read_qos
        read
        read_read_qos = read_read_qos_value
    End Property

    Property Let write_read_qos(aData)
        set_read_qos = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_qos_mask = &Hf
        if data_low > LONG_MAX then
            if read_qos_mask = mask then
                read_read_qos_value = data_low
            else
                read_read_qos_value = (data_low - H8000_0000) and read_qos_mask
            end If
        else
            read_read_qos_value = data_low and read_qos_mask
        end If

    End Sub

    Sub write
        If flag_read_qos = &H0 Then read
        If flag_read_qos = &H0 Then write_read_qos_value = get_read_qos

        regValue = leftShift((write_read_qos_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_qos_mask = &Hf
        if data_low > LONG_MAX then
            if read_qos_mask = mask then
                read_read_qos_value = data_low
            else
                read_read_qos_value = (data_low - H8000_0000) and read_qos_mask
            end If
        else
            read_read_qos_value = data_low and read_qos_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_read_qos_value = &H0
        flag_read_qos        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_write_qos_ind_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' write_qos                                  [3:0]            get_write_qos
''                                                             set_write_qos
''                                                             read_write_qos
''                                                             write_write_qos
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_write_qos_ind_m
    Private write_write_qos_value
    Private read_write_qos_value
    Private flag_write_qos

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H5104
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_write_qos
        get_write_qos = read_write_qos_value
    End Property

    Property Let set_write_qos(aData)
        write_write_qos_value = aData
        flag_write_qos        = &H1
    End Property

    Property Get read_write_qos
        read
        read_write_qos = read_write_qos_value
    End Property

    Property Let write_write_qos(aData)
        set_write_qos = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        write_qos_mask = &Hf
        if data_low > LONG_MAX then
            if write_qos_mask = mask then
                read_write_qos_value = data_low
            else
                read_write_qos_value = (data_low - H8000_0000) and write_qos_mask
            end If
        else
            read_write_qos_value = data_low and write_qos_mask
        end If

    End Sub

    Sub write
        If flag_write_qos = &H0 Then read
        If flag_write_qos = &H0 Then write_write_qos_value = get_write_qos

        regValue = leftShift((write_write_qos_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        write_qos_mask = &Hf
        if data_low > LONG_MAX then
            if write_qos_mask = mask then
                read_write_qos_value = data_low
            else
                read_write_qos_value = (data_low - H8000_0000) and write_qos_mask
            end If
        else
            read_write_qos_value = data_low and write_qos_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_write_qos_value = &H0
        flag_write_qos        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_fn_mod_ind_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' fn_mod                                     [1:0]            get_fn_mod
''                                                             set_fn_mod
''                                                             read_fn_mod
''                                                             write_fn_mod
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_fn_mod_ind_m
    Private write_fn_mod_value
    Private read_fn_mod_value
    Private flag_fn_mod

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H5108
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_fn_mod
        get_fn_mod = read_fn_mod_value
    End Property

    Property Let set_fn_mod(aData)
        write_fn_mod_value = aData
        flag_fn_mod        = &H1
    End Property

    Property Get read_fn_mod
        read
        read_fn_mod = read_fn_mod_value
    End Property

    Property Let write_fn_mod(aData)
        set_fn_mod = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        fn_mod_mask = &H3
        if data_low > LONG_MAX then
            if fn_mod_mask = mask then
                read_fn_mod_value = data_low
            else
                read_fn_mod_value = (data_low - H8000_0000) and fn_mod_mask
            end If
        else
            read_fn_mod_value = data_low and fn_mod_mask
        end If

    End Sub

    Sub write
        If flag_fn_mod = &H0 Then read
        If flag_fn_mod = &H0 Then write_fn_mod_value = get_fn_mod

        regValue = leftShift((write_fn_mod_value and &H3), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        fn_mod_mask = &H3
        if data_low > LONG_MAX then
            if fn_mod_mask = mask then
                read_fn_mod_value = data_low
            else
                read_fn_mod_value = (data_low - H8000_0000) and fn_mod_mask
            end If
        else
            read_fn_mod_value = data_low and fn_mod_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_fn_mod_value = &H0
        flag_fn_mod        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_qos_cntl_ind_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mode_ar_fc                                 [20:20]          get_mode_ar_fc
''                                                             set_mode_ar_fc
''                                                             read_mode_ar_fc
''                                                             write_mode_ar_fc
''---------------------------------------------------------------------------------
'' mode_aw_fc                                 [16:16]          get_mode_aw_fc
''                                                             set_mode_aw_fc
''                                                             read_mode_aw_fc
''                                                             write_mode_aw_fc
''---------------------------------------------------------------------------------
'' en_awar_ot                                 [7:7]            get_en_awar_ot
''                                                             set_en_awar_ot
''                                                             read_en_awar_ot
''                                                             write_en_awar_ot
''---------------------------------------------------------------------------------
'' en_ar_ot                                   [6:6]            get_en_ar_ot
''                                                             set_en_ar_ot
''                                                             read_en_ar_ot
''                                                             write_en_ar_ot
''---------------------------------------------------------------------------------
'' en_aw_ot                                   [5:5]            get_en_aw_ot
''                                                             set_en_aw_ot
''                                                             read_en_aw_ot
''                                                             write_en_aw_ot
''---------------------------------------------------------------------------------
'' en_ar_fc                                   [4:4]            get_en_ar_fc
''                                                             set_en_ar_fc
''                                                             read_en_ar_fc
''                                                             write_en_ar_fc
''---------------------------------------------------------------------------------
'' en_aw_fc                                   [3:3]            get_en_aw_fc
''                                                             set_en_aw_fc
''                                                             read_en_aw_fc
''                                                             write_en_aw_fc
''---------------------------------------------------------------------------------
'' en_awar_rate                               [2:2]            get_en_awar_rate
''                                                             set_en_awar_rate
''                                                             read_en_awar_rate
''                                                             write_en_awar_rate
''---------------------------------------------------------------------------------
'' en_ar_rate                                 [1:1]            get_en_ar_rate
''                                                             set_en_ar_rate
''                                                             read_en_ar_rate
''                                                             write_en_ar_rate
''---------------------------------------------------------------------------------
'' en_aw_rate                                 [0:0]            get_en_aw_rate
''                                                             set_en_aw_rate
''                                                             read_en_aw_rate
''                                                             write_en_aw_rate
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_qos_cntl_ind_m
    Private write_mode_ar_fc_value
    Private read_mode_ar_fc_value
    Private flag_mode_ar_fc
    Private write_mode_aw_fc_value
    Private read_mode_aw_fc_value
    Private flag_mode_aw_fc
    Private write_en_awar_ot_value
    Private read_en_awar_ot_value
    Private flag_en_awar_ot
    Private write_en_ar_ot_value
    Private read_en_ar_ot_value
    Private flag_en_ar_ot
    Private write_en_aw_ot_value
    Private read_en_aw_ot_value
    Private flag_en_aw_ot
    Private write_en_ar_fc_value
    Private read_en_ar_fc_value
    Private flag_en_ar_fc
    Private write_en_aw_fc_value
    Private read_en_aw_fc_value
    Private flag_en_aw_fc
    Private write_en_awar_rate_value
    Private read_en_awar_rate_value
    Private flag_en_awar_rate
    Private write_en_ar_rate_value
    Private read_en_ar_rate_value
    Private flag_en_ar_rate
    Private write_en_aw_rate_value
    Private read_en_aw_rate_value
    Private flag_en_aw_rate

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H510c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mode_ar_fc
        get_mode_ar_fc = read_mode_ar_fc_value
    End Property

    Property Let set_mode_ar_fc(aData)
        write_mode_ar_fc_value = aData
        flag_mode_ar_fc        = &H1
    End Property

    Property Get read_mode_ar_fc
        read
        read_mode_ar_fc = read_mode_ar_fc_value
    End Property

    Property Let write_mode_ar_fc(aData)
        set_mode_ar_fc = aData
        write
    End Property

    Property Get get_mode_aw_fc
        get_mode_aw_fc = read_mode_aw_fc_value
    End Property

    Property Let set_mode_aw_fc(aData)
        write_mode_aw_fc_value = aData
        flag_mode_aw_fc        = &H1
    End Property

    Property Get read_mode_aw_fc
        read
        read_mode_aw_fc = read_mode_aw_fc_value
    End Property

    Property Let write_mode_aw_fc(aData)
        set_mode_aw_fc = aData
        write
    End Property

    Property Get get_en_awar_ot
        get_en_awar_ot = read_en_awar_ot_value
    End Property

    Property Let set_en_awar_ot(aData)
        write_en_awar_ot_value = aData
        flag_en_awar_ot        = &H1
    End Property

    Property Get read_en_awar_ot
        read
        read_en_awar_ot = read_en_awar_ot_value
    End Property

    Property Let write_en_awar_ot(aData)
        set_en_awar_ot = aData
        write
    End Property

    Property Get get_en_ar_ot
        get_en_ar_ot = read_en_ar_ot_value
    End Property

    Property Let set_en_ar_ot(aData)
        write_en_ar_ot_value = aData
        flag_en_ar_ot        = &H1
    End Property

    Property Get read_en_ar_ot
        read
        read_en_ar_ot = read_en_ar_ot_value
    End Property

    Property Let write_en_ar_ot(aData)
        set_en_ar_ot = aData
        write
    End Property

    Property Get get_en_aw_ot
        get_en_aw_ot = read_en_aw_ot_value
    End Property

    Property Let set_en_aw_ot(aData)
        write_en_aw_ot_value = aData
        flag_en_aw_ot        = &H1
    End Property

    Property Get read_en_aw_ot
        read
        read_en_aw_ot = read_en_aw_ot_value
    End Property

    Property Let write_en_aw_ot(aData)
        set_en_aw_ot = aData
        write
    End Property

    Property Get get_en_ar_fc
        get_en_ar_fc = read_en_ar_fc_value
    End Property

    Property Let set_en_ar_fc(aData)
        write_en_ar_fc_value = aData
        flag_en_ar_fc        = &H1
    End Property

    Property Get read_en_ar_fc
        read
        read_en_ar_fc = read_en_ar_fc_value
    End Property

    Property Let write_en_ar_fc(aData)
        set_en_ar_fc = aData
        write
    End Property

    Property Get get_en_aw_fc
        get_en_aw_fc = read_en_aw_fc_value
    End Property

    Property Let set_en_aw_fc(aData)
        write_en_aw_fc_value = aData
        flag_en_aw_fc        = &H1
    End Property

    Property Get read_en_aw_fc
        read
        read_en_aw_fc = read_en_aw_fc_value
    End Property

    Property Let write_en_aw_fc(aData)
        set_en_aw_fc = aData
        write
    End Property

    Property Get get_en_awar_rate
        get_en_awar_rate = read_en_awar_rate_value
    End Property

    Property Let set_en_awar_rate(aData)
        write_en_awar_rate_value = aData
        flag_en_awar_rate        = &H1
    End Property

    Property Get read_en_awar_rate
        read
        read_en_awar_rate = read_en_awar_rate_value
    End Property

    Property Let write_en_awar_rate(aData)
        set_en_awar_rate = aData
        write
    End Property

    Property Get get_en_ar_rate
        get_en_ar_rate = read_en_ar_rate_value
    End Property

    Property Let set_en_ar_rate(aData)
        write_en_ar_rate_value = aData
        flag_en_ar_rate        = &H1
    End Property

    Property Get read_en_ar_rate
        read
        read_en_ar_rate = read_en_ar_rate_value
    End Property

    Property Let write_en_ar_rate(aData)
        set_en_ar_rate = aData
        write
    End Property

    Property Get get_en_aw_rate
        get_en_aw_rate = read_en_aw_rate_value
    End Property

    Property Let set_en_aw_rate(aData)
        write_en_aw_rate_value = aData
        flag_en_aw_rate        = &H1
    End Property

    Property Get read_en_aw_rate
        read
        read_en_aw_rate = read_en_aw_rate_value
    End Property

    Property Let write_en_aw_rate(aData)
        set_en_aw_rate = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_mode_ar_fc_value = rightShift(data_low, 20) and &H1
        read_mode_aw_fc_value = rightShift(data_low, 16) and &H1
        read_en_awar_ot_value = rightShift(data_low, 7) and &H1
        read_en_ar_ot_value = rightShift(data_low, 6) and &H1
        read_en_aw_ot_value = rightShift(data_low, 5) and &H1
        read_en_ar_fc_value = rightShift(data_low, 4) and &H1
        read_en_aw_fc_value = rightShift(data_low, 3) and &H1
        read_en_awar_rate_value = rightShift(data_low, 2) and &H1
        read_en_ar_rate_value = rightShift(data_low, 1) and &H1
        en_aw_rate_mask = &H1
        if data_low > LONG_MAX then
            if en_aw_rate_mask = mask then
                read_en_aw_rate_value = data_low
            else
                read_en_aw_rate_value = (data_low - H8000_0000) and en_aw_rate_mask
            end If
        else
            read_en_aw_rate_value = data_low and en_aw_rate_mask
        end If

    End Sub

    Sub write
        If flag_mode_ar_fc = &H0 or flag_mode_aw_fc = &H0 or flag_en_awar_ot = &H0 or flag_en_ar_ot = &H0 or flag_en_aw_ot = &H0 or flag_en_ar_fc = &H0 or flag_en_aw_fc = &H0 or flag_en_awar_rate = &H0 or flag_en_ar_rate = &H0 or flag_en_aw_rate = &H0 Then read
        If flag_mode_ar_fc = &H0 Then write_mode_ar_fc_value = get_mode_ar_fc
        If flag_mode_aw_fc = &H0 Then write_mode_aw_fc_value = get_mode_aw_fc
        If flag_en_awar_ot = &H0 Then write_en_awar_ot_value = get_en_awar_ot
        If flag_en_ar_ot = &H0 Then write_en_ar_ot_value = get_en_ar_ot
        If flag_en_aw_ot = &H0 Then write_en_aw_ot_value = get_en_aw_ot
        If flag_en_ar_fc = &H0 Then write_en_ar_fc_value = get_en_ar_fc
        If flag_en_aw_fc = &H0 Then write_en_aw_fc_value = get_en_aw_fc
        If flag_en_awar_rate = &H0 Then write_en_awar_rate_value = get_en_awar_rate
        If flag_en_ar_rate = &H0 Then write_en_ar_rate_value = get_en_ar_rate
        If flag_en_aw_rate = &H0 Then write_en_aw_rate_value = get_en_aw_rate

        regValue = leftShift((write_mode_ar_fc_value and &H1), 20) + leftShift((write_mode_aw_fc_value and &H1), 16) + leftShift((write_en_awar_ot_value and &H1), 7) + leftShift((write_en_ar_ot_value and &H1), 6) + leftShift((write_en_aw_ot_value and &H1), 5) + leftShift((write_en_ar_fc_value and &H1), 4) + leftShift((write_en_aw_fc_value and &H1), 3) + leftShift((write_en_awar_rate_value and &H1), 2) + leftShift((write_en_ar_rate_value and &H1), 1) + leftShift((write_en_aw_rate_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_mode_ar_fc_value = rightShift(data_low, 20) and &H1
        read_mode_aw_fc_value = rightShift(data_low, 16) and &H1
        read_en_awar_ot_value = rightShift(data_low, 7) and &H1
        read_en_ar_ot_value = rightShift(data_low, 6) and &H1
        read_en_aw_ot_value = rightShift(data_low, 5) and &H1
        read_en_ar_fc_value = rightShift(data_low, 4) and &H1
        read_en_aw_fc_value = rightShift(data_low, 3) and &H1
        read_en_awar_rate_value = rightShift(data_low, 2) and &H1
        read_en_ar_rate_value = rightShift(data_low, 1) and &H1
        en_aw_rate_mask = &H1
        if data_low > LONG_MAX then
            if en_aw_rate_mask = mask then
                read_en_aw_rate_value = data_low
            else
                read_en_aw_rate_value = (data_low - H8000_0000) and en_aw_rate_mask
            end If
        else
            read_en_aw_rate_value = data_low and en_aw_rate_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mode_ar_fc_value = &H0
        flag_mode_ar_fc        = &H0
        write_mode_aw_fc_value = &H0
        flag_mode_aw_fc        = &H0
        write_en_awar_ot_value = &H0
        flag_en_awar_ot        = &H0
        write_en_ar_ot_value = &H0
        flag_en_ar_ot        = &H0
        write_en_aw_ot_value = &H0
        flag_en_aw_ot        = &H0
        write_en_ar_fc_value = &H0
        flag_en_ar_fc        = &H0
        write_en_aw_fc_value = &H0
        flag_en_aw_fc        = &H0
        write_en_awar_rate_value = &H0
        flag_en_awar_rate        = &H0
        write_en_ar_rate_value = &H0
        flag_en_ar_rate        = &H0
        write_en_aw_rate_value = &H0
        flag_en_aw_rate        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_max_ot_ind_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ar_max_oti                                 [29:24]          get_ar_max_oti
''                                                             set_ar_max_oti
''                                                             read_ar_max_oti
''                                                             write_ar_max_oti
''---------------------------------------------------------------------------------
'' ar_max_otf                                 [23:16]          get_ar_max_otf
''                                                             set_ar_max_otf
''                                                             read_ar_max_otf
''                                                             write_ar_max_otf
''---------------------------------------------------------------------------------
'' aw_max_oti                                 [13:8]           get_aw_max_oti
''                                                             set_aw_max_oti
''                                                             read_aw_max_oti
''                                                             write_aw_max_oti
''---------------------------------------------------------------------------------
'' en_ar_ot                                   [7:0]            get_en_ar_ot
''                                                             set_en_ar_ot
''                                                             read_en_ar_ot
''                                                             write_en_ar_ot
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_max_ot_ind_m
    Private write_ar_max_oti_value
    Private read_ar_max_oti_value
    Private flag_ar_max_oti
    Private write_ar_max_otf_value
    Private read_ar_max_otf_value
    Private flag_ar_max_otf
    Private write_aw_max_oti_value
    Private read_aw_max_oti_value
    Private flag_aw_max_oti
    Private write_en_ar_ot_value
    Private read_en_ar_ot_value
    Private flag_en_ar_ot

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H5110
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ar_max_oti
        get_ar_max_oti = read_ar_max_oti_value
    End Property

    Property Let set_ar_max_oti(aData)
        write_ar_max_oti_value = aData
        flag_ar_max_oti        = &H1
    End Property

    Property Get read_ar_max_oti
        read
        read_ar_max_oti = read_ar_max_oti_value
    End Property

    Property Let write_ar_max_oti(aData)
        set_ar_max_oti = aData
        write
    End Property

    Property Get get_ar_max_otf
        get_ar_max_otf = read_ar_max_otf_value
    End Property

    Property Let set_ar_max_otf(aData)
        write_ar_max_otf_value = aData
        flag_ar_max_otf        = &H1
    End Property

    Property Get read_ar_max_otf
        read
        read_ar_max_otf = read_ar_max_otf_value
    End Property

    Property Let write_ar_max_otf(aData)
        set_ar_max_otf = aData
        write
    End Property

    Property Get get_aw_max_oti
        get_aw_max_oti = read_aw_max_oti_value
    End Property

    Property Let set_aw_max_oti(aData)
        write_aw_max_oti_value = aData
        flag_aw_max_oti        = &H1
    End Property

    Property Get read_aw_max_oti
        read
        read_aw_max_oti = read_aw_max_oti_value
    End Property

    Property Let write_aw_max_oti(aData)
        set_aw_max_oti = aData
        write
    End Property

    Property Get get_en_ar_ot
        get_en_ar_ot = read_en_ar_ot_value
    End Property

    Property Let set_en_ar_ot(aData)
        write_en_ar_ot_value = aData
        flag_en_ar_ot        = &H1
    End Property

    Property Get read_en_ar_ot
        read
        read_en_ar_ot = read_en_ar_ot_value
    End Property

    Property Let write_en_ar_ot(aData)
        set_en_ar_ot = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ar_max_oti_value = rightShift(data_low, 24) and &H3f
        read_ar_max_otf_value = rightShift(data_low, 16) and &Hff
        read_aw_max_oti_value = rightShift(data_low, 8) and &H3f
        en_ar_ot_mask = &Hff
        if data_low > LONG_MAX then
            if en_ar_ot_mask = mask then
                read_en_ar_ot_value = data_low
            else
                read_en_ar_ot_value = (data_low - H8000_0000) and en_ar_ot_mask
            end If
        else
            read_en_ar_ot_value = data_low and en_ar_ot_mask
        end If

    End Sub

    Sub write
        If flag_ar_max_oti = &H0 or flag_ar_max_otf = &H0 or flag_aw_max_oti = &H0 or flag_en_ar_ot = &H0 Then read
        If flag_ar_max_oti = &H0 Then write_ar_max_oti_value = get_ar_max_oti
        If flag_ar_max_otf = &H0 Then write_ar_max_otf_value = get_ar_max_otf
        If flag_aw_max_oti = &H0 Then write_aw_max_oti_value = get_aw_max_oti
        If flag_en_ar_ot = &H0 Then write_en_ar_ot_value = get_en_ar_ot

        regValue = leftShift((write_ar_max_oti_value and &H3f), 24) + leftShift((write_ar_max_otf_value and &Hff), 16) + leftShift((write_aw_max_oti_value and &H3f), 8) + leftShift((write_en_ar_ot_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ar_max_oti_value = rightShift(data_low, 24) and &H3f
        read_ar_max_otf_value = rightShift(data_low, 16) and &Hff
        read_aw_max_oti_value = rightShift(data_low, 8) and &H3f
        en_ar_ot_mask = &Hff
        if data_low > LONG_MAX then
            if en_ar_ot_mask = mask then
                read_en_ar_ot_value = data_low
            else
                read_en_ar_ot_value = (data_low - H8000_0000) and en_ar_ot_mask
            end If
        else
            read_en_ar_ot_value = data_low and en_ar_ot_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ar_max_oti_value = &H0
        flag_ar_max_oti        = &H0
        write_ar_max_otf_value = &H0
        flag_ar_max_otf        = &H0
        write_aw_max_oti_value = &H0
        flag_aw_max_oti        = &H0
        write_en_ar_ot_value = &H0
        flag_en_ar_ot        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_max_comb_ot_ind_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' awar_max_oti                               [14:8]           get_awar_max_oti
''                                                             set_awar_max_oti
''                                                             read_awar_max_oti
''                                                             write_awar_max_oti
''---------------------------------------------------------------------------------
'' awar_max_otf                               [7:0]            get_awar_max_otf
''                                                             set_awar_max_otf
''                                                             read_awar_max_otf
''                                                             write_awar_max_otf
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_max_comb_ot_ind_m
    Private write_awar_max_oti_value
    Private read_awar_max_oti_value
    Private flag_awar_max_oti
    Private write_awar_max_otf_value
    Private read_awar_max_otf_value
    Private flag_awar_max_otf

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H5114
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_awar_max_oti
        get_awar_max_oti = read_awar_max_oti_value
    End Property

    Property Let set_awar_max_oti(aData)
        write_awar_max_oti_value = aData
        flag_awar_max_oti        = &H1
    End Property

    Property Get read_awar_max_oti
        read
        read_awar_max_oti = read_awar_max_oti_value
    End Property

    Property Let write_awar_max_oti(aData)
        set_awar_max_oti = aData
        write
    End Property

    Property Get get_awar_max_otf
        get_awar_max_otf = read_awar_max_otf_value
    End Property

    Property Let set_awar_max_otf(aData)
        write_awar_max_otf_value = aData
        flag_awar_max_otf        = &H1
    End Property

    Property Get read_awar_max_otf
        read
        read_awar_max_otf = read_awar_max_otf_value
    End Property

    Property Let write_awar_max_otf(aData)
        set_awar_max_otf = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_awar_max_oti_value = rightShift(data_low, 8) and &H7f
        awar_max_otf_mask = &Hff
        if data_low > LONG_MAX then
            if awar_max_otf_mask = mask then
                read_awar_max_otf_value = data_low
            else
                read_awar_max_otf_value = (data_low - H8000_0000) and awar_max_otf_mask
            end If
        else
            read_awar_max_otf_value = data_low and awar_max_otf_mask
        end If

    End Sub

    Sub write
        If flag_awar_max_oti = &H0 or flag_awar_max_otf = &H0 Then read
        If flag_awar_max_oti = &H0 Then write_awar_max_oti_value = get_awar_max_oti
        If flag_awar_max_otf = &H0 Then write_awar_max_otf_value = get_awar_max_otf

        regValue = leftShift((write_awar_max_oti_value and &H7f), 8) + leftShift((write_awar_max_otf_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_awar_max_oti_value = rightShift(data_low, 8) and &H7f
        awar_max_otf_mask = &Hff
        if data_low > LONG_MAX then
            if awar_max_otf_mask = mask then
                read_awar_max_otf_value = data_low
            else
                read_awar_max_otf_value = (data_low - H8000_0000) and awar_max_otf_mask
            end If
        else
            read_awar_max_otf_value = data_low and awar_max_otf_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_awar_max_oti_value = &H0
        flag_awar_max_oti        = &H0
        write_awar_max_otf_value = &H0
        flag_awar_max_otf        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_aw_p_ind_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' aw_p                                       [31:24]          get_aw_p
''                                                             set_aw_p
''                                                             read_aw_p
''                                                             write_aw_p
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_aw_p_ind_m
    Private write_aw_p_value
    Private read_aw_p_value
    Private flag_aw_p

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H5118
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_aw_p
        get_aw_p = read_aw_p_value
    End Property

    Property Let set_aw_p(aData)
        write_aw_p_value = aData
        flag_aw_p        = &H1
    End Property

    Property Get read_aw_p
        read
        read_aw_p = read_aw_p_value
    End Property

    Property Let write_aw_p(aData)
        set_aw_p = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_aw_p_value = rightShift(data_low, 24) and &Hff

    End Sub

    Sub write
        If flag_aw_p = &H0 Then read
        If flag_aw_p = &H0 Then write_aw_p_value = get_aw_p

        regValue = leftShift((write_aw_p_value and &Hff), 24)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_aw_p_value = rightShift(data_low, 24) and &Hff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_aw_p_value = &H0
        flag_aw_p        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_aw_b_ind_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' aw_b                                       [15:0]           get_aw_b
''                                                             set_aw_b
''                                                             read_aw_b
''                                                             write_aw_b
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_aw_b_ind_m
    Private write_aw_b_value
    Private read_aw_b_value
    Private flag_aw_b

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H511c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_aw_b
        get_aw_b = read_aw_b_value
    End Property

    Property Let set_aw_b(aData)
        write_aw_b_value = aData
        flag_aw_b        = &H1
    End Property

    Property Get read_aw_b
        read
        read_aw_b = read_aw_b_value
    End Property

    Property Let write_aw_b(aData)
        set_aw_b = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        aw_b_mask = &Hffff
        if data_low > LONG_MAX then
            if aw_b_mask = mask then
                read_aw_b_value = data_low
            else
                read_aw_b_value = (data_low - H8000_0000) and aw_b_mask
            end If
        else
            read_aw_b_value = data_low and aw_b_mask
        end If

    End Sub

    Sub write
        If flag_aw_b = &H0 Then read
        If flag_aw_b = &H0 Then write_aw_b_value = get_aw_b

        regValue = leftShift((write_aw_b_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        aw_b_mask = &Hffff
        if data_low > LONG_MAX then
            if aw_b_mask = mask then
                read_aw_b_value = data_low
            else
                read_aw_b_value = (data_low - H8000_0000) and aw_b_mask
            end If
        else
            read_aw_b_value = data_low and aw_b_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_aw_b_value = &H0
        flag_aw_b        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_aw_r_ind_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' aw_r                                       [31:20]          get_aw_r
''                                                             set_aw_r
''                                                             read_aw_r
''                                                             write_aw_r
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_aw_r_ind_m
    Private write_aw_r_value
    Private read_aw_r_value
    Private flag_aw_r

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H5120
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_aw_r
        get_aw_r = read_aw_r_value
    End Property

    Property Let set_aw_r(aData)
        write_aw_r_value = aData
        flag_aw_r        = &H1
    End Property

    Property Get read_aw_r
        read
        read_aw_r = read_aw_r_value
    End Property

    Property Let write_aw_r(aData)
        set_aw_r = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_aw_r_value = rightShift(data_low, 20) and &Hfff

    End Sub

    Sub write
        If flag_aw_r = &H0 Then read
        If flag_aw_r = &H0 Then write_aw_r_value = get_aw_r

        regValue = leftShift((write_aw_r_value and &Hfff), 20)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_aw_r_value = rightShift(data_low, 20) and &Hfff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_aw_r_value = &H0
        flag_aw_r        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_ar_p_ind_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ar_p                                       [31:24]          get_ar_p
''                                                             set_ar_p
''                                                             read_ar_p
''                                                             write_ar_p
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_ar_p_ind_m
    Private write_ar_p_value
    Private read_ar_p_value
    Private flag_ar_p

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H5124
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ar_p
        get_ar_p = read_ar_p_value
    End Property

    Property Let set_ar_p(aData)
        write_ar_p_value = aData
        flag_ar_p        = &H1
    End Property

    Property Get read_ar_p
        read
        read_ar_p = read_ar_p_value
    End Property

    Property Let write_ar_p(aData)
        set_ar_p = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ar_p_value = rightShift(data_low, 24) and &Hff

    End Sub

    Sub write
        If flag_ar_p = &H0 Then read
        If flag_ar_p = &H0 Then write_ar_p_value = get_ar_p

        regValue = leftShift((write_ar_p_value and &Hff), 24)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ar_p_value = rightShift(data_low, 24) and &Hff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ar_p_value = &H0
        flag_ar_p        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_ar_b_ind_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ar_b                                       [15:0]           get_ar_b
''                                                             set_ar_b
''                                                             read_ar_b
''                                                             write_ar_b
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_ar_b_ind_m
    Private write_ar_b_value
    Private read_ar_b_value
    Private flag_ar_b

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H5128
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ar_b
        get_ar_b = read_ar_b_value
    End Property

    Property Let set_ar_b(aData)
        write_ar_b_value = aData
        flag_ar_b        = &H1
    End Property

    Property Get read_ar_b
        read
        read_ar_b = read_ar_b_value
    End Property

    Property Let write_ar_b(aData)
        set_ar_b = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ar_b_mask = &Hffff
        if data_low > LONG_MAX then
            if ar_b_mask = mask then
                read_ar_b_value = data_low
            else
                read_ar_b_value = (data_low - H8000_0000) and ar_b_mask
            end If
        else
            read_ar_b_value = data_low and ar_b_mask
        end If

    End Sub

    Sub write
        If flag_ar_b = &H0 Then read
        If flag_ar_b = &H0 Then write_ar_b_value = get_ar_b

        regValue = leftShift((write_ar_b_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ar_b_mask = &Hffff
        if data_low > LONG_MAX then
            if ar_b_mask = mask then
                read_ar_b_value = data_low
            else
                read_ar_b_value = (data_low - H8000_0000) and ar_b_mask
            end If
        else
            read_ar_b_value = data_low and ar_b_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ar_b_value = &H0
        flag_ar_b        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_ar_r_ind_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ar_r                                       [31:20]          get_ar_r
''                                                             set_ar_r
''                                                             read_ar_r
''                                                             write_ar_r
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_ar_r_ind_m
    Private write_ar_r_value
    Private read_ar_r_value
    Private flag_ar_r

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H512c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ar_r
        get_ar_r = read_ar_r_value
    End Property

    Property Let set_ar_r(aData)
        write_ar_r_value = aData
        flag_ar_r        = &H1
    End Property

    Property Get read_ar_r
        read
        read_ar_r = read_ar_r_value
    End Property

    Property Let write_ar_r(aData)
        set_ar_r = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ar_r_value = rightShift(data_low, 20) and &Hfff

    End Sub

    Sub write
        If flag_ar_r = &H0 Then read
        If flag_ar_r = &H0 Then write_ar_r_value = get_ar_r

        regValue = leftShift((write_ar_r_value and &Hfff), 20)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ar_r_value = rightShift(data_low, 20) and &Hfff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ar_r_value = &H0
        flag_ar_r        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_target_fc_ind_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ar_tgt_latency                             [27:16]          get_ar_tgt_latency
''                                                             set_ar_tgt_latency
''                                                             read_ar_tgt_latency
''                                                             write_ar_tgt_latency
''---------------------------------------------------------------------------------
'' aw_tgt_latency                             [11:0]           get_aw_tgt_latency
''                                                             set_aw_tgt_latency
''                                                             read_aw_tgt_latency
''                                                             write_aw_tgt_latency
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_target_fc_ind_m
    Private write_ar_tgt_latency_value
    Private read_ar_tgt_latency_value
    Private flag_ar_tgt_latency
    Private write_aw_tgt_latency_value
    Private read_aw_tgt_latency_value
    Private flag_aw_tgt_latency

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H5130
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ar_tgt_latency
        get_ar_tgt_latency = read_ar_tgt_latency_value
    End Property

    Property Let set_ar_tgt_latency(aData)
        write_ar_tgt_latency_value = aData
        flag_ar_tgt_latency        = &H1
    End Property

    Property Get read_ar_tgt_latency
        read
        read_ar_tgt_latency = read_ar_tgt_latency_value
    End Property

    Property Let write_ar_tgt_latency(aData)
        set_ar_tgt_latency = aData
        write
    End Property

    Property Get get_aw_tgt_latency
        get_aw_tgt_latency = read_aw_tgt_latency_value
    End Property

    Property Let set_aw_tgt_latency(aData)
        write_aw_tgt_latency_value = aData
        flag_aw_tgt_latency        = &H1
    End Property

    Property Get read_aw_tgt_latency
        read
        read_aw_tgt_latency = read_aw_tgt_latency_value
    End Property

    Property Let write_aw_tgt_latency(aData)
        set_aw_tgt_latency = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ar_tgt_latency_value = rightShift(data_low, 16) and &Hfff
        aw_tgt_latency_mask = &Hfff
        if data_low > LONG_MAX then
            if aw_tgt_latency_mask = mask then
                read_aw_tgt_latency_value = data_low
            else
                read_aw_tgt_latency_value = (data_low - H8000_0000) and aw_tgt_latency_mask
            end If
        else
            read_aw_tgt_latency_value = data_low and aw_tgt_latency_mask
        end If

    End Sub

    Sub write
        If flag_ar_tgt_latency = &H0 or flag_aw_tgt_latency = &H0 Then read
        If flag_ar_tgt_latency = &H0 Then write_ar_tgt_latency_value = get_ar_tgt_latency
        If flag_aw_tgt_latency = &H0 Then write_aw_tgt_latency_value = get_aw_tgt_latency

        regValue = leftShift((write_ar_tgt_latency_value and &Hfff), 16) + leftShift((write_aw_tgt_latency_value and &Hfff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ar_tgt_latency_value = rightShift(data_low, 16) and &Hfff
        aw_tgt_latency_mask = &Hfff
        if data_low > LONG_MAX then
            if aw_tgt_latency_mask = mask then
                read_aw_tgt_latency_value = data_low
            else
                read_aw_tgt_latency_value = (data_low - H8000_0000) and aw_tgt_latency_mask
            end If
        else
            read_aw_tgt_latency_value = data_low and aw_tgt_latency_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ar_tgt_latency_value = &H0
        flag_ar_tgt_latency        = &H0
        write_aw_tgt_latency_value = &H0
        flag_aw_tgt_latency        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_ki_fc_ind_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ar_ki                                      [10:8]           get_ar_ki
''                                                             set_ar_ki
''                                                             read_ar_ki
''                                                             write_ar_ki
''---------------------------------------------------------------------------------
'' aw_ki                                      [2:0]            get_aw_ki
''                                                             set_aw_ki
''                                                             read_aw_ki
''                                                             write_aw_ki
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_ki_fc_ind_m
    Private write_ar_ki_value
    Private read_ar_ki_value
    Private flag_ar_ki
    Private write_aw_ki_value
    Private read_aw_ki_value
    Private flag_aw_ki

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H5134
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ar_ki
        get_ar_ki = read_ar_ki_value
    End Property

    Property Let set_ar_ki(aData)
        write_ar_ki_value = aData
        flag_ar_ki        = &H1
    End Property

    Property Get read_ar_ki
        read
        read_ar_ki = read_ar_ki_value
    End Property

    Property Let write_ar_ki(aData)
        set_ar_ki = aData
        write
    End Property

    Property Get get_aw_ki
        get_aw_ki = read_aw_ki_value
    End Property

    Property Let set_aw_ki(aData)
        write_aw_ki_value = aData
        flag_aw_ki        = &H1
    End Property

    Property Get read_aw_ki
        read
        read_aw_ki = read_aw_ki_value
    End Property

    Property Let write_aw_ki(aData)
        set_aw_ki = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ar_ki_value = rightShift(data_low, 8) and &H7
        aw_ki_mask = &H7
        if data_low > LONG_MAX then
            if aw_ki_mask = mask then
                read_aw_ki_value = data_low
            else
                read_aw_ki_value = (data_low - H8000_0000) and aw_ki_mask
            end If
        else
            read_aw_ki_value = data_low and aw_ki_mask
        end If

    End Sub

    Sub write
        If flag_ar_ki = &H0 or flag_aw_ki = &H0 Then read
        If flag_ar_ki = &H0 Then write_ar_ki_value = get_ar_ki
        If flag_aw_ki = &H0 Then write_aw_ki_value = get_aw_ki

        regValue = leftShift((write_ar_ki_value and &H7), 8) + leftShift((write_aw_ki_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ar_ki_value = rightShift(data_low, 8) and &H7
        aw_ki_mask = &H7
        if data_low > LONG_MAX then
            if aw_ki_mask = mask then
                read_aw_ki_value = data_low
            else
                read_aw_ki_value = (data_low - H8000_0000) and aw_ki_mask
            end If
        else
            read_aw_ki_value = data_low and aw_ki_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ar_ki_value = &H0
        flag_ar_ki        = &H0
        write_aw_ki_value = &H0
        flag_aw_ki        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_qos_range_ind_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ar_max_qos                                 [27:24]          get_ar_max_qos
''                                                             set_ar_max_qos
''                                                             read_ar_max_qos
''                                                             write_ar_max_qos
''---------------------------------------------------------------------------------
'' ar_min_qos                                 [19:16]          get_ar_min_qos
''                                                             set_ar_min_qos
''                                                             read_ar_min_qos
''                                                             write_ar_min_qos
''---------------------------------------------------------------------------------
'' aw_max_qos                                 [11:8]           get_aw_max_qos
''                                                             set_aw_max_qos
''                                                             read_aw_max_qos
''                                                             write_aw_max_qos
''---------------------------------------------------------------------------------
'' aw_min_qos                                 [3:0]            get_aw_min_qos
''                                                             set_aw_min_qos
''                                                             read_aw_min_qos
''                                                             write_aw_min_qos
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_qos_range_ind_m
    Private write_ar_max_qos_value
    Private read_ar_max_qos_value
    Private flag_ar_max_qos
    Private write_ar_min_qos_value
    Private read_ar_min_qos_value
    Private flag_ar_min_qos
    Private write_aw_max_qos_value
    Private read_aw_max_qos_value
    Private flag_aw_max_qos
    Private write_aw_min_qos_value
    Private read_aw_min_qos_value
    Private flag_aw_min_qos

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H5138
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ar_max_qos
        get_ar_max_qos = read_ar_max_qos_value
    End Property

    Property Let set_ar_max_qos(aData)
        write_ar_max_qos_value = aData
        flag_ar_max_qos        = &H1
    End Property

    Property Get read_ar_max_qos
        read
        read_ar_max_qos = read_ar_max_qos_value
    End Property

    Property Let write_ar_max_qos(aData)
        set_ar_max_qos = aData
        write
    End Property

    Property Get get_ar_min_qos
        get_ar_min_qos = read_ar_min_qos_value
    End Property

    Property Let set_ar_min_qos(aData)
        write_ar_min_qos_value = aData
        flag_ar_min_qos        = &H1
    End Property

    Property Get read_ar_min_qos
        read
        read_ar_min_qos = read_ar_min_qos_value
    End Property

    Property Let write_ar_min_qos(aData)
        set_ar_min_qos = aData
        write
    End Property

    Property Get get_aw_max_qos
        get_aw_max_qos = read_aw_max_qos_value
    End Property

    Property Let set_aw_max_qos(aData)
        write_aw_max_qos_value = aData
        flag_aw_max_qos        = &H1
    End Property

    Property Get read_aw_max_qos
        read
        read_aw_max_qos = read_aw_max_qos_value
    End Property

    Property Let write_aw_max_qos(aData)
        set_aw_max_qos = aData
        write
    End Property

    Property Get get_aw_min_qos
        get_aw_min_qos = read_aw_min_qos_value
    End Property

    Property Let set_aw_min_qos(aData)
        write_aw_min_qos_value = aData
        flag_aw_min_qos        = &H1
    End Property

    Property Get read_aw_min_qos
        read
        read_aw_min_qos = read_aw_min_qos_value
    End Property

    Property Let write_aw_min_qos(aData)
        set_aw_min_qos = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ar_max_qos_value = rightShift(data_low, 24) and &Hf
        read_ar_min_qos_value = rightShift(data_low, 16) and &Hf
        read_aw_max_qos_value = rightShift(data_low, 8) and &Hf
        aw_min_qos_mask = &Hf
        if data_low > LONG_MAX then
            if aw_min_qos_mask = mask then
                read_aw_min_qos_value = data_low
            else
                read_aw_min_qos_value = (data_low - H8000_0000) and aw_min_qos_mask
            end If
        else
            read_aw_min_qos_value = data_low and aw_min_qos_mask
        end If

    End Sub

    Sub write
        If flag_ar_max_qos = &H0 or flag_ar_min_qos = &H0 or flag_aw_max_qos = &H0 or flag_aw_min_qos = &H0 Then read
        If flag_ar_max_qos = &H0 Then write_ar_max_qos_value = get_ar_max_qos
        If flag_ar_min_qos = &H0 Then write_ar_min_qos_value = get_ar_min_qos
        If flag_aw_max_qos = &H0 Then write_aw_max_qos_value = get_aw_max_qos
        If flag_aw_min_qos = &H0 Then write_aw_min_qos_value = get_aw_min_qos

        regValue = leftShift((write_ar_max_qos_value and &Hf), 24) + leftShift((write_ar_min_qos_value and &Hf), 16) + leftShift((write_aw_max_qos_value and &Hf), 8) + leftShift((write_aw_min_qos_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ar_max_qos_value = rightShift(data_low, 24) and &Hf
        read_ar_min_qos_value = rightShift(data_low, 16) and &Hf
        read_aw_max_qos_value = rightShift(data_low, 8) and &Hf
        aw_min_qos_mask = &Hf
        if data_low > LONG_MAX then
            if aw_min_qos_mask = mask then
                read_aw_min_qos_value = data_low
            else
                read_aw_min_qos_value = (data_low - H8000_0000) and aw_min_qos_mask
            end If
        else
            read_aw_min_qos_value = data_low and aw_min_qos_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ar_max_qos_value = &H0
        flag_ar_max_qos        = &H0
        write_ar_min_qos_value = &H0
        flag_ar_min_qos        = &H0
        write_aw_max_qos_value = &H0
        flag_aw_max_qos        = &H0
        write_aw_min_qos_value = &H0
        flag_aw_min_qos        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_fn_mod2_dap_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' fn_mode2                                   [0:0]            get_fn_mode2
''                                                             set_fn_mode2
''                                                             read_fn_mode2
''                                                             write_fn_mode2
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_fn_mod2_dap_m
    Private write_fn_mode2_value
    Private read_fn_mode2_value
    Private flag_fn_mode2

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H6024
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_fn_mode2
        get_fn_mode2 = read_fn_mode2_value
    End Property

    Property Let set_fn_mode2(aData)
        write_fn_mode2_value = aData
        flag_fn_mode2        = &H1
    End Property

    Property Get read_fn_mode2
        read
        read_fn_mode2 = read_fn_mode2_value
    End Property

    Property Let write_fn_mode2(aData)
        set_fn_mode2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        fn_mode2_mask = &H1
        if data_low > LONG_MAX then
            if fn_mode2_mask = mask then
                read_fn_mode2_value = data_low
            else
                read_fn_mode2_value = (data_low - H8000_0000) and fn_mode2_mask
            end If
        else
            read_fn_mode2_value = data_low and fn_mode2_mask
        end If

    End Sub

    Sub write
        If flag_fn_mode2 = &H0 Then read
        If flag_fn_mode2 = &H0 Then write_fn_mode2_value = get_fn_mode2

        regValue = leftShift((write_fn_mode2_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        fn_mode2_mask = &H1
        if data_low > LONG_MAX then
            if fn_mode2_mask = mask then
                read_fn_mode2_value = data_low
            else
                read_fn_mode2_value = (data_low - H8000_0000) and fn_mode2_mask
            end If
        else
            read_fn_mode2_value = data_low and fn_mode2_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_fn_mode2_value = &H0
        flag_fn_mode2        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_fn_mod_ahb_dap_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' fn_mod_ahb                                 [1:0]            get_fn_mod_ahb
''                                                             set_fn_mod_ahb
''                                                             read_fn_mod_ahb
''                                                             write_fn_mod_ahb
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_fn_mod_ahb_dap_m
    Private write_fn_mod_ahb_value
    Private read_fn_mod_ahb_value
    Private flag_fn_mod_ahb

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H6028
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_fn_mod_ahb
        get_fn_mod_ahb = read_fn_mod_ahb_value
    End Property

    Property Let set_fn_mod_ahb(aData)
        write_fn_mod_ahb_value = aData
        flag_fn_mod_ahb        = &H1
    End Property

    Property Get read_fn_mod_ahb
        read
        read_fn_mod_ahb = read_fn_mod_ahb_value
    End Property

    Property Let write_fn_mod_ahb(aData)
        set_fn_mod_ahb = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        fn_mod_ahb_mask = &H3
        if data_low > LONG_MAX then
            if fn_mod_ahb_mask = mask then
                read_fn_mod_ahb_value = data_low
            else
                read_fn_mod_ahb_value = (data_low - H8000_0000) and fn_mod_ahb_mask
            end If
        else
            read_fn_mod_ahb_value = data_low and fn_mod_ahb_mask
        end If

    End Sub

    Sub write
        If flag_fn_mod_ahb = &H0 Then read
        If flag_fn_mod_ahb = &H0 Then write_fn_mod_ahb_value = get_fn_mod_ahb

        regValue = leftShift((write_fn_mod_ahb_value and &H3), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        fn_mod_ahb_mask = &H3
        if data_low > LONG_MAX then
            if fn_mod_ahb_mask = mask then
                read_fn_mod_ahb_value = data_low
            else
                read_fn_mod_ahb_value = (data_low - H8000_0000) and fn_mod_ahb_mask
            end If
        else
            read_fn_mod_ahb_value = data_low and fn_mod_ahb_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_fn_mod_ahb_value = &H0
        flag_fn_mod_ahb        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_read_qos_dap_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' read_qos                                   [3:0]            get_read_qos
''                                                             set_read_qos
''                                                             read_read_qos
''                                                             write_read_qos
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_read_qos_dap_m
    Private write_read_qos_value
    Private read_read_qos_value
    Private flag_read_qos

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H6100
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_read_qos
        get_read_qos = read_read_qos_value
    End Property

    Property Let set_read_qos(aData)
        write_read_qos_value = aData
        flag_read_qos        = &H1
    End Property

    Property Get read_read_qos
        read
        read_read_qos = read_read_qos_value
    End Property

    Property Let write_read_qos(aData)
        set_read_qos = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_qos_mask = &Hf
        if data_low > LONG_MAX then
            if read_qos_mask = mask then
                read_read_qos_value = data_low
            else
                read_read_qos_value = (data_low - H8000_0000) and read_qos_mask
            end If
        else
            read_read_qos_value = data_low and read_qos_mask
        end If

    End Sub

    Sub write
        If flag_read_qos = &H0 Then read
        If flag_read_qos = &H0 Then write_read_qos_value = get_read_qos

        regValue = leftShift((write_read_qos_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_qos_mask = &Hf
        if data_low > LONG_MAX then
            if read_qos_mask = mask then
                read_read_qos_value = data_low
            else
                read_read_qos_value = (data_low - H8000_0000) and read_qos_mask
            end If
        else
            read_read_qos_value = data_low and read_qos_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_read_qos_value = &H0
        flag_read_qos        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_write_qos_dap_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' write_qos                                  [3:0]            get_write_qos
''                                                             set_write_qos
''                                                             read_write_qos
''                                                             write_write_qos
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_write_qos_dap_m
    Private write_write_qos_value
    Private read_write_qos_value
    Private flag_write_qos

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H6104
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_write_qos
        get_write_qos = read_write_qos_value
    End Property

    Property Let set_write_qos(aData)
        write_write_qos_value = aData
        flag_write_qos        = &H1
    End Property

    Property Get read_write_qos
        read
        read_write_qos = read_write_qos_value
    End Property

    Property Let write_write_qos(aData)
        set_write_qos = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        write_qos_mask = &Hf
        if data_low > LONG_MAX then
            if write_qos_mask = mask then
                read_write_qos_value = data_low
            else
                read_write_qos_value = (data_low - H8000_0000) and write_qos_mask
            end If
        else
            read_write_qos_value = data_low and write_qos_mask
        end If

    End Sub

    Sub write
        If flag_write_qos = &H0 Then read
        If flag_write_qos = &H0 Then write_write_qos_value = get_write_qos

        regValue = leftShift((write_write_qos_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        write_qos_mask = &Hf
        if data_low > LONG_MAX then
            if write_qos_mask = mask then
                read_write_qos_value = data_low
            else
                read_write_qos_value = (data_low - H8000_0000) and write_qos_mask
            end If
        else
            read_write_qos_value = data_low and write_qos_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_write_qos_value = &H0
        flag_write_qos        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_fn_mod_dap_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' fn_mod                                     [1:0]            get_fn_mod
''                                                             set_fn_mod
''                                                             read_fn_mod
''                                                             write_fn_mod
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_fn_mod_dap_m
    Private write_fn_mod_value
    Private read_fn_mod_value
    Private flag_fn_mod

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H6108
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_fn_mod
        get_fn_mod = read_fn_mod_value
    End Property

    Property Let set_fn_mod(aData)
        write_fn_mod_value = aData
        flag_fn_mod        = &H1
    End Property

    Property Get read_fn_mod
        read
        read_fn_mod = read_fn_mod_value
    End Property

    Property Let write_fn_mod(aData)
        set_fn_mod = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        fn_mod_mask = &H3
        if data_low > LONG_MAX then
            if fn_mod_mask = mask then
                read_fn_mod_value = data_low
            else
                read_fn_mod_value = (data_low - H8000_0000) and fn_mod_mask
            end If
        else
            read_fn_mod_value = data_low and fn_mod_mask
        end If

    End Sub

    Sub write
        If flag_fn_mod = &H0 Then read
        If flag_fn_mod = &H0 Then write_fn_mod_value = get_fn_mod

        regValue = leftShift((write_fn_mod_value and &H3), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        fn_mod_mask = &H3
        if data_low > LONG_MAX then
            if fn_mod_mask = mask then
                read_fn_mod_value = data_low
            else
                read_fn_mod_value = (data_low - H8000_0000) and fn_mod_mask
            end If
        else
            read_fn_mod_value = data_low and fn_mod_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_fn_mod_value = &H0
        flag_fn_mod        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_qos_cntl_dap_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mode_ar_fc                                 [20:20]          get_mode_ar_fc
''                                                             set_mode_ar_fc
''                                                             read_mode_ar_fc
''                                                             write_mode_ar_fc
''---------------------------------------------------------------------------------
'' mode_aw_fc                                 [16:16]          get_mode_aw_fc
''                                                             set_mode_aw_fc
''                                                             read_mode_aw_fc
''                                                             write_mode_aw_fc
''---------------------------------------------------------------------------------
'' en_awar_ot                                 [7:7]            get_en_awar_ot
''                                                             set_en_awar_ot
''                                                             read_en_awar_ot
''                                                             write_en_awar_ot
''---------------------------------------------------------------------------------
'' en_ar_ot                                   [6:6]            get_en_ar_ot
''                                                             set_en_ar_ot
''                                                             read_en_ar_ot
''                                                             write_en_ar_ot
''---------------------------------------------------------------------------------
'' en_aw_ot                                   [5:5]            get_en_aw_ot
''                                                             set_en_aw_ot
''                                                             read_en_aw_ot
''                                                             write_en_aw_ot
''---------------------------------------------------------------------------------
'' en_ar_fc                                   [4:4]            get_en_ar_fc
''                                                             set_en_ar_fc
''                                                             read_en_ar_fc
''                                                             write_en_ar_fc
''---------------------------------------------------------------------------------
'' en_aw_fc                                   [3:3]            get_en_aw_fc
''                                                             set_en_aw_fc
''                                                             read_en_aw_fc
''                                                             write_en_aw_fc
''---------------------------------------------------------------------------------
'' en_awar_rate                               [2:2]            get_en_awar_rate
''                                                             set_en_awar_rate
''                                                             read_en_awar_rate
''                                                             write_en_awar_rate
''---------------------------------------------------------------------------------
'' en_ar_rate                                 [1:1]            get_en_ar_rate
''                                                             set_en_ar_rate
''                                                             read_en_ar_rate
''                                                             write_en_ar_rate
''---------------------------------------------------------------------------------
'' en_aw_rate                                 [0:0]            get_en_aw_rate
''                                                             set_en_aw_rate
''                                                             read_en_aw_rate
''                                                             write_en_aw_rate
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_qos_cntl_dap_m
    Private write_mode_ar_fc_value
    Private read_mode_ar_fc_value
    Private flag_mode_ar_fc
    Private write_mode_aw_fc_value
    Private read_mode_aw_fc_value
    Private flag_mode_aw_fc
    Private write_en_awar_ot_value
    Private read_en_awar_ot_value
    Private flag_en_awar_ot
    Private write_en_ar_ot_value
    Private read_en_ar_ot_value
    Private flag_en_ar_ot
    Private write_en_aw_ot_value
    Private read_en_aw_ot_value
    Private flag_en_aw_ot
    Private write_en_ar_fc_value
    Private read_en_ar_fc_value
    Private flag_en_ar_fc
    Private write_en_aw_fc_value
    Private read_en_aw_fc_value
    Private flag_en_aw_fc
    Private write_en_awar_rate_value
    Private read_en_awar_rate_value
    Private flag_en_awar_rate
    Private write_en_ar_rate_value
    Private read_en_ar_rate_value
    Private flag_en_ar_rate
    Private write_en_aw_rate_value
    Private read_en_aw_rate_value
    Private flag_en_aw_rate

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H610c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mode_ar_fc
        get_mode_ar_fc = read_mode_ar_fc_value
    End Property

    Property Let set_mode_ar_fc(aData)
        write_mode_ar_fc_value = aData
        flag_mode_ar_fc        = &H1
    End Property

    Property Get read_mode_ar_fc
        read
        read_mode_ar_fc = read_mode_ar_fc_value
    End Property

    Property Let write_mode_ar_fc(aData)
        set_mode_ar_fc = aData
        write
    End Property

    Property Get get_mode_aw_fc
        get_mode_aw_fc = read_mode_aw_fc_value
    End Property

    Property Let set_mode_aw_fc(aData)
        write_mode_aw_fc_value = aData
        flag_mode_aw_fc        = &H1
    End Property

    Property Get read_mode_aw_fc
        read
        read_mode_aw_fc = read_mode_aw_fc_value
    End Property

    Property Let write_mode_aw_fc(aData)
        set_mode_aw_fc = aData
        write
    End Property

    Property Get get_en_awar_ot
        get_en_awar_ot = read_en_awar_ot_value
    End Property

    Property Let set_en_awar_ot(aData)
        write_en_awar_ot_value = aData
        flag_en_awar_ot        = &H1
    End Property

    Property Get read_en_awar_ot
        read
        read_en_awar_ot = read_en_awar_ot_value
    End Property

    Property Let write_en_awar_ot(aData)
        set_en_awar_ot = aData
        write
    End Property

    Property Get get_en_ar_ot
        get_en_ar_ot = read_en_ar_ot_value
    End Property

    Property Let set_en_ar_ot(aData)
        write_en_ar_ot_value = aData
        flag_en_ar_ot        = &H1
    End Property

    Property Get read_en_ar_ot
        read
        read_en_ar_ot = read_en_ar_ot_value
    End Property

    Property Let write_en_ar_ot(aData)
        set_en_ar_ot = aData
        write
    End Property

    Property Get get_en_aw_ot
        get_en_aw_ot = read_en_aw_ot_value
    End Property

    Property Let set_en_aw_ot(aData)
        write_en_aw_ot_value = aData
        flag_en_aw_ot        = &H1
    End Property

    Property Get read_en_aw_ot
        read
        read_en_aw_ot = read_en_aw_ot_value
    End Property

    Property Let write_en_aw_ot(aData)
        set_en_aw_ot = aData
        write
    End Property

    Property Get get_en_ar_fc
        get_en_ar_fc = read_en_ar_fc_value
    End Property

    Property Let set_en_ar_fc(aData)
        write_en_ar_fc_value = aData
        flag_en_ar_fc        = &H1
    End Property

    Property Get read_en_ar_fc
        read
        read_en_ar_fc = read_en_ar_fc_value
    End Property

    Property Let write_en_ar_fc(aData)
        set_en_ar_fc = aData
        write
    End Property

    Property Get get_en_aw_fc
        get_en_aw_fc = read_en_aw_fc_value
    End Property

    Property Let set_en_aw_fc(aData)
        write_en_aw_fc_value = aData
        flag_en_aw_fc        = &H1
    End Property

    Property Get read_en_aw_fc
        read
        read_en_aw_fc = read_en_aw_fc_value
    End Property

    Property Let write_en_aw_fc(aData)
        set_en_aw_fc = aData
        write
    End Property

    Property Get get_en_awar_rate
        get_en_awar_rate = read_en_awar_rate_value
    End Property

    Property Let set_en_awar_rate(aData)
        write_en_awar_rate_value = aData
        flag_en_awar_rate        = &H1
    End Property

    Property Get read_en_awar_rate
        read
        read_en_awar_rate = read_en_awar_rate_value
    End Property

    Property Let write_en_awar_rate(aData)
        set_en_awar_rate = aData
        write
    End Property

    Property Get get_en_ar_rate
        get_en_ar_rate = read_en_ar_rate_value
    End Property

    Property Let set_en_ar_rate(aData)
        write_en_ar_rate_value = aData
        flag_en_ar_rate        = &H1
    End Property

    Property Get read_en_ar_rate
        read
        read_en_ar_rate = read_en_ar_rate_value
    End Property

    Property Let write_en_ar_rate(aData)
        set_en_ar_rate = aData
        write
    End Property

    Property Get get_en_aw_rate
        get_en_aw_rate = read_en_aw_rate_value
    End Property

    Property Let set_en_aw_rate(aData)
        write_en_aw_rate_value = aData
        flag_en_aw_rate        = &H1
    End Property

    Property Get read_en_aw_rate
        read
        read_en_aw_rate = read_en_aw_rate_value
    End Property

    Property Let write_en_aw_rate(aData)
        set_en_aw_rate = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_mode_ar_fc_value = rightShift(data_low, 20) and &H1
        read_mode_aw_fc_value = rightShift(data_low, 16) and &H1
        read_en_awar_ot_value = rightShift(data_low, 7) and &H1
        read_en_ar_ot_value = rightShift(data_low, 6) and &H1
        read_en_aw_ot_value = rightShift(data_low, 5) and &H1
        read_en_ar_fc_value = rightShift(data_low, 4) and &H1
        read_en_aw_fc_value = rightShift(data_low, 3) and &H1
        read_en_awar_rate_value = rightShift(data_low, 2) and &H1
        read_en_ar_rate_value = rightShift(data_low, 1) and &H1
        en_aw_rate_mask = &H1
        if data_low > LONG_MAX then
            if en_aw_rate_mask = mask then
                read_en_aw_rate_value = data_low
            else
                read_en_aw_rate_value = (data_low - H8000_0000) and en_aw_rate_mask
            end If
        else
            read_en_aw_rate_value = data_low and en_aw_rate_mask
        end If

    End Sub

    Sub write
        If flag_mode_ar_fc = &H0 or flag_mode_aw_fc = &H0 or flag_en_awar_ot = &H0 or flag_en_ar_ot = &H0 or flag_en_aw_ot = &H0 or flag_en_ar_fc = &H0 or flag_en_aw_fc = &H0 or flag_en_awar_rate = &H0 or flag_en_ar_rate = &H0 or flag_en_aw_rate = &H0 Then read
        If flag_mode_ar_fc = &H0 Then write_mode_ar_fc_value = get_mode_ar_fc
        If flag_mode_aw_fc = &H0 Then write_mode_aw_fc_value = get_mode_aw_fc
        If flag_en_awar_ot = &H0 Then write_en_awar_ot_value = get_en_awar_ot
        If flag_en_ar_ot = &H0 Then write_en_ar_ot_value = get_en_ar_ot
        If flag_en_aw_ot = &H0 Then write_en_aw_ot_value = get_en_aw_ot
        If flag_en_ar_fc = &H0 Then write_en_ar_fc_value = get_en_ar_fc
        If flag_en_aw_fc = &H0 Then write_en_aw_fc_value = get_en_aw_fc
        If flag_en_awar_rate = &H0 Then write_en_awar_rate_value = get_en_awar_rate
        If flag_en_ar_rate = &H0 Then write_en_ar_rate_value = get_en_ar_rate
        If flag_en_aw_rate = &H0 Then write_en_aw_rate_value = get_en_aw_rate

        regValue = leftShift((write_mode_ar_fc_value and &H1), 20) + leftShift((write_mode_aw_fc_value and &H1), 16) + leftShift((write_en_awar_ot_value and &H1), 7) + leftShift((write_en_ar_ot_value and &H1), 6) + leftShift((write_en_aw_ot_value and &H1), 5) + leftShift((write_en_ar_fc_value and &H1), 4) + leftShift((write_en_aw_fc_value and &H1), 3) + leftShift((write_en_awar_rate_value and &H1), 2) + leftShift((write_en_ar_rate_value and &H1), 1) + leftShift((write_en_aw_rate_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_mode_ar_fc_value = rightShift(data_low, 20) and &H1
        read_mode_aw_fc_value = rightShift(data_low, 16) and &H1
        read_en_awar_ot_value = rightShift(data_low, 7) and &H1
        read_en_ar_ot_value = rightShift(data_low, 6) and &H1
        read_en_aw_ot_value = rightShift(data_low, 5) and &H1
        read_en_ar_fc_value = rightShift(data_low, 4) and &H1
        read_en_aw_fc_value = rightShift(data_low, 3) and &H1
        read_en_awar_rate_value = rightShift(data_low, 2) and &H1
        read_en_ar_rate_value = rightShift(data_low, 1) and &H1
        en_aw_rate_mask = &H1
        if data_low > LONG_MAX then
            if en_aw_rate_mask = mask then
                read_en_aw_rate_value = data_low
            else
                read_en_aw_rate_value = (data_low - H8000_0000) and en_aw_rate_mask
            end If
        else
            read_en_aw_rate_value = data_low and en_aw_rate_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mode_ar_fc_value = &H0
        flag_mode_ar_fc        = &H0
        write_mode_aw_fc_value = &H0
        flag_mode_aw_fc        = &H0
        write_en_awar_ot_value = &H0
        flag_en_awar_ot        = &H0
        write_en_ar_ot_value = &H0
        flag_en_ar_ot        = &H0
        write_en_aw_ot_value = &H0
        flag_en_aw_ot        = &H0
        write_en_ar_fc_value = &H0
        flag_en_ar_fc        = &H0
        write_en_aw_fc_value = &H0
        flag_en_aw_fc        = &H0
        write_en_awar_rate_value = &H0
        flag_en_awar_rate        = &H0
        write_en_ar_rate_value = &H0
        flag_en_ar_rate        = &H0
        write_en_aw_rate_value = &H0
        flag_en_aw_rate        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_max_ot_dap_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ar_max_oti                                 [29:24]          get_ar_max_oti
''                                                             set_ar_max_oti
''                                                             read_ar_max_oti
''                                                             write_ar_max_oti
''---------------------------------------------------------------------------------
'' ar_max_otf                                 [23:16]          get_ar_max_otf
''                                                             set_ar_max_otf
''                                                             read_ar_max_otf
''                                                             write_ar_max_otf
''---------------------------------------------------------------------------------
'' aw_max_oti                                 [13:8]           get_aw_max_oti
''                                                             set_aw_max_oti
''                                                             read_aw_max_oti
''                                                             write_aw_max_oti
''---------------------------------------------------------------------------------
'' en_ar_ot                                   [7:0]            get_en_ar_ot
''                                                             set_en_ar_ot
''                                                             read_en_ar_ot
''                                                             write_en_ar_ot
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_max_ot_dap_m
    Private write_ar_max_oti_value
    Private read_ar_max_oti_value
    Private flag_ar_max_oti
    Private write_ar_max_otf_value
    Private read_ar_max_otf_value
    Private flag_ar_max_otf
    Private write_aw_max_oti_value
    Private read_aw_max_oti_value
    Private flag_aw_max_oti
    Private write_en_ar_ot_value
    Private read_en_ar_ot_value
    Private flag_en_ar_ot

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H6110
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ar_max_oti
        get_ar_max_oti = read_ar_max_oti_value
    End Property

    Property Let set_ar_max_oti(aData)
        write_ar_max_oti_value = aData
        flag_ar_max_oti        = &H1
    End Property

    Property Get read_ar_max_oti
        read
        read_ar_max_oti = read_ar_max_oti_value
    End Property

    Property Let write_ar_max_oti(aData)
        set_ar_max_oti = aData
        write
    End Property

    Property Get get_ar_max_otf
        get_ar_max_otf = read_ar_max_otf_value
    End Property

    Property Let set_ar_max_otf(aData)
        write_ar_max_otf_value = aData
        flag_ar_max_otf        = &H1
    End Property

    Property Get read_ar_max_otf
        read
        read_ar_max_otf = read_ar_max_otf_value
    End Property

    Property Let write_ar_max_otf(aData)
        set_ar_max_otf = aData
        write
    End Property

    Property Get get_aw_max_oti
        get_aw_max_oti = read_aw_max_oti_value
    End Property

    Property Let set_aw_max_oti(aData)
        write_aw_max_oti_value = aData
        flag_aw_max_oti        = &H1
    End Property

    Property Get read_aw_max_oti
        read
        read_aw_max_oti = read_aw_max_oti_value
    End Property

    Property Let write_aw_max_oti(aData)
        set_aw_max_oti = aData
        write
    End Property

    Property Get get_en_ar_ot
        get_en_ar_ot = read_en_ar_ot_value
    End Property

    Property Let set_en_ar_ot(aData)
        write_en_ar_ot_value = aData
        flag_en_ar_ot        = &H1
    End Property

    Property Get read_en_ar_ot
        read
        read_en_ar_ot = read_en_ar_ot_value
    End Property

    Property Let write_en_ar_ot(aData)
        set_en_ar_ot = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ar_max_oti_value = rightShift(data_low, 24) and &H3f
        read_ar_max_otf_value = rightShift(data_low, 16) and &Hff
        read_aw_max_oti_value = rightShift(data_low, 8) and &H3f
        en_ar_ot_mask = &Hff
        if data_low > LONG_MAX then
            if en_ar_ot_mask = mask then
                read_en_ar_ot_value = data_low
            else
                read_en_ar_ot_value = (data_low - H8000_0000) and en_ar_ot_mask
            end If
        else
            read_en_ar_ot_value = data_low and en_ar_ot_mask
        end If

    End Sub

    Sub write
        If flag_ar_max_oti = &H0 or flag_ar_max_otf = &H0 or flag_aw_max_oti = &H0 or flag_en_ar_ot = &H0 Then read
        If flag_ar_max_oti = &H0 Then write_ar_max_oti_value = get_ar_max_oti
        If flag_ar_max_otf = &H0 Then write_ar_max_otf_value = get_ar_max_otf
        If flag_aw_max_oti = &H0 Then write_aw_max_oti_value = get_aw_max_oti
        If flag_en_ar_ot = &H0 Then write_en_ar_ot_value = get_en_ar_ot

        regValue = leftShift((write_ar_max_oti_value and &H3f), 24) + leftShift((write_ar_max_otf_value and &Hff), 16) + leftShift((write_aw_max_oti_value and &H3f), 8) + leftShift((write_en_ar_ot_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ar_max_oti_value = rightShift(data_low, 24) and &H3f
        read_ar_max_otf_value = rightShift(data_low, 16) and &Hff
        read_aw_max_oti_value = rightShift(data_low, 8) and &H3f
        en_ar_ot_mask = &Hff
        if data_low > LONG_MAX then
            if en_ar_ot_mask = mask then
                read_en_ar_ot_value = data_low
            else
                read_en_ar_ot_value = (data_low - H8000_0000) and en_ar_ot_mask
            end If
        else
            read_en_ar_ot_value = data_low and en_ar_ot_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ar_max_oti_value = &H0
        flag_ar_max_oti        = &H0
        write_ar_max_otf_value = &H0
        flag_ar_max_otf        = &H0
        write_aw_max_oti_value = &H0
        flag_aw_max_oti        = &H0
        write_en_ar_ot_value = &H0
        flag_en_ar_ot        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_max_comb_ot_dap_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' awar_max_oti                               [14:8]           get_awar_max_oti
''                                                             set_awar_max_oti
''                                                             read_awar_max_oti
''                                                             write_awar_max_oti
''---------------------------------------------------------------------------------
'' awar_max_otf                               [7:0]            get_awar_max_otf
''                                                             set_awar_max_otf
''                                                             read_awar_max_otf
''                                                             write_awar_max_otf
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_max_comb_ot_dap_m
    Private write_awar_max_oti_value
    Private read_awar_max_oti_value
    Private flag_awar_max_oti
    Private write_awar_max_otf_value
    Private read_awar_max_otf_value
    Private flag_awar_max_otf

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H6114
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_awar_max_oti
        get_awar_max_oti = read_awar_max_oti_value
    End Property

    Property Let set_awar_max_oti(aData)
        write_awar_max_oti_value = aData
        flag_awar_max_oti        = &H1
    End Property

    Property Get read_awar_max_oti
        read
        read_awar_max_oti = read_awar_max_oti_value
    End Property

    Property Let write_awar_max_oti(aData)
        set_awar_max_oti = aData
        write
    End Property

    Property Get get_awar_max_otf
        get_awar_max_otf = read_awar_max_otf_value
    End Property

    Property Let set_awar_max_otf(aData)
        write_awar_max_otf_value = aData
        flag_awar_max_otf        = &H1
    End Property

    Property Get read_awar_max_otf
        read
        read_awar_max_otf = read_awar_max_otf_value
    End Property

    Property Let write_awar_max_otf(aData)
        set_awar_max_otf = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_awar_max_oti_value = rightShift(data_low, 8) and &H7f
        awar_max_otf_mask = &Hff
        if data_low > LONG_MAX then
            if awar_max_otf_mask = mask then
                read_awar_max_otf_value = data_low
            else
                read_awar_max_otf_value = (data_low - H8000_0000) and awar_max_otf_mask
            end If
        else
            read_awar_max_otf_value = data_low and awar_max_otf_mask
        end If

    End Sub

    Sub write
        If flag_awar_max_oti = &H0 or flag_awar_max_otf = &H0 Then read
        If flag_awar_max_oti = &H0 Then write_awar_max_oti_value = get_awar_max_oti
        If flag_awar_max_otf = &H0 Then write_awar_max_otf_value = get_awar_max_otf

        regValue = leftShift((write_awar_max_oti_value and &H7f), 8) + leftShift((write_awar_max_otf_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_awar_max_oti_value = rightShift(data_low, 8) and &H7f
        awar_max_otf_mask = &Hff
        if data_low > LONG_MAX then
            if awar_max_otf_mask = mask then
                read_awar_max_otf_value = data_low
            else
                read_awar_max_otf_value = (data_low - H8000_0000) and awar_max_otf_mask
            end If
        else
            read_awar_max_otf_value = data_low and awar_max_otf_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_awar_max_oti_value = &H0
        flag_awar_max_oti        = &H0
        write_awar_max_otf_value = &H0
        flag_awar_max_otf        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_aw_p_dap_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' aw_p                                       [31:24]          get_aw_p
''                                                             set_aw_p
''                                                             read_aw_p
''                                                             write_aw_p
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_aw_p_dap_m
    Private write_aw_p_value
    Private read_aw_p_value
    Private flag_aw_p

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H6118
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_aw_p
        get_aw_p = read_aw_p_value
    End Property

    Property Let set_aw_p(aData)
        write_aw_p_value = aData
        flag_aw_p        = &H1
    End Property

    Property Get read_aw_p
        read
        read_aw_p = read_aw_p_value
    End Property

    Property Let write_aw_p(aData)
        set_aw_p = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_aw_p_value = rightShift(data_low, 24) and &Hff

    End Sub

    Sub write
        If flag_aw_p = &H0 Then read
        If flag_aw_p = &H0 Then write_aw_p_value = get_aw_p

        regValue = leftShift((write_aw_p_value and &Hff), 24)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_aw_p_value = rightShift(data_low, 24) and &Hff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_aw_p_value = &H0
        flag_aw_p        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_aw_b_dap_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' aw_b                                       [15:0]           get_aw_b
''                                                             set_aw_b
''                                                             read_aw_b
''                                                             write_aw_b
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_aw_b_dap_m
    Private write_aw_b_value
    Private read_aw_b_value
    Private flag_aw_b

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H611c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_aw_b
        get_aw_b = read_aw_b_value
    End Property

    Property Let set_aw_b(aData)
        write_aw_b_value = aData
        flag_aw_b        = &H1
    End Property

    Property Get read_aw_b
        read
        read_aw_b = read_aw_b_value
    End Property

    Property Let write_aw_b(aData)
        set_aw_b = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        aw_b_mask = &Hffff
        if data_low > LONG_MAX then
            if aw_b_mask = mask then
                read_aw_b_value = data_low
            else
                read_aw_b_value = (data_low - H8000_0000) and aw_b_mask
            end If
        else
            read_aw_b_value = data_low and aw_b_mask
        end If

    End Sub

    Sub write
        If flag_aw_b = &H0 Then read
        If flag_aw_b = &H0 Then write_aw_b_value = get_aw_b

        regValue = leftShift((write_aw_b_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        aw_b_mask = &Hffff
        if data_low > LONG_MAX then
            if aw_b_mask = mask then
                read_aw_b_value = data_low
            else
                read_aw_b_value = (data_low - H8000_0000) and aw_b_mask
            end If
        else
            read_aw_b_value = data_low and aw_b_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_aw_b_value = &H0
        flag_aw_b        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_aw_r_dap_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' aw_r                                       [31:20]          get_aw_r
''                                                             set_aw_r
''                                                             read_aw_r
''                                                             write_aw_r
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_aw_r_dap_m
    Private write_aw_r_value
    Private read_aw_r_value
    Private flag_aw_r

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H6120
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_aw_r
        get_aw_r = read_aw_r_value
    End Property

    Property Let set_aw_r(aData)
        write_aw_r_value = aData
        flag_aw_r        = &H1
    End Property

    Property Get read_aw_r
        read
        read_aw_r = read_aw_r_value
    End Property

    Property Let write_aw_r(aData)
        set_aw_r = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_aw_r_value = rightShift(data_low, 20) and &Hfff

    End Sub

    Sub write
        If flag_aw_r = &H0 Then read
        If flag_aw_r = &H0 Then write_aw_r_value = get_aw_r

        regValue = leftShift((write_aw_r_value and &Hfff), 20)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_aw_r_value = rightShift(data_low, 20) and &Hfff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_aw_r_value = &H0
        flag_aw_r        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_ar_p_dap_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ar_p                                       [31:24]          get_ar_p
''                                                             set_ar_p
''                                                             read_ar_p
''                                                             write_ar_p
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_ar_p_dap_m
    Private write_ar_p_value
    Private read_ar_p_value
    Private flag_ar_p

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H6124
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ar_p
        get_ar_p = read_ar_p_value
    End Property

    Property Let set_ar_p(aData)
        write_ar_p_value = aData
        flag_ar_p        = &H1
    End Property

    Property Get read_ar_p
        read
        read_ar_p = read_ar_p_value
    End Property

    Property Let write_ar_p(aData)
        set_ar_p = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ar_p_value = rightShift(data_low, 24) and &Hff

    End Sub

    Sub write
        If flag_ar_p = &H0 Then read
        If flag_ar_p = &H0 Then write_ar_p_value = get_ar_p

        regValue = leftShift((write_ar_p_value and &Hff), 24)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ar_p_value = rightShift(data_low, 24) and &Hff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ar_p_value = &H0
        flag_ar_p        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_ar_b_dap_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ar_b                                       [15:0]           get_ar_b
''                                                             set_ar_b
''                                                             read_ar_b
''                                                             write_ar_b
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_ar_b_dap_m
    Private write_ar_b_value
    Private read_ar_b_value
    Private flag_ar_b

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H6128
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ar_b
        get_ar_b = read_ar_b_value
    End Property

    Property Let set_ar_b(aData)
        write_ar_b_value = aData
        flag_ar_b        = &H1
    End Property

    Property Get read_ar_b
        read
        read_ar_b = read_ar_b_value
    End Property

    Property Let write_ar_b(aData)
        set_ar_b = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ar_b_mask = &Hffff
        if data_low > LONG_MAX then
            if ar_b_mask = mask then
                read_ar_b_value = data_low
            else
                read_ar_b_value = (data_low - H8000_0000) and ar_b_mask
            end If
        else
            read_ar_b_value = data_low and ar_b_mask
        end If

    End Sub

    Sub write
        If flag_ar_b = &H0 Then read
        If flag_ar_b = &H0 Then write_ar_b_value = get_ar_b

        regValue = leftShift((write_ar_b_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ar_b_mask = &Hffff
        if data_low > LONG_MAX then
            if ar_b_mask = mask then
                read_ar_b_value = data_low
            else
                read_ar_b_value = (data_low - H8000_0000) and ar_b_mask
            end If
        else
            read_ar_b_value = data_low and ar_b_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ar_b_value = &H0
        flag_ar_b        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_ar_r_dap_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ar_r                                       [31:20]          get_ar_r
''                                                             set_ar_r
''                                                             read_ar_r
''                                                             write_ar_r
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_ar_r_dap_m
    Private write_ar_r_value
    Private read_ar_r_value
    Private flag_ar_r

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H612c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ar_r
        get_ar_r = read_ar_r_value
    End Property

    Property Let set_ar_r(aData)
        write_ar_r_value = aData
        flag_ar_r        = &H1
    End Property

    Property Get read_ar_r
        read
        read_ar_r = read_ar_r_value
    End Property

    Property Let write_ar_r(aData)
        set_ar_r = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ar_r_value = rightShift(data_low, 20) and &Hfff

    End Sub

    Sub write
        If flag_ar_r = &H0 Then read
        If flag_ar_r = &H0 Then write_ar_r_value = get_ar_r

        regValue = leftShift((write_ar_r_value and &Hfff), 20)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ar_r_value = rightShift(data_low, 20) and &Hfff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ar_r_value = &H0
        flag_ar_r        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_target_fc_dap_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ar_tgt_latency                             [27:16]          get_ar_tgt_latency
''                                                             set_ar_tgt_latency
''                                                             read_ar_tgt_latency
''                                                             write_ar_tgt_latency
''---------------------------------------------------------------------------------
'' aw_tgt_latency                             [11:0]           get_aw_tgt_latency
''                                                             set_aw_tgt_latency
''                                                             read_aw_tgt_latency
''                                                             write_aw_tgt_latency
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_target_fc_dap_m
    Private write_ar_tgt_latency_value
    Private read_ar_tgt_latency_value
    Private flag_ar_tgt_latency
    Private write_aw_tgt_latency_value
    Private read_aw_tgt_latency_value
    Private flag_aw_tgt_latency

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H6130
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ar_tgt_latency
        get_ar_tgt_latency = read_ar_tgt_latency_value
    End Property

    Property Let set_ar_tgt_latency(aData)
        write_ar_tgt_latency_value = aData
        flag_ar_tgt_latency        = &H1
    End Property

    Property Get read_ar_tgt_latency
        read
        read_ar_tgt_latency = read_ar_tgt_latency_value
    End Property

    Property Let write_ar_tgt_latency(aData)
        set_ar_tgt_latency = aData
        write
    End Property

    Property Get get_aw_tgt_latency
        get_aw_tgt_latency = read_aw_tgt_latency_value
    End Property

    Property Let set_aw_tgt_latency(aData)
        write_aw_tgt_latency_value = aData
        flag_aw_tgt_latency        = &H1
    End Property

    Property Get read_aw_tgt_latency
        read
        read_aw_tgt_latency = read_aw_tgt_latency_value
    End Property

    Property Let write_aw_tgt_latency(aData)
        set_aw_tgt_latency = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ar_tgt_latency_value = rightShift(data_low, 16) and &Hfff
        aw_tgt_latency_mask = &Hfff
        if data_low > LONG_MAX then
            if aw_tgt_latency_mask = mask then
                read_aw_tgt_latency_value = data_low
            else
                read_aw_tgt_latency_value = (data_low - H8000_0000) and aw_tgt_latency_mask
            end If
        else
            read_aw_tgt_latency_value = data_low and aw_tgt_latency_mask
        end If

    End Sub

    Sub write
        If flag_ar_tgt_latency = &H0 or flag_aw_tgt_latency = &H0 Then read
        If flag_ar_tgt_latency = &H0 Then write_ar_tgt_latency_value = get_ar_tgt_latency
        If flag_aw_tgt_latency = &H0 Then write_aw_tgt_latency_value = get_aw_tgt_latency

        regValue = leftShift((write_ar_tgt_latency_value and &Hfff), 16) + leftShift((write_aw_tgt_latency_value and &Hfff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ar_tgt_latency_value = rightShift(data_low, 16) and &Hfff
        aw_tgt_latency_mask = &Hfff
        if data_low > LONG_MAX then
            if aw_tgt_latency_mask = mask then
                read_aw_tgt_latency_value = data_low
            else
                read_aw_tgt_latency_value = (data_low - H8000_0000) and aw_tgt_latency_mask
            end If
        else
            read_aw_tgt_latency_value = data_low and aw_tgt_latency_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ar_tgt_latency_value = &H0
        flag_ar_tgt_latency        = &H0
        write_aw_tgt_latency_value = &H0
        flag_aw_tgt_latency        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_ki_fc_dap_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ar_ki                                      [10:8]           get_ar_ki
''                                                             set_ar_ki
''                                                             read_ar_ki
''                                                             write_ar_ki
''---------------------------------------------------------------------------------
'' aw_ki                                      [2:0]            get_aw_ki
''                                                             set_aw_ki
''                                                             read_aw_ki
''                                                             write_aw_ki
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_ki_fc_dap_m
    Private write_ar_ki_value
    Private read_ar_ki_value
    Private flag_ar_ki
    Private write_aw_ki_value
    Private read_aw_ki_value
    Private flag_aw_ki

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H6134
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ar_ki
        get_ar_ki = read_ar_ki_value
    End Property

    Property Let set_ar_ki(aData)
        write_ar_ki_value = aData
        flag_ar_ki        = &H1
    End Property

    Property Get read_ar_ki
        read
        read_ar_ki = read_ar_ki_value
    End Property

    Property Let write_ar_ki(aData)
        set_ar_ki = aData
        write
    End Property

    Property Get get_aw_ki
        get_aw_ki = read_aw_ki_value
    End Property

    Property Let set_aw_ki(aData)
        write_aw_ki_value = aData
        flag_aw_ki        = &H1
    End Property

    Property Get read_aw_ki
        read
        read_aw_ki = read_aw_ki_value
    End Property

    Property Let write_aw_ki(aData)
        set_aw_ki = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ar_ki_value = rightShift(data_low, 8) and &H7
        aw_ki_mask = &H7
        if data_low > LONG_MAX then
            if aw_ki_mask = mask then
                read_aw_ki_value = data_low
            else
                read_aw_ki_value = (data_low - H8000_0000) and aw_ki_mask
            end If
        else
            read_aw_ki_value = data_low and aw_ki_mask
        end If

    End Sub

    Sub write
        If flag_ar_ki = &H0 or flag_aw_ki = &H0 Then read
        If flag_ar_ki = &H0 Then write_ar_ki_value = get_ar_ki
        If flag_aw_ki = &H0 Then write_aw_ki_value = get_aw_ki

        regValue = leftShift((write_ar_ki_value and &H7), 8) + leftShift((write_aw_ki_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ar_ki_value = rightShift(data_low, 8) and &H7
        aw_ki_mask = &H7
        if data_low > LONG_MAX then
            if aw_ki_mask = mask then
                read_aw_ki_value = data_low
            else
                read_aw_ki_value = (data_low - H8000_0000) and aw_ki_mask
            end If
        else
            read_aw_ki_value = data_low and aw_ki_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ar_ki_value = &H0
        flag_ar_ki        = &H0
        write_aw_ki_value = &H0
        flag_aw_ki        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_qos_range_dap_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ar_max_qos                                 [27:24]          get_ar_max_qos
''                                                             set_ar_max_qos
''                                                             read_ar_max_qos
''                                                             write_ar_max_qos
''---------------------------------------------------------------------------------
'' ar_min_qos                                 [19:16]          get_ar_min_qos
''                                                             set_ar_min_qos
''                                                             read_ar_min_qos
''                                                             write_ar_min_qos
''---------------------------------------------------------------------------------
'' aw_max_qos                                 [11:8]           get_aw_max_qos
''                                                             set_aw_max_qos
''                                                             read_aw_max_qos
''                                                             write_aw_max_qos
''---------------------------------------------------------------------------------
'' aw_min_qos                                 [3:0]            get_aw_min_qos
''                                                             set_aw_min_qos
''                                                             read_aw_min_qos
''                                                             write_aw_min_qos
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_qos_range_dap_m
    Private write_ar_max_qos_value
    Private read_ar_max_qos_value
    Private flag_ar_max_qos
    Private write_ar_min_qos_value
    Private read_ar_min_qos_value
    Private flag_ar_min_qos
    Private write_aw_max_qos_value
    Private read_aw_max_qos_value
    Private flag_aw_max_qos
    Private write_aw_min_qos_value
    Private read_aw_min_qos_value
    Private flag_aw_min_qos

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H6138
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ar_max_qos
        get_ar_max_qos = read_ar_max_qos_value
    End Property

    Property Let set_ar_max_qos(aData)
        write_ar_max_qos_value = aData
        flag_ar_max_qos        = &H1
    End Property

    Property Get read_ar_max_qos
        read
        read_ar_max_qos = read_ar_max_qos_value
    End Property

    Property Let write_ar_max_qos(aData)
        set_ar_max_qos = aData
        write
    End Property

    Property Get get_ar_min_qos
        get_ar_min_qos = read_ar_min_qos_value
    End Property

    Property Let set_ar_min_qos(aData)
        write_ar_min_qos_value = aData
        flag_ar_min_qos        = &H1
    End Property

    Property Get read_ar_min_qos
        read
        read_ar_min_qos = read_ar_min_qos_value
    End Property

    Property Let write_ar_min_qos(aData)
        set_ar_min_qos = aData
        write
    End Property

    Property Get get_aw_max_qos
        get_aw_max_qos = read_aw_max_qos_value
    End Property

    Property Let set_aw_max_qos(aData)
        write_aw_max_qos_value = aData
        flag_aw_max_qos        = &H1
    End Property

    Property Get read_aw_max_qos
        read
        read_aw_max_qos = read_aw_max_qos_value
    End Property

    Property Let write_aw_max_qos(aData)
        set_aw_max_qos = aData
        write
    End Property

    Property Get get_aw_min_qos
        get_aw_min_qos = read_aw_min_qos_value
    End Property

    Property Let set_aw_min_qos(aData)
        write_aw_min_qos_value = aData
        flag_aw_min_qos        = &H1
    End Property

    Property Get read_aw_min_qos
        read
        read_aw_min_qos = read_aw_min_qos_value
    End Property

    Property Let write_aw_min_qos(aData)
        set_aw_min_qos = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ar_max_qos_value = rightShift(data_low, 24) and &Hf
        read_ar_min_qos_value = rightShift(data_low, 16) and &Hf
        read_aw_max_qos_value = rightShift(data_low, 8) and &Hf
        aw_min_qos_mask = &Hf
        if data_low > LONG_MAX then
            if aw_min_qos_mask = mask then
                read_aw_min_qos_value = data_low
            else
                read_aw_min_qos_value = (data_low - H8000_0000) and aw_min_qos_mask
            end If
        else
            read_aw_min_qos_value = data_low and aw_min_qos_mask
        end If

    End Sub

    Sub write
        If flag_ar_max_qos = &H0 or flag_ar_min_qos = &H0 or flag_aw_max_qos = &H0 or flag_aw_min_qos = &H0 Then read
        If flag_ar_max_qos = &H0 Then write_ar_max_qos_value = get_ar_max_qos
        If flag_ar_min_qos = &H0 Then write_ar_min_qos_value = get_ar_min_qos
        If flag_aw_max_qos = &H0 Then write_aw_max_qos_value = get_aw_max_qos
        If flag_aw_min_qos = &H0 Then write_aw_min_qos_value = get_aw_min_qos

        regValue = leftShift((write_ar_max_qos_value and &Hf), 24) + leftShift((write_ar_min_qos_value and &Hf), 16) + leftShift((write_aw_max_qos_value and &Hf), 8) + leftShift((write_aw_min_qos_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ar_max_qos_value = rightShift(data_low, 24) and &Hf
        read_ar_min_qos_value = rightShift(data_low, 16) and &Hf
        read_aw_max_qos_value = rightShift(data_low, 8) and &Hf
        aw_min_qos_mask = &Hf
        if data_low > LONG_MAX then
            if aw_min_qos_mask = mask then
                read_aw_min_qos_value = data_low
            else
                read_aw_min_qos_value = (data_low - H8000_0000) and aw_min_qos_mask
            end If
        else
            read_aw_min_qos_value = data_low and aw_min_qos_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ar_max_qos_value = &H0
        flag_ar_max_qos        = &H0
        write_ar_min_qos_value = &H0
        flag_ar_min_qos        = &H0
        write_aw_max_qos_value = &H0
        flag_aw_max_qos        = &H0
        write_aw_min_qos_value = &H0
        flag_aw_min_qos        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_fn_mod2_m7_ahbp_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' fn_mode2                                   [0:0]            get_fn_mode2
''                                                             set_fn_mode2
''                                                             read_fn_mode2
''                                                             write_fn_mode2
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_fn_mod2_m7_ahbp_m
    Private write_fn_mode2_value
    Private read_fn_mode2_value
    Private flag_fn_mode2

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H7024
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_fn_mode2
        get_fn_mode2 = read_fn_mode2_value
    End Property

    Property Let set_fn_mode2(aData)
        write_fn_mode2_value = aData
        flag_fn_mode2        = &H1
    End Property

    Property Get read_fn_mode2
        read
        read_fn_mode2 = read_fn_mode2_value
    End Property

    Property Let write_fn_mode2(aData)
        set_fn_mode2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        fn_mode2_mask = &H1
        if data_low > LONG_MAX then
            if fn_mode2_mask = mask then
                read_fn_mode2_value = data_low
            else
                read_fn_mode2_value = (data_low - H8000_0000) and fn_mode2_mask
            end If
        else
            read_fn_mode2_value = data_low and fn_mode2_mask
        end If

    End Sub

    Sub write
        If flag_fn_mode2 = &H0 Then read
        If flag_fn_mode2 = &H0 Then write_fn_mode2_value = get_fn_mode2

        regValue = leftShift((write_fn_mode2_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        fn_mode2_mask = &H1
        if data_low > LONG_MAX then
            if fn_mode2_mask = mask then
                read_fn_mode2_value = data_low
            else
                read_fn_mode2_value = (data_low - H8000_0000) and fn_mode2_mask
            end If
        else
            read_fn_mode2_value = data_low and fn_mode2_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_fn_mode2_value = &H0
        flag_fn_mode2        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_fn_mod_ahb_m7_ahbp_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' fn_mod_ahb                                 [1:0]            get_fn_mod_ahb
''                                                             set_fn_mod_ahb
''                                                             read_fn_mod_ahb
''                                                             write_fn_mod_ahb
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_fn_mod_ahb_m7_ahbp_m
    Private write_fn_mod_ahb_value
    Private read_fn_mod_ahb_value
    Private flag_fn_mod_ahb

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H7028
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_fn_mod_ahb
        get_fn_mod_ahb = read_fn_mod_ahb_value
    End Property

    Property Let set_fn_mod_ahb(aData)
        write_fn_mod_ahb_value = aData
        flag_fn_mod_ahb        = &H1
    End Property

    Property Get read_fn_mod_ahb
        read
        read_fn_mod_ahb = read_fn_mod_ahb_value
    End Property

    Property Let write_fn_mod_ahb(aData)
        set_fn_mod_ahb = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        fn_mod_ahb_mask = &H3
        if data_low > LONG_MAX then
            if fn_mod_ahb_mask = mask then
                read_fn_mod_ahb_value = data_low
            else
                read_fn_mod_ahb_value = (data_low - H8000_0000) and fn_mod_ahb_mask
            end If
        else
            read_fn_mod_ahb_value = data_low and fn_mod_ahb_mask
        end If

    End Sub

    Sub write
        If flag_fn_mod_ahb = &H0 Then read
        If flag_fn_mod_ahb = &H0 Then write_fn_mod_ahb_value = get_fn_mod_ahb

        regValue = leftShift((write_fn_mod_ahb_value and &H3), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        fn_mod_ahb_mask = &H3
        if data_low > LONG_MAX then
            if fn_mod_ahb_mask = mask then
                read_fn_mod_ahb_value = data_low
            else
                read_fn_mod_ahb_value = (data_low - H8000_0000) and fn_mod_ahb_mask
            end If
        else
            read_fn_mod_ahb_value = data_low and fn_mod_ahb_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_fn_mod_ahb_value = &H0
        flag_fn_mod_ahb        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_read_qos_m7_ahbp_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' read_qos                                   [3:0]            get_read_qos
''                                                             set_read_qos
''                                                             read_read_qos
''                                                             write_read_qos
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_read_qos_m7_ahbp_m
    Private write_read_qos_value
    Private read_read_qos_value
    Private flag_read_qos

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H7100
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_read_qos
        get_read_qos = read_read_qos_value
    End Property

    Property Let set_read_qos(aData)
        write_read_qos_value = aData
        flag_read_qos        = &H1
    End Property

    Property Get read_read_qos
        read
        read_read_qos = read_read_qos_value
    End Property

    Property Let write_read_qos(aData)
        set_read_qos = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_qos_mask = &Hf
        if data_low > LONG_MAX then
            if read_qos_mask = mask then
                read_read_qos_value = data_low
            else
                read_read_qos_value = (data_low - H8000_0000) and read_qos_mask
            end If
        else
            read_read_qos_value = data_low and read_qos_mask
        end If

    End Sub

    Sub write
        If flag_read_qos = &H0 Then read
        If flag_read_qos = &H0 Then write_read_qos_value = get_read_qos

        regValue = leftShift((write_read_qos_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_qos_mask = &Hf
        if data_low > LONG_MAX then
            if read_qos_mask = mask then
                read_read_qos_value = data_low
            else
                read_read_qos_value = (data_low - H8000_0000) and read_qos_mask
            end If
        else
            read_read_qos_value = data_low and read_qos_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_read_qos_value = &H0
        flag_read_qos        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_write_qos_m7_ahbp_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' write_qos                                  [3:0]            get_write_qos
''                                                             set_write_qos
''                                                             read_write_qos
''                                                             write_write_qos
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_write_qos_m7_ahbp_m
    Private write_write_qos_value
    Private read_write_qos_value
    Private flag_write_qos

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H7104
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_write_qos
        get_write_qos = read_write_qos_value
    End Property

    Property Let set_write_qos(aData)
        write_write_qos_value = aData
        flag_write_qos        = &H1
    End Property

    Property Get read_write_qos
        read
        read_write_qos = read_write_qos_value
    End Property

    Property Let write_write_qos(aData)
        set_write_qos = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        write_qos_mask = &Hf
        if data_low > LONG_MAX then
            if write_qos_mask = mask then
                read_write_qos_value = data_low
            else
                read_write_qos_value = (data_low - H8000_0000) and write_qos_mask
            end If
        else
            read_write_qos_value = data_low and write_qos_mask
        end If

    End Sub

    Sub write
        If flag_write_qos = &H0 Then read
        If flag_write_qos = &H0 Then write_write_qos_value = get_write_qos

        regValue = leftShift((write_write_qos_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        write_qos_mask = &Hf
        if data_low > LONG_MAX then
            if write_qos_mask = mask then
                read_write_qos_value = data_low
            else
                read_write_qos_value = (data_low - H8000_0000) and write_qos_mask
            end If
        else
            read_write_qos_value = data_low and write_qos_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_write_qos_value = &H0
        flag_write_qos        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_fn_mod_m7_ahbp_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' fn_mod                                     [1:0]            get_fn_mod
''                                                             set_fn_mod
''                                                             read_fn_mod
''                                                             write_fn_mod
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_fn_mod_m7_ahbp_m
    Private write_fn_mod_value
    Private read_fn_mod_value
    Private flag_fn_mod

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H7108
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_fn_mod
        get_fn_mod = read_fn_mod_value
    End Property

    Property Let set_fn_mod(aData)
        write_fn_mod_value = aData
        flag_fn_mod        = &H1
    End Property

    Property Get read_fn_mod
        read
        read_fn_mod = read_fn_mod_value
    End Property

    Property Let write_fn_mod(aData)
        set_fn_mod = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        fn_mod_mask = &H3
        if data_low > LONG_MAX then
            if fn_mod_mask = mask then
                read_fn_mod_value = data_low
            else
                read_fn_mod_value = (data_low - H8000_0000) and fn_mod_mask
            end If
        else
            read_fn_mod_value = data_low and fn_mod_mask
        end If

    End Sub

    Sub write
        If flag_fn_mod = &H0 Then read
        If flag_fn_mod = &H0 Then write_fn_mod_value = get_fn_mod

        regValue = leftShift((write_fn_mod_value and &H3), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        fn_mod_mask = &H3
        if data_low > LONG_MAX then
            if fn_mod_mask = mask then
                read_fn_mod_value = data_low
            else
                read_fn_mod_value = (data_low - H8000_0000) and fn_mod_mask
            end If
        else
            read_fn_mod_value = data_low and fn_mod_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_fn_mod_value = &H0
        flag_fn_mod        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_qos_cntl_m7_ahbp_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mode_ar_fc                                 [20:20]          get_mode_ar_fc
''                                                             set_mode_ar_fc
''                                                             read_mode_ar_fc
''                                                             write_mode_ar_fc
''---------------------------------------------------------------------------------
'' mode_aw_fc                                 [16:16]          get_mode_aw_fc
''                                                             set_mode_aw_fc
''                                                             read_mode_aw_fc
''                                                             write_mode_aw_fc
''---------------------------------------------------------------------------------
'' en_awar_ot                                 [7:7]            get_en_awar_ot
''                                                             set_en_awar_ot
''                                                             read_en_awar_ot
''                                                             write_en_awar_ot
''---------------------------------------------------------------------------------
'' en_ar_ot                                   [6:6]            get_en_ar_ot
''                                                             set_en_ar_ot
''                                                             read_en_ar_ot
''                                                             write_en_ar_ot
''---------------------------------------------------------------------------------
'' en_aw_ot                                   [5:5]            get_en_aw_ot
''                                                             set_en_aw_ot
''                                                             read_en_aw_ot
''                                                             write_en_aw_ot
''---------------------------------------------------------------------------------
'' en_ar_fc                                   [4:4]            get_en_ar_fc
''                                                             set_en_ar_fc
''                                                             read_en_ar_fc
''                                                             write_en_ar_fc
''---------------------------------------------------------------------------------
'' en_aw_fc                                   [3:3]            get_en_aw_fc
''                                                             set_en_aw_fc
''                                                             read_en_aw_fc
''                                                             write_en_aw_fc
''---------------------------------------------------------------------------------
'' en_awar_rate                               [2:2]            get_en_awar_rate
''                                                             set_en_awar_rate
''                                                             read_en_awar_rate
''                                                             write_en_awar_rate
''---------------------------------------------------------------------------------
'' en_ar_rate                                 [1:1]            get_en_ar_rate
''                                                             set_en_ar_rate
''                                                             read_en_ar_rate
''                                                             write_en_ar_rate
''---------------------------------------------------------------------------------
'' en_aw_rate                                 [0:0]            get_en_aw_rate
''                                                             set_en_aw_rate
''                                                             read_en_aw_rate
''                                                             write_en_aw_rate
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_qos_cntl_m7_ahbp_m
    Private write_mode_ar_fc_value
    Private read_mode_ar_fc_value
    Private flag_mode_ar_fc
    Private write_mode_aw_fc_value
    Private read_mode_aw_fc_value
    Private flag_mode_aw_fc
    Private write_en_awar_ot_value
    Private read_en_awar_ot_value
    Private flag_en_awar_ot
    Private write_en_ar_ot_value
    Private read_en_ar_ot_value
    Private flag_en_ar_ot
    Private write_en_aw_ot_value
    Private read_en_aw_ot_value
    Private flag_en_aw_ot
    Private write_en_ar_fc_value
    Private read_en_ar_fc_value
    Private flag_en_ar_fc
    Private write_en_aw_fc_value
    Private read_en_aw_fc_value
    Private flag_en_aw_fc
    Private write_en_awar_rate_value
    Private read_en_awar_rate_value
    Private flag_en_awar_rate
    Private write_en_ar_rate_value
    Private read_en_ar_rate_value
    Private flag_en_ar_rate
    Private write_en_aw_rate_value
    Private read_en_aw_rate_value
    Private flag_en_aw_rate

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H710c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mode_ar_fc
        get_mode_ar_fc = read_mode_ar_fc_value
    End Property

    Property Let set_mode_ar_fc(aData)
        write_mode_ar_fc_value = aData
        flag_mode_ar_fc        = &H1
    End Property

    Property Get read_mode_ar_fc
        read
        read_mode_ar_fc = read_mode_ar_fc_value
    End Property

    Property Let write_mode_ar_fc(aData)
        set_mode_ar_fc = aData
        write
    End Property

    Property Get get_mode_aw_fc
        get_mode_aw_fc = read_mode_aw_fc_value
    End Property

    Property Let set_mode_aw_fc(aData)
        write_mode_aw_fc_value = aData
        flag_mode_aw_fc        = &H1
    End Property

    Property Get read_mode_aw_fc
        read
        read_mode_aw_fc = read_mode_aw_fc_value
    End Property

    Property Let write_mode_aw_fc(aData)
        set_mode_aw_fc = aData
        write
    End Property

    Property Get get_en_awar_ot
        get_en_awar_ot = read_en_awar_ot_value
    End Property

    Property Let set_en_awar_ot(aData)
        write_en_awar_ot_value = aData
        flag_en_awar_ot        = &H1
    End Property

    Property Get read_en_awar_ot
        read
        read_en_awar_ot = read_en_awar_ot_value
    End Property

    Property Let write_en_awar_ot(aData)
        set_en_awar_ot = aData
        write
    End Property

    Property Get get_en_ar_ot
        get_en_ar_ot = read_en_ar_ot_value
    End Property

    Property Let set_en_ar_ot(aData)
        write_en_ar_ot_value = aData
        flag_en_ar_ot        = &H1
    End Property

    Property Get read_en_ar_ot
        read
        read_en_ar_ot = read_en_ar_ot_value
    End Property

    Property Let write_en_ar_ot(aData)
        set_en_ar_ot = aData
        write
    End Property

    Property Get get_en_aw_ot
        get_en_aw_ot = read_en_aw_ot_value
    End Property

    Property Let set_en_aw_ot(aData)
        write_en_aw_ot_value = aData
        flag_en_aw_ot        = &H1
    End Property

    Property Get read_en_aw_ot
        read
        read_en_aw_ot = read_en_aw_ot_value
    End Property

    Property Let write_en_aw_ot(aData)
        set_en_aw_ot = aData
        write
    End Property

    Property Get get_en_ar_fc
        get_en_ar_fc = read_en_ar_fc_value
    End Property

    Property Let set_en_ar_fc(aData)
        write_en_ar_fc_value = aData
        flag_en_ar_fc        = &H1
    End Property

    Property Get read_en_ar_fc
        read
        read_en_ar_fc = read_en_ar_fc_value
    End Property

    Property Let write_en_ar_fc(aData)
        set_en_ar_fc = aData
        write
    End Property

    Property Get get_en_aw_fc
        get_en_aw_fc = read_en_aw_fc_value
    End Property

    Property Let set_en_aw_fc(aData)
        write_en_aw_fc_value = aData
        flag_en_aw_fc        = &H1
    End Property

    Property Get read_en_aw_fc
        read
        read_en_aw_fc = read_en_aw_fc_value
    End Property

    Property Let write_en_aw_fc(aData)
        set_en_aw_fc = aData
        write
    End Property

    Property Get get_en_awar_rate
        get_en_awar_rate = read_en_awar_rate_value
    End Property

    Property Let set_en_awar_rate(aData)
        write_en_awar_rate_value = aData
        flag_en_awar_rate        = &H1
    End Property

    Property Get read_en_awar_rate
        read
        read_en_awar_rate = read_en_awar_rate_value
    End Property

    Property Let write_en_awar_rate(aData)
        set_en_awar_rate = aData
        write
    End Property

    Property Get get_en_ar_rate
        get_en_ar_rate = read_en_ar_rate_value
    End Property

    Property Let set_en_ar_rate(aData)
        write_en_ar_rate_value = aData
        flag_en_ar_rate        = &H1
    End Property

    Property Get read_en_ar_rate
        read
        read_en_ar_rate = read_en_ar_rate_value
    End Property

    Property Let write_en_ar_rate(aData)
        set_en_ar_rate = aData
        write
    End Property

    Property Get get_en_aw_rate
        get_en_aw_rate = read_en_aw_rate_value
    End Property

    Property Let set_en_aw_rate(aData)
        write_en_aw_rate_value = aData
        flag_en_aw_rate        = &H1
    End Property

    Property Get read_en_aw_rate
        read
        read_en_aw_rate = read_en_aw_rate_value
    End Property

    Property Let write_en_aw_rate(aData)
        set_en_aw_rate = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_mode_ar_fc_value = rightShift(data_low, 20) and &H1
        read_mode_aw_fc_value = rightShift(data_low, 16) and &H1
        read_en_awar_ot_value = rightShift(data_low, 7) and &H1
        read_en_ar_ot_value = rightShift(data_low, 6) and &H1
        read_en_aw_ot_value = rightShift(data_low, 5) and &H1
        read_en_ar_fc_value = rightShift(data_low, 4) and &H1
        read_en_aw_fc_value = rightShift(data_low, 3) and &H1
        read_en_awar_rate_value = rightShift(data_low, 2) and &H1
        read_en_ar_rate_value = rightShift(data_low, 1) and &H1
        en_aw_rate_mask = &H1
        if data_low > LONG_MAX then
            if en_aw_rate_mask = mask then
                read_en_aw_rate_value = data_low
            else
                read_en_aw_rate_value = (data_low - H8000_0000) and en_aw_rate_mask
            end If
        else
            read_en_aw_rate_value = data_low and en_aw_rate_mask
        end If

    End Sub

    Sub write
        If flag_mode_ar_fc = &H0 or flag_mode_aw_fc = &H0 or flag_en_awar_ot = &H0 or flag_en_ar_ot = &H0 or flag_en_aw_ot = &H0 or flag_en_ar_fc = &H0 or flag_en_aw_fc = &H0 or flag_en_awar_rate = &H0 or flag_en_ar_rate = &H0 or flag_en_aw_rate = &H0 Then read
        If flag_mode_ar_fc = &H0 Then write_mode_ar_fc_value = get_mode_ar_fc
        If flag_mode_aw_fc = &H0 Then write_mode_aw_fc_value = get_mode_aw_fc
        If flag_en_awar_ot = &H0 Then write_en_awar_ot_value = get_en_awar_ot
        If flag_en_ar_ot = &H0 Then write_en_ar_ot_value = get_en_ar_ot
        If flag_en_aw_ot = &H0 Then write_en_aw_ot_value = get_en_aw_ot
        If flag_en_ar_fc = &H0 Then write_en_ar_fc_value = get_en_ar_fc
        If flag_en_aw_fc = &H0 Then write_en_aw_fc_value = get_en_aw_fc
        If flag_en_awar_rate = &H0 Then write_en_awar_rate_value = get_en_awar_rate
        If flag_en_ar_rate = &H0 Then write_en_ar_rate_value = get_en_ar_rate
        If flag_en_aw_rate = &H0 Then write_en_aw_rate_value = get_en_aw_rate

        regValue = leftShift((write_mode_ar_fc_value and &H1), 20) + leftShift((write_mode_aw_fc_value and &H1), 16) + leftShift((write_en_awar_ot_value and &H1), 7) + leftShift((write_en_ar_ot_value and &H1), 6) + leftShift((write_en_aw_ot_value and &H1), 5) + leftShift((write_en_ar_fc_value and &H1), 4) + leftShift((write_en_aw_fc_value and &H1), 3) + leftShift((write_en_awar_rate_value and &H1), 2) + leftShift((write_en_ar_rate_value and &H1), 1) + leftShift((write_en_aw_rate_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_mode_ar_fc_value = rightShift(data_low, 20) and &H1
        read_mode_aw_fc_value = rightShift(data_low, 16) and &H1
        read_en_awar_ot_value = rightShift(data_low, 7) and &H1
        read_en_ar_ot_value = rightShift(data_low, 6) and &H1
        read_en_aw_ot_value = rightShift(data_low, 5) and &H1
        read_en_ar_fc_value = rightShift(data_low, 4) and &H1
        read_en_aw_fc_value = rightShift(data_low, 3) and &H1
        read_en_awar_rate_value = rightShift(data_low, 2) and &H1
        read_en_ar_rate_value = rightShift(data_low, 1) and &H1
        en_aw_rate_mask = &H1
        if data_low > LONG_MAX then
            if en_aw_rate_mask = mask then
                read_en_aw_rate_value = data_low
            else
                read_en_aw_rate_value = (data_low - H8000_0000) and en_aw_rate_mask
            end If
        else
            read_en_aw_rate_value = data_low and en_aw_rate_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mode_ar_fc_value = &H0
        flag_mode_ar_fc        = &H0
        write_mode_aw_fc_value = &H0
        flag_mode_aw_fc        = &H0
        write_en_awar_ot_value = &H0
        flag_en_awar_ot        = &H0
        write_en_ar_ot_value = &H0
        flag_en_ar_ot        = &H0
        write_en_aw_ot_value = &H0
        flag_en_aw_ot        = &H0
        write_en_ar_fc_value = &H0
        flag_en_ar_fc        = &H0
        write_en_aw_fc_value = &H0
        flag_en_aw_fc        = &H0
        write_en_awar_rate_value = &H0
        flag_en_awar_rate        = &H0
        write_en_ar_rate_value = &H0
        flag_en_ar_rate        = &H0
        write_en_aw_rate_value = &H0
        flag_en_aw_rate        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_max_ot_m7_ahbp_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ar_max_oti                                 [29:24]          get_ar_max_oti
''                                                             set_ar_max_oti
''                                                             read_ar_max_oti
''                                                             write_ar_max_oti
''---------------------------------------------------------------------------------
'' ar_max_otf                                 [23:16]          get_ar_max_otf
''                                                             set_ar_max_otf
''                                                             read_ar_max_otf
''                                                             write_ar_max_otf
''---------------------------------------------------------------------------------
'' aw_max_oti                                 [13:8]           get_aw_max_oti
''                                                             set_aw_max_oti
''                                                             read_aw_max_oti
''                                                             write_aw_max_oti
''---------------------------------------------------------------------------------
'' en_ar_ot                                   [7:0]            get_en_ar_ot
''                                                             set_en_ar_ot
''                                                             read_en_ar_ot
''                                                             write_en_ar_ot
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_max_ot_m7_ahbp_m
    Private write_ar_max_oti_value
    Private read_ar_max_oti_value
    Private flag_ar_max_oti
    Private write_ar_max_otf_value
    Private read_ar_max_otf_value
    Private flag_ar_max_otf
    Private write_aw_max_oti_value
    Private read_aw_max_oti_value
    Private flag_aw_max_oti
    Private write_en_ar_ot_value
    Private read_en_ar_ot_value
    Private flag_en_ar_ot

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H7110
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ar_max_oti
        get_ar_max_oti = read_ar_max_oti_value
    End Property

    Property Let set_ar_max_oti(aData)
        write_ar_max_oti_value = aData
        flag_ar_max_oti        = &H1
    End Property

    Property Get read_ar_max_oti
        read
        read_ar_max_oti = read_ar_max_oti_value
    End Property

    Property Let write_ar_max_oti(aData)
        set_ar_max_oti = aData
        write
    End Property

    Property Get get_ar_max_otf
        get_ar_max_otf = read_ar_max_otf_value
    End Property

    Property Let set_ar_max_otf(aData)
        write_ar_max_otf_value = aData
        flag_ar_max_otf        = &H1
    End Property

    Property Get read_ar_max_otf
        read
        read_ar_max_otf = read_ar_max_otf_value
    End Property

    Property Let write_ar_max_otf(aData)
        set_ar_max_otf = aData
        write
    End Property

    Property Get get_aw_max_oti
        get_aw_max_oti = read_aw_max_oti_value
    End Property

    Property Let set_aw_max_oti(aData)
        write_aw_max_oti_value = aData
        flag_aw_max_oti        = &H1
    End Property

    Property Get read_aw_max_oti
        read
        read_aw_max_oti = read_aw_max_oti_value
    End Property

    Property Let write_aw_max_oti(aData)
        set_aw_max_oti = aData
        write
    End Property

    Property Get get_en_ar_ot
        get_en_ar_ot = read_en_ar_ot_value
    End Property

    Property Let set_en_ar_ot(aData)
        write_en_ar_ot_value = aData
        flag_en_ar_ot        = &H1
    End Property

    Property Get read_en_ar_ot
        read
        read_en_ar_ot = read_en_ar_ot_value
    End Property

    Property Let write_en_ar_ot(aData)
        set_en_ar_ot = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ar_max_oti_value = rightShift(data_low, 24) and &H3f
        read_ar_max_otf_value = rightShift(data_low, 16) and &Hff
        read_aw_max_oti_value = rightShift(data_low, 8) and &H3f
        en_ar_ot_mask = &Hff
        if data_low > LONG_MAX then
            if en_ar_ot_mask = mask then
                read_en_ar_ot_value = data_low
            else
                read_en_ar_ot_value = (data_low - H8000_0000) and en_ar_ot_mask
            end If
        else
            read_en_ar_ot_value = data_low and en_ar_ot_mask
        end If

    End Sub

    Sub write
        If flag_ar_max_oti = &H0 or flag_ar_max_otf = &H0 or flag_aw_max_oti = &H0 or flag_en_ar_ot = &H0 Then read
        If flag_ar_max_oti = &H0 Then write_ar_max_oti_value = get_ar_max_oti
        If flag_ar_max_otf = &H0 Then write_ar_max_otf_value = get_ar_max_otf
        If flag_aw_max_oti = &H0 Then write_aw_max_oti_value = get_aw_max_oti
        If flag_en_ar_ot = &H0 Then write_en_ar_ot_value = get_en_ar_ot

        regValue = leftShift((write_ar_max_oti_value and &H3f), 24) + leftShift((write_ar_max_otf_value and &Hff), 16) + leftShift((write_aw_max_oti_value and &H3f), 8) + leftShift((write_en_ar_ot_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ar_max_oti_value = rightShift(data_low, 24) and &H3f
        read_ar_max_otf_value = rightShift(data_low, 16) and &Hff
        read_aw_max_oti_value = rightShift(data_low, 8) and &H3f
        en_ar_ot_mask = &Hff
        if data_low > LONG_MAX then
            if en_ar_ot_mask = mask then
                read_en_ar_ot_value = data_low
            else
                read_en_ar_ot_value = (data_low - H8000_0000) and en_ar_ot_mask
            end If
        else
            read_en_ar_ot_value = data_low and en_ar_ot_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ar_max_oti_value = &H0
        flag_ar_max_oti        = &H0
        write_ar_max_otf_value = &H0
        flag_ar_max_otf        = &H0
        write_aw_max_oti_value = &H0
        flag_aw_max_oti        = &H0
        write_en_ar_ot_value = &H0
        flag_en_ar_ot        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_max_comb_ot_m7_ahbp_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' awar_max_oti                               [14:8]           get_awar_max_oti
''                                                             set_awar_max_oti
''                                                             read_awar_max_oti
''                                                             write_awar_max_oti
''---------------------------------------------------------------------------------
'' awar_max_otf                               [7:0]            get_awar_max_otf
''                                                             set_awar_max_otf
''                                                             read_awar_max_otf
''                                                             write_awar_max_otf
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_max_comb_ot_m7_ahbp_m
    Private write_awar_max_oti_value
    Private read_awar_max_oti_value
    Private flag_awar_max_oti
    Private write_awar_max_otf_value
    Private read_awar_max_otf_value
    Private flag_awar_max_otf

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H7114
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_awar_max_oti
        get_awar_max_oti = read_awar_max_oti_value
    End Property

    Property Let set_awar_max_oti(aData)
        write_awar_max_oti_value = aData
        flag_awar_max_oti        = &H1
    End Property

    Property Get read_awar_max_oti
        read
        read_awar_max_oti = read_awar_max_oti_value
    End Property

    Property Let write_awar_max_oti(aData)
        set_awar_max_oti = aData
        write
    End Property

    Property Get get_awar_max_otf
        get_awar_max_otf = read_awar_max_otf_value
    End Property

    Property Let set_awar_max_otf(aData)
        write_awar_max_otf_value = aData
        flag_awar_max_otf        = &H1
    End Property

    Property Get read_awar_max_otf
        read
        read_awar_max_otf = read_awar_max_otf_value
    End Property

    Property Let write_awar_max_otf(aData)
        set_awar_max_otf = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_awar_max_oti_value = rightShift(data_low, 8) and &H7f
        awar_max_otf_mask = &Hff
        if data_low > LONG_MAX then
            if awar_max_otf_mask = mask then
                read_awar_max_otf_value = data_low
            else
                read_awar_max_otf_value = (data_low - H8000_0000) and awar_max_otf_mask
            end If
        else
            read_awar_max_otf_value = data_low and awar_max_otf_mask
        end If

    End Sub

    Sub write
        If flag_awar_max_oti = &H0 or flag_awar_max_otf = &H0 Then read
        If flag_awar_max_oti = &H0 Then write_awar_max_oti_value = get_awar_max_oti
        If flag_awar_max_otf = &H0 Then write_awar_max_otf_value = get_awar_max_otf

        regValue = leftShift((write_awar_max_oti_value and &H7f), 8) + leftShift((write_awar_max_otf_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_awar_max_oti_value = rightShift(data_low, 8) and &H7f
        awar_max_otf_mask = &Hff
        if data_low > LONG_MAX then
            if awar_max_otf_mask = mask then
                read_awar_max_otf_value = data_low
            else
                read_awar_max_otf_value = (data_low - H8000_0000) and awar_max_otf_mask
            end If
        else
            read_awar_max_otf_value = data_low and awar_max_otf_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_awar_max_oti_value = &H0
        flag_awar_max_oti        = &H0
        write_awar_max_otf_value = &H0
        flag_awar_max_otf        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_aw_p_m7_ahbp_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' aw_p                                       [31:24]          get_aw_p
''                                                             set_aw_p
''                                                             read_aw_p
''                                                             write_aw_p
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_aw_p_m7_ahbp_m
    Private write_aw_p_value
    Private read_aw_p_value
    Private flag_aw_p

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H7118
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_aw_p
        get_aw_p = read_aw_p_value
    End Property

    Property Let set_aw_p(aData)
        write_aw_p_value = aData
        flag_aw_p        = &H1
    End Property

    Property Get read_aw_p
        read
        read_aw_p = read_aw_p_value
    End Property

    Property Let write_aw_p(aData)
        set_aw_p = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_aw_p_value = rightShift(data_low, 24) and &Hff

    End Sub

    Sub write
        If flag_aw_p = &H0 Then read
        If flag_aw_p = &H0 Then write_aw_p_value = get_aw_p

        regValue = leftShift((write_aw_p_value and &Hff), 24)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_aw_p_value = rightShift(data_low, 24) and &Hff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_aw_p_value = &H0
        flag_aw_p        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_aw_b_m7_ahbp_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' aw_b                                       [15:0]           get_aw_b
''                                                             set_aw_b
''                                                             read_aw_b
''                                                             write_aw_b
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_aw_b_m7_ahbp_m
    Private write_aw_b_value
    Private read_aw_b_value
    Private flag_aw_b

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H711c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_aw_b
        get_aw_b = read_aw_b_value
    End Property

    Property Let set_aw_b(aData)
        write_aw_b_value = aData
        flag_aw_b        = &H1
    End Property

    Property Get read_aw_b
        read
        read_aw_b = read_aw_b_value
    End Property

    Property Let write_aw_b(aData)
        set_aw_b = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        aw_b_mask = &Hffff
        if data_low > LONG_MAX then
            if aw_b_mask = mask then
                read_aw_b_value = data_low
            else
                read_aw_b_value = (data_low - H8000_0000) and aw_b_mask
            end If
        else
            read_aw_b_value = data_low and aw_b_mask
        end If

    End Sub

    Sub write
        If flag_aw_b = &H0 Then read
        If flag_aw_b = &H0 Then write_aw_b_value = get_aw_b

        regValue = leftShift((write_aw_b_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        aw_b_mask = &Hffff
        if data_low > LONG_MAX then
            if aw_b_mask = mask then
                read_aw_b_value = data_low
            else
                read_aw_b_value = (data_low - H8000_0000) and aw_b_mask
            end If
        else
            read_aw_b_value = data_low and aw_b_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_aw_b_value = &H0
        flag_aw_b        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_aw_r_m7_ahbp_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' aw_r                                       [31:20]          get_aw_r
''                                                             set_aw_r
''                                                             read_aw_r
''                                                             write_aw_r
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_aw_r_m7_ahbp_m
    Private write_aw_r_value
    Private read_aw_r_value
    Private flag_aw_r

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H7120
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_aw_r
        get_aw_r = read_aw_r_value
    End Property

    Property Let set_aw_r(aData)
        write_aw_r_value = aData
        flag_aw_r        = &H1
    End Property

    Property Get read_aw_r
        read
        read_aw_r = read_aw_r_value
    End Property

    Property Let write_aw_r(aData)
        set_aw_r = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_aw_r_value = rightShift(data_low, 20) and &Hfff

    End Sub

    Sub write
        If flag_aw_r = &H0 Then read
        If flag_aw_r = &H0 Then write_aw_r_value = get_aw_r

        regValue = leftShift((write_aw_r_value and &Hfff), 20)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_aw_r_value = rightShift(data_low, 20) and &Hfff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_aw_r_value = &H0
        flag_aw_r        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_ar_p_m7_ahbp_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ar_p                                       [31:24]          get_ar_p
''                                                             set_ar_p
''                                                             read_ar_p
''                                                             write_ar_p
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_ar_p_m7_ahbp_m
    Private write_ar_p_value
    Private read_ar_p_value
    Private flag_ar_p

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H7124
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ar_p
        get_ar_p = read_ar_p_value
    End Property

    Property Let set_ar_p(aData)
        write_ar_p_value = aData
        flag_ar_p        = &H1
    End Property

    Property Get read_ar_p
        read
        read_ar_p = read_ar_p_value
    End Property

    Property Let write_ar_p(aData)
        set_ar_p = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ar_p_value = rightShift(data_low, 24) and &Hff

    End Sub

    Sub write
        If flag_ar_p = &H0 Then read
        If flag_ar_p = &H0 Then write_ar_p_value = get_ar_p

        regValue = leftShift((write_ar_p_value and &Hff), 24)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ar_p_value = rightShift(data_low, 24) and &Hff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ar_p_value = &H0
        flag_ar_p        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_ar_b_m7_ahbp_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ar_b                                       [15:0]           get_ar_b
''                                                             set_ar_b
''                                                             read_ar_b
''                                                             write_ar_b
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_ar_b_m7_ahbp_m
    Private write_ar_b_value
    Private read_ar_b_value
    Private flag_ar_b

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H7128
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ar_b
        get_ar_b = read_ar_b_value
    End Property

    Property Let set_ar_b(aData)
        write_ar_b_value = aData
        flag_ar_b        = &H1
    End Property

    Property Get read_ar_b
        read
        read_ar_b = read_ar_b_value
    End Property

    Property Let write_ar_b(aData)
        set_ar_b = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ar_b_mask = &Hffff
        if data_low > LONG_MAX then
            if ar_b_mask = mask then
                read_ar_b_value = data_low
            else
                read_ar_b_value = (data_low - H8000_0000) and ar_b_mask
            end If
        else
            read_ar_b_value = data_low and ar_b_mask
        end If

    End Sub

    Sub write
        If flag_ar_b = &H0 Then read
        If flag_ar_b = &H0 Then write_ar_b_value = get_ar_b

        regValue = leftShift((write_ar_b_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ar_b_mask = &Hffff
        if data_low > LONG_MAX then
            if ar_b_mask = mask then
                read_ar_b_value = data_low
            else
                read_ar_b_value = (data_low - H8000_0000) and ar_b_mask
            end If
        else
            read_ar_b_value = data_low and ar_b_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ar_b_value = &H0
        flag_ar_b        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_ar_r_m7_ahbp_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ar_r                                       [31:20]          get_ar_r
''                                                             set_ar_r
''                                                             read_ar_r
''                                                             write_ar_r
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_ar_r_m7_ahbp_m
    Private write_ar_r_value
    Private read_ar_r_value
    Private flag_ar_r

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H712c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ar_r
        get_ar_r = read_ar_r_value
    End Property

    Property Let set_ar_r(aData)
        write_ar_r_value = aData
        flag_ar_r        = &H1
    End Property

    Property Get read_ar_r
        read
        read_ar_r = read_ar_r_value
    End Property

    Property Let write_ar_r(aData)
        set_ar_r = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ar_r_value = rightShift(data_low, 20) and &Hfff

    End Sub

    Sub write
        If flag_ar_r = &H0 Then read
        If flag_ar_r = &H0 Then write_ar_r_value = get_ar_r

        regValue = leftShift((write_ar_r_value and &Hfff), 20)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ar_r_value = rightShift(data_low, 20) and &Hfff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ar_r_value = &H0
        flag_ar_r        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_target_fc_m7_ahbp_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ar_tgt_latency                             [27:16]          get_ar_tgt_latency
''                                                             set_ar_tgt_latency
''                                                             read_ar_tgt_latency
''                                                             write_ar_tgt_latency
''---------------------------------------------------------------------------------
'' aw_tgt_latency                             [11:0]           get_aw_tgt_latency
''                                                             set_aw_tgt_latency
''                                                             read_aw_tgt_latency
''                                                             write_aw_tgt_latency
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_target_fc_m7_ahbp_m
    Private write_ar_tgt_latency_value
    Private read_ar_tgt_latency_value
    Private flag_ar_tgt_latency
    Private write_aw_tgt_latency_value
    Private read_aw_tgt_latency_value
    Private flag_aw_tgt_latency

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H7130
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ar_tgt_latency
        get_ar_tgt_latency = read_ar_tgt_latency_value
    End Property

    Property Let set_ar_tgt_latency(aData)
        write_ar_tgt_latency_value = aData
        flag_ar_tgt_latency        = &H1
    End Property

    Property Get read_ar_tgt_latency
        read
        read_ar_tgt_latency = read_ar_tgt_latency_value
    End Property

    Property Let write_ar_tgt_latency(aData)
        set_ar_tgt_latency = aData
        write
    End Property

    Property Get get_aw_tgt_latency
        get_aw_tgt_latency = read_aw_tgt_latency_value
    End Property

    Property Let set_aw_tgt_latency(aData)
        write_aw_tgt_latency_value = aData
        flag_aw_tgt_latency        = &H1
    End Property

    Property Get read_aw_tgt_latency
        read
        read_aw_tgt_latency = read_aw_tgt_latency_value
    End Property

    Property Let write_aw_tgt_latency(aData)
        set_aw_tgt_latency = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ar_tgt_latency_value = rightShift(data_low, 16) and &Hfff
        aw_tgt_latency_mask = &Hfff
        if data_low > LONG_MAX then
            if aw_tgt_latency_mask = mask then
                read_aw_tgt_latency_value = data_low
            else
                read_aw_tgt_latency_value = (data_low - H8000_0000) and aw_tgt_latency_mask
            end If
        else
            read_aw_tgt_latency_value = data_low and aw_tgt_latency_mask
        end If

    End Sub

    Sub write
        If flag_ar_tgt_latency = &H0 or flag_aw_tgt_latency = &H0 Then read
        If flag_ar_tgt_latency = &H0 Then write_ar_tgt_latency_value = get_ar_tgt_latency
        If flag_aw_tgt_latency = &H0 Then write_aw_tgt_latency_value = get_aw_tgt_latency

        regValue = leftShift((write_ar_tgt_latency_value and &Hfff), 16) + leftShift((write_aw_tgt_latency_value and &Hfff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ar_tgt_latency_value = rightShift(data_low, 16) and &Hfff
        aw_tgt_latency_mask = &Hfff
        if data_low > LONG_MAX then
            if aw_tgt_latency_mask = mask then
                read_aw_tgt_latency_value = data_low
            else
                read_aw_tgt_latency_value = (data_low - H8000_0000) and aw_tgt_latency_mask
            end If
        else
            read_aw_tgt_latency_value = data_low and aw_tgt_latency_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ar_tgt_latency_value = &H0
        flag_ar_tgt_latency        = &H0
        write_aw_tgt_latency_value = &H0
        flag_aw_tgt_latency        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_ki_fc_m7_ahbp_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ar_ki                                      [10:8]           get_ar_ki
''                                                             set_ar_ki
''                                                             read_ar_ki
''                                                             write_ar_ki
''---------------------------------------------------------------------------------
'' aw_ki                                      [2:0]            get_aw_ki
''                                                             set_aw_ki
''                                                             read_aw_ki
''                                                             write_aw_ki
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_ki_fc_m7_ahbp_m
    Private write_ar_ki_value
    Private read_ar_ki_value
    Private flag_ar_ki
    Private write_aw_ki_value
    Private read_aw_ki_value
    Private flag_aw_ki

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H7134
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ar_ki
        get_ar_ki = read_ar_ki_value
    End Property

    Property Let set_ar_ki(aData)
        write_ar_ki_value = aData
        flag_ar_ki        = &H1
    End Property

    Property Get read_ar_ki
        read
        read_ar_ki = read_ar_ki_value
    End Property

    Property Let write_ar_ki(aData)
        set_ar_ki = aData
        write
    End Property

    Property Get get_aw_ki
        get_aw_ki = read_aw_ki_value
    End Property

    Property Let set_aw_ki(aData)
        write_aw_ki_value = aData
        flag_aw_ki        = &H1
    End Property

    Property Get read_aw_ki
        read
        read_aw_ki = read_aw_ki_value
    End Property

    Property Let write_aw_ki(aData)
        set_aw_ki = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ar_ki_value = rightShift(data_low, 8) and &H7
        aw_ki_mask = &H7
        if data_low > LONG_MAX then
            if aw_ki_mask = mask then
                read_aw_ki_value = data_low
            else
                read_aw_ki_value = (data_low - H8000_0000) and aw_ki_mask
            end If
        else
            read_aw_ki_value = data_low and aw_ki_mask
        end If

    End Sub

    Sub write
        If flag_ar_ki = &H0 or flag_aw_ki = &H0 Then read
        If flag_ar_ki = &H0 Then write_ar_ki_value = get_ar_ki
        If flag_aw_ki = &H0 Then write_aw_ki_value = get_aw_ki

        regValue = leftShift((write_ar_ki_value and &H7), 8) + leftShift((write_aw_ki_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ar_ki_value = rightShift(data_low, 8) and &H7
        aw_ki_mask = &H7
        if data_low > LONG_MAX then
            if aw_ki_mask = mask then
                read_aw_ki_value = data_low
            else
                read_aw_ki_value = (data_low - H8000_0000) and aw_ki_mask
            end If
        else
            read_aw_ki_value = data_low and aw_ki_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ar_ki_value = &H0
        flag_ar_ki        = &H0
        write_aw_ki_value = &H0
        flag_aw_ki        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_qos_range_m7_ahbp_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ar_max_qos                                 [27:24]          get_ar_max_qos
''                                                             set_ar_max_qos
''                                                             read_ar_max_qos
''                                                             write_ar_max_qos
''---------------------------------------------------------------------------------
'' ar_min_qos                                 [19:16]          get_ar_min_qos
''                                                             set_ar_min_qos
''                                                             read_ar_min_qos
''                                                             write_ar_min_qos
''---------------------------------------------------------------------------------
'' aw_max_qos                                 [11:8]           get_aw_max_qos
''                                                             set_aw_max_qos
''                                                             read_aw_max_qos
''                                                             write_aw_max_qos
''---------------------------------------------------------------------------------
'' aw_min_qos                                 [3:0]            get_aw_min_qos
''                                                             set_aw_min_qos
''                                                             read_aw_min_qos
''                                                             write_aw_min_qos
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_qos_range_m7_ahbp_m
    Private write_ar_max_qos_value
    Private read_ar_max_qos_value
    Private flag_ar_max_qos
    Private write_ar_min_qos_value
    Private read_ar_min_qos_value
    Private flag_ar_min_qos
    Private write_aw_max_qos_value
    Private read_aw_max_qos_value
    Private flag_aw_max_qos
    Private write_aw_min_qos_value
    Private read_aw_min_qos_value
    Private flag_aw_min_qos

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H7138
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ar_max_qos
        get_ar_max_qos = read_ar_max_qos_value
    End Property

    Property Let set_ar_max_qos(aData)
        write_ar_max_qos_value = aData
        flag_ar_max_qos        = &H1
    End Property

    Property Get read_ar_max_qos
        read
        read_ar_max_qos = read_ar_max_qos_value
    End Property

    Property Let write_ar_max_qos(aData)
        set_ar_max_qos = aData
        write
    End Property

    Property Get get_ar_min_qos
        get_ar_min_qos = read_ar_min_qos_value
    End Property

    Property Let set_ar_min_qos(aData)
        write_ar_min_qos_value = aData
        flag_ar_min_qos        = &H1
    End Property

    Property Get read_ar_min_qos
        read
        read_ar_min_qos = read_ar_min_qos_value
    End Property

    Property Let write_ar_min_qos(aData)
        set_ar_min_qos = aData
        write
    End Property

    Property Get get_aw_max_qos
        get_aw_max_qos = read_aw_max_qos_value
    End Property

    Property Let set_aw_max_qos(aData)
        write_aw_max_qos_value = aData
        flag_aw_max_qos        = &H1
    End Property

    Property Get read_aw_max_qos
        read
        read_aw_max_qos = read_aw_max_qos_value
    End Property

    Property Let write_aw_max_qos(aData)
        set_aw_max_qos = aData
        write
    End Property

    Property Get get_aw_min_qos
        get_aw_min_qos = read_aw_min_qos_value
    End Property

    Property Let set_aw_min_qos(aData)
        write_aw_min_qos_value = aData
        flag_aw_min_qos        = &H1
    End Property

    Property Get read_aw_min_qos
        read
        read_aw_min_qos = read_aw_min_qos_value
    End Property

    Property Let write_aw_min_qos(aData)
        set_aw_min_qos = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ar_max_qos_value = rightShift(data_low, 24) and &Hf
        read_ar_min_qos_value = rightShift(data_low, 16) and &Hf
        read_aw_max_qos_value = rightShift(data_low, 8) and &Hf
        aw_min_qos_mask = &Hf
        if data_low > LONG_MAX then
            if aw_min_qos_mask = mask then
                read_aw_min_qos_value = data_low
            else
                read_aw_min_qos_value = (data_low - H8000_0000) and aw_min_qos_mask
            end If
        else
            read_aw_min_qos_value = data_low and aw_min_qos_mask
        end If

    End Sub

    Sub write
        If flag_ar_max_qos = &H0 or flag_ar_min_qos = &H0 or flag_aw_max_qos = &H0 or flag_aw_min_qos = &H0 Then read
        If flag_ar_max_qos = &H0 Then write_ar_max_qos_value = get_ar_max_qos
        If flag_ar_min_qos = &H0 Then write_ar_min_qos_value = get_ar_min_qos
        If flag_aw_max_qos = &H0 Then write_aw_max_qos_value = get_aw_max_qos
        If flag_aw_min_qos = &H0 Then write_aw_min_qos_value = get_aw_min_qos

        regValue = leftShift((write_ar_max_qos_value and &Hf), 24) + leftShift((write_ar_min_qos_value and &Hf), 16) + leftShift((write_aw_max_qos_value and &Hf), 8) + leftShift((write_aw_min_qos_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ar_max_qos_value = rightShift(data_low, 24) and &Hf
        read_ar_min_qos_value = rightShift(data_low, 16) and &Hf
        read_aw_max_qos_value = rightShift(data_low, 8) and &Hf
        aw_min_qos_mask = &Hf
        if data_low > LONG_MAX then
            if aw_min_qos_mask = mask then
                read_aw_min_qos_value = data_low
            else
                read_aw_min_qos_value = (data_low - H8000_0000) and aw_min_qos_mask
            end If
        else
            read_aw_min_qos_value = data_low and aw_min_qos_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ar_max_qos_value = &H0
        flag_ar_max_qos        = &H0
        write_ar_min_qos_value = &H0
        flag_ar_min_qos        = &H0
        write_aw_max_qos_value = &H0
        flag_aw_max_qos        = &H0
        write_aw_min_qos_value = &H0
        flag_aw_min_qos        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_fn_mod2_dma_10t1s_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' fn_mode2                                   [0:0]            get_fn_mode2
''                                                             set_fn_mode2
''                                                             read_fn_mode2
''                                                             write_fn_mode2
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_fn_mod2_dma_10t1s_m
    Private write_fn_mode2_value
    Private read_fn_mode2_value
    Private flag_fn_mode2

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H8024
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_fn_mode2
        get_fn_mode2 = read_fn_mode2_value
    End Property

    Property Let set_fn_mode2(aData)
        write_fn_mode2_value = aData
        flag_fn_mode2        = &H1
    End Property

    Property Get read_fn_mode2
        read
        read_fn_mode2 = read_fn_mode2_value
    End Property

    Property Let write_fn_mode2(aData)
        set_fn_mode2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        fn_mode2_mask = &H1
        if data_low > LONG_MAX then
            if fn_mode2_mask = mask then
                read_fn_mode2_value = data_low
            else
                read_fn_mode2_value = (data_low - H8000_0000) and fn_mode2_mask
            end If
        else
            read_fn_mode2_value = data_low and fn_mode2_mask
        end If

    End Sub

    Sub write
        If flag_fn_mode2 = &H0 Then read
        If flag_fn_mode2 = &H0 Then write_fn_mode2_value = get_fn_mode2

        regValue = leftShift((write_fn_mode2_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        fn_mode2_mask = &H1
        if data_low > LONG_MAX then
            if fn_mode2_mask = mask then
                read_fn_mode2_value = data_low
            else
                read_fn_mode2_value = (data_low - H8000_0000) and fn_mode2_mask
            end If
        else
            read_fn_mode2_value = data_low and fn_mode2_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_fn_mode2_value = &H0
        flag_fn_mode2        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_fn_mod_ahb_dma_10t1s_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' fn_mod_ahb                                 [1:0]            get_fn_mod_ahb
''                                                             set_fn_mod_ahb
''                                                             read_fn_mod_ahb
''                                                             write_fn_mod_ahb
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_fn_mod_ahb_dma_10t1s_m
    Private write_fn_mod_ahb_value
    Private read_fn_mod_ahb_value
    Private flag_fn_mod_ahb

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H8028
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_fn_mod_ahb
        get_fn_mod_ahb = read_fn_mod_ahb_value
    End Property

    Property Let set_fn_mod_ahb(aData)
        write_fn_mod_ahb_value = aData
        flag_fn_mod_ahb        = &H1
    End Property

    Property Get read_fn_mod_ahb
        read
        read_fn_mod_ahb = read_fn_mod_ahb_value
    End Property

    Property Let write_fn_mod_ahb(aData)
        set_fn_mod_ahb = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        fn_mod_ahb_mask = &H3
        if data_low > LONG_MAX then
            if fn_mod_ahb_mask = mask then
                read_fn_mod_ahb_value = data_low
            else
                read_fn_mod_ahb_value = (data_low - H8000_0000) and fn_mod_ahb_mask
            end If
        else
            read_fn_mod_ahb_value = data_low and fn_mod_ahb_mask
        end If

    End Sub

    Sub write
        If flag_fn_mod_ahb = &H0 Then read
        If flag_fn_mod_ahb = &H0 Then write_fn_mod_ahb_value = get_fn_mod_ahb

        regValue = leftShift((write_fn_mod_ahb_value and &H3), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        fn_mod_ahb_mask = &H3
        if data_low > LONG_MAX then
            if fn_mod_ahb_mask = mask then
                read_fn_mod_ahb_value = data_low
            else
                read_fn_mod_ahb_value = (data_low - H8000_0000) and fn_mod_ahb_mask
            end If
        else
            read_fn_mod_ahb_value = data_low and fn_mod_ahb_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_fn_mod_ahb_value = &H0
        flag_fn_mod_ahb        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_wr_tidemark_dma_10t1s_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' wr_tidemark                                [3:0]            get_wr_tidemark
''                                                             set_wr_tidemark
''                                                             read_wr_tidemark
''                                                             write_wr_tidemark
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_wr_tidemark_dma_10t1s_m
    Private write_wr_tidemark_value
    Private read_wr_tidemark_value
    Private flag_wr_tidemark

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H8040
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_wr_tidemark
        get_wr_tidemark = read_wr_tidemark_value
    End Property

    Property Let set_wr_tidemark(aData)
        write_wr_tidemark_value = aData
        flag_wr_tidemark        = &H1
    End Property

    Property Get read_wr_tidemark
        read
        read_wr_tidemark = read_wr_tidemark_value
    End Property

    Property Let write_wr_tidemark(aData)
        set_wr_tidemark = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        wr_tidemark_mask = &Hf
        if data_low > LONG_MAX then
            if wr_tidemark_mask = mask then
                read_wr_tidemark_value = data_low
            else
                read_wr_tidemark_value = (data_low - H8000_0000) and wr_tidemark_mask
            end If
        else
            read_wr_tidemark_value = data_low and wr_tidemark_mask
        end If

    End Sub

    Sub write
        If flag_wr_tidemark = &H0 Then read
        If flag_wr_tidemark = &H0 Then write_wr_tidemark_value = get_wr_tidemark

        regValue = leftShift((write_wr_tidemark_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        wr_tidemark_mask = &Hf
        if data_low > LONG_MAX then
            if wr_tidemark_mask = mask then
                read_wr_tidemark_value = data_low
            else
                read_wr_tidemark_value = (data_low - H8000_0000) and wr_tidemark_mask
            end If
        else
            read_wr_tidemark_value = data_low and wr_tidemark_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_wr_tidemark_value = &H0
        flag_wr_tidemark        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_read_qos_dma_10t1s_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' read_qos                                   [3:0]            get_read_qos
''                                                             set_read_qos
''                                                             read_read_qos
''                                                             write_read_qos
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_read_qos_dma_10t1s_m
    Private write_read_qos_value
    Private read_read_qos_value
    Private flag_read_qos

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H8100
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_read_qos
        get_read_qos = read_read_qos_value
    End Property

    Property Let set_read_qos(aData)
        write_read_qos_value = aData
        flag_read_qos        = &H1
    End Property

    Property Get read_read_qos
        read
        read_read_qos = read_read_qos_value
    End Property

    Property Let write_read_qos(aData)
        set_read_qos = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_qos_mask = &Hf
        if data_low > LONG_MAX then
            if read_qos_mask = mask then
                read_read_qos_value = data_low
            else
                read_read_qos_value = (data_low - H8000_0000) and read_qos_mask
            end If
        else
            read_read_qos_value = data_low and read_qos_mask
        end If

    End Sub

    Sub write
        If flag_read_qos = &H0 Then read
        If flag_read_qos = &H0 Then write_read_qos_value = get_read_qos

        regValue = leftShift((write_read_qos_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_qos_mask = &Hf
        if data_low > LONG_MAX then
            if read_qos_mask = mask then
                read_read_qos_value = data_low
            else
                read_read_qos_value = (data_low - H8000_0000) and read_qos_mask
            end If
        else
            read_read_qos_value = data_low and read_qos_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_read_qos_value = &H0
        flag_read_qos        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_write_qos_dma_10t1s_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' write_qos                                  [3:0]            get_write_qos
''                                                             set_write_qos
''                                                             read_write_qos
''                                                             write_write_qos
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_write_qos_dma_10t1s_m
    Private write_write_qos_value
    Private read_write_qos_value
    Private flag_write_qos

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H8104
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_write_qos
        get_write_qos = read_write_qos_value
    End Property

    Property Let set_write_qos(aData)
        write_write_qos_value = aData
        flag_write_qos        = &H1
    End Property

    Property Get read_write_qos
        read
        read_write_qos = read_write_qos_value
    End Property

    Property Let write_write_qos(aData)
        set_write_qos = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        write_qos_mask = &Hf
        if data_low > LONG_MAX then
            if write_qos_mask = mask then
                read_write_qos_value = data_low
            else
                read_write_qos_value = (data_low - H8000_0000) and write_qos_mask
            end If
        else
            read_write_qos_value = data_low and write_qos_mask
        end If

    End Sub

    Sub write
        If flag_write_qos = &H0 Then read
        If flag_write_qos = &H0 Then write_write_qos_value = get_write_qos

        regValue = leftShift((write_write_qos_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        write_qos_mask = &Hf
        if data_low > LONG_MAX then
            if write_qos_mask = mask then
                read_write_qos_value = data_low
            else
                read_write_qos_value = (data_low - H8000_0000) and write_qos_mask
            end If
        else
            read_write_qos_value = data_low and write_qos_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_write_qos_value = &H0
        flag_write_qos        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_fn_mod_dma_10t1s_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' fn_mod                                     [1:0]            get_fn_mod
''                                                             set_fn_mod
''                                                             read_fn_mod
''                                                             write_fn_mod
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_fn_mod_dma_10t1s_m
    Private write_fn_mod_value
    Private read_fn_mod_value
    Private flag_fn_mod

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H8108
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_fn_mod
        get_fn_mod = read_fn_mod_value
    End Property

    Property Let set_fn_mod(aData)
        write_fn_mod_value = aData
        flag_fn_mod        = &H1
    End Property

    Property Get read_fn_mod
        read
        read_fn_mod = read_fn_mod_value
    End Property

    Property Let write_fn_mod(aData)
        set_fn_mod = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        fn_mod_mask = &H3
        if data_low > LONG_MAX then
            if fn_mod_mask = mask then
                read_fn_mod_value = data_low
            else
                read_fn_mod_value = (data_low - H8000_0000) and fn_mod_mask
            end If
        else
            read_fn_mod_value = data_low and fn_mod_mask
        end If

    End Sub

    Sub write
        If flag_fn_mod = &H0 Then read
        If flag_fn_mod = &H0 Then write_fn_mod_value = get_fn_mod

        regValue = leftShift((write_fn_mod_value and &H3), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        fn_mod_mask = &H3
        if data_low > LONG_MAX then
            if fn_mod_mask = mask then
                read_fn_mod_value = data_low
            else
                read_fn_mod_value = (data_low - H8000_0000) and fn_mod_mask
            end If
        else
            read_fn_mod_value = data_low and fn_mod_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_fn_mod_value = &H0
        flag_fn_mod        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_qos_cntl_dma_10t1s_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mode_ar_fc                                 [20:20]          get_mode_ar_fc
''                                                             set_mode_ar_fc
''                                                             read_mode_ar_fc
''                                                             write_mode_ar_fc
''---------------------------------------------------------------------------------
'' mode_aw_fc                                 [16:16]          get_mode_aw_fc
''                                                             set_mode_aw_fc
''                                                             read_mode_aw_fc
''                                                             write_mode_aw_fc
''---------------------------------------------------------------------------------
'' en_awar_ot                                 [7:7]            get_en_awar_ot
''                                                             set_en_awar_ot
''                                                             read_en_awar_ot
''                                                             write_en_awar_ot
''---------------------------------------------------------------------------------
'' en_ar_ot                                   [6:6]            get_en_ar_ot
''                                                             set_en_ar_ot
''                                                             read_en_ar_ot
''                                                             write_en_ar_ot
''---------------------------------------------------------------------------------
'' en_aw_ot                                   [5:5]            get_en_aw_ot
''                                                             set_en_aw_ot
''                                                             read_en_aw_ot
''                                                             write_en_aw_ot
''---------------------------------------------------------------------------------
'' en_ar_fc                                   [4:4]            get_en_ar_fc
''                                                             set_en_ar_fc
''                                                             read_en_ar_fc
''                                                             write_en_ar_fc
''---------------------------------------------------------------------------------
'' en_aw_fc                                   [3:3]            get_en_aw_fc
''                                                             set_en_aw_fc
''                                                             read_en_aw_fc
''                                                             write_en_aw_fc
''---------------------------------------------------------------------------------
'' en_awar_rate                               [2:2]            get_en_awar_rate
''                                                             set_en_awar_rate
''                                                             read_en_awar_rate
''                                                             write_en_awar_rate
''---------------------------------------------------------------------------------
'' en_ar_rate                                 [1:1]            get_en_ar_rate
''                                                             set_en_ar_rate
''                                                             read_en_ar_rate
''                                                             write_en_ar_rate
''---------------------------------------------------------------------------------
'' en_aw_rate                                 [0:0]            get_en_aw_rate
''                                                             set_en_aw_rate
''                                                             read_en_aw_rate
''                                                             write_en_aw_rate
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_qos_cntl_dma_10t1s_m
    Private write_mode_ar_fc_value
    Private read_mode_ar_fc_value
    Private flag_mode_ar_fc
    Private write_mode_aw_fc_value
    Private read_mode_aw_fc_value
    Private flag_mode_aw_fc
    Private write_en_awar_ot_value
    Private read_en_awar_ot_value
    Private flag_en_awar_ot
    Private write_en_ar_ot_value
    Private read_en_ar_ot_value
    Private flag_en_ar_ot
    Private write_en_aw_ot_value
    Private read_en_aw_ot_value
    Private flag_en_aw_ot
    Private write_en_ar_fc_value
    Private read_en_ar_fc_value
    Private flag_en_ar_fc
    Private write_en_aw_fc_value
    Private read_en_aw_fc_value
    Private flag_en_aw_fc
    Private write_en_awar_rate_value
    Private read_en_awar_rate_value
    Private flag_en_awar_rate
    Private write_en_ar_rate_value
    Private read_en_ar_rate_value
    Private flag_en_ar_rate
    Private write_en_aw_rate_value
    Private read_en_aw_rate_value
    Private flag_en_aw_rate

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H810c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mode_ar_fc
        get_mode_ar_fc = read_mode_ar_fc_value
    End Property

    Property Let set_mode_ar_fc(aData)
        write_mode_ar_fc_value = aData
        flag_mode_ar_fc        = &H1
    End Property

    Property Get read_mode_ar_fc
        read
        read_mode_ar_fc = read_mode_ar_fc_value
    End Property

    Property Let write_mode_ar_fc(aData)
        set_mode_ar_fc = aData
        write
    End Property

    Property Get get_mode_aw_fc
        get_mode_aw_fc = read_mode_aw_fc_value
    End Property

    Property Let set_mode_aw_fc(aData)
        write_mode_aw_fc_value = aData
        flag_mode_aw_fc        = &H1
    End Property

    Property Get read_mode_aw_fc
        read
        read_mode_aw_fc = read_mode_aw_fc_value
    End Property

    Property Let write_mode_aw_fc(aData)
        set_mode_aw_fc = aData
        write
    End Property

    Property Get get_en_awar_ot
        get_en_awar_ot = read_en_awar_ot_value
    End Property

    Property Let set_en_awar_ot(aData)
        write_en_awar_ot_value = aData
        flag_en_awar_ot        = &H1
    End Property

    Property Get read_en_awar_ot
        read
        read_en_awar_ot = read_en_awar_ot_value
    End Property

    Property Let write_en_awar_ot(aData)
        set_en_awar_ot = aData
        write
    End Property

    Property Get get_en_ar_ot
        get_en_ar_ot = read_en_ar_ot_value
    End Property

    Property Let set_en_ar_ot(aData)
        write_en_ar_ot_value = aData
        flag_en_ar_ot        = &H1
    End Property

    Property Get read_en_ar_ot
        read
        read_en_ar_ot = read_en_ar_ot_value
    End Property

    Property Let write_en_ar_ot(aData)
        set_en_ar_ot = aData
        write
    End Property

    Property Get get_en_aw_ot
        get_en_aw_ot = read_en_aw_ot_value
    End Property

    Property Let set_en_aw_ot(aData)
        write_en_aw_ot_value = aData
        flag_en_aw_ot        = &H1
    End Property

    Property Get read_en_aw_ot
        read
        read_en_aw_ot = read_en_aw_ot_value
    End Property

    Property Let write_en_aw_ot(aData)
        set_en_aw_ot = aData
        write
    End Property

    Property Get get_en_ar_fc
        get_en_ar_fc = read_en_ar_fc_value
    End Property

    Property Let set_en_ar_fc(aData)
        write_en_ar_fc_value = aData
        flag_en_ar_fc        = &H1
    End Property

    Property Get read_en_ar_fc
        read
        read_en_ar_fc = read_en_ar_fc_value
    End Property

    Property Let write_en_ar_fc(aData)
        set_en_ar_fc = aData
        write
    End Property

    Property Get get_en_aw_fc
        get_en_aw_fc = read_en_aw_fc_value
    End Property

    Property Let set_en_aw_fc(aData)
        write_en_aw_fc_value = aData
        flag_en_aw_fc        = &H1
    End Property

    Property Get read_en_aw_fc
        read
        read_en_aw_fc = read_en_aw_fc_value
    End Property

    Property Let write_en_aw_fc(aData)
        set_en_aw_fc = aData
        write
    End Property

    Property Get get_en_awar_rate
        get_en_awar_rate = read_en_awar_rate_value
    End Property

    Property Let set_en_awar_rate(aData)
        write_en_awar_rate_value = aData
        flag_en_awar_rate        = &H1
    End Property

    Property Get read_en_awar_rate
        read
        read_en_awar_rate = read_en_awar_rate_value
    End Property

    Property Let write_en_awar_rate(aData)
        set_en_awar_rate = aData
        write
    End Property

    Property Get get_en_ar_rate
        get_en_ar_rate = read_en_ar_rate_value
    End Property

    Property Let set_en_ar_rate(aData)
        write_en_ar_rate_value = aData
        flag_en_ar_rate        = &H1
    End Property

    Property Get read_en_ar_rate
        read
        read_en_ar_rate = read_en_ar_rate_value
    End Property

    Property Let write_en_ar_rate(aData)
        set_en_ar_rate = aData
        write
    End Property

    Property Get get_en_aw_rate
        get_en_aw_rate = read_en_aw_rate_value
    End Property

    Property Let set_en_aw_rate(aData)
        write_en_aw_rate_value = aData
        flag_en_aw_rate        = &H1
    End Property

    Property Get read_en_aw_rate
        read
        read_en_aw_rate = read_en_aw_rate_value
    End Property

    Property Let write_en_aw_rate(aData)
        set_en_aw_rate = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_mode_ar_fc_value = rightShift(data_low, 20) and &H1
        read_mode_aw_fc_value = rightShift(data_low, 16) and &H1
        read_en_awar_ot_value = rightShift(data_low, 7) and &H1
        read_en_ar_ot_value = rightShift(data_low, 6) and &H1
        read_en_aw_ot_value = rightShift(data_low, 5) and &H1
        read_en_ar_fc_value = rightShift(data_low, 4) and &H1
        read_en_aw_fc_value = rightShift(data_low, 3) and &H1
        read_en_awar_rate_value = rightShift(data_low, 2) and &H1
        read_en_ar_rate_value = rightShift(data_low, 1) and &H1
        en_aw_rate_mask = &H1
        if data_low > LONG_MAX then
            if en_aw_rate_mask = mask then
                read_en_aw_rate_value = data_low
            else
                read_en_aw_rate_value = (data_low - H8000_0000) and en_aw_rate_mask
            end If
        else
            read_en_aw_rate_value = data_low and en_aw_rate_mask
        end If

    End Sub

    Sub write
        If flag_mode_ar_fc = &H0 or flag_mode_aw_fc = &H0 or flag_en_awar_ot = &H0 or flag_en_ar_ot = &H0 or flag_en_aw_ot = &H0 or flag_en_ar_fc = &H0 or flag_en_aw_fc = &H0 or flag_en_awar_rate = &H0 or flag_en_ar_rate = &H0 or flag_en_aw_rate = &H0 Then read
        If flag_mode_ar_fc = &H0 Then write_mode_ar_fc_value = get_mode_ar_fc
        If flag_mode_aw_fc = &H0 Then write_mode_aw_fc_value = get_mode_aw_fc
        If flag_en_awar_ot = &H0 Then write_en_awar_ot_value = get_en_awar_ot
        If flag_en_ar_ot = &H0 Then write_en_ar_ot_value = get_en_ar_ot
        If flag_en_aw_ot = &H0 Then write_en_aw_ot_value = get_en_aw_ot
        If flag_en_ar_fc = &H0 Then write_en_ar_fc_value = get_en_ar_fc
        If flag_en_aw_fc = &H0 Then write_en_aw_fc_value = get_en_aw_fc
        If flag_en_awar_rate = &H0 Then write_en_awar_rate_value = get_en_awar_rate
        If flag_en_ar_rate = &H0 Then write_en_ar_rate_value = get_en_ar_rate
        If flag_en_aw_rate = &H0 Then write_en_aw_rate_value = get_en_aw_rate

        regValue = leftShift((write_mode_ar_fc_value and &H1), 20) + leftShift((write_mode_aw_fc_value and &H1), 16) + leftShift((write_en_awar_ot_value and &H1), 7) + leftShift((write_en_ar_ot_value and &H1), 6) + leftShift((write_en_aw_ot_value and &H1), 5) + leftShift((write_en_ar_fc_value and &H1), 4) + leftShift((write_en_aw_fc_value and &H1), 3) + leftShift((write_en_awar_rate_value and &H1), 2) + leftShift((write_en_ar_rate_value and &H1), 1) + leftShift((write_en_aw_rate_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_mode_ar_fc_value = rightShift(data_low, 20) and &H1
        read_mode_aw_fc_value = rightShift(data_low, 16) and &H1
        read_en_awar_ot_value = rightShift(data_low, 7) and &H1
        read_en_ar_ot_value = rightShift(data_low, 6) and &H1
        read_en_aw_ot_value = rightShift(data_low, 5) and &H1
        read_en_ar_fc_value = rightShift(data_low, 4) and &H1
        read_en_aw_fc_value = rightShift(data_low, 3) and &H1
        read_en_awar_rate_value = rightShift(data_low, 2) and &H1
        read_en_ar_rate_value = rightShift(data_low, 1) and &H1
        en_aw_rate_mask = &H1
        if data_low > LONG_MAX then
            if en_aw_rate_mask = mask then
                read_en_aw_rate_value = data_low
            else
                read_en_aw_rate_value = (data_low - H8000_0000) and en_aw_rate_mask
            end If
        else
            read_en_aw_rate_value = data_low and en_aw_rate_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mode_ar_fc_value = &H0
        flag_mode_ar_fc        = &H0
        write_mode_aw_fc_value = &H0
        flag_mode_aw_fc        = &H0
        write_en_awar_ot_value = &H0
        flag_en_awar_ot        = &H0
        write_en_ar_ot_value = &H0
        flag_en_ar_ot        = &H0
        write_en_aw_ot_value = &H0
        flag_en_aw_ot        = &H0
        write_en_ar_fc_value = &H0
        flag_en_ar_fc        = &H0
        write_en_aw_fc_value = &H0
        flag_en_aw_fc        = &H0
        write_en_awar_rate_value = &H0
        flag_en_awar_rate        = &H0
        write_en_ar_rate_value = &H0
        flag_en_ar_rate        = &H0
        write_en_aw_rate_value = &H0
        flag_en_aw_rate        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_max_ot_dma_10t1s_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ar_max_oti                                 [29:24]          get_ar_max_oti
''                                                             set_ar_max_oti
''                                                             read_ar_max_oti
''                                                             write_ar_max_oti
''---------------------------------------------------------------------------------
'' ar_max_otf                                 [23:16]          get_ar_max_otf
''                                                             set_ar_max_otf
''                                                             read_ar_max_otf
''                                                             write_ar_max_otf
''---------------------------------------------------------------------------------
'' aw_max_oti                                 [13:8]           get_aw_max_oti
''                                                             set_aw_max_oti
''                                                             read_aw_max_oti
''                                                             write_aw_max_oti
''---------------------------------------------------------------------------------
'' en_ar_ot                                   [7:0]            get_en_ar_ot
''                                                             set_en_ar_ot
''                                                             read_en_ar_ot
''                                                             write_en_ar_ot
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_max_ot_dma_10t1s_m
    Private write_ar_max_oti_value
    Private read_ar_max_oti_value
    Private flag_ar_max_oti
    Private write_ar_max_otf_value
    Private read_ar_max_otf_value
    Private flag_ar_max_otf
    Private write_aw_max_oti_value
    Private read_aw_max_oti_value
    Private flag_aw_max_oti
    Private write_en_ar_ot_value
    Private read_en_ar_ot_value
    Private flag_en_ar_ot

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H8110
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ar_max_oti
        get_ar_max_oti = read_ar_max_oti_value
    End Property

    Property Let set_ar_max_oti(aData)
        write_ar_max_oti_value = aData
        flag_ar_max_oti        = &H1
    End Property

    Property Get read_ar_max_oti
        read
        read_ar_max_oti = read_ar_max_oti_value
    End Property

    Property Let write_ar_max_oti(aData)
        set_ar_max_oti = aData
        write
    End Property

    Property Get get_ar_max_otf
        get_ar_max_otf = read_ar_max_otf_value
    End Property

    Property Let set_ar_max_otf(aData)
        write_ar_max_otf_value = aData
        flag_ar_max_otf        = &H1
    End Property

    Property Get read_ar_max_otf
        read
        read_ar_max_otf = read_ar_max_otf_value
    End Property

    Property Let write_ar_max_otf(aData)
        set_ar_max_otf = aData
        write
    End Property

    Property Get get_aw_max_oti
        get_aw_max_oti = read_aw_max_oti_value
    End Property

    Property Let set_aw_max_oti(aData)
        write_aw_max_oti_value = aData
        flag_aw_max_oti        = &H1
    End Property

    Property Get read_aw_max_oti
        read
        read_aw_max_oti = read_aw_max_oti_value
    End Property

    Property Let write_aw_max_oti(aData)
        set_aw_max_oti = aData
        write
    End Property

    Property Get get_en_ar_ot
        get_en_ar_ot = read_en_ar_ot_value
    End Property

    Property Let set_en_ar_ot(aData)
        write_en_ar_ot_value = aData
        flag_en_ar_ot        = &H1
    End Property

    Property Get read_en_ar_ot
        read
        read_en_ar_ot = read_en_ar_ot_value
    End Property

    Property Let write_en_ar_ot(aData)
        set_en_ar_ot = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ar_max_oti_value = rightShift(data_low, 24) and &H3f
        read_ar_max_otf_value = rightShift(data_low, 16) and &Hff
        read_aw_max_oti_value = rightShift(data_low, 8) and &H3f
        en_ar_ot_mask = &Hff
        if data_low > LONG_MAX then
            if en_ar_ot_mask = mask then
                read_en_ar_ot_value = data_low
            else
                read_en_ar_ot_value = (data_low - H8000_0000) and en_ar_ot_mask
            end If
        else
            read_en_ar_ot_value = data_low and en_ar_ot_mask
        end If

    End Sub

    Sub write
        If flag_ar_max_oti = &H0 or flag_ar_max_otf = &H0 or flag_aw_max_oti = &H0 or flag_en_ar_ot = &H0 Then read
        If flag_ar_max_oti = &H0 Then write_ar_max_oti_value = get_ar_max_oti
        If flag_ar_max_otf = &H0 Then write_ar_max_otf_value = get_ar_max_otf
        If flag_aw_max_oti = &H0 Then write_aw_max_oti_value = get_aw_max_oti
        If flag_en_ar_ot = &H0 Then write_en_ar_ot_value = get_en_ar_ot

        regValue = leftShift((write_ar_max_oti_value and &H3f), 24) + leftShift((write_ar_max_otf_value and &Hff), 16) + leftShift((write_aw_max_oti_value and &H3f), 8) + leftShift((write_en_ar_ot_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ar_max_oti_value = rightShift(data_low, 24) and &H3f
        read_ar_max_otf_value = rightShift(data_low, 16) and &Hff
        read_aw_max_oti_value = rightShift(data_low, 8) and &H3f
        en_ar_ot_mask = &Hff
        if data_low > LONG_MAX then
            if en_ar_ot_mask = mask then
                read_en_ar_ot_value = data_low
            else
                read_en_ar_ot_value = (data_low - H8000_0000) and en_ar_ot_mask
            end If
        else
            read_en_ar_ot_value = data_low and en_ar_ot_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ar_max_oti_value = &H0
        flag_ar_max_oti        = &H0
        write_ar_max_otf_value = &H0
        flag_ar_max_otf        = &H0
        write_aw_max_oti_value = &H0
        flag_aw_max_oti        = &H0
        write_en_ar_ot_value = &H0
        flag_en_ar_ot        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_max_comb_ot_dma_10t1s_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' awar_max_oti                               [14:8]           get_awar_max_oti
''                                                             set_awar_max_oti
''                                                             read_awar_max_oti
''                                                             write_awar_max_oti
''---------------------------------------------------------------------------------
'' awar_max_otf                               [7:0]            get_awar_max_otf
''                                                             set_awar_max_otf
''                                                             read_awar_max_otf
''                                                             write_awar_max_otf
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_max_comb_ot_dma_10t1s_m
    Private write_awar_max_oti_value
    Private read_awar_max_oti_value
    Private flag_awar_max_oti
    Private write_awar_max_otf_value
    Private read_awar_max_otf_value
    Private flag_awar_max_otf

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H8114
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_awar_max_oti
        get_awar_max_oti = read_awar_max_oti_value
    End Property

    Property Let set_awar_max_oti(aData)
        write_awar_max_oti_value = aData
        flag_awar_max_oti        = &H1
    End Property

    Property Get read_awar_max_oti
        read
        read_awar_max_oti = read_awar_max_oti_value
    End Property

    Property Let write_awar_max_oti(aData)
        set_awar_max_oti = aData
        write
    End Property

    Property Get get_awar_max_otf
        get_awar_max_otf = read_awar_max_otf_value
    End Property

    Property Let set_awar_max_otf(aData)
        write_awar_max_otf_value = aData
        flag_awar_max_otf        = &H1
    End Property

    Property Get read_awar_max_otf
        read
        read_awar_max_otf = read_awar_max_otf_value
    End Property

    Property Let write_awar_max_otf(aData)
        set_awar_max_otf = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_awar_max_oti_value = rightShift(data_low, 8) and &H7f
        awar_max_otf_mask = &Hff
        if data_low > LONG_MAX then
            if awar_max_otf_mask = mask then
                read_awar_max_otf_value = data_low
            else
                read_awar_max_otf_value = (data_low - H8000_0000) and awar_max_otf_mask
            end If
        else
            read_awar_max_otf_value = data_low and awar_max_otf_mask
        end If

    End Sub

    Sub write
        If flag_awar_max_oti = &H0 or flag_awar_max_otf = &H0 Then read
        If flag_awar_max_oti = &H0 Then write_awar_max_oti_value = get_awar_max_oti
        If flag_awar_max_otf = &H0 Then write_awar_max_otf_value = get_awar_max_otf

        regValue = leftShift((write_awar_max_oti_value and &H7f), 8) + leftShift((write_awar_max_otf_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_awar_max_oti_value = rightShift(data_low, 8) and &H7f
        awar_max_otf_mask = &Hff
        if data_low > LONG_MAX then
            if awar_max_otf_mask = mask then
                read_awar_max_otf_value = data_low
            else
                read_awar_max_otf_value = (data_low - H8000_0000) and awar_max_otf_mask
            end If
        else
            read_awar_max_otf_value = data_low and awar_max_otf_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_awar_max_oti_value = &H0
        flag_awar_max_oti        = &H0
        write_awar_max_otf_value = &H0
        flag_awar_max_otf        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_aw_p_dma_10t1s_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' aw_p                                       [31:24]          get_aw_p
''                                                             set_aw_p
''                                                             read_aw_p
''                                                             write_aw_p
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_aw_p_dma_10t1s_m
    Private write_aw_p_value
    Private read_aw_p_value
    Private flag_aw_p

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H8118
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_aw_p
        get_aw_p = read_aw_p_value
    End Property

    Property Let set_aw_p(aData)
        write_aw_p_value = aData
        flag_aw_p        = &H1
    End Property

    Property Get read_aw_p
        read
        read_aw_p = read_aw_p_value
    End Property

    Property Let write_aw_p(aData)
        set_aw_p = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_aw_p_value = rightShift(data_low, 24) and &Hff

    End Sub

    Sub write
        If flag_aw_p = &H0 Then read
        If flag_aw_p = &H0 Then write_aw_p_value = get_aw_p

        regValue = leftShift((write_aw_p_value and &Hff), 24)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_aw_p_value = rightShift(data_low, 24) and &Hff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_aw_p_value = &H0
        flag_aw_p        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_aw_b_dma_10t1s_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' aw_b                                       [15:0]           get_aw_b
''                                                             set_aw_b
''                                                             read_aw_b
''                                                             write_aw_b
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_aw_b_dma_10t1s_m
    Private write_aw_b_value
    Private read_aw_b_value
    Private flag_aw_b

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H811c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_aw_b
        get_aw_b = read_aw_b_value
    End Property

    Property Let set_aw_b(aData)
        write_aw_b_value = aData
        flag_aw_b        = &H1
    End Property

    Property Get read_aw_b
        read
        read_aw_b = read_aw_b_value
    End Property

    Property Let write_aw_b(aData)
        set_aw_b = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        aw_b_mask = &Hffff
        if data_low > LONG_MAX then
            if aw_b_mask = mask then
                read_aw_b_value = data_low
            else
                read_aw_b_value = (data_low - H8000_0000) and aw_b_mask
            end If
        else
            read_aw_b_value = data_low and aw_b_mask
        end If

    End Sub

    Sub write
        If flag_aw_b = &H0 Then read
        If flag_aw_b = &H0 Then write_aw_b_value = get_aw_b

        regValue = leftShift((write_aw_b_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        aw_b_mask = &Hffff
        if data_low > LONG_MAX then
            if aw_b_mask = mask then
                read_aw_b_value = data_low
            else
                read_aw_b_value = (data_low - H8000_0000) and aw_b_mask
            end If
        else
            read_aw_b_value = data_low and aw_b_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_aw_b_value = &H0
        flag_aw_b        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_aw_r_dma_10t1s_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' aw_r                                       [31:20]          get_aw_r
''                                                             set_aw_r
''                                                             read_aw_r
''                                                             write_aw_r
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_aw_r_dma_10t1s_m
    Private write_aw_r_value
    Private read_aw_r_value
    Private flag_aw_r

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H8120
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_aw_r
        get_aw_r = read_aw_r_value
    End Property

    Property Let set_aw_r(aData)
        write_aw_r_value = aData
        flag_aw_r        = &H1
    End Property

    Property Get read_aw_r
        read
        read_aw_r = read_aw_r_value
    End Property

    Property Let write_aw_r(aData)
        set_aw_r = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_aw_r_value = rightShift(data_low, 20) and &Hfff

    End Sub

    Sub write
        If flag_aw_r = &H0 Then read
        If flag_aw_r = &H0 Then write_aw_r_value = get_aw_r

        regValue = leftShift((write_aw_r_value and &Hfff), 20)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_aw_r_value = rightShift(data_low, 20) and &Hfff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_aw_r_value = &H0
        flag_aw_r        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_ar_p_dma_10t1s_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ar_p                                       [31:24]          get_ar_p
''                                                             set_ar_p
''                                                             read_ar_p
''                                                             write_ar_p
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_ar_p_dma_10t1s_m
    Private write_ar_p_value
    Private read_ar_p_value
    Private flag_ar_p

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H8124
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ar_p
        get_ar_p = read_ar_p_value
    End Property

    Property Let set_ar_p(aData)
        write_ar_p_value = aData
        flag_ar_p        = &H1
    End Property

    Property Get read_ar_p
        read
        read_ar_p = read_ar_p_value
    End Property

    Property Let write_ar_p(aData)
        set_ar_p = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ar_p_value = rightShift(data_low, 24) and &Hff

    End Sub

    Sub write
        If flag_ar_p = &H0 Then read
        If flag_ar_p = &H0 Then write_ar_p_value = get_ar_p

        regValue = leftShift((write_ar_p_value and &Hff), 24)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ar_p_value = rightShift(data_low, 24) and &Hff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ar_p_value = &H0
        flag_ar_p        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_ar_b_dma_10t1s_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ar_b                                       [15:0]           get_ar_b
''                                                             set_ar_b
''                                                             read_ar_b
''                                                             write_ar_b
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_ar_b_dma_10t1s_m
    Private write_ar_b_value
    Private read_ar_b_value
    Private flag_ar_b

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H8128
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ar_b
        get_ar_b = read_ar_b_value
    End Property

    Property Let set_ar_b(aData)
        write_ar_b_value = aData
        flag_ar_b        = &H1
    End Property

    Property Get read_ar_b
        read
        read_ar_b = read_ar_b_value
    End Property

    Property Let write_ar_b(aData)
        set_ar_b = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ar_b_mask = &Hffff
        if data_low > LONG_MAX then
            if ar_b_mask = mask then
                read_ar_b_value = data_low
            else
                read_ar_b_value = (data_low - H8000_0000) and ar_b_mask
            end If
        else
            read_ar_b_value = data_low and ar_b_mask
        end If

    End Sub

    Sub write
        If flag_ar_b = &H0 Then read
        If flag_ar_b = &H0 Then write_ar_b_value = get_ar_b

        regValue = leftShift((write_ar_b_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ar_b_mask = &Hffff
        if data_low > LONG_MAX then
            if ar_b_mask = mask then
                read_ar_b_value = data_low
            else
                read_ar_b_value = (data_low - H8000_0000) and ar_b_mask
            end If
        else
            read_ar_b_value = data_low and ar_b_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ar_b_value = &H0
        flag_ar_b        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_ar_r_dma_10t1s_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ar_r                                       [31:20]          get_ar_r
''                                                             set_ar_r
''                                                             read_ar_r
''                                                             write_ar_r
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_ar_r_dma_10t1s_m
    Private write_ar_r_value
    Private read_ar_r_value
    Private flag_ar_r

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H812c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ar_r
        get_ar_r = read_ar_r_value
    End Property

    Property Let set_ar_r(aData)
        write_ar_r_value = aData
        flag_ar_r        = &H1
    End Property

    Property Get read_ar_r
        read
        read_ar_r = read_ar_r_value
    End Property

    Property Let write_ar_r(aData)
        set_ar_r = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ar_r_value = rightShift(data_low, 20) and &Hfff

    End Sub

    Sub write
        If flag_ar_r = &H0 Then read
        If flag_ar_r = &H0 Then write_ar_r_value = get_ar_r

        regValue = leftShift((write_ar_r_value and &Hfff), 20)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ar_r_value = rightShift(data_low, 20) and &Hfff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ar_r_value = &H0
        flag_ar_r        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_target_fc_dma_10t1s_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ar_tgt_latency                             [27:16]          get_ar_tgt_latency
''                                                             set_ar_tgt_latency
''                                                             read_ar_tgt_latency
''                                                             write_ar_tgt_latency
''---------------------------------------------------------------------------------
'' aw_tgt_latency                             [11:0]           get_aw_tgt_latency
''                                                             set_aw_tgt_latency
''                                                             read_aw_tgt_latency
''                                                             write_aw_tgt_latency
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_target_fc_dma_10t1s_m
    Private write_ar_tgt_latency_value
    Private read_ar_tgt_latency_value
    Private flag_ar_tgt_latency
    Private write_aw_tgt_latency_value
    Private read_aw_tgt_latency_value
    Private flag_aw_tgt_latency

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H8130
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ar_tgt_latency
        get_ar_tgt_latency = read_ar_tgt_latency_value
    End Property

    Property Let set_ar_tgt_latency(aData)
        write_ar_tgt_latency_value = aData
        flag_ar_tgt_latency        = &H1
    End Property

    Property Get read_ar_tgt_latency
        read
        read_ar_tgt_latency = read_ar_tgt_latency_value
    End Property

    Property Let write_ar_tgt_latency(aData)
        set_ar_tgt_latency = aData
        write
    End Property

    Property Get get_aw_tgt_latency
        get_aw_tgt_latency = read_aw_tgt_latency_value
    End Property

    Property Let set_aw_tgt_latency(aData)
        write_aw_tgt_latency_value = aData
        flag_aw_tgt_latency        = &H1
    End Property

    Property Get read_aw_tgt_latency
        read
        read_aw_tgt_latency = read_aw_tgt_latency_value
    End Property

    Property Let write_aw_tgt_latency(aData)
        set_aw_tgt_latency = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ar_tgt_latency_value = rightShift(data_low, 16) and &Hfff
        aw_tgt_latency_mask = &Hfff
        if data_low > LONG_MAX then
            if aw_tgt_latency_mask = mask then
                read_aw_tgt_latency_value = data_low
            else
                read_aw_tgt_latency_value = (data_low - H8000_0000) and aw_tgt_latency_mask
            end If
        else
            read_aw_tgt_latency_value = data_low and aw_tgt_latency_mask
        end If

    End Sub

    Sub write
        If flag_ar_tgt_latency = &H0 or flag_aw_tgt_latency = &H0 Then read
        If flag_ar_tgt_latency = &H0 Then write_ar_tgt_latency_value = get_ar_tgt_latency
        If flag_aw_tgt_latency = &H0 Then write_aw_tgt_latency_value = get_aw_tgt_latency

        regValue = leftShift((write_ar_tgt_latency_value and &Hfff), 16) + leftShift((write_aw_tgt_latency_value and &Hfff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ar_tgt_latency_value = rightShift(data_low, 16) and &Hfff
        aw_tgt_latency_mask = &Hfff
        if data_low > LONG_MAX then
            if aw_tgt_latency_mask = mask then
                read_aw_tgt_latency_value = data_low
            else
                read_aw_tgt_latency_value = (data_low - H8000_0000) and aw_tgt_latency_mask
            end If
        else
            read_aw_tgt_latency_value = data_low and aw_tgt_latency_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ar_tgt_latency_value = &H0
        flag_ar_tgt_latency        = &H0
        write_aw_tgt_latency_value = &H0
        flag_aw_tgt_latency        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_ki_fc_dma_10t1s_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ar_ki                                      [10:8]           get_ar_ki
''                                                             set_ar_ki
''                                                             read_ar_ki
''                                                             write_ar_ki
''---------------------------------------------------------------------------------
'' aw_ki                                      [2:0]            get_aw_ki
''                                                             set_aw_ki
''                                                             read_aw_ki
''                                                             write_aw_ki
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_ki_fc_dma_10t1s_m
    Private write_ar_ki_value
    Private read_ar_ki_value
    Private flag_ar_ki
    Private write_aw_ki_value
    Private read_aw_ki_value
    Private flag_aw_ki

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H8134
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ar_ki
        get_ar_ki = read_ar_ki_value
    End Property

    Property Let set_ar_ki(aData)
        write_ar_ki_value = aData
        flag_ar_ki        = &H1
    End Property

    Property Get read_ar_ki
        read
        read_ar_ki = read_ar_ki_value
    End Property

    Property Let write_ar_ki(aData)
        set_ar_ki = aData
        write
    End Property

    Property Get get_aw_ki
        get_aw_ki = read_aw_ki_value
    End Property

    Property Let set_aw_ki(aData)
        write_aw_ki_value = aData
        flag_aw_ki        = &H1
    End Property

    Property Get read_aw_ki
        read
        read_aw_ki = read_aw_ki_value
    End Property

    Property Let write_aw_ki(aData)
        set_aw_ki = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ar_ki_value = rightShift(data_low, 8) and &H7
        aw_ki_mask = &H7
        if data_low > LONG_MAX then
            if aw_ki_mask = mask then
                read_aw_ki_value = data_low
            else
                read_aw_ki_value = (data_low - H8000_0000) and aw_ki_mask
            end If
        else
            read_aw_ki_value = data_low and aw_ki_mask
        end If

    End Sub

    Sub write
        If flag_ar_ki = &H0 or flag_aw_ki = &H0 Then read
        If flag_ar_ki = &H0 Then write_ar_ki_value = get_ar_ki
        If flag_aw_ki = &H0 Then write_aw_ki_value = get_aw_ki

        regValue = leftShift((write_ar_ki_value and &H7), 8) + leftShift((write_aw_ki_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ar_ki_value = rightShift(data_low, 8) and &H7
        aw_ki_mask = &H7
        if data_low > LONG_MAX then
            if aw_ki_mask = mask then
                read_aw_ki_value = data_low
            else
                read_aw_ki_value = (data_low - H8000_0000) and aw_ki_mask
            end If
        else
            read_aw_ki_value = data_low and aw_ki_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ar_ki_value = &H0
        flag_ar_ki        = &H0
        write_aw_ki_value = &H0
        flag_aw_ki        = &H0
    End Sub
End Class


'' @REGISTER : GPV_ASIB_qos_range_dma_10t1s_m
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ar_max_qos                                 [27:24]          get_ar_max_qos
''                                                             set_ar_max_qos
''                                                             read_ar_max_qos
''                                                             write_ar_max_qos
''---------------------------------------------------------------------------------
'' ar_min_qos                                 [19:16]          get_ar_min_qos
''                                                             set_ar_min_qos
''                                                             read_ar_min_qos
''                                                             write_ar_min_qos
''---------------------------------------------------------------------------------
'' aw_max_qos                                 [11:8]           get_aw_max_qos
''                                                             set_aw_max_qos
''                                                             read_aw_max_qos
''                                                             write_aw_max_qos
''---------------------------------------------------------------------------------
'' aw_min_qos                                 [3:0]            get_aw_min_qos
''                                                             set_aw_min_qos
''                                                             read_aw_min_qos
''                                                             write_aw_min_qos
''---------------------------------------------------------------------------------
Class REGISTER_GPV_ASIB_qos_range_dma_10t1s_m
    Private write_ar_max_qos_value
    Private read_ar_max_qos_value
    Private flag_ar_max_qos
    Private write_ar_min_qos_value
    Private read_ar_min_qos_value
    Private flag_ar_min_qos
    Private write_aw_max_qos_value
    Private read_aw_max_qos_value
    Private flag_aw_max_qos
    Private write_aw_min_qos_value
    Private read_aw_min_qos_value
    Private flag_aw_min_qos

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H8138
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ar_max_qos
        get_ar_max_qos = read_ar_max_qos_value
    End Property

    Property Let set_ar_max_qos(aData)
        write_ar_max_qos_value = aData
        flag_ar_max_qos        = &H1
    End Property

    Property Get read_ar_max_qos
        read
        read_ar_max_qos = read_ar_max_qos_value
    End Property

    Property Let write_ar_max_qos(aData)
        set_ar_max_qos = aData
        write
    End Property

    Property Get get_ar_min_qos
        get_ar_min_qos = read_ar_min_qos_value
    End Property

    Property Let set_ar_min_qos(aData)
        write_ar_min_qos_value = aData
        flag_ar_min_qos        = &H1
    End Property

    Property Get read_ar_min_qos
        read
        read_ar_min_qos = read_ar_min_qos_value
    End Property

    Property Let write_ar_min_qos(aData)
        set_ar_min_qos = aData
        write
    End Property

    Property Get get_aw_max_qos
        get_aw_max_qos = read_aw_max_qos_value
    End Property

    Property Let set_aw_max_qos(aData)
        write_aw_max_qos_value = aData
        flag_aw_max_qos        = &H1
    End Property

    Property Get read_aw_max_qos
        read
        read_aw_max_qos = read_aw_max_qos_value
    End Property

    Property Let write_aw_max_qos(aData)
        set_aw_max_qos = aData
        write
    End Property

    Property Get get_aw_min_qos
        get_aw_min_qos = read_aw_min_qos_value
    End Property

    Property Let set_aw_min_qos(aData)
        write_aw_min_qos_value = aData
        flag_aw_min_qos        = &H1
    End Property

    Property Get read_aw_min_qos
        read
        read_aw_min_qos = read_aw_min_qos_value
    End Property

    Property Let write_aw_min_qos(aData)
        set_aw_min_qos = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ar_max_qos_value = rightShift(data_low, 24) and &Hf
        read_ar_min_qos_value = rightShift(data_low, 16) and &Hf
        read_aw_max_qos_value = rightShift(data_low, 8) and &Hf
        aw_min_qos_mask = &Hf
        if data_low > LONG_MAX then
            if aw_min_qos_mask = mask then
                read_aw_min_qos_value = data_low
            else
                read_aw_min_qos_value = (data_low - H8000_0000) and aw_min_qos_mask
            end If
        else
            read_aw_min_qos_value = data_low and aw_min_qos_mask
        end If

    End Sub

    Sub write
        If flag_ar_max_qos = &H0 or flag_ar_min_qos = &H0 or flag_aw_max_qos = &H0 or flag_aw_min_qos = &H0 Then read
        If flag_ar_max_qos = &H0 Then write_ar_max_qos_value = get_ar_max_qos
        If flag_ar_min_qos = &H0 Then write_ar_min_qos_value = get_ar_min_qos
        If flag_aw_max_qos = &H0 Then write_aw_max_qos_value = get_aw_max_qos
        If flag_aw_min_qos = &H0 Then write_aw_min_qos_value = get_aw_min_qos

        regValue = leftShift((write_ar_max_qos_value and &Hf), 24) + leftShift((write_ar_min_qos_value and &Hf), 16) + leftShift((write_aw_max_qos_value and &Hf), 8) + leftShift((write_aw_min_qos_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ar_max_qos_value = rightShift(data_low, 24) and &Hf
        read_ar_min_qos_value = rightShift(data_low, 16) and &Hf
        read_aw_max_qos_value = rightShift(data_low, 8) and &Hf
        aw_min_qos_mask = &Hf
        if data_low > LONG_MAX then
            if aw_min_qos_mask = mask then
                read_aw_min_qos_value = data_low
            else
                read_aw_min_qos_value = (data_low - H8000_0000) and aw_min_qos_mask
            end If
        else
            read_aw_min_qos_value = data_low and aw_min_qos_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ar_max_qos_value = &H0
        flag_ar_max_qos        = &H0
        write_ar_min_qos_value = &H0
        flag_ar_min_qos        = &H0
        write_aw_max_qos_value = &H0
        flag_aw_max_qos        = &H0
        write_aw_min_qos_value = &H0
        flag_aw_min_qos        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class GPV_ASIB_INSTANCE

    Public fn_mod2_m7_m
    Public read_qos_m7_m
    Public write_qos_m7_m
    Public fn_mod_m7_m
    Public qos_cntl_m7_m
    Public max_ot_m7_m
    Public max_comb_ot_m7_m
    Public aw_p_m7_m
    Public aw_b_m7_m
    Public aw_r_m7_m
    Public ar_p_m7_m
    Public ar_b_m7_m
    Public ar_r_m7_m
    Public target_fc_m7_m
    Public ki_fc_m7_m
    Public qos_range_m7_m
    Public fn_mod2_amac_m
    Public read_qos_amac_m
    Public write_qos_amac_m
    Public fn_mod_amac_m
    Public qos_cntl_amac_m
    Public max_ot_amac_m
    Public max_comb_ot_amac_m
    Public aw_p_amac_m
    Public aw_b_amac_m
    Public aw_r_amac_m
    Public ar_p_amac_m
    Public ar_b_amac_m
    Public ar_r_amac_m
    Public target_fc_amac_m
    Public ki_fc_amac_m
    Public qos_range_amac_m
    Public read_qos_ser_m
    Public write_qos_ser_m
    Public fn_mod_ser_m
    Public qos_cntl_ser_m
    Public max_ot_ser_m
    Public max_comb_ot_ser_m
    Public aw_p_ser_m
    Public aw_b_ser_m
    Public aw_r_ser_m
    Public ar_p_ser_m
    Public ar_b_ser_m
    Public ar_r_ser_m
    Public target_fc_ser_m
    Public ki_fc_ser_m
    Public qos_range_ser_m
    Public fn_mod_ahb_pcie_m
    Public read_qos_pcie_m
    Public write_qos_pcie_m
    Public fn_mod_pcie_m
    Public qos_cntl_pcie_m
    Public max_ot_pcie_m
    Public max_comb_ot_pcie_m
    Public aw_p_pcie_m
    Public aw_b_pcie_m
    Public aw_r_pcie_m
    Public ar_p_pcie_m
    Public ar_b_pcie_m
    Public ar_r_pcie_m
    Public target_fc_pcie_m
    Public ki_fc_pcie_m
    Public qos_range_pcie_m
    Public fn_mod2_hsm_m
    Public fn_mod_ahb_hsm_m
    Public read_qos_hsm_m
    Public write_qos_hsm_m
    Public fn_mod_hsm_m
    Public qos_cntl_hsm_m
    Public max_ot_hsm_m
    Public max_comb_ot_hsm_m
    Public aw_p_hsm_m
    Public aw_b_hsm_m
    Public aw_r_hsm_m
    Public ar_p_hsm_m
    Public ar_b_hsm_m
    Public ar_r_hsm_m
    Public target_fc_hsm_m
    Public ki_fc_hsm_m
    Public qos_range_hsm_m
    Public fn_mod_ahb_ind_m
    Public read_qos_ind_m
    Public write_qos_ind_m
    Public fn_mod_ind_m
    Public qos_cntl_ind_m
    Public max_ot_ind_m
    Public max_comb_ot_ind_m
    Public aw_p_ind_m
    Public aw_b_ind_m
    Public aw_r_ind_m
    Public ar_p_ind_m
    Public ar_b_ind_m
    Public ar_r_ind_m
    Public target_fc_ind_m
    Public ki_fc_ind_m
    Public qos_range_ind_m
    Public fn_mod2_dap_m
    Public fn_mod_ahb_dap_m
    Public read_qos_dap_m
    Public write_qos_dap_m
    Public fn_mod_dap_m
    Public qos_cntl_dap_m
    Public max_ot_dap_m
    Public max_comb_ot_dap_m
    Public aw_p_dap_m
    Public aw_b_dap_m
    Public aw_r_dap_m
    Public ar_p_dap_m
    Public ar_b_dap_m
    Public ar_r_dap_m
    Public target_fc_dap_m
    Public ki_fc_dap_m
    Public qos_range_dap_m
    Public fn_mod2_m7_ahbp_m
    Public fn_mod_ahb_m7_ahbp_m
    Public read_qos_m7_ahbp_m
    Public write_qos_m7_ahbp_m
    Public fn_mod_m7_ahbp_m
    Public qos_cntl_m7_ahbp_m
    Public max_ot_m7_ahbp_m
    Public max_comb_ot_m7_ahbp_m
    Public aw_p_m7_ahbp_m
    Public aw_b_m7_ahbp_m
    Public aw_r_m7_ahbp_m
    Public ar_p_m7_ahbp_m
    Public ar_b_m7_ahbp_m
    Public ar_r_m7_ahbp_m
    Public target_fc_m7_ahbp_m
    Public ki_fc_m7_ahbp_m
    Public qos_range_m7_ahbp_m
    Public fn_mod2_dma_10t1s_m
    Public fn_mod_ahb_dma_10t1s_m
    Public wr_tidemark_dma_10t1s_m
    Public read_qos_dma_10t1s_m
    Public write_qos_dma_10t1s_m
    Public fn_mod_dma_10t1s_m
    Public qos_cntl_dma_10t1s_m
    Public max_ot_dma_10t1s_m
    Public max_comb_ot_dma_10t1s_m
    Public aw_p_dma_10t1s_m
    Public aw_b_dma_10t1s_m
    Public aw_r_dma_10t1s_m
    Public ar_p_dma_10t1s_m
    Public ar_b_dma_10t1s_m
    Public ar_r_dma_10t1s_m
    Public target_fc_dma_10t1s_m
    Public ki_fc_dma_10t1s_m
    Public qos_range_dma_10t1s_m


    Public default function Init(aBaseAddr)
        Set fn_mod2_m7_m = (New REGISTER_GPV_ASIB_fn_mod2_m7_m)(aBaseAddr, 32)
        Set read_qos_m7_m = (New REGISTER_GPV_ASIB_read_qos_m7_m)(aBaseAddr, 32)
        Set write_qos_m7_m = (New REGISTER_GPV_ASIB_write_qos_m7_m)(aBaseAddr, 32)
        Set fn_mod_m7_m = (New REGISTER_GPV_ASIB_fn_mod_m7_m)(aBaseAddr, 32)
        Set qos_cntl_m7_m = (New REGISTER_GPV_ASIB_qos_cntl_m7_m)(aBaseAddr, 32)
        Set max_ot_m7_m = (New REGISTER_GPV_ASIB_max_ot_m7_m)(aBaseAddr, 32)
        Set max_comb_ot_m7_m = (New REGISTER_GPV_ASIB_max_comb_ot_m7_m)(aBaseAddr, 32)
        Set aw_p_m7_m = (New REGISTER_GPV_ASIB_aw_p_m7_m)(aBaseAddr, 32)
        Set aw_b_m7_m = (New REGISTER_GPV_ASIB_aw_b_m7_m)(aBaseAddr, 32)
        Set aw_r_m7_m = (New REGISTER_GPV_ASIB_aw_r_m7_m)(aBaseAddr, 32)
        Set ar_p_m7_m = (New REGISTER_GPV_ASIB_ar_p_m7_m)(aBaseAddr, 32)
        Set ar_b_m7_m = (New REGISTER_GPV_ASIB_ar_b_m7_m)(aBaseAddr, 32)
        Set ar_r_m7_m = (New REGISTER_GPV_ASIB_ar_r_m7_m)(aBaseAddr, 32)
        Set target_fc_m7_m = (New REGISTER_GPV_ASIB_target_fc_m7_m)(aBaseAddr, 32)
        Set ki_fc_m7_m = (New REGISTER_GPV_ASIB_ki_fc_m7_m)(aBaseAddr, 32)
        Set qos_range_m7_m = (New REGISTER_GPV_ASIB_qos_range_m7_m)(aBaseAddr, 32)
        Set fn_mod2_amac_m = (New REGISTER_GPV_ASIB_fn_mod2_amac_m)(aBaseAddr, 32)
        Set read_qos_amac_m = (New REGISTER_GPV_ASIB_read_qos_amac_m)(aBaseAddr, 32)
        Set write_qos_amac_m = (New REGISTER_GPV_ASIB_write_qos_amac_m)(aBaseAddr, 32)
        Set fn_mod_amac_m = (New REGISTER_GPV_ASIB_fn_mod_amac_m)(aBaseAddr, 32)
        Set qos_cntl_amac_m = (New REGISTER_GPV_ASIB_qos_cntl_amac_m)(aBaseAddr, 32)
        Set max_ot_amac_m = (New REGISTER_GPV_ASIB_max_ot_amac_m)(aBaseAddr, 32)
        Set max_comb_ot_amac_m = (New REGISTER_GPV_ASIB_max_comb_ot_amac_m)(aBaseAddr, 32)
        Set aw_p_amac_m = (New REGISTER_GPV_ASIB_aw_p_amac_m)(aBaseAddr, 32)
        Set aw_b_amac_m = (New REGISTER_GPV_ASIB_aw_b_amac_m)(aBaseAddr, 32)
        Set aw_r_amac_m = (New REGISTER_GPV_ASIB_aw_r_amac_m)(aBaseAddr, 32)
        Set ar_p_amac_m = (New REGISTER_GPV_ASIB_ar_p_amac_m)(aBaseAddr, 32)
        Set ar_b_amac_m = (New REGISTER_GPV_ASIB_ar_b_amac_m)(aBaseAddr, 32)
        Set ar_r_amac_m = (New REGISTER_GPV_ASIB_ar_r_amac_m)(aBaseAddr, 32)
        Set target_fc_amac_m = (New REGISTER_GPV_ASIB_target_fc_amac_m)(aBaseAddr, 32)
        Set ki_fc_amac_m = (New REGISTER_GPV_ASIB_ki_fc_amac_m)(aBaseAddr, 32)
        Set qos_range_amac_m = (New REGISTER_GPV_ASIB_qos_range_amac_m)(aBaseAddr, 32)
        Set read_qos_ser_m = (New REGISTER_GPV_ASIB_read_qos_ser_m)(aBaseAddr, 32)
        Set write_qos_ser_m = (New REGISTER_GPV_ASIB_write_qos_ser_m)(aBaseAddr, 32)
        Set fn_mod_ser_m = (New REGISTER_GPV_ASIB_fn_mod_ser_m)(aBaseAddr, 32)
        Set qos_cntl_ser_m = (New REGISTER_GPV_ASIB_qos_cntl_ser_m)(aBaseAddr, 32)
        Set max_ot_ser_m = (New REGISTER_GPV_ASIB_max_ot_ser_m)(aBaseAddr, 32)
        Set max_comb_ot_ser_m = (New REGISTER_GPV_ASIB_max_comb_ot_ser_m)(aBaseAddr, 32)
        Set aw_p_ser_m = (New REGISTER_GPV_ASIB_aw_p_ser_m)(aBaseAddr, 32)
        Set aw_b_ser_m = (New REGISTER_GPV_ASIB_aw_b_ser_m)(aBaseAddr, 32)
        Set aw_r_ser_m = (New REGISTER_GPV_ASIB_aw_r_ser_m)(aBaseAddr, 32)
        Set ar_p_ser_m = (New REGISTER_GPV_ASIB_ar_p_ser_m)(aBaseAddr, 32)
        Set ar_b_ser_m = (New REGISTER_GPV_ASIB_ar_b_ser_m)(aBaseAddr, 32)
        Set ar_r_ser_m = (New REGISTER_GPV_ASIB_ar_r_ser_m)(aBaseAddr, 32)
        Set target_fc_ser_m = (New REGISTER_GPV_ASIB_target_fc_ser_m)(aBaseAddr, 32)
        Set ki_fc_ser_m = (New REGISTER_GPV_ASIB_ki_fc_ser_m)(aBaseAddr, 32)
        Set qos_range_ser_m = (New REGISTER_GPV_ASIB_qos_range_ser_m)(aBaseAddr, 32)
        Set fn_mod_ahb_pcie_m = (New REGISTER_GPV_ASIB_fn_mod_ahb_pcie_m)(aBaseAddr, 32)
        Set read_qos_pcie_m = (New REGISTER_GPV_ASIB_read_qos_pcie_m)(aBaseAddr, 32)
        Set write_qos_pcie_m = (New REGISTER_GPV_ASIB_write_qos_pcie_m)(aBaseAddr, 32)
        Set fn_mod_pcie_m = (New REGISTER_GPV_ASIB_fn_mod_pcie_m)(aBaseAddr, 32)
        Set qos_cntl_pcie_m = (New REGISTER_GPV_ASIB_qos_cntl_pcie_m)(aBaseAddr, 32)
        Set max_ot_pcie_m = (New REGISTER_GPV_ASIB_max_ot_pcie_m)(aBaseAddr, 32)
        Set max_comb_ot_pcie_m = (New REGISTER_GPV_ASIB_max_comb_ot_pcie_m)(aBaseAddr, 32)
        Set aw_p_pcie_m = (New REGISTER_GPV_ASIB_aw_p_pcie_m)(aBaseAddr, 32)
        Set aw_b_pcie_m = (New REGISTER_GPV_ASIB_aw_b_pcie_m)(aBaseAddr, 32)
        Set aw_r_pcie_m = (New REGISTER_GPV_ASIB_aw_r_pcie_m)(aBaseAddr, 32)
        Set ar_p_pcie_m = (New REGISTER_GPV_ASIB_ar_p_pcie_m)(aBaseAddr, 32)
        Set ar_b_pcie_m = (New REGISTER_GPV_ASIB_ar_b_pcie_m)(aBaseAddr, 32)
        Set ar_r_pcie_m = (New REGISTER_GPV_ASIB_ar_r_pcie_m)(aBaseAddr, 32)
        Set target_fc_pcie_m = (New REGISTER_GPV_ASIB_target_fc_pcie_m)(aBaseAddr, 32)
        Set ki_fc_pcie_m = (New REGISTER_GPV_ASIB_ki_fc_pcie_m)(aBaseAddr, 32)
        Set qos_range_pcie_m = (New REGISTER_GPV_ASIB_qos_range_pcie_m)(aBaseAddr, 32)
        Set fn_mod2_hsm_m = (New REGISTER_GPV_ASIB_fn_mod2_hsm_m)(aBaseAddr, 32)
        Set fn_mod_ahb_hsm_m = (New REGISTER_GPV_ASIB_fn_mod_ahb_hsm_m)(aBaseAddr, 32)
        Set read_qos_hsm_m = (New REGISTER_GPV_ASIB_read_qos_hsm_m)(aBaseAddr, 32)
        Set write_qos_hsm_m = (New REGISTER_GPV_ASIB_write_qos_hsm_m)(aBaseAddr, 32)
        Set fn_mod_hsm_m = (New REGISTER_GPV_ASIB_fn_mod_hsm_m)(aBaseAddr, 32)
        Set qos_cntl_hsm_m = (New REGISTER_GPV_ASIB_qos_cntl_hsm_m)(aBaseAddr, 32)
        Set max_ot_hsm_m = (New REGISTER_GPV_ASIB_max_ot_hsm_m)(aBaseAddr, 32)
        Set max_comb_ot_hsm_m = (New REGISTER_GPV_ASIB_max_comb_ot_hsm_m)(aBaseAddr, 32)
        Set aw_p_hsm_m = (New REGISTER_GPV_ASIB_aw_p_hsm_m)(aBaseAddr, 32)
        Set aw_b_hsm_m = (New REGISTER_GPV_ASIB_aw_b_hsm_m)(aBaseAddr, 32)
        Set aw_r_hsm_m = (New REGISTER_GPV_ASIB_aw_r_hsm_m)(aBaseAddr, 32)
        Set ar_p_hsm_m = (New REGISTER_GPV_ASIB_ar_p_hsm_m)(aBaseAddr, 32)
        Set ar_b_hsm_m = (New REGISTER_GPV_ASIB_ar_b_hsm_m)(aBaseAddr, 32)
        Set ar_r_hsm_m = (New REGISTER_GPV_ASIB_ar_r_hsm_m)(aBaseAddr, 32)
        Set target_fc_hsm_m = (New REGISTER_GPV_ASIB_target_fc_hsm_m)(aBaseAddr, 32)
        Set ki_fc_hsm_m = (New REGISTER_GPV_ASIB_ki_fc_hsm_m)(aBaseAddr, 32)
        Set qos_range_hsm_m = (New REGISTER_GPV_ASIB_qos_range_hsm_m)(aBaseAddr, 32)
        Set fn_mod_ahb_ind_m = (New REGISTER_GPV_ASIB_fn_mod_ahb_ind_m)(aBaseAddr, 32)
        Set read_qos_ind_m = (New REGISTER_GPV_ASIB_read_qos_ind_m)(aBaseAddr, 32)
        Set write_qos_ind_m = (New REGISTER_GPV_ASIB_write_qos_ind_m)(aBaseAddr, 32)
        Set fn_mod_ind_m = (New REGISTER_GPV_ASIB_fn_mod_ind_m)(aBaseAddr, 32)
        Set qos_cntl_ind_m = (New REGISTER_GPV_ASIB_qos_cntl_ind_m)(aBaseAddr, 32)
        Set max_ot_ind_m = (New REGISTER_GPV_ASIB_max_ot_ind_m)(aBaseAddr, 32)
        Set max_comb_ot_ind_m = (New REGISTER_GPV_ASIB_max_comb_ot_ind_m)(aBaseAddr, 32)
        Set aw_p_ind_m = (New REGISTER_GPV_ASIB_aw_p_ind_m)(aBaseAddr, 32)
        Set aw_b_ind_m = (New REGISTER_GPV_ASIB_aw_b_ind_m)(aBaseAddr, 32)
        Set aw_r_ind_m = (New REGISTER_GPV_ASIB_aw_r_ind_m)(aBaseAddr, 32)
        Set ar_p_ind_m = (New REGISTER_GPV_ASIB_ar_p_ind_m)(aBaseAddr, 32)
        Set ar_b_ind_m = (New REGISTER_GPV_ASIB_ar_b_ind_m)(aBaseAddr, 32)
        Set ar_r_ind_m = (New REGISTER_GPV_ASIB_ar_r_ind_m)(aBaseAddr, 32)
        Set target_fc_ind_m = (New REGISTER_GPV_ASIB_target_fc_ind_m)(aBaseAddr, 32)
        Set ki_fc_ind_m = (New REGISTER_GPV_ASIB_ki_fc_ind_m)(aBaseAddr, 32)
        Set qos_range_ind_m = (New REGISTER_GPV_ASIB_qos_range_ind_m)(aBaseAddr, 32)
        Set fn_mod2_dap_m = (New REGISTER_GPV_ASIB_fn_mod2_dap_m)(aBaseAddr, 32)
        Set fn_mod_ahb_dap_m = (New REGISTER_GPV_ASIB_fn_mod_ahb_dap_m)(aBaseAddr, 32)
        Set read_qos_dap_m = (New REGISTER_GPV_ASIB_read_qos_dap_m)(aBaseAddr, 32)
        Set write_qos_dap_m = (New REGISTER_GPV_ASIB_write_qos_dap_m)(aBaseAddr, 32)
        Set fn_mod_dap_m = (New REGISTER_GPV_ASIB_fn_mod_dap_m)(aBaseAddr, 32)
        Set qos_cntl_dap_m = (New REGISTER_GPV_ASIB_qos_cntl_dap_m)(aBaseAddr, 32)
        Set max_ot_dap_m = (New REGISTER_GPV_ASIB_max_ot_dap_m)(aBaseAddr, 32)
        Set max_comb_ot_dap_m = (New REGISTER_GPV_ASIB_max_comb_ot_dap_m)(aBaseAddr, 32)
        Set aw_p_dap_m = (New REGISTER_GPV_ASIB_aw_p_dap_m)(aBaseAddr, 32)
        Set aw_b_dap_m = (New REGISTER_GPV_ASIB_aw_b_dap_m)(aBaseAddr, 32)
        Set aw_r_dap_m = (New REGISTER_GPV_ASIB_aw_r_dap_m)(aBaseAddr, 32)
        Set ar_p_dap_m = (New REGISTER_GPV_ASIB_ar_p_dap_m)(aBaseAddr, 32)
        Set ar_b_dap_m = (New REGISTER_GPV_ASIB_ar_b_dap_m)(aBaseAddr, 32)
        Set ar_r_dap_m = (New REGISTER_GPV_ASIB_ar_r_dap_m)(aBaseAddr, 32)
        Set target_fc_dap_m = (New REGISTER_GPV_ASIB_target_fc_dap_m)(aBaseAddr, 32)
        Set ki_fc_dap_m = (New REGISTER_GPV_ASIB_ki_fc_dap_m)(aBaseAddr, 32)
        Set qos_range_dap_m = (New REGISTER_GPV_ASIB_qos_range_dap_m)(aBaseAddr, 32)
        Set fn_mod2_m7_ahbp_m = (New REGISTER_GPV_ASIB_fn_mod2_m7_ahbp_m)(aBaseAddr, 32)
        Set fn_mod_ahb_m7_ahbp_m = (New REGISTER_GPV_ASIB_fn_mod_ahb_m7_ahbp_m)(aBaseAddr, 32)
        Set read_qos_m7_ahbp_m = (New REGISTER_GPV_ASIB_read_qos_m7_ahbp_m)(aBaseAddr, 32)
        Set write_qos_m7_ahbp_m = (New REGISTER_GPV_ASIB_write_qos_m7_ahbp_m)(aBaseAddr, 32)
        Set fn_mod_m7_ahbp_m = (New REGISTER_GPV_ASIB_fn_mod_m7_ahbp_m)(aBaseAddr, 32)
        Set qos_cntl_m7_ahbp_m = (New REGISTER_GPV_ASIB_qos_cntl_m7_ahbp_m)(aBaseAddr, 32)
        Set max_ot_m7_ahbp_m = (New REGISTER_GPV_ASIB_max_ot_m7_ahbp_m)(aBaseAddr, 32)
        Set max_comb_ot_m7_ahbp_m = (New REGISTER_GPV_ASIB_max_comb_ot_m7_ahbp_m)(aBaseAddr, 32)
        Set aw_p_m7_ahbp_m = (New REGISTER_GPV_ASIB_aw_p_m7_ahbp_m)(aBaseAddr, 32)
        Set aw_b_m7_ahbp_m = (New REGISTER_GPV_ASIB_aw_b_m7_ahbp_m)(aBaseAddr, 32)
        Set aw_r_m7_ahbp_m = (New REGISTER_GPV_ASIB_aw_r_m7_ahbp_m)(aBaseAddr, 32)
        Set ar_p_m7_ahbp_m = (New REGISTER_GPV_ASIB_ar_p_m7_ahbp_m)(aBaseAddr, 32)
        Set ar_b_m7_ahbp_m = (New REGISTER_GPV_ASIB_ar_b_m7_ahbp_m)(aBaseAddr, 32)
        Set ar_r_m7_ahbp_m = (New REGISTER_GPV_ASIB_ar_r_m7_ahbp_m)(aBaseAddr, 32)
        Set target_fc_m7_ahbp_m = (New REGISTER_GPV_ASIB_target_fc_m7_ahbp_m)(aBaseAddr, 32)
        Set ki_fc_m7_ahbp_m = (New REGISTER_GPV_ASIB_ki_fc_m7_ahbp_m)(aBaseAddr, 32)
        Set qos_range_m7_ahbp_m = (New REGISTER_GPV_ASIB_qos_range_m7_ahbp_m)(aBaseAddr, 32)
        Set fn_mod2_dma_10t1s_m = (New REGISTER_GPV_ASIB_fn_mod2_dma_10t1s_m)(aBaseAddr, 32)
        Set fn_mod_ahb_dma_10t1s_m = (New REGISTER_GPV_ASIB_fn_mod_ahb_dma_10t1s_m)(aBaseAddr, 32)
        Set wr_tidemark_dma_10t1s_m = (New REGISTER_GPV_ASIB_wr_tidemark_dma_10t1s_m)(aBaseAddr, 32)
        Set read_qos_dma_10t1s_m = (New REGISTER_GPV_ASIB_read_qos_dma_10t1s_m)(aBaseAddr, 32)
        Set write_qos_dma_10t1s_m = (New REGISTER_GPV_ASIB_write_qos_dma_10t1s_m)(aBaseAddr, 32)
        Set fn_mod_dma_10t1s_m = (New REGISTER_GPV_ASIB_fn_mod_dma_10t1s_m)(aBaseAddr, 32)
        Set qos_cntl_dma_10t1s_m = (New REGISTER_GPV_ASIB_qos_cntl_dma_10t1s_m)(aBaseAddr, 32)
        Set max_ot_dma_10t1s_m = (New REGISTER_GPV_ASIB_max_ot_dma_10t1s_m)(aBaseAddr, 32)
        Set max_comb_ot_dma_10t1s_m = (New REGISTER_GPV_ASIB_max_comb_ot_dma_10t1s_m)(aBaseAddr, 32)
        Set aw_p_dma_10t1s_m = (New REGISTER_GPV_ASIB_aw_p_dma_10t1s_m)(aBaseAddr, 32)
        Set aw_b_dma_10t1s_m = (New REGISTER_GPV_ASIB_aw_b_dma_10t1s_m)(aBaseAddr, 32)
        Set aw_r_dma_10t1s_m = (New REGISTER_GPV_ASIB_aw_r_dma_10t1s_m)(aBaseAddr, 32)
        Set ar_p_dma_10t1s_m = (New REGISTER_GPV_ASIB_ar_p_dma_10t1s_m)(aBaseAddr, 32)
        Set ar_b_dma_10t1s_m = (New REGISTER_GPV_ASIB_ar_b_dma_10t1s_m)(aBaseAddr, 32)
        Set ar_r_dma_10t1s_m = (New REGISTER_GPV_ASIB_ar_r_dma_10t1s_m)(aBaseAddr, 32)
        Set target_fc_dma_10t1s_m = (New REGISTER_GPV_ASIB_target_fc_dma_10t1s_m)(aBaseAddr, 32)
        Set ki_fc_dma_10t1s_m = (New REGISTER_GPV_ASIB_ki_fc_dma_10t1s_m)(aBaseAddr, 32)
        Set qos_range_dma_10t1s_m = (New REGISTER_GPV_ASIB_qos_range_dma_10t1s_m)(aBaseAddr, 32)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set GPV_ASIB = CreateObject("System.Collections.ArrayList")
GPV_ASIB.Add ((New GPV_ASIB_INSTANCE)(&H4c242000))


