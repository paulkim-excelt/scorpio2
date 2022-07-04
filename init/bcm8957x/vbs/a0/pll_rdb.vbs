

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


'' @REGISTER : PLL_pllctrl_0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PLL_CTL                                    [15:0]           get_PLL_CTL
''                                                             set_PLL_CTL
''                                                             read_PLL_CTL
''                                                             write_PLL_CTL
''---------------------------------------------------------------------------------
Class REGISTER_PLL_pllctrl_0
    Private write_PLL_CTL_value
    Private read_PLL_CTL_value
    Private flag_PLL_CTL

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

    Property Get get_PLL_CTL
        get_PLL_CTL = read_PLL_CTL_value
    End Property

    Property Let set_PLL_CTL(aData)
        write_PLL_CTL_value = aData
        flag_PLL_CTL        = &H1
    End Property

    Property Get read_PLL_CTL
        read
        read_PLL_CTL = read_PLL_CTL_value
    End Property

    Property Let write_PLL_CTL(aData)
        set_PLL_CTL = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PLL_CTL_mask = &Hffff
        if data_low > LONG_MAX then
            if PLL_CTL_mask = mask then
                read_PLL_CTL_value = data_low
            else
                read_PLL_CTL_value = (data_low - H8000_0000) and PLL_CTL_mask
            end If
        else
            read_PLL_CTL_value = data_low and PLL_CTL_mask
        end If

    End Sub

    Sub write
        If flag_PLL_CTL = &H0 Then read
        If flag_PLL_CTL = &H0 Then write_PLL_CTL_value = get_PLL_CTL

        regValue = leftShift((write_PLL_CTL_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PLL_CTL_mask = &Hffff
        if data_low > LONG_MAX then
            if PLL_CTL_mask = mask then
                read_PLL_CTL_value = data_low
            else
                read_PLL_CTL_value = (data_low - H8000_0000) and PLL_CTL_mask
            end If
        else
            read_PLL_CTL_value = data_low and PLL_CTL_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PLL_CTL_value = &H0
        flag_PLL_CTL        = &H0
    End Sub
End Class


'' @REGISTER : PLL_pllctrl_1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PLL_CTL                                    [15:0]           get_PLL_CTL
''                                                             set_PLL_CTL
''                                                             read_PLL_CTL
''                                                             write_PLL_CTL
''---------------------------------------------------------------------------------
Class REGISTER_PLL_pllctrl_1
    Private write_PLL_CTL_value
    Private read_PLL_CTL_value
    Private flag_PLL_CTL

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

    Property Get get_PLL_CTL
        get_PLL_CTL = read_PLL_CTL_value
    End Property

    Property Let set_PLL_CTL(aData)
        write_PLL_CTL_value = aData
        flag_PLL_CTL        = &H1
    End Property

    Property Get read_PLL_CTL
        read
        read_PLL_CTL = read_PLL_CTL_value
    End Property

    Property Let write_PLL_CTL(aData)
        set_PLL_CTL = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PLL_CTL_mask = &Hffff
        if data_low > LONG_MAX then
            if PLL_CTL_mask = mask then
                read_PLL_CTL_value = data_low
            else
                read_PLL_CTL_value = (data_low - H8000_0000) and PLL_CTL_mask
            end If
        else
            read_PLL_CTL_value = data_low and PLL_CTL_mask
        end If

    End Sub

    Sub write
        If flag_PLL_CTL = &H0 Then read
        If flag_PLL_CTL = &H0 Then write_PLL_CTL_value = get_PLL_CTL

        regValue = leftShift((write_PLL_CTL_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PLL_CTL_mask = &Hffff
        if data_low > LONG_MAX then
            if PLL_CTL_mask = mask then
                read_PLL_CTL_value = data_low
            else
                read_PLL_CTL_value = (data_low - H8000_0000) and PLL_CTL_mask
            end If
        else
            read_PLL_CTL_value = data_low and PLL_CTL_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PLL_CTL_value = &H0
        flag_PLL_CTL        = &H0
    End Sub
End Class


'' @REGISTER : PLL_pllctrl_2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PLL_SPARE2                                 [15:14]          get_PLL_SPARE2
''                                                             set_PLL_SPARE2
''                                                             read_PLL_SPARE2
''                                                             write_PLL_SPARE2
''---------------------------------------------------------------------------------
'' PLL_PDIV                                   [13:10]          get_PLL_PDIV
''                                                             set_PLL_PDIV
''                                                             read_PLL_PDIV
''                                                             write_PLL_PDIV
''---------------------------------------------------------------------------------
'' PLL_SPARE2_2                               [9:0]            get_PLL_SPARE2_2
''                                                             set_PLL_SPARE2_2
''                                                             read_PLL_SPARE2_2
''                                                             write_PLL_SPARE2_2
''---------------------------------------------------------------------------------
Class REGISTER_PLL_pllctrl_2
    Private write_PLL_SPARE2_value
    Private read_PLL_SPARE2_value
    Private flag_PLL_SPARE2
    Private write_PLL_PDIV_value
    Private read_PLL_PDIV_value
    Private flag_PLL_PDIV
    Private write_PLL_SPARE2_2_value
    Private read_PLL_SPARE2_2_value
    Private flag_PLL_SPARE2_2

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

    Property Get get_PLL_SPARE2
        get_PLL_SPARE2 = read_PLL_SPARE2_value
    End Property

    Property Let set_PLL_SPARE2(aData)
        write_PLL_SPARE2_value = aData
        flag_PLL_SPARE2        = &H1
    End Property

    Property Get read_PLL_SPARE2
        read
        read_PLL_SPARE2 = read_PLL_SPARE2_value
    End Property

    Property Let write_PLL_SPARE2(aData)
        set_PLL_SPARE2 = aData
        write
    End Property

    Property Get get_PLL_PDIV
        get_PLL_PDIV = read_PLL_PDIV_value
    End Property

    Property Let set_PLL_PDIV(aData)
        write_PLL_PDIV_value = aData
        flag_PLL_PDIV        = &H1
    End Property

    Property Get read_PLL_PDIV
        read
        read_PLL_PDIV = read_PLL_PDIV_value
    End Property

    Property Let write_PLL_PDIV(aData)
        set_PLL_PDIV = aData
        write
    End Property

    Property Get get_PLL_SPARE2_2
        get_PLL_SPARE2_2 = read_PLL_SPARE2_2_value
    End Property

    Property Let set_PLL_SPARE2_2(aData)
        write_PLL_SPARE2_2_value = aData
        flag_PLL_SPARE2_2        = &H1
    End Property

    Property Get read_PLL_SPARE2_2
        read
        read_PLL_SPARE2_2 = read_PLL_SPARE2_2_value
    End Property

    Property Let write_PLL_SPARE2_2(aData)
        set_PLL_SPARE2_2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_PLL_SPARE2_value = rightShift(data_low, 14) and &H3
        read_PLL_PDIV_value = rightShift(data_low, 10) and &Hf
        PLL_SPARE2_2_mask = &H3ff
        if data_low > LONG_MAX then
            if PLL_SPARE2_2_mask = mask then
                read_PLL_SPARE2_2_value = data_low
            else
                read_PLL_SPARE2_2_value = (data_low - H8000_0000) and PLL_SPARE2_2_mask
            end If
        else
            read_PLL_SPARE2_2_value = data_low and PLL_SPARE2_2_mask
        end If

    End Sub

    Sub write
        If flag_PLL_SPARE2 = &H0 or flag_PLL_PDIV = &H0 or flag_PLL_SPARE2_2 = &H0 Then read
        If flag_PLL_SPARE2 = &H0 Then write_PLL_SPARE2_value = get_PLL_SPARE2
        If flag_PLL_PDIV = &H0 Then write_PLL_PDIV_value = get_PLL_PDIV
        If flag_PLL_SPARE2_2 = &H0 Then write_PLL_SPARE2_2_value = get_PLL_SPARE2_2

        regValue = leftShift((write_PLL_SPARE2_value and &H3), 14) + leftShift((write_PLL_PDIV_value and &Hf), 10) + leftShift((write_PLL_SPARE2_2_value and &H3ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_PLL_SPARE2_value = rightShift(data_low, 14) and &H3
        read_PLL_PDIV_value = rightShift(data_low, 10) and &Hf
        PLL_SPARE2_2_mask = &H3ff
        if data_low > LONG_MAX then
            if PLL_SPARE2_2_mask = mask then
                read_PLL_SPARE2_2_value = data_low
            else
                read_PLL_SPARE2_2_value = (data_low - H8000_0000) and PLL_SPARE2_2_mask
            end If
        else
            read_PLL_SPARE2_2_value = data_low and PLL_SPARE2_2_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PLL_SPARE2_value = &H0
        flag_PLL_SPARE2        = &H0
        write_PLL_PDIV_value = &H0
        flag_PLL_PDIV        = &H0
        write_PLL_SPARE2_2_value = &H0
        flag_PLL_SPARE2_2        = &H0
    End Sub
End Class


'' @REGISTER : PLL_pllctrl_3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PLL_SPARE3                                 [15:10]          get_PLL_SPARE3
''                                                             set_PLL_SPARE3
''                                                             read_PLL_SPARE3
''                                                             write_PLL_SPARE3
''---------------------------------------------------------------------------------
'' PLL_NDIV_INT_MS                            [9:0]            get_PLL_NDIV_INT_MS
''                                                             set_PLL_NDIV_INT_MS
''                                                             read_PLL_NDIV_INT_MS
''                                                             write_PLL_NDIV_INT_MS
''---------------------------------------------------------------------------------
Class REGISTER_PLL_pllctrl_3
    Private write_PLL_SPARE3_value
    Private read_PLL_SPARE3_value
    Private flag_PLL_SPARE3
    Private write_PLL_NDIV_INT_MS_value
    Private read_PLL_NDIV_INT_MS_value
    Private flag_PLL_NDIV_INT_MS

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

    Property Get get_PLL_SPARE3
        get_PLL_SPARE3 = read_PLL_SPARE3_value
    End Property

    Property Let set_PLL_SPARE3(aData)
        write_PLL_SPARE3_value = aData
        flag_PLL_SPARE3        = &H1
    End Property

    Property Get read_PLL_SPARE3
        read
        read_PLL_SPARE3 = read_PLL_SPARE3_value
    End Property

    Property Let write_PLL_SPARE3(aData)
        set_PLL_SPARE3 = aData
        write
    End Property

    Property Get get_PLL_NDIV_INT_MS
        get_PLL_NDIV_INT_MS = read_PLL_NDIV_INT_MS_value
    End Property

    Property Let set_PLL_NDIV_INT_MS(aData)
        write_PLL_NDIV_INT_MS_value = aData
        flag_PLL_NDIV_INT_MS        = &H1
    End Property

    Property Get read_PLL_NDIV_INT_MS
        read
        read_PLL_NDIV_INT_MS = read_PLL_NDIV_INT_MS_value
    End Property

    Property Let write_PLL_NDIV_INT_MS(aData)
        set_PLL_NDIV_INT_MS = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_PLL_SPARE3_value = rightShift(data_low, 10) and &H3f
        PLL_NDIV_INT_MS_mask = &H3ff
        if data_low > LONG_MAX then
            if PLL_NDIV_INT_MS_mask = mask then
                read_PLL_NDIV_INT_MS_value = data_low
            else
                read_PLL_NDIV_INT_MS_value = (data_low - H8000_0000) and PLL_NDIV_INT_MS_mask
            end If
        else
            read_PLL_NDIV_INT_MS_value = data_low and PLL_NDIV_INT_MS_mask
        end If

    End Sub

    Sub write
        If flag_PLL_SPARE3 = &H0 or flag_PLL_NDIV_INT_MS = &H0 Then read
        If flag_PLL_SPARE3 = &H0 Then write_PLL_SPARE3_value = get_PLL_SPARE3
        If flag_PLL_NDIV_INT_MS = &H0 Then write_PLL_NDIV_INT_MS_value = get_PLL_NDIV_INT_MS

        regValue = leftShift((write_PLL_SPARE3_value and &H3f), 10) + leftShift((write_PLL_NDIV_INT_MS_value and &H3ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_PLL_SPARE3_value = rightShift(data_low, 10) and &H3f
        PLL_NDIV_INT_MS_mask = &H3ff
        if data_low > LONG_MAX then
            if PLL_NDIV_INT_MS_mask = mask then
                read_PLL_NDIV_INT_MS_value = data_low
            else
                read_PLL_NDIV_INT_MS_value = (data_low - H8000_0000) and PLL_NDIV_INT_MS_mask
            end If
        else
            read_PLL_NDIV_INT_MS_value = data_low and PLL_NDIV_INT_MS_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PLL_SPARE3_value = &H0
        flag_PLL_SPARE3        = &H0
        write_PLL_NDIV_INT_MS_value = &H0
        flag_PLL_NDIV_INT_MS        = &H0
    End Sub
End Class


'' @REGISTER : PLL_pllctrl_4
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PLL_SPARE4                                 [15:15]          get_PLL_SPARE4
''                                                             set_PLL_SPARE4
''                                                             read_PLL_SPARE4
''                                                             write_PLL_SPARE4
''---------------------------------------------------------------------------------
'' SD_SEL_300mV                               [14:14]          get_SD_SEL_300mV
''                                                             set_SD_SEL_300mV
''                                                             read_SD_SEL_300mV
''                                                             write_SD_SEL_300mV
''---------------------------------------------------------------------------------
'' CML_BUF_TUNE                               [13:12]          get_CML_BUF_TUNE
''                                                             set_CML_BUF_TUNE
''                                                             read_CML_BUF_TUNE
''                                                             write_CML_BUF_TUNE
''---------------------------------------------------------------------------------
'' PLL_BIAS_BANDGAP                           [11:9]           get_PLL_BIAS_BANDGAP
''                                                             set_PLL_BIAS_BANDGAP
''                                                             read_PLL_BIAS_BANDGAP
''                                                             write_PLL_BIAS_BANDGAP
''---------------------------------------------------------------------------------
'' PLL_SPARE4a                                [8:6]            get_PLL_SPARE4a
''                                                             set_PLL_SPARE4a
''                                                             read_PLL_SPARE4a
''                                                             write_PLL_SPARE4a
''---------------------------------------------------------------------------------
'' ATEST_OR_BIAS_TEST_OUTPUT                  [5:5]            get_ATEST_OR_BIAS_TEST_OUTPUT
''                                                             set_ATEST_OR_BIAS_TEST_OUTPUT
''                                                             read_ATEST_OR_BIAS_TEST_OUTPUT
''                                                             write_ATEST_OR_BIAS_TEST_OUTPUT
''---------------------------------------------------------------------------------
'' PLL_MUX_ATEST                              [4:3]            get_PLL_MUX_ATEST
''                                                             set_PLL_MUX_ATEST
''                                                             read_PLL_MUX_ATEST
''                                                             write_PLL_MUX_ATEST
''---------------------------------------------------------------------------------
'' PLL_BIAS_TEST_MUX                          [2:0]            get_PLL_BIAS_TEST_MUX
''                                                             set_PLL_BIAS_TEST_MUX
''                                                             read_PLL_BIAS_TEST_MUX
''                                                             write_PLL_BIAS_TEST_MUX
''---------------------------------------------------------------------------------
Class REGISTER_PLL_pllctrl_4
    Private write_PLL_SPARE4_value
    Private read_PLL_SPARE4_value
    Private flag_PLL_SPARE4
    Private write_SD_SEL_300mV_value
    Private read_SD_SEL_300mV_value
    Private flag_SD_SEL_300mV
    Private write_CML_BUF_TUNE_value
    Private read_CML_BUF_TUNE_value
    Private flag_CML_BUF_TUNE
    Private write_PLL_BIAS_BANDGAP_value
    Private read_PLL_BIAS_BANDGAP_value
    Private flag_PLL_BIAS_BANDGAP
    Private write_PLL_SPARE4a_value
    Private read_PLL_SPARE4a_value
    Private flag_PLL_SPARE4a
    Private write_ATEST_OR_BIAS_TEST_OUTPUT_value
    Private read_ATEST_OR_BIAS_TEST_OUTPUT_value
    Private flag_ATEST_OR_BIAS_TEST_OUTPUT
    Private write_PLL_MUX_ATEST_value
    Private read_PLL_MUX_ATEST_value
    Private flag_PLL_MUX_ATEST
    Private write_PLL_BIAS_TEST_MUX_value
    Private read_PLL_BIAS_TEST_MUX_value
    Private flag_PLL_BIAS_TEST_MUX

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

    Property Get get_PLL_SPARE4
        get_PLL_SPARE4 = read_PLL_SPARE4_value
    End Property

    Property Let set_PLL_SPARE4(aData)
        write_PLL_SPARE4_value = aData
        flag_PLL_SPARE4        = &H1
    End Property

    Property Get read_PLL_SPARE4
        read
        read_PLL_SPARE4 = read_PLL_SPARE4_value
    End Property

    Property Let write_PLL_SPARE4(aData)
        set_PLL_SPARE4 = aData
        write
    End Property

    Property Get get_SD_SEL_300mV
        get_SD_SEL_300mV = read_SD_SEL_300mV_value
    End Property

    Property Let set_SD_SEL_300mV(aData)
        write_SD_SEL_300mV_value = aData
        flag_SD_SEL_300mV        = &H1
    End Property

    Property Get read_SD_SEL_300mV
        read
        read_SD_SEL_300mV = read_SD_SEL_300mV_value
    End Property

    Property Let write_SD_SEL_300mV(aData)
        set_SD_SEL_300mV = aData
        write
    End Property

    Property Get get_CML_BUF_TUNE
        get_CML_BUF_TUNE = read_CML_BUF_TUNE_value
    End Property

    Property Let set_CML_BUF_TUNE(aData)
        write_CML_BUF_TUNE_value = aData
        flag_CML_BUF_TUNE        = &H1
    End Property

    Property Get read_CML_BUF_TUNE
        read
        read_CML_BUF_TUNE = read_CML_BUF_TUNE_value
    End Property

    Property Let write_CML_BUF_TUNE(aData)
        set_CML_BUF_TUNE = aData
        write
    End Property

    Property Get get_PLL_BIAS_BANDGAP
        get_PLL_BIAS_BANDGAP = read_PLL_BIAS_BANDGAP_value
    End Property

    Property Let set_PLL_BIAS_BANDGAP(aData)
        write_PLL_BIAS_BANDGAP_value = aData
        flag_PLL_BIAS_BANDGAP        = &H1
    End Property

    Property Get read_PLL_BIAS_BANDGAP
        read
        read_PLL_BIAS_BANDGAP = read_PLL_BIAS_BANDGAP_value
    End Property

    Property Let write_PLL_BIAS_BANDGAP(aData)
        set_PLL_BIAS_BANDGAP = aData
        write
    End Property

    Property Get get_PLL_SPARE4a
        get_PLL_SPARE4a = read_PLL_SPARE4a_value
    End Property

    Property Let set_PLL_SPARE4a(aData)
        write_PLL_SPARE4a_value = aData
        flag_PLL_SPARE4a        = &H1
    End Property

    Property Get read_PLL_SPARE4a
        read
        read_PLL_SPARE4a = read_PLL_SPARE4a_value
    End Property

    Property Let write_PLL_SPARE4a(aData)
        set_PLL_SPARE4a = aData
        write
    End Property

    Property Get get_ATEST_OR_BIAS_TEST_OUTPUT
        get_ATEST_OR_BIAS_TEST_OUTPUT = read_ATEST_OR_BIAS_TEST_OUTPUT_value
    End Property

    Property Let set_ATEST_OR_BIAS_TEST_OUTPUT(aData)
        write_ATEST_OR_BIAS_TEST_OUTPUT_value = aData
        flag_ATEST_OR_BIAS_TEST_OUTPUT        = &H1
    End Property

    Property Get read_ATEST_OR_BIAS_TEST_OUTPUT
        read
        read_ATEST_OR_BIAS_TEST_OUTPUT = read_ATEST_OR_BIAS_TEST_OUTPUT_value
    End Property

    Property Let write_ATEST_OR_BIAS_TEST_OUTPUT(aData)
        set_ATEST_OR_BIAS_TEST_OUTPUT = aData
        write
    End Property

    Property Get get_PLL_MUX_ATEST
        get_PLL_MUX_ATEST = read_PLL_MUX_ATEST_value
    End Property

    Property Let set_PLL_MUX_ATEST(aData)
        write_PLL_MUX_ATEST_value = aData
        flag_PLL_MUX_ATEST        = &H1
    End Property

    Property Get read_PLL_MUX_ATEST
        read
        read_PLL_MUX_ATEST = read_PLL_MUX_ATEST_value
    End Property

    Property Let write_PLL_MUX_ATEST(aData)
        set_PLL_MUX_ATEST = aData
        write
    End Property

    Property Get get_PLL_BIAS_TEST_MUX
        get_PLL_BIAS_TEST_MUX = read_PLL_BIAS_TEST_MUX_value
    End Property

    Property Let set_PLL_BIAS_TEST_MUX(aData)
        write_PLL_BIAS_TEST_MUX_value = aData
        flag_PLL_BIAS_TEST_MUX        = &H1
    End Property

    Property Get read_PLL_BIAS_TEST_MUX
        read
        read_PLL_BIAS_TEST_MUX = read_PLL_BIAS_TEST_MUX_value
    End Property

    Property Let write_PLL_BIAS_TEST_MUX(aData)
        set_PLL_BIAS_TEST_MUX = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_PLL_SPARE4_value = rightShift(data_low, 15) and &H1
        read_SD_SEL_300mV_value = rightShift(data_low, 14) and &H1
        read_CML_BUF_TUNE_value = rightShift(data_low, 12) and &H3
        read_PLL_BIAS_BANDGAP_value = rightShift(data_low, 9) and &H7
        read_PLL_SPARE4a_value = rightShift(data_low, 6) and &H7
        read_ATEST_OR_BIAS_TEST_OUTPUT_value = rightShift(data_low, 5) and &H1
        read_PLL_MUX_ATEST_value = rightShift(data_low, 3) and &H3
        PLL_BIAS_TEST_MUX_mask = &H7
        if data_low > LONG_MAX then
            if PLL_BIAS_TEST_MUX_mask = mask then
                read_PLL_BIAS_TEST_MUX_value = data_low
            else
                read_PLL_BIAS_TEST_MUX_value = (data_low - H8000_0000) and PLL_BIAS_TEST_MUX_mask
            end If
        else
            read_PLL_BIAS_TEST_MUX_value = data_low and PLL_BIAS_TEST_MUX_mask
        end If

    End Sub

    Sub write
        If flag_PLL_SPARE4 = &H0 or flag_SD_SEL_300mV = &H0 or flag_CML_BUF_TUNE = &H0 or flag_PLL_BIAS_BANDGAP = &H0 or flag_PLL_SPARE4a = &H0 or flag_ATEST_OR_BIAS_TEST_OUTPUT = &H0 or flag_PLL_MUX_ATEST = &H0 or flag_PLL_BIAS_TEST_MUX = &H0 Then read
        If flag_PLL_SPARE4 = &H0 Then write_PLL_SPARE4_value = get_PLL_SPARE4
        If flag_SD_SEL_300mV = &H0 Then write_SD_SEL_300mV_value = get_SD_SEL_300mV
        If flag_CML_BUF_TUNE = &H0 Then write_CML_BUF_TUNE_value = get_CML_BUF_TUNE
        If flag_PLL_BIAS_BANDGAP = &H0 Then write_PLL_BIAS_BANDGAP_value = get_PLL_BIAS_BANDGAP
        If flag_PLL_SPARE4a = &H0 Then write_PLL_SPARE4a_value = get_PLL_SPARE4a
        If flag_ATEST_OR_BIAS_TEST_OUTPUT = &H0 Then write_ATEST_OR_BIAS_TEST_OUTPUT_value = get_ATEST_OR_BIAS_TEST_OUTPUT
        If flag_PLL_MUX_ATEST = &H0 Then write_PLL_MUX_ATEST_value = get_PLL_MUX_ATEST
        If flag_PLL_BIAS_TEST_MUX = &H0 Then write_PLL_BIAS_TEST_MUX_value = get_PLL_BIAS_TEST_MUX

        regValue = leftShift((write_PLL_SPARE4_value and &H1), 15) + leftShift((write_SD_SEL_300mV_value and &H1), 14) + leftShift((write_CML_BUF_TUNE_value and &H3), 12) + leftShift((write_PLL_BIAS_BANDGAP_value and &H7), 9) + leftShift((write_PLL_SPARE4a_value and &H7), 6) + leftShift((write_ATEST_OR_BIAS_TEST_OUTPUT_value and &H1), 5) + leftShift((write_PLL_MUX_ATEST_value and &H3), 3) + leftShift((write_PLL_BIAS_TEST_MUX_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_PLL_SPARE4_value = rightShift(data_low, 15) and &H1
        read_SD_SEL_300mV_value = rightShift(data_low, 14) and &H1
        read_CML_BUF_TUNE_value = rightShift(data_low, 12) and &H3
        read_PLL_BIAS_BANDGAP_value = rightShift(data_low, 9) and &H7
        read_PLL_SPARE4a_value = rightShift(data_low, 6) and &H7
        read_ATEST_OR_BIAS_TEST_OUTPUT_value = rightShift(data_low, 5) and &H1
        read_PLL_MUX_ATEST_value = rightShift(data_low, 3) and &H3
        PLL_BIAS_TEST_MUX_mask = &H7
        if data_low > LONG_MAX then
            if PLL_BIAS_TEST_MUX_mask = mask then
                read_PLL_BIAS_TEST_MUX_value = data_low
            else
                read_PLL_BIAS_TEST_MUX_value = (data_low - H8000_0000) and PLL_BIAS_TEST_MUX_mask
            end If
        else
            read_PLL_BIAS_TEST_MUX_value = data_low and PLL_BIAS_TEST_MUX_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PLL_SPARE4_value = &H0
        flag_PLL_SPARE4        = &H0
        write_SD_SEL_300mV_value = &H0
        flag_SD_SEL_300mV        = &H0
        write_CML_BUF_TUNE_value = &H0
        flag_CML_BUF_TUNE        = &H0
        write_PLL_BIAS_BANDGAP_value = &H0
        flag_PLL_BIAS_BANDGAP        = &H0
        write_PLL_SPARE4a_value = &H0
        flag_PLL_SPARE4a        = &H0
        write_ATEST_OR_BIAS_TEST_OUTPUT_value = &H0
        flag_ATEST_OR_BIAS_TEST_OUTPUT        = &H0
        write_PLL_MUX_ATEST_value = &H0
        flag_PLL_MUX_ATEST        = &H0
        write_PLL_BIAS_TEST_MUX_value = &H0
        flag_PLL_BIAS_TEST_MUX        = &H0
    End Sub
End Class


'' @REGISTER : PLL_pllctrl_5
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PLL_SPARE5                                 [15:14]          get_PLL_SPARE5
''                                                             set_PLL_SPARE5
''                                                             read_PLL_SPARE5
''                                                             write_PLL_SPARE5
''---------------------------------------------------------------------------------
'' PLL_CP                                     [13:13]          get_PLL_CP
''                                                             set_PLL_CP
''                                                             read_PLL_CP
''                                                             write_PLL_CP
''---------------------------------------------------------------------------------
'' PLL_CP1                                    [12:12]          get_PLL_CP1
''                                                             set_PLL_CP1
''                                                             read_PLL_CP1
''                                                             write_PLL_CP1
''---------------------------------------------------------------------------------
'' PLL_CZ                                     [11:11]          get_PLL_CZ
''                                                             set_PLL_CZ
''                                                             read_PLL_CZ
''                                                             write_PLL_CZ
''---------------------------------------------------------------------------------
'' PLL_RZ                                     [10:7]           get_PLL_RZ
''                                                             set_PLL_RZ
''                                                             read_PLL_RZ
''                                                             write_PLL_RZ
''---------------------------------------------------------------------------------
'' PLL_ICP                                    [6:3]            get_PLL_ICP
''                                                             set_PLL_ICP
''                                                             read_PLL_ICP
''                                                             write_PLL_ICP
''---------------------------------------------------------------------------------
'' PLL_VCO_GAIN                               [2:0]            get_PLL_VCO_GAIN
''                                                             set_PLL_VCO_GAIN
''                                                             read_PLL_VCO_GAIN
''                                                             write_PLL_VCO_GAIN
''---------------------------------------------------------------------------------
Class REGISTER_PLL_pllctrl_5
    Private write_PLL_SPARE5_value
    Private read_PLL_SPARE5_value
    Private flag_PLL_SPARE5
    Private write_PLL_CP_value
    Private read_PLL_CP_value
    Private flag_PLL_CP
    Private write_PLL_CP1_value
    Private read_PLL_CP1_value
    Private flag_PLL_CP1
    Private write_PLL_CZ_value
    Private read_PLL_CZ_value
    Private flag_PLL_CZ
    Private write_PLL_RZ_value
    Private read_PLL_RZ_value
    Private flag_PLL_RZ
    Private write_PLL_ICP_value
    Private read_PLL_ICP_value
    Private flag_PLL_ICP
    Private write_PLL_VCO_GAIN_value
    Private read_PLL_VCO_GAIN_value
    Private flag_PLL_VCO_GAIN

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

    Property Get get_PLL_SPARE5
        get_PLL_SPARE5 = read_PLL_SPARE5_value
    End Property

    Property Let set_PLL_SPARE5(aData)
        write_PLL_SPARE5_value = aData
        flag_PLL_SPARE5        = &H1
    End Property

    Property Get read_PLL_SPARE5
        read
        read_PLL_SPARE5 = read_PLL_SPARE5_value
    End Property

    Property Let write_PLL_SPARE5(aData)
        set_PLL_SPARE5 = aData
        write
    End Property

    Property Get get_PLL_CP
        get_PLL_CP = read_PLL_CP_value
    End Property

    Property Let set_PLL_CP(aData)
        write_PLL_CP_value = aData
        flag_PLL_CP        = &H1
    End Property

    Property Get read_PLL_CP
        read
        read_PLL_CP = read_PLL_CP_value
    End Property

    Property Let write_PLL_CP(aData)
        set_PLL_CP = aData
        write
    End Property

    Property Get get_PLL_CP1
        get_PLL_CP1 = read_PLL_CP1_value
    End Property

    Property Let set_PLL_CP1(aData)
        write_PLL_CP1_value = aData
        flag_PLL_CP1        = &H1
    End Property

    Property Get read_PLL_CP1
        read
        read_PLL_CP1 = read_PLL_CP1_value
    End Property

    Property Let write_PLL_CP1(aData)
        set_PLL_CP1 = aData
        write
    End Property

    Property Get get_PLL_CZ
        get_PLL_CZ = read_PLL_CZ_value
    End Property

    Property Let set_PLL_CZ(aData)
        write_PLL_CZ_value = aData
        flag_PLL_CZ        = &H1
    End Property

    Property Get read_PLL_CZ
        read
        read_PLL_CZ = read_PLL_CZ_value
    End Property

    Property Let write_PLL_CZ(aData)
        set_PLL_CZ = aData
        write
    End Property

    Property Get get_PLL_RZ
        get_PLL_RZ = read_PLL_RZ_value
    End Property

    Property Let set_PLL_RZ(aData)
        write_PLL_RZ_value = aData
        flag_PLL_RZ        = &H1
    End Property

    Property Get read_PLL_RZ
        read
        read_PLL_RZ = read_PLL_RZ_value
    End Property

    Property Let write_PLL_RZ(aData)
        set_PLL_RZ = aData
        write
    End Property

    Property Get get_PLL_ICP
        get_PLL_ICP = read_PLL_ICP_value
    End Property

    Property Let set_PLL_ICP(aData)
        write_PLL_ICP_value = aData
        flag_PLL_ICP        = &H1
    End Property

    Property Get read_PLL_ICP
        read
        read_PLL_ICP = read_PLL_ICP_value
    End Property

    Property Let write_PLL_ICP(aData)
        set_PLL_ICP = aData
        write
    End Property

    Property Get get_PLL_VCO_GAIN
        get_PLL_VCO_GAIN = read_PLL_VCO_GAIN_value
    End Property

    Property Let set_PLL_VCO_GAIN(aData)
        write_PLL_VCO_GAIN_value = aData
        flag_PLL_VCO_GAIN        = &H1
    End Property

    Property Get read_PLL_VCO_GAIN
        read
        read_PLL_VCO_GAIN = read_PLL_VCO_GAIN_value
    End Property

    Property Let write_PLL_VCO_GAIN(aData)
        set_PLL_VCO_GAIN = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_PLL_SPARE5_value = rightShift(data_low, 14) and &H3
        read_PLL_CP_value = rightShift(data_low, 13) and &H1
        read_PLL_CP1_value = rightShift(data_low, 12) and &H1
        read_PLL_CZ_value = rightShift(data_low, 11) and &H1
        read_PLL_RZ_value = rightShift(data_low, 7) and &Hf
        read_PLL_ICP_value = rightShift(data_low, 3) and &Hf
        PLL_VCO_GAIN_mask = &H7
        if data_low > LONG_MAX then
            if PLL_VCO_GAIN_mask = mask then
                read_PLL_VCO_GAIN_value = data_low
            else
                read_PLL_VCO_GAIN_value = (data_low - H8000_0000) and PLL_VCO_GAIN_mask
            end If
        else
            read_PLL_VCO_GAIN_value = data_low and PLL_VCO_GAIN_mask
        end If

    End Sub

    Sub write
        If flag_PLL_SPARE5 = &H0 or flag_PLL_CP = &H0 or flag_PLL_CP1 = &H0 or flag_PLL_CZ = &H0 or flag_PLL_RZ = &H0 or flag_PLL_ICP = &H0 or flag_PLL_VCO_GAIN = &H0 Then read
        If flag_PLL_SPARE5 = &H0 Then write_PLL_SPARE5_value = get_PLL_SPARE5
        If flag_PLL_CP = &H0 Then write_PLL_CP_value = get_PLL_CP
        If flag_PLL_CP1 = &H0 Then write_PLL_CP1_value = get_PLL_CP1
        If flag_PLL_CZ = &H0 Then write_PLL_CZ_value = get_PLL_CZ
        If flag_PLL_RZ = &H0 Then write_PLL_RZ_value = get_PLL_RZ
        If flag_PLL_ICP = &H0 Then write_PLL_ICP_value = get_PLL_ICP
        If flag_PLL_VCO_GAIN = &H0 Then write_PLL_VCO_GAIN_value = get_PLL_VCO_GAIN

        regValue = leftShift((write_PLL_SPARE5_value and &H3), 14) + leftShift((write_PLL_CP_value and &H1), 13) + leftShift((write_PLL_CP1_value and &H1), 12) + leftShift((write_PLL_CZ_value and &H1), 11) + leftShift((write_PLL_RZ_value and &Hf), 7) + leftShift((write_PLL_ICP_value and &Hf), 3) + leftShift((write_PLL_VCO_GAIN_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_PLL_SPARE5_value = rightShift(data_low, 14) and &H3
        read_PLL_CP_value = rightShift(data_low, 13) and &H1
        read_PLL_CP1_value = rightShift(data_low, 12) and &H1
        read_PLL_CZ_value = rightShift(data_low, 11) and &H1
        read_PLL_RZ_value = rightShift(data_low, 7) and &Hf
        read_PLL_ICP_value = rightShift(data_low, 3) and &Hf
        PLL_VCO_GAIN_mask = &H7
        if data_low > LONG_MAX then
            if PLL_VCO_GAIN_mask = mask then
                read_PLL_VCO_GAIN_value = data_low
            else
                read_PLL_VCO_GAIN_value = (data_low - H8000_0000) and PLL_VCO_GAIN_mask
            end If
        else
            read_PLL_VCO_GAIN_value = data_low and PLL_VCO_GAIN_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PLL_SPARE5_value = &H0
        flag_PLL_SPARE5        = &H0
        write_PLL_CP_value = &H0
        flag_PLL_CP        = &H0
        write_PLL_CP1_value = &H0
        flag_PLL_CP1        = &H0
        write_PLL_CZ_value = &H0
        flag_PLL_CZ        = &H0
        write_PLL_RZ_value = &H0
        flag_PLL_RZ        = &H0
        write_PLL_ICP_value = &H0
        flag_PLL_ICP        = &H0
        write_PLL_VCO_GAIN_value = &H0
        flag_PLL_VCO_GAIN        = &H0
    End Sub
End Class


'' @REGISTER : PLL_pllctrl_6
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PLL_SPARE6                                 [15:9]           get_PLL_SPARE6
''                                                             set_PLL_SPARE6
''                                                             read_PLL_SPARE6
''                                                             write_PLL_SPARE6
''---------------------------------------------------------------------------------
'' POR_CONFIG                                 [8:7]            get_POR_CONFIG
''                                                             set_POR_CONFIG
''                                                             read_POR_CONFIG
''                                                             write_POR_CONFIG
''---------------------------------------------------------------------------------
'' CLK500_EN                                  [6:6]            get_CLK500_EN
''                                                             set_CLK500_EN
''                                                             read_CLK500_EN
''                                                             write_CLK500_EN
''---------------------------------------------------------------------------------
'' RCAL_OFFSET                                [5:3]            get_RCAL_OFFSET
''                                                             set_RCAL_OFFSET
''                                                             read_RCAL_OFFSET
''                                                             write_RCAL_OFFSET
''---------------------------------------------------------------------------------
'' RCCAL_OFFSET                               [2:0]            get_RCCAL_OFFSET
''                                                             set_RCCAL_OFFSET
''                                                             read_RCCAL_OFFSET
''                                                             write_RCCAL_OFFSET
''---------------------------------------------------------------------------------
Class REGISTER_PLL_pllctrl_6
    Private write_PLL_SPARE6_value
    Private read_PLL_SPARE6_value
    Private flag_PLL_SPARE6
    Private write_POR_CONFIG_value
    Private read_POR_CONFIG_value
    Private flag_POR_CONFIG
    Private write_CLK500_EN_value
    Private read_CLK500_EN_value
    Private flag_CLK500_EN
    Private write_RCAL_OFFSET_value
    Private read_RCAL_OFFSET_value
    Private flag_RCAL_OFFSET
    Private write_RCCAL_OFFSET_value
    Private read_RCCAL_OFFSET_value
    Private flag_RCCAL_OFFSET

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

    Property Get get_PLL_SPARE6
        get_PLL_SPARE6 = read_PLL_SPARE6_value
    End Property

    Property Let set_PLL_SPARE6(aData)
        write_PLL_SPARE6_value = aData
        flag_PLL_SPARE6        = &H1
    End Property

    Property Get read_PLL_SPARE6
        read
        read_PLL_SPARE6 = read_PLL_SPARE6_value
    End Property

    Property Let write_PLL_SPARE6(aData)
        set_PLL_SPARE6 = aData
        write
    End Property

    Property Get get_POR_CONFIG
        get_POR_CONFIG = read_POR_CONFIG_value
    End Property

    Property Let set_POR_CONFIG(aData)
        write_POR_CONFIG_value = aData
        flag_POR_CONFIG        = &H1
    End Property

    Property Get read_POR_CONFIG
        read
        read_POR_CONFIG = read_POR_CONFIG_value
    End Property

    Property Let write_POR_CONFIG(aData)
        set_POR_CONFIG = aData
        write
    End Property

    Property Get get_CLK500_EN
        get_CLK500_EN = read_CLK500_EN_value
    End Property

    Property Let set_CLK500_EN(aData)
        write_CLK500_EN_value = aData
        flag_CLK500_EN        = &H1
    End Property

    Property Get read_CLK500_EN
        read
        read_CLK500_EN = read_CLK500_EN_value
    End Property

    Property Let write_CLK500_EN(aData)
        set_CLK500_EN = aData
        write
    End Property

    Property Get get_RCAL_OFFSET
        get_RCAL_OFFSET = read_RCAL_OFFSET_value
    End Property

    Property Let set_RCAL_OFFSET(aData)
        write_RCAL_OFFSET_value = aData
        flag_RCAL_OFFSET        = &H1
    End Property

    Property Get read_RCAL_OFFSET
        read
        read_RCAL_OFFSET = read_RCAL_OFFSET_value
    End Property

    Property Let write_RCAL_OFFSET(aData)
        set_RCAL_OFFSET = aData
        write
    End Property

    Property Get get_RCCAL_OFFSET
        get_RCCAL_OFFSET = read_RCCAL_OFFSET_value
    End Property

    Property Let set_RCCAL_OFFSET(aData)
        write_RCCAL_OFFSET_value = aData
        flag_RCCAL_OFFSET        = &H1
    End Property

    Property Get read_RCCAL_OFFSET
        read
        read_RCCAL_OFFSET = read_RCCAL_OFFSET_value
    End Property

    Property Let write_RCCAL_OFFSET(aData)
        set_RCCAL_OFFSET = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_PLL_SPARE6_value = rightShift(data_low, 9) and &H7f
        read_POR_CONFIG_value = rightShift(data_low, 7) and &H3
        read_CLK500_EN_value = rightShift(data_low, 6) and &H1
        read_RCAL_OFFSET_value = rightShift(data_low, 3) and &H7
        RCCAL_OFFSET_mask = &H7
        if data_low > LONG_MAX then
            if RCCAL_OFFSET_mask = mask then
                read_RCCAL_OFFSET_value = data_low
            else
                read_RCCAL_OFFSET_value = (data_low - H8000_0000) and RCCAL_OFFSET_mask
            end If
        else
            read_RCCAL_OFFSET_value = data_low and RCCAL_OFFSET_mask
        end If

    End Sub

    Sub write
        If flag_PLL_SPARE6 = &H0 or flag_POR_CONFIG = &H0 or flag_CLK500_EN = &H0 or flag_RCAL_OFFSET = &H0 or flag_RCCAL_OFFSET = &H0 Then read
        If flag_PLL_SPARE6 = &H0 Then write_PLL_SPARE6_value = get_PLL_SPARE6
        If flag_POR_CONFIG = &H0 Then write_POR_CONFIG_value = get_POR_CONFIG
        If flag_CLK500_EN = &H0 Then write_CLK500_EN_value = get_CLK500_EN
        If flag_RCAL_OFFSET = &H0 Then write_RCAL_OFFSET_value = get_RCAL_OFFSET
        If flag_RCCAL_OFFSET = &H0 Then write_RCCAL_OFFSET_value = get_RCCAL_OFFSET

        regValue = leftShift((write_PLL_SPARE6_value and &H7f), 9) + leftShift((write_POR_CONFIG_value and &H3), 7) + leftShift((write_CLK500_EN_value and &H1), 6) + leftShift((write_RCAL_OFFSET_value and &H7), 3) + leftShift((write_RCCAL_OFFSET_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_PLL_SPARE6_value = rightShift(data_low, 9) and &H7f
        read_POR_CONFIG_value = rightShift(data_low, 7) and &H3
        read_CLK500_EN_value = rightShift(data_low, 6) and &H1
        read_RCAL_OFFSET_value = rightShift(data_low, 3) and &H7
        RCCAL_OFFSET_mask = &H7
        if data_low > LONG_MAX then
            if RCCAL_OFFSET_mask = mask then
                read_RCCAL_OFFSET_value = data_low
            else
                read_RCCAL_OFFSET_value = (data_low - H8000_0000) and RCCAL_OFFSET_mask
            end If
        else
            read_RCCAL_OFFSET_value = data_low and RCCAL_OFFSET_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PLL_SPARE6_value = &H0
        flag_PLL_SPARE6        = &H0
        write_POR_CONFIG_value = &H0
        flag_POR_CONFIG        = &H0
        write_CLK500_EN_value = &H0
        flag_CLK500_EN        = &H0
        write_RCAL_OFFSET_value = &H0
        flag_RCAL_OFFSET        = &H0
        write_RCCAL_OFFSET_value = &H0
        flag_RCCAL_OFFSET        = &H0
    End Sub
End Class


'' @REGISTER : PLL_pll_status_0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PLL_STATUS_WORD                            [11:0]           get_PLL_STATUS_WORD
''                                                             set_PLL_STATUS_WORD
''                                                             read_PLL_STATUS_WORD
''                                                             write_PLL_STATUS_WORD
''---------------------------------------------------------------------------------
Class REGISTER_PLL_pll_status_0
    Private write_PLL_STATUS_WORD_value
    Private read_PLL_STATUS_WORD_value
    Private flag_PLL_STATUS_WORD

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

    Property Get get_PLL_STATUS_WORD
        get_PLL_STATUS_WORD = read_PLL_STATUS_WORD_value
    End Property

    Property Let set_PLL_STATUS_WORD(aData)
        write_PLL_STATUS_WORD_value = aData
        flag_PLL_STATUS_WORD        = &H1
    End Property

    Property Get read_PLL_STATUS_WORD
        read
        read_PLL_STATUS_WORD = read_PLL_STATUS_WORD_value
    End Property

    Property Let write_PLL_STATUS_WORD(aData)
        set_PLL_STATUS_WORD = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PLL_STATUS_WORD_mask = &Hfff
        if data_low > LONG_MAX then
            if PLL_STATUS_WORD_mask = mask then
                read_PLL_STATUS_WORD_value = data_low
            else
                read_PLL_STATUS_WORD_value = (data_low - H8000_0000) and PLL_STATUS_WORD_mask
            end If
        else
            read_PLL_STATUS_WORD_value = data_low and PLL_STATUS_WORD_mask
        end If

    End Sub

    Sub write
        If flag_PLL_STATUS_WORD = &H0 Then read
        If flag_PLL_STATUS_WORD = &H0 Then write_PLL_STATUS_WORD_value = get_PLL_STATUS_WORD

        regValue = leftShift((write_PLL_STATUS_WORD_value and &Hfff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PLL_STATUS_WORD_mask = &Hfff
        if data_low > LONG_MAX then
            if PLL_STATUS_WORD_mask = mask then
                read_PLL_STATUS_WORD_value = data_low
            else
                read_PLL_STATUS_WORD_value = (data_low - H8000_0000) and PLL_STATUS_WORD_mask
            end If
        else
            read_PLL_STATUS_WORD_value = data_low and PLL_STATUS_WORD_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PLL_STATUS_WORD_value = &H0
        flag_PLL_STATUS_WORD        = &H0
    End Sub
End Class


'' @REGISTER : PLL_pll_status_1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PLL_LOCK                                   [8:8]            get_PLL_LOCK
''                                                             set_PLL_LOCK
''                                                             read_PLL_LOCK
''                                                             write_PLL_LOCK
''---------------------------------------------------------------------------------
'' PLL_BER                                    [3:0]            get_PLL_BER
''                                                             set_PLL_BER
''                                                             read_PLL_BER
''                                                             write_PLL_BER
''---------------------------------------------------------------------------------
Class REGISTER_PLL_pll_status_1
    Private write_PLL_LOCK_value
    Private read_PLL_LOCK_value
    Private flag_PLL_LOCK
    Private write_PLL_BER_value
    Private read_PLL_BER_value
    Private flag_PLL_BER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H22
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_PLL_LOCK
        get_PLL_LOCK = read_PLL_LOCK_value
    End Property

    Property Let set_PLL_LOCK(aData)
        write_PLL_LOCK_value = aData
        flag_PLL_LOCK        = &H1
    End Property

    Property Get read_PLL_LOCK
        read
        read_PLL_LOCK = read_PLL_LOCK_value
    End Property

    Property Let write_PLL_LOCK(aData)
        set_PLL_LOCK = aData
        write
    End Property

    Property Get get_PLL_BER
        get_PLL_BER = read_PLL_BER_value
    End Property

    Property Let set_PLL_BER(aData)
        write_PLL_BER_value = aData
        flag_PLL_BER        = &H1
    End Property

    Property Get read_PLL_BER
        read
        read_PLL_BER = read_PLL_BER_value
    End Property

    Property Let write_PLL_BER(aData)
        set_PLL_BER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_PLL_LOCK_value = rightShift(data_low, 8) and &H1
        PLL_BER_mask = &Hf
        if data_low > LONG_MAX then
            if PLL_BER_mask = mask then
                read_PLL_BER_value = data_low
            else
                read_PLL_BER_value = (data_low - H8000_0000) and PLL_BER_mask
            end If
        else
            read_PLL_BER_value = data_low and PLL_BER_mask
        end If

    End Sub

    Sub write
        If flag_PLL_LOCK = &H0 or flag_PLL_BER = &H0 Then read
        If flag_PLL_LOCK = &H0 Then write_PLL_LOCK_value = get_PLL_LOCK
        If flag_PLL_BER = &H0 Then write_PLL_BER_value = get_PLL_BER

        regValue = leftShift((write_PLL_LOCK_value and &H1), 8) + leftShift((write_PLL_BER_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_PLL_LOCK_value = rightShift(data_low, 8) and &H1
        PLL_BER_mask = &Hf
        if data_low > LONG_MAX then
            if PLL_BER_mask = mask then
                read_PLL_BER_value = data_low
            else
                read_PLL_BER_value = (data_low - H8000_0000) and PLL_BER_mask
            end If
        else
            read_PLL_BER_value = data_low and PLL_BER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PLL_LOCK_value = &H0
        flag_PLL_LOCK        = &H0
        write_PLL_BER_value = &H0
        flag_PLL_BER        = &H0
    End Sub
End Class


'' @REGISTER : PLL_afe_sigdet_status
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' CHANNEL_SIGSTATE                           [6:1]            get_CHANNEL_SIGSTATE
''                                                             set_CHANNEL_SIGSTATE
''                                                             read_CHANNEL_SIGSTATE
''                                                             write_CHANNEL_SIGSTATE
''---------------------------------------------------------------------------------
'' CHANNEL_Select                             [0:0]            get_CHANNEL_Select
''                                                             set_CHANNEL_Select
''                                                             read_CHANNEL_Select
''                                                             write_CHANNEL_Select
''---------------------------------------------------------------------------------
Class REGISTER_PLL_afe_sigdet_status
    Private write_CHANNEL_SIGSTATE_value
    Private read_CHANNEL_SIGSTATE_value
    Private flag_CHANNEL_SIGSTATE
    Private write_CHANNEL_Select_value
    Private read_CHANNEL_Select_value
    Private flag_CHANNEL_Select

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

    Property Get get_CHANNEL_SIGSTATE
        get_CHANNEL_SIGSTATE = read_CHANNEL_SIGSTATE_value
    End Property

    Property Let set_CHANNEL_SIGSTATE(aData)
        write_CHANNEL_SIGSTATE_value = aData
        flag_CHANNEL_SIGSTATE        = &H1
    End Property

    Property Get read_CHANNEL_SIGSTATE
        read
        read_CHANNEL_SIGSTATE = read_CHANNEL_SIGSTATE_value
    End Property

    Property Let write_CHANNEL_SIGSTATE(aData)
        set_CHANNEL_SIGSTATE = aData
        write
    End Property

    Property Get get_CHANNEL_Select
        get_CHANNEL_Select = read_CHANNEL_Select_value
    End Property

    Property Let set_CHANNEL_Select(aData)
        write_CHANNEL_Select_value = aData
        flag_CHANNEL_Select        = &H1
    End Property

    Property Get read_CHANNEL_Select
        read
        read_CHANNEL_Select = read_CHANNEL_Select_value
    End Property

    Property Let write_CHANNEL_Select(aData)
        set_CHANNEL_Select = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_CHANNEL_SIGSTATE_value = rightShift(data_low, 1) and &H3f
        CHANNEL_Select_mask = &H1
        if data_low > LONG_MAX then
            if CHANNEL_Select_mask = mask then
                read_CHANNEL_Select_value = data_low
            else
                read_CHANNEL_Select_value = (data_low - H8000_0000) and CHANNEL_Select_mask
            end If
        else
            read_CHANNEL_Select_value = data_low and CHANNEL_Select_mask
        end If

    End Sub

    Sub write
        If flag_CHANNEL_SIGSTATE = &H0 or flag_CHANNEL_Select = &H0 Then read
        If flag_CHANNEL_SIGSTATE = &H0 Then write_CHANNEL_SIGSTATE_value = get_CHANNEL_SIGSTATE
        If flag_CHANNEL_Select = &H0 Then write_CHANNEL_Select_value = get_CHANNEL_Select

        regValue = leftShift((write_CHANNEL_SIGSTATE_value and &H3f), 1) + leftShift((write_CHANNEL_Select_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_CHANNEL_SIGSTATE_value = rightShift(data_low, 1) and &H3f
        CHANNEL_Select_mask = &H1
        if data_low > LONG_MAX then
            if CHANNEL_Select_mask = mask then
                read_CHANNEL_Select_value = data_low
            else
                read_CHANNEL_Select_value = (data_low - H8000_0000) and CHANNEL_Select_mask
            end If
        else
            read_CHANNEL_Select_value = data_low and CHANNEL_Select_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_CHANNEL_SIGSTATE_value = &H0
        flag_CHANNEL_SIGSTATE        = &H0
        write_CHANNEL_Select_value = &H0
        flag_CHANNEL_Select        = &H0
    End Sub
End Class


'' @REGISTER : PLL_pllctrl_7
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TVCO_MUX_EN                                [15:15]          get_TVCO_MUX_EN
''                                                             set_TVCO_MUX_EN
''                                                             read_TVCO_MUX_EN
''                                                             write_TVCO_MUX_EN
''---------------------------------------------------------------------------------
'' TVCO_PAD                                   [14:12]          get_TVCO_PAD
''                                                             set_TVCO_PAD
''                                                             read_TVCO_PAD
''                                                             write_TVCO_PAD
''---------------------------------------------------------------------------------
'' ADJUST_AUX_LDO                             [11:11]          get_ADJUST_AUX_LDO
''                                                             set_ADJUST_AUX_LDO
''                                                             read_ADJUST_AUX_LDO
''                                                             write_ADJUST_AUX_LDO
''---------------------------------------------------------------------------------
'' CLAMP_REFERENCE                            [10:9]           get_CLAMP_REFERENCE
''                                                             set_CLAMP_REFERENCE
''                                                             read_CLAMP_REFERENCE
''                                                             write_CLAMP_REFERENCE
''---------------------------------------------------------------------------------
'' CML_BUFFER_PWRDN                           [8:8]            get_CML_BUFFER_PWRDN
''                                                             set_CML_BUFFER_PWRDN
''                                                             read_CML_BUFFER_PWRDN
''                                                             write_CML_BUFFER_PWRDN
''---------------------------------------------------------------------------------
'' TXCLK_PWRDN                                [7:4]            get_TXCLK_PWRDN
''                                                             set_TXCLK_PWRDN
''                                                             read_TXCLK_PWRDN
''                                                             write_TXCLK_PWRDN
''---------------------------------------------------------------------------------
'' RXCLK_PWRDN                                [3:0]            get_RXCLK_PWRDN
''                                                             set_RXCLK_PWRDN
''                                                             read_RXCLK_PWRDN
''                                                             write_RXCLK_PWRDN
''---------------------------------------------------------------------------------
Class REGISTER_PLL_pllctrl_7
    Private write_TVCO_MUX_EN_value
    Private read_TVCO_MUX_EN_value
    Private flag_TVCO_MUX_EN
    Private write_TVCO_PAD_value
    Private read_TVCO_PAD_value
    Private flag_TVCO_PAD
    Private write_ADJUST_AUX_LDO_value
    Private read_ADJUST_AUX_LDO_value
    Private flag_ADJUST_AUX_LDO
    Private write_CLAMP_REFERENCE_value
    Private read_CLAMP_REFERENCE_value
    Private flag_CLAMP_REFERENCE
    Private write_CML_BUFFER_PWRDN_value
    Private read_CML_BUFFER_PWRDN_value
    Private flag_CML_BUFFER_PWRDN
    Private write_TXCLK_PWRDN_value
    Private read_TXCLK_PWRDN_value
    Private flag_TXCLK_PWRDN
    Private write_RXCLK_PWRDN_value
    Private read_RXCLK_PWRDN_value
    Private flag_RXCLK_PWRDN

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H26
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_TVCO_MUX_EN
        get_TVCO_MUX_EN = read_TVCO_MUX_EN_value
    End Property

    Property Let set_TVCO_MUX_EN(aData)
        write_TVCO_MUX_EN_value = aData
        flag_TVCO_MUX_EN        = &H1
    End Property

    Property Get read_TVCO_MUX_EN
        read
        read_TVCO_MUX_EN = read_TVCO_MUX_EN_value
    End Property

    Property Let write_TVCO_MUX_EN(aData)
        set_TVCO_MUX_EN = aData
        write
    End Property

    Property Get get_TVCO_PAD
        get_TVCO_PAD = read_TVCO_PAD_value
    End Property

    Property Let set_TVCO_PAD(aData)
        write_TVCO_PAD_value = aData
        flag_TVCO_PAD        = &H1
    End Property

    Property Get read_TVCO_PAD
        read
        read_TVCO_PAD = read_TVCO_PAD_value
    End Property

    Property Let write_TVCO_PAD(aData)
        set_TVCO_PAD = aData
        write
    End Property

    Property Get get_ADJUST_AUX_LDO
        get_ADJUST_AUX_LDO = read_ADJUST_AUX_LDO_value
    End Property

    Property Let set_ADJUST_AUX_LDO(aData)
        write_ADJUST_AUX_LDO_value = aData
        flag_ADJUST_AUX_LDO        = &H1
    End Property

    Property Get read_ADJUST_AUX_LDO
        read
        read_ADJUST_AUX_LDO = read_ADJUST_AUX_LDO_value
    End Property

    Property Let write_ADJUST_AUX_LDO(aData)
        set_ADJUST_AUX_LDO = aData
        write
    End Property

    Property Get get_CLAMP_REFERENCE
        get_CLAMP_REFERENCE = read_CLAMP_REFERENCE_value
    End Property

    Property Let set_CLAMP_REFERENCE(aData)
        write_CLAMP_REFERENCE_value = aData
        flag_CLAMP_REFERENCE        = &H1
    End Property

    Property Get read_CLAMP_REFERENCE
        read
        read_CLAMP_REFERENCE = read_CLAMP_REFERENCE_value
    End Property

    Property Let write_CLAMP_REFERENCE(aData)
        set_CLAMP_REFERENCE = aData
        write
    End Property

    Property Get get_CML_BUFFER_PWRDN
        get_CML_BUFFER_PWRDN = read_CML_BUFFER_PWRDN_value
    End Property

    Property Let set_CML_BUFFER_PWRDN(aData)
        write_CML_BUFFER_PWRDN_value = aData
        flag_CML_BUFFER_PWRDN        = &H1
    End Property

    Property Get read_CML_BUFFER_PWRDN
        read
        read_CML_BUFFER_PWRDN = read_CML_BUFFER_PWRDN_value
    End Property

    Property Let write_CML_BUFFER_PWRDN(aData)
        set_CML_BUFFER_PWRDN = aData
        write
    End Property

    Property Get get_TXCLK_PWRDN
        get_TXCLK_PWRDN = read_TXCLK_PWRDN_value
    End Property

    Property Let set_TXCLK_PWRDN(aData)
        write_TXCLK_PWRDN_value = aData
        flag_TXCLK_PWRDN        = &H1
    End Property

    Property Get read_TXCLK_PWRDN
        read
        read_TXCLK_PWRDN = read_TXCLK_PWRDN_value
    End Property

    Property Let write_TXCLK_PWRDN(aData)
        set_TXCLK_PWRDN = aData
        write
    End Property

    Property Get get_RXCLK_PWRDN
        get_RXCLK_PWRDN = read_RXCLK_PWRDN_value
    End Property

    Property Let set_RXCLK_PWRDN(aData)
        write_RXCLK_PWRDN_value = aData
        flag_RXCLK_PWRDN        = &H1
    End Property

    Property Get read_RXCLK_PWRDN
        read
        read_RXCLK_PWRDN = read_RXCLK_PWRDN_value
    End Property

    Property Let write_RXCLK_PWRDN(aData)
        set_RXCLK_PWRDN = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TVCO_MUX_EN_value = rightShift(data_low, 15) and &H1
        read_TVCO_PAD_value = rightShift(data_low, 12) and &H7
        read_ADJUST_AUX_LDO_value = rightShift(data_low, 11) and &H1
        read_CLAMP_REFERENCE_value = rightShift(data_low, 9) and &H3
        read_CML_BUFFER_PWRDN_value = rightShift(data_low, 8) and &H1
        read_TXCLK_PWRDN_value = rightShift(data_low, 4) and &Hf
        RXCLK_PWRDN_mask = &Hf
        if data_low > LONG_MAX then
            if RXCLK_PWRDN_mask = mask then
                read_RXCLK_PWRDN_value = data_low
            else
                read_RXCLK_PWRDN_value = (data_low - H8000_0000) and RXCLK_PWRDN_mask
            end If
        else
            read_RXCLK_PWRDN_value = data_low and RXCLK_PWRDN_mask
        end If

    End Sub

    Sub write
        If flag_TVCO_MUX_EN = &H0 or flag_TVCO_PAD = &H0 or flag_ADJUST_AUX_LDO = &H0 or flag_CLAMP_REFERENCE = &H0 or flag_CML_BUFFER_PWRDN = &H0 or flag_TXCLK_PWRDN = &H0 or flag_RXCLK_PWRDN = &H0 Then read
        If flag_TVCO_MUX_EN = &H0 Then write_TVCO_MUX_EN_value = get_TVCO_MUX_EN
        If flag_TVCO_PAD = &H0 Then write_TVCO_PAD_value = get_TVCO_PAD
        If flag_ADJUST_AUX_LDO = &H0 Then write_ADJUST_AUX_LDO_value = get_ADJUST_AUX_LDO
        If flag_CLAMP_REFERENCE = &H0 Then write_CLAMP_REFERENCE_value = get_CLAMP_REFERENCE
        If flag_CML_BUFFER_PWRDN = &H0 Then write_CML_BUFFER_PWRDN_value = get_CML_BUFFER_PWRDN
        If flag_TXCLK_PWRDN = &H0 Then write_TXCLK_PWRDN_value = get_TXCLK_PWRDN
        If flag_RXCLK_PWRDN = &H0 Then write_RXCLK_PWRDN_value = get_RXCLK_PWRDN

        regValue = leftShift((write_TVCO_MUX_EN_value and &H1), 15) + leftShift((write_TVCO_PAD_value and &H7), 12) + leftShift((write_ADJUST_AUX_LDO_value and &H1), 11) + leftShift((write_CLAMP_REFERENCE_value and &H3), 9) + leftShift((write_CML_BUFFER_PWRDN_value and &H1), 8) + leftShift((write_TXCLK_PWRDN_value and &Hf), 4) + leftShift((write_RXCLK_PWRDN_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TVCO_MUX_EN_value = rightShift(data_low, 15) and &H1
        read_TVCO_PAD_value = rightShift(data_low, 12) and &H7
        read_ADJUST_AUX_LDO_value = rightShift(data_low, 11) and &H1
        read_CLAMP_REFERENCE_value = rightShift(data_low, 9) and &H3
        read_CML_BUFFER_PWRDN_value = rightShift(data_low, 8) and &H1
        read_TXCLK_PWRDN_value = rightShift(data_low, 4) and &Hf
        RXCLK_PWRDN_mask = &Hf
        if data_low > LONG_MAX then
            if RXCLK_PWRDN_mask = mask then
                read_RXCLK_PWRDN_value = data_low
            else
                read_RXCLK_PWRDN_value = (data_low - H8000_0000) and RXCLK_PWRDN_mask
            end If
        else
            read_RXCLK_PWRDN_value = data_low and RXCLK_PWRDN_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TVCO_MUX_EN_value = &H0
        flag_TVCO_MUX_EN        = &H0
        write_TVCO_PAD_value = &H0
        flag_TVCO_PAD        = &H0
        write_ADJUST_AUX_LDO_value = &H0
        flag_ADJUST_AUX_LDO        = &H0
        write_CLAMP_REFERENCE_value = &H0
        flag_CLAMP_REFERENCE        = &H0
        write_CML_BUFFER_PWRDN_value = &H0
        flag_CML_BUFFER_PWRDN        = &H0
        write_TXCLK_PWRDN_value = &H0
        flag_TXCLK_PWRDN        = &H0
        write_RXCLK_PWRDN_value = &H0
        flag_RXCLK_PWRDN        = &H0
    End Sub
End Class


'' @REGISTER : PLL_pllctrl_8
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PLL_SPARE5                                 [15:1]           get_PLL_SPARE5
''                                                             set_PLL_SPARE5
''                                                             read_PLL_SPARE5
''                                                             write_PLL_SPARE5
''---------------------------------------------------------------------------------
'' PC_CLK_1G_PWRDN                            [0:0]            get_PC_CLK_1G_PWRDN
''                                                             set_PC_CLK_1G_PWRDN
''                                                             read_PC_CLK_1G_PWRDN
''                                                             write_PC_CLK_1G_PWRDN
''---------------------------------------------------------------------------------
Class REGISTER_PLL_pllctrl_8
    Private write_PLL_SPARE5_value
    Private read_PLL_SPARE5_value
    Private flag_PLL_SPARE5
    Private write_PC_CLK_1G_PWRDN_value
    Private read_PC_CLK_1G_PWRDN_value
    Private flag_PC_CLK_1G_PWRDN

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

    Property Get get_PLL_SPARE5
        get_PLL_SPARE5 = read_PLL_SPARE5_value
    End Property

    Property Let set_PLL_SPARE5(aData)
        write_PLL_SPARE5_value = aData
        flag_PLL_SPARE5        = &H1
    End Property

    Property Get read_PLL_SPARE5
        read
        read_PLL_SPARE5 = read_PLL_SPARE5_value
    End Property

    Property Let write_PLL_SPARE5(aData)
        set_PLL_SPARE5 = aData
        write
    End Property

    Property Get get_PC_CLK_1G_PWRDN
        get_PC_CLK_1G_PWRDN = read_PC_CLK_1G_PWRDN_value
    End Property

    Property Let set_PC_CLK_1G_PWRDN(aData)
        write_PC_CLK_1G_PWRDN_value = aData
        flag_PC_CLK_1G_PWRDN        = &H1
    End Property

    Property Get read_PC_CLK_1G_PWRDN
        read
        read_PC_CLK_1G_PWRDN = read_PC_CLK_1G_PWRDN_value
    End Property

    Property Let write_PC_CLK_1G_PWRDN(aData)
        set_PC_CLK_1G_PWRDN = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_PLL_SPARE5_value = rightShift(data_low, 1) and &H7fff
        PC_CLK_1G_PWRDN_mask = &H1
        if data_low > LONG_MAX then
            if PC_CLK_1G_PWRDN_mask = mask then
                read_PC_CLK_1G_PWRDN_value = data_low
            else
                read_PC_CLK_1G_PWRDN_value = (data_low - H8000_0000) and PC_CLK_1G_PWRDN_mask
            end If
        else
            read_PC_CLK_1G_PWRDN_value = data_low and PC_CLK_1G_PWRDN_mask
        end If

    End Sub

    Sub write
        If flag_PLL_SPARE5 = &H0 or flag_PC_CLK_1G_PWRDN = &H0 Then read
        If flag_PLL_SPARE5 = &H0 Then write_PLL_SPARE5_value = get_PLL_SPARE5
        If flag_PC_CLK_1G_PWRDN = &H0 Then write_PC_CLK_1G_PWRDN_value = get_PC_CLK_1G_PWRDN

        regValue = leftShift((write_PLL_SPARE5_value and &H7fff), 1) + leftShift((write_PC_CLK_1G_PWRDN_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_PLL_SPARE5_value = rightShift(data_low, 1) and &H7fff
        PC_CLK_1G_PWRDN_mask = &H1
        if data_low > LONG_MAX then
            if PC_CLK_1G_PWRDN_mask = mask then
                read_PC_CLK_1G_PWRDN_value = data_low
            else
                read_PC_CLK_1G_PWRDN_value = (data_low - H8000_0000) and PC_CLK_1G_PWRDN_mask
            end If
        else
            read_PC_CLK_1G_PWRDN_value = data_low and PC_CLK_1G_PWRDN_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PLL_SPARE5_value = &H0
        flag_PLL_SPARE5        = &H0
        write_PC_CLK_1G_PWRDN_value = &H0
        flag_PC_CLK_1G_PWRDN        = &H0
    End Sub
End Class


'' @REGISTER : PLL_pllctrl_9
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PLL_NDIV_FRAC0                             [15:0]           get_PLL_NDIV_FRAC0
''                                                             set_PLL_NDIV_FRAC0
''                                                             read_PLL_NDIV_FRAC0
''                                                             write_PLL_NDIV_FRAC0
''---------------------------------------------------------------------------------
Class REGISTER_PLL_pllctrl_9
    Private write_PLL_NDIV_FRAC0_value
    Private read_PLL_NDIV_FRAC0_value
    Private flag_PLL_NDIV_FRAC0

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H2a
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_PLL_NDIV_FRAC0
        get_PLL_NDIV_FRAC0 = read_PLL_NDIV_FRAC0_value
    End Property

    Property Let set_PLL_NDIV_FRAC0(aData)
        write_PLL_NDIV_FRAC0_value = aData
        flag_PLL_NDIV_FRAC0        = &H1
    End Property

    Property Get read_PLL_NDIV_FRAC0
        read
        read_PLL_NDIV_FRAC0 = read_PLL_NDIV_FRAC0_value
    End Property

    Property Let write_PLL_NDIV_FRAC0(aData)
        set_PLL_NDIV_FRAC0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PLL_NDIV_FRAC0_mask = &Hffff
        if data_low > LONG_MAX then
            if PLL_NDIV_FRAC0_mask = mask then
                read_PLL_NDIV_FRAC0_value = data_low
            else
                read_PLL_NDIV_FRAC0_value = (data_low - H8000_0000) and PLL_NDIV_FRAC0_mask
            end If
        else
            read_PLL_NDIV_FRAC0_value = data_low and PLL_NDIV_FRAC0_mask
        end If

    End Sub

    Sub write
        If flag_PLL_NDIV_FRAC0 = &H0 Then read
        If flag_PLL_NDIV_FRAC0 = &H0 Then write_PLL_NDIV_FRAC0_value = get_PLL_NDIV_FRAC0

        regValue = leftShift((write_PLL_NDIV_FRAC0_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PLL_NDIV_FRAC0_mask = &Hffff
        if data_low > LONG_MAX then
            if PLL_NDIV_FRAC0_mask = mask then
                read_PLL_NDIV_FRAC0_value = data_low
            else
                read_PLL_NDIV_FRAC0_value = (data_low - H8000_0000) and PLL_NDIV_FRAC0_mask
            end If
        else
            read_PLL_NDIV_FRAC0_value = data_low and PLL_NDIV_FRAC0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PLL_NDIV_FRAC0_value = &H0
        flag_PLL_NDIV_FRAC0        = &H0
    End Sub
End Class


'' @REGISTER : PLL_pllctrl_10
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PLL_NDIV_FRAC1                             [3:0]            get_PLL_NDIV_FRAC1
''                                                             set_PLL_NDIV_FRAC1
''                                                             read_PLL_NDIV_FRAC1
''                                                             write_PLL_NDIV_FRAC1
''---------------------------------------------------------------------------------
Class REGISTER_PLL_pllctrl_10
    Private write_PLL_NDIV_FRAC1_value
    Private read_PLL_NDIV_FRAC1_value
    Private flag_PLL_NDIV_FRAC1

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

    Property Get get_PLL_NDIV_FRAC1
        get_PLL_NDIV_FRAC1 = read_PLL_NDIV_FRAC1_value
    End Property

    Property Let set_PLL_NDIV_FRAC1(aData)
        write_PLL_NDIV_FRAC1_value = aData
        flag_PLL_NDIV_FRAC1        = &H1
    End Property

    Property Get read_PLL_NDIV_FRAC1
        read
        read_PLL_NDIV_FRAC1 = read_PLL_NDIV_FRAC1_value
    End Property

    Property Let write_PLL_NDIV_FRAC1(aData)
        set_PLL_NDIV_FRAC1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PLL_NDIV_FRAC1_mask = &Hf
        if data_low > LONG_MAX then
            if PLL_NDIV_FRAC1_mask = mask then
                read_PLL_NDIV_FRAC1_value = data_low
            else
                read_PLL_NDIV_FRAC1_value = (data_low - H8000_0000) and PLL_NDIV_FRAC1_mask
            end If
        else
            read_PLL_NDIV_FRAC1_value = data_low and PLL_NDIV_FRAC1_mask
        end If

    End Sub

    Sub write
        If flag_PLL_NDIV_FRAC1 = &H0 Then read
        If flag_PLL_NDIV_FRAC1 = &H0 Then write_PLL_NDIV_FRAC1_value = get_PLL_NDIV_FRAC1

        regValue = leftShift((write_PLL_NDIV_FRAC1_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PLL_NDIV_FRAC1_mask = &Hf
        if data_low > LONG_MAX then
            if PLL_NDIV_FRAC1_mask = mask then
                read_PLL_NDIV_FRAC1_value = data_low
            else
                read_PLL_NDIV_FRAC1_value = (data_low - H8000_0000) and PLL_NDIV_FRAC1_mask
            end If
        else
            read_PLL_NDIV_FRAC1_value = data_low and PLL_NDIV_FRAC1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PLL_NDIV_FRAC1_value = &H0
        flag_PLL_NDIV_FRAC1        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class PLL_INSTANCE

    Public pllctrl_0
    Public pllctrl_1
    Public pllctrl_2
    Public pllctrl_3
    Public pllctrl_4
    Public pllctrl_5
    Public pllctrl_6
    Public pll_status_0
    Public pll_status_1
    Public afe_sigdet_status
    Public pllctrl_7
    Public pllctrl_8
    Public pllctrl_9
    Public pllctrl_10


    Public default function Init(aBaseAddr)
        Set pllctrl_0 = (New REGISTER_PLL_pllctrl_0)(aBaseAddr, 16)
        Set pllctrl_1 = (New REGISTER_PLL_pllctrl_1)(aBaseAddr, 16)
        Set pllctrl_2 = (New REGISTER_PLL_pllctrl_2)(aBaseAddr, 16)
        Set pllctrl_3 = (New REGISTER_PLL_pllctrl_3)(aBaseAddr, 16)
        Set pllctrl_4 = (New REGISTER_PLL_pllctrl_4)(aBaseAddr, 16)
        Set pllctrl_5 = (New REGISTER_PLL_pllctrl_5)(aBaseAddr, 16)
        Set pllctrl_6 = (New REGISTER_PLL_pllctrl_6)(aBaseAddr, 16)
        Set pll_status_0 = (New REGISTER_PLL_pll_status_0)(aBaseAddr, 16)
        Set pll_status_1 = (New REGISTER_PLL_pll_status_1)(aBaseAddr, 16)
        Set afe_sigdet_status = (New REGISTER_PLL_afe_sigdet_status)(aBaseAddr, 16)
        Set pllctrl_7 = (New REGISTER_PLL_pllctrl_7)(aBaseAddr, 16)
        Set pllctrl_8 = (New REGISTER_PLL_pllctrl_8)(aBaseAddr, 16)
        Set pllctrl_9 = (New REGISTER_PLL_pllctrl_9)(aBaseAddr, 16)
        Set pllctrl_10 = (New REGISTER_PLL_pllctrl_10)(aBaseAddr, 16)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set PLL = CreateObject("System.Collections.ArrayList")
PLL.Add ((New PLL_INSTANCE)(&H4a4f2380))
PLL.Add ((New PLL_INSTANCE)(&H494f2380))
PLL.Add ((New PLL_INSTANCE)(&H498f2380))
PLL.Add ((New PLL_INSTANCE)(&H49cf2380))
PLL.Add ((New PLL_INSTANCE)(&H4a0f2380))


