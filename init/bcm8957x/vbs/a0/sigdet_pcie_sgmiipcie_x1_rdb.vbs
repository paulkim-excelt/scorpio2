

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


'' @REGISTER : SIGDET_PCIE_SGMIIPCIE_X1_sigdet_ctrl_3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' rg_sigdet_fast_drop_gen2                   [15:15]          get_rg_sigdet_fast_drop_gen2
''                                                             set_rg_sigdet_fast_drop_gen2
''                                                             read_rg_sigdet_fast_drop_gen2
''                                                             write_rg_sigdet_fast_drop_gen2
''---------------------------------------------------------------------------------
'' rg_sigdet_frc                              [14:14]          get_rg_sigdet_frc
''                                                             set_rg_sigdet_frc
''                                                             read_rg_sigdet_frc
''                                                             write_rg_sigdet_frc
''---------------------------------------------------------------------------------
'' rg_sigdet_frc_val                          [13:13]          get_rg_sigdet_frc_val
''                                                             set_rg_sigdet_frc_val
''                                                             read_rg_sigdet_frc_val
''                                                             write_rg_sigdet_frc_val
''---------------------------------------------------------------------------------
'' rg_rxinfeidledis                           [12:12]          get_rg_rxinfeidledis
''                                                             set_rg_rxinfeidledis
''                                                             read_rg_rxinfeidledis
''                                                             write_rg_rxinfeidledis
''---------------------------------------------------------------------------------
'' rg_rxl0sl1failure_dis                      [11:11]          get_rg_rxl0sl1failure_dis
''                                                             set_rg_rxl0sl1failure_dis
''                                                             read_rg_rxl0sl1failure_dis
''                                                             write_rg_rxl0sl1failure_dis
''---------------------------------------------------------------------------------
'' rg_rx_afe_pwrdn_bypass                     [10:10]          get_rg_rx_afe_pwrdn_bypass
''                                                             set_rg_rx_afe_pwrdn_bypass
''                                                             read_rg_rx_afe_pwrdn_bypass
''                                                             write_rg_rx_afe_pwrdn_bypass
''---------------------------------------------------------------------------------
'' rg_rxl0sl1failure_cnt                      [9:0]            get_rg_rxl0sl1failure_cnt
''                                                             set_rg_rxl0sl1failure_cnt
''                                                             read_rg_rxl0sl1failure_cnt
''                                                             write_rg_rxl0sl1failure_cnt
''---------------------------------------------------------------------------------
Class REGISTER_SIGDET_PCIE_SGMIIPCIE_X1_sigdet_ctrl_3
    Private write_rg_sigdet_fast_drop_gen2_value
    Private read_rg_sigdet_fast_drop_gen2_value
    Private flag_rg_sigdet_fast_drop_gen2
    Private write_rg_sigdet_frc_value
    Private read_rg_sigdet_frc_value
    Private flag_rg_sigdet_frc
    Private write_rg_sigdet_frc_val_value
    Private read_rg_sigdet_frc_val_value
    Private flag_rg_sigdet_frc_val
    Private write_rg_rxinfeidledis_value
    Private read_rg_rxinfeidledis_value
    Private flag_rg_rxinfeidledis
    Private write_rg_rxl0sl1failure_dis_value
    Private read_rg_rxl0sl1failure_dis_value
    Private flag_rg_rxl0sl1failure_dis
    Private write_rg_rx_afe_pwrdn_bypass_value
    Private read_rg_rx_afe_pwrdn_bypass_value
    Private flag_rg_rx_afe_pwrdn_bypass
    Private write_rg_rxl0sl1failure_cnt_value
    Private read_rg_rxl0sl1failure_cnt_value
    Private flag_rg_rxl0sl1failure_cnt

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

    Property Get get_rg_sigdet_fast_drop_gen2
        get_rg_sigdet_fast_drop_gen2 = read_rg_sigdet_fast_drop_gen2_value
    End Property

    Property Let set_rg_sigdet_fast_drop_gen2(aData)
        write_rg_sigdet_fast_drop_gen2_value = aData
        flag_rg_sigdet_fast_drop_gen2        = &H1
    End Property

    Property Get read_rg_sigdet_fast_drop_gen2
        read
        read_rg_sigdet_fast_drop_gen2 = read_rg_sigdet_fast_drop_gen2_value
    End Property

    Property Let write_rg_sigdet_fast_drop_gen2(aData)
        set_rg_sigdet_fast_drop_gen2 = aData
        write
    End Property

    Property Get get_rg_sigdet_frc
        get_rg_sigdet_frc = read_rg_sigdet_frc_value
    End Property

    Property Let set_rg_sigdet_frc(aData)
        write_rg_sigdet_frc_value = aData
        flag_rg_sigdet_frc        = &H1
    End Property

    Property Get read_rg_sigdet_frc
        read
        read_rg_sigdet_frc = read_rg_sigdet_frc_value
    End Property

    Property Let write_rg_sigdet_frc(aData)
        set_rg_sigdet_frc = aData
        write
    End Property

    Property Get get_rg_sigdet_frc_val
        get_rg_sigdet_frc_val = read_rg_sigdet_frc_val_value
    End Property

    Property Let set_rg_sigdet_frc_val(aData)
        write_rg_sigdet_frc_val_value = aData
        flag_rg_sigdet_frc_val        = &H1
    End Property

    Property Get read_rg_sigdet_frc_val
        read
        read_rg_sigdet_frc_val = read_rg_sigdet_frc_val_value
    End Property

    Property Let write_rg_sigdet_frc_val(aData)
        set_rg_sigdet_frc_val = aData
        write
    End Property

    Property Get get_rg_rxinfeidledis
        get_rg_rxinfeidledis = read_rg_rxinfeidledis_value
    End Property

    Property Let set_rg_rxinfeidledis(aData)
        write_rg_rxinfeidledis_value = aData
        flag_rg_rxinfeidledis        = &H1
    End Property

    Property Get read_rg_rxinfeidledis
        read
        read_rg_rxinfeidledis = read_rg_rxinfeidledis_value
    End Property

    Property Let write_rg_rxinfeidledis(aData)
        set_rg_rxinfeidledis = aData
        write
    End Property

    Property Get get_rg_rxl0sl1failure_dis
        get_rg_rxl0sl1failure_dis = read_rg_rxl0sl1failure_dis_value
    End Property

    Property Let set_rg_rxl0sl1failure_dis(aData)
        write_rg_rxl0sl1failure_dis_value = aData
        flag_rg_rxl0sl1failure_dis        = &H1
    End Property

    Property Get read_rg_rxl0sl1failure_dis
        read
        read_rg_rxl0sl1failure_dis = read_rg_rxl0sl1failure_dis_value
    End Property

    Property Let write_rg_rxl0sl1failure_dis(aData)
        set_rg_rxl0sl1failure_dis = aData
        write
    End Property

    Property Get get_rg_rx_afe_pwrdn_bypass
        get_rg_rx_afe_pwrdn_bypass = read_rg_rx_afe_pwrdn_bypass_value
    End Property

    Property Let set_rg_rx_afe_pwrdn_bypass(aData)
        write_rg_rx_afe_pwrdn_bypass_value = aData
        flag_rg_rx_afe_pwrdn_bypass        = &H1
    End Property

    Property Get read_rg_rx_afe_pwrdn_bypass
        read
        read_rg_rx_afe_pwrdn_bypass = read_rg_rx_afe_pwrdn_bypass_value
    End Property

    Property Let write_rg_rx_afe_pwrdn_bypass(aData)
        set_rg_rx_afe_pwrdn_bypass = aData
        write
    End Property

    Property Get get_rg_rxl0sl1failure_cnt
        get_rg_rxl0sl1failure_cnt = read_rg_rxl0sl1failure_cnt_value
    End Property

    Property Let set_rg_rxl0sl1failure_cnt(aData)
        write_rg_rxl0sl1failure_cnt_value = aData
        flag_rg_rxl0sl1failure_cnt        = &H1
    End Property

    Property Get read_rg_rxl0sl1failure_cnt
        read
        read_rg_rxl0sl1failure_cnt = read_rg_rxl0sl1failure_cnt_value
    End Property

    Property Let write_rg_rxl0sl1failure_cnt(aData)
        set_rg_rxl0sl1failure_cnt = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_rg_sigdet_fast_drop_gen2_value = rightShift(data_low, 15) and &H1
        read_rg_sigdet_frc_value = rightShift(data_low, 14) and &H1
        read_rg_sigdet_frc_val_value = rightShift(data_low, 13) and &H1
        read_rg_rxinfeidledis_value = rightShift(data_low, 12) and &H1
        read_rg_rxl0sl1failure_dis_value = rightShift(data_low, 11) and &H1
        read_rg_rx_afe_pwrdn_bypass_value = rightShift(data_low, 10) and &H1
        rg_rxl0sl1failure_cnt_mask = &H3ff
        if data_low > LONG_MAX then
            if rg_rxl0sl1failure_cnt_mask = mask then
                read_rg_rxl0sl1failure_cnt_value = data_low
            else
                read_rg_rxl0sl1failure_cnt_value = (data_low - H8000_0000) and rg_rxl0sl1failure_cnt_mask
            end If
        else
            read_rg_rxl0sl1failure_cnt_value = data_low and rg_rxl0sl1failure_cnt_mask
        end If

    End Sub

    Sub write
        If flag_rg_sigdet_fast_drop_gen2 = &H0 or flag_rg_sigdet_frc = &H0 or flag_rg_sigdet_frc_val = &H0 or flag_rg_rxinfeidledis = &H0 or flag_rg_rxl0sl1failure_dis = &H0 or flag_rg_rx_afe_pwrdn_bypass = &H0 or flag_rg_rxl0sl1failure_cnt = &H0 Then read
        If flag_rg_sigdet_fast_drop_gen2 = &H0 Then write_rg_sigdet_fast_drop_gen2_value = get_rg_sigdet_fast_drop_gen2
        If flag_rg_sigdet_frc = &H0 Then write_rg_sigdet_frc_value = get_rg_sigdet_frc
        If flag_rg_sigdet_frc_val = &H0 Then write_rg_sigdet_frc_val_value = get_rg_sigdet_frc_val
        If flag_rg_rxinfeidledis = &H0 Then write_rg_rxinfeidledis_value = get_rg_rxinfeidledis
        If flag_rg_rxl0sl1failure_dis = &H0 Then write_rg_rxl0sl1failure_dis_value = get_rg_rxl0sl1failure_dis
        If flag_rg_rx_afe_pwrdn_bypass = &H0 Then write_rg_rx_afe_pwrdn_bypass_value = get_rg_rx_afe_pwrdn_bypass
        If flag_rg_rxl0sl1failure_cnt = &H0 Then write_rg_rxl0sl1failure_cnt_value = get_rg_rxl0sl1failure_cnt

        regValue = leftShift((write_rg_sigdet_fast_drop_gen2_value and &H1), 15) + leftShift((write_rg_sigdet_frc_value and &H1), 14) + leftShift((write_rg_sigdet_frc_val_value and &H1), 13) + leftShift((write_rg_rxinfeidledis_value and &H1), 12) + leftShift((write_rg_rxl0sl1failure_dis_value and &H1), 11) + leftShift((write_rg_rx_afe_pwrdn_bypass_value and &H1), 10) + leftShift((write_rg_rxl0sl1failure_cnt_value and &H3ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_rg_sigdet_fast_drop_gen2_value = rightShift(data_low, 15) and &H1
        read_rg_sigdet_frc_value = rightShift(data_low, 14) and &H1
        read_rg_sigdet_frc_val_value = rightShift(data_low, 13) and &H1
        read_rg_rxinfeidledis_value = rightShift(data_low, 12) and &H1
        read_rg_rxl0sl1failure_dis_value = rightShift(data_low, 11) and &H1
        read_rg_rx_afe_pwrdn_bypass_value = rightShift(data_low, 10) and &H1
        rg_rxl0sl1failure_cnt_mask = &H3ff
        if data_low > LONG_MAX then
            if rg_rxl0sl1failure_cnt_mask = mask then
                read_rg_rxl0sl1failure_cnt_value = data_low
            else
                read_rg_rxl0sl1failure_cnt_value = (data_low - H8000_0000) and rg_rxl0sl1failure_cnt_mask
            end If
        else
            read_rg_rxl0sl1failure_cnt_value = data_low and rg_rxl0sl1failure_cnt_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_rg_sigdet_fast_drop_gen2_value = &H0
        flag_rg_sigdet_fast_drop_gen2        = &H0
        write_rg_sigdet_frc_value = &H0
        flag_rg_sigdet_frc        = &H0
        write_rg_sigdet_frc_val_value = &H0
        flag_rg_sigdet_frc_val        = &H0
        write_rg_rxinfeidledis_value = &H0
        flag_rg_rxinfeidledis        = &H0
        write_rg_rxl0sl1failure_dis_value = &H0
        flag_rg_rxl0sl1failure_dis        = &H0
        write_rg_rx_afe_pwrdn_bypass_value = &H0
        flag_rg_rx_afe_pwrdn_bypass        = &H0
        write_rg_rxl0sl1failure_cnt_value = &H0
        flag_rg_rxl0sl1failure_cnt        = &H0
    End Sub
End Class


'' @REGISTER : SIGDET_PCIE_SGMIIPCIE_X1_sigdet_ctrl_4
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' rg_sigdet_plllock_tmr                      [15:0]           get_rg_sigdet_plllock_tmr
''                                                             set_rg_sigdet_plllock_tmr
''                                                             read_rg_sigdet_plllock_tmr
''                                                             write_rg_sigdet_plllock_tmr
''---------------------------------------------------------------------------------
Class REGISTER_SIGDET_PCIE_SGMIIPCIE_X1_sigdet_ctrl_4
    Private write_rg_sigdet_plllock_tmr_value
    Private read_rg_sigdet_plllock_tmr_value
    Private flag_rg_sigdet_plllock_tmr

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

    Property Get get_rg_sigdet_plllock_tmr
        get_rg_sigdet_plllock_tmr = read_rg_sigdet_plllock_tmr_value
    End Property

    Property Let set_rg_sigdet_plllock_tmr(aData)
        write_rg_sigdet_plllock_tmr_value = aData
        flag_rg_sigdet_plllock_tmr        = &H1
    End Property

    Property Get read_rg_sigdet_plllock_tmr
        read
        read_rg_sigdet_plllock_tmr = read_rg_sigdet_plllock_tmr_value
    End Property

    Property Let write_rg_sigdet_plllock_tmr(aData)
        set_rg_sigdet_plllock_tmr = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rg_sigdet_plllock_tmr_mask = &Hffff
        if data_low > LONG_MAX then
            if rg_sigdet_plllock_tmr_mask = mask then
                read_rg_sigdet_plllock_tmr_value = data_low
            else
                read_rg_sigdet_plllock_tmr_value = (data_low - H8000_0000) and rg_sigdet_plllock_tmr_mask
            end If
        else
            read_rg_sigdet_plllock_tmr_value = data_low and rg_sigdet_plllock_tmr_mask
        end If

    End Sub

    Sub write
        If flag_rg_sigdet_plllock_tmr = &H0 Then read
        If flag_rg_sigdet_plllock_tmr = &H0 Then write_rg_sigdet_plllock_tmr_value = get_rg_sigdet_plllock_tmr

        regValue = leftShift((write_rg_sigdet_plllock_tmr_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rg_sigdet_plllock_tmr_mask = &Hffff
        if data_low > LONG_MAX then
            if rg_sigdet_plllock_tmr_mask = mask then
                read_rg_sigdet_plllock_tmr_value = data_low
            else
                read_rg_sigdet_plllock_tmr_value = (data_low - H8000_0000) and rg_sigdet_plllock_tmr_mask
            end If
        else
            read_rg_sigdet_plllock_tmr_value = data_low and rg_sigdet_plllock_tmr_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_rg_sigdet_plllock_tmr_value = &H0
        flag_rg_sigdet_plllock_tmr        = &H0
    End Sub
End Class


'' @REGISTER : SIGDET_PCIE_SGMIIPCIE_X1_sigdet_ctrl_5
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' rg_sigdet_eieos_tmr                        [15:6]           get_rg_sigdet_eieos_tmr
''                                                             set_rg_sigdet_eieos_tmr
''                                                             read_rg_sigdet_eieos_tmr
''                                                             write_rg_sigdet_eieos_tmr
''---------------------------------------------------------------------------------
'' rg_sigdet_wait_tmr                         [5:0]            get_rg_sigdet_wait_tmr
''                                                             set_rg_sigdet_wait_tmr
''                                                             read_rg_sigdet_wait_tmr
''                                                             write_rg_sigdet_wait_tmr
''---------------------------------------------------------------------------------
Class REGISTER_SIGDET_PCIE_SGMIIPCIE_X1_sigdet_ctrl_5
    Private write_rg_sigdet_eieos_tmr_value
    Private read_rg_sigdet_eieos_tmr_value
    Private flag_rg_sigdet_eieos_tmr
    Private write_rg_sigdet_wait_tmr_value
    Private read_rg_sigdet_wait_tmr_value
    Private flag_rg_sigdet_wait_tmr

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

    Property Get get_rg_sigdet_eieos_tmr
        get_rg_sigdet_eieos_tmr = read_rg_sigdet_eieos_tmr_value
    End Property

    Property Let set_rg_sigdet_eieos_tmr(aData)
        write_rg_sigdet_eieos_tmr_value = aData
        flag_rg_sigdet_eieos_tmr        = &H1
    End Property

    Property Get read_rg_sigdet_eieos_tmr
        read
        read_rg_sigdet_eieos_tmr = read_rg_sigdet_eieos_tmr_value
    End Property

    Property Let write_rg_sigdet_eieos_tmr(aData)
        set_rg_sigdet_eieos_tmr = aData
        write
    End Property

    Property Get get_rg_sigdet_wait_tmr
        get_rg_sigdet_wait_tmr = read_rg_sigdet_wait_tmr_value
    End Property

    Property Let set_rg_sigdet_wait_tmr(aData)
        write_rg_sigdet_wait_tmr_value = aData
        flag_rg_sigdet_wait_tmr        = &H1
    End Property

    Property Get read_rg_sigdet_wait_tmr
        read
        read_rg_sigdet_wait_tmr = read_rg_sigdet_wait_tmr_value
    End Property

    Property Let write_rg_sigdet_wait_tmr(aData)
        set_rg_sigdet_wait_tmr = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_rg_sigdet_eieos_tmr_value = rightShift(data_low, 6) and &H3ff
        rg_sigdet_wait_tmr_mask = &H3f
        if data_low > LONG_MAX then
            if rg_sigdet_wait_tmr_mask = mask then
                read_rg_sigdet_wait_tmr_value = data_low
            else
                read_rg_sigdet_wait_tmr_value = (data_low - H8000_0000) and rg_sigdet_wait_tmr_mask
            end If
        else
            read_rg_sigdet_wait_tmr_value = data_low and rg_sigdet_wait_tmr_mask
        end If

    End Sub

    Sub write
        If flag_rg_sigdet_eieos_tmr = &H0 or flag_rg_sigdet_wait_tmr = &H0 Then read
        If flag_rg_sigdet_eieos_tmr = &H0 Then write_rg_sigdet_eieos_tmr_value = get_rg_sigdet_eieos_tmr
        If flag_rg_sigdet_wait_tmr = &H0 Then write_rg_sigdet_wait_tmr_value = get_rg_sigdet_wait_tmr

        regValue = leftShift((write_rg_sigdet_eieos_tmr_value and &H3ff), 6) + leftShift((write_rg_sigdet_wait_tmr_value and &H3f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_rg_sigdet_eieos_tmr_value = rightShift(data_low, 6) and &H3ff
        rg_sigdet_wait_tmr_mask = &H3f
        if data_low > LONG_MAX then
            if rg_sigdet_wait_tmr_mask = mask then
                read_rg_sigdet_wait_tmr_value = data_low
            else
                read_rg_sigdet_wait_tmr_value = (data_low - H8000_0000) and rg_sigdet_wait_tmr_mask
            end If
        else
            read_rg_sigdet_wait_tmr_value = data_low and rg_sigdet_wait_tmr_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_rg_sigdet_eieos_tmr_value = &H0
        flag_rg_sigdet_eieos_tmr        = &H0
        write_rg_sigdet_wait_tmr_value = &H0
        flag_rg_sigdet_wait_tmr        = &H0
    End Sub
End Class


'' @REGISTER : SIGDET_PCIE_SGMIIPCIE_X1_sigdet_ctrl_6
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' rg_sigdet_tggl_cnt_clr                     [15:15]          get_rg_sigdet_tggl_cnt_clr
''                                                             set_rg_sigdet_tggl_cnt_clr
''                                                             read_rg_sigdet_tggl_cnt_clr
''                                                             write_rg_sigdet_tggl_cnt_clr
''---------------------------------------------------------------------------------
'' rg_sigdet_filter_sel_gen1                  [14:14]          get_rg_sigdet_filter_sel_gen1
''                                                             set_rg_sigdet_filter_sel_gen1
''                                                             read_rg_sigdet_filter_sel_gen1
''                                                             write_rg_sigdet_filter_sel_gen1
''---------------------------------------------------------------------------------
'' rg_sigdet_filter_sel_gen2                  [13:13]          get_rg_sigdet_filter_sel_gen2
''                                                             set_rg_sigdet_filter_sel_gen2
''                                                             read_rg_sigdet_filter_sel_gen2
''                                                             write_rg_sigdet_filter_sel_gen2
''---------------------------------------------------------------------------------
'' rg_sigdet_sm_rst_cya                       [12:12]          get_rg_sigdet_sm_rst_cya
''                                                             set_rg_sigdet_sm_rst_cya
''                                                             read_rg_sigdet_sm_rst_cya
''                                                             write_rg_sigdet_sm_rst_cya
''---------------------------------------------------------------------------------
'' rg_early_pat_det_wo_scal                   [11:11]          get_rg_early_pat_det_wo_scal
''                                                             set_rg_early_pat_det_wo_scal
''                                                             read_rg_early_pat_det_wo_scal
''                                                             write_rg_early_pat_det_wo_scal
''---------------------------------------------------------------------------------
'' rg_sigdet_sm_rst                           [10:10]          get_rg_sigdet_sm_rst
''                                                             set_rg_sigdet_sm_rst
''                                                             read_rg_sigdet_sm_rst
''                                                             write_rg_sigdet_sm_rst
''---------------------------------------------------------------------------------
'' rg_eieos_det_bypass                        [9:9]            get_rg_eieos_det_bypass
''                                                             set_rg_eieos_det_bypass
''                                                             read_rg_eieos_det_bypass
''                                                             write_rg_eieos_det_bypass
''---------------------------------------------------------------------------------
'' rg_eios_det_bypass                         [8:8]            get_rg_eios_det_bypass
''                                                             set_rg_eios_det_bypass
''                                                             read_rg_eios_det_bypass
''                                                             write_rg_eios_det_bypass
''---------------------------------------------------------------------------------
'' rg_com_detect_cnt_gen2                     [7:0]            get_rg_com_detect_cnt_gen2
''                                                             set_rg_com_detect_cnt_gen2
''                                                             read_rg_com_detect_cnt_gen2
''                                                             write_rg_com_detect_cnt_gen2
''---------------------------------------------------------------------------------
Class REGISTER_SIGDET_PCIE_SGMIIPCIE_X1_sigdet_ctrl_6
    Private write_rg_sigdet_tggl_cnt_clr_value
    Private read_rg_sigdet_tggl_cnt_clr_value
    Private flag_rg_sigdet_tggl_cnt_clr
    Private write_rg_sigdet_filter_sel_gen1_value
    Private read_rg_sigdet_filter_sel_gen1_value
    Private flag_rg_sigdet_filter_sel_gen1
    Private write_rg_sigdet_filter_sel_gen2_value
    Private read_rg_sigdet_filter_sel_gen2_value
    Private flag_rg_sigdet_filter_sel_gen2
    Private write_rg_sigdet_sm_rst_cya_value
    Private read_rg_sigdet_sm_rst_cya_value
    Private flag_rg_sigdet_sm_rst_cya
    Private write_rg_early_pat_det_wo_scal_value
    Private read_rg_early_pat_det_wo_scal_value
    Private flag_rg_early_pat_det_wo_scal
    Private write_rg_sigdet_sm_rst_value
    Private read_rg_sigdet_sm_rst_value
    Private flag_rg_sigdet_sm_rst
    Private write_rg_eieos_det_bypass_value
    Private read_rg_eieos_det_bypass_value
    Private flag_rg_eieos_det_bypass
    Private write_rg_eios_det_bypass_value
    Private read_rg_eios_det_bypass_value
    Private flag_rg_eios_det_bypass
    Private write_rg_com_detect_cnt_gen2_value
    Private read_rg_com_detect_cnt_gen2_value
    Private flag_rg_com_detect_cnt_gen2

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

    Property Get get_rg_sigdet_tggl_cnt_clr
        get_rg_sigdet_tggl_cnt_clr = read_rg_sigdet_tggl_cnt_clr_value
    End Property

    Property Let set_rg_sigdet_tggl_cnt_clr(aData)
        write_rg_sigdet_tggl_cnt_clr_value = aData
        flag_rg_sigdet_tggl_cnt_clr        = &H1
    End Property

    Property Get read_rg_sigdet_tggl_cnt_clr
        read
        read_rg_sigdet_tggl_cnt_clr = read_rg_sigdet_tggl_cnt_clr_value
    End Property

    Property Let write_rg_sigdet_tggl_cnt_clr(aData)
        set_rg_sigdet_tggl_cnt_clr = aData
        write
    End Property

    Property Get get_rg_sigdet_filter_sel_gen1
        get_rg_sigdet_filter_sel_gen1 = read_rg_sigdet_filter_sel_gen1_value
    End Property

    Property Let set_rg_sigdet_filter_sel_gen1(aData)
        write_rg_sigdet_filter_sel_gen1_value = aData
        flag_rg_sigdet_filter_sel_gen1        = &H1
    End Property

    Property Get read_rg_sigdet_filter_sel_gen1
        read
        read_rg_sigdet_filter_sel_gen1 = read_rg_sigdet_filter_sel_gen1_value
    End Property

    Property Let write_rg_sigdet_filter_sel_gen1(aData)
        set_rg_sigdet_filter_sel_gen1 = aData
        write
    End Property

    Property Get get_rg_sigdet_filter_sel_gen2
        get_rg_sigdet_filter_sel_gen2 = read_rg_sigdet_filter_sel_gen2_value
    End Property

    Property Let set_rg_sigdet_filter_sel_gen2(aData)
        write_rg_sigdet_filter_sel_gen2_value = aData
        flag_rg_sigdet_filter_sel_gen2        = &H1
    End Property

    Property Get read_rg_sigdet_filter_sel_gen2
        read
        read_rg_sigdet_filter_sel_gen2 = read_rg_sigdet_filter_sel_gen2_value
    End Property

    Property Let write_rg_sigdet_filter_sel_gen2(aData)
        set_rg_sigdet_filter_sel_gen2 = aData
        write
    End Property

    Property Get get_rg_sigdet_sm_rst_cya
        get_rg_sigdet_sm_rst_cya = read_rg_sigdet_sm_rst_cya_value
    End Property

    Property Let set_rg_sigdet_sm_rst_cya(aData)
        write_rg_sigdet_sm_rst_cya_value = aData
        flag_rg_sigdet_sm_rst_cya        = &H1
    End Property

    Property Get read_rg_sigdet_sm_rst_cya
        read
        read_rg_sigdet_sm_rst_cya = read_rg_sigdet_sm_rst_cya_value
    End Property

    Property Let write_rg_sigdet_sm_rst_cya(aData)
        set_rg_sigdet_sm_rst_cya = aData
        write
    End Property

    Property Get get_rg_early_pat_det_wo_scal
        get_rg_early_pat_det_wo_scal = read_rg_early_pat_det_wo_scal_value
    End Property

    Property Let set_rg_early_pat_det_wo_scal(aData)
        write_rg_early_pat_det_wo_scal_value = aData
        flag_rg_early_pat_det_wo_scal        = &H1
    End Property

    Property Get read_rg_early_pat_det_wo_scal
        read
        read_rg_early_pat_det_wo_scal = read_rg_early_pat_det_wo_scal_value
    End Property

    Property Let write_rg_early_pat_det_wo_scal(aData)
        set_rg_early_pat_det_wo_scal = aData
        write
    End Property

    Property Get get_rg_sigdet_sm_rst
        get_rg_sigdet_sm_rst = read_rg_sigdet_sm_rst_value
    End Property

    Property Let set_rg_sigdet_sm_rst(aData)
        write_rg_sigdet_sm_rst_value = aData
        flag_rg_sigdet_sm_rst        = &H1
    End Property

    Property Get read_rg_sigdet_sm_rst
        read
        read_rg_sigdet_sm_rst = read_rg_sigdet_sm_rst_value
    End Property

    Property Let write_rg_sigdet_sm_rst(aData)
        set_rg_sigdet_sm_rst = aData
        write
    End Property

    Property Get get_rg_eieos_det_bypass
        get_rg_eieos_det_bypass = read_rg_eieos_det_bypass_value
    End Property

    Property Let set_rg_eieos_det_bypass(aData)
        write_rg_eieos_det_bypass_value = aData
        flag_rg_eieos_det_bypass        = &H1
    End Property

    Property Get read_rg_eieos_det_bypass
        read
        read_rg_eieos_det_bypass = read_rg_eieos_det_bypass_value
    End Property

    Property Let write_rg_eieos_det_bypass(aData)
        set_rg_eieos_det_bypass = aData
        write
    End Property

    Property Get get_rg_eios_det_bypass
        get_rg_eios_det_bypass = read_rg_eios_det_bypass_value
    End Property

    Property Let set_rg_eios_det_bypass(aData)
        write_rg_eios_det_bypass_value = aData
        flag_rg_eios_det_bypass        = &H1
    End Property

    Property Get read_rg_eios_det_bypass
        read
        read_rg_eios_det_bypass = read_rg_eios_det_bypass_value
    End Property

    Property Let write_rg_eios_det_bypass(aData)
        set_rg_eios_det_bypass = aData
        write
    End Property

    Property Get get_rg_com_detect_cnt_gen2
        get_rg_com_detect_cnt_gen2 = read_rg_com_detect_cnt_gen2_value
    End Property

    Property Let set_rg_com_detect_cnt_gen2(aData)
        write_rg_com_detect_cnt_gen2_value = aData
        flag_rg_com_detect_cnt_gen2        = &H1
    End Property

    Property Get read_rg_com_detect_cnt_gen2
        read
        read_rg_com_detect_cnt_gen2 = read_rg_com_detect_cnt_gen2_value
    End Property

    Property Let write_rg_com_detect_cnt_gen2(aData)
        set_rg_com_detect_cnt_gen2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_rg_sigdet_tggl_cnt_clr_value = rightShift(data_low, 15) and &H1
        read_rg_sigdet_filter_sel_gen1_value = rightShift(data_low, 14) and &H1
        read_rg_sigdet_filter_sel_gen2_value = rightShift(data_low, 13) and &H1
        read_rg_sigdet_sm_rst_cya_value = rightShift(data_low, 12) and &H1
        read_rg_early_pat_det_wo_scal_value = rightShift(data_low, 11) and &H1
        read_rg_sigdet_sm_rst_value = rightShift(data_low, 10) and &H1
        read_rg_eieos_det_bypass_value = rightShift(data_low, 9) and &H1
        read_rg_eios_det_bypass_value = rightShift(data_low, 8) and &H1
        rg_com_detect_cnt_gen2_mask = &Hff
        if data_low > LONG_MAX then
            if rg_com_detect_cnt_gen2_mask = mask then
                read_rg_com_detect_cnt_gen2_value = data_low
            else
                read_rg_com_detect_cnt_gen2_value = (data_low - H8000_0000) and rg_com_detect_cnt_gen2_mask
            end If
        else
            read_rg_com_detect_cnt_gen2_value = data_low and rg_com_detect_cnt_gen2_mask
        end If

    End Sub

    Sub write
        If flag_rg_sigdet_tggl_cnt_clr = &H0 or flag_rg_sigdet_filter_sel_gen1 = &H0 or flag_rg_sigdet_filter_sel_gen2 = &H0 or flag_rg_sigdet_sm_rst_cya = &H0 or flag_rg_early_pat_det_wo_scal = &H0 or flag_rg_sigdet_sm_rst = &H0 or flag_rg_eieos_det_bypass = &H0 or flag_rg_eios_det_bypass = &H0 or flag_rg_com_detect_cnt_gen2 = &H0 Then read
        If flag_rg_sigdet_tggl_cnt_clr = &H0 Then write_rg_sigdet_tggl_cnt_clr_value = get_rg_sigdet_tggl_cnt_clr
        If flag_rg_sigdet_filter_sel_gen1 = &H0 Then write_rg_sigdet_filter_sel_gen1_value = get_rg_sigdet_filter_sel_gen1
        If flag_rg_sigdet_filter_sel_gen2 = &H0 Then write_rg_sigdet_filter_sel_gen2_value = get_rg_sigdet_filter_sel_gen2
        If flag_rg_sigdet_sm_rst_cya = &H0 Then write_rg_sigdet_sm_rst_cya_value = get_rg_sigdet_sm_rst_cya
        If flag_rg_early_pat_det_wo_scal = &H0 Then write_rg_early_pat_det_wo_scal_value = get_rg_early_pat_det_wo_scal
        If flag_rg_sigdet_sm_rst = &H0 Then write_rg_sigdet_sm_rst_value = get_rg_sigdet_sm_rst
        If flag_rg_eieos_det_bypass = &H0 Then write_rg_eieos_det_bypass_value = get_rg_eieos_det_bypass
        If flag_rg_eios_det_bypass = &H0 Then write_rg_eios_det_bypass_value = get_rg_eios_det_bypass
        If flag_rg_com_detect_cnt_gen2 = &H0 Then write_rg_com_detect_cnt_gen2_value = get_rg_com_detect_cnt_gen2

        regValue = leftShift((write_rg_sigdet_tggl_cnt_clr_value and &H1), 15) + leftShift((write_rg_sigdet_filter_sel_gen1_value and &H1), 14) + leftShift((write_rg_sigdet_filter_sel_gen2_value and &H1), 13) + leftShift((write_rg_sigdet_sm_rst_cya_value and &H1), 12) + leftShift((write_rg_early_pat_det_wo_scal_value and &H1), 11) + leftShift((write_rg_sigdet_sm_rst_value and &H1), 10) + leftShift((write_rg_eieos_det_bypass_value and &H1), 9) + leftShift((write_rg_eios_det_bypass_value and &H1), 8) + leftShift((write_rg_com_detect_cnt_gen2_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_rg_sigdet_tggl_cnt_clr_value = rightShift(data_low, 15) and &H1
        read_rg_sigdet_filter_sel_gen1_value = rightShift(data_low, 14) and &H1
        read_rg_sigdet_filter_sel_gen2_value = rightShift(data_low, 13) and &H1
        read_rg_sigdet_sm_rst_cya_value = rightShift(data_low, 12) and &H1
        read_rg_early_pat_det_wo_scal_value = rightShift(data_low, 11) and &H1
        read_rg_sigdet_sm_rst_value = rightShift(data_low, 10) and &H1
        read_rg_eieos_det_bypass_value = rightShift(data_low, 9) and &H1
        read_rg_eios_det_bypass_value = rightShift(data_low, 8) and &H1
        rg_com_detect_cnt_gen2_mask = &Hff
        if data_low > LONG_MAX then
            if rg_com_detect_cnt_gen2_mask = mask then
                read_rg_com_detect_cnt_gen2_value = data_low
            else
                read_rg_com_detect_cnt_gen2_value = (data_low - H8000_0000) and rg_com_detect_cnt_gen2_mask
            end If
        else
            read_rg_com_detect_cnt_gen2_value = data_low and rg_com_detect_cnt_gen2_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_rg_sigdet_tggl_cnt_clr_value = &H0
        flag_rg_sigdet_tggl_cnt_clr        = &H0
        write_rg_sigdet_filter_sel_gen1_value = &H0
        flag_rg_sigdet_filter_sel_gen1        = &H0
        write_rg_sigdet_filter_sel_gen2_value = &H0
        flag_rg_sigdet_filter_sel_gen2        = &H0
        write_rg_sigdet_sm_rst_cya_value = &H0
        flag_rg_sigdet_sm_rst_cya        = &H0
        write_rg_early_pat_det_wo_scal_value = &H0
        flag_rg_early_pat_det_wo_scal        = &H0
        write_rg_sigdet_sm_rst_value = &H0
        flag_rg_sigdet_sm_rst        = &H0
        write_rg_eieos_det_bypass_value = &H0
        flag_rg_eieos_det_bypass        = &H0
        write_rg_eios_det_bypass_value = &H0
        flag_rg_eios_det_bypass        = &H0
        write_rg_com_detect_cnt_gen2_value = &H0
        flag_rg_com_detect_cnt_gen2        = &H0
    End Sub
End Class


'' @REGISTER : SIGDET_PCIE_SGMIIPCIE_X1_sigdet_ctrl_7
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' rg_sigdet_cnt_src_sel                      [15:14]          get_rg_sigdet_cnt_src_sel
''                                                             set_rg_sigdet_cnt_src_sel
''                                                             read_rg_sigdet_cnt_src_sel
''                                                             write_rg_sigdet_cnt_src_sel
''---------------------------------------------------------------------------------
'' RSRQLR                                     [13:12]          get_RSRQLR
''                                                             set_RSRQLR
''                                                             read_RSRQLR
''                                                             write_RSRQLR
''---------------------------------------------------------------------------------
'' RSFLRG1                                    [11:8]           get_RSFLRG1
''                                                             set_RSFLRG1
''                                                             read_RSFLRG1
''                                                             write_RSFLRG1
''---------------------------------------------------------------------------------
'' RSFLRG2                                    [7:4]            get_RSFLRG2
''                                                             set_RSFLRG2
''                                                             read_RSFLRG2
''                                                             write_RSFLRG2
''---------------------------------------------------------------------------------
Class REGISTER_SIGDET_PCIE_SGMIIPCIE_X1_sigdet_ctrl_7
    Private write_rg_sigdet_cnt_src_sel_value
    Private read_rg_sigdet_cnt_src_sel_value
    Private flag_rg_sigdet_cnt_src_sel
    Private write_RSRQLR_value
    Private read_RSRQLR_value
    Private flag_RSRQLR
    Private write_RSFLRG1_value
    Private read_RSFLRG1_value
    Private flag_RSFLRG1
    Private write_RSFLRG2_value
    Private read_RSFLRG2_value
    Private flag_RSFLRG2

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

    Property Get get_rg_sigdet_cnt_src_sel
        get_rg_sigdet_cnt_src_sel = read_rg_sigdet_cnt_src_sel_value
    End Property

    Property Let set_rg_sigdet_cnt_src_sel(aData)
        write_rg_sigdet_cnt_src_sel_value = aData
        flag_rg_sigdet_cnt_src_sel        = &H1
    End Property

    Property Get read_rg_sigdet_cnt_src_sel
        read
        read_rg_sigdet_cnt_src_sel = read_rg_sigdet_cnt_src_sel_value
    End Property

    Property Let write_rg_sigdet_cnt_src_sel(aData)
        set_rg_sigdet_cnt_src_sel = aData
        write
    End Property

    Property Get get_RSRQLR
        get_RSRQLR = read_RSRQLR_value
    End Property

    Property Let set_RSRQLR(aData)
        write_RSRQLR_value = aData
        flag_RSRQLR        = &H1
    End Property

    Property Get read_RSRQLR
        read
        read_RSRQLR = read_RSRQLR_value
    End Property

    Property Let write_RSRQLR(aData)
        set_RSRQLR = aData
        write
    End Property

    Property Get get_RSFLRG1
        get_RSFLRG1 = read_RSFLRG1_value
    End Property

    Property Let set_RSFLRG1(aData)
        write_RSFLRG1_value = aData
        flag_RSFLRG1        = &H1
    End Property

    Property Get read_RSFLRG1
        read
        read_RSFLRG1 = read_RSFLRG1_value
    End Property

    Property Let write_RSFLRG1(aData)
        set_RSFLRG1 = aData
        write
    End Property

    Property Get get_RSFLRG2
        get_RSFLRG2 = read_RSFLRG2_value
    End Property

    Property Let set_RSFLRG2(aData)
        write_RSFLRG2_value = aData
        flag_RSFLRG2        = &H1
    End Property

    Property Get read_RSFLRG2
        read
        read_RSFLRG2 = read_RSFLRG2_value
    End Property

    Property Let write_RSFLRG2(aData)
        set_RSFLRG2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_rg_sigdet_cnt_src_sel_value = rightShift(data_low, 14) and &H3
        read_RSRQLR_value = rightShift(data_low, 12) and &H3
        read_RSFLRG1_value = rightShift(data_low, 8) and &Hf
        read_RSFLRG2_value = rightShift(data_low, 4) and &Hf

    End Sub

    Sub write
        If flag_rg_sigdet_cnt_src_sel = &H0 or flag_RSRQLR = &H0 or flag_RSFLRG1 = &H0 or flag_RSFLRG2 = &H0 Then read
        If flag_rg_sigdet_cnt_src_sel = &H0 Then write_rg_sigdet_cnt_src_sel_value = get_rg_sigdet_cnt_src_sel
        If flag_RSRQLR = &H0 Then write_RSRQLR_value = get_RSRQLR
        If flag_RSFLRG1 = &H0 Then write_RSFLRG1_value = get_RSFLRG1
        If flag_RSFLRG2 = &H0 Then write_RSFLRG2_value = get_RSFLRG2

        regValue = leftShift((write_rg_sigdet_cnt_src_sel_value and &H3), 14) + leftShift((write_RSRQLR_value and &H3), 12) + leftShift((write_RSFLRG1_value and &Hf), 8) + leftShift((write_RSFLRG2_value and &Hf), 4)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_rg_sigdet_cnt_src_sel_value = rightShift(data_low, 14) and &H3
        read_RSRQLR_value = rightShift(data_low, 12) and &H3
        read_RSFLRG1_value = rightShift(data_low, 8) and &Hf
        read_RSFLRG2_value = rightShift(data_low, 4) and &Hf

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_rg_sigdet_cnt_src_sel_value = &H0
        flag_rg_sigdet_cnt_src_sel        = &H0
        write_RSRQLR_value = &H0
        flag_RSRQLR        = &H0
        write_RSFLRG1_value = &H0
        flag_RSFLRG1        = &H0
        write_RSFLRG2_value = &H0
        flag_RSFLRG2        = &H0
    End Sub
End Class


'' @REGISTER : SIGDET_PCIE_SGMIIPCIE_X1_sigdet_ctrl_8
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' rg_com_det_pattern_sel                     [15:14]          get_rg_com_det_pattern_sel
''                                                             set_rg_com_det_pattern_sel
''                                                             read_rg_com_det_pattern_sel
''                                                             write_rg_com_det_pattern_sel
''---------------------------------------------------------------------------------
'' RSRQLA                                     [13:12]          get_RSRQLA
''                                                             set_RSRQLA
''                                                             read_RSRQLA
''                                                             write_RSRQLA
''---------------------------------------------------------------------------------
'' RSFLAG1                                    [11:8]           get_RSFLAG1
''                                                             set_RSFLAG1
''                                                             read_RSFLAG1
''                                                             write_RSFLAG1
''---------------------------------------------------------------------------------
'' RSFLAG2                                    [7:4]            get_RSFLAG2
''                                                             set_RSFLAG2
''                                                             read_RSFLAG2
''                                                             write_RSFLAG2
''---------------------------------------------------------------------------------
Class REGISTER_SIGDET_PCIE_SGMIIPCIE_X1_sigdet_ctrl_8
    Private write_rg_com_det_pattern_sel_value
    Private read_rg_com_det_pattern_sel_value
    Private flag_rg_com_det_pattern_sel
    Private write_RSRQLA_value
    Private read_RSRQLA_value
    Private flag_RSRQLA
    Private write_RSFLAG1_value
    Private read_RSFLAG1_value
    Private flag_RSFLAG1
    Private write_RSFLAG2_value
    Private read_RSFLAG2_value
    Private flag_RSFLAG2

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

    Property Get get_rg_com_det_pattern_sel
        get_rg_com_det_pattern_sel = read_rg_com_det_pattern_sel_value
    End Property

    Property Let set_rg_com_det_pattern_sel(aData)
        write_rg_com_det_pattern_sel_value = aData
        flag_rg_com_det_pattern_sel        = &H1
    End Property

    Property Get read_rg_com_det_pattern_sel
        read
        read_rg_com_det_pattern_sel = read_rg_com_det_pattern_sel_value
    End Property

    Property Let write_rg_com_det_pattern_sel(aData)
        set_rg_com_det_pattern_sel = aData
        write
    End Property

    Property Get get_RSRQLA
        get_RSRQLA = read_RSRQLA_value
    End Property

    Property Let set_RSRQLA(aData)
        write_RSRQLA_value = aData
        flag_RSRQLA        = &H1
    End Property

    Property Get read_RSRQLA
        read
        read_RSRQLA = read_RSRQLA_value
    End Property

    Property Let write_RSRQLA(aData)
        set_RSRQLA = aData
        write
    End Property

    Property Get get_RSFLAG1
        get_RSFLAG1 = read_RSFLAG1_value
    End Property

    Property Let set_RSFLAG1(aData)
        write_RSFLAG1_value = aData
        flag_RSFLAG1        = &H1
    End Property

    Property Get read_RSFLAG1
        read
        read_RSFLAG1 = read_RSFLAG1_value
    End Property

    Property Let write_RSFLAG1(aData)
        set_RSFLAG1 = aData
        write
    End Property

    Property Get get_RSFLAG2
        get_RSFLAG2 = read_RSFLAG2_value
    End Property

    Property Let set_RSFLAG2(aData)
        write_RSFLAG2_value = aData
        flag_RSFLAG2        = &H1
    End Property

    Property Get read_RSFLAG2
        read
        read_RSFLAG2 = read_RSFLAG2_value
    End Property

    Property Let write_RSFLAG2(aData)
        set_RSFLAG2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_rg_com_det_pattern_sel_value = rightShift(data_low, 14) and &H3
        read_RSRQLA_value = rightShift(data_low, 12) and &H3
        read_RSFLAG1_value = rightShift(data_low, 8) and &Hf
        read_RSFLAG2_value = rightShift(data_low, 4) and &Hf

    End Sub

    Sub write
        If flag_rg_com_det_pattern_sel = &H0 or flag_RSRQLA = &H0 or flag_RSFLAG1 = &H0 or flag_RSFLAG2 = &H0 Then read
        If flag_rg_com_det_pattern_sel = &H0 Then write_rg_com_det_pattern_sel_value = get_rg_com_det_pattern_sel
        If flag_RSRQLA = &H0 Then write_RSRQLA_value = get_RSRQLA
        If flag_RSFLAG1 = &H0 Then write_RSFLAG1_value = get_RSFLAG1
        If flag_RSFLAG2 = &H0 Then write_RSFLAG2_value = get_RSFLAG2

        regValue = leftShift((write_rg_com_det_pattern_sel_value and &H3), 14) + leftShift((write_RSRQLA_value and &H3), 12) + leftShift((write_RSFLAG1_value and &Hf), 8) + leftShift((write_RSFLAG2_value and &Hf), 4)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_rg_com_det_pattern_sel_value = rightShift(data_low, 14) and &H3
        read_RSRQLA_value = rightShift(data_low, 12) and &H3
        read_RSFLAG1_value = rightShift(data_low, 8) and &Hf
        read_RSFLAG2_value = rightShift(data_low, 4) and &Hf

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_rg_com_det_pattern_sel_value = &H0
        flag_rg_com_det_pattern_sel        = &H0
        write_RSRQLA_value = &H0
        flag_RSRQLA        = &H0
        write_RSFLAG1_value = &H0
        flag_RSFLAG1        = &H0
        write_RSFLAG2_value = &H0
        flag_RSFLAG2        = &H0
    End Sub
End Class


'' @REGISTER : SIGDET_PCIE_SGMIIPCIE_X1_sigdet_stat_0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' rx_sigdet_mac                              [2:2]            get_rx_sigdet_mac
''                                                             set_rx_sigdet_mac
''                                                             read_rx_sigdet_mac
''                                                             write_rx_sigdet_mac
''---------------------------------------------------------------------------------
'' rx_sigdet_dsc                              [1:1]            get_rx_sigdet_dsc
''                                                             set_rx_sigdet_dsc
''                                                             read_rx_sigdet_dsc
''                                                             write_rx_sigdet_dsc
''---------------------------------------------------------------------------------
'' afe_sigdet_raw                             [0:0]            get_afe_sigdet_raw
''                                                             set_afe_sigdet_raw
''                                                             read_afe_sigdet_raw
''                                                             write_afe_sigdet_raw
''---------------------------------------------------------------------------------
Class REGISTER_SIGDET_PCIE_SGMIIPCIE_X1_sigdet_stat_0
    Private write_rx_sigdet_mac_value
    Private read_rx_sigdet_mac_value
    Private flag_rx_sigdet_mac
    Private write_rx_sigdet_dsc_value
    Private read_rx_sigdet_dsc_value
    Private flag_rx_sigdet_dsc
    Private write_afe_sigdet_raw_value
    Private read_afe_sigdet_raw_value
    Private flag_afe_sigdet_raw

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

    Property Get get_rx_sigdet_mac
        get_rx_sigdet_mac = read_rx_sigdet_mac_value
    End Property

    Property Let set_rx_sigdet_mac(aData)
        write_rx_sigdet_mac_value = aData
        flag_rx_sigdet_mac        = &H1
    End Property

    Property Get read_rx_sigdet_mac
        read
        read_rx_sigdet_mac = read_rx_sigdet_mac_value
    End Property

    Property Let write_rx_sigdet_mac(aData)
        set_rx_sigdet_mac = aData
        write
    End Property

    Property Get get_rx_sigdet_dsc
        get_rx_sigdet_dsc = read_rx_sigdet_dsc_value
    End Property

    Property Let set_rx_sigdet_dsc(aData)
        write_rx_sigdet_dsc_value = aData
        flag_rx_sigdet_dsc        = &H1
    End Property

    Property Get read_rx_sigdet_dsc
        read
        read_rx_sigdet_dsc = read_rx_sigdet_dsc_value
    End Property

    Property Let write_rx_sigdet_dsc(aData)
        set_rx_sigdet_dsc = aData
        write
    End Property

    Property Get get_afe_sigdet_raw
        get_afe_sigdet_raw = read_afe_sigdet_raw_value
    End Property

    Property Let set_afe_sigdet_raw(aData)
        write_afe_sigdet_raw_value = aData
        flag_afe_sigdet_raw        = &H1
    End Property

    Property Get read_afe_sigdet_raw
        read
        read_afe_sigdet_raw = read_afe_sigdet_raw_value
    End Property

    Property Let write_afe_sigdet_raw(aData)
        set_afe_sigdet_raw = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_rx_sigdet_mac_value = rightShift(data_low, 2) and &H1
        read_rx_sigdet_dsc_value = rightShift(data_low, 1) and &H1
        afe_sigdet_raw_mask = &H1
        if data_low > LONG_MAX then
            if afe_sigdet_raw_mask = mask then
                read_afe_sigdet_raw_value = data_low
            else
                read_afe_sigdet_raw_value = (data_low - H8000_0000) and afe_sigdet_raw_mask
            end If
        else
            read_afe_sigdet_raw_value = data_low and afe_sigdet_raw_mask
        end If

    End Sub

    Sub write
        If flag_rx_sigdet_mac = &H0 or flag_rx_sigdet_dsc = &H0 or flag_afe_sigdet_raw = &H0 Then read
        If flag_rx_sigdet_mac = &H0 Then write_rx_sigdet_mac_value = get_rx_sigdet_mac
        If flag_rx_sigdet_dsc = &H0 Then write_rx_sigdet_dsc_value = get_rx_sigdet_dsc
        If flag_afe_sigdet_raw = &H0 Then write_afe_sigdet_raw_value = get_afe_sigdet_raw

        regValue = leftShift((write_rx_sigdet_mac_value and &H1), 2) + leftShift((write_rx_sigdet_dsc_value and &H1), 1) + leftShift((write_afe_sigdet_raw_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_rx_sigdet_mac_value = rightShift(data_low, 2) and &H1
        read_rx_sigdet_dsc_value = rightShift(data_low, 1) and &H1
        afe_sigdet_raw_mask = &H1
        if data_low > LONG_MAX then
            if afe_sigdet_raw_mask = mask then
                read_afe_sigdet_raw_value = data_low
            else
                read_afe_sigdet_raw_value = (data_low - H8000_0000) and afe_sigdet_raw_mask
            end If
        else
            read_afe_sigdet_raw_value = data_low and afe_sigdet_raw_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_rx_sigdet_mac_value = &H0
        flag_rx_sigdet_mac        = &H0
        write_rx_sigdet_dsc_value = &H0
        flag_rx_sigdet_dsc        = &H0
        write_afe_sigdet_raw_value = &H0
        flag_afe_sigdet_raw        = &H0
    End Sub
End Class


'' @REGISTER : SIGDET_PCIE_SGMIIPCIE_X1_sigdet_stat_1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' rg_sigdet_tggl_cnt                         [15:0]           get_rg_sigdet_tggl_cnt
''                                                             set_rg_sigdet_tggl_cnt
''                                                             read_rg_sigdet_tggl_cnt
''                                                             write_rg_sigdet_tggl_cnt
''---------------------------------------------------------------------------------
Class REGISTER_SIGDET_PCIE_SGMIIPCIE_X1_sigdet_stat_1
    Private write_rg_sigdet_tggl_cnt_value
    Private read_rg_sigdet_tggl_cnt_value
    Private flag_rg_sigdet_tggl_cnt

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

    Property Get get_rg_sigdet_tggl_cnt
        get_rg_sigdet_tggl_cnt = read_rg_sigdet_tggl_cnt_value
    End Property

    Property Let set_rg_sigdet_tggl_cnt(aData)
        write_rg_sigdet_tggl_cnt_value = aData
        flag_rg_sigdet_tggl_cnt        = &H1
    End Property

    Property Get read_rg_sigdet_tggl_cnt
        read
        read_rg_sigdet_tggl_cnt = read_rg_sigdet_tggl_cnt_value
    End Property

    Property Let write_rg_sigdet_tggl_cnt(aData)
        set_rg_sigdet_tggl_cnt = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rg_sigdet_tggl_cnt_mask = &Hffff
        if data_low > LONG_MAX then
            if rg_sigdet_tggl_cnt_mask = mask then
                read_rg_sigdet_tggl_cnt_value = data_low
            else
                read_rg_sigdet_tggl_cnt_value = (data_low - H8000_0000) and rg_sigdet_tggl_cnt_mask
            end If
        else
            read_rg_sigdet_tggl_cnt_value = data_low and rg_sigdet_tggl_cnt_mask
        end If

    End Sub

    Sub write
        If flag_rg_sigdet_tggl_cnt = &H0 Then read
        If flag_rg_sigdet_tggl_cnt = &H0 Then write_rg_sigdet_tggl_cnt_value = get_rg_sigdet_tggl_cnt

        regValue = leftShift((write_rg_sigdet_tggl_cnt_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rg_sigdet_tggl_cnt_mask = &Hffff
        if data_low > LONG_MAX then
            if rg_sigdet_tggl_cnt_mask = mask then
                read_rg_sigdet_tggl_cnt_value = data_low
            else
                read_rg_sigdet_tggl_cnt_value = (data_low - H8000_0000) and rg_sigdet_tggl_cnt_mask
            end If
        else
            read_rg_sigdet_tggl_cnt_value = data_low and rg_sigdet_tggl_cnt_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_rg_sigdet_tggl_cnt_value = &H0
        flag_rg_sigdet_tggl_cnt        = &H0
    End Sub
End Class


'' @REGISTER : SIGDET_PCIE_SGMIIPCIE_X1_sigdet_ctrl_10
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' rg_sigdet_deassert_tmr                     [5:0]            get_rg_sigdet_deassert_tmr
''                                                             set_rg_sigdet_deassert_tmr
''                                                             read_rg_sigdet_deassert_tmr
''                                                             write_rg_sigdet_deassert_tmr
''---------------------------------------------------------------------------------
'' RSDTS                                      [6:6]            get_RSDTS
''                                                             set_RSDTS
''                                                             read_RSDTS
''                                                             write_RSDTS
''---------------------------------------------------------------------------------
'' spares_sigdet                              [15:12]          get_spares_sigdet
''                                                             set_spares_sigdet
''                                                             read_spares_sigdet
''                                                             write_spares_sigdet
''---------------------------------------------------------------------------------
Class REGISTER_SIGDET_PCIE_SGMIIPCIE_X1_sigdet_ctrl_10
    Private write_rg_sigdet_deassert_tmr_value
    Private read_rg_sigdet_deassert_tmr_value
    Private flag_rg_sigdet_deassert_tmr
    Private write_RSDTS_value
    Private read_RSDTS_value
    Private flag_RSDTS
    Private write_spares_sigdet_value
    Private read_spares_sigdet_value
    Private flag_spares_sigdet

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

    Property Get get_rg_sigdet_deassert_tmr
        get_rg_sigdet_deassert_tmr = read_rg_sigdet_deassert_tmr_value
    End Property

    Property Let set_rg_sigdet_deassert_tmr(aData)
        write_rg_sigdet_deassert_tmr_value = aData
        flag_rg_sigdet_deassert_tmr        = &H1
    End Property

    Property Get read_rg_sigdet_deassert_tmr
        read
        read_rg_sigdet_deassert_tmr = read_rg_sigdet_deassert_tmr_value
    End Property

    Property Let write_rg_sigdet_deassert_tmr(aData)
        set_rg_sigdet_deassert_tmr = aData
        write
    End Property

    Property Get get_RSDTS
        get_RSDTS = read_RSDTS_value
    End Property

    Property Let set_RSDTS(aData)
        write_RSDTS_value = aData
        flag_RSDTS        = &H1
    End Property

    Property Get read_RSDTS
        read
        read_RSDTS = read_RSDTS_value
    End Property

    Property Let write_RSDTS(aData)
        set_RSDTS = aData
        write
    End Property

    Property Get get_spares_sigdet
        get_spares_sigdet = read_spares_sigdet_value
    End Property

    Property Let set_spares_sigdet(aData)
        write_spares_sigdet_value = aData
        flag_spares_sigdet        = &H1
    End Property

    Property Get read_spares_sigdet
        read
        read_spares_sigdet = read_spares_sigdet_value
    End Property

    Property Let write_spares_sigdet(aData)
        set_spares_sigdet = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rg_sigdet_deassert_tmr_mask = &H3f
        if data_low > LONG_MAX then
            if rg_sigdet_deassert_tmr_mask = mask then
                read_rg_sigdet_deassert_tmr_value = data_low
            else
                read_rg_sigdet_deassert_tmr_value = (data_low - H8000_0000) and rg_sigdet_deassert_tmr_mask
            end If
        else
            read_rg_sigdet_deassert_tmr_value = data_low and rg_sigdet_deassert_tmr_mask
        end If
        read_RSDTS_value = rightShift(data_low, 6) and &H1
        read_spares_sigdet_value = rightShift(data_low, 12) and &Hf

    End Sub

    Sub write
        If flag_rg_sigdet_deassert_tmr = &H0 or flag_RSDTS = &H0 or flag_spares_sigdet = &H0 Then read
        If flag_rg_sigdet_deassert_tmr = &H0 Then write_rg_sigdet_deassert_tmr_value = get_rg_sigdet_deassert_tmr
        If flag_RSDTS = &H0 Then write_RSDTS_value = get_RSDTS
        If flag_spares_sigdet = &H0 Then write_spares_sigdet_value = get_spares_sigdet

        regValue = leftShift((write_rg_sigdet_deassert_tmr_value and &H3f), 0) + leftShift((write_RSDTS_value and &H1), 6) + leftShift((write_spares_sigdet_value and &Hf), 12)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rg_sigdet_deassert_tmr_mask = &H3f
        if data_low > LONG_MAX then
            if rg_sigdet_deassert_tmr_mask = mask then
                read_rg_sigdet_deassert_tmr_value = data_low
            else
                read_rg_sigdet_deassert_tmr_value = (data_low - H8000_0000) and rg_sigdet_deassert_tmr_mask
            end If
        else
            read_rg_sigdet_deassert_tmr_value = data_low and rg_sigdet_deassert_tmr_mask
        end If
        read_RSDTS_value = rightShift(data_low, 6) and &H1
        read_spares_sigdet_value = rightShift(data_low, 12) and &Hf

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_rg_sigdet_deassert_tmr_value = &H0
        flag_rg_sigdet_deassert_tmr        = &H0
        write_RSDTS_value = &H0
        flag_RSDTS        = &H0
        write_spares_sigdet_value = &H0
        flag_spares_sigdet        = &H0
    End Sub
End Class


'' @REGISTER : SIGDET_PCIE_SGMIIPCIE_X1_sigdet_ctrl_11
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' rg_rloop_sigdet_sm_sel                     [15:15]          get_rg_rloop_sigdet_sm_sel
''                                                             set_rg_rloop_sigdet_sm_sel
''                                                             read_rg_rloop_sigdet_sm_sel
''                                                             write_rg_rloop_sigdet_sm_sel
''---------------------------------------------------------------------------------
'' rg_use_legacy_rx_sigdet                    [7:7]            get_rg_use_legacy_rx_sigdet
''                                                             set_rg_use_legacy_rx_sigdet
''                                                             read_rg_use_legacy_rx_sigdet
''                                                             write_rg_use_legacy_rx_sigdet
''---------------------------------------------------------------------------------
'' rg_no_raw_sigdet                           [6:6]            get_rg_no_raw_sigdet
''                                                             set_rg_no_raw_sigdet
''                                                             read_rg_no_raw_sigdet
''                                                             write_rg_no_raw_sigdet
''---------------------------------------------------------------------------------
'' rg_sigdet_sm_sel_gen2                      [5:5]            get_rg_sigdet_sm_sel_gen2
''                                                             set_rg_sigdet_sm_sel_gen2
''                                                             read_rg_sigdet_sm_sel_gen2
''                                                             write_rg_sigdet_sm_sel_gen2
''---------------------------------------------------------------------------------
'' rg_eios_detect_sel_gen2                    [4:4]            get_rg_eios_detect_sel_gen2
''                                                             set_rg_eios_detect_sel_gen2
''                                                             read_rg_eios_detect_sel_gen2
''                                                             write_rg_eios_detect_sel_gen2
''---------------------------------------------------------------------------------
'' rg_eieos_detect_cnt_gen2                   [3:0]            get_rg_eieos_detect_cnt_gen2
''                                                             set_rg_eieos_detect_cnt_gen2
''                                                             read_rg_eieos_detect_cnt_gen2
''                                                             write_rg_eieos_detect_cnt_gen2
''---------------------------------------------------------------------------------
Class REGISTER_SIGDET_PCIE_SGMIIPCIE_X1_sigdet_ctrl_11
    Private write_rg_rloop_sigdet_sm_sel_value
    Private read_rg_rloop_sigdet_sm_sel_value
    Private flag_rg_rloop_sigdet_sm_sel
    Private write_rg_use_legacy_rx_sigdet_value
    Private read_rg_use_legacy_rx_sigdet_value
    Private flag_rg_use_legacy_rx_sigdet
    Private write_rg_no_raw_sigdet_value
    Private read_rg_no_raw_sigdet_value
    Private flag_rg_no_raw_sigdet
    Private write_rg_sigdet_sm_sel_gen2_value
    Private read_rg_sigdet_sm_sel_gen2_value
    Private flag_rg_sigdet_sm_sel_gen2
    Private write_rg_eios_detect_sel_gen2_value
    Private read_rg_eios_detect_sel_gen2_value
    Private flag_rg_eios_detect_sel_gen2
    Private write_rg_eieos_detect_cnt_gen2_value
    Private read_rg_eieos_detect_cnt_gen2_value
    Private flag_rg_eieos_detect_cnt_gen2

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

    Property Get get_rg_rloop_sigdet_sm_sel
        get_rg_rloop_sigdet_sm_sel = read_rg_rloop_sigdet_sm_sel_value
    End Property

    Property Let set_rg_rloop_sigdet_sm_sel(aData)
        write_rg_rloop_sigdet_sm_sel_value = aData
        flag_rg_rloop_sigdet_sm_sel        = &H1
    End Property

    Property Get read_rg_rloop_sigdet_sm_sel
        read
        read_rg_rloop_sigdet_sm_sel = read_rg_rloop_sigdet_sm_sel_value
    End Property

    Property Let write_rg_rloop_sigdet_sm_sel(aData)
        set_rg_rloop_sigdet_sm_sel = aData
        write
    End Property

    Property Get get_rg_use_legacy_rx_sigdet
        get_rg_use_legacy_rx_sigdet = read_rg_use_legacy_rx_sigdet_value
    End Property

    Property Let set_rg_use_legacy_rx_sigdet(aData)
        write_rg_use_legacy_rx_sigdet_value = aData
        flag_rg_use_legacy_rx_sigdet        = &H1
    End Property

    Property Get read_rg_use_legacy_rx_sigdet
        read
        read_rg_use_legacy_rx_sigdet = read_rg_use_legacy_rx_sigdet_value
    End Property

    Property Let write_rg_use_legacy_rx_sigdet(aData)
        set_rg_use_legacy_rx_sigdet = aData
        write
    End Property

    Property Get get_rg_no_raw_sigdet
        get_rg_no_raw_sigdet = read_rg_no_raw_sigdet_value
    End Property

    Property Let set_rg_no_raw_sigdet(aData)
        write_rg_no_raw_sigdet_value = aData
        flag_rg_no_raw_sigdet        = &H1
    End Property

    Property Get read_rg_no_raw_sigdet
        read
        read_rg_no_raw_sigdet = read_rg_no_raw_sigdet_value
    End Property

    Property Let write_rg_no_raw_sigdet(aData)
        set_rg_no_raw_sigdet = aData
        write
    End Property

    Property Get get_rg_sigdet_sm_sel_gen2
        get_rg_sigdet_sm_sel_gen2 = read_rg_sigdet_sm_sel_gen2_value
    End Property

    Property Let set_rg_sigdet_sm_sel_gen2(aData)
        write_rg_sigdet_sm_sel_gen2_value = aData
        flag_rg_sigdet_sm_sel_gen2        = &H1
    End Property

    Property Get read_rg_sigdet_sm_sel_gen2
        read
        read_rg_sigdet_sm_sel_gen2 = read_rg_sigdet_sm_sel_gen2_value
    End Property

    Property Let write_rg_sigdet_sm_sel_gen2(aData)
        set_rg_sigdet_sm_sel_gen2 = aData
        write
    End Property

    Property Get get_rg_eios_detect_sel_gen2
        get_rg_eios_detect_sel_gen2 = read_rg_eios_detect_sel_gen2_value
    End Property

    Property Let set_rg_eios_detect_sel_gen2(aData)
        write_rg_eios_detect_sel_gen2_value = aData
        flag_rg_eios_detect_sel_gen2        = &H1
    End Property

    Property Get read_rg_eios_detect_sel_gen2
        read
        read_rg_eios_detect_sel_gen2 = read_rg_eios_detect_sel_gen2_value
    End Property

    Property Let write_rg_eios_detect_sel_gen2(aData)
        set_rg_eios_detect_sel_gen2 = aData
        write
    End Property

    Property Get get_rg_eieos_detect_cnt_gen2
        get_rg_eieos_detect_cnt_gen2 = read_rg_eieos_detect_cnt_gen2_value
    End Property

    Property Let set_rg_eieos_detect_cnt_gen2(aData)
        write_rg_eieos_detect_cnt_gen2_value = aData
        flag_rg_eieos_detect_cnt_gen2        = &H1
    End Property

    Property Get read_rg_eieos_detect_cnt_gen2
        read
        read_rg_eieos_detect_cnt_gen2 = read_rg_eieos_detect_cnt_gen2_value
    End Property

    Property Let write_rg_eieos_detect_cnt_gen2(aData)
        set_rg_eieos_detect_cnt_gen2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_rg_rloop_sigdet_sm_sel_value = rightShift(data_low, 15) and &H1
        read_rg_use_legacy_rx_sigdet_value = rightShift(data_low, 7) and &H1
        read_rg_no_raw_sigdet_value = rightShift(data_low, 6) and &H1
        read_rg_sigdet_sm_sel_gen2_value = rightShift(data_low, 5) and &H1
        read_rg_eios_detect_sel_gen2_value = rightShift(data_low, 4) and &H1
        rg_eieos_detect_cnt_gen2_mask = &Hf
        if data_low > LONG_MAX then
            if rg_eieos_detect_cnt_gen2_mask = mask then
                read_rg_eieos_detect_cnt_gen2_value = data_low
            else
                read_rg_eieos_detect_cnt_gen2_value = (data_low - H8000_0000) and rg_eieos_detect_cnt_gen2_mask
            end If
        else
            read_rg_eieos_detect_cnt_gen2_value = data_low and rg_eieos_detect_cnt_gen2_mask
        end If

    End Sub

    Sub write
        If flag_rg_rloop_sigdet_sm_sel = &H0 or flag_rg_use_legacy_rx_sigdet = &H0 or flag_rg_no_raw_sigdet = &H0 or flag_rg_sigdet_sm_sel_gen2 = &H0 or flag_rg_eios_detect_sel_gen2 = &H0 or flag_rg_eieos_detect_cnt_gen2 = &H0 Then read
        If flag_rg_rloop_sigdet_sm_sel = &H0 Then write_rg_rloop_sigdet_sm_sel_value = get_rg_rloop_sigdet_sm_sel
        If flag_rg_use_legacy_rx_sigdet = &H0 Then write_rg_use_legacy_rx_sigdet_value = get_rg_use_legacy_rx_sigdet
        If flag_rg_no_raw_sigdet = &H0 Then write_rg_no_raw_sigdet_value = get_rg_no_raw_sigdet
        If flag_rg_sigdet_sm_sel_gen2 = &H0 Then write_rg_sigdet_sm_sel_gen2_value = get_rg_sigdet_sm_sel_gen2
        If flag_rg_eios_detect_sel_gen2 = &H0 Then write_rg_eios_detect_sel_gen2_value = get_rg_eios_detect_sel_gen2
        If flag_rg_eieos_detect_cnt_gen2 = &H0 Then write_rg_eieos_detect_cnt_gen2_value = get_rg_eieos_detect_cnt_gen2

        regValue = leftShift((write_rg_rloop_sigdet_sm_sel_value and &H1), 15) + leftShift((write_rg_use_legacy_rx_sigdet_value and &H1), 7) + leftShift((write_rg_no_raw_sigdet_value and &H1), 6) + leftShift((write_rg_sigdet_sm_sel_gen2_value and &H1), 5) + leftShift((write_rg_eios_detect_sel_gen2_value and &H1), 4) + leftShift((write_rg_eieos_detect_cnt_gen2_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_rg_rloop_sigdet_sm_sel_value = rightShift(data_low, 15) and &H1
        read_rg_use_legacy_rx_sigdet_value = rightShift(data_low, 7) and &H1
        read_rg_no_raw_sigdet_value = rightShift(data_low, 6) and &H1
        read_rg_sigdet_sm_sel_gen2_value = rightShift(data_low, 5) and &H1
        read_rg_eios_detect_sel_gen2_value = rightShift(data_low, 4) and &H1
        rg_eieos_detect_cnt_gen2_mask = &Hf
        if data_low > LONG_MAX then
            if rg_eieos_detect_cnt_gen2_mask = mask then
                read_rg_eieos_detect_cnt_gen2_value = data_low
            else
                read_rg_eieos_detect_cnt_gen2_value = (data_low - H8000_0000) and rg_eieos_detect_cnt_gen2_mask
            end If
        else
            read_rg_eieos_detect_cnt_gen2_value = data_low and rg_eieos_detect_cnt_gen2_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_rg_rloop_sigdet_sm_sel_value = &H0
        flag_rg_rloop_sigdet_sm_sel        = &H0
        write_rg_use_legacy_rx_sigdet_value = &H0
        flag_rg_use_legacy_rx_sigdet        = &H0
        write_rg_no_raw_sigdet_value = &H0
        flag_rg_no_raw_sigdet        = &H0
        write_rg_sigdet_sm_sel_gen2_value = &H0
        flag_rg_sigdet_sm_sel_gen2        = &H0
        write_rg_eios_detect_sel_gen2_value = &H0
        flag_rg_eios_detect_sel_gen2        = &H0
        write_rg_eieos_detect_cnt_gen2_value = &H0
        flag_rg_eieos_detect_cnt_gen2        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class SIGDET_PCIE_SGMIIPCIE_X1_INSTANCE

    Public sigdet_ctrl_3
    Public sigdet_ctrl_4
    Public sigdet_ctrl_5
    Public sigdet_ctrl_6
    Public sigdet_ctrl_7
    Public sigdet_ctrl_8
    Public sigdet_stat_0
    Public sigdet_stat_1
    Public sigdet_ctrl_10
    Public sigdet_ctrl_11


    Public default function Init(aBaseAddr)
        Set sigdet_ctrl_3 = (New REGISTER_SIGDET_PCIE_SGMIIPCIE_X1_sigdet_ctrl_3)(aBaseAddr, 16)
        Set sigdet_ctrl_4 = (New REGISTER_SIGDET_PCIE_SGMIIPCIE_X1_sigdet_ctrl_4)(aBaseAddr, 16)
        Set sigdet_ctrl_5 = (New REGISTER_SIGDET_PCIE_SGMIIPCIE_X1_sigdet_ctrl_5)(aBaseAddr, 16)
        Set sigdet_ctrl_6 = (New REGISTER_SIGDET_PCIE_SGMIIPCIE_X1_sigdet_ctrl_6)(aBaseAddr, 16)
        Set sigdet_ctrl_7 = (New REGISTER_SIGDET_PCIE_SGMIIPCIE_X1_sigdet_ctrl_7)(aBaseAddr, 16)
        Set sigdet_ctrl_8 = (New REGISTER_SIGDET_PCIE_SGMIIPCIE_X1_sigdet_ctrl_8)(aBaseAddr, 16)
        Set sigdet_stat_0 = (New REGISTER_SIGDET_PCIE_SGMIIPCIE_X1_sigdet_stat_0)(aBaseAddr, 16)
        Set sigdet_stat_1 = (New REGISTER_SIGDET_PCIE_SGMIIPCIE_X1_sigdet_stat_1)(aBaseAddr, 16)
        Set sigdet_ctrl_10 = (New REGISTER_SIGDET_PCIE_SGMIIPCIE_X1_sigdet_ctrl_10)(aBaseAddr, 16)
        Set sigdet_ctrl_11 = (New REGISTER_SIGDET_PCIE_SGMIIPCIE_X1_sigdet_ctrl_11)(aBaseAddr, 16)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set SIGDET_PCIE_SGMIIPCIE_X1 = CreateObject("System.Collections.ArrayList")
SIGDET_PCIE_SGMIIPCIE_X1.Add ((New SIGDET_PCIE_SGMIIPCIE_X1_INSTANCE)(&H4adee800))


