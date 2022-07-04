

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


'' @REGISTER : TX_PMD_TEST_SGMIIPLUSR_X1_SGMIIPLUSR_X1_txpmd_prbsgenctrl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TTME                                       [7:7]            get_TTME
''                                                             set_TTME
''                                                             read_TTME
''                                                             write_TTME
''---------------------------------------------------------------------------------
'' TBO                                        [6:6]            get_TBO
''                                                             set_TBO
''                                                             read_TBO
''                                                             write_TBO
''---------------------------------------------------------------------------------
'' TTS                                        [5:5]            get_TTS
''                                                             set_TTS
''                                                             read_TTS
''                                                             write_TTS
''---------------------------------------------------------------------------------
'' TPE                                        [4:4]            get_TPE
''                                                             set_TPE
''                                                             read_TPE
''                                                             write_TPE
''---------------------------------------------------------------------------------
'' TPI                                        [3:3]            get_TPI
''                                                             set_TPI
''                                                             read_TPI
''                                                             write_TPI
''---------------------------------------------------------------------------------
'' TPO                                        [2:0]            get_TPO
''                                                             set_TPO
''                                                             read_TPO
''                                                             write_TPO
''---------------------------------------------------------------------------------
Class REGISTER_TX_PMD_TEST_SGMIIPLUSR_X1_SGMIIPLUSR_X1_txpmd_prbsgenctrl
    Private write_TTME_value
    Private read_TTME_value
    Private flag_TTME
    Private write_TBO_value
    Private read_TBO_value
    Private flag_TBO
    Private write_TTS_value
    Private read_TTS_value
    Private flag_TTS
    Private write_TPE_value
    Private read_TPE_value
    Private flag_TPE
    Private write_TPI_value
    Private read_TPI_value
    Private flag_TPI
    Private write_TPO_value
    Private read_TPO_value
    Private flag_TPO

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

    Property Get get_TTME
        get_TTME = read_TTME_value
    End Property

    Property Let set_TTME(aData)
        write_TTME_value = aData
        flag_TTME        = &H1
    End Property

    Property Get read_TTME
        read
        read_TTME = read_TTME_value
    End Property

    Property Let write_TTME(aData)
        set_TTME = aData
        write
    End Property

    Property Get get_TBO
        get_TBO = read_TBO_value
    End Property

    Property Let set_TBO(aData)
        write_TBO_value = aData
        flag_TBO        = &H1
    End Property

    Property Get read_TBO
        read
        read_TBO = read_TBO_value
    End Property

    Property Let write_TBO(aData)
        set_TBO = aData
        write
    End Property

    Property Get get_TTS
        get_TTS = read_TTS_value
    End Property

    Property Let set_TTS(aData)
        write_TTS_value = aData
        flag_TTS        = &H1
    End Property

    Property Get read_TTS
        read
        read_TTS = read_TTS_value
    End Property

    Property Let write_TTS(aData)
        set_TTS = aData
        write
    End Property

    Property Get get_TPE
        get_TPE = read_TPE_value
    End Property

    Property Let set_TPE(aData)
        write_TPE_value = aData
        flag_TPE        = &H1
    End Property

    Property Get read_TPE
        read
        read_TPE = read_TPE_value
    End Property

    Property Let write_TPE(aData)
        set_TPE = aData
        write
    End Property

    Property Get get_TPI
        get_TPI = read_TPI_value
    End Property

    Property Let set_TPI(aData)
        write_TPI_value = aData
        flag_TPI        = &H1
    End Property

    Property Get read_TPI
        read
        read_TPI = read_TPI_value
    End Property

    Property Let write_TPI(aData)
        set_TPI = aData
        write
    End Property

    Property Get get_TPO
        get_TPO = read_TPO_value
    End Property

    Property Let set_TPO(aData)
        write_TPO_value = aData
        flag_TPO        = &H1
    End Property

    Property Get read_TPO
        read
        read_TPO = read_TPO_value
    End Property

    Property Let write_TPO(aData)
        set_TPO = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TTME_value = rightShift(data_low, 7) and &H1
        read_TBO_value = rightShift(data_low, 6) and &H1
        read_TTS_value = rightShift(data_low, 5) and &H1
        read_TPE_value = rightShift(data_low, 4) and &H1
        read_TPI_value = rightShift(data_low, 3) and &H1
        TPO_mask = &H7
        if data_low > LONG_MAX then
            if TPO_mask = mask then
                read_TPO_value = data_low
            else
                read_TPO_value = (data_low - H8000_0000) and TPO_mask
            end If
        else
            read_TPO_value = data_low and TPO_mask
        end If

    End Sub

    Sub write
        If flag_TTME = &H0 or flag_TBO = &H0 or flag_TTS = &H0 or flag_TPE = &H0 or flag_TPI = &H0 or flag_TPO = &H0 Then read
        If flag_TTME = &H0 Then write_TTME_value = get_TTME
        If flag_TBO = &H0 Then write_TBO_value = get_TBO
        If flag_TTS = &H0 Then write_TTS_value = get_TTS
        If flag_TPE = &H0 Then write_TPE_value = get_TPE
        If flag_TPI = &H0 Then write_TPI_value = get_TPI
        If flag_TPO = &H0 Then write_TPO_value = get_TPO

        regValue = leftShift((write_TTME_value and &H1), 7) + leftShift((write_TBO_value and &H1), 6) + leftShift((write_TTS_value and &H1), 5) + leftShift((write_TPE_value and &H1), 4) + leftShift((write_TPI_value and &H1), 3) + leftShift((write_TPO_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TTME_value = rightShift(data_low, 7) and &H1
        read_TBO_value = rightShift(data_low, 6) and &H1
        read_TTS_value = rightShift(data_low, 5) and &H1
        read_TPE_value = rightShift(data_low, 4) and &H1
        read_TPI_value = rightShift(data_low, 3) and &H1
        TPO_mask = &H7
        if data_low > LONG_MAX then
            if TPO_mask = mask then
                read_TPO_value = data_low
            else
                read_TPO_value = (data_low - H8000_0000) and TPO_mask
            end If
        else
            read_TPO_value = data_low and TPO_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TTME_value = &H0
        flag_TTME        = &H0
        write_TBO_value = &H0
        flag_TBO        = &H0
        write_TTS_value = &H0
        flag_TTS        = &H0
        write_TPE_value = &H0
        flag_TPE        = &H0
        write_TPI_value = &H0
        flag_TPI        = &H0
        write_TPO_value = &H0
        flag_TPO        = &H0
    End Sub
End Class


'' @REGISTER : TX_PMD_TEST_SGMIIPLUSR_X1_SGMIIPLUSR_X1_txpmd_txmdata0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TXMDIOTSTDATAL                             [9:0]            get_TXMDIOTSTDATAL
''                                                             set_TXMDIOTSTDATAL
''                                                             read_TXMDIOTSTDATAL
''                                                             write_TXMDIOTSTDATAL
''---------------------------------------------------------------------------------
Class REGISTER_TX_PMD_TEST_SGMIIPLUSR_X1_SGMIIPLUSR_X1_txpmd_txmdata0
    Private write_TXMDIOTSTDATAL_value
    Private read_TXMDIOTSTDATAL_value
    Private flag_TXMDIOTSTDATAL

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

    Property Get get_TXMDIOTSTDATAL
        get_TXMDIOTSTDATAL = read_TXMDIOTSTDATAL_value
    End Property

    Property Let set_TXMDIOTSTDATAL(aData)
        write_TXMDIOTSTDATAL_value = aData
        flag_TXMDIOTSTDATAL        = &H1
    End Property

    Property Get read_TXMDIOTSTDATAL
        read
        read_TXMDIOTSTDATAL = read_TXMDIOTSTDATAL_value
    End Property

    Property Let write_TXMDIOTSTDATAL(aData)
        set_TXMDIOTSTDATAL = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TXMDIOTSTDATAL_mask = &H3ff
        if data_low > LONG_MAX then
            if TXMDIOTSTDATAL_mask = mask then
                read_TXMDIOTSTDATAL_value = data_low
            else
                read_TXMDIOTSTDATAL_value = (data_low - H8000_0000) and TXMDIOTSTDATAL_mask
            end If
        else
            read_TXMDIOTSTDATAL_value = data_low and TXMDIOTSTDATAL_mask
        end If

    End Sub

    Sub write
        If flag_TXMDIOTSTDATAL = &H0 Then read
        If flag_TXMDIOTSTDATAL = &H0 Then write_TXMDIOTSTDATAL_value = get_TXMDIOTSTDATAL

        regValue = leftShift((write_TXMDIOTSTDATAL_value and &H3ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TXMDIOTSTDATAL_mask = &H3ff
        if data_low > LONG_MAX then
            if TXMDIOTSTDATAL_mask = mask then
                read_TXMDIOTSTDATAL_value = data_low
            else
                read_TXMDIOTSTDATAL_value = (data_low - H8000_0000) and TXMDIOTSTDATAL_mask
            end If
        else
            read_TXMDIOTSTDATAL_value = data_low and TXMDIOTSTDATAL_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TXMDIOTSTDATAL_value = &H0
        flag_TXMDIOTSTDATAL        = &H0
    End Sub
End Class


'' @REGISTER : TX_PMD_TEST_SGMIIPLUSR_X1_SGMIIPLUSR_X1_txpmd_txmdata1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TXMDIOTSTDATAH                             [9:0]            get_TXMDIOTSTDATAH
''                                                             set_TXMDIOTSTDATAH
''                                                             read_TXMDIOTSTDATAH
''                                                             write_TXMDIOTSTDATAH
''---------------------------------------------------------------------------------
Class REGISTER_TX_PMD_TEST_SGMIIPLUSR_X1_SGMIIPLUSR_X1_txpmd_txmdata1
    Private write_TXMDIOTSTDATAH_value
    Private read_TXMDIOTSTDATAH_value
    Private flag_TXMDIOTSTDATAH

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

    Property Get get_TXMDIOTSTDATAH
        get_TXMDIOTSTDATAH = read_TXMDIOTSTDATAH_value
    End Property

    Property Let set_TXMDIOTSTDATAH(aData)
        write_TXMDIOTSTDATAH_value = aData
        flag_TXMDIOTSTDATAH        = &H1
    End Property

    Property Get read_TXMDIOTSTDATAH
        read
        read_TXMDIOTSTDATAH = read_TXMDIOTSTDATAH_value
    End Property

    Property Let write_TXMDIOTSTDATAH(aData)
        set_TXMDIOTSTDATAH = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TXMDIOTSTDATAH_mask = &H3ff
        if data_low > LONG_MAX then
            if TXMDIOTSTDATAH_mask = mask then
                read_TXMDIOTSTDATAH_value = data_low
            else
                read_TXMDIOTSTDATAH_value = (data_low - H8000_0000) and TXMDIOTSTDATAH_mask
            end If
        else
            read_TXMDIOTSTDATAH_value = data_low and TXMDIOTSTDATAH_mask
        end If

    End Sub

    Sub write
        If flag_TXMDIOTSTDATAH = &H0 Then read
        If flag_TXMDIOTSTDATAH = &H0 Then write_TXMDIOTSTDATAH_value = get_TXMDIOTSTDATAH

        regValue = leftShift((write_TXMDIOTSTDATAH_value and &H3ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TXMDIOTSTDATAH_mask = &H3ff
        if data_low > LONG_MAX then
            if TXMDIOTSTDATAH_mask = mask then
                read_TXMDIOTSTDATAH_value = data_low
            else
                read_TXMDIOTSTDATAH_value = (data_low - H8000_0000) and TXMDIOTSTDATAH_mask
            end If
        else
            read_TXMDIOTSTDATAH_value = data_low and TXMDIOTSTDATAH_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TXMDIOTSTDATAH_value = &H0
        flag_TXMDIOTSTDATAH        = &H0
    End Sub
End Class


'' @REGISTER : TX_PMD_TEST_SGMIIPLUSR_X1_SGMIIPLUSR_X1_txpmd_control0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PMD_TXPO_FLIP                              [10:10]          get_PMD_TXPO_FLIP
''                                                             set_PMD_TXPO_FLIP
''                                                             read_PMD_TXPO_FLIP
''                                                             write_PMD_TXPO_FLIP
''---------------------------------------------------------------------------------
'' PTL                                        [9:9]            get_PTL
''                                                             set_PTL
''                                                             read_PTL
''                                                             write_PTL
''---------------------------------------------------------------------------------
'' PMD_RLFI_RST                               [8:8]            get_PMD_RLFI_RST
''                                                             set_PMD_RLFI_RST
''                                                             read_PMD_RLFI_RST
''                                                             write_PMD_RLFI_RST
''---------------------------------------------------------------------------------
'' PRT                                        [7:5]            get_PRT
''                                                             set_PRT
''                                                             read_PRT
''                                                             write_PRT
''---------------------------------------------------------------------------------
'' OMTPO                                      [4:4]            get_OMTPO
''                                                             set_OMTPO
''                                                             read_OMTPO
''                                                             write_OMTPO
''---------------------------------------------------------------------------------
'' OS_MODE_TX_PMD                             [3:0]            get_OS_MODE_TX_PMD
''                                                             set_OS_MODE_TX_PMD
''                                                             read_OS_MODE_TX_PMD
''                                                             write_OS_MODE_TX_PMD
''---------------------------------------------------------------------------------
Class REGISTER_TX_PMD_TEST_SGMIIPLUSR_X1_SGMIIPLUSR_X1_txpmd_control0
    Private write_PMD_TXPO_FLIP_value
    Private read_PMD_TXPO_FLIP_value
    Private flag_PMD_TXPO_FLIP
    Private write_PTL_value
    Private read_PTL_value
    Private flag_PTL
    Private write_PMD_RLFI_RST_value
    Private read_PMD_RLFI_RST_value
    Private flag_PMD_RLFI_RST
    Private write_PRT_value
    Private read_PRT_value
    Private flag_PRT
    Private write_OMTPO_value
    Private read_OMTPO_value
    Private flag_OMTPO
    Private write_OS_MODE_TX_PMD_value
    Private read_OS_MODE_TX_PMD_value
    Private flag_OS_MODE_TX_PMD

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

    Property Get get_PMD_TXPO_FLIP
        get_PMD_TXPO_FLIP = read_PMD_TXPO_FLIP_value
    End Property

    Property Let set_PMD_TXPO_FLIP(aData)
        write_PMD_TXPO_FLIP_value = aData
        flag_PMD_TXPO_FLIP        = &H1
    End Property

    Property Get read_PMD_TXPO_FLIP
        read
        read_PMD_TXPO_FLIP = read_PMD_TXPO_FLIP_value
    End Property

    Property Let write_PMD_TXPO_FLIP(aData)
        set_PMD_TXPO_FLIP = aData
        write
    End Property

    Property Get get_PTL
        get_PTL = read_PTL_value
    End Property

    Property Let set_PTL(aData)
        write_PTL_value = aData
        flag_PTL        = &H1
    End Property

    Property Get read_PTL
        read
        read_PTL = read_PTL_value
    End Property

    Property Let write_PTL(aData)
        set_PTL = aData
        write
    End Property

    Property Get get_PMD_RLFI_RST
        get_PMD_RLFI_RST = read_PMD_RLFI_RST_value
    End Property

    Property Let set_PMD_RLFI_RST(aData)
        write_PMD_RLFI_RST_value = aData
        flag_PMD_RLFI_RST        = &H1
    End Property

    Property Get read_PMD_RLFI_RST
        read
        read_PMD_RLFI_RST = read_PMD_RLFI_RST_value
    End Property

    Property Let write_PMD_RLFI_RST(aData)
        set_PMD_RLFI_RST = aData
        write
    End Property

    Property Get get_PRT
        get_PRT = read_PRT_value
    End Property

    Property Let set_PRT(aData)
        write_PRT_value = aData
        flag_PRT        = &H1
    End Property

    Property Get read_PRT
        read
        read_PRT = read_PRT_value
    End Property

    Property Let write_PRT(aData)
        set_PRT = aData
        write
    End Property

    Property Get get_OMTPO
        get_OMTPO = read_OMTPO_value
    End Property

    Property Let set_OMTPO(aData)
        write_OMTPO_value = aData
        flag_OMTPO        = &H1
    End Property

    Property Get read_OMTPO
        read
        read_OMTPO = read_OMTPO_value
    End Property

    Property Let write_OMTPO(aData)
        set_OMTPO = aData
        write
    End Property

    Property Get get_OS_MODE_TX_PMD
        get_OS_MODE_TX_PMD = read_OS_MODE_TX_PMD_value
    End Property

    Property Let set_OS_MODE_TX_PMD(aData)
        write_OS_MODE_TX_PMD_value = aData
        flag_OS_MODE_TX_PMD        = &H1
    End Property

    Property Get read_OS_MODE_TX_PMD
        read
        read_OS_MODE_TX_PMD = read_OS_MODE_TX_PMD_value
    End Property

    Property Let write_OS_MODE_TX_PMD(aData)
        set_OS_MODE_TX_PMD = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_PMD_TXPO_FLIP_value = rightShift(data_low, 10) and &H1
        read_PTL_value = rightShift(data_low, 9) and &H1
        read_PMD_RLFI_RST_value = rightShift(data_low, 8) and &H1
        read_PRT_value = rightShift(data_low, 5) and &H7
        read_OMTPO_value = rightShift(data_low, 4) and &H1
        OS_MODE_TX_PMD_mask = &Hf
        if data_low > LONG_MAX then
            if OS_MODE_TX_PMD_mask = mask then
                read_OS_MODE_TX_PMD_value = data_low
            else
                read_OS_MODE_TX_PMD_value = (data_low - H8000_0000) and OS_MODE_TX_PMD_mask
            end If
        else
            read_OS_MODE_TX_PMD_value = data_low and OS_MODE_TX_PMD_mask
        end If

    End Sub

    Sub write
        If flag_PMD_TXPO_FLIP = &H0 or flag_PTL = &H0 or flag_PMD_RLFI_RST = &H0 or flag_PRT = &H0 or flag_OMTPO = &H0 or flag_OS_MODE_TX_PMD = &H0 Then read
        If flag_PMD_TXPO_FLIP = &H0 Then write_PMD_TXPO_FLIP_value = get_PMD_TXPO_FLIP
        If flag_PTL = &H0 Then write_PTL_value = get_PTL
        If flag_PMD_RLFI_RST = &H0 Then write_PMD_RLFI_RST_value = get_PMD_RLFI_RST
        If flag_PRT = &H0 Then write_PRT_value = get_PRT
        If flag_OMTPO = &H0 Then write_OMTPO_value = get_OMTPO
        If flag_OS_MODE_TX_PMD = &H0 Then write_OS_MODE_TX_PMD_value = get_OS_MODE_TX_PMD

        regValue = leftShift((write_PMD_TXPO_FLIP_value and &H1), 10) + leftShift((write_PTL_value and &H1), 9) + leftShift((write_PMD_RLFI_RST_value and &H1), 8) + leftShift((write_PRT_value and &H7), 5) + leftShift((write_OMTPO_value and &H1), 4) + leftShift((write_OS_MODE_TX_PMD_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_PMD_TXPO_FLIP_value = rightShift(data_low, 10) and &H1
        read_PTL_value = rightShift(data_low, 9) and &H1
        read_PMD_RLFI_RST_value = rightShift(data_low, 8) and &H1
        read_PRT_value = rightShift(data_low, 5) and &H7
        read_OMTPO_value = rightShift(data_low, 4) and &H1
        OS_MODE_TX_PMD_mask = &Hf
        if data_low > LONG_MAX then
            if OS_MODE_TX_PMD_mask = mask then
                read_OS_MODE_TX_PMD_value = data_low
            else
                read_OS_MODE_TX_PMD_value = (data_low - H8000_0000) and OS_MODE_TX_PMD_mask
            end If
        else
            read_OS_MODE_TX_PMD_value = data_low and OS_MODE_TX_PMD_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PMD_TXPO_FLIP_value = &H0
        flag_PMD_TXPO_FLIP        = &H0
        write_PTL_value = &H0
        flag_PTL        = &H0
        write_PMD_RLFI_RST_value = &H0
        flag_PMD_RLFI_RST        = &H0
        write_PRT_value = &H0
        flag_PRT        = &H0
        write_OMTPO_value = &H0
        flag_OMTPO        = &H0
        write_OS_MODE_TX_PMD_value = &H0
        flag_OS_MODE_TX_PMD        = &H0
    End Sub
End Class


'' @REGISTER : TX_PMD_TEST_SGMIIPLUSR_X1_SGMIIPLUSR_X1_txpmd_test_status
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TOMM                                       [10:7]           get_TOMM
''                                                             set_TOMM
''                                                             read_TOMM
''                                                             write_TOMM
''---------------------------------------------------------------------------------
'' RLTX_TMUX                                  [6:1]            get_RLTX_TMUX
''                                                             set_RLTX_TMUX
''                                                             read_RLTX_TMUX
''                                                             write_RLTX_TMUX
''---------------------------------------------------------------------------------
'' RLTX_STKY                                  [0:0]            get_RLTX_STKY
''                                                             set_RLTX_STKY
''                                                             read_RLTX_STKY
''                                                             write_RLTX_STKY
''---------------------------------------------------------------------------------
Class REGISTER_TX_PMD_TEST_SGMIIPLUSR_X1_SGMIIPLUSR_X1_txpmd_test_status
    Private write_TOMM_value
    Private read_TOMM_value
    Private flag_TOMM
    Private write_RLTX_TMUX_value
    Private read_RLTX_TMUX_value
    Private flag_RLTX_TMUX
    Private write_RLTX_STKY_value
    Private read_RLTX_STKY_value
    Private flag_RLTX_STKY

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

    Property Get get_TOMM
        get_TOMM = read_TOMM_value
    End Property

    Property Let set_TOMM(aData)
        write_TOMM_value = aData
        flag_TOMM        = &H1
    End Property

    Property Get read_TOMM
        read
        read_TOMM = read_TOMM_value
    End Property

    Property Let write_TOMM(aData)
        set_TOMM = aData
        write
    End Property

    Property Get get_RLTX_TMUX
        get_RLTX_TMUX = read_RLTX_TMUX_value
    End Property

    Property Let set_RLTX_TMUX(aData)
        write_RLTX_TMUX_value = aData
        flag_RLTX_TMUX        = &H1
    End Property

    Property Get read_RLTX_TMUX
        read
        read_RLTX_TMUX = read_RLTX_TMUX_value
    End Property

    Property Let write_RLTX_TMUX(aData)
        set_RLTX_TMUX = aData
        write
    End Property

    Property Get get_RLTX_STKY
        get_RLTX_STKY = read_RLTX_STKY_value
    End Property

    Property Let set_RLTX_STKY(aData)
        write_RLTX_STKY_value = aData
        flag_RLTX_STKY        = &H1
    End Property

    Property Get read_RLTX_STKY
        read
        read_RLTX_STKY = read_RLTX_STKY_value
    End Property

    Property Let write_RLTX_STKY(aData)
        set_RLTX_STKY = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TOMM_value = rightShift(data_low, 7) and &Hf
        read_RLTX_TMUX_value = rightShift(data_low, 1) and &H3f
        RLTX_STKY_mask = &H1
        if data_low > LONG_MAX then
            if RLTX_STKY_mask = mask then
                read_RLTX_STKY_value = data_low
            else
                read_RLTX_STKY_value = (data_low - H8000_0000) and RLTX_STKY_mask
            end If
        else
            read_RLTX_STKY_value = data_low and RLTX_STKY_mask
        end If

    End Sub

    Sub write
        If flag_TOMM = &H0 or flag_RLTX_TMUX = &H0 or flag_RLTX_STKY = &H0 Then read
        If flag_TOMM = &H0 Then write_TOMM_value = get_TOMM
        If flag_RLTX_TMUX = &H0 Then write_RLTX_TMUX_value = get_RLTX_TMUX
        If flag_RLTX_STKY = &H0 Then write_RLTX_STKY_value = get_RLTX_STKY

        regValue = leftShift((write_TOMM_value and &Hf), 7) + leftShift((write_RLTX_TMUX_value and &H3f), 1) + leftShift((write_RLTX_STKY_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TOMM_value = rightShift(data_low, 7) and &Hf
        read_RLTX_TMUX_value = rightShift(data_low, 1) and &H3f
        RLTX_STKY_mask = &H1
        if data_low > LONG_MAX then
            if RLTX_STKY_mask = mask then
                read_RLTX_STKY_value = data_low
            else
                read_RLTX_STKY_value = (data_low - H8000_0000) and RLTX_STKY_mask
            end If
        else
            read_RLTX_STKY_value = data_low and RLTX_STKY_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TOMM_value = &H0
        flag_TOMM        = &H0
        write_RLTX_TMUX_value = &H0
        flag_RLTX_TMUX        = &H0
        write_RLTX_STKY_value = &H0
        flag_RLTX_STKY        = &H0
    End Sub
End Class


'' @REGISTER : TX_PMD_TEST_SGMIIPLUSR_X1_SGMIIPLUSR_X1_blockaddress
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
Class REGISTER_TX_PMD_TEST_SGMIIPLUSR_X1_SGMIIPLUSR_X1_blockaddress
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

Class TX_PMD_TEST_SGMIIPLUSR_X1_SGMIIPLUSR_X1_INSTANCE

    Public txpmd_prbsgenctrl
    Public txpmd_txmdata0
    Public txpmd_txmdata1
    Public txpmd_control0
    Public txpmd_test_status
    Public blockaddress


    Public default function Init(aBaseAddr)
        Set txpmd_prbsgenctrl = (New REGISTER_TX_PMD_TEST_SGMIIPLUSR_X1_SGMIIPLUSR_X1_txpmd_prbsgenctrl)(aBaseAddr, 16)
        Set txpmd_txmdata0 = (New REGISTER_TX_PMD_TEST_SGMIIPLUSR_X1_SGMIIPLUSR_X1_txpmd_txmdata0)(aBaseAddr, 16)
        Set txpmd_txmdata1 = (New REGISTER_TX_PMD_TEST_SGMIIPLUSR_X1_SGMIIPLUSR_X1_txpmd_txmdata1)(aBaseAddr, 16)
        Set txpmd_control0 = (New REGISTER_TX_PMD_TEST_SGMIIPLUSR_X1_SGMIIPLUSR_X1_txpmd_control0)(aBaseAddr, 16)
        Set txpmd_test_status = (New REGISTER_TX_PMD_TEST_SGMIIPLUSR_X1_SGMIIPLUSR_X1_txpmd_test_status)(aBaseAddr, 16)
        Set blockaddress = (New REGISTER_TX_PMD_TEST_SGMIIPLUSR_X1_SGMIIPLUSR_X1_blockaddress)(aBaseAddr, 16)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set TX_PMD_TEST_SGMIIPLUSR_X1_SGMIIPLUSR_X1 = CreateObject("System.Collections.ArrayList")
TX_PMD_TEST_SGMIIPLUSR_X1_SGMIIPLUSR_X1.Add ((New TX_PMD_TEST_SGMIIPLUSR_X1_SGMIIPLUSR_X1_INSTANCE)(&H4ae50c20))


