

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


'' @REGISTER : PCIE0__SGMIIPCIE_X1_ctrl0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' sw_hw_rst                                  [15:15]          get_sw_hw_rst
''                                                             set_sw_hw_rst
''                                                             read_sw_hw_rst
''                                                             write_sw_hw_rst
''---------------------------------------------------------------------------------
'' sw_mdio_rst                                [14:14]          get_sw_mdio_rst
''                                                             set_sw_mdio_rst
''                                                             read_sw_mdio_rst
''                                                             write_sw_mdio_rst
''---------------------------------------------------------------------------------
'' tca_done_unblock                           [8:8]            get_tca_done_unblock
''                                                             set_tca_done_unblock
''                                                             read_tca_done_unblock
''                                                             write_tca_done_unblock
''---------------------------------------------------------------------------------
'' core_config_frc                            [7:7]            get_core_config_frc
''                                                             set_core_config_frc
''                                                             read_core_config_frc
''                                                             write_core_config_frc
''---------------------------------------------------------------------------------
'' core_config_frc_val                        [6:3]            get_core_config_frc_val
''                                                             set_core_config_frc_val
''                                                             read_core_config_frc_val
''                                                             write_core_config_frc_val
''---------------------------------------------------------------------------------
'' mdio_iddq_ovrd_select                      [2:2]            get_mdio_iddq_ovrd_select
''                                                             set_mdio_iddq_ovrd_select
''                                                             read_mdio_iddq_ovrd_select
''                                                             write_mdio_iddq_ovrd_select
''---------------------------------------------------------------------------------
'' mdio_iddq_ovrd_value                       [1:1]            get_mdio_iddq_ovrd_value
''                                                             set_mdio_iddq_ovrd_value
''                                                             read_mdio_iddq_ovrd_value
''                                                             write_mdio_iddq_ovrd_value
''---------------------------------------------------------------------------------
'' sw_pwrdwn                                  [0:0]            get_sw_pwrdwn
''                                                             set_sw_pwrdwn
''                                                             read_sw_pwrdwn
''                                                             write_sw_pwrdwn
''---------------------------------------------------------------------------------
Class REGISTER_PCIE0__SGMIIPCIE_X1_ctrl0
    Private write_sw_hw_rst_value
    Private read_sw_hw_rst_value
    Private flag_sw_hw_rst
    Private write_sw_mdio_rst_value
    Private read_sw_mdio_rst_value
    Private flag_sw_mdio_rst
    Private write_tca_done_unblock_value
    Private read_tca_done_unblock_value
    Private flag_tca_done_unblock
    Private write_core_config_frc_value
    Private read_core_config_frc_value
    Private flag_core_config_frc
    Private write_core_config_frc_val_value
    Private read_core_config_frc_val_value
    Private flag_core_config_frc_val
    Private write_mdio_iddq_ovrd_select_value
    Private read_mdio_iddq_ovrd_select_value
    Private flag_mdio_iddq_ovrd_select
    Private write_mdio_iddq_ovrd_value_value
    Private read_mdio_iddq_ovrd_value_value
    Private flag_mdio_iddq_ovrd_value
    Private write_sw_pwrdwn_value
    Private read_sw_pwrdwn_value
    Private flag_sw_pwrdwn

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

    Property Get get_sw_hw_rst
        get_sw_hw_rst = read_sw_hw_rst_value
    End Property

    Property Let set_sw_hw_rst(aData)
        write_sw_hw_rst_value = aData
        flag_sw_hw_rst        = &H1
    End Property

    Property Get read_sw_hw_rst
        read
        read_sw_hw_rst = read_sw_hw_rst_value
    End Property

    Property Let write_sw_hw_rst(aData)
        set_sw_hw_rst = aData
        write
    End Property

    Property Get get_sw_mdio_rst
        get_sw_mdio_rst = read_sw_mdio_rst_value
    End Property

    Property Let set_sw_mdio_rst(aData)
        write_sw_mdio_rst_value = aData
        flag_sw_mdio_rst        = &H1
    End Property

    Property Get read_sw_mdio_rst
        read
        read_sw_mdio_rst = read_sw_mdio_rst_value
    End Property

    Property Let write_sw_mdio_rst(aData)
        set_sw_mdio_rst = aData
        write
    End Property

    Property Get get_tca_done_unblock
        get_tca_done_unblock = read_tca_done_unblock_value
    End Property

    Property Let set_tca_done_unblock(aData)
        write_tca_done_unblock_value = aData
        flag_tca_done_unblock        = &H1
    End Property

    Property Get read_tca_done_unblock
        read
        read_tca_done_unblock = read_tca_done_unblock_value
    End Property

    Property Let write_tca_done_unblock(aData)
        set_tca_done_unblock = aData
        write
    End Property

    Property Get get_core_config_frc
        get_core_config_frc = read_core_config_frc_value
    End Property

    Property Let set_core_config_frc(aData)
        write_core_config_frc_value = aData
        flag_core_config_frc        = &H1
    End Property

    Property Get read_core_config_frc
        read
        read_core_config_frc = read_core_config_frc_value
    End Property

    Property Let write_core_config_frc(aData)
        set_core_config_frc = aData
        write
    End Property

    Property Get get_core_config_frc_val
        get_core_config_frc_val = read_core_config_frc_val_value
    End Property

    Property Let set_core_config_frc_val(aData)
        write_core_config_frc_val_value = aData
        flag_core_config_frc_val        = &H1
    End Property

    Property Get read_core_config_frc_val
        read
        read_core_config_frc_val = read_core_config_frc_val_value
    End Property

    Property Let write_core_config_frc_val(aData)
        set_core_config_frc_val = aData
        write
    End Property

    Property Get get_mdio_iddq_ovrd_select
        get_mdio_iddq_ovrd_select = read_mdio_iddq_ovrd_select_value
    End Property

    Property Let set_mdio_iddq_ovrd_select(aData)
        write_mdio_iddq_ovrd_select_value = aData
        flag_mdio_iddq_ovrd_select        = &H1
    End Property

    Property Get read_mdio_iddq_ovrd_select
        read
        read_mdio_iddq_ovrd_select = read_mdio_iddq_ovrd_select_value
    End Property

    Property Let write_mdio_iddq_ovrd_select(aData)
        set_mdio_iddq_ovrd_select = aData
        write
    End Property

    Property Get get_mdio_iddq_ovrd_value
        get_mdio_iddq_ovrd_value = read_mdio_iddq_ovrd_value_value
    End Property

    Property Let set_mdio_iddq_ovrd_value(aData)
        write_mdio_iddq_ovrd_value_value = aData
        flag_mdio_iddq_ovrd_value        = &H1
    End Property

    Property Get read_mdio_iddq_ovrd_value
        read
        read_mdio_iddq_ovrd_value = read_mdio_iddq_ovrd_value_value
    End Property

    Property Let write_mdio_iddq_ovrd_value(aData)
        set_mdio_iddq_ovrd_value = aData
        write
    End Property

    Property Get get_sw_pwrdwn
        get_sw_pwrdwn = read_sw_pwrdwn_value
    End Property

    Property Let set_sw_pwrdwn(aData)
        write_sw_pwrdwn_value = aData
        flag_sw_pwrdwn        = &H1
    End Property

    Property Get read_sw_pwrdwn
        read
        read_sw_pwrdwn = read_sw_pwrdwn_value
    End Property

    Property Let write_sw_pwrdwn(aData)
        set_sw_pwrdwn = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_sw_hw_rst_value = rightShift(data_low, 15) and &H1
        read_sw_mdio_rst_value = rightShift(data_low, 14) and &H1
        read_tca_done_unblock_value = rightShift(data_low, 8) and &H1
        read_core_config_frc_value = rightShift(data_low, 7) and &H1
        read_core_config_frc_val_value = rightShift(data_low, 3) and &Hf
        read_mdio_iddq_ovrd_select_value = rightShift(data_low, 2) and &H1
        read_mdio_iddq_ovrd_value_value = rightShift(data_low, 1) and &H1
        sw_pwrdwn_mask = &H1
        if data_low > LONG_MAX then
            if sw_pwrdwn_mask = mask then
                read_sw_pwrdwn_value = data_low
            else
                read_sw_pwrdwn_value = (data_low - H8000_0000) and sw_pwrdwn_mask
            end If
        else
            read_sw_pwrdwn_value = data_low and sw_pwrdwn_mask
        end If

    End Sub

    Sub write
        If flag_sw_hw_rst = &H0 or flag_sw_mdio_rst = &H0 or flag_tca_done_unblock = &H0 or flag_core_config_frc = &H0 or flag_core_config_frc_val = &H0 or flag_mdio_iddq_ovrd_select = &H0 or flag_mdio_iddq_ovrd_value = &H0 or flag_sw_pwrdwn = &H0 Then read
        If flag_sw_hw_rst = &H0 Then write_sw_hw_rst_value = get_sw_hw_rst
        If flag_sw_mdio_rst = &H0 Then write_sw_mdio_rst_value = get_sw_mdio_rst
        If flag_tca_done_unblock = &H0 Then write_tca_done_unblock_value = get_tca_done_unblock
        If flag_core_config_frc = &H0 Then write_core_config_frc_value = get_core_config_frc
        If flag_core_config_frc_val = &H0 Then write_core_config_frc_val_value = get_core_config_frc_val
        If flag_mdio_iddq_ovrd_select = &H0 Then write_mdio_iddq_ovrd_select_value = get_mdio_iddq_ovrd_select
        If flag_mdio_iddq_ovrd_value = &H0 Then write_mdio_iddq_ovrd_value_value = get_mdio_iddq_ovrd_value
        If flag_sw_pwrdwn = &H0 Then write_sw_pwrdwn_value = get_sw_pwrdwn

        regValue = leftShift((write_sw_hw_rst_value and &H1), 15) + leftShift((write_sw_mdio_rst_value and &H1), 14) + leftShift((write_tca_done_unblock_value and &H1), 8) + leftShift((write_core_config_frc_value and &H1), 7) + leftShift((write_core_config_frc_val_value and &Hf), 3) + leftShift((write_mdio_iddq_ovrd_select_value and &H1), 2) + leftShift((write_mdio_iddq_ovrd_value_value and &H1), 1) + leftShift((write_sw_pwrdwn_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_sw_hw_rst_value = rightShift(data_low, 15) and &H1
        read_sw_mdio_rst_value = rightShift(data_low, 14) and &H1
        read_tca_done_unblock_value = rightShift(data_low, 8) and &H1
        read_core_config_frc_value = rightShift(data_low, 7) and &H1
        read_core_config_frc_val_value = rightShift(data_low, 3) and &Hf
        read_mdio_iddq_ovrd_select_value = rightShift(data_low, 2) and &H1
        read_mdio_iddq_ovrd_value_value = rightShift(data_low, 1) and &H1
        sw_pwrdwn_mask = &H1
        if data_low > LONG_MAX then
            if sw_pwrdwn_mask = mask then
                read_sw_pwrdwn_value = data_low
            else
                read_sw_pwrdwn_value = (data_low - H8000_0000) and sw_pwrdwn_mask
            end If
        else
            read_sw_pwrdwn_value = data_low and sw_pwrdwn_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_sw_hw_rst_value = &H0
        flag_sw_hw_rst        = &H0
        write_sw_mdio_rst_value = &H0
        flag_sw_mdio_rst        = &H0
        write_tca_done_unblock_value = &H0
        flag_tca_done_unblock        = &H0
        write_core_config_frc_value = &H0
        flag_core_config_frc        = &H0
        write_core_config_frc_val_value = &H0
        flag_core_config_frc_val        = &H0
        write_mdio_iddq_ovrd_select_value = &H0
        flag_mdio_iddq_ovrd_select        = &H0
        write_mdio_iddq_ovrd_value_value = &H0
        flag_mdio_iddq_ovrd_value        = &H0
        write_sw_pwrdwn_value = &H0
        flag_sw_pwrdwn        = &H0
    End Sub
End Class


'' @REGISTER : PCIE0__SGMIIPCIE_X1_ctrl1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mdio_res_cal_val                           [3:0]            get_mdio_res_cal_val
''                                                             set_mdio_res_cal_val
''                                                             read_mdio_res_cal_val
''                                                             write_mdio_res_cal_val
''---------------------------------------------------------------------------------
'' mdio_res_cal_sel                           [4:4]            get_mdio_res_cal_sel
''                                                             set_mdio_res_cal_sel
''                                                             read_mdio_res_cal_sel
''                                                             write_mdio_res_cal_sel
''---------------------------------------------------------------------------------
'' mdio_PllTuningBypSel                       [5:5]            get_mdio_PllTuningBypSel
''                                                             set_mdio_PllTuningBypSel
''                                                             read_mdio_PllTuningBypSel
''                                                             write_mdio_PllTuningBypSel
''---------------------------------------------------------------------------------
'' mdio_PllTuningBypVal                       [6:6]            get_mdio_PllTuningBypVal
''                                                             set_mdio_PllTuningBypVal
''                                                             read_mdio_PllTuningBypVal
''                                                             write_mdio_PllTuningBypVal
''---------------------------------------------------------------------------------
'' mdio_PllTuningSel                          [7:7]            get_mdio_PllTuningSel
''                                                             set_mdio_PllTuningSel
''                                                             read_mdio_PllTuningSel
''                                                             write_mdio_PllTuningSel
''---------------------------------------------------------------------------------
'' mdio_PllTuningEnable                       [8:8]            get_mdio_PllTuningEnable
''                                                             set_mdio_PllTuningEnable
''                                                             read_mdio_PllTuningEnable
''                                                             write_mdio_PllTuningEnable
''---------------------------------------------------------------------------------
'' refclk_sense_req_force_val                 [9:9]            get_refclk_sense_req_force_val
''                                                             set_refclk_sense_req_force_val
''                                                             read_refclk_sense_req_force_val
''                                                             write_refclk_sense_req_force_val
''---------------------------------------------------------------------------------
'' refclk_sense_req_force                     [10:10]          get_refclk_sense_req_force
''                                                             set_refclk_sense_req_force
''                                                             read_refclk_sense_req_force
''                                                             write_refclk_sense_req_force
''---------------------------------------------------------------------------------
'' mdio_RC_refclk_sel                         [12:12]          get_mdio_RC_refclk_sel
''                                                             set_mdio_RC_refclk_sel
''                                                             read_mdio_RC_refclk_sel
''                                                             write_mdio_RC_refclk_sel
''---------------------------------------------------------------------------------
'' mdio_RC_refclk_val                         [13:13]          get_mdio_RC_refclk_val
''                                                             set_mdio_RC_refclk_val
''                                                             read_mdio_RC_refclk_val
''                                                             write_mdio_RC_refclk_val
''---------------------------------------------------------------------------------
'' mdio_RxSlicerCalBypass                     [14:14]          get_mdio_RxSlicerCalBypass
''                                                             set_mdio_RxSlicerCalBypass
''                                                             read_mdio_RxSlicerCalBypass
''                                                             write_mdio_RxSlicerCalBypass
''---------------------------------------------------------------------------------
'' mdio_RxLimitAmpCal                         [15:15]          get_mdio_RxLimitAmpCal
''                                                             set_mdio_RxLimitAmpCal
''                                                             read_mdio_RxLimitAmpCal
''                                                             write_mdio_RxLimitAmpCal
''---------------------------------------------------------------------------------
Class REGISTER_PCIE0__SGMIIPCIE_X1_ctrl1
    Private write_mdio_res_cal_val_value
    Private read_mdio_res_cal_val_value
    Private flag_mdio_res_cal_val
    Private write_mdio_res_cal_sel_value
    Private read_mdio_res_cal_sel_value
    Private flag_mdio_res_cal_sel
    Private write_mdio_PllTuningBypSel_value
    Private read_mdio_PllTuningBypSel_value
    Private flag_mdio_PllTuningBypSel
    Private write_mdio_PllTuningBypVal_value
    Private read_mdio_PllTuningBypVal_value
    Private flag_mdio_PllTuningBypVal
    Private write_mdio_PllTuningSel_value
    Private read_mdio_PllTuningSel_value
    Private flag_mdio_PllTuningSel
    Private write_mdio_PllTuningEnable_value
    Private read_mdio_PllTuningEnable_value
    Private flag_mdio_PllTuningEnable
    Private write_refclk_sense_req_force_val_value
    Private read_refclk_sense_req_force_val_value
    Private flag_refclk_sense_req_force_val
    Private write_refclk_sense_req_force_value
    Private read_refclk_sense_req_force_value
    Private flag_refclk_sense_req_force
    Private write_mdio_RC_refclk_sel_value
    Private read_mdio_RC_refclk_sel_value
    Private flag_mdio_RC_refclk_sel
    Private write_mdio_RC_refclk_val_value
    Private read_mdio_RC_refclk_val_value
    Private flag_mdio_RC_refclk_val
    Private write_mdio_RxSlicerCalBypass_value
    Private read_mdio_RxSlicerCalBypass_value
    Private flag_mdio_RxSlicerCalBypass
    Private write_mdio_RxLimitAmpCal_value
    Private read_mdio_RxLimitAmpCal_value
    Private flag_mdio_RxLimitAmpCal

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

    Property Get get_mdio_res_cal_val
        get_mdio_res_cal_val = read_mdio_res_cal_val_value
    End Property

    Property Let set_mdio_res_cal_val(aData)
        write_mdio_res_cal_val_value = aData
        flag_mdio_res_cal_val        = &H1
    End Property

    Property Get read_mdio_res_cal_val
        read
        read_mdio_res_cal_val = read_mdio_res_cal_val_value
    End Property

    Property Let write_mdio_res_cal_val(aData)
        set_mdio_res_cal_val = aData
        write
    End Property

    Property Get get_mdio_res_cal_sel
        get_mdio_res_cal_sel = read_mdio_res_cal_sel_value
    End Property

    Property Let set_mdio_res_cal_sel(aData)
        write_mdio_res_cal_sel_value = aData
        flag_mdio_res_cal_sel        = &H1
    End Property

    Property Get read_mdio_res_cal_sel
        read
        read_mdio_res_cal_sel = read_mdio_res_cal_sel_value
    End Property

    Property Let write_mdio_res_cal_sel(aData)
        set_mdio_res_cal_sel = aData
        write
    End Property

    Property Get get_mdio_PllTuningBypSel
        get_mdio_PllTuningBypSel = read_mdio_PllTuningBypSel_value
    End Property

    Property Let set_mdio_PllTuningBypSel(aData)
        write_mdio_PllTuningBypSel_value = aData
        flag_mdio_PllTuningBypSel        = &H1
    End Property

    Property Get read_mdio_PllTuningBypSel
        read
        read_mdio_PllTuningBypSel = read_mdio_PllTuningBypSel_value
    End Property

    Property Let write_mdio_PllTuningBypSel(aData)
        set_mdio_PllTuningBypSel = aData
        write
    End Property

    Property Get get_mdio_PllTuningBypVal
        get_mdio_PllTuningBypVal = read_mdio_PllTuningBypVal_value
    End Property

    Property Let set_mdio_PllTuningBypVal(aData)
        write_mdio_PllTuningBypVal_value = aData
        flag_mdio_PllTuningBypVal        = &H1
    End Property

    Property Get read_mdio_PllTuningBypVal
        read
        read_mdio_PllTuningBypVal = read_mdio_PllTuningBypVal_value
    End Property

    Property Let write_mdio_PllTuningBypVal(aData)
        set_mdio_PllTuningBypVal = aData
        write
    End Property

    Property Get get_mdio_PllTuningSel
        get_mdio_PllTuningSel = read_mdio_PllTuningSel_value
    End Property

    Property Let set_mdio_PllTuningSel(aData)
        write_mdio_PllTuningSel_value = aData
        flag_mdio_PllTuningSel        = &H1
    End Property

    Property Get read_mdio_PllTuningSel
        read
        read_mdio_PllTuningSel = read_mdio_PllTuningSel_value
    End Property

    Property Let write_mdio_PllTuningSel(aData)
        set_mdio_PllTuningSel = aData
        write
    End Property

    Property Get get_mdio_PllTuningEnable
        get_mdio_PllTuningEnable = read_mdio_PllTuningEnable_value
    End Property

    Property Let set_mdio_PllTuningEnable(aData)
        write_mdio_PllTuningEnable_value = aData
        flag_mdio_PllTuningEnable        = &H1
    End Property

    Property Get read_mdio_PllTuningEnable
        read
        read_mdio_PllTuningEnable = read_mdio_PllTuningEnable_value
    End Property

    Property Let write_mdio_PllTuningEnable(aData)
        set_mdio_PllTuningEnable = aData
        write
    End Property

    Property Get get_refclk_sense_req_force_val
        get_refclk_sense_req_force_val = read_refclk_sense_req_force_val_value
    End Property

    Property Let set_refclk_sense_req_force_val(aData)
        write_refclk_sense_req_force_val_value = aData
        flag_refclk_sense_req_force_val        = &H1
    End Property

    Property Get read_refclk_sense_req_force_val
        read
        read_refclk_sense_req_force_val = read_refclk_sense_req_force_val_value
    End Property

    Property Let write_refclk_sense_req_force_val(aData)
        set_refclk_sense_req_force_val = aData
        write
    End Property

    Property Get get_refclk_sense_req_force
        get_refclk_sense_req_force = read_refclk_sense_req_force_value
    End Property

    Property Let set_refclk_sense_req_force(aData)
        write_refclk_sense_req_force_value = aData
        flag_refclk_sense_req_force        = &H1
    End Property

    Property Get read_refclk_sense_req_force
        read
        read_refclk_sense_req_force = read_refclk_sense_req_force_value
    End Property

    Property Let write_refclk_sense_req_force(aData)
        set_refclk_sense_req_force = aData
        write
    End Property

    Property Get get_mdio_RC_refclk_sel
        get_mdio_RC_refclk_sel = read_mdio_RC_refclk_sel_value
    End Property

    Property Let set_mdio_RC_refclk_sel(aData)
        write_mdio_RC_refclk_sel_value = aData
        flag_mdio_RC_refclk_sel        = &H1
    End Property

    Property Get read_mdio_RC_refclk_sel
        read
        read_mdio_RC_refclk_sel = read_mdio_RC_refclk_sel_value
    End Property

    Property Let write_mdio_RC_refclk_sel(aData)
        set_mdio_RC_refclk_sel = aData
        write
    End Property

    Property Get get_mdio_RC_refclk_val
        get_mdio_RC_refclk_val = read_mdio_RC_refclk_val_value
    End Property

    Property Let set_mdio_RC_refclk_val(aData)
        write_mdio_RC_refclk_val_value = aData
        flag_mdio_RC_refclk_val        = &H1
    End Property

    Property Get read_mdio_RC_refclk_val
        read
        read_mdio_RC_refclk_val = read_mdio_RC_refclk_val_value
    End Property

    Property Let write_mdio_RC_refclk_val(aData)
        set_mdio_RC_refclk_val = aData
        write
    End Property

    Property Get get_mdio_RxSlicerCalBypass
        get_mdio_RxSlicerCalBypass = read_mdio_RxSlicerCalBypass_value
    End Property

    Property Let set_mdio_RxSlicerCalBypass(aData)
        write_mdio_RxSlicerCalBypass_value = aData
        flag_mdio_RxSlicerCalBypass        = &H1
    End Property

    Property Get read_mdio_RxSlicerCalBypass
        read
        read_mdio_RxSlicerCalBypass = read_mdio_RxSlicerCalBypass_value
    End Property

    Property Let write_mdio_RxSlicerCalBypass(aData)
        set_mdio_RxSlicerCalBypass = aData
        write
    End Property

    Property Get get_mdio_RxLimitAmpCal
        get_mdio_RxLimitAmpCal = read_mdio_RxLimitAmpCal_value
    End Property

    Property Let set_mdio_RxLimitAmpCal(aData)
        write_mdio_RxLimitAmpCal_value = aData
        flag_mdio_RxLimitAmpCal        = &H1
    End Property

    Property Get read_mdio_RxLimitAmpCal
        read
        read_mdio_RxLimitAmpCal = read_mdio_RxLimitAmpCal_value
    End Property

    Property Let write_mdio_RxLimitAmpCal(aData)
        set_mdio_RxLimitAmpCal = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mdio_res_cal_val_mask = &Hf
        if data_low > LONG_MAX then
            if mdio_res_cal_val_mask = mask then
                read_mdio_res_cal_val_value = data_low
            else
                read_mdio_res_cal_val_value = (data_low - H8000_0000) and mdio_res_cal_val_mask
            end If
        else
            read_mdio_res_cal_val_value = data_low and mdio_res_cal_val_mask
        end If
        read_mdio_res_cal_sel_value = rightShift(data_low, 4) and &H1
        read_mdio_PllTuningBypSel_value = rightShift(data_low, 5) and &H1
        read_mdio_PllTuningBypVal_value = rightShift(data_low, 6) and &H1
        read_mdio_PllTuningSel_value = rightShift(data_low, 7) and &H1
        read_mdio_PllTuningEnable_value = rightShift(data_low, 8) and &H1
        read_refclk_sense_req_force_val_value = rightShift(data_low, 9) and &H1
        read_refclk_sense_req_force_value = rightShift(data_low, 10) and &H1
        read_mdio_RC_refclk_sel_value = rightShift(data_low, 12) and &H1
        read_mdio_RC_refclk_val_value = rightShift(data_low, 13) and &H1
        read_mdio_RxSlicerCalBypass_value = rightShift(data_low, 14) and &H1
        read_mdio_RxLimitAmpCal_value = rightShift(data_low, 15) and &H1

    End Sub

    Sub write
        If flag_mdio_res_cal_val = &H0 or flag_mdio_res_cal_sel = &H0 or flag_mdio_PllTuningBypSel = &H0 or flag_mdio_PllTuningBypVal = &H0 or flag_mdio_PllTuningSel = &H0 or flag_mdio_PllTuningEnable = &H0 or flag_refclk_sense_req_force_val = &H0 or flag_refclk_sense_req_force = &H0 or flag_mdio_RC_refclk_sel = &H0 or flag_mdio_RC_refclk_val = &H0 or flag_mdio_RxSlicerCalBypass = &H0 or flag_mdio_RxLimitAmpCal = &H0 Then read
        If flag_mdio_res_cal_val = &H0 Then write_mdio_res_cal_val_value = get_mdio_res_cal_val
        If flag_mdio_res_cal_sel = &H0 Then write_mdio_res_cal_sel_value = get_mdio_res_cal_sel
        If flag_mdio_PllTuningBypSel = &H0 Then write_mdio_PllTuningBypSel_value = get_mdio_PllTuningBypSel
        If flag_mdio_PllTuningBypVal = &H0 Then write_mdio_PllTuningBypVal_value = get_mdio_PllTuningBypVal
        If flag_mdio_PllTuningSel = &H0 Then write_mdio_PllTuningSel_value = get_mdio_PllTuningSel
        If flag_mdio_PllTuningEnable = &H0 Then write_mdio_PllTuningEnable_value = get_mdio_PllTuningEnable
        If flag_refclk_sense_req_force_val = &H0 Then write_refclk_sense_req_force_val_value = get_refclk_sense_req_force_val
        If flag_refclk_sense_req_force = &H0 Then write_refclk_sense_req_force_value = get_refclk_sense_req_force
        If flag_mdio_RC_refclk_sel = &H0 Then write_mdio_RC_refclk_sel_value = get_mdio_RC_refclk_sel
        If flag_mdio_RC_refclk_val = &H0 Then write_mdio_RC_refclk_val_value = get_mdio_RC_refclk_val
        If flag_mdio_RxSlicerCalBypass = &H0 Then write_mdio_RxSlicerCalBypass_value = get_mdio_RxSlicerCalBypass
        If flag_mdio_RxLimitAmpCal = &H0 Then write_mdio_RxLimitAmpCal_value = get_mdio_RxLimitAmpCal

        regValue = leftShift((write_mdio_res_cal_val_value and &Hf), 0) + leftShift((write_mdio_res_cal_sel_value and &H1), 4) + leftShift((write_mdio_PllTuningBypSel_value and &H1), 5) + leftShift((write_mdio_PllTuningBypVal_value and &H1), 6) + leftShift((write_mdio_PllTuningSel_value and &H1), 7) + leftShift((write_mdio_PllTuningEnable_value and &H1), 8) + leftShift((write_refclk_sense_req_force_val_value and &H1), 9) + leftShift((write_refclk_sense_req_force_value and &H1), 10) + leftShift((write_mdio_RC_refclk_sel_value and &H1), 12) + leftShift((write_mdio_RC_refclk_val_value and &H1), 13) + leftShift((write_mdio_RxSlicerCalBypass_value and &H1), 14) + leftShift((write_mdio_RxLimitAmpCal_value and &H1), 15)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mdio_res_cal_val_mask = &Hf
        if data_low > LONG_MAX then
            if mdio_res_cal_val_mask = mask then
                read_mdio_res_cal_val_value = data_low
            else
                read_mdio_res_cal_val_value = (data_low - H8000_0000) and mdio_res_cal_val_mask
            end If
        else
            read_mdio_res_cal_val_value = data_low and mdio_res_cal_val_mask
        end If
        read_mdio_res_cal_sel_value = rightShift(data_low, 4) and &H1
        read_mdio_PllTuningBypSel_value = rightShift(data_low, 5) and &H1
        read_mdio_PllTuningBypVal_value = rightShift(data_low, 6) and &H1
        read_mdio_PllTuningSel_value = rightShift(data_low, 7) and &H1
        read_mdio_PllTuningEnable_value = rightShift(data_low, 8) and &H1
        read_refclk_sense_req_force_val_value = rightShift(data_low, 9) and &H1
        read_refclk_sense_req_force_value = rightShift(data_low, 10) and &H1
        read_mdio_RC_refclk_sel_value = rightShift(data_low, 12) and &H1
        read_mdio_RC_refclk_val_value = rightShift(data_low, 13) and &H1
        read_mdio_RxSlicerCalBypass_value = rightShift(data_low, 14) and &H1
        read_mdio_RxLimitAmpCal_value = rightShift(data_low, 15) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mdio_res_cal_val_value = &H0
        flag_mdio_res_cal_val        = &H0
        write_mdio_res_cal_sel_value = &H0
        flag_mdio_res_cal_sel        = &H0
        write_mdio_PllTuningBypSel_value = &H0
        flag_mdio_PllTuningBypSel        = &H0
        write_mdio_PllTuningBypVal_value = &H0
        flag_mdio_PllTuningBypVal        = &H0
        write_mdio_PllTuningSel_value = &H0
        flag_mdio_PllTuningSel        = &H0
        write_mdio_PllTuningEnable_value = &H0
        flag_mdio_PllTuningEnable        = &H0
        write_refclk_sense_req_force_val_value = &H0
        flag_refclk_sense_req_force_val        = &H0
        write_refclk_sense_req_force_value = &H0
        flag_refclk_sense_req_force        = &H0
        write_mdio_RC_refclk_sel_value = &H0
        flag_mdio_RC_refclk_sel        = &H0
        write_mdio_RC_refclk_val_value = &H0
        flag_mdio_RC_refclk_val        = &H0
        write_mdio_RxSlicerCalBypass_value = &H0
        flag_mdio_RxSlicerCalBypass        = &H0
        write_mdio_RxLimitAmpCal_value = &H0
        flag_mdio_RxLimitAmpCal        = &H0
    End Sub
End Class


'' @REGISTER : PCIE0__SGMIIPCIE_X1_ctrl2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mdio_tmr_start_cal                         [15:8]           get_mdio_tmr_start_cal
''                                                             set_mdio_tmr_start_cal
''                                                             read_mdio_tmr_start_cal
''                                                             write_mdio_tmr_start_cal
''---------------------------------------------------------------------------------
'' pcie0status_lane_sel                       [7:4]            get_pcie0status_lane_sel
''                                                             set_pcie0status_lane_sel
''                                                             read_pcie0status_lane_sel
''                                                             write_pcie0status_lane_sel
''---------------------------------------------------------------------------------
'' mdio_RefSelBypSel                          [3:3]            get_mdio_RefSelBypSel
''                                                             set_mdio_RefSelBypSel
''                                                             read_mdio_RefSelBypSel
''                                                             write_mdio_RefSelBypSel
''---------------------------------------------------------------------------------
'' mdio_RefSelVal                             [2:0]            get_mdio_RefSelVal
''                                                             set_mdio_RefSelVal
''                                                             read_mdio_RefSelVal
''                                                             write_mdio_RefSelVal
''---------------------------------------------------------------------------------
Class REGISTER_PCIE0__SGMIIPCIE_X1_ctrl2
    Private write_mdio_tmr_start_cal_value
    Private read_mdio_tmr_start_cal_value
    Private flag_mdio_tmr_start_cal
    Private write_pcie0status_lane_sel_value
    Private read_pcie0status_lane_sel_value
    Private flag_pcie0status_lane_sel
    Private write_mdio_RefSelBypSel_value
    Private read_mdio_RefSelBypSel_value
    Private flag_mdio_RefSelBypSel
    Private write_mdio_RefSelVal_value
    Private read_mdio_RefSelVal_value
    Private flag_mdio_RefSelVal

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

    Property Get get_mdio_tmr_start_cal
        get_mdio_tmr_start_cal = read_mdio_tmr_start_cal_value
    End Property

    Property Let set_mdio_tmr_start_cal(aData)
        write_mdio_tmr_start_cal_value = aData
        flag_mdio_tmr_start_cal        = &H1
    End Property

    Property Get read_mdio_tmr_start_cal
        read
        read_mdio_tmr_start_cal = read_mdio_tmr_start_cal_value
    End Property

    Property Let write_mdio_tmr_start_cal(aData)
        set_mdio_tmr_start_cal = aData
        write
    End Property

    Property Get get_pcie0status_lane_sel
        get_pcie0status_lane_sel = read_pcie0status_lane_sel_value
    End Property

    Property Let set_pcie0status_lane_sel(aData)
        write_pcie0status_lane_sel_value = aData
        flag_pcie0status_lane_sel        = &H1
    End Property

    Property Get read_pcie0status_lane_sel
        read
        read_pcie0status_lane_sel = read_pcie0status_lane_sel_value
    End Property

    Property Let write_pcie0status_lane_sel(aData)
        set_pcie0status_lane_sel = aData
        write
    End Property

    Property Get get_mdio_RefSelBypSel
        get_mdio_RefSelBypSel = read_mdio_RefSelBypSel_value
    End Property

    Property Let set_mdio_RefSelBypSel(aData)
        write_mdio_RefSelBypSel_value = aData
        flag_mdio_RefSelBypSel        = &H1
    End Property

    Property Get read_mdio_RefSelBypSel
        read
        read_mdio_RefSelBypSel = read_mdio_RefSelBypSel_value
    End Property

    Property Let write_mdio_RefSelBypSel(aData)
        set_mdio_RefSelBypSel = aData
        write
    End Property

    Property Get get_mdio_RefSelVal
        get_mdio_RefSelVal = read_mdio_RefSelVal_value
    End Property

    Property Let set_mdio_RefSelVal(aData)
        write_mdio_RefSelVal_value = aData
        flag_mdio_RefSelVal        = &H1
    End Property

    Property Get read_mdio_RefSelVal
        read
        read_mdio_RefSelVal = read_mdio_RefSelVal_value
    End Property

    Property Let write_mdio_RefSelVal(aData)
        set_mdio_RefSelVal = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_mdio_tmr_start_cal_value = rightShift(data_low, 8) and &Hff
        read_pcie0status_lane_sel_value = rightShift(data_low, 4) and &Hf
        read_mdio_RefSelBypSel_value = rightShift(data_low, 3) and &H1
        mdio_RefSelVal_mask = &H7
        if data_low > LONG_MAX then
            if mdio_RefSelVal_mask = mask then
                read_mdio_RefSelVal_value = data_low
            else
                read_mdio_RefSelVal_value = (data_low - H8000_0000) and mdio_RefSelVal_mask
            end If
        else
            read_mdio_RefSelVal_value = data_low and mdio_RefSelVal_mask
        end If

    End Sub

    Sub write
        If flag_mdio_tmr_start_cal = &H0 or flag_pcie0status_lane_sel = &H0 or flag_mdio_RefSelBypSel = &H0 or flag_mdio_RefSelVal = &H0 Then read
        If flag_mdio_tmr_start_cal = &H0 Then write_mdio_tmr_start_cal_value = get_mdio_tmr_start_cal
        If flag_pcie0status_lane_sel = &H0 Then write_pcie0status_lane_sel_value = get_pcie0status_lane_sel
        If flag_mdio_RefSelBypSel = &H0 Then write_mdio_RefSelBypSel_value = get_mdio_RefSelBypSel
        If flag_mdio_RefSelVal = &H0 Then write_mdio_RefSelVal_value = get_mdio_RefSelVal

        regValue = leftShift((write_mdio_tmr_start_cal_value and &Hff), 8) + leftShift((write_pcie0status_lane_sel_value and &Hf), 4) + leftShift((write_mdio_RefSelBypSel_value and &H1), 3) + leftShift((write_mdio_RefSelVal_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_mdio_tmr_start_cal_value = rightShift(data_low, 8) and &Hff
        read_pcie0status_lane_sel_value = rightShift(data_low, 4) and &Hf
        read_mdio_RefSelBypSel_value = rightShift(data_low, 3) and &H1
        mdio_RefSelVal_mask = &H7
        if data_low > LONG_MAX then
            if mdio_RefSelVal_mask = mask then
                read_mdio_RefSelVal_value = data_low
            else
                read_mdio_RefSelVal_value = (data_low - H8000_0000) and mdio_RefSelVal_mask
            end If
        else
            read_mdio_RefSelVal_value = data_low and mdio_RefSelVal_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mdio_tmr_start_cal_value = &H0
        flag_mdio_tmr_start_cal        = &H0
        write_pcie0status_lane_sel_value = &H0
        flag_pcie0status_lane_sel        = &H0
        write_mdio_RefSelBypSel_value = &H0
        flag_mdio_RefSelBypSel        = &H0
        write_mdio_RefSelVal_value = &H0
        flag_mdio_RefSelVal        = &H0
    End Sub
End Class


'' @REGISTER : PCIE0__SGMIIPCIE_X1_ctrl3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mdio_tmr_rx_seqstart                       [15:8]           get_mdio_tmr_rx_seqstart
''                                                             set_mdio_tmr_rx_seqstart
''                                                             read_mdio_tmr_rx_seqstart
''                                                             write_mdio_tmr_rx_seqstart
''---------------------------------------------------------------------------------
'' mdio_tmr_pcal                              [7:0]            get_mdio_tmr_pcal
''                                                             set_mdio_tmr_pcal
''                                                             read_mdio_tmr_pcal
''                                                             write_mdio_tmr_pcal
''---------------------------------------------------------------------------------
Class REGISTER_PCIE0__SGMIIPCIE_X1_ctrl3
    Private write_mdio_tmr_rx_seqstart_value
    Private read_mdio_tmr_rx_seqstart_value
    Private flag_mdio_tmr_rx_seqstart
    Private write_mdio_tmr_pcal_value
    Private read_mdio_tmr_pcal_value
    Private flag_mdio_tmr_pcal

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

    Property Get get_mdio_tmr_rx_seqstart
        get_mdio_tmr_rx_seqstart = read_mdio_tmr_rx_seqstart_value
    End Property

    Property Let set_mdio_tmr_rx_seqstart(aData)
        write_mdio_tmr_rx_seqstart_value = aData
        flag_mdio_tmr_rx_seqstart        = &H1
    End Property

    Property Get read_mdio_tmr_rx_seqstart
        read
        read_mdio_tmr_rx_seqstart = read_mdio_tmr_rx_seqstart_value
    End Property

    Property Let write_mdio_tmr_rx_seqstart(aData)
        set_mdio_tmr_rx_seqstart = aData
        write
    End Property

    Property Get get_mdio_tmr_pcal
        get_mdio_tmr_pcal = read_mdio_tmr_pcal_value
    End Property

    Property Let set_mdio_tmr_pcal(aData)
        write_mdio_tmr_pcal_value = aData
        flag_mdio_tmr_pcal        = &H1
    End Property

    Property Get read_mdio_tmr_pcal
        read
        read_mdio_tmr_pcal = read_mdio_tmr_pcal_value
    End Property

    Property Let write_mdio_tmr_pcal(aData)
        set_mdio_tmr_pcal = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_mdio_tmr_rx_seqstart_value = rightShift(data_low, 8) and &Hff
        mdio_tmr_pcal_mask = &Hff
        if data_low > LONG_MAX then
            if mdio_tmr_pcal_mask = mask then
                read_mdio_tmr_pcal_value = data_low
            else
                read_mdio_tmr_pcal_value = (data_low - H8000_0000) and mdio_tmr_pcal_mask
            end If
        else
            read_mdio_tmr_pcal_value = data_low and mdio_tmr_pcal_mask
        end If

    End Sub

    Sub write
        If flag_mdio_tmr_rx_seqstart = &H0 or flag_mdio_tmr_pcal = &H0 Then read
        If flag_mdio_tmr_rx_seqstart = &H0 Then write_mdio_tmr_rx_seqstart_value = get_mdio_tmr_rx_seqstart
        If flag_mdio_tmr_pcal = &H0 Then write_mdio_tmr_pcal_value = get_mdio_tmr_pcal

        regValue = leftShift((write_mdio_tmr_rx_seqstart_value and &Hff), 8) + leftShift((write_mdio_tmr_pcal_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_mdio_tmr_rx_seqstart_value = rightShift(data_low, 8) and &Hff
        mdio_tmr_pcal_mask = &Hff
        if data_low > LONG_MAX then
            if mdio_tmr_pcal_mask = mask then
                read_mdio_tmr_pcal_value = data_low
            else
                read_mdio_tmr_pcal_value = (data_low - H8000_0000) and mdio_tmr_pcal_mask
            end If
        else
            read_mdio_tmr_pcal_value = data_low and mdio_tmr_pcal_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mdio_tmr_rx_seqstart_value = &H0
        flag_mdio_tmr_rx_seqstart        = &H0
        write_mdio_tmr_pcal_value = &H0
        flag_mdio_tmr_pcal        = &H0
    End Sub
End Class


'' @REGISTER : PCIE0__SGMIIPCIE_X1_status0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' rx_sigdet_filt                             [15:15]          get_rx_sigdet_filt
''                                                             set_rx_sigdet_filt
''                                                             read_rx_sigdet_filt
''                                                             write_rx_sigdet_filt
''---------------------------------------------------------------------------------
'' rx_sigdet                                  [14:14]          get_rx_sigdet
''                                                             set_rx_sigdet
''                                                             read_rx_sigdet
''                                                             write_rx_sigdet
''---------------------------------------------------------------------------------
'' rx_bit_lock                                [13:13]          get_rx_bit_lock
''                                                             set_rx_bit_lock
''                                                             read_rx_bit_lock
''                                                             write_rx_bit_lock
''---------------------------------------------------------------------------------
'' rx_symbol_lock_0                           [12:12]          get_rx_symbol_lock_0
''                                                             set_rx_symbol_lock_0
''                                                             read_rx_symbol_lock_0
''                                                             write_rx_symbol_lock_0
''---------------------------------------------------------------------------------
'' rx_slicer_cal_done                         [11:11]          get_rx_slicer_cal_done
''                                                             set_rx_slicer_cal_done
''                                                             read_rx_slicer_cal_done
''                                                             write_rx_slicer_cal_done
''---------------------------------------------------------------------------------
'' rx_slicer_calvalid                         [10:10]          get_rx_slicer_calvalid
''                                                             set_rx_slicer_calvalid
''                                                             read_rx_slicer_calvalid
''                                                             write_rx_slicer_calvalid
''---------------------------------------------------------------------------------
'' rx_sloff2_invalid                          [9:9]            get_rx_sloff2_invalid
''                                                             set_rx_sloff2_invalid
''                                                             read_rx_sloff2_invalid
''                                                             write_rx_sloff2_invalid
''---------------------------------------------------------------------------------
'' rx_sloff1_invalid                          [8:8]            get_rx_sloff1_invalid
''                                                             set_rx_sloff1_invalid
''                                                             read_rx_sloff1_invalid
''                                                             write_rx_sloff1_invalid
''---------------------------------------------------------------------------------
'' rx_sloff0_invalid                          [7:7]            get_rx_sloff0_invalid
''                                                             set_rx_sloff0_invalid
''                                                             read_rx_sloff0_invalid
''                                                             write_rx_sloff0_invalid
''---------------------------------------------------------------------------------
'' rx_lmtcal_done                             [6:6]            get_rx_lmtcal_done
''                                                             set_rx_lmtcal_done
''                                                             read_rx_lmtcal_done
''                                                             write_rx_lmtcal_done
''---------------------------------------------------------------------------------
'' rx_lmtcal_valid                            [5:5]            get_rx_lmtcal_valid
''                                                             set_rx_lmtcal_valid
''                                                             read_rx_lmtcal_valid
''                                                             write_rx_lmtcal_valid
''---------------------------------------------------------------------------------
'' rx_lmtoff_b5_b1                            [4:0]            get_rx_lmtoff_b5_b1
''                                                             set_rx_lmtoff_b5_b1
''                                                             read_rx_lmtoff_b5_b1
''                                                             write_rx_lmtoff_b5_b1
''---------------------------------------------------------------------------------
Class REGISTER_PCIE0__SGMIIPCIE_X1_status0
    Private write_rx_sigdet_filt_value
    Private read_rx_sigdet_filt_value
    Private flag_rx_sigdet_filt
    Private write_rx_sigdet_value
    Private read_rx_sigdet_value
    Private flag_rx_sigdet
    Private write_rx_bit_lock_value
    Private read_rx_bit_lock_value
    Private flag_rx_bit_lock
    Private write_rx_symbol_lock_0_value
    Private read_rx_symbol_lock_0_value
    Private flag_rx_symbol_lock_0
    Private write_rx_slicer_cal_done_value
    Private read_rx_slicer_cal_done_value
    Private flag_rx_slicer_cal_done
    Private write_rx_slicer_calvalid_value
    Private read_rx_slicer_calvalid_value
    Private flag_rx_slicer_calvalid
    Private write_rx_sloff2_invalid_value
    Private read_rx_sloff2_invalid_value
    Private flag_rx_sloff2_invalid
    Private write_rx_sloff1_invalid_value
    Private read_rx_sloff1_invalid_value
    Private flag_rx_sloff1_invalid
    Private write_rx_sloff0_invalid_value
    Private read_rx_sloff0_invalid_value
    Private flag_rx_sloff0_invalid
    Private write_rx_lmtcal_done_value
    Private read_rx_lmtcal_done_value
    Private flag_rx_lmtcal_done
    Private write_rx_lmtcal_valid_value
    Private read_rx_lmtcal_valid_value
    Private flag_rx_lmtcal_valid
    Private write_rx_lmtoff_b5_b1_value
    Private read_rx_lmtoff_b5_b1_value
    Private flag_rx_lmtoff_b5_b1

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

    Property Get get_rx_sigdet_filt
        get_rx_sigdet_filt = read_rx_sigdet_filt_value
    End Property

    Property Let set_rx_sigdet_filt(aData)
        write_rx_sigdet_filt_value = aData
        flag_rx_sigdet_filt        = &H1
    End Property

    Property Get read_rx_sigdet_filt
        read
        read_rx_sigdet_filt = read_rx_sigdet_filt_value
    End Property

    Property Let write_rx_sigdet_filt(aData)
        set_rx_sigdet_filt = aData
        write
    End Property

    Property Get get_rx_sigdet
        get_rx_sigdet = read_rx_sigdet_value
    End Property

    Property Let set_rx_sigdet(aData)
        write_rx_sigdet_value = aData
        flag_rx_sigdet        = &H1
    End Property

    Property Get read_rx_sigdet
        read
        read_rx_sigdet = read_rx_sigdet_value
    End Property

    Property Let write_rx_sigdet(aData)
        set_rx_sigdet = aData
        write
    End Property

    Property Get get_rx_bit_lock
        get_rx_bit_lock = read_rx_bit_lock_value
    End Property

    Property Let set_rx_bit_lock(aData)
        write_rx_bit_lock_value = aData
        flag_rx_bit_lock        = &H1
    End Property

    Property Get read_rx_bit_lock
        read
        read_rx_bit_lock = read_rx_bit_lock_value
    End Property

    Property Let write_rx_bit_lock(aData)
        set_rx_bit_lock = aData
        write
    End Property

    Property Get get_rx_symbol_lock_0
        get_rx_symbol_lock_0 = read_rx_symbol_lock_0_value
    End Property

    Property Let set_rx_symbol_lock_0(aData)
        write_rx_symbol_lock_0_value = aData
        flag_rx_symbol_lock_0        = &H1
    End Property

    Property Get read_rx_symbol_lock_0
        read
        read_rx_symbol_lock_0 = read_rx_symbol_lock_0_value
    End Property

    Property Let write_rx_symbol_lock_0(aData)
        set_rx_symbol_lock_0 = aData
        write
    End Property

    Property Get get_rx_slicer_cal_done
        get_rx_slicer_cal_done = read_rx_slicer_cal_done_value
    End Property

    Property Let set_rx_slicer_cal_done(aData)
        write_rx_slicer_cal_done_value = aData
        flag_rx_slicer_cal_done        = &H1
    End Property

    Property Get read_rx_slicer_cal_done
        read
        read_rx_slicer_cal_done = read_rx_slicer_cal_done_value
    End Property

    Property Let write_rx_slicer_cal_done(aData)
        set_rx_slicer_cal_done = aData
        write
    End Property

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

    Property Get get_rx_lmtcal_done
        get_rx_lmtcal_done = read_rx_lmtcal_done_value
    End Property

    Property Let set_rx_lmtcal_done(aData)
        write_rx_lmtcal_done_value = aData
        flag_rx_lmtcal_done        = &H1
    End Property

    Property Get read_rx_lmtcal_done
        read
        read_rx_lmtcal_done = read_rx_lmtcal_done_value
    End Property

    Property Let write_rx_lmtcal_done(aData)
        set_rx_lmtcal_done = aData
        write
    End Property

    Property Get get_rx_lmtcal_valid
        get_rx_lmtcal_valid = read_rx_lmtcal_valid_value
    End Property

    Property Let set_rx_lmtcal_valid(aData)
        write_rx_lmtcal_valid_value = aData
        flag_rx_lmtcal_valid        = &H1
    End Property

    Property Get read_rx_lmtcal_valid
        read
        read_rx_lmtcal_valid = read_rx_lmtcal_valid_value
    End Property

    Property Let write_rx_lmtcal_valid(aData)
        set_rx_lmtcal_valid = aData
        write
    End Property

    Property Get get_rx_lmtoff_b5_b1
        get_rx_lmtoff_b5_b1 = read_rx_lmtoff_b5_b1_value
    End Property

    Property Let set_rx_lmtoff_b5_b1(aData)
        write_rx_lmtoff_b5_b1_value = aData
        flag_rx_lmtoff_b5_b1        = &H1
    End Property

    Property Get read_rx_lmtoff_b5_b1
        read
        read_rx_lmtoff_b5_b1 = read_rx_lmtoff_b5_b1_value
    End Property

    Property Let write_rx_lmtoff_b5_b1(aData)
        set_rx_lmtoff_b5_b1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_rx_sigdet_filt_value = rightShift(data_low, 15) and &H1
        read_rx_sigdet_value = rightShift(data_low, 14) and &H1
        read_rx_bit_lock_value = rightShift(data_low, 13) and &H1
        read_rx_symbol_lock_0_value = rightShift(data_low, 12) and &H1
        read_rx_slicer_cal_done_value = rightShift(data_low, 11) and &H1
        read_rx_slicer_calvalid_value = rightShift(data_low, 10) and &H1
        read_rx_sloff2_invalid_value = rightShift(data_low, 9) and &H1
        read_rx_sloff1_invalid_value = rightShift(data_low, 8) and &H1
        read_rx_sloff0_invalid_value = rightShift(data_low, 7) and &H1
        read_rx_lmtcal_done_value = rightShift(data_low, 6) and &H1
        read_rx_lmtcal_valid_value = rightShift(data_low, 5) and &H1
        rx_lmtoff_b5_b1_mask = &H1f
        if data_low > LONG_MAX then
            if rx_lmtoff_b5_b1_mask = mask then
                read_rx_lmtoff_b5_b1_value = data_low
            else
                read_rx_lmtoff_b5_b1_value = (data_low - H8000_0000) and rx_lmtoff_b5_b1_mask
            end If
        else
            read_rx_lmtoff_b5_b1_value = data_low and rx_lmtoff_b5_b1_mask
        end If

    End Sub

    Sub write
        If flag_rx_sigdet_filt = &H0 or flag_rx_sigdet = &H0 or flag_rx_bit_lock = &H0 or flag_rx_symbol_lock_0 = &H0 or flag_rx_slicer_cal_done = &H0 or flag_rx_slicer_calvalid = &H0 or flag_rx_sloff2_invalid = &H0 or flag_rx_sloff1_invalid = &H0 or flag_rx_sloff0_invalid = &H0 or flag_rx_lmtcal_done = &H0 or flag_rx_lmtcal_valid = &H0 or flag_rx_lmtoff_b5_b1 = &H0 Then read
        If flag_rx_sigdet_filt = &H0 Then write_rx_sigdet_filt_value = get_rx_sigdet_filt
        If flag_rx_sigdet = &H0 Then write_rx_sigdet_value = get_rx_sigdet
        If flag_rx_bit_lock = &H0 Then write_rx_bit_lock_value = get_rx_bit_lock
        If flag_rx_symbol_lock_0 = &H0 Then write_rx_symbol_lock_0_value = get_rx_symbol_lock_0
        If flag_rx_slicer_cal_done = &H0 Then write_rx_slicer_cal_done_value = get_rx_slicer_cal_done
        If flag_rx_slicer_calvalid = &H0 Then write_rx_slicer_calvalid_value = get_rx_slicer_calvalid
        If flag_rx_sloff2_invalid = &H0 Then write_rx_sloff2_invalid_value = get_rx_sloff2_invalid
        If flag_rx_sloff1_invalid = &H0 Then write_rx_sloff1_invalid_value = get_rx_sloff1_invalid
        If flag_rx_sloff0_invalid = &H0 Then write_rx_sloff0_invalid_value = get_rx_sloff0_invalid
        If flag_rx_lmtcal_done = &H0 Then write_rx_lmtcal_done_value = get_rx_lmtcal_done
        If flag_rx_lmtcal_valid = &H0 Then write_rx_lmtcal_valid_value = get_rx_lmtcal_valid
        If flag_rx_lmtoff_b5_b1 = &H0 Then write_rx_lmtoff_b5_b1_value = get_rx_lmtoff_b5_b1

        regValue = leftShift((write_rx_sigdet_filt_value and &H1), 15) + leftShift((write_rx_sigdet_value and &H1), 14) + leftShift((write_rx_bit_lock_value and &H1), 13) + leftShift((write_rx_symbol_lock_0_value and &H1), 12) + leftShift((write_rx_slicer_cal_done_value and &H1), 11) + leftShift((write_rx_slicer_calvalid_value and &H1), 10) + leftShift((write_rx_sloff2_invalid_value and &H1), 9) + leftShift((write_rx_sloff1_invalid_value and &H1), 8) + leftShift((write_rx_sloff0_invalid_value and &H1), 7) + leftShift((write_rx_lmtcal_done_value and &H1), 6) + leftShift((write_rx_lmtcal_valid_value and &H1), 5) + leftShift((write_rx_lmtoff_b5_b1_value and &H1f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_rx_sigdet_filt_value = rightShift(data_low, 15) and &H1
        read_rx_sigdet_value = rightShift(data_low, 14) and &H1
        read_rx_bit_lock_value = rightShift(data_low, 13) and &H1
        read_rx_symbol_lock_0_value = rightShift(data_low, 12) and &H1
        read_rx_slicer_cal_done_value = rightShift(data_low, 11) and &H1
        read_rx_slicer_calvalid_value = rightShift(data_low, 10) and &H1
        read_rx_sloff2_invalid_value = rightShift(data_low, 9) and &H1
        read_rx_sloff1_invalid_value = rightShift(data_low, 8) and &H1
        read_rx_sloff0_invalid_value = rightShift(data_low, 7) and &H1
        read_rx_lmtcal_done_value = rightShift(data_low, 6) and &H1
        read_rx_lmtcal_valid_value = rightShift(data_low, 5) and &H1
        rx_lmtoff_b5_b1_mask = &H1f
        if data_low > LONG_MAX then
            if rx_lmtoff_b5_b1_mask = mask then
                read_rx_lmtoff_b5_b1_value = data_low
            else
                read_rx_lmtoff_b5_b1_value = (data_low - H8000_0000) and rx_lmtoff_b5_b1_mask
            end If
        else
            read_rx_lmtoff_b5_b1_value = data_low and rx_lmtoff_b5_b1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_rx_sigdet_filt_value = &H0
        flag_rx_sigdet_filt        = &H0
        write_rx_sigdet_value = &H0
        flag_rx_sigdet        = &H0
        write_rx_bit_lock_value = &H0
        flag_rx_bit_lock        = &H0
        write_rx_symbol_lock_0_value = &H0
        flag_rx_symbol_lock_0        = &H0
        write_rx_slicer_cal_done_value = &H0
        flag_rx_slicer_cal_done        = &H0
        write_rx_slicer_calvalid_value = &H0
        flag_rx_slicer_calvalid        = &H0
        write_rx_sloff2_invalid_value = &H0
        flag_rx_sloff2_invalid        = &H0
        write_rx_sloff1_invalid_value = &H0
        flag_rx_sloff1_invalid        = &H0
        write_rx_sloff0_invalid_value = &H0
        flag_rx_sloff0_invalid        = &H0
        write_rx_lmtcal_done_value = &H0
        flag_rx_lmtcal_done        = &H0
        write_rx_lmtcal_valid_value = &H0
        flag_rx_lmtcal_valid        = &H0
        write_rx_lmtoff_b5_b1_value = &H0
        flag_rx_lmtoff_b5_b1        = &H0
    End Sub
End Class


'' @REGISTER : PCIE0__SGMIIPCIE_X1_status1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' rx_lmtoff_b0                               [15:15]          get_rx_lmtoff_b0
''                                                             set_rx_lmtoff_b0
''                                                             read_rx_lmtoff_b0
''                                                             write_rx_lmtoff_b0
''---------------------------------------------------------------------------------
'' rx_sloff2                                  [14:11]          get_rx_sloff2
''                                                             set_rx_sloff2
''                                                             read_rx_sloff2
''                                                             write_rx_sloff2
''---------------------------------------------------------------------------------
'' rx_sloff1                                  [10:7]           get_rx_sloff1
''                                                             set_rx_sloff1
''                                                             read_rx_sloff1
''                                                             write_rx_sloff1
''---------------------------------------------------------------------------------
'' pm_ana_pwrdn_ctrl                          [6:0]            get_pm_ana_pwrdn_ctrl
''                                                             set_pm_ana_pwrdn_ctrl
''                                                             read_pm_ana_pwrdn_ctrl
''                                                             write_pm_ana_pwrdn_ctrl
''---------------------------------------------------------------------------------
Class REGISTER_PCIE0__SGMIIPCIE_X1_status1
    Private write_rx_lmtoff_b0_value
    Private read_rx_lmtoff_b0_value
    Private flag_rx_lmtoff_b0
    Private write_rx_sloff2_value
    Private read_rx_sloff2_value
    Private flag_rx_sloff2
    Private write_rx_sloff1_value
    Private read_rx_sloff1_value
    Private flag_rx_sloff1
    Private write_pm_ana_pwrdn_ctrl_value
    Private read_pm_ana_pwrdn_ctrl_value
    Private flag_pm_ana_pwrdn_ctrl

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

    Property Get get_rx_lmtoff_b0
        get_rx_lmtoff_b0 = read_rx_lmtoff_b0_value
    End Property

    Property Let set_rx_lmtoff_b0(aData)
        write_rx_lmtoff_b0_value = aData
        flag_rx_lmtoff_b0        = &H1
    End Property

    Property Get read_rx_lmtoff_b0
        read
        read_rx_lmtoff_b0 = read_rx_lmtoff_b0_value
    End Property

    Property Let write_rx_lmtoff_b0(aData)
        set_rx_lmtoff_b0 = aData
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

    Property Get get_pm_ana_pwrdn_ctrl
        get_pm_ana_pwrdn_ctrl = read_pm_ana_pwrdn_ctrl_value
    End Property

    Property Let set_pm_ana_pwrdn_ctrl(aData)
        write_pm_ana_pwrdn_ctrl_value = aData
        flag_pm_ana_pwrdn_ctrl        = &H1
    End Property

    Property Get read_pm_ana_pwrdn_ctrl
        read
        read_pm_ana_pwrdn_ctrl = read_pm_ana_pwrdn_ctrl_value
    End Property

    Property Let write_pm_ana_pwrdn_ctrl(aData)
        set_pm_ana_pwrdn_ctrl = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_rx_lmtoff_b0_value = rightShift(data_low, 15) and &H1
        read_rx_sloff2_value = rightShift(data_low, 11) and &Hf
        read_rx_sloff1_value = rightShift(data_low, 7) and &Hf
        pm_ana_pwrdn_ctrl_mask = &H7f
        if data_low > LONG_MAX then
            if pm_ana_pwrdn_ctrl_mask = mask then
                read_pm_ana_pwrdn_ctrl_value = data_low
            else
                read_pm_ana_pwrdn_ctrl_value = (data_low - H8000_0000) and pm_ana_pwrdn_ctrl_mask
            end If
        else
            read_pm_ana_pwrdn_ctrl_value = data_low and pm_ana_pwrdn_ctrl_mask
        end If

    End Sub

    Sub write
        If flag_rx_lmtoff_b0 = &H0 or flag_rx_sloff2 = &H0 or flag_rx_sloff1 = &H0 or flag_pm_ana_pwrdn_ctrl = &H0 Then read
        If flag_rx_lmtoff_b0 = &H0 Then write_rx_lmtoff_b0_value = get_rx_lmtoff_b0
        If flag_rx_sloff2 = &H0 Then write_rx_sloff2_value = get_rx_sloff2
        If flag_rx_sloff1 = &H0 Then write_rx_sloff1_value = get_rx_sloff1
        If flag_pm_ana_pwrdn_ctrl = &H0 Then write_pm_ana_pwrdn_ctrl_value = get_pm_ana_pwrdn_ctrl

        regValue = leftShift((write_rx_lmtoff_b0_value and &H1), 15) + leftShift((write_rx_sloff2_value and &Hf), 11) + leftShift((write_rx_sloff1_value and &Hf), 7) + leftShift((write_pm_ana_pwrdn_ctrl_value and &H7f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_rx_lmtoff_b0_value = rightShift(data_low, 15) and &H1
        read_rx_sloff2_value = rightShift(data_low, 11) and &Hf
        read_rx_sloff1_value = rightShift(data_low, 7) and &Hf
        pm_ana_pwrdn_ctrl_mask = &H7f
        if data_low > LONG_MAX then
            if pm_ana_pwrdn_ctrl_mask = mask then
                read_pm_ana_pwrdn_ctrl_value = data_low
            else
                read_pm_ana_pwrdn_ctrl_value = (data_low - H8000_0000) and pm_ana_pwrdn_ctrl_mask
            end If
        else
            read_pm_ana_pwrdn_ctrl_value = data_low and pm_ana_pwrdn_ctrl_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_rx_lmtoff_b0_value = &H0
        flag_rx_lmtoff_b0        = &H0
        write_rx_sloff2_value = &H0
        flag_rx_sloff2        = &H0
        write_rx_sloff1_value = &H0
        flag_rx_sloff1        = &H0
        write_pm_ana_pwrdn_ctrl_value = &H0
        flag_pm_ana_pwrdn_ctrl        = &H0
    End Sub
End Class


'' @REGISTER : PCIE0__SGMIIPCIE_X1_status2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' device_type                                [11:9]           get_device_type
''                                                             set_device_type
''                                                             read_device_type
''                                                             write_device_type
''---------------------------------------------------------------------------------
'' res_cal_done                               [8:8]            get_res_cal_done
''                                                             set_res_cal_done
''                                                             read_res_cal_done
''                                                             write_res_cal_done
''---------------------------------------------------------------------------------
'' res_cal_val                                [7:4]            get_res_cal_val
''                                                             set_res_cal_val
''                                                             read_res_cal_val
''                                                             write_res_cal_val
''---------------------------------------------------------------------------------
'' rx_sloff0                                  [3:0]            get_rx_sloff0
''                                                             set_rx_sloff0
''                                                             read_rx_sloff0
''                                                             write_rx_sloff0
''---------------------------------------------------------------------------------
Class REGISTER_PCIE0__SGMIIPCIE_X1_status2
    Private write_device_type_value
    Private read_device_type_value
    Private flag_device_type
    Private write_res_cal_done_value
    Private read_res_cal_done_value
    Private flag_res_cal_done
    Private write_res_cal_val_value
    Private read_res_cal_val_value
    Private flag_res_cal_val
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

    Property Get get_device_type
        get_device_type = read_device_type_value
    End Property

    Property Let set_device_type(aData)
        write_device_type_value = aData
        flag_device_type        = &H1
    End Property

    Property Get read_device_type
        read
        read_device_type = read_device_type_value
    End Property

    Property Let write_device_type(aData)
        set_device_type = aData
        write
    End Property

    Property Get get_res_cal_done
        get_res_cal_done = read_res_cal_done_value
    End Property

    Property Let set_res_cal_done(aData)
        write_res_cal_done_value = aData
        flag_res_cal_done        = &H1
    End Property

    Property Get read_res_cal_done
        read
        read_res_cal_done = read_res_cal_done_value
    End Property

    Property Let write_res_cal_done(aData)
        set_res_cal_done = aData
        write
    End Property

    Property Get get_res_cal_val
        get_res_cal_val = read_res_cal_val_value
    End Property

    Property Let set_res_cal_val(aData)
        write_res_cal_val_value = aData
        flag_res_cal_val        = &H1
    End Property

    Property Get read_res_cal_val
        read
        read_res_cal_val = read_res_cal_val_value
    End Property

    Property Let write_res_cal_val(aData)
        set_res_cal_val = aData
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
        read_device_type_value = rightShift(data_low, 9) and &H7
        read_res_cal_done_value = rightShift(data_low, 8) and &H1
        read_res_cal_val_value = rightShift(data_low, 4) and &Hf
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
        If flag_device_type = &H0 or flag_res_cal_done = &H0 or flag_res_cal_val = &H0 or flag_rx_sloff0 = &H0 Then read
        If flag_device_type = &H0 Then write_device_type_value = get_device_type
        If flag_res_cal_done = &H0 Then write_res_cal_done_value = get_res_cal_done
        If flag_res_cal_val = &H0 Then write_res_cal_val_value = get_res_cal_val
        If flag_rx_sloff0 = &H0 Then write_rx_sloff0_value = get_rx_sloff0

        regValue = leftShift((write_device_type_value and &H7), 9) + leftShift((write_res_cal_done_value and &H1), 8) + leftShift((write_res_cal_val_value and &Hf), 4) + leftShift((write_rx_sloff0_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_device_type_value = rightShift(data_low, 9) and &H7
        read_res_cal_done_value = rightShift(data_low, 8) and &H1
        read_res_cal_val_value = rightShift(data_low, 4) and &Hf
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
        write_device_type_value = &H0
        flag_device_type        = &H0
        write_res_cal_done_value = &H0
        flag_res_cal_done        = &H0
        write_res_cal_val_value = &H0
        flag_res_cal_val        = &H0
        write_rx_sloff0_value = &H0
        flag_rx_sloff0        = &H0
    End Sub
End Class


'' @REGISTER : PCIE0__SGMIIPCIE_X1_status3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' pm_state                                   [15:13]          get_pm_state
''                                                             set_pm_state
''                                                             read_pm_state
''                                                             write_pm_state
''---------------------------------------------------------------------------------
'' pll_lock                                   [12:12]          get_pll_lock
''                                                             set_pll_lock
''                                                             read_pll_lock
''                                                             write_pll_lock
''---------------------------------------------------------------------------------
'' rx_symbol_lock_1                           [11:11]          get_rx_symbol_lock_1
''                                                             set_rx_symbol_lock_1
''                                                             read_rx_symbol_lock_1
''                                                             write_rx_symbol_lock_1
''---------------------------------------------------------------------------------
'' pwr_mgmt_tmux                              [10:0]           get_pwr_mgmt_tmux
''                                                             set_pwr_mgmt_tmux
''                                                             read_pwr_mgmt_tmux
''                                                             write_pwr_mgmt_tmux
''---------------------------------------------------------------------------------
Class REGISTER_PCIE0__SGMIIPCIE_X1_status3
    Private write_pm_state_value
    Private read_pm_state_value
    Private flag_pm_state
    Private write_pll_lock_value
    Private read_pll_lock_value
    Private flag_pll_lock
    Private write_rx_symbol_lock_1_value
    Private read_rx_symbol_lock_1_value
    Private flag_rx_symbol_lock_1
    Private write_pwr_mgmt_tmux_value
    Private read_pwr_mgmt_tmux_value
    Private flag_pwr_mgmt_tmux

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

    Property Get get_pm_state
        get_pm_state = read_pm_state_value
    End Property

    Property Let set_pm_state(aData)
        write_pm_state_value = aData
        flag_pm_state        = &H1
    End Property

    Property Get read_pm_state
        read
        read_pm_state = read_pm_state_value
    End Property

    Property Let write_pm_state(aData)
        set_pm_state = aData
        write
    End Property

    Property Get get_pll_lock
        get_pll_lock = read_pll_lock_value
    End Property

    Property Let set_pll_lock(aData)
        write_pll_lock_value = aData
        flag_pll_lock        = &H1
    End Property

    Property Get read_pll_lock
        read
        read_pll_lock = read_pll_lock_value
    End Property

    Property Let write_pll_lock(aData)
        set_pll_lock = aData
        write
    End Property

    Property Get get_rx_symbol_lock_1
        get_rx_symbol_lock_1 = read_rx_symbol_lock_1_value
    End Property

    Property Let set_rx_symbol_lock_1(aData)
        write_rx_symbol_lock_1_value = aData
        flag_rx_symbol_lock_1        = &H1
    End Property

    Property Get read_rx_symbol_lock_1
        read
        read_rx_symbol_lock_1 = read_rx_symbol_lock_1_value
    End Property

    Property Let write_rx_symbol_lock_1(aData)
        set_rx_symbol_lock_1 = aData
        write
    End Property

    Property Get get_pwr_mgmt_tmux
        get_pwr_mgmt_tmux = read_pwr_mgmt_tmux_value
    End Property

    Property Let set_pwr_mgmt_tmux(aData)
        write_pwr_mgmt_tmux_value = aData
        flag_pwr_mgmt_tmux        = &H1
    End Property

    Property Get read_pwr_mgmt_tmux
        read
        read_pwr_mgmt_tmux = read_pwr_mgmt_tmux_value
    End Property

    Property Let write_pwr_mgmt_tmux(aData)
        set_pwr_mgmt_tmux = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_pm_state_value = rightShift(data_low, 13) and &H7
        read_pll_lock_value = rightShift(data_low, 12) and &H1
        read_rx_symbol_lock_1_value = rightShift(data_low, 11) and &H1
        pwr_mgmt_tmux_mask = &H7ff
        if data_low > LONG_MAX then
            if pwr_mgmt_tmux_mask = mask then
                read_pwr_mgmt_tmux_value = data_low
            else
                read_pwr_mgmt_tmux_value = (data_low - H8000_0000) and pwr_mgmt_tmux_mask
            end If
        else
            read_pwr_mgmt_tmux_value = data_low and pwr_mgmt_tmux_mask
        end If

    End Sub

    Sub write
        If flag_pm_state = &H0 or flag_pll_lock = &H0 or flag_rx_symbol_lock_1 = &H0 or flag_pwr_mgmt_tmux = &H0 Then read
        If flag_pm_state = &H0 Then write_pm_state_value = get_pm_state
        If flag_pll_lock = &H0 Then write_pll_lock_value = get_pll_lock
        If flag_rx_symbol_lock_1 = &H0 Then write_rx_symbol_lock_1_value = get_rx_symbol_lock_1
        If flag_pwr_mgmt_tmux = &H0 Then write_pwr_mgmt_tmux_value = get_pwr_mgmt_tmux

        regValue = leftShift((write_pm_state_value and &H7), 13) + leftShift((write_pll_lock_value and &H1), 12) + leftShift((write_rx_symbol_lock_1_value and &H1), 11) + leftShift((write_pwr_mgmt_tmux_value and &H7ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_pm_state_value = rightShift(data_low, 13) and &H7
        read_pll_lock_value = rightShift(data_low, 12) and &H1
        read_rx_symbol_lock_1_value = rightShift(data_low, 11) and &H1
        pwr_mgmt_tmux_mask = &H7ff
        if data_low > LONG_MAX then
            if pwr_mgmt_tmux_mask = mask then
                read_pwr_mgmt_tmux_value = data_low
            else
                read_pwr_mgmt_tmux_value = (data_low - H8000_0000) and pwr_mgmt_tmux_mask
            end If
        else
            read_pwr_mgmt_tmux_value = data_low and pwr_mgmt_tmux_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_pm_state_value = &H0
        flag_pm_state        = &H0
        write_pll_lock_value = &H0
        flag_pll_lock        = &H0
        write_rx_symbol_lock_1_value = &H0
        flag_rx_symbol_lock_1        = &H0
        write_pwr_mgmt_tmux_value = &H0
        flag_pwr_mgmt_tmux        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class PCIE0__SGMIIPCIE_X1_INSTANCE

    Public ctrl0
    Public ctrl1
    Public ctrl2
    Public ctrl3
    Public status0
    Public status1
    Public status2
    Public status3


    Public default function Init(aBaseAddr)
        Set ctrl0 = (New REGISTER_PCIE0__SGMIIPCIE_X1_ctrl0)(aBaseAddr, 16)
        Set ctrl1 = (New REGISTER_PCIE0__SGMIIPCIE_X1_ctrl1)(aBaseAddr, 16)
        Set ctrl2 = (New REGISTER_PCIE0__SGMIIPCIE_X1_ctrl2)(aBaseAddr, 16)
        Set ctrl3 = (New REGISTER_PCIE0__SGMIIPCIE_X1_ctrl3)(aBaseAddr, 16)
        Set status0 = (New REGISTER_PCIE0__SGMIIPCIE_X1_status0)(aBaseAddr, 16)
        Set status1 = (New REGISTER_PCIE0__SGMIIPCIE_X1_status1)(aBaseAddr, 16)
        Set status2 = (New REGISTER_PCIE0__SGMIIPCIE_X1_status2)(aBaseAddr, 16)
        Set status3 = (New REGISTER_PCIE0__SGMIIPCIE_X1_status3)(aBaseAddr, 16)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set PCIE0__SGMIIPCIE_X1 = CreateObject("System.Collections.ArrayList")
PCIE0__SGMIIPCIE_X1.Add ((New PCIE0__SGMIIPCIE_X1_INSTANCE)(&H4ade2000))


