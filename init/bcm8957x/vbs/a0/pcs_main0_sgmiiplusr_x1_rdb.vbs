

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


'' @REGISTER : PCS_MAIN0_SGMIIPLUSR_X1_setup
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' refclk_sel                                 [15:12]          get_refclk_sel
''                                                             set_refclk_sel
''                                                             read_refclk_sel
''                                                             write_refclk_sel
''---------------------------------------------------------------------------------
'' port_mode_sel                              [6:4]            get_port_mode_sel
''                                                             set_port_mode_sel
''                                                             read_port_mode_sel
''                                                             write_port_mode_sel
''---------------------------------------------------------------------------------
'' single_port_mode                           [3:3]            get_single_port_mode
''                                                             set_single_port_mode
''                                                             read_single_port_mode
''                                                             write_single_port_mode
''---------------------------------------------------------------------------------
'' stand_alone_mode                           [2:2]            get_stand_alone_mode
''                                                             set_stand_alone_mode
''                                                             read_stand_alone_mode
''                                                             write_stand_alone_mode
''---------------------------------------------------------------------------------
'' pmd_ieee_rst_decouple_en                   [1:1]            get_pmd_ieee_rst_decouple_en
''                                                             set_pmd_ieee_rst_decouple_en
''                                                             read_pmd_ieee_rst_decouple_en
''                                                             write_pmd_ieee_rst_decouple_en
''---------------------------------------------------------------------------------
'' mdioreg_rst_sw                             [0:0]            get_mdioreg_rst_sw
''                                                             set_mdioreg_rst_sw
''                                                             read_mdioreg_rst_sw
''                                                             write_mdioreg_rst_sw
''---------------------------------------------------------------------------------
Class REGISTER_PCS_MAIN0_SGMIIPLUSR_X1_setup
    Private write_refclk_sel_value
    Private read_refclk_sel_value
    Private flag_refclk_sel
    Private write_port_mode_sel_value
    Private read_port_mode_sel_value
    Private flag_port_mode_sel
    Private write_single_port_mode_value
    Private read_single_port_mode_value
    Private flag_single_port_mode
    Private write_stand_alone_mode_value
    Private read_stand_alone_mode_value
    Private flag_stand_alone_mode
    Private write_pmd_ieee_rst_decouple_en_value
    Private read_pmd_ieee_rst_decouple_en_value
    Private flag_pmd_ieee_rst_decouple_en
    Private write_mdioreg_rst_sw_value
    Private read_mdioreg_rst_sw_value
    Private flag_mdioreg_rst_sw

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

    Property Get get_refclk_sel
        get_refclk_sel = read_refclk_sel_value
    End Property

    Property Let set_refclk_sel(aData)
        write_refclk_sel_value = aData
        flag_refclk_sel        = &H1
    End Property

    Property Get read_refclk_sel
        read
        read_refclk_sel = read_refclk_sel_value
    End Property

    Property Let write_refclk_sel(aData)
        set_refclk_sel = aData
        write
    End Property

    Property Get get_port_mode_sel
        get_port_mode_sel = read_port_mode_sel_value
    End Property

    Property Let set_port_mode_sel(aData)
        write_port_mode_sel_value = aData
        flag_port_mode_sel        = &H1
    End Property

    Property Get read_port_mode_sel
        read
        read_port_mode_sel = read_port_mode_sel_value
    End Property

    Property Let write_port_mode_sel(aData)
        set_port_mode_sel = aData
        write
    End Property

    Property Get get_single_port_mode
        get_single_port_mode = read_single_port_mode_value
    End Property

    Property Let set_single_port_mode(aData)
        write_single_port_mode_value = aData
        flag_single_port_mode        = &H1
    End Property

    Property Get read_single_port_mode
        read
        read_single_port_mode = read_single_port_mode_value
    End Property

    Property Let write_single_port_mode(aData)
        set_single_port_mode = aData
        write
    End Property

    Property Get get_stand_alone_mode
        get_stand_alone_mode = read_stand_alone_mode_value
    End Property

    Property Let set_stand_alone_mode(aData)
        write_stand_alone_mode_value = aData
        flag_stand_alone_mode        = &H1
    End Property

    Property Get read_stand_alone_mode
        read
        read_stand_alone_mode = read_stand_alone_mode_value
    End Property

    Property Let write_stand_alone_mode(aData)
        set_stand_alone_mode = aData
        write
    End Property

    Property Get get_pmd_ieee_rst_decouple_en
        get_pmd_ieee_rst_decouple_en = read_pmd_ieee_rst_decouple_en_value
    End Property

    Property Let set_pmd_ieee_rst_decouple_en(aData)
        write_pmd_ieee_rst_decouple_en_value = aData
        flag_pmd_ieee_rst_decouple_en        = &H1
    End Property

    Property Get read_pmd_ieee_rst_decouple_en
        read
        read_pmd_ieee_rst_decouple_en = read_pmd_ieee_rst_decouple_en_value
    End Property

    Property Let write_pmd_ieee_rst_decouple_en(aData)
        set_pmd_ieee_rst_decouple_en = aData
        write
    End Property

    Property Get get_mdioreg_rst_sw
        get_mdioreg_rst_sw = read_mdioreg_rst_sw_value
    End Property

    Property Let set_mdioreg_rst_sw(aData)
        write_mdioreg_rst_sw_value = aData
        flag_mdioreg_rst_sw        = &H1
    End Property

    Property Get read_mdioreg_rst_sw
        read
        read_mdioreg_rst_sw = read_mdioreg_rst_sw_value
    End Property

    Property Let write_mdioreg_rst_sw(aData)
        set_mdioreg_rst_sw = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_refclk_sel_value = rightShift(data_low, 12) and &Hf
        read_port_mode_sel_value = rightShift(data_low, 4) and &H7
        read_single_port_mode_value = rightShift(data_low, 3) and &H1
        read_stand_alone_mode_value = rightShift(data_low, 2) and &H1
        read_pmd_ieee_rst_decouple_en_value = rightShift(data_low, 1) and &H1
        mdioreg_rst_sw_mask = &H1
        if data_low > LONG_MAX then
            if mdioreg_rst_sw_mask = mask then
                read_mdioreg_rst_sw_value = data_low
            else
                read_mdioreg_rst_sw_value = (data_low - H8000_0000) and mdioreg_rst_sw_mask
            end If
        else
            read_mdioreg_rst_sw_value = data_low and mdioreg_rst_sw_mask
        end If

    End Sub

    Sub write
        If flag_refclk_sel = &H0 or flag_port_mode_sel = &H0 or flag_single_port_mode = &H0 or flag_stand_alone_mode = &H0 or flag_pmd_ieee_rst_decouple_en = &H0 or flag_mdioreg_rst_sw = &H0 Then read
        If flag_refclk_sel = &H0 Then write_refclk_sel_value = get_refclk_sel
        If flag_port_mode_sel = &H0 Then write_port_mode_sel_value = get_port_mode_sel
        If flag_single_port_mode = &H0 Then write_single_port_mode_value = get_single_port_mode
        If flag_stand_alone_mode = &H0 Then write_stand_alone_mode_value = get_stand_alone_mode
        If flag_pmd_ieee_rst_decouple_en = &H0 Then write_pmd_ieee_rst_decouple_en_value = get_pmd_ieee_rst_decouple_en
        If flag_mdioreg_rst_sw = &H0 Then write_mdioreg_rst_sw_value = get_mdioreg_rst_sw

        regValue = leftShift((write_refclk_sel_value and &Hf), 12) + leftShift((write_port_mode_sel_value and &H7), 4) + leftShift((write_single_port_mode_value and &H1), 3) + leftShift((write_stand_alone_mode_value and &H1), 2) + leftShift((write_pmd_ieee_rst_decouple_en_value and &H1), 1) + leftShift((write_mdioreg_rst_sw_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_refclk_sel_value = rightShift(data_low, 12) and &Hf
        read_port_mode_sel_value = rightShift(data_low, 4) and &H7
        read_single_port_mode_value = rightShift(data_low, 3) and &H1
        read_stand_alone_mode_value = rightShift(data_low, 2) and &H1
        read_pmd_ieee_rst_decouple_en_value = rightShift(data_low, 1) and &H1
        mdioreg_rst_sw_mask = &H1
        if data_low > LONG_MAX then
            if mdioreg_rst_sw_mask = mask then
                read_mdioreg_rst_sw_value = data_low
            else
                read_mdioreg_rst_sw_value = (data_low - H8000_0000) and mdioreg_rst_sw_mask
            end If
        else
            read_mdioreg_rst_sw_value = data_low and mdioreg_rst_sw_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_refclk_sel_value = &H0
        flag_refclk_sel        = &H0
        write_port_mode_sel_value = &H0
        flag_port_mode_sel        = &H0
        write_single_port_mode_value = &H0
        flag_single_port_mode        = &H0
        write_stand_alone_mode_value = &H0
        flag_stand_alone_mode        = &H0
        write_pmd_ieee_rst_decouple_en_value = &H0
        flag_pmd_ieee_rst_decouple_en        = &H0
        write_mdioreg_rst_sw_value = &H0
        flag_mdioreg_rst_sw        = &H0
    End Sub
End Class


'' @REGISTER : PCS_MAIN0_SGMIIPLUSR_X1_tick_control_1_sgmiiplusr_x1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' tick_override                              [15:15]          get_tick_override
''                                                             set_tick_override
''                                                             read_tick_override
''                                                             write_tick_override
''---------------------------------------------------------------------------------
'' tick_numerator_upper                       [14:0]           get_tick_numerator_upper
''                                                             set_tick_numerator_upper
''                                                             read_tick_numerator_upper
''                                                             write_tick_numerator_upper
''---------------------------------------------------------------------------------
Class REGISTER_PCS_MAIN0_SGMIIPLUSR_X1_tick_control_1_sgmiiplusr_x1
    Private write_tick_override_value
    Private read_tick_override_value
    Private flag_tick_override
    Private write_tick_numerator_upper_value
    Private read_tick_numerator_upper_value
    Private flag_tick_numerator_upper

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

    Property Get get_tick_override
        get_tick_override = read_tick_override_value
    End Property

    Property Let set_tick_override(aData)
        write_tick_override_value = aData
        flag_tick_override        = &H1
    End Property

    Property Get read_tick_override
        read
        read_tick_override = read_tick_override_value
    End Property

    Property Let write_tick_override(aData)
        set_tick_override = aData
        write
    End Property

    Property Get get_tick_numerator_upper
        get_tick_numerator_upper = read_tick_numerator_upper_value
    End Property

    Property Let set_tick_numerator_upper(aData)
        write_tick_numerator_upper_value = aData
        flag_tick_numerator_upper        = &H1
    End Property

    Property Get read_tick_numerator_upper
        read
        read_tick_numerator_upper = read_tick_numerator_upper_value
    End Property

    Property Let write_tick_numerator_upper(aData)
        set_tick_numerator_upper = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_tick_override_value = rightShift(data_low, 15) and &H1
        tick_numerator_upper_mask = &H7fff
        if data_low > LONG_MAX then
            if tick_numerator_upper_mask = mask then
                read_tick_numerator_upper_value = data_low
            else
                read_tick_numerator_upper_value = (data_low - H8000_0000) and tick_numerator_upper_mask
            end If
        else
            read_tick_numerator_upper_value = data_low and tick_numerator_upper_mask
        end If

    End Sub

    Sub write
        If flag_tick_override = &H0 or flag_tick_numerator_upper = &H0 Then read
        If flag_tick_override = &H0 Then write_tick_override_value = get_tick_override
        If flag_tick_numerator_upper = &H0 Then write_tick_numerator_upper_value = get_tick_numerator_upper

        regValue = leftShift((write_tick_override_value and &H1), 15) + leftShift((write_tick_numerator_upper_value and &H7fff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_tick_override_value = rightShift(data_low, 15) and &H1
        tick_numerator_upper_mask = &H7fff
        if data_low > LONG_MAX then
            if tick_numerator_upper_mask = mask then
                read_tick_numerator_upper_value = data_low
            else
                read_tick_numerator_upper_value = (data_low - H8000_0000) and tick_numerator_upper_mask
            end If
        else
            read_tick_numerator_upper_value = data_low and tick_numerator_upper_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_tick_override_value = &H0
        flag_tick_override        = &H0
        write_tick_numerator_upper_value = &H0
        flag_tick_numerator_upper        = &H0
    End Sub
End Class


'' @REGISTER : PCS_MAIN0_SGMIIPLUSR_X1_tick_control_0_sgmiiplusr_x1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' tick_numerator_lower                       [15:12]          get_tick_numerator_lower
''                                                             set_tick_numerator_lower
''                                                             read_tick_numerator_lower
''                                                             write_tick_numerator_lower
''---------------------------------------------------------------------------------
'' tick_denominator                           [11:2]           get_tick_denominator
''                                                             set_tick_denominator
''                                                             read_tick_denominator
''                                                             write_tick_denominator
''---------------------------------------------------------------------------------
Class REGISTER_PCS_MAIN0_SGMIIPLUSR_X1_tick_control_0_sgmiiplusr_x1
    Private write_tick_numerator_lower_value
    Private read_tick_numerator_lower_value
    Private flag_tick_numerator_lower
    Private write_tick_denominator_value
    Private read_tick_denominator_value
    Private flag_tick_denominator

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

    Property Get get_tick_numerator_lower
        get_tick_numerator_lower = read_tick_numerator_lower_value
    End Property

    Property Let set_tick_numerator_lower(aData)
        write_tick_numerator_lower_value = aData
        flag_tick_numerator_lower        = &H1
    End Property

    Property Get read_tick_numerator_lower
        read
        read_tick_numerator_lower = read_tick_numerator_lower_value
    End Property

    Property Let write_tick_numerator_lower(aData)
        set_tick_numerator_lower = aData
        write
    End Property

    Property Get get_tick_denominator
        get_tick_denominator = read_tick_denominator_value
    End Property

    Property Let set_tick_denominator(aData)
        write_tick_denominator_value = aData
        flag_tick_denominator        = &H1
    End Property

    Property Get read_tick_denominator
        read
        read_tick_denominator = read_tick_denominator_value
    End Property

    Property Let write_tick_denominator(aData)
        set_tick_denominator = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_tick_numerator_lower_value = rightShift(data_low, 12) and &Hf
        read_tick_denominator_value = rightShift(data_low, 2) and &H3ff

    End Sub

    Sub write
        If flag_tick_numerator_lower = &H0 or flag_tick_denominator = &H0 Then read
        If flag_tick_numerator_lower = &H0 Then write_tick_numerator_lower_value = get_tick_numerator_lower
        If flag_tick_denominator = &H0 Then write_tick_denominator_value = get_tick_denominator

        regValue = leftShift((write_tick_numerator_lower_value and &Hf), 12) + leftShift((write_tick_denominator_value and &H3ff), 2)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_tick_numerator_lower_value = rightShift(data_low, 12) and &Hf
        read_tick_denominator_value = rightShift(data_low, 2) and &H3ff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_tick_numerator_lower_value = &H0
        flag_tick_numerator_lower        = &H0
        write_tick_denominator_value = &H0
        flag_tick_denominator        = &H0
    End Sub
End Class


'' @REGISTER : PCS_MAIN0_SGMIIPLUSR_X1_loopback_control_sgmiiplusr_x1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' remote_pcs_loopback_enable                 [15:12]          get_remote_pcs_loopback_enable
''                                                             set_remote_pcs_loopback_enable
''                                                             read_remote_pcs_loopback_enable
''                                                             write_remote_pcs_loopback_enable
''---------------------------------------------------------------------------------
'' remote_pmd_loopback_enable                 [11:8]           get_remote_pmd_loopback_enable
''                                                             set_remote_pmd_loopback_enable
''                                                             read_remote_pmd_loopback_enable
''                                                             write_remote_pmd_loopback_enable
''---------------------------------------------------------------------------------
'' local_pcs_loopback_enable                  [7:4]            get_local_pcs_loopback_enable
''                                                             set_local_pcs_loopback_enable
''                                                             read_local_pcs_loopback_enable
''                                                             write_local_pcs_loopback_enable
''---------------------------------------------------------------------------------
Class REGISTER_PCS_MAIN0_SGMIIPLUSR_X1_loopback_control_sgmiiplusr_x1
    Private write_remote_pcs_loopback_enable_value
    Private read_remote_pcs_loopback_enable_value
    Private flag_remote_pcs_loopback_enable
    Private write_remote_pmd_loopback_enable_value
    Private read_remote_pmd_loopback_enable_value
    Private flag_remote_pmd_loopback_enable
    Private write_local_pcs_loopback_enable_value
    Private read_local_pcs_loopback_enable_value
    Private flag_local_pcs_loopback_enable

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

    Property Get get_remote_pcs_loopback_enable
        get_remote_pcs_loopback_enable = read_remote_pcs_loopback_enable_value
    End Property

    Property Let set_remote_pcs_loopback_enable(aData)
        write_remote_pcs_loopback_enable_value = aData
        flag_remote_pcs_loopback_enable        = &H1
    End Property

    Property Get read_remote_pcs_loopback_enable
        read
        read_remote_pcs_loopback_enable = read_remote_pcs_loopback_enable_value
    End Property

    Property Let write_remote_pcs_loopback_enable(aData)
        set_remote_pcs_loopback_enable = aData
        write
    End Property

    Property Get get_remote_pmd_loopback_enable
        get_remote_pmd_loopback_enable = read_remote_pmd_loopback_enable_value
    End Property

    Property Let set_remote_pmd_loopback_enable(aData)
        write_remote_pmd_loopback_enable_value = aData
        flag_remote_pmd_loopback_enable        = &H1
    End Property

    Property Get read_remote_pmd_loopback_enable
        read
        read_remote_pmd_loopback_enable = read_remote_pmd_loopback_enable_value
    End Property

    Property Let write_remote_pmd_loopback_enable(aData)
        set_remote_pmd_loopback_enable = aData
        write
    End Property

    Property Get get_local_pcs_loopback_enable
        get_local_pcs_loopback_enable = read_local_pcs_loopback_enable_value
    End Property

    Property Let set_local_pcs_loopback_enable(aData)
        write_local_pcs_loopback_enable_value = aData
        flag_local_pcs_loopback_enable        = &H1
    End Property

    Property Get read_local_pcs_loopback_enable
        read
        read_local_pcs_loopback_enable = read_local_pcs_loopback_enable_value
    End Property

    Property Let write_local_pcs_loopback_enable(aData)
        set_local_pcs_loopback_enable = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_remote_pcs_loopback_enable_value = rightShift(data_low, 12) and &Hf
        read_remote_pmd_loopback_enable_value = rightShift(data_low, 8) and &Hf
        read_local_pcs_loopback_enable_value = rightShift(data_low, 4) and &Hf

    End Sub

    Sub write
        If flag_remote_pcs_loopback_enable = &H0 or flag_remote_pmd_loopback_enable = &H0 or flag_local_pcs_loopback_enable = &H0 Then read
        If flag_remote_pcs_loopback_enable = &H0 Then write_remote_pcs_loopback_enable_value = get_remote_pcs_loopback_enable
        If flag_remote_pmd_loopback_enable = &H0 Then write_remote_pmd_loopback_enable_value = get_remote_pmd_loopback_enable
        If flag_local_pcs_loopback_enable = &H0 Then write_local_pcs_loopback_enable_value = get_local_pcs_loopback_enable

        regValue = leftShift((write_remote_pcs_loopback_enable_value and &Hf), 12) + leftShift((write_remote_pmd_loopback_enable_value and &Hf), 8) + leftShift((write_local_pcs_loopback_enable_value and &Hf), 4)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_remote_pcs_loopback_enable_value = rightShift(data_low, 12) and &Hf
        read_remote_pmd_loopback_enable_value = rightShift(data_low, 8) and &Hf
        read_local_pcs_loopback_enable_value = rightShift(data_low, 4) and &Hf

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_remote_pcs_loopback_enable_value = &H0
        flag_remote_pcs_loopback_enable        = &H0
        write_remote_pmd_loopback_enable_value = &H0
        flag_remote_pmd_loopback_enable        = &H0
        write_local_pcs_loopback_enable_value = &H0
        flag_local_pcs_loopback_enable        = &H0
    End Sub
End Class


'' @REGISTER : PCS_MAIN0_SGMIIPLUSR_X1_serdesid
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' rev_letter                                 [15:14]          get_rev_letter
''                                                             set_rev_letter
''                                                             read_rev_letter
''                                                             write_rev_letter
''---------------------------------------------------------------------------------
'' rev_number                                 [13:11]          get_rev_number
''                                                             set_rev_number
''                                                             read_rev_number
''                                                             write_rev_number
''---------------------------------------------------------------------------------
'' bonding                                    [10:9]           get_bonding
''                                                             set_bonding
''                                                             read_bonding
''                                                             write_bonding
''---------------------------------------------------------------------------------
'' tech_proc                                  [8:6]            get_tech_proc
''                                                             set_tech_proc
''                                                             read_tech_proc
''                                                             write_tech_proc
''---------------------------------------------------------------------------------
'' model_number                               [5:0]            get_model_number
''                                                             set_model_number
''                                                             read_model_number
''                                                             write_model_number
''---------------------------------------------------------------------------------
Class REGISTER_PCS_MAIN0_SGMIIPLUSR_X1_serdesid
    Private write_rev_letter_value
    Private read_rev_letter_value
    Private flag_rev_letter
    Private write_rev_number_value
    Private read_rev_number_value
    Private flag_rev_number
    Private write_bonding_value
    Private read_bonding_value
    Private flag_bonding
    Private write_tech_proc_value
    Private read_tech_proc_value
    Private flag_tech_proc
    Private write_model_number_value
    Private read_model_number_value
    Private flag_model_number

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

    Property Get get_rev_letter
        get_rev_letter = read_rev_letter_value
    End Property

    Property Let set_rev_letter(aData)
        write_rev_letter_value = aData
        flag_rev_letter        = &H1
    End Property

    Property Get read_rev_letter
        read
        read_rev_letter = read_rev_letter_value
    End Property

    Property Let write_rev_letter(aData)
        set_rev_letter = aData
        write
    End Property

    Property Get get_rev_number
        get_rev_number = read_rev_number_value
    End Property

    Property Let set_rev_number(aData)
        write_rev_number_value = aData
        flag_rev_number        = &H1
    End Property

    Property Get read_rev_number
        read
        read_rev_number = read_rev_number_value
    End Property

    Property Let write_rev_number(aData)
        set_rev_number = aData
        write
    End Property

    Property Get get_bonding
        get_bonding = read_bonding_value
    End Property

    Property Let set_bonding(aData)
        write_bonding_value = aData
        flag_bonding        = &H1
    End Property

    Property Get read_bonding
        read
        read_bonding = read_bonding_value
    End Property

    Property Let write_bonding(aData)
        set_bonding = aData
        write
    End Property

    Property Get get_tech_proc
        get_tech_proc = read_tech_proc_value
    End Property

    Property Let set_tech_proc(aData)
        write_tech_proc_value = aData
        flag_tech_proc        = &H1
    End Property

    Property Get read_tech_proc
        read
        read_tech_proc = read_tech_proc_value
    End Property

    Property Let write_tech_proc(aData)
        set_tech_proc = aData
        write
    End Property

    Property Get get_model_number
        get_model_number = read_model_number_value
    End Property

    Property Let set_model_number(aData)
        write_model_number_value = aData
        flag_model_number        = &H1
    End Property

    Property Get read_model_number
        read
        read_model_number = read_model_number_value
    End Property

    Property Let write_model_number(aData)
        set_model_number = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_rev_letter_value = rightShift(data_low, 14) and &H3
        read_rev_number_value = rightShift(data_low, 11) and &H7
        read_bonding_value = rightShift(data_low, 9) and &H3
        read_tech_proc_value = rightShift(data_low, 6) and &H7
        model_number_mask = &H3f
        if data_low > LONG_MAX then
            if model_number_mask = mask then
                read_model_number_value = data_low
            else
                read_model_number_value = (data_low - H8000_0000) and model_number_mask
            end If
        else
            read_model_number_value = data_low and model_number_mask
        end If

    End Sub

    Sub write
        If flag_rev_letter = &H0 or flag_rev_number = &H0 or flag_bonding = &H0 or flag_tech_proc = &H0 or flag_model_number = &H0 Then read
        If flag_rev_letter = &H0 Then write_rev_letter_value = get_rev_letter
        If flag_rev_number = &H0 Then write_rev_number_value = get_rev_number
        If flag_bonding = &H0 Then write_bonding_value = get_bonding
        If flag_tech_proc = &H0 Then write_tech_proc_value = get_tech_proc
        If flag_model_number = &H0 Then write_model_number_value = get_model_number

        regValue = leftShift((write_rev_letter_value and &H3), 14) + leftShift((write_rev_number_value and &H7), 11) + leftShift((write_bonding_value and &H3), 9) + leftShift((write_tech_proc_value and &H7), 6) + leftShift((write_model_number_value and &H3f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_rev_letter_value = rightShift(data_low, 14) and &H3
        read_rev_number_value = rightShift(data_low, 11) and &H7
        read_bonding_value = rightShift(data_low, 9) and &H3
        read_tech_proc_value = rightShift(data_low, 6) and &H7
        model_number_mask = &H3f
        if data_low > LONG_MAX then
            if model_number_mask = mask then
                read_model_number_value = data_low
            else
                read_model_number_value = (data_low - H8000_0000) and model_number_mask
            end If
        else
            read_model_number_value = data_low and model_number_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_rev_letter_value = &H0
        flag_rev_letter        = &H0
        write_rev_number_value = &H0
        flag_rev_number        = &H0
        write_bonding_value = &H0
        flag_bonding        = &H0
        write_tech_proc_value = &H0
        flag_tech_proc        = &H0
        write_model_number_value = &H0
        flag_model_number        = &H0
    End Sub
End Class


'' @REGISTER : PCS_MAIN0_SGMIIPLUSR_X1_blockaddress
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
Class REGISTER_PCS_MAIN0_SGMIIPLUSR_X1_blockaddress
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

Class PCS_MAIN0_SGMIIPLUSR_X1_INSTANCE

    Public setup
    Public tick_control_1_sgmiiplusr_x1
    Public tick_control_0_sgmiiplusr_x1
    Public loopback_control_sgmiiplusr_x1
    Public serdesid
    Public blockaddress


    Public default function Init(aBaseAddr)
        Set setup = (New REGISTER_PCS_MAIN0_SGMIIPLUSR_X1_setup)(aBaseAddr, 16)
        Set tick_control_1_sgmiiplusr_x1 = (New REGISTER_PCS_MAIN0_SGMIIPLUSR_X1_tick_control_1_sgmiiplusr_x1)(aBaseAddr, 16)
        Set tick_control_0_sgmiiplusr_x1 = (New REGISTER_PCS_MAIN0_SGMIIPLUSR_X1_tick_control_0_sgmiiplusr_x1)(aBaseAddr, 16)
        Set loopback_control_sgmiiplusr_x1 = (New REGISTER_PCS_MAIN0_SGMIIPLUSR_X1_loopback_control_sgmiiplusr_x1)(aBaseAddr, 16)
        Set serdesid = (New REGISTER_PCS_MAIN0_SGMIIPLUSR_X1_serdesid)(aBaseAddr, 16)
        Set blockaddress = (New REGISTER_PCS_MAIN0_SGMIIPLUSR_X1_blockaddress)(aBaseAddr, 16)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set PCS_MAIN0_SGMIIPLUSR_X1 = CreateObject("System.Collections.ArrayList")
PCS_MAIN0_SGMIIPLUSR_X1.Add ((New PCS_MAIN0_SGMIIPLUSR_X1_INSTANCE)(&H4aed2200))


