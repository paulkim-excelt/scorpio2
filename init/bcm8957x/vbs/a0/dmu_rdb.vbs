

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


'' @REGISTER : DMU_dmu_status
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' dmu_clk_sel_busy                           [4:4]            get_dmu_clk_sel_busy
''                                                             set_dmu_clk_sel_busy
''                                                             read_dmu_clk_sel_busy
''                                                             write_dmu_clk_sel_busy
''---------------------------------------------------------------------------------
Class REGISTER_DMU_dmu_status
    Private write_dmu_clk_sel_busy_value
    Private read_dmu_clk_sel_busy_value
    Private flag_dmu_clk_sel_busy

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H40
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_dmu_clk_sel_busy
        get_dmu_clk_sel_busy = read_dmu_clk_sel_busy_value
    End Property

    Property Let set_dmu_clk_sel_busy(aData)
        write_dmu_clk_sel_busy_value = aData
        flag_dmu_clk_sel_busy        = &H1
    End Property

    Property Get read_dmu_clk_sel_busy
        read
        read_dmu_clk_sel_busy = read_dmu_clk_sel_busy_value
    End Property

    Property Let write_dmu_clk_sel_busy(aData)
        set_dmu_clk_sel_busy = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_dmu_clk_sel_busy_value = rightShift(data_low, 4) and &H1

    End Sub

    Sub write
        If flag_dmu_clk_sel_busy = &H0 Then read
        If flag_dmu_clk_sel_busy = &H0 Then write_dmu_clk_sel_busy_value = get_dmu_clk_sel_busy

        regValue = leftShift((write_dmu_clk_sel_busy_value and &H1), 4)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_dmu_clk_sel_busy_value = rightShift(data_low, 4) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_dmu_clk_sel_busy_value = &H0
        flag_dmu_clk_sel_busy        = &H0
    End Sub
End Class


'' @REGISTER : DMU_dmu_clk_sel
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' dmu_pclk_sel                               [7:6]            get_dmu_pclk_sel
''                                                             set_dmu_pclk_sel
''                                                             read_dmu_pclk_sel
''                                                             write_dmu_pclk_sel
''---------------------------------------------------------------------------------
'' dmu_hclk_sel                               [5:4]            get_dmu_hclk_sel
''                                                             set_dmu_hclk_sel
''                                                             read_dmu_hclk_sel
''                                                             write_dmu_hclk_sel
''---------------------------------------------------------------------------------
'' dmu_qclk_sel                               [3:2]            get_dmu_qclk_sel
''                                                             set_dmu_qclk_sel
''                                                             read_dmu_qclk_sel
''                                                             write_dmu_qclk_sel
''---------------------------------------------------------------------------------
'' dmu_cpuclk_sel                             [1:0]            get_dmu_cpuclk_sel
''                                                             set_dmu_cpuclk_sel
''                                                             read_dmu_cpuclk_sel
''                                                             write_dmu_cpuclk_sel
''---------------------------------------------------------------------------------
Class REGISTER_DMU_dmu_clk_sel
    Private write_dmu_pclk_sel_value
    Private read_dmu_pclk_sel_value
    Private flag_dmu_pclk_sel
    Private write_dmu_hclk_sel_value
    Private read_dmu_hclk_sel_value
    Private flag_dmu_hclk_sel
    Private write_dmu_qclk_sel_value
    Private read_dmu_qclk_sel_value
    Private flag_dmu_qclk_sel
    Private write_dmu_cpuclk_sel_value
    Private read_dmu_cpuclk_sel_value
    Private flag_dmu_cpuclk_sel

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H44
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_dmu_pclk_sel
        get_dmu_pclk_sel = read_dmu_pclk_sel_value
    End Property

    Property Let set_dmu_pclk_sel(aData)
        write_dmu_pclk_sel_value = aData
        flag_dmu_pclk_sel        = &H1
    End Property

    Property Get read_dmu_pclk_sel
        read
        read_dmu_pclk_sel = read_dmu_pclk_sel_value
    End Property

    Property Let write_dmu_pclk_sel(aData)
        set_dmu_pclk_sel = aData
        write
    End Property

    Property Get get_dmu_hclk_sel
        get_dmu_hclk_sel = read_dmu_hclk_sel_value
    End Property

    Property Let set_dmu_hclk_sel(aData)
        write_dmu_hclk_sel_value = aData
        flag_dmu_hclk_sel        = &H1
    End Property

    Property Get read_dmu_hclk_sel
        read
        read_dmu_hclk_sel = read_dmu_hclk_sel_value
    End Property

    Property Let write_dmu_hclk_sel(aData)
        set_dmu_hclk_sel = aData
        write
    End Property

    Property Get get_dmu_qclk_sel
        get_dmu_qclk_sel = read_dmu_qclk_sel_value
    End Property

    Property Let set_dmu_qclk_sel(aData)
        write_dmu_qclk_sel_value = aData
        flag_dmu_qclk_sel        = &H1
    End Property

    Property Get read_dmu_qclk_sel
        read
        read_dmu_qclk_sel = read_dmu_qclk_sel_value
    End Property

    Property Let write_dmu_qclk_sel(aData)
        set_dmu_qclk_sel = aData
        write
    End Property

    Property Get get_dmu_cpuclk_sel
        get_dmu_cpuclk_sel = read_dmu_cpuclk_sel_value
    End Property

    Property Let set_dmu_cpuclk_sel(aData)
        write_dmu_cpuclk_sel_value = aData
        flag_dmu_cpuclk_sel        = &H1
    End Property

    Property Get read_dmu_cpuclk_sel
        read
        read_dmu_cpuclk_sel = read_dmu_cpuclk_sel_value
    End Property

    Property Let write_dmu_cpuclk_sel(aData)
        set_dmu_cpuclk_sel = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_dmu_pclk_sel_value = rightShift(data_low, 6) and &H3
        read_dmu_hclk_sel_value = rightShift(data_low, 4) and &H3
        read_dmu_qclk_sel_value = rightShift(data_low, 2) and &H3
        dmu_cpuclk_sel_mask = &H3
        if data_low > LONG_MAX then
            if dmu_cpuclk_sel_mask = mask then
                read_dmu_cpuclk_sel_value = data_low
            else
                read_dmu_cpuclk_sel_value = (data_low - H8000_0000) and dmu_cpuclk_sel_mask
            end If
        else
            read_dmu_cpuclk_sel_value = data_low and dmu_cpuclk_sel_mask
        end If

    End Sub

    Sub write
        If flag_dmu_pclk_sel = &H0 or flag_dmu_hclk_sel = &H0 or flag_dmu_qclk_sel = &H0 or flag_dmu_cpuclk_sel = &H0 Then read
        If flag_dmu_pclk_sel = &H0 Then write_dmu_pclk_sel_value = get_dmu_pclk_sel
        If flag_dmu_hclk_sel = &H0 Then write_dmu_hclk_sel_value = get_dmu_hclk_sel
        If flag_dmu_qclk_sel = &H0 Then write_dmu_qclk_sel_value = get_dmu_qclk_sel
        If flag_dmu_cpuclk_sel = &H0 Then write_dmu_cpuclk_sel_value = get_dmu_cpuclk_sel

        regValue = leftShift((write_dmu_pclk_sel_value and &H3), 6) + leftShift((write_dmu_hclk_sel_value and &H3), 4) + leftShift((write_dmu_qclk_sel_value and &H3), 2) + leftShift((write_dmu_cpuclk_sel_value and &H3), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_dmu_pclk_sel_value = rightShift(data_low, 6) and &H3
        read_dmu_hclk_sel_value = rightShift(data_low, 4) and &H3
        read_dmu_qclk_sel_value = rightShift(data_low, 2) and &H3
        dmu_cpuclk_sel_mask = &H3
        if data_low > LONG_MAX then
            if dmu_cpuclk_sel_mask = mask then
                read_dmu_cpuclk_sel_value = data_low
            else
                read_dmu_cpuclk_sel_value = (data_low - H8000_0000) and dmu_cpuclk_sel_mask
            end If
        else
            read_dmu_cpuclk_sel_value = data_low and dmu_cpuclk_sel_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_dmu_pclk_sel_value = &H0
        flag_dmu_pclk_sel        = &H0
        write_dmu_hclk_sel_value = &H0
        flag_dmu_hclk_sel        = &H0
        write_dmu_qclk_sel_value = &H0
        flag_dmu_qclk_sel        = &H0
        write_dmu_cpuclk_sel_value = &H0
        flag_dmu_cpuclk_sel        = &H0
    End Sub
End Class


'' @REGISTER : DMU_dmu_clkout_sel
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' dmu_clkout0_scalar                         [15:6]           get_dmu_clkout0_scalar
''                                                             set_dmu_clkout0_scalar
''                                                             read_dmu_clkout0_scalar
''                                                             write_dmu_clkout0_scalar
''---------------------------------------------------------------------------------
'' dmu_clkout0_sel                            [5:2]            get_dmu_clkout0_sel
''                                                             set_dmu_clkout0_sel
''                                                             read_dmu_clkout0_sel
''                                                             write_dmu_clkout0_sel
''---------------------------------------------------------------------------------
'' dmu_clkout0_data                           [1:1]            get_dmu_clkout0_data
''                                                             set_dmu_clkout0_data
''                                                             read_dmu_clkout0_data
''                                                             write_dmu_clkout0_data
''---------------------------------------------------------------------------------
'' dmu_clkout0_pwd                            [0:0]            get_dmu_clkout0_pwd
''                                                             set_dmu_clkout0_pwd
''                                                             read_dmu_clkout0_pwd
''                                                             write_dmu_clkout0_pwd
''---------------------------------------------------------------------------------
Class REGISTER_DMU_dmu_clkout_sel
    Private write_dmu_clkout0_scalar_value
    Private read_dmu_clkout0_scalar_value
    Private flag_dmu_clkout0_scalar
    Private write_dmu_clkout0_sel_value
    Private read_dmu_clkout0_sel_value
    Private flag_dmu_clkout0_sel
    Private write_dmu_clkout0_data_value
    Private read_dmu_clkout0_data_value
    Private flag_dmu_clkout0_data
    Private write_dmu_clkout0_pwd_value
    Private read_dmu_clkout0_pwd_value
    Private flag_dmu_clkout0_pwd

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H48
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_dmu_clkout0_scalar
        get_dmu_clkout0_scalar = read_dmu_clkout0_scalar_value
    End Property

    Property Let set_dmu_clkout0_scalar(aData)
        write_dmu_clkout0_scalar_value = aData
        flag_dmu_clkout0_scalar        = &H1
    End Property

    Property Get read_dmu_clkout0_scalar
        read
        read_dmu_clkout0_scalar = read_dmu_clkout0_scalar_value
    End Property

    Property Let write_dmu_clkout0_scalar(aData)
        set_dmu_clkout0_scalar = aData
        write
    End Property

    Property Get get_dmu_clkout0_sel
        get_dmu_clkout0_sel = read_dmu_clkout0_sel_value
    End Property

    Property Let set_dmu_clkout0_sel(aData)
        write_dmu_clkout0_sel_value = aData
        flag_dmu_clkout0_sel        = &H1
    End Property

    Property Get read_dmu_clkout0_sel
        read
        read_dmu_clkout0_sel = read_dmu_clkout0_sel_value
    End Property

    Property Let write_dmu_clkout0_sel(aData)
        set_dmu_clkout0_sel = aData
        write
    End Property

    Property Get get_dmu_clkout0_data
        get_dmu_clkout0_data = read_dmu_clkout0_data_value
    End Property

    Property Let set_dmu_clkout0_data(aData)
        write_dmu_clkout0_data_value = aData
        flag_dmu_clkout0_data        = &H1
    End Property

    Property Get read_dmu_clkout0_data
        read
        read_dmu_clkout0_data = read_dmu_clkout0_data_value
    End Property

    Property Let write_dmu_clkout0_data(aData)
        set_dmu_clkout0_data = aData
        write
    End Property

    Property Get get_dmu_clkout0_pwd
        get_dmu_clkout0_pwd = read_dmu_clkout0_pwd_value
    End Property

    Property Let set_dmu_clkout0_pwd(aData)
        write_dmu_clkout0_pwd_value = aData
        flag_dmu_clkout0_pwd        = &H1
    End Property

    Property Get read_dmu_clkout0_pwd
        read
        read_dmu_clkout0_pwd = read_dmu_clkout0_pwd_value
    End Property

    Property Let write_dmu_clkout0_pwd(aData)
        set_dmu_clkout0_pwd = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_dmu_clkout0_scalar_value = rightShift(data_low, 6) and &H3ff
        read_dmu_clkout0_sel_value = rightShift(data_low, 2) and &Hf
        read_dmu_clkout0_data_value = rightShift(data_low, 1) and &H1
        dmu_clkout0_pwd_mask = &H1
        if data_low > LONG_MAX then
            if dmu_clkout0_pwd_mask = mask then
                read_dmu_clkout0_pwd_value = data_low
            else
                read_dmu_clkout0_pwd_value = (data_low - H8000_0000) and dmu_clkout0_pwd_mask
            end If
        else
            read_dmu_clkout0_pwd_value = data_low and dmu_clkout0_pwd_mask
        end If

    End Sub

    Sub write
        If flag_dmu_clkout0_scalar = &H0 or flag_dmu_clkout0_sel = &H0 or flag_dmu_clkout0_data = &H0 or flag_dmu_clkout0_pwd = &H0 Then read
        If flag_dmu_clkout0_scalar = &H0 Then write_dmu_clkout0_scalar_value = get_dmu_clkout0_scalar
        If flag_dmu_clkout0_sel = &H0 Then write_dmu_clkout0_sel_value = get_dmu_clkout0_sel
        If flag_dmu_clkout0_data = &H0 Then write_dmu_clkout0_data_value = get_dmu_clkout0_data
        If flag_dmu_clkout0_pwd = &H0 Then write_dmu_clkout0_pwd_value = get_dmu_clkout0_pwd

        regValue = leftShift((write_dmu_clkout0_scalar_value and &H3ff), 6) + leftShift((write_dmu_clkout0_sel_value and &Hf), 2) + leftShift((write_dmu_clkout0_data_value and &H1), 1) + leftShift((write_dmu_clkout0_pwd_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_dmu_clkout0_scalar_value = rightShift(data_low, 6) and &H3ff
        read_dmu_clkout0_sel_value = rightShift(data_low, 2) and &Hf
        read_dmu_clkout0_data_value = rightShift(data_low, 1) and &H1
        dmu_clkout0_pwd_mask = &H1
        if data_low > LONG_MAX then
            if dmu_clkout0_pwd_mask = mask then
                read_dmu_clkout0_pwd_value = data_low
            else
                read_dmu_clkout0_pwd_value = (data_low - H8000_0000) and dmu_clkout0_pwd_mask
            end If
        else
            read_dmu_clkout0_pwd_value = data_low and dmu_clkout0_pwd_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_dmu_clkout0_scalar_value = &H0
        flag_dmu_clkout0_scalar        = &H0
        write_dmu_clkout0_sel_value = &H0
        flag_dmu_clkout0_sel        = &H0
        write_dmu_clkout0_data_value = &H0
        flag_dmu_clkout0_data        = &H0
        write_dmu_clkout0_pwd_value = &H0
        flag_dmu_clkout0_pwd        = &H0
    End Sub
End Class


'' @REGISTER : DMU_dmu_timer_enable_sel
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' dmu_wdt_enable_pclk                        [5:5]            get_dmu_wdt_enable_pclk
''                                                             set_dmu_wdt_enable_pclk
''                                                             read_dmu_wdt_enable_pclk
''                                                             write_dmu_wdt_enable_pclk
''---------------------------------------------------------------------------------
'' dmu_tim_refclk_sel                         [2:2]            get_dmu_tim_refclk_sel
''                                                             set_dmu_tim_refclk_sel
''                                                             read_dmu_tim_refclk_sel
''                                                             write_dmu_tim_refclk_sel
''---------------------------------------------------------------------------------
'' dmu_tim_enable_pclk                        [0:0]            get_dmu_tim_enable_pclk
''                                                             set_dmu_tim_enable_pclk
''                                                             read_dmu_tim_enable_pclk
''                                                             write_dmu_tim_enable_pclk
''---------------------------------------------------------------------------------
Class REGISTER_DMU_dmu_timer_enable_sel
    Private write_dmu_wdt_enable_pclk_value
    Private read_dmu_wdt_enable_pclk_value
    Private flag_dmu_wdt_enable_pclk
    Private write_dmu_tim_refclk_sel_value
    Private read_dmu_tim_refclk_sel_value
    Private flag_dmu_tim_refclk_sel
    Private write_dmu_tim_enable_pclk_value
    Private read_dmu_tim_enable_pclk_value
    Private flag_dmu_tim_enable_pclk

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H4c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_dmu_wdt_enable_pclk
        get_dmu_wdt_enable_pclk = read_dmu_wdt_enable_pclk_value
    End Property

    Property Let set_dmu_wdt_enable_pclk(aData)
        write_dmu_wdt_enable_pclk_value = aData
        flag_dmu_wdt_enable_pclk        = &H1
    End Property

    Property Get read_dmu_wdt_enable_pclk
        read
        read_dmu_wdt_enable_pclk = read_dmu_wdt_enable_pclk_value
    End Property

    Property Let write_dmu_wdt_enable_pclk(aData)
        set_dmu_wdt_enable_pclk = aData
        write
    End Property

    Property Get get_dmu_tim_refclk_sel
        get_dmu_tim_refclk_sel = read_dmu_tim_refclk_sel_value
    End Property

    Property Let set_dmu_tim_refclk_sel(aData)
        write_dmu_tim_refclk_sel_value = aData
        flag_dmu_tim_refclk_sel        = &H1
    End Property

    Property Get read_dmu_tim_refclk_sel
        read
        read_dmu_tim_refclk_sel = read_dmu_tim_refclk_sel_value
    End Property

    Property Let write_dmu_tim_refclk_sel(aData)
        set_dmu_tim_refclk_sel = aData
        write
    End Property

    Property Get get_dmu_tim_enable_pclk
        get_dmu_tim_enable_pclk = read_dmu_tim_enable_pclk_value
    End Property

    Property Let set_dmu_tim_enable_pclk(aData)
        write_dmu_tim_enable_pclk_value = aData
        flag_dmu_tim_enable_pclk        = &H1
    End Property

    Property Get read_dmu_tim_enable_pclk
        read
        read_dmu_tim_enable_pclk = read_dmu_tim_enable_pclk_value
    End Property

    Property Let write_dmu_tim_enable_pclk(aData)
        set_dmu_tim_enable_pclk = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_dmu_wdt_enable_pclk_value = rightShift(data_low, 5) and &H1
        read_dmu_tim_refclk_sel_value = rightShift(data_low, 2) and &H1
        dmu_tim_enable_pclk_mask = &H1
        if data_low > LONG_MAX then
            if dmu_tim_enable_pclk_mask = mask then
                read_dmu_tim_enable_pclk_value = data_low
            else
                read_dmu_tim_enable_pclk_value = (data_low - H8000_0000) and dmu_tim_enable_pclk_mask
            end If
        else
            read_dmu_tim_enable_pclk_value = data_low and dmu_tim_enable_pclk_mask
        end If

    End Sub

    Sub write
        If flag_dmu_wdt_enable_pclk = &H0 or flag_dmu_tim_refclk_sel = &H0 or flag_dmu_tim_enable_pclk = &H0 Then read
        If flag_dmu_wdt_enable_pclk = &H0 Then write_dmu_wdt_enable_pclk_value = get_dmu_wdt_enable_pclk
        If flag_dmu_tim_refclk_sel = &H0 Then write_dmu_tim_refclk_sel_value = get_dmu_tim_refclk_sel
        If flag_dmu_tim_enable_pclk = &H0 Then write_dmu_tim_enable_pclk_value = get_dmu_tim_enable_pclk

        regValue = leftShift((write_dmu_wdt_enable_pclk_value and &H1), 5) + leftShift((write_dmu_tim_refclk_sel_value and &H1), 2) + leftShift((write_dmu_tim_enable_pclk_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_dmu_wdt_enable_pclk_value = rightShift(data_low, 5) and &H1
        read_dmu_tim_refclk_sel_value = rightShift(data_low, 2) and &H1
        dmu_tim_enable_pclk_mask = &H1
        if data_low > LONG_MAX then
            if dmu_tim_enable_pclk_mask = mask then
                read_dmu_tim_enable_pclk_value = data_low
            else
                read_dmu_tim_enable_pclk_value = (data_low - H8000_0000) and dmu_tim_enable_pclk_mask
            end If
        else
            read_dmu_tim_enable_pclk_value = data_low and dmu_tim_enable_pclk_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_dmu_wdt_enable_pclk_value = &H0
        flag_dmu_wdt_enable_pclk        = &H0
        write_dmu_tim_refclk_sel_value = &H0
        flag_dmu_tim_refclk_sel        = &H0
        write_dmu_tim_enable_pclk_value = &H0
        flag_dmu_tim_enable_pclk        = &H0
    End Sub
End Class


'' @REGISTER : DMU_dmu_pm
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' pm_deepsleep_timeout                       [31:0]           get_pm_deepsleep_timeout
''                                                             set_pm_deepsleep_timeout
''                                                             read_pm_deepsleep_timeout
''                                                             write_pm_deepsleep_timeout
''---------------------------------------------------------------------------------
Class REGISTER_DMU_dmu_pm
    Private write_pm_deepsleep_timeout_value
    Private read_pm_deepsleep_timeout_value
    Private flag_pm_deepsleep_timeout

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H50
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_pm_deepsleep_timeout
        get_pm_deepsleep_timeout = read_pm_deepsleep_timeout_value
    End Property

    Property Let set_pm_deepsleep_timeout(aData)
        write_pm_deepsleep_timeout_value = aData
        flag_pm_deepsleep_timeout        = &H1
    End Property

    Property Get read_pm_deepsleep_timeout
        read
        read_pm_deepsleep_timeout = read_pm_deepsleep_timeout_value
    End Property

    Property Let write_pm_deepsleep_timeout(aData)
        set_pm_deepsleep_timeout = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pm_deepsleep_timeout_mask = &Hffffffff
        if data_low > LONG_MAX then
            if pm_deepsleep_timeout_mask = mask then
                read_pm_deepsleep_timeout_value = data_low
            else
                read_pm_deepsleep_timeout_value = (data_low - H8000_0000) and pm_deepsleep_timeout_mask
            end If
        else
            read_pm_deepsleep_timeout_value = data_low and pm_deepsleep_timeout_mask
        end If

    End Sub

    Sub write
        If flag_pm_deepsleep_timeout = &H0 Then read
        If flag_pm_deepsleep_timeout = &H0 Then write_pm_deepsleep_timeout_value = get_pm_deepsleep_timeout

        regValue = leftShift(write_pm_deepsleep_timeout_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pm_deepsleep_timeout_mask = &Hffffffff
        if data_low > LONG_MAX then
            if pm_deepsleep_timeout_mask = mask then
                read_pm_deepsleep_timeout_value = data_low
            else
                read_pm_deepsleep_timeout_value = (data_low - H8000_0000) and pm_deepsleep_timeout_mask
            end If
        else
            read_pm_deepsleep_timeout_value = data_low and pm_deepsleep_timeout_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_pm_deepsleep_timeout_value = &H0
        flag_pm_deepsleep_timeout        = &H0
    End Sub
End Class


'' @REGISTER : DMU_dmu_rst_blk1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' dmu_rst_sci0                               [31:31]          get_dmu_rst_sci0
''                                                             set_dmu_rst_sci0
''                                                             read_dmu_rst_sci0
''                                                             write_dmu_rst_sci0
''---------------------------------------------------------------------------------
'' dmu_rst_rom                                [30:30]          get_dmu_rst_rom
''                                                             set_dmu_rst_rom
''                                                             read_dmu_rst_rom
''                                                             write_dmu_rst_rom
''---------------------------------------------------------------------------------
'' dmu_rst_rng                                [29:29]          get_dmu_rst_rng
''                                                             set_dmu_rst_rng
''                                                             read_dmu_rst_rng
''                                                             write_dmu_rst_rng
''---------------------------------------------------------------------------------
'' dmu_rst_pwm                                [28:28]          get_dmu_rst_pwm
''                                                             set_dmu_rst_pwm
''                                                             read_dmu_rst_pwm
''                                                             write_dmu_rst_pwm
''---------------------------------------------------------------------------------
'' dmu_rst_pka                                [27:27]          get_dmu_rst_pka
''                                                             set_dmu_rst_pka
''                                                             read_dmu_rst_pka
''                                                             write_dmu_rst_pka
''---------------------------------------------------------------------------------
'' dmu_rst_pbz                                [26:26]          get_dmu_rst_pbz
''                                                             set_dmu_rst_pbz
''                                                             read_dmu_rst_pbz
''                                                             write_dmu_rst_pbz
''---------------------------------------------------------------------------------
'' dmu_rst_pby                                [25:25]          get_dmu_rst_pby
''                                                             set_dmu_rst_pby
''                                                             read_dmu_rst_pby
''                                                             write_dmu_rst_pby
''---------------------------------------------------------------------------------
'' dmu_rst_pbx                                [24:24]          get_dmu_rst_pbx
''                                                             set_dmu_rst_pbx
''                                                             read_dmu_rst_pbx
''                                                             write_dmu_rst_pbx
''---------------------------------------------------------------------------------
'' dmu_rst_odma                               [23:23]          get_dmu_rst_odma
''                                                             set_dmu_rst_odma
''                                                             read_dmu_rst_odma
''                                                             write_dmu_rst_odma
''---------------------------------------------------------------------------------
'' dmu_rst_nvm                                [22:22]          get_dmu_rst_nvm
''                                                             set_dmu_rst_nvm
''                                                             read_dmu_rst_nvm
''                                                             write_dmu_rst_nvm
''---------------------------------------------------------------------------------
'' dmu_rst_msr                                [21:21]          get_dmu_rst_msr
''                                                             set_dmu_rst_msr
''                                                             read_dmu_rst_msr
''                                                             write_dmu_rst_msr
''---------------------------------------------------------------------------------
'' dmu_rst_mmi                                [20:20]          get_dmu_rst_mmi
''                                                             set_dmu_rst_mmi
''                                                             read_dmu_rst_mmi
''                                                             write_dmu_rst_mmi
''---------------------------------------------------------------------------------
'' dmu_rst_mem                                [19:19]          get_dmu_rst_mem
''                                                             set_dmu_rst_mem
''                                                             read_dmu_rst_mem
''                                                             write_dmu_rst_mem
''---------------------------------------------------------------------------------
'' dmu_rst_lcd                                [18:18]          get_dmu_rst_lcd
''                                                             set_dmu_rst_lcd
''                                                             read_dmu_rst_lcd
''                                                             write_dmu_rst_lcd
''---------------------------------------------------------------------------------
'' dmu_rst_i2s                                [17:17]          get_dmu_rst_i2s
''                                                             set_dmu_rst_i2s
''                                                             read_dmu_rst_i2s
''                                                             write_dmu_rst_i2s
''---------------------------------------------------------------------------------
'' dmu_rst_i2c1                               [16:16]          get_dmu_rst_i2c1
''                                                             set_dmu_rst_i2c1
''                                                             read_dmu_rst_i2c1
''                                                             write_dmu_rst_i2c1
''---------------------------------------------------------------------------------
'' dmu_rst_i2c0                               [15:15]          get_dmu_rst_i2c0
''                                                             set_dmu_rst_i2c0
''                                                             read_dmu_rst_i2c0
''                                                             write_dmu_rst_i2c0
''---------------------------------------------------------------------------------
'' dmu_rst_gio4                               [14:14]          get_dmu_rst_gio4
''                                                             set_dmu_rst_gio4
''                                                             read_dmu_rst_gio4
''                                                             write_dmu_rst_gio4
''---------------------------------------------------------------------------------
'' dmu_rst_gio3                               [13:13]          get_dmu_rst_gio3
''                                                             set_dmu_rst_gio3
''                                                             read_dmu_rst_gio3
''                                                             write_dmu_rst_gio3
''---------------------------------------------------------------------------------
'' dmu_rst_gio2                               [12:12]          get_dmu_rst_gio2
''                                                             set_dmu_rst_gio2
''                                                             read_dmu_rst_gio2
''                                                             write_dmu_rst_gio2
''---------------------------------------------------------------------------------
'' dmu_rst_gio1                               [11:11]          get_dmu_rst_gio1
''                                                             set_dmu_rst_gio1
''                                                             read_dmu_rst_gio1
''                                                             write_dmu_rst_gio1
''---------------------------------------------------------------------------------
'' dmu_rst_gio0                               [10:10]          get_dmu_rst_gio0
''                                                             set_dmu_rst_gio0
''                                                             read_dmu_rst_gio0
''                                                             write_dmu_rst_gio0
''---------------------------------------------------------------------------------
'' dmu_rst_etm                                [9:9]            get_dmu_rst_etm
''                                                             set_dmu_rst_etm
''                                                             read_dmu_rst_etm
''                                                             write_dmu_rst_etm
''---------------------------------------------------------------------------------
'' dmu_rst_amac                               [8:8]            get_dmu_rst_amac
''                                                             set_dmu_rst_amac
''                                                             read_dmu_rst_amac
''                                                             write_dmu_rst_amac
''---------------------------------------------------------------------------------
'' dmu_rst_dec                                [7:7]            get_dmu_rst_dec
''                                                             set_dmu_rst_dec
''                                                             read_dmu_rst_dec
''                                                             write_dmu_rst_dec
''---------------------------------------------------------------------------------
'' dmu_rst_ddr                                [6:6]            get_dmu_rst_ddr
''                                                             set_dmu_rst_ddr
''                                                             read_dmu_rst_ddr
''                                                             write_dmu_rst_ddr
''---------------------------------------------------------------------------------
'' dmu_rst_dac                                [5:5]            get_dmu_rst_dac
''                                                             set_dmu_rst_dac
''                                                             read_dmu_rst_dac
''                                                             write_dmu_rst_dac
''---------------------------------------------------------------------------------
'' dmu_rst_d1w                                [4:4]            get_dmu_rst_d1w
''                                                             set_dmu_rst_d1w
''                                                             read_dmu_rst_d1w
''                                                             write_dmu_rst_d1w
''---------------------------------------------------------------------------------
'' dmu_rst_cfg                                [3:3]            get_dmu_rst_cfg
''                                                             set_dmu_rst_cfg
''                                                             read_dmu_rst_cfg
''                                                             write_dmu_rst_cfg
''---------------------------------------------------------------------------------
'' dmu_rst_bbl                                [2:2]            get_dmu_rst_bbl
''                                                             set_dmu_rst_bbl
''                                                             read_dmu_rst_bbl
''                                                             write_dmu_rst_bbl
''---------------------------------------------------------------------------------
'' dmu_rst_adc1                               [1:1]            get_dmu_rst_adc1
''                                                             set_dmu_rst_adc1
''                                                             read_dmu_rst_adc1
''                                                             write_dmu_rst_adc1
''---------------------------------------------------------------------------------
'' dmu_rst_adc0                               [0:0]            get_dmu_rst_adc0
''                                                             set_dmu_rst_adc0
''                                                             read_dmu_rst_adc0
''                                                             write_dmu_rst_adc0
''---------------------------------------------------------------------------------
Class REGISTER_DMU_dmu_rst_blk1
    Private write_dmu_rst_sci0_value
    Private read_dmu_rst_sci0_value
    Private flag_dmu_rst_sci0
    Private write_dmu_rst_rom_value
    Private read_dmu_rst_rom_value
    Private flag_dmu_rst_rom
    Private write_dmu_rst_rng_value
    Private read_dmu_rst_rng_value
    Private flag_dmu_rst_rng
    Private write_dmu_rst_pwm_value
    Private read_dmu_rst_pwm_value
    Private flag_dmu_rst_pwm
    Private write_dmu_rst_pka_value
    Private read_dmu_rst_pka_value
    Private flag_dmu_rst_pka
    Private write_dmu_rst_pbz_value
    Private read_dmu_rst_pbz_value
    Private flag_dmu_rst_pbz
    Private write_dmu_rst_pby_value
    Private read_dmu_rst_pby_value
    Private flag_dmu_rst_pby
    Private write_dmu_rst_pbx_value
    Private read_dmu_rst_pbx_value
    Private flag_dmu_rst_pbx
    Private write_dmu_rst_odma_value
    Private read_dmu_rst_odma_value
    Private flag_dmu_rst_odma
    Private write_dmu_rst_nvm_value
    Private read_dmu_rst_nvm_value
    Private flag_dmu_rst_nvm
    Private write_dmu_rst_msr_value
    Private read_dmu_rst_msr_value
    Private flag_dmu_rst_msr
    Private write_dmu_rst_mmi_value
    Private read_dmu_rst_mmi_value
    Private flag_dmu_rst_mmi
    Private write_dmu_rst_mem_value
    Private read_dmu_rst_mem_value
    Private flag_dmu_rst_mem
    Private write_dmu_rst_lcd_value
    Private read_dmu_rst_lcd_value
    Private flag_dmu_rst_lcd
    Private write_dmu_rst_i2s_value
    Private read_dmu_rst_i2s_value
    Private flag_dmu_rst_i2s
    Private write_dmu_rst_i2c1_value
    Private read_dmu_rst_i2c1_value
    Private flag_dmu_rst_i2c1
    Private write_dmu_rst_i2c0_value
    Private read_dmu_rst_i2c0_value
    Private flag_dmu_rst_i2c0
    Private write_dmu_rst_gio4_value
    Private read_dmu_rst_gio4_value
    Private flag_dmu_rst_gio4
    Private write_dmu_rst_gio3_value
    Private read_dmu_rst_gio3_value
    Private flag_dmu_rst_gio3
    Private write_dmu_rst_gio2_value
    Private read_dmu_rst_gio2_value
    Private flag_dmu_rst_gio2
    Private write_dmu_rst_gio1_value
    Private read_dmu_rst_gio1_value
    Private flag_dmu_rst_gio1
    Private write_dmu_rst_gio0_value
    Private read_dmu_rst_gio0_value
    Private flag_dmu_rst_gio0
    Private write_dmu_rst_etm_value
    Private read_dmu_rst_etm_value
    Private flag_dmu_rst_etm
    Private write_dmu_rst_amac_value
    Private read_dmu_rst_amac_value
    Private flag_dmu_rst_amac
    Private write_dmu_rst_dec_value
    Private read_dmu_rst_dec_value
    Private flag_dmu_rst_dec
    Private write_dmu_rst_ddr_value
    Private read_dmu_rst_ddr_value
    Private flag_dmu_rst_ddr
    Private write_dmu_rst_dac_value
    Private read_dmu_rst_dac_value
    Private flag_dmu_rst_dac
    Private write_dmu_rst_d1w_value
    Private read_dmu_rst_d1w_value
    Private flag_dmu_rst_d1w
    Private write_dmu_rst_cfg_value
    Private read_dmu_rst_cfg_value
    Private flag_dmu_rst_cfg
    Private write_dmu_rst_bbl_value
    Private read_dmu_rst_bbl_value
    Private flag_dmu_rst_bbl
    Private write_dmu_rst_adc1_value
    Private read_dmu_rst_adc1_value
    Private flag_dmu_rst_adc1
    Private write_dmu_rst_adc0_value
    Private read_dmu_rst_adc0_value
    Private flag_dmu_rst_adc0

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H98
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_dmu_rst_sci0
        get_dmu_rst_sci0 = read_dmu_rst_sci0_value
    End Property

    Property Let set_dmu_rst_sci0(aData)
        write_dmu_rst_sci0_value = aData
        flag_dmu_rst_sci0        = &H1
    End Property

    Property Get read_dmu_rst_sci0
        read
        read_dmu_rst_sci0 = read_dmu_rst_sci0_value
    End Property

    Property Let write_dmu_rst_sci0(aData)
        set_dmu_rst_sci0 = aData
        write
    End Property

    Property Get get_dmu_rst_rom
        get_dmu_rst_rom = read_dmu_rst_rom_value
    End Property

    Property Let set_dmu_rst_rom(aData)
        write_dmu_rst_rom_value = aData
        flag_dmu_rst_rom        = &H1
    End Property

    Property Get read_dmu_rst_rom
        read
        read_dmu_rst_rom = read_dmu_rst_rom_value
    End Property

    Property Let write_dmu_rst_rom(aData)
        set_dmu_rst_rom = aData
        write
    End Property

    Property Get get_dmu_rst_rng
        get_dmu_rst_rng = read_dmu_rst_rng_value
    End Property

    Property Let set_dmu_rst_rng(aData)
        write_dmu_rst_rng_value = aData
        flag_dmu_rst_rng        = &H1
    End Property

    Property Get read_dmu_rst_rng
        read
        read_dmu_rst_rng = read_dmu_rst_rng_value
    End Property

    Property Let write_dmu_rst_rng(aData)
        set_dmu_rst_rng = aData
        write
    End Property

    Property Get get_dmu_rst_pwm
        get_dmu_rst_pwm = read_dmu_rst_pwm_value
    End Property

    Property Let set_dmu_rst_pwm(aData)
        write_dmu_rst_pwm_value = aData
        flag_dmu_rst_pwm        = &H1
    End Property

    Property Get read_dmu_rst_pwm
        read
        read_dmu_rst_pwm = read_dmu_rst_pwm_value
    End Property

    Property Let write_dmu_rst_pwm(aData)
        set_dmu_rst_pwm = aData
        write
    End Property

    Property Get get_dmu_rst_pka
        get_dmu_rst_pka = read_dmu_rst_pka_value
    End Property

    Property Let set_dmu_rst_pka(aData)
        write_dmu_rst_pka_value = aData
        flag_dmu_rst_pka        = &H1
    End Property

    Property Get read_dmu_rst_pka
        read
        read_dmu_rst_pka = read_dmu_rst_pka_value
    End Property

    Property Let write_dmu_rst_pka(aData)
        set_dmu_rst_pka = aData
        write
    End Property

    Property Get get_dmu_rst_pbz
        get_dmu_rst_pbz = read_dmu_rst_pbz_value
    End Property

    Property Let set_dmu_rst_pbz(aData)
        write_dmu_rst_pbz_value = aData
        flag_dmu_rst_pbz        = &H1
    End Property

    Property Get read_dmu_rst_pbz
        read
        read_dmu_rst_pbz = read_dmu_rst_pbz_value
    End Property

    Property Let write_dmu_rst_pbz(aData)
        set_dmu_rst_pbz = aData
        write
    End Property

    Property Get get_dmu_rst_pby
        get_dmu_rst_pby = read_dmu_rst_pby_value
    End Property

    Property Let set_dmu_rst_pby(aData)
        write_dmu_rst_pby_value = aData
        flag_dmu_rst_pby        = &H1
    End Property

    Property Get read_dmu_rst_pby
        read
        read_dmu_rst_pby = read_dmu_rst_pby_value
    End Property

    Property Let write_dmu_rst_pby(aData)
        set_dmu_rst_pby = aData
        write
    End Property

    Property Get get_dmu_rst_pbx
        get_dmu_rst_pbx = read_dmu_rst_pbx_value
    End Property

    Property Let set_dmu_rst_pbx(aData)
        write_dmu_rst_pbx_value = aData
        flag_dmu_rst_pbx        = &H1
    End Property

    Property Get read_dmu_rst_pbx
        read
        read_dmu_rst_pbx = read_dmu_rst_pbx_value
    End Property

    Property Let write_dmu_rst_pbx(aData)
        set_dmu_rst_pbx = aData
        write
    End Property

    Property Get get_dmu_rst_odma
        get_dmu_rst_odma = read_dmu_rst_odma_value
    End Property

    Property Let set_dmu_rst_odma(aData)
        write_dmu_rst_odma_value = aData
        flag_dmu_rst_odma        = &H1
    End Property

    Property Get read_dmu_rst_odma
        read
        read_dmu_rst_odma = read_dmu_rst_odma_value
    End Property

    Property Let write_dmu_rst_odma(aData)
        set_dmu_rst_odma = aData
        write
    End Property

    Property Get get_dmu_rst_nvm
        get_dmu_rst_nvm = read_dmu_rst_nvm_value
    End Property

    Property Let set_dmu_rst_nvm(aData)
        write_dmu_rst_nvm_value = aData
        flag_dmu_rst_nvm        = &H1
    End Property

    Property Get read_dmu_rst_nvm
        read
        read_dmu_rst_nvm = read_dmu_rst_nvm_value
    End Property

    Property Let write_dmu_rst_nvm(aData)
        set_dmu_rst_nvm = aData
        write
    End Property

    Property Get get_dmu_rst_msr
        get_dmu_rst_msr = read_dmu_rst_msr_value
    End Property

    Property Let set_dmu_rst_msr(aData)
        write_dmu_rst_msr_value = aData
        flag_dmu_rst_msr        = &H1
    End Property

    Property Get read_dmu_rst_msr
        read
        read_dmu_rst_msr = read_dmu_rst_msr_value
    End Property

    Property Let write_dmu_rst_msr(aData)
        set_dmu_rst_msr = aData
        write
    End Property

    Property Get get_dmu_rst_mmi
        get_dmu_rst_mmi = read_dmu_rst_mmi_value
    End Property

    Property Let set_dmu_rst_mmi(aData)
        write_dmu_rst_mmi_value = aData
        flag_dmu_rst_mmi        = &H1
    End Property

    Property Get read_dmu_rst_mmi
        read
        read_dmu_rst_mmi = read_dmu_rst_mmi_value
    End Property

    Property Let write_dmu_rst_mmi(aData)
        set_dmu_rst_mmi = aData
        write
    End Property

    Property Get get_dmu_rst_mem
        get_dmu_rst_mem = read_dmu_rst_mem_value
    End Property

    Property Let set_dmu_rst_mem(aData)
        write_dmu_rst_mem_value = aData
        flag_dmu_rst_mem        = &H1
    End Property

    Property Get read_dmu_rst_mem
        read
        read_dmu_rst_mem = read_dmu_rst_mem_value
    End Property

    Property Let write_dmu_rst_mem(aData)
        set_dmu_rst_mem = aData
        write
    End Property

    Property Get get_dmu_rst_lcd
        get_dmu_rst_lcd = read_dmu_rst_lcd_value
    End Property

    Property Let set_dmu_rst_lcd(aData)
        write_dmu_rst_lcd_value = aData
        flag_dmu_rst_lcd        = &H1
    End Property

    Property Get read_dmu_rst_lcd
        read
        read_dmu_rst_lcd = read_dmu_rst_lcd_value
    End Property

    Property Let write_dmu_rst_lcd(aData)
        set_dmu_rst_lcd = aData
        write
    End Property

    Property Get get_dmu_rst_i2s
        get_dmu_rst_i2s = read_dmu_rst_i2s_value
    End Property

    Property Let set_dmu_rst_i2s(aData)
        write_dmu_rst_i2s_value = aData
        flag_dmu_rst_i2s        = &H1
    End Property

    Property Get read_dmu_rst_i2s
        read
        read_dmu_rst_i2s = read_dmu_rst_i2s_value
    End Property

    Property Let write_dmu_rst_i2s(aData)
        set_dmu_rst_i2s = aData
        write
    End Property

    Property Get get_dmu_rst_i2c1
        get_dmu_rst_i2c1 = read_dmu_rst_i2c1_value
    End Property

    Property Let set_dmu_rst_i2c1(aData)
        write_dmu_rst_i2c1_value = aData
        flag_dmu_rst_i2c1        = &H1
    End Property

    Property Get read_dmu_rst_i2c1
        read
        read_dmu_rst_i2c1 = read_dmu_rst_i2c1_value
    End Property

    Property Let write_dmu_rst_i2c1(aData)
        set_dmu_rst_i2c1 = aData
        write
    End Property

    Property Get get_dmu_rst_i2c0
        get_dmu_rst_i2c0 = read_dmu_rst_i2c0_value
    End Property

    Property Let set_dmu_rst_i2c0(aData)
        write_dmu_rst_i2c0_value = aData
        flag_dmu_rst_i2c0        = &H1
    End Property

    Property Get read_dmu_rst_i2c0
        read
        read_dmu_rst_i2c0 = read_dmu_rst_i2c0_value
    End Property

    Property Let write_dmu_rst_i2c0(aData)
        set_dmu_rst_i2c0 = aData
        write
    End Property

    Property Get get_dmu_rst_gio4
        get_dmu_rst_gio4 = read_dmu_rst_gio4_value
    End Property

    Property Let set_dmu_rst_gio4(aData)
        write_dmu_rst_gio4_value = aData
        flag_dmu_rst_gio4        = &H1
    End Property

    Property Get read_dmu_rst_gio4
        read
        read_dmu_rst_gio4 = read_dmu_rst_gio4_value
    End Property

    Property Let write_dmu_rst_gio4(aData)
        set_dmu_rst_gio4 = aData
        write
    End Property

    Property Get get_dmu_rst_gio3
        get_dmu_rst_gio3 = read_dmu_rst_gio3_value
    End Property

    Property Let set_dmu_rst_gio3(aData)
        write_dmu_rst_gio3_value = aData
        flag_dmu_rst_gio3        = &H1
    End Property

    Property Get read_dmu_rst_gio3
        read
        read_dmu_rst_gio3 = read_dmu_rst_gio3_value
    End Property

    Property Let write_dmu_rst_gio3(aData)
        set_dmu_rst_gio3 = aData
        write
    End Property

    Property Get get_dmu_rst_gio2
        get_dmu_rst_gio2 = read_dmu_rst_gio2_value
    End Property

    Property Let set_dmu_rst_gio2(aData)
        write_dmu_rst_gio2_value = aData
        flag_dmu_rst_gio2        = &H1
    End Property

    Property Get read_dmu_rst_gio2
        read
        read_dmu_rst_gio2 = read_dmu_rst_gio2_value
    End Property

    Property Let write_dmu_rst_gio2(aData)
        set_dmu_rst_gio2 = aData
        write
    End Property

    Property Get get_dmu_rst_gio1
        get_dmu_rst_gio1 = read_dmu_rst_gio1_value
    End Property

    Property Let set_dmu_rst_gio1(aData)
        write_dmu_rst_gio1_value = aData
        flag_dmu_rst_gio1        = &H1
    End Property

    Property Get read_dmu_rst_gio1
        read
        read_dmu_rst_gio1 = read_dmu_rst_gio1_value
    End Property

    Property Let write_dmu_rst_gio1(aData)
        set_dmu_rst_gio1 = aData
        write
    End Property

    Property Get get_dmu_rst_gio0
        get_dmu_rst_gio0 = read_dmu_rst_gio0_value
    End Property

    Property Let set_dmu_rst_gio0(aData)
        write_dmu_rst_gio0_value = aData
        flag_dmu_rst_gio0        = &H1
    End Property

    Property Get read_dmu_rst_gio0
        read
        read_dmu_rst_gio0 = read_dmu_rst_gio0_value
    End Property

    Property Let write_dmu_rst_gio0(aData)
        set_dmu_rst_gio0 = aData
        write
    End Property

    Property Get get_dmu_rst_etm
        get_dmu_rst_etm = read_dmu_rst_etm_value
    End Property

    Property Let set_dmu_rst_etm(aData)
        write_dmu_rst_etm_value = aData
        flag_dmu_rst_etm        = &H1
    End Property

    Property Get read_dmu_rst_etm
        read
        read_dmu_rst_etm = read_dmu_rst_etm_value
    End Property

    Property Let write_dmu_rst_etm(aData)
        set_dmu_rst_etm = aData
        write
    End Property

    Property Get get_dmu_rst_amac
        get_dmu_rst_amac = read_dmu_rst_amac_value
    End Property

    Property Let set_dmu_rst_amac(aData)
        write_dmu_rst_amac_value = aData
        flag_dmu_rst_amac        = &H1
    End Property

    Property Get read_dmu_rst_amac
        read
        read_dmu_rst_amac = read_dmu_rst_amac_value
    End Property

    Property Let write_dmu_rst_amac(aData)
        set_dmu_rst_amac = aData
        write
    End Property

    Property Get get_dmu_rst_dec
        get_dmu_rst_dec = read_dmu_rst_dec_value
    End Property

    Property Let set_dmu_rst_dec(aData)
        write_dmu_rst_dec_value = aData
        flag_dmu_rst_dec        = &H1
    End Property

    Property Get read_dmu_rst_dec
        read
        read_dmu_rst_dec = read_dmu_rst_dec_value
    End Property

    Property Let write_dmu_rst_dec(aData)
        set_dmu_rst_dec = aData
        write
    End Property

    Property Get get_dmu_rst_ddr
        get_dmu_rst_ddr = read_dmu_rst_ddr_value
    End Property

    Property Let set_dmu_rst_ddr(aData)
        write_dmu_rst_ddr_value = aData
        flag_dmu_rst_ddr        = &H1
    End Property

    Property Get read_dmu_rst_ddr
        read
        read_dmu_rst_ddr = read_dmu_rst_ddr_value
    End Property

    Property Let write_dmu_rst_ddr(aData)
        set_dmu_rst_ddr = aData
        write
    End Property

    Property Get get_dmu_rst_dac
        get_dmu_rst_dac = read_dmu_rst_dac_value
    End Property

    Property Let set_dmu_rst_dac(aData)
        write_dmu_rst_dac_value = aData
        flag_dmu_rst_dac        = &H1
    End Property

    Property Get read_dmu_rst_dac
        read
        read_dmu_rst_dac = read_dmu_rst_dac_value
    End Property

    Property Let write_dmu_rst_dac(aData)
        set_dmu_rst_dac = aData
        write
    End Property

    Property Get get_dmu_rst_d1w
        get_dmu_rst_d1w = read_dmu_rst_d1w_value
    End Property

    Property Let set_dmu_rst_d1w(aData)
        write_dmu_rst_d1w_value = aData
        flag_dmu_rst_d1w        = &H1
    End Property

    Property Get read_dmu_rst_d1w
        read
        read_dmu_rst_d1w = read_dmu_rst_d1w_value
    End Property

    Property Let write_dmu_rst_d1w(aData)
        set_dmu_rst_d1w = aData
        write
    End Property

    Property Get get_dmu_rst_cfg
        get_dmu_rst_cfg = read_dmu_rst_cfg_value
    End Property

    Property Let set_dmu_rst_cfg(aData)
        write_dmu_rst_cfg_value = aData
        flag_dmu_rst_cfg        = &H1
    End Property

    Property Get read_dmu_rst_cfg
        read
        read_dmu_rst_cfg = read_dmu_rst_cfg_value
    End Property

    Property Let write_dmu_rst_cfg(aData)
        set_dmu_rst_cfg = aData
        write
    End Property

    Property Get get_dmu_rst_bbl
        get_dmu_rst_bbl = read_dmu_rst_bbl_value
    End Property

    Property Let set_dmu_rst_bbl(aData)
        write_dmu_rst_bbl_value = aData
        flag_dmu_rst_bbl        = &H1
    End Property

    Property Get read_dmu_rst_bbl
        read
        read_dmu_rst_bbl = read_dmu_rst_bbl_value
    End Property

    Property Let write_dmu_rst_bbl(aData)
        set_dmu_rst_bbl = aData
        write
    End Property

    Property Get get_dmu_rst_adc1
        get_dmu_rst_adc1 = read_dmu_rst_adc1_value
    End Property

    Property Let set_dmu_rst_adc1(aData)
        write_dmu_rst_adc1_value = aData
        flag_dmu_rst_adc1        = &H1
    End Property

    Property Get read_dmu_rst_adc1
        read
        read_dmu_rst_adc1 = read_dmu_rst_adc1_value
    End Property

    Property Let write_dmu_rst_adc1(aData)
        set_dmu_rst_adc1 = aData
        write
    End Property

    Property Get get_dmu_rst_adc0
        get_dmu_rst_adc0 = read_dmu_rst_adc0_value
    End Property

    Property Let set_dmu_rst_adc0(aData)
        write_dmu_rst_adc0_value = aData
        flag_dmu_rst_adc0        = &H1
    End Property

    Property Get read_dmu_rst_adc0
        read
        read_dmu_rst_adc0 = read_dmu_rst_adc0_value
    End Property

    Property Let write_dmu_rst_adc0(aData)
        set_dmu_rst_adc0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_dmu_rst_sci0_value = rightShift(data_low, 31) and &H1
        read_dmu_rst_rom_value = rightShift(data_low, 30) and &H1
        read_dmu_rst_rng_value = rightShift(data_low, 29) and &H1
        read_dmu_rst_pwm_value = rightShift(data_low, 28) and &H1
        read_dmu_rst_pka_value = rightShift(data_low, 27) and &H1
        read_dmu_rst_pbz_value = rightShift(data_low, 26) and &H1
        read_dmu_rst_pby_value = rightShift(data_low, 25) and &H1
        read_dmu_rst_pbx_value = rightShift(data_low, 24) and &H1
        read_dmu_rst_odma_value = rightShift(data_low, 23) and &H1
        read_dmu_rst_nvm_value = rightShift(data_low, 22) and &H1
        read_dmu_rst_msr_value = rightShift(data_low, 21) and &H1
        read_dmu_rst_mmi_value = rightShift(data_low, 20) and &H1
        read_dmu_rst_mem_value = rightShift(data_low, 19) and &H1
        read_dmu_rst_lcd_value = rightShift(data_low, 18) and &H1
        read_dmu_rst_i2s_value = rightShift(data_low, 17) and &H1
        read_dmu_rst_i2c1_value = rightShift(data_low, 16) and &H1
        read_dmu_rst_i2c0_value = rightShift(data_low, 15) and &H1
        read_dmu_rst_gio4_value = rightShift(data_low, 14) and &H1
        read_dmu_rst_gio3_value = rightShift(data_low, 13) and &H1
        read_dmu_rst_gio2_value = rightShift(data_low, 12) and &H1
        read_dmu_rst_gio1_value = rightShift(data_low, 11) and &H1
        read_dmu_rst_gio0_value = rightShift(data_low, 10) and &H1
        read_dmu_rst_etm_value = rightShift(data_low, 9) and &H1
        read_dmu_rst_amac_value = rightShift(data_low, 8) and &H1
        read_dmu_rst_dec_value = rightShift(data_low, 7) and &H1
        read_dmu_rst_ddr_value = rightShift(data_low, 6) and &H1
        read_dmu_rst_dac_value = rightShift(data_low, 5) and &H1
        read_dmu_rst_d1w_value = rightShift(data_low, 4) and &H1
        read_dmu_rst_cfg_value = rightShift(data_low, 3) and &H1
        read_dmu_rst_bbl_value = rightShift(data_low, 2) and &H1
        read_dmu_rst_adc1_value = rightShift(data_low, 1) and &H1
        dmu_rst_adc0_mask = &H1
        if data_low > LONG_MAX then
            if dmu_rst_adc0_mask = mask then
                read_dmu_rst_adc0_value = data_low
            else
                read_dmu_rst_adc0_value = (data_low - H8000_0000) and dmu_rst_adc0_mask
            end If
        else
            read_dmu_rst_adc0_value = data_low and dmu_rst_adc0_mask
        end If

    End Sub

    Sub write
        If flag_dmu_rst_sci0 = &H0 or flag_dmu_rst_rom = &H0 or flag_dmu_rst_rng = &H0 or flag_dmu_rst_pwm = &H0 or flag_dmu_rst_pka = &H0 or flag_dmu_rst_pbz = &H0 or flag_dmu_rst_pby = &H0 or flag_dmu_rst_pbx = &H0 or flag_dmu_rst_odma = &H0 or flag_dmu_rst_nvm = &H0 or flag_dmu_rst_msr = &H0 or flag_dmu_rst_mmi = &H0 or flag_dmu_rst_mem = &H0 or flag_dmu_rst_lcd = &H0 or flag_dmu_rst_i2s = &H0 or flag_dmu_rst_i2c1 = &H0 or flag_dmu_rst_i2c0 = &H0 or flag_dmu_rst_gio4 = &H0 or flag_dmu_rst_gio3 = &H0 or flag_dmu_rst_gio2 = &H0 or flag_dmu_rst_gio1 = &H0 or flag_dmu_rst_gio0 = &H0 or flag_dmu_rst_etm = &H0 or flag_dmu_rst_amac = &H0 or flag_dmu_rst_dec = &H0 or flag_dmu_rst_ddr = &H0 or flag_dmu_rst_dac = &H0 or flag_dmu_rst_d1w = &H0 or flag_dmu_rst_cfg = &H0 or flag_dmu_rst_bbl = &H0 or flag_dmu_rst_adc1 = &H0 or flag_dmu_rst_adc0 = &H0 Then read
        If flag_dmu_rst_sci0 = &H0 Then write_dmu_rst_sci0_value = get_dmu_rst_sci0
        If flag_dmu_rst_rom = &H0 Then write_dmu_rst_rom_value = get_dmu_rst_rom
        If flag_dmu_rst_rng = &H0 Then write_dmu_rst_rng_value = get_dmu_rst_rng
        If flag_dmu_rst_pwm = &H0 Then write_dmu_rst_pwm_value = get_dmu_rst_pwm
        If flag_dmu_rst_pka = &H0 Then write_dmu_rst_pka_value = get_dmu_rst_pka
        If flag_dmu_rst_pbz = &H0 Then write_dmu_rst_pbz_value = get_dmu_rst_pbz
        If flag_dmu_rst_pby = &H0 Then write_dmu_rst_pby_value = get_dmu_rst_pby
        If flag_dmu_rst_pbx = &H0 Then write_dmu_rst_pbx_value = get_dmu_rst_pbx
        If flag_dmu_rst_odma = &H0 Then write_dmu_rst_odma_value = get_dmu_rst_odma
        If flag_dmu_rst_nvm = &H0 Then write_dmu_rst_nvm_value = get_dmu_rst_nvm
        If flag_dmu_rst_msr = &H0 Then write_dmu_rst_msr_value = get_dmu_rst_msr
        If flag_dmu_rst_mmi = &H0 Then write_dmu_rst_mmi_value = get_dmu_rst_mmi
        If flag_dmu_rst_mem = &H0 Then write_dmu_rst_mem_value = get_dmu_rst_mem
        If flag_dmu_rst_lcd = &H0 Then write_dmu_rst_lcd_value = get_dmu_rst_lcd
        If flag_dmu_rst_i2s = &H0 Then write_dmu_rst_i2s_value = get_dmu_rst_i2s
        If flag_dmu_rst_i2c1 = &H0 Then write_dmu_rst_i2c1_value = get_dmu_rst_i2c1
        If flag_dmu_rst_i2c0 = &H0 Then write_dmu_rst_i2c0_value = get_dmu_rst_i2c0
        If flag_dmu_rst_gio4 = &H0 Then write_dmu_rst_gio4_value = get_dmu_rst_gio4
        If flag_dmu_rst_gio3 = &H0 Then write_dmu_rst_gio3_value = get_dmu_rst_gio3
        If flag_dmu_rst_gio2 = &H0 Then write_dmu_rst_gio2_value = get_dmu_rst_gio2
        If flag_dmu_rst_gio1 = &H0 Then write_dmu_rst_gio1_value = get_dmu_rst_gio1
        If flag_dmu_rst_gio0 = &H0 Then write_dmu_rst_gio0_value = get_dmu_rst_gio0
        If flag_dmu_rst_etm = &H0 Then write_dmu_rst_etm_value = get_dmu_rst_etm
        If flag_dmu_rst_amac = &H0 Then write_dmu_rst_amac_value = get_dmu_rst_amac
        If flag_dmu_rst_dec = &H0 Then write_dmu_rst_dec_value = get_dmu_rst_dec
        If flag_dmu_rst_ddr = &H0 Then write_dmu_rst_ddr_value = get_dmu_rst_ddr
        If flag_dmu_rst_dac = &H0 Then write_dmu_rst_dac_value = get_dmu_rst_dac
        If flag_dmu_rst_d1w = &H0 Then write_dmu_rst_d1w_value = get_dmu_rst_d1w
        If flag_dmu_rst_cfg = &H0 Then write_dmu_rst_cfg_value = get_dmu_rst_cfg
        If flag_dmu_rst_bbl = &H0 Then write_dmu_rst_bbl_value = get_dmu_rst_bbl
        If flag_dmu_rst_adc1 = &H0 Then write_dmu_rst_adc1_value = get_dmu_rst_adc1
        If flag_dmu_rst_adc0 = &H0 Then write_dmu_rst_adc0_value = get_dmu_rst_adc0

        regValue = leftShift((write_dmu_rst_sci0_value and &H1), 31) + leftShift((write_dmu_rst_rom_value and &H1), 30) + leftShift((write_dmu_rst_rng_value and &H1), 29) + leftShift((write_dmu_rst_pwm_value and &H1), 28) + leftShift((write_dmu_rst_pka_value and &H1), 27) + leftShift((write_dmu_rst_pbz_value and &H1), 26) + leftShift((write_dmu_rst_pby_value and &H1), 25) + leftShift((write_dmu_rst_pbx_value and &H1), 24) + leftShift((write_dmu_rst_odma_value and &H1), 23) + leftShift((write_dmu_rst_nvm_value and &H1), 22) + leftShift((write_dmu_rst_msr_value and &H1), 21) + leftShift((write_dmu_rst_mmi_value and &H1), 20) + leftShift((write_dmu_rst_mem_value and &H1), 19) + leftShift((write_dmu_rst_lcd_value and &H1), 18) + leftShift((write_dmu_rst_i2s_value and &H1), 17) + leftShift((write_dmu_rst_i2c1_value and &H1), 16) + leftShift((write_dmu_rst_i2c0_value and &H1), 15) + leftShift((write_dmu_rst_gio4_value and &H1), 14) + leftShift((write_dmu_rst_gio3_value and &H1), 13) + leftShift((write_dmu_rst_gio2_value and &H1), 12) + leftShift((write_dmu_rst_gio1_value and &H1), 11) + leftShift((write_dmu_rst_gio0_value and &H1), 10) + leftShift((write_dmu_rst_etm_value and &H1), 9) + leftShift((write_dmu_rst_amac_value and &H1), 8) + leftShift((write_dmu_rst_dec_value and &H1), 7) + leftShift((write_dmu_rst_ddr_value and &H1), 6) + leftShift((write_dmu_rst_dac_value and &H1), 5) + leftShift((write_dmu_rst_d1w_value and &H1), 4) + leftShift((write_dmu_rst_cfg_value and &H1), 3) + leftShift((write_dmu_rst_bbl_value and &H1), 2) + leftShift((write_dmu_rst_adc1_value and &H1), 1) + leftShift((write_dmu_rst_adc0_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_dmu_rst_sci0_value = rightShift(data_low, 31) and &H1
        read_dmu_rst_rom_value = rightShift(data_low, 30) and &H1
        read_dmu_rst_rng_value = rightShift(data_low, 29) and &H1
        read_dmu_rst_pwm_value = rightShift(data_low, 28) and &H1
        read_dmu_rst_pka_value = rightShift(data_low, 27) and &H1
        read_dmu_rst_pbz_value = rightShift(data_low, 26) and &H1
        read_dmu_rst_pby_value = rightShift(data_low, 25) and &H1
        read_dmu_rst_pbx_value = rightShift(data_low, 24) and &H1
        read_dmu_rst_odma_value = rightShift(data_low, 23) and &H1
        read_dmu_rst_nvm_value = rightShift(data_low, 22) and &H1
        read_dmu_rst_msr_value = rightShift(data_low, 21) and &H1
        read_dmu_rst_mmi_value = rightShift(data_low, 20) and &H1
        read_dmu_rst_mem_value = rightShift(data_low, 19) and &H1
        read_dmu_rst_lcd_value = rightShift(data_low, 18) and &H1
        read_dmu_rst_i2s_value = rightShift(data_low, 17) and &H1
        read_dmu_rst_i2c1_value = rightShift(data_low, 16) and &H1
        read_dmu_rst_i2c0_value = rightShift(data_low, 15) and &H1
        read_dmu_rst_gio4_value = rightShift(data_low, 14) and &H1
        read_dmu_rst_gio3_value = rightShift(data_low, 13) and &H1
        read_dmu_rst_gio2_value = rightShift(data_low, 12) and &H1
        read_dmu_rst_gio1_value = rightShift(data_low, 11) and &H1
        read_dmu_rst_gio0_value = rightShift(data_low, 10) and &H1
        read_dmu_rst_etm_value = rightShift(data_low, 9) and &H1
        read_dmu_rst_amac_value = rightShift(data_low, 8) and &H1
        read_dmu_rst_dec_value = rightShift(data_low, 7) and &H1
        read_dmu_rst_ddr_value = rightShift(data_low, 6) and &H1
        read_dmu_rst_dac_value = rightShift(data_low, 5) and &H1
        read_dmu_rst_d1w_value = rightShift(data_low, 4) and &H1
        read_dmu_rst_cfg_value = rightShift(data_low, 3) and &H1
        read_dmu_rst_bbl_value = rightShift(data_low, 2) and &H1
        read_dmu_rst_adc1_value = rightShift(data_low, 1) and &H1
        dmu_rst_adc0_mask = &H1
        if data_low > LONG_MAX then
            if dmu_rst_adc0_mask = mask then
                read_dmu_rst_adc0_value = data_low
            else
                read_dmu_rst_adc0_value = (data_low - H8000_0000) and dmu_rst_adc0_mask
            end If
        else
            read_dmu_rst_adc0_value = data_low and dmu_rst_adc0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_dmu_rst_sci0_value = &H0
        flag_dmu_rst_sci0        = &H0
        write_dmu_rst_rom_value = &H0
        flag_dmu_rst_rom        = &H0
        write_dmu_rst_rng_value = &H0
        flag_dmu_rst_rng        = &H0
        write_dmu_rst_pwm_value = &H0
        flag_dmu_rst_pwm        = &H0
        write_dmu_rst_pka_value = &H0
        flag_dmu_rst_pka        = &H0
        write_dmu_rst_pbz_value = &H0
        flag_dmu_rst_pbz        = &H0
        write_dmu_rst_pby_value = &H0
        flag_dmu_rst_pby        = &H0
        write_dmu_rst_pbx_value = &H0
        flag_dmu_rst_pbx        = &H0
        write_dmu_rst_odma_value = &H0
        flag_dmu_rst_odma        = &H0
        write_dmu_rst_nvm_value = &H0
        flag_dmu_rst_nvm        = &H0
        write_dmu_rst_msr_value = &H0
        flag_dmu_rst_msr        = &H0
        write_dmu_rst_mmi_value = &H0
        flag_dmu_rst_mmi        = &H0
        write_dmu_rst_mem_value = &H0
        flag_dmu_rst_mem        = &H0
        write_dmu_rst_lcd_value = &H0
        flag_dmu_rst_lcd        = &H0
        write_dmu_rst_i2s_value = &H0
        flag_dmu_rst_i2s        = &H0
        write_dmu_rst_i2c1_value = &H0
        flag_dmu_rst_i2c1        = &H0
        write_dmu_rst_i2c0_value = &H0
        flag_dmu_rst_i2c0        = &H0
        write_dmu_rst_gio4_value = &H0
        flag_dmu_rst_gio4        = &H0
        write_dmu_rst_gio3_value = &H0
        flag_dmu_rst_gio3        = &H0
        write_dmu_rst_gio2_value = &H0
        flag_dmu_rst_gio2        = &H0
        write_dmu_rst_gio1_value = &H0
        flag_dmu_rst_gio1        = &H0
        write_dmu_rst_gio0_value = &H0
        flag_dmu_rst_gio0        = &H0
        write_dmu_rst_etm_value = &H0
        flag_dmu_rst_etm        = &H0
        write_dmu_rst_amac_value = &H0
        flag_dmu_rst_amac        = &H0
        write_dmu_rst_dec_value = &H0
        flag_dmu_rst_dec        = &H0
        write_dmu_rst_ddr_value = &H0
        flag_dmu_rst_ddr        = &H0
        write_dmu_rst_dac_value = &H0
        flag_dmu_rst_dac        = &H0
        write_dmu_rst_d1w_value = &H0
        flag_dmu_rst_d1w        = &H0
        write_dmu_rst_cfg_value = &H0
        flag_dmu_rst_cfg        = &H0
        write_dmu_rst_bbl_value = &H0
        flag_dmu_rst_bbl        = &H0
        write_dmu_rst_adc1_value = &H0
        flag_dmu_rst_adc1        = &H0
        write_dmu_rst_adc0_value = &H0
        flag_dmu_rst_adc0        = &H0
    End Sub
End Class


'' @REGISTER : DMU_dmu_rst_blk2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' dmu_rst_ram                                [26:26]          get_dmu_rst_ram
''                                                             set_dmu_rst_ram
''                                                             read_dmu_rst_ram
''                                                             write_dmu_rst_ram
''---------------------------------------------------------------------------------
'' dmu_rst_wdt                                [25:25]          get_dmu_rst_wdt
''                                                             set_dmu_rst_wdt
''                                                             read_dmu_rst_wdt
''                                                             write_dmu_rst_wdt
''---------------------------------------------------------------------------------
'' dmu_rst_usb2                               [24:24]          get_dmu_rst_usb2
''                                                             set_dmu_rst_usb2
''                                                             read_dmu_rst_usb2
''                                                             write_dmu_rst_usb2
''---------------------------------------------------------------------------------
'' dmu_rst_usb1                               [23:23]          get_dmu_rst_usb1
''                                                             set_dmu_rst_usb1
''                                                             read_dmu_rst_usb1
''                                                             write_dmu_rst_usb1
''---------------------------------------------------------------------------------
'' dmu_rst_usb0                               [22:22]          get_dmu_rst_usb0
''                                                             set_dmu_rst_usb0
''                                                             read_dmu_rst_usb0
''                                                             write_dmu_rst_usb0
''---------------------------------------------------------------------------------
'' dmu_rst_urt3                               [21:21]          get_dmu_rst_urt3
''                                                             set_dmu_rst_urt3
''                                                             read_dmu_rst_urt3
''                                                             write_dmu_rst_urt3
''---------------------------------------------------------------------------------
'' dmu_rst_urt2                               [20:20]          get_dmu_rst_urt2
''                                                             set_dmu_rst_urt2
''                                                             read_dmu_rst_urt2
''                                                             write_dmu_rst_urt2
''---------------------------------------------------------------------------------
'' dmu_rst_urt1                               [19:19]          get_dmu_rst_urt1
''                                                             set_dmu_rst_urt1
''                                                             read_dmu_rst_urt1
''                                                             write_dmu_rst_urt1
''---------------------------------------------------------------------------------
'' dmu_rst_urt0                               [18:18]          get_dmu_rst_urt0
''                                                             set_dmu_rst_urt0
''                                                             read_dmu_rst_urt0
''                                                             write_dmu_rst_urt0
''---------------------------------------------------------------------------------
'' dmu_rst_umc                                [17:17]          get_dmu_rst_umc
''                                                             set_dmu_rst_umc
''                                                             read_dmu_rst_umc
''                                                             write_dmu_rst_umc
''---------------------------------------------------------------------------------
'' dmu_rst_tpb                                [16:16]          get_dmu_rst_tpb
''                                                             set_dmu_rst_tpb
''                                                             read_dmu_rst_tpb
''                                                             write_dmu_rst_tpb
''---------------------------------------------------------------------------------
'' dmu_rst_tim4                               [15:15]          get_dmu_rst_tim4
''                                                             set_dmu_rst_tim4
''                                                             read_dmu_rst_tim4
''                                                             write_dmu_rst_tim4
''---------------------------------------------------------------------------------
'' dmu_rst_tim3                               [14:14]          get_dmu_rst_tim3
''                                                             set_dmu_rst_tim3
''                                                             read_dmu_rst_tim3
''                                                             write_dmu_rst_tim3
''---------------------------------------------------------------------------------
'' dmu_rst_tim2                               [13:13]          get_dmu_rst_tim2
''                                                             set_dmu_rst_tim2
''                                                             read_dmu_rst_tim2
''                                                             write_dmu_rst_tim2
''---------------------------------------------------------------------------------
'' dmu_rst_tim1                               [12:12]          get_dmu_rst_tim1
''                                                             set_dmu_rst_tim1
''                                                             read_dmu_rst_tim1
''                                                             write_dmu_rst_tim1
''---------------------------------------------------------------------------------
'' dmu_rst_tim0                               [11:11]          get_dmu_rst_tim0
''                                                             set_dmu_rst_tim0
''                                                             read_dmu_rst_tim0
''                                                             write_dmu_rst_tim0
''---------------------------------------------------------------------------------
'' dmu_rst_spl                                [10:10]          get_dmu_rst_spl
''                                                             set_dmu_rst_spl
''                                                             read_dmu_rst_spl
''                                                             write_dmu_rst_spl
''---------------------------------------------------------------------------------
'' dmu_rst_qspi                               [9:9]            get_dmu_rst_qspi
''                                                             set_dmu_rst_qspi
''                                                             read_dmu_rst_qspi
''                                                             write_dmu_rst_qspi
''---------------------------------------------------------------------------------
'' dmu_rst_spi10t1s                           [8:8]            get_dmu_rst_spi10t1s
''                                                             set_dmu_rst_spi10t1s
''                                                             read_dmu_rst_spi10t1s
''                                                             write_dmu_rst_spi10t1s
''---------------------------------------------------------------------------------
'' dmu_rst_spi1                               [7:7]            get_dmu_rst_spi1
''                                                             set_dmu_rst_spi1
''                                                             read_dmu_rst_spi1
''                                                             write_dmu_rst_spi1
''---------------------------------------------------------------------------------
'' dmu_rst_spi0                               [6:6]            get_dmu_rst_spi0
''                                                             set_dmu_rst_spi0
''                                                             read_dmu_rst_spi0
''                                                             write_dmu_rst_spi0
''---------------------------------------------------------------------------------
'' dmu_rst_smu                                [5:5]            get_dmu_rst_smu
''                                                             set_dmu_rst_smu
''                                                             read_dmu_rst_smu
''                                                             write_dmu_rst_smu
''---------------------------------------------------------------------------------
'' dmu_rst_smc                                [4:4]            get_dmu_rst_smc
''                                                             set_dmu_rst_smc
''                                                             read_dmu_rst_smc
''                                                             write_dmu_rst_smc
''---------------------------------------------------------------------------------
'' dmu_rst_sdma                               [3:3]            get_dmu_rst_sdma
''                                                             set_dmu_rst_sdma
''                                                             read_dmu_rst_sdma
''                                                             write_dmu_rst_sdma
''---------------------------------------------------------------------------------
'' dmu_rst_sdm1                               [2:2]            get_dmu_rst_sdm1
''                                                             set_dmu_rst_sdm1
''                                                             read_dmu_rst_sdm1
''                                                             write_dmu_rst_sdm1
''---------------------------------------------------------------------------------
'' dmu_rst_sdm0                               [1:1]            get_dmu_rst_sdm0
''                                                             set_dmu_rst_sdm0
''                                                             read_dmu_rst_sdm0
''                                                             write_dmu_rst_sdm0
''---------------------------------------------------------------------------------
'' dmu_rst_sci1                               [0:0]            get_dmu_rst_sci1
''                                                             set_dmu_rst_sci1
''                                                             read_dmu_rst_sci1
''                                                             write_dmu_rst_sci1
''---------------------------------------------------------------------------------
Class REGISTER_DMU_dmu_rst_blk2
    Private write_dmu_rst_ram_value
    Private read_dmu_rst_ram_value
    Private flag_dmu_rst_ram
    Private write_dmu_rst_wdt_value
    Private read_dmu_rst_wdt_value
    Private flag_dmu_rst_wdt
    Private write_dmu_rst_usb2_value
    Private read_dmu_rst_usb2_value
    Private flag_dmu_rst_usb2
    Private write_dmu_rst_usb1_value
    Private read_dmu_rst_usb1_value
    Private flag_dmu_rst_usb1
    Private write_dmu_rst_usb0_value
    Private read_dmu_rst_usb0_value
    Private flag_dmu_rst_usb0
    Private write_dmu_rst_urt3_value
    Private read_dmu_rst_urt3_value
    Private flag_dmu_rst_urt3
    Private write_dmu_rst_urt2_value
    Private read_dmu_rst_urt2_value
    Private flag_dmu_rst_urt2
    Private write_dmu_rst_urt1_value
    Private read_dmu_rst_urt1_value
    Private flag_dmu_rst_urt1
    Private write_dmu_rst_urt0_value
    Private read_dmu_rst_urt0_value
    Private flag_dmu_rst_urt0
    Private write_dmu_rst_umc_value
    Private read_dmu_rst_umc_value
    Private flag_dmu_rst_umc
    Private write_dmu_rst_tpb_value
    Private read_dmu_rst_tpb_value
    Private flag_dmu_rst_tpb
    Private write_dmu_rst_tim4_value
    Private read_dmu_rst_tim4_value
    Private flag_dmu_rst_tim4
    Private write_dmu_rst_tim3_value
    Private read_dmu_rst_tim3_value
    Private flag_dmu_rst_tim3
    Private write_dmu_rst_tim2_value
    Private read_dmu_rst_tim2_value
    Private flag_dmu_rst_tim2
    Private write_dmu_rst_tim1_value
    Private read_dmu_rst_tim1_value
    Private flag_dmu_rst_tim1
    Private write_dmu_rst_tim0_value
    Private read_dmu_rst_tim0_value
    Private flag_dmu_rst_tim0
    Private write_dmu_rst_spl_value
    Private read_dmu_rst_spl_value
    Private flag_dmu_rst_spl
    Private write_dmu_rst_qspi_value
    Private read_dmu_rst_qspi_value
    Private flag_dmu_rst_qspi
    Private write_dmu_rst_spi10t1s_value
    Private read_dmu_rst_spi10t1s_value
    Private flag_dmu_rst_spi10t1s
    Private write_dmu_rst_spi1_value
    Private read_dmu_rst_spi1_value
    Private flag_dmu_rst_spi1
    Private write_dmu_rst_spi0_value
    Private read_dmu_rst_spi0_value
    Private flag_dmu_rst_spi0
    Private write_dmu_rst_smu_value
    Private read_dmu_rst_smu_value
    Private flag_dmu_rst_smu
    Private write_dmu_rst_smc_value
    Private read_dmu_rst_smc_value
    Private flag_dmu_rst_smc
    Private write_dmu_rst_sdma_value
    Private read_dmu_rst_sdma_value
    Private flag_dmu_rst_sdma
    Private write_dmu_rst_sdm1_value
    Private read_dmu_rst_sdm1_value
    Private flag_dmu_rst_sdm1
    Private write_dmu_rst_sdm0_value
    Private read_dmu_rst_sdm0_value
    Private flag_dmu_rst_sdm0
    Private write_dmu_rst_sci1_value
    Private read_dmu_rst_sci1_value
    Private flag_dmu_rst_sci1

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H9c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_dmu_rst_ram
        get_dmu_rst_ram = read_dmu_rst_ram_value
    End Property

    Property Let set_dmu_rst_ram(aData)
        write_dmu_rst_ram_value = aData
        flag_dmu_rst_ram        = &H1
    End Property

    Property Get read_dmu_rst_ram
        read
        read_dmu_rst_ram = read_dmu_rst_ram_value
    End Property

    Property Let write_dmu_rst_ram(aData)
        set_dmu_rst_ram = aData
        write
    End Property

    Property Get get_dmu_rst_wdt
        get_dmu_rst_wdt = read_dmu_rst_wdt_value
    End Property

    Property Let set_dmu_rst_wdt(aData)
        write_dmu_rst_wdt_value = aData
        flag_dmu_rst_wdt        = &H1
    End Property

    Property Get read_dmu_rst_wdt
        read
        read_dmu_rst_wdt = read_dmu_rst_wdt_value
    End Property

    Property Let write_dmu_rst_wdt(aData)
        set_dmu_rst_wdt = aData
        write
    End Property

    Property Get get_dmu_rst_usb2
        get_dmu_rst_usb2 = read_dmu_rst_usb2_value
    End Property

    Property Let set_dmu_rst_usb2(aData)
        write_dmu_rst_usb2_value = aData
        flag_dmu_rst_usb2        = &H1
    End Property

    Property Get read_dmu_rst_usb2
        read
        read_dmu_rst_usb2 = read_dmu_rst_usb2_value
    End Property

    Property Let write_dmu_rst_usb2(aData)
        set_dmu_rst_usb2 = aData
        write
    End Property

    Property Get get_dmu_rst_usb1
        get_dmu_rst_usb1 = read_dmu_rst_usb1_value
    End Property

    Property Let set_dmu_rst_usb1(aData)
        write_dmu_rst_usb1_value = aData
        flag_dmu_rst_usb1        = &H1
    End Property

    Property Get read_dmu_rst_usb1
        read
        read_dmu_rst_usb1 = read_dmu_rst_usb1_value
    End Property

    Property Let write_dmu_rst_usb1(aData)
        set_dmu_rst_usb1 = aData
        write
    End Property

    Property Get get_dmu_rst_usb0
        get_dmu_rst_usb0 = read_dmu_rst_usb0_value
    End Property

    Property Let set_dmu_rst_usb0(aData)
        write_dmu_rst_usb0_value = aData
        flag_dmu_rst_usb0        = &H1
    End Property

    Property Get read_dmu_rst_usb0
        read
        read_dmu_rst_usb0 = read_dmu_rst_usb0_value
    End Property

    Property Let write_dmu_rst_usb0(aData)
        set_dmu_rst_usb0 = aData
        write
    End Property

    Property Get get_dmu_rst_urt3
        get_dmu_rst_urt3 = read_dmu_rst_urt3_value
    End Property

    Property Let set_dmu_rst_urt3(aData)
        write_dmu_rst_urt3_value = aData
        flag_dmu_rst_urt3        = &H1
    End Property

    Property Get read_dmu_rst_urt3
        read
        read_dmu_rst_urt3 = read_dmu_rst_urt3_value
    End Property

    Property Let write_dmu_rst_urt3(aData)
        set_dmu_rst_urt3 = aData
        write
    End Property

    Property Get get_dmu_rst_urt2
        get_dmu_rst_urt2 = read_dmu_rst_urt2_value
    End Property

    Property Let set_dmu_rst_urt2(aData)
        write_dmu_rst_urt2_value = aData
        flag_dmu_rst_urt2        = &H1
    End Property

    Property Get read_dmu_rst_urt2
        read
        read_dmu_rst_urt2 = read_dmu_rst_urt2_value
    End Property

    Property Let write_dmu_rst_urt2(aData)
        set_dmu_rst_urt2 = aData
        write
    End Property

    Property Get get_dmu_rst_urt1
        get_dmu_rst_urt1 = read_dmu_rst_urt1_value
    End Property

    Property Let set_dmu_rst_urt1(aData)
        write_dmu_rst_urt1_value = aData
        flag_dmu_rst_urt1        = &H1
    End Property

    Property Get read_dmu_rst_urt1
        read
        read_dmu_rst_urt1 = read_dmu_rst_urt1_value
    End Property

    Property Let write_dmu_rst_urt1(aData)
        set_dmu_rst_urt1 = aData
        write
    End Property

    Property Get get_dmu_rst_urt0
        get_dmu_rst_urt0 = read_dmu_rst_urt0_value
    End Property

    Property Let set_dmu_rst_urt0(aData)
        write_dmu_rst_urt0_value = aData
        flag_dmu_rst_urt0        = &H1
    End Property

    Property Get read_dmu_rst_urt0
        read
        read_dmu_rst_urt0 = read_dmu_rst_urt0_value
    End Property

    Property Let write_dmu_rst_urt0(aData)
        set_dmu_rst_urt0 = aData
        write
    End Property

    Property Get get_dmu_rst_umc
        get_dmu_rst_umc = read_dmu_rst_umc_value
    End Property

    Property Let set_dmu_rst_umc(aData)
        write_dmu_rst_umc_value = aData
        flag_dmu_rst_umc        = &H1
    End Property

    Property Get read_dmu_rst_umc
        read
        read_dmu_rst_umc = read_dmu_rst_umc_value
    End Property

    Property Let write_dmu_rst_umc(aData)
        set_dmu_rst_umc = aData
        write
    End Property

    Property Get get_dmu_rst_tpb
        get_dmu_rst_tpb = read_dmu_rst_tpb_value
    End Property

    Property Let set_dmu_rst_tpb(aData)
        write_dmu_rst_tpb_value = aData
        flag_dmu_rst_tpb        = &H1
    End Property

    Property Get read_dmu_rst_tpb
        read
        read_dmu_rst_tpb = read_dmu_rst_tpb_value
    End Property

    Property Let write_dmu_rst_tpb(aData)
        set_dmu_rst_tpb = aData
        write
    End Property

    Property Get get_dmu_rst_tim4
        get_dmu_rst_tim4 = read_dmu_rst_tim4_value
    End Property

    Property Let set_dmu_rst_tim4(aData)
        write_dmu_rst_tim4_value = aData
        flag_dmu_rst_tim4        = &H1
    End Property

    Property Get read_dmu_rst_tim4
        read
        read_dmu_rst_tim4 = read_dmu_rst_tim4_value
    End Property

    Property Let write_dmu_rst_tim4(aData)
        set_dmu_rst_tim4 = aData
        write
    End Property

    Property Get get_dmu_rst_tim3
        get_dmu_rst_tim3 = read_dmu_rst_tim3_value
    End Property

    Property Let set_dmu_rst_tim3(aData)
        write_dmu_rst_tim3_value = aData
        flag_dmu_rst_tim3        = &H1
    End Property

    Property Get read_dmu_rst_tim3
        read
        read_dmu_rst_tim3 = read_dmu_rst_tim3_value
    End Property

    Property Let write_dmu_rst_tim3(aData)
        set_dmu_rst_tim3 = aData
        write
    End Property

    Property Get get_dmu_rst_tim2
        get_dmu_rst_tim2 = read_dmu_rst_tim2_value
    End Property

    Property Let set_dmu_rst_tim2(aData)
        write_dmu_rst_tim2_value = aData
        flag_dmu_rst_tim2        = &H1
    End Property

    Property Get read_dmu_rst_tim2
        read
        read_dmu_rst_tim2 = read_dmu_rst_tim2_value
    End Property

    Property Let write_dmu_rst_tim2(aData)
        set_dmu_rst_tim2 = aData
        write
    End Property

    Property Get get_dmu_rst_tim1
        get_dmu_rst_tim1 = read_dmu_rst_tim1_value
    End Property

    Property Let set_dmu_rst_tim1(aData)
        write_dmu_rst_tim1_value = aData
        flag_dmu_rst_tim1        = &H1
    End Property

    Property Get read_dmu_rst_tim1
        read
        read_dmu_rst_tim1 = read_dmu_rst_tim1_value
    End Property

    Property Let write_dmu_rst_tim1(aData)
        set_dmu_rst_tim1 = aData
        write
    End Property

    Property Get get_dmu_rst_tim0
        get_dmu_rst_tim0 = read_dmu_rst_tim0_value
    End Property

    Property Let set_dmu_rst_tim0(aData)
        write_dmu_rst_tim0_value = aData
        flag_dmu_rst_tim0        = &H1
    End Property

    Property Get read_dmu_rst_tim0
        read
        read_dmu_rst_tim0 = read_dmu_rst_tim0_value
    End Property

    Property Let write_dmu_rst_tim0(aData)
        set_dmu_rst_tim0 = aData
        write
    End Property

    Property Get get_dmu_rst_spl
        get_dmu_rst_spl = read_dmu_rst_spl_value
    End Property

    Property Let set_dmu_rst_spl(aData)
        write_dmu_rst_spl_value = aData
        flag_dmu_rst_spl        = &H1
    End Property

    Property Get read_dmu_rst_spl
        read
        read_dmu_rst_spl = read_dmu_rst_spl_value
    End Property

    Property Let write_dmu_rst_spl(aData)
        set_dmu_rst_spl = aData
        write
    End Property

    Property Get get_dmu_rst_qspi
        get_dmu_rst_qspi = read_dmu_rst_qspi_value
    End Property

    Property Let set_dmu_rst_qspi(aData)
        write_dmu_rst_qspi_value = aData
        flag_dmu_rst_qspi        = &H1
    End Property

    Property Get read_dmu_rst_qspi
        read
        read_dmu_rst_qspi = read_dmu_rst_qspi_value
    End Property

    Property Let write_dmu_rst_qspi(aData)
        set_dmu_rst_qspi = aData
        write
    End Property

    Property Get get_dmu_rst_spi10t1s
        get_dmu_rst_spi10t1s = read_dmu_rst_spi10t1s_value
    End Property

    Property Let set_dmu_rst_spi10t1s(aData)
        write_dmu_rst_spi10t1s_value = aData
        flag_dmu_rst_spi10t1s        = &H1
    End Property

    Property Get read_dmu_rst_spi10t1s
        read
        read_dmu_rst_spi10t1s = read_dmu_rst_spi10t1s_value
    End Property

    Property Let write_dmu_rst_spi10t1s(aData)
        set_dmu_rst_spi10t1s = aData
        write
    End Property

    Property Get get_dmu_rst_spi1
        get_dmu_rst_spi1 = read_dmu_rst_spi1_value
    End Property

    Property Let set_dmu_rst_spi1(aData)
        write_dmu_rst_spi1_value = aData
        flag_dmu_rst_spi1        = &H1
    End Property

    Property Get read_dmu_rst_spi1
        read
        read_dmu_rst_spi1 = read_dmu_rst_spi1_value
    End Property

    Property Let write_dmu_rst_spi1(aData)
        set_dmu_rst_spi1 = aData
        write
    End Property

    Property Get get_dmu_rst_spi0
        get_dmu_rst_spi0 = read_dmu_rst_spi0_value
    End Property

    Property Let set_dmu_rst_spi0(aData)
        write_dmu_rst_spi0_value = aData
        flag_dmu_rst_spi0        = &H1
    End Property

    Property Get read_dmu_rst_spi0
        read
        read_dmu_rst_spi0 = read_dmu_rst_spi0_value
    End Property

    Property Let write_dmu_rst_spi0(aData)
        set_dmu_rst_spi0 = aData
        write
    End Property

    Property Get get_dmu_rst_smu
        get_dmu_rst_smu = read_dmu_rst_smu_value
    End Property

    Property Let set_dmu_rst_smu(aData)
        write_dmu_rst_smu_value = aData
        flag_dmu_rst_smu        = &H1
    End Property

    Property Get read_dmu_rst_smu
        read
        read_dmu_rst_smu = read_dmu_rst_smu_value
    End Property

    Property Let write_dmu_rst_smu(aData)
        set_dmu_rst_smu = aData
        write
    End Property

    Property Get get_dmu_rst_smc
        get_dmu_rst_smc = read_dmu_rst_smc_value
    End Property

    Property Let set_dmu_rst_smc(aData)
        write_dmu_rst_smc_value = aData
        flag_dmu_rst_smc        = &H1
    End Property

    Property Get read_dmu_rst_smc
        read
        read_dmu_rst_smc = read_dmu_rst_smc_value
    End Property

    Property Let write_dmu_rst_smc(aData)
        set_dmu_rst_smc = aData
        write
    End Property

    Property Get get_dmu_rst_sdma
        get_dmu_rst_sdma = read_dmu_rst_sdma_value
    End Property

    Property Let set_dmu_rst_sdma(aData)
        write_dmu_rst_sdma_value = aData
        flag_dmu_rst_sdma        = &H1
    End Property

    Property Get read_dmu_rst_sdma
        read
        read_dmu_rst_sdma = read_dmu_rst_sdma_value
    End Property

    Property Let write_dmu_rst_sdma(aData)
        set_dmu_rst_sdma = aData
        write
    End Property

    Property Get get_dmu_rst_sdm1
        get_dmu_rst_sdm1 = read_dmu_rst_sdm1_value
    End Property

    Property Let set_dmu_rst_sdm1(aData)
        write_dmu_rst_sdm1_value = aData
        flag_dmu_rst_sdm1        = &H1
    End Property

    Property Get read_dmu_rst_sdm1
        read
        read_dmu_rst_sdm1 = read_dmu_rst_sdm1_value
    End Property

    Property Let write_dmu_rst_sdm1(aData)
        set_dmu_rst_sdm1 = aData
        write
    End Property

    Property Get get_dmu_rst_sdm0
        get_dmu_rst_sdm0 = read_dmu_rst_sdm0_value
    End Property

    Property Let set_dmu_rst_sdm0(aData)
        write_dmu_rst_sdm0_value = aData
        flag_dmu_rst_sdm0        = &H1
    End Property

    Property Get read_dmu_rst_sdm0
        read
        read_dmu_rst_sdm0 = read_dmu_rst_sdm0_value
    End Property

    Property Let write_dmu_rst_sdm0(aData)
        set_dmu_rst_sdm0 = aData
        write
    End Property

    Property Get get_dmu_rst_sci1
        get_dmu_rst_sci1 = read_dmu_rst_sci1_value
    End Property

    Property Let set_dmu_rst_sci1(aData)
        write_dmu_rst_sci1_value = aData
        flag_dmu_rst_sci1        = &H1
    End Property

    Property Get read_dmu_rst_sci1
        read
        read_dmu_rst_sci1 = read_dmu_rst_sci1_value
    End Property

    Property Let write_dmu_rst_sci1(aData)
        set_dmu_rst_sci1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_dmu_rst_ram_value = rightShift(data_low, 26) and &H1
        read_dmu_rst_wdt_value = rightShift(data_low, 25) and &H1
        read_dmu_rst_usb2_value = rightShift(data_low, 24) and &H1
        read_dmu_rst_usb1_value = rightShift(data_low, 23) and &H1
        read_dmu_rst_usb0_value = rightShift(data_low, 22) and &H1
        read_dmu_rst_urt3_value = rightShift(data_low, 21) and &H1
        read_dmu_rst_urt2_value = rightShift(data_low, 20) and &H1
        read_dmu_rst_urt1_value = rightShift(data_low, 19) and &H1
        read_dmu_rst_urt0_value = rightShift(data_low, 18) and &H1
        read_dmu_rst_umc_value = rightShift(data_low, 17) and &H1
        read_dmu_rst_tpb_value = rightShift(data_low, 16) and &H1
        read_dmu_rst_tim4_value = rightShift(data_low, 15) and &H1
        read_dmu_rst_tim3_value = rightShift(data_low, 14) and &H1
        read_dmu_rst_tim2_value = rightShift(data_low, 13) and &H1
        read_dmu_rst_tim1_value = rightShift(data_low, 12) and &H1
        read_dmu_rst_tim0_value = rightShift(data_low, 11) and &H1
        read_dmu_rst_spl_value = rightShift(data_low, 10) and &H1
        read_dmu_rst_qspi_value = rightShift(data_low, 9) and &H1
        read_dmu_rst_spi10t1s_value = rightShift(data_low, 8) and &H1
        read_dmu_rst_spi1_value = rightShift(data_low, 7) and &H1
        read_dmu_rst_spi0_value = rightShift(data_low, 6) and &H1
        read_dmu_rst_smu_value = rightShift(data_low, 5) and &H1
        read_dmu_rst_smc_value = rightShift(data_low, 4) and &H1
        read_dmu_rst_sdma_value = rightShift(data_low, 3) and &H1
        read_dmu_rst_sdm1_value = rightShift(data_low, 2) and &H1
        read_dmu_rst_sdm0_value = rightShift(data_low, 1) and &H1
        dmu_rst_sci1_mask = &H1
        if data_low > LONG_MAX then
            if dmu_rst_sci1_mask = mask then
                read_dmu_rst_sci1_value = data_low
            else
                read_dmu_rst_sci1_value = (data_low - H8000_0000) and dmu_rst_sci1_mask
            end If
        else
            read_dmu_rst_sci1_value = data_low and dmu_rst_sci1_mask
        end If

    End Sub

    Sub write
        If flag_dmu_rst_ram = &H0 or flag_dmu_rst_wdt = &H0 or flag_dmu_rst_usb2 = &H0 or flag_dmu_rst_usb1 = &H0 or flag_dmu_rst_usb0 = &H0 or flag_dmu_rst_urt3 = &H0 or flag_dmu_rst_urt2 = &H0 or flag_dmu_rst_urt1 = &H0 or flag_dmu_rst_urt0 = &H0 or flag_dmu_rst_umc = &H0 or flag_dmu_rst_tpb = &H0 or flag_dmu_rst_tim4 = &H0 or flag_dmu_rst_tim3 = &H0 or flag_dmu_rst_tim2 = &H0 or flag_dmu_rst_tim1 = &H0 or flag_dmu_rst_tim0 = &H0 or flag_dmu_rst_spl = &H0 or flag_dmu_rst_qspi = &H0 or flag_dmu_rst_spi10t1s = &H0 or flag_dmu_rst_spi1 = &H0 or flag_dmu_rst_spi0 = &H0 or flag_dmu_rst_smu = &H0 or flag_dmu_rst_smc = &H0 or flag_dmu_rst_sdma = &H0 or flag_dmu_rst_sdm1 = &H0 or flag_dmu_rst_sdm0 = &H0 or flag_dmu_rst_sci1 = &H0 Then read
        If flag_dmu_rst_ram = &H0 Then write_dmu_rst_ram_value = get_dmu_rst_ram
        If flag_dmu_rst_wdt = &H0 Then write_dmu_rst_wdt_value = get_dmu_rst_wdt
        If flag_dmu_rst_usb2 = &H0 Then write_dmu_rst_usb2_value = get_dmu_rst_usb2
        If flag_dmu_rst_usb1 = &H0 Then write_dmu_rst_usb1_value = get_dmu_rst_usb1
        If flag_dmu_rst_usb0 = &H0 Then write_dmu_rst_usb0_value = get_dmu_rst_usb0
        If flag_dmu_rst_urt3 = &H0 Then write_dmu_rst_urt3_value = get_dmu_rst_urt3
        If flag_dmu_rst_urt2 = &H0 Then write_dmu_rst_urt2_value = get_dmu_rst_urt2
        If flag_dmu_rst_urt1 = &H0 Then write_dmu_rst_urt1_value = get_dmu_rst_urt1
        If flag_dmu_rst_urt0 = &H0 Then write_dmu_rst_urt0_value = get_dmu_rst_urt0
        If flag_dmu_rst_umc = &H0 Then write_dmu_rst_umc_value = get_dmu_rst_umc
        If flag_dmu_rst_tpb = &H0 Then write_dmu_rst_tpb_value = get_dmu_rst_tpb
        If flag_dmu_rst_tim4 = &H0 Then write_dmu_rst_tim4_value = get_dmu_rst_tim4
        If flag_dmu_rst_tim3 = &H0 Then write_dmu_rst_tim3_value = get_dmu_rst_tim3
        If flag_dmu_rst_tim2 = &H0 Then write_dmu_rst_tim2_value = get_dmu_rst_tim2
        If flag_dmu_rst_tim1 = &H0 Then write_dmu_rst_tim1_value = get_dmu_rst_tim1
        If flag_dmu_rst_tim0 = &H0 Then write_dmu_rst_tim0_value = get_dmu_rst_tim0
        If flag_dmu_rst_spl = &H0 Then write_dmu_rst_spl_value = get_dmu_rst_spl
        If flag_dmu_rst_qspi = &H0 Then write_dmu_rst_qspi_value = get_dmu_rst_qspi
        If flag_dmu_rst_spi10t1s = &H0 Then write_dmu_rst_spi10t1s_value = get_dmu_rst_spi10t1s
        If flag_dmu_rst_spi1 = &H0 Then write_dmu_rst_spi1_value = get_dmu_rst_spi1
        If flag_dmu_rst_spi0 = &H0 Then write_dmu_rst_spi0_value = get_dmu_rst_spi0
        If flag_dmu_rst_smu = &H0 Then write_dmu_rst_smu_value = get_dmu_rst_smu
        If flag_dmu_rst_smc = &H0 Then write_dmu_rst_smc_value = get_dmu_rst_smc
        If flag_dmu_rst_sdma = &H0 Then write_dmu_rst_sdma_value = get_dmu_rst_sdma
        If flag_dmu_rst_sdm1 = &H0 Then write_dmu_rst_sdm1_value = get_dmu_rst_sdm1
        If flag_dmu_rst_sdm0 = &H0 Then write_dmu_rst_sdm0_value = get_dmu_rst_sdm0
        If flag_dmu_rst_sci1 = &H0 Then write_dmu_rst_sci1_value = get_dmu_rst_sci1

        regValue = leftShift((write_dmu_rst_ram_value and &H1), 26) + leftShift((write_dmu_rst_wdt_value and &H1), 25) + leftShift((write_dmu_rst_usb2_value and &H1), 24) + leftShift((write_dmu_rst_usb1_value and &H1), 23) + leftShift((write_dmu_rst_usb0_value and &H1), 22) + leftShift((write_dmu_rst_urt3_value and &H1), 21) + leftShift((write_dmu_rst_urt2_value and &H1), 20) + leftShift((write_dmu_rst_urt1_value and &H1), 19) + leftShift((write_dmu_rst_urt0_value and &H1), 18) + leftShift((write_dmu_rst_umc_value and &H1), 17) + leftShift((write_dmu_rst_tpb_value and &H1), 16) + leftShift((write_dmu_rst_tim4_value and &H1), 15) + leftShift((write_dmu_rst_tim3_value and &H1), 14) + leftShift((write_dmu_rst_tim2_value and &H1), 13) + leftShift((write_dmu_rst_tim1_value and &H1), 12) + leftShift((write_dmu_rst_tim0_value and &H1), 11) + leftShift((write_dmu_rst_spl_value and &H1), 10) + leftShift((write_dmu_rst_qspi_value and &H1), 9) + leftShift((write_dmu_rst_spi10t1s_value and &H1), 8) + leftShift((write_dmu_rst_spi1_value and &H1), 7) + leftShift((write_dmu_rst_spi0_value and &H1), 6) + leftShift((write_dmu_rst_smu_value and &H1), 5) + leftShift((write_dmu_rst_smc_value and &H1), 4) + leftShift((write_dmu_rst_sdma_value and &H1), 3) + leftShift((write_dmu_rst_sdm1_value and &H1), 2) + leftShift((write_dmu_rst_sdm0_value and &H1), 1) + leftShift((write_dmu_rst_sci1_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_dmu_rst_ram_value = rightShift(data_low, 26) and &H1
        read_dmu_rst_wdt_value = rightShift(data_low, 25) and &H1
        read_dmu_rst_usb2_value = rightShift(data_low, 24) and &H1
        read_dmu_rst_usb1_value = rightShift(data_low, 23) and &H1
        read_dmu_rst_usb0_value = rightShift(data_low, 22) and &H1
        read_dmu_rst_urt3_value = rightShift(data_low, 21) and &H1
        read_dmu_rst_urt2_value = rightShift(data_low, 20) and &H1
        read_dmu_rst_urt1_value = rightShift(data_low, 19) and &H1
        read_dmu_rst_urt0_value = rightShift(data_low, 18) and &H1
        read_dmu_rst_umc_value = rightShift(data_low, 17) and &H1
        read_dmu_rst_tpb_value = rightShift(data_low, 16) and &H1
        read_dmu_rst_tim4_value = rightShift(data_low, 15) and &H1
        read_dmu_rst_tim3_value = rightShift(data_low, 14) and &H1
        read_dmu_rst_tim2_value = rightShift(data_low, 13) and &H1
        read_dmu_rst_tim1_value = rightShift(data_low, 12) and &H1
        read_dmu_rst_tim0_value = rightShift(data_low, 11) and &H1
        read_dmu_rst_spl_value = rightShift(data_low, 10) and &H1
        read_dmu_rst_qspi_value = rightShift(data_low, 9) and &H1
        read_dmu_rst_spi10t1s_value = rightShift(data_low, 8) and &H1
        read_dmu_rst_spi1_value = rightShift(data_low, 7) and &H1
        read_dmu_rst_spi0_value = rightShift(data_low, 6) and &H1
        read_dmu_rst_smu_value = rightShift(data_low, 5) and &H1
        read_dmu_rst_smc_value = rightShift(data_low, 4) and &H1
        read_dmu_rst_sdma_value = rightShift(data_low, 3) and &H1
        read_dmu_rst_sdm1_value = rightShift(data_low, 2) and &H1
        read_dmu_rst_sdm0_value = rightShift(data_low, 1) and &H1
        dmu_rst_sci1_mask = &H1
        if data_low > LONG_MAX then
            if dmu_rst_sci1_mask = mask then
                read_dmu_rst_sci1_value = data_low
            else
                read_dmu_rst_sci1_value = (data_low - H8000_0000) and dmu_rst_sci1_mask
            end If
        else
            read_dmu_rst_sci1_value = data_low and dmu_rst_sci1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_dmu_rst_ram_value = &H0
        flag_dmu_rst_ram        = &H0
        write_dmu_rst_wdt_value = &H0
        flag_dmu_rst_wdt        = &H0
        write_dmu_rst_usb2_value = &H0
        flag_dmu_rst_usb2        = &H0
        write_dmu_rst_usb1_value = &H0
        flag_dmu_rst_usb1        = &H0
        write_dmu_rst_usb0_value = &H0
        flag_dmu_rst_usb0        = &H0
        write_dmu_rst_urt3_value = &H0
        flag_dmu_rst_urt3        = &H0
        write_dmu_rst_urt2_value = &H0
        flag_dmu_rst_urt2        = &H0
        write_dmu_rst_urt1_value = &H0
        flag_dmu_rst_urt1        = &H0
        write_dmu_rst_urt0_value = &H0
        flag_dmu_rst_urt0        = &H0
        write_dmu_rst_umc_value = &H0
        flag_dmu_rst_umc        = &H0
        write_dmu_rst_tpb_value = &H0
        flag_dmu_rst_tpb        = &H0
        write_dmu_rst_tim4_value = &H0
        flag_dmu_rst_tim4        = &H0
        write_dmu_rst_tim3_value = &H0
        flag_dmu_rst_tim3        = &H0
        write_dmu_rst_tim2_value = &H0
        flag_dmu_rst_tim2        = &H0
        write_dmu_rst_tim1_value = &H0
        flag_dmu_rst_tim1        = &H0
        write_dmu_rst_tim0_value = &H0
        flag_dmu_rst_tim0        = &H0
        write_dmu_rst_spl_value = &H0
        flag_dmu_rst_spl        = &H0
        write_dmu_rst_qspi_value = &H0
        flag_dmu_rst_qspi        = &H0
        write_dmu_rst_spi10t1s_value = &H0
        flag_dmu_rst_spi10t1s        = &H0
        write_dmu_rst_spi1_value = &H0
        flag_dmu_rst_spi1        = &H0
        write_dmu_rst_spi0_value = &H0
        flag_dmu_rst_spi0        = &H0
        write_dmu_rst_smu_value = &H0
        flag_dmu_rst_smu        = &H0
        write_dmu_rst_smc_value = &H0
        flag_dmu_rst_smc        = &H0
        write_dmu_rst_sdma_value = &H0
        flag_dmu_rst_sdma        = &H0
        write_dmu_rst_sdm1_value = &H0
        flag_dmu_rst_sdm1        = &H0
        write_dmu_rst_sdm0_value = &H0
        flag_dmu_rst_sdm0        = &H0
        write_dmu_rst_sci1_value = &H0
        flag_dmu_rst_sci1        = &H0
    End Sub
End Class


'' @REGISTER : DMU_dmu_pwd_blk1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' dmu_pwd_sci0                               [31:31]          get_dmu_pwd_sci0
''                                                             set_dmu_pwd_sci0
''                                                             read_dmu_pwd_sci0
''                                                             write_dmu_pwd_sci0
''---------------------------------------------------------------------------------
'' dmu_pwd_rom                                [30:30]          get_dmu_pwd_rom
''                                                             set_dmu_pwd_rom
''                                                             read_dmu_pwd_rom
''                                                             write_dmu_pwd_rom
''---------------------------------------------------------------------------------
'' dmu_pwd_rng                                [29:29]          get_dmu_pwd_rng
''                                                             set_dmu_pwd_rng
''                                                             read_dmu_pwd_rng
''                                                             write_dmu_pwd_rng
''---------------------------------------------------------------------------------
'' dmu_pwd_pwm                                [28:28]          get_dmu_pwd_pwm
''                                                             set_dmu_pwd_pwm
''                                                             read_dmu_pwd_pwm
''                                                             write_dmu_pwd_pwm
''---------------------------------------------------------------------------------
'' dmu_pwd_pka                                [27:27]          get_dmu_pwd_pka
''                                                             set_dmu_pwd_pka
''                                                             read_dmu_pwd_pka
''                                                             write_dmu_pwd_pka
''---------------------------------------------------------------------------------
'' dmu_pwd_pbz                                [26:26]          get_dmu_pwd_pbz
''                                                             set_dmu_pwd_pbz
''                                                             read_dmu_pwd_pbz
''                                                             write_dmu_pwd_pbz
''---------------------------------------------------------------------------------
'' dmu_pwd_pby                                [25:25]          get_dmu_pwd_pby
''                                                             set_dmu_pwd_pby
''                                                             read_dmu_pwd_pby
''                                                             write_dmu_pwd_pby
''---------------------------------------------------------------------------------
'' dmu_pwd_pbx                                [24:24]          get_dmu_pwd_pbx
''                                                             set_dmu_pwd_pbx
''                                                             read_dmu_pwd_pbx
''                                                             write_dmu_pwd_pbx
''---------------------------------------------------------------------------------
'' dmu_pwd_odma                               [23:23]          get_dmu_pwd_odma
''                                                             set_dmu_pwd_odma
''                                                             read_dmu_pwd_odma
''                                                             write_dmu_pwd_odma
''---------------------------------------------------------------------------------
'' dmu_pwd_nvm                                [22:22]          get_dmu_pwd_nvm
''                                                             set_dmu_pwd_nvm
''                                                             read_dmu_pwd_nvm
''                                                             write_dmu_pwd_nvm
''---------------------------------------------------------------------------------
'' dmu_pwd_msr                                [21:21]          get_dmu_pwd_msr
''                                                             set_dmu_pwd_msr
''                                                             read_dmu_pwd_msr
''                                                             write_dmu_pwd_msr
''---------------------------------------------------------------------------------
'' dmu_pwd_mmi                                [20:20]          get_dmu_pwd_mmi
''                                                             set_dmu_pwd_mmi
''                                                             read_dmu_pwd_mmi
''                                                             write_dmu_pwd_mmi
''---------------------------------------------------------------------------------
'' dmu_pwd_mem                                [19:19]          get_dmu_pwd_mem
''                                                             set_dmu_pwd_mem
''                                                             read_dmu_pwd_mem
''                                                             write_dmu_pwd_mem
''---------------------------------------------------------------------------------
'' dmu_pwd_lcd                                [18:18]          get_dmu_pwd_lcd
''                                                             set_dmu_pwd_lcd
''                                                             read_dmu_pwd_lcd
''                                                             write_dmu_pwd_lcd
''---------------------------------------------------------------------------------
'' dmu_pwd_i2s                                [17:17]          get_dmu_pwd_i2s
''                                                             set_dmu_pwd_i2s
''                                                             read_dmu_pwd_i2s
''                                                             write_dmu_pwd_i2s
''---------------------------------------------------------------------------------
'' dmu_pwd_i2c1                               [16:16]          get_dmu_pwd_i2c1
''                                                             set_dmu_pwd_i2c1
''                                                             read_dmu_pwd_i2c1
''                                                             write_dmu_pwd_i2c1
''---------------------------------------------------------------------------------
'' dmu_pwd_i2c0                               [15:15]          get_dmu_pwd_i2c0
''                                                             set_dmu_pwd_i2c0
''                                                             read_dmu_pwd_i2c0
''                                                             write_dmu_pwd_i2c0
''---------------------------------------------------------------------------------
'' dmu_pwd_gio4                               [14:14]          get_dmu_pwd_gio4
''                                                             set_dmu_pwd_gio4
''                                                             read_dmu_pwd_gio4
''                                                             write_dmu_pwd_gio4
''---------------------------------------------------------------------------------
'' dmu_pwd_gio3                               [13:13]          get_dmu_pwd_gio3
''                                                             set_dmu_pwd_gio3
''                                                             read_dmu_pwd_gio3
''                                                             write_dmu_pwd_gio3
''---------------------------------------------------------------------------------
'' dmu_pwd_gio2                               [12:12]          get_dmu_pwd_gio2
''                                                             set_dmu_pwd_gio2
''                                                             read_dmu_pwd_gio2
''                                                             write_dmu_pwd_gio2
''---------------------------------------------------------------------------------
'' dmu_pwd_gio1                               [11:11]          get_dmu_pwd_gio1
''                                                             set_dmu_pwd_gio1
''                                                             read_dmu_pwd_gio1
''                                                             write_dmu_pwd_gio1
''---------------------------------------------------------------------------------
'' dmu_pwd_gio0                               [10:10]          get_dmu_pwd_gio0
''                                                             set_dmu_pwd_gio0
''                                                             read_dmu_pwd_gio0
''                                                             write_dmu_pwd_gio0
''---------------------------------------------------------------------------------
'' dmu_pwd_etm                                [9:9]            get_dmu_pwd_etm
''                                                             set_dmu_pwd_etm
''                                                             read_dmu_pwd_etm
''                                                             write_dmu_pwd_etm
''---------------------------------------------------------------------------------
'' dmu_pwd_eth                                [8:8]            get_dmu_pwd_eth
''                                                             set_dmu_pwd_eth
''                                                             read_dmu_pwd_eth
''                                                             write_dmu_pwd_eth
''---------------------------------------------------------------------------------
'' dmu_pwd_dec                                [7:7]            get_dmu_pwd_dec
''                                                             set_dmu_pwd_dec
''                                                             read_dmu_pwd_dec
''                                                             write_dmu_pwd_dec
''---------------------------------------------------------------------------------
'' dmu_pwd_ddr                                [6:6]            get_dmu_pwd_ddr
''                                                             set_dmu_pwd_ddr
''                                                             read_dmu_pwd_ddr
''                                                             write_dmu_pwd_ddr
''---------------------------------------------------------------------------------
'' dmu_pwd_dac                                [5:5]            get_dmu_pwd_dac
''                                                             set_dmu_pwd_dac
''                                                             read_dmu_pwd_dac
''                                                             write_dmu_pwd_dac
''---------------------------------------------------------------------------------
'' dmu_pwd_d1w                                [4:4]            get_dmu_pwd_d1w
''                                                             set_dmu_pwd_d1w
''                                                             read_dmu_pwd_d1w
''                                                             write_dmu_pwd_d1w
''---------------------------------------------------------------------------------
'' dmu_pwd_cfg                                [3:3]            get_dmu_pwd_cfg
''                                                             set_dmu_pwd_cfg
''                                                             read_dmu_pwd_cfg
''                                                             write_dmu_pwd_cfg
''---------------------------------------------------------------------------------
'' dmu_pwd_bbl                                [2:2]            get_dmu_pwd_bbl
''                                                             set_dmu_pwd_bbl
''                                                             read_dmu_pwd_bbl
''                                                             write_dmu_pwd_bbl
''---------------------------------------------------------------------------------
'' dmu_pwd_adc1                               [1:1]            get_dmu_pwd_adc1
''                                                             set_dmu_pwd_adc1
''                                                             read_dmu_pwd_adc1
''                                                             write_dmu_pwd_adc1
''---------------------------------------------------------------------------------
'' dmu_pwd_adc0                               [0:0]            get_dmu_pwd_adc0
''                                                             set_dmu_pwd_adc0
''                                                             read_dmu_pwd_adc0
''                                                             write_dmu_pwd_adc0
''---------------------------------------------------------------------------------
Class REGISTER_DMU_dmu_pwd_blk1
    Private write_dmu_pwd_sci0_value
    Private read_dmu_pwd_sci0_value
    Private flag_dmu_pwd_sci0
    Private write_dmu_pwd_rom_value
    Private read_dmu_pwd_rom_value
    Private flag_dmu_pwd_rom
    Private write_dmu_pwd_rng_value
    Private read_dmu_pwd_rng_value
    Private flag_dmu_pwd_rng
    Private write_dmu_pwd_pwm_value
    Private read_dmu_pwd_pwm_value
    Private flag_dmu_pwd_pwm
    Private write_dmu_pwd_pka_value
    Private read_dmu_pwd_pka_value
    Private flag_dmu_pwd_pka
    Private write_dmu_pwd_pbz_value
    Private read_dmu_pwd_pbz_value
    Private flag_dmu_pwd_pbz
    Private write_dmu_pwd_pby_value
    Private read_dmu_pwd_pby_value
    Private flag_dmu_pwd_pby
    Private write_dmu_pwd_pbx_value
    Private read_dmu_pwd_pbx_value
    Private flag_dmu_pwd_pbx
    Private write_dmu_pwd_odma_value
    Private read_dmu_pwd_odma_value
    Private flag_dmu_pwd_odma
    Private write_dmu_pwd_nvm_value
    Private read_dmu_pwd_nvm_value
    Private flag_dmu_pwd_nvm
    Private write_dmu_pwd_msr_value
    Private read_dmu_pwd_msr_value
    Private flag_dmu_pwd_msr
    Private write_dmu_pwd_mmi_value
    Private read_dmu_pwd_mmi_value
    Private flag_dmu_pwd_mmi
    Private write_dmu_pwd_mem_value
    Private read_dmu_pwd_mem_value
    Private flag_dmu_pwd_mem
    Private write_dmu_pwd_lcd_value
    Private read_dmu_pwd_lcd_value
    Private flag_dmu_pwd_lcd
    Private write_dmu_pwd_i2s_value
    Private read_dmu_pwd_i2s_value
    Private flag_dmu_pwd_i2s
    Private write_dmu_pwd_i2c1_value
    Private read_dmu_pwd_i2c1_value
    Private flag_dmu_pwd_i2c1
    Private write_dmu_pwd_i2c0_value
    Private read_dmu_pwd_i2c0_value
    Private flag_dmu_pwd_i2c0
    Private write_dmu_pwd_gio4_value
    Private read_dmu_pwd_gio4_value
    Private flag_dmu_pwd_gio4
    Private write_dmu_pwd_gio3_value
    Private read_dmu_pwd_gio3_value
    Private flag_dmu_pwd_gio3
    Private write_dmu_pwd_gio2_value
    Private read_dmu_pwd_gio2_value
    Private flag_dmu_pwd_gio2
    Private write_dmu_pwd_gio1_value
    Private read_dmu_pwd_gio1_value
    Private flag_dmu_pwd_gio1
    Private write_dmu_pwd_gio0_value
    Private read_dmu_pwd_gio0_value
    Private flag_dmu_pwd_gio0
    Private write_dmu_pwd_etm_value
    Private read_dmu_pwd_etm_value
    Private flag_dmu_pwd_etm
    Private write_dmu_pwd_eth_value
    Private read_dmu_pwd_eth_value
    Private flag_dmu_pwd_eth
    Private write_dmu_pwd_dec_value
    Private read_dmu_pwd_dec_value
    Private flag_dmu_pwd_dec
    Private write_dmu_pwd_ddr_value
    Private read_dmu_pwd_ddr_value
    Private flag_dmu_pwd_ddr
    Private write_dmu_pwd_dac_value
    Private read_dmu_pwd_dac_value
    Private flag_dmu_pwd_dac
    Private write_dmu_pwd_d1w_value
    Private read_dmu_pwd_d1w_value
    Private flag_dmu_pwd_d1w
    Private write_dmu_pwd_cfg_value
    Private read_dmu_pwd_cfg_value
    Private flag_dmu_pwd_cfg
    Private write_dmu_pwd_bbl_value
    Private read_dmu_pwd_bbl_value
    Private flag_dmu_pwd_bbl
    Private write_dmu_pwd_adc1_value
    Private read_dmu_pwd_adc1_value
    Private flag_dmu_pwd_adc1
    Private write_dmu_pwd_adc0_value
    Private read_dmu_pwd_adc0_value
    Private flag_dmu_pwd_adc0

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hc0
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_dmu_pwd_sci0
        get_dmu_pwd_sci0 = read_dmu_pwd_sci0_value
    End Property

    Property Let set_dmu_pwd_sci0(aData)
        write_dmu_pwd_sci0_value = aData
        flag_dmu_pwd_sci0        = &H1
    End Property

    Property Get read_dmu_pwd_sci0
        read
        read_dmu_pwd_sci0 = read_dmu_pwd_sci0_value
    End Property

    Property Let write_dmu_pwd_sci0(aData)
        set_dmu_pwd_sci0 = aData
        write
    End Property

    Property Get get_dmu_pwd_rom
        get_dmu_pwd_rom = read_dmu_pwd_rom_value
    End Property

    Property Let set_dmu_pwd_rom(aData)
        write_dmu_pwd_rom_value = aData
        flag_dmu_pwd_rom        = &H1
    End Property

    Property Get read_dmu_pwd_rom
        read
        read_dmu_pwd_rom = read_dmu_pwd_rom_value
    End Property

    Property Let write_dmu_pwd_rom(aData)
        set_dmu_pwd_rom = aData
        write
    End Property

    Property Get get_dmu_pwd_rng
        get_dmu_pwd_rng = read_dmu_pwd_rng_value
    End Property

    Property Let set_dmu_pwd_rng(aData)
        write_dmu_pwd_rng_value = aData
        flag_dmu_pwd_rng        = &H1
    End Property

    Property Get read_dmu_pwd_rng
        read
        read_dmu_pwd_rng = read_dmu_pwd_rng_value
    End Property

    Property Let write_dmu_pwd_rng(aData)
        set_dmu_pwd_rng = aData
        write
    End Property

    Property Get get_dmu_pwd_pwm
        get_dmu_pwd_pwm = read_dmu_pwd_pwm_value
    End Property

    Property Let set_dmu_pwd_pwm(aData)
        write_dmu_pwd_pwm_value = aData
        flag_dmu_pwd_pwm        = &H1
    End Property

    Property Get read_dmu_pwd_pwm
        read
        read_dmu_pwd_pwm = read_dmu_pwd_pwm_value
    End Property

    Property Let write_dmu_pwd_pwm(aData)
        set_dmu_pwd_pwm = aData
        write
    End Property

    Property Get get_dmu_pwd_pka
        get_dmu_pwd_pka = read_dmu_pwd_pka_value
    End Property

    Property Let set_dmu_pwd_pka(aData)
        write_dmu_pwd_pka_value = aData
        flag_dmu_pwd_pka        = &H1
    End Property

    Property Get read_dmu_pwd_pka
        read
        read_dmu_pwd_pka = read_dmu_pwd_pka_value
    End Property

    Property Let write_dmu_pwd_pka(aData)
        set_dmu_pwd_pka = aData
        write
    End Property

    Property Get get_dmu_pwd_pbz
        get_dmu_pwd_pbz = read_dmu_pwd_pbz_value
    End Property

    Property Let set_dmu_pwd_pbz(aData)
        write_dmu_pwd_pbz_value = aData
        flag_dmu_pwd_pbz        = &H1
    End Property

    Property Get read_dmu_pwd_pbz
        read
        read_dmu_pwd_pbz = read_dmu_pwd_pbz_value
    End Property

    Property Let write_dmu_pwd_pbz(aData)
        set_dmu_pwd_pbz = aData
        write
    End Property

    Property Get get_dmu_pwd_pby
        get_dmu_pwd_pby = read_dmu_pwd_pby_value
    End Property

    Property Let set_dmu_pwd_pby(aData)
        write_dmu_pwd_pby_value = aData
        flag_dmu_pwd_pby        = &H1
    End Property

    Property Get read_dmu_pwd_pby
        read
        read_dmu_pwd_pby = read_dmu_pwd_pby_value
    End Property

    Property Let write_dmu_pwd_pby(aData)
        set_dmu_pwd_pby = aData
        write
    End Property

    Property Get get_dmu_pwd_pbx
        get_dmu_pwd_pbx = read_dmu_pwd_pbx_value
    End Property

    Property Let set_dmu_pwd_pbx(aData)
        write_dmu_pwd_pbx_value = aData
        flag_dmu_pwd_pbx        = &H1
    End Property

    Property Get read_dmu_pwd_pbx
        read
        read_dmu_pwd_pbx = read_dmu_pwd_pbx_value
    End Property

    Property Let write_dmu_pwd_pbx(aData)
        set_dmu_pwd_pbx = aData
        write
    End Property

    Property Get get_dmu_pwd_odma
        get_dmu_pwd_odma = read_dmu_pwd_odma_value
    End Property

    Property Let set_dmu_pwd_odma(aData)
        write_dmu_pwd_odma_value = aData
        flag_dmu_pwd_odma        = &H1
    End Property

    Property Get read_dmu_pwd_odma
        read
        read_dmu_pwd_odma = read_dmu_pwd_odma_value
    End Property

    Property Let write_dmu_pwd_odma(aData)
        set_dmu_pwd_odma = aData
        write
    End Property

    Property Get get_dmu_pwd_nvm
        get_dmu_pwd_nvm = read_dmu_pwd_nvm_value
    End Property

    Property Let set_dmu_pwd_nvm(aData)
        write_dmu_pwd_nvm_value = aData
        flag_dmu_pwd_nvm        = &H1
    End Property

    Property Get read_dmu_pwd_nvm
        read
        read_dmu_pwd_nvm = read_dmu_pwd_nvm_value
    End Property

    Property Let write_dmu_pwd_nvm(aData)
        set_dmu_pwd_nvm = aData
        write
    End Property

    Property Get get_dmu_pwd_msr
        get_dmu_pwd_msr = read_dmu_pwd_msr_value
    End Property

    Property Let set_dmu_pwd_msr(aData)
        write_dmu_pwd_msr_value = aData
        flag_dmu_pwd_msr        = &H1
    End Property

    Property Get read_dmu_pwd_msr
        read
        read_dmu_pwd_msr = read_dmu_pwd_msr_value
    End Property

    Property Let write_dmu_pwd_msr(aData)
        set_dmu_pwd_msr = aData
        write
    End Property

    Property Get get_dmu_pwd_mmi
        get_dmu_pwd_mmi = read_dmu_pwd_mmi_value
    End Property

    Property Let set_dmu_pwd_mmi(aData)
        write_dmu_pwd_mmi_value = aData
        flag_dmu_pwd_mmi        = &H1
    End Property

    Property Get read_dmu_pwd_mmi
        read
        read_dmu_pwd_mmi = read_dmu_pwd_mmi_value
    End Property

    Property Let write_dmu_pwd_mmi(aData)
        set_dmu_pwd_mmi = aData
        write
    End Property

    Property Get get_dmu_pwd_mem
        get_dmu_pwd_mem = read_dmu_pwd_mem_value
    End Property

    Property Let set_dmu_pwd_mem(aData)
        write_dmu_pwd_mem_value = aData
        flag_dmu_pwd_mem        = &H1
    End Property

    Property Get read_dmu_pwd_mem
        read
        read_dmu_pwd_mem = read_dmu_pwd_mem_value
    End Property

    Property Let write_dmu_pwd_mem(aData)
        set_dmu_pwd_mem = aData
        write
    End Property

    Property Get get_dmu_pwd_lcd
        get_dmu_pwd_lcd = read_dmu_pwd_lcd_value
    End Property

    Property Let set_dmu_pwd_lcd(aData)
        write_dmu_pwd_lcd_value = aData
        flag_dmu_pwd_lcd        = &H1
    End Property

    Property Get read_dmu_pwd_lcd
        read
        read_dmu_pwd_lcd = read_dmu_pwd_lcd_value
    End Property

    Property Let write_dmu_pwd_lcd(aData)
        set_dmu_pwd_lcd = aData
        write
    End Property

    Property Get get_dmu_pwd_i2s
        get_dmu_pwd_i2s = read_dmu_pwd_i2s_value
    End Property

    Property Let set_dmu_pwd_i2s(aData)
        write_dmu_pwd_i2s_value = aData
        flag_dmu_pwd_i2s        = &H1
    End Property

    Property Get read_dmu_pwd_i2s
        read
        read_dmu_pwd_i2s = read_dmu_pwd_i2s_value
    End Property

    Property Let write_dmu_pwd_i2s(aData)
        set_dmu_pwd_i2s = aData
        write
    End Property

    Property Get get_dmu_pwd_i2c1
        get_dmu_pwd_i2c1 = read_dmu_pwd_i2c1_value
    End Property

    Property Let set_dmu_pwd_i2c1(aData)
        write_dmu_pwd_i2c1_value = aData
        flag_dmu_pwd_i2c1        = &H1
    End Property

    Property Get read_dmu_pwd_i2c1
        read
        read_dmu_pwd_i2c1 = read_dmu_pwd_i2c1_value
    End Property

    Property Let write_dmu_pwd_i2c1(aData)
        set_dmu_pwd_i2c1 = aData
        write
    End Property

    Property Get get_dmu_pwd_i2c0
        get_dmu_pwd_i2c0 = read_dmu_pwd_i2c0_value
    End Property

    Property Let set_dmu_pwd_i2c0(aData)
        write_dmu_pwd_i2c0_value = aData
        flag_dmu_pwd_i2c0        = &H1
    End Property

    Property Get read_dmu_pwd_i2c0
        read
        read_dmu_pwd_i2c0 = read_dmu_pwd_i2c0_value
    End Property

    Property Let write_dmu_pwd_i2c0(aData)
        set_dmu_pwd_i2c0 = aData
        write
    End Property

    Property Get get_dmu_pwd_gio4
        get_dmu_pwd_gio4 = read_dmu_pwd_gio4_value
    End Property

    Property Let set_dmu_pwd_gio4(aData)
        write_dmu_pwd_gio4_value = aData
        flag_dmu_pwd_gio4        = &H1
    End Property

    Property Get read_dmu_pwd_gio4
        read
        read_dmu_pwd_gio4 = read_dmu_pwd_gio4_value
    End Property

    Property Let write_dmu_pwd_gio4(aData)
        set_dmu_pwd_gio4 = aData
        write
    End Property

    Property Get get_dmu_pwd_gio3
        get_dmu_pwd_gio3 = read_dmu_pwd_gio3_value
    End Property

    Property Let set_dmu_pwd_gio3(aData)
        write_dmu_pwd_gio3_value = aData
        flag_dmu_pwd_gio3        = &H1
    End Property

    Property Get read_dmu_pwd_gio3
        read
        read_dmu_pwd_gio3 = read_dmu_pwd_gio3_value
    End Property

    Property Let write_dmu_pwd_gio3(aData)
        set_dmu_pwd_gio3 = aData
        write
    End Property

    Property Get get_dmu_pwd_gio2
        get_dmu_pwd_gio2 = read_dmu_pwd_gio2_value
    End Property

    Property Let set_dmu_pwd_gio2(aData)
        write_dmu_pwd_gio2_value = aData
        flag_dmu_pwd_gio2        = &H1
    End Property

    Property Get read_dmu_pwd_gio2
        read
        read_dmu_pwd_gio2 = read_dmu_pwd_gio2_value
    End Property

    Property Let write_dmu_pwd_gio2(aData)
        set_dmu_pwd_gio2 = aData
        write
    End Property

    Property Get get_dmu_pwd_gio1
        get_dmu_pwd_gio1 = read_dmu_pwd_gio1_value
    End Property

    Property Let set_dmu_pwd_gio1(aData)
        write_dmu_pwd_gio1_value = aData
        flag_dmu_pwd_gio1        = &H1
    End Property

    Property Get read_dmu_pwd_gio1
        read
        read_dmu_pwd_gio1 = read_dmu_pwd_gio1_value
    End Property

    Property Let write_dmu_pwd_gio1(aData)
        set_dmu_pwd_gio1 = aData
        write
    End Property

    Property Get get_dmu_pwd_gio0
        get_dmu_pwd_gio0 = read_dmu_pwd_gio0_value
    End Property

    Property Let set_dmu_pwd_gio0(aData)
        write_dmu_pwd_gio0_value = aData
        flag_dmu_pwd_gio0        = &H1
    End Property

    Property Get read_dmu_pwd_gio0
        read
        read_dmu_pwd_gio0 = read_dmu_pwd_gio0_value
    End Property

    Property Let write_dmu_pwd_gio0(aData)
        set_dmu_pwd_gio0 = aData
        write
    End Property

    Property Get get_dmu_pwd_etm
        get_dmu_pwd_etm = read_dmu_pwd_etm_value
    End Property

    Property Let set_dmu_pwd_etm(aData)
        write_dmu_pwd_etm_value = aData
        flag_dmu_pwd_etm        = &H1
    End Property

    Property Get read_dmu_pwd_etm
        read
        read_dmu_pwd_etm = read_dmu_pwd_etm_value
    End Property

    Property Let write_dmu_pwd_etm(aData)
        set_dmu_pwd_etm = aData
        write
    End Property

    Property Get get_dmu_pwd_eth
        get_dmu_pwd_eth = read_dmu_pwd_eth_value
    End Property

    Property Let set_dmu_pwd_eth(aData)
        write_dmu_pwd_eth_value = aData
        flag_dmu_pwd_eth        = &H1
    End Property

    Property Get read_dmu_pwd_eth
        read
        read_dmu_pwd_eth = read_dmu_pwd_eth_value
    End Property

    Property Let write_dmu_pwd_eth(aData)
        set_dmu_pwd_eth = aData
        write
    End Property

    Property Get get_dmu_pwd_dec
        get_dmu_pwd_dec = read_dmu_pwd_dec_value
    End Property

    Property Let set_dmu_pwd_dec(aData)
        write_dmu_pwd_dec_value = aData
        flag_dmu_pwd_dec        = &H1
    End Property

    Property Get read_dmu_pwd_dec
        read
        read_dmu_pwd_dec = read_dmu_pwd_dec_value
    End Property

    Property Let write_dmu_pwd_dec(aData)
        set_dmu_pwd_dec = aData
        write
    End Property

    Property Get get_dmu_pwd_ddr
        get_dmu_pwd_ddr = read_dmu_pwd_ddr_value
    End Property

    Property Let set_dmu_pwd_ddr(aData)
        write_dmu_pwd_ddr_value = aData
        flag_dmu_pwd_ddr        = &H1
    End Property

    Property Get read_dmu_pwd_ddr
        read
        read_dmu_pwd_ddr = read_dmu_pwd_ddr_value
    End Property

    Property Let write_dmu_pwd_ddr(aData)
        set_dmu_pwd_ddr = aData
        write
    End Property

    Property Get get_dmu_pwd_dac
        get_dmu_pwd_dac = read_dmu_pwd_dac_value
    End Property

    Property Let set_dmu_pwd_dac(aData)
        write_dmu_pwd_dac_value = aData
        flag_dmu_pwd_dac        = &H1
    End Property

    Property Get read_dmu_pwd_dac
        read
        read_dmu_pwd_dac = read_dmu_pwd_dac_value
    End Property

    Property Let write_dmu_pwd_dac(aData)
        set_dmu_pwd_dac = aData
        write
    End Property

    Property Get get_dmu_pwd_d1w
        get_dmu_pwd_d1w = read_dmu_pwd_d1w_value
    End Property

    Property Let set_dmu_pwd_d1w(aData)
        write_dmu_pwd_d1w_value = aData
        flag_dmu_pwd_d1w        = &H1
    End Property

    Property Get read_dmu_pwd_d1w
        read
        read_dmu_pwd_d1w = read_dmu_pwd_d1w_value
    End Property

    Property Let write_dmu_pwd_d1w(aData)
        set_dmu_pwd_d1w = aData
        write
    End Property

    Property Get get_dmu_pwd_cfg
        get_dmu_pwd_cfg = read_dmu_pwd_cfg_value
    End Property

    Property Let set_dmu_pwd_cfg(aData)
        write_dmu_pwd_cfg_value = aData
        flag_dmu_pwd_cfg        = &H1
    End Property

    Property Get read_dmu_pwd_cfg
        read
        read_dmu_pwd_cfg = read_dmu_pwd_cfg_value
    End Property

    Property Let write_dmu_pwd_cfg(aData)
        set_dmu_pwd_cfg = aData
        write
    End Property

    Property Get get_dmu_pwd_bbl
        get_dmu_pwd_bbl = read_dmu_pwd_bbl_value
    End Property

    Property Let set_dmu_pwd_bbl(aData)
        write_dmu_pwd_bbl_value = aData
        flag_dmu_pwd_bbl        = &H1
    End Property

    Property Get read_dmu_pwd_bbl
        read
        read_dmu_pwd_bbl = read_dmu_pwd_bbl_value
    End Property

    Property Let write_dmu_pwd_bbl(aData)
        set_dmu_pwd_bbl = aData
        write
    End Property

    Property Get get_dmu_pwd_adc1
        get_dmu_pwd_adc1 = read_dmu_pwd_adc1_value
    End Property

    Property Let set_dmu_pwd_adc1(aData)
        write_dmu_pwd_adc1_value = aData
        flag_dmu_pwd_adc1        = &H1
    End Property

    Property Get read_dmu_pwd_adc1
        read
        read_dmu_pwd_adc1 = read_dmu_pwd_adc1_value
    End Property

    Property Let write_dmu_pwd_adc1(aData)
        set_dmu_pwd_adc1 = aData
        write
    End Property

    Property Get get_dmu_pwd_adc0
        get_dmu_pwd_adc0 = read_dmu_pwd_adc0_value
    End Property

    Property Let set_dmu_pwd_adc0(aData)
        write_dmu_pwd_adc0_value = aData
        flag_dmu_pwd_adc0        = &H1
    End Property

    Property Get read_dmu_pwd_adc0
        read
        read_dmu_pwd_adc0 = read_dmu_pwd_adc0_value
    End Property

    Property Let write_dmu_pwd_adc0(aData)
        set_dmu_pwd_adc0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_dmu_pwd_sci0_value = rightShift(data_low, 31) and &H1
        read_dmu_pwd_rom_value = rightShift(data_low, 30) and &H1
        read_dmu_pwd_rng_value = rightShift(data_low, 29) and &H1
        read_dmu_pwd_pwm_value = rightShift(data_low, 28) and &H1
        read_dmu_pwd_pka_value = rightShift(data_low, 27) and &H1
        read_dmu_pwd_pbz_value = rightShift(data_low, 26) and &H1
        read_dmu_pwd_pby_value = rightShift(data_low, 25) and &H1
        read_dmu_pwd_pbx_value = rightShift(data_low, 24) and &H1
        read_dmu_pwd_odma_value = rightShift(data_low, 23) and &H1
        read_dmu_pwd_nvm_value = rightShift(data_low, 22) and &H1
        read_dmu_pwd_msr_value = rightShift(data_low, 21) and &H1
        read_dmu_pwd_mmi_value = rightShift(data_low, 20) and &H1
        read_dmu_pwd_mem_value = rightShift(data_low, 19) and &H1
        read_dmu_pwd_lcd_value = rightShift(data_low, 18) and &H1
        read_dmu_pwd_i2s_value = rightShift(data_low, 17) and &H1
        read_dmu_pwd_i2c1_value = rightShift(data_low, 16) and &H1
        read_dmu_pwd_i2c0_value = rightShift(data_low, 15) and &H1
        read_dmu_pwd_gio4_value = rightShift(data_low, 14) and &H1
        read_dmu_pwd_gio3_value = rightShift(data_low, 13) and &H1
        read_dmu_pwd_gio2_value = rightShift(data_low, 12) and &H1
        read_dmu_pwd_gio1_value = rightShift(data_low, 11) and &H1
        read_dmu_pwd_gio0_value = rightShift(data_low, 10) and &H1
        read_dmu_pwd_etm_value = rightShift(data_low, 9) and &H1
        read_dmu_pwd_eth_value = rightShift(data_low, 8) and &H1
        read_dmu_pwd_dec_value = rightShift(data_low, 7) and &H1
        read_dmu_pwd_ddr_value = rightShift(data_low, 6) and &H1
        read_dmu_pwd_dac_value = rightShift(data_low, 5) and &H1
        read_dmu_pwd_d1w_value = rightShift(data_low, 4) and &H1
        read_dmu_pwd_cfg_value = rightShift(data_low, 3) and &H1
        read_dmu_pwd_bbl_value = rightShift(data_low, 2) and &H1
        read_dmu_pwd_adc1_value = rightShift(data_low, 1) and &H1
        dmu_pwd_adc0_mask = &H1
        if data_low > LONG_MAX then
            if dmu_pwd_adc0_mask = mask then
                read_dmu_pwd_adc0_value = data_low
            else
                read_dmu_pwd_adc0_value = (data_low - H8000_0000) and dmu_pwd_adc0_mask
            end If
        else
            read_dmu_pwd_adc0_value = data_low and dmu_pwd_adc0_mask
        end If

    End Sub

    Sub write
        If flag_dmu_pwd_sci0 = &H0 or flag_dmu_pwd_rom = &H0 or flag_dmu_pwd_rng = &H0 or flag_dmu_pwd_pwm = &H0 or flag_dmu_pwd_pka = &H0 or flag_dmu_pwd_pbz = &H0 or flag_dmu_pwd_pby = &H0 or flag_dmu_pwd_pbx = &H0 or flag_dmu_pwd_odma = &H0 or flag_dmu_pwd_nvm = &H0 or flag_dmu_pwd_msr = &H0 or flag_dmu_pwd_mmi = &H0 or flag_dmu_pwd_mem = &H0 or flag_dmu_pwd_lcd = &H0 or flag_dmu_pwd_i2s = &H0 or flag_dmu_pwd_i2c1 = &H0 or flag_dmu_pwd_i2c0 = &H0 or flag_dmu_pwd_gio4 = &H0 or flag_dmu_pwd_gio3 = &H0 or flag_dmu_pwd_gio2 = &H0 or flag_dmu_pwd_gio1 = &H0 or flag_dmu_pwd_gio0 = &H0 or flag_dmu_pwd_etm = &H0 or flag_dmu_pwd_eth = &H0 or flag_dmu_pwd_dec = &H0 or flag_dmu_pwd_ddr = &H0 or flag_dmu_pwd_dac = &H0 or flag_dmu_pwd_d1w = &H0 or flag_dmu_pwd_cfg = &H0 or flag_dmu_pwd_bbl = &H0 or flag_dmu_pwd_adc1 = &H0 or flag_dmu_pwd_adc0 = &H0 Then read
        If flag_dmu_pwd_sci0 = &H0 Then write_dmu_pwd_sci0_value = get_dmu_pwd_sci0
        If flag_dmu_pwd_rom = &H0 Then write_dmu_pwd_rom_value = get_dmu_pwd_rom
        If flag_dmu_pwd_rng = &H0 Then write_dmu_pwd_rng_value = get_dmu_pwd_rng
        If flag_dmu_pwd_pwm = &H0 Then write_dmu_pwd_pwm_value = get_dmu_pwd_pwm
        If flag_dmu_pwd_pka = &H0 Then write_dmu_pwd_pka_value = get_dmu_pwd_pka
        If flag_dmu_pwd_pbz = &H0 Then write_dmu_pwd_pbz_value = get_dmu_pwd_pbz
        If flag_dmu_pwd_pby = &H0 Then write_dmu_pwd_pby_value = get_dmu_pwd_pby
        If flag_dmu_pwd_pbx = &H0 Then write_dmu_pwd_pbx_value = get_dmu_pwd_pbx
        If flag_dmu_pwd_odma = &H0 Then write_dmu_pwd_odma_value = get_dmu_pwd_odma
        If flag_dmu_pwd_nvm = &H0 Then write_dmu_pwd_nvm_value = get_dmu_pwd_nvm
        If flag_dmu_pwd_msr = &H0 Then write_dmu_pwd_msr_value = get_dmu_pwd_msr
        If flag_dmu_pwd_mmi = &H0 Then write_dmu_pwd_mmi_value = get_dmu_pwd_mmi
        If flag_dmu_pwd_mem = &H0 Then write_dmu_pwd_mem_value = get_dmu_pwd_mem
        If flag_dmu_pwd_lcd = &H0 Then write_dmu_pwd_lcd_value = get_dmu_pwd_lcd
        If flag_dmu_pwd_i2s = &H0 Then write_dmu_pwd_i2s_value = get_dmu_pwd_i2s
        If flag_dmu_pwd_i2c1 = &H0 Then write_dmu_pwd_i2c1_value = get_dmu_pwd_i2c1
        If flag_dmu_pwd_i2c0 = &H0 Then write_dmu_pwd_i2c0_value = get_dmu_pwd_i2c0
        If flag_dmu_pwd_gio4 = &H0 Then write_dmu_pwd_gio4_value = get_dmu_pwd_gio4
        If flag_dmu_pwd_gio3 = &H0 Then write_dmu_pwd_gio3_value = get_dmu_pwd_gio3
        If flag_dmu_pwd_gio2 = &H0 Then write_dmu_pwd_gio2_value = get_dmu_pwd_gio2
        If flag_dmu_pwd_gio1 = &H0 Then write_dmu_pwd_gio1_value = get_dmu_pwd_gio1
        If flag_dmu_pwd_gio0 = &H0 Then write_dmu_pwd_gio0_value = get_dmu_pwd_gio0
        If flag_dmu_pwd_etm = &H0 Then write_dmu_pwd_etm_value = get_dmu_pwd_etm
        If flag_dmu_pwd_eth = &H0 Then write_dmu_pwd_eth_value = get_dmu_pwd_eth
        If flag_dmu_pwd_dec = &H0 Then write_dmu_pwd_dec_value = get_dmu_pwd_dec
        If flag_dmu_pwd_ddr = &H0 Then write_dmu_pwd_ddr_value = get_dmu_pwd_ddr
        If flag_dmu_pwd_dac = &H0 Then write_dmu_pwd_dac_value = get_dmu_pwd_dac
        If flag_dmu_pwd_d1w = &H0 Then write_dmu_pwd_d1w_value = get_dmu_pwd_d1w
        If flag_dmu_pwd_cfg = &H0 Then write_dmu_pwd_cfg_value = get_dmu_pwd_cfg
        If flag_dmu_pwd_bbl = &H0 Then write_dmu_pwd_bbl_value = get_dmu_pwd_bbl
        If flag_dmu_pwd_adc1 = &H0 Then write_dmu_pwd_adc1_value = get_dmu_pwd_adc1
        If flag_dmu_pwd_adc0 = &H0 Then write_dmu_pwd_adc0_value = get_dmu_pwd_adc0

        regValue = leftShift((write_dmu_pwd_sci0_value and &H1), 31) + leftShift((write_dmu_pwd_rom_value and &H1), 30) + leftShift((write_dmu_pwd_rng_value and &H1), 29) + leftShift((write_dmu_pwd_pwm_value and &H1), 28) + leftShift((write_dmu_pwd_pka_value and &H1), 27) + leftShift((write_dmu_pwd_pbz_value and &H1), 26) + leftShift((write_dmu_pwd_pby_value and &H1), 25) + leftShift((write_dmu_pwd_pbx_value and &H1), 24) + leftShift((write_dmu_pwd_odma_value and &H1), 23) + leftShift((write_dmu_pwd_nvm_value and &H1), 22) + leftShift((write_dmu_pwd_msr_value and &H1), 21) + leftShift((write_dmu_pwd_mmi_value and &H1), 20) + leftShift((write_dmu_pwd_mem_value and &H1), 19) + leftShift((write_dmu_pwd_lcd_value and &H1), 18) + leftShift((write_dmu_pwd_i2s_value and &H1), 17) + leftShift((write_dmu_pwd_i2c1_value and &H1), 16) + leftShift((write_dmu_pwd_i2c0_value and &H1), 15) + leftShift((write_dmu_pwd_gio4_value and &H1), 14) + leftShift((write_dmu_pwd_gio3_value and &H1), 13) + leftShift((write_dmu_pwd_gio2_value and &H1), 12) + leftShift((write_dmu_pwd_gio1_value and &H1), 11) + leftShift((write_dmu_pwd_gio0_value and &H1), 10) + leftShift((write_dmu_pwd_etm_value and &H1), 9) + leftShift((write_dmu_pwd_eth_value and &H1), 8) + leftShift((write_dmu_pwd_dec_value and &H1), 7) + leftShift((write_dmu_pwd_ddr_value and &H1), 6) + leftShift((write_dmu_pwd_dac_value and &H1), 5) + leftShift((write_dmu_pwd_d1w_value and &H1), 4) + leftShift((write_dmu_pwd_cfg_value and &H1), 3) + leftShift((write_dmu_pwd_bbl_value and &H1), 2) + leftShift((write_dmu_pwd_adc1_value and &H1), 1) + leftShift((write_dmu_pwd_adc0_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_dmu_pwd_sci0_value = rightShift(data_low, 31) and &H1
        read_dmu_pwd_rom_value = rightShift(data_low, 30) and &H1
        read_dmu_pwd_rng_value = rightShift(data_low, 29) and &H1
        read_dmu_pwd_pwm_value = rightShift(data_low, 28) and &H1
        read_dmu_pwd_pka_value = rightShift(data_low, 27) and &H1
        read_dmu_pwd_pbz_value = rightShift(data_low, 26) and &H1
        read_dmu_pwd_pby_value = rightShift(data_low, 25) and &H1
        read_dmu_pwd_pbx_value = rightShift(data_low, 24) and &H1
        read_dmu_pwd_odma_value = rightShift(data_low, 23) and &H1
        read_dmu_pwd_nvm_value = rightShift(data_low, 22) and &H1
        read_dmu_pwd_msr_value = rightShift(data_low, 21) and &H1
        read_dmu_pwd_mmi_value = rightShift(data_low, 20) and &H1
        read_dmu_pwd_mem_value = rightShift(data_low, 19) and &H1
        read_dmu_pwd_lcd_value = rightShift(data_low, 18) and &H1
        read_dmu_pwd_i2s_value = rightShift(data_low, 17) and &H1
        read_dmu_pwd_i2c1_value = rightShift(data_low, 16) and &H1
        read_dmu_pwd_i2c0_value = rightShift(data_low, 15) and &H1
        read_dmu_pwd_gio4_value = rightShift(data_low, 14) and &H1
        read_dmu_pwd_gio3_value = rightShift(data_low, 13) and &H1
        read_dmu_pwd_gio2_value = rightShift(data_low, 12) and &H1
        read_dmu_pwd_gio1_value = rightShift(data_low, 11) and &H1
        read_dmu_pwd_gio0_value = rightShift(data_low, 10) and &H1
        read_dmu_pwd_etm_value = rightShift(data_low, 9) and &H1
        read_dmu_pwd_eth_value = rightShift(data_low, 8) and &H1
        read_dmu_pwd_dec_value = rightShift(data_low, 7) and &H1
        read_dmu_pwd_ddr_value = rightShift(data_low, 6) and &H1
        read_dmu_pwd_dac_value = rightShift(data_low, 5) and &H1
        read_dmu_pwd_d1w_value = rightShift(data_low, 4) and &H1
        read_dmu_pwd_cfg_value = rightShift(data_low, 3) and &H1
        read_dmu_pwd_bbl_value = rightShift(data_low, 2) and &H1
        read_dmu_pwd_adc1_value = rightShift(data_low, 1) and &H1
        dmu_pwd_adc0_mask = &H1
        if data_low > LONG_MAX then
            if dmu_pwd_adc0_mask = mask then
                read_dmu_pwd_adc0_value = data_low
            else
                read_dmu_pwd_adc0_value = (data_low - H8000_0000) and dmu_pwd_adc0_mask
            end If
        else
            read_dmu_pwd_adc0_value = data_low and dmu_pwd_adc0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_dmu_pwd_sci0_value = &H0
        flag_dmu_pwd_sci0        = &H0
        write_dmu_pwd_rom_value = &H0
        flag_dmu_pwd_rom        = &H0
        write_dmu_pwd_rng_value = &H0
        flag_dmu_pwd_rng        = &H0
        write_dmu_pwd_pwm_value = &H0
        flag_dmu_pwd_pwm        = &H0
        write_dmu_pwd_pka_value = &H0
        flag_dmu_pwd_pka        = &H0
        write_dmu_pwd_pbz_value = &H0
        flag_dmu_pwd_pbz        = &H0
        write_dmu_pwd_pby_value = &H0
        flag_dmu_pwd_pby        = &H0
        write_dmu_pwd_pbx_value = &H0
        flag_dmu_pwd_pbx        = &H0
        write_dmu_pwd_odma_value = &H0
        flag_dmu_pwd_odma        = &H0
        write_dmu_pwd_nvm_value = &H0
        flag_dmu_pwd_nvm        = &H0
        write_dmu_pwd_msr_value = &H0
        flag_dmu_pwd_msr        = &H0
        write_dmu_pwd_mmi_value = &H0
        flag_dmu_pwd_mmi        = &H0
        write_dmu_pwd_mem_value = &H0
        flag_dmu_pwd_mem        = &H0
        write_dmu_pwd_lcd_value = &H0
        flag_dmu_pwd_lcd        = &H0
        write_dmu_pwd_i2s_value = &H0
        flag_dmu_pwd_i2s        = &H0
        write_dmu_pwd_i2c1_value = &H0
        flag_dmu_pwd_i2c1        = &H0
        write_dmu_pwd_i2c0_value = &H0
        flag_dmu_pwd_i2c0        = &H0
        write_dmu_pwd_gio4_value = &H0
        flag_dmu_pwd_gio4        = &H0
        write_dmu_pwd_gio3_value = &H0
        flag_dmu_pwd_gio3        = &H0
        write_dmu_pwd_gio2_value = &H0
        flag_dmu_pwd_gio2        = &H0
        write_dmu_pwd_gio1_value = &H0
        flag_dmu_pwd_gio1        = &H0
        write_dmu_pwd_gio0_value = &H0
        flag_dmu_pwd_gio0        = &H0
        write_dmu_pwd_etm_value = &H0
        flag_dmu_pwd_etm        = &H0
        write_dmu_pwd_eth_value = &H0
        flag_dmu_pwd_eth        = &H0
        write_dmu_pwd_dec_value = &H0
        flag_dmu_pwd_dec        = &H0
        write_dmu_pwd_ddr_value = &H0
        flag_dmu_pwd_ddr        = &H0
        write_dmu_pwd_dac_value = &H0
        flag_dmu_pwd_dac        = &H0
        write_dmu_pwd_d1w_value = &H0
        flag_dmu_pwd_d1w        = &H0
        write_dmu_pwd_cfg_value = &H0
        flag_dmu_pwd_cfg        = &H0
        write_dmu_pwd_bbl_value = &H0
        flag_dmu_pwd_bbl        = &H0
        write_dmu_pwd_adc1_value = &H0
        flag_dmu_pwd_adc1        = &H0
        write_dmu_pwd_adc0_value = &H0
        flag_dmu_pwd_adc0        = &H0
    End Sub
End Class


'' @REGISTER : DMU_dmu_pwd_blk2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' dmu_pwd_ram                                [26:26]          get_dmu_pwd_ram
''                                                             set_dmu_pwd_ram
''                                                             read_dmu_pwd_ram
''                                                             write_dmu_pwd_ram
''---------------------------------------------------------------------------------
'' dmu_pwd_wdt                                [25:25]          get_dmu_pwd_wdt
''                                                             set_dmu_pwd_wdt
''                                                             read_dmu_pwd_wdt
''                                                             write_dmu_pwd_wdt
''---------------------------------------------------------------------------------
'' dmu_pwd_usb2                               [24:24]          get_dmu_pwd_usb2
''                                                             set_dmu_pwd_usb2
''                                                             read_dmu_pwd_usb2
''                                                             write_dmu_pwd_usb2
''---------------------------------------------------------------------------------
'' dmu_pwd_usb1                               [23:23]          get_dmu_pwd_usb1
''                                                             set_dmu_pwd_usb1
''                                                             read_dmu_pwd_usb1
''                                                             write_dmu_pwd_usb1
''---------------------------------------------------------------------------------
'' dmu_pwd_usb0                               [22:22]          get_dmu_pwd_usb0
''                                                             set_dmu_pwd_usb0
''                                                             read_dmu_pwd_usb0
''                                                             write_dmu_pwd_usb0
''---------------------------------------------------------------------------------
'' dmu_pwd_urt3                               [21:21]          get_dmu_pwd_urt3
''                                                             set_dmu_pwd_urt3
''                                                             read_dmu_pwd_urt3
''                                                             write_dmu_pwd_urt3
''---------------------------------------------------------------------------------
'' dmu_pwd_urt2                               [20:20]          get_dmu_pwd_urt2
''                                                             set_dmu_pwd_urt2
''                                                             read_dmu_pwd_urt2
''                                                             write_dmu_pwd_urt2
''---------------------------------------------------------------------------------
'' dmu_pwd_urt1                               [19:19]          get_dmu_pwd_urt1
''                                                             set_dmu_pwd_urt1
''                                                             read_dmu_pwd_urt1
''                                                             write_dmu_pwd_urt1
''---------------------------------------------------------------------------------
'' dmu_pwd_urt0                               [18:18]          get_dmu_pwd_urt0
''                                                             set_dmu_pwd_urt0
''                                                             read_dmu_pwd_urt0
''                                                             write_dmu_pwd_urt0
''---------------------------------------------------------------------------------
'' dmu_pwd_umc                                [17:17]          get_dmu_pwd_umc
''                                                             set_dmu_pwd_umc
''                                                             read_dmu_pwd_umc
''                                                             write_dmu_pwd_umc
''---------------------------------------------------------------------------------
'' dmu_pwd_tpb                                [16:16]          get_dmu_pwd_tpb
''                                                             set_dmu_pwd_tpb
''                                                             read_dmu_pwd_tpb
''                                                             write_dmu_pwd_tpb
''---------------------------------------------------------------------------------
'' dmu_pwd_tim4                               [15:15]          get_dmu_pwd_tim4
''                                                             set_dmu_pwd_tim4
''                                                             read_dmu_pwd_tim4
''                                                             write_dmu_pwd_tim4
''---------------------------------------------------------------------------------
'' dmu_pwd_tim3                               [14:14]          get_dmu_pwd_tim3
''                                                             set_dmu_pwd_tim3
''                                                             read_dmu_pwd_tim3
''                                                             write_dmu_pwd_tim3
''---------------------------------------------------------------------------------
'' dmu_pwd_tim2                               [13:13]          get_dmu_pwd_tim2
''                                                             set_dmu_pwd_tim2
''                                                             read_dmu_pwd_tim2
''                                                             write_dmu_pwd_tim2
''---------------------------------------------------------------------------------
'' dmu_pwd_tim1                               [12:12]          get_dmu_pwd_tim1
''                                                             set_dmu_pwd_tim1
''                                                             read_dmu_pwd_tim1
''                                                             write_dmu_pwd_tim1
''---------------------------------------------------------------------------------
'' dmu_pwd_tim0                               [11:11]          get_dmu_pwd_tim0
''                                                             set_dmu_pwd_tim0
''                                                             read_dmu_pwd_tim0
''                                                             write_dmu_pwd_tim0
''---------------------------------------------------------------------------------
'' dmu_pwd_spl                                [10:10]          get_dmu_pwd_spl
''                                                             set_dmu_pwd_spl
''                                                             read_dmu_pwd_spl
''                                                             write_dmu_pwd_spl
''---------------------------------------------------------------------------------
'' dmu_pwd_qspi                               [9:9]            get_dmu_pwd_qspi
''                                                             set_dmu_pwd_qspi
''                                                             read_dmu_pwd_qspi
''                                                             write_dmu_pwd_qspi
''---------------------------------------------------------------------------------
'' dmu_pwd_spi10t1s                           [8:8]            get_dmu_pwd_spi10t1s
''                                                             set_dmu_pwd_spi10t1s
''                                                             read_dmu_pwd_spi10t1s
''                                                             write_dmu_pwd_spi10t1s
''---------------------------------------------------------------------------------
'' dmu_pwd_spi1                               [7:7]            get_dmu_pwd_spi1
''                                                             set_dmu_pwd_spi1
''                                                             read_dmu_pwd_spi1
''                                                             write_dmu_pwd_spi1
''---------------------------------------------------------------------------------
'' dmu_pwd_spi0                               [6:6]            get_dmu_pwd_spi0
''                                                             set_dmu_pwd_spi0
''                                                             read_dmu_pwd_spi0
''                                                             write_dmu_pwd_spi0
''---------------------------------------------------------------------------------
'' dmu_pwd_smu                                [5:5]            get_dmu_pwd_smu
''                                                             set_dmu_pwd_smu
''                                                             read_dmu_pwd_smu
''                                                             write_dmu_pwd_smu
''---------------------------------------------------------------------------------
'' dmu_pwd_smc                                [4:4]            get_dmu_pwd_smc
''                                                             set_dmu_pwd_smc
''                                                             read_dmu_pwd_smc
''                                                             write_dmu_pwd_smc
''---------------------------------------------------------------------------------
'' dmu_pwd_sdma                               [3:3]            get_dmu_pwd_sdma
''                                                             set_dmu_pwd_sdma
''                                                             read_dmu_pwd_sdma
''                                                             write_dmu_pwd_sdma
''---------------------------------------------------------------------------------
'' dmu_pwd_sdm1                               [2:2]            get_dmu_pwd_sdm1
''                                                             set_dmu_pwd_sdm1
''                                                             read_dmu_pwd_sdm1
''                                                             write_dmu_pwd_sdm1
''---------------------------------------------------------------------------------
'' dmu_pwd_sdm0                               [1:1]            get_dmu_pwd_sdm0
''                                                             set_dmu_pwd_sdm0
''                                                             read_dmu_pwd_sdm0
''                                                             write_dmu_pwd_sdm0
''---------------------------------------------------------------------------------
'' dmu_pwd_sci1                               [0:0]            get_dmu_pwd_sci1
''                                                             set_dmu_pwd_sci1
''                                                             read_dmu_pwd_sci1
''                                                             write_dmu_pwd_sci1
''---------------------------------------------------------------------------------
Class REGISTER_DMU_dmu_pwd_blk2
    Private write_dmu_pwd_ram_value
    Private read_dmu_pwd_ram_value
    Private flag_dmu_pwd_ram
    Private write_dmu_pwd_wdt_value
    Private read_dmu_pwd_wdt_value
    Private flag_dmu_pwd_wdt
    Private write_dmu_pwd_usb2_value
    Private read_dmu_pwd_usb2_value
    Private flag_dmu_pwd_usb2
    Private write_dmu_pwd_usb1_value
    Private read_dmu_pwd_usb1_value
    Private flag_dmu_pwd_usb1
    Private write_dmu_pwd_usb0_value
    Private read_dmu_pwd_usb0_value
    Private flag_dmu_pwd_usb0
    Private write_dmu_pwd_urt3_value
    Private read_dmu_pwd_urt3_value
    Private flag_dmu_pwd_urt3
    Private write_dmu_pwd_urt2_value
    Private read_dmu_pwd_urt2_value
    Private flag_dmu_pwd_urt2
    Private write_dmu_pwd_urt1_value
    Private read_dmu_pwd_urt1_value
    Private flag_dmu_pwd_urt1
    Private write_dmu_pwd_urt0_value
    Private read_dmu_pwd_urt0_value
    Private flag_dmu_pwd_urt0
    Private write_dmu_pwd_umc_value
    Private read_dmu_pwd_umc_value
    Private flag_dmu_pwd_umc
    Private write_dmu_pwd_tpb_value
    Private read_dmu_pwd_tpb_value
    Private flag_dmu_pwd_tpb
    Private write_dmu_pwd_tim4_value
    Private read_dmu_pwd_tim4_value
    Private flag_dmu_pwd_tim4
    Private write_dmu_pwd_tim3_value
    Private read_dmu_pwd_tim3_value
    Private flag_dmu_pwd_tim3
    Private write_dmu_pwd_tim2_value
    Private read_dmu_pwd_tim2_value
    Private flag_dmu_pwd_tim2
    Private write_dmu_pwd_tim1_value
    Private read_dmu_pwd_tim1_value
    Private flag_dmu_pwd_tim1
    Private write_dmu_pwd_tim0_value
    Private read_dmu_pwd_tim0_value
    Private flag_dmu_pwd_tim0
    Private write_dmu_pwd_spl_value
    Private read_dmu_pwd_spl_value
    Private flag_dmu_pwd_spl
    Private write_dmu_pwd_qspi_value
    Private read_dmu_pwd_qspi_value
    Private flag_dmu_pwd_qspi
    Private write_dmu_pwd_spi10t1s_value
    Private read_dmu_pwd_spi10t1s_value
    Private flag_dmu_pwd_spi10t1s
    Private write_dmu_pwd_spi1_value
    Private read_dmu_pwd_spi1_value
    Private flag_dmu_pwd_spi1
    Private write_dmu_pwd_spi0_value
    Private read_dmu_pwd_spi0_value
    Private flag_dmu_pwd_spi0
    Private write_dmu_pwd_smu_value
    Private read_dmu_pwd_smu_value
    Private flag_dmu_pwd_smu
    Private write_dmu_pwd_smc_value
    Private read_dmu_pwd_smc_value
    Private flag_dmu_pwd_smc
    Private write_dmu_pwd_sdma_value
    Private read_dmu_pwd_sdma_value
    Private flag_dmu_pwd_sdma
    Private write_dmu_pwd_sdm1_value
    Private read_dmu_pwd_sdm1_value
    Private flag_dmu_pwd_sdm1
    Private write_dmu_pwd_sdm0_value
    Private read_dmu_pwd_sdm0_value
    Private flag_dmu_pwd_sdm0
    Private write_dmu_pwd_sci1_value
    Private read_dmu_pwd_sci1_value
    Private flag_dmu_pwd_sci1

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hc4
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_dmu_pwd_ram
        get_dmu_pwd_ram = read_dmu_pwd_ram_value
    End Property

    Property Let set_dmu_pwd_ram(aData)
        write_dmu_pwd_ram_value = aData
        flag_dmu_pwd_ram        = &H1
    End Property

    Property Get read_dmu_pwd_ram
        read
        read_dmu_pwd_ram = read_dmu_pwd_ram_value
    End Property

    Property Let write_dmu_pwd_ram(aData)
        set_dmu_pwd_ram = aData
        write
    End Property

    Property Get get_dmu_pwd_wdt
        get_dmu_pwd_wdt = read_dmu_pwd_wdt_value
    End Property

    Property Let set_dmu_pwd_wdt(aData)
        write_dmu_pwd_wdt_value = aData
        flag_dmu_pwd_wdt        = &H1
    End Property

    Property Get read_dmu_pwd_wdt
        read
        read_dmu_pwd_wdt = read_dmu_pwd_wdt_value
    End Property

    Property Let write_dmu_pwd_wdt(aData)
        set_dmu_pwd_wdt = aData
        write
    End Property

    Property Get get_dmu_pwd_usb2
        get_dmu_pwd_usb2 = read_dmu_pwd_usb2_value
    End Property

    Property Let set_dmu_pwd_usb2(aData)
        write_dmu_pwd_usb2_value = aData
        flag_dmu_pwd_usb2        = &H1
    End Property

    Property Get read_dmu_pwd_usb2
        read
        read_dmu_pwd_usb2 = read_dmu_pwd_usb2_value
    End Property

    Property Let write_dmu_pwd_usb2(aData)
        set_dmu_pwd_usb2 = aData
        write
    End Property

    Property Get get_dmu_pwd_usb1
        get_dmu_pwd_usb1 = read_dmu_pwd_usb1_value
    End Property

    Property Let set_dmu_pwd_usb1(aData)
        write_dmu_pwd_usb1_value = aData
        flag_dmu_pwd_usb1        = &H1
    End Property

    Property Get read_dmu_pwd_usb1
        read
        read_dmu_pwd_usb1 = read_dmu_pwd_usb1_value
    End Property

    Property Let write_dmu_pwd_usb1(aData)
        set_dmu_pwd_usb1 = aData
        write
    End Property

    Property Get get_dmu_pwd_usb0
        get_dmu_pwd_usb0 = read_dmu_pwd_usb0_value
    End Property

    Property Let set_dmu_pwd_usb0(aData)
        write_dmu_pwd_usb0_value = aData
        flag_dmu_pwd_usb0        = &H1
    End Property

    Property Get read_dmu_pwd_usb0
        read
        read_dmu_pwd_usb0 = read_dmu_pwd_usb0_value
    End Property

    Property Let write_dmu_pwd_usb0(aData)
        set_dmu_pwd_usb0 = aData
        write
    End Property

    Property Get get_dmu_pwd_urt3
        get_dmu_pwd_urt3 = read_dmu_pwd_urt3_value
    End Property

    Property Let set_dmu_pwd_urt3(aData)
        write_dmu_pwd_urt3_value = aData
        flag_dmu_pwd_urt3        = &H1
    End Property

    Property Get read_dmu_pwd_urt3
        read
        read_dmu_pwd_urt3 = read_dmu_pwd_urt3_value
    End Property

    Property Let write_dmu_pwd_urt3(aData)
        set_dmu_pwd_urt3 = aData
        write
    End Property

    Property Get get_dmu_pwd_urt2
        get_dmu_pwd_urt2 = read_dmu_pwd_urt2_value
    End Property

    Property Let set_dmu_pwd_urt2(aData)
        write_dmu_pwd_urt2_value = aData
        flag_dmu_pwd_urt2        = &H1
    End Property

    Property Get read_dmu_pwd_urt2
        read
        read_dmu_pwd_urt2 = read_dmu_pwd_urt2_value
    End Property

    Property Let write_dmu_pwd_urt2(aData)
        set_dmu_pwd_urt2 = aData
        write
    End Property

    Property Get get_dmu_pwd_urt1
        get_dmu_pwd_urt1 = read_dmu_pwd_urt1_value
    End Property

    Property Let set_dmu_pwd_urt1(aData)
        write_dmu_pwd_urt1_value = aData
        flag_dmu_pwd_urt1        = &H1
    End Property

    Property Get read_dmu_pwd_urt1
        read
        read_dmu_pwd_urt1 = read_dmu_pwd_urt1_value
    End Property

    Property Let write_dmu_pwd_urt1(aData)
        set_dmu_pwd_urt1 = aData
        write
    End Property

    Property Get get_dmu_pwd_urt0
        get_dmu_pwd_urt0 = read_dmu_pwd_urt0_value
    End Property

    Property Let set_dmu_pwd_urt0(aData)
        write_dmu_pwd_urt0_value = aData
        flag_dmu_pwd_urt0        = &H1
    End Property

    Property Get read_dmu_pwd_urt0
        read
        read_dmu_pwd_urt0 = read_dmu_pwd_urt0_value
    End Property

    Property Let write_dmu_pwd_urt0(aData)
        set_dmu_pwd_urt0 = aData
        write
    End Property

    Property Get get_dmu_pwd_umc
        get_dmu_pwd_umc = read_dmu_pwd_umc_value
    End Property

    Property Let set_dmu_pwd_umc(aData)
        write_dmu_pwd_umc_value = aData
        flag_dmu_pwd_umc        = &H1
    End Property

    Property Get read_dmu_pwd_umc
        read
        read_dmu_pwd_umc = read_dmu_pwd_umc_value
    End Property

    Property Let write_dmu_pwd_umc(aData)
        set_dmu_pwd_umc = aData
        write
    End Property

    Property Get get_dmu_pwd_tpb
        get_dmu_pwd_tpb = read_dmu_pwd_tpb_value
    End Property

    Property Let set_dmu_pwd_tpb(aData)
        write_dmu_pwd_tpb_value = aData
        flag_dmu_pwd_tpb        = &H1
    End Property

    Property Get read_dmu_pwd_tpb
        read
        read_dmu_pwd_tpb = read_dmu_pwd_tpb_value
    End Property

    Property Let write_dmu_pwd_tpb(aData)
        set_dmu_pwd_tpb = aData
        write
    End Property

    Property Get get_dmu_pwd_tim4
        get_dmu_pwd_tim4 = read_dmu_pwd_tim4_value
    End Property

    Property Let set_dmu_pwd_tim4(aData)
        write_dmu_pwd_tim4_value = aData
        flag_dmu_pwd_tim4        = &H1
    End Property

    Property Get read_dmu_pwd_tim4
        read
        read_dmu_pwd_tim4 = read_dmu_pwd_tim4_value
    End Property

    Property Let write_dmu_pwd_tim4(aData)
        set_dmu_pwd_tim4 = aData
        write
    End Property

    Property Get get_dmu_pwd_tim3
        get_dmu_pwd_tim3 = read_dmu_pwd_tim3_value
    End Property

    Property Let set_dmu_pwd_tim3(aData)
        write_dmu_pwd_tim3_value = aData
        flag_dmu_pwd_tim3        = &H1
    End Property

    Property Get read_dmu_pwd_tim3
        read
        read_dmu_pwd_tim3 = read_dmu_pwd_tim3_value
    End Property

    Property Let write_dmu_pwd_tim3(aData)
        set_dmu_pwd_tim3 = aData
        write
    End Property

    Property Get get_dmu_pwd_tim2
        get_dmu_pwd_tim2 = read_dmu_pwd_tim2_value
    End Property

    Property Let set_dmu_pwd_tim2(aData)
        write_dmu_pwd_tim2_value = aData
        flag_dmu_pwd_tim2        = &H1
    End Property

    Property Get read_dmu_pwd_tim2
        read
        read_dmu_pwd_tim2 = read_dmu_pwd_tim2_value
    End Property

    Property Let write_dmu_pwd_tim2(aData)
        set_dmu_pwd_tim2 = aData
        write
    End Property

    Property Get get_dmu_pwd_tim1
        get_dmu_pwd_tim1 = read_dmu_pwd_tim1_value
    End Property

    Property Let set_dmu_pwd_tim1(aData)
        write_dmu_pwd_tim1_value = aData
        flag_dmu_pwd_tim1        = &H1
    End Property

    Property Get read_dmu_pwd_tim1
        read
        read_dmu_pwd_tim1 = read_dmu_pwd_tim1_value
    End Property

    Property Let write_dmu_pwd_tim1(aData)
        set_dmu_pwd_tim1 = aData
        write
    End Property

    Property Get get_dmu_pwd_tim0
        get_dmu_pwd_tim0 = read_dmu_pwd_tim0_value
    End Property

    Property Let set_dmu_pwd_tim0(aData)
        write_dmu_pwd_tim0_value = aData
        flag_dmu_pwd_tim0        = &H1
    End Property

    Property Get read_dmu_pwd_tim0
        read
        read_dmu_pwd_tim0 = read_dmu_pwd_tim0_value
    End Property

    Property Let write_dmu_pwd_tim0(aData)
        set_dmu_pwd_tim0 = aData
        write
    End Property

    Property Get get_dmu_pwd_spl
        get_dmu_pwd_spl = read_dmu_pwd_spl_value
    End Property

    Property Let set_dmu_pwd_spl(aData)
        write_dmu_pwd_spl_value = aData
        flag_dmu_pwd_spl        = &H1
    End Property

    Property Get read_dmu_pwd_spl
        read
        read_dmu_pwd_spl = read_dmu_pwd_spl_value
    End Property

    Property Let write_dmu_pwd_spl(aData)
        set_dmu_pwd_spl = aData
        write
    End Property

    Property Get get_dmu_pwd_qspi
        get_dmu_pwd_qspi = read_dmu_pwd_qspi_value
    End Property

    Property Let set_dmu_pwd_qspi(aData)
        write_dmu_pwd_qspi_value = aData
        flag_dmu_pwd_qspi        = &H1
    End Property

    Property Get read_dmu_pwd_qspi
        read
        read_dmu_pwd_qspi = read_dmu_pwd_qspi_value
    End Property

    Property Let write_dmu_pwd_qspi(aData)
        set_dmu_pwd_qspi = aData
        write
    End Property

    Property Get get_dmu_pwd_spi10t1s
        get_dmu_pwd_spi10t1s = read_dmu_pwd_spi10t1s_value
    End Property

    Property Let set_dmu_pwd_spi10t1s(aData)
        write_dmu_pwd_spi10t1s_value = aData
        flag_dmu_pwd_spi10t1s        = &H1
    End Property

    Property Get read_dmu_pwd_spi10t1s
        read
        read_dmu_pwd_spi10t1s = read_dmu_pwd_spi10t1s_value
    End Property

    Property Let write_dmu_pwd_spi10t1s(aData)
        set_dmu_pwd_spi10t1s = aData
        write
    End Property

    Property Get get_dmu_pwd_spi1
        get_dmu_pwd_spi1 = read_dmu_pwd_spi1_value
    End Property

    Property Let set_dmu_pwd_spi1(aData)
        write_dmu_pwd_spi1_value = aData
        flag_dmu_pwd_spi1        = &H1
    End Property

    Property Get read_dmu_pwd_spi1
        read
        read_dmu_pwd_spi1 = read_dmu_pwd_spi1_value
    End Property

    Property Let write_dmu_pwd_spi1(aData)
        set_dmu_pwd_spi1 = aData
        write
    End Property

    Property Get get_dmu_pwd_spi0
        get_dmu_pwd_spi0 = read_dmu_pwd_spi0_value
    End Property

    Property Let set_dmu_pwd_spi0(aData)
        write_dmu_pwd_spi0_value = aData
        flag_dmu_pwd_spi0        = &H1
    End Property

    Property Get read_dmu_pwd_spi0
        read
        read_dmu_pwd_spi0 = read_dmu_pwd_spi0_value
    End Property

    Property Let write_dmu_pwd_spi0(aData)
        set_dmu_pwd_spi0 = aData
        write
    End Property

    Property Get get_dmu_pwd_smu
        get_dmu_pwd_smu = read_dmu_pwd_smu_value
    End Property

    Property Let set_dmu_pwd_smu(aData)
        write_dmu_pwd_smu_value = aData
        flag_dmu_pwd_smu        = &H1
    End Property

    Property Get read_dmu_pwd_smu
        read
        read_dmu_pwd_smu = read_dmu_pwd_smu_value
    End Property

    Property Let write_dmu_pwd_smu(aData)
        set_dmu_pwd_smu = aData
        write
    End Property

    Property Get get_dmu_pwd_smc
        get_dmu_pwd_smc = read_dmu_pwd_smc_value
    End Property

    Property Let set_dmu_pwd_smc(aData)
        write_dmu_pwd_smc_value = aData
        flag_dmu_pwd_smc        = &H1
    End Property

    Property Get read_dmu_pwd_smc
        read
        read_dmu_pwd_smc = read_dmu_pwd_smc_value
    End Property

    Property Let write_dmu_pwd_smc(aData)
        set_dmu_pwd_smc = aData
        write
    End Property

    Property Get get_dmu_pwd_sdma
        get_dmu_pwd_sdma = read_dmu_pwd_sdma_value
    End Property

    Property Let set_dmu_pwd_sdma(aData)
        write_dmu_pwd_sdma_value = aData
        flag_dmu_pwd_sdma        = &H1
    End Property

    Property Get read_dmu_pwd_sdma
        read
        read_dmu_pwd_sdma = read_dmu_pwd_sdma_value
    End Property

    Property Let write_dmu_pwd_sdma(aData)
        set_dmu_pwd_sdma = aData
        write
    End Property

    Property Get get_dmu_pwd_sdm1
        get_dmu_pwd_sdm1 = read_dmu_pwd_sdm1_value
    End Property

    Property Let set_dmu_pwd_sdm1(aData)
        write_dmu_pwd_sdm1_value = aData
        flag_dmu_pwd_sdm1        = &H1
    End Property

    Property Get read_dmu_pwd_sdm1
        read
        read_dmu_pwd_sdm1 = read_dmu_pwd_sdm1_value
    End Property

    Property Let write_dmu_pwd_sdm1(aData)
        set_dmu_pwd_sdm1 = aData
        write
    End Property

    Property Get get_dmu_pwd_sdm0
        get_dmu_pwd_sdm0 = read_dmu_pwd_sdm0_value
    End Property

    Property Let set_dmu_pwd_sdm0(aData)
        write_dmu_pwd_sdm0_value = aData
        flag_dmu_pwd_sdm0        = &H1
    End Property

    Property Get read_dmu_pwd_sdm0
        read
        read_dmu_pwd_sdm0 = read_dmu_pwd_sdm0_value
    End Property

    Property Let write_dmu_pwd_sdm0(aData)
        set_dmu_pwd_sdm0 = aData
        write
    End Property

    Property Get get_dmu_pwd_sci1
        get_dmu_pwd_sci1 = read_dmu_pwd_sci1_value
    End Property

    Property Let set_dmu_pwd_sci1(aData)
        write_dmu_pwd_sci1_value = aData
        flag_dmu_pwd_sci1        = &H1
    End Property

    Property Get read_dmu_pwd_sci1
        read
        read_dmu_pwd_sci1 = read_dmu_pwd_sci1_value
    End Property

    Property Let write_dmu_pwd_sci1(aData)
        set_dmu_pwd_sci1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_dmu_pwd_ram_value = rightShift(data_low, 26) and &H1
        read_dmu_pwd_wdt_value = rightShift(data_low, 25) and &H1
        read_dmu_pwd_usb2_value = rightShift(data_low, 24) and &H1
        read_dmu_pwd_usb1_value = rightShift(data_low, 23) and &H1
        read_dmu_pwd_usb0_value = rightShift(data_low, 22) and &H1
        read_dmu_pwd_urt3_value = rightShift(data_low, 21) and &H1
        read_dmu_pwd_urt2_value = rightShift(data_low, 20) and &H1
        read_dmu_pwd_urt1_value = rightShift(data_low, 19) and &H1
        read_dmu_pwd_urt0_value = rightShift(data_low, 18) and &H1
        read_dmu_pwd_umc_value = rightShift(data_low, 17) and &H1
        read_dmu_pwd_tpb_value = rightShift(data_low, 16) and &H1
        read_dmu_pwd_tim4_value = rightShift(data_low, 15) and &H1
        read_dmu_pwd_tim3_value = rightShift(data_low, 14) and &H1
        read_dmu_pwd_tim2_value = rightShift(data_low, 13) and &H1
        read_dmu_pwd_tim1_value = rightShift(data_low, 12) and &H1
        read_dmu_pwd_tim0_value = rightShift(data_low, 11) and &H1
        read_dmu_pwd_spl_value = rightShift(data_low, 10) and &H1
        read_dmu_pwd_qspi_value = rightShift(data_low, 9) and &H1
        read_dmu_pwd_spi10t1s_value = rightShift(data_low, 8) and &H1
        read_dmu_pwd_spi1_value = rightShift(data_low, 7) and &H1
        read_dmu_pwd_spi0_value = rightShift(data_low, 6) and &H1
        read_dmu_pwd_smu_value = rightShift(data_low, 5) and &H1
        read_dmu_pwd_smc_value = rightShift(data_low, 4) and &H1
        read_dmu_pwd_sdma_value = rightShift(data_low, 3) and &H1
        read_dmu_pwd_sdm1_value = rightShift(data_low, 2) and &H1
        read_dmu_pwd_sdm0_value = rightShift(data_low, 1) and &H1
        dmu_pwd_sci1_mask = &H1
        if data_low > LONG_MAX then
            if dmu_pwd_sci1_mask = mask then
                read_dmu_pwd_sci1_value = data_low
            else
                read_dmu_pwd_sci1_value = (data_low - H8000_0000) and dmu_pwd_sci1_mask
            end If
        else
            read_dmu_pwd_sci1_value = data_low and dmu_pwd_sci1_mask
        end If

    End Sub

    Sub write
        If flag_dmu_pwd_ram = &H0 or flag_dmu_pwd_wdt = &H0 or flag_dmu_pwd_usb2 = &H0 or flag_dmu_pwd_usb1 = &H0 or flag_dmu_pwd_usb0 = &H0 or flag_dmu_pwd_urt3 = &H0 or flag_dmu_pwd_urt2 = &H0 or flag_dmu_pwd_urt1 = &H0 or flag_dmu_pwd_urt0 = &H0 or flag_dmu_pwd_umc = &H0 or flag_dmu_pwd_tpb = &H0 or flag_dmu_pwd_tim4 = &H0 or flag_dmu_pwd_tim3 = &H0 or flag_dmu_pwd_tim2 = &H0 or flag_dmu_pwd_tim1 = &H0 or flag_dmu_pwd_tim0 = &H0 or flag_dmu_pwd_spl = &H0 or flag_dmu_pwd_qspi = &H0 or flag_dmu_pwd_spi10t1s = &H0 or flag_dmu_pwd_spi1 = &H0 or flag_dmu_pwd_spi0 = &H0 or flag_dmu_pwd_smu = &H0 or flag_dmu_pwd_smc = &H0 or flag_dmu_pwd_sdma = &H0 or flag_dmu_pwd_sdm1 = &H0 or flag_dmu_pwd_sdm0 = &H0 or flag_dmu_pwd_sci1 = &H0 Then read
        If flag_dmu_pwd_ram = &H0 Then write_dmu_pwd_ram_value = get_dmu_pwd_ram
        If flag_dmu_pwd_wdt = &H0 Then write_dmu_pwd_wdt_value = get_dmu_pwd_wdt
        If flag_dmu_pwd_usb2 = &H0 Then write_dmu_pwd_usb2_value = get_dmu_pwd_usb2
        If flag_dmu_pwd_usb1 = &H0 Then write_dmu_pwd_usb1_value = get_dmu_pwd_usb1
        If flag_dmu_pwd_usb0 = &H0 Then write_dmu_pwd_usb0_value = get_dmu_pwd_usb0
        If flag_dmu_pwd_urt3 = &H0 Then write_dmu_pwd_urt3_value = get_dmu_pwd_urt3
        If flag_dmu_pwd_urt2 = &H0 Then write_dmu_pwd_urt2_value = get_dmu_pwd_urt2
        If flag_dmu_pwd_urt1 = &H0 Then write_dmu_pwd_urt1_value = get_dmu_pwd_urt1
        If flag_dmu_pwd_urt0 = &H0 Then write_dmu_pwd_urt0_value = get_dmu_pwd_urt0
        If flag_dmu_pwd_umc = &H0 Then write_dmu_pwd_umc_value = get_dmu_pwd_umc
        If flag_dmu_pwd_tpb = &H0 Then write_dmu_pwd_tpb_value = get_dmu_pwd_tpb
        If flag_dmu_pwd_tim4 = &H0 Then write_dmu_pwd_tim4_value = get_dmu_pwd_tim4
        If flag_dmu_pwd_tim3 = &H0 Then write_dmu_pwd_tim3_value = get_dmu_pwd_tim3
        If flag_dmu_pwd_tim2 = &H0 Then write_dmu_pwd_tim2_value = get_dmu_pwd_tim2
        If flag_dmu_pwd_tim1 = &H0 Then write_dmu_pwd_tim1_value = get_dmu_pwd_tim1
        If flag_dmu_pwd_tim0 = &H0 Then write_dmu_pwd_tim0_value = get_dmu_pwd_tim0
        If flag_dmu_pwd_spl = &H0 Then write_dmu_pwd_spl_value = get_dmu_pwd_spl
        If flag_dmu_pwd_qspi = &H0 Then write_dmu_pwd_qspi_value = get_dmu_pwd_qspi
        If flag_dmu_pwd_spi10t1s = &H0 Then write_dmu_pwd_spi10t1s_value = get_dmu_pwd_spi10t1s
        If flag_dmu_pwd_spi1 = &H0 Then write_dmu_pwd_spi1_value = get_dmu_pwd_spi1
        If flag_dmu_pwd_spi0 = &H0 Then write_dmu_pwd_spi0_value = get_dmu_pwd_spi0
        If flag_dmu_pwd_smu = &H0 Then write_dmu_pwd_smu_value = get_dmu_pwd_smu
        If flag_dmu_pwd_smc = &H0 Then write_dmu_pwd_smc_value = get_dmu_pwd_smc
        If flag_dmu_pwd_sdma = &H0 Then write_dmu_pwd_sdma_value = get_dmu_pwd_sdma
        If flag_dmu_pwd_sdm1 = &H0 Then write_dmu_pwd_sdm1_value = get_dmu_pwd_sdm1
        If flag_dmu_pwd_sdm0 = &H0 Then write_dmu_pwd_sdm0_value = get_dmu_pwd_sdm0
        If flag_dmu_pwd_sci1 = &H0 Then write_dmu_pwd_sci1_value = get_dmu_pwd_sci1

        regValue = leftShift((write_dmu_pwd_ram_value and &H1), 26) + leftShift((write_dmu_pwd_wdt_value and &H1), 25) + leftShift((write_dmu_pwd_usb2_value and &H1), 24) + leftShift((write_dmu_pwd_usb1_value and &H1), 23) + leftShift((write_dmu_pwd_usb0_value and &H1), 22) + leftShift((write_dmu_pwd_urt3_value and &H1), 21) + leftShift((write_dmu_pwd_urt2_value and &H1), 20) + leftShift((write_dmu_pwd_urt1_value and &H1), 19) + leftShift((write_dmu_pwd_urt0_value and &H1), 18) + leftShift((write_dmu_pwd_umc_value and &H1), 17) + leftShift((write_dmu_pwd_tpb_value and &H1), 16) + leftShift((write_dmu_pwd_tim4_value and &H1), 15) + leftShift((write_dmu_pwd_tim3_value and &H1), 14) + leftShift((write_dmu_pwd_tim2_value and &H1), 13) + leftShift((write_dmu_pwd_tim1_value and &H1), 12) + leftShift((write_dmu_pwd_tim0_value and &H1), 11) + leftShift((write_dmu_pwd_spl_value and &H1), 10) + leftShift((write_dmu_pwd_qspi_value and &H1), 9) + leftShift((write_dmu_pwd_spi10t1s_value and &H1), 8) + leftShift((write_dmu_pwd_spi1_value and &H1), 7) + leftShift((write_dmu_pwd_spi0_value and &H1), 6) + leftShift((write_dmu_pwd_smu_value and &H1), 5) + leftShift((write_dmu_pwd_smc_value and &H1), 4) + leftShift((write_dmu_pwd_sdma_value and &H1), 3) + leftShift((write_dmu_pwd_sdm1_value and &H1), 2) + leftShift((write_dmu_pwd_sdm0_value and &H1), 1) + leftShift((write_dmu_pwd_sci1_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_dmu_pwd_ram_value = rightShift(data_low, 26) and &H1
        read_dmu_pwd_wdt_value = rightShift(data_low, 25) and &H1
        read_dmu_pwd_usb2_value = rightShift(data_low, 24) and &H1
        read_dmu_pwd_usb1_value = rightShift(data_low, 23) and &H1
        read_dmu_pwd_usb0_value = rightShift(data_low, 22) and &H1
        read_dmu_pwd_urt3_value = rightShift(data_low, 21) and &H1
        read_dmu_pwd_urt2_value = rightShift(data_low, 20) and &H1
        read_dmu_pwd_urt1_value = rightShift(data_low, 19) and &H1
        read_dmu_pwd_urt0_value = rightShift(data_low, 18) and &H1
        read_dmu_pwd_umc_value = rightShift(data_low, 17) and &H1
        read_dmu_pwd_tpb_value = rightShift(data_low, 16) and &H1
        read_dmu_pwd_tim4_value = rightShift(data_low, 15) and &H1
        read_dmu_pwd_tim3_value = rightShift(data_low, 14) and &H1
        read_dmu_pwd_tim2_value = rightShift(data_low, 13) and &H1
        read_dmu_pwd_tim1_value = rightShift(data_low, 12) and &H1
        read_dmu_pwd_tim0_value = rightShift(data_low, 11) and &H1
        read_dmu_pwd_spl_value = rightShift(data_low, 10) and &H1
        read_dmu_pwd_qspi_value = rightShift(data_low, 9) and &H1
        read_dmu_pwd_spi10t1s_value = rightShift(data_low, 8) and &H1
        read_dmu_pwd_spi1_value = rightShift(data_low, 7) and &H1
        read_dmu_pwd_spi0_value = rightShift(data_low, 6) and &H1
        read_dmu_pwd_smu_value = rightShift(data_low, 5) and &H1
        read_dmu_pwd_smc_value = rightShift(data_low, 4) and &H1
        read_dmu_pwd_sdma_value = rightShift(data_low, 3) and &H1
        read_dmu_pwd_sdm1_value = rightShift(data_low, 2) and &H1
        read_dmu_pwd_sdm0_value = rightShift(data_low, 1) and &H1
        dmu_pwd_sci1_mask = &H1
        if data_low > LONG_MAX then
            if dmu_pwd_sci1_mask = mask then
                read_dmu_pwd_sci1_value = data_low
            else
                read_dmu_pwd_sci1_value = (data_low - H8000_0000) and dmu_pwd_sci1_mask
            end If
        else
            read_dmu_pwd_sci1_value = data_low and dmu_pwd_sci1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_dmu_pwd_ram_value = &H0
        flag_dmu_pwd_ram        = &H0
        write_dmu_pwd_wdt_value = &H0
        flag_dmu_pwd_wdt        = &H0
        write_dmu_pwd_usb2_value = &H0
        flag_dmu_pwd_usb2        = &H0
        write_dmu_pwd_usb1_value = &H0
        flag_dmu_pwd_usb1        = &H0
        write_dmu_pwd_usb0_value = &H0
        flag_dmu_pwd_usb0        = &H0
        write_dmu_pwd_urt3_value = &H0
        flag_dmu_pwd_urt3        = &H0
        write_dmu_pwd_urt2_value = &H0
        flag_dmu_pwd_urt2        = &H0
        write_dmu_pwd_urt1_value = &H0
        flag_dmu_pwd_urt1        = &H0
        write_dmu_pwd_urt0_value = &H0
        flag_dmu_pwd_urt0        = &H0
        write_dmu_pwd_umc_value = &H0
        flag_dmu_pwd_umc        = &H0
        write_dmu_pwd_tpb_value = &H0
        flag_dmu_pwd_tpb        = &H0
        write_dmu_pwd_tim4_value = &H0
        flag_dmu_pwd_tim4        = &H0
        write_dmu_pwd_tim3_value = &H0
        flag_dmu_pwd_tim3        = &H0
        write_dmu_pwd_tim2_value = &H0
        flag_dmu_pwd_tim2        = &H0
        write_dmu_pwd_tim1_value = &H0
        flag_dmu_pwd_tim1        = &H0
        write_dmu_pwd_tim0_value = &H0
        flag_dmu_pwd_tim0        = &H0
        write_dmu_pwd_spl_value = &H0
        flag_dmu_pwd_spl        = &H0
        write_dmu_pwd_qspi_value = &H0
        flag_dmu_pwd_qspi        = &H0
        write_dmu_pwd_spi10t1s_value = &H0
        flag_dmu_pwd_spi10t1s        = &H0
        write_dmu_pwd_spi1_value = &H0
        flag_dmu_pwd_spi1        = &H0
        write_dmu_pwd_spi0_value = &H0
        flag_dmu_pwd_spi0        = &H0
        write_dmu_pwd_smu_value = &H0
        flag_dmu_pwd_smu        = &H0
        write_dmu_pwd_smc_value = &H0
        flag_dmu_pwd_smc        = &H0
        write_dmu_pwd_sdma_value = &H0
        flag_dmu_pwd_sdma        = &H0
        write_dmu_pwd_sdm1_value = &H0
        flag_dmu_pwd_sdm1        = &H0
        write_dmu_pwd_sdm0_value = &H0
        flag_dmu_pwd_sdm0        = &H0
        write_dmu_pwd_sci1_value = &H0
        flag_dmu_pwd_sci1        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class DMU_INSTANCE

    Public dmu_status
    Public dmu_clk_sel
    Public dmu_clkout_sel
    Public dmu_timer_enable_sel
    Public dmu_pm
    Public dmu_rst_blk1
    Public dmu_rst_blk2
    Public dmu_pwd_blk1
    Public dmu_pwd_blk2


    Public default function Init(aBaseAddr)
        Set dmu_status = (New REGISTER_DMU_dmu_status)(aBaseAddr, 32)
        Set dmu_clk_sel = (New REGISTER_DMU_dmu_clk_sel)(aBaseAddr, 32)
        Set dmu_clkout_sel = (New REGISTER_DMU_dmu_clkout_sel)(aBaseAddr, 32)
        Set dmu_timer_enable_sel = (New REGISTER_DMU_dmu_timer_enable_sel)(aBaseAddr, 32)
        Set dmu_pm = (New REGISTER_DMU_dmu_pm)(aBaseAddr, 32)
        Set dmu_rst_blk1 = (New REGISTER_DMU_dmu_rst_blk1)(aBaseAddr, 32)
        Set dmu_rst_blk2 = (New REGISTER_DMU_dmu_rst_blk2)(aBaseAddr, 32)
        Set dmu_pwd_blk1 = (New REGISTER_DMU_dmu_pwd_blk1)(aBaseAddr, 32)
        Set dmu_pwd_blk2 = (New REGISTER_DMU_dmu_pwd_blk2)(aBaseAddr, 32)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set DMU = CreateObject("System.Collections.ArrayList")
DMU.Add ((New DMU_INSTANCE)(&H40146000))


