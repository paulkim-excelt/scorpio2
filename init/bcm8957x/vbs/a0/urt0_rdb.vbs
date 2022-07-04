

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


'' @REGISTER : URT0_uartdr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' OE                                         [11:11]          get_OE
''                                                             set_OE
''                                                             read_OE
''                                                             write_OE
''---------------------------------------------------------------------------------
'' BE                                         [10:10]          get_BE
''                                                             set_BE
''                                                             read_BE
''                                                             write_BE
''---------------------------------------------------------------------------------
'' PE                                         [9:9]            get_PE
''                                                             set_PE
''                                                             read_PE
''                                                             write_PE
''---------------------------------------------------------------------------------
'' FE                                         [8:8]            get_FE
''                                                             set_FE
''                                                             read_FE
''                                                             write_FE
''---------------------------------------------------------------------------------
'' Data                                       [7:0]            get_Data
''                                                             set_Data
''                                                             read_Data
''                                                             write_Data
''---------------------------------------------------------------------------------
Class REGISTER_URT0_uartdr
    Private write_OE_value
    Private read_OE_value
    Private flag_OE
    Private write_BE_value
    Private read_BE_value
    Private flag_BE
    Private write_PE_value
    Private read_PE_value
    Private flag_PE
    Private write_FE_value
    Private read_FE_value
    Private flag_FE
    Private write_Data_value
    Private read_Data_value
    Private flag_Data

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

    Property Get get_OE
        get_OE = read_OE_value
    End Property

    Property Let set_OE(aData)
        write_OE_value = aData
        flag_OE        = &H1
    End Property

    Property Get read_OE
        read
        read_OE = read_OE_value
    End Property

    Property Let write_OE(aData)
        set_OE = aData
        write
    End Property

    Property Get get_BE
        get_BE = read_BE_value
    End Property

    Property Let set_BE(aData)
        write_BE_value = aData
        flag_BE        = &H1
    End Property

    Property Get read_BE
        read
        read_BE = read_BE_value
    End Property

    Property Let write_BE(aData)
        set_BE = aData
        write
    End Property

    Property Get get_PE
        get_PE = read_PE_value
    End Property

    Property Let set_PE(aData)
        write_PE_value = aData
        flag_PE        = &H1
    End Property

    Property Get read_PE
        read
        read_PE = read_PE_value
    End Property

    Property Let write_PE(aData)
        set_PE = aData
        write
    End Property

    Property Get get_FE
        get_FE = read_FE_value
    End Property

    Property Let set_FE(aData)
        write_FE_value = aData
        flag_FE        = &H1
    End Property

    Property Get read_FE
        read
        read_FE = read_FE_value
    End Property

    Property Let write_FE(aData)
        set_FE = aData
        write
    End Property

    Property Get get_Data
        get_Data = read_Data_value
    End Property

    Property Let set_Data(aData)
        write_Data_value = aData
        flag_Data        = &H1
    End Property

    Property Get read_Data
        read
        read_Data = read_Data_value
    End Property

    Property Let write_Data(aData)
        set_Data = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_OE_value = rightShift(data_low, 11) and &H1
        read_BE_value = rightShift(data_low, 10) and &H1
        read_PE_value = rightShift(data_low, 9) and &H1
        read_FE_value = rightShift(data_low, 8) and &H1
        Data_mask = &Hff
        if data_low > LONG_MAX then
            if Data_mask = mask then
                read_Data_value = data_low
            else
                read_Data_value = (data_low - H8000_0000) and Data_mask
            end If
        else
            read_Data_value = data_low and Data_mask
        end If

    End Sub

    Sub write
        If flag_OE = &H0 or flag_BE = &H0 or flag_PE = &H0 or flag_FE = &H0 or flag_Data = &H0 Then read
        If flag_OE = &H0 Then write_OE_value = get_OE
        If flag_BE = &H0 Then write_BE_value = get_BE
        If flag_PE = &H0 Then write_PE_value = get_PE
        If flag_FE = &H0 Then write_FE_value = get_FE
        If flag_Data = &H0 Then write_Data_value = get_Data

        regValue = leftShift((write_OE_value and &H1), 11) + leftShift((write_BE_value and &H1), 10) + leftShift((write_PE_value and &H1), 9) + leftShift((write_FE_value and &H1), 8) + leftShift((write_Data_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_OE_value = rightShift(data_low, 11) and &H1
        read_BE_value = rightShift(data_low, 10) and &H1
        read_PE_value = rightShift(data_low, 9) and &H1
        read_FE_value = rightShift(data_low, 8) and &H1
        Data_mask = &Hff
        if data_low > LONG_MAX then
            if Data_mask = mask then
                read_Data_value = data_low
            else
                read_Data_value = (data_low - H8000_0000) and Data_mask
            end If
        else
            read_Data_value = data_low and Data_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_OE_value = &H0
        flag_OE        = &H0
        write_BE_value = &H0
        flag_BE        = &H0
        write_PE_value = &H0
        flag_PE        = &H0
        write_FE_value = &H0
        flag_FE        = &H0
        write_Data_value = &H0
        flag_Data        = &H0
    End Sub
End Class


'' @REGISTER : URT0_uartrsr_uartecr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' RECEIVE_OE                                 [3:3]            get_RECEIVE_OE
''                                                             set_RECEIVE_OE
''                                                             read_RECEIVE_OE
''                                                             write_RECEIVE_OE
''---------------------------------------------------------------------------------
'' RECEIVE_BE                                 [2:2]            get_RECEIVE_BE
''                                                             set_RECEIVE_BE
''                                                             read_RECEIVE_BE
''                                                             write_RECEIVE_BE
''---------------------------------------------------------------------------------
'' RECEIVE_PE                                 [1:1]            get_RECEIVE_PE
''                                                             set_RECEIVE_PE
''                                                             read_RECEIVE_PE
''                                                             write_RECEIVE_PE
''---------------------------------------------------------------------------------
'' RECEIVE_FE                                 [0:0]            get_RECEIVE_FE
''                                                             set_RECEIVE_FE
''                                                             read_RECEIVE_FE
''                                                             write_RECEIVE_FE
''---------------------------------------------------------------------------------
Class REGISTER_URT0_uartrsr_uartecr
    Private write_RECEIVE_OE_value
    Private read_RECEIVE_OE_value
    Private flag_RECEIVE_OE
    Private write_RECEIVE_BE_value
    Private read_RECEIVE_BE_value
    Private flag_RECEIVE_BE
    Private write_RECEIVE_PE_value
    Private read_RECEIVE_PE_value
    Private flag_RECEIVE_PE
    Private write_RECEIVE_FE_value
    Private read_RECEIVE_FE_value
    Private flag_RECEIVE_FE

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

    Property Get get_RECEIVE_OE
        get_RECEIVE_OE = read_RECEIVE_OE_value
    End Property

    Property Let set_RECEIVE_OE(aData)
        write_RECEIVE_OE_value = aData
        flag_RECEIVE_OE        = &H1
    End Property

    Property Get read_RECEIVE_OE
        read
        read_RECEIVE_OE = read_RECEIVE_OE_value
    End Property

    Property Let write_RECEIVE_OE(aData)
        set_RECEIVE_OE = aData
        write
    End Property

    Property Get get_RECEIVE_BE
        get_RECEIVE_BE = read_RECEIVE_BE_value
    End Property

    Property Let set_RECEIVE_BE(aData)
        write_RECEIVE_BE_value = aData
        flag_RECEIVE_BE        = &H1
    End Property

    Property Get read_RECEIVE_BE
        read
        read_RECEIVE_BE = read_RECEIVE_BE_value
    End Property

    Property Let write_RECEIVE_BE(aData)
        set_RECEIVE_BE = aData
        write
    End Property

    Property Get get_RECEIVE_PE
        get_RECEIVE_PE = read_RECEIVE_PE_value
    End Property

    Property Let set_RECEIVE_PE(aData)
        write_RECEIVE_PE_value = aData
        flag_RECEIVE_PE        = &H1
    End Property

    Property Get read_RECEIVE_PE
        read
        read_RECEIVE_PE = read_RECEIVE_PE_value
    End Property

    Property Let write_RECEIVE_PE(aData)
        set_RECEIVE_PE = aData
        write
    End Property

    Property Get get_RECEIVE_FE
        get_RECEIVE_FE = read_RECEIVE_FE_value
    End Property

    Property Let set_RECEIVE_FE(aData)
        write_RECEIVE_FE_value = aData
        flag_RECEIVE_FE        = &H1
    End Property

    Property Get read_RECEIVE_FE
        read
        read_RECEIVE_FE = read_RECEIVE_FE_value
    End Property

    Property Let write_RECEIVE_FE(aData)
        set_RECEIVE_FE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_RECEIVE_OE_value = rightShift(data_low, 3) and &H1
        read_RECEIVE_BE_value = rightShift(data_low, 2) and &H1
        read_RECEIVE_PE_value = rightShift(data_low, 1) and &H1
        RECEIVE_FE_mask = &H1
        if data_low > LONG_MAX then
            if RECEIVE_FE_mask = mask then
                read_RECEIVE_FE_value = data_low
            else
                read_RECEIVE_FE_value = (data_low - H8000_0000) and RECEIVE_FE_mask
            end If
        else
            read_RECEIVE_FE_value = data_low and RECEIVE_FE_mask
        end If

    End Sub

    Sub write
        If flag_RECEIVE_OE = &H0 or flag_RECEIVE_BE = &H0 or flag_RECEIVE_PE = &H0 or flag_RECEIVE_FE = &H0 Then read
        If flag_RECEIVE_OE = &H0 Then write_RECEIVE_OE_value = get_RECEIVE_OE
        If flag_RECEIVE_BE = &H0 Then write_RECEIVE_BE_value = get_RECEIVE_BE
        If flag_RECEIVE_PE = &H0 Then write_RECEIVE_PE_value = get_RECEIVE_PE
        If flag_RECEIVE_FE = &H0 Then write_RECEIVE_FE_value = get_RECEIVE_FE

        regValue = leftShift((write_RECEIVE_OE_value and &H1), 3) + leftShift((write_RECEIVE_BE_value and &H1), 2) + leftShift((write_RECEIVE_PE_value and &H1), 1) + leftShift((write_RECEIVE_FE_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_RECEIVE_OE_value = rightShift(data_low, 3) and &H1
        read_RECEIVE_BE_value = rightShift(data_low, 2) and &H1
        read_RECEIVE_PE_value = rightShift(data_low, 1) and &H1
        RECEIVE_FE_mask = &H1
        if data_low > LONG_MAX then
            if RECEIVE_FE_mask = mask then
                read_RECEIVE_FE_value = data_low
            else
                read_RECEIVE_FE_value = (data_low - H8000_0000) and RECEIVE_FE_mask
            end If
        else
            read_RECEIVE_FE_value = data_low and RECEIVE_FE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_RECEIVE_OE_value = &H0
        flag_RECEIVE_OE        = &H0
        write_RECEIVE_BE_value = &H0
        flag_RECEIVE_BE        = &H0
        write_RECEIVE_PE_value = &H0
        flag_RECEIVE_PE        = &H0
        write_RECEIVE_FE_value = &H0
        flag_RECEIVE_FE        = &H0
    End Sub
End Class


'' @REGISTER : URT0_uartfr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' RI                                         [8:8]            get_RI
''                                                             set_RI
''                                                             read_RI
''                                                             write_RI
''---------------------------------------------------------------------------------
'' TXFE                                       [7:7]            get_TXFE
''                                                             set_TXFE
''                                                             read_TXFE
''                                                             write_TXFE
''---------------------------------------------------------------------------------
'' RXFF                                       [6:6]            get_RXFF
''                                                             set_RXFF
''                                                             read_RXFF
''                                                             write_RXFF
''---------------------------------------------------------------------------------
'' TXFF                                       [5:5]            get_TXFF
''                                                             set_TXFF
''                                                             read_TXFF
''                                                             write_TXFF
''---------------------------------------------------------------------------------
'' RXFE                                       [4:4]            get_RXFE
''                                                             set_RXFE
''                                                             read_RXFE
''                                                             write_RXFE
''---------------------------------------------------------------------------------
'' BUSY                                       [3:3]            get_BUSY
''                                                             set_BUSY
''                                                             read_BUSY
''                                                             write_BUSY
''---------------------------------------------------------------------------------
'' DCD                                        [2:2]            get_DCD
''                                                             set_DCD
''                                                             read_DCD
''                                                             write_DCD
''---------------------------------------------------------------------------------
'' DSR                                        [1:1]            get_DSR
''                                                             set_DSR
''                                                             read_DSR
''                                                             write_DSR
''---------------------------------------------------------------------------------
'' CTS                                        [0:0]            get_CTS
''                                                             set_CTS
''                                                             read_CTS
''                                                             write_CTS
''---------------------------------------------------------------------------------
Class REGISTER_URT0_uartfr
    Private write_RI_value
    Private read_RI_value
    Private flag_RI
    Private write_TXFE_value
    Private read_TXFE_value
    Private flag_TXFE
    Private write_RXFF_value
    Private read_RXFF_value
    Private flag_RXFF
    Private write_TXFF_value
    Private read_TXFF_value
    Private flag_TXFF
    Private write_RXFE_value
    Private read_RXFE_value
    Private flag_RXFE
    Private write_BUSY_value
    Private read_BUSY_value
    Private flag_BUSY
    Private write_DCD_value
    Private read_DCD_value
    Private flag_DCD
    Private write_DSR_value
    Private read_DSR_value
    Private flag_DSR
    Private write_CTS_value
    Private read_CTS_value
    Private flag_CTS

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

    Property Get get_RI
        get_RI = read_RI_value
    End Property

    Property Let set_RI(aData)
        write_RI_value = aData
        flag_RI        = &H1
    End Property

    Property Get read_RI
        read
        read_RI = read_RI_value
    End Property

    Property Let write_RI(aData)
        set_RI = aData
        write
    End Property

    Property Get get_TXFE
        get_TXFE = read_TXFE_value
    End Property

    Property Let set_TXFE(aData)
        write_TXFE_value = aData
        flag_TXFE        = &H1
    End Property

    Property Get read_TXFE
        read
        read_TXFE = read_TXFE_value
    End Property

    Property Let write_TXFE(aData)
        set_TXFE = aData
        write
    End Property

    Property Get get_RXFF
        get_RXFF = read_RXFF_value
    End Property

    Property Let set_RXFF(aData)
        write_RXFF_value = aData
        flag_RXFF        = &H1
    End Property

    Property Get read_RXFF
        read
        read_RXFF = read_RXFF_value
    End Property

    Property Let write_RXFF(aData)
        set_RXFF = aData
        write
    End Property

    Property Get get_TXFF
        get_TXFF = read_TXFF_value
    End Property

    Property Let set_TXFF(aData)
        write_TXFF_value = aData
        flag_TXFF        = &H1
    End Property

    Property Get read_TXFF
        read
        read_TXFF = read_TXFF_value
    End Property

    Property Let write_TXFF(aData)
        set_TXFF = aData
        write
    End Property

    Property Get get_RXFE
        get_RXFE = read_RXFE_value
    End Property

    Property Let set_RXFE(aData)
        write_RXFE_value = aData
        flag_RXFE        = &H1
    End Property

    Property Get read_RXFE
        read
        read_RXFE = read_RXFE_value
    End Property

    Property Let write_RXFE(aData)
        set_RXFE = aData
        write
    End Property

    Property Get get_BUSY
        get_BUSY = read_BUSY_value
    End Property

    Property Let set_BUSY(aData)
        write_BUSY_value = aData
        flag_BUSY        = &H1
    End Property

    Property Get read_BUSY
        read
        read_BUSY = read_BUSY_value
    End Property

    Property Let write_BUSY(aData)
        set_BUSY = aData
        write
    End Property

    Property Get get_DCD
        get_DCD = read_DCD_value
    End Property

    Property Let set_DCD(aData)
        write_DCD_value = aData
        flag_DCD        = &H1
    End Property

    Property Get read_DCD
        read
        read_DCD = read_DCD_value
    End Property

    Property Let write_DCD(aData)
        set_DCD = aData
        write
    End Property

    Property Get get_DSR
        get_DSR = read_DSR_value
    End Property

    Property Let set_DSR(aData)
        write_DSR_value = aData
        flag_DSR        = &H1
    End Property

    Property Get read_DSR
        read
        read_DSR = read_DSR_value
    End Property

    Property Let write_DSR(aData)
        set_DSR = aData
        write
    End Property

    Property Get get_CTS
        get_CTS = read_CTS_value
    End Property

    Property Let set_CTS(aData)
        write_CTS_value = aData
        flag_CTS        = &H1
    End Property

    Property Get read_CTS
        read
        read_CTS = read_CTS_value
    End Property

    Property Let write_CTS(aData)
        set_CTS = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_RI_value = rightShift(data_low, 8) and &H1
        read_TXFE_value = rightShift(data_low, 7) and &H1
        read_RXFF_value = rightShift(data_low, 6) and &H1
        read_TXFF_value = rightShift(data_low, 5) and &H1
        read_RXFE_value = rightShift(data_low, 4) and &H1
        read_BUSY_value = rightShift(data_low, 3) and &H1
        read_DCD_value = rightShift(data_low, 2) and &H1
        read_DSR_value = rightShift(data_low, 1) and &H1
        CTS_mask = &H1
        if data_low > LONG_MAX then
            if CTS_mask = mask then
                read_CTS_value = data_low
            else
                read_CTS_value = (data_low - H8000_0000) and CTS_mask
            end If
        else
            read_CTS_value = data_low and CTS_mask
        end If

    End Sub

    Sub write
        If flag_RI = &H0 or flag_TXFE = &H0 or flag_RXFF = &H0 or flag_TXFF = &H0 or flag_RXFE = &H0 or flag_BUSY = &H0 or flag_DCD = &H0 or flag_DSR = &H0 or flag_CTS = &H0 Then read
        If flag_RI = &H0 Then write_RI_value = get_RI
        If flag_TXFE = &H0 Then write_TXFE_value = get_TXFE
        If flag_RXFF = &H0 Then write_RXFF_value = get_RXFF
        If flag_TXFF = &H0 Then write_TXFF_value = get_TXFF
        If flag_RXFE = &H0 Then write_RXFE_value = get_RXFE
        If flag_BUSY = &H0 Then write_BUSY_value = get_BUSY
        If flag_DCD = &H0 Then write_DCD_value = get_DCD
        If flag_DSR = &H0 Then write_DSR_value = get_DSR
        If flag_CTS = &H0 Then write_CTS_value = get_CTS

        regValue = leftShift((write_RI_value and &H1), 8) + leftShift((write_TXFE_value and &H1), 7) + leftShift((write_RXFF_value and &H1), 6) + leftShift((write_TXFF_value and &H1), 5) + leftShift((write_RXFE_value and &H1), 4) + leftShift((write_BUSY_value and &H1), 3) + leftShift((write_DCD_value and &H1), 2) + leftShift((write_DSR_value and &H1), 1) + leftShift((write_CTS_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_RI_value = rightShift(data_low, 8) and &H1
        read_TXFE_value = rightShift(data_low, 7) and &H1
        read_RXFF_value = rightShift(data_low, 6) and &H1
        read_TXFF_value = rightShift(data_low, 5) and &H1
        read_RXFE_value = rightShift(data_low, 4) and &H1
        read_BUSY_value = rightShift(data_low, 3) and &H1
        read_DCD_value = rightShift(data_low, 2) and &H1
        read_DSR_value = rightShift(data_low, 1) and &H1
        CTS_mask = &H1
        if data_low > LONG_MAX then
            if CTS_mask = mask then
                read_CTS_value = data_low
            else
                read_CTS_value = (data_low - H8000_0000) and CTS_mask
            end If
        else
            read_CTS_value = data_low and CTS_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_RI_value = &H0
        flag_RI        = &H0
        write_TXFE_value = &H0
        flag_TXFE        = &H0
        write_RXFF_value = &H0
        flag_RXFF        = &H0
        write_TXFF_value = &H0
        flag_TXFF        = &H0
        write_RXFE_value = &H0
        flag_RXFE        = &H0
        write_BUSY_value = &H0
        flag_BUSY        = &H0
        write_DCD_value = &H0
        flag_DCD        = &H0
        write_DSR_value = &H0
        flag_DSR        = &H0
        write_CTS_value = &H0
        flag_CTS        = &H0
    End Sub
End Class


'' @REGISTER : URT0_uartilpr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ILPDVSR                                    [7:0]            get_ILPDVSR
''                                                             set_ILPDVSR
''                                                             read_ILPDVSR
''                                                             write_ILPDVSR
''---------------------------------------------------------------------------------
Class REGISTER_URT0_uartilpr
    Private write_ILPDVSR_value
    Private read_ILPDVSR_value
    Private flag_ILPDVSR

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

    Property Get get_ILPDVSR
        get_ILPDVSR = read_ILPDVSR_value
    End Property

    Property Let set_ILPDVSR(aData)
        write_ILPDVSR_value = aData
        flag_ILPDVSR        = &H1
    End Property

    Property Get read_ILPDVSR
        read
        read_ILPDVSR = read_ILPDVSR_value
    End Property

    Property Let write_ILPDVSR(aData)
        set_ILPDVSR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ILPDVSR_mask = &Hff
        if data_low > LONG_MAX then
            if ILPDVSR_mask = mask then
                read_ILPDVSR_value = data_low
            else
                read_ILPDVSR_value = (data_low - H8000_0000) and ILPDVSR_mask
            end If
        else
            read_ILPDVSR_value = data_low and ILPDVSR_mask
        end If

    End Sub

    Sub write
        If flag_ILPDVSR = &H0 Then read
        If flag_ILPDVSR = &H0 Then write_ILPDVSR_value = get_ILPDVSR

        regValue = leftShift((write_ILPDVSR_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ILPDVSR_mask = &Hff
        if data_low > LONG_MAX then
            if ILPDVSR_mask = mask then
                read_ILPDVSR_value = data_low
            else
                read_ILPDVSR_value = (data_low - H8000_0000) and ILPDVSR_mask
            end If
        else
            read_ILPDVSR_value = data_low and ILPDVSR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ILPDVSR_value = &H0
        flag_ILPDVSR        = &H0
    End Sub
End Class


'' @REGISTER : URT0_uartibrd
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' BAUD_DIVINT                                [15:0]           get_BAUD_DIVINT
''                                                             set_BAUD_DIVINT
''                                                             read_BAUD_DIVINT
''                                                             write_BAUD_DIVINT
''---------------------------------------------------------------------------------
Class REGISTER_URT0_uartibrd
    Private write_BAUD_DIVINT_value
    Private read_BAUD_DIVINT_value
    Private flag_BAUD_DIVINT

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

    Property Get get_BAUD_DIVINT
        get_BAUD_DIVINT = read_BAUD_DIVINT_value
    End Property

    Property Let set_BAUD_DIVINT(aData)
        write_BAUD_DIVINT_value = aData
        flag_BAUD_DIVINT        = &H1
    End Property

    Property Get read_BAUD_DIVINT
        read
        read_BAUD_DIVINT = read_BAUD_DIVINT_value
    End Property

    Property Let write_BAUD_DIVINT(aData)
        set_BAUD_DIVINT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        BAUD_DIVINT_mask = &Hffff
        if data_low > LONG_MAX then
            if BAUD_DIVINT_mask = mask then
                read_BAUD_DIVINT_value = data_low
            else
                read_BAUD_DIVINT_value = (data_low - H8000_0000) and BAUD_DIVINT_mask
            end If
        else
            read_BAUD_DIVINT_value = data_low and BAUD_DIVINT_mask
        end If

    End Sub

    Sub write
        If flag_BAUD_DIVINT = &H0 Then read
        If flag_BAUD_DIVINT = &H0 Then write_BAUD_DIVINT_value = get_BAUD_DIVINT

        regValue = leftShift((write_BAUD_DIVINT_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        BAUD_DIVINT_mask = &Hffff
        if data_low > LONG_MAX then
            if BAUD_DIVINT_mask = mask then
                read_BAUD_DIVINT_value = data_low
            else
                read_BAUD_DIVINT_value = (data_low - H8000_0000) and BAUD_DIVINT_mask
            end If
        else
            read_BAUD_DIVINT_value = data_low and BAUD_DIVINT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_BAUD_DIVINT_value = &H0
        flag_BAUD_DIVINT        = &H0
    End Sub
End Class


'' @REGISTER : URT0_uartfbrd
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' BAUD_DIVFRAC                               [5:0]            get_BAUD_DIVFRAC
''                                                             set_BAUD_DIVFRAC
''                                                             read_BAUD_DIVFRAC
''                                                             write_BAUD_DIVFRAC
''---------------------------------------------------------------------------------
Class REGISTER_URT0_uartfbrd
    Private write_BAUD_DIVFRAC_value
    Private read_BAUD_DIVFRAC_value
    Private flag_BAUD_DIVFRAC

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

    Property Get get_BAUD_DIVFRAC
        get_BAUD_DIVFRAC = read_BAUD_DIVFRAC_value
    End Property

    Property Let set_BAUD_DIVFRAC(aData)
        write_BAUD_DIVFRAC_value = aData
        flag_BAUD_DIVFRAC        = &H1
    End Property

    Property Get read_BAUD_DIVFRAC
        read
        read_BAUD_DIVFRAC = read_BAUD_DIVFRAC_value
    End Property

    Property Let write_BAUD_DIVFRAC(aData)
        set_BAUD_DIVFRAC = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        BAUD_DIVFRAC_mask = &H3f
        if data_low > LONG_MAX then
            if BAUD_DIVFRAC_mask = mask then
                read_BAUD_DIVFRAC_value = data_low
            else
                read_BAUD_DIVFRAC_value = (data_low - H8000_0000) and BAUD_DIVFRAC_mask
            end If
        else
            read_BAUD_DIVFRAC_value = data_low and BAUD_DIVFRAC_mask
        end If

    End Sub

    Sub write
        If flag_BAUD_DIVFRAC = &H0 Then read
        If flag_BAUD_DIVFRAC = &H0 Then write_BAUD_DIVFRAC_value = get_BAUD_DIVFRAC

        regValue = leftShift((write_BAUD_DIVFRAC_value and &H3f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        BAUD_DIVFRAC_mask = &H3f
        if data_low > LONG_MAX then
            if BAUD_DIVFRAC_mask = mask then
                read_BAUD_DIVFRAC_value = data_low
            else
                read_BAUD_DIVFRAC_value = (data_low - H8000_0000) and BAUD_DIVFRAC_mask
            end If
        else
            read_BAUD_DIVFRAC_value = data_low and BAUD_DIVFRAC_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_BAUD_DIVFRAC_value = &H0
        flag_BAUD_DIVFRAC        = &H0
    End Sub
End Class


'' @REGISTER : URT0_uartlcr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SPS                                        [7:7]            get_SPS
''                                                             set_SPS
''                                                             read_SPS
''                                                             write_SPS
''---------------------------------------------------------------------------------
'' FEN                                        [4:4]            get_FEN
''                                                             set_FEN
''                                                             read_FEN
''                                                             write_FEN
''---------------------------------------------------------------------------------
'' STP2                                       [3:3]            get_STP2
''                                                             set_STP2
''                                                             read_STP2
''                                                             write_STP2
''---------------------------------------------------------------------------------
'' EPS                                        [2:2]            get_EPS
''                                                             set_EPS
''                                                             read_EPS
''                                                             write_EPS
''---------------------------------------------------------------------------------
'' PEN                                        [1:1]            get_PEN
''                                                             set_PEN
''                                                             read_PEN
''                                                             write_PEN
''---------------------------------------------------------------------------------
'' BRK                                        [0:0]            get_BRK
''                                                             set_BRK
''                                                             read_BRK
''                                                             write_BRK
''---------------------------------------------------------------------------------
Class REGISTER_URT0_uartlcr
    Private write_SPS_value
    Private read_SPS_value
    Private flag_SPS
    Private write_FEN_value
    Private read_FEN_value
    Private flag_FEN
    Private write_STP2_value
    Private read_STP2_value
    Private flag_STP2
    Private write_EPS_value
    Private read_EPS_value
    Private flag_EPS
    Private write_PEN_value
    Private read_PEN_value
    Private flag_PEN
    Private write_BRK_value
    Private read_BRK_value
    Private flag_BRK

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

    Property Get get_SPS
        get_SPS = read_SPS_value
    End Property

    Property Let set_SPS(aData)
        write_SPS_value = aData
        flag_SPS        = &H1
    End Property

    Property Get read_SPS
        read
        read_SPS = read_SPS_value
    End Property

    Property Let write_SPS(aData)
        set_SPS = aData
        write
    End Property

    Property Get get_FEN
        get_FEN = read_FEN_value
    End Property

    Property Let set_FEN(aData)
        write_FEN_value = aData
        flag_FEN        = &H1
    End Property

    Property Get read_FEN
        read
        read_FEN = read_FEN_value
    End Property

    Property Let write_FEN(aData)
        set_FEN = aData
        write
    End Property

    Property Get get_STP2
        get_STP2 = read_STP2_value
    End Property

    Property Let set_STP2(aData)
        write_STP2_value = aData
        flag_STP2        = &H1
    End Property

    Property Get read_STP2
        read
        read_STP2 = read_STP2_value
    End Property

    Property Let write_STP2(aData)
        set_STP2 = aData
        write
    End Property

    Property Get get_EPS
        get_EPS = read_EPS_value
    End Property

    Property Let set_EPS(aData)
        write_EPS_value = aData
        flag_EPS        = &H1
    End Property

    Property Get read_EPS
        read
        read_EPS = read_EPS_value
    End Property

    Property Let write_EPS(aData)
        set_EPS = aData
        write
    End Property

    Property Get get_PEN
        get_PEN = read_PEN_value
    End Property

    Property Let set_PEN(aData)
        write_PEN_value = aData
        flag_PEN        = &H1
    End Property

    Property Get read_PEN
        read
        read_PEN = read_PEN_value
    End Property

    Property Let write_PEN(aData)
        set_PEN = aData
        write
    End Property

    Property Get get_BRK
        get_BRK = read_BRK_value
    End Property

    Property Let set_BRK(aData)
        write_BRK_value = aData
        flag_BRK        = &H1
    End Property

    Property Get read_BRK
        read
        read_BRK = read_BRK_value
    End Property

    Property Let write_BRK(aData)
        set_BRK = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_SPS_value = rightShift(data_low, 7) and &H1
        read_FEN_value = rightShift(data_low, 4) and &H1
        read_STP2_value = rightShift(data_low, 3) and &H1
        read_EPS_value = rightShift(data_low, 2) and &H1
        read_PEN_value = rightShift(data_low, 1) and &H1
        BRK_mask = &H1
        if data_low > LONG_MAX then
            if BRK_mask = mask then
                read_BRK_value = data_low
            else
                read_BRK_value = (data_low - H8000_0000) and BRK_mask
            end If
        else
            read_BRK_value = data_low and BRK_mask
        end If

    End Sub

    Sub write
        If flag_SPS = &H0 or flag_FEN = &H0 or flag_STP2 = &H0 or flag_EPS = &H0 or flag_PEN = &H0 or flag_BRK = &H0 Then read
        If flag_SPS = &H0 Then write_SPS_value = get_SPS
        If flag_FEN = &H0 Then write_FEN_value = get_FEN
        If flag_STP2 = &H0 Then write_STP2_value = get_STP2
        If flag_EPS = &H0 Then write_EPS_value = get_EPS
        If flag_PEN = &H0 Then write_PEN_value = get_PEN
        If flag_BRK = &H0 Then write_BRK_value = get_BRK

        regValue = leftShift((write_SPS_value and &H1), 7) + leftShift((write_FEN_value and &H1), 4) + leftShift((write_STP2_value and &H1), 3) + leftShift((write_EPS_value and &H1), 2) + leftShift((write_PEN_value and &H1), 1) + leftShift((write_BRK_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_SPS_value = rightShift(data_low, 7) and &H1
        read_FEN_value = rightShift(data_low, 4) and &H1
        read_STP2_value = rightShift(data_low, 3) and &H1
        read_EPS_value = rightShift(data_low, 2) and &H1
        read_PEN_value = rightShift(data_low, 1) and &H1
        BRK_mask = &H1
        if data_low > LONG_MAX then
            if BRK_mask = mask then
                read_BRK_value = data_low
            else
                read_BRK_value = (data_low - H8000_0000) and BRK_mask
            end If
        else
            read_BRK_value = data_low and BRK_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SPS_value = &H0
        flag_SPS        = &H0
        write_FEN_value = &H0
        flag_FEN        = &H0
        write_STP2_value = &H0
        flag_STP2        = &H0
        write_EPS_value = &H0
        flag_EPS        = &H0
        write_PEN_value = &H0
        flag_PEN        = &H0
        write_BRK_value = &H0
        flag_BRK        = &H0
    End Sub
End Class


'' @REGISTER : URT0_uartcr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' CTSEn                                      [15:15]          get_CTSEn
''                                                             set_CTSEn
''                                                             read_CTSEn
''                                                             write_CTSEn
''---------------------------------------------------------------------------------
'' Out2                                       [13:13]          get_Out2
''                                                             set_Out2
''                                                             read_Out2
''                                                             write_Out2
''---------------------------------------------------------------------------------
'' Out1                                       [12:12]          get_Out1
''                                                             set_Out1
''                                                             read_Out1
''                                                             write_Out1
''---------------------------------------------------------------------------------
'' RTS                                        [11:11]          get_RTS
''                                                             set_RTS
''                                                             read_RTS
''                                                             write_RTS
''---------------------------------------------------------------------------------
'' DTR                                        [10:10]          get_DTR
''                                                             set_DTR
''                                                             read_DTR
''                                                             write_DTR
''---------------------------------------------------------------------------------
'' RXE                                        [9:9]            get_RXE
''                                                             set_RXE
''                                                             read_RXE
''                                                             write_RXE
''---------------------------------------------------------------------------------
'' TXE                                        [8:8]            get_TXE
''                                                             set_TXE
''                                                             read_TXE
''                                                             write_TXE
''---------------------------------------------------------------------------------
'' LBE                                        [7:7]            get_LBE
''                                                             set_LBE
''                                                             read_LBE
''                                                             write_LBE
''---------------------------------------------------------------------------------
'' SIRLP                                      [2:2]            get_SIRLP
''                                                             set_SIRLP
''                                                             read_SIRLP
''                                                             write_SIRLP
''---------------------------------------------------------------------------------
'' SIREN                                      [1:1]            get_SIREN
''                                                             set_SIREN
''                                                             read_SIREN
''                                                             write_SIREN
''---------------------------------------------------------------------------------
'' UARTEN                                     [0:0]            get_UARTEN
''                                                             set_UARTEN
''                                                             read_UARTEN
''                                                             write_UARTEN
''---------------------------------------------------------------------------------
Class REGISTER_URT0_uartcr
    Private write_CTSEn_value
    Private read_CTSEn_value
    Private flag_CTSEn
    Private write_Out2_value
    Private read_Out2_value
    Private flag_Out2
    Private write_Out1_value
    Private read_Out1_value
    Private flag_Out1
    Private write_RTS_value
    Private read_RTS_value
    Private flag_RTS
    Private write_DTR_value
    Private read_DTR_value
    Private flag_DTR
    Private write_RXE_value
    Private read_RXE_value
    Private flag_RXE
    Private write_TXE_value
    Private read_TXE_value
    Private flag_TXE
    Private write_LBE_value
    Private read_LBE_value
    Private flag_LBE
    Private write_SIRLP_value
    Private read_SIRLP_value
    Private flag_SIRLP
    Private write_SIREN_value
    Private read_SIREN_value
    Private flag_SIREN
    Private write_UARTEN_value
    Private read_UARTEN_value
    Private flag_UARTEN

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

    Property Get get_CTSEn
        get_CTSEn = read_CTSEn_value
    End Property

    Property Let set_CTSEn(aData)
        write_CTSEn_value = aData
        flag_CTSEn        = &H1
    End Property

    Property Get read_CTSEn
        read
        read_CTSEn = read_CTSEn_value
    End Property

    Property Let write_CTSEn(aData)
        set_CTSEn = aData
        write
    End Property

    Property Get get_Out2
        get_Out2 = read_Out2_value
    End Property

    Property Let set_Out2(aData)
        write_Out2_value = aData
        flag_Out2        = &H1
    End Property

    Property Get read_Out2
        read
        read_Out2 = read_Out2_value
    End Property

    Property Let write_Out2(aData)
        set_Out2 = aData
        write
    End Property

    Property Get get_Out1
        get_Out1 = read_Out1_value
    End Property

    Property Let set_Out1(aData)
        write_Out1_value = aData
        flag_Out1        = &H1
    End Property

    Property Get read_Out1
        read
        read_Out1 = read_Out1_value
    End Property

    Property Let write_Out1(aData)
        set_Out1 = aData
        write
    End Property

    Property Get get_RTS
        get_RTS = read_RTS_value
    End Property

    Property Let set_RTS(aData)
        write_RTS_value = aData
        flag_RTS        = &H1
    End Property

    Property Get read_RTS
        read
        read_RTS = read_RTS_value
    End Property

    Property Let write_RTS(aData)
        set_RTS = aData
        write
    End Property

    Property Get get_DTR
        get_DTR = read_DTR_value
    End Property

    Property Let set_DTR(aData)
        write_DTR_value = aData
        flag_DTR        = &H1
    End Property

    Property Get read_DTR
        read
        read_DTR = read_DTR_value
    End Property

    Property Let write_DTR(aData)
        set_DTR = aData
        write
    End Property

    Property Get get_RXE
        get_RXE = read_RXE_value
    End Property

    Property Let set_RXE(aData)
        write_RXE_value = aData
        flag_RXE        = &H1
    End Property

    Property Get read_RXE
        read
        read_RXE = read_RXE_value
    End Property

    Property Let write_RXE(aData)
        set_RXE = aData
        write
    End Property

    Property Get get_TXE
        get_TXE = read_TXE_value
    End Property

    Property Let set_TXE(aData)
        write_TXE_value = aData
        flag_TXE        = &H1
    End Property

    Property Get read_TXE
        read
        read_TXE = read_TXE_value
    End Property

    Property Let write_TXE(aData)
        set_TXE = aData
        write
    End Property

    Property Get get_LBE
        get_LBE = read_LBE_value
    End Property

    Property Let set_LBE(aData)
        write_LBE_value = aData
        flag_LBE        = &H1
    End Property

    Property Get read_LBE
        read
        read_LBE = read_LBE_value
    End Property

    Property Let write_LBE(aData)
        set_LBE = aData
        write
    End Property

    Property Get get_SIRLP
        get_SIRLP = read_SIRLP_value
    End Property

    Property Let set_SIRLP(aData)
        write_SIRLP_value = aData
        flag_SIRLP        = &H1
    End Property

    Property Get read_SIRLP
        read
        read_SIRLP = read_SIRLP_value
    End Property

    Property Let write_SIRLP(aData)
        set_SIRLP = aData
        write
    End Property

    Property Get get_SIREN
        get_SIREN = read_SIREN_value
    End Property

    Property Let set_SIREN(aData)
        write_SIREN_value = aData
        flag_SIREN        = &H1
    End Property

    Property Get read_SIREN
        read
        read_SIREN = read_SIREN_value
    End Property

    Property Let write_SIREN(aData)
        set_SIREN = aData
        write
    End Property

    Property Get get_UARTEN
        get_UARTEN = read_UARTEN_value
    End Property

    Property Let set_UARTEN(aData)
        write_UARTEN_value = aData
        flag_UARTEN        = &H1
    End Property

    Property Get read_UARTEN
        read
        read_UARTEN = read_UARTEN_value
    End Property

    Property Let write_UARTEN(aData)
        set_UARTEN = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_CTSEn_value = rightShift(data_low, 15) and &H1
        read_Out2_value = rightShift(data_low, 13) and &H1
        read_Out1_value = rightShift(data_low, 12) and &H1
        read_RTS_value = rightShift(data_low, 11) and &H1
        read_DTR_value = rightShift(data_low, 10) and &H1
        read_RXE_value = rightShift(data_low, 9) and &H1
        read_TXE_value = rightShift(data_low, 8) and &H1
        read_LBE_value = rightShift(data_low, 7) and &H1
        read_SIRLP_value = rightShift(data_low, 2) and &H1
        read_SIREN_value = rightShift(data_low, 1) and &H1
        UARTEN_mask = &H1
        if data_low > LONG_MAX then
            if UARTEN_mask = mask then
                read_UARTEN_value = data_low
            else
                read_UARTEN_value = (data_low - H8000_0000) and UARTEN_mask
            end If
        else
            read_UARTEN_value = data_low and UARTEN_mask
        end If

    End Sub

    Sub write
        If flag_CTSEn = &H0 or flag_Out2 = &H0 or flag_Out1 = &H0 or flag_RTS = &H0 or flag_DTR = &H0 or flag_RXE = &H0 or flag_TXE = &H0 or flag_LBE = &H0 or flag_SIRLP = &H0 or flag_SIREN = &H0 or flag_UARTEN = &H0 Then read
        If flag_CTSEn = &H0 Then write_CTSEn_value = get_CTSEn
        If flag_Out2 = &H0 Then write_Out2_value = get_Out2
        If flag_Out1 = &H0 Then write_Out1_value = get_Out1
        If flag_RTS = &H0 Then write_RTS_value = get_RTS
        If flag_DTR = &H0 Then write_DTR_value = get_DTR
        If flag_RXE = &H0 Then write_RXE_value = get_RXE
        If flag_TXE = &H0 Then write_TXE_value = get_TXE
        If flag_LBE = &H0 Then write_LBE_value = get_LBE
        If flag_SIRLP = &H0 Then write_SIRLP_value = get_SIRLP
        If flag_SIREN = &H0 Then write_SIREN_value = get_SIREN
        If flag_UARTEN = &H0 Then write_UARTEN_value = get_UARTEN

        regValue = leftShift((write_CTSEn_value and &H1), 15) + leftShift((write_Out2_value and &H1), 13) + leftShift((write_Out1_value and &H1), 12) + leftShift((write_RTS_value and &H1), 11) + leftShift((write_DTR_value and &H1), 10) + leftShift((write_RXE_value and &H1), 9) + leftShift((write_TXE_value and &H1), 8) + leftShift((write_LBE_value and &H1), 7) + leftShift((write_SIRLP_value and &H1), 2) + leftShift((write_SIREN_value and &H1), 1) + leftShift((write_UARTEN_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_CTSEn_value = rightShift(data_low, 15) and &H1
        read_Out2_value = rightShift(data_low, 13) and &H1
        read_Out1_value = rightShift(data_low, 12) and &H1
        read_RTS_value = rightShift(data_low, 11) and &H1
        read_DTR_value = rightShift(data_low, 10) and &H1
        read_RXE_value = rightShift(data_low, 9) and &H1
        read_TXE_value = rightShift(data_low, 8) and &H1
        read_LBE_value = rightShift(data_low, 7) and &H1
        read_SIRLP_value = rightShift(data_low, 2) and &H1
        read_SIREN_value = rightShift(data_low, 1) and &H1
        UARTEN_mask = &H1
        if data_low > LONG_MAX then
            if UARTEN_mask = mask then
                read_UARTEN_value = data_low
            else
                read_UARTEN_value = (data_low - H8000_0000) and UARTEN_mask
            end If
        else
            read_UARTEN_value = data_low and UARTEN_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_CTSEn_value = &H0
        flag_CTSEn        = &H0
        write_Out2_value = &H0
        flag_Out2        = &H0
        write_Out1_value = &H0
        flag_Out1        = &H0
        write_RTS_value = &H0
        flag_RTS        = &H0
        write_DTR_value = &H0
        flag_DTR        = &H0
        write_RXE_value = &H0
        flag_RXE        = &H0
        write_TXE_value = &H0
        flag_TXE        = &H0
        write_LBE_value = &H0
        flag_LBE        = &H0
        write_SIRLP_value = &H0
        flag_SIRLP        = &H0
        write_SIREN_value = &H0
        flag_SIREN        = &H0
        write_UARTEN_value = &H0
        flag_UARTEN        = &H0
    End Sub
End Class


'' @REGISTER : URT0_uartifls
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' RXIFLSEL                                   [5:3]            get_RXIFLSEL
''                                                             set_RXIFLSEL
''                                                             read_RXIFLSEL
''                                                             write_RXIFLSEL
''---------------------------------------------------------------------------------
'' TXIFLSEL                                   [2:0]            get_TXIFLSEL
''                                                             set_TXIFLSEL
''                                                             read_TXIFLSEL
''                                                             write_TXIFLSEL
''---------------------------------------------------------------------------------
Class REGISTER_URT0_uartifls
    Private write_RXIFLSEL_value
    Private read_RXIFLSEL_value
    Private flag_RXIFLSEL
    Private write_TXIFLSEL_value
    Private read_TXIFLSEL_value
    Private flag_TXIFLSEL

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

    Property Get get_RXIFLSEL
        get_RXIFLSEL = read_RXIFLSEL_value
    End Property

    Property Let set_RXIFLSEL(aData)
        write_RXIFLSEL_value = aData
        flag_RXIFLSEL        = &H1
    End Property

    Property Get read_RXIFLSEL
        read
        read_RXIFLSEL = read_RXIFLSEL_value
    End Property

    Property Let write_RXIFLSEL(aData)
        set_RXIFLSEL = aData
        write
    End Property

    Property Get get_TXIFLSEL
        get_TXIFLSEL = read_TXIFLSEL_value
    End Property

    Property Let set_TXIFLSEL(aData)
        write_TXIFLSEL_value = aData
        flag_TXIFLSEL        = &H1
    End Property

    Property Get read_TXIFLSEL
        read
        read_TXIFLSEL = read_TXIFLSEL_value
    End Property

    Property Let write_TXIFLSEL(aData)
        set_TXIFLSEL = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_RXIFLSEL_value = rightShift(data_low, 3) and &H7
        TXIFLSEL_mask = &H7
        if data_low > LONG_MAX then
            if TXIFLSEL_mask = mask then
                read_TXIFLSEL_value = data_low
            else
                read_TXIFLSEL_value = (data_low - H8000_0000) and TXIFLSEL_mask
            end If
        else
            read_TXIFLSEL_value = data_low and TXIFLSEL_mask
        end If

    End Sub

    Sub write
        If flag_RXIFLSEL = &H0 or flag_TXIFLSEL = &H0 Then read
        If flag_RXIFLSEL = &H0 Then write_RXIFLSEL_value = get_RXIFLSEL
        If flag_TXIFLSEL = &H0 Then write_TXIFLSEL_value = get_TXIFLSEL

        regValue = leftShift((write_RXIFLSEL_value and &H7), 3) + leftShift((write_TXIFLSEL_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_RXIFLSEL_value = rightShift(data_low, 3) and &H7
        TXIFLSEL_mask = &H7
        if data_low > LONG_MAX then
            if TXIFLSEL_mask = mask then
                read_TXIFLSEL_value = data_low
            else
                read_TXIFLSEL_value = (data_low - H8000_0000) and TXIFLSEL_mask
            end If
        else
            read_TXIFLSEL_value = data_low and TXIFLSEL_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_RXIFLSEL_value = &H0
        flag_RXIFLSEL        = &H0
        write_TXIFLSEL_value = &H0
        flag_TXIFLSEL        = &H0
    End Sub
End Class


'' @REGISTER : URT0_uartimsc
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' OEIM                                       [10:10]          get_OEIM
''                                                             set_OEIM
''                                                             read_OEIM
''                                                             write_OEIM
''---------------------------------------------------------------------------------
'' BEIM                                       [9:9]            get_BEIM
''                                                             set_BEIM
''                                                             read_BEIM
''                                                             write_BEIM
''---------------------------------------------------------------------------------
'' PEIM                                       [8:8]            get_PEIM
''                                                             set_PEIM
''                                                             read_PEIM
''                                                             write_PEIM
''---------------------------------------------------------------------------------
'' FEIM                                       [7:7]            get_FEIM
''                                                             set_FEIM
''                                                             read_FEIM
''                                                             write_FEIM
''---------------------------------------------------------------------------------
'' RTIM                                       [6:6]            get_RTIM
''                                                             set_RTIM
''                                                             read_RTIM
''                                                             write_RTIM
''---------------------------------------------------------------------------------
'' TXIM                                       [5:5]            get_TXIM
''                                                             set_TXIM
''                                                             read_TXIM
''                                                             write_TXIM
''---------------------------------------------------------------------------------
'' RXIM                                       [4:4]            get_RXIM
''                                                             set_RXIM
''                                                             read_RXIM
''                                                             write_RXIM
''---------------------------------------------------------------------------------
'' DSRMIM                                     [3:3]            get_DSRMIM
''                                                             set_DSRMIM
''                                                             read_DSRMIM
''                                                             write_DSRMIM
''---------------------------------------------------------------------------------
'' DCDMIM                                     [2:2]            get_DCDMIM
''                                                             set_DCDMIM
''                                                             read_DCDMIM
''                                                             write_DCDMIM
''---------------------------------------------------------------------------------
'' CTSMIM                                     [1:1]            get_CTSMIM
''                                                             set_CTSMIM
''                                                             read_CTSMIM
''                                                             write_CTSMIM
''---------------------------------------------------------------------------------
'' RIMIM                                      [0:0]            get_RIMIM
''                                                             set_RIMIM
''                                                             read_RIMIM
''                                                             write_RIMIM
''---------------------------------------------------------------------------------
Class REGISTER_URT0_uartimsc
    Private write_OEIM_value
    Private read_OEIM_value
    Private flag_OEIM
    Private write_BEIM_value
    Private read_BEIM_value
    Private flag_BEIM
    Private write_PEIM_value
    Private read_PEIM_value
    Private flag_PEIM
    Private write_FEIM_value
    Private read_FEIM_value
    Private flag_FEIM
    Private write_RTIM_value
    Private read_RTIM_value
    Private flag_RTIM
    Private write_TXIM_value
    Private read_TXIM_value
    Private flag_TXIM
    Private write_RXIM_value
    Private read_RXIM_value
    Private flag_RXIM
    Private write_DSRMIM_value
    Private read_DSRMIM_value
    Private flag_DSRMIM
    Private write_DCDMIM_value
    Private read_DCDMIM_value
    Private flag_DCDMIM
    Private write_CTSMIM_value
    Private read_CTSMIM_value
    Private flag_CTSMIM
    Private write_RIMIM_value
    Private read_RIMIM_value
    Private flag_RIMIM

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

    Property Get get_OEIM
        get_OEIM = read_OEIM_value
    End Property

    Property Let set_OEIM(aData)
        write_OEIM_value = aData
        flag_OEIM        = &H1
    End Property

    Property Get read_OEIM
        read
        read_OEIM = read_OEIM_value
    End Property

    Property Let write_OEIM(aData)
        set_OEIM = aData
        write
    End Property

    Property Get get_BEIM
        get_BEIM = read_BEIM_value
    End Property

    Property Let set_BEIM(aData)
        write_BEIM_value = aData
        flag_BEIM        = &H1
    End Property

    Property Get read_BEIM
        read
        read_BEIM = read_BEIM_value
    End Property

    Property Let write_BEIM(aData)
        set_BEIM = aData
        write
    End Property

    Property Get get_PEIM
        get_PEIM = read_PEIM_value
    End Property

    Property Let set_PEIM(aData)
        write_PEIM_value = aData
        flag_PEIM        = &H1
    End Property

    Property Get read_PEIM
        read
        read_PEIM = read_PEIM_value
    End Property

    Property Let write_PEIM(aData)
        set_PEIM = aData
        write
    End Property

    Property Get get_FEIM
        get_FEIM = read_FEIM_value
    End Property

    Property Let set_FEIM(aData)
        write_FEIM_value = aData
        flag_FEIM        = &H1
    End Property

    Property Get read_FEIM
        read
        read_FEIM = read_FEIM_value
    End Property

    Property Let write_FEIM(aData)
        set_FEIM = aData
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

    Property Get get_DSRMIM
        get_DSRMIM = read_DSRMIM_value
    End Property

    Property Let set_DSRMIM(aData)
        write_DSRMIM_value = aData
        flag_DSRMIM        = &H1
    End Property

    Property Get read_DSRMIM
        read
        read_DSRMIM = read_DSRMIM_value
    End Property

    Property Let write_DSRMIM(aData)
        set_DSRMIM = aData
        write
    End Property

    Property Get get_DCDMIM
        get_DCDMIM = read_DCDMIM_value
    End Property

    Property Let set_DCDMIM(aData)
        write_DCDMIM_value = aData
        flag_DCDMIM        = &H1
    End Property

    Property Get read_DCDMIM
        read
        read_DCDMIM = read_DCDMIM_value
    End Property

    Property Let write_DCDMIM(aData)
        set_DCDMIM = aData
        write
    End Property

    Property Get get_CTSMIM
        get_CTSMIM = read_CTSMIM_value
    End Property

    Property Let set_CTSMIM(aData)
        write_CTSMIM_value = aData
        flag_CTSMIM        = &H1
    End Property

    Property Get read_CTSMIM
        read
        read_CTSMIM = read_CTSMIM_value
    End Property

    Property Let write_CTSMIM(aData)
        set_CTSMIM = aData
        write
    End Property

    Property Get get_RIMIM
        get_RIMIM = read_RIMIM_value
    End Property

    Property Let set_RIMIM(aData)
        write_RIMIM_value = aData
        flag_RIMIM        = &H1
    End Property

    Property Get read_RIMIM
        read
        read_RIMIM = read_RIMIM_value
    End Property

    Property Let write_RIMIM(aData)
        set_RIMIM = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_OEIM_value = rightShift(data_low, 10) and &H1
        read_BEIM_value = rightShift(data_low, 9) and &H1
        read_PEIM_value = rightShift(data_low, 8) and &H1
        read_FEIM_value = rightShift(data_low, 7) and &H1
        read_RTIM_value = rightShift(data_low, 6) and &H1
        read_TXIM_value = rightShift(data_low, 5) and &H1
        read_RXIM_value = rightShift(data_low, 4) and &H1
        read_DSRMIM_value = rightShift(data_low, 3) and &H1
        read_DCDMIM_value = rightShift(data_low, 2) and &H1
        read_CTSMIM_value = rightShift(data_low, 1) and &H1
        RIMIM_mask = &H1
        if data_low > LONG_MAX then
            if RIMIM_mask = mask then
                read_RIMIM_value = data_low
            else
                read_RIMIM_value = (data_low - H8000_0000) and RIMIM_mask
            end If
        else
            read_RIMIM_value = data_low and RIMIM_mask
        end If

    End Sub

    Sub write
        If flag_OEIM = &H0 or flag_BEIM = &H0 or flag_PEIM = &H0 or flag_FEIM = &H0 or flag_RTIM = &H0 or flag_TXIM = &H0 or flag_RXIM = &H0 or flag_DSRMIM = &H0 or flag_DCDMIM = &H0 or flag_CTSMIM = &H0 or flag_RIMIM = &H0 Then read
        If flag_OEIM = &H0 Then write_OEIM_value = get_OEIM
        If flag_BEIM = &H0 Then write_BEIM_value = get_BEIM
        If flag_PEIM = &H0 Then write_PEIM_value = get_PEIM
        If flag_FEIM = &H0 Then write_FEIM_value = get_FEIM
        If flag_RTIM = &H0 Then write_RTIM_value = get_RTIM
        If flag_TXIM = &H0 Then write_TXIM_value = get_TXIM
        If flag_RXIM = &H0 Then write_RXIM_value = get_RXIM
        If flag_DSRMIM = &H0 Then write_DSRMIM_value = get_DSRMIM
        If flag_DCDMIM = &H0 Then write_DCDMIM_value = get_DCDMIM
        If flag_CTSMIM = &H0 Then write_CTSMIM_value = get_CTSMIM
        If flag_RIMIM = &H0 Then write_RIMIM_value = get_RIMIM

        regValue = leftShift((write_OEIM_value and &H1), 10) + leftShift((write_BEIM_value and &H1), 9) + leftShift((write_PEIM_value and &H1), 8) + leftShift((write_FEIM_value and &H1), 7) + leftShift((write_RTIM_value and &H1), 6) + leftShift((write_TXIM_value and &H1), 5) + leftShift((write_RXIM_value and &H1), 4) + leftShift((write_DSRMIM_value and &H1), 3) + leftShift((write_DCDMIM_value and &H1), 2) + leftShift((write_CTSMIM_value and &H1), 1) + leftShift((write_RIMIM_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_OEIM_value = rightShift(data_low, 10) and &H1
        read_BEIM_value = rightShift(data_low, 9) and &H1
        read_PEIM_value = rightShift(data_low, 8) and &H1
        read_FEIM_value = rightShift(data_low, 7) and &H1
        read_RTIM_value = rightShift(data_low, 6) and &H1
        read_TXIM_value = rightShift(data_low, 5) and &H1
        read_RXIM_value = rightShift(data_low, 4) and &H1
        read_DSRMIM_value = rightShift(data_low, 3) and &H1
        read_DCDMIM_value = rightShift(data_low, 2) and &H1
        read_CTSMIM_value = rightShift(data_low, 1) and &H1
        RIMIM_mask = &H1
        if data_low > LONG_MAX then
            if RIMIM_mask = mask then
                read_RIMIM_value = data_low
            else
                read_RIMIM_value = (data_low - H8000_0000) and RIMIM_mask
            end If
        else
            read_RIMIM_value = data_low and RIMIM_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_OEIM_value = &H0
        flag_OEIM        = &H0
        write_BEIM_value = &H0
        flag_BEIM        = &H0
        write_PEIM_value = &H0
        flag_PEIM        = &H0
        write_FEIM_value = &H0
        flag_FEIM        = &H0
        write_RTIM_value = &H0
        flag_RTIM        = &H0
        write_TXIM_value = &H0
        flag_TXIM        = &H0
        write_RXIM_value = &H0
        flag_RXIM        = &H0
        write_DSRMIM_value = &H0
        flag_DSRMIM        = &H0
        write_DCDMIM_value = &H0
        flag_DCDMIM        = &H0
        write_CTSMIM_value = &H0
        flag_CTSMIM        = &H0
        write_RIMIM_value = &H0
        flag_RIMIM        = &H0
    End Sub
End Class


'' @REGISTER : URT0_uartris
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' OERIS                                      [10:10]          get_OERIS
''                                                             set_OERIS
''                                                             read_OERIS
''                                                             write_OERIS
''---------------------------------------------------------------------------------
'' BERIS                                      [9:9]            get_BERIS
''                                                             set_BERIS
''                                                             read_BERIS
''                                                             write_BERIS
''---------------------------------------------------------------------------------
'' PERIS                                      [8:8]            get_PERIS
''                                                             set_PERIS
''                                                             read_PERIS
''                                                             write_PERIS
''---------------------------------------------------------------------------------
'' FERIS                                      [7:7]            get_FERIS
''                                                             set_FERIS
''                                                             read_FERIS
''                                                             write_FERIS
''---------------------------------------------------------------------------------
'' RTRIS                                      [6:6]            get_RTRIS
''                                                             set_RTRIS
''                                                             read_RTRIS
''                                                             write_RTRIS
''---------------------------------------------------------------------------------
'' TXRIS                                      [5:5]            get_TXRIS
''                                                             set_TXRIS
''                                                             read_TXRIS
''                                                             write_TXRIS
''---------------------------------------------------------------------------------
'' RXRIS                                      [4:4]            get_RXRIS
''                                                             set_RXRIS
''                                                             read_RXRIS
''                                                             write_RXRIS
''---------------------------------------------------------------------------------
'' DSRRMIS                                    [3:3]            get_DSRRMIS
''                                                             set_DSRRMIS
''                                                             read_DSRRMIS
''                                                             write_DSRRMIS
''---------------------------------------------------------------------------------
'' DCDRMIS                                    [2:2]            get_DCDRMIS
''                                                             set_DCDRMIS
''                                                             read_DCDRMIS
''                                                             write_DCDRMIS
''---------------------------------------------------------------------------------
'' CTSRMIS                                    [1:1]            get_CTSRMIS
''                                                             set_CTSRMIS
''                                                             read_CTSRMIS
''                                                             write_CTSRMIS
''---------------------------------------------------------------------------------
'' RIRMIS                                     [0:0]            get_RIRMIS
''                                                             set_RIRMIS
''                                                             read_RIRMIS
''                                                             write_RIRMIS
''---------------------------------------------------------------------------------
Class REGISTER_URT0_uartris
    Private write_OERIS_value
    Private read_OERIS_value
    Private flag_OERIS
    Private write_BERIS_value
    Private read_BERIS_value
    Private flag_BERIS
    Private write_PERIS_value
    Private read_PERIS_value
    Private flag_PERIS
    Private write_FERIS_value
    Private read_FERIS_value
    Private flag_FERIS
    Private write_RTRIS_value
    Private read_RTRIS_value
    Private flag_RTRIS
    Private write_TXRIS_value
    Private read_TXRIS_value
    Private flag_TXRIS
    Private write_RXRIS_value
    Private read_RXRIS_value
    Private flag_RXRIS
    Private write_DSRRMIS_value
    Private read_DSRRMIS_value
    Private flag_DSRRMIS
    Private write_DCDRMIS_value
    Private read_DCDRMIS_value
    Private flag_DCDRMIS
    Private write_CTSRMIS_value
    Private read_CTSRMIS_value
    Private flag_CTSRMIS
    Private write_RIRMIS_value
    Private read_RIRMIS_value
    Private flag_RIRMIS

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

    Property Get get_OERIS
        get_OERIS = read_OERIS_value
    End Property

    Property Let set_OERIS(aData)
        write_OERIS_value = aData
        flag_OERIS        = &H1
    End Property

    Property Get read_OERIS
        read
        read_OERIS = read_OERIS_value
    End Property

    Property Let write_OERIS(aData)
        set_OERIS = aData
        write
    End Property

    Property Get get_BERIS
        get_BERIS = read_BERIS_value
    End Property

    Property Let set_BERIS(aData)
        write_BERIS_value = aData
        flag_BERIS        = &H1
    End Property

    Property Get read_BERIS
        read
        read_BERIS = read_BERIS_value
    End Property

    Property Let write_BERIS(aData)
        set_BERIS = aData
        write
    End Property

    Property Get get_PERIS
        get_PERIS = read_PERIS_value
    End Property

    Property Let set_PERIS(aData)
        write_PERIS_value = aData
        flag_PERIS        = &H1
    End Property

    Property Get read_PERIS
        read
        read_PERIS = read_PERIS_value
    End Property

    Property Let write_PERIS(aData)
        set_PERIS = aData
        write
    End Property

    Property Get get_FERIS
        get_FERIS = read_FERIS_value
    End Property

    Property Let set_FERIS(aData)
        write_FERIS_value = aData
        flag_FERIS        = &H1
    End Property

    Property Get read_FERIS
        read
        read_FERIS = read_FERIS_value
    End Property

    Property Let write_FERIS(aData)
        set_FERIS = aData
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

    Property Get get_DSRRMIS
        get_DSRRMIS = read_DSRRMIS_value
    End Property

    Property Let set_DSRRMIS(aData)
        write_DSRRMIS_value = aData
        flag_DSRRMIS        = &H1
    End Property

    Property Get read_DSRRMIS
        read
        read_DSRRMIS = read_DSRRMIS_value
    End Property

    Property Let write_DSRRMIS(aData)
        set_DSRRMIS = aData
        write
    End Property

    Property Get get_DCDRMIS
        get_DCDRMIS = read_DCDRMIS_value
    End Property

    Property Let set_DCDRMIS(aData)
        write_DCDRMIS_value = aData
        flag_DCDRMIS        = &H1
    End Property

    Property Get read_DCDRMIS
        read
        read_DCDRMIS = read_DCDRMIS_value
    End Property

    Property Let write_DCDRMIS(aData)
        set_DCDRMIS = aData
        write
    End Property

    Property Get get_CTSRMIS
        get_CTSRMIS = read_CTSRMIS_value
    End Property

    Property Let set_CTSRMIS(aData)
        write_CTSRMIS_value = aData
        flag_CTSRMIS        = &H1
    End Property

    Property Get read_CTSRMIS
        read
        read_CTSRMIS = read_CTSRMIS_value
    End Property

    Property Let write_CTSRMIS(aData)
        set_CTSRMIS = aData
        write
    End Property

    Property Get get_RIRMIS
        get_RIRMIS = read_RIRMIS_value
    End Property

    Property Let set_RIRMIS(aData)
        write_RIRMIS_value = aData
        flag_RIRMIS        = &H1
    End Property

    Property Get read_RIRMIS
        read
        read_RIRMIS = read_RIRMIS_value
    End Property

    Property Let write_RIRMIS(aData)
        set_RIRMIS = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_OERIS_value = rightShift(data_low, 10) and &H1
        read_BERIS_value = rightShift(data_low, 9) and &H1
        read_PERIS_value = rightShift(data_low, 8) and &H1
        read_FERIS_value = rightShift(data_low, 7) and &H1
        read_RTRIS_value = rightShift(data_low, 6) and &H1
        read_TXRIS_value = rightShift(data_low, 5) and &H1
        read_RXRIS_value = rightShift(data_low, 4) and &H1
        read_DSRRMIS_value = rightShift(data_low, 3) and &H1
        read_DCDRMIS_value = rightShift(data_low, 2) and &H1
        read_CTSRMIS_value = rightShift(data_low, 1) and &H1
        RIRMIS_mask = &H1
        if data_low > LONG_MAX then
            if RIRMIS_mask = mask then
                read_RIRMIS_value = data_low
            else
                read_RIRMIS_value = (data_low - H8000_0000) and RIRMIS_mask
            end If
        else
            read_RIRMIS_value = data_low and RIRMIS_mask
        end If

    End Sub

    Sub write
        If flag_OERIS = &H0 or flag_BERIS = &H0 or flag_PERIS = &H0 or flag_FERIS = &H0 or flag_RTRIS = &H0 or flag_TXRIS = &H0 or flag_RXRIS = &H0 or flag_DSRRMIS = &H0 or flag_DCDRMIS = &H0 or flag_CTSRMIS = &H0 or flag_RIRMIS = &H0 Then read
        If flag_OERIS = &H0 Then write_OERIS_value = get_OERIS
        If flag_BERIS = &H0 Then write_BERIS_value = get_BERIS
        If flag_PERIS = &H0 Then write_PERIS_value = get_PERIS
        If flag_FERIS = &H0 Then write_FERIS_value = get_FERIS
        If flag_RTRIS = &H0 Then write_RTRIS_value = get_RTRIS
        If flag_TXRIS = &H0 Then write_TXRIS_value = get_TXRIS
        If flag_RXRIS = &H0 Then write_RXRIS_value = get_RXRIS
        If flag_DSRRMIS = &H0 Then write_DSRRMIS_value = get_DSRRMIS
        If flag_DCDRMIS = &H0 Then write_DCDRMIS_value = get_DCDRMIS
        If flag_CTSRMIS = &H0 Then write_CTSRMIS_value = get_CTSRMIS
        If flag_RIRMIS = &H0 Then write_RIRMIS_value = get_RIRMIS

        regValue = leftShift((write_OERIS_value and &H1), 10) + leftShift((write_BERIS_value and &H1), 9) + leftShift((write_PERIS_value and &H1), 8) + leftShift((write_FERIS_value and &H1), 7) + leftShift((write_RTRIS_value and &H1), 6) + leftShift((write_TXRIS_value and &H1), 5) + leftShift((write_RXRIS_value and &H1), 4) + leftShift((write_DSRRMIS_value and &H1), 3) + leftShift((write_DCDRMIS_value and &H1), 2) + leftShift((write_CTSRMIS_value and &H1), 1) + leftShift((write_RIRMIS_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_OERIS_value = rightShift(data_low, 10) and &H1
        read_BERIS_value = rightShift(data_low, 9) and &H1
        read_PERIS_value = rightShift(data_low, 8) and &H1
        read_FERIS_value = rightShift(data_low, 7) and &H1
        read_RTRIS_value = rightShift(data_low, 6) and &H1
        read_TXRIS_value = rightShift(data_low, 5) and &H1
        read_RXRIS_value = rightShift(data_low, 4) and &H1
        read_DSRRMIS_value = rightShift(data_low, 3) and &H1
        read_DCDRMIS_value = rightShift(data_low, 2) and &H1
        read_CTSRMIS_value = rightShift(data_low, 1) and &H1
        RIRMIS_mask = &H1
        if data_low > LONG_MAX then
            if RIRMIS_mask = mask then
                read_RIRMIS_value = data_low
            else
                read_RIRMIS_value = (data_low - H8000_0000) and RIRMIS_mask
            end If
        else
            read_RIRMIS_value = data_low and RIRMIS_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_OERIS_value = &H0
        flag_OERIS        = &H0
        write_BERIS_value = &H0
        flag_BERIS        = &H0
        write_PERIS_value = &H0
        flag_PERIS        = &H0
        write_FERIS_value = &H0
        flag_FERIS        = &H0
        write_RTRIS_value = &H0
        flag_RTRIS        = &H0
        write_TXRIS_value = &H0
        flag_TXRIS        = &H0
        write_RXRIS_value = &H0
        flag_RXRIS        = &H0
        write_DSRRMIS_value = &H0
        flag_DSRRMIS        = &H0
        write_DCDRMIS_value = &H0
        flag_DCDRMIS        = &H0
        write_CTSRMIS_value = &H0
        flag_CTSRMIS        = &H0
        write_RIRMIS_value = &H0
        flag_RIRMIS        = &H0
    End Sub
End Class


'' @REGISTER : URT0_uartmis
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' OEMIS                                      [10:10]          get_OEMIS
''                                                             set_OEMIS
''                                                             read_OEMIS
''                                                             write_OEMIS
''---------------------------------------------------------------------------------
'' BEMIS                                      [9:9]            get_BEMIS
''                                                             set_BEMIS
''                                                             read_BEMIS
''                                                             write_BEMIS
''---------------------------------------------------------------------------------
'' PEMIS                                      [8:8]            get_PEMIS
''                                                             set_PEMIS
''                                                             read_PEMIS
''                                                             write_PEMIS
''---------------------------------------------------------------------------------
'' FEMIS                                      [7:7]            get_FEMIS
''                                                             set_FEMIS
''                                                             read_FEMIS
''                                                             write_FEMIS
''---------------------------------------------------------------------------------
'' RTMIS                                      [6:6]            get_RTMIS
''                                                             set_RTMIS
''                                                             read_RTMIS
''                                                             write_RTMIS
''---------------------------------------------------------------------------------
'' TXMIS                                      [5:5]            get_TXMIS
''                                                             set_TXMIS
''                                                             read_TXMIS
''                                                             write_TXMIS
''---------------------------------------------------------------------------------
'' RXMIS                                      [4:4]            get_RXMIS
''                                                             set_RXMIS
''                                                             read_RXMIS
''                                                             write_RXMIS
''---------------------------------------------------------------------------------
'' DSRMMIS                                    [3:3]            get_DSRMMIS
''                                                             set_DSRMMIS
''                                                             read_DSRMMIS
''                                                             write_DSRMMIS
''---------------------------------------------------------------------------------
'' DCDMMIS                                    [2:2]            get_DCDMMIS
''                                                             set_DCDMMIS
''                                                             read_DCDMMIS
''                                                             write_DCDMMIS
''---------------------------------------------------------------------------------
'' CTSMMIS                                    [1:1]            get_CTSMMIS
''                                                             set_CTSMMIS
''                                                             read_CTSMMIS
''                                                             write_CTSMMIS
''---------------------------------------------------------------------------------
'' RIMMIS                                     [0:0]            get_RIMMIS
''                                                             set_RIMMIS
''                                                             read_RIMMIS
''                                                             write_RIMMIS
''---------------------------------------------------------------------------------
Class REGISTER_URT0_uartmis
    Private write_OEMIS_value
    Private read_OEMIS_value
    Private flag_OEMIS
    Private write_BEMIS_value
    Private read_BEMIS_value
    Private flag_BEMIS
    Private write_PEMIS_value
    Private read_PEMIS_value
    Private flag_PEMIS
    Private write_FEMIS_value
    Private read_FEMIS_value
    Private flag_FEMIS
    Private write_RTMIS_value
    Private read_RTMIS_value
    Private flag_RTMIS
    Private write_TXMIS_value
    Private read_TXMIS_value
    Private flag_TXMIS
    Private write_RXMIS_value
    Private read_RXMIS_value
    Private flag_RXMIS
    Private write_DSRMMIS_value
    Private read_DSRMMIS_value
    Private flag_DSRMMIS
    Private write_DCDMMIS_value
    Private read_DCDMMIS_value
    Private flag_DCDMMIS
    Private write_CTSMMIS_value
    Private read_CTSMMIS_value
    Private flag_CTSMMIS
    Private write_RIMMIS_value
    Private read_RIMMIS_value
    Private flag_RIMMIS

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

    Property Get get_OEMIS
        get_OEMIS = read_OEMIS_value
    End Property

    Property Let set_OEMIS(aData)
        write_OEMIS_value = aData
        flag_OEMIS        = &H1
    End Property

    Property Get read_OEMIS
        read
        read_OEMIS = read_OEMIS_value
    End Property

    Property Let write_OEMIS(aData)
        set_OEMIS = aData
        write
    End Property

    Property Get get_BEMIS
        get_BEMIS = read_BEMIS_value
    End Property

    Property Let set_BEMIS(aData)
        write_BEMIS_value = aData
        flag_BEMIS        = &H1
    End Property

    Property Get read_BEMIS
        read
        read_BEMIS = read_BEMIS_value
    End Property

    Property Let write_BEMIS(aData)
        set_BEMIS = aData
        write
    End Property

    Property Get get_PEMIS
        get_PEMIS = read_PEMIS_value
    End Property

    Property Let set_PEMIS(aData)
        write_PEMIS_value = aData
        flag_PEMIS        = &H1
    End Property

    Property Get read_PEMIS
        read
        read_PEMIS = read_PEMIS_value
    End Property

    Property Let write_PEMIS(aData)
        set_PEMIS = aData
        write
    End Property

    Property Get get_FEMIS
        get_FEMIS = read_FEMIS_value
    End Property

    Property Let set_FEMIS(aData)
        write_FEMIS_value = aData
        flag_FEMIS        = &H1
    End Property

    Property Get read_FEMIS
        read
        read_FEMIS = read_FEMIS_value
    End Property

    Property Let write_FEMIS(aData)
        set_FEMIS = aData
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

    Property Get get_DSRMMIS
        get_DSRMMIS = read_DSRMMIS_value
    End Property

    Property Let set_DSRMMIS(aData)
        write_DSRMMIS_value = aData
        flag_DSRMMIS        = &H1
    End Property

    Property Get read_DSRMMIS
        read
        read_DSRMMIS = read_DSRMMIS_value
    End Property

    Property Let write_DSRMMIS(aData)
        set_DSRMMIS = aData
        write
    End Property

    Property Get get_DCDMMIS
        get_DCDMMIS = read_DCDMMIS_value
    End Property

    Property Let set_DCDMMIS(aData)
        write_DCDMMIS_value = aData
        flag_DCDMMIS        = &H1
    End Property

    Property Get read_DCDMMIS
        read
        read_DCDMMIS = read_DCDMMIS_value
    End Property

    Property Let write_DCDMMIS(aData)
        set_DCDMMIS = aData
        write
    End Property

    Property Get get_CTSMMIS
        get_CTSMMIS = read_CTSMMIS_value
    End Property

    Property Let set_CTSMMIS(aData)
        write_CTSMMIS_value = aData
        flag_CTSMMIS        = &H1
    End Property

    Property Get read_CTSMMIS
        read
        read_CTSMMIS = read_CTSMMIS_value
    End Property

    Property Let write_CTSMMIS(aData)
        set_CTSMMIS = aData
        write
    End Property

    Property Get get_RIMMIS
        get_RIMMIS = read_RIMMIS_value
    End Property

    Property Let set_RIMMIS(aData)
        write_RIMMIS_value = aData
        flag_RIMMIS        = &H1
    End Property

    Property Get read_RIMMIS
        read
        read_RIMMIS = read_RIMMIS_value
    End Property

    Property Let write_RIMMIS(aData)
        set_RIMMIS = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_OEMIS_value = rightShift(data_low, 10) and &H1
        read_BEMIS_value = rightShift(data_low, 9) and &H1
        read_PEMIS_value = rightShift(data_low, 8) and &H1
        read_FEMIS_value = rightShift(data_low, 7) and &H1
        read_RTMIS_value = rightShift(data_low, 6) and &H1
        read_TXMIS_value = rightShift(data_low, 5) and &H1
        read_RXMIS_value = rightShift(data_low, 4) and &H1
        read_DSRMMIS_value = rightShift(data_low, 3) and &H1
        read_DCDMMIS_value = rightShift(data_low, 2) and &H1
        read_CTSMMIS_value = rightShift(data_low, 1) and &H1
        RIMMIS_mask = &H1
        if data_low > LONG_MAX then
            if RIMMIS_mask = mask then
                read_RIMMIS_value = data_low
            else
                read_RIMMIS_value = (data_low - H8000_0000) and RIMMIS_mask
            end If
        else
            read_RIMMIS_value = data_low and RIMMIS_mask
        end If

    End Sub

    Sub write
        If flag_OEMIS = &H0 or flag_BEMIS = &H0 or flag_PEMIS = &H0 or flag_FEMIS = &H0 or flag_RTMIS = &H0 or flag_TXMIS = &H0 or flag_RXMIS = &H0 or flag_DSRMMIS = &H0 or flag_DCDMMIS = &H0 or flag_CTSMMIS = &H0 or flag_RIMMIS = &H0 Then read
        If flag_OEMIS = &H0 Then write_OEMIS_value = get_OEMIS
        If flag_BEMIS = &H0 Then write_BEMIS_value = get_BEMIS
        If flag_PEMIS = &H0 Then write_PEMIS_value = get_PEMIS
        If flag_FEMIS = &H0 Then write_FEMIS_value = get_FEMIS
        If flag_RTMIS = &H0 Then write_RTMIS_value = get_RTMIS
        If flag_TXMIS = &H0 Then write_TXMIS_value = get_TXMIS
        If flag_RXMIS = &H0 Then write_RXMIS_value = get_RXMIS
        If flag_DSRMMIS = &H0 Then write_DSRMMIS_value = get_DSRMMIS
        If flag_DCDMMIS = &H0 Then write_DCDMMIS_value = get_DCDMMIS
        If flag_CTSMMIS = &H0 Then write_CTSMMIS_value = get_CTSMMIS
        If flag_RIMMIS = &H0 Then write_RIMMIS_value = get_RIMMIS

        regValue = leftShift((write_OEMIS_value and &H1), 10) + leftShift((write_BEMIS_value and &H1), 9) + leftShift((write_PEMIS_value and &H1), 8) + leftShift((write_FEMIS_value and &H1), 7) + leftShift((write_RTMIS_value and &H1), 6) + leftShift((write_TXMIS_value and &H1), 5) + leftShift((write_RXMIS_value and &H1), 4) + leftShift((write_DSRMMIS_value and &H1), 3) + leftShift((write_DCDMMIS_value and &H1), 2) + leftShift((write_CTSMMIS_value and &H1), 1) + leftShift((write_RIMMIS_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_OEMIS_value = rightShift(data_low, 10) and &H1
        read_BEMIS_value = rightShift(data_low, 9) and &H1
        read_PEMIS_value = rightShift(data_low, 8) and &H1
        read_FEMIS_value = rightShift(data_low, 7) and &H1
        read_RTMIS_value = rightShift(data_low, 6) and &H1
        read_TXMIS_value = rightShift(data_low, 5) and &H1
        read_RXMIS_value = rightShift(data_low, 4) and &H1
        read_DSRMMIS_value = rightShift(data_low, 3) and &H1
        read_DCDMMIS_value = rightShift(data_low, 2) and &H1
        read_CTSMMIS_value = rightShift(data_low, 1) and &H1
        RIMMIS_mask = &H1
        if data_low > LONG_MAX then
            if RIMMIS_mask = mask then
                read_RIMMIS_value = data_low
            else
                read_RIMMIS_value = (data_low - H8000_0000) and RIMMIS_mask
            end If
        else
            read_RIMMIS_value = data_low and RIMMIS_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_OEMIS_value = &H0
        flag_OEMIS        = &H0
        write_BEMIS_value = &H0
        flag_BEMIS        = &H0
        write_PEMIS_value = &H0
        flag_PEMIS        = &H0
        write_FEMIS_value = &H0
        flag_FEMIS        = &H0
        write_RTMIS_value = &H0
        flag_RTMIS        = &H0
        write_TXMIS_value = &H0
        flag_TXMIS        = &H0
        write_RXMIS_value = &H0
        flag_RXMIS        = &H0
        write_DSRMMIS_value = &H0
        flag_DSRMMIS        = &H0
        write_DCDMMIS_value = &H0
        flag_DCDMMIS        = &H0
        write_CTSMMIS_value = &H0
        flag_CTSMMIS        = &H0
        write_RIMMIS_value = &H0
        flag_RIMMIS        = &H0
    End Sub
End Class


'' @REGISTER : URT0_uarticr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' OEIC                                       [10:10]          get_OEIC
''                                                             set_OEIC
''                                                             read_OEIC
''                                                             write_OEIC
''---------------------------------------------------------------------------------
'' BEIC                                       [9:9]            get_BEIC
''                                                             set_BEIC
''                                                             read_BEIC
''                                                             write_BEIC
''---------------------------------------------------------------------------------
'' PEIC                                       [8:8]            get_PEIC
''                                                             set_PEIC
''                                                             read_PEIC
''                                                             write_PEIC
''---------------------------------------------------------------------------------
'' FEIC                                       [7:7]            get_FEIC
''                                                             set_FEIC
''                                                             read_FEIC
''                                                             write_FEIC
''---------------------------------------------------------------------------------
'' RTIC                                       [6:6]            get_RTIC
''                                                             set_RTIC
''                                                             read_RTIC
''                                                             write_RTIC
''---------------------------------------------------------------------------------
'' TXIC                                       [5:5]            get_TXIC
''                                                             set_TXIC
''                                                             read_TXIC
''                                                             write_TXIC
''---------------------------------------------------------------------------------
'' RXIC                                       [4:4]            get_RXIC
''                                                             set_RXIC
''                                                             read_RXIC
''                                                             write_RXIC
''---------------------------------------------------------------------------------
'' DSRMIC                                     [3:3]            get_DSRMIC
''                                                             set_DSRMIC
''                                                             read_DSRMIC
''                                                             write_DSRMIC
''---------------------------------------------------------------------------------
'' DCDMIC                                     [2:2]            get_DCDMIC
''                                                             set_DCDMIC
''                                                             read_DCDMIC
''                                                             write_DCDMIC
''---------------------------------------------------------------------------------
'' CTSMIC                                     [1:1]            get_CTSMIC
''                                                             set_CTSMIC
''                                                             read_CTSMIC
''                                                             write_CTSMIC
''---------------------------------------------------------------------------------
'' RIMIC                                      [0:0]            get_RIMIC
''                                                             set_RIMIC
''                                                             read_RIMIC
''                                                             write_RIMIC
''---------------------------------------------------------------------------------
Class REGISTER_URT0_uarticr
    Private write_OEIC_value
    Private read_OEIC_value
    Private flag_OEIC
    Private write_BEIC_value
    Private read_BEIC_value
    Private flag_BEIC
    Private write_PEIC_value
    Private read_PEIC_value
    Private flag_PEIC
    Private write_FEIC_value
    Private read_FEIC_value
    Private flag_FEIC
    Private write_RTIC_value
    Private read_RTIC_value
    Private flag_RTIC
    Private write_TXIC_value
    Private read_TXIC_value
    Private flag_TXIC
    Private write_RXIC_value
    Private read_RXIC_value
    Private flag_RXIC
    Private write_DSRMIC_value
    Private read_DSRMIC_value
    Private flag_DSRMIC
    Private write_DCDMIC_value
    Private read_DCDMIC_value
    Private flag_DCDMIC
    Private write_CTSMIC_value
    Private read_CTSMIC_value
    Private flag_CTSMIC
    Private write_RIMIC_value
    Private read_RIMIC_value
    Private flag_RIMIC

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

    Property Get get_OEIC
        get_OEIC = read_OEIC_value
    End Property

    Property Let set_OEIC(aData)
        write_OEIC_value = aData
        flag_OEIC        = &H1
    End Property

    Property Get read_OEIC
        read
        read_OEIC = read_OEIC_value
    End Property

    Property Let write_OEIC(aData)
        set_OEIC = aData
        write
    End Property

    Property Get get_BEIC
        get_BEIC = read_BEIC_value
    End Property

    Property Let set_BEIC(aData)
        write_BEIC_value = aData
        flag_BEIC        = &H1
    End Property

    Property Get read_BEIC
        read
        read_BEIC = read_BEIC_value
    End Property

    Property Let write_BEIC(aData)
        set_BEIC = aData
        write
    End Property

    Property Get get_PEIC
        get_PEIC = read_PEIC_value
    End Property

    Property Let set_PEIC(aData)
        write_PEIC_value = aData
        flag_PEIC        = &H1
    End Property

    Property Get read_PEIC
        read
        read_PEIC = read_PEIC_value
    End Property

    Property Let write_PEIC(aData)
        set_PEIC = aData
        write
    End Property

    Property Get get_FEIC
        get_FEIC = read_FEIC_value
    End Property

    Property Let set_FEIC(aData)
        write_FEIC_value = aData
        flag_FEIC        = &H1
    End Property

    Property Get read_FEIC
        read
        read_FEIC = read_FEIC_value
    End Property

    Property Let write_FEIC(aData)
        set_FEIC = aData
        write
    End Property

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

    Property Get get_TXIC
        get_TXIC = read_TXIC_value
    End Property

    Property Let set_TXIC(aData)
        write_TXIC_value = aData
        flag_TXIC        = &H1
    End Property

    Property Get read_TXIC
        read
        read_TXIC = read_TXIC_value
    End Property

    Property Let write_TXIC(aData)
        set_TXIC = aData
        write
    End Property

    Property Get get_RXIC
        get_RXIC = read_RXIC_value
    End Property

    Property Let set_RXIC(aData)
        write_RXIC_value = aData
        flag_RXIC        = &H1
    End Property

    Property Get read_RXIC
        read
        read_RXIC = read_RXIC_value
    End Property

    Property Let write_RXIC(aData)
        set_RXIC = aData
        write
    End Property

    Property Get get_DSRMIC
        get_DSRMIC = read_DSRMIC_value
    End Property

    Property Let set_DSRMIC(aData)
        write_DSRMIC_value = aData
        flag_DSRMIC        = &H1
    End Property

    Property Get read_DSRMIC
        read
        read_DSRMIC = read_DSRMIC_value
    End Property

    Property Let write_DSRMIC(aData)
        set_DSRMIC = aData
        write
    End Property

    Property Get get_DCDMIC
        get_DCDMIC = read_DCDMIC_value
    End Property

    Property Let set_DCDMIC(aData)
        write_DCDMIC_value = aData
        flag_DCDMIC        = &H1
    End Property

    Property Get read_DCDMIC
        read
        read_DCDMIC = read_DCDMIC_value
    End Property

    Property Let write_DCDMIC(aData)
        set_DCDMIC = aData
        write
    End Property

    Property Get get_CTSMIC
        get_CTSMIC = read_CTSMIC_value
    End Property

    Property Let set_CTSMIC(aData)
        write_CTSMIC_value = aData
        flag_CTSMIC        = &H1
    End Property

    Property Get read_CTSMIC
        read
        read_CTSMIC = read_CTSMIC_value
    End Property

    Property Let write_CTSMIC(aData)
        set_CTSMIC = aData
        write
    End Property

    Property Get get_RIMIC
        get_RIMIC = read_RIMIC_value
    End Property

    Property Let set_RIMIC(aData)
        write_RIMIC_value = aData
        flag_RIMIC        = &H1
    End Property

    Property Get read_RIMIC
        read
        read_RIMIC = read_RIMIC_value
    End Property

    Property Let write_RIMIC(aData)
        set_RIMIC = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_OEIC_value = rightShift(data_low, 10) and &H1
        read_BEIC_value = rightShift(data_low, 9) and &H1
        read_PEIC_value = rightShift(data_low, 8) and &H1
        read_FEIC_value = rightShift(data_low, 7) and &H1
        read_RTIC_value = rightShift(data_low, 6) and &H1
        read_TXIC_value = rightShift(data_low, 5) and &H1
        read_RXIC_value = rightShift(data_low, 4) and &H1
        read_DSRMIC_value = rightShift(data_low, 3) and &H1
        read_DCDMIC_value = rightShift(data_low, 2) and &H1
        read_CTSMIC_value = rightShift(data_low, 1) and &H1
        RIMIC_mask = &H1
        if data_low > LONG_MAX then
            if RIMIC_mask = mask then
                read_RIMIC_value = data_low
            else
                read_RIMIC_value = (data_low - H8000_0000) and RIMIC_mask
            end If
        else
            read_RIMIC_value = data_low and RIMIC_mask
        end If

    End Sub

    Sub write
        If flag_OEIC = &H0 or flag_BEIC = &H0 or flag_PEIC = &H0 or flag_FEIC = &H0 or flag_RTIC = &H0 or flag_TXIC = &H0 or flag_RXIC = &H0 or flag_DSRMIC = &H0 or flag_DCDMIC = &H0 or flag_CTSMIC = &H0 or flag_RIMIC = &H0 Then read
        If flag_OEIC = &H0 Then write_OEIC_value = get_OEIC
        If flag_BEIC = &H0 Then write_BEIC_value = get_BEIC
        If flag_PEIC = &H0 Then write_PEIC_value = get_PEIC
        If flag_FEIC = &H0 Then write_FEIC_value = get_FEIC
        If flag_RTIC = &H0 Then write_RTIC_value = get_RTIC
        If flag_TXIC = &H0 Then write_TXIC_value = get_TXIC
        If flag_RXIC = &H0 Then write_RXIC_value = get_RXIC
        If flag_DSRMIC = &H0 Then write_DSRMIC_value = get_DSRMIC
        If flag_DCDMIC = &H0 Then write_DCDMIC_value = get_DCDMIC
        If flag_CTSMIC = &H0 Then write_CTSMIC_value = get_CTSMIC
        If flag_RIMIC = &H0 Then write_RIMIC_value = get_RIMIC

        regValue = leftShift((write_OEIC_value and &H1), 10) + leftShift((write_BEIC_value and &H1), 9) + leftShift((write_PEIC_value and &H1), 8) + leftShift((write_FEIC_value and &H1), 7) + leftShift((write_RTIC_value and &H1), 6) + leftShift((write_TXIC_value and &H1), 5) + leftShift((write_RXIC_value and &H1), 4) + leftShift((write_DSRMIC_value and &H1), 3) + leftShift((write_DCDMIC_value and &H1), 2) + leftShift((write_CTSMIC_value and &H1), 1) + leftShift((write_RIMIC_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_OEIC_value = rightShift(data_low, 10) and &H1
        read_BEIC_value = rightShift(data_low, 9) and &H1
        read_PEIC_value = rightShift(data_low, 8) and &H1
        read_FEIC_value = rightShift(data_low, 7) and &H1
        read_RTIC_value = rightShift(data_low, 6) and &H1
        read_TXIC_value = rightShift(data_low, 5) and &H1
        read_RXIC_value = rightShift(data_low, 4) and &H1
        read_DSRMIC_value = rightShift(data_low, 3) and &H1
        read_DCDMIC_value = rightShift(data_low, 2) and &H1
        read_CTSMIC_value = rightShift(data_low, 1) and &H1
        RIMIC_mask = &H1
        if data_low > LONG_MAX then
            if RIMIC_mask = mask then
                read_RIMIC_value = data_low
            else
                read_RIMIC_value = (data_low - H8000_0000) and RIMIC_mask
            end If
        else
            read_RIMIC_value = data_low and RIMIC_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_OEIC_value = &H0
        flag_OEIC        = &H0
        write_BEIC_value = &H0
        flag_BEIC        = &H0
        write_PEIC_value = &H0
        flag_PEIC        = &H0
        write_FEIC_value = &H0
        flag_FEIC        = &H0
        write_RTIC_value = &H0
        flag_RTIC        = &H0
        write_TXIC_value = &H0
        flag_TXIC        = &H0
        write_RXIC_value = &H0
        flag_RXIC        = &H0
        write_DSRMIC_value = &H0
        flag_DSRMIC        = &H0
        write_DCDMIC_value = &H0
        flag_DCDMIC        = &H0
        write_CTSMIC_value = &H0
        flag_CTSMIC        = &H0
        write_RIMIC_value = &H0
        flag_RIMIC        = &H0
    End Sub
End Class


'' @REGISTER : URT0_uartdmacr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DMAONERR                                   [2:2]            get_DMAONERR
''                                                             set_DMAONERR
''                                                             read_DMAONERR
''                                                             write_DMAONERR
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
Class REGISTER_URT0_uartdmacr
    Private write_DMAONERR_value
    Private read_DMAONERR_value
    Private flag_DMAONERR
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

    Property Get get_DMAONERR
        get_DMAONERR = read_DMAONERR_value
    End Property

    Property Let set_DMAONERR(aData)
        write_DMAONERR_value = aData
        flag_DMAONERR        = &H1
    End Property

    Property Get read_DMAONERR
        read
        read_DMAONERR = read_DMAONERR_value
    End Property

    Property Let write_DMAONERR(aData)
        set_DMAONERR = aData
        write
    End Property

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
        read_DMAONERR_value = rightShift(data_low, 2) and &H1
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
        If flag_DMAONERR = &H0 or flag_TXDMAE = &H0 or flag_RXDMAE = &H0 Then read
        If flag_DMAONERR = &H0 Then write_DMAONERR_value = get_DMAONERR
        If flag_TXDMAE = &H0 Then write_TXDMAE_value = get_TXDMAE
        If flag_RXDMAE = &H0 Then write_RXDMAE_value = get_RXDMAE

        regValue = leftShift((write_DMAONERR_value and &H1), 2) + leftShift((write_TXDMAE_value and &H1), 1) + leftShift((write_RXDMAE_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_DMAONERR_value = rightShift(data_low, 2) and &H1
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
        write_DMAONERR_value = &H0
        flag_DMAONERR        = &H0
        write_TXDMAE_value = &H0
        flag_TXDMAE        = &H0
        write_RXDMAE_value = &H0
        flag_RXDMAE        = &H0
    End Sub
End Class


'' @REGISTER : URT0_uartperiphid0
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
Class REGISTER_URT0_uartperiphid0
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


'' @REGISTER : URT0_uartperiphid1
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
Class REGISTER_URT0_uartperiphid1
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


'' @REGISTER : URT0_uartperiphid2
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
Class REGISTER_URT0_uartperiphid2
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


'' @REGISTER : URT0_uartperiphid3
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
Class REGISTER_URT0_uartperiphid3
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


'' @REGISTER : URT0_uartpcellid0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' UARTPCellID0                               [7:0]            get_UARTPCellID0
''                                                             set_UARTPCellID0
''                                                             read_UARTPCellID0
''                                                             write_UARTPCellID0
''---------------------------------------------------------------------------------
Class REGISTER_URT0_uartpcellid0
    Private write_UARTPCellID0_value
    Private read_UARTPCellID0_value
    Private flag_UARTPCellID0

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

    Property Get get_UARTPCellID0
        get_UARTPCellID0 = read_UARTPCellID0_value
    End Property

    Property Let set_UARTPCellID0(aData)
        write_UARTPCellID0_value = aData
        flag_UARTPCellID0        = &H1
    End Property

    Property Get read_UARTPCellID0
        read
        read_UARTPCellID0 = read_UARTPCellID0_value
    End Property

    Property Let write_UARTPCellID0(aData)
        set_UARTPCellID0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        UARTPCellID0_mask = &Hff
        if data_low > LONG_MAX then
            if UARTPCellID0_mask = mask then
                read_UARTPCellID0_value = data_low
            else
                read_UARTPCellID0_value = (data_low - H8000_0000) and UARTPCellID0_mask
            end If
        else
            read_UARTPCellID0_value = data_low and UARTPCellID0_mask
        end If

    End Sub

    Sub write
        If flag_UARTPCellID0 = &H0 Then read
        If flag_UARTPCellID0 = &H0 Then write_UARTPCellID0_value = get_UARTPCellID0

        regValue = leftShift((write_UARTPCellID0_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        UARTPCellID0_mask = &Hff
        if data_low > LONG_MAX then
            if UARTPCellID0_mask = mask then
                read_UARTPCellID0_value = data_low
            else
                read_UARTPCellID0_value = (data_low - H8000_0000) and UARTPCellID0_mask
            end If
        else
            read_UARTPCellID0_value = data_low and UARTPCellID0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_UARTPCellID0_value = &H0
        flag_UARTPCellID0        = &H0
    End Sub
End Class


'' @REGISTER : URT0_uartpcellid1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' UARTPCellID1                               [7:0]            get_UARTPCellID1
''                                                             set_UARTPCellID1
''                                                             read_UARTPCellID1
''                                                             write_UARTPCellID1
''---------------------------------------------------------------------------------
Class REGISTER_URT0_uartpcellid1
    Private write_UARTPCellID1_value
    Private read_UARTPCellID1_value
    Private flag_UARTPCellID1

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

    Property Get get_UARTPCellID1
        get_UARTPCellID1 = read_UARTPCellID1_value
    End Property

    Property Let set_UARTPCellID1(aData)
        write_UARTPCellID1_value = aData
        flag_UARTPCellID1        = &H1
    End Property

    Property Get read_UARTPCellID1
        read
        read_UARTPCellID1 = read_UARTPCellID1_value
    End Property

    Property Let write_UARTPCellID1(aData)
        set_UARTPCellID1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        UARTPCellID1_mask = &Hff
        if data_low > LONG_MAX then
            if UARTPCellID1_mask = mask then
                read_UARTPCellID1_value = data_low
            else
                read_UARTPCellID1_value = (data_low - H8000_0000) and UARTPCellID1_mask
            end If
        else
            read_UARTPCellID1_value = data_low and UARTPCellID1_mask
        end If

    End Sub

    Sub write
        If flag_UARTPCellID1 = &H0 Then read
        If flag_UARTPCellID1 = &H0 Then write_UARTPCellID1_value = get_UARTPCellID1

        regValue = leftShift((write_UARTPCellID1_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        UARTPCellID1_mask = &Hff
        if data_low > LONG_MAX then
            if UARTPCellID1_mask = mask then
                read_UARTPCellID1_value = data_low
            else
                read_UARTPCellID1_value = (data_low - H8000_0000) and UARTPCellID1_mask
            end If
        else
            read_UARTPCellID1_value = data_low and UARTPCellID1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_UARTPCellID1_value = &H0
        flag_UARTPCellID1        = &H0
    End Sub
End Class


'' @REGISTER : URT0_uartpcellid2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' UARTPCellID2                               [7:0]            get_UARTPCellID2
''                                                             set_UARTPCellID2
''                                                             read_UARTPCellID2
''                                                             write_UARTPCellID2
''---------------------------------------------------------------------------------
Class REGISTER_URT0_uartpcellid2
    Private write_UARTPCellID2_value
    Private read_UARTPCellID2_value
    Private flag_UARTPCellID2

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

    Property Get get_UARTPCellID2
        get_UARTPCellID2 = read_UARTPCellID2_value
    End Property

    Property Let set_UARTPCellID2(aData)
        write_UARTPCellID2_value = aData
        flag_UARTPCellID2        = &H1
    End Property

    Property Get read_UARTPCellID2
        read
        read_UARTPCellID2 = read_UARTPCellID2_value
    End Property

    Property Let write_UARTPCellID2(aData)
        set_UARTPCellID2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        UARTPCellID2_mask = &Hff
        if data_low > LONG_MAX then
            if UARTPCellID2_mask = mask then
                read_UARTPCellID2_value = data_low
            else
                read_UARTPCellID2_value = (data_low - H8000_0000) and UARTPCellID2_mask
            end If
        else
            read_UARTPCellID2_value = data_low and UARTPCellID2_mask
        end If

    End Sub

    Sub write
        If flag_UARTPCellID2 = &H0 Then read
        If flag_UARTPCellID2 = &H0 Then write_UARTPCellID2_value = get_UARTPCellID2

        regValue = leftShift((write_UARTPCellID2_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        UARTPCellID2_mask = &Hff
        if data_low > LONG_MAX then
            if UARTPCellID2_mask = mask then
                read_UARTPCellID2_value = data_low
            else
                read_UARTPCellID2_value = (data_low - H8000_0000) and UARTPCellID2_mask
            end If
        else
            read_UARTPCellID2_value = data_low and UARTPCellID2_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_UARTPCellID2_value = &H0
        flag_UARTPCellID2        = &H0
    End Sub
End Class


'' @REGISTER : URT0_uartpcellid3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' UARTPCellID3                               [7:0]            get_UARTPCellID3
''                                                             set_UARTPCellID3
''                                                             read_UARTPCellID3
''                                                             write_UARTPCellID3
''---------------------------------------------------------------------------------
Class REGISTER_URT0_uartpcellid3
    Private write_UARTPCellID3_value
    Private read_UARTPCellID3_value
    Private flag_UARTPCellID3

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

    Property Get get_UARTPCellID3
        get_UARTPCellID3 = read_UARTPCellID3_value
    End Property

    Property Let set_UARTPCellID3(aData)
        write_UARTPCellID3_value = aData
        flag_UARTPCellID3        = &H1
    End Property

    Property Get read_UARTPCellID3
        read
        read_UARTPCellID3 = read_UARTPCellID3_value
    End Property

    Property Let write_UARTPCellID3(aData)
        set_UARTPCellID3 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        UARTPCellID3_mask = &Hff
        if data_low > LONG_MAX then
            if UARTPCellID3_mask = mask then
                read_UARTPCellID3_value = data_low
            else
                read_UARTPCellID3_value = (data_low - H8000_0000) and UARTPCellID3_mask
            end If
        else
            read_UARTPCellID3_value = data_low and UARTPCellID3_mask
        end If

    End Sub

    Sub write
        If flag_UARTPCellID3 = &H0 Then read
        If flag_UARTPCellID3 = &H0 Then write_UARTPCellID3_value = get_UARTPCellID3

        regValue = leftShift((write_UARTPCellID3_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        UARTPCellID3_mask = &Hff
        if data_low > LONG_MAX then
            if UARTPCellID3_mask = mask then
                read_UARTPCellID3_value = data_low
            else
                read_UARTPCellID3_value = (data_low - H8000_0000) and UARTPCellID3_mask
            end If
        else
            read_UARTPCellID3_value = data_low and UARTPCellID3_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_UARTPCellID3_value = &H0
        flag_UARTPCellID3        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class URT0_INSTANCE

    Public uartdr
    Public uartrsr_uartecr
    Public uartfr
    Public uartilpr
    Public uartibrd
    Public uartfbrd
    Public uartlcr
    Public uartcr
    Public uartifls
    Public uartimsc
    Public uartris
    Public uartmis
    Public uarticr
    Public uartdmacr
    Public uartperiphid0
    Public uartperiphid1
    Public uartperiphid2
    Public uartperiphid3
    Public uartpcellid0
    Public uartpcellid1
    Public uartpcellid2
    Public uartpcellid3


    Public default function Init(aBaseAddr)
        Set uartdr = (New REGISTER_URT0_uartdr)(aBaseAddr, 32)
        Set uartrsr_uartecr = (New REGISTER_URT0_uartrsr_uartecr)(aBaseAddr, 32)
        Set uartfr = (New REGISTER_URT0_uartfr)(aBaseAddr, 32)
        Set uartilpr = (New REGISTER_URT0_uartilpr)(aBaseAddr, 32)
        Set uartibrd = (New REGISTER_URT0_uartibrd)(aBaseAddr, 32)
        Set uartfbrd = (New REGISTER_URT0_uartfbrd)(aBaseAddr, 32)
        Set uartlcr = (New REGISTER_URT0_uartlcr)(aBaseAddr, 32)
        Set uartcr = (New REGISTER_URT0_uartcr)(aBaseAddr, 32)
        Set uartifls = (New REGISTER_URT0_uartifls)(aBaseAddr, 32)
        Set uartimsc = (New REGISTER_URT0_uartimsc)(aBaseAddr, 32)
        Set uartris = (New REGISTER_URT0_uartris)(aBaseAddr, 32)
        Set uartmis = (New REGISTER_URT0_uartmis)(aBaseAddr, 32)
        Set uarticr = (New REGISTER_URT0_uarticr)(aBaseAddr, 32)
        Set uartdmacr = (New REGISTER_URT0_uartdmacr)(aBaseAddr, 32)
        Set uartperiphid0 = (New REGISTER_URT0_uartperiphid0)(aBaseAddr, 32)
        Set uartperiphid1 = (New REGISTER_URT0_uartperiphid1)(aBaseAddr, 32)
        Set uartperiphid2 = (New REGISTER_URT0_uartperiphid2)(aBaseAddr, 32)
        Set uartperiphid3 = (New REGISTER_URT0_uartperiphid3)(aBaseAddr, 32)
        Set uartpcellid0 = (New REGISTER_URT0_uartpcellid0)(aBaseAddr, 32)
        Set uartpcellid1 = (New REGISTER_URT0_uartpcellid1)(aBaseAddr, 32)
        Set uartpcellid2 = (New REGISTER_URT0_uartpcellid2)(aBaseAddr, 32)
        Set uartpcellid3 = (New REGISTER_URT0_uartpcellid3)(aBaseAddr, 32)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set URT0 = CreateObject("System.Collections.ArrayList")
URT0.Add ((New URT0_INSTANCE)(&H40149000))


