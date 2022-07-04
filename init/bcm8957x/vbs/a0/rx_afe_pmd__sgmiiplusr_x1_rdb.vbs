

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


'' @REGISTER : RX_AFE_PMD__SGMIIPLUSR_X1_ctrl0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' slicer_pd                                  [15:15]          get_slicer_pd
''                                                             set_slicer_pd
''                                                             read_slicer_pd
''                                                             write_slicer_pd
''---------------------------------------------------------------------------------
'' RX_pon                                     [11:8]           get_RX_pon
''                                                             set_RX_pon
''                                                             read_RX_pon
''                                                             write_RX_pon
''---------------------------------------------------------------------------------
'' Filter_band                                [7:6]            get_Filter_band
''                                                             set_Filter_band
''                                                             read_Filter_band
''                                                             write_Filter_band
''---------------------------------------------------------------------------------
'' pd_lmtng                                   [2:2]            get_pd_lmtng
''                                                             set_pd_lmtng
''                                                             read_pd_lmtng
''                                                             write_pd_lmtng
''---------------------------------------------------------------------------------
'' pd_eqz                                     [1:1]            get_pd_eqz
''                                                             set_pd_eqz
''                                                             read_pd_eqz
''                                                             write_pd_eqz
''---------------------------------------------------------------------------------
Class REGISTER_RX_AFE_PMD__SGMIIPLUSR_X1_ctrl0
    Private write_slicer_pd_value
    Private read_slicer_pd_value
    Private flag_slicer_pd
    Private write_RX_pon_value
    Private read_RX_pon_value
    Private flag_RX_pon
    Private write_Filter_band_value
    Private read_Filter_band_value
    Private flag_Filter_band
    Private write_pd_lmtng_value
    Private read_pd_lmtng_value
    Private flag_pd_lmtng
    Private write_pd_eqz_value
    Private read_pd_eqz_value
    Private flag_pd_eqz

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

    Property Get get_slicer_pd
        get_slicer_pd = read_slicer_pd_value
    End Property

    Property Let set_slicer_pd(aData)
        write_slicer_pd_value = aData
        flag_slicer_pd        = &H1
    End Property

    Property Get read_slicer_pd
        read
        read_slicer_pd = read_slicer_pd_value
    End Property

    Property Let write_slicer_pd(aData)
        set_slicer_pd = aData
        write
    End Property

    Property Get get_RX_pon
        get_RX_pon = read_RX_pon_value
    End Property

    Property Let set_RX_pon(aData)
        write_RX_pon_value = aData
        flag_RX_pon        = &H1
    End Property

    Property Get read_RX_pon
        read
        read_RX_pon = read_RX_pon_value
    End Property

    Property Let write_RX_pon(aData)
        set_RX_pon = aData
        write
    End Property

    Property Get get_Filter_band
        get_Filter_band = read_Filter_band_value
    End Property

    Property Let set_Filter_band(aData)
        write_Filter_band_value = aData
        flag_Filter_band        = &H1
    End Property

    Property Get read_Filter_band
        read
        read_Filter_band = read_Filter_band_value
    End Property

    Property Let write_Filter_band(aData)
        set_Filter_band = aData
        write
    End Property

    Property Get get_pd_lmtng
        get_pd_lmtng = read_pd_lmtng_value
    End Property

    Property Let set_pd_lmtng(aData)
        write_pd_lmtng_value = aData
        flag_pd_lmtng        = &H1
    End Property

    Property Get read_pd_lmtng
        read
        read_pd_lmtng = read_pd_lmtng_value
    End Property

    Property Let write_pd_lmtng(aData)
        set_pd_lmtng = aData
        write
    End Property

    Property Get get_pd_eqz
        get_pd_eqz = read_pd_eqz_value
    End Property

    Property Let set_pd_eqz(aData)
        write_pd_eqz_value = aData
        flag_pd_eqz        = &H1
    End Property

    Property Get read_pd_eqz
        read
        read_pd_eqz = read_pd_eqz_value
    End Property

    Property Let write_pd_eqz(aData)
        set_pd_eqz = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_slicer_pd_value = rightShift(data_low, 15) and &H1
        read_RX_pon_value = rightShift(data_low, 8) and &Hf
        read_Filter_band_value = rightShift(data_low, 6) and &H3
        read_pd_lmtng_value = rightShift(data_low, 2) and &H1
        read_pd_eqz_value = rightShift(data_low, 1) and &H1

    End Sub

    Sub write
        If flag_slicer_pd = &H0 or flag_RX_pon = &H0 or flag_Filter_band = &H0 or flag_pd_lmtng = &H0 or flag_pd_eqz = &H0 Then read
        If flag_slicer_pd = &H0 Then write_slicer_pd_value = get_slicer_pd
        If flag_RX_pon = &H0 Then write_RX_pon_value = get_RX_pon
        If flag_Filter_band = &H0 Then write_Filter_band_value = get_Filter_band
        If flag_pd_lmtng = &H0 Then write_pd_lmtng_value = get_pd_lmtng
        If flag_pd_eqz = &H0 Then write_pd_eqz_value = get_pd_eqz

        regValue = leftShift((write_slicer_pd_value and &H1), 15) + leftShift((write_RX_pon_value and &Hf), 8) + leftShift((write_Filter_band_value and &H3), 6) + leftShift((write_pd_lmtng_value and &H1), 2) + leftShift((write_pd_eqz_value and &H1), 1)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_slicer_pd_value = rightShift(data_low, 15) and &H1
        read_RX_pon_value = rightShift(data_low, 8) and &Hf
        read_Filter_band_value = rightShift(data_low, 6) and &H3
        read_pd_lmtng_value = rightShift(data_low, 2) and &H1
        read_pd_eqz_value = rightShift(data_low, 1) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_slicer_pd_value = &H0
        flag_slicer_pd        = &H0
        write_RX_pon_value = &H0
        flag_RX_pon        = &H0
        write_Filter_band_value = &H0
        flag_Filter_band        = &H0
        write_pd_lmtng_value = &H0
        flag_pd_lmtng        = &H0
        write_pd_eqz_value = &H0
        flag_pd_eqz        = &H0
    End Sub
End Class


'' @REGISTER : RX_AFE_PMD__SGMIIPLUSR_X1_ctrl1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' demux_eyem_pd                              [15:15]          get_demux_eyem_pd
''                                                             set_demux_eyem_pd
''                                                             read_demux_eyem_pd
''                                                             write_demux_eyem_pd
''---------------------------------------------------------------------------------
'' demux_pd                                   [14:14]          get_demux_pd
''                                                             set_demux_pd
''                                                             read_demux_pd
''                                                             write_demux_pd
''---------------------------------------------------------------------------------
'' demux_peak_pd                              [13:13]          get_demux_peak_pd
''                                                             set_demux_peak_pd
''                                                             read_demux_peak_pd
''                                                             write_demux_peak_pd
''---------------------------------------------------------------------------------
'' demux_zero_pd                              [12:12]          get_demux_zero_pd
''                                                             set_demux_zero_pd
''                                                             read_demux_zero_pd
''                                                             write_demux_zero_pd
''---------------------------------------------------------------------------------
'' div_4_demux_enable                         [11:11]          get_div_4_demux_enable
''                                                             set_div_4_demux_enable
''                                                             read_div_4_demux_enable
''                                                             write_div_4_demux_enable
''---------------------------------------------------------------------------------
'' eyem_pd                                    [0:0]            get_eyem_pd
''                                                             set_eyem_pd
''                                                             read_eyem_pd
''                                                             write_eyem_pd
''---------------------------------------------------------------------------------
Class REGISTER_RX_AFE_PMD__SGMIIPLUSR_X1_ctrl1
    Private write_demux_eyem_pd_value
    Private read_demux_eyem_pd_value
    Private flag_demux_eyem_pd
    Private write_demux_pd_value
    Private read_demux_pd_value
    Private flag_demux_pd
    Private write_demux_peak_pd_value
    Private read_demux_peak_pd_value
    Private flag_demux_peak_pd
    Private write_demux_zero_pd_value
    Private read_demux_zero_pd_value
    Private flag_demux_zero_pd
    Private write_div_4_demux_enable_value
    Private read_div_4_demux_enable_value
    Private flag_div_4_demux_enable
    Private write_eyem_pd_value
    Private read_eyem_pd_value
    Private flag_eyem_pd

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

    Property Get get_demux_eyem_pd
        get_demux_eyem_pd = read_demux_eyem_pd_value
    End Property

    Property Let set_demux_eyem_pd(aData)
        write_demux_eyem_pd_value = aData
        flag_demux_eyem_pd        = &H1
    End Property

    Property Get read_demux_eyem_pd
        read
        read_demux_eyem_pd = read_demux_eyem_pd_value
    End Property

    Property Let write_demux_eyem_pd(aData)
        set_demux_eyem_pd = aData
        write
    End Property

    Property Get get_demux_pd
        get_demux_pd = read_demux_pd_value
    End Property

    Property Let set_demux_pd(aData)
        write_demux_pd_value = aData
        flag_demux_pd        = &H1
    End Property

    Property Get read_demux_pd
        read
        read_demux_pd = read_demux_pd_value
    End Property

    Property Let write_demux_pd(aData)
        set_demux_pd = aData
        write
    End Property

    Property Get get_demux_peak_pd
        get_demux_peak_pd = read_demux_peak_pd_value
    End Property

    Property Let set_demux_peak_pd(aData)
        write_demux_peak_pd_value = aData
        flag_demux_peak_pd        = &H1
    End Property

    Property Get read_demux_peak_pd
        read
        read_demux_peak_pd = read_demux_peak_pd_value
    End Property

    Property Let write_demux_peak_pd(aData)
        set_demux_peak_pd = aData
        write
    End Property

    Property Get get_demux_zero_pd
        get_demux_zero_pd = read_demux_zero_pd_value
    End Property

    Property Let set_demux_zero_pd(aData)
        write_demux_zero_pd_value = aData
        flag_demux_zero_pd        = &H1
    End Property

    Property Get read_demux_zero_pd
        read
        read_demux_zero_pd = read_demux_zero_pd_value
    End Property

    Property Let write_demux_zero_pd(aData)
        set_demux_zero_pd = aData
        write
    End Property

    Property Get get_div_4_demux_enable
        get_div_4_demux_enable = read_div_4_demux_enable_value
    End Property

    Property Let set_div_4_demux_enable(aData)
        write_div_4_demux_enable_value = aData
        flag_div_4_demux_enable        = &H1
    End Property

    Property Get read_div_4_demux_enable
        read
        read_div_4_demux_enable = read_div_4_demux_enable_value
    End Property

    Property Let write_div_4_demux_enable(aData)
        set_div_4_demux_enable = aData
        write
    End Property

    Property Get get_eyem_pd
        get_eyem_pd = read_eyem_pd_value
    End Property

    Property Let set_eyem_pd(aData)
        write_eyem_pd_value = aData
        flag_eyem_pd        = &H1
    End Property

    Property Get read_eyem_pd
        read
        read_eyem_pd = read_eyem_pd_value
    End Property

    Property Let write_eyem_pd(aData)
        set_eyem_pd = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_demux_eyem_pd_value = rightShift(data_low, 15) and &H1
        read_demux_pd_value = rightShift(data_low, 14) and &H1
        read_demux_peak_pd_value = rightShift(data_low, 13) and &H1
        read_demux_zero_pd_value = rightShift(data_low, 12) and &H1
        read_div_4_demux_enable_value = rightShift(data_low, 11) and &H1
        eyem_pd_mask = &H1
        if data_low > LONG_MAX then
            if eyem_pd_mask = mask then
                read_eyem_pd_value = data_low
            else
                read_eyem_pd_value = (data_low - H8000_0000) and eyem_pd_mask
            end If
        else
            read_eyem_pd_value = data_low and eyem_pd_mask
        end If

    End Sub

    Sub write
        If flag_demux_eyem_pd = &H0 or flag_demux_pd = &H0 or flag_demux_peak_pd = &H0 or flag_demux_zero_pd = &H0 or flag_div_4_demux_enable = &H0 or flag_eyem_pd = &H0 Then read
        If flag_demux_eyem_pd = &H0 Then write_demux_eyem_pd_value = get_demux_eyem_pd
        If flag_demux_pd = &H0 Then write_demux_pd_value = get_demux_pd
        If flag_demux_peak_pd = &H0 Then write_demux_peak_pd_value = get_demux_peak_pd
        If flag_demux_zero_pd = &H0 Then write_demux_zero_pd_value = get_demux_zero_pd
        If flag_div_4_demux_enable = &H0 Then write_div_4_demux_enable_value = get_div_4_demux_enable
        If flag_eyem_pd = &H0 Then write_eyem_pd_value = get_eyem_pd

        regValue = leftShift((write_demux_eyem_pd_value and &H1), 15) + leftShift((write_demux_pd_value and &H1), 14) + leftShift((write_demux_peak_pd_value and &H1), 13) + leftShift((write_demux_zero_pd_value and &H1), 12) + leftShift((write_div_4_demux_enable_value and &H1), 11) + leftShift((write_eyem_pd_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_demux_eyem_pd_value = rightShift(data_low, 15) and &H1
        read_demux_pd_value = rightShift(data_low, 14) and &H1
        read_demux_peak_pd_value = rightShift(data_low, 13) and &H1
        read_demux_zero_pd_value = rightShift(data_low, 12) and &H1
        read_div_4_demux_enable_value = rightShift(data_low, 11) and &H1
        eyem_pd_mask = &H1
        if data_low > LONG_MAX then
            if eyem_pd_mask = mask then
                read_eyem_pd_value = data_low
            else
                read_eyem_pd_value = (data_low - H8000_0000) and eyem_pd_mask
            end If
        else
            read_eyem_pd_value = data_low and eyem_pd_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_demux_eyem_pd_value = &H0
        flag_demux_eyem_pd        = &H0
        write_demux_pd_value = &H0
        flag_demux_pd        = &H0
        write_demux_peak_pd_value = &H0
        flag_demux_peak_pd        = &H0
        write_demux_zero_pd_value = &H0
        flag_demux_zero_pd        = &H0
        write_div_4_demux_enable_value = &H0
        flag_div_4_demux_enable        = &H0
        write_eyem_pd_value = &H0
        flag_eyem_pd        = &H0
    End Sub
End Class


'' @REGISTER : RX_AFE_PMD__SGMIIPLUSR_X1_ctrl2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' inputerm_lowZvdd_en                        [6:6]            get_inputerm_lowZvdd_en
''                                                             set_inputerm_lowZvdd_en
''                                                             read_inputerm_lowZvdd_en
''                                                             write_inputerm_lowZvdd_en
''---------------------------------------------------------------------------------
'' inputerm_lowZgnd_en                        [5:5]            get_inputerm_lowZgnd_en
''                                                             set_inputerm_lowZgnd_en
''                                                             read_inputerm_lowZgnd_en
''                                                             write_inputerm_lowZgnd_en
''---------------------------------------------------------------------------------
'' inputerm_cmult_en                          [4:4]            get_inputerm_cmult_en
''                                                             set_inputerm_cmult_en
''                                                             read_inputerm_cmult_en
''                                                             write_inputerm_cmult_en
''---------------------------------------------------------------------------------
'' inputerm_cm_en                             [3:3]            get_inputerm_cm_en
''                                                             set_inputerm_cm_en
''                                                             read_inputerm_cm_en
''                                                             write_inputerm_cm_en
''---------------------------------------------------------------------------------
'' div10_pd                                   [2:2]            get_div10_pd
''                                                             set_div10_pd
''                                                             read_div10_pd
''                                                             write_div10_pd
''---------------------------------------------------------------------------------
'' div4_pd                                    [1:1]            get_div4_pd
''                                                             set_div4_pd
''                                                             read_div4_pd
''                                                             write_div4_pd
''---------------------------------------------------------------------------------
Class REGISTER_RX_AFE_PMD__SGMIIPLUSR_X1_ctrl2
    Private write_inputerm_lowZvdd_en_value
    Private read_inputerm_lowZvdd_en_value
    Private flag_inputerm_lowZvdd_en
    Private write_inputerm_lowZgnd_en_value
    Private read_inputerm_lowZgnd_en_value
    Private flag_inputerm_lowZgnd_en
    Private write_inputerm_cmult_en_value
    Private read_inputerm_cmult_en_value
    Private flag_inputerm_cmult_en
    Private write_inputerm_cm_en_value
    Private read_inputerm_cm_en_value
    Private flag_inputerm_cm_en
    Private write_div10_pd_value
    Private read_div10_pd_value
    Private flag_div10_pd
    Private write_div4_pd_value
    Private read_div4_pd_value
    Private flag_div4_pd

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

    Property Get get_inputerm_lowZvdd_en
        get_inputerm_lowZvdd_en = read_inputerm_lowZvdd_en_value
    End Property

    Property Let set_inputerm_lowZvdd_en(aData)
        write_inputerm_lowZvdd_en_value = aData
        flag_inputerm_lowZvdd_en        = &H1
    End Property

    Property Get read_inputerm_lowZvdd_en
        read
        read_inputerm_lowZvdd_en = read_inputerm_lowZvdd_en_value
    End Property

    Property Let write_inputerm_lowZvdd_en(aData)
        set_inputerm_lowZvdd_en = aData
        write
    End Property

    Property Get get_inputerm_lowZgnd_en
        get_inputerm_lowZgnd_en = read_inputerm_lowZgnd_en_value
    End Property

    Property Let set_inputerm_lowZgnd_en(aData)
        write_inputerm_lowZgnd_en_value = aData
        flag_inputerm_lowZgnd_en        = &H1
    End Property

    Property Get read_inputerm_lowZgnd_en
        read
        read_inputerm_lowZgnd_en = read_inputerm_lowZgnd_en_value
    End Property

    Property Let write_inputerm_lowZgnd_en(aData)
        set_inputerm_lowZgnd_en = aData
        write
    End Property

    Property Get get_inputerm_cmult_en
        get_inputerm_cmult_en = read_inputerm_cmult_en_value
    End Property

    Property Let set_inputerm_cmult_en(aData)
        write_inputerm_cmult_en_value = aData
        flag_inputerm_cmult_en        = &H1
    End Property

    Property Get read_inputerm_cmult_en
        read
        read_inputerm_cmult_en = read_inputerm_cmult_en_value
    End Property

    Property Let write_inputerm_cmult_en(aData)
        set_inputerm_cmult_en = aData
        write
    End Property

    Property Get get_inputerm_cm_en
        get_inputerm_cm_en = read_inputerm_cm_en_value
    End Property

    Property Let set_inputerm_cm_en(aData)
        write_inputerm_cm_en_value = aData
        flag_inputerm_cm_en        = &H1
    End Property

    Property Get read_inputerm_cm_en
        read
        read_inputerm_cm_en = read_inputerm_cm_en_value
    End Property

    Property Let write_inputerm_cm_en(aData)
        set_inputerm_cm_en = aData
        write
    End Property

    Property Get get_div10_pd
        get_div10_pd = read_div10_pd_value
    End Property

    Property Let set_div10_pd(aData)
        write_div10_pd_value = aData
        flag_div10_pd        = &H1
    End Property

    Property Get read_div10_pd
        read
        read_div10_pd = read_div10_pd_value
    End Property

    Property Let write_div10_pd(aData)
        set_div10_pd = aData
        write
    End Property

    Property Get get_div4_pd
        get_div4_pd = read_div4_pd_value
    End Property

    Property Let set_div4_pd(aData)
        write_div4_pd_value = aData
        flag_div4_pd        = &H1
    End Property

    Property Get read_div4_pd
        read
        read_div4_pd = read_div4_pd_value
    End Property

    Property Let write_div4_pd(aData)
        set_div4_pd = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_inputerm_lowZvdd_en_value = rightShift(data_low, 6) and &H1
        read_inputerm_lowZgnd_en_value = rightShift(data_low, 5) and &H1
        read_inputerm_cmult_en_value = rightShift(data_low, 4) and &H1
        read_inputerm_cm_en_value = rightShift(data_low, 3) and &H1
        read_div10_pd_value = rightShift(data_low, 2) and &H1
        read_div4_pd_value = rightShift(data_low, 1) and &H1

    End Sub

    Sub write
        If flag_inputerm_lowZvdd_en = &H0 or flag_inputerm_lowZgnd_en = &H0 or flag_inputerm_cmult_en = &H0 or flag_inputerm_cm_en = &H0 or flag_div10_pd = &H0 or flag_div4_pd = &H0 Then read
        If flag_inputerm_lowZvdd_en = &H0 Then write_inputerm_lowZvdd_en_value = get_inputerm_lowZvdd_en
        If flag_inputerm_lowZgnd_en = &H0 Then write_inputerm_lowZgnd_en_value = get_inputerm_lowZgnd_en
        If flag_inputerm_cmult_en = &H0 Then write_inputerm_cmult_en_value = get_inputerm_cmult_en
        If flag_inputerm_cm_en = &H0 Then write_inputerm_cm_en_value = get_inputerm_cm_en
        If flag_div10_pd = &H0 Then write_div10_pd_value = get_div10_pd
        If flag_div4_pd = &H0 Then write_div4_pd_value = get_div4_pd

        regValue = leftShift((write_inputerm_lowZvdd_en_value and &H1), 6) + leftShift((write_inputerm_lowZgnd_en_value and &H1), 5) + leftShift((write_inputerm_cmult_en_value and &H1), 4) + leftShift((write_inputerm_cm_en_value and &H1), 3) + leftShift((write_div10_pd_value and &H1), 2) + leftShift((write_div4_pd_value and &H1), 1)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_inputerm_lowZvdd_en_value = rightShift(data_low, 6) and &H1
        read_inputerm_lowZgnd_en_value = rightShift(data_low, 5) and &H1
        read_inputerm_cmult_en_value = rightShift(data_low, 4) and &H1
        read_inputerm_cm_en_value = rightShift(data_low, 3) and &H1
        read_div10_pd_value = rightShift(data_low, 2) and &H1
        read_div4_pd_value = rightShift(data_low, 1) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_inputerm_lowZvdd_en_value = &H0
        flag_inputerm_lowZvdd_en        = &H0
        write_inputerm_lowZgnd_en_value = &H0
        flag_inputerm_lowZgnd_en        = &H0
        write_inputerm_cmult_en_value = &H0
        flag_inputerm_cmult_en        = &H0
        write_inputerm_cm_en_value = &H0
        flag_inputerm_cm_en        = &H0
        write_div10_pd_value = &H0
        flag_div10_pd        = &H0
        write_div4_pd_value = &H0
        flag_div4_pd        = &H0
    End Sub
End Class


'' @REGISTER : RX_AFE_PMD__SGMIIPLUSR_X1_ctrl3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' pd_bias                                    [9:9]            get_pd_bias
''                                                             set_pd_bias
''                                                             read_pd_bias
''                                                             write_pd_bias
''---------------------------------------------------------------------------------
'' Duty_Cycle                                 [8:6]            get_Duty_Cycle
''                                                             set_Duty_Cycle
''                                                             read_Duty_Cycle
''                                                             write_Duty_Cycle
''---------------------------------------------------------------------------------
'' Dcc_en                                     [5:5]            get_Dcc_en
''                                                             set_Dcc_en
''                                                             read_Dcc_en
''                                                             write_Dcc_en
''---------------------------------------------------------------------------------
Class REGISTER_RX_AFE_PMD__SGMIIPLUSR_X1_ctrl3
    Private write_pd_bias_value
    Private read_pd_bias_value
    Private flag_pd_bias
    Private write_Duty_Cycle_value
    Private read_Duty_Cycle_value
    Private flag_Duty_Cycle
    Private write_Dcc_en_value
    Private read_Dcc_en_value
    Private flag_Dcc_en

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

    Property Get get_pd_bias
        get_pd_bias = read_pd_bias_value
    End Property

    Property Let set_pd_bias(aData)
        write_pd_bias_value = aData
        flag_pd_bias        = &H1
    End Property

    Property Get read_pd_bias
        read
        read_pd_bias = read_pd_bias_value
    End Property

    Property Let write_pd_bias(aData)
        set_pd_bias = aData
        write
    End Property

    Property Get get_Duty_Cycle
        get_Duty_Cycle = read_Duty_Cycle_value
    End Property

    Property Let set_Duty_Cycle(aData)
        write_Duty_Cycle_value = aData
        flag_Duty_Cycle        = &H1
    End Property

    Property Get read_Duty_Cycle
        read
        read_Duty_Cycle = read_Duty_Cycle_value
    End Property

    Property Let write_Duty_Cycle(aData)
        set_Duty_Cycle = aData
        write
    End Property

    Property Get get_Dcc_en
        get_Dcc_en = read_Dcc_en_value
    End Property

    Property Let set_Dcc_en(aData)
        write_Dcc_en_value = aData
        flag_Dcc_en        = &H1
    End Property

    Property Get read_Dcc_en
        read
        read_Dcc_en = read_Dcc_en_value
    End Property

    Property Let write_Dcc_en(aData)
        set_Dcc_en = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_pd_bias_value = rightShift(data_low, 9) and &H1
        read_Duty_Cycle_value = rightShift(data_low, 6) and &H7
        read_Dcc_en_value = rightShift(data_low, 5) and &H1

    End Sub

    Sub write
        If flag_pd_bias = &H0 or flag_Duty_Cycle = &H0 or flag_Dcc_en = &H0 Then read
        If flag_pd_bias = &H0 Then write_pd_bias_value = get_pd_bias
        If flag_Duty_Cycle = &H0 Then write_Duty_Cycle_value = get_Duty_Cycle
        If flag_Dcc_en = &H0 Then write_Dcc_en_value = get_Dcc_en

        regValue = leftShift((write_pd_bias_value and &H1), 9) + leftShift((write_Duty_Cycle_value and &H7), 6) + leftShift((write_Dcc_en_value and &H1), 5)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_pd_bias_value = rightShift(data_low, 9) and &H1
        read_Duty_Cycle_value = rightShift(data_low, 6) and &H7
        read_Dcc_en_value = rightShift(data_low, 5) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_pd_bias_value = &H0
        flag_pd_bias        = &H0
        write_Duty_Cycle_value = &H0
        flag_Duty_Cycle        = &H0
        write_Dcc_en_value = &H0
        flag_Dcc_en        = &H0
    End Sub
End Class


'' @REGISTER : RX_AFE_PMD__SGMIIPLUSR_X1_ctrl4
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' en_testmux                                 [15:15]          get_en_testmux
''                                                             set_en_testmux
''                                                             read_en_testmux
''                                                             write_en_testmux
''---------------------------------------------------------------------------------
'' Sigdet_modeselect                          [14:14]          get_Sigdet_modeselect
''                                                             set_Sigdet_modeselect
''                                                             read_Sigdet_modeselect
''                                                             write_Sigdet_modeselect
''---------------------------------------------------------------------------------
'' sigdet_pd                                  [13:13]          get_sigdet_pd
''                                                             set_sigdet_pd
''                                                             read_sigdet_pd
''                                                             write_sigdet_pd
''---------------------------------------------------------------------------------
'' sigdet_bypass                              [12:12]          get_sigdet_bypass
''                                                             set_sigdet_bypass
''                                                             read_sigdet_bypass
''                                                             write_sigdet_bypass
''---------------------------------------------------------------------------------
'' bias_sigdet_ctrl                           [11:9]           get_bias_sigdet_ctrl
''                                                             set_bias_sigdet_ctrl
''                                                             read_bias_sigdet_ctrl
''                                                             write_bias_sigdet_ctrl
''---------------------------------------------------------------------------------
'' bias_eyem_ctrl                             [8:6]            get_bias_eyem_ctrl
''                                                             set_bias_eyem_ctrl
''                                                             read_bias_eyem_ctrl
''                                                             write_bias_eyem_ctrl
''---------------------------------------------------------------------------------
'' bias_la_dac_ctrl                           [5:3]            get_bias_la_dac_ctrl
''                                                             set_bias_la_dac_ctrl
''                                                             read_bias_la_dac_ctrl
''                                                             write_bias_la_dac_ctrl
''---------------------------------------------------------------------------------
'' bias_la_ctrl                               [2:0]            get_bias_la_ctrl
''                                                             set_bias_la_ctrl
''                                                             read_bias_la_ctrl
''                                                             write_bias_la_ctrl
''---------------------------------------------------------------------------------
Class REGISTER_RX_AFE_PMD__SGMIIPLUSR_X1_ctrl4
    Private write_en_testmux_value
    Private read_en_testmux_value
    Private flag_en_testmux
    Private write_Sigdet_modeselect_value
    Private read_Sigdet_modeselect_value
    Private flag_Sigdet_modeselect
    Private write_sigdet_pd_value
    Private read_sigdet_pd_value
    Private flag_sigdet_pd
    Private write_sigdet_bypass_value
    Private read_sigdet_bypass_value
    Private flag_sigdet_bypass
    Private write_bias_sigdet_ctrl_value
    Private read_bias_sigdet_ctrl_value
    Private flag_bias_sigdet_ctrl
    Private write_bias_eyem_ctrl_value
    Private read_bias_eyem_ctrl_value
    Private flag_bias_eyem_ctrl
    Private write_bias_la_dac_ctrl_value
    Private read_bias_la_dac_ctrl_value
    Private flag_bias_la_dac_ctrl
    Private write_bias_la_ctrl_value
    Private read_bias_la_ctrl_value
    Private flag_bias_la_ctrl

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

    Property Get get_en_testmux
        get_en_testmux = read_en_testmux_value
    End Property

    Property Let set_en_testmux(aData)
        write_en_testmux_value = aData
        flag_en_testmux        = &H1
    End Property

    Property Get read_en_testmux
        read
        read_en_testmux = read_en_testmux_value
    End Property

    Property Let write_en_testmux(aData)
        set_en_testmux = aData
        write
    End Property

    Property Get get_Sigdet_modeselect
        get_Sigdet_modeselect = read_Sigdet_modeselect_value
    End Property

    Property Let set_Sigdet_modeselect(aData)
        write_Sigdet_modeselect_value = aData
        flag_Sigdet_modeselect        = &H1
    End Property

    Property Get read_Sigdet_modeselect
        read
        read_Sigdet_modeselect = read_Sigdet_modeselect_value
    End Property

    Property Let write_Sigdet_modeselect(aData)
        set_Sigdet_modeselect = aData
        write
    End Property

    Property Get get_sigdet_pd
        get_sigdet_pd = read_sigdet_pd_value
    End Property

    Property Let set_sigdet_pd(aData)
        write_sigdet_pd_value = aData
        flag_sigdet_pd        = &H1
    End Property

    Property Get read_sigdet_pd
        read
        read_sigdet_pd = read_sigdet_pd_value
    End Property

    Property Let write_sigdet_pd(aData)
        set_sigdet_pd = aData
        write
    End Property

    Property Get get_sigdet_bypass
        get_sigdet_bypass = read_sigdet_bypass_value
    End Property

    Property Let set_sigdet_bypass(aData)
        write_sigdet_bypass_value = aData
        flag_sigdet_bypass        = &H1
    End Property

    Property Get read_sigdet_bypass
        read
        read_sigdet_bypass = read_sigdet_bypass_value
    End Property

    Property Let write_sigdet_bypass(aData)
        set_sigdet_bypass = aData
        write
    End Property

    Property Get get_bias_sigdet_ctrl
        get_bias_sigdet_ctrl = read_bias_sigdet_ctrl_value
    End Property

    Property Let set_bias_sigdet_ctrl(aData)
        write_bias_sigdet_ctrl_value = aData
        flag_bias_sigdet_ctrl        = &H1
    End Property

    Property Get read_bias_sigdet_ctrl
        read
        read_bias_sigdet_ctrl = read_bias_sigdet_ctrl_value
    End Property

    Property Let write_bias_sigdet_ctrl(aData)
        set_bias_sigdet_ctrl = aData
        write
    End Property

    Property Get get_bias_eyem_ctrl
        get_bias_eyem_ctrl = read_bias_eyem_ctrl_value
    End Property

    Property Let set_bias_eyem_ctrl(aData)
        write_bias_eyem_ctrl_value = aData
        flag_bias_eyem_ctrl        = &H1
    End Property

    Property Get read_bias_eyem_ctrl
        read
        read_bias_eyem_ctrl = read_bias_eyem_ctrl_value
    End Property

    Property Let write_bias_eyem_ctrl(aData)
        set_bias_eyem_ctrl = aData
        write
    End Property

    Property Get get_bias_la_dac_ctrl
        get_bias_la_dac_ctrl = read_bias_la_dac_ctrl_value
    End Property

    Property Let set_bias_la_dac_ctrl(aData)
        write_bias_la_dac_ctrl_value = aData
        flag_bias_la_dac_ctrl        = &H1
    End Property

    Property Get read_bias_la_dac_ctrl
        read
        read_bias_la_dac_ctrl = read_bias_la_dac_ctrl_value
    End Property

    Property Let write_bias_la_dac_ctrl(aData)
        set_bias_la_dac_ctrl = aData
        write
    End Property

    Property Get get_bias_la_ctrl
        get_bias_la_ctrl = read_bias_la_ctrl_value
    End Property

    Property Let set_bias_la_ctrl(aData)
        write_bias_la_ctrl_value = aData
        flag_bias_la_ctrl        = &H1
    End Property

    Property Get read_bias_la_ctrl
        read
        read_bias_la_ctrl = read_bias_la_ctrl_value
    End Property

    Property Let write_bias_la_ctrl(aData)
        set_bias_la_ctrl = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_en_testmux_value = rightShift(data_low, 15) and &H1
        read_Sigdet_modeselect_value = rightShift(data_low, 14) and &H1
        read_sigdet_pd_value = rightShift(data_low, 13) and &H1
        read_sigdet_bypass_value = rightShift(data_low, 12) and &H1
        read_bias_sigdet_ctrl_value = rightShift(data_low, 9) and &H7
        read_bias_eyem_ctrl_value = rightShift(data_low, 6) and &H7
        read_bias_la_dac_ctrl_value = rightShift(data_low, 3) and &H7
        bias_la_ctrl_mask = &H7
        if data_low > LONG_MAX then
            if bias_la_ctrl_mask = mask then
                read_bias_la_ctrl_value = data_low
            else
                read_bias_la_ctrl_value = (data_low - H8000_0000) and bias_la_ctrl_mask
            end If
        else
            read_bias_la_ctrl_value = data_low and bias_la_ctrl_mask
        end If

    End Sub

    Sub write
        If flag_en_testmux = &H0 or flag_Sigdet_modeselect = &H0 or flag_sigdet_pd = &H0 or flag_sigdet_bypass = &H0 or flag_bias_sigdet_ctrl = &H0 or flag_bias_eyem_ctrl = &H0 or flag_bias_la_dac_ctrl = &H0 or flag_bias_la_ctrl = &H0 Then read
        If flag_en_testmux = &H0 Then write_en_testmux_value = get_en_testmux
        If flag_Sigdet_modeselect = &H0 Then write_Sigdet_modeselect_value = get_Sigdet_modeselect
        If flag_sigdet_pd = &H0 Then write_sigdet_pd_value = get_sigdet_pd
        If flag_sigdet_bypass = &H0 Then write_sigdet_bypass_value = get_sigdet_bypass
        If flag_bias_sigdet_ctrl = &H0 Then write_bias_sigdet_ctrl_value = get_bias_sigdet_ctrl
        If flag_bias_eyem_ctrl = &H0 Then write_bias_eyem_ctrl_value = get_bias_eyem_ctrl
        If flag_bias_la_dac_ctrl = &H0 Then write_bias_la_dac_ctrl_value = get_bias_la_dac_ctrl
        If flag_bias_la_ctrl = &H0 Then write_bias_la_ctrl_value = get_bias_la_ctrl

        regValue = leftShift((write_en_testmux_value and &H1), 15) + leftShift((write_Sigdet_modeselect_value and &H1), 14) + leftShift((write_sigdet_pd_value and &H1), 13) + leftShift((write_sigdet_bypass_value and &H1), 12) + leftShift((write_bias_sigdet_ctrl_value and &H7), 9) + leftShift((write_bias_eyem_ctrl_value and &H7), 6) + leftShift((write_bias_la_dac_ctrl_value and &H7), 3) + leftShift((write_bias_la_ctrl_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_en_testmux_value = rightShift(data_low, 15) and &H1
        read_Sigdet_modeselect_value = rightShift(data_low, 14) and &H1
        read_sigdet_pd_value = rightShift(data_low, 13) and &H1
        read_sigdet_bypass_value = rightShift(data_low, 12) and &H1
        read_bias_sigdet_ctrl_value = rightShift(data_low, 9) and &H7
        read_bias_eyem_ctrl_value = rightShift(data_low, 6) and &H7
        read_bias_la_dac_ctrl_value = rightShift(data_low, 3) and &H7
        bias_la_ctrl_mask = &H7
        if data_low > LONG_MAX then
            if bias_la_ctrl_mask = mask then
                read_bias_la_ctrl_value = data_low
            else
                read_bias_la_ctrl_value = (data_low - H8000_0000) and bias_la_ctrl_mask
            end If
        else
            read_bias_la_ctrl_value = data_low and bias_la_ctrl_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_en_testmux_value = &H0
        flag_en_testmux        = &H0
        write_Sigdet_modeselect_value = &H0
        flag_Sigdet_modeselect        = &H0
        write_sigdet_pd_value = &H0
        flag_sigdet_pd        = &H0
        write_sigdet_bypass_value = &H0
        flag_sigdet_bypass        = &H0
        write_bias_sigdet_ctrl_value = &H0
        flag_bias_sigdet_ctrl        = &H0
        write_bias_eyem_ctrl_value = &H0
        flag_bias_eyem_ctrl        = &H0
        write_bias_la_dac_ctrl_value = &H0
        flag_bias_la_dac_ctrl        = &H0
        write_bias_la_ctrl_value = &H0
        flag_bias_la_ctrl        = &H0
    End Sub
End Class


'' @REGISTER : RX_AFE_PMD__SGMIIPLUSR_X1_ctrl5
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' sigdet_usb_en                              [15:15]          get_sigdet_usb_en
''                                                             set_sigdet_usb_en
''                                                             read_sigdet_usb_en
''                                                             write_sigdet_usb_en
''---------------------------------------------------------------------------------
'' pi_eyem_enable                             [14:14]          get_pi_eyem_enable
''                                                             set_pi_eyem_enable
''                                                             read_pi_eyem_enable
''                                                             write_pi_eyem_enable
''---------------------------------------------------------------------------------
'' pi_main_enable                             [13:13]          get_pi_main_enable
''                                                             set_pi_main_enable
''                                                             read_pi_main_enable
''                                                             write_pi_main_enable
''---------------------------------------------------------------------------------
'' eyemonitor_ref_zero                        [12:12]          get_eyemonitor_ref_zero
''                                                             set_eyemonitor_ref_zero
''                                                             read_eyemonitor_ref_zero
''                                                             write_eyemonitor_ref_zero
''---------------------------------------------------------------------------------
'' eyemonitorref_pd                           [11:11]          get_eyemonitorref_pd
''                                                             set_eyemonitorref_pd
''                                                             read_eyemonitorref_pd
''                                                             write_eyemonitorref_pd
''---------------------------------------------------------------------------------
'' eyem_refadjust                             [10:6]           get_eyem_refadjust
''                                                             set_eyem_refadjust
''                                                             read_eyem_refadjust
''                                                             write_eyem_refadjust
''---------------------------------------------------------------------------------
'' sel_clk                                    [5:4]            get_sel_clk
''                                                             set_sel_clk
''                                                             read_sel_clk
''                                                             write_sel_clk
''---------------------------------------------------------------------------------
'' Sigdet_threshold                           [3:0]            get_Sigdet_threshold
''                                                             set_Sigdet_threshold
''                                                             read_Sigdet_threshold
''                                                             write_Sigdet_threshold
''---------------------------------------------------------------------------------
Class REGISTER_RX_AFE_PMD__SGMIIPLUSR_X1_ctrl5
    Private write_sigdet_usb_en_value
    Private read_sigdet_usb_en_value
    Private flag_sigdet_usb_en
    Private write_pi_eyem_enable_value
    Private read_pi_eyem_enable_value
    Private flag_pi_eyem_enable
    Private write_pi_main_enable_value
    Private read_pi_main_enable_value
    Private flag_pi_main_enable
    Private write_eyemonitor_ref_zero_value
    Private read_eyemonitor_ref_zero_value
    Private flag_eyemonitor_ref_zero
    Private write_eyemonitorref_pd_value
    Private read_eyemonitorref_pd_value
    Private flag_eyemonitorref_pd
    Private write_eyem_refadjust_value
    Private read_eyem_refadjust_value
    Private flag_eyem_refadjust
    Private write_sel_clk_value
    Private read_sel_clk_value
    Private flag_sel_clk
    Private write_Sigdet_threshold_value
    Private read_Sigdet_threshold_value
    Private flag_Sigdet_threshold

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

    Property Get get_sigdet_usb_en
        get_sigdet_usb_en = read_sigdet_usb_en_value
    End Property

    Property Let set_sigdet_usb_en(aData)
        write_sigdet_usb_en_value = aData
        flag_sigdet_usb_en        = &H1
    End Property

    Property Get read_sigdet_usb_en
        read
        read_sigdet_usb_en = read_sigdet_usb_en_value
    End Property

    Property Let write_sigdet_usb_en(aData)
        set_sigdet_usb_en = aData
        write
    End Property

    Property Get get_pi_eyem_enable
        get_pi_eyem_enable = read_pi_eyem_enable_value
    End Property

    Property Let set_pi_eyem_enable(aData)
        write_pi_eyem_enable_value = aData
        flag_pi_eyem_enable        = &H1
    End Property

    Property Get read_pi_eyem_enable
        read
        read_pi_eyem_enable = read_pi_eyem_enable_value
    End Property

    Property Let write_pi_eyem_enable(aData)
        set_pi_eyem_enable = aData
        write
    End Property

    Property Get get_pi_main_enable
        get_pi_main_enable = read_pi_main_enable_value
    End Property

    Property Let set_pi_main_enable(aData)
        write_pi_main_enable_value = aData
        flag_pi_main_enable        = &H1
    End Property

    Property Get read_pi_main_enable
        read
        read_pi_main_enable = read_pi_main_enable_value
    End Property

    Property Let write_pi_main_enable(aData)
        set_pi_main_enable = aData
        write
    End Property

    Property Get get_eyemonitor_ref_zero
        get_eyemonitor_ref_zero = read_eyemonitor_ref_zero_value
    End Property

    Property Let set_eyemonitor_ref_zero(aData)
        write_eyemonitor_ref_zero_value = aData
        flag_eyemonitor_ref_zero        = &H1
    End Property

    Property Get read_eyemonitor_ref_zero
        read
        read_eyemonitor_ref_zero = read_eyemonitor_ref_zero_value
    End Property

    Property Let write_eyemonitor_ref_zero(aData)
        set_eyemonitor_ref_zero = aData
        write
    End Property

    Property Get get_eyemonitorref_pd
        get_eyemonitorref_pd = read_eyemonitorref_pd_value
    End Property

    Property Let set_eyemonitorref_pd(aData)
        write_eyemonitorref_pd_value = aData
        flag_eyemonitorref_pd        = &H1
    End Property

    Property Get read_eyemonitorref_pd
        read
        read_eyemonitorref_pd = read_eyemonitorref_pd_value
    End Property

    Property Let write_eyemonitorref_pd(aData)
        set_eyemonitorref_pd = aData
        write
    End Property

    Property Get get_eyem_refadjust
        get_eyem_refadjust = read_eyem_refadjust_value
    End Property

    Property Let set_eyem_refadjust(aData)
        write_eyem_refadjust_value = aData
        flag_eyem_refadjust        = &H1
    End Property

    Property Get read_eyem_refadjust
        read
        read_eyem_refadjust = read_eyem_refadjust_value
    End Property

    Property Let write_eyem_refadjust(aData)
        set_eyem_refadjust = aData
        write
    End Property

    Property Get get_sel_clk
        get_sel_clk = read_sel_clk_value
    End Property

    Property Let set_sel_clk(aData)
        write_sel_clk_value = aData
        flag_sel_clk        = &H1
    End Property

    Property Get read_sel_clk
        read
        read_sel_clk = read_sel_clk_value
    End Property

    Property Let write_sel_clk(aData)
        set_sel_clk = aData
        write
    End Property

    Property Get get_Sigdet_threshold
        get_Sigdet_threshold = read_Sigdet_threshold_value
    End Property

    Property Let set_Sigdet_threshold(aData)
        write_Sigdet_threshold_value = aData
        flag_Sigdet_threshold        = &H1
    End Property

    Property Get read_Sigdet_threshold
        read
        read_Sigdet_threshold = read_Sigdet_threshold_value
    End Property

    Property Let write_Sigdet_threshold(aData)
        set_Sigdet_threshold = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_sigdet_usb_en_value = rightShift(data_low, 15) and &H1
        read_pi_eyem_enable_value = rightShift(data_low, 14) and &H1
        read_pi_main_enable_value = rightShift(data_low, 13) and &H1
        read_eyemonitor_ref_zero_value = rightShift(data_low, 12) and &H1
        read_eyemonitorref_pd_value = rightShift(data_low, 11) and &H1
        read_eyem_refadjust_value = rightShift(data_low, 6) and &H1f
        read_sel_clk_value = rightShift(data_low, 4) and &H3
        Sigdet_threshold_mask = &Hf
        if data_low > LONG_MAX then
            if Sigdet_threshold_mask = mask then
                read_Sigdet_threshold_value = data_low
            else
                read_Sigdet_threshold_value = (data_low - H8000_0000) and Sigdet_threshold_mask
            end If
        else
            read_Sigdet_threshold_value = data_low and Sigdet_threshold_mask
        end If

    End Sub

    Sub write
        If flag_sigdet_usb_en = &H0 or flag_pi_eyem_enable = &H0 or flag_pi_main_enable = &H0 or flag_eyemonitor_ref_zero = &H0 or flag_eyemonitorref_pd = &H0 or flag_eyem_refadjust = &H0 or flag_sel_clk = &H0 or flag_Sigdet_threshold = &H0 Then read
        If flag_sigdet_usb_en = &H0 Then write_sigdet_usb_en_value = get_sigdet_usb_en
        If flag_pi_eyem_enable = &H0 Then write_pi_eyem_enable_value = get_pi_eyem_enable
        If flag_pi_main_enable = &H0 Then write_pi_main_enable_value = get_pi_main_enable
        If flag_eyemonitor_ref_zero = &H0 Then write_eyemonitor_ref_zero_value = get_eyemonitor_ref_zero
        If flag_eyemonitorref_pd = &H0 Then write_eyemonitorref_pd_value = get_eyemonitorref_pd
        If flag_eyem_refadjust = &H0 Then write_eyem_refadjust_value = get_eyem_refadjust
        If flag_sel_clk = &H0 Then write_sel_clk_value = get_sel_clk
        If flag_Sigdet_threshold = &H0 Then write_Sigdet_threshold_value = get_Sigdet_threshold

        regValue = leftShift((write_sigdet_usb_en_value and &H1), 15) + leftShift((write_pi_eyem_enable_value and &H1), 14) + leftShift((write_pi_main_enable_value and &H1), 13) + leftShift((write_eyemonitor_ref_zero_value and &H1), 12) + leftShift((write_eyemonitorref_pd_value and &H1), 11) + leftShift((write_eyem_refadjust_value and &H1f), 6) + leftShift((write_sel_clk_value and &H3), 4) + leftShift((write_Sigdet_threshold_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_sigdet_usb_en_value = rightShift(data_low, 15) and &H1
        read_pi_eyem_enable_value = rightShift(data_low, 14) and &H1
        read_pi_main_enable_value = rightShift(data_low, 13) and &H1
        read_eyemonitor_ref_zero_value = rightShift(data_low, 12) and &H1
        read_eyemonitorref_pd_value = rightShift(data_low, 11) and &H1
        read_eyem_refadjust_value = rightShift(data_low, 6) and &H1f
        read_sel_clk_value = rightShift(data_low, 4) and &H3
        Sigdet_threshold_mask = &Hf
        if data_low > LONG_MAX then
            if Sigdet_threshold_mask = mask then
                read_Sigdet_threshold_value = data_low
            else
                read_Sigdet_threshold_value = (data_low - H8000_0000) and Sigdet_threshold_mask
            end If
        else
            read_Sigdet_threshold_value = data_low and Sigdet_threshold_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_sigdet_usb_en_value = &H0
        flag_sigdet_usb_en        = &H0
        write_pi_eyem_enable_value = &H0
        flag_pi_eyem_enable        = &H0
        write_pi_main_enable_value = &H0
        flag_pi_main_enable        = &H0
        write_eyemonitor_ref_zero_value = &H0
        flag_eyemonitor_ref_zero        = &H0
        write_eyemonitorref_pd_value = &H0
        flag_eyemonitorref_pd        = &H0
        write_eyem_refadjust_value = &H0
        flag_eyem_refadjust        = &H0
        write_sel_clk_value = &H0
        flag_sel_clk        = &H0
        write_Sigdet_threshold_value = &H0
        flag_Sigdet_threshold        = &H0
    End Sub
End Class


'' @REGISTER : RX_AFE_PMD__SGMIIPLUSR_X1_ctrl6
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' Eye_Monitor_PI_BW_sel                      [6:6]            get_Eye_Monitor_PI_BW_sel
''                                                             set_Eye_Monitor_PI_BW_sel
''                                                             read_Eye_Monitor_PI_BW_sel
''                                                             write_Eye_Monitor_PI_BW_sel
''---------------------------------------------------------------------------------
'' Eye_Monitor_PI_pwd_lvl2pi                  [5:5]            get_Eye_Monitor_PI_pwd_lvl2pi
''                                                             set_Eye_Monitor_PI_pwd_lvl2pi
''                                                             read_Eye_Monitor_PI_pwd_lvl2pi
''                                                             write_Eye_Monitor_PI_pwd_lvl2pi
''---------------------------------------------------------------------------------
'' PI_lowvdd_enb                              [3:3]            get_PI_lowvdd_enb
''                                                             set_PI_lowvdd_enb
''                                                             read_PI_lowvdd_enb
''                                                             write_PI_lowvdd_enb
''---------------------------------------------------------------------------------
'' Main_PI_BW_sel                             [2:2]            get_Main_PI_BW_sel
''                                                             set_Main_PI_BW_sel
''                                                             read_Main_PI_BW_sel
''                                                             write_Main_PI_BW_sel
''---------------------------------------------------------------------------------
'' Main_PI_pwd_lvl2pi                         [1:1]            get_Main_PI_pwd_lvl2pi
''                                                             set_Main_PI_pwd_lvl2pi
''                                                             read_Main_PI_pwd_lvl2pi
''                                                             write_Main_PI_pwd_lvl2pi
''---------------------------------------------------------------------------------
Class REGISTER_RX_AFE_PMD__SGMIIPLUSR_X1_ctrl6
    Private write_Eye_Monitor_PI_BW_sel_value
    Private read_Eye_Monitor_PI_BW_sel_value
    Private flag_Eye_Monitor_PI_BW_sel
    Private write_Eye_Monitor_PI_pwd_lvl2pi_value
    Private read_Eye_Monitor_PI_pwd_lvl2pi_value
    Private flag_Eye_Monitor_PI_pwd_lvl2pi
    Private write_PI_lowvdd_enb_value
    Private read_PI_lowvdd_enb_value
    Private flag_PI_lowvdd_enb
    Private write_Main_PI_BW_sel_value
    Private read_Main_PI_BW_sel_value
    Private flag_Main_PI_BW_sel
    Private write_Main_PI_pwd_lvl2pi_value
    Private read_Main_PI_pwd_lvl2pi_value
    Private flag_Main_PI_pwd_lvl2pi

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

    Property Get get_Eye_Monitor_PI_BW_sel
        get_Eye_Monitor_PI_BW_sel = read_Eye_Monitor_PI_BW_sel_value
    End Property

    Property Let set_Eye_Monitor_PI_BW_sel(aData)
        write_Eye_Monitor_PI_BW_sel_value = aData
        flag_Eye_Monitor_PI_BW_sel        = &H1
    End Property

    Property Get read_Eye_Monitor_PI_BW_sel
        read
        read_Eye_Monitor_PI_BW_sel = read_Eye_Monitor_PI_BW_sel_value
    End Property

    Property Let write_Eye_Monitor_PI_BW_sel(aData)
        set_Eye_Monitor_PI_BW_sel = aData
        write
    End Property

    Property Get get_Eye_Monitor_PI_pwd_lvl2pi
        get_Eye_Monitor_PI_pwd_lvl2pi = read_Eye_Monitor_PI_pwd_lvl2pi_value
    End Property

    Property Let set_Eye_Monitor_PI_pwd_lvl2pi(aData)
        write_Eye_Monitor_PI_pwd_lvl2pi_value = aData
        flag_Eye_Monitor_PI_pwd_lvl2pi        = &H1
    End Property

    Property Get read_Eye_Monitor_PI_pwd_lvl2pi
        read
        read_Eye_Monitor_PI_pwd_lvl2pi = read_Eye_Monitor_PI_pwd_lvl2pi_value
    End Property

    Property Let write_Eye_Monitor_PI_pwd_lvl2pi(aData)
        set_Eye_Monitor_PI_pwd_lvl2pi = aData
        write
    End Property

    Property Get get_PI_lowvdd_enb
        get_PI_lowvdd_enb = read_PI_lowvdd_enb_value
    End Property

    Property Let set_PI_lowvdd_enb(aData)
        write_PI_lowvdd_enb_value = aData
        flag_PI_lowvdd_enb        = &H1
    End Property

    Property Get read_PI_lowvdd_enb
        read
        read_PI_lowvdd_enb = read_PI_lowvdd_enb_value
    End Property

    Property Let write_PI_lowvdd_enb(aData)
        set_PI_lowvdd_enb = aData
        write
    End Property

    Property Get get_Main_PI_BW_sel
        get_Main_PI_BW_sel = read_Main_PI_BW_sel_value
    End Property

    Property Let set_Main_PI_BW_sel(aData)
        write_Main_PI_BW_sel_value = aData
        flag_Main_PI_BW_sel        = &H1
    End Property

    Property Get read_Main_PI_BW_sel
        read
        read_Main_PI_BW_sel = read_Main_PI_BW_sel_value
    End Property

    Property Let write_Main_PI_BW_sel(aData)
        set_Main_PI_BW_sel = aData
        write
    End Property

    Property Get get_Main_PI_pwd_lvl2pi
        get_Main_PI_pwd_lvl2pi = read_Main_PI_pwd_lvl2pi_value
    End Property

    Property Let set_Main_PI_pwd_lvl2pi(aData)
        write_Main_PI_pwd_lvl2pi_value = aData
        flag_Main_PI_pwd_lvl2pi        = &H1
    End Property

    Property Get read_Main_PI_pwd_lvl2pi
        read
        read_Main_PI_pwd_lvl2pi = read_Main_PI_pwd_lvl2pi_value
    End Property

    Property Let write_Main_PI_pwd_lvl2pi(aData)
        set_Main_PI_pwd_lvl2pi = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_Eye_Monitor_PI_BW_sel_value = rightShift(data_low, 6) and &H1
        read_Eye_Monitor_PI_pwd_lvl2pi_value = rightShift(data_low, 5) and &H1
        read_PI_lowvdd_enb_value = rightShift(data_low, 3) and &H1
        read_Main_PI_BW_sel_value = rightShift(data_low, 2) and &H1
        read_Main_PI_pwd_lvl2pi_value = rightShift(data_low, 1) and &H1

    End Sub

    Sub write
        If flag_Eye_Monitor_PI_BW_sel = &H0 or flag_Eye_Monitor_PI_pwd_lvl2pi = &H0 or flag_PI_lowvdd_enb = &H0 or flag_Main_PI_BW_sel = &H0 or flag_Main_PI_pwd_lvl2pi = &H0 Then read
        If flag_Eye_Monitor_PI_BW_sel = &H0 Then write_Eye_Monitor_PI_BW_sel_value = get_Eye_Monitor_PI_BW_sel
        If flag_Eye_Monitor_PI_pwd_lvl2pi = &H0 Then write_Eye_Monitor_PI_pwd_lvl2pi_value = get_Eye_Monitor_PI_pwd_lvl2pi
        If flag_PI_lowvdd_enb = &H0 Then write_PI_lowvdd_enb_value = get_PI_lowvdd_enb
        If flag_Main_PI_BW_sel = &H0 Then write_Main_PI_BW_sel_value = get_Main_PI_BW_sel
        If flag_Main_PI_pwd_lvl2pi = &H0 Then write_Main_PI_pwd_lvl2pi_value = get_Main_PI_pwd_lvl2pi

        regValue = leftShift((write_Eye_Monitor_PI_BW_sel_value and &H1), 6) + leftShift((write_Eye_Monitor_PI_pwd_lvl2pi_value and &H1), 5) + leftShift((write_PI_lowvdd_enb_value and &H1), 3) + leftShift((write_Main_PI_BW_sel_value and &H1), 2) + leftShift((write_Main_PI_pwd_lvl2pi_value and &H1), 1)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_Eye_Monitor_PI_BW_sel_value = rightShift(data_low, 6) and &H1
        read_Eye_Monitor_PI_pwd_lvl2pi_value = rightShift(data_low, 5) and &H1
        read_PI_lowvdd_enb_value = rightShift(data_low, 3) and &H1
        read_Main_PI_BW_sel_value = rightShift(data_low, 2) and &H1
        read_Main_PI_pwd_lvl2pi_value = rightShift(data_low, 1) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_Eye_Monitor_PI_BW_sel_value = &H0
        flag_Eye_Monitor_PI_BW_sel        = &H0
        write_Eye_Monitor_PI_pwd_lvl2pi_value = &H0
        flag_Eye_Monitor_PI_pwd_lvl2pi        = &H0
        write_PI_lowvdd_enb_value = &H0
        flag_PI_lowvdd_enb        = &H0
        write_Main_PI_BW_sel_value = &H0
        flag_Main_PI_BW_sel        = &H0
        write_Main_PI_pwd_lvl2pi_value = &H0
        flag_Main_PI_pwd_lvl2pi        = &H0
    End Sub
End Class


'' @REGISTER : RX_AFE_PMD__SGMIIPLUSR_X1_blockaddress
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
Class REGISTER_RX_AFE_PMD__SGMIIPLUSR_X1_blockaddress
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

Class RX_AFE_PMD__SGMIIPLUSR_X1_INSTANCE

    Public ctrl0
    Public ctrl1
    Public ctrl2
    Public ctrl3
    Public ctrl4
    Public ctrl5
    Public ctrl6
    Public blockaddress


    Public default function Init(aBaseAddr)
        Set ctrl0 = (New REGISTER_RX_AFE_PMD__SGMIIPLUSR_X1_ctrl0)(aBaseAddr, 16)
        Set ctrl1 = (New REGISTER_RX_AFE_PMD__SGMIIPLUSR_X1_ctrl1)(aBaseAddr, 16)
        Set ctrl2 = (New REGISTER_RX_AFE_PMD__SGMIIPLUSR_X1_ctrl2)(aBaseAddr, 16)
        Set ctrl3 = (New REGISTER_RX_AFE_PMD__SGMIIPLUSR_X1_ctrl3)(aBaseAddr, 16)
        Set ctrl4 = (New REGISTER_RX_AFE_PMD__SGMIIPLUSR_X1_ctrl4)(aBaseAddr, 16)
        Set ctrl5 = (New REGISTER_RX_AFE_PMD__SGMIIPLUSR_X1_ctrl5)(aBaseAddr, 16)
        Set ctrl6 = (New REGISTER_RX_AFE_PMD__SGMIIPLUSR_X1_ctrl6)(aBaseAddr, 16)
        Set blockaddress = (New REGISTER_RX_AFE_PMD__SGMIIPLUSR_X1_blockaddress)(aBaseAddr, 16)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set RX_AFE_PMD__SGMIIPLUSR_X1 = CreateObject("System.Collections.ArrayList")
RX_AFE_PMD__SGMIIPLUSR_X1.Add ((New RX_AFE_PMD__SGMIIPLUSR_X1_INSTANCE)(&H4ae50160))


