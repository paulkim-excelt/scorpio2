

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


'' @REGISTER : PCIE3__SGMIIPCIE_X1_gen2ctrl0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mdio_byp_pipe_io                           [15:15]          get_mdio_byp_pipe_io
''                                                             set_mdio_byp_pipe_io
''                                                             read_mdio_byp_pipe_io
''                                                             write_mdio_byp_pipe_io
''---------------------------------------------------------------------------------
'' pwrdown_mdio_sel                           [14:14]          get_pwrdown_mdio_sel
''                                                             set_pwrdown_mdio_sel
''                                                             read_pwrdown_mdio_sel
''                                                             write_pwrdown_mdio_sel
''---------------------------------------------------------------------------------
'' tx_idle_mdio_sel                           [13:13]          get_tx_idle_mdio_sel
''                                                             set_tx_idle_mdio_sel
''                                                             read_tx_idle_mdio_sel
''                                                             write_tx_idle_mdio_sel
''---------------------------------------------------------------------------------
'' rloop_pipe_mdio_sel                        [12:12]          get_rloop_pipe_mdio_sel
''                                                             set_rloop_pipe_mdio_sel
''                                                             read_rloop_pipe_mdio_sel
''                                                             write_rloop_pipe_mdio_sel
''---------------------------------------------------------------------------------
'' gloop_mdio_sel                             [11:11]          get_gloop_mdio_sel
''                                                             set_gloop_mdio_sel
''                                                             read_gloop_mdio_sel
''                                                             write_gloop_mdio_sel
''---------------------------------------------------------------------------------
'' tx_comp_mdio_sel                           [10:10]          get_tx_comp_mdio_sel
''                                                             set_tx_comp_mdio_sel
''                                                             read_tx_comp_mdio_sel
''                                                             write_tx_comp_mdio_sel
''---------------------------------------------------------------------------------
'' mdioAfeLowLeakMode_N                       [9:9]            get_mdioAfeLowLeakMode_N
''                                                             set_mdioAfeLowLeakMode_N
''                                                             read_mdioAfeLowLeakMode_N
''                                                             write_mdioAfeLowLeakMode_N
''---------------------------------------------------------------------------------
'' AfeLowLeakMode_mdio_sel                    [8:8]            get_AfeLowLeakMode_mdio_sel
''                                                             set_AfeLowLeakMode_mdio_sel
''                                                             read_AfeLowLeakMode_mdio_sel
''                                                             write_AfeLowLeakMode_mdio_sel
''---------------------------------------------------------------------------------
'' mdio_RxElectIdleRloopEn                    [7:7]            get_mdio_RxElectIdleRloopEn
''                                                             set_mdio_RxElectIdleRloopEn
''                                                             read_mdio_RxElectIdleRloopEn
''                                                             write_mdio_RxElectIdleRloopEn
''---------------------------------------------------------------------------------
'' StandAloneMode_mdio_sel                    [6:6]            get_StandAloneMode_mdio_sel
''                                                             set_StandAloneMode_mdio_sel
''                                                             read_StandAloneMode_mdio_sel
''                                                             write_StandAloneMode_mdio_sel
''---------------------------------------------------------------------------------
'' PllTuningBypass_mdio_sel                   [5:5]            get_PllTuningBypass_mdio_sel
''                                                             set_PllTuningBypass_mdio_sel
''                                                             read_PllTuningBypass_mdio_sel
''                                                             write_PllTuningBypass_mdio_sel
''---------------------------------------------------------------------------------
'' lfck_rx_sel_mdio_sel                       [4:4]            get_lfck_rx_sel_mdio_sel
''                                                             set_lfck_rx_sel_mdio_sel
''                                                             read_lfck_rx_sel_mdio_sel
''                                                             write_lfck_rx_sel_mdio_sel
''---------------------------------------------------------------------------------
'' mdio_DeviceType_sel                        [3:3]            get_mdio_DeviceType_sel
''                                                             set_mdio_DeviceType_sel
''                                                             read_mdio_DeviceType_sel
''                                                             write_mdio_DeviceType_sel
''---------------------------------------------------------------------------------
'' mdio_DeviceType                            [2:0]            get_mdio_DeviceType
''                                                             set_mdio_DeviceType
''                                                             read_mdio_DeviceType
''                                                             write_mdio_DeviceType
''---------------------------------------------------------------------------------
Class REGISTER_PCIE3__SGMIIPCIE_X1_gen2ctrl0
    Private write_mdio_byp_pipe_io_value
    Private read_mdio_byp_pipe_io_value
    Private flag_mdio_byp_pipe_io
    Private write_pwrdown_mdio_sel_value
    Private read_pwrdown_mdio_sel_value
    Private flag_pwrdown_mdio_sel
    Private write_tx_idle_mdio_sel_value
    Private read_tx_idle_mdio_sel_value
    Private flag_tx_idle_mdio_sel
    Private write_rloop_pipe_mdio_sel_value
    Private read_rloop_pipe_mdio_sel_value
    Private flag_rloop_pipe_mdio_sel
    Private write_gloop_mdio_sel_value
    Private read_gloop_mdio_sel_value
    Private flag_gloop_mdio_sel
    Private write_tx_comp_mdio_sel_value
    Private read_tx_comp_mdio_sel_value
    Private flag_tx_comp_mdio_sel
    Private write_mdioAfeLowLeakMode_N_value
    Private read_mdioAfeLowLeakMode_N_value
    Private flag_mdioAfeLowLeakMode_N
    Private write_AfeLowLeakMode_mdio_sel_value
    Private read_AfeLowLeakMode_mdio_sel_value
    Private flag_AfeLowLeakMode_mdio_sel
    Private write_mdio_RxElectIdleRloopEn_value
    Private read_mdio_RxElectIdleRloopEn_value
    Private flag_mdio_RxElectIdleRloopEn
    Private write_StandAloneMode_mdio_sel_value
    Private read_StandAloneMode_mdio_sel_value
    Private flag_StandAloneMode_mdio_sel
    Private write_PllTuningBypass_mdio_sel_value
    Private read_PllTuningBypass_mdio_sel_value
    Private flag_PllTuningBypass_mdio_sel
    Private write_lfck_rx_sel_mdio_sel_value
    Private read_lfck_rx_sel_mdio_sel_value
    Private flag_lfck_rx_sel_mdio_sel
    Private write_mdio_DeviceType_sel_value
    Private read_mdio_DeviceType_sel_value
    Private flag_mdio_DeviceType_sel
    Private write_mdio_DeviceType_value
    Private read_mdio_DeviceType_value
    Private flag_mdio_DeviceType

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

    Property Get get_mdio_byp_pipe_io
        get_mdio_byp_pipe_io = read_mdio_byp_pipe_io_value
    End Property

    Property Let set_mdio_byp_pipe_io(aData)
        write_mdio_byp_pipe_io_value = aData
        flag_mdio_byp_pipe_io        = &H1
    End Property

    Property Get read_mdio_byp_pipe_io
        read
        read_mdio_byp_pipe_io = read_mdio_byp_pipe_io_value
    End Property

    Property Let write_mdio_byp_pipe_io(aData)
        set_mdio_byp_pipe_io = aData
        write
    End Property

    Property Get get_pwrdown_mdio_sel
        get_pwrdown_mdio_sel = read_pwrdown_mdio_sel_value
    End Property

    Property Let set_pwrdown_mdio_sel(aData)
        write_pwrdown_mdio_sel_value = aData
        flag_pwrdown_mdio_sel        = &H1
    End Property

    Property Get read_pwrdown_mdio_sel
        read
        read_pwrdown_mdio_sel = read_pwrdown_mdio_sel_value
    End Property

    Property Let write_pwrdown_mdio_sel(aData)
        set_pwrdown_mdio_sel = aData
        write
    End Property

    Property Get get_tx_idle_mdio_sel
        get_tx_idle_mdio_sel = read_tx_idle_mdio_sel_value
    End Property

    Property Let set_tx_idle_mdio_sel(aData)
        write_tx_idle_mdio_sel_value = aData
        flag_tx_idle_mdio_sel        = &H1
    End Property

    Property Get read_tx_idle_mdio_sel
        read
        read_tx_idle_mdio_sel = read_tx_idle_mdio_sel_value
    End Property

    Property Let write_tx_idle_mdio_sel(aData)
        set_tx_idle_mdio_sel = aData
        write
    End Property

    Property Get get_rloop_pipe_mdio_sel
        get_rloop_pipe_mdio_sel = read_rloop_pipe_mdio_sel_value
    End Property

    Property Let set_rloop_pipe_mdio_sel(aData)
        write_rloop_pipe_mdio_sel_value = aData
        flag_rloop_pipe_mdio_sel        = &H1
    End Property

    Property Get read_rloop_pipe_mdio_sel
        read
        read_rloop_pipe_mdio_sel = read_rloop_pipe_mdio_sel_value
    End Property

    Property Let write_rloop_pipe_mdio_sel(aData)
        set_rloop_pipe_mdio_sel = aData
        write
    End Property

    Property Get get_gloop_mdio_sel
        get_gloop_mdio_sel = read_gloop_mdio_sel_value
    End Property

    Property Let set_gloop_mdio_sel(aData)
        write_gloop_mdio_sel_value = aData
        flag_gloop_mdio_sel        = &H1
    End Property

    Property Get read_gloop_mdio_sel
        read
        read_gloop_mdio_sel = read_gloop_mdio_sel_value
    End Property

    Property Let write_gloop_mdio_sel(aData)
        set_gloop_mdio_sel = aData
        write
    End Property

    Property Get get_tx_comp_mdio_sel
        get_tx_comp_mdio_sel = read_tx_comp_mdio_sel_value
    End Property

    Property Let set_tx_comp_mdio_sel(aData)
        write_tx_comp_mdio_sel_value = aData
        flag_tx_comp_mdio_sel        = &H1
    End Property

    Property Get read_tx_comp_mdio_sel
        read
        read_tx_comp_mdio_sel = read_tx_comp_mdio_sel_value
    End Property

    Property Let write_tx_comp_mdio_sel(aData)
        set_tx_comp_mdio_sel = aData
        write
    End Property

    Property Get get_mdioAfeLowLeakMode_N
        get_mdioAfeLowLeakMode_N = read_mdioAfeLowLeakMode_N_value
    End Property

    Property Let set_mdioAfeLowLeakMode_N(aData)
        write_mdioAfeLowLeakMode_N_value = aData
        flag_mdioAfeLowLeakMode_N        = &H1
    End Property

    Property Get read_mdioAfeLowLeakMode_N
        read
        read_mdioAfeLowLeakMode_N = read_mdioAfeLowLeakMode_N_value
    End Property

    Property Let write_mdioAfeLowLeakMode_N(aData)
        set_mdioAfeLowLeakMode_N = aData
        write
    End Property

    Property Get get_AfeLowLeakMode_mdio_sel
        get_AfeLowLeakMode_mdio_sel = read_AfeLowLeakMode_mdio_sel_value
    End Property

    Property Let set_AfeLowLeakMode_mdio_sel(aData)
        write_AfeLowLeakMode_mdio_sel_value = aData
        flag_AfeLowLeakMode_mdio_sel        = &H1
    End Property

    Property Get read_AfeLowLeakMode_mdio_sel
        read
        read_AfeLowLeakMode_mdio_sel = read_AfeLowLeakMode_mdio_sel_value
    End Property

    Property Let write_AfeLowLeakMode_mdio_sel(aData)
        set_AfeLowLeakMode_mdio_sel = aData
        write
    End Property

    Property Get get_mdio_RxElectIdleRloopEn
        get_mdio_RxElectIdleRloopEn = read_mdio_RxElectIdleRloopEn_value
    End Property

    Property Let set_mdio_RxElectIdleRloopEn(aData)
        write_mdio_RxElectIdleRloopEn_value = aData
        flag_mdio_RxElectIdleRloopEn        = &H1
    End Property

    Property Get read_mdio_RxElectIdleRloopEn
        read
        read_mdio_RxElectIdleRloopEn = read_mdio_RxElectIdleRloopEn_value
    End Property

    Property Let write_mdio_RxElectIdleRloopEn(aData)
        set_mdio_RxElectIdleRloopEn = aData
        write
    End Property

    Property Get get_StandAloneMode_mdio_sel
        get_StandAloneMode_mdio_sel = read_StandAloneMode_mdio_sel_value
    End Property

    Property Let set_StandAloneMode_mdio_sel(aData)
        write_StandAloneMode_mdio_sel_value = aData
        flag_StandAloneMode_mdio_sel        = &H1
    End Property

    Property Get read_StandAloneMode_mdio_sel
        read
        read_StandAloneMode_mdio_sel = read_StandAloneMode_mdio_sel_value
    End Property

    Property Let write_StandAloneMode_mdio_sel(aData)
        set_StandAloneMode_mdio_sel = aData
        write
    End Property

    Property Get get_PllTuningBypass_mdio_sel
        get_PllTuningBypass_mdio_sel = read_PllTuningBypass_mdio_sel_value
    End Property

    Property Let set_PllTuningBypass_mdio_sel(aData)
        write_PllTuningBypass_mdio_sel_value = aData
        flag_PllTuningBypass_mdio_sel        = &H1
    End Property

    Property Get read_PllTuningBypass_mdio_sel
        read
        read_PllTuningBypass_mdio_sel = read_PllTuningBypass_mdio_sel_value
    End Property

    Property Let write_PllTuningBypass_mdio_sel(aData)
        set_PllTuningBypass_mdio_sel = aData
        write
    End Property

    Property Get get_lfck_rx_sel_mdio_sel
        get_lfck_rx_sel_mdio_sel = read_lfck_rx_sel_mdio_sel_value
    End Property

    Property Let set_lfck_rx_sel_mdio_sel(aData)
        write_lfck_rx_sel_mdio_sel_value = aData
        flag_lfck_rx_sel_mdio_sel        = &H1
    End Property

    Property Get read_lfck_rx_sel_mdio_sel
        read
        read_lfck_rx_sel_mdio_sel = read_lfck_rx_sel_mdio_sel_value
    End Property

    Property Let write_lfck_rx_sel_mdio_sel(aData)
        set_lfck_rx_sel_mdio_sel = aData
        write
    End Property

    Property Get get_mdio_DeviceType_sel
        get_mdio_DeviceType_sel = read_mdio_DeviceType_sel_value
    End Property

    Property Let set_mdio_DeviceType_sel(aData)
        write_mdio_DeviceType_sel_value = aData
        flag_mdio_DeviceType_sel        = &H1
    End Property

    Property Get read_mdio_DeviceType_sel
        read
        read_mdio_DeviceType_sel = read_mdio_DeviceType_sel_value
    End Property

    Property Let write_mdio_DeviceType_sel(aData)
        set_mdio_DeviceType_sel = aData
        write
    End Property

    Property Get get_mdio_DeviceType
        get_mdio_DeviceType = read_mdio_DeviceType_value
    End Property

    Property Let set_mdio_DeviceType(aData)
        write_mdio_DeviceType_value = aData
        flag_mdio_DeviceType        = &H1
    End Property

    Property Get read_mdio_DeviceType
        read
        read_mdio_DeviceType = read_mdio_DeviceType_value
    End Property

    Property Let write_mdio_DeviceType(aData)
        set_mdio_DeviceType = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_mdio_byp_pipe_io_value = rightShift(data_low, 15) and &H1
        read_pwrdown_mdio_sel_value = rightShift(data_low, 14) and &H1
        read_tx_idle_mdio_sel_value = rightShift(data_low, 13) and &H1
        read_rloop_pipe_mdio_sel_value = rightShift(data_low, 12) and &H1
        read_gloop_mdio_sel_value = rightShift(data_low, 11) and &H1
        read_tx_comp_mdio_sel_value = rightShift(data_low, 10) and &H1
        read_mdioAfeLowLeakMode_N_value = rightShift(data_low, 9) and &H1
        read_AfeLowLeakMode_mdio_sel_value = rightShift(data_low, 8) and &H1
        read_mdio_RxElectIdleRloopEn_value = rightShift(data_low, 7) and &H1
        read_StandAloneMode_mdio_sel_value = rightShift(data_low, 6) and &H1
        read_PllTuningBypass_mdio_sel_value = rightShift(data_low, 5) and &H1
        read_lfck_rx_sel_mdio_sel_value = rightShift(data_low, 4) and &H1
        read_mdio_DeviceType_sel_value = rightShift(data_low, 3) and &H1
        mdio_DeviceType_mask = &H7
        if data_low > LONG_MAX then
            if mdio_DeviceType_mask = mask then
                read_mdio_DeviceType_value = data_low
            else
                read_mdio_DeviceType_value = (data_low - H8000_0000) and mdio_DeviceType_mask
            end If
        else
            read_mdio_DeviceType_value = data_low and mdio_DeviceType_mask
        end If

    End Sub

    Sub write
        If flag_mdio_byp_pipe_io = &H0 or flag_pwrdown_mdio_sel = &H0 or flag_tx_idle_mdio_sel = &H0 or flag_rloop_pipe_mdio_sel = &H0 or flag_gloop_mdio_sel = &H0 or flag_tx_comp_mdio_sel = &H0 or flag_mdioAfeLowLeakMode_N = &H0 or flag_AfeLowLeakMode_mdio_sel = &H0 or flag_mdio_RxElectIdleRloopEn = &H0 or flag_StandAloneMode_mdio_sel = &H0 or flag_PllTuningBypass_mdio_sel = &H0 or flag_lfck_rx_sel_mdio_sel = &H0 or flag_mdio_DeviceType_sel = &H0 or flag_mdio_DeviceType = &H0 Then read
        If flag_mdio_byp_pipe_io = &H0 Then write_mdio_byp_pipe_io_value = get_mdio_byp_pipe_io
        If flag_pwrdown_mdio_sel = &H0 Then write_pwrdown_mdio_sel_value = get_pwrdown_mdio_sel
        If flag_tx_idle_mdio_sel = &H0 Then write_tx_idle_mdio_sel_value = get_tx_idle_mdio_sel
        If flag_rloop_pipe_mdio_sel = &H0 Then write_rloop_pipe_mdio_sel_value = get_rloop_pipe_mdio_sel
        If flag_gloop_mdio_sel = &H0 Then write_gloop_mdio_sel_value = get_gloop_mdio_sel
        If flag_tx_comp_mdio_sel = &H0 Then write_tx_comp_mdio_sel_value = get_tx_comp_mdio_sel
        If flag_mdioAfeLowLeakMode_N = &H0 Then write_mdioAfeLowLeakMode_N_value = get_mdioAfeLowLeakMode_N
        If flag_AfeLowLeakMode_mdio_sel = &H0 Then write_AfeLowLeakMode_mdio_sel_value = get_AfeLowLeakMode_mdio_sel
        If flag_mdio_RxElectIdleRloopEn = &H0 Then write_mdio_RxElectIdleRloopEn_value = get_mdio_RxElectIdleRloopEn
        If flag_StandAloneMode_mdio_sel = &H0 Then write_StandAloneMode_mdio_sel_value = get_StandAloneMode_mdio_sel
        If flag_PllTuningBypass_mdio_sel = &H0 Then write_PllTuningBypass_mdio_sel_value = get_PllTuningBypass_mdio_sel
        If flag_lfck_rx_sel_mdio_sel = &H0 Then write_lfck_rx_sel_mdio_sel_value = get_lfck_rx_sel_mdio_sel
        If flag_mdio_DeviceType_sel = &H0 Then write_mdio_DeviceType_sel_value = get_mdio_DeviceType_sel
        If flag_mdio_DeviceType = &H0 Then write_mdio_DeviceType_value = get_mdio_DeviceType

        regValue = leftShift((write_mdio_byp_pipe_io_value and &H1), 15) + leftShift((write_pwrdown_mdio_sel_value and &H1), 14) + leftShift((write_tx_idle_mdio_sel_value and &H1), 13) + leftShift((write_rloop_pipe_mdio_sel_value and &H1), 12) + leftShift((write_gloop_mdio_sel_value and &H1), 11) + leftShift((write_tx_comp_mdio_sel_value and &H1), 10) + leftShift((write_mdioAfeLowLeakMode_N_value and &H1), 9) + leftShift((write_AfeLowLeakMode_mdio_sel_value and &H1), 8) + leftShift((write_mdio_RxElectIdleRloopEn_value and &H1), 7) + leftShift((write_StandAloneMode_mdio_sel_value and &H1), 6) + leftShift((write_PllTuningBypass_mdio_sel_value and &H1), 5) + leftShift((write_lfck_rx_sel_mdio_sel_value and &H1), 4) + leftShift((write_mdio_DeviceType_sel_value and &H1), 3) + leftShift((write_mdio_DeviceType_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_mdio_byp_pipe_io_value = rightShift(data_low, 15) and &H1
        read_pwrdown_mdio_sel_value = rightShift(data_low, 14) and &H1
        read_tx_idle_mdio_sel_value = rightShift(data_low, 13) and &H1
        read_rloop_pipe_mdio_sel_value = rightShift(data_low, 12) and &H1
        read_gloop_mdio_sel_value = rightShift(data_low, 11) and &H1
        read_tx_comp_mdio_sel_value = rightShift(data_low, 10) and &H1
        read_mdioAfeLowLeakMode_N_value = rightShift(data_low, 9) and &H1
        read_AfeLowLeakMode_mdio_sel_value = rightShift(data_low, 8) and &H1
        read_mdio_RxElectIdleRloopEn_value = rightShift(data_low, 7) and &H1
        read_StandAloneMode_mdio_sel_value = rightShift(data_low, 6) and &H1
        read_PllTuningBypass_mdio_sel_value = rightShift(data_low, 5) and &H1
        read_lfck_rx_sel_mdio_sel_value = rightShift(data_low, 4) and &H1
        read_mdio_DeviceType_sel_value = rightShift(data_low, 3) and &H1
        mdio_DeviceType_mask = &H7
        if data_low > LONG_MAX then
            if mdio_DeviceType_mask = mask then
                read_mdio_DeviceType_value = data_low
            else
                read_mdio_DeviceType_value = (data_low - H8000_0000) and mdio_DeviceType_mask
            end If
        else
            read_mdio_DeviceType_value = data_low and mdio_DeviceType_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mdio_byp_pipe_io_value = &H0
        flag_mdio_byp_pipe_io        = &H0
        write_pwrdown_mdio_sel_value = &H0
        flag_pwrdown_mdio_sel        = &H0
        write_tx_idle_mdio_sel_value = &H0
        flag_tx_idle_mdio_sel        = &H0
        write_rloop_pipe_mdio_sel_value = &H0
        flag_rloop_pipe_mdio_sel        = &H0
        write_gloop_mdio_sel_value = &H0
        flag_gloop_mdio_sel        = &H0
        write_tx_comp_mdio_sel_value = &H0
        flag_tx_comp_mdio_sel        = &H0
        write_mdioAfeLowLeakMode_N_value = &H0
        flag_mdioAfeLowLeakMode_N        = &H0
        write_AfeLowLeakMode_mdio_sel_value = &H0
        flag_AfeLowLeakMode_mdio_sel        = &H0
        write_mdio_RxElectIdleRloopEn_value = &H0
        flag_mdio_RxElectIdleRloopEn        = &H0
        write_StandAloneMode_mdio_sel_value = &H0
        flag_StandAloneMode_mdio_sel        = &H0
        write_PllTuningBypass_mdio_sel_value = &H0
        flag_PllTuningBypass_mdio_sel        = &H0
        write_lfck_rx_sel_mdio_sel_value = &H0
        flag_lfck_rx_sel_mdio_sel        = &H0
        write_mdio_DeviceType_sel_value = &H0
        flag_mdio_DeviceType_sel        = &H0
        write_mdio_DeviceType_value = &H0
        flag_mdio_DeviceType        = &H0
    End Sub
End Class


'' @REGISTER : PCIE3__SGMIIPCIE_X1_gen2ctrl1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' txEI_cnt_en                                [1:1]            get_txEI_cnt_en
''                                                             set_txEI_cnt_en
''                                                             read_txEI_cnt_en
''                                                             write_txEI_cnt_en
''---------------------------------------------------------------------------------
'' RateSelect_mdio_sel                        [0:0]            get_RateSelect_mdio_sel
''                                                             set_RateSelect_mdio_sel
''                                                             read_RateSelect_mdio_sel
''                                                             write_RateSelect_mdio_sel
''---------------------------------------------------------------------------------
Class REGISTER_PCIE3__SGMIIPCIE_X1_gen2ctrl1
    Private write_txEI_cnt_en_value
    Private read_txEI_cnt_en_value
    Private flag_txEI_cnt_en
    Private write_RateSelect_mdio_sel_value
    Private read_RateSelect_mdio_sel_value
    Private flag_RateSelect_mdio_sel

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

    Property Get get_txEI_cnt_en
        get_txEI_cnt_en = read_txEI_cnt_en_value
    End Property

    Property Let set_txEI_cnt_en(aData)
        write_txEI_cnt_en_value = aData
        flag_txEI_cnt_en        = &H1
    End Property

    Property Get read_txEI_cnt_en
        read
        read_txEI_cnt_en = read_txEI_cnt_en_value
    End Property

    Property Let write_txEI_cnt_en(aData)
        set_txEI_cnt_en = aData
        write
    End Property

    Property Get get_RateSelect_mdio_sel
        get_RateSelect_mdio_sel = read_RateSelect_mdio_sel_value
    End Property

    Property Let set_RateSelect_mdio_sel(aData)
        write_RateSelect_mdio_sel_value = aData
        flag_RateSelect_mdio_sel        = &H1
    End Property

    Property Get read_RateSelect_mdio_sel
        read
        read_RateSelect_mdio_sel = read_RateSelect_mdio_sel_value
    End Property

    Property Let write_RateSelect_mdio_sel(aData)
        set_RateSelect_mdio_sel = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_txEI_cnt_en_value = rightShift(data_low, 1) and &H1
        RateSelect_mdio_sel_mask = &H1
        if data_low > LONG_MAX then
            if RateSelect_mdio_sel_mask = mask then
                read_RateSelect_mdio_sel_value = data_low
            else
                read_RateSelect_mdio_sel_value = (data_low - H8000_0000) and RateSelect_mdio_sel_mask
            end If
        else
            read_RateSelect_mdio_sel_value = data_low and RateSelect_mdio_sel_mask
        end If

    End Sub

    Sub write
        If flag_txEI_cnt_en = &H0 or flag_RateSelect_mdio_sel = &H0 Then read
        If flag_txEI_cnt_en = &H0 Then write_txEI_cnt_en_value = get_txEI_cnt_en
        If flag_RateSelect_mdio_sel = &H0 Then write_RateSelect_mdio_sel_value = get_RateSelect_mdio_sel

        regValue = leftShift((write_txEI_cnt_en_value and &H1), 1) + leftShift((write_RateSelect_mdio_sel_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_txEI_cnt_en_value = rightShift(data_low, 1) and &H1
        RateSelect_mdio_sel_mask = &H1
        if data_low > LONG_MAX then
            if RateSelect_mdio_sel_mask = mask then
                read_RateSelect_mdio_sel_value = data_low
            else
                read_RateSelect_mdio_sel_value = (data_low - H8000_0000) and RateSelect_mdio_sel_mask
            end If
        else
            read_RateSelect_mdio_sel_value = data_low and RateSelect_mdio_sel_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_txEI_cnt_en_value = &H0
        flag_txEI_cnt_en        = &H0
        write_RateSelect_mdio_sel_value = &H0
        flag_RateSelect_mdio_sel        = &H0
    End Sub
End Class


'' @REGISTER : PCIE3__SGMIIPCIE_X1_gen2ctrl2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mdioRateSelect                             [15:0]           get_mdioRateSelect
''                                                             set_mdioRateSelect
''                                                             read_mdioRateSelect
''                                                             write_mdioRateSelect
''---------------------------------------------------------------------------------
Class REGISTER_PCIE3__SGMIIPCIE_X1_gen2ctrl2
    Private write_mdioRateSelect_value
    Private read_mdioRateSelect_value
    Private flag_mdioRateSelect

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

    Property Get get_mdioRateSelect
        get_mdioRateSelect = read_mdioRateSelect_value
    End Property

    Property Let set_mdioRateSelect(aData)
        write_mdioRateSelect_value = aData
        flag_mdioRateSelect        = &H1
    End Property

    Property Get read_mdioRateSelect
        read
        read_mdioRateSelect = read_mdioRateSelect_value
    End Property

    Property Let write_mdioRateSelect(aData)
        set_mdioRateSelect = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mdioRateSelect_mask = &Hffff
        if data_low > LONG_MAX then
            if mdioRateSelect_mask = mask then
                read_mdioRateSelect_value = data_low
            else
                read_mdioRateSelect_value = (data_low - H8000_0000) and mdioRateSelect_mask
            end If
        else
            read_mdioRateSelect_value = data_low and mdioRateSelect_mask
        end If

    End Sub

    Sub write
        If flag_mdioRateSelect = &H0 Then read
        If flag_mdioRateSelect = &H0 Then write_mdioRateSelect_value = get_mdioRateSelect

        regValue = leftShift((write_mdioRateSelect_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mdioRateSelect_mask = &Hffff
        if data_low > LONG_MAX then
            if mdioRateSelect_mask = mask then
                read_mdioRateSelect_value = data_low
            else
                read_mdioRateSelect_value = (data_low - H8000_0000) and mdioRateSelect_mask
            end If
        else
            read_mdioRateSelect_value = data_low and mdioRateSelect_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mdioRateSelect_value = &H0
        flag_mdioRateSelect        = &H0
    End Sub
End Class


'' @REGISTER : PCIE3__SGMIIPCIE_X1_gen2ctrl3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mdio_gloop                                 [15:0]           get_mdio_gloop
''                                                             set_mdio_gloop
''                                                             read_mdio_gloop
''                                                             write_mdio_gloop
''---------------------------------------------------------------------------------
Class REGISTER_PCIE3__SGMIIPCIE_X1_gen2ctrl3
    Private write_mdio_gloop_value
    Private read_mdio_gloop_value
    Private flag_mdio_gloop

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

    Property Get get_mdio_gloop
        get_mdio_gloop = read_mdio_gloop_value
    End Property

    Property Let set_mdio_gloop(aData)
        write_mdio_gloop_value = aData
        flag_mdio_gloop        = &H1
    End Property

    Property Get read_mdio_gloop
        read
        read_mdio_gloop = read_mdio_gloop_value
    End Property

    Property Let write_mdio_gloop(aData)
        set_mdio_gloop = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mdio_gloop_mask = &Hffff
        if data_low > LONG_MAX then
            if mdio_gloop_mask = mask then
                read_mdio_gloop_value = data_low
            else
                read_mdio_gloop_value = (data_low - H8000_0000) and mdio_gloop_mask
            end If
        else
            read_mdio_gloop_value = data_low and mdio_gloop_mask
        end If

    End Sub

    Sub write
        If flag_mdio_gloop = &H0 Then read
        If flag_mdio_gloop = &H0 Then write_mdio_gloop_value = get_mdio_gloop

        regValue = leftShift((write_mdio_gloop_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mdio_gloop_mask = &Hffff
        if data_low > LONG_MAX then
            if mdio_gloop_mask = mask then
                read_mdio_gloop_value = data_low
            else
                read_mdio_gloop_value = (data_low - H8000_0000) and mdio_gloop_mask
            end If
        else
            read_mdio_gloop_value = data_low and mdio_gloop_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mdio_gloop_value = &H0
        flag_mdio_gloop        = &H0
    End Sub
End Class


'' @REGISTER : PCIE3__SGMIIPCIE_X1_gen2ctrl4
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' rloop1g                                    [15:0]           get_rloop1g
''                                                             set_rloop1g
''                                                             read_rloop1g
''                                                             write_rloop1g
''---------------------------------------------------------------------------------
Class REGISTER_PCIE3__SGMIIPCIE_X1_gen2ctrl4
    Private write_rloop1g_value
    Private read_rloop1g_value
    Private flag_rloop1g

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

    Property Get get_rloop1g
        get_rloop1g = read_rloop1g_value
    End Property

    Property Let set_rloop1g(aData)
        write_rloop1g_value = aData
        flag_rloop1g        = &H1
    End Property

    Property Get read_rloop1g
        read
        read_rloop1g = read_rloop1g_value
    End Property

    Property Let write_rloop1g(aData)
        set_rloop1g = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rloop1g_mask = &Hffff
        if data_low > LONG_MAX then
            if rloop1g_mask = mask then
                read_rloop1g_value = data_low
            else
                read_rloop1g_value = (data_low - H8000_0000) and rloop1g_mask
            end If
        else
            read_rloop1g_value = data_low and rloop1g_mask
        end If

    End Sub

    Sub write
        If flag_rloop1g = &H0 Then read
        If flag_rloop1g = &H0 Then write_rloop1g_value = get_rloop1g

        regValue = leftShift((write_rloop1g_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rloop1g_mask = &Hffff
        if data_low > LONG_MAX then
            if rloop1g_mask = mask then
                read_rloop1g_value = data_low
            else
                read_rloop1g_value = (data_low - H8000_0000) and rloop1g_mask
            end If
        else
            read_rloop1g_value = data_low and rloop1g_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_rloop1g_value = &H0
        flag_rloop1g        = &H0
    End Sub
End Class


'' @REGISTER : PCIE3__SGMIIPCIE_X1_gen2ctrl5
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mdio_rloop_pipe                            [15:0]           get_mdio_rloop_pipe
''                                                             set_mdio_rloop_pipe
''                                                             read_mdio_rloop_pipe
''                                                             write_mdio_rloop_pipe
''---------------------------------------------------------------------------------
Class REGISTER_PCIE3__SGMIIPCIE_X1_gen2ctrl5
    Private write_mdio_rloop_pipe_value
    Private read_mdio_rloop_pipe_value
    Private flag_mdio_rloop_pipe

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

    Property Get get_mdio_rloop_pipe
        get_mdio_rloop_pipe = read_mdio_rloop_pipe_value
    End Property

    Property Let set_mdio_rloop_pipe(aData)
        write_mdio_rloop_pipe_value = aData
        flag_mdio_rloop_pipe        = &H1
    End Property

    Property Get read_mdio_rloop_pipe
        read
        read_mdio_rloop_pipe = read_mdio_rloop_pipe_value
    End Property

    Property Let write_mdio_rloop_pipe(aData)
        set_mdio_rloop_pipe = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mdio_rloop_pipe_mask = &Hffff
        if data_low > LONG_MAX then
            if mdio_rloop_pipe_mask = mask then
                read_mdio_rloop_pipe_value = data_low
            else
                read_mdio_rloop_pipe_value = (data_low - H8000_0000) and mdio_rloop_pipe_mask
            end If
        else
            read_mdio_rloop_pipe_value = data_low and mdio_rloop_pipe_mask
        end If

    End Sub

    Sub write
        If flag_mdio_rloop_pipe = &H0 Then read
        If flag_mdio_rloop_pipe = &H0 Then write_mdio_rloop_pipe_value = get_mdio_rloop_pipe

        regValue = leftShift((write_mdio_rloop_pipe_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mdio_rloop_pipe_mask = &Hffff
        if data_low > LONG_MAX then
            if mdio_rloop_pipe_mask = mask then
                read_mdio_rloop_pipe_value = data_low
            else
                read_mdio_rloop_pipe_value = (data_low - H8000_0000) and mdio_rloop_pipe_mask
            end If
        else
            read_mdio_rloop_pipe_value = data_low and mdio_rloop_pipe_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mdio_rloop_pipe_value = &H0
        flag_mdio_rloop_pipe        = &H0
    End Sub
End Class


'' @REGISTER : PCIE3__SGMIIPCIE_X1_gen2ctrl6
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' gen2_ctrl6                                 [15:0]           get_gen2_ctrl6
''                                                             set_gen2_ctrl6
''                                                             read_gen2_ctrl6
''                                                             write_gen2_ctrl6
''---------------------------------------------------------------------------------
Class REGISTER_PCIE3__SGMIIPCIE_X1_gen2ctrl6
    Private write_gen2_ctrl6_value
    Private read_gen2_ctrl6_value
    Private flag_gen2_ctrl6

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

    Property Get get_gen2_ctrl6
        get_gen2_ctrl6 = read_gen2_ctrl6_value
    End Property

    Property Let set_gen2_ctrl6(aData)
        write_gen2_ctrl6_value = aData
        flag_gen2_ctrl6        = &H1
    End Property

    Property Get read_gen2_ctrl6
        read
        read_gen2_ctrl6 = read_gen2_ctrl6_value
    End Property

    Property Let write_gen2_ctrl6(aData)
        set_gen2_ctrl6 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        gen2_ctrl6_mask = &Hffff
        if data_low > LONG_MAX then
            if gen2_ctrl6_mask = mask then
                read_gen2_ctrl6_value = data_low
            else
                read_gen2_ctrl6_value = (data_low - H8000_0000) and gen2_ctrl6_mask
            end If
        else
            read_gen2_ctrl6_value = data_low and gen2_ctrl6_mask
        end If

    End Sub

    Sub write
        If flag_gen2_ctrl6 = &H0 Then read
        If flag_gen2_ctrl6 = &H0 Then write_gen2_ctrl6_value = get_gen2_ctrl6

        regValue = leftShift((write_gen2_ctrl6_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        gen2_ctrl6_mask = &Hffff
        if data_low > LONG_MAX then
            if gen2_ctrl6_mask = mask then
                read_gen2_ctrl6_value = data_low
            else
                read_gen2_ctrl6_value = (data_low - H8000_0000) and gen2_ctrl6_mask
            end If
        else
            read_gen2_ctrl6_value = data_low and gen2_ctrl6_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_gen2_ctrl6_value = &H0
        flag_gen2_ctrl6        = &H0
    End Sub
End Class


'' @REGISTER : PCIE3__SGMIIPCIE_X1_gen2ctrl7
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DisablePmRxFastAcq                         [15:0]           get_DisablePmRxFastAcq
''                                                             set_DisablePmRxFastAcq
''                                                             read_DisablePmRxFastAcq
''                                                             write_DisablePmRxFastAcq
''---------------------------------------------------------------------------------
Class REGISTER_PCIE3__SGMIIPCIE_X1_gen2ctrl7
    Private write_DisablePmRxFastAcq_value
    Private read_DisablePmRxFastAcq_value
    Private flag_DisablePmRxFastAcq

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

    Property Get get_DisablePmRxFastAcq
        get_DisablePmRxFastAcq = read_DisablePmRxFastAcq_value
    End Property

    Property Let set_DisablePmRxFastAcq(aData)
        write_DisablePmRxFastAcq_value = aData
        flag_DisablePmRxFastAcq        = &H1
    End Property

    Property Get read_DisablePmRxFastAcq
        read
        read_DisablePmRxFastAcq = read_DisablePmRxFastAcq_value
    End Property

    Property Let write_DisablePmRxFastAcq(aData)
        set_DisablePmRxFastAcq = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DisablePmRxFastAcq_mask = &Hffff
        if data_low > LONG_MAX then
            if DisablePmRxFastAcq_mask = mask then
                read_DisablePmRxFastAcq_value = data_low
            else
                read_DisablePmRxFastAcq_value = (data_low - H8000_0000) and DisablePmRxFastAcq_mask
            end If
        else
            read_DisablePmRxFastAcq_value = data_low and DisablePmRxFastAcq_mask
        end If

    End Sub

    Sub write
        If flag_DisablePmRxFastAcq = &H0 Then read
        If flag_DisablePmRxFastAcq = &H0 Then write_DisablePmRxFastAcq_value = get_DisablePmRxFastAcq

        regValue = leftShift((write_DisablePmRxFastAcq_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DisablePmRxFastAcq_mask = &Hffff
        if data_low > LONG_MAX then
            if DisablePmRxFastAcq_mask = mask then
                read_DisablePmRxFastAcq_value = data_low
            else
                read_DisablePmRxFastAcq_value = (data_low - H8000_0000) and DisablePmRxFastAcq_mask
            end If
        else
            read_DisablePmRxFastAcq_value = data_low and DisablePmRxFastAcq_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DisablePmRxFastAcq_value = &H0
        flag_DisablePmRxFastAcq        = &H0
    End Sub
End Class


'' @REGISTER : PCIE3__SGMIIPCIE_X1_gen2ctrl8
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mdioRxFastAcqEnable                        [15:0]           get_mdioRxFastAcqEnable
''                                                             set_mdioRxFastAcqEnable
''                                                             read_mdioRxFastAcqEnable
''                                                             write_mdioRxFastAcqEnable
''---------------------------------------------------------------------------------
Class REGISTER_PCIE3__SGMIIPCIE_X1_gen2ctrl8
    Private write_mdioRxFastAcqEnable_value
    Private read_mdioRxFastAcqEnable_value
    Private flag_mdioRxFastAcqEnable

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

    Property Get get_mdioRxFastAcqEnable
        get_mdioRxFastAcqEnable = read_mdioRxFastAcqEnable_value
    End Property

    Property Let set_mdioRxFastAcqEnable(aData)
        write_mdioRxFastAcqEnable_value = aData
        flag_mdioRxFastAcqEnable        = &H1
    End Property

    Property Get read_mdioRxFastAcqEnable
        read
        read_mdioRxFastAcqEnable = read_mdioRxFastAcqEnable_value
    End Property

    Property Let write_mdioRxFastAcqEnable(aData)
        set_mdioRxFastAcqEnable = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mdioRxFastAcqEnable_mask = &Hffff
        if data_low > LONG_MAX then
            if mdioRxFastAcqEnable_mask = mask then
                read_mdioRxFastAcqEnable_value = data_low
            else
                read_mdioRxFastAcqEnable_value = (data_low - H8000_0000) and mdioRxFastAcqEnable_mask
            end If
        else
            read_mdioRxFastAcqEnable_value = data_low and mdioRxFastAcqEnable_mask
        end If

    End Sub

    Sub write
        If flag_mdioRxFastAcqEnable = &H0 Then read
        If flag_mdioRxFastAcqEnable = &H0 Then write_mdioRxFastAcqEnable_value = get_mdioRxFastAcqEnable

        regValue = leftShift((write_mdioRxFastAcqEnable_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mdioRxFastAcqEnable_mask = &Hffff
        if data_low > LONG_MAX then
            if mdioRxFastAcqEnable_mask = mask then
                read_mdioRxFastAcqEnable_value = data_low
            else
                read_mdioRxFastAcqEnable_value = (data_low - H8000_0000) and mdioRxFastAcqEnable_mask
            end If
        else
            read_mdioRxFastAcqEnable_value = data_low and mdioRxFastAcqEnable_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mdioRxFastAcqEnable_value = &H0
        flag_mdioRxFastAcqEnable        = &H0
    End Sub
End Class


'' @REGISTER : PCIE3__SGMIIPCIE_X1_gen2ctrl9
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mdioRxSeqStart                             [15:0]           get_mdioRxSeqStart
''                                                             set_mdioRxSeqStart
''                                                             read_mdioRxSeqStart
''                                                             write_mdioRxSeqStart
''---------------------------------------------------------------------------------
Class REGISTER_PCIE3__SGMIIPCIE_X1_gen2ctrl9
    Private write_mdioRxSeqStart_value
    Private read_mdioRxSeqStart_value
    Private flag_mdioRxSeqStart

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

    Property Get get_mdioRxSeqStart
        get_mdioRxSeqStart = read_mdioRxSeqStart_value
    End Property

    Property Let set_mdioRxSeqStart(aData)
        write_mdioRxSeqStart_value = aData
        flag_mdioRxSeqStart        = &H1
    End Property

    Property Get read_mdioRxSeqStart
        read
        read_mdioRxSeqStart = read_mdioRxSeqStart_value
    End Property

    Property Let write_mdioRxSeqStart(aData)
        set_mdioRxSeqStart = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mdioRxSeqStart_mask = &Hffff
        if data_low > LONG_MAX then
            if mdioRxSeqStart_mask = mask then
                read_mdioRxSeqStart_value = data_low
            else
                read_mdioRxSeqStart_value = (data_low - H8000_0000) and mdioRxSeqStart_mask
            end If
        else
            read_mdioRxSeqStart_value = data_low and mdioRxSeqStart_mask
        end If

    End Sub

    Sub write
        If flag_mdioRxSeqStart = &H0 Then read
        If flag_mdioRxSeqStart = &H0 Then write_mdioRxSeqStart_value = get_mdioRxSeqStart

        regValue = leftShift((write_mdioRxSeqStart_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mdioRxSeqStart_mask = &Hffff
        if data_low > LONG_MAX then
            if mdioRxSeqStart_mask = mask then
                read_mdioRxSeqStart_value = data_low
            else
                read_mdioRxSeqStart_value = (data_low - H8000_0000) and mdioRxSeqStart_mask
            end If
        else
            read_mdioRxSeqStart_value = data_low and mdioRxSeqStart_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mdioRxSeqStart_value = &H0
        flag_mdioRxSeqStart        = &H0
    End Sub
End Class


'' @REGISTER : PCIE3__SGMIIPCIE_X1_gen2ctrl10
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mdio_TxElectIdle_r                         [15:0]           get_mdio_TxElectIdle_r
''                                                             set_mdio_TxElectIdle_r
''                                                             read_mdio_TxElectIdle_r
''                                                             write_mdio_TxElectIdle_r
''---------------------------------------------------------------------------------
Class REGISTER_PCIE3__SGMIIPCIE_X1_gen2ctrl10
    Private write_mdio_TxElectIdle_r_value
    Private read_mdio_TxElectIdle_r_value
    Private flag_mdio_TxElectIdle_r

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

    Property Get get_mdio_TxElectIdle_r
        get_mdio_TxElectIdle_r = read_mdio_TxElectIdle_r_value
    End Property

    Property Let set_mdio_TxElectIdle_r(aData)
        write_mdio_TxElectIdle_r_value = aData
        flag_mdio_TxElectIdle_r        = &H1
    End Property

    Property Get read_mdio_TxElectIdle_r
        read
        read_mdio_TxElectIdle_r = read_mdio_TxElectIdle_r_value
    End Property

    Property Let write_mdio_TxElectIdle_r(aData)
        set_mdio_TxElectIdle_r = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mdio_TxElectIdle_r_mask = &Hffff
        if data_low > LONG_MAX then
            if mdio_TxElectIdle_r_mask = mask then
                read_mdio_TxElectIdle_r_value = data_low
            else
                read_mdio_TxElectIdle_r_value = (data_low - H8000_0000) and mdio_TxElectIdle_r_mask
            end If
        else
            read_mdio_TxElectIdle_r_value = data_low and mdio_TxElectIdle_r_mask
        end If

    End Sub

    Sub write
        If flag_mdio_TxElectIdle_r = &H0 Then read
        If flag_mdio_TxElectIdle_r = &H0 Then write_mdio_TxElectIdle_r_value = get_mdio_TxElectIdle_r

        regValue = leftShift((write_mdio_TxElectIdle_r_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mdio_TxElectIdle_r_mask = &Hffff
        if data_low > LONG_MAX then
            if mdio_TxElectIdle_r_mask = mask then
                read_mdio_TxElectIdle_r_value = data_low
            else
                read_mdio_TxElectIdle_r_value = (data_low - H8000_0000) and mdio_TxElectIdle_r_mask
            end If
        else
            read_mdio_TxElectIdle_r_value = data_low and mdio_TxElectIdle_r_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mdio_TxElectIdle_r_value = &H0
        flag_mdio_TxElectIdle_r        = &H0
    End Sub
End Class


'' @REGISTER : PCIE3__SGMIIPCIE_X1_gen2ctrl11
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mdio_TxComp_r                              [15:0]           get_mdio_TxComp_r
''                                                             set_mdio_TxComp_r
''                                                             read_mdio_TxComp_r
''                                                             write_mdio_TxComp_r
''---------------------------------------------------------------------------------
Class REGISTER_PCIE3__SGMIIPCIE_X1_gen2ctrl11
    Private write_mdio_TxComp_r_value
    Private read_mdio_TxComp_r_value
    Private flag_mdio_TxComp_r

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

    Property Get get_mdio_TxComp_r
        get_mdio_TxComp_r = read_mdio_TxComp_r_value
    End Property

    Property Let set_mdio_TxComp_r(aData)
        write_mdio_TxComp_r_value = aData
        flag_mdio_TxComp_r        = &H1
    End Property

    Property Get read_mdio_TxComp_r
        read
        read_mdio_TxComp_r = read_mdio_TxComp_r_value
    End Property

    Property Let write_mdio_TxComp_r(aData)
        set_mdio_TxComp_r = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mdio_TxComp_r_mask = &Hffff
        if data_low > LONG_MAX then
            if mdio_TxComp_r_mask = mask then
                read_mdio_TxComp_r_value = data_low
            else
                read_mdio_TxComp_r_value = (data_low - H8000_0000) and mdio_TxComp_r_mask
            end If
        else
            read_mdio_TxComp_r_value = data_low and mdio_TxComp_r_mask
        end If

    End Sub

    Sub write
        If flag_mdio_TxComp_r = &H0 Then read
        If flag_mdio_TxComp_r = &H0 Then write_mdio_TxComp_r_value = get_mdio_TxComp_r

        regValue = leftShift((write_mdio_TxComp_r_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mdio_TxComp_r_mask = &Hffff
        if data_low > LONG_MAX then
            if mdio_TxComp_r_mask = mask then
                read_mdio_TxComp_r_value = data_low
            else
                read_mdio_TxComp_r_value = (data_low - H8000_0000) and mdio_TxComp_r_mask
            end If
        else
            read_mdio_TxComp_r_value = data_low and mdio_TxComp_r_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mdio_TxComp_r_value = &H0
        flag_mdio_TxComp_r        = &H0
    End Sub
End Class


'' @REGISTER : PCIE3__SGMIIPCIE_X1_gen2ctrl12
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mdio_PowerDown_0                           [15:0]           get_mdio_PowerDown_0
''                                                             set_mdio_PowerDown_0
''                                                             read_mdio_PowerDown_0
''                                                             write_mdio_PowerDown_0
''---------------------------------------------------------------------------------
Class REGISTER_PCIE3__SGMIIPCIE_X1_gen2ctrl12
    Private write_mdio_PowerDown_0_value
    Private read_mdio_PowerDown_0_value
    Private flag_mdio_PowerDown_0

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

    Property Get get_mdio_PowerDown_0
        get_mdio_PowerDown_0 = read_mdio_PowerDown_0_value
    End Property

    Property Let set_mdio_PowerDown_0(aData)
        write_mdio_PowerDown_0_value = aData
        flag_mdio_PowerDown_0        = &H1
    End Property

    Property Get read_mdio_PowerDown_0
        read
        read_mdio_PowerDown_0 = read_mdio_PowerDown_0_value
    End Property

    Property Let write_mdio_PowerDown_0(aData)
        set_mdio_PowerDown_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mdio_PowerDown_0_mask = &Hffff
        if data_low > LONG_MAX then
            if mdio_PowerDown_0_mask = mask then
                read_mdio_PowerDown_0_value = data_low
            else
                read_mdio_PowerDown_0_value = (data_low - H8000_0000) and mdio_PowerDown_0_mask
            end If
        else
            read_mdio_PowerDown_0_value = data_low and mdio_PowerDown_0_mask
        end If

    End Sub

    Sub write
        If flag_mdio_PowerDown_0 = &H0 Then read
        If flag_mdio_PowerDown_0 = &H0 Then write_mdio_PowerDown_0_value = get_mdio_PowerDown_0

        regValue = leftShift((write_mdio_PowerDown_0_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mdio_PowerDown_0_mask = &Hffff
        if data_low > LONG_MAX then
            if mdio_PowerDown_0_mask = mask then
                read_mdio_PowerDown_0_value = data_low
            else
                read_mdio_PowerDown_0_value = (data_low - H8000_0000) and mdio_PowerDown_0_mask
            end If
        else
            read_mdio_PowerDown_0_value = data_low and mdio_PowerDown_0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mdio_PowerDown_0_value = &H0
        flag_mdio_PowerDown_0        = &H0
    End Sub
End Class


'' @REGISTER : PCIE3__SGMIIPCIE_X1_gen2ctrl13
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mdio_PowerDown_1                           [15:0]           get_mdio_PowerDown_1
''                                                             set_mdio_PowerDown_1
''                                                             read_mdio_PowerDown_1
''                                                             write_mdio_PowerDown_1
''---------------------------------------------------------------------------------
Class REGISTER_PCIE3__SGMIIPCIE_X1_gen2ctrl13
    Private write_mdio_PowerDown_1_value
    Private read_mdio_PowerDown_1_value
    Private flag_mdio_PowerDown_1

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

    Property Get get_mdio_PowerDown_1
        get_mdio_PowerDown_1 = read_mdio_PowerDown_1_value
    End Property

    Property Let set_mdio_PowerDown_1(aData)
        write_mdio_PowerDown_1_value = aData
        flag_mdio_PowerDown_1        = &H1
    End Property

    Property Get read_mdio_PowerDown_1
        read
        read_mdio_PowerDown_1 = read_mdio_PowerDown_1_value
    End Property

    Property Let write_mdio_PowerDown_1(aData)
        set_mdio_PowerDown_1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mdio_PowerDown_1_mask = &Hffff
        if data_low > LONG_MAX then
            if mdio_PowerDown_1_mask = mask then
                read_mdio_PowerDown_1_value = data_low
            else
                read_mdio_PowerDown_1_value = (data_low - H8000_0000) and mdio_PowerDown_1_mask
            end If
        else
            read_mdio_PowerDown_1_value = data_low and mdio_PowerDown_1_mask
        end If

    End Sub

    Sub write
        If flag_mdio_PowerDown_1 = &H0 Then read
        If flag_mdio_PowerDown_1 = &H0 Then write_mdio_PowerDown_1_value = get_mdio_PowerDown_1

        regValue = leftShift((write_mdio_PowerDown_1_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mdio_PowerDown_1_mask = &Hffff
        if data_low > LONG_MAX then
            if mdio_PowerDown_1_mask = mask then
                read_mdio_PowerDown_1_value = data_low
            else
                read_mdio_PowerDown_1_value = (data_low - H8000_0000) and mdio_PowerDown_1_mask
            end If
        else
            read_mdio_PowerDown_1_value = data_low and mdio_PowerDown_1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mdio_PowerDown_1_value = &H0
        flag_mdio_PowerDown_1        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class PCIE3__SGMIIPCIE_X1_INSTANCE

    Public gen2ctrl0
    Public gen2ctrl1
    Public gen2ctrl2
    Public gen2ctrl3
    Public gen2ctrl4
    Public gen2ctrl5
    Public gen2ctrl6
    Public gen2ctrl7
    Public gen2ctrl8
    Public gen2ctrl9
    Public gen2ctrl10
    Public gen2ctrl11
    Public gen2ctrl12
    Public gen2ctrl13


    Public default function Init(aBaseAddr)
        Set gen2ctrl0 = (New REGISTER_PCIE3__SGMIIPCIE_X1_gen2ctrl0)(aBaseAddr, 16)
        Set gen2ctrl1 = (New REGISTER_PCIE3__SGMIIPCIE_X1_gen2ctrl1)(aBaseAddr, 16)
        Set gen2ctrl2 = (New REGISTER_PCIE3__SGMIIPCIE_X1_gen2ctrl2)(aBaseAddr, 16)
        Set gen2ctrl3 = (New REGISTER_PCIE3__SGMIIPCIE_X1_gen2ctrl3)(aBaseAddr, 16)
        Set gen2ctrl4 = (New REGISTER_PCIE3__SGMIIPCIE_X1_gen2ctrl4)(aBaseAddr, 16)
        Set gen2ctrl5 = (New REGISTER_PCIE3__SGMIIPCIE_X1_gen2ctrl5)(aBaseAddr, 16)
        Set gen2ctrl6 = (New REGISTER_PCIE3__SGMIIPCIE_X1_gen2ctrl6)(aBaseAddr, 16)
        Set gen2ctrl7 = (New REGISTER_PCIE3__SGMIIPCIE_X1_gen2ctrl7)(aBaseAddr, 16)
        Set gen2ctrl8 = (New REGISTER_PCIE3__SGMIIPCIE_X1_gen2ctrl8)(aBaseAddr, 16)
        Set gen2ctrl9 = (New REGISTER_PCIE3__SGMIIPCIE_X1_gen2ctrl9)(aBaseAddr, 16)
        Set gen2ctrl10 = (New REGISTER_PCIE3__SGMIIPCIE_X1_gen2ctrl10)(aBaseAddr, 16)
        Set gen2ctrl11 = (New REGISTER_PCIE3__SGMIIPCIE_X1_gen2ctrl11)(aBaseAddr, 16)
        Set gen2ctrl12 = (New REGISTER_PCIE3__SGMIIPCIE_X1_gen2ctrl12)(aBaseAddr, 16)
        Set gen2ctrl13 = (New REGISTER_PCIE3__SGMIIPCIE_X1_gen2ctrl13)(aBaseAddr, 16)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set PCIE3__SGMIIPCIE_X1 = CreateObject("System.Collections.ArrayList")
PCIE3__SGMIIPCIE_X1.Add ((New PCIE3__SGMIIPCIE_X1_INSTANCE)(&H4ade2600))


