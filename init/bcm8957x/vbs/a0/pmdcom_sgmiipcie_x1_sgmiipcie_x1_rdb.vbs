

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


'' @REGISTER : PMDCOM_SGMIIPCIE_X1_SGMIIPCIE_X1_pmd_maskdata
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' pmd_maskdata                               [15:0]           get_pmd_maskdata
''                                                             set_pmd_maskdata
''                                                             read_pmd_maskdata
''                                                             write_pmd_maskdata
''---------------------------------------------------------------------------------
Class REGISTER_PMDCOM_SGMIIPCIE_X1_SGMIIPCIE_X1_pmd_maskdata
    Private write_pmd_maskdata_value
    Private read_pmd_maskdata_value
    Private flag_pmd_maskdata

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

    Property Get get_pmd_maskdata
        get_pmd_maskdata = read_pmd_maskdata_value
    End Property

    Property Let set_pmd_maskdata(aData)
        write_pmd_maskdata_value = aData
        flag_pmd_maskdata        = &H1
    End Property

    Property Get read_pmd_maskdata
        read
        read_pmd_maskdata = read_pmd_maskdata_value
    End Property

    Property Let write_pmd_maskdata(aData)
        set_pmd_maskdata = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pmd_maskdata_mask = &Hffff
        if data_low > LONG_MAX then
            if pmd_maskdata_mask = mask then
                read_pmd_maskdata_value = data_low
            else
                read_pmd_maskdata_value = (data_low - H8000_0000) and pmd_maskdata_mask
            end If
        else
            read_pmd_maskdata_value = data_low and pmd_maskdata_mask
        end If

    End Sub

    Sub write
        If flag_pmd_maskdata = &H0 Then read
        If flag_pmd_maskdata = &H0 Then write_pmd_maskdata_value = get_pmd_maskdata

        regValue = leftShift((write_pmd_maskdata_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pmd_maskdata_mask = &Hffff
        if data_low > LONG_MAX then
            if pmd_maskdata_mask = mask then
                read_pmd_maskdata_value = data_low
            else
                read_pmd_maskdata_value = (data_low - H8000_0000) and pmd_maskdata_mask
            end If
        else
            read_pmd_maskdata_value = data_low and pmd_maskdata_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_pmd_maskdata_value = &H0
        flag_pmd_maskdata        = &H0
    End Sub
End Class


'' @REGISTER : PMDCOM_SGMIIPCIE_X1_SGMIIPCIE_X1_pmd_maskdata_ctrl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PMBA                                       [1:0]            get_PMBA
''                                                             set_PMBA
''                                                             read_PMBA
''                                                             write_PMBA
''---------------------------------------------------------------------------------
Class REGISTER_PMDCOM_SGMIIPCIE_X1_SGMIIPCIE_X1_pmd_maskdata_ctrl
    Private write_PMBA_value
    Private read_PMBA_value
    Private flag_PMBA

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

    Property Get get_PMBA
        get_PMBA = read_PMBA_value
    End Property

    Property Let set_PMBA(aData)
        write_PMBA_value = aData
        flag_PMBA        = &H1
    End Property

    Property Get read_PMBA
        read
        read_PMBA = read_PMBA_value
    End Property

    Property Let write_PMBA(aData)
        set_PMBA = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PMBA_mask = &H3
        if data_low > LONG_MAX then
            if PMBA_mask = mask then
                read_PMBA_value = data_low
            else
                read_PMBA_value = (data_low - H8000_0000) and PMBA_mask
            end If
        else
            read_PMBA_value = data_low and PMBA_mask
        end If

    End Sub

    Sub write
        If flag_PMBA = &H0 Then read
        If flag_PMBA = &H0 Then write_PMBA_value = get_PMBA

        regValue = leftShift((write_PMBA_value and &H3), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PMBA_mask = &H3
        if data_low > LONG_MAX then
            if PMBA_mask = mask then
                read_PMBA_value = data_low
            else
                read_PMBA_value = (data_low - H8000_0000) and PMBA_mask
            end If
        else
            read_PMBA_value = data_low and PMBA_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PMBA_value = &H0
        flag_PMBA        = &H0
    End Sub
End Class


'' @REGISTER : PMDCOM_SGMIIPCIE_X1_SGMIIPCIE_X1_pmd_ln_offset
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' pmd_ln_offset                              [4:0]            get_pmd_ln_offset
''                                                             set_pmd_ln_offset
''                                                             read_pmd_ln_offset
''                                                             write_pmd_ln_offset
''---------------------------------------------------------------------------------
Class REGISTER_PMDCOM_SGMIIPCIE_X1_SGMIIPCIE_X1_pmd_ln_offset
    Private write_pmd_ln_offset_value
    Private read_pmd_ln_offset_value
    Private flag_pmd_ln_offset

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

    Property Get get_pmd_ln_offset
        get_pmd_ln_offset = read_pmd_ln_offset_value
    End Property

    Property Let set_pmd_ln_offset(aData)
        write_pmd_ln_offset_value = aData
        flag_pmd_ln_offset        = &H1
    End Property

    Property Get read_pmd_ln_offset
        read
        read_pmd_ln_offset = read_pmd_ln_offset_value
    End Property

    Property Let write_pmd_ln_offset(aData)
        set_pmd_ln_offset = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pmd_ln_offset_mask = &H1f
        if data_low > LONG_MAX then
            if pmd_ln_offset_mask = mask then
                read_pmd_ln_offset_value = data_low
            else
                read_pmd_ln_offset_value = (data_low - H8000_0000) and pmd_ln_offset_mask
            end If
        else
            read_pmd_ln_offset_value = data_low and pmd_ln_offset_mask
        end If

    End Sub

    Sub write
        If flag_pmd_ln_offset = &H0 Then read
        If flag_pmd_ln_offset = &H0 Then write_pmd_ln_offset_value = get_pmd_ln_offset

        regValue = leftShift((write_pmd_ln_offset_value and &H1f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pmd_ln_offset_mask = &H1f
        if data_low > LONG_MAX then
            if pmd_ln_offset_mask = mask then
                read_pmd_ln_offset_value = data_low
            else
                read_pmd_ln_offset_value = (data_low - H8000_0000) and pmd_ln_offset_mask
            end If
        else
            read_pmd_ln_offset_value = data_low and pmd_ln_offset_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_pmd_ln_offset_value = &H0
        flag_pmd_ln_offset        = &H0
    End Sub
End Class


'' @REGISTER : PMDCOM_SGMIIPCIE_X1_SGMIIPCIE_X1_pmd_control
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TFCS                                       [7:7]            get_TFCS
''                                                             set_TFCS
''                                                             read_TFCS
''                                                             write_TFCS
''---------------------------------------------------------------------------------
'' RFCS                                       [6:6]            get_RFCS
''                                                             set_RFCS
''                                                             read_RFCS
''                                                             write_RFCS
''---------------------------------------------------------------------------------
'' toggle_fracN_sel                           [5:5]            get_toggle_fracN_sel
''                                                             set_toggle_fracN_sel
''                                                             read_toggle_fracN_sel
''                                                             write_toggle_fracN_sel
''---------------------------------------------------------------------------------
'' pll_bypass                                 [4:4]            get_pll_bypass
''                                                             set_pll_bypass
''                                                             read_pll_bypass
''                                                             write_pll_bypass
''---------------------------------------------------------------------------------
'' pwrdn_pll                                  [3:3]            get_pwrdn_pll
''                                                             set_pwrdn_pll
''                                                             read_pwrdn_pll
''                                                             write_pwrdn_pll
''---------------------------------------------------------------------------------
'' pwrdn_safe_dis                             [2:2]            get_pwrdn_safe_dis
''                                                             set_pwrdn_safe_dis
''                                                             read_pwrdn_safe_dis
''                                                             write_pwrdn_safe_dis
''---------------------------------------------------------------------------------
'' pwrdwn_clks_en                             [1:1]            get_pwrdwn_clks_en
''                                                             set_pwrdwn_clks_en
''                                                             read_pwrdwn_clks_en
''                                                             write_pwrdwn_clks_en
''---------------------------------------------------------------------------------
'' Rescal_sel                                 [0:0]            get_Rescal_sel
''                                                             set_Rescal_sel
''                                                             read_Rescal_sel
''                                                             write_Rescal_sel
''---------------------------------------------------------------------------------
Class REGISTER_PMDCOM_SGMIIPCIE_X1_SGMIIPCIE_X1_pmd_control
    Private write_TFCS_value
    Private read_TFCS_value
    Private flag_TFCS
    Private write_RFCS_value
    Private read_RFCS_value
    Private flag_RFCS
    Private write_toggle_fracN_sel_value
    Private read_toggle_fracN_sel_value
    Private flag_toggle_fracN_sel
    Private write_pll_bypass_value
    Private read_pll_bypass_value
    Private flag_pll_bypass
    Private write_pwrdn_pll_value
    Private read_pwrdn_pll_value
    Private flag_pwrdn_pll
    Private write_pwrdn_safe_dis_value
    Private read_pwrdn_safe_dis_value
    Private flag_pwrdn_safe_dis
    Private write_pwrdwn_clks_en_value
    Private read_pwrdwn_clks_en_value
    Private flag_pwrdwn_clks_en
    Private write_Rescal_sel_value
    Private read_Rescal_sel_value
    Private flag_Rescal_sel

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

    Property Get get_TFCS
        get_TFCS = read_TFCS_value
    End Property

    Property Let set_TFCS(aData)
        write_TFCS_value = aData
        flag_TFCS        = &H1
    End Property

    Property Get read_TFCS
        read
        read_TFCS = read_TFCS_value
    End Property

    Property Let write_TFCS(aData)
        set_TFCS = aData
        write
    End Property

    Property Get get_RFCS
        get_RFCS = read_RFCS_value
    End Property

    Property Let set_RFCS(aData)
        write_RFCS_value = aData
        flag_RFCS        = &H1
    End Property

    Property Get read_RFCS
        read
        read_RFCS = read_RFCS_value
    End Property

    Property Let write_RFCS(aData)
        set_RFCS = aData
        write
    End Property

    Property Get get_toggle_fracN_sel
        get_toggle_fracN_sel = read_toggle_fracN_sel_value
    End Property

    Property Let set_toggle_fracN_sel(aData)
        write_toggle_fracN_sel_value = aData
        flag_toggle_fracN_sel        = &H1
    End Property

    Property Get read_toggle_fracN_sel
        read
        read_toggle_fracN_sel = read_toggle_fracN_sel_value
    End Property

    Property Let write_toggle_fracN_sel(aData)
        set_toggle_fracN_sel = aData
        write
    End Property

    Property Get get_pll_bypass
        get_pll_bypass = read_pll_bypass_value
    End Property

    Property Let set_pll_bypass(aData)
        write_pll_bypass_value = aData
        flag_pll_bypass        = &H1
    End Property

    Property Get read_pll_bypass
        read
        read_pll_bypass = read_pll_bypass_value
    End Property

    Property Let write_pll_bypass(aData)
        set_pll_bypass = aData
        write
    End Property

    Property Get get_pwrdn_pll
        get_pwrdn_pll = read_pwrdn_pll_value
    End Property

    Property Let set_pwrdn_pll(aData)
        write_pwrdn_pll_value = aData
        flag_pwrdn_pll        = &H1
    End Property

    Property Get read_pwrdn_pll
        read
        read_pwrdn_pll = read_pwrdn_pll_value
    End Property

    Property Let write_pwrdn_pll(aData)
        set_pwrdn_pll = aData
        write
    End Property

    Property Get get_pwrdn_safe_dis
        get_pwrdn_safe_dis = read_pwrdn_safe_dis_value
    End Property

    Property Let set_pwrdn_safe_dis(aData)
        write_pwrdn_safe_dis_value = aData
        flag_pwrdn_safe_dis        = &H1
    End Property

    Property Get read_pwrdn_safe_dis
        read
        read_pwrdn_safe_dis = read_pwrdn_safe_dis_value
    End Property

    Property Let write_pwrdn_safe_dis(aData)
        set_pwrdn_safe_dis = aData
        write
    End Property

    Property Get get_pwrdwn_clks_en
        get_pwrdwn_clks_en = read_pwrdwn_clks_en_value
    End Property

    Property Let set_pwrdwn_clks_en(aData)
        write_pwrdwn_clks_en_value = aData
        flag_pwrdwn_clks_en        = &H1
    End Property

    Property Get read_pwrdwn_clks_en
        read
        read_pwrdwn_clks_en = read_pwrdwn_clks_en_value
    End Property

    Property Let write_pwrdwn_clks_en(aData)
        set_pwrdwn_clks_en = aData
        write
    End Property

    Property Get get_Rescal_sel
        get_Rescal_sel = read_Rescal_sel_value
    End Property

    Property Let set_Rescal_sel(aData)
        write_Rescal_sel_value = aData
        flag_Rescal_sel        = &H1
    End Property

    Property Get read_Rescal_sel
        read
        read_Rescal_sel = read_Rescal_sel_value
    End Property

    Property Let write_Rescal_sel(aData)
        set_Rescal_sel = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TFCS_value = rightShift(data_low, 7) and &H1
        read_RFCS_value = rightShift(data_low, 6) and &H1
        read_toggle_fracN_sel_value = rightShift(data_low, 5) and &H1
        read_pll_bypass_value = rightShift(data_low, 4) and &H1
        read_pwrdn_pll_value = rightShift(data_low, 3) and &H1
        read_pwrdn_safe_dis_value = rightShift(data_low, 2) and &H1
        read_pwrdwn_clks_en_value = rightShift(data_low, 1) and &H1
        Rescal_sel_mask = &H1
        if data_low > LONG_MAX then
            if Rescal_sel_mask = mask then
                read_Rescal_sel_value = data_low
            else
                read_Rescal_sel_value = (data_low - H8000_0000) and Rescal_sel_mask
            end If
        else
            read_Rescal_sel_value = data_low and Rescal_sel_mask
        end If

    End Sub

    Sub write
        If flag_TFCS = &H0 or flag_RFCS = &H0 or flag_toggle_fracN_sel = &H0 or flag_pll_bypass = &H0 or flag_pwrdn_pll = &H0 or flag_pwrdn_safe_dis = &H0 or flag_pwrdwn_clks_en = &H0 or flag_Rescal_sel = &H0 Then read
        If flag_TFCS = &H0 Then write_TFCS_value = get_TFCS
        If flag_RFCS = &H0 Then write_RFCS_value = get_RFCS
        If flag_toggle_fracN_sel = &H0 Then write_toggle_fracN_sel_value = get_toggle_fracN_sel
        If flag_pll_bypass = &H0 Then write_pll_bypass_value = get_pll_bypass
        If flag_pwrdn_pll = &H0 Then write_pwrdn_pll_value = get_pwrdn_pll
        If flag_pwrdn_safe_dis = &H0 Then write_pwrdn_safe_dis_value = get_pwrdn_safe_dis
        If flag_pwrdwn_clks_en = &H0 Then write_pwrdwn_clks_en_value = get_pwrdwn_clks_en
        If flag_Rescal_sel = &H0 Then write_Rescal_sel_value = get_Rescal_sel

        regValue = leftShift((write_TFCS_value and &H1), 7) + leftShift((write_RFCS_value and &H1), 6) + leftShift((write_toggle_fracN_sel_value and &H1), 5) + leftShift((write_pll_bypass_value and &H1), 4) + leftShift((write_pwrdn_pll_value and &H1), 3) + leftShift((write_pwrdn_safe_dis_value and &H1), 2) + leftShift((write_pwrdwn_clks_en_value and &H1), 1) + leftShift((write_Rescal_sel_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TFCS_value = rightShift(data_low, 7) and &H1
        read_RFCS_value = rightShift(data_low, 6) and &H1
        read_toggle_fracN_sel_value = rightShift(data_low, 5) and &H1
        read_pll_bypass_value = rightShift(data_low, 4) and &H1
        read_pwrdn_pll_value = rightShift(data_low, 3) and &H1
        read_pwrdn_safe_dis_value = rightShift(data_low, 2) and &H1
        read_pwrdwn_clks_en_value = rightShift(data_low, 1) and &H1
        Rescal_sel_mask = &H1
        if data_low > LONG_MAX then
            if Rescal_sel_mask = mask then
                read_Rescal_sel_value = data_low
            else
                read_Rescal_sel_value = (data_low - H8000_0000) and Rescal_sel_mask
            end If
        else
            read_Rescal_sel_value = data_low and Rescal_sel_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TFCS_value = &H0
        flag_TFCS        = &H0
        write_RFCS_value = &H0
        flag_RFCS        = &H0
        write_toggle_fracN_sel_value = &H0
        flag_toggle_fracN_sel        = &H0
        write_pll_bypass_value = &H0
        flag_pll_bypass        = &H0
        write_pwrdn_pll_value = &H0
        flag_pwrdn_pll        = &H0
        write_pwrdn_safe_dis_value = &H0
        flag_pwrdn_safe_dis        = &H0
        write_pwrdwn_clks_en_value = &H0
        flag_pwrdwn_clks_en        = &H0
        write_Rescal_sel_value = &H0
        flag_Rescal_sel        = &H0
    End Sub
End Class


'' @REGISTER : PMDCOM_SGMIIPCIE_X1_SGMIIPCIE_X1_blockaddress
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
Class REGISTER_PMDCOM_SGMIIPCIE_X1_SGMIIPCIE_X1_blockaddress
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

Class PMDCOM_SGMIIPCIE_X1_SGMIIPCIE_X1_INSTANCE

    Public pmd_maskdata
    Public pmd_maskdata_ctrl
    Public pmd_ln_offset
    Public pmd_control
    Public blockaddress


    Public default function Init(aBaseAddr)
        Set pmd_maskdata = (New REGISTER_PMDCOM_SGMIIPCIE_X1_SGMIIPCIE_X1_pmd_maskdata)(aBaseAddr, 16)
        Set pmd_maskdata_ctrl = (New REGISTER_PMDCOM_SGMIIPCIE_X1_SGMIIPCIE_X1_pmd_maskdata_ctrl)(aBaseAddr, 16)
        Set pmd_ln_offset = (New REGISTER_PMDCOM_SGMIIPCIE_X1_SGMIIPCIE_X1_pmd_ln_offset)(aBaseAddr, 16)
        Set pmd_control = (New REGISTER_PMDCOM_SGMIIPCIE_X1_SGMIIPCIE_X1_pmd_control)(aBaseAddr, 16)
        Set blockaddress = (New REGISTER_PMDCOM_SGMIIPCIE_X1_SGMIIPCIE_X1_blockaddress)(aBaseAddr, 16)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set PMDCOM_SGMIIPCIE_X1_SGMIIPCIE_X1 = CreateObject("System.Collections.ArrayList")
PMDCOM_SGMIIPCIE_X1_SGMIIPCIE_X1.Add ((New PMDCOM_SGMIIPCIE_X1_SGMIIPCIE_X1_INSTANCE)(&H4ad50340))


