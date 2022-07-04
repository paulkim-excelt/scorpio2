

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


'' @REGISTER : XGXSBLK0_SGMIIPLUS2_X2_xgxscontrol
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' start_sequencer                            [13:13]          get_start_sequencer
''                                                             set_start_sequencer
''                                                             read_start_sequencer
''                                                             write_start_sequencer
''---------------------------------------------------------------------------------
'' mode                                       [11:8]           get_mode
''                                                             set_mode
''                                                             read_mode
''                                                             write_mode
''---------------------------------------------------------------------------------
'' hstl                                       [5:5]            get_hstl
''                                                             set_hstl
''                                                             read_hstl
''                                                             write_hstl
''---------------------------------------------------------------------------------
'' mdio_cont_en                               [4:4]            get_mdio_cont_en
''                                                             set_mdio_cont_en
''                                                             read_mdio_cont_en
''                                                             write_mdio_cont_en
''---------------------------------------------------------------------------------
'' cdet_en                                    [3:3]            get_cdet_en
''                                                             set_cdet_en
''                                                             read_cdet_en
''                                                             write_cdet_en
''---------------------------------------------------------------------------------
'' eden                                       [2:2]            get_eden
''                                                             set_eden
''                                                             read_eden
''                                                             write_eden
''---------------------------------------------------------------------------------
'' afrst_en                                   [1:1]            get_afrst_en
''                                                             set_afrst_en
''                                                             read_afrst_en
''                                                             write_afrst_en
''---------------------------------------------------------------------------------
'' txcko_div                                  [0:0]            get_txcko_div
''                                                             set_txcko_div
''                                                             read_txcko_div
''                                                             write_txcko_div
''---------------------------------------------------------------------------------
Class REGISTER_XGXSBLK0_SGMIIPLUS2_X2_xgxscontrol
    Private write_start_sequencer_value
    Private read_start_sequencer_value
    Private flag_start_sequencer
    Private write_mode_value
    Private read_mode_value
    Private flag_mode
    Private write_hstl_value
    Private read_hstl_value
    Private flag_hstl
    Private write_mdio_cont_en_value
    Private read_mdio_cont_en_value
    Private flag_mdio_cont_en
    Private write_cdet_en_value
    Private read_cdet_en_value
    Private flag_cdet_en
    Private write_eden_value
    Private read_eden_value
    Private flag_eden
    Private write_afrst_en_value
    Private read_afrst_en_value
    Private flag_afrst_en
    Private write_txcko_div_value
    Private read_txcko_div_value
    Private flag_txcko_div

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

    Property Get get_start_sequencer
        get_start_sequencer = read_start_sequencer_value
    End Property

    Property Let set_start_sequencer(aData)
        write_start_sequencer_value = aData
        flag_start_sequencer        = &H1
    End Property

    Property Get read_start_sequencer
        read
        read_start_sequencer = read_start_sequencer_value
    End Property

    Property Let write_start_sequencer(aData)
        set_start_sequencer = aData
        write
    End Property

    Property Get get_mode
        get_mode = read_mode_value
    End Property

    Property Let set_mode(aData)
        write_mode_value = aData
        flag_mode        = &H1
    End Property

    Property Get read_mode
        read
        read_mode = read_mode_value
    End Property

    Property Let write_mode(aData)
        set_mode = aData
        write
    End Property

    Property Get get_hstl
        get_hstl = read_hstl_value
    End Property

    Property Let set_hstl(aData)
        write_hstl_value = aData
        flag_hstl        = &H1
    End Property

    Property Get read_hstl
        read
        read_hstl = read_hstl_value
    End Property

    Property Let write_hstl(aData)
        set_hstl = aData
        write
    End Property

    Property Get get_mdio_cont_en
        get_mdio_cont_en = read_mdio_cont_en_value
    End Property

    Property Let set_mdio_cont_en(aData)
        write_mdio_cont_en_value = aData
        flag_mdio_cont_en        = &H1
    End Property

    Property Get read_mdio_cont_en
        read
        read_mdio_cont_en = read_mdio_cont_en_value
    End Property

    Property Let write_mdio_cont_en(aData)
        set_mdio_cont_en = aData
        write
    End Property

    Property Get get_cdet_en
        get_cdet_en = read_cdet_en_value
    End Property

    Property Let set_cdet_en(aData)
        write_cdet_en_value = aData
        flag_cdet_en        = &H1
    End Property

    Property Get read_cdet_en
        read
        read_cdet_en = read_cdet_en_value
    End Property

    Property Let write_cdet_en(aData)
        set_cdet_en = aData
        write
    End Property

    Property Get get_eden
        get_eden = read_eden_value
    End Property

    Property Let set_eden(aData)
        write_eden_value = aData
        flag_eden        = &H1
    End Property

    Property Get read_eden
        read
        read_eden = read_eden_value
    End Property

    Property Let write_eden(aData)
        set_eden = aData
        write
    End Property

    Property Get get_afrst_en
        get_afrst_en = read_afrst_en_value
    End Property

    Property Let set_afrst_en(aData)
        write_afrst_en_value = aData
        flag_afrst_en        = &H1
    End Property

    Property Get read_afrst_en
        read
        read_afrst_en = read_afrst_en_value
    End Property

    Property Let write_afrst_en(aData)
        set_afrst_en = aData
        write
    End Property

    Property Get get_txcko_div
        get_txcko_div = read_txcko_div_value
    End Property

    Property Let set_txcko_div(aData)
        write_txcko_div_value = aData
        flag_txcko_div        = &H1
    End Property

    Property Get read_txcko_div
        read
        read_txcko_div = read_txcko_div_value
    End Property

    Property Let write_txcko_div(aData)
        set_txcko_div = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_start_sequencer_value = rightShift(data_low, 13) and &H1
        read_mode_value = rightShift(data_low, 8) and &Hf
        read_hstl_value = rightShift(data_low, 5) and &H1
        read_mdio_cont_en_value = rightShift(data_low, 4) and &H1
        read_cdet_en_value = rightShift(data_low, 3) and &H1
        read_eden_value = rightShift(data_low, 2) and &H1
        read_afrst_en_value = rightShift(data_low, 1) and &H1
        txcko_div_mask = &H1
        if data_low > LONG_MAX then
            if txcko_div_mask = mask then
                read_txcko_div_value = data_low
            else
                read_txcko_div_value = (data_low - H8000_0000) and txcko_div_mask
            end If
        else
            read_txcko_div_value = data_low and txcko_div_mask
        end If

    End Sub

    Sub write
        If flag_start_sequencer = &H0 or flag_mode = &H0 or flag_hstl = &H0 or flag_mdio_cont_en = &H0 or flag_cdet_en = &H0 or flag_eden = &H0 or flag_afrst_en = &H0 or flag_txcko_div = &H0 Then read
        If flag_start_sequencer = &H0 Then write_start_sequencer_value = get_start_sequencer
        If flag_mode = &H0 Then write_mode_value = get_mode
        If flag_hstl = &H0 Then write_hstl_value = get_hstl
        If flag_mdio_cont_en = &H0 Then write_mdio_cont_en_value = get_mdio_cont_en
        If flag_cdet_en = &H0 Then write_cdet_en_value = get_cdet_en
        If flag_eden = &H0 Then write_eden_value = get_eden
        If flag_afrst_en = &H0 Then write_afrst_en_value = get_afrst_en
        If flag_txcko_div = &H0 Then write_txcko_div_value = get_txcko_div

        regValue = leftShift((write_start_sequencer_value and &H1), 13) + leftShift((write_mode_value and &Hf), 8) + leftShift((write_hstl_value and &H1), 5) + leftShift((write_mdio_cont_en_value and &H1), 4) + leftShift((write_cdet_en_value and &H1), 3) + leftShift((write_eden_value and &H1), 2) + leftShift((write_afrst_en_value and &H1), 1) + leftShift((write_txcko_div_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_start_sequencer_value = rightShift(data_low, 13) and &H1
        read_mode_value = rightShift(data_low, 8) and &Hf
        read_hstl_value = rightShift(data_low, 5) and &H1
        read_mdio_cont_en_value = rightShift(data_low, 4) and &H1
        read_cdet_en_value = rightShift(data_low, 3) and &H1
        read_eden_value = rightShift(data_low, 2) and &H1
        read_afrst_en_value = rightShift(data_low, 1) and &H1
        txcko_div_mask = &H1
        if data_low > LONG_MAX then
            if txcko_div_mask = mask then
                read_txcko_div_value = data_low
            else
                read_txcko_div_value = (data_low - H8000_0000) and txcko_div_mask
            end If
        else
            read_txcko_div_value = data_low and txcko_div_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_start_sequencer_value = &H0
        flag_start_sequencer        = &H0
        write_mode_value = &H0
        flag_mode        = &H0
        write_hstl_value = &H0
        flag_hstl        = &H0
        write_mdio_cont_en_value = &H0
        flag_mdio_cont_en        = &H0
        write_cdet_en_value = &H0
        flag_cdet_en        = &H0
        write_eden_value = &H0
        flag_eden        = &H0
        write_afrst_en_value = &H0
        flag_afrst_en        = &H0
        write_txcko_div_value = &H0
        flag_txcko_div        = &H0
    End Sub
End Class


'' @REGISTER : XGXSBLK0_SGMIIPLUS2_X2_mmdselect
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' multiPRTs_en                               [15:15]          get_multiPRTs_en
''                                                             set_multiPRTs_en
''                                                             read_multiPRTs_en
''                                                             write_multiPRTs_en
''---------------------------------------------------------------------------------
'' multiMMDs_en                               [14:14]          get_multiMMDs_en
''                                                             set_multiMMDs_en
''                                                             read_multiMMDs_en
''                                                             write_multiMMDs_en
''---------------------------------------------------------------------------------
'' prtad_bcst_disable                         [13:13]          get_prtad_bcst_disable
''                                                             set_prtad_bcst_disable
''                                                             read_prtad_bcst_disable
''                                                             write_prtad_bcst_disable
''---------------------------------------------------------------------------------
'' devAN_en                                   [3:3]            get_devAN_en
''                                                             set_devAN_en
''                                                             read_devAN_en
''                                                             write_devAN_en
''---------------------------------------------------------------------------------
'' devPMD_en                                  [2:2]            get_devPMD_en
''                                                             set_devPMD_en
''                                                             read_devPMD_en
''                                                             write_devPMD_en
''---------------------------------------------------------------------------------
'' devDEVAD_en                                [1:1]            get_devDEVAD_en
''                                                             set_devDEVAD_en
''                                                             read_devDEVAD_en
''                                                             write_devDEVAD_en
''---------------------------------------------------------------------------------
'' devCL22_en                                 [0:0]            get_devCL22_en
''                                                             set_devCL22_en
''                                                             read_devCL22_en
''                                                             write_devCL22_en
''---------------------------------------------------------------------------------
Class REGISTER_XGXSBLK0_SGMIIPLUS2_X2_mmdselect
    Private write_multiPRTs_en_value
    Private read_multiPRTs_en_value
    Private flag_multiPRTs_en
    Private write_multiMMDs_en_value
    Private read_multiMMDs_en_value
    Private flag_multiMMDs_en
    Private write_prtad_bcst_disable_value
    Private read_prtad_bcst_disable_value
    Private flag_prtad_bcst_disable
    Private write_devAN_en_value
    Private read_devAN_en_value
    Private flag_devAN_en
    Private write_devPMD_en_value
    Private read_devPMD_en_value
    Private flag_devPMD_en
    Private write_devDEVAD_en_value
    Private read_devDEVAD_en_value
    Private flag_devDEVAD_en
    Private write_devCL22_en_value
    Private read_devCL22_en_value
    Private flag_devCL22_en

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

    Property Get get_multiPRTs_en
        get_multiPRTs_en = read_multiPRTs_en_value
    End Property

    Property Let set_multiPRTs_en(aData)
        write_multiPRTs_en_value = aData
        flag_multiPRTs_en        = &H1
    End Property

    Property Get read_multiPRTs_en
        read
        read_multiPRTs_en = read_multiPRTs_en_value
    End Property

    Property Let write_multiPRTs_en(aData)
        set_multiPRTs_en = aData
        write
    End Property

    Property Get get_multiMMDs_en
        get_multiMMDs_en = read_multiMMDs_en_value
    End Property

    Property Let set_multiMMDs_en(aData)
        write_multiMMDs_en_value = aData
        flag_multiMMDs_en        = &H1
    End Property

    Property Get read_multiMMDs_en
        read
        read_multiMMDs_en = read_multiMMDs_en_value
    End Property

    Property Let write_multiMMDs_en(aData)
        set_multiMMDs_en = aData
        write
    End Property

    Property Get get_prtad_bcst_disable
        get_prtad_bcst_disable = read_prtad_bcst_disable_value
    End Property

    Property Let set_prtad_bcst_disable(aData)
        write_prtad_bcst_disable_value = aData
        flag_prtad_bcst_disable        = &H1
    End Property

    Property Get read_prtad_bcst_disable
        read
        read_prtad_bcst_disable = read_prtad_bcst_disable_value
    End Property

    Property Let write_prtad_bcst_disable(aData)
        set_prtad_bcst_disable = aData
        write
    End Property

    Property Get get_devAN_en
        get_devAN_en = read_devAN_en_value
    End Property

    Property Let set_devAN_en(aData)
        write_devAN_en_value = aData
        flag_devAN_en        = &H1
    End Property

    Property Get read_devAN_en
        read
        read_devAN_en = read_devAN_en_value
    End Property

    Property Let write_devAN_en(aData)
        set_devAN_en = aData
        write
    End Property

    Property Get get_devPMD_en
        get_devPMD_en = read_devPMD_en_value
    End Property

    Property Let set_devPMD_en(aData)
        write_devPMD_en_value = aData
        flag_devPMD_en        = &H1
    End Property

    Property Get read_devPMD_en
        read
        read_devPMD_en = read_devPMD_en_value
    End Property

    Property Let write_devPMD_en(aData)
        set_devPMD_en = aData
        write
    End Property

    Property Get get_devDEVAD_en
        get_devDEVAD_en = read_devDEVAD_en_value
    End Property

    Property Let set_devDEVAD_en(aData)
        write_devDEVAD_en_value = aData
        flag_devDEVAD_en        = &H1
    End Property

    Property Get read_devDEVAD_en
        read
        read_devDEVAD_en = read_devDEVAD_en_value
    End Property

    Property Let write_devDEVAD_en(aData)
        set_devDEVAD_en = aData
        write
    End Property

    Property Get get_devCL22_en
        get_devCL22_en = read_devCL22_en_value
    End Property

    Property Let set_devCL22_en(aData)
        write_devCL22_en_value = aData
        flag_devCL22_en        = &H1
    End Property

    Property Get read_devCL22_en
        read
        read_devCL22_en = read_devCL22_en_value
    End Property

    Property Let write_devCL22_en(aData)
        set_devCL22_en = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_multiPRTs_en_value = rightShift(data_low, 15) and &H1
        read_multiMMDs_en_value = rightShift(data_low, 14) and &H1
        read_prtad_bcst_disable_value = rightShift(data_low, 13) and &H1
        read_devAN_en_value = rightShift(data_low, 3) and &H1
        read_devPMD_en_value = rightShift(data_low, 2) and &H1
        read_devDEVAD_en_value = rightShift(data_low, 1) and &H1
        devCL22_en_mask = &H1
        if data_low > LONG_MAX then
            if devCL22_en_mask = mask then
                read_devCL22_en_value = data_low
            else
                read_devCL22_en_value = (data_low - H8000_0000) and devCL22_en_mask
            end If
        else
            read_devCL22_en_value = data_low and devCL22_en_mask
        end If

    End Sub

    Sub write
        If flag_multiPRTs_en = &H0 or flag_multiMMDs_en = &H0 or flag_prtad_bcst_disable = &H0 or flag_devAN_en = &H0 or flag_devPMD_en = &H0 or flag_devDEVAD_en = &H0 or flag_devCL22_en = &H0 Then read
        If flag_multiPRTs_en = &H0 Then write_multiPRTs_en_value = get_multiPRTs_en
        If flag_multiMMDs_en = &H0 Then write_multiMMDs_en_value = get_multiMMDs_en
        If flag_prtad_bcst_disable = &H0 Then write_prtad_bcst_disable_value = get_prtad_bcst_disable
        If flag_devAN_en = &H0 Then write_devAN_en_value = get_devAN_en
        If flag_devPMD_en = &H0 Then write_devPMD_en_value = get_devPMD_en
        If flag_devDEVAD_en = &H0 Then write_devDEVAD_en_value = get_devDEVAD_en
        If flag_devCL22_en = &H0 Then write_devCL22_en_value = get_devCL22_en

        regValue = leftShift((write_multiPRTs_en_value and &H1), 15) + leftShift((write_multiMMDs_en_value and &H1), 14) + leftShift((write_prtad_bcst_disable_value and &H1), 13) + leftShift((write_devAN_en_value and &H1), 3) + leftShift((write_devPMD_en_value and &H1), 2) + leftShift((write_devDEVAD_en_value and &H1), 1) + leftShift((write_devCL22_en_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_multiPRTs_en_value = rightShift(data_low, 15) and &H1
        read_multiMMDs_en_value = rightShift(data_low, 14) and &H1
        read_prtad_bcst_disable_value = rightShift(data_low, 13) and &H1
        read_devAN_en_value = rightShift(data_low, 3) and &H1
        read_devPMD_en_value = rightShift(data_low, 2) and &H1
        read_devDEVAD_en_value = rightShift(data_low, 1) and &H1
        devCL22_en_mask = &H1
        if data_low > LONG_MAX then
            if devCL22_en_mask = mask then
                read_devCL22_en_value = data_low
            else
                read_devCL22_en_value = (data_low - H8000_0000) and devCL22_en_mask
            end If
        else
            read_devCL22_en_value = data_low and devCL22_en_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_multiPRTs_en_value = &H0
        flag_multiPRTs_en        = &H0
        write_multiMMDs_en_value = &H0
        flag_multiMMDs_en        = &H0
        write_prtad_bcst_disable_value = &H0
        flag_prtad_bcst_disable        = &H0
        write_devAN_en_value = &H0
        flag_devAN_en        = &H0
        write_devPMD_en_value = &H0
        flag_devPMD_en        = &H0
        write_devDEVAD_en_value = &H0
        flag_devDEVAD_en        = &H0
        write_devCL22_en_value = &H0
        flag_devCL22_en        = &H0
    End Sub
End Class


'' @REGISTER : XGXSBLK0_SGMIIPLUS2_X2_misccontrol1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ieee_blksel_autodet                        [1:1]            get_ieee_blksel_autodet
''                                                             set_ieee_blksel_autodet
''                                                             read_ieee_blksel_autodet
''                                                             write_ieee_blksel_autodet
''---------------------------------------------------------------------------------
'' ieee_blksel_val                            [0:0]            get_ieee_blksel_val
''                                                             set_ieee_blksel_val
''                                                             read_ieee_blksel_val
''                                                             write_ieee_blksel_val
''---------------------------------------------------------------------------------
Class REGISTER_XGXSBLK0_SGMIIPLUS2_X2_misccontrol1
    Private write_ieee_blksel_autodet_value
    Private read_ieee_blksel_autodet_value
    Private flag_ieee_blksel_autodet
    Private write_ieee_blksel_val_value
    Private read_ieee_blksel_val_value
    Private flag_ieee_blksel_val

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

    Property Get get_ieee_blksel_autodet
        get_ieee_blksel_autodet = read_ieee_blksel_autodet_value
    End Property

    Property Let set_ieee_blksel_autodet(aData)
        write_ieee_blksel_autodet_value = aData
        flag_ieee_blksel_autodet        = &H1
    End Property

    Property Get read_ieee_blksel_autodet
        read
        read_ieee_blksel_autodet = read_ieee_blksel_autodet_value
    End Property

    Property Let write_ieee_blksel_autodet(aData)
        set_ieee_blksel_autodet = aData
        write
    End Property

    Property Get get_ieee_blksel_val
        get_ieee_blksel_val = read_ieee_blksel_val_value
    End Property

    Property Let set_ieee_blksel_val(aData)
        write_ieee_blksel_val_value = aData
        flag_ieee_blksel_val        = &H1
    End Property

    Property Get read_ieee_blksel_val
        read
        read_ieee_blksel_val = read_ieee_blksel_val_value
    End Property

    Property Let write_ieee_blksel_val(aData)
        set_ieee_blksel_val = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ieee_blksel_autodet_value = rightShift(data_low, 1) and &H1
        ieee_blksel_val_mask = &H1
        if data_low > LONG_MAX then
            if ieee_blksel_val_mask = mask then
                read_ieee_blksel_val_value = data_low
            else
                read_ieee_blksel_val_value = (data_low - H8000_0000) and ieee_blksel_val_mask
            end If
        else
            read_ieee_blksel_val_value = data_low and ieee_blksel_val_mask
        end If

    End Sub

    Sub write
        If flag_ieee_blksel_autodet = &H0 or flag_ieee_blksel_val = &H0 Then read
        If flag_ieee_blksel_autodet = &H0 Then write_ieee_blksel_autodet_value = get_ieee_blksel_autodet
        If flag_ieee_blksel_val = &H0 Then write_ieee_blksel_val_value = get_ieee_blksel_val

        regValue = leftShift((write_ieee_blksel_autodet_value and &H1), 1) + leftShift((write_ieee_blksel_val_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ieee_blksel_autodet_value = rightShift(data_low, 1) and &H1
        ieee_blksel_val_mask = &H1
        if data_low > LONG_MAX then
            if ieee_blksel_val_mask = mask then
                read_ieee_blksel_val_value = data_low
            else
                read_ieee_blksel_val_value = (data_low - H8000_0000) and ieee_blksel_val_mask
            end If
        else
            read_ieee_blksel_val_value = data_low and ieee_blksel_val_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ieee_blksel_autodet_value = &H0
        flag_ieee_blksel_autodet        = &H0
        write_ieee_blksel_val_value = &H0
        flag_ieee_blksel_val        = &H0
    End Sub
End Class


'' @REGISTER : XGXSBLK0_SGMIIPLUS2_X2_blockaddress
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
Class REGISTER_XGXSBLK0_SGMIIPLUS2_X2_blockaddress
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

Class XGXSBLK0_SGMIIPLUS2_X2_INSTANCE

    Public xgxscontrol
    Public mmdselect
    Public misccontrol1
    Public blockaddress


    Public default function Init(aBaseAddr)
        Set xgxscontrol = (New REGISTER_XGXSBLK0_SGMIIPLUS2_X2_xgxscontrol)(aBaseAddr, 16)
        Set mmdselect = (New REGISTER_XGXSBLK0_SGMIIPLUS2_X2_mmdselect)(aBaseAddr, 16)
        Set misccontrol1 = (New REGISTER_XGXSBLK0_SGMIIPLUS2_X2_misccontrol1)(aBaseAddr, 16)
        Set blockaddress = (New REGISTER_XGXSBLK0_SGMIIPLUS2_X2_blockaddress)(aBaseAddr, 16)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set XGXSBLK0_SGMIIPLUS2_X2 = CreateObject("System.Collections.ArrayList")
XGXSBLK0_SGMIIPLUS2_X2.Add ((New XGXSBLK0_SGMIIPLUS2_X2_INSTANCE)(&H4acd0000))


