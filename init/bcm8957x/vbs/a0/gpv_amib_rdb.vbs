

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


'' @REGISTER : GPV_AMIB_fn_mod_bm_iss_m7_ahb_s
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' fn_mod_bm_iss                              [1:0]            get_fn_mod_bm_iss
''                                                             set_fn_mod_bm_iss
''                                                             read_fn_mod_bm_iss
''                                                             write_fn_mod_bm_iss
''---------------------------------------------------------------------------------
Class REGISTER_GPV_AMIB_fn_mod_bm_iss_m7_ahb_s
    Private write_fn_mod_bm_iss_value
    Private read_fn_mod_bm_iss_value
    Private flag_fn_mod_bm_iss

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

    Property Get get_fn_mod_bm_iss
        get_fn_mod_bm_iss = read_fn_mod_bm_iss_value
    End Property

    Property Let set_fn_mod_bm_iss(aData)
        write_fn_mod_bm_iss_value = aData
        flag_fn_mod_bm_iss        = &H1
    End Property

    Property Get read_fn_mod_bm_iss
        read
        read_fn_mod_bm_iss = read_fn_mod_bm_iss_value
    End Property

    Property Let write_fn_mod_bm_iss(aData)
        set_fn_mod_bm_iss = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        fn_mod_bm_iss_mask = &H3
        if data_low > LONG_MAX then
            if fn_mod_bm_iss_mask = mask then
                read_fn_mod_bm_iss_value = data_low
            else
                read_fn_mod_bm_iss_value = (data_low - H8000_0000) and fn_mod_bm_iss_mask
            end If
        else
            read_fn_mod_bm_iss_value = data_low and fn_mod_bm_iss_mask
        end If

    End Sub

    Sub write
        If flag_fn_mod_bm_iss = &H0 Then read
        If flag_fn_mod_bm_iss = &H0 Then write_fn_mod_bm_iss_value = get_fn_mod_bm_iss

        regValue = leftShift((write_fn_mod_bm_iss_value and &H3), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        fn_mod_bm_iss_mask = &H3
        if data_low > LONG_MAX then
            if fn_mod_bm_iss_mask = mask then
                read_fn_mod_bm_iss_value = data_low
            else
                read_fn_mod_bm_iss_value = (data_low - H8000_0000) and fn_mod_bm_iss_mask
            end If
        else
            read_fn_mod_bm_iss_value = data_low and fn_mod_bm_iss_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_fn_mod_bm_iss_value = &H0
        flag_fn_mod_bm_iss        = &H0
    End Sub
End Class


'' @REGISTER : GPV_AMIB_fn_mod2_m7_ahb_s
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' fn_mod2                                    [0:0]            get_fn_mod2
''                                                             set_fn_mod2
''                                                             read_fn_mod2
''                                                             write_fn_mod2
''---------------------------------------------------------------------------------
Class REGISTER_GPV_AMIB_fn_mod2_m7_ahb_s
    Private write_fn_mod2_value
    Private read_fn_mod2_value
    Private flag_fn_mod2

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

    Property Get get_fn_mod2
        get_fn_mod2 = read_fn_mod2_value
    End Property

    Property Let set_fn_mod2(aData)
        write_fn_mod2_value = aData
        flag_fn_mod2        = &H1
    End Property

    Property Get read_fn_mod2
        read
        read_fn_mod2 = read_fn_mod2_value
    End Property

    Property Let write_fn_mod2(aData)
        set_fn_mod2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        fn_mod2_mask = &H1
        if data_low > LONG_MAX then
            if fn_mod2_mask = mask then
                read_fn_mod2_value = data_low
            else
                read_fn_mod2_value = (data_low - H8000_0000) and fn_mod2_mask
            end If
        else
            read_fn_mod2_value = data_low and fn_mod2_mask
        end If

    End Sub

    Sub write
        If flag_fn_mod2 = &H0 Then read
        If flag_fn_mod2 = &H0 Then write_fn_mod2_value = get_fn_mod2

        regValue = leftShift((write_fn_mod2_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        fn_mod2_mask = &H1
        if data_low > LONG_MAX then
            if fn_mod2_mask = mask then
                read_fn_mod2_value = data_low
            else
                read_fn_mod2_value = (data_low - H8000_0000) and fn_mod2_mask
            end If
        else
            read_fn_mod2_value = data_low and fn_mod2_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_fn_mod2_value = &H0
        flag_fn_mod2        = &H0
    End Sub
End Class


'' @REGISTER : GPV_AMIB_fn_mod_lb_m7_ahb_s
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' fn_mod_lb                                  [0:0]            get_fn_mod_lb
''                                                             set_fn_mod_lb
''                                                             read_fn_mod_lb
''                                                             write_fn_mod_lb
''---------------------------------------------------------------------------------
Class REGISTER_GPV_AMIB_fn_mod_lb_m7_ahb_s
    Private write_fn_mod_lb_value
    Private read_fn_mod_lb_value
    Private flag_fn_mod_lb

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H2c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_fn_mod_lb
        get_fn_mod_lb = read_fn_mod_lb_value
    End Property

    Property Let set_fn_mod_lb(aData)
        write_fn_mod_lb_value = aData
        flag_fn_mod_lb        = &H1
    End Property

    Property Get read_fn_mod_lb
        read
        read_fn_mod_lb = read_fn_mod_lb_value
    End Property

    Property Let write_fn_mod_lb(aData)
        set_fn_mod_lb = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        fn_mod_lb_mask = &H1
        if data_low > LONG_MAX then
            if fn_mod_lb_mask = mask then
                read_fn_mod_lb_value = data_low
            else
                read_fn_mod_lb_value = (data_low - H8000_0000) and fn_mod_lb_mask
            end If
        else
            read_fn_mod_lb_value = data_low and fn_mod_lb_mask
        end If

    End Sub

    Sub write
        If flag_fn_mod_lb = &H0 Then read
        If flag_fn_mod_lb = &H0 Then write_fn_mod_lb_value = get_fn_mod_lb

        regValue = leftShift((write_fn_mod_lb_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        fn_mod_lb_mask = &H1
        if data_low > LONG_MAX then
            if fn_mod_lb_mask = mask then
                read_fn_mod_lb_value = data_low
            else
                read_fn_mod_lb_value = (data_low - H8000_0000) and fn_mod_lb_mask
            end If
        else
            read_fn_mod_lb_value = data_low and fn_mod_lb_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_fn_mod_lb_value = &H0
        flag_fn_mod_lb        = &H0
    End Sub
End Class


'' @REGISTER : GPV_AMIB_fn_mod_m7_ahb_s
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
Class REGISTER_GPV_AMIB_fn_mod_m7_ahb_s
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


'' @REGISTER : GPV_AMIB_fn_mod_bm_iss_cfg_s
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' fn_mod_bm_iss                              [1:0]            get_fn_mod_bm_iss
''                                                             set_fn_mod_bm_iss
''                                                             read_fn_mod_bm_iss
''                                                             write_fn_mod_bm_iss
''---------------------------------------------------------------------------------
Class REGISTER_GPV_AMIB_fn_mod_bm_iss_cfg_s
    Private write_fn_mod_bm_iss_value
    Private read_fn_mod_bm_iss_value
    Private flag_fn_mod_bm_iss

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1008
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_fn_mod_bm_iss
        get_fn_mod_bm_iss = read_fn_mod_bm_iss_value
    End Property

    Property Let set_fn_mod_bm_iss(aData)
        write_fn_mod_bm_iss_value = aData
        flag_fn_mod_bm_iss        = &H1
    End Property

    Property Get read_fn_mod_bm_iss
        read
        read_fn_mod_bm_iss = read_fn_mod_bm_iss_value
    End Property

    Property Let write_fn_mod_bm_iss(aData)
        set_fn_mod_bm_iss = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        fn_mod_bm_iss_mask = &H3
        if data_low > LONG_MAX then
            if fn_mod_bm_iss_mask = mask then
                read_fn_mod_bm_iss_value = data_low
            else
                read_fn_mod_bm_iss_value = (data_low - H8000_0000) and fn_mod_bm_iss_mask
            end If
        else
            read_fn_mod_bm_iss_value = data_low and fn_mod_bm_iss_mask
        end If

    End Sub

    Sub write
        If flag_fn_mod_bm_iss = &H0 Then read
        If flag_fn_mod_bm_iss = &H0 Then write_fn_mod_bm_iss_value = get_fn_mod_bm_iss

        regValue = leftShift((write_fn_mod_bm_iss_value and &H3), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        fn_mod_bm_iss_mask = &H3
        if data_low > LONG_MAX then
            if fn_mod_bm_iss_mask = mask then
                read_fn_mod_bm_iss_value = data_low
            else
                read_fn_mod_bm_iss_value = (data_low - H8000_0000) and fn_mod_bm_iss_mask
            end If
        else
            read_fn_mod_bm_iss_value = data_low and fn_mod_bm_iss_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_fn_mod_bm_iss_value = &H0
        flag_fn_mod_bm_iss        = &H0
    End Sub
End Class


'' @REGISTER : GPV_AMIB_fn_mod_bm_iss_memp0_s
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' fn_mod_bm_iss                              [1:0]            get_fn_mod_bm_iss
''                                                             set_fn_mod_bm_iss
''                                                             read_fn_mod_bm_iss
''                                                             write_fn_mod_bm_iss
''---------------------------------------------------------------------------------
Class REGISTER_GPV_AMIB_fn_mod_bm_iss_memp0_s
    Private write_fn_mod_bm_iss_value
    Private read_fn_mod_bm_iss_value
    Private flag_fn_mod_bm_iss

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H2008
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_fn_mod_bm_iss
        get_fn_mod_bm_iss = read_fn_mod_bm_iss_value
    End Property

    Property Let set_fn_mod_bm_iss(aData)
        write_fn_mod_bm_iss_value = aData
        flag_fn_mod_bm_iss        = &H1
    End Property

    Property Get read_fn_mod_bm_iss
        read
        read_fn_mod_bm_iss = read_fn_mod_bm_iss_value
    End Property

    Property Let write_fn_mod_bm_iss(aData)
        set_fn_mod_bm_iss = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        fn_mod_bm_iss_mask = &H3
        if data_low > LONG_MAX then
            if fn_mod_bm_iss_mask = mask then
                read_fn_mod_bm_iss_value = data_low
            else
                read_fn_mod_bm_iss_value = (data_low - H8000_0000) and fn_mod_bm_iss_mask
            end If
        else
            read_fn_mod_bm_iss_value = data_low and fn_mod_bm_iss_mask
        end If

    End Sub

    Sub write
        If flag_fn_mod_bm_iss = &H0 Then read
        If flag_fn_mod_bm_iss = &H0 Then write_fn_mod_bm_iss_value = get_fn_mod_bm_iss

        regValue = leftShift((write_fn_mod_bm_iss_value and &H3), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        fn_mod_bm_iss_mask = &H3
        if data_low > LONG_MAX then
            if fn_mod_bm_iss_mask = mask then
                read_fn_mod_bm_iss_value = data_low
            else
                read_fn_mod_bm_iss_value = (data_low - H8000_0000) and fn_mod_bm_iss_mask
            end If
        else
            read_fn_mod_bm_iss_value = data_low and fn_mod_bm_iss_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_fn_mod_bm_iss_value = &H0
        flag_fn_mod_bm_iss        = &H0
    End Sub
End Class


'' @REGISTER : GPV_AMIB_fn_mod_bm_iss_memp1_s
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' fn_mod_bm_iss                              [1:0]            get_fn_mod_bm_iss
''                                                             set_fn_mod_bm_iss
''                                                             read_fn_mod_bm_iss
''                                                             write_fn_mod_bm_iss
''---------------------------------------------------------------------------------
Class REGISTER_GPV_AMIB_fn_mod_bm_iss_memp1_s
    Private write_fn_mod_bm_iss_value
    Private read_fn_mod_bm_iss_value
    Private flag_fn_mod_bm_iss

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

    Property Get get_fn_mod_bm_iss
        get_fn_mod_bm_iss = read_fn_mod_bm_iss_value
    End Property

    Property Let set_fn_mod_bm_iss(aData)
        write_fn_mod_bm_iss_value = aData
        flag_fn_mod_bm_iss        = &H1
    End Property

    Property Get read_fn_mod_bm_iss
        read
        read_fn_mod_bm_iss = read_fn_mod_bm_iss_value
    End Property

    Property Let write_fn_mod_bm_iss(aData)
        set_fn_mod_bm_iss = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        fn_mod_bm_iss_mask = &H3
        if data_low > LONG_MAX then
            if fn_mod_bm_iss_mask = mask then
                read_fn_mod_bm_iss_value = data_low
            else
                read_fn_mod_bm_iss_value = (data_low - H8000_0000) and fn_mod_bm_iss_mask
            end If
        else
            read_fn_mod_bm_iss_value = data_low and fn_mod_bm_iss_mask
        end If

    End Sub

    Sub write
        If flag_fn_mod_bm_iss = &H0 Then read
        If flag_fn_mod_bm_iss = &H0 Then write_fn_mod_bm_iss_value = get_fn_mod_bm_iss

        regValue = leftShift((write_fn_mod_bm_iss_value and &H3), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        fn_mod_bm_iss_mask = &H3
        if data_low > LONG_MAX then
            if fn_mod_bm_iss_mask = mask then
                read_fn_mod_bm_iss_value = data_low
            else
                read_fn_mod_bm_iss_value = (data_low - H8000_0000) and fn_mod_bm_iss_mask
            end If
        else
            read_fn_mod_bm_iss_value = data_low and fn_mod_bm_iss_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_fn_mod_bm_iss_value = &H0
        flag_fn_mod_bm_iss        = &H0
    End Sub
End Class


'' @REGISTER : GPV_AMIB_fn_mod_bm_iss_hsm_s
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' fn_mod_bm_iss                              [1:0]            get_fn_mod_bm_iss
''                                                             set_fn_mod_bm_iss
''                                                             read_fn_mod_bm_iss
''                                                             write_fn_mod_bm_iss
''---------------------------------------------------------------------------------
Class REGISTER_GPV_AMIB_fn_mod_bm_iss_hsm_s
    Private write_fn_mod_bm_iss_value
    Private read_fn_mod_bm_iss_value
    Private flag_fn_mod_bm_iss

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H4008
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_fn_mod_bm_iss
        get_fn_mod_bm_iss = read_fn_mod_bm_iss_value
    End Property

    Property Let set_fn_mod_bm_iss(aData)
        write_fn_mod_bm_iss_value = aData
        flag_fn_mod_bm_iss        = &H1
    End Property

    Property Get read_fn_mod_bm_iss
        read
        read_fn_mod_bm_iss = read_fn_mod_bm_iss_value
    End Property

    Property Let write_fn_mod_bm_iss(aData)
        set_fn_mod_bm_iss = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        fn_mod_bm_iss_mask = &H3
        if data_low > LONG_MAX then
            if fn_mod_bm_iss_mask = mask then
                read_fn_mod_bm_iss_value = data_low
            else
                read_fn_mod_bm_iss_value = (data_low - H8000_0000) and fn_mod_bm_iss_mask
            end If
        else
            read_fn_mod_bm_iss_value = data_low and fn_mod_bm_iss_mask
        end If

    End Sub

    Sub write
        If flag_fn_mod_bm_iss = &H0 Then read
        If flag_fn_mod_bm_iss = &H0 Then write_fn_mod_bm_iss_value = get_fn_mod_bm_iss

        regValue = leftShift((write_fn_mod_bm_iss_value and &H3), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        fn_mod_bm_iss_mask = &H3
        if data_low > LONG_MAX then
            if fn_mod_bm_iss_mask = mask then
                read_fn_mod_bm_iss_value = data_low
            else
                read_fn_mod_bm_iss_value = (data_low - H8000_0000) and fn_mod_bm_iss_mask
            end If
        else
            read_fn_mod_bm_iss_value = data_low and fn_mod_bm_iss_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_fn_mod_bm_iss_value = &H0
        flag_fn_mod_bm_iss        = &H0
    End Sub
End Class


'' @REGISTER : GPV_AMIB_fn_mod2_hsm_s
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' fn_mod2                                    [0:0]            get_fn_mod2
''                                                             set_fn_mod2
''                                                             read_fn_mod2
''                                                             write_fn_mod2
''---------------------------------------------------------------------------------
Class REGISTER_GPV_AMIB_fn_mod2_hsm_s
    Private write_fn_mod2_value
    Private read_fn_mod2_value
    Private flag_fn_mod2

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

    Property Get get_fn_mod2
        get_fn_mod2 = read_fn_mod2_value
    End Property

    Property Let set_fn_mod2(aData)
        write_fn_mod2_value = aData
        flag_fn_mod2        = &H1
    End Property

    Property Get read_fn_mod2
        read
        read_fn_mod2 = read_fn_mod2_value
    End Property

    Property Let write_fn_mod2(aData)
        set_fn_mod2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        fn_mod2_mask = &H1
        if data_low > LONG_MAX then
            if fn_mod2_mask = mask then
                read_fn_mod2_value = data_low
            else
                read_fn_mod2_value = (data_low - H8000_0000) and fn_mod2_mask
            end If
        else
            read_fn_mod2_value = data_low and fn_mod2_mask
        end If

    End Sub

    Sub write
        If flag_fn_mod2 = &H0 Then read
        If flag_fn_mod2 = &H0 Then write_fn_mod2_value = get_fn_mod2

        regValue = leftShift((write_fn_mod2_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        fn_mod2_mask = &H1
        if data_low > LONG_MAX then
            if fn_mod2_mask = mask then
                read_fn_mod2_value = data_low
            else
                read_fn_mod2_value = (data_low - H8000_0000) and fn_mod2_mask
            end If
        else
            read_fn_mod2_value = data_low and fn_mod2_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_fn_mod2_value = &H0
        flag_fn_mod2        = &H0
    End Sub
End Class


'' @REGISTER : GPV_AMIB_ahb_cntl_hsm_s
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ahb_cntl                                   [1:0]            get_ahb_cntl
''                                                             set_ahb_cntl
''                                                             read_ahb_cntl
''                                                             write_ahb_cntl
''---------------------------------------------------------------------------------
Class REGISTER_GPV_AMIB_ahb_cntl_hsm_s
    Private write_ahb_cntl_value
    Private read_ahb_cntl_value
    Private flag_ahb_cntl

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H4044
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ahb_cntl
        get_ahb_cntl = read_ahb_cntl_value
    End Property

    Property Let set_ahb_cntl(aData)
        write_ahb_cntl_value = aData
        flag_ahb_cntl        = &H1
    End Property

    Property Get read_ahb_cntl
        read
        read_ahb_cntl = read_ahb_cntl_value
    End Property

    Property Let write_ahb_cntl(aData)
        set_ahb_cntl = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ahb_cntl_mask = &H3
        if data_low > LONG_MAX then
            if ahb_cntl_mask = mask then
                read_ahb_cntl_value = data_low
            else
                read_ahb_cntl_value = (data_low - H8000_0000) and ahb_cntl_mask
            end If
        else
            read_ahb_cntl_value = data_low and ahb_cntl_mask
        end If

    End Sub

    Sub write
        If flag_ahb_cntl = &H0 Then read
        If flag_ahb_cntl = &H0 Then write_ahb_cntl_value = get_ahb_cntl

        regValue = leftShift((write_ahb_cntl_value and &H3), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ahb_cntl_mask = &H3
        if data_low > LONG_MAX then
            if ahb_cntl_mask = mask then
                read_ahb_cntl_value = data_low
            else
                read_ahb_cntl_value = (data_low - H8000_0000) and ahb_cntl_mask
            end If
        else
            read_ahb_cntl_value = data_low and ahb_cntl_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ahb_cntl_value = &H0
        flag_ahb_cntl        = &H0
    End Sub
End Class


'' @REGISTER : GPV_AMIB_fn_mod_bm_iss_ind_s
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' fn_mod_bm_iss                              [1:0]            get_fn_mod_bm_iss
''                                                             set_fn_mod_bm_iss
''                                                             read_fn_mod_bm_iss
''                                                             write_fn_mod_bm_iss
''---------------------------------------------------------------------------------
Class REGISTER_GPV_AMIB_fn_mod_bm_iss_ind_s
    Private write_fn_mod_bm_iss_value
    Private read_fn_mod_bm_iss_value
    Private flag_fn_mod_bm_iss

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H5008
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_fn_mod_bm_iss
        get_fn_mod_bm_iss = read_fn_mod_bm_iss_value
    End Property

    Property Let set_fn_mod_bm_iss(aData)
        write_fn_mod_bm_iss_value = aData
        flag_fn_mod_bm_iss        = &H1
    End Property

    Property Get read_fn_mod_bm_iss
        read
        read_fn_mod_bm_iss = read_fn_mod_bm_iss_value
    End Property

    Property Let write_fn_mod_bm_iss(aData)
        set_fn_mod_bm_iss = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        fn_mod_bm_iss_mask = &H3
        if data_low > LONG_MAX then
            if fn_mod_bm_iss_mask = mask then
                read_fn_mod_bm_iss_value = data_low
            else
                read_fn_mod_bm_iss_value = (data_low - H8000_0000) and fn_mod_bm_iss_mask
            end If
        else
            read_fn_mod_bm_iss_value = data_low and fn_mod_bm_iss_mask
        end If

    End Sub

    Sub write
        If flag_fn_mod_bm_iss = &H0 Then read
        If flag_fn_mod_bm_iss = &H0 Then write_fn_mod_bm_iss_value = get_fn_mod_bm_iss

        regValue = leftShift((write_fn_mod_bm_iss_value and &H3), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        fn_mod_bm_iss_mask = &H3
        if data_low > LONG_MAX then
            if fn_mod_bm_iss_mask = mask then
                read_fn_mod_bm_iss_value = data_low
            else
                read_fn_mod_bm_iss_value = (data_low - H8000_0000) and fn_mod_bm_iss_mask
            end If
        else
            read_fn_mod_bm_iss_value = data_low and fn_mod_bm_iss_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_fn_mod_bm_iss_value = &H0
        flag_fn_mod_bm_iss        = &H0
    End Sub
End Class


'' @REGISTER : GPV_AMIB_ahb_cntl_ind_s
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ahb_cntl                                   [1:0]            get_ahb_cntl
''                                                             set_ahb_cntl
''                                                             read_ahb_cntl
''                                                             write_ahb_cntl
''---------------------------------------------------------------------------------
Class REGISTER_GPV_AMIB_ahb_cntl_ind_s
    Private write_ahb_cntl_value
    Private read_ahb_cntl_value
    Private flag_ahb_cntl

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H5044
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ahb_cntl
        get_ahb_cntl = read_ahb_cntl_value
    End Property

    Property Let set_ahb_cntl(aData)
        write_ahb_cntl_value = aData
        flag_ahb_cntl        = &H1
    End Property

    Property Get read_ahb_cntl
        read
        read_ahb_cntl = read_ahb_cntl_value
    End Property

    Property Let write_ahb_cntl(aData)
        set_ahb_cntl = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ahb_cntl_mask = &H3
        if data_low > LONG_MAX then
            if ahb_cntl_mask = mask then
                read_ahb_cntl_value = data_low
            else
                read_ahb_cntl_value = (data_low - H8000_0000) and ahb_cntl_mask
            end If
        else
            read_ahb_cntl_value = data_low and ahb_cntl_mask
        end If

    End Sub

    Sub write
        If flag_ahb_cntl = &H0 Then read
        If flag_ahb_cntl = &H0 Then write_ahb_cntl_value = get_ahb_cntl

        regValue = leftShift((write_ahb_cntl_value and &H3), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ahb_cntl_mask = &H3
        if data_low > LONG_MAX then
            if ahb_cntl_mask = mask then
                read_ahb_cntl_value = data_low
            else
                read_ahb_cntl_value = (data_low - H8000_0000) and ahb_cntl_mask
            end If
        else
            read_ahb_cntl_value = data_low and ahb_cntl_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ahb_cntl_value = &H0
        flag_ahb_cntl        = &H0
    End Sub
End Class


'' @REGISTER : GPV_AMIB_fn_mod_bm_iss_qspi_s
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' fn_mod_bm_iss                              [1:0]            get_fn_mod_bm_iss
''                                                             set_fn_mod_bm_iss
''                                                             read_fn_mod_bm_iss
''                                                             write_fn_mod_bm_iss
''---------------------------------------------------------------------------------
Class REGISTER_GPV_AMIB_fn_mod_bm_iss_qspi_s
    Private write_fn_mod_bm_iss_value
    Private read_fn_mod_bm_iss_value
    Private flag_fn_mod_bm_iss

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H6008
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_fn_mod_bm_iss
        get_fn_mod_bm_iss = read_fn_mod_bm_iss_value
    End Property

    Property Let set_fn_mod_bm_iss(aData)
        write_fn_mod_bm_iss_value = aData
        flag_fn_mod_bm_iss        = &H1
    End Property

    Property Get read_fn_mod_bm_iss
        read
        read_fn_mod_bm_iss = read_fn_mod_bm_iss_value
    End Property

    Property Let write_fn_mod_bm_iss(aData)
        set_fn_mod_bm_iss = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        fn_mod_bm_iss_mask = &H3
        if data_low > LONG_MAX then
            if fn_mod_bm_iss_mask = mask then
                read_fn_mod_bm_iss_value = data_low
            else
                read_fn_mod_bm_iss_value = (data_low - H8000_0000) and fn_mod_bm_iss_mask
            end If
        else
            read_fn_mod_bm_iss_value = data_low and fn_mod_bm_iss_mask
        end If

    End Sub

    Sub write
        If flag_fn_mod_bm_iss = &H0 Then read
        If flag_fn_mod_bm_iss = &H0 Then write_fn_mod_bm_iss_value = get_fn_mod_bm_iss

        regValue = leftShift((write_fn_mod_bm_iss_value and &H3), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        fn_mod_bm_iss_mask = &H3
        if data_low > LONG_MAX then
            if fn_mod_bm_iss_mask = mask then
                read_fn_mod_bm_iss_value = data_low
            else
                read_fn_mod_bm_iss_value = (data_low - H8000_0000) and fn_mod_bm_iss_mask
            end If
        else
            read_fn_mod_bm_iss_value = data_low and fn_mod_bm_iss_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_fn_mod_bm_iss_value = &H0
        flag_fn_mod_bm_iss        = &H0
    End Sub
End Class


'' @REGISTER : GPV_AMIB_fn_mod2_qspi_s
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' fn_mod2                                    [0:0]            get_fn_mod2
''                                                             set_fn_mod2
''                                                             read_fn_mod2
''                                                             write_fn_mod2
''---------------------------------------------------------------------------------
Class REGISTER_GPV_AMIB_fn_mod2_qspi_s
    Private write_fn_mod2_value
    Private read_fn_mod2_value
    Private flag_fn_mod2

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

    Property Get get_fn_mod2
        get_fn_mod2 = read_fn_mod2_value
    End Property

    Property Let set_fn_mod2(aData)
        write_fn_mod2_value = aData
        flag_fn_mod2        = &H1
    End Property

    Property Get read_fn_mod2
        read
        read_fn_mod2 = read_fn_mod2_value
    End Property

    Property Let write_fn_mod2(aData)
        set_fn_mod2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        fn_mod2_mask = &H1
        if data_low > LONG_MAX then
            if fn_mod2_mask = mask then
                read_fn_mod2_value = data_low
            else
                read_fn_mod2_value = (data_low - H8000_0000) and fn_mod2_mask
            end If
        else
            read_fn_mod2_value = data_low and fn_mod2_mask
        end If

    End Sub

    Sub write
        If flag_fn_mod2 = &H0 Then read
        If flag_fn_mod2 = &H0 Then write_fn_mod2_value = get_fn_mod2

        regValue = leftShift((write_fn_mod2_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        fn_mod2_mask = &H1
        if data_low > LONG_MAX then
            if fn_mod2_mask = mask then
                read_fn_mod2_value = data_low
            else
                read_fn_mod2_value = (data_low - H8000_0000) and fn_mod2_mask
            end If
        else
            read_fn_mod2_value = data_low and fn_mod2_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_fn_mod2_value = &H0
        flag_fn_mod2        = &H0
    End Sub
End Class


'' @REGISTER : GPV_AMIB_fn_mod_qspi_s
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
Class REGISTER_GPV_AMIB_fn_mod_qspi_s
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


'' @REGISTER : GPV_AMIB_fn_mod_bm_iss_pcie_s
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' fn_mod_bm_iss                              [1:0]            get_fn_mod_bm_iss
''                                                             set_fn_mod_bm_iss
''                                                             read_fn_mod_bm_iss
''                                                             write_fn_mod_bm_iss
''---------------------------------------------------------------------------------
Class REGISTER_GPV_AMIB_fn_mod_bm_iss_pcie_s
    Private write_fn_mod_bm_iss_value
    Private read_fn_mod_bm_iss_value
    Private flag_fn_mod_bm_iss

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H7008
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_fn_mod_bm_iss
        get_fn_mod_bm_iss = read_fn_mod_bm_iss_value
    End Property

    Property Let set_fn_mod_bm_iss(aData)
        write_fn_mod_bm_iss_value = aData
        flag_fn_mod_bm_iss        = &H1
    End Property

    Property Get read_fn_mod_bm_iss
        read
        read_fn_mod_bm_iss = read_fn_mod_bm_iss_value
    End Property

    Property Let write_fn_mod_bm_iss(aData)
        set_fn_mod_bm_iss = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        fn_mod_bm_iss_mask = &H3
        if data_low > LONG_MAX then
            if fn_mod_bm_iss_mask = mask then
                read_fn_mod_bm_iss_value = data_low
            else
                read_fn_mod_bm_iss_value = (data_low - H8000_0000) and fn_mod_bm_iss_mask
            end If
        else
            read_fn_mod_bm_iss_value = data_low and fn_mod_bm_iss_mask
        end If

    End Sub

    Sub write
        If flag_fn_mod_bm_iss = &H0 Then read
        If flag_fn_mod_bm_iss = &H0 Then write_fn_mod_bm_iss_value = get_fn_mod_bm_iss

        regValue = leftShift((write_fn_mod_bm_iss_value and &H3), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        fn_mod_bm_iss_mask = &H3
        if data_low > LONG_MAX then
            if fn_mod_bm_iss_mask = mask then
                read_fn_mod_bm_iss_value = data_low
            else
                read_fn_mod_bm_iss_value = (data_low - H8000_0000) and fn_mod_bm_iss_mask
            end If
        else
            read_fn_mod_bm_iss_value = data_low and fn_mod_bm_iss_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_fn_mod_bm_iss_value = &H0
        flag_fn_mod_bm_iss        = &H0
    End Sub
End Class


'' @REGISTER : GPV_AMIB_fn_mod2_pcie_s
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' fn_mod2                                    [0:0]            get_fn_mod2
''                                                             set_fn_mod2
''                                                             read_fn_mod2
''                                                             write_fn_mod2
''---------------------------------------------------------------------------------
Class REGISTER_GPV_AMIB_fn_mod2_pcie_s
    Private write_fn_mod2_value
    Private read_fn_mod2_value
    Private flag_fn_mod2

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

    Property Get get_fn_mod2
        get_fn_mod2 = read_fn_mod2_value
    End Property

    Property Let set_fn_mod2(aData)
        write_fn_mod2_value = aData
        flag_fn_mod2        = &H1
    End Property

    Property Get read_fn_mod2
        read
        read_fn_mod2 = read_fn_mod2_value
    End Property

    Property Let write_fn_mod2(aData)
        set_fn_mod2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        fn_mod2_mask = &H1
        if data_low > LONG_MAX then
            if fn_mod2_mask = mask then
                read_fn_mod2_value = data_low
            else
                read_fn_mod2_value = (data_low - H8000_0000) and fn_mod2_mask
            end If
        else
            read_fn_mod2_value = data_low and fn_mod2_mask
        end If

    End Sub

    Sub write
        If flag_fn_mod2 = &H0 Then read
        If flag_fn_mod2 = &H0 Then write_fn_mod2_value = get_fn_mod2

        regValue = leftShift((write_fn_mod2_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        fn_mod2_mask = &H1
        if data_low > LONG_MAX then
            if fn_mod2_mask = mask then
                read_fn_mod2_value = data_low
            else
                read_fn_mod2_value = (data_low - H8000_0000) and fn_mod2_mask
            end If
        else
            read_fn_mod2_value = data_low and fn_mod2_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_fn_mod2_value = &H0
        flag_fn_mod2        = &H0
    End Sub
End Class


'' @REGISTER : GPV_AMIB_fn_mod_pcie_s
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
Class REGISTER_GPV_AMIB_fn_mod_pcie_s
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


'' @REGISTER : GPV_AMIB_fn_mod_bm_iss_dma_10t1s_s
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' fn_mod_bm_iss                              [1:0]            get_fn_mod_bm_iss
''                                                             set_fn_mod_bm_iss
''                                                             read_fn_mod_bm_iss
''                                                             write_fn_mod_bm_iss
''---------------------------------------------------------------------------------
Class REGISTER_GPV_AMIB_fn_mod_bm_iss_dma_10t1s_s
    Private write_fn_mod_bm_iss_value
    Private read_fn_mod_bm_iss_value
    Private flag_fn_mod_bm_iss

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H8008
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_fn_mod_bm_iss
        get_fn_mod_bm_iss = read_fn_mod_bm_iss_value
    End Property

    Property Let set_fn_mod_bm_iss(aData)
        write_fn_mod_bm_iss_value = aData
        flag_fn_mod_bm_iss        = &H1
    End Property

    Property Get read_fn_mod_bm_iss
        read
        read_fn_mod_bm_iss = read_fn_mod_bm_iss_value
    End Property

    Property Let write_fn_mod_bm_iss(aData)
        set_fn_mod_bm_iss = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        fn_mod_bm_iss_mask = &H3
        if data_low > LONG_MAX then
            if fn_mod_bm_iss_mask = mask then
                read_fn_mod_bm_iss_value = data_low
            else
                read_fn_mod_bm_iss_value = (data_low - H8000_0000) and fn_mod_bm_iss_mask
            end If
        else
            read_fn_mod_bm_iss_value = data_low and fn_mod_bm_iss_mask
        end If

    End Sub

    Sub write
        If flag_fn_mod_bm_iss = &H0 Then read
        If flag_fn_mod_bm_iss = &H0 Then write_fn_mod_bm_iss_value = get_fn_mod_bm_iss

        regValue = leftShift((write_fn_mod_bm_iss_value and &H3), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        fn_mod_bm_iss_mask = &H3
        if data_low > LONG_MAX then
            if fn_mod_bm_iss_mask = mask then
                read_fn_mod_bm_iss_value = data_low
            else
                read_fn_mod_bm_iss_value = (data_low - H8000_0000) and fn_mod_bm_iss_mask
            end If
        else
            read_fn_mod_bm_iss_value = data_low and fn_mod_bm_iss_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_fn_mod_bm_iss_value = &H0
        flag_fn_mod_bm_iss        = &H0
    End Sub
End Class


'' @REGISTER : GPV_AMIB_fn_mod2_dma_10t1s_s
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' fn_mod2                                    [0:0]            get_fn_mod2
''                                                             set_fn_mod2
''                                                             read_fn_mod2
''                                                             write_fn_mod2
''---------------------------------------------------------------------------------
Class REGISTER_GPV_AMIB_fn_mod2_dma_10t1s_s
    Private write_fn_mod2_value
    Private read_fn_mod2_value
    Private flag_fn_mod2

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

    Property Get get_fn_mod2
        get_fn_mod2 = read_fn_mod2_value
    End Property

    Property Let set_fn_mod2(aData)
        write_fn_mod2_value = aData
        flag_fn_mod2        = &H1
    End Property

    Property Get read_fn_mod2
        read
        read_fn_mod2 = read_fn_mod2_value
    End Property

    Property Let write_fn_mod2(aData)
        set_fn_mod2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        fn_mod2_mask = &H1
        if data_low > LONG_MAX then
            if fn_mod2_mask = mask then
                read_fn_mod2_value = data_low
            else
                read_fn_mod2_value = (data_low - H8000_0000) and fn_mod2_mask
            end If
        else
            read_fn_mod2_value = data_low and fn_mod2_mask
        end If

    End Sub

    Sub write
        If flag_fn_mod2 = &H0 Then read
        If flag_fn_mod2 = &H0 Then write_fn_mod2_value = get_fn_mod2

        regValue = leftShift((write_fn_mod2_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        fn_mod2_mask = &H1
        if data_low > LONG_MAX then
            if fn_mod2_mask = mask then
                read_fn_mod2_value = data_low
            else
                read_fn_mod2_value = (data_low - H8000_0000) and fn_mod2_mask
            end If
        else
            read_fn_mod2_value = data_low and fn_mod2_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_fn_mod2_value = &H0
        flag_fn_mod2        = &H0
    End Sub
End Class


'' @REGISTER : GPV_AMIB_wr_tidemark_dma_10t1s_s
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
Class REGISTER_GPV_AMIB_wr_tidemark_dma_10t1s_s
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


'' @REGISTER : GPV_AMIB_ahb_cntl_dma_10t1s_s
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ahb_cntl                                   [1:0]            get_ahb_cntl
''                                                             set_ahb_cntl
''                                                             read_ahb_cntl
''                                                             write_ahb_cntl
''---------------------------------------------------------------------------------
Class REGISTER_GPV_AMIB_ahb_cntl_dma_10t1s_s
    Private write_ahb_cntl_value
    Private read_ahb_cntl_value
    Private flag_ahb_cntl

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H8044
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ahb_cntl
        get_ahb_cntl = read_ahb_cntl_value
    End Property

    Property Let set_ahb_cntl(aData)
        write_ahb_cntl_value = aData
        flag_ahb_cntl        = &H1
    End Property

    Property Get read_ahb_cntl
        read
        read_ahb_cntl = read_ahb_cntl_value
    End Property

    Property Let write_ahb_cntl(aData)
        set_ahb_cntl = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ahb_cntl_mask = &H3
        if data_low > LONG_MAX then
            if ahb_cntl_mask = mask then
                read_ahb_cntl_value = data_low
            else
                read_ahb_cntl_value = (data_low - H8000_0000) and ahb_cntl_mask
            end If
        else
            read_ahb_cntl_value = data_low and ahb_cntl_mask
        end If

    End Sub

    Sub write
        If flag_ahb_cntl = &H0 Then read
        If flag_ahb_cntl = &H0 Then write_ahb_cntl_value = get_ahb_cntl

        regValue = leftShift((write_ahb_cntl_value and &H3), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ahb_cntl_mask = &H3
        if data_low > LONG_MAX then
            if ahb_cntl_mask = mask then
                read_ahb_cntl_value = data_low
            else
                read_ahb_cntl_value = (data_low - H8000_0000) and ahb_cntl_mask
            end If
        else
            read_ahb_cntl_value = data_low and ahb_cntl_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ahb_cntl_value = &H0
        flag_ahb_cntl        = &H0
    End Sub
End Class


'' @REGISTER : GPV_AMIB_fn_mod_bm_iss_spi_10t1s_s
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' fn_mod_bm_iss                              [1:0]            get_fn_mod_bm_iss
''                                                             set_fn_mod_bm_iss
''                                                             read_fn_mod_bm_iss
''                                                             write_fn_mod_bm_iss
''---------------------------------------------------------------------------------
Class REGISTER_GPV_AMIB_fn_mod_bm_iss_spi_10t1s_s
    Private write_fn_mod_bm_iss_value
    Private read_fn_mod_bm_iss_value
    Private flag_fn_mod_bm_iss

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H9008
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_fn_mod_bm_iss
        get_fn_mod_bm_iss = read_fn_mod_bm_iss_value
    End Property

    Property Let set_fn_mod_bm_iss(aData)
        write_fn_mod_bm_iss_value = aData
        flag_fn_mod_bm_iss        = &H1
    End Property

    Property Get read_fn_mod_bm_iss
        read
        read_fn_mod_bm_iss = read_fn_mod_bm_iss_value
    End Property

    Property Let write_fn_mod_bm_iss(aData)
        set_fn_mod_bm_iss = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        fn_mod_bm_iss_mask = &H3
        if data_low > LONG_MAX then
            if fn_mod_bm_iss_mask = mask then
                read_fn_mod_bm_iss_value = data_low
            else
                read_fn_mod_bm_iss_value = (data_low - H8000_0000) and fn_mod_bm_iss_mask
            end If
        else
            read_fn_mod_bm_iss_value = data_low and fn_mod_bm_iss_mask
        end If

    End Sub

    Sub write
        If flag_fn_mod_bm_iss = &H0 Then read
        If flag_fn_mod_bm_iss = &H0 Then write_fn_mod_bm_iss_value = get_fn_mod_bm_iss

        regValue = leftShift((write_fn_mod_bm_iss_value and &H3), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        fn_mod_bm_iss_mask = &H3
        if data_low > LONG_MAX then
            if fn_mod_bm_iss_mask = mask then
                read_fn_mod_bm_iss_value = data_low
            else
                read_fn_mod_bm_iss_value = (data_low - H8000_0000) and fn_mod_bm_iss_mask
            end If
        else
            read_fn_mod_bm_iss_value = data_low and fn_mod_bm_iss_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_fn_mod_bm_iss_value = &H0
        flag_fn_mod_bm_iss        = &H0
    End Sub
End Class


'' @REGISTER : GPV_AMIB_fn_mod2_spi_10t1s_s
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' fn_mod2                                    [0:0]            get_fn_mod2
''                                                             set_fn_mod2
''                                                             read_fn_mod2
''                                                             write_fn_mod2
''---------------------------------------------------------------------------------
Class REGISTER_GPV_AMIB_fn_mod2_spi_10t1s_s
    Private write_fn_mod2_value
    Private read_fn_mod2_value
    Private flag_fn_mod2

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H9024
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_fn_mod2
        get_fn_mod2 = read_fn_mod2_value
    End Property

    Property Let set_fn_mod2(aData)
        write_fn_mod2_value = aData
        flag_fn_mod2        = &H1
    End Property

    Property Get read_fn_mod2
        read
        read_fn_mod2 = read_fn_mod2_value
    End Property

    Property Let write_fn_mod2(aData)
        set_fn_mod2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        fn_mod2_mask = &H1
        if data_low > LONG_MAX then
            if fn_mod2_mask = mask then
                read_fn_mod2_value = data_low
            else
                read_fn_mod2_value = (data_low - H8000_0000) and fn_mod2_mask
            end If
        else
            read_fn_mod2_value = data_low and fn_mod2_mask
        end If

    End Sub

    Sub write
        If flag_fn_mod2 = &H0 Then read
        If flag_fn_mod2 = &H0 Then write_fn_mod2_value = get_fn_mod2

        regValue = leftShift((write_fn_mod2_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        fn_mod2_mask = &H1
        if data_low > LONG_MAX then
            if fn_mod2_mask = mask then
                read_fn_mod2_value = data_low
            else
                read_fn_mod2_value = (data_low - H8000_0000) and fn_mod2_mask
            end If
        else
            read_fn_mod2_value = data_low and fn_mod2_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_fn_mod2_value = &H0
        flag_fn_mod2        = &H0
    End Sub
End Class


'' @REGISTER : GPV_AMIB_wr_tidemark_spi_10t1s_s
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
Class REGISTER_GPV_AMIB_wr_tidemark_spi_10t1s_s
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
        offset = &H9040
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


'' @REGISTER : GPV_AMIB_ahb_cntl_spi_10t1s_s
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ahb_cntl                                   [1:0]            get_ahb_cntl
''                                                             set_ahb_cntl
''                                                             read_ahb_cntl
''                                                             write_ahb_cntl
''---------------------------------------------------------------------------------
Class REGISTER_GPV_AMIB_ahb_cntl_spi_10t1s_s
    Private write_ahb_cntl_value
    Private read_ahb_cntl_value
    Private flag_ahb_cntl

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H9044
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ahb_cntl
        get_ahb_cntl = read_ahb_cntl_value
    End Property

    Property Let set_ahb_cntl(aData)
        write_ahb_cntl_value = aData
        flag_ahb_cntl        = &H1
    End Property

    Property Get read_ahb_cntl
        read
        read_ahb_cntl = read_ahb_cntl_value
    End Property

    Property Let write_ahb_cntl(aData)
        set_ahb_cntl = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ahb_cntl_mask = &H3
        if data_low > LONG_MAX then
            if ahb_cntl_mask = mask then
                read_ahb_cntl_value = data_low
            else
                read_ahb_cntl_value = (data_low - H8000_0000) and ahb_cntl_mask
            end If
        else
            read_ahb_cntl_value = data_low and ahb_cntl_mask
        end If

    End Sub

    Sub write
        If flag_ahb_cntl = &H0 Then read
        If flag_ahb_cntl = &H0 Then write_ahb_cntl_value = get_ahb_cntl

        regValue = leftShift((write_ahb_cntl_value and &H3), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ahb_cntl_mask = &H3
        if data_low > LONG_MAX then
            if ahb_cntl_mask = mask then
                read_ahb_cntl_value = data_low
            else
                read_ahb_cntl_value = (data_low - H8000_0000) and ahb_cntl_mask
            end If
        else
            read_ahb_cntl_value = data_low and ahb_cntl_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ahb_cntl_value = &H0
        flag_ahb_cntl        = &H0
    End Sub
End Class


'' @REGISTER : GPV_AMIB_fn_mod_bm_iss_macsec_s
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' fn_mod_bm_iss                              [1:0]            get_fn_mod_bm_iss
''                                                             set_fn_mod_bm_iss
''                                                             read_fn_mod_bm_iss
''                                                             write_fn_mod_bm_iss
''---------------------------------------------------------------------------------
Class REGISTER_GPV_AMIB_fn_mod_bm_iss_macsec_s
    Private write_fn_mod_bm_iss_value
    Private read_fn_mod_bm_iss_value
    Private flag_fn_mod_bm_iss

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Ha008
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_fn_mod_bm_iss
        get_fn_mod_bm_iss = read_fn_mod_bm_iss_value
    End Property

    Property Let set_fn_mod_bm_iss(aData)
        write_fn_mod_bm_iss_value = aData
        flag_fn_mod_bm_iss        = &H1
    End Property

    Property Get read_fn_mod_bm_iss
        read
        read_fn_mod_bm_iss = read_fn_mod_bm_iss_value
    End Property

    Property Let write_fn_mod_bm_iss(aData)
        set_fn_mod_bm_iss = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        fn_mod_bm_iss_mask = &H3
        if data_low > LONG_MAX then
            if fn_mod_bm_iss_mask = mask then
                read_fn_mod_bm_iss_value = data_low
            else
                read_fn_mod_bm_iss_value = (data_low - H8000_0000) and fn_mod_bm_iss_mask
            end If
        else
            read_fn_mod_bm_iss_value = data_low and fn_mod_bm_iss_mask
        end If

    End Sub

    Sub write
        If flag_fn_mod_bm_iss = &H0 Then read
        If flag_fn_mod_bm_iss = &H0 Then write_fn_mod_bm_iss_value = get_fn_mod_bm_iss

        regValue = leftShift((write_fn_mod_bm_iss_value and &H3), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        fn_mod_bm_iss_mask = &H3
        if data_low > LONG_MAX then
            if fn_mod_bm_iss_mask = mask then
                read_fn_mod_bm_iss_value = data_low
            else
                read_fn_mod_bm_iss_value = (data_low - H8000_0000) and fn_mod_bm_iss_mask
            end If
        else
            read_fn_mod_bm_iss_value = data_low and fn_mod_bm_iss_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_fn_mod_bm_iss_value = &H0
        flag_fn_mod_bm_iss        = &H0
    End Sub
End Class


'' @REGISTER : GPV_AMIB_fn_mod2_macsec_s
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' fn_mod2                                    [0:0]            get_fn_mod2
''                                                             set_fn_mod2
''                                                             read_fn_mod2
''                                                             write_fn_mod2
''---------------------------------------------------------------------------------
Class REGISTER_GPV_AMIB_fn_mod2_macsec_s
    Private write_fn_mod2_value
    Private read_fn_mod2_value
    Private flag_fn_mod2

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Ha024
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_fn_mod2
        get_fn_mod2 = read_fn_mod2_value
    End Property

    Property Let set_fn_mod2(aData)
        write_fn_mod2_value = aData
        flag_fn_mod2        = &H1
    End Property

    Property Get read_fn_mod2
        read
        read_fn_mod2 = read_fn_mod2_value
    End Property

    Property Let write_fn_mod2(aData)
        set_fn_mod2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        fn_mod2_mask = &H1
        if data_low > LONG_MAX then
            if fn_mod2_mask = mask then
                read_fn_mod2_value = data_low
            else
                read_fn_mod2_value = (data_low - H8000_0000) and fn_mod2_mask
            end If
        else
            read_fn_mod2_value = data_low and fn_mod2_mask
        end If

    End Sub

    Sub write
        If flag_fn_mod2 = &H0 Then read
        If flag_fn_mod2 = &H0 Then write_fn_mod2_value = get_fn_mod2

        regValue = leftShift((write_fn_mod2_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        fn_mod2_mask = &H1
        if data_low > LONG_MAX then
            if fn_mod2_mask = mask then
                read_fn_mod2_value = data_low
            else
                read_fn_mod2_value = (data_low - H8000_0000) and fn_mod2_mask
            end If
        else
            read_fn_mod2_value = data_low and fn_mod2_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_fn_mod2_value = &H0
        flag_fn_mod2        = &H0
    End Sub
End Class


'' @REGISTER : GPV_AMIB_ahb_cntl_macsec_s
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ahb_cntl                                   [1:0]            get_ahb_cntl
''                                                             set_ahb_cntl
''                                                             read_ahb_cntl
''                                                             write_ahb_cntl
''---------------------------------------------------------------------------------
Class REGISTER_GPV_AMIB_ahb_cntl_macsec_s
    Private write_ahb_cntl_value
    Private read_ahb_cntl_value
    Private flag_ahb_cntl

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Ha044
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ahb_cntl
        get_ahb_cntl = read_ahb_cntl_value
    End Property

    Property Let set_ahb_cntl(aData)
        write_ahb_cntl_value = aData
        flag_ahb_cntl        = &H1
    End Property

    Property Get read_ahb_cntl
        read
        read_ahb_cntl = read_ahb_cntl_value
    End Property

    Property Let write_ahb_cntl(aData)
        set_ahb_cntl = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ahb_cntl_mask = &H3
        if data_low > LONG_MAX then
            if ahb_cntl_mask = mask then
                read_ahb_cntl_value = data_low
            else
                read_ahb_cntl_value = (data_low - H8000_0000) and ahb_cntl_mask
            end If
        else
            read_ahb_cntl_value = data_low and ahb_cntl_mask
        end If

    End Sub

    Sub write
        If flag_ahb_cntl = &H0 Then read
        If flag_ahb_cntl = &H0 Then write_ahb_cntl_value = get_ahb_cntl

        regValue = leftShift((write_ahb_cntl_value and &H3), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ahb_cntl_mask = &H3
        if data_low > LONG_MAX then
            if ahb_cntl_mask = mask then
                read_ahb_cntl_value = data_low
            else
                read_ahb_cntl_value = (data_low - H8000_0000) and ahb_cntl_mask
            end If
        else
            read_ahb_cntl_value = data_low and ahb_cntl_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ahb_cntl_value = &H0
        flag_ahb_cntl        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class GPV_AMIB_INSTANCE

    Public fn_mod_bm_iss_m7_ahb_s
    Public fn_mod2_m7_ahb_s
    Public fn_mod_lb_m7_ahb_s
    Public fn_mod_m7_ahb_s
    Public fn_mod_bm_iss_cfg_s
    Public fn_mod_bm_iss_memp0_s
    Public fn_mod_bm_iss_memp1_s
    Public fn_mod_bm_iss_hsm_s
    Public fn_mod2_hsm_s
    Public ahb_cntl_hsm_s
    Public fn_mod_bm_iss_ind_s
    Public ahb_cntl_ind_s
    Public fn_mod_bm_iss_qspi_s
    Public fn_mod2_qspi_s
    Public fn_mod_qspi_s
    Public fn_mod_bm_iss_pcie_s
    Public fn_mod2_pcie_s
    Public fn_mod_pcie_s
    Public fn_mod_bm_iss_dma_10t1s_s
    Public fn_mod2_dma_10t1s_s
    Public wr_tidemark_dma_10t1s_s
    Public ahb_cntl_dma_10t1s_s
    Public fn_mod_bm_iss_spi_10t1s_s
    Public fn_mod2_spi_10t1s_s
    Public wr_tidemark_spi_10t1s_s
    Public ahb_cntl_spi_10t1s_s
    Public fn_mod_bm_iss_macsec_s
    Public fn_mod2_macsec_s
    Public ahb_cntl_macsec_s


    Public default function Init(aBaseAddr)
        Set fn_mod_bm_iss_m7_ahb_s = (New REGISTER_GPV_AMIB_fn_mod_bm_iss_m7_ahb_s)(aBaseAddr, 32)
        Set fn_mod2_m7_ahb_s = (New REGISTER_GPV_AMIB_fn_mod2_m7_ahb_s)(aBaseAddr, 32)
        Set fn_mod_lb_m7_ahb_s = (New REGISTER_GPV_AMIB_fn_mod_lb_m7_ahb_s)(aBaseAddr, 32)
        Set fn_mod_m7_ahb_s = (New REGISTER_GPV_AMIB_fn_mod_m7_ahb_s)(aBaseAddr, 32)
        Set fn_mod_bm_iss_cfg_s = (New REGISTER_GPV_AMIB_fn_mod_bm_iss_cfg_s)(aBaseAddr, 32)
        Set fn_mod_bm_iss_memp0_s = (New REGISTER_GPV_AMIB_fn_mod_bm_iss_memp0_s)(aBaseAddr, 32)
        Set fn_mod_bm_iss_memp1_s = (New REGISTER_GPV_AMIB_fn_mod_bm_iss_memp1_s)(aBaseAddr, 32)
        Set fn_mod_bm_iss_hsm_s = (New REGISTER_GPV_AMIB_fn_mod_bm_iss_hsm_s)(aBaseAddr, 32)
        Set fn_mod2_hsm_s = (New REGISTER_GPV_AMIB_fn_mod2_hsm_s)(aBaseAddr, 32)
        Set ahb_cntl_hsm_s = (New REGISTER_GPV_AMIB_ahb_cntl_hsm_s)(aBaseAddr, 32)
        Set fn_mod_bm_iss_ind_s = (New REGISTER_GPV_AMIB_fn_mod_bm_iss_ind_s)(aBaseAddr, 32)
        Set ahb_cntl_ind_s = (New REGISTER_GPV_AMIB_ahb_cntl_ind_s)(aBaseAddr, 32)
        Set fn_mod_bm_iss_qspi_s = (New REGISTER_GPV_AMIB_fn_mod_bm_iss_qspi_s)(aBaseAddr, 32)
        Set fn_mod2_qspi_s = (New REGISTER_GPV_AMIB_fn_mod2_qspi_s)(aBaseAddr, 32)
        Set fn_mod_qspi_s = (New REGISTER_GPV_AMIB_fn_mod_qspi_s)(aBaseAddr, 32)
        Set fn_mod_bm_iss_pcie_s = (New REGISTER_GPV_AMIB_fn_mod_bm_iss_pcie_s)(aBaseAddr, 32)
        Set fn_mod2_pcie_s = (New REGISTER_GPV_AMIB_fn_mod2_pcie_s)(aBaseAddr, 32)
        Set fn_mod_pcie_s = (New REGISTER_GPV_AMIB_fn_mod_pcie_s)(aBaseAddr, 32)
        Set fn_mod_bm_iss_dma_10t1s_s = (New REGISTER_GPV_AMIB_fn_mod_bm_iss_dma_10t1s_s)(aBaseAddr, 32)
        Set fn_mod2_dma_10t1s_s = (New REGISTER_GPV_AMIB_fn_mod2_dma_10t1s_s)(aBaseAddr, 32)
        Set wr_tidemark_dma_10t1s_s = (New REGISTER_GPV_AMIB_wr_tidemark_dma_10t1s_s)(aBaseAddr, 32)
        Set ahb_cntl_dma_10t1s_s = (New REGISTER_GPV_AMIB_ahb_cntl_dma_10t1s_s)(aBaseAddr, 32)
        Set fn_mod_bm_iss_spi_10t1s_s = (New REGISTER_GPV_AMIB_fn_mod_bm_iss_spi_10t1s_s)(aBaseAddr, 32)
        Set fn_mod2_spi_10t1s_s = (New REGISTER_GPV_AMIB_fn_mod2_spi_10t1s_s)(aBaseAddr, 32)
        Set wr_tidemark_spi_10t1s_s = (New REGISTER_GPV_AMIB_wr_tidemark_spi_10t1s_s)(aBaseAddr, 32)
        Set ahb_cntl_spi_10t1s_s = (New REGISTER_GPV_AMIB_ahb_cntl_spi_10t1s_s)(aBaseAddr, 32)
        Set fn_mod_bm_iss_macsec_s = (New REGISTER_GPV_AMIB_fn_mod_bm_iss_macsec_s)(aBaseAddr, 32)
        Set fn_mod2_macsec_s = (New REGISTER_GPV_AMIB_fn_mod2_macsec_s)(aBaseAddr, 32)
        Set ahb_cntl_macsec_s = (New REGISTER_GPV_AMIB_ahb_cntl_macsec_s)(aBaseAddr, 32)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set GPV_AMIB = CreateObject("System.Collections.ArrayList")
GPV_AMIB.Add ((New GPV_AMIB_INSTANCE)(&H4c202000))


