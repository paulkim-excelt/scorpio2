

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


'' @REGISTER : SPI1_sspcr0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SCR                                        [15:8]           get_SCR
''                                                             set_SCR
''                                                             read_SCR
''                                                             write_SCR
''---------------------------------------------------------------------------------
'' SPH                                        [7:7]            get_SPH
''                                                             set_SPH
''                                                             read_SPH
''                                                             write_SPH
''---------------------------------------------------------------------------------
'' SPO                                        [6:6]            get_SPO
''                                                             set_SPO
''                                                             read_SPO
''                                                             write_SPO
''---------------------------------------------------------------------------------
'' FRF                                        [5:4]            get_FRF
''                                                             set_FRF
''                                                             read_FRF
''                                                             write_FRF
''---------------------------------------------------------------------------------
'' DSS                                        [3:0]            get_DSS
''                                                             set_DSS
''                                                             read_DSS
''                                                             write_DSS
''---------------------------------------------------------------------------------
Class REGISTER_SPI1_sspcr0
    Private write_SCR_value
    Private read_SCR_value
    Private flag_SCR
    Private write_SPH_value
    Private read_SPH_value
    Private flag_SPH
    Private write_SPO_value
    Private read_SPO_value
    Private flag_SPO
    Private write_FRF_value
    Private read_FRF_value
    Private flag_FRF
    Private write_DSS_value
    Private read_DSS_value
    Private flag_DSS

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

    Property Get get_SCR
        get_SCR = read_SCR_value
    End Property

    Property Let set_SCR(aData)
        write_SCR_value = aData
        flag_SCR        = &H1
    End Property

    Property Get read_SCR
        read
        read_SCR = read_SCR_value
    End Property

    Property Let write_SCR(aData)
        set_SCR = aData
        write
    End Property

    Property Get get_SPH
        get_SPH = read_SPH_value
    End Property

    Property Let set_SPH(aData)
        write_SPH_value = aData
        flag_SPH        = &H1
    End Property

    Property Get read_SPH
        read
        read_SPH = read_SPH_value
    End Property

    Property Let write_SPH(aData)
        set_SPH = aData
        write
    End Property

    Property Get get_SPO
        get_SPO = read_SPO_value
    End Property

    Property Let set_SPO(aData)
        write_SPO_value = aData
        flag_SPO        = &H1
    End Property

    Property Get read_SPO
        read
        read_SPO = read_SPO_value
    End Property

    Property Let write_SPO(aData)
        set_SPO = aData
        write
    End Property

    Property Get get_FRF
        get_FRF = read_FRF_value
    End Property

    Property Let set_FRF(aData)
        write_FRF_value = aData
        flag_FRF        = &H1
    End Property

    Property Get read_FRF
        read
        read_FRF = read_FRF_value
    End Property

    Property Let write_FRF(aData)
        set_FRF = aData
        write
    End Property

    Property Get get_DSS
        get_DSS = read_DSS_value
    End Property

    Property Let set_DSS(aData)
        write_DSS_value = aData
        flag_DSS        = &H1
    End Property

    Property Get read_DSS
        read
        read_DSS = read_DSS_value
    End Property

    Property Let write_DSS(aData)
        set_DSS = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_SCR_value = rightShift(data_low, 8) and &Hff
        read_SPH_value = rightShift(data_low, 7) and &H1
        read_SPO_value = rightShift(data_low, 6) and &H1
        read_FRF_value = rightShift(data_low, 4) and &H3
        DSS_mask = &Hf
        if data_low > LONG_MAX then
            if DSS_mask = mask then
                read_DSS_value = data_low
            else
                read_DSS_value = (data_low - H8000_0000) and DSS_mask
            end If
        else
            read_DSS_value = data_low and DSS_mask
        end If

    End Sub

    Sub write
        If flag_SCR = &H0 or flag_SPH = &H0 or flag_SPO = &H0 or flag_FRF = &H0 or flag_DSS = &H0 Then read
        If flag_SCR = &H0 Then write_SCR_value = get_SCR
        If flag_SPH = &H0 Then write_SPH_value = get_SPH
        If flag_SPO = &H0 Then write_SPO_value = get_SPO
        If flag_FRF = &H0 Then write_FRF_value = get_FRF
        If flag_DSS = &H0 Then write_DSS_value = get_DSS

        regValue = leftShift((write_SCR_value and &Hff), 8) + leftShift((write_SPH_value and &H1), 7) + leftShift((write_SPO_value and &H1), 6) + leftShift((write_FRF_value and &H3), 4) + leftShift((write_DSS_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_SCR_value = rightShift(data_low, 8) and &Hff
        read_SPH_value = rightShift(data_low, 7) and &H1
        read_SPO_value = rightShift(data_low, 6) and &H1
        read_FRF_value = rightShift(data_low, 4) and &H3
        DSS_mask = &Hf
        if data_low > LONG_MAX then
            if DSS_mask = mask then
                read_DSS_value = data_low
            else
                read_DSS_value = (data_low - H8000_0000) and DSS_mask
            end If
        else
            read_DSS_value = data_low and DSS_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SCR_value = &H0
        flag_SCR        = &H0
        write_SPH_value = &H0
        flag_SPH        = &H0
        write_SPO_value = &H0
        flag_SPO        = &H0
        write_FRF_value = &H0
        flag_FRF        = &H0
        write_DSS_value = &H0
        flag_DSS        = &H0
    End Sub
End Class


'' @REGISTER : SPI1_sspcr1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MRxLBClkEn                                 [4:4]            get_MRxLBClkEn
''                                                             set_MRxLBClkEn
''                                                             read_MRxLBClkEn
''                                                             write_MRxLBClkEn
''---------------------------------------------------------------------------------
'' SOD                                        [3:3]            get_SOD
''                                                             set_SOD
''                                                             read_SOD
''                                                             write_SOD
''---------------------------------------------------------------------------------
'' MS                                         [2:2]            get_MS
''                                                             set_MS
''                                                             read_MS
''                                                             write_MS
''---------------------------------------------------------------------------------
'' SSE                                        [1:1]            get_SSE
''                                                             set_SSE
''                                                             read_SSE
''                                                             write_SSE
''---------------------------------------------------------------------------------
Class REGISTER_SPI1_sspcr1
    Private write_MRxLBClkEn_value
    Private read_MRxLBClkEn_value
    Private flag_MRxLBClkEn
    Private write_SOD_value
    Private read_SOD_value
    Private flag_SOD
    Private write_MS_value
    Private read_MS_value
    Private flag_MS
    Private write_SSE_value
    Private read_SSE_value
    Private flag_SSE

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

    Property Get get_MRxLBClkEn
        get_MRxLBClkEn = read_MRxLBClkEn_value
    End Property

    Property Let set_MRxLBClkEn(aData)
        write_MRxLBClkEn_value = aData
        flag_MRxLBClkEn        = &H1
    End Property

    Property Get read_MRxLBClkEn
        read
        read_MRxLBClkEn = read_MRxLBClkEn_value
    End Property

    Property Let write_MRxLBClkEn(aData)
        set_MRxLBClkEn = aData
        write
    End Property

    Property Get get_SOD
        get_SOD = read_SOD_value
    End Property

    Property Let set_SOD(aData)
        write_SOD_value = aData
        flag_SOD        = &H1
    End Property

    Property Get read_SOD
        read
        read_SOD = read_SOD_value
    End Property

    Property Let write_SOD(aData)
        set_SOD = aData
        write
    End Property

    Property Get get_MS
        get_MS = read_MS_value
    End Property

    Property Let set_MS(aData)
        write_MS_value = aData
        flag_MS        = &H1
    End Property

    Property Get read_MS
        read
        read_MS = read_MS_value
    End Property

    Property Let write_MS(aData)
        set_MS = aData
        write
    End Property

    Property Get get_SSE
        get_SSE = read_SSE_value
    End Property

    Property Let set_SSE(aData)
        write_SSE_value = aData
        flag_SSE        = &H1
    End Property

    Property Get read_SSE
        read
        read_SSE = read_SSE_value
    End Property

    Property Let write_SSE(aData)
        set_SSE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_MRxLBClkEn_value = rightShift(data_low, 4) and &H1
        read_SOD_value = rightShift(data_low, 3) and &H1
        read_MS_value = rightShift(data_low, 2) and &H1
        read_SSE_value = rightShift(data_low, 1) and &H1

    End Sub

    Sub write
        If flag_MRxLBClkEn = &H0 or flag_SOD = &H0 or flag_MS = &H0 or flag_SSE = &H0 Then read
        If flag_MRxLBClkEn = &H0 Then write_MRxLBClkEn_value = get_MRxLBClkEn
        If flag_SOD = &H0 Then write_SOD_value = get_SOD
        If flag_MS = &H0 Then write_MS_value = get_MS
        If flag_SSE = &H0 Then write_SSE_value = get_SSE

        regValue = leftShift((write_MRxLBClkEn_value and &H1), 4) + leftShift((write_SOD_value and &H1), 3) + leftShift((write_MS_value and &H1), 2) + leftShift((write_SSE_value and &H1), 1)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_MRxLBClkEn_value = rightShift(data_low, 4) and &H1
        read_SOD_value = rightShift(data_low, 3) and &H1
        read_MS_value = rightShift(data_low, 2) and &H1
        read_SSE_value = rightShift(data_low, 1) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MRxLBClkEn_value = &H0
        flag_MRxLBClkEn        = &H0
        write_SOD_value = &H0
        flag_SOD        = &H0
        write_MS_value = &H0
        flag_MS        = &H0
        write_SSE_value = &H0
        flag_SSE        = &H0
    End Sub
End Class


'' @REGISTER : SPI1_sspdr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DATA                                       [15:0]           get_DATA
''                                                             set_DATA
''                                                             read_DATA
''                                                             write_DATA
''---------------------------------------------------------------------------------
Class REGISTER_SPI1_sspdr
    Private write_DATA_value
    Private read_DATA_value
    Private flag_DATA

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

    Property Get get_DATA
        get_DATA = read_DATA_value
    End Property

    Property Let set_DATA(aData)
        write_DATA_value = aData
        flag_DATA        = &H1
    End Property

    Property Get read_DATA
        read
        read_DATA = read_DATA_value
    End Property

    Property Let write_DATA(aData)
        set_DATA = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DATA_mask = &Hffff
        if data_low > LONG_MAX then
            if DATA_mask = mask then
                read_DATA_value = data_low
            else
                read_DATA_value = (data_low - H8000_0000) and DATA_mask
            end If
        else
            read_DATA_value = data_low and DATA_mask
        end If

    End Sub

    Sub write
        If flag_DATA = &H0 Then read
        If flag_DATA = &H0 Then write_DATA_value = get_DATA

        regValue = leftShift((write_DATA_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DATA_mask = &Hffff
        if data_low > LONG_MAX then
            if DATA_mask = mask then
                read_DATA_value = data_low
            else
                read_DATA_value = (data_low - H8000_0000) and DATA_mask
            end If
        else
            read_DATA_value = data_low and DATA_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DATA_value = &H0
        flag_DATA        = &H0
    End Sub
End Class


'' @REGISTER : SPI1_sspsr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' BSY                                        [4:4]            get_BSY
''                                                             set_BSY
''                                                             read_BSY
''                                                             write_BSY
''---------------------------------------------------------------------------------
'' RFF                                        [3:3]            get_RFF
''                                                             set_RFF
''                                                             read_RFF
''                                                             write_RFF
''---------------------------------------------------------------------------------
'' RNE                                        [2:2]            get_RNE
''                                                             set_RNE
''                                                             read_RNE
''                                                             write_RNE
''---------------------------------------------------------------------------------
'' TNF                                        [1:1]            get_TNF
''                                                             set_TNF
''                                                             read_TNF
''                                                             write_TNF
''---------------------------------------------------------------------------------
'' TFE                                        [0:0]            get_TFE
''                                                             set_TFE
''                                                             read_TFE
''                                                             write_TFE
''---------------------------------------------------------------------------------
Class REGISTER_SPI1_sspsr
    Private write_BSY_value
    Private read_BSY_value
    Private flag_BSY
    Private write_RFF_value
    Private read_RFF_value
    Private flag_RFF
    Private write_RNE_value
    Private read_RNE_value
    Private flag_RNE
    Private write_TNF_value
    Private read_TNF_value
    Private flag_TNF
    Private write_TFE_value
    Private read_TFE_value
    Private flag_TFE

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

    Property Get get_BSY
        get_BSY = read_BSY_value
    End Property

    Property Let set_BSY(aData)
        write_BSY_value = aData
        flag_BSY        = &H1
    End Property

    Property Get read_BSY
        read
        read_BSY = read_BSY_value
    End Property

    Property Let write_BSY(aData)
        set_BSY = aData
        write
    End Property

    Property Get get_RFF
        get_RFF = read_RFF_value
    End Property

    Property Let set_RFF(aData)
        write_RFF_value = aData
        flag_RFF        = &H1
    End Property

    Property Get read_RFF
        read
        read_RFF = read_RFF_value
    End Property

    Property Let write_RFF(aData)
        set_RFF = aData
        write
    End Property

    Property Get get_RNE
        get_RNE = read_RNE_value
    End Property

    Property Let set_RNE(aData)
        write_RNE_value = aData
        flag_RNE        = &H1
    End Property

    Property Get read_RNE
        read
        read_RNE = read_RNE_value
    End Property

    Property Let write_RNE(aData)
        set_RNE = aData
        write
    End Property

    Property Get get_TNF
        get_TNF = read_TNF_value
    End Property

    Property Let set_TNF(aData)
        write_TNF_value = aData
        flag_TNF        = &H1
    End Property

    Property Get read_TNF
        read
        read_TNF = read_TNF_value
    End Property

    Property Let write_TNF(aData)
        set_TNF = aData
        write
    End Property

    Property Get get_TFE
        get_TFE = read_TFE_value
    End Property

    Property Let set_TFE(aData)
        write_TFE_value = aData
        flag_TFE        = &H1
    End Property

    Property Get read_TFE
        read
        read_TFE = read_TFE_value
    End Property

    Property Let write_TFE(aData)
        set_TFE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_BSY_value = rightShift(data_low, 4) and &H1
        read_RFF_value = rightShift(data_low, 3) and &H1
        read_RNE_value = rightShift(data_low, 2) and &H1
        read_TNF_value = rightShift(data_low, 1) and &H1
        TFE_mask = &H1
        if data_low > LONG_MAX then
            if TFE_mask = mask then
                read_TFE_value = data_low
            else
                read_TFE_value = (data_low - H8000_0000) and TFE_mask
            end If
        else
            read_TFE_value = data_low and TFE_mask
        end If

    End Sub

    Sub write
        If flag_BSY = &H0 or flag_RFF = &H0 or flag_RNE = &H0 or flag_TNF = &H0 or flag_TFE = &H0 Then read
        If flag_BSY = &H0 Then write_BSY_value = get_BSY
        If flag_RFF = &H0 Then write_RFF_value = get_RFF
        If flag_RNE = &H0 Then write_RNE_value = get_RNE
        If flag_TNF = &H0 Then write_TNF_value = get_TNF
        If flag_TFE = &H0 Then write_TFE_value = get_TFE

        regValue = leftShift((write_BSY_value and &H1), 4) + leftShift((write_RFF_value and &H1), 3) + leftShift((write_RNE_value and &H1), 2) + leftShift((write_TNF_value and &H1), 1) + leftShift((write_TFE_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_BSY_value = rightShift(data_low, 4) and &H1
        read_RFF_value = rightShift(data_low, 3) and &H1
        read_RNE_value = rightShift(data_low, 2) and &H1
        read_TNF_value = rightShift(data_low, 1) and &H1
        TFE_mask = &H1
        if data_low > LONG_MAX then
            if TFE_mask = mask then
                read_TFE_value = data_low
            else
                read_TFE_value = (data_low - H8000_0000) and TFE_mask
            end If
        else
            read_TFE_value = data_low and TFE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_BSY_value = &H0
        flag_BSY        = &H0
        write_RFF_value = &H0
        flag_RFF        = &H0
        write_RNE_value = &H0
        flag_RNE        = &H0
        write_TNF_value = &H0
        flag_TNF        = &H0
        write_TFE_value = &H0
        flag_TFE        = &H0
    End Sub
End Class


'' @REGISTER : SPI1_sspcpsr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' CPSDVSR                                    [7:0]            get_CPSDVSR
''                                                             set_CPSDVSR
''                                                             read_CPSDVSR
''                                                             write_CPSDVSR
''---------------------------------------------------------------------------------
Class REGISTER_SPI1_sspcpsr
    Private write_CPSDVSR_value
    Private read_CPSDVSR_value
    Private flag_CPSDVSR

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

    Property Get get_CPSDVSR
        get_CPSDVSR = read_CPSDVSR_value
    End Property

    Property Let set_CPSDVSR(aData)
        write_CPSDVSR_value = aData
        flag_CPSDVSR        = &H1
    End Property

    Property Get read_CPSDVSR
        read
        read_CPSDVSR = read_CPSDVSR_value
    End Property

    Property Let write_CPSDVSR(aData)
        set_CPSDVSR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        CPSDVSR_mask = &Hff
        if data_low > LONG_MAX then
            if CPSDVSR_mask = mask then
                read_CPSDVSR_value = data_low
            else
                read_CPSDVSR_value = (data_low - H8000_0000) and CPSDVSR_mask
            end If
        else
            read_CPSDVSR_value = data_low and CPSDVSR_mask
        end If

    End Sub

    Sub write
        If flag_CPSDVSR = &H0 Then read
        If flag_CPSDVSR = &H0 Then write_CPSDVSR_value = get_CPSDVSR

        regValue = leftShift((write_CPSDVSR_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        CPSDVSR_mask = &Hff
        if data_low > LONG_MAX then
            if CPSDVSR_mask = mask then
                read_CPSDVSR_value = data_low
            else
                read_CPSDVSR_value = (data_low - H8000_0000) and CPSDVSR_mask
            end If
        else
            read_CPSDVSR_value = data_low and CPSDVSR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_CPSDVSR_value = &H0
        flag_CPSDVSR        = &H0
    End Sub
End Class


'' @REGISTER : SPI1_sspimsc
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TXIM                                       [3:3]            get_TXIM
''                                                             set_TXIM
''                                                             read_TXIM
''                                                             write_TXIM
''---------------------------------------------------------------------------------
'' RXIM                                       [2:2]            get_RXIM
''                                                             set_RXIM
''                                                             read_RXIM
''                                                             write_RXIM
''---------------------------------------------------------------------------------
'' RTIM                                       [1:1]            get_RTIM
''                                                             set_RTIM
''                                                             read_RTIM
''                                                             write_RTIM
''---------------------------------------------------------------------------------
'' RORIM                                      [0:0]            get_RORIM
''                                                             set_RORIM
''                                                             read_RORIM
''                                                             write_RORIM
''---------------------------------------------------------------------------------
Class REGISTER_SPI1_sspimsc
    Private write_TXIM_value
    Private read_TXIM_value
    Private flag_TXIM
    Private write_RXIM_value
    Private read_RXIM_value
    Private flag_RXIM
    Private write_RTIM_value
    Private read_RTIM_value
    Private flag_RTIM
    Private write_RORIM_value
    Private read_RORIM_value
    Private flag_RORIM

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

    Property Get get_TXIM
        get_TXIM = read_TXIM_value
    End Property

    Property Let set_TXIM(aData)
        write_TXIM_value = aData
        flag_TXIM        = &H1
    End Property

    Property Get read_TXIM
        read
        read_TXIM = read_TXIM_value
    End Property

    Property Let write_TXIM(aData)
        set_TXIM = aData
        write
    End Property

    Property Get get_RXIM
        get_RXIM = read_RXIM_value
    End Property

    Property Let set_RXIM(aData)
        write_RXIM_value = aData
        flag_RXIM        = &H1
    End Property

    Property Get read_RXIM
        read
        read_RXIM = read_RXIM_value
    End Property

    Property Let write_RXIM(aData)
        set_RXIM = aData
        write
    End Property

    Property Get get_RTIM
        get_RTIM = read_RTIM_value
    End Property

    Property Let set_RTIM(aData)
        write_RTIM_value = aData
        flag_RTIM        = &H1
    End Property

    Property Get read_RTIM
        read
        read_RTIM = read_RTIM_value
    End Property

    Property Let write_RTIM(aData)
        set_RTIM = aData
        write
    End Property

    Property Get get_RORIM
        get_RORIM = read_RORIM_value
    End Property

    Property Let set_RORIM(aData)
        write_RORIM_value = aData
        flag_RORIM        = &H1
    End Property

    Property Get read_RORIM
        read
        read_RORIM = read_RORIM_value
    End Property

    Property Let write_RORIM(aData)
        set_RORIM = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TXIM_value = rightShift(data_low, 3) and &H1
        read_RXIM_value = rightShift(data_low, 2) and &H1
        read_RTIM_value = rightShift(data_low, 1) and &H1
        RORIM_mask = &H1
        if data_low > LONG_MAX then
            if RORIM_mask = mask then
                read_RORIM_value = data_low
            else
                read_RORIM_value = (data_low - H8000_0000) and RORIM_mask
            end If
        else
            read_RORIM_value = data_low and RORIM_mask
        end If

    End Sub

    Sub write
        If flag_TXIM = &H0 or flag_RXIM = &H0 or flag_RTIM = &H0 or flag_RORIM = &H0 Then read
        If flag_TXIM = &H0 Then write_TXIM_value = get_TXIM
        If flag_RXIM = &H0 Then write_RXIM_value = get_RXIM
        If flag_RTIM = &H0 Then write_RTIM_value = get_RTIM
        If flag_RORIM = &H0 Then write_RORIM_value = get_RORIM

        regValue = leftShift((write_TXIM_value and &H1), 3) + leftShift((write_RXIM_value and &H1), 2) + leftShift((write_RTIM_value and &H1), 1) + leftShift((write_RORIM_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TXIM_value = rightShift(data_low, 3) and &H1
        read_RXIM_value = rightShift(data_low, 2) and &H1
        read_RTIM_value = rightShift(data_low, 1) and &H1
        RORIM_mask = &H1
        if data_low > LONG_MAX then
            if RORIM_mask = mask then
                read_RORIM_value = data_low
            else
                read_RORIM_value = (data_low - H8000_0000) and RORIM_mask
            end If
        else
            read_RORIM_value = data_low and RORIM_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TXIM_value = &H0
        flag_TXIM        = &H0
        write_RXIM_value = &H0
        flag_RXIM        = &H0
        write_RTIM_value = &H0
        flag_RTIM        = &H0
        write_RORIM_value = &H0
        flag_RORIM        = &H0
    End Sub
End Class


'' @REGISTER : SPI1_sspris
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TXRIS                                      [3:3]            get_TXRIS
''                                                             set_TXRIS
''                                                             read_TXRIS
''                                                             write_TXRIS
''---------------------------------------------------------------------------------
'' RXRIS                                      [2:2]            get_RXRIS
''                                                             set_RXRIS
''                                                             read_RXRIS
''                                                             write_RXRIS
''---------------------------------------------------------------------------------
'' RTRIS                                      [1:1]            get_RTRIS
''                                                             set_RTRIS
''                                                             read_RTRIS
''                                                             write_RTRIS
''---------------------------------------------------------------------------------
'' RORRIS                                     [0:0]            get_RORRIS
''                                                             set_RORRIS
''                                                             read_RORRIS
''                                                             write_RORRIS
''---------------------------------------------------------------------------------
Class REGISTER_SPI1_sspris
    Private write_TXRIS_value
    Private read_TXRIS_value
    Private flag_TXRIS
    Private write_RXRIS_value
    Private read_RXRIS_value
    Private flag_RXRIS
    Private write_RTRIS_value
    Private read_RTRIS_value
    Private flag_RTRIS
    Private write_RORRIS_value
    Private read_RORRIS_value
    Private flag_RORRIS

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

    Property Get get_TXRIS
        get_TXRIS = read_TXRIS_value
    End Property

    Property Let set_TXRIS(aData)
        write_TXRIS_value = aData
        flag_TXRIS        = &H1
    End Property

    Property Get read_TXRIS
        read
        read_TXRIS = read_TXRIS_value
    End Property

    Property Let write_TXRIS(aData)
        set_TXRIS = aData
        write
    End Property

    Property Get get_RXRIS
        get_RXRIS = read_RXRIS_value
    End Property

    Property Let set_RXRIS(aData)
        write_RXRIS_value = aData
        flag_RXRIS        = &H1
    End Property

    Property Get read_RXRIS
        read
        read_RXRIS = read_RXRIS_value
    End Property

    Property Let write_RXRIS(aData)
        set_RXRIS = aData
        write
    End Property

    Property Get get_RTRIS
        get_RTRIS = read_RTRIS_value
    End Property

    Property Let set_RTRIS(aData)
        write_RTRIS_value = aData
        flag_RTRIS        = &H1
    End Property

    Property Get read_RTRIS
        read
        read_RTRIS = read_RTRIS_value
    End Property

    Property Let write_RTRIS(aData)
        set_RTRIS = aData
        write
    End Property

    Property Get get_RORRIS
        get_RORRIS = read_RORRIS_value
    End Property

    Property Let set_RORRIS(aData)
        write_RORRIS_value = aData
        flag_RORRIS        = &H1
    End Property

    Property Get read_RORRIS
        read
        read_RORRIS = read_RORRIS_value
    End Property

    Property Let write_RORRIS(aData)
        set_RORRIS = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TXRIS_value = rightShift(data_low, 3) and &H1
        read_RXRIS_value = rightShift(data_low, 2) and &H1
        read_RTRIS_value = rightShift(data_low, 1) and &H1
        RORRIS_mask = &H1
        if data_low > LONG_MAX then
            if RORRIS_mask = mask then
                read_RORRIS_value = data_low
            else
                read_RORRIS_value = (data_low - H8000_0000) and RORRIS_mask
            end If
        else
            read_RORRIS_value = data_low and RORRIS_mask
        end If

    End Sub

    Sub write
        If flag_TXRIS = &H0 or flag_RXRIS = &H0 or flag_RTRIS = &H0 or flag_RORRIS = &H0 Then read
        If flag_TXRIS = &H0 Then write_TXRIS_value = get_TXRIS
        If flag_RXRIS = &H0 Then write_RXRIS_value = get_RXRIS
        If flag_RTRIS = &H0 Then write_RTRIS_value = get_RTRIS
        If flag_RORRIS = &H0 Then write_RORRIS_value = get_RORRIS

        regValue = leftShift((write_TXRIS_value and &H1), 3) + leftShift((write_RXRIS_value and &H1), 2) + leftShift((write_RTRIS_value and &H1), 1) + leftShift((write_RORRIS_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TXRIS_value = rightShift(data_low, 3) and &H1
        read_RXRIS_value = rightShift(data_low, 2) and &H1
        read_RTRIS_value = rightShift(data_low, 1) and &H1
        RORRIS_mask = &H1
        if data_low > LONG_MAX then
            if RORRIS_mask = mask then
                read_RORRIS_value = data_low
            else
                read_RORRIS_value = (data_low - H8000_0000) and RORRIS_mask
            end If
        else
            read_RORRIS_value = data_low and RORRIS_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TXRIS_value = &H0
        flag_TXRIS        = &H0
        write_RXRIS_value = &H0
        flag_RXRIS        = &H0
        write_RTRIS_value = &H0
        flag_RTRIS        = &H0
        write_RORRIS_value = &H0
        flag_RORRIS        = &H0
    End Sub
End Class


'' @REGISTER : SPI1_sspmis
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TXMIS                                      [3:3]            get_TXMIS
''                                                             set_TXMIS
''                                                             read_TXMIS
''                                                             write_TXMIS
''---------------------------------------------------------------------------------
'' RXMIS                                      [2:2]            get_RXMIS
''                                                             set_RXMIS
''                                                             read_RXMIS
''                                                             write_RXMIS
''---------------------------------------------------------------------------------
'' RTMIS                                      [1:1]            get_RTMIS
''                                                             set_RTMIS
''                                                             read_RTMIS
''                                                             write_RTMIS
''---------------------------------------------------------------------------------
'' RORMIS                                     [0:0]            get_RORMIS
''                                                             set_RORMIS
''                                                             read_RORMIS
''                                                             write_RORMIS
''---------------------------------------------------------------------------------
Class REGISTER_SPI1_sspmis
    Private write_TXMIS_value
    Private read_TXMIS_value
    Private flag_TXMIS
    Private write_RXMIS_value
    Private read_RXMIS_value
    Private flag_RXMIS
    Private write_RTMIS_value
    Private read_RTMIS_value
    Private flag_RTMIS
    Private write_RORMIS_value
    Private read_RORMIS_value
    Private flag_RORMIS

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

    Property Get get_TXMIS
        get_TXMIS = read_TXMIS_value
    End Property

    Property Let set_TXMIS(aData)
        write_TXMIS_value = aData
        flag_TXMIS        = &H1
    End Property

    Property Get read_TXMIS
        read
        read_TXMIS = read_TXMIS_value
    End Property

    Property Let write_TXMIS(aData)
        set_TXMIS = aData
        write
    End Property

    Property Get get_RXMIS
        get_RXMIS = read_RXMIS_value
    End Property

    Property Let set_RXMIS(aData)
        write_RXMIS_value = aData
        flag_RXMIS        = &H1
    End Property

    Property Get read_RXMIS
        read
        read_RXMIS = read_RXMIS_value
    End Property

    Property Let write_RXMIS(aData)
        set_RXMIS = aData
        write
    End Property

    Property Get get_RTMIS
        get_RTMIS = read_RTMIS_value
    End Property

    Property Let set_RTMIS(aData)
        write_RTMIS_value = aData
        flag_RTMIS        = &H1
    End Property

    Property Get read_RTMIS
        read
        read_RTMIS = read_RTMIS_value
    End Property

    Property Let write_RTMIS(aData)
        set_RTMIS = aData
        write
    End Property

    Property Get get_RORMIS
        get_RORMIS = read_RORMIS_value
    End Property

    Property Let set_RORMIS(aData)
        write_RORMIS_value = aData
        flag_RORMIS        = &H1
    End Property

    Property Get read_RORMIS
        read
        read_RORMIS = read_RORMIS_value
    End Property

    Property Let write_RORMIS(aData)
        set_RORMIS = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TXMIS_value = rightShift(data_low, 3) and &H1
        read_RXMIS_value = rightShift(data_low, 2) and &H1
        read_RTMIS_value = rightShift(data_low, 1) and &H1
        RORMIS_mask = &H1
        if data_low > LONG_MAX then
            if RORMIS_mask = mask then
                read_RORMIS_value = data_low
            else
                read_RORMIS_value = (data_low - H8000_0000) and RORMIS_mask
            end If
        else
            read_RORMIS_value = data_low and RORMIS_mask
        end If

    End Sub

    Sub write
        If flag_TXMIS = &H0 or flag_RXMIS = &H0 or flag_RTMIS = &H0 or flag_RORMIS = &H0 Then read
        If flag_TXMIS = &H0 Then write_TXMIS_value = get_TXMIS
        If flag_RXMIS = &H0 Then write_RXMIS_value = get_RXMIS
        If flag_RTMIS = &H0 Then write_RTMIS_value = get_RTMIS
        If flag_RORMIS = &H0 Then write_RORMIS_value = get_RORMIS

        regValue = leftShift((write_TXMIS_value and &H1), 3) + leftShift((write_RXMIS_value and &H1), 2) + leftShift((write_RTMIS_value and &H1), 1) + leftShift((write_RORMIS_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TXMIS_value = rightShift(data_low, 3) and &H1
        read_RXMIS_value = rightShift(data_low, 2) and &H1
        read_RTMIS_value = rightShift(data_low, 1) and &H1
        RORMIS_mask = &H1
        if data_low > LONG_MAX then
            if RORMIS_mask = mask then
                read_RORMIS_value = data_low
            else
                read_RORMIS_value = (data_low - H8000_0000) and RORMIS_mask
            end If
        else
            read_RORMIS_value = data_low and RORMIS_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TXMIS_value = &H0
        flag_TXMIS        = &H0
        write_RXMIS_value = &H0
        flag_RXMIS        = &H0
        write_RTMIS_value = &H0
        flag_RTMIS        = &H0
        write_RORMIS_value = &H0
        flag_RORMIS        = &H0
    End Sub
End Class


'' @REGISTER : SPI1_sspicr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' RTIC                                       [1:1]            get_RTIC
''                                                             set_RTIC
''                                                             read_RTIC
''                                                             write_RTIC
''---------------------------------------------------------------------------------
'' RORIC                                      [0:0]            get_RORIC
''                                                             set_RORIC
''                                                             read_RORIC
''                                                             write_RORIC
''---------------------------------------------------------------------------------
Class REGISTER_SPI1_sspicr
    Private write_RTIC_value
    Private read_RTIC_value
    Private flag_RTIC
    Private write_RORIC_value
    Private read_RORIC_value
    Private flag_RORIC

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

    Property Get get_RTIC
        get_RTIC = read_RTIC_value
    End Property

    Property Let set_RTIC(aData)
        write_RTIC_value = aData
        flag_RTIC        = &H1
    End Property

    Property Get read_RTIC
        read
        read_RTIC = read_RTIC_value
    End Property

    Property Let write_RTIC(aData)
        set_RTIC = aData
        write
    End Property

    Property Get get_RORIC
        get_RORIC = read_RORIC_value
    End Property

    Property Let set_RORIC(aData)
        write_RORIC_value = aData
        flag_RORIC        = &H1
    End Property

    Property Get read_RORIC
        read
        read_RORIC = read_RORIC_value
    End Property

    Property Let write_RORIC(aData)
        set_RORIC = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_RTIC_value = rightShift(data_low, 1) and &H1
        RORIC_mask = &H1
        if data_low > LONG_MAX then
            if RORIC_mask = mask then
                read_RORIC_value = data_low
            else
                read_RORIC_value = (data_low - H8000_0000) and RORIC_mask
            end If
        else
            read_RORIC_value = data_low and RORIC_mask
        end If

    End Sub

    Sub write
        If flag_RTIC = &H0 or flag_RORIC = &H0 Then read
        If flag_RTIC = &H0 Then write_RTIC_value = get_RTIC
        If flag_RORIC = &H0 Then write_RORIC_value = get_RORIC

        regValue = leftShift((write_RTIC_value and &H1), 1) + leftShift((write_RORIC_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_RTIC_value = rightShift(data_low, 1) and &H1
        RORIC_mask = &H1
        if data_low > LONG_MAX then
            if RORIC_mask = mask then
                read_RORIC_value = data_low
            else
                read_RORIC_value = (data_low - H8000_0000) and RORIC_mask
            end If
        else
            read_RORIC_value = data_low and RORIC_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_RTIC_value = &H0
        flag_RTIC        = &H0
        write_RORIC_value = &H0
        flag_RORIC        = &H0
    End Sub
End Class


'' @REGISTER : SPI1_sspdmacr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TXDMAE                                     [1:1]            get_TXDMAE
''                                                             set_TXDMAE
''                                                             read_TXDMAE
''                                                             write_TXDMAE
''---------------------------------------------------------------------------------
'' RXDMAE                                     [0:0]            get_RXDMAE
''                                                             set_RXDMAE
''                                                             read_RXDMAE
''                                                             write_RXDMAE
''---------------------------------------------------------------------------------
Class REGISTER_SPI1_sspdmacr
    Private write_TXDMAE_value
    Private read_TXDMAE_value
    Private flag_TXDMAE
    Private write_RXDMAE_value
    Private read_RXDMAE_value
    Private flag_RXDMAE

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

    Property Get get_TXDMAE
        get_TXDMAE = read_TXDMAE_value
    End Property

    Property Let set_TXDMAE(aData)
        write_TXDMAE_value = aData
        flag_TXDMAE        = &H1
    End Property

    Property Get read_TXDMAE
        read
        read_TXDMAE = read_TXDMAE_value
    End Property

    Property Let write_TXDMAE(aData)
        set_TXDMAE = aData
        write
    End Property

    Property Get get_RXDMAE
        get_RXDMAE = read_RXDMAE_value
    End Property

    Property Let set_RXDMAE(aData)
        write_RXDMAE_value = aData
        flag_RXDMAE        = &H1
    End Property

    Property Get read_RXDMAE
        read
        read_RXDMAE = read_RXDMAE_value
    End Property

    Property Let write_RXDMAE(aData)
        set_RXDMAE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TXDMAE_value = rightShift(data_low, 1) and &H1
        RXDMAE_mask = &H1
        if data_low > LONG_MAX then
            if RXDMAE_mask = mask then
                read_RXDMAE_value = data_low
            else
                read_RXDMAE_value = (data_low - H8000_0000) and RXDMAE_mask
            end If
        else
            read_RXDMAE_value = data_low and RXDMAE_mask
        end If

    End Sub

    Sub write
        If flag_TXDMAE = &H0 or flag_RXDMAE = &H0 Then read
        If flag_TXDMAE = &H0 Then write_TXDMAE_value = get_TXDMAE
        If flag_RXDMAE = &H0 Then write_RXDMAE_value = get_RXDMAE

        regValue = leftShift((write_TXDMAE_value and &H1), 1) + leftShift((write_RXDMAE_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TXDMAE_value = rightShift(data_low, 1) and &H1
        RXDMAE_mask = &H1
        if data_low > LONG_MAX then
            if RXDMAE_mask = mask then
                read_RXDMAE_value = data_low
            else
                read_RXDMAE_value = (data_low - H8000_0000) and RXDMAE_mask
            end If
        else
            read_RXDMAE_value = data_low and RXDMAE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TXDMAE_value = &H0
        flag_TXDMAE        = &H0
        write_RXDMAE_value = &H0
        flag_RXDMAE        = &H0
    End Sub
End Class


'' @REGISTER : SPI1_sspperiphid0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PartNumber0                                [7:0]            get_PartNumber0
''                                                             set_PartNumber0
''                                                             read_PartNumber0
''                                                             write_PartNumber0
''---------------------------------------------------------------------------------
Class REGISTER_SPI1_sspperiphid0
    Private write_PartNumber0_value
    Private read_PartNumber0_value
    Private flag_PartNumber0

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hfe0
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_PartNumber0
        get_PartNumber0 = read_PartNumber0_value
    End Property

    Property Let set_PartNumber0(aData)
        write_PartNumber0_value = aData
        flag_PartNumber0        = &H1
    End Property

    Property Get read_PartNumber0
        read
        read_PartNumber0 = read_PartNumber0_value
    End Property

    Property Let write_PartNumber0(aData)
        set_PartNumber0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PartNumber0_mask = &Hff
        if data_low > LONG_MAX then
            if PartNumber0_mask = mask then
                read_PartNumber0_value = data_low
            else
                read_PartNumber0_value = (data_low - H8000_0000) and PartNumber0_mask
            end If
        else
            read_PartNumber0_value = data_low and PartNumber0_mask
        end If

    End Sub

    Sub write
        If flag_PartNumber0 = &H0 Then read
        If flag_PartNumber0 = &H0 Then write_PartNumber0_value = get_PartNumber0

        regValue = leftShift((write_PartNumber0_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PartNumber0_mask = &Hff
        if data_low > LONG_MAX then
            if PartNumber0_mask = mask then
                read_PartNumber0_value = data_low
            else
                read_PartNumber0_value = (data_low - H8000_0000) and PartNumber0_mask
            end If
        else
            read_PartNumber0_value = data_low and PartNumber0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PartNumber0_value = &H0
        flag_PartNumber0        = &H0
    End Sub
End Class


'' @REGISTER : SPI1_sspperiphid1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' Designer0                                  [7:4]            get_Designer0
''                                                             set_Designer0
''                                                             read_Designer0
''                                                             write_Designer0
''---------------------------------------------------------------------------------
'' PartNumber1                                [3:0]            get_PartNumber1
''                                                             set_PartNumber1
''                                                             read_PartNumber1
''                                                             write_PartNumber1
''---------------------------------------------------------------------------------
Class REGISTER_SPI1_sspperiphid1
    Private write_Designer0_value
    Private read_Designer0_value
    Private flag_Designer0
    Private write_PartNumber1_value
    Private read_PartNumber1_value
    Private flag_PartNumber1

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hfe4
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_Designer0
        get_Designer0 = read_Designer0_value
    End Property

    Property Let set_Designer0(aData)
        write_Designer0_value = aData
        flag_Designer0        = &H1
    End Property

    Property Get read_Designer0
        read
        read_Designer0 = read_Designer0_value
    End Property

    Property Let write_Designer0(aData)
        set_Designer0 = aData
        write
    End Property

    Property Get get_PartNumber1
        get_PartNumber1 = read_PartNumber1_value
    End Property

    Property Let set_PartNumber1(aData)
        write_PartNumber1_value = aData
        flag_PartNumber1        = &H1
    End Property

    Property Get read_PartNumber1
        read
        read_PartNumber1 = read_PartNumber1_value
    End Property

    Property Let write_PartNumber1(aData)
        set_PartNumber1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_Designer0_value = rightShift(data_low, 4) and &Hf
        PartNumber1_mask = &Hf
        if data_low > LONG_MAX then
            if PartNumber1_mask = mask then
                read_PartNumber1_value = data_low
            else
                read_PartNumber1_value = (data_low - H8000_0000) and PartNumber1_mask
            end If
        else
            read_PartNumber1_value = data_low and PartNumber1_mask
        end If

    End Sub

    Sub write
        If flag_Designer0 = &H0 or flag_PartNumber1 = &H0 Then read
        If flag_Designer0 = &H0 Then write_Designer0_value = get_Designer0
        If flag_PartNumber1 = &H0 Then write_PartNumber1_value = get_PartNumber1

        regValue = leftShift((write_Designer0_value and &Hf), 4) + leftShift((write_PartNumber1_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_Designer0_value = rightShift(data_low, 4) and &Hf
        PartNumber1_mask = &Hf
        if data_low > LONG_MAX then
            if PartNumber1_mask = mask then
                read_PartNumber1_value = data_low
            else
                read_PartNumber1_value = (data_low - H8000_0000) and PartNumber1_mask
            end If
        else
            read_PartNumber1_value = data_low and PartNumber1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_Designer0_value = &H0
        flag_Designer0        = &H0
        write_PartNumber1_value = &H0
        flag_PartNumber1        = &H0
    End Sub
End Class


'' @REGISTER : SPI1_sspperiphid2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' Revision                                   [7:4]            get_Revision
''                                                             set_Revision
''                                                             read_Revision
''                                                             write_Revision
''---------------------------------------------------------------------------------
'' Designer1                                  [3:0]            get_Designer1
''                                                             set_Designer1
''                                                             read_Designer1
''                                                             write_Designer1
''---------------------------------------------------------------------------------
Class REGISTER_SPI1_sspperiphid2
    Private write_Revision_value
    Private read_Revision_value
    Private flag_Revision
    Private write_Designer1_value
    Private read_Designer1_value
    Private flag_Designer1

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hfe8
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_Revision
        get_Revision = read_Revision_value
    End Property

    Property Let set_Revision(aData)
        write_Revision_value = aData
        flag_Revision        = &H1
    End Property

    Property Get read_Revision
        read
        read_Revision = read_Revision_value
    End Property

    Property Let write_Revision(aData)
        set_Revision = aData
        write
    End Property

    Property Get get_Designer1
        get_Designer1 = read_Designer1_value
    End Property

    Property Let set_Designer1(aData)
        write_Designer1_value = aData
        flag_Designer1        = &H1
    End Property

    Property Get read_Designer1
        read
        read_Designer1 = read_Designer1_value
    End Property

    Property Let write_Designer1(aData)
        set_Designer1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_Revision_value = rightShift(data_low, 4) and &Hf
        Designer1_mask = &Hf
        if data_low > LONG_MAX then
            if Designer1_mask = mask then
                read_Designer1_value = data_low
            else
                read_Designer1_value = (data_low - H8000_0000) and Designer1_mask
            end If
        else
            read_Designer1_value = data_low and Designer1_mask
        end If

    End Sub

    Sub write
        If flag_Revision = &H0 or flag_Designer1 = &H0 Then read
        If flag_Revision = &H0 Then write_Revision_value = get_Revision
        If flag_Designer1 = &H0 Then write_Designer1_value = get_Designer1

        regValue = leftShift((write_Revision_value and &Hf), 4) + leftShift((write_Designer1_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_Revision_value = rightShift(data_low, 4) and &Hf
        Designer1_mask = &Hf
        if data_low > LONG_MAX then
            if Designer1_mask = mask then
                read_Designer1_value = data_low
            else
                read_Designer1_value = (data_low - H8000_0000) and Designer1_mask
            end If
        else
            read_Designer1_value = data_low and Designer1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_Revision_value = &H0
        flag_Revision        = &H0
        write_Designer1_value = &H0
        flag_Designer1        = &H0
    End Sub
End Class


'' @REGISTER : SPI1_sspperiphid3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' Configuration                              [7:0]            get_Configuration
''                                                             set_Configuration
''                                                             read_Configuration
''                                                             write_Configuration
''---------------------------------------------------------------------------------
Class REGISTER_SPI1_sspperiphid3
    Private write_Configuration_value
    Private read_Configuration_value
    Private flag_Configuration

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hfec
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_Configuration
        get_Configuration = read_Configuration_value
    End Property

    Property Let set_Configuration(aData)
        write_Configuration_value = aData
        flag_Configuration        = &H1
    End Property

    Property Get read_Configuration
        read
        read_Configuration = read_Configuration_value
    End Property

    Property Let write_Configuration(aData)
        set_Configuration = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        Configuration_mask = &Hff
        if data_low > LONG_MAX then
            if Configuration_mask = mask then
                read_Configuration_value = data_low
            else
                read_Configuration_value = (data_low - H8000_0000) and Configuration_mask
            end If
        else
            read_Configuration_value = data_low and Configuration_mask
        end If

    End Sub

    Sub write
        If flag_Configuration = &H0 Then read
        If flag_Configuration = &H0 Then write_Configuration_value = get_Configuration

        regValue = leftShift((write_Configuration_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        Configuration_mask = &Hff
        if data_low > LONG_MAX then
            if Configuration_mask = mask then
                read_Configuration_value = data_low
            else
                read_Configuration_value = (data_low - H8000_0000) and Configuration_mask
            end If
        else
            read_Configuration_value = data_low and Configuration_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_Configuration_value = &H0
        flag_Configuration        = &H0
    End Sub
End Class


'' @REGISTER : SPI1_ssppcellid0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SSPPCellID0                                [7:0]            get_SSPPCellID0
''                                                             set_SSPPCellID0
''                                                             read_SSPPCellID0
''                                                             write_SSPPCellID0
''---------------------------------------------------------------------------------
Class REGISTER_SPI1_ssppcellid0
    Private write_SSPPCellID0_value
    Private read_SSPPCellID0_value
    Private flag_SSPPCellID0

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hff0
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_SSPPCellID0
        get_SSPPCellID0 = read_SSPPCellID0_value
    End Property

    Property Let set_SSPPCellID0(aData)
        write_SSPPCellID0_value = aData
        flag_SSPPCellID0        = &H1
    End Property

    Property Get read_SSPPCellID0
        read
        read_SSPPCellID0 = read_SSPPCellID0_value
    End Property

    Property Let write_SSPPCellID0(aData)
        set_SSPPCellID0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SSPPCellID0_mask = &Hff
        if data_low > LONG_MAX then
            if SSPPCellID0_mask = mask then
                read_SSPPCellID0_value = data_low
            else
                read_SSPPCellID0_value = (data_low - H8000_0000) and SSPPCellID0_mask
            end If
        else
            read_SSPPCellID0_value = data_low and SSPPCellID0_mask
        end If

    End Sub

    Sub write
        If flag_SSPPCellID0 = &H0 Then read
        If flag_SSPPCellID0 = &H0 Then write_SSPPCellID0_value = get_SSPPCellID0

        regValue = leftShift((write_SSPPCellID0_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SSPPCellID0_mask = &Hff
        if data_low > LONG_MAX then
            if SSPPCellID0_mask = mask then
                read_SSPPCellID0_value = data_low
            else
                read_SSPPCellID0_value = (data_low - H8000_0000) and SSPPCellID0_mask
            end If
        else
            read_SSPPCellID0_value = data_low and SSPPCellID0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SSPPCellID0_value = &H0
        flag_SSPPCellID0        = &H0
    End Sub
End Class


'' @REGISTER : SPI1_ssppcellid1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SSPPCellID1                                [7:0]            get_SSPPCellID1
''                                                             set_SSPPCellID1
''                                                             read_SSPPCellID1
''                                                             write_SSPPCellID1
''---------------------------------------------------------------------------------
Class REGISTER_SPI1_ssppcellid1
    Private write_SSPPCellID1_value
    Private read_SSPPCellID1_value
    Private flag_SSPPCellID1

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hff4
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_SSPPCellID1
        get_SSPPCellID1 = read_SSPPCellID1_value
    End Property

    Property Let set_SSPPCellID1(aData)
        write_SSPPCellID1_value = aData
        flag_SSPPCellID1        = &H1
    End Property

    Property Get read_SSPPCellID1
        read
        read_SSPPCellID1 = read_SSPPCellID1_value
    End Property

    Property Let write_SSPPCellID1(aData)
        set_SSPPCellID1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SSPPCellID1_mask = &Hff
        if data_low > LONG_MAX then
            if SSPPCellID1_mask = mask then
                read_SSPPCellID1_value = data_low
            else
                read_SSPPCellID1_value = (data_low - H8000_0000) and SSPPCellID1_mask
            end If
        else
            read_SSPPCellID1_value = data_low and SSPPCellID1_mask
        end If

    End Sub

    Sub write
        If flag_SSPPCellID1 = &H0 Then read
        If flag_SSPPCellID1 = &H0 Then write_SSPPCellID1_value = get_SSPPCellID1

        regValue = leftShift((write_SSPPCellID1_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SSPPCellID1_mask = &Hff
        if data_low > LONG_MAX then
            if SSPPCellID1_mask = mask then
                read_SSPPCellID1_value = data_low
            else
                read_SSPPCellID1_value = (data_low - H8000_0000) and SSPPCellID1_mask
            end If
        else
            read_SSPPCellID1_value = data_low and SSPPCellID1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SSPPCellID1_value = &H0
        flag_SSPPCellID1        = &H0
    End Sub
End Class


'' @REGISTER : SPI1_ssppcellid2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SSPPCellID2                                [7:0]            get_SSPPCellID2
''                                                             set_SSPPCellID2
''                                                             read_SSPPCellID2
''                                                             write_SSPPCellID2
''---------------------------------------------------------------------------------
Class REGISTER_SPI1_ssppcellid2
    Private write_SSPPCellID2_value
    Private read_SSPPCellID2_value
    Private flag_SSPPCellID2

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hff8
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_SSPPCellID2
        get_SSPPCellID2 = read_SSPPCellID2_value
    End Property

    Property Let set_SSPPCellID2(aData)
        write_SSPPCellID2_value = aData
        flag_SSPPCellID2        = &H1
    End Property

    Property Get read_SSPPCellID2
        read
        read_SSPPCellID2 = read_SSPPCellID2_value
    End Property

    Property Let write_SSPPCellID2(aData)
        set_SSPPCellID2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SSPPCellID2_mask = &Hff
        if data_low > LONG_MAX then
            if SSPPCellID2_mask = mask then
                read_SSPPCellID2_value = data_low
            else
                read_SSPPCellID2_value = (data_low - H8000_0000) and SSPPCellID2_mask
            end If
        else
            read_SSPPCellID2_value = data_low and SSPPCellID2_mask
        end If

    End Sub

    Sub write
        If flag_SSPPCellID2 = &H0 Then read
        If flag_SSPPCellID2 = &H0 Then write_SSPPCellID2_value = get_SSPPCellID2

        regValue = leftShift((write_SSPPCellID2_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SSPPCellID2_mask = &Hff
        if data_low > LONG_MAX then
            if SSPPCellID2_mask = mask then
                read_SSPPCellID2_value = data_low
            else
                read_SSPPCellID2_value = (data_low - H8000_0000) and SSPPCellID2_mask
            end If
        else
            read_SSPPCellID2_value = data_low and SSPPCellID2_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SSPPCellID2_value = &H0
        flag_SSPPCellID2        = &H0
    End Sub
End Class


'' @REGISTER : SPI1_ssppcellid3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SSPPCellID3                                [7:0]            get_SSPPCellID3
''                                                             set_SSPPCellID3
''                                                             read_SSPPCellID3
''                                                             write_SSPPCellID3
''---------------------------------------------------------------------------------
Class REGISTER_SPI1_ssppcellid3
    Private write_SSPPCellID3_value
    Private read_SSPPCellID3_value
    Private flag_SSPPCellID3

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hffc
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_SSPPCellID3
        get_SSPPCellID3 = read_SSPPCellID3_value
    End Property

    Property Let set_SSPPCellID3(aData)
        write_SSPPCellID3_value = aData
        flag_SSPPCellID3        = &H1
    End Property

    Property Get read_SSPPCellID3
        read
        read_SSPPCellID3 = read_SSPPCellID3_value
    End Property

    Property Let write_SSPPCellID3(aData)
        set_SSPPCellID3 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SSPPCellID3_mask = &Hff
        if data_low > LONG_MAX then
            if SSPPCellID3_mask = mask then
                read_SSPPCellID3_value = data_low
            else
                read_SSPPCellID3_value = (data_low - H8000_0000) and SSPPCellID3_mask
            end If
        else
            read_SSPPCellID3_value = data_low and SSPPCellID3_mask
        end If

    End Sub

    Sub write
        If flag_SSPPCellID3 = &H0 Then read
        If flag_SSPPCellID3 = &H0 Then write_SSPPCellID3_value = get_SSPPCellID3

        regValue = leftShift((write_SSPPCellID3_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SSPPCellID3_mask = &Hff
        if data_low > LONG_MAX then
            if SSPPCellID3_mask = mask then
                read_SSPPCellID3_value = data_low
            else
                read_SSPPCellID3_value = (data_low - H8000_0000) and SSPPCellID3_mask
            end If
        else
            read_SSPPCellID3_value = data_low and SSPPCellID3_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SSPPCellID3_value = &H0
        flag_SSPPCellID3        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class SPI1_INSTANCE

    Public sspcr0
    Public sspcr1
    Public sspdr
    Public sspsr
    Public sspcpsr
    Public sspimsc
    Public sspris
    Public sspmis
    Public sspicr
    Public sspdmacr
    Public sspperiphid0
    Public sspperiphid1
    Public sspperiphid2
    Public sspperiphid3
    Public ssppcellid0
    Public ssppcellid1
    Public ssppcellid2
    Public ssppcellid3


    Public default function Init(aBaseAddr)
        Set sspcr0 = (New REGISTER_SPI1_sspcr0)(aBaseAddr, 32)
        Set sspcr1 = (New REGISTER_SPI1_sspcr1)(aBaseAddr, 32)
        Set sspdr = (New REGISTER_SPI1_sspdr)(aBaseAddr, 32)
        Set sspsr = (New REGISTER_SPI1_sspsr)(aBaseAddr, 32)
        Set sspcpsr = (New REGISTER_SPI1_sspcpsr)(aBaseAddr, 32)
        Set sspimsc = (New REGISTER_SPI1_sspimsc)(aBaseAddr, 32)
        Set sspris = (New REGISTER_SPI1_sspris)(aBaseAddr, 32)
        Set sspmis = (New REGISTER_SPI1_sspmis)(aBaseAddr, 32)
        Set sspicr = (New REGISTER_SPI1_sspicr)(aBaseAddr, 32)
        Set sspdmacr = (New REGISTER_SPI1_sspdmacr)(aBaseAddr, 32)
        Set sspperiphid0 = (New REGISTER_SPI1_sspperiphid0)(aBaseAddr, 32)
        Set sspperiphid1 = (New REGISTER_SPI1_sspperiphid1)(aBaseAddr, 32)
        Set sspperiphid2 = (New REGISTER_SPI1_sspperiphid2)(aBaseAddr, 32)
        Set sspperiphid3 = (New REGISTER_SPI1_sspperiphid3)(aBaseAddr, 32)
        Set ssppcellid0 = (New REGISTER_SPI1_ssppcellid0)(aBaseAddr, 32)
        Set ssppcellid1 = (New REGISTER_SPI1_ssppcellid1)(aBaseAddr, 32)
        Set ssppcellid2 = (New REGISTER_SPI1_ssppcellid2)(aBaseAddr, 32)
        Set ssppcellid3 = (New REGISTER_SPI1_ssppcellid3)(aBaseAddr, 32)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set SPI1 = CreateObject("System.Collections.ArrayList")
SPI1.Add ((New SPI1_INSTANCE)(&H40141000))


