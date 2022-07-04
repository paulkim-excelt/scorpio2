

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


'' @REGISTER : HSM_MISC_clock_gating_control
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' spu_clk_en                                 [24:24]          get_spu_clk_en
''                                                             set_spu_clk_en
''                                                             read_spu_clk_en
''                                                             write_spu_clk_en
''---------------------------------------------------------------------------------
'' spu_axi_clk_en                             [23:23]          get_spu_axi_clk_en
''                                                             set_spu_axi_clk_en
''                                                             read_spu_axi_clk_en
''                                                             write_spu_axi_clk_en
''---------------------------------------------------------------------------------
'' dma_axi_clk_en                             [22:22]          get_dma_axi_clk_en
''                                                             set_dma_axi_clk_en
''                                                             read_dma_axi_clk_en
''                                                             write_dma_axi_clk_en
''---------------------------------------------------------------------------------
'' sram_clk_en                                [21:21]          get_sram_clk_en
''                                                             set_sram_clk_en
''                                                             read_sram_clk_en
''                                                             write_sram_clk_en
''---------------------------------------------------------------------------------
'' ipc_clk_en                                 [20:20]          get_ipc_clk_en
''                                                             set_ipc_clk_en
''                                                             read_ipc_clk_en
''                                                             write_ipc_clk_en
''---------------------------------------------------------------------------------
'' pka_clk_en                                 [19:19]          get_pka_clk_en
''                                                             set_pka_clk_en
''                                                             read_pka_clk_en
''                                                             write_pka_clk_en
''---------------------------------------------------------------------------------
'' rng_clk_en                                 [18:18]          get_rng_clk_en
''                                                             set_rng_clk_en
''                                                             read_rng_clk_en
''                                                             write_rng_clk_en
''---------------------------------------------------------------------------------
'' otp_clk_en                                 [17:17]          get_otp_clk_en
''                                                             set_otp_clk_en
''                                                             read_otp_clk_en
''                                                             write_otp_clk_en
''---------------------------------------------------------------------------------
'' wdg_clk_en                                 [16:16]          get_wdg_clk_en
''                                                             set_wdg_clk_en
''                                                             read_wdg_clk_en
''                                                             write_wdg_clk_en
''---------------------------------------------------------------------------------
'' timer_ref_clk_sel                          [8:4]            get_timer_ref_clk_sel
''                                                             set_timer_ref_clk_sel
''                                                             read_timer_ref_clk_sel
''                                                             write_timer_ref_clk_sel
''---------------------------------------------------------------------------------
'' timer_clk_en                               [3:0]            get_timer_clk_en
''                                                             set_timer_clk_en
''                                                             read_timer_clk_en
''                                                             write_timer_clk_en
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_clock_gating_control
    Private write_spu_clk_en_value
    Private read_spu_clk_en_value
    Private flag_spu_clk_en
    Private write_spu_axi_clk_en_value
    Private read_spu_axi_clk_en_value
    Private flag_spu_axi_clk_en
    Private write_dma_axi_clk_en_value
    Private read_dma_axi_clk_en_value
    Private flag_dma_axi_clk_en
    Private write_sram_clk_en_value
    Private read_sram_clk_en_value
    Private flag_sram_clk_en
    Private write_ipc_clk_en_value
    Private read_ipc_clk_en_value
    Private flag_ipc_clk_en
    Private write_pka_clk_en_value
    Private read_pka_clk_en_value
    Private flag_pka_clk_en
    Private write_rng_clk_en_value
    Private read_rng_clk_en_value
    Private flag_rng_clk_en
    Private write_otp_clk_en_value
    Private read_otp_clk_en_value
    Private flag_otp_clk_en
    Private write_wdg_clk_en_value
    Private read_wdg_clk_en_value
    Private flag_wdg_clk_en
    Private write_timer_ref_clk_sel_value
    Private read_timer_ref_clk_sel_value
    Private flag_timer_ref_clk_sel
    Private write_timer_clk_en_value
    Private read_timer_clk_en_value
    Private flag_timer_clk_en

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

    Property Get get_spu_clk_en
        get_spu_clk_en = read_spu_clk_en_value
    End Property

    Property Let set_spu_clk_en(aData)
        write_spu_clk_en_value = aData
        flag_spu_clk_en        = &H1
    End Property

    Property Get read_spu_clk_en
        read
        read_spu_clk_en = read_spu_clk_en_value
    End Property

    Property Let write_spu_clk_en(aData)
        set_spu_clk_en = aData
        write
    End Property

    Property Get get_spu_axi_clk_en
        get_spu_axi_clk_en = read_spu_axi_clk_en_value
    End Property

    Property Let set_spu_axi_clk_en(aData)
        write_spu_axi_clk_en_value = aData
        flag_spu_axi_clk_en        = &H1
    End Property

    Property Get read_spu_axi_clk_en
        read
        read_spu_axi_clk_en = read_spu_axi_clk_en_value
    End Property

    Property Let write_spu_axi_clk_en(aData)
        set_spu_axi_clk_en = aData
        write
    End Property

    Property Get get_dma_axi_clk_en
        get_dma_axi_clk_en = read_dma_axi_clk_en_value
    End Property

    Property Let set_dma_axi_clk_en(aData)
        write_dma_axi_clk_en_value = aData
        flag_dma_axi_clk_en        = &H1
    End Property

    Property Get read_dma_axi_clk_en
        read
        read_dma_axi_clk_en = read_dma_axi_clk_en_value
    End Property

    Property Let write_dma_axi_clk_en(aData)
        set_dma_axi_clk_en = aData
        write
    End Property

    Property Get get_sram_clk_en
        get_sram_clk_en = read_sram_clk_en_value
    End Property

    Property Let set_sram_clk_en(aData)
        write_sram_clk_en_value = aData
        flag_sram_clk_en        = &H1
    End Property

    Property Get read_sram_clk_en
        read
        read_sram_clk_en = read_sram_clk_en_value
    End Property

    Property Let write_sram_clk_en(aData)
        set_sram_clk_en = aData
        write
    End Property

    Property Get get_ipc_clk_en
        get_ipc_clk_en = read_ipc_clk_en_value
    End Property

    Property Let set_ipc_clk_en(aData)
        write_ipc_clk_en_value = aData
        flag_ipc_clk_en        = &H1
    End Property

    Property Get read_ipc_clk_en
        read
        read_ipc_clk_en = read_ipc_clk_en_value
    End Property

    Property Let write_ipc_clk_en(aData)
        set_ipc_clk_en = aData
        write
    End Property

    Property Get get_pka_clk_en
        get_pka_clk_en = read_pka_clk_en_value
    End Property

    Property Let set_pka_clk_en(aData)
        write_pka_clk_en_value = aData
        flag_pka_clk_en        = &H1
    End Property

    Property Get read_pka_clk_en
        read
        read_pka_clk_en = read_pka_clk_en_value
    End Property

    Property Let write_pka_clk_en(aData)
        set_pka_clk_en = aData
        write
    End Property

    Property Get get_rng_clk_en
        get_rng_clk_en = read_rng_clk_en_value
    End Property

    Property Let set_rng_clk_en(aData)
        write_rng_clk_en_value = aData
        flag_rng_clk_en        = &H1
    End Property

    Property Get read_rng_clk_en
        read
        read_rng_clk_en = read_rng_clk_en_value
    End Property

    Property Let write_rng_clk_en(aData)
        set_rng_clk_en = aData
        write
    End Property

    Property Get get_otp_clk_en
        get_otp_clk_en = read_otp_clk_en_value
    End Property

    Property Let set_otp_clk_en(aData)
        write_otp_clk_en_value = aData
        flag_otp_clk_en        = &H1
    End Property

    Property Get read_otp_clk_en
        read
        read_otp_clk_en = read_otp_clk_en_value
    End Property

    Property Let write_otp_clk_en(aData)
        set_otp_clk_en = aData
        write
    End Property

    Property Get get_wdg_clk_en
        get_wdg_clk_en = read_wdg_clk_en_value
    End Property

    Property Let set_wdg_clk_en(aData)
        write_wdg_clk_en_value = aData
        flag_wdg_clk_en        = &H1
    End Property

    Property Get read_wdg_clk_en
        read
        read_wdg_clk_en = read_wdg_clk_en_value
    End Property

    Property Let write_wdg_clk_en(aData)
        set_wdg_clk_en = aData
        write
    End Property

    Property Get get_timer_ref_clk_sel
        get_timer_ref_clk_sel = read_timer_ref_clk_sel_value
    End Property

    Property Let set_timer_ref_clk_sel(aData)
        write_timer_ref_clk_sel_value = aData
        flag_timer_ref_clk_sel        = &H1
    End Property

    Property Get read_timer_ref_clk_sel
        read
        read_timer_ref_clk_sel = read_timer_ref_clk_sel_value
    End Property

    Property Let write_timer_ref_clk_sel(aData)
        set_timer_ref_clk_sel = aData
        write
    End Property

    Property Get get_timer_clk_en
        get_timer_clk_en = read_timer_clk_en_value
    End Property

    Property Let set_timer_clk_en(aData)
        write_timer_clk_en_value = aData
        flag_timer_clk_en        = &H1
    End Property

    Property Get read_timer_clk_en
        read
        read_timer_clk_en = read_timer_clk_en_value
    End Property

    Property Let write_timer_clk_en(aData)
        set_timer_clk_en = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_spu_clk_en_value = rightShift(data_low, 24) and &H1
        read_spu_axi_clk_en_value = rightShift(data_low, 23) and &H1
        read_dma_axi_clk_en_value = rightShift(data_low, 22) and &H1
        read_sram_clk_en_value = rightShift(data_low, 21) and &H1
        read_ipc_clk_en_value = rightShift(data_low, 20) and &H1
        read_pka_clk_en_value = rightShift(data_low, 19) and &H1
        read_rng_clk_en_value = rightShift(data_low, 18) and &H1
        read_otp_clk_en_value = rightShift(data_low, 17) and &H1
        read_wdg_clk_en_value = rightShift(data_low, 16) and &H1
        read_timer_ref_clk_sel_value = rightShift(data_low, 4) and &H1f
        timer_clk_en_mask = &Hf
        if data_low > LONG_MAX then
            if timer_clk_en_mask = mask then
                read_timer_clk_en_value = data_low
            else
                read_timer_clk_en_value = (data_low - H8000_0000) and timer_clk_en_mask
            end If
        else
            read_timer_clk_en_value = data_low and timer_clk_en_mask
        end If

    End Sub

    Sub write
        If flag_spu_clk_en = &H0 or flag_spu_axi_clk_en = &H0 or flag_dma_axi_clk_en = &H0 or flag_sram_clk_en = &H0 or flag_ipc_clk_en = &H0 or flag_pka_clk_en = &H0 or flag_rng_clk_en = &H0 or flag_otp_clk_en = &H0 or flag_wdg_clk_en = &H0 or flag_timer_ref_clk_sel = &H0 or flag_timer_clk_en = &H0 Then read
        If flag_spu_clk_en = &H0 Then write_spu_clk_en_value = get_spu_clk_en
        If flag_spu_axi_clk_en = &H0 Then write_spu_axi_clk_en_value = get_spu_axi_clk_en
        If flag_dma_axi_clk_en = &H0 Then write_dma_axi_clk_en_value = get_dma_axi_clk_en
        If flag_sram_clk_en = &H0 Then write_sram_clk_en_value = get_sram_clk_en
        If flag_ipc_clk_en = &H0 Then write_ipc_clk_en_value = get_ipc_clk_en
        If flag_pka_clk_en = &H0 Then write_pka_clk_en_value = get_pka_clk_en
        If flag_rng_clk_en = &H0 Then write_rng_clk_en_value = get_rng_clk_en
        If flag_otp_clk_en = &H0 Then write_otp_clk_en_value = get_otp_clk_en
        If flag_wdg_clk_en = &H0 Then write_wdg_clk_en_value = get_wdg_clk_en
        If flag_timer_ref_clk_sel = &H0 Then write_timer_ref_clk_sel_value = get_timer_ref_clk_sel
        If flag_timer_clk_en = &H0 Then write_timer_clk_en_value = get_timer_clk_en

        regValue = leftShift((write_spu_clk_en_value and &H1), 24) + leftShift((write_spu_axi_clk_en_value and &H1), 23) + leftShift((write_dma_axi_clk_en_value and &H1), 22) + leftShift((write_sram_clk_en_value and &H1), 21) + leftShift((write_ipc_clk_en_value and &H1), 20) + leftShift((write_pka_clk_en_value and &H1), 19) + leftShift((write_rng_clk_en_value and &H1), 18) + leftShift((write_otp_clk_en_value and &H1), 17) + leftShift((write_wdg_clk_en_value and &H1), 16) + leftShift((write_timer_ref_clk_sel_value and &H1f), 4) + leftShift((write_timer_clk_en_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_spu_clk_en_value = rightShift(data_low, 24) and &H1
        read_spu_axi_clk_en_value = rightShift(data_low, 23) and &H1
        read_dma_axi_clk_en_value = rightShift(data_low, 22) and &H1
        read_sram_clk_en_value = rightShift(data_low, 21) and &H1
        read_ipc_clk_en_value = rightShift(data_low, 20) and &H1
        read_pka_clk_en_value = rightShift(data_low, 19) and &H1
        read_rng_clk_en_value = rightShift(data_low, 18) and &H1
        read_otp_clk_en_value = rightShift(data_low, 17) and &H1
        read_wdg_clk_en_value = rightShift(data_low, 16) and &H1
        read_timer_ref_clk_sel_value = rightShift(data_low, 4) and &H1f
        timer_clk_en_mask = &Hf
        if data_low > LONG_MAX then
            if timer_clk_en_mask = mask then
                read_timer_clk_en_value = data_low
            else
                read_timer_clk_en_value = (data_low - H8000_0000) and timer_clk_en_mask
            end If
        else
            read_timer_clk_en_value = data_low and timer_clk_en_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_spu_clk_en_value = &H0
        flag_spu_clk_en        = &H0
        write_spu_axi_clk_en_value = &H0
        flag_spu_axi_clk_en        = &H0
        write_dma_axi_clk_en_value = &H0
        flag_dma_axi_clk_en        = &H0
        write_sram_clk_en_value = &H0
        flag_sram_clk_en        = &H0
        write_ipc_clk_en_value = &H0
        flag_ipc_clk_en        = &H0
        write_pka_clk_en_value = &H0
        flag_pka_clk_en        = &H0
        write_rng_clk_en_value = &H0
        flag_rng_clk_en        = &H0
        write_otp_clk_en_value = &H0
        flag_otp_clk_en        = &H0
        write_wdg_clk_en_value = &H0
        flag_wdg_clk_en        = &H0
        write_timer_ref_clk_sel_value = &H0
        flag_timer_ref_clk_sel        = &H0
        write_timer_clk_en_value = &H0
        flag_timer_clk_en        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_block_reset
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' spu_rst_n                                  [4:4]            get_spu_rst_n
''                                                             set_spu_rst_n
''                                                             read_spu_rst_n
''                                                             write_spu_rst_n
''---------------------------------------------------------------------------------
'' ipc_rst_n                                  [3:3]            get_ipc_rst_n
''                                                             set_ipc_rst_n
''                                                             read_ipc_rst_n
''                                                             write_ipc_rst_n
''---------------------------------------------------------------------------------
'' wdg_rst_n                                  [2:2]            get_wdg_rst_n
''                                                             set_wdg_rst_n
''                                                             read_wdg_rst_n
''                                                             write_wdg_rst_n
''---------------------------------------------------------------------------------
'' timer23_rst_n                              [1:1]            get_timer23_rst_n
''                                                             set_timer23_rst_n
''                                                             read_timer23_rst_n
''                                                             write_timer23_rst_n
''---------------------------------------------------------------------------------
'' timer01_rst_n                              [0:0]            get_timer01_rst_n
''                                                             set_timer01_rst_n
''                                                             read_timer01_rst_n
''                                                             write_timer01_rst_n
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_block_reset
    Private write_spu_rst_n_value
    Private read_spu_rst_n_value
    Private flag_spu_rst_n
    Private write_ipc_rst_n_value
    Private read_ipc_rst_n_value
    Private flag_ipc_rst_n
    Private write_wdg_rst_n_value
    Private read_wdg_rst_n_value
    Private flag_wdg_rst_n
    Private write_timer23_rst_n_value
    Private read_timer23_rst_n_value
    Private flag_timer23_rst_n
    Private write_timer01_rst_n_value
    Private read_timer01_rst_n_value
    Private flag_timer01_rst_n

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

    Property Get get_spu_rst_n
        get_spu_rst_n = read_spu_rst_n_value
    End Property

    Property Let set_spu_rst_n(aData)
        write_spu_rst_n_value = aData
        flag_spu_rst_n        = &H1
    End Property

    Property Get read_spu_rst_n
        read
        read_spu_rst_n = read_spu_rst_n_value
    End Property

    Property Let write_spu_rst_n(aData)
        set_spu_rst_n = aData
        write
    End Property

    Property Get get_ipc_rst_n
        get_ipc_rst_n = read_ipc_rst_n_value
    End Property

    Property Let set_ipc_rst_n(aData)
        write_ipc_rst_n_value = aData
        flag_ipc_rst_n        = &H1
    End Property

    Property Get read_ipc_rst_n
        read
        read_ipc_rst_n = read_ipc_rst_n_value
    End Property

    Property Let write_ipc_rst_n(aData)
        set_ipc_rst_n = aData
        write
    End Property

    Property Get get_wdg_rst_n
        get_wdg_rst_n = read_wdg_rst_n_value
    End Property

    Property Let set_wdg_rst_n(aData)
        write_wdg_rst_n_value = aData
        flag_wdg_rst_n        = &H1
    End Property

    Property Get read_wdg_rst_n
        read
        read_wdg_rst_n = read_wdg_rst_n_value
    End Property

    Property Let write_wdg_rst_n(aData)
        set_wdg_rst_n = aData
        write
    End Property

    Property Get get_timer23_rst_n
        get_timer23_rst_n = read_timer23_rst_n_value
    End Property

    Property Let set_timer23_rst_n(aData)
        write_timer23_rst_n_value = aData
        flag_timer23_rst_n        = &H1
    End Property

    Property Get read_timer23_rst_n
        read
        read_timer23_rst_n = read_timer23_rst_n_value
    End Property

    Property Let write_timer23_rst_n(aData)
        set_timer23_rst_n = aData
        write
    End Property

    Property Get get_timer01_rst_n
        get_timer01_rst_n = read_timer01_rst_n_value
    End Property

    Property Let set_timer01_rst_n(aData)
        write_timer01_rst_n_value = aData
        flag_timer01_rst_n        = &H1
    End Property

    Property Get read_timer01_rst_n
        read
        read_timer01_rst_n = read_timer01_rst_n_value
    End Property

    Property Let write_timer01_rst_n(aData)
        set_timer01_rst_n = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_spu_rst_n_value = rightShift(data_low, 4) and &H1
        read_ipc_rst_n_value = rightShift(data_low, 3) and &H1
        read_wdg_rst_n_value = rightShift(data_low, 2) and &H1
        read_timer23_rst_n_value = rightShift(data_low, 1) and &H1
        timer01_rst_n_mask = &H1
        if data_low > LONG_MAX then
            if timer01_rst_n_mask = mask then
                read_timer01_rst_n_value = data_low
            else
                read_timer01_rst_n_value = (data_low - H8000_0000) and timer01_rst_n_mask
            end If
        else
            read_timer01_rst_n_value = data_low and timer01_rst_n_mask
        end If

    End Sub

    Sub write
        If flag_spu_rst_n = &H0 or flag_ipc_rst_n = &H0 or flag_wdg_rst_n = &H0 or flag_timer23_rst_n = &H0 or flag_timer01_rst_n = &H0 Then read
        If flag_spu_rst_n = &H0 Then write_spu_rst_n_value = get_spu_rst_n
        If flag_ipc_rst_n = &H0 Then write_ipc_rst_n_value = get_ipc_rst_n
        If flag_wdg_rst_n = &H0 Then write_wdg_rst_n_value = get_wdg_rst_n
        If flag_timer23_rst_n = &H0 Then write_timer23_rst_n_value = get_timer23_rst_n
        If flag_timer01_rst_n = &H0 Then write_timer01_rst_n_value = get_timer01_rst_n

        regValue = leftShift((write_spu_rst_n_value and &H1), 4) + leftShift((write_ipc_rst_n_value and &H1), 3) + leftShift((write_wdg_rst_n_value and &H1), 2) + leftShift((write_timer23_rst_n_value and &H1), 1) + leftShift((write_timer01_rst_n_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_spu_rst_n_value = rightShift(data_low, 4) and &H1
        read_ipc_rst_n_value = rightShift(data_low, 3) and &H1
        read_wdg_rst_n_value = rightShift(data_low, 2) and &H1
        read_timer23_rst_n_value = rightShift(data_low, 1) and &H1
        timer01_rst_n_mask = &H1
        if data_low > LONG_MAX then
            if timer01_rst_n_mask = mask then
                read_timer01_rst_n_value = data_low
            else
                read_timer01_rst_n_value = (data_low - H8000_0000) and timer01_rst_n_mask
            end If
        else
            read_timer01_rst_n_value = data_low and timer01_rst_n_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_spu_rst_n_value = &H0
        flag_spu_rst_n        = &H0
        write_ipc_rst_n_value = &H0
        flag_ipc_rst_n        = &H0
        write_wdg_rst_n_value = &H0
        flag_wdg_rst_n        = &H0
        write_timer23_rst_n_value = &H0
        flag_timer23_rst_n        = &H0
        write_timer01_rst_n_value = &H0
        flag_timer01_rst_n        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_proc_mem_tm
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' imem_tm                                    [25:19]          get_imem_tm
''                                                             set_imem_tm
''                                                             read_imem_tm
''                                                             write_imem_tm
''---------------------------------------------------------------------------------
'' dmem_tm                                    [15:9]           get_dmem_tm
''                                                             set_dmem_tm
''                                                             read_dmem_tm
''                                                             write_dmem_tm
''---------------------------------------------------------------------------------
'' bootrom_tm                                 [6:0]            get_bootrom_tm
''                                                             set_bootrom_tm
''                                                             read_bootrom_tm
''                                                             write_bootrom_tm
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_proc_mem_tm
    Private write_imem_tm_value
    Private read_imem_tm_value
    Private flag_imem_tm
    Private write_dmem_tm_value
    Private read_dmem_tm_value
    Private flag_dmem_tm
    Private write_bootrom_tm_value
    Private read_bootrom_tm_value
    Private flag_bootrom_tm

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

    Property Get get_imem_tm
        get_imem_tm = read_imem_tm_value
    End Property

    Property Let set_imem_tm(aData)
        write_imem_tm_value = aData
        flag_imem_tm        = &H1
    End Property

    Property Get read_imem_tm
        read
        read_imem_tm = read_imem_tm_value
    End Property

    Property Let write_imem_tm(aData)
        set_imem_tm = aData
        write
    End Property

    Property Get get_dmem_tm
        get_dmem_tm = read_dmem_tm_value
    End Property

    Property Let set_dmem_tm(aData)
        write_dmem_tm_value = aData
        flag_dmem_tm        = &H1
    End Property

    Property Get read_dmem_tm
        read
        read_dmem_tm = read_dmem_tm_value
    End Property

    Property Let write_dmem_tm(aData)
        set_dmem_tm = aData
        write
    End Property

    Property Get get_bootrom_tm
        get_bootrom_tm = read_bootrom_tm_value
    End Property

    Property Let set_bootrom_tm(aData)
        write_bootrom_tm_value = aData
        flag_bootrom_tm        = &H1
    End Property

    Property Get read_bootrom_tm
        read
        read_bootrom_tm = read_bootrom_tm_value
    End Property

    Property Let write_bootrom_tm(aData)
        set_bootrom_tm = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_imem_tm_value = rightShift(data_low, 19) and &H7f
        read_dmem_tm_value = rightShift(data_low, 9) and &H7f
        bootrom_tm_mask = &H7f
        if data_low > LONG_MAX then
            if bootrom_tm_mask = mask then
                read_bootrom_tm_value = data_low
            else
                read_bootrom_tm_value = (data_low - H8000_0000) and bootrom_tm_mask
            end If
        else
            read_bootrom_tm_value = data_low and bootrom_tm_mask
        end If

    End Sub

    Sub write
        If flag_imem_tm = &H0 or flag_dmem_tm = &H0 or flag_bootrom_tm = &H0 Then read
        If flag_imem_tm = &H0 Then write_imem_tm_value = get_imem_tm
        If flag_dmem_tm = &H0 Then write_dmem_tm_value = get_dmem_tm
        If flag_bootrom_tm = &H0 Then write_bootrom_tm_value = get_bootrom_tm

        regValue = leftShift((write_imem_tm_value and &H7f), 19) + leftShift((write_dmem_tm_value and &H7f), 9) + leftShift((write_bootrom_tm_value and &H7f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_imem_tm_value = rightShift(data_low, 19) and &H7f
        read_dmem_tm_value = rightShift(data_low, 9) and &H7f
        bootrom_tm_mask = &H7f
        if data_low > LONG_MAX then
            if bootrom_tm_mask = mask then
                read_bootrom_tm_value = data_low
            else
                read_bootrom_tm_value = (data_low - H8000_0000) and bootrom_tm_mask
            end If
        else
            read_bootrom_tm_value = data_low and bootrom_tm_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_imem_tm_value = &H0
        flag_imem_tm        = &H0
        write_dmem_tm_value = &H0
        flag_dmem_tm        = &H0
        write_bootrom_tm_value = &H0
        flag_bootrom_tm        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_misc_mem_tm1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' pka_srm_tm                                 [29:22]          get_pka_srm_tm
''                                                             set_pka_srm_tm
''                                                             read_pka_srm_tm
''                                                             write_pka_srm_tm
''---------------------------------------------------------------------------------
'' sram_tm                                    [17:10]          get_sram_tm
''                                                             set_sram_tm
''                                                             read_sram_tm
''                                                             write_sram_tm
''---------------------------------------------------------------------------------
'' spum_rf_tm                                 [9:0]            get_spum_rf_tm
''                                                             set_spum_rf_tm
''                                                             read_spum_rf_tm
''                                                             write_spum_rf_tm
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_misc_mem_tm1
    Private write_pka_srm_tm_value
    Private read_pka_srm_tm_value
    Private flag_pka_srm_tm
    Private write_sram_tm_value
    Private read_sram_tm_value
    Private flag_sram_tm
    Private write_spum_rf_tm_value
    Private read_spum_rf_tm_value
    Private flag_spum_rf_tm

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

    Property Get get_pka_srm_tm
        get_pka_srm_tm = read_pka_srm_tm_value
    End Property

    Property Let set_pka_srm_tm(aData)
        write_pka_srm_tm_value = aData
        flag_pka_srm_tm        = &H1
    End Property

    Property Get read_pka_srm_tm
        read
        read_pka_srm_tm = read_pka_srm_tm_value
    End Property

    Property Let write_pka_srm_tm(aData)
        set_pka_srm_tm = aData
        write
    End Property

    Property Get get_sram_tm
        get_sram_tm = read_sram_tm_value
    End Property

    Property Let set_sram_tm(aData)
        write_sram_tm_value = aData
        flag_sram_tm        = &H1
    End Property

    Property Get read_sram_tm
        read
        read_sram_tm = read_sram_tm_value
    End Property

    Property Let write_sram_tm(aData)
        set_sram_tm = aData
        write
    End Property

    Property Get get_spum_rf_tm
        get_spum_rf_tm = read_spum_rf_tm_value
    End Property

    Property Let set_spum_rf_tm(aData)
        write_spum_rf_tm_value = aData
        flag_spum_rf_tm        = &H1
    End Property

    Property Get read_spum_rf_tm
        read
        read_spum_rf_tm = read_spum_rf_tm_value
    End Property

    Property Let write_spum_rf_tm(aData)
        set_spum_rf_tm = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_pka_srm_tm_value = rightShift(data_low, 22) and &Hff
        read_sram_tm_value = rightShift(data_low, 10) and &Hff
        spum_rf_tm_mask = &H3ff
        if data_low > LONG_MAX then
            if spum_rf_tm_mask = mask then
                read_spum_rf_tm_value = data_low
            else
                read_spum_rf_tm_value = (data_low - H8000_0000) and spum_rf_tm_mask
            end If
        else
            read_spum_rf_tm_value = data_low and spum_rf_tm_mask
        end If

    End Sub

    Sub write
        If flag_pka_srm_tm = &H0 or flag_sram_tm = &H0 or flag_spum_rf_tm = &H0 Then read
        If flag_pka_srm_tm = &H0 Then write_pka_srm_tm_value = get_pka_srm_tm
        If flag_sram_tm = &H0 Then write_sram_tm_value = get_sram_tm
        If flag_spum_rf_tm = &H0 Then write_spum_rf_tm_value = get_spum_rf_tm

        regValue = leftShift((write_pka_srm_tm_value and &Hff), 22) + leftShift((write_sram_tm_value and &Hff), 10) + leftShift((write_spum_rf_tm_value and &H3ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_pka_srm_tm_value = rightShift(data_low, 22) and &Hff
        read_sram_tm_value = rightShift(data_low, 10) and &Hff
        spum_rf_tm_mask = &H3ff
        if data_low > LONG_MAX then
            if spum_rf_tm_mask = mask then
                read_spum_rf_tm_value = data_low
            else
                read_spum_rf_tm_value = (data_low - H8000_0000) and spum_rf_tm_mask
            end If
        else
            read_spum_rf_tm_value = data_low and spum_rf_tm_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_pka_srm_tm_value = &H0
        flag_pka_srm_tm        = &H0
        write_sram_tm_value = &H0
        flag_sram_tm        = &H0
        write_spum_rf_tm_value = &H0
        flag_spum_rf_tm        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_misc_mem_tm2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' spum_sp_tm                                 [25:12]          get_spum_sp_tm
''                                                             set_spum_sp_tm
''                                                             read_spum_sp_tm
''                                                             write_spum_sp_tm
''---------------------------------------------------------------------------------
'' spum_srf_tm                                [11:0]           get_spum_srf_tm
''                                                             set_spum_srf_tm
''                                                             read_spum_srf_tm
''                                                             write_spum_srf_tm
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_misc_mem_tm2
    Private write_spum_sp_tm_value
    Private read_spum_sp_tm_value
    Private flag_spum_sp_tm
    Private write_spum_srf_tm_value
    Private read_spum_srf_tm_value
    Private flag_spum_srf_tm

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

    Property Get get_spum_sp_tm
        get_spum_sp_tm = read_spum_sp_tm_value
    End Property

    Property Let set_spum_sp_tm(aData)
        write_spum_sp_tm_value = aData
        flag_spum_sp_tm        = &H1
    End Property

    Property Get read_spum_sp_tm
        read
        read_spum_sp_tm = read_spum_sp_tm_value
    End Property

    Property Let write_spum_sp_tm(aData)
        set_spum_sp_tm = aData
        write
    End Property

    Property Get get_spum_srf_tm
        get_spum_srf_tm = read_spum_srf_tm_value
    End Property

    Property Let set_spum_srf_tm(aData)
        write_spum_srf_tm_value = aData
        flag_spum_srf_tm        = &H1
    End Property

    Property Get read_spum_srf_tm
        read
        read_spum_srf_tm = read_spum_srf_tm_value
    End Property

    Property Let write_spum_srf_tm(aData)
        set_spum_srf_tm = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_spum_sp_tm_value = rightShift(data_low, 12) and &H3fff
        spum_srf_tm_mask = &Hfff
        if data_low > LONG_MAX then
            if spum_srf_tm_mask = mask then
                read_spum_srf_tm_value = data_low
            else
                read_spum_srf_tm_value = (data_low - H8000_0000) and spum_srf_tm_mask
            end If
        else
            read_spum_srf_tm_value = data_low and spum_srf_tm_mask
        end If

    End Sub

    Sub write
        If flag_spum_sp_tm = &H0 or flag_spum_srf_tm = &H0 Then read
        If flag_spum_sp_tm = &H0 Then write_spum_sp_tm_value = get_spum_sp_tm
        If flag_spum_srf_tm = &H0 Then write_spum_srf_tm_value = get_spum_srf_tm

        regValue = leftShift((write_spum_sp_tm_value and &H3fff), 12) + leftShift((write_spum_srf_tm_value and &Hfff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_spum_sp_tm_value = rightShift(data_low, 12) and &H3fff
        spum_srf_tm_mask = &Hfff
        if data_low > LONG_MAX then
            if spum_srf_tm_mask = mask then
                read_spum_srf_tm_value = data_low
            else
                read_spum_srf_tm_value = (data_low - H8000_0000) and spum_srf_tm_mask
            end If
        else
            read_spum_srf_tm_value = data_low and spum_srf_tm_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_spum_sp_tm_value = &H0
        flag_spum_sp_tm        = &H0
        write_spum_srf_tm_value = &H0
        flag_spum_srf_tm        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_misc_mem_ctrl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' pka_srf_stby                               [6:6]            get_pka_srf_stby
''                                                             set_pka_srf_stby
''                                                             read_pka_srf_stby
''                                                             write_pka_srf_stby
''---------------------------------------------------------------------------------
'' spum_srf_stby                              [5:5]            get_spum_srf_stby
''                                                             set_spum_srf_stby
''                                                             read_spum_srf_stby
''                                                             write_spum_srf_stby
''---------------------------------------------------------------------------------
'' spum_sp_stby                               [4:3]            get_spum_sp_stby
''                                                             set_spum_sp_stby
''                                                             read_spum_sp_stby
''                                                             write_spum_sp_stby
''---------------------------------------------------------------------------------
'' spum_rf_stby                               [2:2]            get_spum_rf_stby
''                                                             set_spum_rf_stby
''                                                             read_spum_rf_stby
''                                                             write_spum_rf_stby
''---------------------------------------------------------------------------------
'' mem_stby                                   [1:1]            get_mem_stby
''                                                             set_mem_stby
''                                                             read_mem_stby
''                                                             write_mem_stby
''---------------------------------------------------------------------------------
'' mem_lvm                                    [0:0]            get_mem_lvm
''                                                             set_mem_lvm
''                                                             read_mem_lvm
''                                                             write_mem_lvm
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_misc_mem_ctrl
    Private write_pka_srf_stby_value
    Private read_pka_srf_stby_value
    Private flag_pka_srf_stby
    Private write_spum_srf_stby_value
    Private read_spum_srf_stby_value
    Private flag_spum_srf_stby
    Private write_spum_sp_stby_value
    Private read_spum_sp_stby_value
    Private flag_spum_sp_stby
    Private write_spum_rf_stby_value
    Private read_spum_rf_stby_value
    Private flag_spum_rf_stby
    Private write_mem_stby_value
    Private read_mem_stby_value
    Private flag_mem_stby
    Private write_mem_lvm_value
    Private read_mem_lvm_value
    Private flag_mem_lvm

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

    Property Get get_pka_srf_stby
        get_pka_srf_stby = read_pka_srf_stby_value
    End Property

    Property Let set_pka_srf_stby(aData)
        write_pka_srf_stby_value = aData
        flag_pka_srf_stby        = &H1
    End Property

    Property Get read_pka_srf_stby
        read
        read_pka_srf_stby = read_pka_srf_stby_value
    End Property

    Property Let write_pka_srf_stby(aData)
        set_pka_srf_stby = aData
        write
    End Property

    Property Get get_spum_srf_stby
        get_spum_srf_stby = read_spum_srf_stby_value
    End Property

    Property Let set_spum_srf_stby(aData)
        write_spum_srf_stby_value = aData
        flag_spum_srf_stby        = &H1
    End Property

    Property Get read_spum_srf_stby
        read
        read_spum_srf_stby = read_spum_srf_stby_value
    End Property

    Property Let write_spum_srf_stby(aData)
        set_spum_srf_stby = aData
        write
    End Property

    Property Get get_spum_sp_stby
        get_spum_sp_stby = read_spum_sp_stby_value
    End Property

    Property Let set_spum_sp_stby(aData)
        write_spum_sp_stby_value = aData
        flag_spum_sp_stby        = &H1
    End Property

    Property Get read_spum_sp_stby
        read
        read_spum_sp_stby = read_spum_sp_stby_value
    End Property

    Property Let write_spum_sp_stby(aData)
        set_spum_sp_stby = aData
        write
    End Property

    Property Get get_spum_rf_stby
        get_spum_rf_stby = read_spum_rf_stby_value
    End Property

    Property Let set_spum_rf_stby(aData)
        write_spum_rf_stby_value = aData
        flag_spum_rf_stby        = &H1
    End Property

    Property Get read_spum_rf_stby
        read
        read_spum_rf_stby = read_spum_rf_stby_value
    End Property

    Property Let write_spum_rf_stby(aData)
        set_spum_rf_stby = aData
        write
    End Property

    Property Get get_mem_stby
        get_mem_stby = read_mem_stby_value
    End Property

    Property Let set_mem_stby(aData)
        write_mem_stby_value = aData
        flag_mem_stby        = &H1
    End Property

    Property Get read_mem_stby
        read
        read_mem_stby = read_mem_stby_value
    End Property

    Property Let write_mem_stby(aData)
        set_mem_stby = aData
        write
    End Property

    Property Get get_mem_lvm
        get_mem_lvm = read_mem_lvm_value
    End Property

    Property Let set_mem_lvm(aData)
        write_mem_lvm_value = aData
        flag_mem_lvm        = &H1
    End Property

    Property Get read_mem_lvm
        read
        read_mem_lvm = read_mem_lvm_value
    End Property

    Property Let write_mem_lvm(aData)
        set_mem_lvm = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_pka_srf_stby_value = rightShift(data_low, 6) and &H1
        read_spum_srf_stby_value = rightShift(data_low, 5) and &H1
        read_spum_sp_stby_value = rightShift(data_low, 3) and &H3
        read_spum_rf_stby_value = rightShift(data_low, 2) and &H1
        read_mem_stby_value = rightShift(data_low, 1) and &H1
        mem_lvm_mask = &H1
        if data_low > LONG_MAX then
            if mem_lvm_mask = mask then
                read_mem_lvm_value = data_low
            else
                read_mem_lvm_value = (data_low - H8000_0000) and mem_lvm_mask
            end If
        else
            read_mem_lvm_value = data_low and mem_lvm_mask
        end If

    End Sub

    Sub write
        If flag_pka_srf_stby = &H0 or flag_spum_srf_stby = &H0 or flag_spum_sp_stby = &H0 or flag_spum_rf_stby = &H0 or flag_mem_stby = &H0 or flag_mem_lvm = &H0 Then read
        If flag_pka_srf_stby = &H0 Then write_pka_srf_stby_value = get_pka_srf_stby
        If flag_spum_srf_stby = &H0 Then write_spum_srf_stby_value = get_spum_srf_stby
        If flag_spum_sp_stby = &H0 Then write_spum_sp_stby_value = get_spum_sp_stby
        If flag_spum_rf_stby = &H0 Then write_spum_rf_stby_value = get_spum_rf_stby
        If flag_mem_stby = &H0 Then write_mem_stby_value = get_mem_stby
        If flag_mem_lvm = &H0 Then write_mem_lvm_value = get_mem_lvm

        regValue = leftShift((write_pka_srf_stby_value and &H1), 6) + leftShift((write_spum_srf_stby_value and &H1), 5) + leftShift((write_spum_sp_stby_value and &H3), 3) + leftShift((write_spum_rf_stby_value and &H1), 2) + leftShift((write_mem_stby_value and &H1), 1) + leftShift((write_mem_lvm_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_pka_srf_stby_value = rightShift(data_low, 6) and &H1
        read_spum_srf_stby_value = rightShift(data_low, 5) and &H1
        read_spum_sp_stby_value = rightShift(data_low, 3) and &H3
        read_spum_rf_stby_value = rightShift(data_low, 2) and &H1
        read_mem_stby_value = rightShift(data_low, 1) and &H1
        mem_lvm_mask = &H1
        if data_low > LONG_MAX then
            if mem_lvm_mask = mask then
                read_mem_lvm_value = data_low
            else
                read_mem_lvm_value = (data_low - H8000_0000) and mem_lvm_mask
            end If
        else
            read_mem_lvm_value = data_low and mem_lvm_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_pka_srf_stby_value = &H0
        flag_pka_srf_stby        = &H0
        write_spum_srf_stby_value = &H0
        flag_spum_srf_stby        = &H0
        write_spum_sp_stby_value = &H0
        flag_spum_sp_stby        = &H0
        write_spum_rf_stby_value = &H0
        flag_spum_rf_stby        = &H0
        write_mem_stby_value = &H0
        flag_mem_stby        = &H0
        write_mem_lvm_value = &H0
        flag_mem_lvm        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_spum_misc_cfg_reg
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' spum_iddq_en                               [2:2]            get_spum_iddq_en
''                                                             set_spum_iddq_en
''                                                             read_spum_iddq_en
''                                                             write_spum_iddq_en
''---------------------------------------------------------------------------------
'' spum_export_mode                           [1:1]            get_spum_export_mode
''                                                             set_spum_export_mode
''                                                             read_spum_export_mode
''                                                             write_spum_export_mode
''---------------------------------------------------------------------------------
'' is_spum_secure                             [0:0]            get_is_spum_secure
''                                                             set_is_spum_secure
''                                                             read_is_spum_secure
''                                                             write_is_spum_secure
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_spum_misc_cfg_reg
    Private write_spum_iddq_en_value
    Private read_spum_iddq_en_value
    Private flag_spum_iddq_en
    Private write_spum_export_mode_value
    Private read_spum_export_mode_value
    Private flag_spum_export_mode
    Private write_is_spum_secure_value
    Private read_is_spum_secure_value
    Private flag_is_spum_secure

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

    Property Get get_spum_iddq_en
        get_spum_iddq_en = read_spum_iddq_en_value
    End Property

    Property Let set_spum_iddq_en(aData)
        write_spum_iddq_en_value = aData
        flag_spum_iddq_en        = &H1
    End Property

    Property Get read_spum_iddq_en
        read
        read_spum_iddq_en = read_spum_iddq_en_value
    End Property

    Property Let write_spum_iddq_en(aData)
        set_spum_iddq_en = aData
        write
    End Property

    Property Get get_spum_export_mode
        get_spum_export_mode = read_spum_export_mode_value
    End Property

    Property Let set_spum_export_mode(aData)
        write_spum_export_mode_value = aData
        flag_spum_export_mode        = &H1
    End Property

    Property Get read_spum_export_mode
        read
        read_spum_export_mode = read_spum_export_mode_value
    End Property

    Property Let write_spum_export_mode(aData)
        set_spum_export_mode = aData
        write
    End Property

    Property Get get_is_spum_secure
        get_is_spum_secure = read_is_spum_secure_value
    End Property

    Property Let set_is_spum_secure(aData)
        write_is_spum_secure_value = aData
        flag_is_spum_secure        = &H1
    End Property

    Property Get read_is_spum_secure
        read
        read_is_spum_secure = read_is_spum_secure_value
    End Property

    Property Let write_is_spum_secure(aData)
        set_is_spum_secure = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_spum_iddq_en_value = rightShift(data_low, 2) and &H1
        read_spum_export_mode_value = rightShift(data_low, 1) and &H1
        is_spum_secure_mask = &H1
        if data_low > LONG_MAX then
            if is_spum_secure_mask = mask then
                read_is_spum_secure_value = data_low
            else
                read_is_spum_secure_value = (data_low - H8000_0000) and is_spum_secure_mask
            end If
        else
            read_is_spum_secure_value = data_low and is_spum_secure_mask
        end If

    End Sub

    Sub write
        If flag_spum_iddq_en = &H0 or flag_spum_export_mode = &H0 or flag_is_spum_secure = &H0 Then read
        If flag_spum_iddq_en = &H0 Then write_spum_iddq_en_value = get_spum_iddq_en
        If flag_spum_export_mode = &H0 Then write_spum_export_mode_value = get_spum_export_mode
        If flag_is_spum_secure = &H0 Then write_is_spum_secure_value = get_is_spum_secure

        regValue = leftShift((write_spum_iddq_en_value and &H1), 2) + leftShift((write_spum_export_mode_value and &H1), 1) + leftShift((write_is_spum_secure_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_spum_iddq_en_value = rightShift(data_low, 2) and &H1
        read_spum_export_mode_value = rightShift(data_low, 1) and &H1
        is_spum_secure_mask = &H1
        if data_low > LONG_MAX then
            if is_spum_secure_mask = mask then
                read_is_spum_secure_value = data_low
            else
                read_is_spum_secure_value = (data_low - H8000_0000) and is_spum_secure_mask
            end If
        else
            read_is_spum_secure_value = data_low and is_spum_secure_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_spum_iddq_en_value = &H0
        flag_spum_iddq_en        = &H0
        write_spum_export_mode_value = &H0
        flag_spum_export_mode        = &H0
        write_is_spum_secure_value = &H0
        flag_is_spum_secure        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_rng_misc_cfg_reg
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' rng_iddq_en                                [0:0]            get_rng_iddq_en
''                                                             set_rng_iddq_en
''                                                             read_rng_iddq_en
''                                                             write_rng_iddq_en
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_rng_misc_cfg_reg
    Private write_rng_iddq_en_value
    Private read_rng_iddq_en_value
    Private flag_rng_iddq_en

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

    Property Get get_rng_iddq_en
        get_rng_iddq_en = read_rng_iddq_en_value
    End Property

    Property Let set_rng_iddq_en(aData)
        write_rng_iddq_en_value = aData
        flag_rng_iddq_en        = &H1
    End Property

    Property Get read_rng_iddq_en
        read
        read_rng_iddq_en = read_rng_iddq_en_value
    End Property

    Property Let write_rng_iddq_en(aData)
        set_rng_iddq_en = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rng_iddq_en_mask = &H1
        if data_low > LONG_MAX then
            if rng_iddq_en_mask = mask then
                read_rng_iddq_en_value = data_low
            else
                read_rng_iddq_en_value = (data_low - H8000_0000) and rng_iddq_en_mask
            end If
        else
            read_rng_iddq_en_value = data_low and rng_iddq_en_mask
        end If

    End Sub

    Sub write
        If flag_rng_iddq_en = &H0 Then read
        If flag_rng_iddq_en = &H0 Then write_rng_iddq_en_value = get_rng_iddq_en

        regValue = leftShift((write_rng_iddq_en_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rng_iddq_en_mask = &H1
        if data_low > LONG_MAX then
            if rng_iddq_en_mask = mask then
                read_rng_iddq_en_value = data_low
            else
                read_rng_iddq_en_value = (data_low - H8000_0000) and rng_iddq_en_mask
            end If
        else
            read_rng_iddq_en_value = data_low and rng_iddq_en_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_rng_iddq_en_value = &H0
        flag_rng_iddq_en        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port0_0a
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' port0_icv_key_0a                           [31:0]           get_port0_icv_key_0a
''                                                             set_port0_icv_key_0a
''                                                             read_port0_icv_key_0a
''                                                             write_port0_icv_key_0a
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port0_0a
    Private write_port0_icv_key_0a_value
    Private read_port0_icv_key_0a_value
    Private flag_port0_icv_key_0a

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H20
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_port0_icv_key_0a
        get_port0_icv_key_0a = read_port0_icv_key_0a_value
    End Property

    Property Let set_port0_icv_key_0a(aData)
        write_port0_icv_key_0a_value = aData
        flag_port0_icv_key_0a        = &H1
    End Property

    Property Get read_port0_icv_key_0a
        read
        read_port0_icv_key_0a = read_port0_icv_key_0a_value
    End Property

    Property Let write_port0_icv_key_0a(aData)
        set_port0_icv_key_0a = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port0_icv_key_0a_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port0_icv_key_0a_mask = mask then
                read_port0_icv_key_0a_value = data_low
            else
                read_port0_icv_key_0a_value = (data_low - H8000_0000) and port0_icv_key_0a_mask
            end If
        else
            read_port0_icv_key_0a_value = data_low and port0_icv_key_0a_mask
        end If

    End Sub

    Sub write
        If flag_port0_icv_key_0a = &H0 Then read
        If flag_port0_icv_key_0a = &H0 Then write_port0_icv_key_0a_value = get_port0_icv_key_0a

        regValue = leftShift(write_port0_icv_key_0a_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port0_icv_key_0a_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port0_icv_key_0a_mask = mask then
                read_port0_icv_key_0a_value = data_low
            else
                read_port0_icv_key_0a_value = (data_low - H8000_0000) and port0_icv_key_0a_mask
            end If
        else
            read_port0_icv_key_0a_value = data_low and port0_icv_key_0a_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_port0_icv_key_0a_value = &H0
        flag_port0_icv_key_0a        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port0_0b
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' port0_icv_key_0b                           [31:0]           get_port0_icv_key_0b
''                                                             set_port0_icv_key_0b
''                                                             read_port0_icv_key_0b
''                                                             write_port0_icv_key_0b
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port0_0b
    Private write_port0_icv_key_0b_value
    Private read_port0_icv_key_0b_value
    Private flag_port0_icv_key_0b

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

    Property Get get_port0_icv_key_0b
        get_port0_icv_key_0b = read_port0_icv_key_0b_value
    End Property

    Property Let set_port0_icv_key_0b(aData)
        write_port0_icv_key_0b_value = aData
        flag_port0_icv_key_0b        = &H1
    End Property

    Property Get read_port0_icv_key_0b
        read
        read_port0_icv_key_0b = read_port0_icv_key_0b_value
    End Property

    Property Let write_port0_icv_key_0b(aData)
        set_port0_icv_key_0b = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port0_icv_key_0b_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port0_icv_key_0b_mask = mask then
                read_port0_icv_key_0b_value = data_low
            else
                read_port0_icv_key_0b_value = (data_low - H8000_0000) and port0_icv_key_0b_mask
            end If
        else
            read_port0_icv_key_0b_value = data_low and port0_icv_key_0b_mask
        end If

    End Sub

    Sub write
        If flag_port0_icv_key_0b = &H0 Then read
        If flag_port0_icv_key_0b = &H0 Then write_port0_icv_key_0b_value = get_port0_icv_key_0b

        regValue = leftShift(write_port0_icv_key_0b_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port0_icv_key_0b_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port0_icv_key_0b_mask = mask then
                read_port0_icv_key_0b_value = data_low
            else
                read_port0_icv_key_0b_value = (data_low - H8000_0000) and port0_icv_key_0b_mask
            end If
        else
            read_port0_icv_key_0b_value = data_low and port0_icv_key_0b_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_port0_icv_key_0b_value = &H0
        flag_port0_icv_key_0b        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port0_0c
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' port0_icv_key_0c                           [31:0]           get_port0_icv_key_0c
''                                                             set_port0_icv_key_0c
''                                                             read_port0_icv_key_0c
''                                                             write_port0_icv_key_0c
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port0_0c
    Private write_port0_icv_key_0c_value
    Private read_port0_icv_key_0c_value
    Private flag_port0_icv_key_0c

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H28
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_port0_icv_key_0c
        get_port0_icv_key_0c = read_port0_icv_key_0c_value
    End Property

    Property Let set_port0_icv_key_0c(aData)
        write_port0_icv_key_0c_value = aData
        flag_port0_icv_key_0c        = &H1
    End Property

    Property Get read_port0_icv_key_0c
        read
        read_port0_icv_key_0c = read_port0_icv_key_0c_value
    End Property

    Property Let write_port0_icv_key_0c(aData)
        set_port0_icv_key_0c = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port0_icv_key_0c_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port0_icv_key_0c_mask = mask then
                read_port0_icv_key_0c_value = data_low
            else
                read_port0_icv_key_0c_value = (data_low - H8000_0000) and port0_icv_key_0c_mask
            end If
        else
            read_port0_icv_key_0c_value = data_low and port0_icv_key_0c_mask
        end If

    End Sub

    Sub write
        If flag_port0_icv_key_0c = &H0 Then read
        If flag_port0_icv_key_0c = &H0 Then write_port0_icv_key_0c_value = get_port0_icv_key_0c

        regValue = leftShift(write_port0_icv_key_0c_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port0_icv_key_0c_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port0_icv_key_0c_mask = mask then
                read_port0_icv_key_0c_value = data_low
            else
                read_port0_icv_key_0c_value = (data_low - H8000_0000) and port0_icv_key_0c_mask
            end If
        else
            read_port0_icv_key_0c_value = data_low and port0_icv_key_0c_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_port0_icv_key_0c_value = &H0
        flag_port0_icv_key_0c        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port0_0d
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' port0_icv_key_0d                           [31:0]           get_port0_icv_key_0d
''                                                             set_port0_icv_key_0d
''                                                             read_port0_icv_key_0d
''                                                             write_port0_icv_key_0d
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port0_0d
    Private write_port0_icv_key_0d_value
    Private read_port0_icv_key_0d_value
    Private flag_port0_icv_key_0d

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

    Property Get get_port0_icv_key_0d
        get_port0_icv_key_0d = read_port0_icv_key_0d_value
    End Property

    Property Let set_port0_icv_key_0d(aData)
        write_port0_icv_key_0d_value = aData
        flag_port0_icv_key_0d        = &H1
    End Property

    Property Get read_port0_icv_key_0d
        read
        read_port0_icv_key_0d = read_port0_icv_key_0d_value
    End Property

    Property Let write_port0_icv_key_0d(aData)
        set_port0_icv_key_0d = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port0_icv_key_0d_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port0_icv_key_0d_mask = mask then
                read_port0_icv_key_0d_value = data_low
            else
                read_port0_icv_key_0d_value = (data_low - H8000_0000) and port0_icv_key_0d_mask
            end If
        else
            read_port0_icv_key_0d_value = data_low and port0_icv_key_0d_mask
        end If

    End Sub

    Sub write
        If flag_port0_icv_key_0d = &H0 Then read
        If flag_port0_icv_key_0d = &H0 Then write_port0_icv_key_0d_value = get_port0_icv_key_0d

        regValue = leftShift(write_port0_icv_key_0d_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port0_icv_key_0d_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port0_icv_key_0d_mask = mask then
                read_port0_icv_key_0d_value = data_low
            else
                read_port0_icv_key_0d_value = (data_low - H8000_0000) and port0_icv_key_0d_mask
            end If
        else
            read_port0_icv_key_0d_value = data_low and port0_icv_key_0d_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_port0_icv_key_0d_value = &H0
        flag_port0_icv_key_0d        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port0_0e
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port0_0e

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H30
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low

    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port0_1a
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' port0_icv_key_1a                           [31:0]           get_port0_icv_key_1a
''                                                             set_port0_icv_key_1a
''                                                             read_port0_icv_key_1a
''                                                             write_port0_icv_key_1a
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port0_1a
    Private write_port0_icv_key_1a_value
    Private read_port0_icv_key_1a_value
    Private flag_port0_icv_key_1a

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H34
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_port0_icv_key_1a
        get_port0_icv_key_1a = read_port0_icv_key_1a_value
    End Property

    Property Let set_port0_icv_key_1a(aData)
        write_port0_icv_key_1a_value = aData
        flag_port0_icv_key_1a        = &H1
    End Property

    Property Get read_port0_icv_key_1a
        read
        read_port0_icv_key_1a = read_port0_icv_key_1a_value
    End Property

    Property Let write_port0_icv_key_1a(aData)
        set_port0_icv_key_1a = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port0_icv_key_1a_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port0_icv_key_1a_mask = mask then
                read_port0_icv_key_1a_value = data_low
            else
                read_port0_icv_key_1a_value = (data_low - H8000_0000) and port0_icv_key_1a_mask
            end If
        else
            read_port0_icv_key_1a_value = data_low and port0_icv_key_1a_mask
        end If

    End Sub

    Sub write
        If flag_port0_icv_key_1a = &H0 Then read
        If flag_port0_icv_key_1a = &H0 Then write_port0_icv_key_1a_value = get_port0_icv_key_1a

        regValue = leftShift(write_port0_icv_key_1a_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port0_icv_key_1a_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port0_icv_key_1a_mask = mask then
                read_port0_icv_key_1a_value = data_low
            else
                read_port0_icv_key_1a_value = (data_low - H8000_0000) and port0_icv_key_1a_mask
            end If
        else
            read_port0_icv_key_1a_value = data_low and port0_icv_key_1a_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_port0_icv_key_1a_value = &H0
        flag_port0_icv_key_1a        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port0_1b
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' port0_icv_key_1b                           [31:0]           get_port0_icv_key_1b
''                                                             set_port0_icv_key_1b
''                                                             read_port0_icv_key_1b
''                                                             write_port0_icv_key_1b
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port0_1b
    Private write_port0_icv_key_1b_value
    Private read_port0_icv_key_1b_value
    Private flag_port0_icv_key_1b

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H38
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_port0_icv_key_1b
        get_port0_icv_key_1b = read_port0_icv_key_1b_value
    End Property

    Property Let set_port0_icv_key_1b(aData)
        write_port0_icv_key_1b_value = aData
        flag_port0_icv_key_1b        = &H1
    End Property

    Property Get read_port0_icv_key_1b
        read
        read_port0_icv_key_1b = read_port0_icv_key_1b_value
    End Property

    Property Let write_port0_icv_key_1b(aData)
        set_port0_icv_key_1b = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port0_icv_key_1b_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port0_icv_key_1b_mask = mask then
                read_port0_icv_key_1b_value = data_low
            else
                read_port0_icv_key_1b_value = (data_low - H8000_0000) and port0_icv_key_1b_mask
            end If
        else
            read_port0_icv_key_1b_value = data_low and port0_icv_key_1b_mask
        end If

    End Sub

    Sub write
        If flag_port0_icv_key_1b = &H0 Then read
        If flag_port0_icv_key_1b = &H0 Then write_port0_icv_key_1b_value = get_port0_icv_key_1b

        regValue = leftShift(write_port0_icv_key_1b_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port0_icv_key_1b_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port0_icv_key_1b_mask = mask then
                read_port0_icv_key_1b_value = data_low
            else
                read_port0_icv_key_1b_value = (data_low - H8000_0000) and port0_icv_key_1b_mask
            end If
        else
            read_port0_icv_key_1b_value = data_low and port0_icv_key_1b_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_port0_icv_key_1b_value = &H0
        flag_port0_icv_key_1b        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port0_1c
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' port0_icv_key_1c                           [31:0]           get_port0_icv_key_1c
''                                                             set_port0_icv_key_1c
''                                                             read_port0_icv_key_1c
''                                                             write_port0_icv_key_1c
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port0_1c
    Private write_port0_icv_key_1c_value
    Private read_port0_icv_key_1c_value
    Private flag_port0_icv_key_1c

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_port0_icv_key_1c
        get_port0_icv_key_1c = read_port0_icv_key_1c_value
    End Property

    Property Let set_port0_icv_key_1c(aData)
        write_port0_icv_key_1c_value = aData
        flag_port0_icv_key_1c        = &H1
    End Property

    Property Get read_port0_icv_key_1c
        read
        read_port0_icv_key_1c = read_port0_icv_key_1c_value
    End Property

    Property Let write_port0_icv_key_1c(aData)
        set_port0_icv_key_1c = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port0_icv_key_1c_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port0_icv_key_1c_mask = mask then
                read_port0_icv_key_1c_value = data_low
            else
                read_port0_icv_key_1c_value = (data_low - H8000_0000) and port0_icv_key_1c_mask
            end If
        else
            read_port0_icv_key_1c_value = data_low and port0_icv_key_1c_mask
        end If

    End Sub

    Sub write
        If flag_port0_icv_key_1c = &H0 Then read
        If flag_port0_icv_key_1c = &H0 Then write_port0_icv_key_1c_value = get_port0_icv_key_1c

        regValue = leftShift(write_port0_icv_key_1c_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port0_icv_key_1c_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port0_icv_key_1c_mask = mask then
                read_port0_icv_key_1c_value = data_low
            else
                read_port0_icv_key_1c_value = (data_low - H8000_0000) and port0_icv_key_1c_mask
            end If
        else
            read_port0_icv_key_1c_value = data_low and port0_icv_key_1c_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_port0_icv_key_1c_value = &H0
        flag_port0_icv_key_1c        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port0_1d
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' port0_icv_key_1d                           [31:0]           get_port0_icv_key_1d
''                                                             set_port0_icv_key_1d
''                                                             read_port0_icv_key_1d
''                                                             write_port0_icv_key_1d
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port0_1d
    Private write_port0_icv_key_1d_value
    Private read_port0_icv_key_1d_value
    Private flag_port0_icv_key_1d

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

    Property Get get_port0_icv_key_1d
        get_port0_icv_key_1d = read_port0_icv_key_1d_value
    End Property

    Property Let set_port0_icv_key_1d(aData)
        write_port0_icv_key_1d_value = aData
        flag_port0_icv_key_1d        = &H1
    End Property

    Property Get read_port0_icv_key_1d
        read
        read_port0_icv_key_1d = read_port0_icv_key_1d_value
    End Property

    Property Let write_port0_icv_key_1d(aData)
        set_port0_icv_key_1d = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port0_icv_key_1d_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port0_icv_key_1d_mask = mask then
                read_port0_icv_key_1d_value = data_low
            else
                read_port0_icv_key_1d_value = (data_low - H8000_0000) and port0_icv_key_1d_mask
            end If
        else
            read_port0_icv_key_1d_value = data_low and port0_icv_key_1d_mask
        end If

    End Sub

    Sub write
        If flag_port0_icv_key_1d = &H0 Then read
        If flag_port0_icv_key_1d = &H0 Then write_port0_icv_key_1d_value = get_port0_icv_key_1d

        regValue = leftShift(write_port0_icv_key_1d_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port0_icv_key_1d_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port0_icv_key_1d_mask = mask then
                read_port0_icv_key_1d_value = data_low
            else
                read_port0_icv_key_1d_value = (data_low - H8000_0000) and port0_icv_key_1d_mask
            end If
        else
            read_port0_icv_key_1d_value = data_low and port0_icv_key_1d_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_port0_icv_key_1d_value = &H0
        flag_port0_icv_key_1d        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port0_1e
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port0_1e

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

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low

    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port0_2a
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' port0_icv_key_2a                           [31:0]           get_port0_icv_key_2a
''                                                             set_port0_icv_key_2a
''                                                             read_port0_icv_key_2a
''                                                             write_port0_icv_key_2a
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port0_2a
    Private write_port0_icv_key_2a_value
    Private read_port0_icv_key_2a_value
    Private flag_port0_icv_key_2a

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

    Property Get get_port0_icv_key_2a
        get_port0_icv_key_2a = read_port0_icv_key_2a_value
    End Property

    Property Let set_port0_icv_key_2a(aData)
        write_port0_icv_key_2a_value = aData
        flag_port0_icv_key_2a        = &H1
    End Property

    Property Get read_port0_icv_key_2a
        read
        read_port0_icv_key_2a = read_port0_icv_key_2a_value
    End Property

    Property Let write_port0_icv_key_2a(aData)
        set_port0_icv_key_2a = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port0_icv_key_2a_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port0_icv_key_2a_mask = mask then
                read_port0_icv_key_2a_value = data_low
            else
                read_port0_icv_key_2a_value = (data_low - H8000_0000) and port0_icv_key_2a_mask
            end If
        else
            read_port0_icv_key_2a_value = data_low and port0_icv_key_2a_mask
        end If

    End Sub

    Sub write
        If flag_port0_icv_key_2a = &H0 Then read
        If flag_port0_icv_key_2a = &H0 Then write_port0_icv_key_2a_value = get_port0_icv_key_2a

        regValue = leftShift(write_port0_icv_key_2a_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port0_icv_key_2a_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port0_icv_key_2a_mask = mask then
                read_port0_icv_key_2a_value = data_low
            else
                read_port0_icv_key_2a_value = (data_low - H8000_0000) and port0_icv_key_2a_mask
            end If
        else
            read_port0_icv_key_2a_value = data_low and port0_icv_key_2a_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_port0_icv_key_2a_value = &H0
        flag_port0_icv_key_2a        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port0_2b
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' port0_icv_key_2b                           [31:0]           get_port0_icv_key_2b
''                                                             set_port0_icv_key_2b
''                                                             read_port0_icv_key_2b
''                                                             write_port0_icv_key_2b
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port0_2b
    Private write_port0_icv_key_2b_value
    Private read_port0_icv_key_2b_value
    Private flag_port0_icv_key_2b

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

    Property Get get_port0_icv_key_2b
        get_port0_icv_key_2b = read_port0_icv_key_2b_value
    End Property

    Property Let set_port0_icv_key_2b(aData)
        write_port0_icv_key_2b_value = aData
        flag_port0_icv_key_2b        = &H1
    End Property

    Property Get read_port0_icv_key_2b
        read
        read_port0_icv_key_2b = read_port0_icv_key_2b_value
    End Property

    Property Let write_port0_icv_key_2b(aData)
        set_port0_icv_key_2b = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port0_icv_key_2b_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port0_icv_key_2b_mask = mask then
                read_port0_icv_key_2b_value = data_low
            else
                read_port0_icv_key_2b_value = (data_low - H8000_0000) and port0_icv_key_2b_mask
            end If
        else
            read_port0_icv_key_2b_value = data_low and port0_icv_key_2b_mask
        end If

    End Sub

    Sub write
        If flag_port0_icv_key_2b = &H0 Then read
        If flag_port0_icv_key_2b = &H0 Then write_port0_icv_key_2b_value = get_port0_icv_key_2b

        regValue = leftShift(write_port0_icv_key_2b_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port0_icv_key_2b_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port0_icv_key_2b_mask = mask then
                read_port0_icv_key_2b_value = data_low
            else
                read_port0_icv_key_2b_value = (data_low - H8000_0000) and port0_icv_key_2b_mask
            end If
        else
            read_port0_icv_key_2b_value = data_low and port0_icv_key_2b_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_port0_icv_key_2b_value = &H0
        flag_port0_icv_key_2b        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port0_2c
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' port0_icv_key_2c                           [31:0]           get_port0_icv_key_2c
''                                                             set_port0_icv_key_2c
''                                                             read_port0_icv_key_2c
''                                                             write_port0_icv_key_2c
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port0_2c
    Private write_port0_icv_key_2c_value
    Private read_port0_icv_key_2c_value
    Private flag_port0_icv_key_2c

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

    Property Get get_port0_icv_key_2c
        get_port0_icv_key_2c = read_port0_icv_key_2c_value
    End Property

    Property Let set_port0_icv_key_2c(aData)
        write_port0_icv_key_2c_value = aData
        flag_port0_icv_key_2c        = &H1
    End Property

    Property Get read_port0_icv_key_2c
        read
        read_port0_icv_key_2c = read_port0_icv_key_2c_value
    End Property

    Property Let write_port0_icv_key_2c(aData)
        set_port0_icv_key_2c = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port0_icv_key_2c_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port0_icv_key_2c_mask = mask then
                read_port0_icv_key_2c_value = data_low
            else
                read_port0_icv_key_2c_value = (data_low - H8000_0000) and port0_icv_key_2c_mask
            end If
        else
            read_port0_icv_key_2c_value = data_low and port0_icv_key_2c_mask
        end If

    End Sub

    Sub write
        If flag_port0_icv_key_2c = &H0 Then read
        If flag_port0_icv_key_2c = &H0 Then write_port0_icv_key_2c_value = get_port0_icv_key_2c

        regValue = leftShift(write_port0_icv_key_2c_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port0_icv_key_2c_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port0_icv_key_2c_mask = mask then
                read_port0_icv_key_2c_value = data_low
            else
                read_port0_icv_key_2c_value = (data_low - H8000_0000) and port0_icv_key_2c_mask
            end If
        else
            read_port0_icv_key_2c_value = data_low and port0_icv_key_2c_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_port0_icv_key_2c_value = &H0
        flag_port0_icv_key_2c        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port0_2d
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' port0_icv_key_2d                           [31:0]           get_port0_icv_key_2d
''                                                             set_port0_icv_key_2d
''                                                             read_port0_icv_key_2d
''                                                             write_port0_icv_key_2d
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port0_2d
    Private write_port0_icv_key_2d_value
    Private read_port0_icv_key_2d_value
    Private flag_port0_icv_key_2d

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H54
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_port0_icv_key_2d
        get_port0_icv_key_2d = read_port0_icv_key_2d_value
    End Property

    Property Let set_port0_icv_key_2d(aData)
        write_port0_icv_key_2d_value = aData
        flag_port0_icv_key_2d        = &H1
    End Property

    Property Get read_port0_icv_key_2d
        read
        read_port0_icv_key_2d = read_port0_icv_key_2d_value
    End Property

    Property Let write_port0_icv_key_2d(aData)
        set_port0_icv_key_2d = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port0_icv_key_2d_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port0_icv_key_2d_mask = mask then
                read_port0_icv_key_2d_value = data_low
            else
                read_port0_icv_key_2d_value = (data_low - H8000_0000) and port0_icv_key_2d_mask
            end If
        else
            read_port0_icv_key_2d_value = data_low and port0_icv_key_2d_mask
        end If

    End Sub

    Sub write
        If flag_port0_icv_key_2d = &H0 Then read
        If flag_port0_icv_key_2d = &H0 Then write_port0_icv_key_2d_value = get_port0_icv_key_2d

        regValue = leftShift(write_port0_icv_key_2d_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port0_icv_key_2d_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port0_icv_key_2d_mask = mask then
                read_port0_icv_key_2d_value = data_low
            else
                read_port0_icv_key_2d_value = (data_low - H8000_0000) and port0_icv_key_2d_mask
            end If
        else
            read_port0_icv_key_2d_value = data_low and port0_icv_key_2d_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_port0_icv_key_2d_value = &H0
        flag_port0_icv_key_2d        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port0_2e
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port0_2e

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H58
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low

    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port0_3a
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' port0_icv_key_3a                           [31:0]           get_port0_icv_key_3a
''                                                             set_port0_icv_key_3a
''                                                             read_port0_icv_key_3a
''                                                             write_port0_icv_key_3a
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port0_3a
    Private write_port0_icv_key_3a_value
    Private read_port0_icv_key_3a_value
    Private flag_port0_icv_key_3a

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H5c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_port0_icv_key_3a
        get_port0_icv_key_3a = read_port0_icv_key_3a_value
    End Property

    Property Let set_port0_icv_key_3a(aData)
        write_port0_icv_key_3a_value = aData
        flag_port0_icv_key_3a        = &H1
    End Property

    Property Get read_port0_icv_key_3a
        read
        read_port0_icv_key_3a = read_port0_icv_key_3a_value
    End Property

    Property Let write_port0_icv_key_3a(aData)
        set_port0_icv_key_3a = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port0_icv_key_3a_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port0_icv_key_3a_mask = mask then
                read_port0_icv_key_3a_value = data_low
            else
                read_port0_icv_key_3a_value = (data_low - H8000_0000) and port0_icv_key_3a_mask
            end If
        else
            read_port0_icv_key_3a_value = data_low and port0_icv_key_3a_mask
        end If

    End Sub

    Sub write
        If flag_port0_icv_key_3a = &H0 Then read
        If flag_port0_icv_key_3a = &H0 Then write_port0_icv_key_3a_value = get_port0_icv_key_3a

        regValue = leftShift(write_port0_icv_key_3a_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port0_icv_key_3a_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port0_icv_key_3a_mask = mask then
                read_port0_icv_key_3a_value = data_low
            else
                read_port0_icv_key_3a_value = (data_low - H8000_0000) and port0_icv_key_3a_mask
            end If
        else
            read_port0_icv_key_3a_value = data_low and port0_icv_key_3a_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_port0_icv_key_3a_value = &H0
        flag_port0_icv_key_3a        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port0_3b
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' port0_icv_key_3b                           [31:0]           get_port0_icv_key_3b
''                                                             set_port0_icv_key_3b
''                                                             read_port0_icv_key_3b
''                                                             write_port0_icv_key_3b
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port0_3b
    Private write_port0_icv_key_3b_value
    Private read_port0_icv_key_3b_value
    Private flag_port0_icv_key_3b

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H60
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_port0_icv_key_3b
        get_port0_icv_key_3b = read_port0_icv_key_3b_value
    End Property

    Property Let set_port0_icv_key_3b(aData)
        write_port0_icv_key_3b_value = aData
        flag_port0_icv_key_3b        = &H1
    End Property

    Property Get read_port0_icv_key_3b
        read
        read_port0_icv_key_3b = read_port0_icv_key_3b_value
    End Property

    Property Let write_port0_icv_key_3b(aData)
        set_port0_icv_key_3b = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port0_icv_key_3b_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port0_icv_key_3b_mask = mask then
                read_port0_icv_key_3b_value = data_low
            else
                read_port0_icv_key_3b_value = (data_low - H8000_0000) and port0_icv_key_3b_mask
            end If
        else
            read_port0_icv_key_3b_value = data_low and port0_icv_key_3b_mask
        end If

    End Sub

    Sub write
        If flag_port0_icv_key_3b = &H0 Then read
        If flag_port0_icv_key_3b = &H0 Then write_port0_icv_key_3b_value = get_port0_icv_key_3b

        regValue = leftShift(write_port0_icv_key_3b_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port0_icv_key_3b_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port0_icv_key_3b_mask = mask then
                read_port0_icv_key_3b_value = data_low
            else
                read_port0_icv_key_3b_value = (data_low - H8000_0000) and port0_icv_key_3b_mask
            end If
        else
            read_port0_icv_key_3b_value = data_low and port0_icv_key_3b_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_port0_icv_key_3b_value = &H0
        flag_port0_icv_key_3b        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port0_3c
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' port0_icv_key_3c                           [31:0]           get_port0_icv_key_3c
''                                                             set_port0_icv_key_3c
''                                                             read_port0_icv_key_3c
''                                                             write_port0_icv_key_3c
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port0_3c
    Private write_port0_icv_key_3c_value
    Private read_port0_icv_key_3c_value
    Private flag_port0_icv_key_3c

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H64
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_port0_icv_key_3c
        get_port0_icv_key_3c = read_port0_icv_key_3c_value
    End Property

    Property Let set_port0_icv_key_3c(aData)
        write_port0_icv_key_3c_value = aData
        flag_port0_icv_key_3c        = &H1
    End Property

    Property Get read_port0_icv_key_3c
        read
        read_port0_icv_key_3c = read_port0_icv_key_3c_value
    End Property

    Property Let write_port0_icv_key_3c(aData)
        set_port0_icv_key_3c = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port0_icv_key_3c_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port0_icv_key_3c_mask = mask then
                read_port0_icv_key_3c_value = data_low
            else
                read_port0_icv_key_3c_value = (data_low - H8000_0000) and port0_icv_key_3c_mask
            end If
        else
            read_port0_icv_key_3c_value = data_low and port0_icv_key_3c_mask
        end If

    End Sub

    Sub write
        If flag_port0_icv_key_3c = &H0 Then read
        If flag_port0_icv_key_3c = &H0 Then write_port0_icv_key_3c_value = get_port0_icv_key_3c

        regValue = leftShift(write_port0_icv_key_3c_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port0_icv_key_3c_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port0_icv_key_3c_mask = mask then
                read_port0_icv_key_3c_value = data_low
            else
                read_port0_icv_key_3c_value = (data_low - H8000_0000) and port0_icv_key_3c_mask
            end If
        else
            read_port0_icv_key_3c_value = data_low and port0_icv_key_3c_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_port0_icv_key_3c_value = &H0
        flag_port0_icv_key_3c        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port0_3d
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' port0_icv_key_3d                           [31:0]           get_port0_icv_key_3d
''                                                             set_port0_icv_key_3d
''                                                             read_port0_icv_key_3d
''                                                             write_port0_icv_key_3d
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port0_3d
    Private write_port0_icv_key_3d_value
    Private read_port0_icv_key_3d_value
    Private flag_port0_icv_key_3d

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H68
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_port0_icv_key_3d
        get_port0_icv_key_3d = read_port0_icv_key_3d_value
    End Property

    Property Let set_port0_icv_key_3d(aData)
        write_port0_icv_key_3d_value = aData
        flag_port0_icv_key_3d        = &H1
    End Property

    Property Get read_port0_icv_key_3d
        read
        read_port0_icv_key_3d = read_port0_icv_key_3d_value
    End Property

    Property Let write_port0_icv_key_3d(aData)
        set_port0_icv_key_3d = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port0_icv_key_3d_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port0_icv_key_3d_mask = mask then
                read_port0_icv_key_3d_value = data_low
            else
                read_port0_icv_key_3d_value = (data_low - H8000_0000) and port0_icv_key_3d_mask
            end If
        else
            read_port0_icv_key_3d_value = data_low and port0_icv_key_3d_mask
        end If

    End Sub

    Sub write
        If flag_port0_icv_key_3d = &H0 Then read
        If flag_port0_icv_key_3d = &H0 Then write_port0_icv_key_3d_value = get_port0_icv_key_3d

        regValue = leftShift(write_port0_icv_key_3d_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port0_icv_key_3d_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port0_icv_key_3d_mask = mask then
                read_port0_icv_key_3d_value = data_low
            else
                read_port0_icv_key_3d_value = (data_low - H8000_0000) and port0_icv_key_3d_mask
            end If
        else
            read_port0_icv_key_3d_value = data_low and port0_icv_key_3d_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_port0_icv_key_3d_value = &H0
        flag_port0_icv_key_3d        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port0_3e
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port0_3e

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H6c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low

    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port1_0a
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' port1_icv_key_0a                           [31:0]           get_port1_icv_key_0a
''                                                             set_port1_icv_key_0a
''                                                             read_port1_icv_key_0a
''                                                             write_port1_icv_key_0a
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port1_0a
    Private write_port1_icv_key_0a_value
    Private read_port1_icv_key_0a_value
    Private flag_port1_icv_key_0a

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H70
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_port1_icv_key_0a
        get_port1_icv_key_0a = read_port1_icv_key_0a_value
    End Property

    Property Let set_port1_icv_key_0a(aData)
        write_port1_icv_key_0a_value = aData
        flag_port1_icv_key_0a        = &H1
    End Property

    Property Get read_port1_icv_key_0a
        read
        read_port1_icv_key_0a = read_port1_icv_key_0a_value
    End Property

    Property Let write_port1_icv_key_0a(aData)
        set_port1_icv_key_0a = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port1_icv_key_0a_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port1_icv_key_0a_mask = mask then
                read_port1_icv_key_0a_value = data_low
            else
                read_port1_icv_key_0a_value = (data_low - H8000_0000) and port1_icv_key_0a_mask
            end If
        else
            read_port1_icv_key_0a_value = data_low and port1_icv_key_0a_mask
        end If

    End Sub

    Sub write
        If flag_port1_icv_key_0a = &H0 Then read
        If flag_port1_icv_key_0a = &H0 Then write_port1_icv_key_0a_value = get_port1_icv_key_0a

        regValue = leftShift(write_port1_icv_key_0a_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port1_icv_key_0a_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port1_icv_key_0a_mask = mask then
                read_port1_icv_key_0a_value = data_low
            else
                read_port1_icv_key_0a_value = (data_low - H8000_0000) and port1_icv_key_0a_mask
            end If
        else
            read_port1_icv_key_0a_value = data_low and port1_icv_key_0a_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_port1_icv_key_0a_value = &H0
        flag_port1_icv_key_0a        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port1_0b
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' port1_icv_key_0b                           [31:0]           get_port1_icv_key_0b
''                                                             set_port1_icv_key_0b
''                                                             read_port1_icv_key_0b
''                                                             write_port1_icv_key_0b
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port1_0b
    Private write_port1_icv_key_0b_value
    Private read_port1_icv_key_0b_value
    Private flag_port1_icv_key_0b

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H74
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_port1_icv_key_0b
        get_port1_icv_key_0b = read_port1_icv_key_0b_value
    End Property

    Property Let set_port1_icv_key_0b(aData)
        write_port1_icv_key_0b_value = aData
        flag_port1_icv_key_0b        = &H1
    End Property

    Property Get read_port1_icv_key_0b
        read
        read_port1_icv_key_0b = read_port1_icv_key_0b_value
    End Property

    Property Let write_port1_icv_key_0b(aData)
        set_port1_icv_key_0b = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port1_icv_key_0b_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port1_icv_key_0b_mask = mask then
                read_port1_icv_key_0b_value = data_low
            else
                read_port1_icv_key_0b_value = (data_low - H8000_0000) and port1_icv_key_0b_mask
            end If
        else
            read_port1_icv_key_0b_value = data_low and port1_icv_key_0b_mask
        end If

    End Sub

    Sub write
        If flag_port1_icv_key_0b = &H0 Then read
        If flag_port1_icv_key_0b = &H0 Then write_port1_icv_key_0b_value = get_port1_icv_key_0b

        regValue = leftShift(write_port1_icv_key_0b_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port1_icv_key_0b_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port1_icv_key_0b_mask = mask then
                read_port1_icv_key_0b_value = data_low
            else
                read_port1_icv_key_0b_value = (data_low - H8000_0000) and port1_icv_key_0b_mask
            end If
        else
            read_port1_icv_key_0b_value = data_low and port1_icv_key_0b_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_port1_icv_key_0b_value = &H0
        flag_port1_icv_key_0b        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port1_0c
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' port1_icv_key_0c                           [31:0]           get_port1_icv_key_0c
''                                                             set_port1_icv_key_0c
''                                                             read_port1_icv_key_0c
''                                                             write_port1_icv_key_0c
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port1_0c
    Private write_port1_icv_key_0c_value
    Private read_port1_icv_key_0c_value
    Private flag_port1_icv_key_0c

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H78
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_port1_icv_key_0c
        get_port1_icv_key_0c = read_port1_icv_key_0c_value
    End Property

    Property Let set_port1_icv_key_0c(aData)
        write_port1_icv_key_0c_value = aData
        flag_port1_icv_key_0c        = &H1
    End Property

    Property Get read_port1_icv_key_0c
        read
        read_port1_icv_key_0c = read_port1_icv_key_0c_value
    End Property

    Property Let write_port1_icv_key_0c(aData)
        set_port1_icv_key_0c = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port1_icv_key_0c_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port1_icv_key_0c_mask = mask then
                read_port1_icv_key_0c_value = data_low
            else
                read_port1_icv_key_0c_value = (data_low - H8000_0000) and port1_icv_key_0c_mask
            end If
        else
            read_port1_icv_key_0c_value = data_low and port1_icv_key_0c_mask
        end If

    End Sub

    Sub write
        If flag_port1_icv_key_0c = &H0 Then read
        If flag_port1_icv_key_0c = &H0 Then write_port1_icv_key_0c_value = get_port1_icv_key_0c

        regValue = leftShift(write_port1_icv_key_0c_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port1_icv_key_0c_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port1_icv_key_0c_mask = mask then
                read_port1_icv_key_0c_value = data_low
            else
                read_port1_icv_key_0c_value = (data_low - H8000_0000) and port1_icv_key_0c_mask
            end If
        else
            read_port1_icv_key_0c_value = data_low and port1_icv_key_0c_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_port1_icv_key_0c_value = &H0
        flag_port1_icv_key_0c        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port1_0d
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' port1_icv_key_0d                           [31:0]           get_port1_icv_key_0d
''                                                             set_port1_icv_key_0d
''                                                             read_port1_icv_key_0d
''                                                             write_port1_icv_key_0d
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port1_0d
    Private write_port1_icv_key_0d_value
    Private read_port1_icv_key_0d_value
    Private flag_port1_icv_key_0d

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H7c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_port1_icv_key_0d
        get_port1_icv_key_0d = read_port1_icv_key_0d_value
    End Property

    Property Let set_port1_icv_key_0d(aData)
        write_port1_icv_key_0d_value = aData
        flag_port1_icv_key_0d        = &H1
    End Property

    Property Get read_port1_icv_key_0d
        read
        read_port1_icv_key_0d = read_port1_icv_key_0d_value
    End Property

    Property Let write_port1_icv_key_0d(aData)
        set_port1_icv_key_0d = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port1_icv_key_0d_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port1_icv_key_0d_mask = mask then
                read_port1_icv_key_0d_value = data_low
            else
                read_port1_icv_key_0d_value = (data_low - H8000_0000) and port1_icv_key_0d_mask
            end If
        else
            read_port1_icv_key_0d_value = data_low and port1_icv_key_0d_mask
        end If

    End Sub

    Sub write
        If flag_port1_icv_key_0d = &H0 Then read
        If flag_port1_icv_key_0d = &H0 Then write_port1_icv_key_0d_value = get_port1_icv_key_0d

        regValue = leftShift(write_port1_icv_key_0d_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port1_icv_key_0d_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port1_icv_key_0d_mask = mask then
                read_port1_icv_key_0d_value = data_low
            else
                read_port1_icv_key_0d_value = (data_low - H8000_0000) and port1_icv_key_0d_mask
            end If
        else
            read_port1_icv_key_0d_value = data_low and port1_icv_key_0d_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_port1_icv_key_0d_value = &H0
        flag_port1_icv_key_0d        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port1_0e
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port1_0e

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H80
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low

    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port1_1a
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' port1_icv_key_1a                           [31:0]           get_port1_icv_key_1a
''                                                             set_port1_icv_key_1a
''                                                             read_port1_icv_key_1a
''                                                             write_port1_icv_key_1a
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port1_1a
    Private write_port1_icv_key_1a_value
    Private read_port1_icv_key_1a_value
    Private flag_port1_icv_key_1a

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H84
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_port1_icv_key_1a
        get_port1_icv_key_1a = read_port1_icv_key_1a_value
    End Property

    Property Let set_port1_icv_key_1a(aData)
        write_port1_icv_key_1a_value = aData
        flag_port1_icv_key_1a        = &H1
    End Property

    Property Get read_port1_icv_key_1a
        read
        read_port1_icv_key_1a = read_port1_icv_key_1a_value
    End Property

    Property Let write_port1_icv_key_1a(aData)
        set_port1_icv_key_1a = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port1_icv_key_1a_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port1_icv_key_1a_mask = mask then
                read_port1_icv_key_1a_value = data_low
            else
                read_port1_icv_key_1a_value = (data_low - H8000_0000) and port1_icv_key_1a_mask
            end If
        else
            read_port1_icv_key_1a_value = data_low and port1_icv_key_1a_mask
        end If

    End Sub

    Sub write
        If flag_port1_icv_key_1a = &H0 Then read
        If flag_port1_icv_key_1a = &H0 Then write_port1_icv_key_1a_value = get_port1_icv_key_1a

        regValue = leftShift(write_port1_icv_key_1a_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port1_icv_key_1a_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port1_icv_key_1a_mask = mask then
                read_port1_icv_key_1a_value = data_low
            else
                read_port1_icv_key_1a_value = (data_low - H8000_0000) and port1_icv_key_1a_mask
            end If
        else
            read_port1_icv_key_1a_value = data_low and port1_icv_key_1a_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_port1_icv_key_1a_value = &H0
        flag_port1_icv_key_1a        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port1_1b
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' port1_icv_key_1b                           [31:0]           get_port1_icv_key_1b
''                                                             set_port1_icv_key_1b
''                                                             read_port1_icv_key_1b
''                                                             write_port1_icv_key_1b
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port1_1b
    Private write_port1_icv_key_1b_value
    Private read_port1_icv_key_1b_value
    Private flag_port1_icv_key_1b

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H88
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_port1_icv_key_1b
        get_port1_icv_key_1b = read_port1_icv_key_1b_value
    End Property

    Property Let set_port1_icv_key_1b(aData)
        write_port1_icv_key_1b_value = aData
        flag_port1_icv_key_1b        = &H1
    End Property

    Property Get read_port1_icv_key_1b
        read
        read_port1_icv_key_1b = read_port1_icv_key_1b_value
    End Property

    Property Let write_port1_icv_key_1b(aData)
        set_port1_icv_key_1b = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port1_icv_key_1b_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port1_icv_key_1b_mask = mask then
                read_port1_icv_key_1b_value = data_low
            else
                read_port1_icv_key_1b_value = (data_low - H8000_0000) and port1_icv_key_1b_mask
            end If
        else
            read_port1_icv_key_1b_value = data_low and port1_icv_key_1b_mask
        end If

    End Sub

    Sub write
        If flag_port1_icv_key_1b = &H0 Then read
        If flag_port1_icv_key_1b = &H0 Then write_port1_icv_key_1b_value = get_port1_icv_key_1b

        regValue = leftShift(write_port1_icv_key_1b_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port1_icv_key_1b_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port1_icv_key_1b_mask = mask then
                read_port1_icv_key_1b_value = data_low
            else
                read_port1_icv_key_1b_value = (data_low - H8000_0000) and port1_icv_key_1b_mask
            end If
        else
            read_port1_icv_key_1b_value = data_low and port1_icv_key_1b_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_port1_icv_key_1b_value = &H0
        flag_port1_icv_key_1b        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port1_1c
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' port1_icv_key_1c                           [31:0]           get_port1_icv_key_1c
''                                                             set_port1_icv_key_1c
''                                                             read_port1_icv_key_1c
''                                                             write_port1_icv_key_1c
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port1_1c
    Private write_port1_icv_key_1c_value
    Private read_port1_icv_key_1c_value
    Private flag_port1_icv_key_1c

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H8c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_port1_icv_key_1c
        get_port1_icv_key_1c = read_port1_icv_key_1c_value
    End Property

    Property Let set_port1_icv_key_1c(aData)
        write_port1_icv_key_1c_value = aData
        flag_port1_icv_key_1c        = &H1
    End Property

    Property Get read_port1_icv_key_1c
        read
        read_port1_icv_key_1c = read_port1_icv_key_1c_value
    End Property

    Property Let write_port1_icv_key_1c(aData)
        set_port1_icv_key_1c = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port1_icv_key_1c_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port1_icv_key_1c_mask = mask then
                read_port1_icv_key_1c_value = data_low
            else
                read_port1_icv_key_1c_value = (data_low - H8000_0000) and port1_icv_key_1c_mask
            end If
        else
            read_port1_icv_key_1c_value = data_low and port1_icv_key_1c_mask
        end If

    End Sub

    Sub write
        If flag_port1_icv_key_1c = &H0 Then read
        If flag_port1_icv_key_1c = &H0 Then write_port1_icv_key_1c_value = get_port1_icv_key_1c

        regValue = leftShift(write_port1_icv_key_1c_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port1_icv_key_1c_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port1_icv_key_1c_mask = mask then
                read_port1_icv_key_1c_value = data_low
            else
                read_port1_icv_key_1c_value = (data_low - H8000_0000) and port1_icv_key_1c_mask
            end If
        else
            read_port1_icv_key_1c_value = data_low and port1_icv_key_1c_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_port1_icv_key_1c_value = &H0
        flag_port1_icv_key_1c        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port1_1d
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' port1_icv_key_1d                           [31:0]           get_port1_icv_key_1d
''                                                             set_port1_icv_key_1d
''                                                             read_port1_icv_key_1d
''                                                             write_port1_icv_key_1d
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port1_1d
    Private write_port1_icv_key_1d_value
    Private read_port1_icv_key_1d_value
    Private flag_port1_icv_key_1d

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H90
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_port1_icv_key_1d
        get_port1_icv_key_1d = read_port1_icv_key_1d_value
    End Property

    Property Let set_port1_icv_key_1d(aData)
        write_port1_icv_key_1d_value = aData
        flag_port1_icv_key_1d        = &H1
    End Property

    Property Get read_port1_icv_key_1d
        read
        read_port1_icv_key_1d = read_port1_icv_key_1d_value
    End Property

    Property Let write_port1_icv_key_1d(aData)
        set_port1_icv_key_1d = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port1_icv_key_1d_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port1_icv_key_1d_mask = mask then
                read_port1_icv_key_1d_value = data_low
            else
                read_port1_icv_key_1d_value = (data_low - H8000_0000) and port1_icv_key_1d_mask
            end If
        else
            read_port1_icv_key_1d_value = data_low and port1_icv_key_1d_mask
        end If

    End Sub

    Sub write
        If flag_port1_icv_key_1d = &H0 Then read
        If flag_port1_icv_key_1d = &H0 Then write_port1_icv_key_1d_value = get_port1_icv_key_1d

        regValue = leftShift(write_port1_icv_key_1d_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port1_icv_key_1d_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port1_icv_key_1d_mask = mask then
                read_port1_icv_key_1d_value = data_low
            else
                read_port1_icv_key_1d_value = (data_low - H8000_0000) and port1_icv_key_1d_mask
            end If
        else
            read_port1_icv_key_1d_value = data_low and port1_icv_key_1d_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_port1_icv_key_1d_value = &H0
        flag_port1_icv_key_1d        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port1_1e
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port1_1e

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H94
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low

    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port1_2a
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' port1_icv_key_2a                           [31:0]           get_port1_icv_key_2a
''                                                             set_port1_icv_key_2a
''                                                             read_port1_icv_key_2a
''                                                             write_port1_icv_key_2a
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port1_2a
    Private write_port1_icv_key_2a_value
    Private read_port1_icv_key_2a_value
    Private flag_port1_icv_key_2a

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

    Property Get get_port1_icv_key_2a
        get_port1_icv_key_2a = read_port1_icv_key_2a_value
    End Property

    Property Let set_port1_icv_key_2a(aData)
        write_port1_icv_key_2a_value = aData
        flag_port1_icv_key_2a        = &H1
    End Property

    Property Get read_port1_icv_key_2a
        read
        read_port1_icv_key_2a = read_port1_icv_key_2a_value
    End Property

    Property Let write_port1_icv_key_2a(aData)
        set_port1_icv_key_2a = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port1_icv_key_2a_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port1_icv_key_2a_mask = mask then
                read_port1_icv_key_2a_value = data_low
            else
                read_port1_icv_key_2a_value = (data_low - H8000_0000) and port1_icv_key_2a_mask
            end If
        else
            read_port1_icv_key_2a_value = data_low and port1_icv_key_2a_mask
        end If

    End Sub

    Sub write
        If flag_port1_icv_key_2a = &H0 Then read
        If flag_port1_icv_key_2a = &H0 Then write_port1_icv_key_2a_value = get_port1_icv_key_2a

        regValue = leftShift(write_port1_icv_key_2a_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port1_icv_key_2a_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port1_icv_key_2a_mask = mask then
                read_port1_icv_key_2a_value = data_low
            else
                read_port1_icv_key_2a_value = (data_low - H8000_0000) and port1_icv_key_2a_mask
            end If
        else
            read_port1_icv_key_2a_value = data_low and port1_icv_key_2a_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_port1_icv_key_2a_value = &H0
        flag_port1_icv_key_2a        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port1_2b
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' port1_icv_key_2b                           [31:0]           get_port1_icv_key_2b
''                                                             set_port1_icv_key_2b
''                                                             read_port1_icv_key_2b
''                                                             write_port1_icv_key_2b
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port1_2b
    Private write_port1_icv_key_2b_value
    Private read_port1_icv_key_2b_value
    Private flag_port1_icv_key_2b

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

    Property Get get_port1_icv_key_2b
        get_port1_icv_key_2b = read_port1_icv_key_2b_value
    End Property

    Property Let set_port1_icv_key_2b(aData)
        write_port1_icv_key_2b_value = aData
        flag_port1_icv_key_2b        = &H1
    End Property

    Property Get read_port1_icv_key_2b
        read
        read_port1_icv_key_2b = read_port1_icv_key_2b_value
    End Property

    Property Let write_port1_icv_key_2b(aData)
        set_port1_icv_key_2b = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port1_icv_key_2b_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port1_icv_key_2b_mask = mask then
                read_port1_icv_key_2b_value = data_low
            else
                read_port1_icv_key_2b_value = (data_low - H8000_0000) and port1_icv_key_2b_mask
            end If
        else
            read_port1_icv_key_2b_value = data_low and port1_icv_key_2b_mask
        end If

    End Sub

    Sub write
        If flag_port1_icv_key_2b = &H0 Then read
        If flag_port1_icv_key_2b = &H0 Then write_port1_icv_key_2b_value = get_port1_icv_key_2b

        regValue = leftShift(write_port1_icv_key_2b_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port1_icv_key_2b_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port1_icv_key_2b_mask = mask then
                read_port1_icv_key_2b_value = data_low
            else
                read_port1_icv_key_2b_value = (data_low - H8000_0000) and port1_icv_key_2b_mask
            end If
        else
            read_port1_icv_key_2b_value = data_low and port1_icv_key_2b_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_port1_icv_key_2b_value = &H0
        flag_port1_icv_key_2b        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port1_2c
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' port1_icv_key_2c                           [31:0]           get_port1_icv_key_2c
''                                                             set_port1_icv_key_2c
''                                                             read_port1_icv_key_2c
''                                                             write_port1_icv_key_2c
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port1_2c
    Private write_port1_icv_key_2c_value
    Private read_port1_icv_key_2c_value
    Private flag_port1_icv_key_2c

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Ha0
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_port1_icv_key_2c
        get_port1_icv_key_2c = read_port1_icv_key_2c_value
    End Property

    Property Let set_port1_icv_key_2c(aData)
        write_port1_icv_key_2c_value = aData
        flag_port1_icv_key_2c        = &H1
    End Property

    Property Get read_port1_icv_key_2c
        read
        read_port1_icv_key_2c = read_port1_icv_key_2c_value
    End Property

    Property Let write_port1_icv_key_2c(aData)
        set_port1_icv_key_2c = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port1_icv_key_2c_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port1_icv_key_2c_mask = mask then
                read_port1_icv_key_2c_value = data_low
            else
                read_port1_icv_key_2c_value = (data_low - H8000_0000) and port1_icv_key_2c_mask
            end If
        else
            read_port1_icv_key_2c_value = data_low and port1_icv_key_2c_mask
        end If

    End Sub

    Sub write
        If flag_port1_icv_key_2c = &H0 Then read
        If flag_port1_icv_key_2c = &H0 Then write_port1_icv_key_2c_value = get_port1_icv_key_2c

        regValue = leftShift(write_port1_icv_key_2c_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port1_icv_key_2c_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port1_icv_key_2c_mask = mask then
                read_port1_icv_key_2c_value = data_low
            else
                read_port1_icv_key_2c_value = (data_low - H8000_0000) and port1_icv_key_2c_mask
            end If
        else
            read_port1_icv_key_2c_value = data_low and port1_icv_key_2c_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_port1_icv_key_2c_value = &H0
        flag_port1_icv_key_2c        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port1_2d
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' port1_icv_key_2d                           [31:0]           get_port1_icv_key_2d
''                                                             set_port1_icv_key_2d
''                                                             read_port1_icv_key_2d
''                                                             write_port1_icv_key_2d
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port1_2d
    Private write_port1_icv_key_2d_value
    Private read_port1_icv_key_2d_value
    Private flag_port1_icv_key_2d

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Ha4
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_port1_icv_key_2d
        get_port1_icv_key_2d = read_port1_icv_key_2d_value
    End Property

    Property Let set_port1_icv_key_2d(aData)
        write_port1_icv_key_2d_value = aData
        flag_port1_icv_key_2d        = &H1
    End Property

    Property Get read_port1_icv_key_2d
        read
        read_port1_icv_key_2d = read_port1_icv_key_2d_value
    End Property

    Property Let write_port1_icv_key_2d(aData)
        set_port1_icv_key_2d = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port1_icv_key_2d_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port1_icv_key_2d_mask = mask then
                read_port1_icv_key_2d_value = data_low
            else
                read_port1_icv_key_2d_value = (data_low - H8000_0000) and port1_icv_key_2d_mask
            end If
        else
            read_port1_icv_key_2d_value = data_low and port1_icv_key_2d_mask
        end If

    End Sub

    Sub write
        If flag_port1_icv_key_2d = &H0 Then read
        If flag_port1_icv_key_2d = &H0 Then write_port1_icv_key_2d_value = get_port1_icv_key_2d

        regValue = leftShift(write_port1_icv_key_2d_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port1_icv_key_2d_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port1_icv_key_2d_mask = mask then
                read_port1_icv_key_2d_value = data_low
            else
                read_port1_icv_key_2d_value = (data_low - H8000_0000) and port1_icv_key_2d_mask
            end If
        else
            read_port1_icv_key_2d_value = data_low and port1_icv_key_2d_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_port1_icv_key_2d_value = &H0
        flag_port1_icv_key_2d        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port1_2e
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port1_2e

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Ha8
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low

    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port1_3a
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' port1_icv_key_3a                           [31:0]           get_port1_icv_key_3a
''                                                             set_port1_icv_key_3a
''                                                             read_port1_icv_key_3a
''                                                             write_port1_icv_key_3a
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port1_3a
    Private write_port1_icv_key_3a_value
    Private read_port1_icv_key_3a_value
    Private flag_port1_icv_key_3a

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hac
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_port1_icv_key_3a
        get_port1_icv_key_3a = read_port1_icv_key_3a_value
    End Property

    Property Let set_port1_icv_key_3a(aData)
        write_port1_icv_key_3a_value = aData
        flag_port1_icv_key_3a        = &H1
    End Property

    Property Get read_port1_icv_key_3a
        read
        read_port1_icv_key_3a = read_port1_icv_key_3a_value
    End Property

    Property Let write_port1_icv_key_3a(aData)
        set_port1_icv_key_3a = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port1_icv_key_3a_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port1_icv_key_3a_mask = mask then
                read_port1_icv_key_3a_value = data_low
            else
                read_port1_icv_key_3a_value = (data_low - H8000_0000) and port1_icv_key_3a_mask
            end If
        else
            read_port1_icv_key_3a_value = data_low and port1_icv_key_3a_mask
        end If

    End Sub

    Sub write
        If flag_port1_icv_key_3a = &H0 Then read
        If flag_port1_icv_key_3a = &H0 Then write_port1_icv_key_3a_value = get_port1_icv_key_3a

        regValue = leftShift(write_port1_icv_key_3a_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port1_icv_key_3a_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port1_icv_key_3a_mask = mask then
                read_port1_icv_key_3a_value = data_low
            else
                read_port1_icv_key_3a_value = (data_low - H8000_0000) and port1_icv_key_3a_mask
            end If
        else
            read_port1_icv_key_3a_value = data_low and port1_icv_key_3a_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_port1_icv_key_3a_value = &H0
        flag_port1_icv_key_3a        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port1_3b
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' port1_icv_key_3b                           [31:0]           get_port1_icv_key_3b
''                                                             set_port1_icv_key_3b
''                                                             read_port1_icv_key_3b
''                                                             write_port1_icv_key_3b
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port1_3b
    Private write_port1_icv_key_3b_value
    Private read_port1_icv_key_3b_value
    Private flag_port1_icv_key_3b

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hb0
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_port1_icv_key_3b
        get_port1_icv_key_3b = read_port1_icv_key_3b_value
    End Property

    Property Let set_port1_icv_key_3b(aData)
        write_port1_icv_key_3b_value = aData
        flag_port1_icv_key_3b        = &H1
    End Property

    Property Get read_port1_icv_key_3b
        read
        read_port1_icv_key_3b = read_port1_icv_key_3b_value
    End Property

    Property Let write_port1_icv_key_3b(aData)
        set_port1_icv_key_3b = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port1_icv_key_3b_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port1_icv_key_3b_mask = mask then
                read_port1_icv_key_3b_value = data_low
            else
                read_port1_icv_key_3b_value = (data_low - H8000_0000) and port1_icv_key_3b_mask
            end If
        else
            read_port1_icv_key_3b_value = data_low and port1_icv_key_3b_mask
        end If

    End Sub

    Sub write
        If flag_port1_icv_key_3b = &H0 Then read
        If flag_port1_icv_key_3b = &H0 Then write_port1_icv_key_3b_value = get_port1_icv_key_3b

        regValue = leftShift(write_port1_icv_key_3b_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port1_icv_key_3b_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port1_icv_key_3b_mask = mask then
                read_port1_icv_key_3b_value = data_low
            else
                read_port1_icv_key_3b_value = (data_low - H8000_0000) and port1_icv_key_3b_mask
            end If
        else
            read_port1_icv_key_3b_value = data_low and port1_icv_key_3b_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_port1_icv_key_3b_value = &H0
        flag_port1_icv_key_3b        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port1_3c
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' port1_icv_key_3c                           [31:0]           get_port1_icv_key_3c
''                                                             set_port1_icv_key_3c
''                                                             read_port1_icv_key_3c
''                                                             write_port1_icv_key_3c
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port1_3c
    Private write_port1_icv_key_3c_value
    Private read_port1_icv_key_3c_value
    Private flag_port1_icv_key_3c

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hb4
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_port1_icv_key_3c
        get_port1_icv_key_3c = read_port1_icv_key_3c_value
    End Property

    Property Let set_port1_icv_key_3c(aData)
        write_port1_icv_key_3c_value = aData
        flag_port1_icv_key_3c        = &H1
    End Property

    Property Get read_port1_icv_key_3c
        read
        read_port1_icv_key_3c = read_port1_icv_key_3c_value
    End Property

    Property Let write_port1_icv_key_3c(aData)
        set_port1_icv_key_3c = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port1_icv_key_3c_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port1_icv_key_3c_mask = mask then
                read_port1_icv_key_3c_value = data_low
            else
                read_port1_icv_key_3c_value = (data_low - H8000_0000) and port1_icv_key_3c_mask
            end If
        else
            read_port1_icv_key_3c_value = data_low and port1_icv_key_3c_mask
        end If

    End Sub

    Sub write
        If flag_port1_icv_key_3c = &H0 Then read
        If flag_port1_icv_key_3c = &H0 Then write_port1_icv_key_3c_value = get_port1_icv_key_3c

        regValue = leftShift(write_port1_icv_key_3c_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port1_icv_key_3c_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port1_icv_key_3c_mask = mask then
                read_port1_icv_key_3c_value = data_low
            else
                read_port1_icv_key_3c_value = (data_low - H8000_0000) and port1_icv_key_3c_mask
            end If
        else
            read_port1_icv_key_3c_value = data_low and port1_icv_key_3c_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_port1_icv_key_3c_value = &H0
        flag_port1_icv_key_3c        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port1_3d
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' port1_icv_key_3d                           [31:0]           get_port1_icv_key_3d
''                                                             set_port1_icv_key_3d
''                                                             read_port1_icv_key_3d
''                                                             write_port1_icv_key_3d
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port1_3d
    Private write_port1_icv_key_3d_value
    Private read_port1_icv_key_3d_value
    Private flag_port1_icv_key_3d

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hb8
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_port1_icv_key_3d
        get_port1_icv_key_3d = read_port1_icv_key_3d_value
    End Property

    Property Let set_port1_icv_key_3d(aData)
        write_port1_icv_key_3d_value = aData
        flag_port1_icv_key_3d        = &H1
    End Property

    Property Get read_port1_icv_key_3d
        read
        read_port1_icv_key_3d = read_port1_icv_key_3d_value
    End Property

    Property Let write_port1_icv_key_3d(aData)
        set_port1_icv_key_3d = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port1_icv_key_3d_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port1_icv_key_3d_mask = mask then
                read_port1_icv_key_3d_value = data_low
            else
                read_port1_icv_key_3d_value = (data_low - H8000_0000) and port1_icv_key_3d_mask
            end If
        else
            read_port1_icv_key_3d_value = data_low and port1_icv_key_3d_mask
        end If

    End Sub

    Sub write
        If flag_port1_icv_key_3d = &H0 Then read
        If flag_port1_icv_key_3d = &H0 Then write_port1_icv_key_3d_value = get_port1_icv_key_3d

        regValue = leftShift(write_port1_icv_key_3d_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port1_icv_key_3d_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port1_icv_key_3d_mask = mask then
                read_port1_icv_key_3d_value = data_low
            else
                read_port1_icv_key_3d_value = (data_low - H8000_0000) and port1_icv_key_3d_mask
            end If
        else
            read_port1_icv_key_3d_value = data_low and port1_icv_key_3d_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_port1_icv_key_3d_value = &H0
        flag_port1_icv_key_3d        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port1_3e
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port1_3e

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hbc
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low

    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port2_0a
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' port2_icv_key_0a                           [31:0]           get_port2_icv_key_0a
''                                                             set_port2_icv_key_0a
''                                                             read_port2_icv_key_0a
''                                                             write_port2_icv_key_0a
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port2_0a
    Private write_port2_icv_key_0a_value
    Private read_port2_icv_key_0a_value
    Private flag_port2_icv_key_0a

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

    Property Get get_port2_icv_key_0a
        get_port2_icv_key_0a = read_port2_icv_key_0a_value
    End Property

    Property Let set_port2_icv_key_0a(aData)
        write_port2_icv_key_0a_value = aData
        flag_port2_icv_key_0a        = &H1
    End Property

    Property Get read_port2_icv_key_0a
        read
        read_port2_icv_key_0a = read_port2_icv_key_0a_value
    End Property

    Property Let write_port2_icv_key_0a(aData)
        set_port2_icv_key_0a = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port2_icv_key_0a_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port2_icv_key_0a_mask = mask then
                read_port2_icv_key_0a_value = data_low
            else
                read_port2_icv_key_0a_value = (data_low - H8000_0000) and port2_icv_key_0a_mask
            end If
        else
            read_port2_icv_key_0a_value = data_low and port2_icv_key_0a_mask
        end If

    End Sub

    Sub write
        If flag_port2_icv_key_0a = &H0 Then read
        If flag_port2_icv_key_0a = &H0 Then write_port2_icv_key_0a_value = get_port2_icv_key_0a

        regValue = leftShift(write_port2_icv_key_0a_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port2_icv_key_0a_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port2_icv_key_0a_mask = mask then
                read_port2_icv_key_0a_value = data_low
            else
                read_port2_icv_key_0a_value = (data_low - H8000_0000) and port2_icv_key_0a_mask
            end If
        else
            read_port2_icv_key_0a_value = data_low and port2_icv_key_0a_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_port2_icv_key_0a_value = &H0
        flag_port2_icv_key_0a        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port2_0b
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' port2_icv_key_0b                           [31:0]           get_port2_icv_key_0b
''                                                             set_port2_icv_key_0b
''                                                             read_port2_icv_key_0b
''                                                             write_port2_icv_key_0b
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port2_0b
    Private write_port2_icv_key_0b_value
    Private read_port2_icv_key_0b_value
    Private flag_port2_icv_key_0b

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

    Property Get get_port2_icv_key_0b
        get_port2_icv_key_0b = read_port2_icv_key_0b_value
    End Property

    Property Let set_port2_icv_key_0b(aData)
        write_port2_icv_key_0b_value = aData
        flag_port2_icv_key_0b        = &H1
    End Property

    Property Get read_port2_icv_key_0b
        read
        read_port2_icv_key_0b = read_port2_icv_key_0b_value
    End Property

    Property Let write_port2_icv_key_0b(aData)
        set_port2_icv_key_0b = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port2_icv_key_0b_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port2_icv_key_0b_mask = mask then
                read_port2_icv_key_0b_value = data_low
            else
                read_port2_icv_key_0b_value = (data_low - H8000_0000) and port2_icv_key_0b_mask
            end If
        else
            read_port2_icv_key_0b_value = data_low and port2_icv_key_0b_mask
        end If

    End Sub

    Sub write
        If flag_port2_icv_key_0b = &H0 Then read
        If flag_port2_icv_key_0b = &H0 Then write_port2_icv_key_0b_value = get_port2_icv_key_0b

        regValue = leftShift(write_port2_icv_key_0b_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port2_icv_key_0b_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port2_icv_key_0b_mask = mask then
                read_port2_icv_key_0b_value = data_low
            else
                read_port2_icv_key_0b_value = (data_low - H8000_0000) and port2_icv_key_0b_mask
            end If
        else
            read_port2_icv_key_0b_value = data_low and port2_icv_key_0b_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_port2_icv_key_0b_value = &H0
        flag_port2_icv_key_0b        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port2_0c
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' port2_icv_key_0c                           [31:0]           get_port2_icv_key_0c
''                                                             set_port2_icv_key_0c
''                                                             read_port2_icv_key_0c
''                                                             write_port2_icv_key_0c
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port2_0c
    Private write_port2_icv_key_0c_value
    Private read_port2_icv_key_0c_value
    Private flag_port2_icv_key_0c

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hc8
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_port2_icv_key_0c
        get_port2_icv_key_0c = read_port2_icv_key_0c_value
    End Property

    Property Let set_port2_icv_key_0c(aData)
        write_port2_icv_key_0c_value = aData
        flag_port2_icv_key_0c        = &H1
    End Property

    Property Get read_port2_icv_key_0c
        read
        read_port2_icv_key_0c = read_port2_icv_key_0c_value
    End Property

    Property Let write_port2_icv_key_0c(aData)
        set_port2_icv_key_0c = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port2_icv_key_0c_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port2_icv_key_0c_mask = mask then
                read_port2_icv_key_0c_value = data_low
            else
                read_port2_icv_key_0c_value = (data_low - H8000_0000) and port2_icv_key_0c_mask
            end If
        else
            read_port2_icv_key_0c_value = data_low and port2_icv_key_0c_mask
        end If

    End Sub

    Sub write
        If flag_port2_icv_key_0c = &H0 Then read
        If flag_port2_icv_key_0c = &H0 Then write_port2_icv_key_0c_value = get_port2_icv_key_0c

        regValue = leftShift(write_port2_icv_key_0c_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port2_icv_key_0c_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port2_icv_key_0c_mask = mask then
                read_port2_icv_key_0c_value = data_low
            else
                read_port2_icv_key_0c_value = (data_low - H8000_0000) and port2_icv_key_0c_mask
            end If
        else
            read_port2_icv_key_0c_value = data_low and port2_icv_key_0c_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_port2_icv_key_0c_value = &H0
        flag_port2_icv_key_0c        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port2_0d
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' port2_icv_key_0d                           [31:0]           get_port2_icv_key_0d
''                                                             set_port2_icv_key_0d
''                                                             read_port2_icv_key_0d
''                                                             write_port2_icv_key_0d
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port2_0d
    Private write_port2_icv_key_0d_value
    Private read_port2_icv_key_0d_value
    Private flag_port2_icv_key_0d

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hcc
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_port2_icv_key_0d
        get_port2_icv_key_0d = read_port2_icv_key_0d_value
    End Property

    Property Let set_port2_icv_key_0d(aData)
        write_port2_icv_key_0d_value = aData
        flag_port2_icv_key_0d        = &H1
    End Property

    Property Get read_port2_icv_key_0d
        read
        read_port2_icv_key_0d = read_port2_icv_key_0d_value
    End Property

    Property Let write_port2_icv_key_0d(aData)
        set_port2_icv_key_0d = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port2_icv_key_0d_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port2_icv_key_0d_mask = mask then
                read_port2_icv_key_0d_value = data_low
            else
                read_port2_icv_key_0d_value = (data_low - H8000_0000) and port2_icv_key_0d_mask
            end If
        else
            read_port2_icv_key_0d_value = data_low and port2_icv_key_0d_mask
        end If

    End Sub

    Sub write
        If flag_port2_icv_key_0d = &H0 Then read
        If flag_port2_icv_key_0d = &H0 Then write_port2_icv_key_0d_value = get_port2_icv_key_0d

        regValue = leftShift(write_port2_icv_key_0d_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port2_icv_key_0d_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port2_icv_key_0d_mask = mask then
                read_port2_icv_key_0d_value = data_low
            else
                read_port2_icv_key_0d_value = (data_low - H8000_0000) and port2_icv_key_0d_mask
            end If
        else
            read_port2_icv_key_0d_value = data_low and port2_icv_key_0d_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_port2_icv_key_0d_value = &H0
        flag_port2_icv_key_0d        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port2_0e
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port2_0e

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hd0
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low

    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port2_1a
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' port2_icv_key_1a                           [31:0]           get_port2_icv_key_1a
''                                                             set_port2_icv_key_1a
''                                                             read_port2_icv_key_1a
''                                                             write_port2_icv_key_1a
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port2_1a
    Private write_port2_icv_key_1a_value
    Private read_port2_icv_key_1a_value
    Private flag_port2_icv_key_1a

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hd4
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_port2_icv_key_1a
        get_port2_icv_key_1a = read_port2_icv_key_1a_value
    End Property

    Property Let set_port2_icv_key_1a(aData)
        write_port2_icv_key_1a_value = aData
        flag_port2_icv_key_1a        = &H1
    End Property

    Property Get read_port2_icv_key_1a
        read
        read_port2_icv_key_1a = read_port2_icv_key_1a_value
    End Property

    Property Let write_port2_icv_key_1a(aData)
        set_port2_icv_key_1a = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port2_icv_key_1a_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port2_icv_key_1a_mask = mask then
                read_port2_icv_key_1a_value = data_low
            else
                read_port2_icv_key_1a_value = (data_low - H8000_0000) and port2_icv_key_1a_mask
            end If
        else
            read_port2_icv_key_1a_value = data_low and port2_icv_key_1a_mask
        end If

    End Sub

    Sub write
        If flag_port2_icv_key_1a = &H0 Then read
        If flag_port2_icv_key_1a = &H0 Then write_port2_icv_key_1a_value = get_port2_icv_key_1a

        regValue = leftShift(write_port2_icv_key_1a_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port2_icv_key_1a_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port2_icv_key_1a_mask = mask then
                read_port2_icv_key_1a_value = data_low
            else
                read_port2_icv_key_1a_value = (data_low - H8000_0000) and port2_icv_key_1a_mask
            end If
        else
            read_port2_icv_key_1a_value = data_low and port2_icv_key_1a_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_port2_icv_key_1a_value = &H0
        flag_port2_icv_key_1a        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port2_1b
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' port2_icv_key_1b                           [31:0]           get_port2_icv_key_1b
''                                                             set_port2_icv_key_1b
''                                                             read_port2_icv_key_1b
''                                                             write_port2_icv_key_1b
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port2_1b
    Private write_port2_icv_key_1b_value
    Private read_port2_icv_key_1b_value
    Private flag_port2_icv_key_1b

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hd8
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_port2_icv_key_1b
        get_port2_icv_key_1b = read_port2_icv_key_1b_value
    End Property

    Property Let set_port2_icv_key_1b(aData)
        write_port2_icv_key_1b_value = aData
        flag_port2_icv_key_1b        = &H1
    End Property

    Property Get read_port2_icv_key_1b
        read
        read_port2_icv_key_1b = read_port2_icv_key_1b_value
    End Property

    Property Let write_port2_icv_key_1b(aData)
        set_port2_icv_key_1b = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port2_icv_key_1b_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port2_icv_key_1b_mask = mask then
                read_port2_icv_key_1b_value = data_low
            else
                read_port2_icv_key_1b_value = (data_low - H8000_0000) and port2_icv_key_1b_mask
            end If
        else
            read_port2_icv_key_1b_value = data_low and port2_icv_key_1b_mask
        end If

    End Sub

    Sub write
        If flag_port2_icv_key_1b = &H0 Then read
        If flag_port2_icv_key_1b = &H0 Then write_port2_icv_key_1b_value = get_port2_icv_key_1b

        regValue = leftShift(write_port2_icv_key_1b_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port2_icv_key_1b_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port2_icv_key_1b_mask = mask then
                read_port2_icv_key_1b_value = data_low
            else
                read_port2_icv_key_1b_value = (data_low - H8000_0000) and port2_icv_key_1b_mask
            end If
        else
            read_port2_icv_key_1b_value = data_low and port2_icv_key_1b_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_port2_icv_key_1b_value = &H0
        flag_port2_icv_key_1b        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port2_1c
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' port2_icv_key_1c                           [31:0]           get_port2_icv_key_1c
''                                                             set_port2_icv_key_1c
''                                                             read_port2_icv_key_1c
''                                                             write_port2_icv_key_1c
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port2_1c
    Private write_port2_icv_key_1c_value
    Private read_port2_icv_key_1c_value
    Private flag_port2_icv_key_1c

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hdc
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_port2_icv_key_1c
        get_port2_icv_key_1c = read_port2_icv_key_1c_value
    End Property

    Property Let set_port2_icv_key_1c(aData)
        write_port2_icv_key_1c_value = aData
        flag_port2_icv_key_1c        = &H1
    End Property

    Property Get read_port2_icv_key_1c
        read
        read_port2_icv_key_1c = read_port2_icv_key_1c_value
    End Property

    Property Let write_port2_icv_key_1c(aData)
        set_port2_icv_key_1c = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port2_icv_key_1c_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port2_icv_key_1c_mask = mask then
                read_port2_icv_key_1c_value = data_low
            else
                read_port2_icv_key_1c_value = (data_low - H8000_0000) and port2_icv_key_1c_mask
            end If
        else
            read_port2_icv_key_1c_value = data_low and port2_icv_key_1c_mask
        end If

    End Sub

    Sub write
        If flag_port2_icv_key_1c = &H0 Then read
        If flag_port2_icv_key_1c = &H0 Then write_port2_icv_key_1c_value = get_port2_icv_key_1c

        regValue = leftShift(write_port2_icv_key_1c_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port2_icv_key_1c_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port2_icv_key_1c_mask = mask then
                read_port2_icv_key_1c_value = data_low
            else
                read_port2_icv_key_1c_value = (data_low - H8000_0000) and port2_icv_key_1c_mask
            end If
        else
            read_port2_icv_key_1c_value = data_low and port2_icv_key_1c_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_port2_icv_key_1c_value = &H0
        flag_port2_icv_key_1c        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port2_1d
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' port2_icv_key_1d                           [31:0]           get_port2_icv_key_1d
''                                                             set_port2_icv_key_1d
''                                                             read_port2_icv_key_1d
''                                                             write_port2_icv_key_1d
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port2_1d
    Private write_port2_icv_key_1d_value
    Private read_port2_icv_key_1d_value
    Private flag_port2_icv_key_1d

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &He0
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_port2_icv_key_1d
        get_port2_icv_key_1d = read_port2_icv_key_1d_value
    End Property

    Property Let set_port2_icv_key_1d(aData)
        write_port2_icv_key_1d_value = aData
        flag_port2_icv_key_1d        = &H1
    End Property

    Property Get read_port2_icv_key_1d
        read
        read_port2_icv_key_1d = read_port2_icv_key_1d_value
    End Property

    Property Let write_port2_icv_key_1d(aData)
        set_port2_icv_key_1d = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port2_icv_key_1d_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port2_icv_key_1d_mask = mask then
                read_port2_icv_key_1d_value = data_low
            else
                read_port2_icv_key_1d_value = (data_low - H8000_0000) and port2_icv_key_1d_mask
            end If
        else
            read_port2_icv_key_1d_value = data_low and port2_icv_key_1d_mask
        end If

    End Sub

    Sub write
        If flag_port2_icv_key_1d = &H0 Then read
        If flag_port2_icv_key_1d = &H0 Then write_port2_icv_key_1d_value = get_port2_icv_key_1d

        regValue = leftShift(write_port2_icv_key_1d_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port2_icv_key_1d_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port2_icv_key_1d_mask = mask then
                read_port2_icv_key_1d_value = data_low
            else
                read_port2_icv_key_1d_value = (data_low - H8000_0000) and port2_icv_key_1d_mask
            end If
        else
            read_port2_icv_key_1d_value = data_low and port2_icv_key_1d_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_port2_icv_key_1d_value = &H0
        flag_port2_icv_key_1d        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port2_1e
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port2_1e

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &He4
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low

    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port2_2a
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' port2_icv_key_2a                           [31:0]           get_port2_icv_key_2a
''                                                             set_port2_icv_key_2a
''                                                             read_port2_icv_key_2a
''                                                             write_port2_icv_key_2a
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port2_2a
    Private write_port2_icv_key_2a_value
    Private read_port2_icv_key_2a_value
    Private flag_port2_icv_key_2a

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &He8
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_port2_icv_key_2a
        get_port2_icv_key_2a = read_port2_icv_key_2a_value
    End Property

    Property Let set_port2_icv_key_2a(aData)
        write_port2_icv_key_2a_value = aData
        flag_port2_icv_key_2a        = &H1
    End Property

    Property Get read_port2_icv_key_2a
        read
        read_port2_icv_key_2a = read_port2_icv_key_2a_value
    End Property

    Property Let write_port2_icv_key_2a(aData)
        set_port2_icv_key_2a = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port2_icv_key_2a_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port2_icv_key_2a_mask = mask then
                read_port2_icv_key_2a_value = data_low
            else
                read_port2_icv_key_2a_value = (data_low - H8000_0000) and port2_icv_key_2a_mask
            end If
        else
            read_port2_icv_key_2a_value = data_low and port2_icv_key_2a_mask
        end If

    End Sub

    Sub write
        If flag_port2_icv_key_2a = &H0 Then read
        If flag_port2_icv_key_2a = &H0 Then write_port2_icv_key_2a_value = get_port2_icv_key_2a

        regValue = leftShift(write_port2_icv_key_2a_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port2_icv_key_2a_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port2_icv_key_2a_mask = mask then
                read_port2_icv_key_2a_value = data_low
            else
                read_port2_icv_key_2a_value = (data_low - H8000_0000) and port2_icv_key_2a_mask
            end If
        else
            read_port2_icv_key_2a_value = data_low and port2_icv_key_2a_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_port2_icv_key_2a_value = &H0
        flag_port2_icv_key_2a        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port2_2b
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' port2_icv_key_2b                           [31:0]           get_port2_icv_key_2b
''                                                             set_port2_icv_key_2b
''                                                             read_port2_icv_key_2b
''                                                             write_port2_icv_key_2b
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port2_2b
    Private write_port2_icv_key_2b_value
    Private read_port2_icv_key_2b_value
    Private flag_port2_icv_key_2b

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hec
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_port2_icv_key_2b
        get_port2_icv_key_2b = read_port2_icv_key_2b_value
    End Property

    Property Let set_port2_icv_key_2b(aData)
        write_port2_icv_key_2b_value = aData
        flag_port2_icv_key_2b        = &H1
    End Property

    Property Get read_port2_icv_key_2b
        read
        read_port2_icv_key_2b = read_port2_icv_key_2b_value
    End Property

    Property Let write_port2_icv_key_2b(aData)
        set_port2_icv_key_2b = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port2_icv_key_2b_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port2_icv_key_2b_mask = mask then
                read_port2_icv_key_2b_value = data_low
            else
                read_port2_icv_key_2b_value = (data_low - H8000_0000) and port2_icv_key_2b_mask
            end If
        else
            read_port2_icv_key_2b_value = data_low and port2_icv_key_2b_mask
        end If

    End Sub

    Sub write
        If flag_port2_icv_key_2b = &H0 Then read
        If flag_port2_icv_key_2b = &H0 Then write_port2_icv_key_2b_value = get_port2_icv_key_2b

        regValue = leftShift(write_port2_icv_key_2b_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port2_icv_key_2b_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port2_icv_key_2b_mask = mask then
                read_port2_icv_key_2b_value = data_low
            else
                read_port2_icv_key_2b_value = (data_low - H8000_0000) and port2_icv_key_2b_mask
            end If
        else
            read_port2_icv_key_2b_value = data_low and port2_icv_key_2b_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_port2_icv_key_2b_value = &H0
        flag_port2_icv_key_2b        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port2_2c
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' port2_icv_key_2c                           [31:0]           get_port2_icv_key_2c
''                                                             set_port2_icv_key_2c
''                                                             read_port2_icv_key_2c
''                                                             write_port2_icv_key_2c
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port2_2c
    Private write_port2_icv_key_2c_value
    Private read_port2_icv_key_2c_value
    Private flag_port2_icv_key_2c

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hf0
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_port2_icv_key_2c
        get_port2_icv_key_2c = read_port2_icv_key_2c_value
    End Property

    Property Let set_port2_icv_key_2c(aData)
        write_port2_icv_key_2c_value = aData
        flag_port2_icv_key_2c        = &H1
    End Property

    Property Get read_port2_icv_key_2c
        read
        read_port2_icv_key_2c = read_port2_icv_key_2c_value
    End Property

    Property Let write_port2_icv_key_2c(aData)
        set_port2_icv_key_2c = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port2_icv_key_2c_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port2_icv_key_2c_mask = mask then
                read_port2_icv_key_2c_value = data_low
            else
                read_port2_icv_key_2c_value = (data_low - H8000_0000) and port2_icv_key_2c_mask
            end If
        else
            read_port2_icv_key_2c_value = data_low and port2_icv_key_2c_mask
        end If

    End Sub

    Sub write
        If flag_port2_icv_key_2c = &H0 Then read
        If flag_port2_icv_key_2c = &H0 Then write_port2_icv_key_2c_value = get_port2_icv_key_2c

        regValue = leftShift(write_port2_icv_key_2c_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port2_icv_key_2c_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port2_icv_key_2c_mask = mask then
                read_port2_icv_key_2c_value = data_low
            else
                read_port2_icv_key_2c_value = (data_low - H8000_0000) and port2_icv_key_2c_mask
            end If
        else
            read_port2_icv_key_2c_value = data_low and port2_icv_key_2c_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_port2_icv_key_2c_value = &H0
        flag_port2_icv_key_2c        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port2_2d
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' port2_icv_key_2d                           [31:0]           get_port2_icv_key_2d
''                                                             set_port2_icv_key_2d
''                                                             read_port2_icv_key_2d
''                                                             write_port2_icv_key_2d
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port2_2d
    Private write_port2_icv_key_2d_value
    Private read_port2_icv_key_2d_value
    Private flag_port2_icv_key_2d

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hf4
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_port2_icv_key_2d
        get_port2_icv_key_2d = read_port2_icv_key_2d_value
    End Property

    Property Let set_port2_icv_key_2d(aData)
        write_port2_icv_key_2d_value = aData
        flag_port2_icv_key_2d        = &H1
    End Property

    Property Get read_port2_icv_key_2d
        read
        read_port2_icv_key_2d = read_port2_icv_key_2d_value
    End Property

    Property Let write_port2_icv_key_2d(aData)
        set_port2_icv_key_2d = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port2_icv_key_2d_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port2_icv_key_2d_mask = mask then
                read_port2_icv_key_2d_value = data_low
            else
                read_port2_icv_key_2d_value = (data_low - H8000_0000) and port2_icv_key_2d_mask
            end If
        else
            read_port2_icv_key_2d_value = data_low and port2_icv_key_2d_mask
        end If

    End Sub

    Sub write
        If flag_port2_icv_key_2d = &H0 Then read
        If flag_port2_icv_key_2d = &H0 Then write_port2_icv_key_2d_value = get_port2_icv_key_2d

        regValue = leftShift(write_port2_icv_key_2d_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port2_icv_key_2d_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port2_icv_key_2d_mask = mask then
                read_port2_icv_key_2d_value = data_low
            else
                read_port2_icv_key_2d_value = (data_low - H8000_0000) and port2_icv_key_2d_mask
            end If
        else
            read_port2_icv_key_2d_value = data_low and port2_icv_key_2d_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_port2_icv_key_2d_value = &H0
        flag_port2_icv_key_2d        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port2_2e
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port2_2e

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hf8
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low

    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port2_3a
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' port2_icv_key_3a                           [31:0]           get_port2_icv_key_3a
''                                                             set_port2_icv_key_3a
''                                                             read_port2_icv_key_3a
''                                                             write_port2_icv_key_3a
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port2_3a
    Private write_port2_icv_key_3a_value
    Private read_port2_icv_key_3a_value
    Private flag_port2_icv_key_3a

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hfc
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_port2_icv_key_3a
        get_port2_icv_key_3a = read_port2_icv_key_3a_value
    End Property

    Property Let set_port2_icv_key_3a(aData)
        write_port2_icv_key_3a_value = aData
        flag_port2_icv_key_3a        = &H1
    End Property

    Property Get read_port2_icv_key_3a
        read
        read_port2_icv_key_3a = read_port2_icv_key_3a_value
    End Property

    Property Let write_port2_icv_key_3a(aData)
        set_port2_icv_key_3a = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port2_icv_key_3a_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port2_icv_key_3a_mask = mask then
                read_port2_icv_key_3a_value = data_low
            else
                read_port2_icv_key_3a_value = (data_low - H8000_0000) and port2_icv_key_3a_mask
            end If
        else
            read_port2_icv_key_3a_value = data_low and port2_icv_key_3a_mask
        end If

    End Sub

    Sub write
        If flag_port2_icv_key_3a = &H0 Then read
        If flag_port2_icv_key_3a = &H0 Then write_port2_icv_key_3a_value = get_port2_icv_key_3a

        regValue = leftShift(write_port2_icv_key_3a_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port2_icv_key_3a_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port2_icv_key_3a_mask = mask then
                read_port2_icv_key_3a_value = data_low
            else
                read_port2_icv_key_3a_value = (data_low - H8000_0000) and port2_icv_key_3a_mask
            end If
        else
            read_port2_icv_key_3a_value = data_low and port2_icv_key_3a_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_port2_icv_key_3a_value = &H0
        flag_port2_icv_key_3a        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port2_3b
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' port2_icv_key_3b                           [31:0]           get_port2_icv_key_3b
''                                                             set_port2_icv_key_3b
''                                                             read_port2_icv_key_3b
''                                                             write_port2_icv_key_3b
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port2_3b
    Private write_port2_icv_key_3b_value
    Private read_port2_icv_key_3b_value
    Private flag_port2_icv_key_3b

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

    Property Get get_port2_icv_key_3b
        get_port2_icv_key_3b = read_port2_icv_key_3b_value
    End Property

    Property Let set_port2_icv_key_3b(aData)
        write_port2_icv_key_3b_value = aData
        flag_port2_icv_key_3b        = &H1
    End Property

    Property Get read_port2_icv_key_3b
        read
        read_port2_icv_key_3b = read_port2_icv_key_3b_value
    End Property

    Property Let write_port2_icv_key_3b(aData)
        set_port2_icv_key_3b = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port2_icv_key_3b_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port2_icv_key_3b_mask = mask then
                read_port2_icv_key_3b_value = data_low
            else
                read_port2_icv_key_3b_value = (data_low - H8000_0000) and port2_icv_key_3b_mask
            end If
        else
            read_port2_icv_key_3b_value = data_low and port2_icv_key_3b_mask
        end If

    End Sub

    Sub write
        If flag_port2_icv_key_3b = &H0 Then read
        If flag_port2_icv_key_3b = &H0 Then write_port2_icv_key_3b_value = get_port2_icv_key_3b

        regValue = leftShift(write_port2_icv_key_3b_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port2_icv_key_3b_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port2_icv_key_3b_mask = mask then
                read_port2_icv_key_3b_value = data_low
            else
                read_port2_icv_key_3b_value = (data_low - H8000_0000) and port2_icv_key_3b_mask
            end If
        else
            read_port2_icv_key_3b_value = data_low and port2_icv_key_3b_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_port2_icv_key_3b_value = &H0
        flag_port2_icv_key_3b        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port2_3c
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' port2_icv_key_3c                           [31:0]           get_port2_icv_key_3c
''                                                             set_port2_icv_key_3c
''                                                             read_port2_icv_key_3c
''                                                             write_port2_icv_key_3c
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port2_3c
    Private write_port2_icv_key_3c_value
    Private read_port2_icv_key_3c_value
    Private flag_port2_icv_key_3c

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

    Property Get get_port2_icv_key_3c
        get_port2_icv_key_3c = read_port2_icv_key_3c_value
    End Property

    Property Let set_port2_icv_key_3c(aData)
        write_port2_icv_key_3c_value = aData
        flag_port2_icv_key_3c        = &H1
    End Property

    Property Get read_port2_icv_key_3c
        read
        read_port2_icv_key_3c = read_port2_icv_key_3c_value
    End Property

    Property Let write_port2_icv_key_3c(aData)
        set_port2_icv_key_3c = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port2_icv_key_3c_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port2_icv_key_3c_mask = mask then
                read_port2_icv_key_3c_value = data_low
            else
                read_port2_icv_key_3c_value = (data_low - H8000_0000) and port2_icv_key_3c_mask
            end If
        else
            read_port2_icv_key_3c_value = data_low and port2_icv_key_3c_mask
        end If

    End Sub

    Sub write
        If flag_port2_icv_key_3c = &H0 Then read
        If flag_port2_icv_key_3c = &H0 Then write_port2_icv_key_3c_value = get_port2_icv_key_3c

        regValue = leftShift(write_port2_icv_key_3c_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port2_icv_key_3c_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port2_icv_key_3c_mask = mask then
                read_port2_icv_key_3c_value = data_low
            else
                read_port2_icv_key_3c_value = (data_low - H8000_0000) and port2_icv_key_3c_mask
            end If
        else
            read_port2_icv_key_3c_value = data_low and port2_icv_key_3c_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_port2_icv_key_3c_value = &H0
        flag_port2_icv_key_3c        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port2_3d
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' port2_icv_key_3d                           [31:0]           get_port2_icv_key_3d
''                                                             set_port2_icv_key_3d
''                                                             read_port2_icv_key_3d
''                                                             write_port2_icv_key_3d
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port2_3d
    Private write_port2_icv_key_3d_value
    Private read_port2_icv_key_3d_value
    Private flag_port2_icv_key_3d

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

    Property Get get_port2_icv_key_3d
        get_port2_icv_key_3d = read_port2_icv_key_3d_value
    End Property

    Property Let set_port2_icv_key_3d(aData)
        write_port2_icv_key_3d_value = aData
        flag_port2_icv_key_3d        = &H1
    End Property

    Property Get read_port2_icv_key_3d
        read
        read_port2_icv_key_3d = read_port2_icv_key_3d_value
    End Property

    Property Let write_port2_icv_key_3d(aData)
        set_port2_icv_key_3d = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port2_icv_key_3d_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port2_icv_key_3d_mask = mask then
                read_port2_icv_key_3d_value = data_low
            else
                read_port2_icv_key_3d_value = (data_low - H8000_0000) and port2_icv_key_3d_mask
            end If
        else
            read_port2_icv_key_3d_value = data_low and port2_icv_key_3d_mask
        end If

    End Sub

    Sub write
        If flag_port2_icv_key_3d = &H0 Then read
        If flag_port2_icv_key_3d = &H0 Then write_port2_icv_key_3d_value = get_port2_icv_key_3d

        regValue = leftShift(write_port2_icv_key_3d_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port2_icv_key_3d_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port2_icv_key_3d_mask = mask then
                read_port2_icv_key_3d_value = data_low
            else
                read_port2_icv_key_3d_value = (data_low - H8000_0000) and port2_icv_key_3d_mask
            end If
        else
            read_port2_icv_key_3d_value = data_low and port2_icv_key_3d_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_port2_icv_key_3d_value = &H0
        flag_port2_icv_key_3d        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port2_3e
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port2_3e

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

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low

    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port3_0a
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' port3_icv_key_0a                           [31:0]           get_port3_icv_key_0a
''                                                             set_port3_icv_key_0a
''                                                             read_port3_icv_key_0a
''                                                             write_port3_icv_key_0a
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port3_0a
    Private write_port3_icv_key_0a_value
    Private read_port3_icv_key_0a_value
    Private flag_port3_icv_key_0a

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

    Property Get get_port3_icv_key_0a
        get_port3_icv_key_0a = read_port3_icv_key_0a_value
    End Property

    Property Let set_port3_icv_key_0a(aData)
        write_port3_icv_key_0a_value = aData
        flag_port3_icv_key_0a        = &H1
    End Property

    Property Get read_port3_icv_key_0a
        read
        read_port3_icv_key_0a = read_port3_icv_key_0a_value
    End Property

    Property Let write_port3_icv_key_0a(aData)
        set_port3_icv_key_0a = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port3_icv_key_0a_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port3_icv_key_0a_mask = mask then
                read_port3_icv_key_0a_value = data_low
            else
                read_port3_icv_key_0a_value = (data_low - H8000_0000) and port3_icv_key_0a_mask
            end If
        else
            read_port3_icv_key_0a_value = data_low and port3_icv_key_0a_mask
        end If

    End Sub

    Sub write
        If flag_port3_icv_key_0a = &H0 Then read
        If flag_port3_icv_key_0a = &H0 Then write_port3_icv_key_0a_value = get_port3_icv_key_0a

        regValue = leftShift(write_port3_icv_key_0a_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port3_icv_key_0a_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port3_icv_key_0a_mask = mask then
                read_port3_icv_key_0a_value = data_low
            else
                read_port3_icv_key_0a_value = (data_low - H8000_0000) and port3_icv_key_0a_mask
            end If
        else
            read_port3_icv_key_0a_value = data_low and port3_icv_key_0a_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_port3_icv_key_0a_value = &H0
        flag_port3_icv_key_0a        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port3_0b
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' port3_icv_key_0b                           [31:0]           get_port3_icv_key_0b
''                                                             set_port3_icv_key_0b
''                                                             read_port3_icv_key_0b
''                                                             write_port3_icv_key_0b
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port3_0b
    Private write_port3_icv_key_0b_value
    Private read_port3_icv_key_0b_value
    Private flag_port3_icv_key_0b

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

    Property Get get_port3_icv_key_0b
        get_port3_icv_key_0b = read_port3_icv_key_0b_value
    End Property

    Property Let set_port3_icv_key_0b(aData)
        write_port3_icv_key_0b_value = aData
        flag_port3_icv_key_0b        = &H1
    End Property

    Property Get read_port3_icv_key_0b
        read
        read_port3_icv_key_0b = read_port3_icv_key_0b_value
    End Property

    Property Let write_port3_icv_key_0b(aData)
        set_port3_icv_key_0b = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port3_icv_key_0b_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port3_icv_key_0b_mask = mask then
                read_port3_icv_key_0b_value = data_low
            else
                read_port3_icv_key_0b_value = (data_low - H8000_0000) and port3_icv_key_0b_mask
            end If
        else
            read_port3_icv_key_0b_value = data_low and port3_icv_key_0b_mask
        end If

    End Sub

    Sub write
        If flag_port3_icv_key_0b = &H0 Then read
        If flag_port3_icv_key_0b = &H0 Then write_port3_icv_key_0b_value = get_port3_icv_key_0b

        regValue = leftShift(write_port3_icv_key_0b_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port3_icv_key_0b_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port3_icv_key_0b_mask = mask then
                read_port3_icv_key_0b_value = data_low
            else
                read_port3_icv_key_0b_value = (data_low - H8000_0000) and port3_icv_key_0b_mask
            end If
        else
            read_port3_icv_key_0b_value = data_low and port3_icv_key_0b_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_port3_icv_key_0b_value = &H0
        flag_port3_icv_key_0b        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port3_0c
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' port3_icv_key_0c                           [31:0]           get_port3_icv_key_0c
''                                                             set_port3_icv_key_0c
''                                                             read_port3_icv_key_0c
''                                                             write_port3_icv_key_0c
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port3_0c
    Private write_port3_icv_key_0c_value
    Private read_port3_icv_key_0c_value
    Private flag_port3_icv_key_0c

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

    Property Get get_port3_icv_key_0c
        get_port3_icv_key_0c = read_port3_icv_key_0c_value
    End Property

    Property Let set_port3_icv_key_0c(aData)
        write_port3_icv_key_0c_value = aData
        flag_port3_icv_key_0c        = &H1
    End Property

    Property Get read_port3_icv_key_0c
        read
        read_port3_icv_key_0c = read_port3_icv_key_0c_value
    End Property

    Property Let write_port3_icv_key_0c(aData)
        set_port3_icv_key_0c = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port3_icv_key_0c_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port3_icv_key_0c_mask = mask then
                read_port3_icv_key_0c_value = data_low
            else
                read_port3_icv_key_0c_value = (data_low - H8000_0000) and port3_icv_key_0c_mask
            end If
        else
            read_port3_icv_key_0c_value = data_low and port3_icv_key_0c_mask
        end If

    End Sub

    Sub write
        If flag_port3_icv_key_0c = &H0 Then read
        If flag_port3_icv_key_0c = &H0 Then write_port3_icv_key_0c_value = get_port3_icv_key_0c

        regValue = leftShift(write_port3_icv_key_0c_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port3_icv_key_0c_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port3_icv_key_0c_mask = mask then
                read_port3_icv_key_0c_value = data_low
            else
                read_port3_icv_key_0c_value = (data_low - H8000_0000) and port3_icv_key_0c_mask
            end If
        else
            read_port3_icv_key_0c_value = data_low and port3_icv_key_0c_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_port3_icv_key_0c_value = &H0
        flag_port3_icv_key_0c        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port3_0d
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' port3_icv_key_0d                           [31:0]           get_port3_icv_key_0d
''                                                             set_port3_icv_key_0d
''                                                             read_port3_icv_key_0d
''                                                             write_port3_icv_key_0d
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port3_0d
    Private write_port3_icv_key_0d_value
    Private read_port3_icv_key_0d_value
    Private flag_port3_icv_key_0d

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

    Property Get get_port3_icv_key_0d
        get_port3_icv_key_0d = read_port3_icv_key_0d_value
    End Property

    Property Let set_port3_icv_key_0d(aData)
        write_port3_icv_key_0d_value = aData
        flag_port3_icv_key_0d        = &H1
    End Property

    Property Get read_port3_icv_key_0d
        read
        read_port3_icv_key_0d = read_port3_icv_key_0d_value
    End Property

    Property Let write_port3_icv_key_0d(aData)
        set_port3_icv_key_0d = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port3_icv_key_0d_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port3_icv_key_0d_mask = mask then
                read_port3_icv_key_0d_value = data_low
            else
                read_port3_icv_key_0d_value = (data_low - H8000_0000) and port3_icv_key_0d_mask
            end If
        else
            read_port3_icv_key_0d_value = data_low and port3_icv_key_0d_mask
        end If

    End Sub

    Sub write
        If flag_port3_icv_key_0d = &H0 Then read
        If flag_port3_icv_key_0d = &H0 Then write_port3_icv_key_0d_value = get_port3_icv_key_0d

        regValue = leftShift(write_port3_icv_key_0d_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port3_icv_key_0d_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port3_icv_key_0d_mask = mask then
                read_port3_icv_key_0d_value = data_low
            else
                read_port3_icv_key_0d_value = (data_low - H8000_0000) and port3_icv_key_0d_mask
            end If
        else
            read_port3_icv_key_0d_value = data_low and port3_icv_key_0d_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_port3_icv_key_0d_value = &H0
        flag_port3_icv_key_0d        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port3_0e
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port3_0e

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

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low

    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port3_1a
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' port3_icv_key_1a                           [31:0]           get_port3_icv_key_1a
''                                                             set_port3_icv_key_1a
''                                                             read_port3_icv_key_1a
''                                                             write_port3_icv_key_1a
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port3_1a
    Private write_port3_icv_key_1a_value
    Private read_port3_icv_key_1a_value
    Private flag_port3_icv_key_1a

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

    Property Get get_port3_icv_key_1a
        get_port3_icv_key_1a = read_port3_icv_key_1a_value
    End Property

    Property Let set_port3_icv_key_1a(aData)
        write_port3_icv_key_1a_value = aData
        flag_port3_icv_key_1a        = &H1
    End Property

    Property Get read_port3_icv_key_1a
        read
        read_port3_icv_key_1a = read_port3_icv_key_1a_value
    End Property

    Property Let write_port3_icv_key_1a(aData)
        set_port3_icv_key_1a = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port3_icv_key_1a_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port3_icv_key_1a_mask = mask then
                read_port3_icv_key_1a_value = data_low
            else
                read_port3_icv_key_1a_value = (data_low - H8000_0000) and port3_icv_key_1a_mask
            end If
        else
            read_port3_icv_key_1a_value = data_low and port3_icv_key_1a_mask
        end If

    End Sub

    Sub write
        If flag_port3_icv_key_1a = &H0 Then read
        If flag_port3_icv_key_1a = &H0 Then write_port3_icv_key_1a_value = get_port3_icv_key_1a

        regValue = leftShift(write_port3_icv_key_1a_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port3_icv_key_1a_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port3_icv_key_1a_mask = mask then
                read_port3_icv_key_1a_value = data_low
            else
                read_port3_icv_key_1a_value = (data_low - H8000_0000) and port3_icv_key_1a_mask
            end If
        else
            read_port3_icv_key_1a_value = data_low and port3_icv_key_1a_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_port3_icv_key_1a_value = &H0
        flag_port3_icv_key_1a        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port3_1b
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' port3_icv_key_1b                           [31:0]           get_port3_icv_key_1b
''                                                             set_port3_icv_key_1b
''                                                             read_port3_icv_key_1b
''                                                             write_port3_icv_key_1b
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port3_1b
    Private write_port3_icv_key_1b_value
    Private read_port3_icv_key_1b_value
    Private flag_port3_icv_key_1b

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

    Property Get get_port3_icv_key_1b
        get_port3_icv_key_1b = read_port3_icv_key_1b_value
    End Property

    Property Let set_port3_icv_key_1b(aData)
        write_port3_icv_key_1b_value = aData
        flag_port3_icv_key_1b        = &H1
    End Property

    Property Get read_port3_icv_key_1b
        read
        read_port3_icv_key_1b = read_port3_icv_key_1b_value
    End Property

    Property Let write_port3_icv_key_1b(aData)
        set_port3_icv_key_1b = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port3_icv_key_1b_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port3_icv_key_1b_mask = mask then
                read_port3_icv_key_1b_value = data_low
            else
                read_port3_icv_key_1b_value = (data_low - H8000_0000) and port3_icv_key_1b_mask
            end If
        else
            read_port3_icv_key_1b_value = data_low and port3_icv_key_1b_mask
        end If

    End Sub

    Sub write
        If flag_port3_icv_key_1b = &H0 Then read
        If flag_port3_icv_key_1b = &H0 Then write_port3_icv_key_1b_value = get_port3_icv_key_1b

        regValue = leftShift(write_port3_icv_key_1b_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port3_icv_key_1b_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port3_icv_key_1b_mask = mask then
                read_port3_icv_key_1b_value = data_low
            else
                read_port3_icv_key_1b_value = (data_low - H8000_0000) and port3_icv_key_1b_mask
            end If
        else
            read_port3_icv_key_1b_value = data_low and port3_icv_key_1b_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_port3_icv_key_1b_value = &H0
        flag_port3_icv_key_1b        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port3_1c
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' port3_icv_key_1c                           [31:0]           get_port3_icv_key_1c
''                                                             set_port3_icv_key_1c
''                                                             read_port3_icv_key_1c
''                                                             write_port3_icv_key_1c
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port3_1c
    Private write_port3_icv_key_1c_value
    Private read_port3_icv_key_1c_value
    Private flag_port3_icv_key_1c

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

    Property Get get_port3_icv_key_1c
        get_port3_icv_key_1c = read_port3_icv_key_1c_value
    End Property

    Property Let set_port3_icv_key_1c(aData)
        write_port3_icv_key_1c_value = aData
        flag_port3_icv_key_1c        = &H1
    End Property

    Property Get read_port3_icv_key_1c
        read
        read_port3_icv_key_1c = read_port3_icv_key_1c_value
    End Property

    Property Let write_port3_icv_key_1c(aData)
        set_port3_icv_key_1c = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port3_icv_key_1c_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port3_icv_key_1c_mask = mask then
                read_port3_icv_key_1c_value = data_low
            else
                read_port3_icv_key_1c_value = (data_low - H8000_0000) and port3_icv_key_1c_mask
            end If
        else
            read_port3_icv_key_1c_value = data_low and port3_icv_key_1c_mask
        end If

    End Sub

    Sub write
        If flag_port3_icv_key_1c = &H0 Then read
        If flag_port3_icv_key_1c = &H0 Then write_port3_icv_key_1c_value = get_port3_icv_key_1c

        regValue = leftShift(write_port3_icv_key_1c_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port3_icv_key_1c_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port3_icv_key_1c_mask = mask then
                read_port3_icv_key_1c_value = data_low
            else
                read_port3_icv_key_1c_value = (data_low - H8000_0000) and port3_icv_key_1c_mask
            end If
        else
            read_port3_icv_key_1c_value = data_low and port3_icv_key_1c_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_port3_icv_key_1c_value = &H0
        flag_port3_icv_key_1c        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port3_1d
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' port3_icv_key_1d                           [31:0]           get_port3_icv_key_1d
''                                                             set_port3_icv_key_1d
''                                                             read_port3_icv_key_1d
''                                                             write_port3_icv_key_1d
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port3_1d
    Private write_port3_icv_key_1d_value
    Private read_port3_icv_key_1d_value
    Private flag_port3_icv_key_1d

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

    Property Get get_port3_icv_key_1d
        get_port3_icv_key_1d = read_port3_icv_key_1d_value
    End Property

    Property Let set_port3_icv_key_1d(aData)
        write_port3_icv_key_1d_value = aData
        flag_port3_icv_key_1d        = &H1
    End Property

    Property Get read_port3_icv_key_1d
        read
        read_port3_icv_key_1d = read_port3_icv_key_1d_value
    End Property

    Property Let write_port3_icv_key_1d(aData)
        set_port3_icv_key_1d = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port3_icv_key_1d_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port3_icv_key_1d_mask = mask then
                read_port3_icv_key_1d_value = data_low
            else
                read_port3_icv_key_1d_value = (data_low - H8000_0000) and port3_icv_key_1d_mask
            end If
        else
            read_port3_icv_key_1d_value = data_low and port3_icv_key_1d_mask
        end If

    End Sub

    Sub write
        If flag_port3_icv_key_1d = &H0 Then read
        If flag_port3_icv_key_1d = &H0 Then write_port3_icv_key_1d_value = get_port3_icv_key_1d

        regValue = leftShift(write_port3_icv_key_1d_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port3_icv_key_1d_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port3_icv_key_1d_mask = mask then
                read_port3_icv_key_1d_value = data_low
            else
                read_port3_icv_key_1d_value = (data_low - H8000_0000) and port3_icv_key_1d_mask
            end If
        else
            read_port3_icv_key_1d_value = data_low and port3_icv_key_1d_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_port3_icv_key_1d_value = &H0
        flag_port3_icv_key_1d        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port3_1e
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port3_1e

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

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low

    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port3_2a
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' port3_icv_key_2a                           [31:0]           get_port3_icv_key_2a
''                                                             set_port3_icv_key_2a
''                                                             read_port3_icv_key_2a
''                                                             write_port3_icv_key_2a
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port3_2a
    Private write_port3_icv_key_2a_value
    Private read_port3_icv_key_2a_value
    Private flag_port3_icv_key_2a

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

    Property Get get_port3_icv_key_2a
        get_port3_icv_key_2a = read_port3_icv_key_2a_value
    End Property

    Property Let set_port3_icv_key_2a(aData)
        write_port3_icv_key_2a_value = aData
        flag_port3_icv_key_2a        = &H1
    End Property

    Property Get read_port3_icv_key_2a
        read
        read_port3_icv_key_2a = read_port3_icv_key_2a_value
    End Property

    Property Let write_port3_icv_key_2a(aData)
        set_port3_icv_key_2a = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port3_icv_key_2a_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port3_icv_key_2a_mask = mask then
                read_port3_icv_key_2a_value = data_low
            else
                read_port3_icv_key_2a_value = (data_low - H8000_0000) and port3_icv_key_2a_mask
            end If
        else
            read_port3_icv_key_2a_value = data_low and port3_icv_key_2a_mask
        end If

    End Sub

    Sub write
        If flag_port3_icv_key_2a = &H0 Then read
        If flag_port3_icv_key_2a = &H0 Then write_port3_icv_key_2a_value = get_port3_icv_key_2a

        regValue = leftShift(write_port3_icv_key_2a_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port3_icv_key_2a_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port3_icv_key_2a_mask = mask then
                read_port3_icv_key_2a_value = data_low
            else
                read_port3_icv_key_2a_value = (data_low - H8000_0000) and port3_icv_key_2a_mask
            end If
        else
            read_port3_icv_key_2a_value = data_low and port3_icv_key_2a_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_port3_icv_key_2a_value = &H0
        flag_port3_icv_key_2a        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port3_2b
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' port3_icv_key_2b                           [31:0]           get_port3_icv_key_2b
''                                                             set_port3_icv_key_2b
''                                                             read_port3_icv_key_2b
''                                                             write_port3_icv_key_2b
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port3_2b
    Private write_port3_icv_key_2b_value
    Private read_port3_icv_key_2b_value
    Private flag_port3_icv_key_2b

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H13c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_port3_icv_key_2b
        get_port3_icv_key_2b = read_port3_icv_key_2b_value
    End Property

    Property Let set_port3_icv_key_2b(aData)
        write_port3_icv_key_2b_value = aData
        flag_port3_icv_key_2b        = &H1
    End Property

    Property Get read_port3_icv_key_2b
        read
        read_port3_icv_key_2b = read_port3_icv_key_2b_value
    End Property

    Property Let write_port3_icv_key_2b(aData)
        set_port3_icv_key_2b = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port3_icv_key_2b_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port3_icv_key_2b_mask = mask then
                read_port3_icv_key_2b_value = data_low
            else
                read_port3_icv_key_2b_value = (data_low - H8000_0000) and port3_icv_key_2b_mask
            end If
        else
            read_port3_icv_key_2b_value = data_low and port3_icv_key_2b_mask
        end If

    End Sub

    Sub write
        If flag_port3_icv_key_2b = &H0 Then read
        If flag_port3_icv_key_2b = &H0 Then write_port3_icv_key_2b_value = get_port3_icv_key_2b

        regValue = leftShift(write_port3_icv_key_2b_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port3_icv_key_2b_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port3_icv_key_2b_mask = mask then
                read_port3_icv_key_2b_value = data_low
            else
                read_port3_icv_key_2b_value = (data_low - H8000_0000) and port3_icv_key_2b_mask
            end If
        else
            read_port3_icv_key_2b_value = data_low and port3_icv_key_2b_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_port3_icv_key_2b_value = &H0
        flag_port3_icv_key_2b        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port3_2c
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' port3_icv_key_2c                           [31:0]           get_port3_icv_key_2c
''                                                             set_port3_icv_key_2c
''                                                             read_port3_icv_key_2c
''                                                             write_port3_icv_key_2c
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port3_2c
    Private write_port3_icv_key_2c_value
    Private read_port3_icv_key_2c_value
    Private flag_port3_icv_key_2c

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H140
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_port3_icv_key_2c
        get_port3_icv_key_2c = read_port3_icv_key_2c_value
    End Property

    Property Let set_port3_icv_key_2c(aData)
        write_port3_icv_key_2c_value = aData
        flag_port3_icv_key_2c        = &H1
    End Property

    Property Get read_port3_icv_key_2c
        read
        read_port3_icv_key_2c = read_port3_icv_key_2c_value
    End Property

    Property Let write_port3_icv_key_2c(aData)
        set_port3_icv_key_2c = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port3_icv_key_2c_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port3_icv_key_2c_mask = mask then
                read_port3_icv_key_2c_value = data_low
            else
                read_port3_icv_key_2c_value = (data_low - H8000_0000) and port3_icv_key_2c_mask
            end If
        else
            read_port3_icv_key_2c_value = data_low and port3_icv_key_2c_mask
        end If

    End Sub

    Sub write
        If flag_port3_icv_key_2c = &H0 Then read
        If flag_port3_icv_key_2c = &H0 Then write_port3_icv_key_2c_value = get_port3_icv_key_2c

        regValue = leftShift(write_port3_icv_key_2c_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port3_icv_key_2c_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port3_icv_key_2c_mask = mask then
                read_port3_icv_key_2c_value = data_low
            else
                read_port3_icv_key_2c_value = (data_low - H8000_0000) and port3_icv_key_2c_mask
            end If
        else
            read_port3_icv_key_2c_value = data_low and port3_icv_key_2c_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_port3_icv_key_2c_value = &H0
        flag_port3_icv_key_2c        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port3_2d
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' port3_icv_key_2d                           [31:0]           get_port3_icv_key_2d
''                                                             set_port3_icv_key_2d
''                                                             read_port3_icv_key_2d
''                                                             write_port3_icv_key_2d
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port3_2d
    Private write_port3_icv_key_2d_value
    Private read_port3_icv_key_2d_value
    Private flag_port3_icv_key_2d

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H144
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_port3_icv_key_2d
        get_port3_icv_key_2d = read_port3_icv_key_2d_value
    End Property

    Property Let set_port3_icv_key_2d(aData)
        write_port3_icv_key_2d_value = aData
        flag_port3_icv_key_2d        = &H1
    End Property

    Property Get read_port3_icv_key_2d
        read
        read_port3_icv_key_2d = read_port3_icv_key_2d_value
    End Property

    Property Let write_port3_icv_key_2d(aData)
        set_port3_icv_key_2d = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port3_icv_key_2d_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port3_icv_key_2d_mask = mask then
                read_port3_icv_key_2d_value = data_low
            else
                read_port3_icv_key_2d_value = (data_low - H8000_0000) and port3_icv_key_2d_mask
            end If
        else
            read_port3_icv_key_2d_value = data_low and port3_icv_key_2d_mask
        end If

    End Sub

    Sub write
        If flag_port3_icv_key_2d = &H0 Then read
        If flag_port3_icv_key_2d = &H0 Then write_port3_icv_key_2d_value = get_port3_icv_key_2d

        regValue = leftShift(write_port3_icv_key_2d_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port3_icv_key_2d_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port3_icv_key_2d_mask = mask then
                read_port3_icv_key_2d_value = data_low
            else
                read_port3_icv_key_2d_value = (data_low - H8000_0000) and port3_icv_key_2d_mask
            end If
        else
            read_port3_icv_key_2d_value = data_low and port3_icv_key_2d_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_port3_icv_key_2d_value = &H0
        flag_port3_icv_key_2d        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port3_2e
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port3_2e

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H148
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low

    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port3_3a
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' port3_icv_key_3a                           [31:0]           get_port3_icv_key_3a
''                                                             set_port3_icv_key_3a
''                                                             read_port3_icv_key_3a
''                                                             write_port3_icv_key_3a
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port3_3a
    Private write_port3_icv_key_3a_value
    Private read_port3_icv_key_3a_value
    Private flag_port3_icv_key_3a

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H14c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_port3_icv_key_3a
        get_port3_icv_key_3a = read_port3_icv_key_3a_value
    End Property

    Property Let set_port3_icv_key_3a(aData)
        write_port3_icv_key_3a_value = aData
        flag_port3_icv_key_3a        = &H1
    End Property

    Property Get read_port3_icv_key_3a
        read
        read_port3_icv_key_3a = read_port3_icv_key_3a_value
    End Property

    Property Let write_port3_icv_key_3a(aData)
        set_port3_icv_key_3a = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port3_icv_key_3a_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port3_icv_key_3a_mask = mask then
                read_port3_icv_key_3a_value = data_low
            else
                read_port3_icv_key_3a_value = (data_low - H8000_0000) and port3_icv_key_3a_mask
            end If
        else
            read_port3_icv_key_3a_value = data_low and port3_icv_key_3a_mask
        end If

    End Sub

    Sub write
        If flag_port3_icv_key_3a = &H0 Then read
        If flag_port3_icv_key_3a = &H0 Then write_port3_icv_key_3a_value = get_port3_icv_key_3a

        regValue = leftShift(write_port3_icv_key_3a_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port3_icv_key_3a_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port3_icv_key_3a_mask = mask then
                read_port3_icv_key_3a_value = data_low
            else
                read_port3_icv_key_3a_value = (data_low - H8000_0000) and port3_icv_key_3a_mask
            end If
        else
            read_port3_icv_key_3a_value = data_low and port3_icv_key_3a_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_port3_icv_key_3a_value = &H0
        flag_port3_icv_key_3a        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port3_3b
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' port3_icv_key_3b                           [31:0]           get_port3_icv_key_3b
''                                                             set_port3_icv_key_3b
''                                                             read_port3_icv_key_3b
''                                                             write_port3_icv_key_3b
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port3_3b
    Private write_port3_icv_key_3b_value
    Private read_port3_icv_key_3b_value
    Private flag_port3_icv_key_3b

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H150
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_port3_icv_key_3b
        get_port3_icv_key_3b = read_port3_icv_key_3b_value
    End Property

    Property Let set_port3_icv_key_3b(aData)
        write_port3_icv_key_3b_value = aData
        flag_port3_icv_key_3b        = &H1
    End Property

    Property Get read_port3_icv_key_3b
        read
        read_port3_icv_key_3b = read_port3_icv_key_3b_value
    End Property

    Property Let write_port3_icv_key_3b(aData)
        set_port3_icv_key_3b = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port3_icv_key_3b_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port3_icv_key_3b_mask = mask then
                read_port3_icv_key_3b_value = data_low
            else
                read_port3_icv_key_3b_value = (data_low - H8000_0000) and port3_icv_key_3b_mask
            end If
        else
            read_port3_icv_key_3b_value = data_low and port3_icv_key_3b_mask
        end If

    End Sub

    Sub write
        If flag_port3_icv_key_3b = &H0 Then read
        If flag_port3_icv_key_3b = &H0 Then write_port3_icv_key_3b_value = get_port3_icv_key_3b

        regValue = leftShift(write_port3_icv_key_3b_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port3_icv_key_3b_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port3_icv_key_3b_mask = mask then
                read_port3_icv_key_3b_value = data_low
            else
                read_port3_icv_key_3b_value = (data_low - H8000_0000) and port3_icv_key_3b_mask
            end If
        else
            read_port3_icv_key_3b_value = data_low and port3_icv_key_3b_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_port3_icv_key_3b_value = &H0
        flag_port3_icv_key_3b        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port3_3c
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' port3_icv_key_3c                           [31:0]           get_port3_icv_key_3c
''                                                             set_port3_icv_key_3c
''                                                             read_port3_icv_key_3c
''                                                             write_port3_icv_key_3c
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port3_3c
    Private write_port3_icv_key_3c_value
    Private read_port3_icv_key_3c_value
    Private flag_port3_icv_key_3c

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H154
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_port3_icv_key_3c
        get_port3_icv_key_3c = read_port3_icv_key_3c_value
    End Property

    Property Let set_port3_icv_key_3c(aData)
        write_port3_icv_key_3c_value = aData
        flag_port3_icv_key_3c        = &H1
    End Property

    Property Get read_port3_icv_key_3c
        read
        read_port3_icv_key_3c = read_port3_icv_key_3c_value
    End Property

    Property Let write_port3_icv_key_3c(aData)
        set_port3_icv_key_3c = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port3_icv_key_3c_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port3_icv_key_3c_mask = mask then
                read_port3_icv_key_3c_value = data_low
            else
                read_port3_icv_key_3c_value = (data_low - H8000_0000) and port3_icv_key_3c_mask
            end If
        else
            read_port3_icv_key_3c_value = data_low and port3_icv_key_3c_mask
        end If

    End Sub

    Sub write
        If flag_port3_icv_key_3c = &H0 Then read
        If flag_port3_icv_key_3c = &H0 Then write_port3_icv_key_3c_value = get_port3_icv_key_3c

        regValue = leftShift(write_port3_icv_key_3c_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port3_icv_key_3c_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port3_icv_key_3c_mask = mask then
                read_port3_icv_key_3c_value = data_low
            else
                read_port3_icv_key_3c_value = (data_low - H8000_0000) and port3_icv_key_3c_mask
            end If
        else
            read_port3_icv_key_3c_value = data_low and port3_icv_key_3c_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_port3_icv_key_3c_value = &H0
        flag_port3_icv_key_3c        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port3_3d
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' port3_icv_key_3d                           [31:0]           get_port3_icv_key_3d
''                                                             set_port3_icv_key_3d
''                                                             read_port3_icv_key_3d
''                                                             write_port3_icv_key_3d
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port3_3d
    Private write_port3_icv_key_3d_value
    Private read_port3_icv_key_3d_value
    Private flag_port3_icv_key_3d

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H158
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_port3_icv_key_3d
        get_port3_icv_key_3d = read_port3_icv_key_3d_value
    End Property

    Property Let set_port3_icv_key_3d(aData)
        write_port3_icv_key_3d_value = aData
        flag_port3_icv_key_3d        = &H1
    End Property

    Property Get read_port3_icv_key_3d
        read
        read_port3_icv_key_3d = read_port3_icv_key_3d_value
    End Property

    Property Let write_port3_icv_key_3d(aData)
        set_port3_icv_key_3d = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port3_icv_key_3d_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port3_icv_key_3d_mask = mask then
                read_port3_icv_key_3d_value = data_low
            else
                read_port3_icv_key_3d_value = (data_low - H8000_0000) and port3_icv_key_3d_mask
            end If
        else
            read_port3_icv_key_3d_value = data_low and port3_icv_key_3d_mask
        end If

    End Sub

    Sub write
        If flag_port3_icv_key_3d = &H0 Then read
        If flag_port3_icv_key_3d = &H0 Then write_port3_icv_key_3d_value = get_port3_icv_key_3d

        regValue = leftShift(write_port3_icv_key_3d_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port3_icv_key_3d_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port3_icv_key_3d_mask = mask then
                read_port3_icv_key_3d_value = data_low
            else
                read_port3_icv_key_3d_value = (data_low - H8000_0000) and port3_icv_key_3d_mask
            end If
        else
            read_port3_icv_key_3d_value = data_low and port3_icv_key_3d_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_port3_icv_key_3d_value = &H0
        flag_port3_icv_key_3d        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port3_3e
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port3_3e

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H15c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low

    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port4_0a
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' port4_icv_key_0a                           [31:0]           get_port4_icv_key_0a
''                                                             set_port4_icv_key_0a
''                                                             read_port4_icv_key_0a
''                                                             write_port4_icv_key_0a
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port4_0a
    Private write_port4_icv_key_0a_value
    Private read_port4_icv_key_0a_value
    Private flag_port4_icv_key_0a

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H200
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_port4_icv_key_0a
        get_port4_icv_key_0a = read_port4_icv_key_0a_value
    End Property

    Property Let set_port4_icv_key_0a(aData)
        write_port4_icv_key_0a_value = aData
        flag_port4_icv_key_0a        = &H1
    End Property

    Property Get read_port4_icv_key_0a
        read
        read_port4_icv_key_0a = read_port4_icv_key_0a_value
    End Property

    Property Let write_port4_icv_key_0a(aData)
        set_port4_icv_key_0a = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port4_icv_key_0a_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port4_icv_key_0a_mask = mask then
                read_port4_icv_key_0a_value = data_low
            else
                read_port4_icv_key_0a_value = (data_low - H8000_0000) and port4_icv_key_0a_mask
            end If
        else
            read_port4_icv_key_0a_value = data_low and port4_icv_key_0a_mask
        end If

    End Sub

    Sub write
        If flag_port4_icv_key_0a = &H0 Then read
        If flag_port4_icv_key_0a = &H0 Then write_port4_icv_key_0a_value = get_port4_icv_key_0a

        regValue = leftShift(write_port4_icv_key_0a_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port4_icv_key_0a_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port4_icv_key_0a_mask = mask then
                read_port4_icv_key_0a_value = data_low
            else
                read_port4_icv_key_0a_value = (data_low - H8000_0000) and port4_icv_key_0a_mask
            end If
        else
            read_port4_icv_key_0a_value = data_low and port4_icv_key_0a_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_port4_icv_key_0a_value = &H0
        flag_port4_icv_key_0a        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port4_0b
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' port4_icv_key_0b                           [31:0]           get_port4_icv_key_0b
''                                                             set_port4_icv_key_0b
''                                                             read_port4_icv_key_0b
''                                                             write_port4_icv_key_0b
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port4_0b
    Private write_port4_icv_key_0b_value
    Private read_port4_icv_key_0b_value
    Private flag_port4_icv_key_0b

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H204
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_port4_icv_key_0b
        get_port4_icv_key_0b = read_port4_icv_key_0b_value
    End Property

    Property Let set_port4_icv_key_0b(aData)
        write_port4_icv_key_0b_value = aData
        flag_port4_icv_key_0b        = &H1
    End Property

    Property Get read_port4_icv_key_0b
        read
        read_port4_icv_key_0b = read_port4_icv_key_0b_value
    End Property

    Property Let write_port4_icv_key_0b(aData)
        set_port4_icv_key_0b = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port4_icv_key_0b_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port4_icv_key_0b_mask = mask then
                read_port4_icv_key_0b_value = data_low
            else
                read_port4_icv_key_0b_value = (data_low - H8000_0000) and port4_icv_key_0b_mask
            end If
        else
            read_port4_icv_key_0b_value = data_low and port4_icv_key_0b_mask
        end If

    End Sub

    Sub write
        If flag_port4_icv_key_0b = &H0 Then read
        If flag_port4_icv_key_0b = &H0 Then write_port4_icv_key_0b_value = get_port4_icv_key_0b

        regValue = leftShift(write_port4_icv_key_0b_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port4_icv_key_0b_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port4_icv_key_0b_mask = mask then
                read_port4_icv_key_0b_value = data_low
            else
                read_port4_icv_key_0b_value = (data_low - H8000_0000) and port4_icv_key_0b_mask
            end If
        else
            read_port4_icv_key_0b_value = data_low and port4_icv_key_0b_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_port4_icv_key_0b_value = &H0
        flag_port4_icv_key_0b        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port4_0c
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' port4_icv_key_0c                           [31:0]           get_port4_icv_key_0c
''                                                             set_port4_icv_key_0c
''                                                             read_port4_icv_key_0c
''                                                             write_port4_icv_key_0c
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port4_0c
    Private write_port4_icv_key_0c_value
    Private read_port4_icv_key_0c_value
    Private flag_port4_icv_key_0c

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H208
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_port4_icv_key_0c
        get_port4_icv_key_0c = read_port4_icv_key_0c_value
    End Property

    Property Let set_port4_icv_key_0c(aData)
        write_port4_icv_key_0c_value = aData
        flag_port4_icv_key_0c        = &H1
    End Property

    Property Get read_port4_icv_key_0c
        read
        read_port4_icv_key_0c = read_port4_icv_key_0c_value
    End Property

    Property Let write_port4_icv_key_0c(aData)
        set_port4_icv_key_0c = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port4_icv_key_0c_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port4_icv_key_0c_mask = mask then
                read_port4_icv_key_0c_value = data_low
            else
                read_port4_icv_key_0c_value = (data_low - H8000_0000) and port4_icv_key_0c_mask
            end If
        else
            read_port4_icv_key_0c_value = data_low and port4_icv_key_0c_mask
        end If

    End Sub

    Sub write
        If flag_port4_icv_key_0c = &H0 Then read
        If flag_port4_icv_key_0c = &H0 Then write_port4_icv_key_0c_value = get_port4_icv_key_0c

        regValue = leftShift(write_port4_icv_key_0c_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port4_icv_key_0c_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port4_icv_key_0c_mask = mask then
                read_port4_icv_key_0c_value = data_low
            else
                read_port4_icv_key_0c_value = (data_low - H8000_0000) and port4_icv_key_0c_mask
            end If
        else
            read_port4_icv_key_0c_value = data_low and port4_icv_key_0c_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_port4_icv_key_0c_value = &H0
        flag_port4_icv_key_0c        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port4_0d
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' port4_icv_key_0d                           [31:0]           get_port4_icv_key_0d
''                                                             set_port4_icv_key_0d
''                                                             read_port4_icv_key_0d
''                                                             write_port4_icv_key_0d
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port4_0d
    Private write_port4_icv_key_0d_value
    Private read_port4_icv_key_0d_value
    Private flag_port4_icv_key_0d

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H20c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_port4_icv_key_0d
        get_port4_icv_key_0d = read_port4_icv_key_0d_value
    End Property

    Property Let set_port4_icv_key_0d(aData)
        write_port4_icv_key_0d_value = aData
        flag_port4_icv_key_0d        = &H1
    End Property

    Property Get read_port4_icv_key_0d
        read
        read_port4_icv_key_0d = read_port4_icv_key_0d_value
    End Property

    Property Let write_port4_icv_key_0d(aData)
        set_port4_icv_key_0d = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port4_icv_key_0d_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port4_icv_key_0d_mask = mask then
                read_port4_icv_key_0d_value = data_low
            else
                read_port4_icv_key_0d_value = (data_low - H8000_0000) and port4_icv_key_0d_mask
            end If
        else
            read_port4_icv_key_0d_value = data_low and port4_icv_key_0d_mask
        end If

    End Sub

    Sub write
        If flag_port4_icv_key_0d = &H0 Then read
        If flag_port4_icv_key_0d = &H0 Then write_port4_icv_key_0d_value = get_port4_icv_key_0d

        regValue = leftShift(write_port4_icv_key_0d_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port4_icv_key_0d_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port4_icv_key_0d_mask = mask then
                read_port4_icv_key_0d_value = data_low
            else
                read_port4_icv_key_0d_value = (data_low - H8000_0000) and port4_icv_key_0d_mask
            end If
        else
            read_port4_icv_key_0d_value = data_low and port4_icv_key_0d_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_port4_icv_key_0d_value = &H0
        flag_port4_icv_key_0d        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port4_0e
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port4_0e

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H210
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low

    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port4_1a
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' port4_icv_key_1a                           [31:0]           get_port4_icv_key_1a
''                                                             set_port4_icv_key_1a
''                                                             read_port4_icv_key_1a
''                                                             write_port4_icv_key_1a
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port4_1a
    Private write_port4_icv_key_1a_value
    Private read_port4_icv_key_1a_value
    Private flag_port4_icv_key_1a

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H214
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_port4_icv_key_1a
        get_port4_icv_key_1a = read_port4_icv_key_1a_value
    End Property

    Property Let set_port4_icv_key_1a(aData)
        write_port4_icv_key_1a_value = aData
        flag_port4_icv_key_1a        = &H1
    End Property

    Property Get read_port4_icv_key_1a
        read
        read_port4_icv_key_1a = read_port4_icv_key_1a_value
    End Property

    Property Let write_port4_icv_key_1a(aData)
        set_port4_icv_key_1a = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port4_icv_key_1a_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port4_icv_key_1a_mask = mask then
                read_port4_icv_key_1a_value = data_low
            else
                read_port4_icv_key_1a_value = (data_low - H8000_0000) and port4_icv_key_1a_mask
            end If
        else
            read_port4_icv_key_1a_value = data_low and port4_icv_key_1a_mask
        end If

    End Sub

    Sub write
        If flag_port4_icv_key_1a = &H0 Then read
        If flag_port4_icv_key_1a = &H0 Then write_port4_icv_key_1a_value = get_port4_icv_key_1a

        regValue = leftShift(write_port4_icv_key_1a_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port4_icv_key_1a_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port4_icv_key_1a_mask = mask then
                read_port4_icv_key_1a_value = data_low
            else
                read_port4_icv_key_1a_value = (data_low - H8000_0000) and port4_icv_key_1a_mask
            end If
        else
            read_port4_icv_key_1a_value = data_low and port4_icv_key_1a_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_port4_icv_key_1a_value = &H0
        flag_port4_icv_key_1a        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port4_1b
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' port4_icv_key_1b                           [31:0]           get_port4_icv_key_1b
''                                                             set_port4_icv_key_1b
''                                                             read_port4_icv_key_1b
''                                                             write_port4_icv_key_1b
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port4_1b
    Private write_port4_icv_key_1b_value
    Private read_port4_icv_key_1b_value
    Private flag_port4_icv_key_1b

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H218
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_port4_icv_key_1b
        get_port4_icv_key_1b = read_port4_icv_key_1b_value
    End Property

    Property Let set_port4_icv_key_1b(aData)
        write_port4_icv_key_1b_value = aData
        flag_port4_icv_key_1b        = &H1
    End Property

    Property Get read_port4_icv_key_1b
        read
        read_port4_icv_key_1b = read_port4_icv_key_1b_value
    End Property

    Property Let write_port4_icv_key_1b(aData)
        set_port4_icv_key_1b = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port4_icv_key_1b_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port4_icv_key_1b_mask = mask then
                read_port4_icv_key_1b_value = data_low
            else
                read_port4_icv_key_1b_value = (data_low - H8000_0000) and port4_icv_key_1b_mask
            end If
        else
            read_port4_icv_key_1b_value = data_low and port4_icv_key_1b_mask
        end If

    End Sub

    Sub write
        If flag_port4_icv_key_1b = &H0 Then read
        If flag_port4_icv_key_1b = &H0 Then write_port4_icv_key_1b_value = get_port4_icv_key_1b

        regValue = leftShift(write_port4_icv_key_1b_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port4_icv_key_1b_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port4_icv_key_1b_mask = mask then
                read_port4_icv_key_1b_value = data_low
            else
                read_port4_icv_key_1b_value = (data_low - H8000_0000) and port4_icv_key_1b_mask
            end If
        else
            read_port4_icv_key_1b_value = data_low and port4_icv_key_1b_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_port4_icv_key_1b_value = &H0
        flag_port4_icv_key_1b        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port4_1c
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' port4_icv_key_1c                           [31:0]           get_port4_icv_key_1c
''                                                             set_port4_icv_key_1c
''                                                             read_port4_icv_key_1c
''                                                             write_port4_icv_key_1c
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port4_1c
    Private write_port4_icv_key_1c_value
    Private read_port4_icv_key_1c_value
    Private flag_port4_icv_key_1c

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H21c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_port4_icv_key_1c
        get_port4_icv_key_1c = read_port4_icv_key_1c_value
    End Property

    Property Let set_port4_icv_key_1c(aData)
        write_port4_icv_key_1c_value = aData
        flag_port4_icv_key_1c        = &H1
    End Property

    Property Get read_port4_icv_key_1c
        read
        read_port4_icv_key_1c = read_port4_icv_key_1c_value
    End Property

    Property Let write_port4_icv_key_1c(aData)
        set_port4_icv_key_1c = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port4_icv_key_1c_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port4_icv_key_1c_mask = mask then
                read_port4_icv_key_1c_value = data_low
            else
                read_port4_icv_key_1c_value = (data_low - H8000_0000) and port4_icv_key_1c_mask
            end If
        else
            read_port4_icv_key_1c_value = data_low and port4_icv_key_1c_mask
        end If

    End Sub

    Sub write
        If flag_port4_icv_key_1c = &H0 Then read
        If flag_port4_icv_key_1c = &H0 Then write_port4_icv_key_1c_value = get_port4_icv_key_1c

        regValue = leftShift(write_port4_icv_key_1c_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port4_icv_key_1c_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port4_icv_key_1c_mask = mask then
                read_port4_icv_key_1c_value = data_low
            else
                read_port4_icv_key_1c_value = (data_low - H8000_0000) and port4_icv_key_1c_mask
            end If
        else
            read_port4_icv_key_1c_value = data_low and port4_icv_key_1c_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_port4_icv_key_1c_value = &H0
        flag_port4_icv_key_1c        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port4_1d
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' port4_icv_key_1d                           [31:0]           get_port4_icv_key_1d
''                                                             set_port4_icv_key_1d
''                                                             read_port4_icv_key_1d
''                                                             write_port4_icv_key_1d
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port4_1d
    Private write_port4_icv_key_1d_value
    Private read_port4_icv_key_1d_value
    Private flag_port4_icv_key_1d

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H220
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_port4_icv_key_1d
        get_port4_icv_key_1d = read_port4_icv_key_1d_value
    End Property

    Property Let set_port4_icv_key_1d(aData)
        write_port4_icv_key_1d_value = aData
        flag_port4_icv_key_1d        = &H1
    End Property

    Property Get read_port4_icv_key_1d
        read
        read_port4_icv_key_1d = read_port4_icv_key_1d_value
    End Property

    Property Let write_port4_icv_key_1d(aData)
        set_port4_icv_key_1d = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port4_icv_key_1d_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port4_icv_key_1d_mask = mask then
                read_port4_icv_key_1d_value = data_low
            else
                read_port4_icv_key_1d_value = (data_low - H8000_0000) and port4_icv_key_1d_mask
            end If
        else
            read_port4_icv_key_1d_value = data_low and port4_icv_key_1d_mask
        end If

    End Sub

    Sub write
        If flag_port4_icv_key_1d = &H0 Then read
        If flag_port4_icv_key_1d = &H0 Then write_port4_icv_key_1d_value = get_port4_icv_key_1d

        regValue = leftShift(write_port4_icv_key_1d_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port4_icv_key_1d_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port4_icv_key_1d_mask = mask then
                read_port4_icv_key_1d_value = data_low
            else
                read_port4_icv_key_1d_value = (data_low - H8000_0000) and port4_icv_key_1d_mask
            end If
        else
            read_port4_icv_key_1d_value = data_low and port4_icv_key_1d_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_port4_icv_key_1d_value = &H0
        flag_port4_icv_key_1d        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port4_1e
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port4_1e

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H224
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low

    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port4_2a
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' port4_icv_key_2a                           [31:0]           get_port4_icv_key_2a
''                                                             set_port4_icv_key_2a
''                                                             read_port4_icv_key_2a
''                                                             write_port4_icv_key_2a
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port4_2a
    Private write_port4_icv_key_2a_value
    Private read_port4_icv_key_2a_value
    Private flag_port4_icv_key_2a

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H228
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_port4_icv_key_2a
        get_port4_icv_key_2a = read_port4_icv_key_2a_value
    End Property

    Property Let set_port4_icv_key_2a(aData)
        write_port4_icv_key_2a_value = aData
        flag_port4_icv_key_2a        = &H1
    End Property

    Property Get read_port4_icv_key_2a
        read
        read_port4_icv_key_2a = read_port4_icv_key_2a_value
    End Property

    Property Let write_port4_icv_key_2a(aData)
        set_port4_icv_key_2a = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port4_icv_key_2a_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port4_icv_key_2a_mask = mask then
                read_port4_icv_key_2a_value = data_low
            else
                read_port4_icv_key_2a_value = (data_low - H8000_0000) and port4_icv_key_2a_mask
            end If
        else
            read_port4_icv_key_2a_value = data_low and port4_icv_key_2a_mask
        end If

    End Sub

    Sub write
        If flag_port4_icv_key_2a = &H0 Then read
        If flag_port4_icv_key_2a = &H0 Then write_port4_icv_key_2a_value = get_port4_icv_key_2a

        regValue = leftShift(write_port4_icv_key_2a_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port4_icv_key_2a_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port4_icv_key_2a_mask = mask then
                read_port4_icv_key_2a_value = data_low
            else
                read_port4_icv_key_2a_value = (data_low - H8000_0000) and port4_icv_key_2a_mask
            end If
        else
            read_port4_icv_key_2a_value = data_low and port4_icv_key_2a_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_port4_icv_key_2a_value = &H0
        flag_port4_icv_key_2a        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port4_2b
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' port4_icv_key_2b                           [31:0]           get_port4_icv_key_2b
''                                                             set_port4_icv_key_2b
''                                                             read_port4_icv_key_2b
''                                                             write_port4_icv_key_2b
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port4_2b
    Private write_port4_icv_key_2b_value
    Private read_port4_icv_key_2b_value
    Private flag_port4_icv_key_2b

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H22c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_port4_icv_key_2b
        get_port4_icv_key_2b = read_port4_icv_key_2b_value
    End Property

    Property Let set_port4_icv_key_2b(aData)
        write_port4_icv_key_2b_value = aData
        flag_port4_icv_key_2b        = &H1
    End Property

    Property Get read_port4_icv_key_2b
        read
        read_port4_icv_key_2b = read_port4_icv_key_2b_value
    End Property

    Property Let write_port4_icv_key_2b(aData)
        set_port4_icv_key_2b = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port4_icv_key_2b_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port4_icv_key_2b_mask = mask then
                read_port4_icv_key_2b_value = data_low
            else
                read_port4_icv_key_2b_value = (data_low - H8000_0000) and port4_icv_key_2b_mask
            end If
        else
            read_port4_icv_key_2b_value = data_low and port4_icv_key_2b_mask
        end If

    End Sub

    Sub write
        If flag_port4_icv_key_2b = &H0 Then read
        If flag_port4_icv_key_2b = &H0 Then write_port4_icv_key_2b_value = get_port4_icv_key_2b

        regValue = leftShift(write_port4_icv_key_2b_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port4_icv_key_2b_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port4_icv_key_2b_mask = mask then
                read_port4_icv_key_2b_value = data_low
            else
                read_port4_icv_key_2b_value = (data_low - H8000_0000) and port4_icv_key_2b_mask
            end If
        else
            read_port4_icv_key_2b_value = data_low and port4_icv_key_2b_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_port4_icv_key_2b_value = &H0
        flag_port4_icv_key_2b        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port4_2c
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' port4_icv_key_2c                           [31:0]           get_port4_icv_key_2c
''                                                             set_port4_icv_key_2c
''                                                             read_port4_icv_key_2c
''                                                             write_port4_icv_key_2c
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port4_2c
    Private write_port4_icv_key_2c_value
    Private read_port4_icv_key_2c_value
    Private flag_port4_icv_key_2c

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H230
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_port4_icv_key_2c
        get_port4_icv_key_2c = read_port4_icv_key_2c_value
    End Property

    Property Let set_port4_icv_key_2c(aData)
        write_port4_icv_key_2c_value = aData
        flag_port4_icv_key_2c        = &H1
    End Property

    Property Get read_port4_icv_key_2c
        read
        read_port4_icv_key_2c = read_port4_icv_key_2c_value
    End Property

    Property Let write_port4_icv_key_2c(aData)
        set_port4_icv_key_2c = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port4_icv_key_2c_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port4_icv_key_2c_mask = mask then
                read_port4_icv_key_2c_value = data_low
            else
                read_port4_icv_key_2c_value = (data_low - H8000_0000) and port4_icv_key_2c_mask
            end If
        else
            read_port4_icv_key_2c_value = data_low and port4_icv_key_2c_mask
        end If

    End Sub

    Sub write
        If flag_port4_icv_key_2c = &H0 Then read
        If flag_port4_icv_key_2c = &H0 Then write_port4_icv_key_2c_value = get_port4_icv_key_2c

        regValue = leftShift(write_port4_icv_key_2c_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port4_icv_key_2c_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port4_icv_key_2c_mask = mask then
                read_port4_icv_key_2c_value = data_low
            else
                read_port4_icv_key_2c_value = (data_low - H8000_0000) and port4_icv_key_2c_mask
            end If
        else
            read_port4_icv_key_2c_value = data_low and port4_icv_key_2c_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_port4_icv_key_2c_value = &H0
        flag_port4_icv_key_2c        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port4_2d
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' port4_icv_key_2d                           [31:0]           get_port4_icv_key_2d
''                                                             set_port4_icv_key_2d
''                                                             read_port4_icv_key_2d
''                                                             write_port4_icv_key_2d
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port4_2d
    Private write_port4_icv_key_2d_value
    Private read_port4_icv_key_2d_value
    Private flag_port4_icv_key_2d

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H234
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_port4_icv_key_2d
        get_port4_icv_key_2d = read_port4_icv_key_2d_value
    End Property

    Property Let set_port4_icv_key_2d(aData)
        write_port4_icv_key_2d_value = aData
        flag_port4_icv_key_2d        = &H1
    End Property

    Property Get read_port4_icv_key_2d
        read
        read_port4_icv_key_2d = read_port4_icv_key_2d_value
    End Property

    Property Let write_port4_icv_key_2d(aData)
        set_port4_icv_key_2d = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port4_icv_key_2d_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port4_icv_key_2d_mask = mask then
                read_port4_icv_key_2d_value = data_low
            else
                read_port4_icv_key_2d_value = (data_low - H8000_0000) and port4_icv_key_2d_mask
            end If
        else
            read_port4_icv_key_2d_value = data_low and port4_icv_key_2d_mask
        end If

    End Sub

    Sub write
        If flag_port4_icv_key_2d = &H0 Then read
        If flag_port4_icv_key_2d = &H0 Then write_port4_icv_key_2d_value = get_port4_icv_key_2d

        regValue = leftShift(write_port4_icv_key_2d_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port4_icv_key_2d_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port4_icv_key_2d_mask = mask then
                read_port4_icv_key_2d_value = data_low
            else
                read_port4_icv_key_2d_value = (data_low - H8000_0000) and port4_icv_key_2d_mask
            end If
        else
            read_port4_icv_key_2d_value = data_low and port4_icv_key_2d_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_port4_icv_key_2d_value = &H0
        flag_port4_icv_key_2d        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port4_2e
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port4_2e

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H238
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low

    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port4_3a
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' port4_icv_key_3a                           [31:0]           get_port4_icv_key_3a
''                                                             set_port4_icv_key_3a
''                                                             read_port4_icv_key_3a
''                                                             write_port4_icv_key_3a
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port4_3a
    Private write_port4_icv_key_3a_value
    Private read_port4_icv_key_3a_value
    Private flag_port4_icv_key_3a

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H23c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_port4_icv_key_3a
        get_port4_icv_key_3a = read_port4_icv_key_3a_value
    End Property

    Property Let set_port4_icv_key_3a(aData)
        write_port4_icv_key_3a_value = aData
        flag_port4_icv_key_3a        = &H1
    End Property

    Property Get read_port4_icv_key_3a
        read
        read_port4_icv_key_3a = read_port4_icv_key_3a_value
    End Property

    Property Let write_port4_icv_key_3a(aData)
        set_port4_icv_key_3a = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port4_icv_key_3a_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port4_icv_key_3a_mask = mask then
                read_port4_icv_key_3a_value = data_low
            else
                read_port4_icv_key_3a_value = (data_low - H8000_0000) and port4_icv_key_3a_mask
            end If
        else
            read_port4_icv_key_3a_value = data_low and port4_icv_key_3a_mask
        end If

    End Sub

    Sub write
        If flag_port4_icv_key_3a = &H0 Then read
        If flag_port4_icv_key_3a = &H0 Then write_port4_icv_key_3a_value = get_port4_icv_key_3a

        regValue = leftShift(write_port4_icv_key_3a_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port4_icv_key_3a_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port4_icv_key_3a_mask = mask then
                read_port4_icv_key_3a_value = data_low
            else
                read_port4_icv_key_3a_value = (data_low - H8000_0000) and port4_icv_key_3a_mask
            end If
        else
            read_port4_icv_key_3a_value = data_low and port4_icv_key_3a_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_port4_icv_key_3a_value = &H0
        flag_port4_icv_key_3a        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port4_3b
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' port4_icv_key_3b                           [31:0]           get_port4_icv_key_3b
''                                                             set_port4_icv_key_3b
''                                                             read_port4_icv_key_3b
''                                                             write_port4_icv_key_3b
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port4_3b
    Private write_port4_icv_key_3b_value
    Private read_port4_icv_key_3b_value
    Private flag_port4_icv_key_3b

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H240
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_port4_icv_key_3b
        get_port4_icv_key_3b = read_port4_icv_key_3b_value
    End Property

    Property Let set_port4_icv_key_3b(aData)
        write_port4_icv_key_3b_value = aData
        flag_port4_icv_key_3b        = &H1
    End Property

    Property Get read_port4_icv_key_3b
        read
        read_port4_icv_key_3b = read_port4_icv_key_3b_value
    End Property

    Property Let write_port4_icv_key_3b(aData)
        set_port4_icv_key_3b = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port4_icv_key_3b_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port4_icv_key_3b_mask = mask then
                read_port4_icv_key_3b_value = data_low
            else
                read_port4_icv_key_3b_value = (data_low - H8000_0000) and port4_icv_key_3b_mask
            end If
        else
            read_port4_icv_key_3b_value = data_low and port4_icv_key_3b_mask
        end If

    End Sub

    Sub write
        If flag_port4_icv_key_3b = &H0 Then read
        If flag_port4_icv_key_3b = &H0 Then write_port4_icv_key_3b_value = get_port4_icv_key_3b

        regValue = leftShift(write_port4_icv_key_3b_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port4_icv_key_3b_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port4_icv_key_3b_mask = mask then
                read_port4_icv_key_3b_value = data_low
            else
                read_port4_icv_key_3b_value = (data_low - H8000_0000) and port4_icv_key_3b_mask
            end If
        else
            read_port4_icv_key_3b_value = data_low and port4_icv_key_3b_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_port4_icv_key_3b_value = &H0
        flag_port4_icv_key_3b        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port4_3c
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' port4_icv_key_3c                           [31:0]           get_port4_icv_key_3c
''                                                             set_port4_icv_key_3c
''                                                             read_port4_icv_key_3c
''                                                             write_port4_icv_key_3c
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port4_3c
    Private write_port4_icv_key_3c_value
    Private read_port4_icv_key_3c_value
    Private flag_port4_icv_key_3c

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H244
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_port4_icv_key_3c
        get_port4_icv_key_3c = read_port4_icv_key_3c_value
    End Property

    Property Let set_port4_icv_key_3c(aData)
        write_port4_icv_key_3c_value = aData
        flag_port4_icv_key_3c        = &H1
    End Property

    Property Get read_port4_icv_key_3c
        read
        read_port4_icv_key_3c = read_port4_icv_key_3c_value
    End Property

    Property Let write_port4_icv_key_3c(aData)
        set_port4_icv_key_3c = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port4_icv_key_3c_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port4_icv_key_3c_mask = mask then
                read_port4_icv_key_3c_value = data_low
            else
                read_port4_icv_key_3c_value = (data_low - H8000_0000) and port4_icv_key_3c_mask
            end If
        else
            read_port4_icv_key_3c_value = data_low and port4_icv_key_3c_mask
        end If

    End Sub

    Sub write
        If flag_port4_icv_key_3c = &H0 Then read
        If flag_port4_icv_key_3c = &H0 Then write_port4_icv_key_3c_value = get_port4_icv_key_3c

        regValue = leftShift(write_port4_icv_key_3c_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port4_icv_key_3c_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port4_icv_key_3c_mask = mask then
                read_port4_icv_key_3c_value = data_low
            else
                read_port4_icv_key_3c_value = (data_low - H8000_0000) and port4_icv_key_3c_mask
            end If
        else
            read_port4_icv_key_3c_value = data_low and port4_icv_key_3c_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_port4_icv_key_3c_value = &H0
        flag_port4_icv_key_3c        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port4_3d
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' port4_icv_key_3d                           [31:0]           get_port4_icv_key_3d
''                                                             set_port4_icv_key_3d
''                                                             read_port4_icv_key_3d
''                                                             write_port4_icv_key_3d
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port4_3d
    Private write_port4_icv_key_3d_value
    Private read_port4_icv_key_3d_value
    Private flag_port4_icv_key_3d

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H248
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_port4_icv_key_3d
        get_port4_icv_key_3d = read_port4_icv_key_3d_value
    End Property

    Property Let set_port4_icv_key_3d(aData)
        write_port4_icv_key_3d_value = aData
        flag_port4_icv_key_3d        = &H1
    End Property

    Property Get read_port4_icv_key_3d
        read
        read_port4_icv_key_3d = read_port4_icv_key_3d_value
    End Property

    Property Let write_port4_icv_key_3d(aData)
        set_port4_icv_key_3d = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port4_icv_key_3d_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port4_icv_key_3d_mask = mask then
                read_port4_icv_key_3d_value = data_low
            else
                read_port4_icv_key_3d_value = (data_low - H8000_0000) and port4_icv_key_3d_mask
            end If
        else
            read_port4_icv_key_3d_value = data_low and port4_icv_key_3d_mask
        end If

    End Sub

    Sub write
        If flag_port4_icv_key_3d = &H0 Then read
        If flag_port4_icv_key_3d = &H0 Then write_port4_icv_key_3d_value = get_port4_icv_key_3d

        regValue = leftShift(write_port4_icv_key_3d_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port4_icv_key_3d_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port4_icv_key_3d_mask = mask then
                read_port4_icv_key_3d_value = data_low
            else
                read_port4_icv_key_3d_value = (data_low - H8000_0000) and port4_icv_key_3d_mask
            end If
        else
            read_port4_icv_key_3d_value = data_low and port4_icv_key_3d_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_port4_icv_key_3d_value = &H0
        flag_port4_icv_key_3d        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port4_3e
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port4_3e

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H24c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low

    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port5_0a
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' port5_icv_key_0a                           [31:0]           get_port5_icv_key_0a
''                                                             set_port5_icv_key_0a
''                                                             read_port5_icv_key_0a
''                                                             write_port5_icv_key_0a
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port5_0a
    Private write_port5_icv_key_0a_value
    Private read_port5_icv_key_0a_value
    Private flag_port5_icv_key_0a

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H250
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_port5_icv_key_0a
        get_port5_icv_key_0a = read_port5_icv_key_0a_value
    End Property

    Property Let set_port5_icv_key_0a(aData)
        write_port5_icv_key_0a_value = aData
        flag_port5_icv_key_0a        = &H1
    End Property

    Property Get read_port5_icv_key_0a
        read
        read_port5_icv_key_0a = read_port5_icv_key_0a_value
    End Property

    Property Let write_port5_icv_key_0a(aData)
        set_port5_icv_key_0a = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port5_icv_key_0a_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port5_icv_key_0a_mask = mask then
                read_port5_icv_key_0a_value = data_low
            else
                read_port5_icv_key_0a_value = (data_low - H8000_0000) and port5_icv_key_0a_mask
            end If
        else
            read_port5_icv_key_0a_value = data_low and port5_icv_key_0a_mask
        end If

    End Sub

    Sub write
        If flag_port5_icv_key_0a = &H0 Then read
        If flag_port5_icv_key_0a = &H0 Then write_port5_icv_key_0a_value = get_port5_icv_key_0a

        regValue = leftShift(write_port5_icv_key_0a_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port5_icv_key_0a_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port5_icv_key_0a_mask = mask then
                read_port5_icv_key_0a_value = data_low
            else
                read_port5_icv_key_0a_value = (data_low - H8000_0000) and port5_icv_key_0a_mask
            end If
        else
            read_port5_icv_key_0a_value = data_low and port5_icv_key_0a_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_port5_icv_key_0a_value = &H0
        flag_port5_icv_key_0a        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port5_0b
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' port5_icv_key_0b                           [31:0]           get_port5_icv_key_0b
''                                                             set_port5_icv_key_0b
''                                                             read_port5_icv_key_0b
''                                                             write_port5_icv_key_0b
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port5_0b
    Private write_port5_icv_key_0b_value
    Private read_port5_icv_key_0b_value
    Private flag_port5_icv_key_0b

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H254
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_port5_icv_key_0b
        get_port5_icv_key_0b = read_port5_icv_key_0b_value
    End Property

    Property Let set_port5_icv_key_0b(aData)
        write_port5_icv_key_0b_value = aData
        flag_port5_icv_key_0b        = &H1
    End Property

    Property Get read_port5_icv_key_0b
        read
        read_port5_icv_key_0b = read_port5_icv_key_0b_value
    End Property

    Property Let write_port5_icv_key_0b(aData)
        set_port5_icv_key_0b = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port5_icv_key_0b_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port5_icv_key_0b_mask = mask then
                read_port5_icv_key_0b_value = data_low
            else
                read_port5_icv_key_0b_value = (data_low - H8000_0000) and port5_icv_key_0b_mask
            end If
        else
            read_port5_icv_key_0b_value = data_low and port5_icv_key_0b_mask
        end If

    End Sub

    Sub write
        If flag_port5_icv_key_0b = &H0 Then read
        If flag_port5_icv_key_0b = &H0 Then write_port5_icv_key_0b_value = get_port5_icv_key_0b

        regValue = leftShift(write_port5_icv_key_0b_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port5_icv_key_0b_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port5_icv_key_0b_mask = mask then
                read_port5_icv_key_0b_value = data_low
            else
                read_port5_icv_key_0b_value = (data_low - H8000_0000) and port5_icv_key_0b_mask
            end If
        else
            read_port5_icv_key_0b_value = data_low and port5_icv_key_0b_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_port5_icv_key_0b_value = &H0
        flag_port5_icv_key_0b        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port5_0c
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' port5_icv_key_0c                           [31:0]           get_port5_icv_key_0c
''                                                             set_port5_icv_key_0c
''                                                             read_port5_icv_key_0c
''                                                             write_port5_icv_key_0c
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port5_0c
    Private write_port5_icv_key_0c_value
    Private read_port5_icv_key_0c_value
    Private flag_port5_icv_key_0c

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H258
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_port5_icv_key_0c
        get_port5_icv_key_0c = read_port5_icv_key_0c_value
    End Property

    Property Let set_port5_icv_key_0c(aData)
        write_port5_icv_key_0c_value = aData
        flag_port5_icv_key_0c        = &H1
    End Property

    Property Get read_port5_icv_key_0c
        read
        read_port5_icv_key_0c = read_port5_icv_key_0c_value
    End Property

    Property Let write_port5_icv_key_0c(aData)
        set_port5_icv_key_0c = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port5_icv_key_0c_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port5_icv_key_0c_mask = mask then
                read_port5_icv_key_0c_value = data_low
            else
                read_port5_icv_key_0c_value = (data_low - H8000_0000) and port5_icv_key_0c_mask
            end If
        else
            read_port5_icv_key_0c_value = data_low and port5_icv_key_0c_mask
        end If

    End Sub

    Sub write
        If flag_port5_icv_key_0c = &H0 Then read
        If flag_port5_icv_key_0c = &H0 Then write_port5_icv_key_0c_value = get_port5_icv_key_0c

        regValue = leftShift(write_port5_icv_key_0c_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port5_icv_key_0c_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port5_icv_key_0c_mask = mask then
                read_port5_icv_key_0c_value = data_low
            else
                read_port5_icv_key_0c_value = (data_low - H8000_0000) and port5_icv_key_0c_mask
            end If
        else
            read_port5_icv_key_0c_value = data_low and port5_icv_key_0c_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_port5_icv_key_0c_value = &H0
        flag_port5_icv_key_0c        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port5_0d
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' port5_icv_key_0d                           [31:0]           get_port5_icv_key_0d
''                                                             set_port5_icv_key_0d
''                                                             read_port5_icv_key_0d
''                                                             write_port5_icv_key_0d
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port5_0d
    Private write_port5_icv_key_0d_value
    Private read_port5_icv_key_0d_value
    Private flag_port5_icv_key_0d

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H25c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_port5_icv_key_0d
        get_port5_icv_key_0d = read_port5_icv_key_0d_value
    End Property

    Property Let set_port5_icv_key_0d(aData)
        write_port5_icv_key_0d_value = aData
        flag_port5_icv_key_0d        = &H1
    End Property

    Property Get read_port5_icv_key_0d
        read
        read_port5_icv_key_0d = read_port5_icv_key_0d_value
    End Property

    Property Let write_port5_icv_key_0d(aData)
        set_port5_icv_key_0d = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port5_icv_key_0d_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port5_icv_key_0d_mask = mask then
                read_port5_icv_key_0d_value = data_low
            else
                read_port5_icv_key_0d_value = (data_low - H8000_0000) and port5_icv_key_0d_mask
            end If
        else
            read_port5_icv_key_0d_value = data_low and port5_icv_key_0d_mask
        end If

    End Sub

    Sub write
        If flag_port5_icv_key_0d = &H0 Then read
        If flag_port5_icv_key_0d = &H0 Then write_port5_icv_key_0d_value = get_port5_icv_key_0d

        regValue = leftShift(write_port5_icv_key_0d_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port5_icv_key_0d_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port5_icv_key_0d_mask = mask then
                read_port5_icv_key_0d_value = data_low
            else
                read_port5_icv_key_0d_value = (data_low - H8000_0000) and port5_icv_key_0d_mask
            end If
        else
            read_port5_icv_key_0d_value = data_low and port5_icv_key_0d_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_port5_icv_key_0d_value = &H0
        flag_port5_icv_key_0d        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port5_0e
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port5_0e

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H260
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low

    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port5_1a
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' port5_icv_key_1a                           [31:0]           get_port5_icv_key_1a
''                                                             set_port5_icv_key_1a
''                                                             read_port5_icv_key_1a
''                                                             write_port5_icv_key_1a
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port5_1a
    Private write_port5_icv_key_1a_value
    Private read_port5_icv_key_1a_value
    Private flag_port5_icv_key_1a

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H264
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_port5_icv_key_1a
        get_port5_icv_key_1a = read_port5_icv_key_1a_value
    End Property

    Property Let set_port5_icv_key_1a(aData)
        write_port5_icv_key_1a_value = aData
        flag_port5_icv_key_1a        = &H1
    End Property

    Property Get read_port5_icv_key_1a
        read
        read_port5_icv_key_1a = read_port5_icv_key_1a_value
    End Property

    Property Let write_port5_icv_key_1a(aData)
        set_port5_icv_key_1a = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port5_icv_key_1a_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port5_icv_key_1a_mask = mask then
                read_port5_icv_key_1a_value = data_low
            else
                read_port5_icv_key_1a_value = (data_low - H8000_0000) and port5_icv_key_1a_mask
            end If
        else
            read_port5_icv_key_1a_value = data_low and port5_icv_key_1a_mask
        end If

    End Sub

    Sub write
        If flag_port5_icv_key_1a = &H0 Then read
        If flag_port5_icv_key_1a = &H0 Then write_port5_icv_key_1a_value = get_port5_icv_key_1a

        regValue = leftShift(write_port5_icv_key_1a_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port5_icv_key_1a_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port5_icv_key_1a_mask = mask then
                read_port5_icv_key_1a_value = data_low
            else
                read_port5_icv_key_1a_value = (data_low - H8000_0000) and port5_icv_key_1a_mask
            end If
        else
            read_port5_icv_key_1a_value = data_low and port5_icv_key_1a_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_port5_icv_key_1a_value = &H0
        flag_port5_icv_key_1a        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port5_1b
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' port5_icv_key_1b                           [31:0]           get_port5_icv_key_1b
''                                                             set_port5_icv_key_1b
''                                                             read_port5_icv_key_1b
''                                                             write_port5_icv_key_1b
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port5_1b
    Private write_port5_icv_key_1b_value
    Private read_port5_icv_key_1b_value
    Private flag_port5_icv_key_1b

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H268
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_port5_icv_key_1b
        get_port5_icv_key_1b = read_port5_icv_key_1b_value
    End Property

    Property Let set_port5_icv_key_1b(aData)
        write_port5_icv_key_1b_value = aData
        flag_port5_icv_key_1b        = &H1
    End Property

    Property Get read_port5_icv_key_1b
        read
        read_port5_icv_key_1b = read_port5_icv_key_1b_value
    End Property

    Property Let write_port5_icv_key_1b(aData)
        set_port5_icv_key_1b = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port5_icv_key_1b_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port5_icv_key_1b_mask = mask then
                read_port5_icv_key_1b_value = data_low
            else
                read_port5_icv_key_1b_value = (data_low - H8000_0000) and port5_icv_key_1b_mask
            end If
        else
            read_port5_icv_key_1b_value = data_low and port5_icv_key_1b_mask
        end If

    End Sub

    Sub write
        If flag_port5_icv_key_1b = &H0 Then read
        If flag_port5_icv_key_1b = &H0 Then write_port5_icv_key_1b_value = get_port5_icv_key_1b

        regValue = leftShift(write_port5_icv_key_1b_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port5_icv_key_1b_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port5_icv_key_1b_mask = mask then
                read_port5_icv_key_1b_value = data_low
            else
                read_port5_icv_key_1b_value = (data_low - H8000_0000) and port5_icv_key_1b_mask
            end If
        else
            read_port5_icv_key_1b_value = data_low and port5_icv_key_1b_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_port5_icv_key_1b_value = &H0
        flag_port5_icv_key_1b        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port5_1c
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' port5_icv_key_1c                           [31:0]           get_port5_icv_key_1c
''                                                             set_port5_icv_key_1c
''                                                             read_port5_icv_key_1c
''                                                             write_port5_icv_key_1c
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port5_1c
    Private write_port5_icv_key_1c_value
    Private read_port5_icv_key_1c_value
    Private flag_port5_icv_key_1c

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H26c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_port5_icv_key_1c
        get_port5_icv_key_1c = read_port5_icv_key_1c_value
    End Property

    Property Let set_port5_icv_key_1c(aData)
        write_port5_icv_key_1c_value = aData
        flag_port5_icv_key_1c        = &H1
    End Property

    Property Get read_port5_icv_key_1c
        read
        read_port5_icv_key_1c = read_port5_icv_key_1c_value
    End Property

    Property Let write_port5_icv_key_1c(aData)
        set_port5_icv_key_1c = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port5_icv_key_1c_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port5_icv_key_1c_mask = mask then
                read_port5_icv_key_1c_value = data_low
            else
                read_port5_icv_key_1c_value = (data_low - H8000_0000) and port5_icv_key_1c_mask
            end If
        else
            read_port5_icv_key_1c_value = data_low and port5_icv_key_1c_mask
        end If

    End Sub

    Sub write
        If flag_port5_icv_key_1c = &H0 Then read
        If flag_port5_icv_key_1c = &H0 Then write_port5_icv_key_1c_value = get_port5_icv_key_1c

        regValue = leftShift(write_port5_icv_key_1c_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port5_icv_key_1c_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port5_icv_key_1c_mask = mask then
                read_port5_icv_key_1c_value = data_low
            else
                read_port5_icv_key_1c_value = (data_low - H8000_0000) and port5_icv_key_1c_mask
            end If
        else
            read_port5_icv_key_1c_value = data_low and port5_icv_key_1c_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_port5_icv_key_1c_value = &H0
        flag_port5_icv_key_1c        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port5_1d
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' port5_icv_key_1d                           [31:0]           get_port5_icv_key_1d
''                                                             set_port5_icv_key_1d
''                                                             read_port5_icv_key_1d
''                                                             write_port5_icv_key_1d
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port5_1d
    Private write_port5_icv_key_1d_value
    Private read_port5_icv_key_1d_value
    Private flag_port5_icv_key_1d

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H270
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_port5_icv_key_1d
        get_port5_icv_key_1d = read_port5_icv_key_1d_value
    End Property

    Property Let set_port5_icv_key_1d(aData)
        write_port5_icv_key_1d_value = aData
        flag_port5_icv_key_1d        = &H1
    End Property

    Property Get read_port5_icv_key_1d
        read
        read_port5_icv_key_1d = read_port5_icv_key_1d_value
    End Property

    Property Let write_port5_icv_key_1d(aData)
        set_port5_icv_key_1d = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port5_icv_key_1d_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port5_icv_key_1d_mask = mask then
                read_port5_icv_key_1d_value = data_low
            else
                read_port5_icv_key_1d_value = (data_low - H8000_0000) and port5_icv_key_1d_mask
            end If
        else
            read_port5_icv_key_1d_value = data_low and port5_icv_key_1d_mask
        end If

    End Sub

    Sub write
        If flag_port5_icv_key_1d = &H0 Then read
        If flag_port5_icv_key_1d = &H0 Then write_port5_icv_key_1d_value = get_port5_icv_key_1d

        regValue = leftShift(write_port5_icv_key_1d_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port5_icv_key_1d_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port5_icv_key_1d_mask = mask then
                read_port5_icv_key_1d_value = data_low
            else
                read_port5_icv_key_1d_value = (data_low - H8000_0000) and port5_icv_key_1d_mask
            end If
        else
            read_port5_icv_key_1d_value = data_low and port5_icv_key_1d_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_port5_icv_key_1d_value = &H0
        flag_port5_icv_key_1d        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port5_1e
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port5_1e

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H274
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low

    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port5_2a
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' port5_icv_key_2a                           [31:0]           get_port5_icv_key_2a
''                                                             set_port5_icv_key_2a
''                                                             read_port5_icv_key_2a
''                                                             write_port5_icv_key_2a
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port5_2a
    Private write_port5_icv_key_2a_value
    Private read_port5_icv_key_2a_value
    Private flag_port5_icv_key_2a

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H278
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_port5_icv_key_2a
        get_port5_icv_key_2a = read_port5_icv_key_2a_value
    End Property

    Property Let set_port5_icv_key_2a(aData)
        write_port5_icv_key_2a_value = aData
        flag_port5_icv_key_2a        = &H1
    End Property

    Property Get read_port5_icv_key_2a
        read
        read_port5_icv_key_2a = read_port5_icv_key_2a_value
    End Property

    Property Let write_port5_icv_key_2a(aData)
        set_port5_icv_key_2a = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port5_icv_key_2a_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port5_icv_key_2a_mask = mask then
                read_port5_icv_key_2a_value = data_low
            else
                read_port5_icv_key_2a_value = (data_low - H8000_0000) and port5_icv_key_2a_mask
            end If
        else
            read_port5_icv_key_2a_value = data_low and port5_icv_key_2a_mask
        end If

    End Sub

    Sub write
        If flag_port5_icv_key_2a = &H0 Then read
        If flag_port5_icv_key_2a = &H0 Then write_port5_icv_key_2a_value = get_port5_icv_key_2a

        regValue = leftShift(write_port5_icv_key_2a_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port5_icv_key_2a_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port5_icv_key_2a_mask = mask then
                read_port5_icv_key_2a_value = data_low
            else
                read_port5_icv_key_2a_value = (data_low - H8000_0000) and port5_icv_key_2a_mask
            end If
        else
            read_port5_icv_key_2a_value = data_low and port5_icv_key_2a_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_port5_icv_key_2a_value = &H0
        flag_port5_icv_key_2a        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port5_2b
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' port5_icv_key_2b                           [31:0]           get_port5_icv_key_2b
''                                                             set_port5_icv_key_2b
''                                                             read_port5_icv_key_2b
''                                                             write_port5_icv_key_2b
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port5_2b
    Private write_port5_icv_key_2b_value
    Private read_port5_icv_key_2b_value
    Private flag_port5_icv_key_2b

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H27c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_port5_icv_key_2b
        get_port5_icv_key_2b = read_port5_icv_key_2b_value
    End Property

    Property Let set_port5_icv_key_2b(aData)
        write_port5_icv_key_2b_value = aData
        flag_port5_icv_key_2b        = &H1
    End Property

    Property Get read_port5_icv_key_2b
        read
        read_port5_icv_key_2b = read_port5_icv_key_2b_value
    End Property

    Property Let write_port5_icv_key_2b(aData)
        set_port5_icv_key_2b = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port5_icv_key_2b_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port5_icv_key_2b_mask = mask then
                read_port5_icv_key_2b_value = data_low
            else
                read_port5_icv_key_2b_value = (data_low - H8000_0000) and port5_icv_key_2b_mask
            end If
        else
            read_port5_icv_key_2b_value = data_low and port5_icv_key_2b_mask
        end If

    End Sub

    Sub write
        If flag_port5_icv_key_2b = &H0 Then read
        If flag_port5_icv_key_2b = &H0 Then write_port5_icv_key_2b_value = get_port5_icv_key_2b

        regValue = leftShift(write_port5_icv_key_2b_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port5_icv_key_2b_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port5_icv_key_2b_mask = mask then
                read_port5_icv_key_2b_value = data_low
            else
                read_port5_icv_key_2b_value = (data_low - H8000_0000) and port5_icv_key_2b_mask
            end If
        else
            read_port5_icv_key_2b_value = data_low and port5_icv_key_2b_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_port5_icv_key_2b_value = &H0
        flag_port5_icv_key_2b        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port5_2c
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' port5_icv_key_2c                           [31:0]           get_port5_icv_key_2c
''                                                             set_port5_icv_key_2c
''                                                             read_port5_icv_key_2c
''                                                             write_port5_icv_key_2c
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port5_2c
    Private write_port5_icv_key_2c_value
    Private read_port5_icv_key_2c_value
    Private flag_port5_icv_key_2c

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H280
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_port5_icv_key_2c
        get_port5_icv_key_2c = read_port5_icv_key_2c_value
    End Property

    Property Let set_port5_icv_key_2c(aData)
        write_port5_icv_key_2c_value = aData
        flag_port5_icv_key_2c        = &H1
    End Property

    Property Get read_port5_icv_key_2c
        read
        read_port5_icv_key_2c = read_port5_icv_key_2c_value
    End Property

    Property Let write_port5_icv_key_2c(aData)
        set_port5_icv_key_2c = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port5_icv_key_2c_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port5_icv_key_2c_mask = mask then
                read_port5_icv_key_2c_value = data_low
            else
                read_port5_icv_key_2c_value = (data_low - H8000_0000) and port5_icv_key_2c_mask
            end If
        else
            read_port5_icv_key_2c_value = data_low and port5_icv_key_2c_mask
        end If

    End Sub

    Sub write
        If flag_port5_icv_key_2c = &H0 Then read
        If flag_port5_icv_key_2c = &H0 Then write_port5_icv_key_2c_value = get_port5_icv_key_2c

        regValue = leftShift(write_port5_icv_key_2c_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port5_icv_key_2c_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port5_icv_key_2c_mask = mask then
                read_port5_icv_key_2c_value = data_low
            else
                read_port5_icv_key_2c_value = (data_low - H8000_0000) and port5_icv_key_2c_mask
            end If
        else
            read_port5_icv_key_2c_value = data_low and port5_icv_key_2c_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_port5_icv_key_2c_value = &H0
        flag_port5_icv_key_2c        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port5_2d
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' port5_icv_key_2d                           [31:0]           get_port5_icv_key_2d
''                                                             set_port5_icv_key_2d
''                                                             read_port5_icv_key_2d
''                                                             write_port5_icv_key_2d
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port5_2d
    Private write_port5_icv_key_2d_value
    Private read_port5_icv_key_2d_value
    Private flag_port5_icv_key_2d

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H284
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_port5_icv_key_2d
        get_port5_icv_key_2d = read_port5_icv_key_2d_value
    End Property

    Property Let set_port5_icv_key_2d(aData)
        write_port5_icv_key_2d_value = aData
        flag_port5_icv_key_2d        = &H1
    End Property

    Property Get read_port5_icv_key_2d
        read
        read_port5_icv_key_2d = read_port5_icv_key_2d_value
    End Property

    Property Let write_port5_icv_key_2d(aData)
        set_port5_icv_key_2d = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port5_icv_key_2d_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port5_icv_key_2d_mask = mask then
                read_port5_icv_key_2d_value = data_low
            else
                read_port5_icv_key_2d_value = (data_low - H8000_0000) and port5_icv_key_2d_mask
            end If
        else
            read_port5_icv_key_2d_value = data_low and port5_icv_key_2d_mask
        end If

    End Sub

    Sub write
        If flag_port5_icv_key_2d = &H0 Then read
        If flag_port5_icv_key_2d = &H0 Then write_port5_icv_key_2d_value = get_port5_icv_key_2d

        regValue = leftShift(write_port5_icv_key_2d_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port5_icv_key_2d_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port5_icv_key_2d_mask = mask then
                read_port5_icv_key_2d_value = data_low
            else
                read_port5_icv_key_2d_value = (data_low - H8000_0000) and port5_icv_key_2d_mask
            end If
        else
            read_port5_icv_key_2d_value = data_low and port5_icv_key_2d_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_port5_icv_key_2d_value = &H0
        flag_port5_icv_key_2d        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port5_2e
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port5_2e

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H288
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low

    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port5_3a
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' port5_icv_key_3a                           [31:0]           get_port5_icv_key_3a
''                                                             set_port5_icv_key_3a
''                                                             read_port5_icv_key_3a
''                                                             write_port5_icv_key_3a
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port5_3a
    Private write_port5_icv_key_3a_value
    Private read_port5_icv_key_3a_value
    Private flag_port5_icv_key_3a

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H28c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_port5_icv_key_3a
        get_port5_icv_key_3a = read_port5_icv_key_3a_value
    End Property

    Property Let set_port5_icv_key_3a(aData)
        write_port5_icv_key_3a_value = aData
        flag_port5_icv_key_3a        = &H1
    End Property

    Property Get read_port5_icv_key_3a
        read
        read_port5_icv_key_3a = read_port5_icv_key_3a_value
    End Property

    Property Let write_port5_icv_key_3a(aData)
        set_port5_icv_key_3a = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port5_icv_key_3a_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port5_icv_key_3a_mask = mask then
                read_port5_icv_key_3a_value = data_low
            else
                read_port5_icv_key_3a_value = (data_low - H8000_0000) and port5_icv_key_3a_mask
            end If
        else
            read_port5_icv_key_3a_value = data_low and port5_icv_key_3a_mask
        end If

    End Sub

    Sub write
        If flag_port5_icv_key_3a = &H0 Then read
        If flag_port5_icv_key_3a = &H0 Then write_port5_icv_key_3a_value = get_port5_icv_key_3a

        regValue = leftShift(write_port5_icv_key_3a_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port5_icv_key_3a_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port5_icv_key_3a_mask = mask then
                read_port5_icv_key_3a_value = data_low
            else
                read_port5_icv_key_3a_value = (data_low - H8000_0000) and port5_icv_key_3a_mask
            end If
        else
            read_port5_icv_key_3a_value = data_low and port5_icv_key_3a_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_port5_icv_key_3a_value = &H0
        flag_port5_icv_key_3a        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port5_3b
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' port5_icv_key_3b                           [31:0]           get_port5_icv_key_3b
''                                                             set_port5_icv_key_3b
''                                                             read_port5_icv_key_3b
''                                                             write_port5_icv_key_3b
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port5_3b
    Private write_port5_icv_key_3b_value
    Private read_port5_icv_key_3b_value
    Private flag_port5_icv_key_3b

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H290
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_port5_icv_key_3b
        get_port5_icv_key_3b = read_port5_icv_key_3b_value
    End Property

    Property Let set_port5_icv_key_3b(aData)
        write_port5_icv_key_3b_value = aData
        flag_port5_icv_key_3b        = &H1
    End Property

    Property Get read_port5_icv_key_3b
        read
        read_port5_icv_key_3b = read_port5_icv_key_3b_value
    End Property

    Property Let write_port5_icv_key_3b(aData)
        set_port5_icv_key_3b = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port5_icv_key_3b_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port5_icv_key_3b_mask = mask then
                read_port5_icv_key_3b_value = data_low
            else
                read_port5_icv_key_3b_value = (data_low - H8000_0000) and port5_icv_key_3b_mask
            end If
        else
            read_port5_icv_key_3b_value = data_low and port5_icv_key_3b_mask
        end If

    End Sub

    Sub write
        If flag_port5_icv_key_3b = &H0 Then read
        If flag_port5_icv_key_3b = &H0 Then write_port5_icv_key_3b_value = get_port5_icv_key_3b

        regValue = leftShift(write_port5_icv_key_3b_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port5_icv_key_3b_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port5_icv_key_3b_mask = mask then
                read_port5_icv_key_3b_value = data_low
            else
                read_port5_icv_key_3b_value = (data_low - H8000_0000) and port5_icv_key_3b_mask
            end If
        else
            read_port5_icv_key_3b_value = data_low and port5_icv_key_3b_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_port5_icv_key_3b_value = &H0
        flag_port5_icv_key_3b        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port5_3c
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' port5_icv_key_3c                           [31:0]           get_port5_icv_key_3c
''                                                             set_port5_icv_key_3c
''                                                             read_port5_icv_key_3c
''                                                             write_port5_icv_key_3c
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port5_3c
    Private write_port5_icv_key_3c_value
    Private read_port5_icv_key_3c_value
    Private flag_port5_icv_key_3c

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H294
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_port5_icv_key_3c
        get_port5_icv_key_3c = read_port5_icv_key_3c_value
    End Property

    Property Let set_port5_icv_key_3c(aData)
        write_port5_icv_key_3c_value = aData
        flag_port5_icv_key_3c        = &H1
    End Property

    Property Get read_port5_icv_key_3c
        read
        read_port5_icv_key_3c = read_port5_icv_key_3c_value
    End Property

    Property Let write_port5_icv_key_3c(aData)
        set_port5_icv_key_3c = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port5_icv_key_3c_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port5_icv_key_3c_mask = mask then
                read_port5_icv_key_3c_value = data_low
            else
                read_port5_icv_key_3c_value = (data_low - H8000_0000) and port5_icv_key_3c_mask
            end If
        else
            read_port5_icv_key_3c_value = data_low and port5_icv_key_3c_mask
        end If

    End Sub

    Sub write
        If flag_port5_icv_key_3c = &H0 Then read
        If flag_port5_icv_key_3c = &H0 Then write_port5_icv_key_3c_value = get_port5_icv_key_3c

        regValue = leftShift(write_port5_icv_key_3c_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port5_icv_key_3c_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port5_icv_key_3c_mask = mask then
                read_port5_icv_key_3c_value = data_low
            else
                read_port5_icv_key_3c_value = (data_low - H8000_0000) and port5_icv_key_3c_mask
            end If
        else
            read_port5_icv_key_3c_value = data_low and port5_icv_key_3c_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_port5_icv_key_3c_value = &H0
        flag_port5_icv_key_3c        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port5_3d
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' port5_icv_key_3d                           [31:0]           get_port5_icv_key_3d
''                                                             set_port5_icv_key_3d
''                                                             read_port5_icv_key_3d
''                                                             write_port5_icv_key_3d
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port5_3d
    Private write_port5_icv_key_3d_value
    Private read_port5_icv_key_3d_value
    Private flag_port5_icv_key_3d

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H298
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_port5_icv_key_3d
        get_port5_icv_key_3d = read_port5_icv_key_3d_value
    End Property

    Property Let set_port5_icv_key_3d(aData)
        write_port5_icv_key_3d_value = aData
        flag_port5_icv_key_3d        = &H1
    End Property

    Property Get read_port5_icv_key_3d
        read
        read_port5_icv_key_3d = read_port5_icv_key_3d_value
    End Property

    Property Let write_port5_icv_key_3d(aData)
        set_port5_icv_key_3d = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port5_icv_key_3d_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port5_icv_key_3d_mask = mask then
                read_port5_icv_key_3d_value = data_low
            else
                read_port5_icv_key_3d_value = (data_low - H8000_0000) and port5_icv_key_3d_mask
            end If
        else
            read_port5_icv_key_3d_value = data_low and port5_icv_key_3d_mask
        end If

    End Sub

    Sub write
        If flag_port5_icv_key_3d = &H0 Then read
        If flag_port5_icv_key_3d = &H0 Then write_port5_icv_key_3d_value = get_port5_icv_key_3d

        regValue = leftShift(write_port5_icv_key_3d_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        port5_icv_key_3d_mask = &Hffffffff
        if data_low > LONG_MAX then
            if port5_icv_key_3d_mask = mask then
                read_port5_icv_key_3d_value = data_low
            else
                read_port5_icv_key_3d_value = (data_low - H8000_0000) and port5_icv_key_3d_mask
            end If
        else
            read_port5_icv_key_3d_value = data_low and port5_icv_key_3d_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_port5_icv_key_3d_value = &H0
        flag_port5_icv_key_3d        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_link_authenticaton_key_port5_3e
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_link_authenticaton_key_port5_3e

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H29c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low

    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
    End Sub
End Class


'' @REGISTER : HSM_MISC_interrupt
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' security_compromise_int                    [0:0]            get_security_compromise_int
''                                                             set_security_compromise_int
''                                                             read_security_compromise_int
''                                                             write_security_compromise_int
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_interrupt
    Private write_security_compromise_int_value
    Private read_security_compromise_int_value
    Private flag_security_compromise_int

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H2a0
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_security_compromise_int
        get_security_compromise_int = read_security_compromise_int_value
    End Property

    Property Let set_security_compromise_int(aData)
        write_security_compromise_int_value = aData
        flag_security_compromise_int        = &H1
    End Property

    Property Get read_security_compromise_int
        read
        read_security_compromise_int = read_security_compromise_int_value
    End Property

    Property Let write_security_compromise_int(aData)
        set_security_compromise_int = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        security_compromise_int_mask = &H1
        if data_low > LONG_MAX then
            if security_compromise_int_mask = mask then
                read_security_compromise_int_value = data_low
            else
                read_security_compromise_int_value = (data_low - H8000_0000) and security_compromise_int_mask
            end If
        else
            read_security_compromise_int_value = data_low and security_compromise_int_mask
        end If

    End Sub

    Sub write
        If flag_security_compromise_int = &H0 Then read
        If flag_security_compromise_int = &H0 Then write_security_compromise_int_value = get_security_compromise_int

        regValue = leftShift((write_security_compromise_int_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        security_compromise_int_mask = &H1
        if data_low > LONG_MAX then
            if security_compromise_int_mask = mask then
                read_security_compromise_int_value = data_low
            else
                read_security_compromise_int_value = (data_low - H8000_0000) and security_compromise_int_mask
            end If
        else
            read_security_compromise_int_value = data_low and security_compromise_int_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_security_compromise_int_value = &H0
        flag_security_compromise_int        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_interrupt_en
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' security_compromise_int_en                 [0:0]            get_security_compromise_int_en
''                                                             set_security_compromise_int_en
''                                                             read_security_compromise_int_en
''                                                             write_security_compromise_int_en
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_interrupt_en
    Private write_security_compromise_int_en_value
    Private read_security_compromise_int_en_value
    Private flag_security_compromise_int_en

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H2a4
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_security_compromise_int_en
        get_security_compromise_int_en = read_security_compromise_int_en_value
    End Property

    Property Let set_security_compromise_int_en(aData)
        write_security_compromise_int_en_value = aData
        flag_security_compromise_int_en        = &H1
    End Property

    Property Get read_security_compromise_int_en
        read
        read_security_compromise_int_en = read_security_compromise_int_en_value
    End Property

    Property Let write_security_compromise_int_en(aData)
        set_security_compromise_int_en = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        security_compromise_int_en_mask = &H1
        if data_low > LONG_MAX then
            if security_compromise_int_en_mask = mask then
                read_security_compromise_int_en_value = data_low
            else
                read_security_compromise_int_en_value = (data_low - H8000_0000) and security_compromise_int_en_mask
            end If
        else
            read_security_compromise_int_en_value = data_low and security_compromise_int_en_mask
        end If

    End Sub

    Sub write
        If flag_security_compromise_int_en = &H0 Then read
        If flag_security_compromise_int_en = &H0 Then write_security_compromise_int_en_value = get_security_compromise_int_en

        regValue = leftShift((write_security_compromise_int_en_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        security_compromise_int_en_mask = &H1
        if data_low > LONG_MAX then
            if security_compromise_int_en_mask = mask then
                read_security_compromise_int_en_value = data_low
            else
                read_security_compromise_int_en_value = (data_low - H8000_0000) and security_compromise_int_en_mask
            end If
        else
            read_security_compromise_int_en_value = data_low and security_compromise_int_en_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_security_compromise_int_en_value = &H0
        flag_security_compromise_int_en        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_interrupt_clear
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' security_compromise_int_clr                [0:0]            get_security_compromise_int_clr
''                                                             set_security_compromise_int_clr
''                                                             read_security_compromise_int_clr
''                                                             write_security_compromise_int_clr
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_interrupt_clear
    Private write_security_compromise_int_clr_value
    Private read_security_compromise_int_clr_value
    Private flag_security_compromise_int_clr

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H2a8
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_security_compromise_int_clr
        get_security_compromise_int_clr = read_security_compromise_int_clr_value
    End Property

    Property Let set_security_compromise_int_clr(aData)
        write_security_compromise_int_clr_value = aData
        flag_security_compromise_int_clr        = &H1
    End Property

    Property Get read_security_compromise_int_clr
        read
        read_security_compromise_int_clr = read_security_compromise_int_clr_value
    End Property

    Property Let write_security_compromise_int_clr(aData)
        set_security_compromise_int_clr = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        security_compromise_int_clr_mask = &H1
        if data_low > LONG_MAX then
            if security_compromise_int_clr_mask = mask then
                read_security_compromise_int_clr_value = data_low
            else
                read_security_compromise_int_clr_value = (data_low - H8000_0000) and security_compromise_int_clr_mask
            end If
        else
            read_security_compromise_int_clr_value = data_low and security_compromise_int_clr_mask
        end If

    End Sub

    Sub write
        If flag_security_compromise_int_clr = &H0 Then read
        If flag_security_compromise_int_clr = &H0 Then write_security_compromise_int_clr_value = get_security_compromise_int_clr

        regValue = leftShift((write_security_compromise_int_clr_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        security_compromise_int_clr_mask = &H1
        if data_low > LONG_MAX then
            if security_compromise_int_clr_mask = mask then
                read_security_compromise_int_clr_value = data_low
            else
                read_security_compromise_int_clr_value = (data_low - H8000_0000) and security_compromise_int_clr_mask
            end If
        else
            read_security_compromise_int_clr_value = data_low and security_compromise_int_clr_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_security_compromise_int_clr_value = &H0
        flag_security_compromise_int_clr        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_ahb_slave_timout_mon_interrupt
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' spu_timout_mon_int                         [5:5]            get_spu_timout_mon_int
''                                                             set_spu_timout_mon_int
''                                                             read_spu_timout_mon_int
''                                                             write_spu_timout_mon_int
''---------------------------------------------------------------------------------
'' dma_slave_timout_mon_int                   [4:4]            get_dma_slave_timout_mon_int
''                                                             set_dma_slave_timout_mon_int
''                                                             read_dma_slave_timout_mon_int
''                                                             write_dma_slave_timout_mon_int
''---------------------------------------------------------------------------------
'' to_cpu_sys_timout_mon_int                  [3:3]            get_to_cpu_sys_timout_mon_int
''                                                             set_to_cpu_sys_timout_mon_int
''                                                             read_to_cpu_sys_timout_mon_int
''                                                             write_to_cpu_sys_timout_mon_int
''---------------------------------------------------------------------------------
'' ipc_timout_mon_int                         [2:2]            get_ipc_timout_mon_int
''                                                             set_ipc_timout_mon_int
''                                                             read_ipc_timout_mon_int
''                                                             write_ipc_timout_mon_int
''---------------------------------------------------------------------------------
'' sram_top_timout_mon_int                    [1:1]            get_sram_top_timout_mon_int
''                                                             set_sram_top_timout_mon_int
''                                                             read_sram_top_timout_mon_int
''                                                             write_sram_top_timout_mon_int
''---------------------------------------------------------------------------------
'' ahb_n_apb_timout_mon_int                   [0:0]            get_ahb_n_apb_timout_mon_int
''                                                             set_ahb_n_apb_timout_mon_int
''                                                             read_ahb_n_apb_timout_mon_int
''                                                             write_ahb_n_apb_timout_mon_int
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_ahb_slave_timout_mon_interrupt
    Private write_spu_timout_mon_int_value
    Private read_spu_timout_mon_int_value
    Private flag_spu_timout_mon_int
    Private write_dma_slave_timout_mon_int_value
    Private read_dma_slave_timout_mon_int_value
    Private flag_dma_slave_timout_mon_int
    Private write_to_cpu_sys_timout_mon_int_value
    Private read_to_cpu_sys_timout_mon_int_value
    Private flag_to_cpu_sys_timout_mon_int
    Private write_ipc_timout_mon_int_value
    Private read_ipc_timout_mon_int_value
    Private flag_ipc_timout_mon_int
    Private write_sram_top_timout_mon_int_value
    Private read_sram_top_timout_mon_int_value
    Private flag_sram_top_timout_mon_int
    Private write_ahb_n_apb_timout_mon_int_value
    Private read_ahb_n_apb_timout_mon_int_value
    Private flag_ahb_n_apb_timout_mon_int

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H2ac
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_spu_timout_mon_int
        get_spu_timout_mon_int = read_spu_timout_mon_int_value
    End Property

    Property Let set_spu_timout_mon_int(aData)
        write_spu_timout_mon_int_value = aData
        flag_spu_timout_mon_int        = &H1
    End Property

    Property Get read_spu_timout_mon_int
        read
        read_spu_timout_mon_int = read_spu_timout_mon_int_value
    End Property

    Property Let write_spu_timout_mon_int(aData)
        set_spu_timout_mon_int = aData
        write
    End Property

    Property Get get_dma_slave_timout_mon_int
        get_dma_slave_timout_mon_int = read_dma_slave_timout_mon_int_value
    End Property

    Property Let set_dma_slave_timout_mon_int(aData)
        write_dma_slave_timout_mon_int_value = aData
        flag_dma_slave_timout_mon_int        = &H1
    End Property

    Property Get read_dma_slave_timout_mon_int
        read
        read_dma_slave_timout_mon_int = read_dma_slave_timout_mon_int_value
    End Property

    Property Let write_dma_slave_timout_mon_int(aData)
        set_dma_slave_timout_mon_int = aData
        write
    End Property

    Property Get get_to_cpu_sys_timout_mon_int
        get_to_cpu_sys_timout_mon_int = read_to_cpu_sys_timout_mon_int_value
    End Property

    Property Let set_to_cpu_sys_timout_mon_int(aData)
        write_to_cpu_sys_timout_mon_int_value = aData
        flag_to_cpu_sys_timout_mon_int        = &H1
    End Property

    Property Get read_to_cpu_sys_timout_mon_int
        read
        read_to_cpu_sys_timout_mon_int = read_to_cpu_sys_timout_mon_int_value
    End Property

    Property Let write_to_cpu_sys_timout_mon_int(aData)
        set_to_cpu_sys_timout_mon_int = aData
        write
    End Property

    Property Get get_ipc_timout_mon_int
        get_ipc_timout_mon_int = read_ipc_timout_mon_int_value
    End Property

    Property Let set_ipc_timout_mon_int(aData)
        write_ipc_timout_mon_int_value = aData
        flag_ipc_timout_mon_int        = &H1
    End Property

    Property Get read_ipc_timout_mon_int
        read
        read_ipc_timout_mon_int = read_ipc_timout_mon_int_value
    End Property

    Property Let write_ipc_timout_mon_int(aData)
        set_ipc_timout_mon_int = aData
        write
    End Property

    Property Get get_sram_top_timout_mon_int
        get_sram_top_timout_mon_int = read_sram_top_timout_mon_int_value
    End Property

    Property Let set_sram_top_timout_mon_int(aData)
        write_sram_top_timout_mon_int_value = aData
        flag_sram_top_timout_mon_int        = &H1
    End Property

    Property Get read_sram_top_timout_mon_int
        read
        read_sram_top_timout_mon_int = read_sram_top_timout_mon_int_value
    End Property

    Property Let write_sram_top_timout_mon_int(aData)
        set_sram_top_timout_mon_int = aData
        write
    End Property

    Property Get get_ahb_n_apb_timout_mon_int
        get_ahb_n_apb_timout_mon_int = read_ahb_n_apb_timout_mon_int_value
    End Property

    Property Let set_ahb_n_apb_timout_mon_int(aData)
        write_ahb_n_apb_timout_mon_int_value = aData
        flag_ahb_n_apb_timout_mon_int        = &H1
    End Property

    Property Get read_ahb_n_apb_timout_mon_int
        read
        read_ahb_n_apb_timout_mon_int = read_ahb_n_apb_timout_mon_int_value
    End Property

    Property Let write_ahb_n_apb_timout_mon_int(aData)
        set_ahb_n_apb_timout_mon_int = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_spu_timout_mon_int_value = rightShift(data_low, 5) and &H1
        read_dma_slave_timout_mon_int_value = rightShift(data_low, 4) and &H1
        read_to_cpu_sys_timout_mon_int_value = rightShift(data_low, 3) and &H1
        read_ipc_timout_mon_int_value = rightShift(data_low, 2) and &H1
        read_sram_top_timout_mon_int_value = rightShift(data_low, 1) and &H1
        ahb_n_apb_timout_mon_int_mask = &H1
        if data_low > LONG_MAX then
            if ahb_n_apb_timout_mon_int_mask = mask then
                read_ahb_n_apb_timout_mon_int_value = data_low
            else
                read_ahb_n_apb_timout_mon_int_value = (data_low - H8000_0000) and ahb_n_apb_timout_mon_int_mask
            end If
        else
            read_ahb_n_apb_timout_mon_int_value = data_low and ahb_n_apb_timout_mon_int_mask
        end If

    End Sub

    Sub write
        If flag_spu_timout_mon_int = &H0 or flag_dma_slave_timout_mon_int = &H0 or flag_to_cpu_sys_timout_mon_int = &H0 or flag_ipc_timout_mon_int = &H0 or flag_sram_top_timout_mon_int = &H0 or flag_ahb_n_apb_timout_mon_int = &H0 Then read
        If flag_spu_timout_mon_int = &H0 Then write_spu_timout_mon_int_value = get_spu_timout_mon_int
        If flag_dma_slave_timout_mon_int = &H0 Then write_dma_slave_timout_mon_int_value = get_dma_slave_timout_mon_int
        If flag_to_cpu_sys_timout_mon_int = &H0 Then write_to_cpu_sys_timout_mon_int_value = get_to_cpu_sys_timout_mon_int
        If flag_ipc_timout_mon_int = &H0 Then write_ipc_timout_mon_int_value = get_ipc_timout_mon_int
        If flag_sram_top_timout_mon_int = &H0 Then write_sram_top_timout_mon_int_value = get_sram_top_timout_mon_int
        If flag_ahb_n_apb_timout_mon_int = &H0 Then write_ahb_n_apb_timout_mon_int_value = get_ahb_n_apb_timout_mon_int

        regValue = leftShift((write_spu_timout_mon_int_value and &H1), 5) + leftShift((write_dma_slave_timout_mon_int_value and &H1), 4) + leftShift((write_to_cpu_sys_timout_mon_int_value and &H1), 3) + leftShift((write_ipc_timout_mon_int_value and &H1), 2) + leftShift((write_sram_top_timout_mon_int_value and &H1), 1) + leftShift((write_ahb_n_apb_timout_mon_int_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_spu_timout_mon_int_value = rightShift(data_low, 5) and &H1
        read_dma_slave_timout_mon_int_value = rightShift(data_low, 4) and &H1
        read_to_cpu_sys_timout_mon_int_value = rightShift(data_low, 3) and &H1
        read_ipc_timout_mon_int_value = rightShift(data_low, 2) and &H1
        read_sram_top_timout_mon_int_value = rightShift(data_low, 1) and &H1
        ahb_n_apb_timout_mon_int_mask = &H1
        if data_low > LONG_MAX then
            if ahb_n_apb_timout_mon_int_mask = mask then
                read_ahb_n_apb_timout_mon_int_value = data_low
            else
                read_ahb_n_apb_timout_mon_int_value = (data_low - H8000_0000) and ahb_n_apb_timout_mon_int_mask
            end If
        else
            read_ahb_n_apb_timout_mon_int_value = data_low and ahb_n_apb_timout_mon_int_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_spu_timout_mon_int_value = &H0
        flag_spu_timout_mon_int        = &H0
        write_dma_slave_timout_mon_int_value = &H0
        flag_dma_slave_timout_mon_int        = &H0
        write_to_cpu_sys_timout_mon_int_value = &H0
        flag_to_cpu_sys_timout_mon_int        = &H0
        write_ipc_timout_mon_int_value = &H0
        flag_ipc_timout_mon_int        = &H0
        write_sram_top_timout_mon_int_value = &H0
        flag_sram_top_timout_mon_int        = &H0
        write_ahb_n_apb_timout_mon_int_value = &H0
        flag_ahb_n_apb_timout_mon_int        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_ahb_slave_timout_mon_interrupt_en
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' spu_timout_mon_int_en                      [5:5]            get_spu_timout_mon_int_en
''                                                             set_spu_timout_mon_int_en
''                                                             read_spu_timout_mon_int_en
''                                                             write_spu_timout_mon_int_en
''---------------------------------------------------------------------------------
'' dma_slave_timout_mon_int_en                [4:4]            get_dma_slave_timout_mon_int_en
''                                                             set_dma_slave_timout_mon_int_en
''                                                             read_dma_slave_timout_mon_int_en
''                                                             write_dma_slave_timout_mon_int_en
''---------------------------------------------------------------------------------
'' to_cpu_sys_timout_mon_int_en               [3:3]            get_to_cpu_sys_timout_mon_int_en
''                                                             set_to_cpu_sys_timout_mon_int_en
''                                                             read_to_cpu_sys_timout_mon_int_en
''                                                             write_to_cpu_sys_timout_mon_int_en
''---------------------------------------------------------------------------------
'' ipc_timout_mon_int_en                      [2:2]            get_ipc_timout_mon_int_en
''                                                             set_ipc_timout_mon_int_en
''                                                             read_ipc_timout_mon_int_en
''                                                             write_ipc_timout_mon_int_en
''---------------------------------------------------------------------------------
'' sram_top_timout_mon_int_en                 [1:1]            get_sram_top_timout_mon_int_en
''                                                             set_sram_top_timout_mon_int_en
''                                                             read_sram_top_timout_mon_int_en
''                                                             write_sram_top_timout_mon_int_en
''---------------------------------------------------------------------------------
'' ahb_n_apb_timout_mon_int_en                [0:0]            get_ahb_n_apb_timout_mon_int_en
''                                                             set_ahb_n_apb_timout_mon_int_en
''                                                             read_ahb_n_apb_timout_mon_int_en
''                                                             write_ahb_n_apb_timout_mon_int_en
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_ahb_slave_timout_mon_interrupt_en
    Private write_spu_timout_mon_int_en_value
    Private read_spu_timout_mon_int_en_value
    Private flag_spu_timout_mon_int_en
    Private write_dma_slave_timout_mon_int_en_value
    Private read_dma_slave_timout_mon_int_en_value
    Private flag_dma_slave_timout_mon_int_en
    Private write_to_cpu_sys_timout_mon_int_en_value
    Private read_to_cpu_sys_timout_mon_int_en_value
    Private flag_to_cpu_sys_timout_mon_int_en
    Private write_ipc_timout_mon_int_en_value
    Private read_ipc_timout_mon_int_en_value
    Private flag_ipc_timout_mon_int_en
    Private write_sram_top_timout_mon_int_en_value
    Private read_sram_top_timout_mon_int_en_value
    Private flag_sram_top_timout_mon_int_en
    Private write_ahb_n_apb_timout_mon_int_en_value
    Private read_ahb_n_apb_timout_mon_int_en_value
    Private flag_ahb_n_apb_timout_mon_int_en

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H2b0
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_spu_timout_mon_int_en
        get_spu_timout_mon_int_en = read_spu_timout_mon_int_en_value
    End Property

    Property Let set_spu_timout_mon_int_en(aData)
        write_spu_timout_mon_int_en_value = aData
        flag_spu_timout_mon_int_en        = &H1
    End Property

    Property Get read_spu_timout_mon_int_en
        read
        read_spu_timout_mon_int_en = read_spu_timout_mon_int_en_value
    End Property

    Property Let write_spu_timout_mon_int_en(aData)
        set_spu_timout_mon_int_en = aData
        write
    End Property

    Property Get get_dma_slave_timout_mon_int_en
        get_dma_slave_timout_mon_int_en = read_dma_slave_timout_mon_int_en_value
    End Property

    Property Let set_dma_slave_timout_mon_int_en(aData)
        write_dma_slave_timout_mon_int_en_value = aData
        flag_dma_slave_timout_mon_int_en        = &H1
    End Property

    Property Get read_dma_slave_timout_mon_int_en
        read
        read_dma_slave_timout_mon_int_en = read_dma_slave_timout_mon_int_en_value
    End Property

    Property Let write_dma_slave_timout_mon_int_en(aData)
        set_dma_slave_timout_mon_int_en = aData
        write
    End Property

    Property Get get_to_cpu_sys_timout_mon_int_en
        get_to_cpu_sys_timout_mon_int_en = read_to_cpu_sys_timout_mon_int_en_value
    End Property

    Property Let set_to_cpu_sys_timout_mon_int_en(aData)
        write_to_cpu_sys_timout_mon_int_en_value = aData
        flag_to_cpu_sys_timout_mon_int_en        = &H1
    End Property

    Property Get read_to_cpu_sys_timout_mon_int_en
        read
        read_to_cpu_sys_timout_mon_int_en = read_to_cpu_sys_timout_mon_int_en_value
    End Property

    Property Let write_to_cpu_sys_timout_mon_int_en(aData)
        set_to_cpu_sys_timout_mon_int_en = aData
        write
    End Property

    Property Get get_ipc_timout_mon_int_en
        get_ipc_timout_mon_int_en = read_ipc_timout_mon_int_en_value
    End Property

    Property Let set_ipc_timout_mon_int_en(aData)
        write_ipc_timout_mon_int_en_value = aData
        flag_ipc_timout_mon_int_en        = &H1
    End Property

    Property Get read_ipc_timout_mon_int_en
        read
        read_ipc_timout_mon_int_en = read_ipc_timout_mon_int_en_value
    End Property

    Property Let write_ipc_timout_mon_int_en(aData)
        set_ipc_timout_mon_int_en = aData
        write
    End Property

    Property Get get_sram_top_timout_mon_int_en
        get_sram_top_timout_mon_int_en = read_sram_top_timout_mon_int_en_value
    End Property

    Property Let set_sram_top_timout_mon_int_en(aData)
        write_sram_top_timout_mon_int_en_value = aData
        flag_sram_top_timout_mon_int_en        = &H1
    End Property

    Property Get read_sram_top_timout_mon_int_en
        read
        read_sram_top_timout_mon_int_en = read_sram_top_timout_mon_int_en_value
    End Property

    Property Let write_sram_top_timout_mon_int_en(aData)
        set_sram_top_timout_mon_int_en = aData
        write
    End Property

    Property Get get_ahb_n_apb_timout_mon_int_en
        get_ahb_n_apb_timout_mon_int_en = read_ahb_n_apb_timout_mon_int_en_value
    End Property

    Property Let set_ahb_n_apb_timout_mon_int_en(aData)
        write_ahb_n_apb_timout_mon_int_en_value = aData
        flag_ahb_n_apb_timout_mon_int_en        = &H1
    End Property

    Property Get read_ahb_n_apb_timout_mon_int_en
        read
        read_ahb_n_apb_timout_mon_int_en = read_ahb_n_apb_timout_mon_int_en_value
    End Property

    Property Let write_ahb_n_apb_timout_mon_int_en(aData)
        set_ahb_n_apb_timout_mon_int_en = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_spu_timout_mon_int_en_value = rightShift(data_low, 5) and &H1
        read_dma_slave_timout_mon_int_en_value = rightShift(data_low, 4) and &H1
        read_to_cpu_sys_timout_mon_int_en_value = rightShift(data_low, 3) and &H1
        read_ipc_timout_mon_int_en_value = rightShift(data_low, 2) and &H1
        read_sram_top_timout_mon_int_en_value = rightShift(data_low, 1) and &H1
        ahb_n_apb_timout_mon_int_en_mask = &H1
        if data_low > LONG_MAX then
            if ahb_n_apb_timout_mon_int_en_mask = mask then
                read_ahb_n_apb_timout_mon_int_en_value = data_low
            else
                read_ahb_n_apb_timout_mon_int_en_value = (data_low - H8000_0000) and ahb_n_apb_timout_mon_int_en_mask
            end If
        else
            read_ahb_n_apb_timout_mon_int_en_value = data_low and ahb_n_apb_timout_mon_int_en_mask
        end If

    End Sub

    Sub write
        If flag_spu_timout_mon_int_en = &H0 or flag_dma_slave_timout_mon_int_en = &H0 or flag_to_cpu_sys_timout_mon_int_en = &H0 or flag_ipc_timout_mon_int_en = &H0 or flag_sram_top_timout_mon_int_en = &H0 or flag_ahb_n_apb_timout_mon_int_en = &H0 Then read
        If flag_spu_timout_mon_int_en = &H0 Then write_spu_timout_mon_int_en_value = get_spu_timout_mon_int_en
        If flag_dma_slave_timout_mon_int_en = &H0 Then write_dma_slave_timout_mon_int_en_value = get_dma_slave_timout_mon_int_en
        If flag_to_cpu_sys_timout_mon_int_en = &H0 Then write_to_cpu_sys_timout_mon_int_en_value = get_to_cpu_sys_timout_mon_int_en
        If flag_ipc_timout_mon_int_en = &H0 Then write_ipc_timout_mon_int_en_value = get_ipc_timout_mon_int_en
        If flag_sram_top_timout_mon_int_en = &H0 Then write_sram_top_timout_mon_int_en_value = get_sram_top_timout_mon_int_en
        If flag_ahb_n_apb_timout_mon_int_en = &H0 Then write_ahb_n_apb_timout_mon_int_en_value = get_ahb_n_apb_timout_mon_int_en

        regValue = leftShift((write_spu_timout_mon_int_en_value and &H1), 5) + leftShift((write_dma_slave_timout_mon_int_en_value and &H1), 4) + leftShift((write_to_cpu_sys_timout_mon_int_en_value and &H1), 3) + leftShift((write_ipc_timout_mon_int_en_value and &H1), 2) + leftShift((write_sram_top_timout_mon_int_en_value and &H1), 1) + leftShift((write_ahb_n_apb_timout_mon_int_en_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_spu_timout_mon_int_en_value = rightShift(data_low, 5) and &H1
        read_dma_slave_timout_mon_int_en_value = rightShift(data_low, 4) and &H1
        read_to_cpu_sys_timout_mon_int_en_value = rightShift(data_low, 3) and &H1
        read_ipc_timout_mon_int_en_value = rightShift(data_low, 2) and &H1
        read_sram_top_timout_mon_int_en_value = rightShift(data_low, 1) and &H1
        ahb_n_apb_timout_mon_int_en_mask = &H1
        if data_low > LONG_MAX then
            if ahb_n_apb_timout_mon_int_en_mask = mask then
                read_ahb_n_apb_timout_mon_int_en_value = data_low
            else
                read_ahb_n_apb_timout_mon_int_en_value = (data_low - H8000_0000) and ahb_n_apb_timout_mon_int_en_mask
            end If
        else
            read_ahb_n_apb_timout_mon_int_en_value = data_low and ahb_n_apb_timout_mon_int_en_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_spu_timout_mon_int_en_value = &H0
        flag_spu_timout_mon_int_en        = &H0
        write_dma_slave_timout_mon_int_en_value = &H0
        flag_dma_slave_timout_mon_int_en        = &H0
        write_to_cpu_sys_timout_mon_int_en_value = &H0
        flag_to_cpu_sys_timout_mon_int_en        = &H0
        write_ipc_timout_mon_int_en_value = &H0
        flag_ipc_timout_mon_int_en        = &H0
        write_sram_top_timout_mon_int_en_value = &H0
        flag_sram_top_timout_mon_int_en        = &H0
        write_ahb_n_apb_timout_mon_int_en_value = &H0
        flag_ahb_n_apb_timout_mon_int_en        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_ahb_slave_timout_mon_interrupt_clr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' spu_timout_mon_int_clr                     [5:5]            get_spu_timout_mon_int_clr
''                                                             set_spu_timout_mon_int_clr
''                                                             read_spu_timout_mon_int_clr
''                                                             write_spu_timout_mon_int_clr
''---------------------------------------------------------------------------------
'' dma_slave_timout_mon_int_clr               [4:4]            get_dma_slave_timout_mon_int_clr
''                                                             set_dma_slave_timout_mon_int_clr
''                                                             read_dma_slave_timout_mon_int_clr
''                                                             write_dma_slave_timout_mon_int_clr
''---------------------------------------------------------------------------------
'' to_cpu_sys_timout_mon_int_clr              [3:3]            get_to_cpu_sys_timout_mon_int_clr
''                                                             set_to_cpu_sys_timout_mon_int_clr
''                                                             read_to_cpu_sys_timout_mon_int_clr
''                                                             write_to_cpu_sys_timout_mon_int_clr
''---------------------------------------------------------------------------------
'' ipc_timout_mon_int_clr                     [2:2]            get_ipc_timout_mon_int_clr
''                                                             set_ipc_timout_mon_int_clr
''                                                             read_ipc_timout_mon_int_clr
''                                                             write_ipc_timout_mon_int_clr
''---------------------------------------------------------------------------------
'' sram_top_timout_mon_int_clr                [1:1]            get_sram_top_timout_mon_int_clr
''                                                             set_sram_top_timout_mon_int_clr
''                                                             read_sram_top_timout_mon_int_clr
''                                                             write_sram_top_timout_mon_int_clr
''---------------------------------------------------------------------------------
'' ahb_n_apb_timout_mon_int_clr               [0:0]            get_ahb_n_apb_timout_mon_int_clr
''                                                             set_ahb_n_apb_timout_mon_int_clr
''                                                             read_ahb_n_apb_timout_mon_int_clr
''                                                             write_ahb_n_apb_timout_mon_int_clr
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_ahb_slave_timout_mon_interrupt_clr
    Private write_spu_timout_mon_int_clr_value
    Private read_spu_timout_mon_int_clr_value
    Private flag_spu_timout_mon_int_clr
    Private write_dma_slave_timout_mon_int_clr_value
    Private read_dma_slave_timout_mon_int_clr_value
    Private flag_dma_slave_timout_mon_int_clr
    Private write_to_cpu_sys_timout_mon_int_clr_value
    Private read_to_cpu_sys_timout_mon_int_clr_value
    Private flag_to_cpu_sys_timout_mon_int_clr
    Private write_ipc_timout_mon_int_clr_value
    Private read_ipc_timout_mon_int_clr_value
    Private flag_ipc_timout_mon_int_clr
    Private write_sram_top_timout_mon_int_clr_value
    Private read_sram_top_timout_mon_int_clr_value
    Private flag_sram_top_timout_mon_int_clr
    Private write_ahb_n_apb_timout_mon_int_clr_value
    Private read_ahb_n_apb_timout_mon_int_clr_value
    Private flag_ahb_n_apb_timout_mon_int_clr

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H2b4
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_spu_timout_mon_int_clr
        get_spu_timout_mon_int_clr = read_spu_timout_mon_int_clr_value
    End Property

    Property Let set_spu_timout_mon_int_clr(aData)
        write_spu_timout_mon_int_clr_value = aData
        flag_spu_timout_mon_int_clr        = &H1
    End Property

    Property Get read_spu_timout_mon_int_clr
        read
        read_spu_timout_mon_int_clr = read_spu_timout_mon_int_clr_value
    End Property

    Property Let write_spu_timout_mon_int_clr(aData)
        set_spu_timout_mon_int_clr = aData
        write
    End Property

    Property Get get_dma_slave_timout_mon_int_clr
        get_dma_slave_timout_mon_int_clr = read_dma_slave_timout_mon_int_clr_value
    End Property

    Property Let set_dma_slave_timout_mon_int_clr(aData)
        write_dma_slave_timout_mon_int_clr_value = aData
        flag_dma_slave_timout_mon_int_clr        = &H1
    End Property

    Property Get read_dma_slave_timout_mon_int_clr
        read
        read_dma_slave_timout_mon_int_clr = read_dma_slave_timout_mon_int_clr_value
    End Property

    Property Let write_dma_slave_timout_mon_int_clr(aData)
        set_dma_slave_timout_mon_int_clr = aData
        write
    End Property

    Property Get get_to_cpu_sys_timout_mon_int_clr
        get_to_cpu_sys_timout_mon_int_clr = read_to_cpu_sys_timout_mon_int_clr_value
    End Property

    Property Let set_to_cpu_sys_timout_mon_int_clr(aData)
        write_to_cpu_sys_timout_mon_int_clr_value = aData
        flag_to_cpu_sys_timout_mon_int_clr        = &H1
    End Property

    Property Get read_to_cpu_sys_timout_mon_int_clr
        read
        read_to_cpu_sys_timout_mon_int_clr = read_to_cpu_sys_timout_mon_int_clr_value
    End Property

    Property Let write_to_cpu_sys_timout_mon_int_clr(aData)
        set_to_cpu_sys_timout_mon_int_clr = aData
        write
    End Property

    Property Get get_ipc_timout_mon_int_clr
        get_ipc_timout_mon_int_clr = read_ipc_timout_mon_int_clr_value
    End Property

    Property Let set_ipc_timout_mon_int_clr(aData)
        write_ipc_timout_mon_int_clr_value = aData
        flag_ipc_timout_mon_int_clr        = &H1
    End Property

    Property Get read_ipc_timout_mon_int_clr
        read
        read_ipc_timout_mon_int_clr = read_ipc_timout_mon_int_clr_value
    End Property

    Property Let write_ipc_timout_mon_int_clr(aData)
        set_ipc_timout_mon_int_clr = aData
        write
    End Property

    Property Get get_sram_top_timout_mon_int_clr
        get_sram_top_timout_mon_int_clr = read_sram_top_timout_mon_int_clr_value
    End Property

    Property Let set_sram_top_timout_mon_int_clr(aData)
        write_sram_top_timout_mon_int_clr_value = aData
        flag_sram_top_timout_mon_int_clr        = &H1
    End Property

    Property Get read_sram_top_timout_mon_int_clr
        read
        read_sram_top_timout_mon_int_clr = read_sram_top_timout_mon_int_clr_value
    End Property

    Property Let write_sram_top_timout_mon_int_clr(aData)
        set_sram_top_timout_mon_int_clr = aData
        write
    End Property

    Property Get get_ahb_n_apb_timout_mon_int_clr
        get_ahb_n_apb_timout_mon_int_clr = read_ahb_n_apb_timout_mon_int_clr_value
    End Property

    Property Let set_ahb_n_apb_timout_mon_int_clr(aData)
        write_ahb_n_apb_timout_mon_int_clr_value = aData
        flag_ahb_n_apb_timout_mon_int_clr        = &H1
    End Property

    Property Get read_ahb_n_apb_timout_mon_int_clr
        read
        read_ahb_n_apb_timout_mon_int_clr = read_ahb_n_apb_timout_mon_int_clr_value
    End Property

    Property Let write_ahb_n_apb_timout_mon_int_clr(aData)
        set_ahb_n_apb_timout_mon_int_clr = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_spu_timout_mon_int_clr_value = rightShift(data_low, 5) and &H1
        read_dma_slave_timout_mon_int_clr_value = rightShift(data_low, 4) and &H1
        read_to_cpu_sys_timout_mon_int_clr_value = rightShift(data_low, 3) and &H1
        read_ipc_timout_mon_int_clr_value = rightShift(data_low, 2) and &H1
        read_sram_top_timout_mon_int_clr_value = rightShift(data_low, 1) and &H1
        ahb_n_apb_timout_mon_int_clr_mask = &H1
        if data_low > LONG_MAX then
            if ahb_n_apb_timout_mon_int_clr_mask = mask then
                read_ahb_n_apb_timout_mon_int_clr_value = data_low
            else
                read_ahb_n_apb_timout_mon_int_clr_value = (data_low - H8000_0000) and ahb_n_apb_timout_mon_int_clr_mask
            end If
        else
            read_ahb_n_apb_timout_mon_int_clr_value = data_low and ahb_n_apb_timout_mon_int_clr_mask
        end If

    End Sub

    Sub write
        If flag_spu_timout_mon_int_clr = &H0 or flag_dma_slave_timout_mon_int_clr = &H0 or flag_to_cpu_sys_timout_mon_int_clr = &H0 or flag_ipc_timout_mon_int_clr = &H0 or flag_sram_top_timout_mon_int_clr = &H0 or flag_ahb_n_apb_timout_mon_int_clr = &H0 Then read
        If flag_spu_timout_mon_int_clr = &H0 Then write_spu_timout_mon_int_clr_value = get_spu_timout_mon_int_clr
        If flag_dma_slave_timout_mon_int_clr = &H0 Then write_dma_slave_timout_mon_int_clr_value = get_dma_slave_timout_mon_int_clr
        If flag_to_cpu_sys_timout_mon_int_clr = &H0 Then write_to_cpu_sys_timout_mon_int_clr_value = get_to_cpu_sys_timout_mon_int_clr
        If flag_ipc_timout_mon_int_clr = &H0 Then write_ipc_timout_mon_int_clr_value = get_ipc_timout_mon_int_clr
        If flag_sram_top_timout_mon_int_clr = &H0 Then write_sram_top_timout_mon_int_clr_value = get_sram_top_timout_mon_int_clr
        If flag_ahb_n_apb_timout_mon_int_clr = &H0 Then write_ahb_n_apb_timout_mon_int_clr_value = get_ahb_n_apb_timout_mon_int_clr

        regValue = leftShift((write_spu_timout_mon_int_clr_value and &H1), 5) + leftShift((write_dma_slave_timout_mon_int_clr_value and &H1), 4) + leftShift((write_to_cpu_sys_timout_mon_int_clr_value and &H1), 3) + leftShift((write_ipc_timout_mon_int_clr_value and &H1), 2) + leftShift((write_sram_top_timout_mon_int_clr_value and &H1), 1) + leftShift((write_ahb_n_apb_timout_mon_int_clr_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_spu_timout_mon_int_clr_value = rightShift(data_low, 5) and &H1
        read_dma_slave_timout_mon_int_clr_value = rightShift(data_low, 4) and &H1
        read_to_cpu_sys_timout_mon_int_clr_value = rightShift(data_low, 3) and &H1
        read_ipc_timout_mon_int_clr_value = rightShift(data_low, 2) and &H1
        read_sram_top_timout_mon_int_clr_value = rightShift(data_low, 1) and &H1
        ahb_n_apb_timout_mon_int_clr_mask = &H1
        if data_low > LONG_MAX then
            if ahb_n_apb_timout_mon_int_clr_mask = mask then
                read_ahb_n_apb_timout_mon_int_clr_value = data_low
            else
                read_ahb_n_apb_timout_mon_int_clr_value = (data_low - H8000_0000) and ahb_n_apb_timout_mon_int_clr_mask
            end If
        else
            read_ahb_n_apb_timout_mon_int_clr_value = data_low and ahb_n_apb_timout_mon_int_clr_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_spu_timout_mon_int_clr_value = &H0
        flag_spu_timout_mon_int_clr        = &H0
        write_dma_slave_timout_mon_int_clr_value = &H0
        flag_dma_slave_timout_mon_int_clr        = &H0
        write_to_cpu_sys_timout_mon_int_clr_value = &H0
        flag_to_cpu_sys_timout_mon_int_clr        = &H0
        write_ipc_timout_mon_int_clr_value = &H0
        flag_ipc_timout_mon_int_clr        = &H0
        write_sram_top_timout_mon_int_clr_value = &H0
        flag_sram_top_timout_mon_int_clr        = &H0
        write_ahb_n_apb_timout_mon_int_clr_value = &H0
        flag_ahb_n_apb_timout_mon_int_clr        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_disable_ahb_slave_timout_mon
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' spu_timout_mon_disable                     [5:5]            get_spu_timout_mon_disable
''                                                             set_spu_timout_mon_disable
''                                                             read_spu_timout_mon_disable
''                                                             write_spu_timout_mon_disable
''---------------------------------------------------------------------------------
'' dma_slave_timout_mon_disable               [4:4]            get_dma_slave_timout_mon_disable
''                                                             set_dma_slave_timout_mon_disable
''                                                             read_dma_slave_timout_mon_disable
''                                                             write_dma_slave_timout_mon_disable
''---------------------------------------------------------------------------------
'' to_cpu_sys_timout_mon_disable              [3:3]            get_to_cpu_sys_timout_mon_disable
''                                                             set_to_cpu_sys_timout_mon_disable
''                                                             read_to_cpu_sys_timout_mon_disable
''                                                             write_to_cpu_sys_timout_mon_disable
''---------------------------------------------------------------------------------
'' ipc_timout_mon_disable                     [2:2]            get_ipc_timout_mon_disable
''                                                             set_ipc_timout_mon_disable
''                                                             read_ipc_timout_mon_disable
''                                                             write_ipc_timout_mon_disable
''---------------------------------------------------------------------------------
'' sram_top_timout_mon_disable                [1:1]            get_sram_top_timout_mon_disable
''                                                             set_sram_top_timout_mon_disable
''                                                             read_sram_top_timout_mon_disable
''                                                             write_sram_top_timout_mon_disable
''---------------------------------------------------------------------------------
'' ahb_n_apb_timout_mon_disable               [0:0]            get_ahb_n_apb_timout_mon_disable
''                                                             set_ahb_n_apb_timout_mon_disable
''                                                             read_ahb_n_apb_timout_mon_disable
''                                                             write_ahb_n_apb_timout_mon_disable
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_disable_ahb_slave_timout_mon
    Private write_spu_timout_mon_disable_value
    Private read_spu_timout_mon_disable_value
    Private flag_spu_timout_mon_disable
    Private write_dma_slave_timout_mon_disable_value
    Private read_dma_slave_timout_mon_disable_value
    Private flag_dma_slave_timout_mon_disable
    Private write_to_cpu_sys_timout_mon_disable_value
    Private read_to_cpu_sys_timout_mon_disable_value
    Private flag_to_cpu_sys_timout_mon_disable
    Private write_ipc_timout_mon_disable_value
    Private read_ipc_timout_mon_disable_value
    Private flag_ipc_timout_mon_disable
    Private write_sram_top_timout_mon_disable_value
    Private read_sram_top_timout_mon_disable_value
    Private flag_sram_top_timout_mon_disable
    Private write_ahb_n_apb_timout_mon_disable_value
    Private read_ahb_n_apb_timout_mon_disable_value
    Private flag_ahb_n_apb_timout_mon_disable

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H2b8
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_spu_timout_mon_disable
        get_spu_timout_mon_disable = read_spu_timout_mon_disable_value
    End Property

    Property Let set_spu_timout_mon_disable(aData)
        write_spu_timout_mon_disable_value = aData
        flag_spu_timout_mon_disable        = &H1
    End Property

    Property Get read_spu_timout_mon_disable
        read
        read_spu_timout_mon_disable = read_spu_timout_mon_disable_value
    End Property

    Property Let write_spu_timout_mon_disable(aData)
        set_spu_timout_mon_disable = aData
        write
    End Property

    Property Get get_dma_slave_timout_mon_disable
        get_dma_slave_timout_mon_disable = read_dma_slave_timout_mon_disable_value
    End Property

    Property Let set_dma_slave_timout_mon_disable(aData)
        write_dma_slave_timout_mon_disable_value = aData
        flag_dma_slave_timout_mon_disable        = &H1
    End Property

    Property Get read_dma_slave_timout_mon_disable
        read
        read_dma_slave_timout_mon_disable = read_dma_slave_timout_mon_disable_value
    End Property

    Property Let write_dma_slave_timout_mon_disable(aData)
        set_dma_slave_timout_mon_disable = aData
        write
    End Property

    Property Get get_to_cpu_sys_timout_mon_disable
        get_to_cpu_sys_timout_mon_disable = read_to_cpu_sys_timout_mon_disable_value
    End Property

    Property Let set_to_cpu_sys_timout_mon_disable(aData)
        write_to_cpu_sys_timout_mon_disable_value = aData
        flag_to_cpu_sys_timout_mon_disable        = &H1
    End Property

    Property Get read_to_cpu_sys_timout_mon_disable
        read
        read_to_cpu_sys_timout_mon_disable = read_to_cpu_sys_timout_mon_disable_value
    End Property

    Property Let write_to_cpu_sys_timout_mon_disable(aData)
        set_to_cpu_sys_timout_mon_disable = aData
        write
    End Property

    Property Get get_ipc_timout_mon_disable
        get_ipc_timout_mon_disable = read_ipc_timout_mon_disable_value
    End Property

    Property Let set_ipc_timout_mon_disable(aData)
        write_ipc_timout_mon_disable_value = aData
        flag_ipc_timout_mon_disable        = &H1
    End Property

    Property Get read_ipc_timout_mon_disable
        read
        read_ipc_timout_mon_disable = read_ipc_timout_mon_disable_value
    End Property

    Property Let write_ipc_timout_mon_disable(aData)
        set_ipc_timout_mon_disable = aData
        write
    End Property

    Property Get get_sram_top_timout_mon_disable
        get_sram_top_timout_mon_disable = read_sram_top_timout_mon_disable_value
    End Property

    Property Let set_sram_top_timout_mon_disable(aData)
        write_sram_top_timout_mon_disable_value = aData
        flag_sram_top_timout_mon_disable        = &H1
    End Property

    Property Get read_sram_top_timout_mon_disable
        read
        read_sram_top_timout_mon_disable = read_sram_top_timout_mon_disable_value
    End Property

    Property Let write_sram_top_timout_mon_disable(aData)
        set_sram_top_timout_mon_disable = aData
        write
    End Property

    Property Get get_ahb_n_apb_timout_mon_disable
        get_ahb_n_apb_timout_mon_disable = read_ahb_n_apb_timout_mon_disable_value
    End Property

    Property Let set_ahb_n_apb_timout_mon_disable(aData)
        write_ahb_n_apb_timout_mon_disable_value = aData
        flag_ahb_n_apb_timout_mon_disable        = &H1
    End Property

    Property Get read_ahb_n_apb_timout_mon_disable
        read
        read_ahb_n_apb_timout_mon_disable = read_ahb_n_apb_timout_mon_disable_value
    End Property

    Property Let write_ahb_n_apb_timout_mon_disable(aData)
        set_ahb_n_apb_timout_mon_disable = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_spu_timout_mon_disable_value = rightShift(data_low, 5) and &H1
        read_dma_slave_timout_mon_disable_value = rightShift(data_low, 4) and &H1
        read_to_cpu_sys_timout_mon_disable_value = rightShift(data_low, 3) and &H1
        read_ipc_timout_mon_disable_value = rightShift(data_low, 2) and &H1
        read_sram_top_timout_mon_disable_value = rightShift(data_low, 1) and &H1
        ahb_n_apb_timout_mon_disable_mask = &H1
        if data_low > LONG_MAX then
            if ahb_n_apb_timout_mon_disable_mask = mask then
                read_ahb_n_apb_timout_mon_disable_value = data_low
            else
                read_ahb_n_apb_timout_mon_disable_value = (data_low - H8000_0000) and ahb_n_apb_timout_mon_disable_mask
            end If
        else
            read_ahb_n_apb_timout_mon_disable_value = data_low and ahb_n_apb_timout_mon_disable_mask
        end If

    End Sub

    Sub write
        If flag_spu_timout_mon_disable = &H0 or flag_dma_slave_timout_mon_disable = &H0 or flag_to_cpu_sys_timout_mon_disable = &H0 or flag_ipc_timout_mon_disable = &H0 or flag_sram_top_timout_mon_disable = &H0 or flag_ahb_n_apb_timout_mon_disable = &H0 Then read
        If flag_spu_timout_mon_disable = &H0 Then write_spu_timout_mon_disable_value = get_spu_timout_mon_disable
        If flag_dma_slave_timout_mon_disable = &H0 Then write_dma_slave_timout_mon_disable_value = get_dma_slave_timout_mon_disable
        If flag_to_cpu_sys_timout_mon_disable = &H0 Then write_to_cpu_sys_timout_mon_disable_value = get_to_cpu_sys_timout_mon_disable
        If flag_ipc_timout_mon_disable = &H0 Then write_ipc_timout_mon_disable_value = get_ipc_timout_mon_disable
        If flag_sram_top_timout_mon_disable = &H0 Then write_sram_top_timout_mon_disable_value = get_sram_top_timout_mon_disable
        If flag_ahb_n_apb_timout_mon_disable = &H0 Then write_ahb_n_apb_timout_mon_disable_value = get_ahb_n_apb_timout_mon_disable

        regValue = leftShift((write_spu_timout_mon_disable_value and &H1), 5) + leftShift((write_dma_slave_timout_mon_disable_value and &H1), 4) + leftShift((write_to_cpu_sys_timout_mon_disable_value and &H1), 3) + leftShift((write_ipc_timout_mon_disable_value and &H1), 2) + leftShift((write_sram_top_timout_mon_disable_value and &H1), 1) + leftShift((write_ahb_n_apb_timout_mon_disable_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_spu_timout_mon_disable_value = rightShift(data_low, 5) and &H1
        read_dma_slave_timout_mon_disable_value = rightShift(data_low, 4) and &H1
        read_to_cpu_sys_timout_mon_disable_value = rightShift(data_low, 3) and &H1
        read_ipc_timout_mon_disable_value = rightShift(data_low, 2) and &H1
        read_sram_top_timout_mon_disable_value = rightShift(data_low, 1) and &H1
        ahb_n_apb_timout_mon_disable_mask = &H1
        if data_low > LONG_MAX then
            if ahb_n_apb_timout_mon_disable_mask = mask then
                read_ahb_n_apb_timout_mon_disable_value = data_low
            else
                read_ahb_n_apb_timout_mon_disable_value = (data_low - H8000_0000) and ahb_n_apb_timout_mon_disable_mask
            end If
        else
            read_ahb_n_apb_timout_mon_disable_value = data_low and ahb_n_apb_timout_mon_disable_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_spu_timout_mon_disable_value = &H0
        flag_spu_timout_mon_disable        = &H0
        write_dma_slave_timout_mon_disable_value = &H0
        flag_dma_slave_timout_mon_disable        = &H0
        write_to_cpu_sys_timout_mon_disable_value = &H0
        flag_to_cpu_sys_timout_mon_disable        = &H0
        write_ipc_timout_mon_disable_value = &H0
        flag_ipc_timout_mon_disable        = &H0
        write_sram_top_timout_mon_disable_value = &H0
        flag_sram_top_timout_mon_disable        = &H0
        write_ahb_n_apb_timout_mon_disable_value = &H0
        flag_ahb_n_apb_timout_mon_disable        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_ecc_interrupt
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' spum_kek_ecc_ded_flag_int                  [25:25]          get_spum_kek_ecc_ded_flag_int
''                                                             set_spum_kek_ecc_ded_flag_int
''                                                             read_spum_kek_ecc_ded_flag_int
''                                                             write_spum_kek_ecc_ded_flag_int
''---------------------------------------------------------------------------------
'' spum_kek_ecc_sec_flag_int                  [24:24]          get_spum_kek_ecc_sec_flag_int
''                                                             set_spum_kek_ecc_sec_flag_int
''                                                             read_spum_kek_ecc_sec_flag_int
''                                                             write_spum_kek_ecc_sec_flag_int
''---------------------------------------------------------------------------------
'' spum_aubps_ecc_ded_flag_int                [23:23]          get_spum_aubps_ecc_ded_flag_int
''                                                             set_spum_aubps_ecc_ded_flag_int
''                                                             read_spum_aubps_ecc_ded_flag_int
''                                                             write_spum_aubps_ecc_ded_flag_int
''---------------------------------------------------------------------------------
'' spum_aubps_ecc_sec_flag_int                [22:22]          get_spum_aubps_ecc_sec_flag_int
''                                                             set_spum_aubps_ecc_sec_flag_int
''                                                             read_spum_aubps_ecc_sec_flag_int
''                                                             write_spum_aubps_ecc_sec_flag_int
''---------------------------------------------------------------------------------
'' spum_creaes_ecc_ded_flag_int               [21:21]          get_spum_creaes_ecc_ded_flag_int
''                                                             set_spum_creaes_ecc_ded_flag_int
''                                                             read_spum_creaes_ecc_ded_flag_int
''                                                             write_spum_creaes_ecc_ded_flag_int
''---------------------------------------------------------------------------------
'' spum_creaes_ecc_sec_flag_int               [20:20]          get_spum_creaes_ecc_sec_flag_int
''                                                             set_spum_creaes_ecc_sec_flag_int
''                                                             read_spum_creaes_ecc_sec_flag_int
''                                                             write_spum_creaes_ecc_sec_flag_int
''---------------------------------------------------------------------------------
'' spum_crbps_ecc_ded_flag_int                [19:19]          get_spum_crbps_ecc_ded_flag_int
''                                                             set_spum_crbps_ecc_ded_flag_int
''                                                             read_spum_crbps_ecc_ded_flag_int
''                                                             write_spum_crbps_ecc_ded_flag_int
''---------------------------------------------------------------------------------
'' spum_crbps_ecc_sec_flag_int                [18:18]          get_spum_crbps_ecc_sec_flag_int
''                                                             set_spum_crbps_ecc_sec_flag_int
''                                                             read_spum_crbps_ecc_sec_flag_int
''                                                             write_spum_crbps_ecc_sec_flag_int
''---------------------------------------------------------------------------------
'' spum_pafifo_ecc_ded_flag_int               [17:17]          get_spum_pafifo_ecc_ded_flag_int
''                                                             set_spum_pafifo_ecc_ded_flag_int
''                                                             read_spum_pafifo_ecc_ded_flag_int
''                                                             write_spum_pafifo_ecc_ded_flag_int
''---------------------------------------------------------------------------------
'' spum_pafifo_ecc_sec_flag_int               [16:16]          get_spum_pafifo_ecc_sec_flag_int
''                                                             set_spum_pafifo_ecc_sec_flag_int
''                                                             read_spum_pafifo_ecc_sec_flag_int
''                                                             write_spum_pafifo_ecc_sec_flag_int
''---------------------------------------------------------------------------------
'' spum_pasctx_ecc_ded_flag_int               [15:15]          get_spum_pasctx_ecc_ded_flag_int
''                                                             set_spum_pasctx_ecc_ded_flag_int
''                                                             read_spum_pasctx_ecc_ded_flag_int
''                                                             write_spum_pasctx_ecc_ded_flag_int
''---------------------------------------------------------------------------------
'' spum_pasctx_ecc_sec_flag_int               [14:14]          get_spum_pasctx_ecc_sec_flag_int
''                                                             set_spum_pasctx_ecc_sec_flag_int
''                                                             read_spum_pasctx_ecc_sec_flag_int
''                                                             write_spum_pasctx_ecc_sec_flag_int
''---------------------------------------------------------------------------------
'' spum_ppsupdt_ecc_ded_flag_int              [13:13]          get_spum_ppsupdt_ecc_ded_flag_int
''                                                             set_spum_ppsupdt_ecc_ded_flag_int
''                                                             read_spum_ppsupdt_ecc_ded_flag_int
''                                                             write_spum_ppsupdt_ecc_ded_flag_int
''---------------------------------------------------------------------------------
'' spum_ppsupdt_ecc_sec_flag_int              [12:12]          get_spum_ppsupdt_ecc_sec_flag_int
''                                                             set_spum_ppsupdt_ecc_sec_flag_int
''                                                             read_spum_ppsupdt_ecc_sec_flag_int
''                                                             write_spum_ppsupdt_ecc_sec_flag_int
''---------------------------------------------------------------------------------
'' pka_opp_ecc_ded_flag_int                   [11:11]          get_pka_opp_ecc_ded_flag_int
''                                                             set_pka_opp_ecc_ded_flag_int
''                                                             read_pka_opp_ecc_ded_flag_int
''                                                             write_pka_opp_ecc_ded_flag_int
''---------------------------------------------------------------------------------
'' pka_opp_ecc_sec_flag_int                   [10:10]          get_pka_opp_ecc_sec_flag_int
''                                                             set_pka_opp_ecc_sec_flag_int
''                                                             read_pka_opp_ecc_sec_flag_int
''                                                             write_pka_opp_ecc_sec_flag_int
''---------------------------------------------------------------------------------
'' pka_lir1_ecc_ded_flag_int                  [9:9]            get_pka_lir1_ecc_ded_flag_int
''                                                             set_pka_lir1_ecc_ded_flag_int
''                                                             read_pka_lir1_ecc_ded_flag_int
''                                                             write_pka_lir1_ecc_ded_flag_int
''---------------------------------------------------------------------------------
'' pka_lir1_ecc_sec_flag_int                  [8:8]            get_pka_lir1_ecc_sec_flag_int
''                                                             set_pka_lir1_ecc_sec_flag_int
''                                                             read_pka_lir1_ecc_sec_flag_int
''                                                             write_pka_lir1_ecc_sec_flag_int
''---------------------------------------------------------------------------------
'' pka_lir0_ecc_ded_flag_int                  [7:7]            get_pka_lir0_ecc_ded_flag_int
''                                                             set_pka_lir0_ecc_ded_flag_int
''                                                             read_pka_lir0_ecc_ded_flag_int
''                                                             write_pka_lir0_ecc_ded_flag_int
''---------------------------------------------------------------------------------
'' pka_lir0_ecc_sec_flag_int                  [6:6]            get_pka_lir0_ecc_sec_flag_int
''                                                             set_pka_lir0_ecc_sec_flag_int
''                                                             read_pka_lir0_ecc_sec_flag_int
''                                                             write_pka_lir0_ecc_sec_flag_int
''---------------------------------------------------------------------------------
'' dmem_ecc_ded_flag_int                      [5:5]            get_dmem_ecc_ded_flag_int
''                                                             set_dmem_ecc_ded_flag_int
''                                                             read_dmem_ecc_ded_flag_int
''                                                             write_dmem_ecc_ded_flag_int
''---------------------------------------------------------------------------------
'' dmem_ecc_sec_flag_int                      [4:4]            get_dmem_ecc_sec_flag_int
''                                                             set_dmem_ecc_sec_flag_int
''                                                             read_dmem_ecc_sec_flag_int
''                                                             write_dmem_ecc_sec_flag_int
''---------------------------------------------------------------------------------
'' imem_ecc_ded_flag_int                      [3:3]            get_imem_ecc_ded_flag_int
''                                                             set_imem_ecc_ded_flag_int
''                                                             read_imem_ecc_ded_flag_int
''                                                             write_imem_ecc_ded_flag_int
''---------------------------------------------------------------------------------
'' imem_ecc_sec_flag_int                      [2:2]            get_imem_ecc_sec_flag_int
''                                                             set_imem_ecc_sec_flag_int
''                                                             read_imem_ecc_sec_flag_int
''                                                             write_imem_ecc_sec_flag_int
''---------------------------------------------------------------------------------
'' sram_ecc_ded_flag_int                      [1:1]            get_sram_ecc_ded_flag_int
''                                                             set_sram_ecc_ded_flag_int
''                                                             read_sram_ecc_ded_flag_int
''                                                             write_sram_ecc_ded_flag_int
''---------------------------------------------------------------------------------
'' sram_ecc_sec_flag_int                      [0:0]            get_sram_ecc_sec_flag_int
''                                                             set_sram_ecc_sec_flag_int
''                                                             read_sram_ecc_sec_flag_int
''                                                             write_sram_ecc_sec_flag_int
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_ecc_interrupt
    Private write_spum_kek_ecc_ded_flag_int_value
    Private read_spum_kek_ecc_ded_flag_int_value
    Private flag_spum_kek_ecc_ded_flag_int
    Private write_spum_kek_ecc_sec_flag_int_value
    Private read_spum_kek_ecc_sec_flag_int_value
    Private flag_spum_kek_ecc_sec_flag_int
    Private write_spum_aubps_ecc_ded_flag_int_value
    Private read_spum_aubps_ecc_ded_flag_int_value
    Private flag_spum_aubps_ecc_ded_flag_int
    Private write_spum_aubps_ecc_sec_flag_int_value
    Private read_spum_aubps_ecc_sec_flag_int_value
    Private flag_spum_aubps_ecc_sec_flag_int
    Private write_spum_creaes_ecc_ded_flag_int_value
    Private read_spum_creaes_ecc_ded_flag_int_value
    Private flag_spum_creaes_ecc_ded_flag_int
    Private write_spum_creaes_ecc_sec_flag_int_value
    Private read_spum_creaes_ecc_sec_flag_int_value
    Private flag_spum_creaes_ecc_sec_flag_int
    Private write_spum_crbps_ecc_ded_flag_int_value
    Private read_spum_crbps_ecc_ded_flag_int_value
    Private flag_spum_crbps_ecc_ded_flag_int
    Private write_spum_crbps_ecc_sec_flag_int_value
    Private read_spum_crbps_ecc_sec_flag_int_value
    Private flag_spum_crbps_ecc_sec_flag_int
    Private write_spum_pafifo_ecc_ded_flag_int_value
    Private read_spum_pafifo_ecc_ded_flag_int_value
    Private flag_spum_pafifo_ecc_ded_flag_int
    Private write_spum_pafifo_ecc_sec_flag_int_value
    Private read_spum_pafifo_ecc_sec_flag_int_value
    Private flag_spum_pafifo_ecc_sec_flag_int
    Private write_spum_pasctx_ecc_ded_flag_int_value
    Private read_spum_pasctx_ecc_ded_flag_int_value
    Private flag_spum_pasctx_ecc_ded_flag_int
    Private write_spum_pasctx_ecc_sec_flag_int_value
    Private read_spum_pasctx_ecc_sec_flag_int_value
    Private flag_spum_pasctx_ecc_sec_flag_int
    Private write_spum_ppsupdt_ecc_ded_flag_int_value
    Private read_spum_ppsupdt_ecc_ded_flag_int_value
    Private flag_spum_ppsupdt_ecc_ded_flag_int
    Private write_spum_ppsupdt_ecc_sec_flag_int_value
    Private read_spum_ppsupdt_ecc_sec_flag_int_value
    Private flag_spum_ppsupdt_ecc_sec_flag_int
    Private write_pka_opp_ecc_ded_flag_int_value
    Private read_pka_opp_ecc_ded_flag_int_value
    Private flag_pka_opp_ecc_ded_flag_int
    Private write_pka_opp_ecc_sec_flag_int_value
    Private read_pka_opp_ecc_sec_flag_int_value
    Private flag_pka_opp_ecc_sec_flag_int
    Private write_pka_lir1_ecc_ded_flag_int_value
    Private read_pka_lir1_ecc_ded_flag_int_value
    Private flag_pka_lir1_ecc_ded_flag_int
    Private write_pka_lir1_ecc_sec_flag_int_value
    Private read_pka_lir1_ecc_sec_flag_int_value
    Private flag_pka_lir1_ecc_sec_flag_int
    Private write_pka_lir0_ecc_ded_flag_int_value
    Private read_pka_lir0_ecc_ded_flag_int_value
    Private flag_pka_lir0_ecc_ded_flag_int
    Private write_pka_lir0_ecc_sec_flag_int_value
    Private read_pka_lir0_ecc_sec_flag_int_value
    Private flag_pka_lir0_ecc_sec_flag_int
    Private write_dmem_ecc_ded_flag_int_value
    Private read_dmem_ecc_ded_flag_int_value
    Private flag_dmem_ecc_ded_flag_int
    Private write_dmem_ecc_sec_flag_int_value
    Private read_dmem_ecc_sec_flag_int_value
    Private flag_dmem_ecc_sec_flag_int
    Private write_imem_ecc_ded_flag_int_value
    Private read_imem_ecc_ded_flag_int_value
    Private flag_imem_ecc_ded_flag_int
    Private write_imem_ecc_sec_flag_int_value
    Private read_imem_ecc_sec_flag_int_value
    Private flag_imem_ecc_sec_flag_int
    Private write_sram_ecc_ded_flag_int_value
    Private read_sram_ecc_ded_flag_int_value
    Private flag_sram_ecc_ded_flag_int
    Private write_sram_ecc_sec_flag_int_value
    Private read_sram_ecc_sec_flag_int_value
    Private flag_sram_ecc_sec_flag_int

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H2bc
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_spum_kek_ecc_ded_flag_int
        get_spum_kek_ecc_ded_flag_int = read_spum_kek_ecc_ded_flag_int_value
    End Property

    Property Let set_spum_kek_ecc_ded_flag_int(aData)
        write_spum_kek_ecc_ded_flag_int_value = aData
        flag_spum_kek_ecc_ded_flag_int        = &H1
    End Property

    Property Get read_spum_kek_ecc_ded_flag_int
        read
        read_spum_kek_ecc_ded_flag_int = read_spum_kek_ecc_ded_flag_int_value
    End Property

    Property Let write_spum_kek_ecc_ded_flag_int(aData)
        set_spum_kek_ecc_ded_flag_int = aData
        write
    End Property

    Property Get get_spum_kek_ecc_sec_flag_int
        get_spum_kek_ecc_sec_flag_int = read_spum_kek_ecc_sec_flag_int_value
    End Property

    Property Let set_spum_kek_ecc_sec_flag_int(aData)
        write_spum_kek_ecc_sec_flag_int_value = aData
        flag_spum_kek_ecc_sec_flag_int        = &H1
    End Property

    Property Get read_spum_kek_ecc_sec_flag_int
        read
        read_spum_kek_ecc_sec_flag_int = read_spum_kek_ecc_sec_flag_int_value
    End Property

    Property Let write_spum_kek_ecc_sec_flag_int(aData)
        set_spum_kek_ecc_sec_flag_int = aData
        write
    End Property

    Property Get get_spum_aubps_ecc_ded_flag_int
        get_spum_aubps_ecc_ded_flag_int = read_spum_aubps_ecc_ded_flag_int_value
    End Property

    Property Let set_spum_aubps_ecc_ded_flag_int(aData)
        write_spum_aubps_ecc_ded_flag_int_value = aData
        flag_spum_aubps_ecc_ded_flag_int        = &H1
    End Property

    Property Get read_spum_aubps_ecc_ded_flag_int
        read
        read_spum_aubps_ecc_ded_flag_int = read_spum_aubps_ecc_ded_flag_int_value
    End Property

    Property Let write_spum_aubps_ecc_ded_flag_int(aData)
        set_spum_aubps_ecc_ded_flag_int = aData
        write
    End Property

    Property Get get_spum_aubps_ecc_sec_flag_int
        get_spum_aubps_ecc_sec_flag_int = read_spum_aubps_ecc_sec_flag_int_value
    End Property

    Property Let set_spum_aubps_ecc_sec_flag_int(aData)
        write_spum_aubps_ecc_sec_flag_int_value = aData
        flag_spum_aubps_ecc_sec_flag_int        = &H1
    End Property

    Property Get read_spum_aubps_ecc_sec_flag_int
        read
        read_spum_aubps_ecc_sec_flag_int = read_spum_aubps_ecc_sec_flag_int_value
    End Property

    Property Let write_spum_aubps_ecc_sec_flag_int(aData)
        set_spum_aubps_ecc_sec_flag_int = aData
        write
    End Property

    Property Get get_spum_creaes_ecc_ded_flag_int
        get_spum_creaes_ecc_ded_flag_int = read_spum_creaes_ecc_ded_flag_int_value
    End Property

    Property Let set_spum_creaes_ecc_ded_flag_int(aData)
        write_spum_creaes_ecc_ded_flag_int_value = aData
        flag_spum_creaes_ecc_ded_flag_int        = &H1
    End Property

    Property Get read_spum_creaes_ecc_ded_flag_int
        read
        read_spum_creaes_ecc_ded_flag_int = read_spum_creaes_ecc_ded_flag_int_value
    End Property

    Property Let write_spum_creaes_ecc_ded_flag_int(aData)
        set_spum_creaes_ecc_ded_flag_int = aData
        write
    End Property

    Property Get get_spum_creaes_ecc_sec_flag_int
        get_spum_creaes_ecc_sec_flag_int = read_spum_creaes_ecc_sec_flag_int_value
    End Property

    Property Let set_spum_creaes_ecc_sec_flag_int(aData)
        write_spum_creaes_ecc_sec_flag_int_value = aData
        flag_spum_creaes_ecc_sec_flag_int        = &H1
    End Property

    Property Get read_spum_creaes_ecc_sec_flag_int
        read
        read_spum_creaes_ecc_sec_flag_int = read_spum_creaes_ecc_sec_flag_int_value
    End Property

    Property Let write_spum_creaes_ecc_sec_flag_int(aData)
        set_spum_creaes_ecc_sec_flag_int = aData
        write
    End Property

    Property Get get_spum_crbps_ecc_ded_flag_int
        get_spum_crbps_ecc_ded_flag_int = read_spum_crbps_ecc_ded_flag_int_value
    End Property

    Property Let set_spum_crbps_ecc_ded_flag_int(aData)
        write_spum_crbps_ecc_ded_flag_int_value = aData
        flag_spum_crbps_ecc_ded_flag_int        = &H1
    End Property

    Property Get read_spum_crbps_ecc_ded_flag_int
        read
        read_spum_crbps_ecc_ded_flag_int = read_spum_crbps_ecc_ded_flag_int_value
    End Property

    Property Let write_spum_crbps_ecc_ded_flag_int(aData)
        set_spum_crbps_ecc_ded_flag_int = aData
        write
    End Property

    Property Get get_spum_crbps_ecc_sec_flag_int
        get_spum_crbps_ecc_sec_flag_int = read_spum_crbps_ecc_sec_flag_int_value
    End Property

    Property Let set_spum_crbps_ecc_sec_flag_int(aData)
        write_spum_crbps_ecc_sec_flag_int_value = aData
        flag_spum_crbps_ecc_sec_flag_int        = &H1
    End Property

    Property Get read_spum_crbps_ecc_sec_flag_int
        read
        read_spum_crbps_ecc_sec_flag_int = read_spum_crbps_ecc_sec_flag_int_value
    End Property

    Property Let write_spum_crbps_ecc_sec_flag_int(aData)
        set_spum_crbps_ecc_sec_flag_int = aData
        write
    End Property

    Property Get get_spum_pafifo_ecc_ded_flag_int
        get_spum_pafifo_ecc_ded_flag_int = read_spum_pafifo_ecc_ded_flag_int_value
    End Property

    Property Let set_spum_pafifo_ecc_ded_flag_int(aData)
        write_spum_pafifo_ecc_ded_flag_int_value = aData
        flag_spum_pafifo_ecc_ded_flag_int        = &H1
    End Property

    Property Get read_spum_pafifo_ecc_ded_flag_int
        read
        read_spum_pafifo_ecc_ded_flag_int = read_spum_pafifo_ecc_ded_flag_int_value
    End Property

    Property Let write_spum_pafifo_ecc_ded_flag_int(aData)
        set_spum_pafifo_ecc_ded_flag_int = aData
        write
    End Property

    Property Get get_spum_pafifo_ecc_sec_flag_int
        get_spum_pafifo_ecc_sec_flag_int = read_spum_pafifo_ecc_sec_flag_int_value
    End Property

    Property Let set_spum_pafifo_ecc_sec_flag_int(aData)
        write_spum_pafifo_ecc_sec_flag_int_value = aData
        flag_spum_pafifo_ecc_sec_flag_int        = &H1
    End Property

    Property Get read_spum_pafifo_ecc_sec_flag_int
        read
        read_spum_pafifo_ecc_sec_flag_int = read_spum_pafifo_ecc_sec_flag_int_value
    End Property

    Property Let write_spum_pafifo_ecc_sec_flag_int(aData)
        set_spum_pafifo_ecc_sec_flag_int = aData
        write
    End Property

    Property Get get_spum_pasctx_ecc_ded_flag_int
        get_spum_pasctx_ecc_ded_flag_int = read_spum_pasctx_ecc_ded_flag_int_value
    End Property

    Property Let set_spum_pasctx_ecc_ded_flag_int(aData)
        write_spum_pasctx_ecc_ded_flag_int_value = aData
        flag_spum_pasctx_ecc_ded_flag_int        = &H1
    End Property

    Property Get read_spum_pasctx_ecc_ded_flag_int
        read
        read_spum_pasctx_ecc_ded_flag_int = read_spum_pasctx_ecc_ded_flag_int_value
    End Property

    Property Let write_spum_pasctx_ecc_ded_flag_int(aData)
        set_spum_pasctx_ecc_ded_flag_int = aData
        write
    End Property

    Property Get get_spum_pasctx_ecc_sec_flag_int
        get_spum_pasctx_ecc_sec_flag_int = read_spum_pasctx_ecc_sec_flag_int_value
    End Property

    Property Let set_spum_pasctx_ecc_sec_flag_int(aData)
        write_spum_pasctx_ecc_sec_flag_int_value = aData
        flag_spum_pasctx_ecc_sec_flag_int        = &H1
    End Property

    Property Get read_spum_pasctx_ecc_sec_flag_int
        read
        read_spum_pasctx_ecc_sec_flag_int = read_spum_pasctx_ecc_sec_flag_int_value
    End Property

    Property Let write_spum_pasctx_ecc_sec_flag_int(aData)
        set_spum_pasctx_ecc_sec_flag_int = aData
        write
    End Property

    Property Get get_spum_ppsupdt_ecc_ded_flag_int
        get_spum_ppsupdt_ecc_ded_flag_int = read_spum_ppsupdt_ecc_ded_flag_int_value
    End Property

    Property Let set_spum_ppsupdt_ecc_ded_flag_int(aData)
        write_spum_ppsupdt_ecc_ded_flag_int_value = aData
        flag_spum_ppsupdt_ecc_ded_flag_int        = &H1
    End Property

    Property Get read_spum_ppsupdt_ecc_ded_flag_int
        read
        read_spum_ppsupdt_ecc_ded_flag_int = read_spum_ppsupdt_ecc_ded_flag_int_value
    End Property

    Property Let write_spum_ppsupdt_ecc_ded_flag_int(aData)
        set_spum_ppsupdt_ecc_ded_flag_int = aData
        write
    End Property

    Property Get get_spum_ppsupdt_ecc_sec_flag_int
        get_spum_ppsupdt_ecc_sec_flag_int = read_spum_ppsupdt_ecc_sec_flag_int_value
    End Property

    Property Let set_spum_ppsupdt_ecc_sec_flag_int(aData)
        write_spum_ppsupdt_ecc_sec_flag_int_value = aData
        flag_spum_ppsupdt_ecc_sec_flag_int        = &H1
    End Property

    Property Get read_spum_ppsupdt_ecc_sec_flag_int
        read
        read_spum_ppsupdt_ecc_sec_flag_int = read_spum_ppsupdt_ecc_sec_flag_int_value
    End Property

    Property Let write_spum_ppsupdt_ecc_sec_flag_int(aData)
        set_spum_ppsupdt_ecc_sec_flag_int = aData
        write
    End Property

    Property Get get_pka_opp_ecc_ded_flag_int
        get_pka_opp_ecc_ded_flag_int = read_pka_opp_ecc_ded_flag_int_value
    End Property

    Property Let set_pka_opp_ecc_ded_flag_int(aData)
        write_pka_opp_ecc_ded_flag_int_value = aData
        flag_pka_opp_ecc_ded_flag_int        = &H1
    End Property

    Property Get read_pka_opp_ecc_ded_flag_int
        read
        read_pka_opp_ecc_ded_flag_int = read_pka_opp_ecc_ded_flag_int_value
    End Property

    Property Let write_pka_opp_ecc_ded_flag_int(aData)
        set_pka_opp_ecc_ded_flag_int = aData
        write
    End Property

    Property Get get_pka_opp_ecc_sec_flag_int
        get_pka_opp_ecc_sec_flag_int = read_pka_opp_ecc_sec_flag_int_value
    End Property

    Property Let set_pka_opp_ecc_sec_flag_int(aData)
        write_pka_opp_ecc_sec_flag_int_value = aData
        flag_pka_opp_ecc_sec_flag_int        = &H1
    End Property

    Property Get read_pka_opp_ecc_sec_flag_int
        read
        read_pka_opp_ecc_sec_flag_int = read_pka_opp_ecc_sec_flag_int_value
    End Property

    Property Let write_pka_opp_ecc_sec_flag_int(aData)
        set_pka_opp_ecc_sec_flag_int = aData
        write
    End Property

    Property Get get_pka_lir1_ecc_ded_flag_int
        get_pka_lir1_ecc_ded_flag_int = read_pka_lir1_ecc_ded_flag_int_value
    End Property

    Property Let set_pka_lir1_ecc_ded_flag_int(aData)
        write_pka_lir1_ecc_ded_flag_int_value = aData
        flag_pka_lir1_ecc_ded_flag_int        = &H1
    End Property

    Property Get read_pka_lir1_ecc_ded_flag_int
        read
        read_pka_lir1_ecc_ded_flag_int = read_pka_lir1_ecc_ded_flag_int_value
    End Property

    Property Let write_pka_lir1_ecc_ded_flag_int(aData)
        set_pka_lir1_ecc_ded_flag_int = aData
        write
    End Property

    Property Get get_pka_lir1_ecc_sec_flag_int
        get_pka_lir1_ecc_sec_flag_int = read_pka_lir1_ecc_sec_flag_int_value
    End Property

    Property Let set_pka_lir1_ecc_sec_flag_int(aData)
        write_pka_lir1_ecc_sec_flag_int_value = aData
        flag_pka_lir1_ecc_sec_flag_int        = &H1
    End Property

    Property Get read_pka_lir1_ecc_sec_flag_int
        read
        read_pka_lir1_ecc_sec_flag_int = read_pka_lir1_ecc_sec_flag_int_value
    End Property

    Property Let write_pka_lir1_ecc_sec_flag_int(aData)
        set_pka_lir1_ecc_sec_flag_int = aData
        write
    End Property

    Property Get get_pka_lir0_ecc_ded_flag_int
        get_pka_lir0_ecc_ded_flag_int = read_pka_lir0_ecc_ded_flag_int_value
    End Property

    Property Let set_pka_lir0_ecc_ded_flag_int(aData)
        write_pka_lir0_ecc_ded_flag_int_value = aData
        flag_pka_lir0_ecc_ded_flag_int        = &H1
    End Property

    Property Get read_pka_lir0_ecc_ded_flag_int
        read
        read_pka_lir0_ecc_ded_flag_int = read_pka_lir0_ecc_ded_flag_int_value
    End Property

    Property Let write_pka_lir0_ecc_ded_flag_int(aData)
        set_pka_lir0_ecc_ded_flag_int = aData
        write
    End Property

    Property Get get_pka_lir0_ecc_sec_flag_int
        get_pka_lir0_ecc_sec_flag_int = read_pka_lir0_ecc_sec_flag_int_value
    End Property

    Property Let set_pka_lir0_ecc_sec_flag_int(aData)
        write_pka_lir0_ecc_sec_flag_int_value = aData
        flag_pka_lir0_ecc_sec_flag_int        = &H1
    End Property

    Property Get read_pka_lir0_ecc_sec_flag_int
        read
        read_pka_lir0_ecc_sec_flag_int = read_pka_lir0_ecc_sec_flag_int_value
    End Property

    Property Let write_pka_lir0_ecc_sec_flag_int(aData)
        set_pka_lir0_ecc_sec_flag_int = aData
        write
    End Property

    Property Get get_dmem_ecc_ded_flag_int
        get_dmem_ecc_ded_flag_int = read_dmem_ecc_ded_flag_int_value
    End Property

    Property Let set_dmem_ecc_ded_flag_int(aData)
        write_dmem_ecc_ded_flag_int_value = aData
        flag_dmem_ecc_ded_flag_int        = &H1
    End Property

    Property Get read_dmem_ecc_ded_flag_int
        read
        read_dmem_ecc_ded_flag_int = read_dmem_ecc_ded_flag_int_value
    End Property

    Property Let write_dmem_ecc_ded_flag_int(aData)
        set_dmem_ecc_ded_flag_int = aData
        write
    End Property

    Property Get get_dmem_ecc_sec_flag_int
        get_dmem_ecc_sec_flag_int = read_dmem_ecc_sec_flag_int_value
    End Property

    Property Let set_dmem_ecc_sec_flag_int(aData)
        write_dmem_ecc_sec_flag_int_value = aData
        flag_dmem_ecc_sec_flag_int        = &H1
    End Property

    Property Get read_dmem_ecc_sec_flag_int
        read
        read_dmem_ecc_sec_flag_int = read_dmem_ecc_sec_flag_int_value
    End Property

    Property Let write_dmem_ecc_sec_flag_int(aData)
        set_dmem_ecc_sec_flag_int = aData
        write
    End Property

    Property Get get_imem_ecc_ded_flag_int
        get_imem_ecc_ded_flag_int = read_imem_ecc_ded_flag_int_value
    End Property

    Property Let set_imem_ecc_ded_flag_int(aData)
        write_imem_ecc_ded_flag_int_value = aData
        flag_imem_ecc_ded_flag_int        = &H1
    End Property

    Property Get read_imem_ecc_ded_flag_int
        read
        read_imem_ecc_ded_flag_int = read_imem_ecc_ded_flag_int_value
    End Property

    Property Let write_imem_ecc_ded_flag_int(aData)
        set_imem_ecc_ded_flag_int = aData
        write
    End Property

    Property Get get_imem_ecc_sec_flag_int
        get_imem_ecc_sec_flag_int = read_imem_ecc_sec_flag_int_value
    End Property

    Property Let set_imem_ecc_sec_flag_int(aData)
        write_imem_ecc_sec_flag_int_value = aData
        flag_imem_ecc_sec_flag_int        = &H1
    End Property

    Property Get read_imem_ecc_sec_flag_int
        read
        read_imem_ecc_sec_flag_int = read_imem_ecc_sec_flag_int_value
    End Property

    Property Let write_imem_ecc_sec_flag_int(aData)
        set_imem_ecc_sec_flag_int = aData
        write
    End Property

    Property Get get_sram_ecc_ded_flag_int
        get_sram_ecc_ded_flag_int = read_sram_ecc_ded_flag_int_value
    End Property

    Property Let set_sram_ecc_ded_flag_int(aData)
        write_sram_ecc_ded_flag_int_value = aData
        flag_sram_ecc_ded_flag_int        = &H1
    End Property

    Property Get read_sram_ecc_ded_flag_int
        read
        read_sram_ecc_ded_flag_int = read_sram_ecc_ded_flag_int_value
    End Property

    Property Let write_sram_ecc_ded_flag_int(aData)
        set_sram_ecc_ded_flag_int = aData
        write
    End Property

    Property Get get_sram_ecc_sec_flag_int
        get_sram_ecc_sec_flag_int = read_sram_ecc_sec_flag_int_value
    End Property

    Property Let set_sram_ecc_sec_flag_int(aData)
        write_sram_ecc_sec_flag_int_value = aData
        flag_sram_ecc_sec_flag_int        = &H1
    End Property

    Property Get read_sram_ecc_sec_flag_int
        read
        read_sram_ecc_sec_flag_int = read_sram_ecc_sec_flag_int_value
    End Property

    Property Let write_sram_ecc_sec_flag_int(aData)
        set_sram_ecc_sec_flag_int = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_spum_kek_ecc_ded_flag_int_value = rightShift(data_low, 25) and &H1
        read_spum_kek_ecc_sec_flag_int_value = rightShift(data_low, 24) and &H1
        read_spum_aubps_ecc_ded_flag_int_value = rightShift(data_low, 23) and &H1
        read_spum_aubps_ecc_sec_flag_int_value = rightShift(data_low, 22) and &H1
        read_spum_creaes_ecc_ded_flag_int_value = rightShift(data_low, 21) and &H1
        read_spum_creaes_ecc_sec_flag_int_value = rightShift(data_low, 20) and &H1
        read_spum_crbps_ecc_ded_flag_int_value = rightShift(data_low, 19) and &H1
        read_spum_crbps_ecc_sec_flag_int_value = rightShift(data_low, 18) and &H1
        read_spum_pafifo_ecc_ded_flag_int_value = rightShift(data_low, 17) and &H1
        read_spum_pafifo_ecc_sec_flag_int_value = rightShift(data_low, 16) and &H1
        read_spum_pasctx_ecc_ded_flag_int_value = rightShift(data_low, 15) and &H1
        read_spum_pasctx_ecc_sec_flag_int_value = rightShift(data_low, 14) and &H1
        read_spum_ppsupdt_ecc_ded_flag_int_value = rightShift(data_low, 13) and &H1
        read_spum_ppsupdt_ecc_sec_flag_int_value = rightShift(data_low, 12) and &H1
        read_pka_opp_ecc_ded_flag_int_value = rightShift(data_low, 11) and &H1
        read_pka_opp_ecc_sec_flag_int_value = rightShift(data_low, 10) and &H1
        read_pka_lir1_ecc_ded_flag_int_value = rightShift(data_low, 9) and &H1
        read_pka_lir1_ecc_sec_flag_int_value = rightShift(data_low, 8) and &H1
        read_pka_lir0_ecc_ded_flag_int_value = rightShift(data_low, 7) and &H1
        read_pka_lir0_ecc_sec_flag_int_value = rightShift(data_low, 6) and &H1
        read_dmem_ecc_ded_flag_int_value = rightShift(data_low, 5) and &H1
        read_dmem_ecc_sec_flag_int_value = rightShift(data_low, 4) and &H1
        read_imem_ecc_ded_flag_int_value = rightShift(data_low, 3) and &H1
        read_imem_ecc_sec_flag_int_value = rightShift(data_low, 2) and &H1
        read_sram_ecc_ded_flag_int_value = rightShift(data_low, 1) and &H1
        sram_ecc_sec_flag_int_mask = &H1
        if data_low > LONG_MAX then
            if sram_ecc_sec_flag_int_mask = mask then
                read_sram_ecc_sec_flag_int_value = data_low
            else
                read_sram_ecc_sec_flag_int_value = (data_low - H8000_0000) and sram_ecc_sec_flag_int_mask
            end If
        else
            read_sram_ecc_sec_flag_int_value = data_low and sram_ecc_sec_flag_int_mask
        end If

    End Sub

    Sub write
        If flag_spum_kek_ecc_ded_flag_int = &H0 or flag_spum_kek_ecc_sec_flag_int = &H0 or flag_spum_aubps_ecc_ded_flag_int = &H0 or flag_spum_aubps_ecc_sec_flag_int = &H0 or flag_spum_creaes_ecc_ded_flag_int = &H0 or flag_spum_creaes_ecc_sec_flag_int = &H0 or flag_spum_crbps_ecc_ded_flag_int = &H0 or flag_spum_crbps_ecc_sec_flag_int = &H0 or flag_spum_pafifo_ecc_ded_flag_int = &H0 or flag_spum_pafifo_ecc_sec_flag_int = &H0 or flag_spum_pasctx_ecc_ded_flag_int = &H0 or flag_spum_pasctx_ecc_sec_flag_int = &H0 or flag_spum_ppsupdt_ecc_ded_flag_int = &H0 or flag_spum_ppsupdt_ecc_sec_flag_int = &H0 or flag_pka_opp_ecc_ded_flag_int = &H0 or flag_pka_opp_ecc_sec_flag_int = &H0 or flag_pka_lir1_ecc_ded_flag_int = &H0 or flag_pka_lir1_ecc_sec_flag_int = &H0 or flag_pka_lir0_ecc_ded_flag_int = &H0 or flag_pka_lir0_ecc_sec_flag_int = &H0 or flag_dmem_ecc_ded_flag_int = &H0 or flag_dmem_ecc_sec_flag_int = &H0 or flag_imem_ecc_ded_flag_int = &H0 or flag_imem_ecc_sec_flag_int = &H0 or flag_sram_ecc_ded_flag_int = &H0 or flag_sram_ecc_sec_flag_int = &H0 Then read
        If flag_spum_kek_ecc_ded_flag_int = &H0 Then write_spum_kek_ecc_ded_flag_int_value = get_spum_kek_ecc_ded_flag_int
        If flag_spum_kek_ecc_sec_flag_int = &H0 Then write_spum_kek_ecc_sec_flag_int_value = get_spum_kek_ecc_sec_flag_int
        If flag_spum_aubps_ecc_ded_flag_int = &H0 Then write_spum_aubps_ecc_ded_flag_int_value = get_spum_aubps_ecc_ded_flag_int
        If flag_spum_aubps_ecc_sec_flag_int = &H0 Then write_spum_aubps_ecc_sec_flag_int_value = get_spum_aubps_ecc_sec_flag_int
        If flag_spum_creaes_ecc_ded_flag_int = &H0 Then write_spum_creaes_ecc_ded_flag_int_value = get_spum_creaes_ecc_ded_flag_int
        If flag_spum_creaes_ecc_sec_flag_int = &H0 Then write_spum_creaes_ecc_sec_flag_int_value = get_spum_creaes_ecc_sec_flag_int
        If flag_spum_crbps_ecc_ded_flag_int = &H0 Then write_spum_crbps_ecc_ded_flag_int_value = get_spum_crbps_ecc_ded_flag_int
        If flag_spum_crbps_ecc_sec_flag_int = &H0 Then write_spum_crbps_ecc_sec_flag_int_value = get_spum_crbps_ecc_sec_flag_int
        If flag_spum_pafifo_ecc_ded_flag_int = &H0 Then write_spum_pafifo_ecc_ded_flag_int_value = get_spum_pafifo_ecc_ded_flag_int
        If flag_spum_pafifo_ecc_sec_flag_int = &H0 Then write_spum_pafifo_ecc_sec_flag_int_value = get_spum_pafifo_ecc_sec_flag_int
        If flag_spum_pasctx_ecc_ded_flag_int = &H0 Then write_spum_pasctx_ecc_ded_flag_int_value = get_spum_pasctx_ecc_ded_flag_int
        If flag_spum_pasctx_ecc_sec_flag_int = &H0 Then write_spum_pasctx_ecc_sec_flag_int_value = get_spum_pasctx_ecc_sec_flag_int
        If flag_spum_ppsupdt_ecc_ded_flag_int = &H0 Then write_spum_ppsupdt_ecc_ded_flag_int_value = get_spum_ppsupdt_ecc_ded_flag_int
        If flag_spum_ppsupdt_ecc_sec_flag_int = &H0 Then write_spum_ppsupdt_ecc_sec_flag_int_value = get_spum_ppsupdt_ecc_sec_flag_int
        If flag_pka_opp_ecc_ded_flag_int = &H0 Then write_pka_opp_ecc_ded_flag_int_value = get_pka_opp_ecc_ded_flag_int
        If flag_pka_opp_ecc_sec_flag_int = &H0 Then write_pka_opp_ecc_sec_flag_int_value = get_pka_opp_ecc_sec_flag_int
        If flag_pka_lir1_ecc_ded_flag_int = &H0 Then write_pka_lir1_ecc_ded_flag_int_value = get_pka_lir1_ecc_ded_flag_int
        If flag_pka_lir1_ecc_sec_flag_int = &H0 Then write_pka_lir1_ecc_sec_flag_int_value = get_pka_lir1_ecc_sec_flag_int
        If flag_pka_lir0_ecc_ded_flag_int = &H0 Then write_pka_lir0_ecc_ded_flag_int_value = get_pka_lir0_ecc_ded_flag_int
        If flag_pka_lir0_ecc_sec_flag_int = &H0 Then write_pka_lir0_ecc_sec_flag_int_value = get_pka_lir0_ecc_sec_flag_int
        If flag_dmem_ecc_ded_flag_int = &H0 Then write_dmem_ecc_ded_flag_int_value = get_dmem_ecc_ded_flag_int
        If flag_dmem_ecc_sec_flag_int = &H0 Then write_dmem_ecc_sec_flag_int_value = get_dmem_ecc_sec_flag_int
        If flag_imem_ecc_ded_flag_int = &H0 Then write_imem_ecc_ded_flag_int_value = get_imem_ecc_ded_flag_int
        If flag_imem_ecc_sec_flag_int = &H0 Then write_imem_ecc_sec_flag_int_value = get_imem_ecc_sec_flag_int
        If flag_sram_ecc_ded_flag_int = &H0 Then write_sram_ecc_ded_flag_int_value = get_sram_ecc_ded_flag_int
        If flag_sram_ecc_sec_flag_int = &H0 Then write_sram_ecc_sec_flag_int_value = get_sram_ecc_sec_flag_int

        regValue = leftShift((write_spum_kek_ecc_ded_flag_int_value and &H1), 25) + leftShift((write_spum_kek_ecc_sec_flag_int_value and &H1), 24) + leftShift((write_spum_aubps_ecc_ded_flag_int_value and &H1), 23) + leftShift((write_spum_aubps_ecc_sec_flag_int_value and &H1), 22) + leftShift((write_spum_creaes_ecc_ded_flag_int_value and &H1), 21) + leftShift((write_spum_creaes_ecc_sec_flag_int_value and &H1), 20) + leftShift((write_spum_crbps_ecc_ded_flag_int_value and &H1), 19) + leftShift((write_spum_crbps_ecc_sec_flag_int_value and &H1), 18) + leftShift((write_spum_pafifo_ecc_ded_flag_int_value and &H1), 17) + leftShift((write_spum_pafifo_ecc_sec_flag_int_value and &H1), 16) + leftShift((write_spum_pasctx_ecc_ded_flag_int_value and &H1), 15) + leftShift((write_spum_pasctx_ecc_sec_flag_int_value and &H1), 14) + leftShift((write_spum_ppsupdt_ecc_ded_flag_int_value and &H1), 13) + leftShift((write_spum_ppsupdt_ecc_sec_flag_int_value and &H1), 12) + leftShift((write_pka_opp_ecc_ded_flag_int_value and &H1), 11) + leftShift((write_pka_opp_ecc_sec_flag_int_value and &H1), 10) + leftShift((write_pka_lir1_ecc_ded_flag_int_value and &H1), 9) + leftShift((write_pka_lir1_ecc_sec_flag_int_value and &H1), 8) + leftShift((write_pka_lir0_ecc_ded_flag_int_value and &H1), 7) + leftShift((write_pka_lir0_ecc_sec_flag_int_value and &H1), 6) + leftShift((write_dmem_ecc_ded_flag_int_value and &H1), 5) + leftShift((write_dmem_ecc_sec_flag_int_value and &H1), 4) + leftShift((write_imem_ecc_ded_flag_int_value and &H1), 3) + leftShift((write_imem_ecc_sec_flag_int_value and &H1), 2) + leftShift((write_sram_ecc_ded_flag_int_value and &H1), 1) + leftShift((write_sram_ecc_sec_flag_int_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_spum_kek_ecc_ded_flag_int_value = rightShift(data_low, 25) and &H1
        read_spum_kek_ecc_sec_flag_int_value = rightShift(data_low, 24) and &H1
        read_spum_aubps_ecc_ded_flag_int_value = rightShift(data_low, 23) and &H1
        read_spum_aubps_ecc_sec_flag_int_value = rightShift(data_low, 22) and &H1
        read_spum_creaes_ecc_ded_flag_int_value = rightShift(data_low, 21) and &H1
        read_spum_creaes_ecc_sec_flag_int_value = rightShift(data_low, 20) and &H1
        read_spum_crbps_ecc_ded_flag_int_value = rightShift(data_low, 19) and &H1
        read_spum_crbps_ecc_sec_flag_int_value = rightShift(data_low, 18) and &H1
        read_spum_pafifo_ecc_ded_flag_int_value = rightShift(data_low, 17) and &H1
        read_spum_pafifo_ecc_sec_flag_int_value = rightShift(data_low, 16) and &H1
        read_spum_pasctx_ecc_ded_flag_int_value = rightShift(data_low, 15) and &H1
        read_spum_pasctx_ecc_sec_flag_int_value = rightShift(data_low, 14) and &H1
        read_spum_ppsupdt_ecc_ded_flag_int_value = rightShift(data_low, 13) and &H1
        read_spum_ppsupdt_ecc_sec_flag_int_value = rightShift(data_low, 12) and &H1
        read_pka_opp_ecc_ded_flag_int_value = rightShift(data_low, 11) and &H1
        read_pka_opp_ecc_sec_flag_int_value = rightShift(data_low, 10) and &H1
        read_pka_lir1_ecc_ded_flag_int_value = rightShift(data_low, 9) and &H1
        read_pka_lir1_ecc_sec_flag_int_value = rightShift(data_low, 8) and &H1
        read_pka_lir0_ecc_ded_flag_int_value = rightShift(data_low, 7) and &H1
        read_pka_lir0_ecc_sec_flag_int_value = rightShift(data_low, 6) and &H1
        read_dmem_ecc_ded_flag_int_value = rightShift(data_low, 5) and &H1
        read_dmem_ecc_sec_flag_int_value = rightShift(data_low, 4) and &H1
        read_imem_ecc_ded_flag_int_value = rightShift(data_low, 3) and &H1
        read_imem_ecc_sec_flag_int_value = rightShift(data_low, 2) and &H1
        read_sram_ecc_ded_flag_int_value = rightShift(data_low, 1) and &H1
        sram_ecc_sec_flag_int_mask = &H1
        if data_low > LONG_MAX then
            if sram_ecc_sec_flag_int_mask = mask then
                read_sram_ecc_sec_flag_int_value = data_low
            else
                read_sram_ecc_sec_flag_int_value = (data_low - H8000_0000) and sram_ecc_sec_flag_int_mask
            end If
        else
            read_sram_ecc_sec_flag_int_value = data_low and sram_ecc_sec_flag_int_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_spum_kek_ecc_ded_flag_int_value = &H0
        flag_spum_kek_ecc_ded_flag_int        = &H0
        write_spum_kek_ecc_sec_flag_int_value = &H0
        flag_spum_kek_ecc_sec_flag_int        = &H0
        write_spum_aubps_ecc_ded_flag_int_value = &H0
        flag_spum_aubps_ecc_ded_flag_int        = &H0
        write_spum_aubps_ecc_sec_flag_int_value = &H0
        flag_spum_aubps_ecc_sec_flag_int        = &H0
        write_spum_creaes_ecc_ded_flag_int_value = &H0
        flag_spum_creaes_ecc_ded_flag_int        = &H0
        write_spum_creaes_ecc_sec_flag_int_value = &H0
        flag_spum_creaes_ecc_sec_flag_int        = &H0
        write_spum_crbps_ecc_ded_flag_int_value = &H0
        flag_spum_crbps_ecc_ded_flag_int        = &H0
        write_spum_crbps_ecc_sec_flag_int_value = &H0
        flag_spum_crbps_ecc_sec_flag_int        = &H0
        write_spum_pafifo_ecc_ded_flag_int_value = &H0
        flag_spum_pafifo_ecc_ded_flag_int        = &H0
        write_spum_pafifo_ecc_sec_flag_int_value = &H0
        flag_spum_pafifo_ecc_sec_flag_int        = &H0
        write_spum_pasctx_ecc_ded_flag_int_value = &H0
        flag_spum_pasctx_ecc_ded_flag_int        = &H0
        write_spum_pasctx_ecc_sec_flag_int_value = &H0
        flag_spum_pasctx_ecc_sec_flag_int        = &H0
        write_spum_ppsupdt_ecc_ded_flag_int_value = &H0
        flag_spum_ppsupdt_ecc_ded_flag_int        = &H0
        write_spum_ppsupdt_ecc_sec_flag_int_value = &H0
        flag_spum_ppsupdt_ecc_sec_flag_int        = &H0
        write_pka_opp_ecc_ded_flag_int_value = &H0
        flag_pka_opp_ecc_ded_flag_int        = &H0
        write_pka_opp_ecc_sec_flag_int_value = &H0
        flag_pka_opp_ecc_sec_flag_int        = &H0
        write_pka_lir1_ecc_ded_flag_int_value = &H0
        flag_pka_lir1_ecc_ded_flag_int        = &H0
        write_pka_lir1_ecc_sec_flag_int_value = &H0
        flag_pka_lir1_ecc_sec_flag_int        = &H0
        write_pka_lir0_ecc_ded_flag_int_value = &H0
        flag_pka_lir0_ecc_ded_flag_int        = &H0
        write_pka_lir0_ecc_sec_flag_int_value = &H0
        flag_pka_lir0_ecc_sec_flag_int        = &H0
        write_dmem_ecc_ded_flag_int_value = &H0
        flag_dmem_ecc_ded_flag_int        = &H0
        write_dmem_ecc_sec_flag_int_value = &H0
        flag_dmem_ecc_sec_flag_int        = &H0
        write_imem_ecc_ded_flag_int_value = &H0
        flag_imem_ecc_ded_flag_int        = &H0
        write_imem_ecc_sec_flag_int_value = &H0
        flag_imem_ecc_sec_flag_int        = &H0
        write_sram_ecc_ded_flag_int_value = &H0
        flag_sram_ecc_ded_flag_int        = &H0
        write_sram_ecc_sec_flag_int_value = &H0
        flag_sram_ecc_sec_flag_int        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_ecc_interrupt_en_reg
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' spum_kek_ecc_ded_flag_int_en               [25:25]          get_spum_kek_ecc_ded_flag_int_en
''                                                             set_spum_kek_ecc_ded_flag_int_en
''                                                             read_spum_kek_ecc_ded_flag_int_en
''                                                             write_spum_kek_ecc_ded_flag_int_en
''---------------------------------------------------------------------------------
'' spum_kek_ecc_sec_flag_int_en               [24:24]          get_spum_kek_ecc_sec_flag_int_en
''                                                             set_spum_kek_ecc_sec_flag_int_en
''                                                             read_spum_kek_ecc_sec_flag_int_en
''                                                             write_spum_kek_ecc_sec_flag_int_en
''---------------------------------------------------------------------------------
'' spum_aubps_ecc_ded_flag_int_en             [23:23]          get_spum_aubps_ecc_ded_flag_int_en
''                                                             set_spum_aubps_ecc_ded_flag_int_en
''                                                             read_spum_aubps_ecc_ded_flag_int_en
''                                                             write_spum_aubps_ecc_ded_flag_int_en
''---------------------------------------------------------------------------------
'' spum_aubps_ecc_sec_flag_int_en             [22:22]          get_spum_aubps_ecc_sec_flag_int_en
''                                                             set_spum_aubps_ecc_sec_flag_int_en
''                                                             read_spum_aubps_ecc_sec_flag_int_en
''                                                             write_spum_aubps_ecc_sec_flag_int_en
''---------------------------------------------------------------------------------
'' spum_creaes_ecc_ded_flag_int_en            [21:21]          get_spum_creaes_ecc_ded_flag_int_en
''                                                             set_spum_creaes_ecc_ded_flag_int_en
''                                                             read_spum_creaes_ecc_ded_flag_int_en
''                                                             write_spum_creaes_ecc_ded_flag_int_en
''---------------------------------------------------------------------------------
'' spum_creaes_ecc_sec_flag_int_en            [20:20]          get_spum_creaes_ecc_sec_flag_int_en
''                                                             set_spum_creaes_ecc_sec_flag_int_en
''                                                             read_spum_creaes_ecc_sec_flag_int_en
''                                                             write_spum_creaes_ecc_sec_flag_int_en
''---------------------------------------------------------------------------------
'' spum_crbps_ecc_ded_flag_int_en             [19:19]          get_spum_crbps_ecc_ded_flag_int_en
''                                                             set_spum_crbps_ecc_ded_flag_int_en
''                                                             read_spum_crbps_ecc_ded_flag_int_en
''                                                             write_spum_crbps_ecc_ded_flag_int_en
''---------------------------------------------------------------------------------
'' spum_crbps_ecc_sec_flag_int_en             [18:18]          get_spum_crbps_ecc_sec_flag_int_en
''                                                             set_spum_crbps_ecc_sec_flag_int_en
''                                                             read_spum_crbps_ecc_sec_flag_int_en
''                                                             write_spum_crbps_ecc_sec_flag_int_en
''---------------------------------------------------------------------------------
'' spum_pafifo_ecc_ded_flag_int_en            [17:17]          get_spum_pafifo_ecc_ded_flag_int_en
''                                                             set_spum_pafifo_ecc_ded_flag_int_en
''                                                             read_spum_pafifo_ecc_ded_flag_int_en
''                                                             write_spum_pafifo_ecc_ded_flag_int_en
''---------------------------------------------------------------------------------
'' spum_pafifo_ecc_sec_flag_int_en            [16:16]          get_spum_pafifo_ecc_sec_flag_int_en
''                                                             set_spum_pafifo_ecc_sec_flag_int_en
''                                                             read_spum_pafifo_ecc_sec_flag_int_en
''                                                             write_spum_pafifo_ecc_sec_flag_int_en
''---------------------------------------------------------------------------------
'' spum_pasctx_ecc_ded_flag_int_en            [15:15]          get_spum_pasctx_ecc_ded_flag_int_en
''                                                             set_spum_pasctx_ecc_ded_flag_int_en
''                                                             read_spum_pasctx_ecc_ded_flag_int_en
''                                                             write_spum_pasctx_ecc_ded_flag_int_en
''---------------------------------------------------------------------------------
'' spum_pasctx_ecc_sec_flag_int_en            [14:14]          get_spum_pasctx_ecc_sec_flag_int_en
''                                                             set_spum_pasctx_ecc_sec_flag_int_en
''                                                             read_spum_pasctx_ecc_sec_flag_int_en
''                                                             write_spum_pasctx_ecc_sec_flag_int_en
''---------------------------------------------------------------------------------
'' spum_ppsupdt_ecc_ded_flag_int_en           [13:13]          get_spum_ppsupdt_ecc_ded_flag_int_en
''                                                             set_spum_ppsupdt_ecc_ded_flag_int_en
''                                                             read_spum_ppsupdt_ecc_ded_flag_int_en
''                                                             write_spum_ppsupdt_ecc_ded_flag_int_en
''---------------------------------------------------------------------------------
'' spum_ppsupdt_ecc_sec_flag_int_en           [12:12]          get_spum_ppsupdt_ecc_sec_flag_int_en
''                                                             set_spum_ppsupdt_ecc_sec_flag_int_en
''                                                             read_spum_ppsupdt_ecc_sec_flag_int_en
''                                                             write_spum_ppsupdt_ecc_sec_flag_int_en
''---------------------------------------------------------------------------------
'' pka_opp_ecc_ded_flag_int_en                [11:11]          get_pka_opp_ecc_ded_flag_int_en
''                                                             set_pka_opp_ecc_ded_flag_int_en
''                                                             read_pka_opp_ecc_ded_flag_int_en
''                                                             write_pka_opp_ecc_ded_flag_int_en
''---------------------------------------------------------------------------------
'' pka_opp_ecc_sec_flag_int_en                [10:10]          get_pka_opp_ecc_sec_flag_int_en
''                                                             set_pka_opp_ecc_sec_flag_int_en
''                                                             read_pka_opp_ecc_sec_flag_int_en
''                                                             write_pka_opp_ecc_sec_flag_int_en
''---------------------------------------------------------------------------------
'' pka_lir1_ecc_ded_flag_int_en               [9:9]            get_pka_lir1_ecc_ded_flag_int_en
''                                                             set_pka_lir1_ecc_ded_flag_int_en
''                                                             read_pka_lir1_ecc_ded_flag_int_en
''                                                             write_pka_lir1_ecc_ded_flag_int_en
''---------------------------------------------------------------------------------
'' pka_lir1_ecc_sec_flag_int_en               [8:8]            get_pka_lir1_ecc_sec_flag_int_en
''                                                             set_pka_lir1_ecc_sec_flag_int_en
''                                                             read_pka_lir1_ecc_sec_flag_int_en
''                                                             write_pka_lir1_ecc_sec_flag_int_en
''---------------------------------------------------------------------------------
'' pka_lir0_ecc_ded_flag_int_en               [7:7]            get_pka_lir0_ecc_ded_flag_int_en
''                                                             set_pka_lir0_ecc_ded_flag_int_en
''                                                             read_pka_lir0_ecc_ded_flag_int_en
''                                                             write_pka_lir0_ecc_ded_flag_int_en
''---------------------------------------------------------------------------------
'' pka_lir0_ecc_sec_flag_int_en               [6:6]            get_pka_lir0_ecc_sec_flag_int_en
''                                                             set_pka_lir0_ecc_sec_flag_int_en
''                                                             read_pka_lir0_ecc_sec_flag_int_en
''                                                             write_pka_lir0_ecc_sec_flag_int_en
''---------------------------------------------------------------------------------
'' dmem_ecc_ded_flag_int_en                   [5:5]            get_dmem_ecc_ded_flag_int_en
''                                                             set_dmem_ecc_ded_flag_int_en
''                                                             read_dmem_ecc_ded_flag_int_en
''                                                             write_dmem_ecc_ded_flag_int_en
''---------------------------------------------------------------------------------
'' dmem_ecc_sec_flag_int_en                   [4:4]            get_dmem_ecc_sec_flag_int_en
''                                                             set_dmem_ecc_sec_flag_int_en
''                                                             read_dmem_ecc_sec_flag_int_en
''                                                             write_dmem_ecc_sec_flag_int_en
''---------------------------------------------------------------------------------
'' imem_ecc_ded_flag_int_en                   [3:3]            get_imem_ecc_ded_flag_int_en
''                                                             set_imem_ecc_ded_flag_int_en
''                                                             read_imem_ecc_ded_flag_int_en
''                                                             write_imem_ecc_ded_flag_int_en
''---------------------------------------------------------------------------------
'' imem_ecc_sec_flag_int_en                   [2:2]            get_imem_ecc_sec_flag_int_en
''                                                             set_imem_ecc_sec_flag_int_en
''                                                             read_imem_ecc_sec_flag_int_en
''                                                             write_imem_ecc_sec_flag_int_en
''---------------------------------------------------------------------------------
'' sram_ecc_ded_flag_int_en                   [1:1]            get_sram_ecc_ded_flag_int_en
''                                                             set_sram_ecc_ded_flag_int_en
''                                                             read_sram_ecc_ded_flag_int_en
''                                                             write_sram_ecc_ded_flag_int_en
''---------------------------------------------------------------------------------
'' sram_ecc_sec_flag_int_en                   [0:0]            get_sram_ecc_sec_flag_int_en
''                                                             set_sram_ecc_sec_flag_int_en
''                                                             read_sram_ecc_sec_flag_int_en
''                                                             write_sram_ecc_sec_flag_int_en
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_ecc_interrupt_en_reg
    Private write_spum_kek_ecc_ded_flag_int_en_value
    Private read_spum_kek_ecc_ded_flag_int_en_value
    Private flag_spum_kek_ecc_ded_flag_int_en
    Private write_spum_kek_ecc_sec_flag_int_en_value
    Private read_spum_kek_ecc_sec_flag_int_en_value
    Private flag_spum_kek_ecc_sec_flag_int_en
    Private write_spum_aubps_ecc_ded_flag_int_en_value
    Private read_spum_aubps_ecc_ded_flag_int_en_value
    Private flag_spum_aubps_ecc_ded_flag_int_en
    Private write_spum_aubps_ecc_sec_flag_int_en_value
    Private read_spum_aubps_ecc_sec_flag_int_en_value
    Private flag_spum_aubps_ecc_sec_flag_int_en
    Private write_spum_creaes_ecc_ded_flag_int_en_value
    Private read_spum_creaes_ecc_ded_flag_int_en_value
    Private flag_spum_creaes_ecc_ded_flag_int_en
    Private write_spum_creaes_ecc_sec_flag_int_en_value
    Private read_spum_creaes_ecc_sec_flag_int_en_value
    Private flag_spum_creaes_ecc_sec_flag_int_en
    Private write_spum_crbps_ecc_ded_flag_int_en_value
    Private read_spum_crbps_ecc_ded_flag_int_en_value
    Private flag_spum_crbps_ecc_ded_flag_int_en
    Private write_spum_crbps_ecc_sec_flag_int_en_value
    Private read_spum_crbps_ecc_sec_flag_int_en_value
    Private flag_spum_crbps_ecc_sec_flag_int_en
    Private write_spum_pafifo_ecc_ded_flag_int_en_value
    Private read_spum_pafifo_ecc_ded_flag_int_en_value
    Private flag_spum_pafifo_ecc_ded_flag_int_en
    Private write_spum_pafifo_ecc_sec_flag_int_en_value
    Private read_spum_pafifo_ecc_sec_flag_int_en_value
    Private flag_spum_pafifo_ecc_sec_flag_int_en
    Private write_spum_pasctx_ecc_ded_flag_int_en_value
    Private read_spum_pasctx_ecc_ded_flag_int_en_value
    Private flag_spum_pasctx_ecc_ded_flag_int_en
    Private write_spum_pasctx_ecc_sec_flag_int_en_value
    Private read_spum_pasctx_ecc_sec_flag_int_en_value
    Private flag_spum_pasctx_ecc_sec_flag_int_en
    Private write_spum_ppsupdt_ecc_ded_flag_int_en_value
    Private read_spum_ppsupdt_ecc_ded_flag_int_en_value
    Private flag_spum_ppsupdt_ecc_ded_flag_int_en
    Private write_spum_ppsupdt_ecc_sec_flag_int_en_value
    Private read_spum_ppsupdt_ecc_sec_flag_int_en_value
    Private flag_spum_ppsupdt_ecc_sec_flag_int_en
    Private write_pka_opp_ecc_ded_flag_int_en_value
    Private read_pka_opp_ecc_ded_flag_int_en_value
    Private flag_pka_opp_ecc_ded_flag_int_en
    Private write_pka_opp_ecc_sec_flag_int_en_value
    Private read_pka_opp_ecc_sec_flag_int_en_value
    Private flag_pka_opp_ecc_sec_flag_int_en
    Private write_pka_lir1_ecc_ded_flag_int_en_value
    Private read_pka_lir1_ecc_ded_flag_int_en_value
    Private flag_pka_lir1_ecc_ded_flag_int_en
    Private write_pka_lir1_ecc_sec_flag_int_en_value
    Private read_pka_lir1_ecc_sec_flag_int_en_value
    Private flag_pka_lir1_ecc_sec_flag_int_en
    Private write_pka_lir0_ecc_ded_flag_int_en_value
    Private read_pka_lir0_ecc_ded_flag_int_en_value
    Private flag_pka_lir0_ecc_ded_flag_int_en
    Private write_pka_lir0_ecc_sec_flag_int_en_value
    Private read_pka_lir0_ecc_sec_flag_int_en_value
    Private flag_pka_lir0_ecc_sec_flag_int_en
    Private write_dmem_ecc_ded_flag_int_en_value
    Private read_dmem_ecc_ded_flag_int_en_value
    Private flag_dmem_ecc_ded_flag_int_en
    Private write_dmem_ecc_sec_flag_int_en_value
    Private read_dmem_ecc_sec_flag_int_en_value
    Private flag_dmem_ecc_sec_flag_int_en
    Private write_imem_ecc_ded_flag_int_en_value
    Private read_imem_ecc_ded_flag_int_en_value
    Private flag_imem_ecc_ded_flag_int_en
    Private write_imem_ecc_sec_flag_int_en_value
    Private read_imem_ecc_sec_flag_int_en_value
    Private flag_imem_ecc_sec_flag_int_en
    Private write_sram_ecc_ded_flag_int_en_value
    Private read_sram_ecc_ded_flag_int_en_value
    Private flag_sram_ecc_ded_flag_int_en
    Private write_sram_ecc_sec_flag_int_en_value
    Private read_sram_ecc_sec_flag_int_en_value
    Private flag_sram_ecc_sec_flag_int_en

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H2c0
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_spum_kek_ecc_ded_flag_int_en
        get_spum_kek_ecc_ded_flag_int_en = read_spum_kek_ecc_ded_flag_int_en_value
    End Property

    Property Let set_spum_kek_ecc_ded_flag_int_en(aData)
        write_spum_kek_ecc_ded_flag_int_en_value = aData
        flag_spum_kek_ecc_ded_flag_int_en        = &H1
    End Property

    Property Get read_spum_kek_ecc_ded_flag_int_en
        read
        read_spum_kek_ecc_ded_flag_int_en = read_spum_kek_ecc_ded_flag_int_en_value
    End Property

    Property Let write_spum_kek_ecc_ded_flag_int_en(aData)
        set_spum_kek_ecc_ded_flag_int_en = aData
        write
    End Property

    Property Get get_spum_kek_ecc_sec_flag_int_en
        get_spum_kek_ecc_sec_flag_int_en = read_spum_kek_ecc_sec_flag_int_en_value
    End Property

    Property Let set_spum_kek_ecc_sec_flag_int_en(aData)
        write_spum_kek_ecc_sec_flag_int_en_value = aData
        flag_spum_kek_ecc_sec_flag_int_en        = &H1
    End Property

    Property Get read_spum_kek_ecc_sec_flag_int_en
        read
        read_spum_kek_ecc_sec_flag_int_en = read_spum_kek_ecc_sec_flag_int_en_value
    End Property

    Property Let write_spum_kek_ecc_sec_flag_int_en(aData)
        set_spum_kek_ecc_sec_flag_int_en = aData
        write
    End Property

    Property Get get_spum_aubps_ecc_ded_flag_int_en
        get_spum_aubps_ecc_ded_flag_int_en = read_spum_aubps_ecc_ded_flag_int_en_value
    End Property

    Property Let set_spum_aubps_ecc_ded_flag_int_en(aData)
        write_spum_aubps_ecc_ded_flag_int_en_value = aData
        flag_spum_aubps_ecc_ded_flag_int_en        = &H1
    End Property

    Property Get read_spum_aubps_ecc_ded_flag_int_en
        read
        read_spum_aubps_ecc_ded_flag_int_en = read_spum_aubps_ecc_ded_flag_int_en_value
    End Property

    Property Let write_spum_aubps_ecc_ded_flag_int_en(aData)
        set_spum_aubps_ecc_ded_flag_int_en = aData
        write
    End Property

    Property Get get_spum_aubps_ecc_sec_flag_int_en
        get_spum_aubps_ecc_sec_flag_int_en = read_spum_aubps_ecc_sec_flag_int_en_value
    End Property

    Property Let set_spum_aubps_ecc_sec_flag_int_en(aData)
        write_spum_aubps_ecc_sec_flag_int_en_value = aData
        flag_spum_aubps_ecc_sec_flag_int_en        = &H1
    End Property

    Property Get read_spum_aubps_ecc_sec_flag_int_en
        read
        read_spum_aubps_ecc_sec_flag_int_en = read_spum_aubps_ecc_sec_flag_int_en_value
    End Property

    Property Let write_spum_aubps_ecc_sec_flag_int_en(aData)
        set_spum_aubps_ecc_sec_flag_int_en = aData
        write
    End Property

    Property Get get_spum_creaes_ecc_ded_flag_int_en
        get_spum_creaes_ecc_ded_flag_int_en = read_spum_creaes_ecc_ded_flag_int_en_value
    End Property

    Property Let set_spum_creaes_ecc_ded_flag_int_en(aData)
        write_spum_creaes_ecc_ded_flag_int_en_value = aData
        flag_spum_creaes_ecc_ded_flag_int_en        = &H1
    End Property

    Property Get read_spum_creaes_ecc_ded_flag_int_en
        read
        read_spum_creaes_ecc_ded_flag_int_en = read_spum_creaes_ecc_ded_flag_int_en_value
    End Property

    Property Let write_spum_creaes_ecc_ded_flag_int_en(aData)
        set_spum_creaes_ecc_ded_flag_int_en = aData
        write
    End Property

    Property Get get_spum_creaes_ecc_sec_flag_int_en
        get_spum_creaes_ecc_sec_flag_int_en = read_spum_creaes_ecc_sec_flag_int_en_value
    End Property

    Property Let set_spum_creaes_ecc_sec_flag_int_en(aData)
        write_spum_creaes_ecc_sec_flag_int_en_value = aData
        flag_spum_creaes_ecc_sec_flag_int_en        = &H1
    End Property

    Property Get read_spum_creaes_ecc_sec_flag_int_en
        read
        read_spum_creaes_ecc_sec_flag_int_en = read_spum_creaes_ecc_sec_flag_int_en_value
    End Property

    Property Let write_spum_creaes_ecc_sec_flag_int_en(aData)
        set_spum_creaes_ecc_sec_flag_int_en = aData
        write
    End Property

    Property Get get_spum_crbps_ecc_ded_flag_int_en
        get_spum_crbps_ecc_ded_flag_int_en = read_spum_crbps_ecc_ded_flag_int_en_value
    End Property

    Property Let set_spum_crbps_ecc_ded_flag_int_en(aData)
        write_spum_crbps_ecc_ded_flag_int_en_value = aData
        flag_spum_crbps_ecc_ded_flag_int_en        = &H1
    End Property

    Property Get read_spum_crbps_ecc_ded_flag_int_en
        read
        read_spum_crbps_ecc_ded_flag_int_en = read_spum_crbps_ecc_ded_flag_int_en_value
    End Property

    Property Let write_spum_crbps_ecc_ded_flag_int_en(aData)
        set_spum_crbps_ecc_ded_flag_int_en = aData
        write
    End Property

    Property Get get_spum_crbps_ecc_sec_flag_int_en
        get_spum_crbps_ecc_sec_flag_int_en = read_spum_crbps_ecc_sec_flag_int_en_value
    End Property

    Property Let set_spum_crbps_ecc_sec_flag_int_en(aData)
        write_spum_crbps_ecc_sec_flag_int_en_value = aData
        flag_spum_crbps_ecc_sec_flag_int_en        = &H1
    End Property

    Property Get read_spum_crbps_ecc_sec_flag_int_en
        read
        read_spum_crbps_ecc_sec_flag_int_en = read_spum_crbps_ecc_sec_flag_int_en_value
    End Property

    Property Let write_spum_crbps_ecc_sec_flag_int_en(aData)
        set_spum_crbps_ecc_sec_flag_int_en = aData
        write
    End Property

    Property Get get_spum_pafifo_ecc_ded_flag_int_en
        get_spum_pafifo_ecc_ded_flag_int_en = read_spum_pafifo_ecc_ded_flag_int_en_value
    End Property

    Property Let set_spum_pafifo_ecc_ded_flag_int_en(aData)
        write_spum_pafifo_ecc_ded_flag_int_en_value = aData
        flag_spum_pafifo_ecc_ded_flag_int_en        = &H1
    End Property

    Property Get read_spum_pafifo_ecc_ded_flag_int_en
        read
        read_spum_pafifo_ecc_ded_flag_int_en = read_spum_pafifo_ecc_ded_flag_int_en_value
    End Property

    Property Let write_spum_pafifo_ecc_ded_flag_int_en(aData)
        set_spum_pafifo_ecc_ded_flag_int_en = aData
        write
    End Property

    Property Get get_spum_pafifo_ecc_sec_flag_int_en
        get_spum_pafifo_ecc_sec_flag_int_en = read_spum_pafifo_ecc_sec_flag_int_en_value
    End Property

    Property Let set_spum_pafifo_ecc_sec_flag_int_en(aData)
        write_spum_pafifo_ecc_sec_flag_int_en_value = aData
        flag_spum_pafifo_ecc_sec_flag_int_en        = &H1
    End Property

    Property Get read_spum_pafifo_ecc_sec_flag_int_en
        read
        read_spum_pafifo_ecc_sec_flag_int_en = read_spum_pafifo_ecc_sec_flag_int_en_value
    End Property

    Property Let write_spum_pafifo_ecc_sec_flag_int_en(aData)
        set_spum_pafifo_ecc_sec_flag_int_en = aData
        write
    End Property

    Property Get get_spum_pasctx_ecc_ded_flag_int_en
        get_spum_pasctx_ecc_ded_flag_int_en = read_spum_pasctx_ecc_ded_flag_int_en_value
    End Property

    Property Let set_spum_pasctx_ecc_ded_flag_int_en(aData)
        write_spum_pasctx_ecc_ded_flag_int_en_value = aData
        flag_spum_pasctx_ecc_ded_flag_int_en        = &H1
    End Property

    Property Get read_spum_pasctx_ecc_ded_flag_int_en
        read
        read_spum_pasctx_ecc_ded_flag_int_en = read_spum_pasctx_ecc_ded_flag_int_en_value
    End Property

    Property Let write_spum_pasctx_ecc_ded_flag_int_en(aData)
        set_spum_pasctx_ecc_ded_flag_int_en = aData
        write
    End Property

    Property Get get_spum_pasctx_ecc_sec_flag_int_en
        get_spum_pasctx_ecc_sec_flag_int_en = read_spum_pasctx_ecc_sec_flag_int_en_value
    End Property

    Property Let set_spum_pasctx_ecc_sec_flag_int_en(aData)
        write_spum_pasctx_ecc_sec_flag_int_en_value = aData
        flag_spum_pasctx_ecc_sec_flag_int_en        = &H1
    End Property

    Property Get read_spum_pasctx_ecc_sec_flag_int_en
        read
        read_spum_pasctx_ecc_sec_flag_int_en = read_spum_pasctx_ecc_sec_flag_int_en_value
    End Property

    Property Let write_spum_pasctx_ecc_sec_flag_int_en(aData)
        set_spum_pasctx_ecc_sec_flag_int_en = aData
        write
    End Property

    Property Get get_spum_ppsupdt_ecc_ded_flag_int_en
        get_spum_ppsupdt_ecc_ded_flag_int_en = read_spum_ppsupdt_ecc_ded_flag_int_en_value
    End Property

    Property Let set_spum_ppsupdt_ecc_ded_flag_int_en(aData)
        write_spum_ppsupdt_ecc_ded_flag_int_en_value = aData
        flag_spum_ppsupdt_ecc_ded_flag_int_en        = &H1
    End Property

    Property Get read_spum_ppsupdt_ecc_ded_flag_int_en
        read
        read_spum_ppsupdt_ecc_ded_flag_int_en = read_spum_ppsupdt_ecc_ded_flag_int_en_value
    End Property

    Property Let write_spum_ppsupdt_ecc_ded_flag_int_en(aData)
        set_spum_ppsupdt_ecc_ded_flag_int_en = aData
        write
    End Property

    Property Get get_spum_ppsupdt_ecc_sec_flag_int_en
        get_spum_ppsupdt_ecc_sec_flag_int_en = read_spum_ppsupdt_ecc_sec_flag_int_en_value
    End Property

    Property Let set_spum_ppsupdt_ecc_sec_flag_int_en(aData)
        write_spum_ppsupdt_ecc_sec_flag_int_en_value = aData
        flag_spum_ppsupdt_ecc_sec_flag_int_en        = &H1
    End Property

    Property Get read_spum_ppsupdt_ecc_sec_flag_int_en
        read
        read_spum_ppsupdt_ecc_sec_flag_int_en = read_spum_ppsupdt_ecc_sec_flag_int_en_value
    End Property

    Property Let write_spum_ppsupdt_ecc_sec_flag_int_en(aData)
        set_spum_ppsupdt_ecc_sec_flag_int_en = aData
        write
    End Property

    Property Get get_pka_opp_ecc_ded_flag_int_en
        get_pka_opp_ecc_ded_flag_int_en = read_pka_opp_ecc_ded_flag_int_en_value
    End Property

    Property Let set_pka_opp_ecc_ded_flag_int_en(aData)
        write_pka_opp_ecc_ded_flag_int_en_value = aData
        flag_pka_opp_ecc_ded_flag_int_en        = &H1
    End Property

    Property Get read_pka_opp_ecc_ded_flag_int_en
        read
        read_pka_opp_ecc_ded_flag_int_en = read_pka_opp_ecc_ded_flag_int_en_value
    End Property

    Property Let write_pka_opp_ecc_ded_flag_int_en(aData)
        set_pka_opp_ecc_ded_flag_int_en = aData
        write
    End Property

    Property Get get_pka_opp_ecc_sec_flag_int_en
        get_pka_opp_ecc_sec_flag_int_en = read_pka_opp_ecc_sec_flag_int_en_value
    End Property

    Property Let set_pka_opp_ecc_sec_flag_int_en(aData)
        write_pka_opp_ecc_sec_flag_int_en_value = aData
        flag_pka_opp_ecc_sec_flag_int_en        = &H1
    End Property

    Property Get read_pka_opp_ecc_sec_flag_int_en
        read
        read_pka_opp_ecc_sec_flag_int_en = read_pka_opp_ecc_sec_flag_int_en_value
    End Property

    Property Let write_pka_opp_ecc_sec_flag_int_en(aData)
        set_pka_opp_ecc_sec_flag_int_en = aData
        write
    End Property

    Property Get get_pka_lir1_ecc_ded_flag_int_en
        get_pka_lir1_ecc_ded_flag_int_en = read_pka_lir1_ecc_ded_flag_int_en_value
    End Property

    Property Let set_pka_lir1_ecc_ded_flag_int_en(aData)
        write_pka_lir1_ecc_ded_flag_int_en_value = aData
        flag_pka_lir1_ecc_ded_flag_int_en        = &H1
    End Property

    Property Get read_pka_lir1_ecc_ded_flag_int_en
        read
        read_pka_lir1_ecc_ded_flag_int_en = read_pka_lir1_ecc_ded_flag_int_en_value
    End Property

    Property Let write_pka_lir1_ecc_ded_flag_int_en(aData)
        set_pka_lir1_ecc_ded_flag_int_en = aData
        write
    End Property

    Property Get get_pka_lir1_ecc_sec_flag_int_en
        get_pka_lir1_ecc_sec_flag_int_en = read_pka_lir1_ecc_sec_flag_int_en_value
    End Property

    Property Let set_pka_lir1_ecc_sec_flag_int_en(aData)
        write_pka_lir1_ecc_sec_flag_int_en_value = aData
        flag_pka_lir1_ecc_sec_flag_int_en        = &H1
    End Property

    Property Get read_pka_lir1_ecc_sec_flag_int_en
        read
        read_pka_lir1_ecc_sec_flag_int_en = read_pka_lir1_ecc_sec_flag_int_en_value
    End Property

    Property Let write_pka_lir1_ecc_sec_flag_int_en(aData)
        set_pka_lir1_ecc_sec_flag_int_en = aData
        write
    End Property

    Property Get get_pka_lir0_ecc_ded_flag_int_en
        get_pka_lir0_ecc_ded_flag_int_en = read_pka_lir0_ecc_ded_flag_int_en_value
    End Property

    Property Let set_pka_lir0_ecc_ded_flag_int_en(aData)
        write_pka_lir0_ecc_ded_flag_int_en_value = aData
        flag_pka_lir0_ecc_ded_flag_int_en        = &H1
    End Property

    Property Get read_pka_lir0_ecc_ded_flag_int_en
        read
        read_pka_lir0_ecc_ded_flag_int_en = read_pka_lir0_ecc_ded_flag_int_en_value
    End Property

    Property Let write_pka_lir0_ecc_ded_flag_int_en(aData)
        set_pka_lir0_ecc_ded_flag_int_en = aData
        write
    End Property

    Property Get get_pka_lir0_ecc_sec_flag_int_en
        get_pka_lir0_ecc_sec_flag_int_en = read_pka_lir0_ecc_sec_flag_int_en_value
    End Property

    Property Let set_pka_lir0_ecc_sec_flag_int_en(aData)
        write_pka_lir0_ecc_sec_flag_int_en_value = aData
        flag_pka_lir0_ecc_sec_flag_int_en        = &H1
    End Property

    Property Get read_pka_lir0_ecc_sec_flag_int_en
        read
        read_pka_lir0_ecc_sec_flag_int_en = read_pka_lir0_ecc_sec_flag_int_en_value
    End Property

    Property Let write_pka_lir0_ecc_sec_flag_int_en(aData)
        set_pka_lir0_ecc_sec_flag_int_en = aData
        write
    End Property

    Property Get get_dmem_ecc_ded_flag_int_en
        get_dmem_ecc_ded_flag_int_en = read_dmem_ecc_ded_flag_int_en_value
    End Property

    Property Let set_dmem_ecc_ded_flag_int_en(aData)
        write_dmem_ecc_ded_flag_int_en_value = aData
        flag_dmem_ecc_ded_flag_int_en        = &H1
    End Property

    Property Get read_dmem_ecc_ded_flag_int_en
        read
        read_dmem_ecc_ded_flag_int_en = read_dmem_ecc_ded_flag_int_en_value
    End Property

    Property Let write_dmem_ecc_ded_flag_int_en(aData)
        set_dmem_ecc_ded_flag_int_en = aData
        write
    End Property

    Property Get get_dmem_ecc_sec_flag_int_en
        get_dmem_ecc_sec_flag_int_en = read_dmem_ecc_sec_flag_int_en_value
    End Property

    Property Let set_dmem_ecc_sec_flag_int_en(aData)
        write_dmem_ecc_sec_flag_int_en_value = aData
        flag_dmem_ecc_sec_flag_int_en        = &H1
    End Property

    Property Get read_dmem_ecc_sec_flag_int_en
        read
        read_dmem_ecc_sec_flag_int_en = read_dmem_ecc_sec_flag_int_en_value
    End Property

    Property Let write_dmem_ecc_sec_flag_int_en(aData)
        set_dmem_ecc_sec_flag_int_en = aData
        write
    End Property

    Property Get get_imem_ecc_ded_flag_int_en
        get_imem_ecc_ded_flag_int_en = read_imem_ecc_ded_flag_int_en_value
    End Property

    Property Let set_imem_ecc_ded_flag_int_en(aData)
        write_imem_ecc_ded_flag_int_en_value = aData
        flag_imem_ecc_ded_flag_int_en        = &H1
    End Property

    Property Get read_imem_ecc_ded_flag_int_en
        read
        read_imem_ecc_ded_flag_int_en = read_imem_ecc_ded_flag_int_en_value
    End Property

    Property Let write_imem_ecc_ded_flag_int_en(aData)
        set_imem_ecc_ded_flag_int_en = aData
        write
    End Property

    Property Get get_imem_ecc_sec_flag_int_en
        get_imem_ecc_sec_flag_int_en = read_imem_ecc_sec_flag_int_en_value
    End Property

    Property Let set_imem_ecc_sec_flag_int_en(aData)
        write_imem_ecc_sec_flag_int_en_value = aData
        flag_imem_ecc_sec_flag_int_en        = &H1
    End Property

    Property Get read_imem_ecc_sec_flag_int_en
        read
        read_imem_ecc_sec_flag_int_en = read_imem_ecc_sec_flag_int_en_value
    End Property

    Property Let write_imem_ecc_sec_flag_int_en(aData)
        set_imem_ecc_sec_flag_int_en = aData
        write
    End Property

    Property Get get_sram_ecc_ded_flag_int_en
        get_sram_ecc_ded_flag_int_en = read_sram_ecc_ded_flag_int_en_value
    End Property

    Property Let set_sram_ecc_ded_flag_int_en(aData)
        write_sram_ecc_ded_flag_int_en_value = aData
        flag_sram_ecc_ded_flag_int_en        = &H1
    End Property

    Property Get read_sram_ecc_ded_flag_int_en
        read
        read_sram_ecc_ded_flag_int_en = read_sram_ecc_ded_flag_int_en_value
    End Property

    Property Let write_sram_ecc_ded_flag_int_en(aData)
        set_sram_ecc_ded_flag_int_en = aData
        write
    End Property

    Property Get get_sram_ecc_sec_flag_int_en
        get_sram_ecc_sec_flag_int_en = read_sram_ecc_sec_flag_int_en_value
    End Property

    Property Let set_sram_ecc_sec_flag_int_en(aData)
        write_sram_ecc_sec_flag_int_en_value = aData
        flag_sram_ecc_sec_flag_int_en        = &H1
    End Property

    Property Get read_sram_ecc_sec_flag_int_en
        read
        read_sram_ecc_sec_flag_int_en = read_sram_ecc_sec_flag_int_en_value
    End Property

    Property Let write_sram_ecc_sec_flag_int_en(aData)
        set_sram_ecc_sec_flag_int_en = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_spum_kek_ecc_ded_flag_int_en_value = rightShift(data_low, 25) and &H1
        read_spum_kek_ecc_sec_flag_int_en_value = rightShift(data_low, 24) and &H1
        read_spum_aubps_ecc_ded_flag_int_en_value = rightShift(data_low, 23) and &H1
        read_spum_aubps_ecc_sec_flag_int_en_value = rightShift(data_low, 22) and &H1
        read_spum_creaes_ecc_ded_flag_int_en_value = rightShift(data_low, 21) and &H1
        read_spum_creaes_ecc_sec_flag_int_en_value = rightShift(data_low, 20) and &H1
        read_spum_crbps_ecc_ded_flag_int_en_value = rightShift(data_low, 19) and &H1
        read_spum_crbps_ecc_sec_flag_int_en_value = rightShift(data_low, 18) and &H1
        read_spum_pafifo_ecc_ded_flag_int_en_value = rightShift(data_low, 17) and &H1
        read_spum_pafifo_ecc_sec_flag_int_en_value = rightShift(data_low, 16) and &H1
        read_spum_pasctx_ecc_ded_flag_int_en_value = rightShift(data_low, 15) and &H1
        read_spum_pasctx_ecc_sec_flag_int_en_value = rightShift(data_low, 14) and &H1
        read_spum_ppsupdt_ecc_ded_flag_int_en_value = rightShift(data_low, 13) and &H1
        read_spum_ppsupdt_ecc_sec_flag_int_en_value = rightShift(data_low, 12) and &H1
        read_pka_opp_ecc_ded_flag_int_en_value = rightShift(data_low, 11) and &H1
        read_pka_opp_ecc_sec_flag_int_en_value = rightShift(data_low, 10) and &H1
        read_pka_lir1_ecc_ded_flag_int_en_value = rightShift(data_low, 9) and &H1
        read_pka_lir1_ecc_sec_flag_int_en_value = rightShift(data_low, 8) and &H1
        read_pka_lir0_ecc_ded_flag_int_en_value = rightShift(data_low, 7) and &H1
        read_pka_lir0_ecc_sec_flag_int_en_value = rightShift(data_low, 6) and &H1
        read_dmem_ecc_ded_flag_int_en_value = rightShift(data_low, 5) and &H1
        read_dmem_ecc_sec_flag_int_en_value = rightShift(data_low, 4) and &H1
        read_imem_ecc_ded_flag_int_en_value = rightShift(data_low, 3) and &H1
        read_imem_ecc_sec_flag_int_en_value = rightShift(data_low, 2) and &H1
        read_sram_ecc_ded_flag_int_en_value = rightShift(data_low, 1) and &H1
        sram_ecc_sec_flag_int_en_mask = &H1
        if data_low > LONG_MAX then
            if sram_ecc_sec_flag_int_en_mask = mask then
                read_sram_ecc_sec_flag_int_en_value = data_low
            else
                read_sram_ecc_sec_flag_int_en_value = (data_low - H8000_0000) and sram_ecc_sec_flag_int_en_mask
            end If
        else
            read_sram_ecc_sec_flag_int_en_value = data_low and sram_ecc_sec_flag_int_en_mask
        end If

    End Sub

    Sub write
        If flag_spum_kek_ecc_ded_flag_int_en = &H0 or flag_spum_kek_ecc_sec_flag_int_en = &H0 or flag_spum_aubps_ecc_ded_flag_int_en = &H0 or flag_spum_aubps_ecc_sec_flag_int_en = &H0 or flag_spum_creaes_ecc_ded_flag_int_en = &H0 or flag_spum_creaes_ecc_sec_flag_int_en = &H0 or flag_spum_crbps_ecc_ded_flag_int_en = &H0 or flag_spum_crbps_ecc_sec_flag_int_en = &H0 or flag_spum_pafifo_ecc_ded_flag_int_en = &H0 or flag_spum_pafifo_ecc_sec_flag_int_en = &H0 or flag_spum_pasctx_ecc_ded_flag_int_en = &H0 or flag_spum_pasctx_ecc_sec_flag_int_en = &H0 or flag_spum_ppsupdt_ecc_ded_flag_int_en = &H0 or flag_spum_ppsupdt_ecc_sec_flag_int_en = &H0 or flag_pka_opp_ecc_ded_flag_int_en = &H0 or flag_pka_opp_ecc_sec_flag_int_en = &H0 or flag_pka_lir1_ecc_ded_flag_int_en = &H0 or flag_pka_lir1_ecc_sec_flag_int_en = &H0 or flag_pka_lir0_ecc_ded_flag_int_en = &H0 or flag_pka_lir0_ecc_sec_flag_int_en = &H0 or flag_dmem_ecc_ded_flag_int_en = &H0 or flag_dmem_ecc_sec_flag_int_en = &H0 or flag_imem_ecc_ded_flag_int_en = &H0 or flag_imem_ecc_sec_flag_int_en = &H0 or flag_sram_ecc_ded_flag_int_en = &H0 or flag_sram_ecc_sec_flag_int_en = &H0 Then read
        If flag_spum_kek_ecc_ded_flag_int_en = &H0 Then write_spum_kek_ecc_ded_flag_int_en_value = get_spum_kek_ecc_ded_flag_int_en
        If flag_spum_kek_ecc_sec_flag_int_en = &H0 Then write_spum_kek_ecc_sec_flag_int_en_value = get_spum_kek_ecc_sec_flag_int_en
        If flag_spum_aubps_ecc_ded_flag_int_en = &H0 Then write_spum_aubps_ecc_ded_flag_int_en_value = get_spum_aubps_ecc_ded_flag_int_en
        If flag_spum_aubps_ecc_sec_flag_int_en = &H0 Then write_spum_aubps_ecc_sec_flag_int_en_value = get_spum_aubps_ecc_sec_flag_int_en
        If flag_spum_creaes_ecc_ded_flag_int_en = &H0 Then write_spum_creaes_ecc_ded_flag_int_en_value = get_spum_creaes_ecc_ded_flag_int_en
        If flag_spum_creaes_ecc_sec_flag_int_en = &H0 Then write_spum_creaes_ecc_sec_flag_int_en_value = get_spum_creaes_ecc_sec_flag_int_en
        If flag_spum_crbps_ecc_ded_flag_int_en = &H0 Then write_spum_crbps_ecc_ded_flag_int_en_value = get_spum_crbps_ecc_ded_flag_int_en
        If flag_spum_crbps_ecc_sec_flag_int_en = &H0 Then write_spum_crbps_ecc_sec_flag_int_en_value = get_spum_crbps_ecc_sec_flag_int_en
        If flag_spum_pafifo_ecc_ded_flag_int_en = &H0 Then write_spum_pafifo_ecc_ded_flag_int_en_value = get_spum_pafifo_ecc_ded_flag_int_en
        If flag_spum_pafifo_ecc_sec_flag_int_en = &H0 Then write_spum_pafifo_ecc_sec_flag_int_en_value = get_spum_pafifo_ecc_sec_flag_int_en
        If flag_spum_pasctx_ecc_ded_flag_int_en = &H0 Then write_spum_pasctx_ecc_ded_flag_int_en_value = get_spum_pasctx_ecc_ded_flag_int_en
        If flag_spum_pasctx_ecc_sec_flag_int_en = &H0 Then write_spum_pasctx_ecc_sec_flag_int_en_value = get_spum_pasctx_ecc_sec_flag_int_en
        If flag_spum_ppsupdt_ecc_ded_flag_int_en = &H0 Then write_spum_ppsupdt_ecc_ded_flag_int_en_value = get_spum_ppsupdt_ecc_ded_flag_int_en
        If flag_spum_ppsupdt_ecc_sec_flag_int_en = &H0 Then write_spum_ppsupdt_ecc_sec_flag_int_en_value = get_spum_ppsupdt_ecc_sec_flag_int_en
        If flag_pka_opp_ecc_ded_flag_int_en = &H0 Then write_pka_opp_ecc_ded_flag_int_en_value = get_pka_opp_ecc_ded_flag_int_en
        If flag_pka_opp_ecc_sec_flag_int_en = &H0 Then write_pka_opp_ecc_sec_flag_int_en_value = get_pka_opp_ecc_sec_flag_int_en
        If flag_pka_lir1_ecc_ded_flag_int_en = &H0 Then write_pka_lir1_ecc_ded_flag_int_en_value = get_pka_lir1_ecc_ded_flag_int_en
        If flag_pka_lir1_ecc_sec_flag_int_en = &H0 Then write_pka_lir1_ecc_sec_flag_int_en_value = get_pka_lir1_ecc_sec_flag_int_en
        If flag_pka_lir0_ecc_ded_flag_int_en = &H0 Then write_pka_lir0_ecc_ded_flag_int_en_value = get_pka_lir0_ecc_ded_flag_int_en
        If flag_pka_lir0_ecc_sec_flag_int_en = &H0 Then write_pka_lir0_ecc_sec_flag_int_en_value = get_pka_lir0_ecc_sec_flag_int_en
        If flag_dmem_ecc_ded_flag_int_en = &H0 Then write_dmem_ecc_ded_flag_int_en_value = get_dmem_ecc_ded_flag_int_en
        If flag_dmem_ecc_sec_flag_int_en = &H0 Then write_dmem_ecc_sec_flag_int_en_value = get_dmem_ecc_sec_flag_int_en
        If flag_imem_ecc_ded_flag_int_en = &H0 Then write_imem_ecc_ded_flag_int_en_value = get_imem_ecc_ded_flag_int_en
        If flag_imem_ecc_sec_flag_int_en = &H0 Then write_imem_ecc_sec_flag_int_en_value = get_imem_ecc_sec_flag_int_en
        If flag_sram_ecc_ded_flag_int_en = &H0 Then write_sram_ecc_ded_flag_int_en_value = get_sram_ecc_ded_flag_int_en
        If flag_sram_ecc_sec_flag_int_en = &H0 Then write_sram_ecc_sec_flag_int_en_value = get_sram_ecc_sec_flag_int_en

        regValue = leftShift((write_spum_kek_ecc_ded_flag_int_en_value and &H1), 25) + leftShift((write_spum_kek_ecc_sec_flag_int_en_value and &H1), 24) + leftShift((write_spum_aubps_ecc_ded_flag_int_en_value and &H1), 23) + leftShift((write_spum_aubps_ecc_sec_flag_int_en_value and &H1), 22) + leftShift((write_spum_creaes_ecc_ded_flag_int_en_value and &H1), 21) + leftShift((write_spum_creaes_ecc_sec_flag_int_en_value and &H1), 20) + leftShift((write_spum_crbps_ecc_ded_flag_int_en_value and &H1), 19) + leftShift((write_spum_crbps_ecc_sec_flag_int_en_value and &H1), 18) + leftShift((write_spum_pafifo_ecc_ded_flag_int_en_value and &H1), 17) + leftShift((write_spum_pafifo_ecc_sec_flag_int_en_value and &H1), 16) + leftShift((write_spum_pasctx_ecc_ded_flag_int_en_value and &H1), 15) + leftShift((write_spum_pasctx_ecc_sec_flag_int_en_value and &H1), 14) + leftShift((write_spum_ppsupdt_ecc_ded_flag_int_en_value and &H1), 13) + leftShift((write_spum_ppsupdt_ecc_sec_flag_int_en_value and &H1), 12) + leftShift((write_pka_opp_ecc_ded_flag_int_en_value and &H1), 11) + leftShift((write_pka_opp_ecc_sec_flag_int_en_value and &H1), 10) + leftShift((write_pka_lir1_ecc_ded_flag_int_en_value and &H1), 9) + leftShift((write_pka_lir1_ecc_sec_flag_int_en_value and &H1), 8) + leftShift((write_pka_lir0_ecc_ded_flag_int_en_value and &H1), 7) + leftShift((write_pka_lir0_ecc_sec_flag_int_en_value and &H1), 6) + leftShift((write_dmem_ecc_ded_flag_int_en_value and &H1), 5) + leftShift((write_dmem_ecc_sec_flag_int_en_value and &H1), 4) + leftShift((write_imem_ecc_ded_flag_int_en_value and &H1), 3) + leftShift((write_imem_ecc_sec_flag_int_en_value and &H1), 2) + leftShift((write_sram_ecc_ded_flag_int_en_value and &H1), 1) + leftShift((write_sram_ecc_sec_flag_int_en_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_spum_kek_ecc_ded_flag_int_en_value = rightShift(data_low, 25) and &H1
        read_spum_kek_ecc_sec_flag_int_en_value = rightShift(data_low, 24) and &H1
        read_spum_aubps_ecc_ded_flag_int_en_value = rightShift(data_low, 23) and &H1
        read_spum_aubps_ecc_sec_flag_int_en_value = rightShift(data_low, 22) and &H1
        read_spum_creaes_ecc_ded_flag_int_en_value = rightShift(data_low, 21) and &H1
        read_spum_creaes_ecc_sec_flag_int_en_value = rightShift(data_low, 20) and &H1
        read_spum_crbps_ecc_ded_flag_int_en_value = rightShift(data_low, 19) and &H1
        read_spum_crbps_ecc_sec_flag_int_en_value = rightShift(data_low, 18) and &H1
        read_spum_pafifo_ecc_ded_flag_int_en_value = rightShift(data_low, 17) and &H1
        read_spum_pafifo_ecc_sec_flag_int_en_value = rightShift(data_low, 16) and &H1
        read_spum_pasctx_ecc_ded_flag_int_en_value = rightShift(data_low, 15) and &H1
        read_spum_pasctx_ecc_sec_flag_int_en_value = rightShift(data_low, 14) and &H1
        read_spum_ppsupdt_ecc_ded_flag_int_en_value = rightShift(data_low, 13) and &H1
        read_spum_ppsupdt_ecc_sec_flag_int_en_value = rightShift(data_low, 12) and &H1
        read_pka_opp_ecc_ded_flag_int_en_value = rightShift(data_low, 11) and &H1
        read_pka_opp_ecc_sec_flag_int_en_value = rightShift(data_low, 10) and &H1
        read_pka_lir1_ecc_ded_flag_int_en_value = rightShift(data_low, 9) and &H1
        read_pka_lir1_ecc_sec_flag_int_en_value = rightShift(data_low, 8) and &H1
        read_pka_lir0_ecc_ded_flag_int_en_value = rightShift(data_low, 7) and &H1
        read_pka_lir0_ecc_sec_flag_int_en_value = rightShift(data_low, 6) and &H1
        read_dmem_ecc_ded_flag_int_en_value = rightShift(data_low, 5) and &H1
        read_dmem_ecc_sec_flag_int_en_value = rightShift(data_low, 4) and &H1
        read_imem_ecc_ded_flag_int_en_value = rightShift(data_low, 3) and &H1
        read_imem_ecc_sec_flag_int_en_value = rightShift(data_low, 2) and &H1
        read_sram_ecc_ded_flag_int_en_value = rightShift(data_low, 1) and &H1
        sram_ecc_sec_flag_int_en_mask = &H1
        if data_low > LONG_MAX then
            if sram_ecc_sec_flag_int_en_mask = mask then
                read_sram_ecc_sec_flag_int_en_value = data_low
            else
                read_sram_ecc_sec_flag_int_en_value = (data_low - H8000_0000) and sram_ecc_sec_flag_int_en_mask
            end If
        else
            read_sram_ecc_sec_flag_int_en_value = data_low and sram_ecc_sec_flag_int_en_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_spum_kek_ecc_ded_flag_int_en_value = &H0
        flag_spum_kek_ecc_ded_flag_int_en        = &H0
        write_spum_kek_ecc_sec_flag_int_en_value = &H0
        flag_spum_kek_ecc_sec_flag_int_en        = &H0
        write_spum_aubps_ecc_ded_flag_int_en_value = &H0
        flag_spum_aubps_ecc_ded_flag_int_en        = &H0
        write_spum_aubps_ecc_sec_flag_int_en_value = &H0
        flag_spum_aubps_ecc_sec_flag_int_en        = &H0
        write_spum_creaes_ecc_ded_flag_int_en_value = &H0
        flag_spum_creaes_ecc_ded_flag_int_en        = &H0
        write_spum_creaes_ecc_sec_flag_int_en_value = &H0
        flag_spum_creaes_ecc_sec_flag_int_en        = &H0
        write_spum_crbps_ecc_ded_flag_int_en_value = &H0
        flag_spum_crbps_ecc_ded_flag_int_en        = &H0
        write_spum_crbps_ecc_sec_flag_int_en_value = &H0
        flag_spum_crbps_ecc_sec_flag_int_en        = &H0
        write_spum_pafifo_ecc_ded_flag_int_en_value = &H0
        flag_spum_pafifo_ecc_ded_flag_int_en        = &H0
        write_spum_pafifo_ecc_sec_flag_int_en_value = &H0
        flag_spum_pafifo_ecc_sec_flag_int_en        = &H0
        write_spum_pasctx_ecc_ded_flag_int_en_value = &H0
        flag_spum_pasctx_ecc_ded_flag_int_en        = &H0
        write_spum_pasctx_ecc_sec_flag_int_en_value = &H0
        flag_spum_pasctx_ecc_sec_flag_int_en        = &H0
        write_spum_ppsupdt_ecc_ded_flag_int_en_value = &H0
        flag_spum_ppsupdt_ecc_ded_flag_int_en        = &H0
        write_spum_ppsupdt_ecc_sec_flag_int_en_value = &H0
        flag_spum_ppsupdt_ecc_sec_flag_int_en        = &H0
        write_pka_opp_ecc_ded_flag_int_en_value = &H0
        flag_pka_opp_ecc_ded_flag_int_en        = &H0
        write_pka_opp_ecc_sec_flag_int_en_value = &H0
        flag_pka_opp_ecc_sec_flag_int_en        = &H0
        write_pka_lir1_ecc_ded_flag_int_en_value = &H0
        flag_pka_lir1_ecc_ded_flag_int_en        = &H0
        write_pka_lir1_ecc_sec_flag_int_en_value = &H0
        flag_pka_lir1_ecc_sec_flag_int_en        = &H0
        write_pka_lir0_ecc_ded_flag_int_en_value = &H0
        flag_pka_lir0_ecc_ded_flag_int_en        = &H0
        write_pka_lir0_ecc_sec_flag_int_en_value = &H0
        flag_pka_lir0_ecc_sec_flag_int_en        = &H0
        write_dmem_ecc_ded_flag_int_en_value = &H0
        flag_dmem_ecc_ded_flag_int_en        = &H0
        write_dmem_ecc_sec_flag_int_en_value = &H0
        flag_dmem_ecc_sec_flag_int_en        = &H0
        write_imem_ecc_ded_flag_int_en_value = &H0
        flag_imem_ecc_ded_flag_int_en        = &H0
        write_imem_ecc_sec_flag_int_en_value = &H0
        flag_imem_ecc_sec_flag_int_en        = &H0
        write_sram_ecc_ded_flag_int_en_value = &H0
        flag_sram_ecc_ded_flag_int_en        = &H0
        write_sram_ecc_sec_flag_int_en_value = &H0
        flag_sram_ecc_sec_flag_int_en        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_ecc_interrupt_clr_reg
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' spum_kek_ecc_ded_flag_int_clr              [25:25]          get_spum_kek_ecc_ded_flag_int_clr
''                                                             set_spum_kek_ecc_ded_flag_int_clr
''                                                             read_spum_kek_ecc_ded_flag_int_clr
''                                                             write_spum_kek_ecc_ded_flag_int_clr
''---------------------------------------------------------------------------------
'' spum_kek_ecc_sec_flag_int_clr              [24:24]          get_spum_kek_ecc_sec_flag_int_clr
''                                                             set_spum_kek_ecc_sec_flag_int_clr
''                                                             read_spum_kek_ecc_sec_flag_int_clr
''                                                             write_spum_kek_ecc_sec_flag_int_clr
''---------------------------------------------------------------------------------
'' spum_aubps_ecc_ded_flag_int_clr            [23:23]          get_spum_aubps_ecc_ded_flag_int_clr
''                                                             set_spum_aubps_ecc_ded_flag_int_clr
''                                                             read_spum_aubps_ecc_ded_flag_int_clr
''                                                             write_spum_aubps_ecc_ded_flag_int_clr
''---------------------------------------------------------------------------------
'' spum_aubps_ecc_sec_flag_int_clr            [22:22]          get_spum_aubps_ecc_sec_flag_int_clr
''                                                             set_spum_aubps_ecc_sec_flag_int_clr
''                                                             read_spum_aubps_ecc_sec_flag_int_clr
''                                                             write_spum_aubps_ecc_sec_flag_int_clr
''---------------------------------------------------------------------------------
'' spum_creaes_ecc_ded_flag_int_clr           [21:21]          get_spum_creaes_ecc_ded_flag_int_clr
''                                                             set_spum_creaes_ecc_ded_flag_int_clr
''                                                             read_spum_creaes_ecc_ded_flag_int_clr
''                                                             write_spum_creaes_ecc_ded_flag_int_clr
''---------------------------------------------------------------------------------
'' spum_creaes_ecc_sec_flag_int_clr           [20:20]          get_spum_creaes_ecc_sec_flag_int_clr
''                                                             set_spum_creaes_ecc_sec_flag_int_clr
''                                                             read_spum_creaes_ecc_sec_flag_int_clr
''                                                             write_spum_creaes_ecc_sec_flag_int_clr
''---------------------------------------------------------------------------------
'' spum_crbps_ecc_ded_flag_int_clr            [19:19]          get_spum_crbps_ecc_ded_flag_int_clr
''                                                             set_spum_crbps_ecc_ded_flag_int_clr
''                                                             read_spum_crbps_ecc_ded_flag_int_clr
''                                                             write_spum_crbps_ecc_ded_flag_int_clr
''---------------------------------------------------------------------------------
'' spum_crbps_ecc_sec_flag_int_clr            [18:18]          get_spum_crbps_ecc_sec_flag_int_clr
''                                                             set_spum_crbps_ecc_sec_flag_int_clr
''                                                             read_spum_crbps_ecc_sec_flag_int_clr
''                                                             write_spum_crbps_ecc_sec_flag_int_clr
''---------------------------------------------------------------------------------
'' spum_pafifo_ecc_ded_flag_int_clr           [17:17]          get_spum_pafifo_ecc_ded_flag_int_clr
''                                                             set_spum_pafifo_ecc_ded_flag_int_clr
''                                                             read_spum_pafifo_ecc_ded_flag_int_clr
''                                                             write_spum_pafifo_ecc_ded_flag_int_clr
''---------------------------------------------------------------------------------
'' spum_pafifo_ecc_sec_flag_int_clr           [16:16]          get_spum_pafifo_ecc_sec_flag_int_clr
''                                                             set_spum_pafifo_ecc_sec_flag_int_clr
''                                                             read_spum_pafifo_ecc_sec_flag_int_clr
''                                                             write_spum_pafifo_ecc_sec_flag_int_clr
''---------------------------------------------------------------------------------
'' spum_pasctx_ecc_ded_flag_int_clr           [15:15]          get_spum_pasctx_ecc_ded_flag_int_clr
''                                                             set_spum_pasctx_ecc_ded_flag_int_clr
''                                                             read_spum_pasctx_ecc_ded_flag_int_clr
''                                                             write_spum_pasctx_ecc_ded_flag_int_clr
''---------------------------------------------------------------------------------
'' spum_pasctx_ecc_sec_flag_int_clr           [14:14]          get_spum_pasctx_ecc_sec_flag_int_clr
''                                                             set_spum_pasctx_ecc_sec_flag_int_clr
''                                                             read_spum_pasctx_ecc_sec_flag_int_clr
''                                                             write_spum_pasctx_ecc_sec_flag_int_clr
''---------------------------------------------------------------------------------
'' spum_ppsupdt_ecc_ded_flag_int_clr          [13:13]          get_spum_ppsupdt_ecc_ded_flag_int_clr
''                                                             set_spum_ppsupdt_ecc_ded_flag_int_clr
''                                                             read_spum_ppsupdt_ecc_ded_flag_int_clr
''                                                             write_spum_ppsupdt_ecc_ded_flag_int_clr
''---------------------------------------------------------------------------------
'' spum_ppsupdt_ecc_sec_flag_int_clr          [12:12]          get_spum_ppsupdt_ecc_sec_flag_int_clr
''                                                             set_spum_ppsupdt_ecc_sec_flag_int_clr
''                                                             read_spum_ppsupdt_ecc_sec_flag_int_clr
''                                                             write_spum_ppsupdt_ecc_sec_flag_int_clr
''---------------------------------------------------------------------------------
'' pka_opp_ecc_ded_flag_int_clr               [11:11]          get_pka_opp_ecc_ded_flag_int_clr
''                                                             set_pka_opp_ecc_ded_flag_int_clr
''                                                             read_pka_opp_ecc_ded_flag_int_clr
''                                                             write_pka_opp_ecc_ded_flag_int_clr
''---------------------------------------------------------------------------------
'' pka_opp_ecc_sec_flag_int_clr               [10:10]          get_pka_opp_ecc_sec_flag_int_clr
''                                                             set_pka_opp_ecc_sec_flag_int_clr
''                                                             read_pka_opp_ecc_sec_flag_int_clr
''                                                             write_pka_opp_ecc_sec_flag_int_clr
''---------------------------------------------------------------------------------
'' pka_lir1_ecc_ded_flag_int_clr              [9:9]            get_pka_lir1_ecc_ded_flag_int_clr
''                                                             set_pka_lir1_ecc_ded_flag_int_clr
''                                                             read_pka_lir1_ecc_ded_flag_int_clr
''                                                             write_pka_lir1_ecc_ded_flag_int_clr
''---------------------------------------------------------------------------------
'' pka_lir1_ecc_sec_flag_int_clr              [8:8]            get_pka_lir1_ecc_sec_flag_int_clr
''                                                             set_pka_lir1_ecc_sec_flag_int_clr
''                                                             read_pka_lir1_ecc_sec_flag_int_clr
''                                                             write_pka_lir1_ecc_sec_flag_int_clr
''---------------------------------------------------------------------------------
'' pka_lir0_ecc_ded_flag_int_clr              [7:7]            get_pka_lir0_ecc_ded_flag_int_clr
''                                                             set_pka_lir0_ecc_ded_flag_int_clr
''                                                             read_pka_lir0_ecc_ded_flag_int_clr
''                                                             write_pka_lir0_ecc_ded_flag_int_clr
''---------------------------------------------------------------------------------
'' pka_lir0_ecc_sec_flag_int_clr              [6:6]            get_pka_lir0_ecc_sec_flag_int_clr
''                                                             set_pka_lir0_ecc_sec_flag_int_clr
''                                                             read_pka_lir0_ecc_sec_flag_int_clr
''                                                             write_pka_lir0_ecc_sec_flag_int_clr
''---------------------------------------------------------------------------------
'' dmem_ecc_ded_flag_int_clr                  [5:5]            get_dmem_ecc_ded_flag_int_clr
''                                                             set_dmem_ecc_ded_flag_int_clr
''                                                             read_dmem_ecc_ded_flag_int_clr
''                                                             write_dmem_ecc_ded_flag_int_clr
''---------------------------------------------------------------------------------
'' dmem_ecc_sec_flag_int_clr                  [4:4]            get_dmem_ecc_sec_flag_int_clr
''                                                             set_dmem_ecc_sec_flag_int_clr
''                                                             read_dmem_ecc_sec_flag_int_clr
''                                                             write_dmem_ecc_sec_flag_int_clr
''---------------------------------------------------------------------------------
'' imem_ecc_ded_flag_int_clr                  [3:3]            get_imem_ecc_ded_flag_int_clr
''                                                             set_imem_ecc_ded_flag_int_clr
''                                                             read_imem_ecc_ded_flag_int_clr
''                                                             write_imem_ecc_ded_flag_int_clr
''---------------------------------------------------------------------------------
'' imem_ecc_sec_flag_int_clr                  [2:2]            get_imem_ecc_sec_flag_int_clr
''                                                             set_imem_ecc_sec_flag_int_clr
''                                                             read_imem_ecc_sec_flag_int_clr
''                                                             write_imem_ecc_sec_flag_int_clr
''---------------------------------------------------------------------------------
'' sram_ecc_ded_flag_int_clr                  [1:1]            get_sram_ecc_ded_flag_int_clr
''                                                             set_sram_ecc_ded_flag_int_clr
''                                                             read_sram_ecc_ded_flag_int_clr
''                                                             write_sram_ecc_ded_flag_int_clr
''---------------------------------------------------------------------------------
'' sram_ecc_sec_flag_int_clr                  [0:0]            get_sram_ecc_sec_flag_int_clr
''                                                             set_sram_ecc_sec_flag_int_clr
''                                                             read_sram_ecc_sec_flag_int_clr
''                                                             write_sram_ecc_sec_flag_int_clr
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_ecc_interrupt_clr_reg
    Private write_spum_kek_ecc_ded_flag_int_clr_value
    Private read_spum_kek_ecc_ded_flag_int_clr_value
    Private flag_spum_kek_ecc_ded_flag_int_clr
    Private write_spum_kek_ecc_sec_flag_int_clr_value
    Private read_spum_kek_ecc_sec_flag_int_clr_value
    Private flag_spum_kek_ecc_sec_flag_int_clr
    Private write_spum_aubps_ecc_ded_flag_int_clr_value
    Private read_spum_aubps_ecc_ded_flag_int_clr_value
    Private flag_spum_aubps_ecc_ded_flag_int_clr
    Private write_spum_aubps_ecc_sec_flag_int_clr_value
    Private read_spum_aubps_ecc_sec_flag_int_clr_value
    Private flag_spum_aubps_ecc_sec_flag_int_clr
    Private write_spum_creaes_ecc_ded_flag_int_clr_value
    Private read_spum_creaes_ecc_ded_flag_int_clr_value
    Private flag_spum_creaes_ecc_ded_flag_int_clr
    Private write_spum_creaes_ecc_sec_flag_int_clr_value
    Private read_spum_creaes_ecc_sec_flag_int_clr_value
    Private flag_spum_creaes_ecc_sec_flag_int_clr
    Private write_spum_crbps_ecc_ded_flag_int_clr_value
    Private read_spum_crbps_ecc_ded_flag_int_clr_value
    Private flag_spum_crbps_ecc_ded_flag_int_clr
    Private write_spum_crbps_ecc_sec_flag_int_clr_value
    Private read_spum_crbps_ecc_sec_flag_int_clr_value
    Private flag_spum_crbps_ecc_sec_flag_int_clr
    Private write_spum_pafifo_ecc_ded_flag_int_clr_value
    Private read_spum_pafifo_ecc_ded_flag_int_clr_value
    Private flag_spum_pafifo_ecc_ded_flag_int_clr
    Private write_spum_pafifo_ecc_sec_flag_int_clr_value
    Private read_spum_pafifo_ecc_sec_flag_int_clr_value
    Private flag_spum_pafifo_ecc_sec_flag_int_clr
    Private write_spum_pasctx_ecc_ded_flag_int_clr_value
    Private read_spum_pasctx_ecc_ded_flag_int_clr_value
    Private flag_spum_pasctx_ecc_ded_flag_int_clr
    Private write_spum_pasctx_ecc_sec_flag_int_clr_value
    Private read_spum_pasctx_ecc_sec_flag_int_clr_value
    Private flag_spum_pasctx_ecc_sec_flag_int_clr
    Private write_spum_ppsupdt_ecc_ded_flag_int_clr_value
    Private read_spum_ppsupdt_ecc_ded_flag_int_clr_value
    Private flag_spum_ppsupdt_ecc_ded_flag_int_clr
    Private write_spum_ppsupdt_ecc_sec_flag_int_clr_value
    Private read_spum_ppsupdt_ecc_sec_flag_int_clr_value
    Private flag_spum_ppsupdt_ecc_sec_flag_int_clr
    Private write_pka_opp_ecc_ded_flag_int_clr_value
    Private read_pka_opp_ecc_ded_flag_int_clr_value
    Private flag_pka_opp_ecc_ded_flag_int_clr
    Private write_pka_opp_ecc_sec_flag_int_clr_value
    Private read_pka_opp_ecc_sec_flag_int_clr_value
    Private flag_pka_opp_ecc_sec_flag_int_clr
    Private write_pka_lir1_ecc_ded_flag_int_clr_value
    Private read_pka_lir1_ecc_ded_flag_int_clr_value
    Private flag_pka_lir1_ecc_ded_flag_int_clr
    Private write_pka_lir1_ecc_sec_flag_int_clr_value
    Private read_pka_lir1_ecc_sec_flag_int_clr_value
    Private flag_pka_lir1_ecc_sec_flag_int_clr
    Private write_pka_lir0_ecc_ded_flag_int_clr_value
    Private read_pka_lir0_ecc_ded_flag_int_clr_value
    Private flag_pka_lir0_ecc_ded_flag_int_clr
    Private write_pka_lir0_ecc_sec_flag_int_clr_value
    Private read_pka_lir0_ecc_sec_flag_int_clr_value
    Private flag_pka_lir0_ecc_sec_flag_int_clr
    Private write_dmem_ecc_ded_flag_int_clr_value
    Private read_dmem_ecc_ded_flag_int_clr_value
    Private flag_dmem_ecc_ded_flag_int_clr
    Private write_dmem_ecc_sec_flag_int_clr_value
    Private read_dmem_ecc_sec_flag_int_clr_value
    Private flag_dmem_ecc_sec_flag_int_clr
    Private write_imem_ecc_ded_flag_int_clr_value
    Private read_imem_ecc_ded_flag_int_clr_value
    Private flag_imem_ecc_ded_flag_int_clr
    Private write_imem_ecc_sec_flag_int_clr_value
    Private read_imem_ecc_sec_flag_int_clr_value
    Private flag_imem_ecc_sec_flag_int_clr
    Private write_sram_ecc_ded_flag_int_clr_value
    Private read_sram_ecc_ded_flag_int_clr_value
    Private flag_sram_ecc_ded_flag_int_clr
    Private write_sram_ecc_sec_flag_int_clr_value
    Private read_sram_ecc_sec_flag_int_clr_value
    Private flag_sram_ecc_sec_flag_int_clr

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H2c4
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_spum_kek_ecc_ded_flag_int_clr
        get_spum_kek_ecc_ded_flag_int_clr = read_spum_kek_ecc_ded_flag_int_clr_value
    End Property

    Property Let set_spum_kek_ecc_ded_flag_int_clr(aData)
        write_spum_kek_ecc_ded_flag_int_clr_value = aData
        flag_spum_kek_ecc_ded_flag_int_clr        = &H1
    End Property

    Property Get read_spum_kek_ecc_ded_flag_int_clr
        read
        read_spum_kek_ecc_ded_flag_int_clr = read_spum_kek_ecc_ded_flag_int_clr_value
    End Property

    Property Let write_spum_kek_ecc_ded_flag_int_clr(aData)
        set_spum_kek_ecc_ded_flag_int_clr = aData
        write
    End Property

    Property Get get_spum_kek_ecc_sec_flag_int_clr
        get_spum_kek_ecc_sec_flag_int_clr = read_spum_kek_ecc_sec_flag_int_clr_value
    End Property

    Property Let set_spum_kek_ecc_sec_flag_int_clr(aData)
        write_spum_kek_ecc_sec_flag_int_clr_value = aData
        flag_spum_kek_ecc_sec_flag_int_clr        = &H1
    End Property

    Property Get read_spum_kek_ecc_sec_flag_int_clr
        read
        read_spum_kek_ecc_sec_flag_int_clr = read_spum_kek_ecc_sec_flag_int_clr_value
    End Property

    Property Let write_spum_kek_ecc_sec_flag_int_clr(aData)
        set_spum_kek_ecc_sec_flag_int_clr = aData
        write
    End Property

    Property Get get_spum_aubps_ecc_ded_flag_int_clr
        get_spum_aubps_ecc_ded_flag_int_clr = read_spum_aubps_ecc_ded_flag_int_clr_value
    End Property

    Property Let set_spum_aubps_ecc_ded_flag_int_clr(aData)
        write_spum_aubps_ecc_ded_flag_int_clr_value = aData
        flag_spum_aubps_ecc_ded_flag_int_clr        = &H1
    End Property

    Property Get read_spum_aubps_ecc_ded_flag_int_clr
        read
        read_spum_aubps_ecc_ded_flag_int_clr = read_spum_aubps_ecc_ded_flag_int_clr_value
    End Property

    Property Let write_spum_aubps_ecc_ded_flag_int_clr(aData)
        set_spum_aubps_ecc_ded_flag_int_clr = aData
        write
    End Property

    Property Get get_spum_aubps_ecc_sec_flag_int_clr
        get_spum_aubps_ecc_sec_flag_int_clr = read_spum_aubps_ecc_sec_flag_int_clr_value
    End Property

    Property Let set_spum_aubps_ecc_sec_flag_int_clr(aData)
        write_spum_aubps_ecc_sec_flag_int_clr_value = aData
        flag_spum_aubps_ecc_sec_flag_int_clr        = &H1
    End Property

    Property Get read_spum_aubps_ecc_sec_flag_int_clr
        read
        read_spum_aubps_ecc_sec_flag_int_clr = read_spum_aubps_ecc_sec_flag_int_clr_value
    End Property

    Property Let write_spum_aubps_ecc_sec_flag_int_clr(aData)
        set_spum_aubps_ecc_sec_flag_int_clr = aData
        write
    End Property

    Property Get get_spum_creaes_ecc_ded_flag_int_clr
        get_spum_creaes_ecc_ded_flag_int_clr = read_spum_creaes_ecc_ded_flag_int_clr_value
    End Property

    Property Let set_spum_creaes_ecc_ded_flag_int_clr(aData)
        write_spum_creaes_ecc_ded_flag_int_clr_value = aData
        flag_spum_creaes_ecc_ded_flag_int_clr        = &H1
    End Property

    Property Get read_spum_creaes_ecc_ded_flag_int_clr
        read
        read_spum_creaes_ecc_ded_flag_int_clr = read_spum_creaes_ecc_ded_flag_int_clr_value
    End Property

    Property Let write_spum_creaes_ecc_ded_flag_int_clr(aData)
        set_spum_creaes_ecc_ded_flag_int_clr = aData
        write
    End Property

    Property Get get_spum_creaes_ecc_sec_flag_int_clr
        get_spum_creaes_ecc_sec_flag_int_clr = read_spum_creaes_ecc_sec_flag_int_clr_value
    End Property

    Property Let set_spum_creaes_ecc_sec_flag_int_clr(aData)
        write_spum_creaes_ecc_sec_flag_int_clr_value = aData
        flag_spum_creaes_ecc_sec_flag_int_clr        = &H1
    End Property

    Property Get read_spum_creaes_ecc_sec_flag_int_clr
        read
        read_spum_creaes_ecc_sec_flag_int_clr = read_spum_creaes_ecc_sec_flag_int_clr_value
    End Property

    Property Let write_spum_creaes_ecc_sec_flag_int_clr(aData)
        set_spum_creaes_ecc_sec_flag_int_clr = aData
        write
    End Property

    Property Get get_spum_crbps_ecc_ded_flag_int_clr
        get_spum_crbps_ecc_ded_flag_int_clr = read_spum_crbps_ecc_ded_flag_int_clr_value
    End Property

    Property Let set_spum_crbps_ecc_ded_flag_int_clr(aData)
        write_spum_crbps_ecc_ded_flag_int_clr_value = aData
        flag_spum_crbps_ecc_ded_flag_int_clr        = &H1
    End Property

    Property Get read_spum_crbps_ecc_ded_flag_int_clr
        read
        read_spum_crbps_ecc_ded_flag_int_clr = read_spum_crbps_ecc_ded_flag_int_clr_value
    End Property

    Property Let write_spum_crbps_ecc_ded_flag_int_clr(aData)
        set_spum_crbps_ecc_ded_flag_int_clr = aData
        write
    End Property

    Property Get get_spum_crbps_ecc_sec_flag_int_clr
        get_spum_crbps_ecc_sec_flag_int_clr = read_spum_crbps_ecc_sec_flag_int_clr_value
    End Property

    Property Let set_spum_crbps_ecc_sec_flag_int_clr(aData)
        write_spum_crbps_ecc_sec_flag_int_clr_value = aData
        flag_spum_crbps_ecc_sec_flag_int_clr        = &H1
    End Property

    Property Get read_spum_crbps_ecc_sec_flag_int_clr
        read
        read_spum_crbps_ecc_sec_flag_int_clr = read_spum_crbps_ecc_sec_flag_int_clr_value
    End Property

    Property Let write_spum_crbps_ecc_sec_flag_int_clr(aData)
        set_spum_crbps_ecc_sec_flag_int_clr = aData
        write
    End Property

    Property Get get_spum_pafifo_ecc_ded_flag_int_clr
        get_spum_pafifo_ecc_ded_flag_int_clr = read_spum_pafifo_ecc_ded_flag_int_clr_value
    End Property

    Property Let set_spum_pafifo_ecc_ded_flag_int_clr(aData)
        write_spum_pafifo_ecc_ded_flag_int_clr_value = aData
        flag_spum_pafifo_ecc_ded_flag_int_clr        = &H1
    End Property

    Property Get read_spum_pafifo_ecc_ded_flag_int_clr
        read
        read_spum_pafifo_ecc_ded_flag_int_clr = read_spum_pafifo_ecc_ded_flag_int_clr_value
    End Property

    Property Let write_spum_pafifo_ecc_ded_flag_int_clr(aData)
        set_spum_pafifo_ecc_ded_flag_int_clr = aData
        write
    End Property

    Property Get get_spum_pafifo_ecc_sec_flag_int_clr
        get_spum_pafifo_ecc_sec_flag_int_clr = read_spum_pafifo_ecc_sec_flag_int_clr_value
    End Property

    Property Let set_spum_pafifo_ecc_sec_flag_int_clr(aData)
        write_spum_pafifo_ecc_sec_flag_int_clr_value = aData
        flag_spum_pafifo_ecc_sec_flag_int_clr        = &H1
    End Property

    Property Get read_spum_pafifo_ecc_sec_flag_int_clr
        read
        read_spum_pafifo_ecc_sec_flag_int_clr = read_spum_pafifo_ecc_sec_flag_int_clr_value
    End Property

    Property Let write_spum_pafifo_ecc_sec_flag_int_clr(aData)
        set_spum_pafifo_ecc_sec_flag_int_clr = aData
        write
    End Property

    Property Get get_spum_pasctx_ecc_ded_flag_int_clr
        get_spum_pasctx_ecc_ded_flag_int_clr = read_spum_pasctx_ecc_ded_flag_int_clr_value
    End Property

    Property Let set_spum_pasctx_ecc_ded_flag_int_clr(aData)
        write_spum_pasctx_ecc_ded_flag_int_clr_value = aData
        flag_spum_pasctx_ecc_ded_flag_int_clr        = &H1
    End Property

    Property Get read_spum_pasctx_ecc_ded_flag_int_clr
        read
        read_spum_pasctx_ecc_ded_flag_int_clr = read_spum_pasctx_ecc_ded_flag_int_clr_value
    End Property

    Property Let write_spum_pasctx_ecc_ded_flag_int_clr(aData)
        set_spum_pasctx_ecc_ded_flag_int_clr = aData
        write
    End Property

    Property Get get_spum_pasctx_ecc_sec_flag_int_clr
        get_spum_pasctx_ecc_sec_flag_int_clr = read_spum_pasctx_ecc_sec_flag_int_clr_value
    End Property

    Property Let set_spum_pasctx_ecc_sec_flag_int_clr(aData)
        write_spum_pasctx_ecc_sec_flag_int_clr_value = aData
        flag_spum_pasctx_ecc_sec_flag_int_clr        = &H1
    End Property

    Property Get read_spum_pasctx_ecc_sec_flag_int_clr
        read
        read_spum_pasctx_ecc_sec_flag_int_clr = read_spum_pasctx_ecc_sec_flag_int_clr_value
    End Property

    Property Let write_spum_pasctx_ecc_sec_flag_int_clr(aData)
        set_spum_pasctx_ecc_sec_flag_int_clr = aData
        write
    End Property

    Property Get get_spum_ppsupdt_ecc_ded_flag_int_clr
        get_spum_ppsupdt_ecc_ded_flag_int_clr = read_spum_ppsupdt_ecc_ded_flag_int_clr_value
    End Property

    Property Let set_spum_ppsupdt_ecc_ded_flag_int_clr(aData)
        write_spum_ppsupdt_ecc_ded_flag_int_clr_value = aData
        flag_spum_ppsupdt_ecc_ded_flag_int_clr        = &H1
    End Property

    Property Get read_spum_ppsupdt_ecc_ded_flag_int_clr
        read
        read_spum_ppsupdt_ecc_ded_flag_int_clr = read_spum_ppsupdt_ecc_ded_flag_int_clr_value
    End Property

    Property Let write_spum_ppsupdt_ecc_ded_flag_int_clr(aData)
        set_spum_ppsupdt_ecc_ded_flag_int_clr = aData
        write
    End Property

    Property Get get_spum_ppsupdt_ecc_sec_flag_int_clr
        get_spum_ppsupdt_ecc_sec_flag_int_clr = read_spum_ppsupdt_ecc_sec_flag_int_clr_value
    End Property

    Property Let set_spum_ppsupdt_ecc_sec_flag_int_clr(aData)
        write_spum_ppsupdt_ecc_sec_flag_int_clr_value = aData
        flag_spum_ppsupdt_ecc_sec_flag_int_clr        = &H1
    End Property

    Property Get read_spum_ppsupdt_ecc_sec_flag_int_clr
        read
        read_spum_ppsupdt_ecc_sec_flag_int_clr = read_spum_ppsupdt_ecc_sec_flag_int_clr_value
    End Property

    Property Let write_spum_ppsupdt_ecc_sec_flag_int_clr(aData)
        set_spum_ppsupdt_ecc_sec_flag_int_clr = aData
        write
    End Property

    Property Get get_pka_opp_ecc_ded_flag_int_clr
        get_pka_opp_ecc_ded_flag_int_clr = read_pka_opp_ecc_ded_flag_int_clr_value
    End Property

    Property Let set_pka_opp_ecc_ded_flag_int_clr(aData)
        write_pka_opp_ecc_ded_flag_int_clr_value = aData
        flag_pka_opp_ecc_ded_flag_int_clr        = &H1
    End Property

    Property Get read_pka_opp_ecc_ded_flag_int_clr
        read
        read_pka_opp_ecc_ded_flag_int_clr = read_pka_opp_ecc_ded_flag_int_clr_value
    End Property

    Property Let write_pka_opp_ecc_ded_flag_int_clr(aData)
        set_pka_opp_ecc_ded_flag_int_clr = aData
        write
    End Property

    Property Get get_pka_opp_ecc_sec_flag_int_clr
        get_pka_opp_ecc_sec_flag_int_clr = read_pka_opp_ecc_sec_flag_int_clr_value
    End Property

    Property Let set_pka_opp_ecc_sec_flag_int_clr(aData)
        write_pka_opp_ecc_sec_flag_int_clr_value = aData
        flag_pka_opp_ecc_sec_flag_int_clr        = &H1
    End Property

    Property Get read_pka_opp_ecc_sec_flag_int_clr
        read
        read_pka_opp_ecc_sec_flag_int_clr = read_pka_opp_ecc_sec_flag_int_clr_value
    End Property

    Property Let write_pka_opp_ecc_sec_flag_int_clr(aData)
        set_pka_opp_ecc_sec_flag_int_clr = aData
        write
    End Property

    Property Get get_pka_lir1_ecc_ded_flag_int_clr
        get_pka_lir1_ecc_ded_flag_int_clr = read_pka_lir1_ecc_ded_flag_int_clr_value
    End Property

    Property Let set_pka_lir1_ecc_ded_flag_int_clr(aData)
        write_pka_lir1_ecc_ded_flag_int_clr_value = aData
        flag_pka_lir1_ecc_ded_flag_int_clr        = &H1
    End Property

    Property Get read_pka_lir1_ecc_ded_flag_int_clr
        read
        read_pka_lir1_ecc_ded_flag_int_clr = read_pka_lir1_ecc_ded_flag_int_clr_value
    End Property

    Property Let write_pka_lir1_ecc_ded_flag_int_clr(aData)
        set_pka_lir1_ecc_ded_flag_int_clr = aData
        write
    End Property

    Property Get get_pka_lir1_ecc_sec_flag_int_clr
        get_pka_lir1_ecc_sec_flag_int_clr = read_pka_lir1_ecc_sec_flag_int_clr_value
    End Property

    Property Let set_pka_lir1_ecc_sec_flag_int_clr(aData)
        write_pka_lir1_ecc_sec_flag_int_clr_value = aData
        flag_pka_lir1_ecc_sec_flag_int_clr        = &H1
    End Property

    Property Get read_pka_lir1_ecc_sec_flag_int_clr
        read
        read_pka_lir1_ecc_sec_flag_int_clr = read_pka_lir1_ecc_sec_flag_int_clr_value
    End Property

    Property Let write_pka_lir1_ecc_sec_flag_int_clr(aData)
        set_pka_lir1_ecc_sec_flag_int_clr = aData
        write
    End Property

    Property Get get_pka_lir0_ecc_ded_flag_int_clr
        get_pka_lir0_ecc_ded_flag_int_clr = read_pka_lir0_ecc_ded_flag_int_clr_value
    End Property

    Property Let set_pka_lir0_ecc_ded_flag_int_clr(aData)
        write_pka_lir0_ecc_ded_flag_int_clr_value = aData
        flag_pka_lir0_ecc_ded_flag_int_clr        = &H1
    End Property

    Property Get read_pka_lir0_ecc_ded_flag_int_clr
        read
        read_pka_lir0_ecc_ded_flag_int_clr = read_pka_lir0_ecc_ded_flag_int_clr_value
    End Property

    Property Let write_pka_lir0_ecc_ded_flag_int_clr(aData)
        set_pka_lir0_ecc_ded_flag_int_clr = aData
        write
    End Property

    Property Get get_pka_lir0_ecc_sec_flag_int_clr
        get_pka_lir0_ecc_sec_flag_int_clr = read_pka_lir0_ecc_sec_flag_int_clr_value
    End Property

    Property Let set_pka_lir0_ecc_sec_flag_int_clr(aData)
        write_pka_lir0_ecc_sec_flag_int_clr_value = aData
        flag_pka_lir0_ecc_sec_flag_int_clr        = &H1
    End Property

    Property Get read_pka_lir0_ecc_sec_flag_int_clr
        read
        read_pka_lir0_ecc_sec_flag_int_clr = read_pka_lir0_ecc_sec_flag_int_clr_value
    End Property

    Property Let write_pka_lir0_ecc_sec_flag_int_clr(aData)
        set_pka_lir0_ecc_sec_flag_int_clr = aData
        write
    End Property

    Property Get get_dmem_ecc_ded_flag_int_clr
        get_dmem_ecc_ded_flag_int_clr = read_dmem_ecc_ded_flag_int_clr_value
    End Property

    Property Let set_dmem_ecc_ded_flag_int_clr(aData)
        write_dmem_ecc_ded_flag_int_clr_value = aData
        flag_dmem_ecc_ded_flag_int_clr        = &H1
    End Property

    Property Get read_dmem_ecc_ded_flag_int_clr
        read
        read_dmem_ecc_ded_flag_int_clr = read_dmem_ecc_ded_flag_int_clr_value
    End Property

    Property Let write_dmem_ecc_ded_flag_int_clr(aData)
        set_dmem_ecc_ded_flag_int_clr = aData
        write
    End Property

    Property Get get_dmem_ecc_sec_flag_int_clr
        get_dmem_ecc_sec_flag_int_clr = read_dmem_ecc_sec_flag_int_clr_value
    End Property

    Property Let set_dmem_ecc_sec_flag_int_clr(aData)
        write_dmem_ecc_sec_flag_int_clr_value = aData
        flag_dmem_ecc_sec_flag_int_clr        = &H1
    End Property

    Property Get read_dmem_ecc_sec_flag_int_clr
        read
        read_dmem_ecc_sec_flag_int_clr = read_dmem_ecc_sec_flag_int_clr_value
    End Property

    Property Let write_dmem_ecc_sec_flag_int_clr(aData)
        set_dmem_ecc_sec_flag_int_clr = aData
        write
    End Property

    Property Get get_imem_ecc_ded_flag_int_clr
        get_imem_ecc_ded_flag_int_clr = read_imem_ecc_ded_flag_int_clr_value
    End Property

    Property Let set_imem_ecc_ded_flag_int_clr(aData)
        write_imem_ecc_ded_flag_int_clr_value = aData
        flag_imem_ecc_ded_flag_int_clr        = &H1
    End Property

    Property Get read_imem_ecc_ded_flag_int_clr
        read
        read_imem_ecc_ded_flag_int_clr = read_imem_ecc_ded_flag_int_clr_value
    End Property

    Property Let write_imem_ecc_ded_flag_int_clr(aData)
        set_imem_ecc_ded_flag_int_clr = aData
        write
    End Property

    Property Get get_imem_ecc_sec_flag_int_clr
        get_imem_ecc_sec_flag_int_clr = read_imem_ecc_sec_flag_int_clr_value
    End Property

    Property Let set_imem_ecc_sec_flag_int_clr(aData)
        write_imem_ecc_sec_flag_int_clr_value = aData
        flag_imem_ecc_sec_flag_int_clr        = &H1
    End Property

    Property Get read_imem_ecc_sec_flag_int_clr
        read
        read_imem_ecc_sec_flag_int_clr = read_imem_ecc_sec_flag_int_clr_value
    End Property

    Property Let write_imem_ecc_sec_flag_int_clr(aData)
        set_imem_ecc_sec_flag_int_clr = aData
        write
    End Property

    Property Get get_sram_ecc_ded_flag_int_clr
        get_sram_ecc_ded_flag_int_clr = read_sram_ecc_ded_flag_int_clr_value
    End Property

    Property Let set_sram_ecc_ded_flag_int_clr(aData)
        write_sram_ecc_ded_flag_int_clr_value = aData
        flag_sram_ecc_ded_flag_int_clr        = &H1
    End Property

    Property Get read_sram_ecc_ded_flag_int_clr
        read
        read_sram_ecc_ded_flag_int_clr = read_sram_ecc_ded_flag_int_clr_value
    End Property

    Property Let write_sram_ecc_ded_flag_int_clr(aData)
        set_sram_ecc_ded_flag_int_clr = aData
        write
    End Property

    Property Get get_sram_ecc_sec_flag_int_clr
        get_sram_ecc_sec_flag_int_clr = read_sram_ecc_sec_flag_int_clr_value
    End Property

    Property Let set_sram_ecc_sec_flag_int_clr(aData)
        write_sram_ecc_sec_flag_int_clr_value = aData
        flag_sram_ecc_sec_flag_int_clr        = &H1
    End Property

    Property Get read_sram_ecc_sec_flag_int_clr
        read
        read_sram_ecc_sec_flag_int_clr = read_sram_ecc_sec_flag_int_clr_value
    End Property

    Property Let write_sram_ecc_sec_flag_int_clr(aData)
        set_sram_ecc_sec_flag_int_clr = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_spum_kek_ecc_ded_flag_int_clr_value = rightShift(data_low, 25) and &H1
        read_spum_kek_ecc_sec_flag_int_clr_value = rightShift(data_low, 24) and &H1
        read_spum_aubps_ecc_ded_flag_int_clr_value = rightShift(data_low, 23) and &H1
        read_spum_aubps_ecc_sec_flag_int_clr_value = rightShift(data_low, 22) and &H1
        read_spum_creaes_ecc_ded_flag_int_clr_value = rightShift(data_low, 21) and &H1
        read_spum_creaes_ecc_sec_flag_int_clr_value = rightShift(data_low, 20) and &H1
        read_spum_crbps_ecc_ded_flag_int_clr_value = rightShift(data_low, 19) and &H1
        read_spum_crbps_ecc_sec_flag_int_clr_value = rightShift(data_low, 18) and &H1
        read_spum_pafifo_ecc_ded_flag_int_clr_value = rightShift(data_low, 17) and &H1
        read_spum_pafifo_ecc_sec_flag_int_clr_value = rightShift(data_low, 16) and &H1
        read_spum_pasctx_ecc_ded_flag_int_clr_value = rightShift(data_low, 15) and &H1
        read_spum_pasctx_ecc_sec_flag_int_clr_value = rightShift(data_low, 14) and &H1
        read_spum_ppsupdt_ecc_ded_flag_int_clr_value = rightShift(data_low, 13) and &H1
        read_spum_ppsupdt_ecc_sec_flag_int_clr_value = rightShift(data_low, 12) and &H1
        read_pka_opp_ecc_ded_flag_int_clr_value = rightShift(data_low, 11) and &H1
        read_pka_opp_ecc_sec_flag_int_clr_value = rightShift(data_low, 10) and &H1
        read_pka_lir1_ecc_ded_flag_int_clr_value = rightShift(data_low, 9) and &H1
        read_pka_lir1_ecc_sec_flag_int_clr_value = rightShift(data_low, 8) and &H1
        read_pka_lir0_ecc_ded_flag_int_clr_value = rightShift(data_low, 7) and &H1
        read_pka_lir0_ecc_sec_flag_int_clr_value = rightShift(data_low, 6) and &H1
        read_dmem_ecc_ded_flag_int_clr_value = rightShift(data_low, 5) and &H1
        read_dmem_ecc_sec_flag_int_clr_value = rightShift(data_low, 4) and &H1
        read_imem_ecc_ded_flag_int_clr_value = rightShift(data_low, 3) and &H1
        read_imem_ecc_sec_flag_int_clr_value = rightShift(data_low, 2) and &H1
        read_sram_ecc_ded_flag_int_clr_value = rightShift(data_low, 1) and &H1
        sram_ecc_sec_flag_int_clr_mask = &H1
        if data_low > LONG_MAX then
            if sram_ecc_sec_flag_int_clr_mask = mask then
                read_sram_ecc_sec_flag_int_clr_value = data_low
            else
                read_sram_ecc_sec_flag_int_clr_value = (data_low - H8000_0000) and sram_ecc_sec_flag_int_clr_mask
            end If
        else
            read_sram_ecc_sec_flag_int_clr_value = data_low and sram_ecc_sec_flag_int_clr_mask
        end If

    End Sub

    Sub write
        If flag_spum_kek_ecc_ded_flag_int_clr = &H0 or flag_spum_kek_ecc_sec_flag_int_clr = &H0 or flag_spum_aubps_ecc_ded_flag_int_clr = &H0 or flag_spum_aubps_ecc_sec_flag_int_clr = &H0 or flag_spum_creaes_ecc_ded_flag_int_clr = &H0 or flag_spum_creaes_ecc_sec_flag_int_clr = &H0 or flag_spum_crbps_ecc_ded_flag_int_clr = &H0 or flag_spum_crbps_ecc_sec_flag_int_clr = &H0 or flag_spum_pafifo_ecc_ded_flag_int_clr = &H0 or flag_spum_pafifo_ecc_sec_flag_int_clr = &H0 or flag_spum_pasctx_ecc_ded_flag_int_clr = &H0 or flag_spum_pasctx_ecc_sec_flag_int_clr = &H0 or flag_spum_ppsupdt_ecc_ded_flag_int_clr = &H0 or flag_spum_ppsupdt_ecc_sec_flag_int_clr = &H0 or flag_pka_opp_ecc_ded_flag_int_clr = &H0 or flag_pka_opp_ecc_sec_flag_int_clr = &H0 or flag_pka_lir1_ecc_ded_flag_int_clr = &H0 or flag_pka_lir1_ecc_sec_flag_int_clr = &H0 or flag_pka_lir0_ecc_ded_flag_int_clr = &H0 or flag_pka_lir0_ecc_sec_flag_int_clr = &H0 or flag_dmem_ecc_ded_flag_int_clr = &H0 or flag_dmem_ecc_sec_flag_int_clr = &H0 or flag_imem_ecc_ded_flag_int_clr = &H0 or flag_imem_ecc_sec_flag_int_clr = &H0 or flag_sram_ecc_ded_flag_int_clr = &H0 or flag_sram_ecc_sec_flag_int_clr = &H0 Then read
        If flag_spum_kek_ecc_ded_flag_int_clr = &H0 Then write_spum_kek_ecc_ded_flag_int_clr_value = get_spum_kek_ecc_ded_flag_int_clr
        If flag_spum_kek_ecc_sec_flag_int_clr = &H0 Then write_spum_kek_ecc_sec_flag_int_clr_value = get_spum_kek_ecc_sec_flag_int_clr
        If flag_spum_aubps_ecc_ded_flag_int_clr = &H0 Then write_spum_aubps_ecc_ded_flag_int_clr_value = get_spum_aubps_ecc_ded_flag_int_clr
        If flag_spum_aubps_ecc_sec_flag_int_clr = &H0 Then write_spum_aubps_ecc_sec_flag_int_clr_value = get_spum_aubps_ecc_sec_flag_int_clr
        If flag_spum_creaes_ecc_ded_flag_int_clr = &H0 Then write_spum_creaes_ecc_ded_flag_int_clr_value = get_spum_creaes_ecc_ded_flag_int_clr
        If flag_spum_creaes_ecc_sec_flag_int_clr = &H0 Then write_spum_creaes_ecc_sec_flag_int_clr_value = get_spum_creaes_ecc_sec_flag_int_clr
        If flag_spum_crbps_ecc_ded_flag_int_clr = &H0 Then write_spum_crbps_ecc_ded_flag_int_clr_value = get_spum_crbps_ecc_ded_flag_int_clr
        If flag_spum_crbps_ecc_sec_flag_int_clr = &H0 Then write_spum_crbps_ecc_sec_flag_int_clr_value = get_spum_crbps_ecc_sec_flag_int_clr
        If flag_spum_pafifo_ecc_ded_flag_int_clr = &H0 Then write_spum_pafifo_ecc_ded_flag_int_clr_value = get_spum_pafifo_ecc_ded_flag_int_clr
        If flag_spum_pafifo_ecc_sec_flag_int_clr = &H0 Then write_spum_pafifo_ecc_sec_flag_int_clr_value = get_spum_pafifo_ecc_sec_flag_int_clr
        If flag_spum_pasctx_ecc_ded_flag_int_clr = &H0 Then write_spum_pasctx_ecc_ded_flag_int_clr_value = get_spum_pasctx_ecc_ded_flag_int_clr
        If flag_spum_pasctx_ecc_sec_flag_int_clr = &H0 Then write_spum_pasctx_ecc_sec_flag_int_clr_value = get_spum_pasctx_ecc_sec_flag_int_clr
        If flag_spum_ppsupdt_ecc_ded_flag_int_clr = &H0 Then write_spum_ppsupdt_ecc_ded_flag_int_clr_value = get_spum_ppsupdt_ecc_ded_flag_int_clr
        If flag_spum_ppsupdt_ecc_sec_flag_int_clr = &H0 Then write_spum_ppsupdt_ecc_sec_flag_int_clr_value = get_spum_ppsupdt_ecc_sec_flag_int_clr
        If flag_pka_opp_ecc_ded_flag_int_clr = &H0 Then write_pka_opp_ecc_ded_flag_int_clr_value = get_pka_opp_ecc_ded_flag_int_clr
        If flag_pka_opp_ecc_sec_flag_int_clr = &H0 Then write_pka_opp_ecc_sec_flag_int_clr_value = get_pka_opp_ecc_sec_flag_int_clr
        If flag_pka_lir1_ecc_ded_flag_int_clr = &H0 Then write_pka_lir1_ecc_ded_flag_int_clr_value = get_pka_lir1_ecc_ded_flag_int_clr
        If flag_pka_lir1_ecc_sec_flag_int_clr = &H0 Then write_pka_lir1_ecc_sec_flag_int_clr_value = get_pka_lir1_ecc_sec_flag_int_clr
        If flag_pka_lir0_ecc_ded_flag_int_clr = &H0 Then write_pka_lir0_ecc_ded_flag_int_clr_value = get_pka_lir0_ecc_ded_flag_int_clr
        If flag_pka_lir0_ecc_sec_flag_int_clr = &H0 Then write_pka_lir0_ecc_sec_flag_int_clr_value = get_pka_lir0_ecc_sec_flag_int_clr
        If flag_dmem_ecc_ded_flag_int_clr = &H0 Then write_dmem_ecc_ded_flag_int_clr_value = get_dmem_ecc_ded_flag_int_clr
        If flag_dmem_ecc_sec_flag_int_clr = &H0 Then write_dmem_ecc_sec_flag_int_clr_value = get_dmem_ecc_sec_flag_int_clr
        If flag_imem_ecc_ded_flag_int_clr = &H0 Then write_imem_ecc_ded_flag_int_clr_value = get_imem_ecc_ded_flag_int_clr
        If flag_imem_ecc_sec_flag_int_clr = &H0 Then write_imem_ecc_sec_flag_int_clr_value = get_imem_ecc_sec_flag_int_clr
        If flag_sram_ecc_ded_flag_int_clr = &H0 Then write_sram_ecc_ded_flag_int_clr_value = get_sram_ecc_ded_flag_int_clr
        If flag_sram_ecc_sec_flag_int_clr = &H0 Then write_sram_ecc_sec_flag_int_clr_value = get_sram_ecc_sec_flag_int_clr

        regValue = leftShift((write_spum_kek_ecc_ded_flag_int_clr_value and &H1), 25) + leftShift((write_spum_kek_ecc_sec_flag_int_clr_value and &H1), 24) + leftShift((write_spum_aubps_ecc_ded_flag_int_clr_value and &H1), 23) + leftShift((write_spum_aubps_ecc_sec_flag_int_clr_value and &H1), 22) + leftShift((write_spum_creaes_ecc_ded_flag_int_clr_value and &H1), 21) + leftShift((write_spum_creaes_ecc_sec_flag_int_clr_value and &H1), 20) + leftShift((write_spum_crbps_ecc_ded_flag_int_clr_value and &H1), 19) + leftShift((write_spum_crbps_ecc_sec_flag_int_clr_value and &H1), 18) + leftShift((write_spum_pafifo_ecc_ded_flag_int_clr_value and &H1), 17) + leftShift((write_spum_pafifo_ecc_sec_flag_int_clr_value and &H1), 16) + leftShift((write_spum_pasctx_ecc_ded_flag_int_clr_value and &H1), 15) + leftShift((write_spum_pasctx_ecc_sec_flag_int_clr_value and &H1), 14) + leftShift((write_spum_ppsupdt_ecc_ded_flag_int_clr_value and &H1), 13) + leftShift((write_spum_ppsupdt_ecc_sec_flag_int_clr_value and &H1), 12) + leftShift((write_pka_opp_ecc_ded_flag_int_clr_value and &H1), 11) + leftShift((write_pka_opp_ecc_sec_flag_int_clr_value and &H1), 10) + leftShift((write_pka_lir1_ecc_ded_flag_int_clr_value and &H1), 9) + leftShift((write_pka_lir1_ecc_sec_flag_int_clr_value and &H1), 8) + leftShift((write_pka_lir0_ecc_ded_flag_int_clr_value and &H1), 7) + leftShift((write_pka_lir0_ecc_sec_flag_int_clr_value and &H1), 6) + leftShift((write_dmem_ecc_ded_flag_int_clr_value and &H1), 5) + leftShift((write_dmem_ecc_sec_flag_int_clr_value and &H1), 4) + leftShift((write_imem_ecc_ded_flag_int_clr_value and &H1), 3) + leftShift((write_imem_ecc_sec_flag_int_clr_value and &H1), 2) + leftShift((write_sram_ecc_ded_flag_int_clr_value and &H1), 1) + leftShift((write_sram_ecc_sec_flag_int_clr_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_spum_kek_ecc_ded_flag_int_clr_value = rightShift(data_low, 25) and &H1
        read_spum_kek_ecc_sec_flag_int_clr_value = rightShift(data_low, 24) and &H1
        read_spum_aubps_ecc_ded_flag_int_clr_value = rightShift(data_low, 23) and &H1
        read_spum_aubps_ecc_sec_flag_int_clr_value = rightShift(data_low, 22) and &H1
        read_spum_creaes_ecc_ded_flag_int_clr_value = rightShift(data_low, 21) and &H1
        read_spum_creaes_ecc_sec_flag_int_clr_value = rightShift(data_low, 20) and &H1
        read_spum_crbps_ecc_ded_flag_int_clr_value = rightShift(data_low, 19) and &H1
        read_spum_crbps_ecc_sec_flag_int_clr_value = rightShift(data_low, 18) and &H1
        read_spum_pafifo_ecc_ded_flag_int_clr_value = rightShift(data_low, 17) and &H1
        read_spum_pafifo_ecc_sec_flag_int_clr_value = rightShift(data_low, 16) and &H1
        read_spum_pasctx_ecc_ded_flag_int_clr_value = rightShift(data_low, 15) and &H1
        read_spum_pasctx_ecc_sec_flag_int_clr_value = rightShift(data_low, 14) and &H1
        read_spum_ppsupdt_ecc_ded_flag_int_clr_value = rightShift(data_low, 13) and &H1
        read_spum_ppsupdt_ecc_sec_flag_int_clr_value = rightShift(data_low, 12) and &H1
        read_pka_opp_ecc_ded_flag_int_clr_value = rightShift(data_low, 11) and &H1
        read_pka_opp_ecc_sec_flag_int_clr_value = rightShift(data_low, 10) and &H1
        read_pka_lir1_ecc_ded_flag_int_clr_value = rightShift(data_low, 9) and &H1
        read_pka_lir1_ecc_sec_flag_int_clr_value = rightShift(data_low, 8) and &H1
        read_pka_lir0_ecc_ded_flag_int_clr_value = rightShift(data_low, 7) and &H1
        read_pka_lir0_ecc_sec_flag_int_clr_value = rightShift(data_low, 6) and &H1
        read_dmem_ecc_ded_flag_int_clr_value = rightShift(data_low, 5) and &H1
        read_dmem_ecc_sec_flag_int_clr_value = rightShift(data_low, 4) and &H1
        read_imem_ecc_ded_flag_int_clr_value = rightShift(data_low, 3) and &H1
        read_imem_ecc_sec_flag_int_clr_value = rightShift(data_low, 2) and &H1
        read_sram_ecc_ded_flag_int_clr_value = rightShift(data_low, 1) and &H1
        sram_ecc_sec_flag_int_clr_mask = &H1
        if data_low > LONG_MAX then
            if sram_ecc_sec_flag_int_clr_mask = mask then
                read_sram_ecc_sec_flag_int_clr_value = data_low
            else
                read_sram_ecc_sec_flag_int_clr_value = (data_low - H8000_0000) and sram_ecc_sec_flag_int_clr_mask
            end If
        else
            read_sram_ecc_sec_flag_int_clr_value = data_low and sram_ecc_sec_flag_int_clr_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_spum_kek_ecc_ded_flag_int_clr_value = &H0
        flag_spum_kek_ecc_ded_flag_int_clr        = &H0
        write_spum_kek_ecc_sec_flag_int_clr_value = &H0
        flag_spum_kek_ecc_sec_flag_int_clr        = &H0
        write_spum_aubps_ecc_ded_flag_int_clr_value = &H0
        flag_spum_aubps_ecc_ded_flag_int_clr        = &H0
        write_spum_aubps_ecc_sec_flag_int_clr_value = &H0
        flag_spum_aubps_ecc_sec_flag_int_clr        = &H0
        write_spum_creaes_ecc_ded_flag_int_clr_value = &H0
        flag_spum_creaes_ecc_ded_flag_int_clr        = &H0
        write_spum_creaes_ecc_sec_flag_int_clr_value = &H0
        flag_spum_creaes_ecc_sec_flag_int_clr        = &H0
        write_spum_crbps_ecc_ded_flag_int_clr_value = &H0
        flag_spum_crbps_ecc_ded_flag_int_clr        = &H0
        write_spum_crbps_ecc_sec_flag_int_clr_value = &H0
        flag_spum_crbps_ecc_sec_flag_int_clr        = &H0
        write_spum_pafifo_ecc_ded_flag_int_clr_value = &H0
        flag_spum_pafifo_ecc_ded_flag_int_clr        = &H0
        write_spum_pafifo_ecc_sec_flag_int_clr_value = &H0
        flag_spum_pafifo_ecc_sec_flag_int_clr        = &H0
        write_spum_pasctx_ecc_ded_flag_int_clr_value = &H0
        flag_spum_pasctx_ecc_ded_flag_int_clr        = &H0
        write_spum_pasctx_ecc_sec_flag_int_clr_value = &H0
        flag_spum_pasctx_ecc_sec_flag_int_clr        = &H0
        write_spum_ppsupdt_ecc_ded_flag_int_clr_value = &H0
        flag_spum_ppsupdt_ecc_ded_flag_int_clr        = &H0
        write_spum_ppsupdt_ecc_sec_flag_int_clr_value = &H0
        flag_spum_ppsupdt_ecc_sec_flag_int_clr        = &H0
        write_pka_opp_ecc_ded_flag_int_clr_value = &H0
        flag_pka_opp_ecc_ded_flag_int_clr        = &H0
        write_pka_opp_ecc_sec_flag_int_clr_value = &H0
        flag_pka_opp_ecc_sec_flag_int_clr        = &H0
        write_pka_lir1_ecc_ded_flag_int_clr_value = &H0
        flag_pka_lir1_ecc_ded_flag_int_clr        = &H0
        write_pka_lir1_ecc_sec_flag_int_clr_value = &H0
        flag_pka_lir1_ecc_sec_flag_int_clr        = &H0
        write_pka_lir0_ecc_ded_flag_int_clr_value = &H0
        flag_pka_lir0_ecc_ded_flag_int_clr        = &H0
        write_pka_lir0_ecc_sec_flag_int_clr_value = &H0
        flag_pka_lir0_ecc_sec_flag_int_clr        = &H0
        write_dmem_ecc_ded_flag_int_clr_value = &H0
        flag_dmem_ecc_ded_flag_int_clr        = &H0
        write_dmem_ecc_sec_flag_int_clr_value = &H0
        flag_dmem_ecc_sec_flag_int_clr        = &H0
        write_imem_ecc_ded_flag_int_clr_value = &H0
        flag_imem_ecc_ded_flag_int_clr        = &H0
        write_imem_ecc_sec_flag_int_clr_value = &H0
        flag_imem_ecc_sec_flag_int_clr        = &H0
        write_sram_ecc_ded_flag_int_clr_value = &H0
        flag_sram_ecc_ded_flag_int_clr        = &H0
        write_sram_ecc_sec_flag_int_clr_value = &H0
        flag_sram_ecc_sec_flag_int_clr        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_init_mem
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' dmem_trigger_mem_init                      [5:5]            get_dmem_trigger_mem_init
''                                                             set_dmem_trigger_mem_init
''                                                             read_dmem_trigger_mem_init
''                                                             write_dmem_trigger_mem_init
''---------------------------------------------------------------------------------
'' dmem_done_mem_init                         [4:4]            get_dmem_done_mem_init
''                                                             set_dmem_done_mem_init
''                                                             read_dmem_done_mem_init
''                                                             write_dmem_done_mem_init
''---------------------------------------------------------------------------------
'' imem_trigger_mem_init                      [3:3]            get_imem_trigger_mem_init
''                                                             set_imem_trigger_mem_init
''                                                             read_imem_trigger_mem_init
''                                                             write_imem_trigger_mem_init
''---------------------------------------------------------------------------------
'' imem_done_mem_init                         [2:2]            get_imem_done_mem_init
''                                                             set_imem_done_mem_init
''                                                             read_imem_done_mem_init
''                                                             write_imem_done_mem_init
''---------------------------------------------------------------------------------
'' sram_trigger_mem_init                      [1:1]            get_sram_trigger_mem_init
''                                                             set_sram_trigger_mem_init
''                                                             read_sram_trigger_mem_init
''                                                             write_sram_trigger_mem_init
''---------------------------------------------------------------------------------
'' sram_done_mem_init                         [0:0]            get_sram_done_mem_init
''                                                             set_sram_done_mem_init
''                                                             read_sram_done_mem_init
''                                                             write_sram_done_mem_init
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_init_mem
    Private write_dmem_trigger_mem_init_value
    Private read_dmem_trigger_mem_init_value
    Private flag_dmem_trigger_mem_init
    Private write_dmem_done_mem_init_value
    Private read_dmem_done_mem_init_value
    Private flag_dmem_done_mem_init
    Private write_imem_trigger_mem_init_value
    Private read_imem_trigger_mem_init_value
    Private flag_imem_trigger_mem_init
    Private write_imem_done_mem_init_value
    Private read_imem_done_mem_init_value
    Private flag_imem_done_mem_init
    Private write_sram_trigger_mem_init_value
    Private read_sram_trigger_mem_init_value
    Private flag_sram_trigger_mem_init
    Private write_sram_done_mem_init_value
    Private read_sram_done_mem_init_value
    Private flag_sram_done_mem_init

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H2c8
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_dmem_trigger_mem_init
        get_dmem_trigger_mem_init = read_dmem_trigger_mem_init_value
    End Property

    Property Let set_dmem_trigger_mem_init(aData)
        write_dmem_trigger_mem_init_value = aData
        flag_dmem_trigger_mem_init        = &H1
    End Property

    Property Get read_dmem_trigger_mem_init
        read
        read_dmem_trigger_mem_init = read_dmem_trigger_mem_init_value
    End Property

    Property Let write_dmem_trigger_mem_init(aData)
        set_dmem_trigger_mem_init = aData
        write
    End Property

    Property Get get_dmem_done_mem_init
        get_dmem_done_mem_init = read_dmem_done_mem_init_value
    End Property

    Property Let set_dmem_done_mem_init(aData)
        write_dmem_done_mem_init_value = aData
        flag_dmem_done_mem_init        = &H1
    End Property

    Property Get read_dmem_done_mem_init
        read
        read_dmem_done_mem_init = read_dmem_done_mem_init_value
    End Property

    Property Let write_dmem_done_mem_init(aData)
        set_dmem_done_mem_init = aData
        write
    End Property

    Property Get get_imem_trigger_mem_init
        get_imem_trigger_mem_init = read_imem_trigger_mem_init_value
    End Property

    Property Let set_imem_trigger_mem_init(aData)
        write_imem_trigger_mem_init_value = aData
        flag_imem_trigger_mem_init        = &H1
    End Property

    Property Get read_imem_trigger_mem_init
        read
        read_imem_trigger_mem_init = read_imem_trigger_mem_init_value
    End Property

    Property Let write_imem_trigger_mem_init(aData)
        set_imem_trigger_mem_init = aData
        write
    End Property

    Property Get get_imem_done_mem_init
        get_imem_done_mem_init = read_imem_done_mem_init_value
    End Property

    Property Let set_imem_done_mem_init(aData)
        write_imem_done_mem_init_value = aData
        flag_imem_done_mem_init        = &H1
    End Property

    Property Get read_imem_done_mem_init
        read
        read_imem_done_mem_init = read_imem_done_mem_init_value
    End Property

    Property Let write_imem_done_mem_init(aData)
        set_imem_done_mem_init = aData
        write
    End Property

    Property Get get_sram_trigger_mem_init
        get_sram_trigger_mem_init = read_sram_trigger_mem_init_value
    End Property

    Property Let set_sram_trigger_mem_init(aData)
        write_sram_trigger_mem_init_value = aData
        flag_sram_trigger_mem_init        = &H1
    End Property

    Property Get read_sram_trigger_mem_init
        read
        read_sram_trigger_mem_init = read_sram_trigger_mem_init_value
    End Property

    Property Let write_sram_trigger_mem_init(aData)
        set_sram_trigger_mem_init = aData
        write
    End Property

    Property Get get_sram_done_mem_init
        get_sram_done_mem_init = read_sram_done_mem_init_value
    End Property

    Property Let set_sram_done_mem_init(aData)
        write_sram_done_mem_init_value = aData
        flag_sram_done_mem_init        = &H1
    End Property

    Property Get read_sram_done_mem_init
        read
        read_sram_done_mem_init = read_sram_done_mem_init_value
    End Property

    Property Let write_sram_done_mem_init(aData)
        set_sram_done_mem_init = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_dmem_trigger_mem_init_value = rightShift(data_low, 5) and &H1
        read_dmem_done_mem_init_value = rightShift(data_low, 4) and &H1
        read_imem_trigger_mem_init_value = rightShift(data_low, 3) and &H1
        read_imem_done_mem_init_value = rightShift(data_low, 2) and &H1
        read_sram_trigger_mem_init_value = rightShift(data_low, 1) and &H1
        sram_done_mem_init_mask = &H1
        if data_low > LONG_MAX then
            if sram_done_mem_init_mask = mask then
                read_sram_done_mem_init_value = data_low
            else
                read_sram_done_mem_init_value = (data_low - H8000_0000) and sram_done_mem_init_mask
            end If
        else
            read_sram_done_mem_init_value = data_low and sram_done_mem_init_mask
        end If

    End Sub

    Sub write
        If flag_dmem_trigger_mem_init = &H0 or flag_dmem_done_mem_init = &H0 or flag_imem_trigger_mem_init = &H0 or flag_imem_done_mem_init = &H0 or flag_sram_trigger_mem_init = &H0 or flag_sram_done_mem_init = &H0 Then read
        If flag_dmem_trigger_mem_init = &H0 Then write_dmem_trigger_mem_init_value = get_dmem_trigger_mem_init
        If flag_dmem_done_mem_init = &H0 Then write_dmem_done_mem_init_value = get_dmem_done_mem_init
        If flag_imem_trigger_mem_init = &H0 Then write_imem_trigger_mem_init_value = get_imem_trigger_mem_init
        If flag_imem_done_mem_init = &H0 Then write_imem_done_mem_init_value = get_imem_done_mem_init
        If flag_sram_trigger_mem_init = &H0 Then write_sram_trigger_mem_init_value = get_sram_trigger_mem_init
        If flag_sram_done_mem_init = &H0 Then write_sram_done_mem_init_value = get_sram_done_mem_init

        regValue = leftShift((write_dmem_trigger_mem_init_value and &H1), 5) + leftShift((write_dmem_done_mem_init_value and &H1), 4) + leftShift((write_imem_trigger_mem_init_value and &H1), 3) + leftShift((write_imem_done_mem_init_value and &H1), 2) + leftShift((write_sram_trigger_mem_init_value and &H1), 1) + leftShift((write_sram_done_mem_init_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_dmem_trigger_mem_init_value = rightShift(data_low, 5) and &H1
        read_dmem_done_mem_init_value = rightShift(data_low, 4) and &H1
        read_imem_trigger_mem_init_value = rightShift(data_low, 3) and &H1
        read_imem_done_mem_init_value = rightShift(data_low, 2) and &H1
        read_sram_trigger_mem_init_value = rightShift(data_low, 1) and &H1
        sram_done_mem_init_mask = &H1
        if data_low > LONG_MAX then
            if sram_done_mem_init_mask = mask then
                read_sram_done_mem_init_value = data_low
            else
                read_sram_done_mem_init_value = (data_low - H8000_0000) and sram_done_mem_init_mask
            end If
        else
            read_sram_done_mem_init_value = data_low and sram_done_mem_init_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_dmem_trigger_mem_init_value = &H0
        flag_dmem_trigger_mem_init        = &H0
        write_dmem_done_mem_init_value = &H0
        flag_dmem_done_mem_init        = &H0
        write_imem_trigger_mem_init_value = &H0
        flag_imem_trigger_mem_init        = &H0
        write_imem_done_mem_init_value = &H0
        flag_imem_done_mem_init        = &H0
        write_sram_trigger_mem_init_value = &H0
        flag_sram_trigger_mem_init        = &H0
        write_sram_done_mem_init_value = &H0
        flag_sram_done_mem_init        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_spare_reg0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' spare_reg0                                 [31:0]           get_spare_reg0
''                                                             set_spare_reg0
''                                                             read_spare_reg0
''                                                             write_spare_reg0
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_spare_reg0
    Private write_spare_reg0_value
    Private read_spare_reg0_value
    Private flag_spare_reg0

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H2cc
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_spare_reg0
        get_spare_reg0 = read_spare_reg0_value
    End Property

    Property Let set_spare_reg0(aData)
        write_spare_reg0_value = aData
        flag_spare_reg0        = &H1
    End Property

    Property Get read_spare_reg0
        read
        read_spare_reg0 = read_spare_reg0_value
    End Property

    Property Let write_spare_reg0(aData)
        set_spare_reg0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        spare_reg0_mask = &Hffffffff
        if data_low > LONG_MAX then
            if spare_reg0_mask = mask then
                read_spare_reg0_value = data_low
            else
                read_spare_reg0_value = (data_low - H8000_0000) and spare_reg0_mask
            end If
        else
            read_spare_reg0_value = data_low and spare_reg0_mask
        end If

    End Sub

    Sub write
        If flag_spare_reg0 = &H0 Then read
        If flag_spare_reg0 = &H0 Then write_spare_reg0_value = get_spare_reg0

        regValue = leftShift(write_spare_reg0_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        spare_reg0_mask = &Hffffffff
        if data_low > LONG_MAX then
            if spare_reg0_mask = mask then
                read_spare_reg0_value = data_low
            else
                read_spare_reg0_value = (data_low - H8000_0000) and spare_reg0_mask
            end If
        else
            read_spare_reg0_value = data_low and spare_reg0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_spare_reg0_value = &H0
        flag_spare_reg0        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_spare_reg1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' spare_reg1                                 [31:0]           get_spare_reg1
''                                                             set_spare_reg1
''                                                             read_spare_reg1
''                                                             write_spare_reg1
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_spare_reg1
    Private write_spare_reg1_value
    Private read_spare_reg1_value
    Private flag_spare_reg1

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H2d0
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_spare_reg1
        get_spare_reg1 = read_spare_reg1_value
    End Property

    Property Let set_spare_reg1(aData)
        write_spare_reg1_value = aData
        flag_spare_reg1        = &H1
    End Property

    Property Get read_spare_reg1
        read
        read_spare_reg1 = read_spare_reg1_value
    End Property

    Property Let write_spare_reg1(aData)
        set_spare_reg1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        spare_reg1_mask = &Hffffffff
        if data_low > LONG_MAX then
            if spare_reg1_mask = mask then
                read_spare_reg1_value = data_low
            else
                read_spare_reg1_value = (data_low - H8000_0000) and spare_reg1_mask
            end If
        else
            read_spare_reg1_value = data_low and spare_reg1_mask
        end If

    End Sub

    Sub write
        If flag_spare_reg1 = &H0 Then read
        If flag_spare_reg1 = &H0 Then write_spare_reg1_value = get_spare_reg1

        regValue = leftShift(write_spare_reg1_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        spare_reg1_mask = &Hffffffff
        if data_low > LONG_MAX then
            if spare_reg1_mask = mask then
                read_spare_reg1_value = data_low
            else
                read_spare_reg1_value = (data_low - H8000_0000) and spare_reg1_mask
            end If
        else
            read_spare_reg1_value = data_low and spare_reg1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_spare_reg1_value = &H0
        flag_spare_reg1        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_spare_reg2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' spare_reg2                                 [31:0]           get_spare_reg2
''                                                             set_spare_reg2
''                                                             read_spare_reg2
''                                                             write_spare_reg2
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_spare_reg2
    Private write_spare_reg2_value
    Private read_spare_reg2_value
    Private flag_spare_reg2

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H2d4
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_spare_reg2
        get_spare_reg2 = read_spare_reg2_value
    End Property

    Property Let set_spare_reg2(aData)
        write_spare_reg2_value = aData
        flag_spare_reg2        = &H1
    End Property

    Property Get read_spare_reg2
        read
        read_spare_reg2 = read_spare_reg2_value
    End Property

    Property Let write_spare_reg2(aData)
        set_spare_reg2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        spare_reg2_mask = &Hffffffff
        if data_low > LONG_MAX then
            if spare_reg2_mask = mask then
                read_spare_reg2_value = data_low
            else
                read_spare_reg2_value = (data_low - H8000_0000) and spare_reg2_mask
            end If
        else
            read_spare_reg2_value = data_low and spare_reg2_mask
        end If

    End Sub

    Sub write
        If flag_spare_reg2 = &H0 Then read
        If flag_spare_reg2 = &H0 Then write_spare_reg2_value = get_spare_reg2

        regValue = leftShift(write_spare_reg2_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        spare_reg2_mask = &Hffffffff
        if data_low > LONG_MAX then
            if spare_reg2_mask = mask then
                read_spare_reg2_value = data_low
            else
                read_spare_reg2_value = (data_low - H8000_0000) and spare_reg2_mask
            end If
        else
            read_spare_reg2_value = data_low and spare_reg2_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_spare_reg2_value = &H0
        flag_spare_reg2        = &H0
    End Sub
End Class


'' @REGISTER : HSM_MISC_spare_reg3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' spare_reg3                                 [31:0]           get_spare_reg3
''                                                             set_spare_reg3
''                                                             read_spare_reg3
''                                                             write_spare_reg3
''---------------------------------------------------------------------------------
Class REGISTER_HSM_MISC_spare_reg3
    Private write_spare_reg3_value
    Private read_spare_reg3_value
    Private flag_spare_reg3

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H2d8
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_spare_reg3
        get_spare_reg3 = read_spare_reg3_value
    End Property

    Property Let set_spare_reg3(aData)
        write_spare_reg3_value = aData
        flag_spare_reg3        = &H1
    End Property

    Property Get read_spare_reg3
        read
        read_spare_reg3 = read_spare_reg3_value
    End Property

    Property Let write_spare_reg3(aData)
        set_spare_reg3 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        spare_reg3_mask = &Hffffffff
        if data_low > LONG_MAX then
            if spare_reg3_mask = mask then
                read_spare_reg3_value = data_low
            else
                read_spare_reg3_value = (data_low - H8000_0000) and spare_reg3_mask
            end If
        else
            read_spare_reg3_value = data_low and spare_reg3_mask
        end If

    End Sub

    Sub write
        If flag_spare_reg3 = &H0 Then read
        If flag_spare_reg3 = &H0 Then write_spare_reg3_value = get_spare_reg3

        regValue = leftShift(write_spare_reg3_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        spare_reg3_mask = &Hffffffff
        if data_low > LONG_MAX then
            if spare_reg3_mask = mask then
                read_spare_reg3_value = data_low
            else
                read_spare_reg3_value = (data_low - H8000_0000) and spare_reg3_mask
            end If
        else
            read_spare_reg3_value = data_low and spare_reg3_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_spare_reg3_value = &H0
        flag_spare_reg3        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class HSM_MISC_INSTANCE

    Public clock_gating_control
    Public block_reset
    Public proc_mem_tm
    Public misc_mem_tm1
    Public misc_mem_tm2
    Public misc_mem_ctrl
    Public spum_misc_cfg_reg
    Public rng_misc_cfg_reg
    Public link_authenticaton_key_port0_0a
    Public link_authenticaton_key_port0_0b
    Public link_authenticaton_key_port0_0c
    Public link_authenticaton_key_port0_0d
    Public link_authenticaton_key_port0_0e
    Public link_authenticaton_key_port0_1a
    Public link_authenticaton_key_port0_1b
    Public link_authenticaton_key_port0_1c
    Public link_authenticaton_key_port0_1d
    Public link_authenticaton_key_port0_1e
    Public link_authenticaton_key_port0_2a
    Public link_authenticaton_key_port0_2b
    Public link_authenticaton_key_port0_2c
    Public link_authenticaton_key_port0_2d
    Public link_authenticaton_key_port0_2e
    Public link_authenticaton_key_port0_3a
    Public link_authenticaton_key_port0_3b
    Public link_authenticaton_key_port0_3c
    Public link_authenticaton_key_port0_3d
    Public link_authenticaton_key_port0_3e
    Public link_authenticaton_key_port1_0a
    Public link_authenticaton_key_port1_0b
    Public link_authenticaton_key_port1_0c
    Public link_authenticaton_key_port1_0d
    Public link_authenticaton_key_port1_0e
    Public link_authenticaton_key_port1_1a
    Public link_authenticaton_key_port1_1b
    Public link_authenticaton_key_port1_1c
    Public link_authenticaton_key_port1_1d
    Public link_authenticaton_key_port1_1e
    Public link_authenticaton_key_port1_2a
    Public link_authenticaton_key_port1_2b
    Public link_authenticaton_key_port1_2c
    Public link_authenticaton_key_port1_2d
    Public link_authenticaton_key_port1_2e
    Public link_authenticaton_key_port1_3a
    Public link_authenticaton_key_port1_3b
    Public link_authenticaton_key_port1_3c
    Public link_authenticaton_key_port1_3d
    Public link_authenticaton_key_port1_3e
    Public link_authenticaton_key_port2_0a
    Public link_authenticaton_key_port2_0b
    Public link_authenticaton_key_port2_0c
    Public link_authenticaton_key_port2_0d
    Public link_authenticaton_key_port2_0e
    Public link_authenticaton_key_port2_1a
    Public link_authenticaton_key_port2_1b
    Public link_authenticaton_key_port2_1c
    Public link_authenticaton_key_port2_1d
    Public link_authenticaton_key_port2_1e
    Public link_authenticaton_key_port2_2a
    Public link_authenticaton_key_port2_2b
    Public link_authenticaton_key_port2_2c
    Public link_authenticaton_key_port2_2d
    Public link_authenticaton_key_port2_2e
    Public link_authenticaton_key_port2_3a
    Public link_authenticaton_key_port2_3b
    Public link_authenticaton_key_port2_3c
    Public link_authenticaton_key_port2_3d
    Public link_authenticaton_key_port2_3e
    Public link_authenticaton_key_port3_0a
    Public link_authenticaton_key_port3_0b
    Public link_authenticaton_key_port3_0c
    Public link_authenticaton_key_port3_0d
    Public link_authenticaton_key_port3_0e
    Public link_authenticaton_key_port3_1a
    Public link_authenticaton_key_port3_1b
    Public link_authenticaton_key_port3_1c
    Public link_authenticaton_key_port3_1d
    Public link_authenticaton_key_port3_1e
    Public link_authenticaton_key_port3_2a
    Public link_authenticaton_key_port3_2b
    Public link_authenticaton_key_port3_2c
    Public link_authenticaton_key_port3_2d
    Public link_authenticaton_key_port3_2e
    Public link_authenticaton_key_port3_3a
    Public link_authenticaton_key_port3_3b
    Public link_authenticaton_key_port3_3c
    Public link_authenticaton_key_port3_3d
    Public link_authenticaton_key_port3_3e
    Public link_authenticaton_key_port4_0a
    Public link_authenticaton_key_port4_0b
    Public link_authenticaton_key_port4_0c
    Public link_authenticaton_key_port4_0d
    Public link_authenticaton_key_port4_0e
    Public link_authenticaton_key_port4_1a
    Public link_authenticaton_key_port4_1b
    Public link_authenticaton_key_port4_1c
    Public link_authenticaton_key_port4_1d
    Public link_authenticaton_key_port4_1e
    Public link_authenticaton_key_port4_2a
    Public link_authenticaton_key_port4_2b
    Public link_authenticaton_key_port4_2c
    Public link_authenticaton_key_port4_2d
    Public link_authenticaton_key_port4_2e
    Public link_authenticaton_key_port4_3a
    Public link_authenticaton_key_port4_3b
    Public link_authenticaton_key_port4_3c
    Public link_authenticaton_key_port4_3d
    Public link_authenticaton_key_port4_3e
    Public link_authenticaton_key_port5_0a
    Public link_authenticaton_key_port5_0b
    Public link_authenticaton_key_port5_0c
    Public link_authenticaton_key_port5_0d
    Public link_authenticaton_key_port5_0e
    Public link_authenticaton_key_port5_1a
    Public link_authenticaton_key_port5_1b
    Public link_authenticaton_key_port5_1c
    Public link_authenticaton_key_port5_1d
    Public link_authenticaton_key_port5_1e
    Public link_authenticaton_key_port5_2a
    Public link_authenticaton_key_port5_2b
    Public link_authenticaton_key_port5_2c
    Public link_authenticaton_key_port5_2d
    Public link_authenticaton_key_port5_2e
    Public link_authenticaton_key_port5_3a
    Public link_authenticaton_key_port5_3b
    Public link_authenticaton_key_port5_3c
    Public link_authenticaton_key_port5_3d
    Public link_authenticaton_key_port5_3e
    Public interrupt
    Public interrupt_en
    Public interrupt_clear
    Public ahb_slave_timout_mon_interrupt
    Public ahb_slave_timout_mon_interrupt_en
    Public ahb_slave_timout_mon_interrupt_clr
    Public disable_ahb_slave_timout_mon
    Public ecc_interrupt
    Public ecc_interrupt_en_reg
    Public ecc_interrupt_clr_reg
    Public init_mem
    Public spare_reg0
    Public spare_reg1
    Public spare_reg2
    Public spare_reg3


    Public default function Init(aBaseAddr)
        Set clock_gating_control = (New REGISTER_HSM_MISC_clock_gating_control)(aBaseAddr, 32)
        Set block_reset = (New REGISTER_HSM_MISC_block_reset)(aBaseAddr, 32)
        Set proc_mem_tm = (New REGISTER_HSM_MISC_proc_mem_tm)(aBaseAddr, 32)
        Set misc_mem_tm1 = (New REGISTER_HSM_MISC_misc_mem_tm1)(aBaseAddr, 32)
        Set misc_mem_tm2 = (New REGISTER_HSM_MISC_misc_mem_tm2)(aBaseAddr, 32)
        Set misc_mem_ctrl = (New REGISTER_HSM_MISC_misc_mem_ctrl)(aBaseAddr, 32)
        Set spum_misc_cfg_reg = (New REGISTER_HSM_MISC_spum_misc_cfg_reg)(aBaseAddr, 32)
        Set rng_misc_cfg_reg = (New REGISTER_HSM_MISC_rng_misc_cfg_reg)(aBaseAddr, 32)
        Set link_authenticaton_key_port0_0a = (New REGISTER_HSM_MISC_link_authenticaton_key_port0_0a)(aBaseAddr, 32)
        Set link_authenticaton_key_port0_0b = (New REGISTER_HSM_MISC_link_authenticaton_key_port0_0b)(aBaseAddr, 32)
        Set link_authenticaton_key_port0_0c = (New REGISTER_HSM_MISC_link_authenticaton_key_port0_0c)(aBaseAddr, 32)
        Set link_authenticaton_key_port0_0d = (New REGISTER_HSM_MISC_link_authenticaton_key_port0_0d)(aBaseAddr, 32)
        Set link_authenticaton_key_port0_0e = (New REGISTER_HSM_MISC_link_authenticaton_key_port0_0e)(aBaseAddr, 32)
        Set link_authenticaton_key_port0_1a = (New REGISTER_HSM_MISC_link_authenticaton_key_port0_1a)(aBaseAddr, 32)
        Set link_authenticaton_key_port0_1b = (New REGISTER_HSM_MISC_link_authenticaton_key_port0_1b)(aBaseAddr, 32)
        Set link_authenticaton_key_port0_1c = (New REGISTER_HSM_MISC_link_authenticaton_key_port0_1c)(aBaseAddr, 32)
        Set link_authenticaton_key_port0_1d = (New REGISTER_HSM_MISC_link_authenticaton_key_port0_1d)(aBaseAddr, 32)
        Set link_authenticaton_key_port0_1e = (New REGISTER_HSM_MISC_link_authenticaton_key_port0_1e)(aBaseAddr, 32)
        Set link_authenticaton_key_port0_2a = (New REGISTER_HSM_MISC_link_authenticaton_key_port0_2a)(aBaseAddr, 32)
        Set link_authenticaton_key_port0_2b = (New REGISTER_HSM_MISC_link_authenticaton_key_port0_2b)(aBaseAddr, 32)
        Set link_authenticaton_key_port0_2c = (New REGISTER_HSM_MISC_link_authenticaton_key_port0_2c)(aBaseAddr, 32)
        Set link_authenticaton_key_port0_2d = (New REGISTER_HSM_MISC_link_authenticaton_key_port0_2d)(aBaseAddr, 32)
        Set link_authenticaton_key_port0_2e = (New REGISTER_HSM_MISC_link_authenticaton_key_port0_2e)(aBaseAddr, 32)
        Set link_authenticaton_key_port0_3a = (New REGISTER_HSM_MISC_link_authenticaton_key_port0_3a)(aBaseAddr, 32)
        Set link_authenticaton_key_port0_3b = (New REGISTER_HSM_MISC_link_authenticaton_key_port0_3b)(aBaseAddr, 32)
        Set link_authenticaton_key_port0_3c = (New REGISTER_HSM_MISC_link_authenticaton_key_port0_3c)(aBaseAddr, 32)
        Set link_authenticaton_key_port0_3d = (New REGISTER_HSM_MISC_link_authenticaton_key_port0_3d)(aBaseAddr, 32)
        Set link_authenticaton_key_port0_3e = (New REGISTER_HSM_MISC_link_authenticaton_key_port0_3e)(aBaseAddr, 32)
        Set link_authenticaton_key_port1_0a = (New REGISTER_HSM_MISC_link_authenticaton_key_port1_0a)(aBaseAddr, 32)
        Set link_authenticaton_key_port1_0b = (New REGISTER_HSM_MISC_link_authenticaton_key_port1_0b)(aBaseAddr, 32)
        Set link_authenticaton_key_port1_0c = (New REGISTER_HSM_MISC_link_authenticaton_key_port1_0c)(aBaseAddr, 32)
        Set link_authenticaton_key_port1_0d = (New REGISTER_HSM_MISC_link_authenticaton_key_port1_0d)(aBaseAddr, 32)
        Set link_authenticaton_key_port1_0e = (New REGISTER_HSM_MISC_link_authenticaton_key_port1_0e)(aBaseAddr, 32)
        Set link_authenticaton_key_port1_1a = (New REGISTER_HSM_MISC_link_authenticaton_key_port1_1a)(aBaseAddr, 32)
        Set link_authenticaton_key_port1_1b = (New REGISTER_HSM_MISC_link_authenticaton_key_port1_1b)(aBaseAddr, 32)
        Set link_authenticaton_key_port1_1c = (New REGISTER_HSM_MISC_link_authenticaton_key_port1_1c)(aBaseAddr, 32)
        Set link_authenticaton_key_port1_1d = (New REGISTER_HSM_MISC_link_authenticaton_key_port1_1d)(aBaseAddr, 32)
        Set link_authenticaton_key_port1_1e = (New REGISTER_HSM_MISC_link_authenticaton_key_port1_1e)(aBaseAddr, 32)
        Set link_authenticaton_key_port1_2a = (New REGISTER_HSM_MISC_link_authenticaton_key_port1_2a)(aBaseAddr, 32)
        Set link_authenticaton_key_port1_2b = (New REGISTER_HSM_MISC_link_authenticaton_key_port1_2b)(aBaseAddr, 32)
        Set link_authenticaton_key_port1_2c = (New REGISTER_HSM_MISC_link_authenticaton_key_port1_2c)(aBaseAddr, 32)
        Set link_authenticaton_key_port1_2d = (New REGISTER_HSM_MISC_link_authenticaton_key_port1_2d)(aBaseAddr, 32)
        Set link_authenticaton_key_port1_2e = (New REGISTER_HSM_MISC_link_authenticaton_key_port1_2e)(aBaseAddr, 32)
        Set link_authenticaton_key_port1_3a = (New REGISTER_HSM_MISC_link_authenticaton_key_port1_3a)(aBaseAddr, 32)
        Set link_authenticaton_key_port1_3b = (New REGISTER_HSM_MISC_link_authenticaton_key_port1_3b)(aBaseAddr, 32)
        Set link_authenticaton_key_port1_3c = (New REGISTER_HSM_MISC_link_authenticaton_key_port1_3c)(aBaseAddr, 32)
        Set link_authenticaton_key_port1_3d = (New REGISTER_HSM_MISC_link_authenticaton_key_port1_3d)(aBaseAddr, 32)
        Set link_authenticaton_key_port1_3e = (New REGISTER_HSM_MISC_link_authenticaton_key_port1_3e)(aBaseAddr, 32)
        Set link_authenticaton_key_port2_0a = (New REGISTER_HSM_MISC_link_authenticaton_key_port2_0a)(aBaseAddr, 32)
        Set link_authenticaton_key_port2_0b = (New REGISTER_HSM_MISC_link_authenticaton_key_port2_0b)(aBaseAddr, 32)
        Set link_authenticaton_key_port2_0c = (New REGISTER_HSM_MISC_link_authenticaton_key_port2_0c)(aBaseAddr, 32)
        Set link_authenticaton_key_port2_0d = (New REGISTER_HSM_MISC_link_authenticaton_key_port2_0d)(aBaseAddr, 32)
        Set link_authenticaton_key_port2_0e = (New REGISTER_HSM_MISC_link_authenticaton_key_port2_0e)(aBaseAddr, 32)
        Set link_authenticaton_key_port2_1a = (New REGISTER_HSM_MISC_link_authenticaton_key_port2_1a)(aBaseAddr, 32)
        Set link_authenticaton_key_port2_1b = (New REGISTER_HSM_MISC_link_authenticaton_key_port2_1b)(aBaseAddr, 32)
        Set link_authenticaton_key_port2_1c = (New REGISTER_HSM_MISC_link_authenticaton_key_port2_1c)(aBaseAddr, 32)
        Set link_authenticaton_key_port2_1d = (New REGISTER_HSM_MISC_link_authenticaton_key_port2_1d)(aBaseAddr, 32)
        Set link_authenticaton_key_port2_1e = (New REGISTER_HSM_MISC_link_authenticaton_key_port2_1e)(aBaseAddr, 32)
        Set link_authenticaton_key_port2_2a = (New REGISTER_HSM_MISC_link_authenticaton_key_port2_2a)(aBaseAddr, 32)
        Set link_authenticaton_key_port2_2b = (New REGISTER_HSM_MISC_link_authenticaton_key_port2_2b)(aBaseAddr, 32)
        Set link_authenticaton_key_port2_2c = (New REGISTER_HSM_MISC_link_authenticaton_key_port2_2c)(aBaseAddr, 32)
        Set link_authenticaton_key_port2_2d = (New REGISTER_HSM_MISC_link_authenticaton_key_port2_2d)(aBaseAddr, 32)
        Set link_authenticaton_key_port2_2e = (New REGISTER_HSM_MISC_link_authenticaton_key_port2_2e)(aBaseAddr, 32)
        Set link_authenticaton_key_port2_3a = (New REGISTER_HSM_MISC_link_authenticaton_key_port2_3a)(aBaseAddr, 32)
        Set link_authenticaton_key_port2_3b = (New REGISTER_HSM_MISC_link_authenticaton_key_port2_3b)(aBaseAddr, 32)
        Set link_authenticaton_key_port2_3c = (New REGISTER_HSM_MISC_link_authenticaton_key_port2_3c)(aBaseAddr, 32)
        Set link_authenticaton_key_port2_3d = (New REGISTER_HSM_MISC_link_authenticaton_key_port2_3d)(aBaseAddr, 32)
        Set link_authenticaton_key_port2_3e = (New REGISTER_HSM_MISC_link_authenticaton_key_port2_3e)(aBaseAddr, 32)
        Set link_authenticaton_key_port3_0a = (New REGISTER_HSM_MISC_link_authenticaton_key_port3_0a)(aBaseAddr, 32)
        Set link_authenticaton_key_port3_0b = (New REGISTER_HSM_MISC_link_authenticaton_key_port3_0b)(aBaseAddr, 32)
        Set link_authenticaton_key_port3_0c = (New REGISTER_HSM_MISC_link_authenticaton_key_port3_0c)(aBaseAddr, 32)
        Set link_authenticaton_key_port3_0d = (New REGISTER_HSM_MISC_link_authenticaton_key_port3_0d)(aBaseAddr, 32)
        Set link_authenticaton_key_port3_0e = (New REGISTER_HSM_MISC_link_authenticaton_key_port3_0e)(aBaseAddr, 32)
        Set link_authenticaton_key_port3_1a = (New REGISTER_HSM_MISC_link_authenticaton_key_port3_1a)(aBaseAddr, 32)
        Set link_authenticaton_key_port3_1b = (New REGISTER_HSM_MISC_link_authenticaton_key_port3_1b)(aBaseAddr, 32)
        Set link_authenticaton_key_port3_1c = (New REGISTER_HSM_MISC_link_authenticaton_key_port3_1c)(aBaseAddr, 32)
        Set link_authenticaton_key_port3_1d = (New REGISTER_HSM_MISC_link_authenticaton_key_port3_1d)(aBaseAddr, 32)
        Set link_authenticaton_key_port3_1e = (New REGISTER_HSM_MISC_link_authenticaton_key_port3_1e)(aBaseAddr, 32)
        Set link_authenticaton_key_port3_2a = (New REGISTER_HSM_MISC_link_authenticaton_key_port3_2a)(aBaseAddr, 32)
        Set link_authenticaton_key_port3_2b = (New REGISTER_HSM_MISC_link_authenticaton_key_port3_2b)(aBaseAddr, 32)
        Set link_authenticaton_key_port3_2c = (New REGISTER_HSM_MISC_link_authenticaton_key_port3_2c)(aBaseAddr, 32)
        Set link_authenticaton_key_port3_2d = (New REGISTER_HSM_MISC_link_authenticaton_key_port3_2d)(aBaseAddr, 32)
        Set link_authenticaton_key_port3_2e = (New REGISTER_HSM_MISC_link_authenticaton_key_port3_2e)(aBaseAddr, 32)
        Set link_authenticaton_key_port3_3a = (New REGISTER_HSM_MISC_link_authenticaton_key_port3_3a)(aBaseAddr, 32)
        Set link_authenticaton_key_port3_3b = (New REGISTER_HSM_MISC_link_authenticaton_key_port3_3b)(aBaseAddr, 32)
        Set link_authenticaton_key_port3_3c = (New REGISTER_HSM_MISC_link_authenticaton_key_port3_3c)(aBaseAddr, 32)
        Set link_authenticaton_key_port3_3d = (New REGISTER_HSM_MISC_link_authenticaton_key_port3_3d)(aBaseAddr, 32)
        Set link_authenticaton_key_port3_3e = (New REGISTER_HSM_MISC_link_authenticaton_key_port3_3e)(aBaseAddr, 32)
        Set link_authenticaton_key_port4_0a = (New REGISTER_HSM_MISC_link_authenticaton_key_port4_0a)(aBaseAddr, 32)
        Set link_authenticaton_key_port4_0b = (New REGISTER_HSM_MISC_link_authenticaton_key_port4_0b)(aBaseAddr, 32)
        Set link_authenticaton_key_port4_0c = (New REGISTER_HSM_MISC_link_authenticaton_key_port4_0c)(aBaseAddr, 32)
        Set link_authenticaton_key_port4_0d = (New REGISTER_HSM_MISC_link_authenticaton_key_port4_0d)(aBaseAddr, 32)
        Set link_authenticaton_key_port4_0e = (New REGISTER_HSM_MISC_link_authenticaton_key_port4_0e)(aBaseAddr, 32)
        Set link_authenticaton_key_port4_1a = (New REGISTER_HSM_MISC_link_authenticaton_key_port4_1a)(aBaseAddr, 32)
        Set link_authenticaton_key_port4_1b = (New REGISTER_HSM_MISC_link_authenticaton_key_port4_1b)(aBaseAddr, 32)
        Set link_authenticaton_key_port4_1c = (New REGISTER_HSM_MISC_link_authenticaton_key_port4_1c)(aBaseAddr, 32)
        Set link_authenticaton_key_port4_1d = (New REGISTER_HSM_MISC_link_authenticaton_key_port4_1d)(aBaseAddr, 32)
        Set link_authenticaton_key_port4_1e = (New REGISTER_HSM_MISC_link_authenticaton_key_port4_1e)(aBaseAddr, 32)
        Set link_authenticaton_key_port4_2a = (New REGISTER_HSM_MISC_link_authenticaton_key_port4_2a)(aBaseAddr, 32)
        Set link_authenticaton_key_port4_2b = (New REGISTER_HSM_MISC_link_authenticaton_key_port4_2b)(aBaseAddr, 32)
        Set link_authenticaton_key_port4_2c = (New REGISTER_HSM_MISC_link_authenticaton_key_port4_2c)(aBaseAddr, 32)
        Set link_authenticaton_key_port4_2d = (New REGISTER_HSM_MISC_link_authenticaton_key_port4_2d)(aBaseAddr, 32)
        Set link_authenticaton_key_port4_2e = (New REGISTER_HSM_MISC_link_authenticaton_key_port4_2e)(aBaseAddr, 32)
        Set link_authenticaton_key_port4_3a = (New REGISTER_HSM_MISC_link_authenticaton_key_port4_3a)(aBaseAddr, 32)
        Set link_authenticaton_key_port4_3b = (New REGISTER_HSM_MISC_link_authenticaton_key_port4_3b)(aBaseAddr, 32)
        Set link_authenticaton_key_port4_3c = (New REGISTER_HSM_MISC_link_authenticaton_key_port4_3c)(aBaseAddr, 32)
        Set link_authenticaton_key_port4_3d = (New REGISTER_HSM_MISC_link_authenticaton_key_port4_3d)(aBaseAddr, 32)
        Set link_authenticaton_key_port4_3e = (New REGISTER_HSM_MISC_link_authenticaton_key_port4_3e)(aBaseAddr, 32)
        Set link_authenticaton_key_port5_0a = (New REGISTER_HSM_MISC_link_authenticaton_key_port5_0a)(aBaseAddr, 32)
        Set link_authenticaton_key_port5_0b = (New REGISTER_HSM_MISC_link_authenticaton_key_port5_0b)(aBaseAddr, 32)
        Set link_authenticaton_key_port5_0c = (New REGISTER_HSM_MISC_link_authenticaton_key_port5_0c)(aBaseAddr, 32)
        Set link_authenticaton_key_port5_0d = (New REGISTER_HSM_MISC_link_authenticaton_key_port5_0d)(aBaseAddr, 32)
        Set link_authenticaton_key_port5_0e = (New REGISTER_HSM_MISC_link_authenticaton_key_port5_0e)(aBaseAddr, 32)
        Set link_authenticaton_key_port5_1a = (New REGISTER_HSM_MISC_link_authenticaton_key_port5_1a)(aBaseAddr, 32)
        Set link_authenticaton_key_port5_1b = (New REGISTER_HSM_MISC_link_authenticaton_key_port5_1b)(aBaseAddr, 32)
        Set link_authenticaton_key_port5_1c = (New REGISTER_HSM_MISC_link_authenticaton_key_port5_1c)(aBaseAddr, 32)
        Set link_authenticaton_key_port5_1d = (New REGISTER_HSM_MISC_link_authenticaton_key_port5_1d)(aBaseAddr, 32)
        Set link_authenticaton_key_port5_1e = (New REGISTER_HSM_MISC_link_authenticaton_key_port5_1e)(aBaseAddr, 32)
        Set link_authenticaton_key_port5_2a = (New REGISTER_HSM_MISC_link_authenticaton_key_port5_2a)(aBaseAddr, 32)
        Set link_authenticaton_key_port5_2b = (New REGISTER_HSM_MISC_link_authenticaton_key_port5_2b)(aBaseAddr, 32)
        Set link_authenticaton_key_port5_2c = (New REGISTER_HSM_MISC_link_authenticaton_key_port5_2c)(aBaseAddr, 32)
        Set link_authenticaton_key_port5_2d = (New REGISTER_HSM_MISC_link_authenticaton_key_port5_2d)(aBaseAddr, 32)
        Set link_authenticaton_key_port5_2e = (New REGISTER_HSM_MISC_link_authenticaton_key_port5_2e)(aBaseAddr, 32)
        Set link_authenticaton_key_port5_3a = (New REGISTER_HSM_MISC_link_authenticaton_key_port5_3a)(aBaseAddr, 32)
        Set link_authenticaton_key_port5_3b = (New REGISTER_HSM_MISC_link_authenticaton_key_port5_3b)(aBaseAddr, 32)
        Set link_authenticaton_key_port5_3c = (New REGISTER_HSM_MISC_link_authenticaton_key_port5_3c)(aBaseAddr, 32)
        Set link_authenticaton_key_port5_3d = (New REGISTER_HSM_MISC_link_authenticaton_key_port5_3d)(aBaseAddr, 32)
        Set link_authenticaton_key_port5_3e = (New REGISTER_HSM_MISC_link_authenticaton_key_port5_3e)(aBaseAddr, 32)
        Set interrupt = (New REGISTER_HSM_MISC_interrupt)(aBaseAddr, 32)
        Set interrupt_en = (New REGISTER_HSM_MISC_interrupt_en)(aBaseAddr, 32)
        Set interrupt_clear = (New REGISTER_HSM_MISC_interrupt_clear)(aBaseAddr, 32)
        Set ahb_slave_timout_mon_interrupt = (New REGISTER_HSM_MISC_ahb_slave_timout_mon_interrupt)(aBaseAddr, 32)
        Set ahb_slave_timout_mon_interrupt_en = (New REGISTER_HSM_MISC_ahb_slave_timout_mon_interrupt_en)(aBaseAddr, 32)
        Set ahb_slave_timout_mon_interrupt_clr = (New REGISTER_HSM_MISC_ahb_slave_timout_mon_interrupt_clr)(aBaseAddr, 32)
        Set disable_ahb_slave_timout_mon = (New REGISTER_HSM_MISC_disable_ahb_slave_timout_mon)(aBaseAddr, 32)
        Set ecc_interrupt = (New REGISTER_HSM_MISC_ecc_interrupt)(aBaseAddr, 32)
        Set ecc_interrupt_en_reg = (New REGISTER_HSM_MISC_ecc_interrupt_en_reg)(aBaseAddr, 32)
        Set ecc_interrupt_clr_reg = (New REGISTER_HSM_MISC_ecc_interrupt_clr_reg)(aBaseAddr, 32)
        Set init_mem = (New REGISTER_HSM_MISC_init_mem)(aBaseAddr, 32)
        Set spare_reg0 = (New REGISTER_HSM_MISC_spare_reg0)(aBaseAddr, 32)
        Set spare_reg1 = (New REGISTER_HSM_MISC_spare_reg1)(aBaseAddr, 32)
        Set spare_reg2 = (New REGISTER_HSM_MISC_spare_reg2)(aBaseAddr, 32)
        Set spare_reg3 = (New REGISTER_HSM_MISC_spare_reg3)(aBaseAddr, 32)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set HSM_MISC = CreateObject("System.Collections.ArrayList")
HSM_MISC.Add ((New HSM_MISC_INSTANCE)(&H4c014000))


