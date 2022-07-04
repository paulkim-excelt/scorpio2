

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


'' @REGISTER : P1588_8P_ICV_icv_tx_cntl_p0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ICV_CNTL                                   [15:0]           get_ICV_CNTL
''                                                             set_ICV_CNTL
''                                                             read_ICV_CNTL
''                                                             write_ICV_CNTL
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_icv_tx_cntl_p0
    Private write_ICV_CNTL_value
    Private read_ICV_CNTL_value
    Private flag_ICV_CNTL

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

    Property Get get_ICV_CNTL
        get_ICV_CNTL = read_ICV_CNTL_value
    End Property

    Property Let set_ICV_CNTL(aData)
        write_ICV_CNTL_value = aData
        flag_ICV_CNTL        = &H1
    End Property

    Property Get read_ICV_CNTL
        read
        read_ICV_CNTL = read_ICV_CNTL_value
    End Property

    Property Let write_ICV_CNTL(aData)
        set_ICV_CNTL = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ICV_CNTL_mask = &Hffff
        if data_low > LONG_MAX then
            if ICV_CNTL_mask = mask then
                read_ICV_CNTL_value = data_low
            else
                read_ICV_CNTL_value = (data_low - H8000_0000) and ICV_CNTL_mask
            end If
        else
            read_ICV_CNTL_value = data_low and ICV_CNTL_mask
        end If

    End Sub

    Sub write
        If flag_ICV_CNTL = &H0 Then read
        If flag_ICV_CNTL = &H0 Then write_ICV_CNTL_value = get_ICV_CNTL

        regValue = leftShift((write_ICV_CNTL_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ICV_CNTL_mask = &Hffff
        if data_low > LONG_MAX then
            if ICV_CNTL_mask = mask then
                read_ICV_CNTL_value = data_low
            else
                read_ICV_CNTL_value = (data_low - H8000_0000) and ICV_CNTL_mask
            end If
        else
            read_ICV_CNTL_value = data_low and ICV_CNTL_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ICV_CNTL_value = &H0
        flag_ICV_CNTL        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_icv_tx_cntl_p1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ICV_CNTL                                   [15:0]           get_ICV_CNTL
''                                                             set_ICV_CNTL
''                                                             read_ICV_CNTL
''                                                             write_ICV_CNTL
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_icv_tx_cntl_p1
    Private write_ICV_CNTL_value
    Private read_ICV_CNTL_value
    Private flag_ICV_CNTL

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

    Property Get get_ICV_CNTL
        get_ICV_CNTL = read_ICV_CNTL_value
    End Property

    Property Let set_ICV_CNTL(aData)
        write_ICV_CNTL_value = aData
        flag_ICV_CNTL        = &H1
    End Property

    Property Get read_ICV_CNTL
        read
        read_ICV_CNTL = read_ICV_CNTL_value
    End Property

    Property Let write_ICV_CNTL(aData)
        set_ICV_CNTL = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ICV_CNTL_mask = &Hffff
        if data_low > LONG_MAX then
            if ICV_CNTL_mask = mask then
                read_ICV_CNTL_value = data_low
            else
                read_ICV_CNTL_value = (data_low - H8000_0000) and ICV_CNTL_mask
            end If
        else
            read_ICV_CNTL_value = data_low and ICV_CNTL_mask
        end If

    End Sub

    Sub write
        If flag_ICV_CNTL = &H0 Then read
        If flag_ICV_CNTL = &H0 Then write_ICV_CNTL_value = get_ICV_CNTL

        regValue = leftShift((write_ICV_CNTL_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ICV_CNTL_mask = &Hffff
        if data_low > LONG_MAX then
            if ICV_CNTL_mask = mask then
                read_ICV_CNTL_value = data_low
            else
                read_ICV_CNTL_value = (data_low - H8000_0000) and ICV_CNTL_mask
            end If
        else
            read_ICV_CNTL_value = data_low and ICV_CNTL_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ICV_CNTL_value = &H0
        flag_ICV_CNTL        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_icv_tx_cntl_p2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ICV_CNTL                                   [15:0]           get_ICV_CNTL
''                                                             set_ICV_CNTL
''                                                             read_ICV_CNTL
''                                                             write_ICV_CNTL
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_icv_tx_cntl_p2
    Private write_ICV_CNTL_value
    Private read_ICV_CNTL_value
    Private flag_ICV_CNTL

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

    Property Get get_ICV_CNTL
        get_ICV_CNTL = read_ICV_CNTL_value
    End Property

    Property Let set_ICV_CNTL(aData)
        write_ICV_CNTL_value = aData
        flag_ICV_CNTL        = &H1
    End Property

    Property Get read_ICV_CNTL
        read
        read_ICV_CNTL = read_ICV_CNTL_value
    End Property

    Property Let write_ICV_CNTL(aData)
        set_ICV_CNTL = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ICV_CNTL_mask = &Hffff
        if data_low > LONG_MAX then
            if ICV_CNTL_mask = mask then
                read_ICV_CNTL_value = data_low
            else
                read_ICV_CNTL_value = (data_low - H8000_0000) and ICV_CNTL_mask
            end If
        else
            read_ICV_CNTL_value = data_low and ICV_CNTL_mask
        end If

    End Sub

    Sub write
        If flag_ICV_CNTL = &H0 Then read
        If flag_ICV_CNTL = &H0 Then write_ICV_CNTL_value = get_ICV_CNTL

        regValue = leftShift((write_ICV_CNTL_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ICV_CNTL_mask = &Hffff
        if data_low > LONG_MAX then
            if ICV_CNTL_mask = mask then
                read_ICV_CNTL_value = data_low
            else
                read_ICV_CNTL_value = (data_low - H8000_0000) and ICV_CNTL_mask
            end If
        else
            read_ICV_CNTL_value = data_low and ICV_CNTL_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ICV_CNTL_value = &H0
        flag_ICV_CNTL        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_icv_tx_cntl_p3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ICV_CNTL                                   [15:0]           get_ICV_CNTL
''                                                             set_ICV_CNTL
''                                                             read_ICV_CNTL
''                                                             write_ICV_CNTL
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_icv_tx_cntl_p3
    Private write_ICV_CNTL_value
    Private read_ICV_CNTL_value
    Private flag_ICV_CNTL

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

    Property Get get_ICV_CNTL
        get_ICV_CNTL = read_ICV_CNTL_value
    End Property

    Property Let set_ICV_CNTL(aData)
        write_ICV_CNTL_value = aData
        flag_ICV_CNTL        = &H1
    End Property

    Property Get read_ICV_CNTL
        read
        read_ICV_CNTL = read_ICV_CNTL_value
    End Property

    Property Let write_ICV_CNTL(aData)
        set_ICV_CNTL = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ICV_CNTL_mask = &Hffff
        if data_low > LONG_MAX then
            if ICV_CNTL_mask = mask then
                read_ICV_CNTL_value = data_low
            else
                read_ICV_CNTL_value = (data_low - H8000_0000) and ICV_CNTL_mask
            end If
        else
            read_ICV_CNTL_value = data_low and ICV_CNTL_mask
        end If

    End Sub

    Sub write
        If flag_ICV_CNTL = &H0 Then read
        If flag_ICV_CNTL = &H0 Then write_ICV_CNTL_value = get_ICV_CNTL

        regValue = leftShift((write_ICV_CNTL_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ICV_CNTL_mask = &Hffff
        if data_low > LONG_MAX then
            if ICV_CNTL_mask = mask then
                read_ICV_CNTL_value = data_low
            else
                read_ICV_CNTL_value = (data_low - H8000_0000) and ICV_CNTL_mask
            end If
        else
            read_ICV_CNTL_value = data_low and ICV_CNTL_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ICV_CNTL_value = &H0
        flag_ICV_CNTL        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_icv_tx_cntl_p4
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ICV_CNTL                                   [15:0]           get_ICV_CNTL
''                                                             set_ICV_CNTL
''                                                             read_ICV_CNTL
''                                                             write_ICV_CNTL
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_icv_tx_cntl_p4
    Private write_ICV_CNTL_value
    Private read_ICV_CNTL_value
    Private flag_ICV_CNTL

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

    Property Get get_ICV_CNTL
        get_ICV_CNTL = read_ICV_CNTL_value
    End Property

    Property Let set_ICV_CNTL(aData)
        write_ICV_CNTL_value = aData
        flag_ICV_CNTL        = &H1
    End Property

    Property Get read_ICV_CNTL
        read
        read_ICV_CNTL = read_ICV_CNTL_value
    End Property

    Property Let write_ICV_CNTL(aData)
        set_ICV_CNTL = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ICV_CNTL_mask = &Hffff
        if data_low > LONG_MAX then
            if ICV_CNTL_mask = mask then
                read_ICV_CNTL_value = data_low
            else
                read_ICV_CNTL_value = (data_low - H8000_0000) and ICV_CNTL_mask
            end If
        else
            read_ICV_CNTL_value = data_low and ICV_CNTL_mask
        end If

    End Sub

    Sub write
        If flag_ICV_CNTL = &H0 Then read
        If flag_ICV_CNTL = &H0 Then write_ICV_CNTL_value = get_ICV_CNTL

        regValue = leftShift((write_ICV_CNTL_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ICV_CNTL_mask = &Hffff
        if data_low > LONG_MAX then
            if ICV_CNTL_mask = mask then
                read_ICV_CNTL_value = data_low
            else
                read_ICV_CNTL_value = (data_low - H8000_0000) and ICV_CNTL_mask
            end If
        else
            read_ICV_CNTL_value = data_low and ICV_CNTL_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ICV_CNTL_value = &H0
        flag_ICV_CNTL        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_icv_tx_cntl_p5
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ICV_CNTL                                   [15:0]           get_ICV_CNTL
''                                                             set_ICV_CNTL
''                                                             read_ICV_CNTL
''                                                             write_ICV_CNTL
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_icv_tx_cntl_p5
    Private write_ICV_CNTL_value
    Private read_ICV_CNTL_value
    Private flag_ICV_CNTL

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

    Property Get get_ICV_CNTL
        get_ICV_CNTL = read_ICV_CNTL_value
    End Property

    Property Let set_ICV_CNTL(aData)
        write_ICV_CNTL_value = aData
        flag_ICV_CNTL        = &H1
    End Property

    Property Get read_ICV_CNTL
        read
        read_ICV_CNTL = read_ICV_CNTL_value
    End Property

    Property Let write_ICV_CNTL(aData)
        set_ICV_CNTL = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ICV_CNTL_mask = &Hffff
        if data_low > LONG_MAX then
            if ICV_CNTL_mask = mask then
                read_ICV_CNTL_value = data_low
            else
                read_ICV_CNTL_value = (data_low - H8000_0000) and ICV_CNTL_mask
            end If
        else
            read_ICV_CNTL_value = data_low and ICV_CNTL_mask
        end If

    End Sub

    Sub write
        If flag_ICV_CNTL = &H0 Then read
        If flag_ICV_CNTL = &H0 Then write_ICV_CNTL_value = get_ICV_CNTL

        regValue = leftShift((write_ICV_CNTL_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ICV_CNTL_mask = &Hffff
        if data_low > LONG_MAX then
            if ICV_CNTL_mask = mask then
                read_ICV_CNTL_value = data_low
            else
                read_ICV_CNTL_value = (data_low - H8000_0000) and ICV_CNTL_mask
            end If
        else
            read_ICV_CNTL_value = data_low and ICV_CNTL_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ICV_CNTL_value = &H0
        flag_ICV_CNTL        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_icv_rx_cntl_p0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ICV_CNTL                                   [15:0]           get_ICV_CNTL
''                                                             set_ICV_CNTL
''                                                             read_ICV_CNTL
''                                                             write_ICV_CNTL
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_icv_rx_cntl_p0
    Private write_ICV_CNTL_value
    Private read_ICV_CNTL_value
    Private flag_ICV_CNTL

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

    Property Get get_ICV_CNTL
        get_ICV_CNTL = read_ICV_CNTL_value
    End Property

    Property Let set_ICV_CNTL(aData)
        write_ICV_CNTL_value = aData
        flag_ICV_CNTL        = &H1
    End Property

    Property Get read_ICV_CNTL
        read
        read_ICV_CNTL = read_ICV_CNTL_value
    End Property

    Property Let write_ICV_CNTL(aData)
        set_ICV_CNTL = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ICV_CNTL_mask = &Hffff
        if data_low > LONG_MAX then
            if ICV_CNTL_mask = mask then
                read_ICV_CNTL_value = data_low
            else
                read_ICV_CNTL_value = (data_low - H8000_0000) and ICV_CNTL_mask
            end If
        else
            read_ICV_CNTL_value = data_low and ICV_CNTL_mask
        end If

    End Sub

    Sub write
        If flag_ICV_CNTL = &H0 Then read
        If flag_ICV_CNTL = &H0 Then write_ICV_CNTL_value = get_ICV_CNTL

        regValue = leftShift((write_ICV_CNTL_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ICV_CNTL_mask = &Hffff
        if data_low > LONG_MAX then
            if ICV_CNTL_mask = mask then
                read_ICV_CNTL_value = data_low
            else
                read_ICV_CNTL_value = (data_low - H8000_0000) and ICV_CNTL_mask
            end If
        else
            read_ICV_CNTL_value = data_low and ICV_CNTL_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ICV_CNTL_value = &H0
        flag_ICV_CNTL        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_icv_rx_cntl_p1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ICV_CNTL                                   [15:0]           get_ICV_CNTL
''                                                             set_ICV_CNTL
''                                                             read_ICV_CNTL
''                                                             write_ICV_CNTL
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_icv_rx_cntl_p1
    Private write_ICV_CNTL_value
    Private read_ICV_CNTL_value
    Private flag_ICV_CNTL

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

    Property Get get_ICV_CNTL
        get_ICV_CNTL = read_ICV_CNTL_value
    End Property

    Property Let set_ICV_CNTL(aData)
        write_ICV_CNTL_value = aData
        flag_ICV_CNTL        = &H1
    End Property

    Property Get read_ICV_CNTL
        read
        read_ICV_CNTL = read_ICV_CNTL_value
    End Property

    Property Let write_ICV_CNTL(aData)
        set_ICV_CNTL = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ICV_CNTL_mask = &Hffff
        if data_low > LONG_MAX then
            if ICV_CNTL_mask = mask then
                read_ICV_CNTL_value = data_low
            else
                read_ICV_CNTL_value = (data_low - H8000_0000) and ICV_CNTL_mask
            end If
        else
            read_ICV_CNTL_value = data_low and ICV_CNTL_mask
        end If

    End Sub

    Sub write
        If flag_ICV_CNTL = &H0 Then read
        If flag_ICV_CNTL = &H0 Then write_ICV_CNTL_value = get_ICV_CNTL

        regValue = leftShift((write_ICV_CNTL_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ICV_CNTL_mask = &Hffff
        if data_low > LONG_MAX then
            if ICV_CNTL_mask = mask then
                read_ICV_CNTL_value = data_low
            else
                read_ICV_CNTL_value = (data_low - H8000_0000) and ICV_CNTL_mask
            end If
        else
            read_ICV_CNTL_value = data_low and ICV_CNTL_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ICV_CNTL_value = &H0
        flag_ICV_CNTL        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_icv_rx_cntl_p2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ICV_CNTL                                   [15:0]           get_ICV_CNTL
''                                                             set_ICV_CNTL
''                                                             read_ICV_CNTL
''                                                             write_ICV_CNTL
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_icv_rx_cntl_p2
    Private write_ICV_CNTL_value
    Private read_ICV_CNTL_value
    Private flag_ICV_CNTL

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

    Property Get get_ICV_CNTL
        get_ICV_CNTL = read_ICV_CNTL_value
    End Property

    Property Let set_ICV_CNTL(aData)
        write_ICV_CNTL_value = aData
        flag_ICV_CNTL        = &H1
    End Property

    Property Get read_ICV_CNTL
        read
        read_ICV_CNTL = read_ICV_CNTL_value
    End Property

    Property Let write_ICV_CNTL(aData)
        set_ICV_CNTL = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ICV_CNTL_mask = &Hffff
        if data_low > LONG_MAX then
            if ICV_CNTL_mask = mask then
                read_ICV_CNTL_value = data_low
            else
                read_ICV_CNTL_value = (data_low - H8000_0000) and ICV_CNTL_mask
            end If
        else
            read_ICV_CNTL_value = data_low and ICV_CNTL_mask
        end If

    End Sub

    Sub write
        If flag_ICV_CNTL = &H0 Then read
        If flag_ICV_CNTL = &H0 Then write_ICV_CNTL_value = get_ICV_CNTL

        regValue = leftShift((write_ICV_CNTL_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ICV_CNTL_mask = &Hffff
        if data_low > LONG_MAX then
            if ICV_CNTL_mask = mask then
                read_ICV_CNTL_value = data_low
            else
                read_ICV_CNTL_value = (data_low - H8000_0000) and ICV_CNTL_mask
            end If
        else
            read_ICV_CNTL_value = data_low and ICV_CNTL_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ICV_CNTL_value = &H0
        flag_ICV_CNTL        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_icv_rx_cntl_p3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ICV_CNTL                                   [15:0]           get_ICV_CNTL
''                                                             set_ICV_CNTL
''                                                             read_ICV_CNTL
''                                                             write_ICV_CNTL
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_icv_rx_cntl_p3
    Private write_ICV_CNTL_value
    Private read_ICV_CNTL_value
    Private flag_ICV_CNTL

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

    Property Get get_ICV_CNTL
        get_ICV_CNTL = read_ICV_CNTL_value
    End Property

    Property Let set_ICV_CNTL(aData)
        write_ICV_CNTL_value = aData
        flag_ICV_CNTL        = &H1
    End Property

    Property Get read_ICV_CNTL
        read
        read_ICV_CNTL = read_ICV_CNTL_value
    End Property

    Property Let write_ICV_CNTL(aData)
        set_ICV_CNTL = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ICV_CNTL_mask = &Hffff
        if data_low > LONG_MAX then
            if ICV_CNTL_mask = mask then
                read_ICV_CNTL_value = data_low
            else
                read_ICV_CNTL_value = (data_low - H8000_0000) and ICV_CNTL_mask
            end If
        else
            read_ICV_CNTL_value = data_low and ICV_CNTL_mask
        end If

    End Sub

    Sub write
        If flag_ICV_CNTL = &H0 Then read
        If flag_ICV_CNTL = &H0 Then write_ICV_CNTL_value = get_ICV_CNTL

        regValue = leftShift((write_ICV_CNTL_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ICV_CNTL_mask = &Hffff
        if data_low > LONG_MAX then
            if ICV_CNTL_mask = mask then
                read_ICV_CNTL_value = data_low
            else
                read_ICV_CNTL_value = (data_low - H8000_0000) and ICV_CNTL_mask
            end If
        else
            read_ICV_CNTL_value = data_low and ICV_CNTL_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ICV_CNTL_value = &H0
        flag_ICV_CNTL        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_icv_rx_cntl_p4
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ICV_CNTL                                   [15:0]           get_ICV_CNTL
''                                                             set_ICV_CNTL
''                                                             read_ICV_CNTL
''                                                             write_ICV_CNTL
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_icv_rx_cntl_p4
    Private write_ICV_CNTL_value
    Private read_ICV_CNTL_value
    Private flag_ICV_CNTL

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

    Property Get get_ICV_CNTL
        get_ICV_CNTL = read_ICV_CNTL_value
    End Property

    Property Let set_ICV_CNTL(aData)
        write_ICV_CNTL_value = aData
        flag_ICV_CNTL        = &H1
    End Property

    Property Get read_ICV_CNTL
        read
        read_ICV_CNTL = read_ICV_CNTL_value
    End Property

    Property Let write_ICV_CNTL(aData)
        set_ICV_CNTL = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ICV_CNTL_mask = &Hffff
        if data_low > LONG_MAX then
            if ICV_CNTL_mask = mask then
                read_ICV_CNTL_value = data_low
            else
                read_ICV_CNTL_value = (data_low - H8000_0000) and ICV_CNTL_mask
            end If
        else
            read_ICV_CNTL_value = data_low and ICV_CNTL_mask
        end If

    End Sub

    Sub write
        If flag_ICV_CNTL = &H0 Then read
        If flag_ICV_CNTL = &H0 Then write_ICV_CNTL_value = get_ICV_CNTL

        regValue = leftShift((write_ICV_CNTL_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ICV_CNTL_mask = &Hffff
        if data_low > LONG_MAX then
            if ICV_CNTL_mask = mask then
                read_ICV_CNTL_value = data_low
            else
                read_ICV_CNTL_value = (data_low - H8000_0000) and ICV_CNTL_mask
            end If
        else
            read_ICV_CNTL_value = data_low and ICV_CNTL_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ICV_CNTL_value = &H0
        flag_ICV_CNTL        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_icv_rx_cntl_p5
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ICV_CNTL                                   [15:0]           get_ICV_CNTL
''                                                             set_ICV_CNTL
''                                                             read_ICV_CNTL
''                                                             write_ICV_CNTL
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_icv_rx_cntl_p5
    Private write_ICV_CNTL_value
    Private read_ICV_CNTL_value
    Private flag_ICV_CNTL

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

    Property Get get_ICV_CNTL
        get_ICV_CNTL = read_ICV_CNTL_value
    End Property

    Property Let set_ICV_CNTL(aData)
        write_ICV_CNTL_value = aData
        flag_ICV_CNTL        = &H1
    End Property

    Property Get read_ICV_CNTL
        read
        read_ICV_CNTL = read_ICV_CNTL_value
    End Property

    Property Let write_ICV_CNTL(aData)
        set_ICV_CNTL = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ICV_CNTL_mask = &Hffff
        if data_low > LONG_MAX then
            if ICV_CNTL_mask = mask then
                read_ICV_CNTL_value = data_low
            else
                read_ICV_CNTL_value = (data_low - H8000_0000) and ICV_CNTL_mask
            end If
        else
            read_ICV_CNTL_value = data_low and ICV_CNTL_mask
        end If

    End Sub

    Sub write
        If flag_ICV_CNTL = &H0 Then read
        If flag_ICV_CNTL = &H0 Then write_ICV_CNTL_value = get_ICV_CNTL

        regValue = leftShift((write_ICV_CNTL_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ICV_CNTL_mask = &Hffff
        if data_low > LONG_MAX then
            if ICV_CNTL_mask = mask then
                read_ICV_CNTL_value = data_low
            else
                read_ICV_CNTL_value = (data_low - H8000_0000) and ICV_CNTL_mask
            end If
        else
            read_ICV_CNTL_value = data_low and ICV_CNTL_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ICV_CNTL_value = &H0
        flag_ICV_CNTL        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_local_icv_id0_p0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LOCAL_ICV_ID_0                             [15:0]           get_LOCAL_ICV_ID_0
''                                                             set_LOCAL_ICV_ID_0
''                                                             read_LOCAL_ICV_ID_0
''                                                             write_LOCAL_ICV_ID_0
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_local_icv_id0_p0
    Private write_LOCAL_ICV_ID_0_value
    Private read_LOCAL_ICV_ID_0_value
    Private flag_LOCAL_ICV_ID_0

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

    Property Get get_LOCAL_ICV_ID_0
        get_LOCAL_ICV_ID_0 = read_LOCAL_ICV_ID_0_value
    End Property

    Property Let set_LOCAL_ICV_ID_0(aData)
        write_LOCAL_ICV_ID_0_value = aData
        flag_LOCAL_ICV_ID_0        = &H1
    End Property

    Property Get read_LOCAL_ICV_ID_0
        read
        read_LOCAL_ICV_ID_0 = read_LOCAL_ICV_ID_0_value
    End Property

    Property Let write_LOCAL_ICV_ID_0(aData)
        set_LOCAL_ICV_ID_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_0_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_0_mask = mask then
                read_LOCAL_ICV_ID_0_value = data_low
            else
                read_LOCAL_ICV_ID_0_value = (data_low - H8000_0000) and LOCAL_ICV_ID_0_mask
            end If
        else
            read_LOCAL_ICV_ID_0_value = data_low and LOCAL_ICV_ID_0_mask
        end If

    End Sub

    Sub write
        If flag_LOCAL_ICV_ID_0 = &H0 Then read
        If flag_LOCAL_ICV_ID_0 = &H0 Then write_LOCAL_ICV_ID_0_value = get_LOCAL_ICV_ID_0

        regValue = leftShift((write_LOCAL_ICV_ID_0_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_0_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_0_mask = mask then
                read_LOCAL_ICV_ID_0_value = data_low
            else
                read_LOCAL_ICV_ID_0_value = (data_low - H8000_0000) and LOCAL_ICV_ID_0_mask
            end If
        else
            read_LOCAL_ICV_ID_0_value = data_low and LOCAL_ICV_ID_0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LOCAL_ICV_ID_0_value = &H0
        flag_LOCAL_ICV_ID_0        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_local_icv_id0_p1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LOCAL_ICV_ID_0                             [15:0]           get_LOCAL_ICV_ID_0
''                                                             set_LOCAL_ICV_ID_0
''                                                             read_LOCAL_ICV_ID_0
''                                                             write_LOCAL_ICV_ID_0
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_local_icv_id0_p1
    Private write_LOCAL_ICV_ID_0_value
    Private read_LOCAL_ICV_ID_0_value
    Private flag_LOCAL_ICV_ID_0

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

    Property Get get_LOCAL_ICV_ID_0
        get_LOCAL_ICV_ID_0 = read_LOCAL_ICV_ID_0_value
    End Property

    Property Let set_LOCAL_ICV_ID_0(aData)
        write_LOCAL_ICV_ID_0_value = aData
        flag_LOCAL_ICV_ID_0        = &H1
    End Property

    Property Get read_LOCAL_ICV_ID_0
        read
        read_LOCAL_ICV_ID_0 = read_LOCAL_ICV_ID_0_value
    End Property

    Property Let write_LOCAL_ICV_ID_0(aData)
        set_LOCAL_ICV_ID_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_0_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_0_mask = mask then
                read_LOCAL_ICV_ID_0_value = data_low
            else
                read_LOCAL_ICV_ID_0_value = (data_low - H8000_0000) and LOCAL_ICV_ID_0_mask
            end If
        else
            read_LOCAL_ICV_ID_0_value = data_low and LOCAL_ICV_ID_0_mask
        end If

    End Sub

    Sub write
        If flag_LOCAL_ICV_ID_0 = &H0 Then read
        If flag_LOCAL_ICV_ID_0 = &H0 Then write_LOCAL_ICV_ID_0_value = get_LOCAL_ICV_ID_0

        regValue = leftShift((write_LOCAL_ICV_ID_0_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_0_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_0_mask = mask then
                read_LOCAL_ICV_ID_0_value = data_low
            else
                read_LOCAL_ICV_ID_0_value = (data_low - H8000_0000) and LOCAL_ICV_ID_0_mask
            end If
        else
            read_LOCAL_ICV_ID_0_value = data_low and LOCAL_ICV_ID_0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LOCAL_ICV_ID_0_value = &H0
        flag_LOCAL_ICV_ID_0        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_local_icv_id0_p2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LOCAL_ICV_ID_0                             [15:0]           get_LOCAL_ICV_ID_0
''                                                             set_LOCAL_ICV_ID_0
''                                                             read_LOCAL_ICV_ID_0
''                                                             write_LOCAL_ICV_ID_0
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_local_icv_id0_p2
    Private write_LOCAL_ICV_ID_0_value
    Private read_LOCAL_ICV_ID_0_value
    Private flag_LOCAL_ICV_ID_0

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

    Property Get get_LOCAL_ICV_ID_0
        get_LOCAL_ICV_ID_0 = read_LOCAL_ICV_ID_0_value
    End Property

    Property Let set_LOCAL_ICV_ID_0(aData)
        write_LOCAL_ICV_ID_0_value = aData
        flag_LOCAL_ICV_ID_0        = &H1
    End Property

    Property Get read_LOCAL_ICV_ID_0
        read
        read_LOCAL_ICV_ID_0 = read_LOCAL_ICV_ID_0_value
    End Property

    Property Let write_LOCAL_ICV_ID_0(aData)
        set_LOCAL_ICV_ID_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_0_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_0_mask = mask then
                read_LOCAL_ICV_ID_0_value = data_low
            else
                read_LOCAL_ICV_ID_0_value = (data_low - H8000_0000) and LOCAL_ICV_ID_0_mask
            end If
        else
            read_LOCAL_ICV_ID_0_value = data_low and LOCAL_ICV_ID_0_mask
        end If

    End Sub

    Sub write
        If flag_LOCAL_ICV_ID_0 = &H0 Then read
        If flag_LOCAL_ICV_ID_0 = &H0 Then write_LOCAL_ICV_ID_0_value = get_LOCAL_ICV_ID_0

        regValue = leftShift((write_LOCAL_ICV_ID_0_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_0_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_0_mask = mask then
                read_LOCAL_ICV_ID_0_value = data_low
            else
                read_LOCAL_ICV_ID_0_value = (data_low - H8000_0000) and LOCAL_ICV_ID_0_mask
            end If
        else
            read_LOCAL_ICV_ID_0_value = data_low and LOCAL_ICV_ID_0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LOCAL_ICV_ID_0_value = &H0
        flag_LOCAL_ICV_ID_0        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_local_icv_id0_p3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LOCAL_ICV_ID_0                             [15:0]           get_LOCAL_ICV_ID_0
''                                                             set_LOCAL_ICV_ID_0
''                                                             read_LOCAL_ICV_ID_0
''                                                             write_LOCAL_ICV_ID_0
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_local_icv_id0_p3
    Private write_LOCAL_ICV_ID_0_value
    Private read_LOCAL_ICV_ID_0_value
    Private flag_LOCAL_ICV_ID_0

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

    Property Get get_LOCAL_ICV_ID_0
        get_LOCAL_ICV_ID_0 = read_LOCAL_ICV_ID_0_value
    End Property

    Property Let set_LOCAL_ICV_ID_0(aData)
        write_LOCAL_ICV_ID_0_value = aData
        flag_LOCAL_ICV_ID_0        = &H1
    End Property

    Property Get read_LOCAL_ICV_ID_0
        read
        read_LOCAL_ICV_ID_0 = read_LOCAL_ICV_ID_0_value
    End Property

    Property Let write_LOCAL_ICV_ID_0(aData)
        set_LOCAL_ICV_ID_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_0_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_0_mask = mask then
                read_LOCAL_ICV_ID_0_value = data_low
            else
                read_LOCAL_ICV_ID_0_value = (data_low - H8000_0000) and LOCAL_ICV_ID_0_mask
            end If
        else
            read_LOCAL_ICV_ID_0_value = data_low and LOCAL_ICV_ID_0_mask
        end If

    End Sub

    Sub write
        If flag_LOCAL_ICV_ID_0 = &H0 Then read
        If flag_LOCAL_ICV_ID_0 = &H0 Then write_LOCAL_ICV_ID_0_value = get_LOCAL_ICV_ID_0

        regValue = leftShift((write_LOCAL_ICV_ID_0_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_0_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_0_mask = mask then
                read_LOCAL_ICV_ID_0_value = data_low
            else
                read_LOCAL_ICV_ID_0_value = (data_low - H8000_0000) and LOCAL_ICV_ID_0_mask
            end If
        else
            read_LOCAL_ICV_ID_0_value = data_low and LOCAL_ICV_ID_0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LOCAL_ICV_ID_0_value = &H0
        flag_LOCAL_ICV_ID_0        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_local_icv_id0_p4
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LOCAL_ICV_ID_0                             [15:0]           get_LOCAL_ICV_ID_0
''                                                             set_LOCAL_ICV_ID_0
''                                                             read_LOCAL_ICV_ID_0
''                                                             write_LOCAL_ICV_ID_0
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_local_icv_id0_p4
    Private write_LOCAL_ICV_ID_0_value
    Private read_LOCAL_ICV_ID_0_value
    Private flag_LOCAL_ICV_ID_0

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

    Property Get get_LOCAL_ICV_ID_0
        get_LOCAL_ICV_ID_0 = read_LOCAL_ICV_ID_0_value
    End Property

    Property Let set_LOCAL_ICV_ID_0(aData)
        write_LOCAL_ICV_ID_0_value = aData
        flag_LOCAL_ICV_ID_0        = &H1
    End Property

    Property Get read_LOCAL_ICV_ID_0
        read
        read_LOCAL_ICV_ID_0 = read_LOCAL_ICV_ID_0_value
    End Property

    Property Let write_LOCAL_ICV_ID_0(aData)
        set_LOCAL_ICV_ID_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_0_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_0_mask = mask then
                read_LOCAL_ICV_ID_0_value = data_low
            else
                read_LOCAL_ICV_ID_0_value = (data_low - H8000_0000) and LOCAL_ICV_ID_0_mask
            end If
        else
            read_LOCAL_ICV_ID_0_value = data_low and LOCAL_ICV_ID_0_mask
        end If

    End Sub

    Sub write
        If flag_LOCAL_ICV_ID_0 = &H0 Then read
        If flag_LOCAL_ICV_ID_0 = &H0 Then write_LOCAL_ICV_ID_0_value = get_LOCAL_ICV_ID_0

        regValue = leftShift((write_LOCAL_ICV_ID_0_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_0_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_0_mask = mask then
                read_LOCAL_ICV_ID_0_value = data_low
            else
                read_LOCAL_ICV_ID_0_value = (data_low - H8000_0000) and LOCAL_ICV_ID_0_mask
            end If
        else
            read_LOCAL_ICV_ID_0_value = data_low and LOCAL_ICV_ID_0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LOCAL_ICV_ID_0_value = &H0
        flag_LOCAL_ICV_ID_0        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_local_icv_id0_p5
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LOCAL_ICV_ID_0                             [15:0]           get_LOCAL_ICV_ID_0
''                                                             set_LOCAL_ICV_ID_0
''                                                             read_LOCAL_ICV_ID_0
''                                                             write_LOCAL_ICV_ID_0
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_local_icv_id0_p5
    Private write_LOCAL_ICV_ID_0_value
    Private read_LOCAL_ICV_ID_0_value
    Private flag_LOCAL_ICV_ID_0

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

    Property Get get_LOCAL_ICV_ID_0
        get_LOCAL_ICV_ID_0 = read_LOCAL_ICV_ID_0_value
    End Property

    Property Let set_LOCAL_ICV_ID_0(aData)
        write_LOCAL_ICV_ID_0_value = aData
        flag_LOCAL_ICV_ID_0        = &H1
    End Property

    Property Get read_LOCAL_ICV_ID_0
        read
        read_LOCAL_ICV_ID_0 = read_LOCAL_ICV_ID_0_value
    End Property

    Property Let write_LOCAL_ICV_ID_0(aData)
        set_LOCAL_ICV_ID_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_0_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_0_mask = mask then
                read_LOCAL_ICV_ID_0_value = data_low
            else
                read_LOCAL_ICV_ID_0_value = (data_low - H8000_0000) and LOCAL_ICV_ID_0_mask
            end If
        else
            read_LOCAL_ICV_ID_0_value = data_low and LOCAL_ICV_ID_0_mask
        end If

    End Sub

    Sub write
        If flag_LOCAL_ICV_ID_0 = &H0 Then read
        If flag_LOCAL_ICV_ID_0 = &H0 Then write_LOCAL_ICV_ID_0_value = get_LOCAL_ICV_ID_0

        regValue = leftShift((write_LOCAL_ICV_ID_0_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_0_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_0_mask = mask then
                read_LOCAL_ICV_ID_0_value = data_low
            else
                read_LOCAL_ICV_ID_0_value = (data_low - H8000_0000) and LOCAL_ICV_ID_0_mask
            end If
        else
            read_LOCAL_ICV_ID_0_value = data_low and LOCAL_ICV_ID_0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LOCAL_ICV_ID_0_value = &H0
        flag_LOCAL_ICV_ID_0        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_local_icv_id1_p0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LOCAL_ICV_ID_1                             [15:0]           get_LOCAL_ICV_ID_1
''                                                             set_LOCAL_ICV_ID_1
''                                                             read_LOCAL_ICV_ID_1
''                                                             write_LOCAL_ICV_ID_1
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_local_icv_id1_p0
    Private write_LOCAL_ICV_ID_1_value
    Private read_LOCAL_ICV_ID_1_value
    Private flag_LOCAL_ICV_ID_1

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

    Property Get get_LOCAL_ICV_ID_1
        get_LOCAL_ICV_ID_1 = read_LOCAL_ICV_ID_1_value
    End Property

    Property Let set_LOCAL_ICV_ID_1(aData)
        write_LOCAL_ICV_ID_1_value = aData
        flag_LOCAL_ICV_ID_1        = &H1
    End Property

    Property Get read_LOCAL_ICV_ID_1
        read
        read_LOCAL_ICV_ID_1 = read_LOCAL_ICV_ID_1_value
    End Property

    Property Let write_LOCAL_ICV_ID_1(aData)
        set_LOCAL_ICV_ID_1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_1_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_1_mask = mask then
                read_LOCAL_ICV_ID_1_value = data_low
            else
                read_LOCAL_ICV_ID_1_value = (data_low - H8000_0000) and LOCAL_ICV_ID_1_mask
            end If
        else
            read_LOCAL_ICV_ID_1_value = data_low and LOCAL_ICV_ID_1_mask
        end If

    End Sub

    Sub write
        If flag_LOCAL_ICV_ID_1 = &H0 Then read
        If flag_LOCAL_ICV_ID_1 = &H0 Then write_LOCAL_ICV_ID_1_value = get_LOCAL_ICV_ID_1

        regValue = leftShift((write_LOCAL_ICV_ID_1_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_1_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_1_mask = mask then
                read_LOCAL_ICV_ID_1_value = data_low
            else
                read_LOCAL_ICV_ID_1_value = (data_low - H8000_0000) and LOCAL_ICV_ID_1_mask
            end If
        else
            read_LOCAL_ICV_ID_1_value = data_low and LOCAL_ICV_ID_1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LOCAL_ICV_ID_1_value = &H0
        flag_LOCAL_ICV_ID_1        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_local_icv_id1_p1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LOCAL_ICV_ID_1                             [15:0]           get_LOCAL_ICV_ID_1
''                                                             set_LOCAL_ICV_ID_1
''                                                             read_LOCAL_ICV_ID_1
''                                                             write_LOCAL_ICV_ID_1
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_local_icv_id1_p1
    Private write_LOCAL_ICV_ID_1_value
    Private read_LOCAL_ICV_ID_1_value
    Private flag_LOCAL_ICV_ID_1

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H32
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_LOCAL_ICV_ID_1
        get_LOCAL_ICV_ID_1 = read_LOCAL_ICV_ID_1_value
    End Property

    Property Let set_LOCAL_ICV_ID_1(aData)
        write_LOCAL_ICV_ID_1_value = aData
        flag_LOCAL_ICV_ID_1        = &H1
    End Property

    Property Get read_LOCAL_ICV_ID_1
        read
        read_LOCAL_ICV_ID_1 = read_LOCAL_ICV_ID_1_value
    End Property

    Property Let write_LOCAL_ICV_ID_1(aData)
        set_LOCAL_ICV_ID_1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_1_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_1_mask = mask then
                read_LOCAL_ICV_ID_1_value = data_low
            else
                read_LOCAL_ICV_ID_1_value = (data_low - H8000_0000) and LOCAL_ICV_ID_1_mask
            end If
        else
            read_LOCAL_ICV_ID_1_value = data_low and LOCAL_ICV_ID_1_mask
        end If

    End Sub

    Sub write
        If flag_LOCAL_ICV_ID_1 = &H0 Then read
        If flag_LOCAL_ICV_ID_1 = &H0 Then write_LOCAL_ICV_ID_1_value = get_LOCAL_ICV_ID_1

        regValue = leftShift((write_LOCAL_ICV_ID_1_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_1_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_1_mask = mask then
                read_LOCAL_ICV_ID_1_value = data_low
            else
                read_LOCAL_ICV_ID_1_value = (data_low - H8000_0000) and LOCAL_ICV_ID_1_mask
            end If
        else
            read_LOCAL_ICV_ID_1_value = data_low and LOCAL_ICV_ID_1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LOCAL_ICV_ID_1_value = &H0
        flag_LOCAL_ICV_ID_1        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_local_icv_id1_p2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LOCAL_ICV_ID_1                             [15:0]           get_LOCAL_ICV_ID_1
''                                                             set_LOCAL_ICV_ID_1
''                                                             read_LOCAL_ICV_ID_1
''                                                             write_LOCAL_ICV_ID_1
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_local_icv_id1_p2
    Private write_LOCAL_ICV_ID_1_value
    Private read_LOCAL_ICV_ID_1_value
    Private flag_LOCAL_ICV_ID_1

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

    Property Get get_LOCAL_ICV_ID_1
        get_LOCAL_ICV_ID_1 = read_LOCAL_ICV_ID_1_value
    End Property

    Property Let set_LOCAL_ICV_ID_1(aData)
        write_LOCAL_ICV_ID_1_value = aData
        flag_LOCAL_ICV_ID_1        = &H1
    End Property

    Property Get read_LOCAL_ICV_ID_1
        read
        read_LOCAL_ICV_ID_1 = read_LOCAL_ICV_ID_1_value
    End Property

    Property Let write_LOCAL_ICV_ID_1(aData)
        set_LOCAL_ICV_ID_1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_1_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_1_mask = mask then
                read_LOCAL_ICV_ID_1_value = data_low
            else
                read_LOCAL_ICV_ID_1_value = (data_low - H8000_0000) and LOCAL_ICV_ID_1_mask
            end If
        else
            read_LOCAL_ICV_ID_1_value = data_low and LOCAL_ICV_ID_1_mask
        end If

    End Sub

    Sub write
        If flag_LOCAL_ICV_ID_1 = &H0 Then read
        If flag_LOCAL_ICV_ID_1 = &H0 Then write_LOCAL_ICV_ID_1_value = get_LOCAL_ICV_ID_1

        regValue = leftShift((write_LOCAL_ICV_ID_1_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_1_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_1_mask = mask then
                read_LOCAL_ICV_ID_1_value = data_low
            else
                read_LOCAL_ICV_ID_1_value = (data_low - H8000_0000) and LOCAL_ICV_ID_1_mask
            end If
        else
            read_LOCAL_ICV_ID_1_value = data_low and LOCAL_ICV_ID_1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LOCAL_ICV_ID_1_value = &H0
        flag_LOCAL_ICV_ID_1        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_local_icv_id1_p3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LOCAL_ICV_ID_1                             [15:0]           get_LOCAL_ICV_ID_1
''                                                             set_LOCAL_ICV_ID_1
''                                                             read_LOCAL_ICV_ID_1
''                                                             write_LOCAL_ICV_ID_1
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_local_icv_id1_p3
    Private write_LOCAL_ICV_ID_1_value
    Private read_LOCAL_ICV_ID_1_value
    Private flag_LOCAL_ICV_ID_1

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H36
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_LOCAL_ICV_ID_1
        get_LOCAL_ICV_ID_1 = read_LOCAL_ICV_ID_1_value
    End Property

    Property Let set_LOCAL_ICV_ID_1(aData)
        write_LOCAL_ICV_ID_1_value = aData
        flag_LOCAL_ICV_ID_1        = &H1
    End Property

    Property Get read_LOCAL_ICV_ID_1
        read
        read_LOCAL_ICV_ID_1 = read_LOCAL_ICV_ID_1_value
    End Property

    Property Let write_LOCAL_ICV_ID_1(aData)
        set_LOCAL_ICV_ID_1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_1_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_1_mask = mask then
                read_LOCAL_ICV_ID_1_value = data_low
            else
                read_LOCAL_ICV_ID_1_value = (data_low - H8000_0000) and LOCAL_ICV_ID_1_mask
            end If
        else
            read_LOCAL_ICV_ID_1_value = data_low and LOCAL_ICV_ID_1_mask
        end If

    End Sub

    Sub write
        If flag_LOCAL_ICV_ID_1 = &H0 Then read
        If flag_LOCAL_ICV_ID_1 = &H0 Then write_LOCAL_ICV_ID_1_value = get_LOCAL_ICV_ID_1

        regValue = leftShift((write_LOCAL_ICV_ID_1_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_1_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_1_mask = mask then
                read_LOCAL_ICV_ID_1_value = data_low
            else
                read_LOCAL_ICV_ID_1_value = (data_low - H8000_0000) and LOCAL_ICV_ID_1_mask
            end If
        else
            read_LOCAL_ICV_ID_1_value = data_low and LOCAL_ICV_ID_1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LOCAL_ICV_ID_1_value = &H0
        flag_LOCAL_ICV_ID_1        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_local_icv_id1_p4
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LOCAL_ICV_ID_1                             [15:0]           get_LOCAL_ICV_ID_1
''                                                             set_LOCAL_ICV_ID_1
''                                                             read_LOCAL_ICV_ID_1
''                                                             write_LOCAL_ICV_ID_1
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_local_icv_id1_p4
    Private write_LOCAL_ICV_ID_1_value
    Private read_LOCAL_ICV_ID_1_value
    Private flag_LOCAL_ICV_ID_1

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

    Property Get get_LOCAL_ICV_ID_1
        get_LOCAL_ICV_ID_1 = read_LOCAL_ICV_ID_1_value
    End Property

    Property Let set_LOCAL_ICV_ID_1(aData)
        write_LOCAL_ICV_ID_1_value = aData
        flag_LOCAL_ICV_ID_1        = &H1
    End Property

    Property Get read_LOCAL_ICV_ID_1
        read
        read_LOCAL_ICV_ID_1 = read_LOCAL_ICV_ID_1_value
    End Property

    Property Let write_LOCAL_ICV_ID_1(aData)
        set_LOCAL_ICV_ID_1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_1_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_1_mask = mask then
                read_LOCAL_ICV_ID_1_value = data_low
            else
                read_LOCAL_ICV_ID_1_value = (data_low - H8000_0000) and LOCAL_ICV_ID_1_mask
            end If
        else
            read_LOCAL_ICV_ID_1_value = data_low and LOCAL_ICV_ID_1_mask
        end If

    End Sub

    Sub write
        If flag_LOCAL_ICV_ID_1 = &H0 Then read
        If flag_LOCAL_ICV_ID_1 = &H0 Then write_LOCAL_ICV_ID_1_value = get_LOCAL_ICV_ID_1

        regValue = leftShift((write_LOCAL_ICV_ID_1_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_1_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_1_mask = mask then
                read_LOCAL_ICV_ID_1_value = data_low
            else
                read_LOCAL_ICV_ID_1_value = (data_low - H8000_0000) and LOCAL_ICV_ID_1_mask
            end If
        else
            read_LOCAL_ICV_ID_1_value = data_low and LOCAL_ICV_ID_1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LOCAL_ICV_ID_1_value = &H0
        flag_LOCAL_ICV_ID_1        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_local_icv_id1_p5
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LOCAL_ICV_ID_1                             [15:0]           get_LOCAL_ICV_ID_1
''                                                             set_LOCAL_ICV_ID_1
''                                                             read_LOCAL_ICV_ID_1
''                                                             write_LOCAL_ICV_ID_1
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_local_icv_id1_p5
    Private write_LOCAL_ICV_ID_1_value
    Private read_LOCAL_ICV_ID_1_value
    Private flag_LOCAL_ICV_ID_1

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3a
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_LOCAL_ICV_ID_1
        get_LOCAL_ICV_ID_1 = read_LOCAL_ICV_ID_1_value
    End Property

    Property Let set_LOCAL_ICV_ID_1(aData)
        write_LOCAL_ICV_ID_1_value = aData
        flag_LOCAL_ICV_ID_1        = &H1
    End Property

    Property Get read_LOCAL_ICV_ID_1
        read
        read_LOCAL_ICV_ID_1 = read_LOCAL_ICV_ID_1_value
    End Property

    Property Let write_LOCAL_ICV_ID_1(aData)
        set_LOCAL_ICV_ID_1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_1_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_1_mask = mask then
                read_LOCAL_ICV_ID_1_value = data_low
            else
                read_LOCAL_ICV_ID_1_value = (data_low - H8000_0000) and LOCAL_ICV_ID_1_mask
            end If
        else
            read_LOCAL_ICV_ID_1_value = data_low and LOCAL_ICV_ID_1_mask
        end If

    End Sub

    Sub write
        If flag_LOCAL_ICV_ID_1 = &H0 Then read
        If flag_LOCAL_ICV_ID_1 = &H0 Then write_LOCAL_ICV_ID_1_value = get_LOCAL_ICV_ID_1

        regValue = leftShift((write_LOCAL_ICV_ID_1_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_1_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_1_mask = mask then
                read_LOCAL_ICV_ID_1_value = data_low
            else
                read_LOCAL_ICV_ID_1_value = (data_low - H8000_0000) and LOCAL_ICV_ID_1_mask
            end If
        else
            read_LOCAL_ICV_ID_1_value = data_low and LOCAL_ICV_ID_1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LOCAL_ICV_ID_1_value = &H0
        flag_LOCAL_ICV_ID_1        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_local_icv_id2_p0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LOCAL_ICV_ID_2                             [15:0]           get_LOCAL_ICV_ID_2
''                                                             set_LOCAL_ICV_ID_2
''                                                             read_LOCAL_ICV_ID_2
''                                                             write_LOCAL_ICV_ID_2
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_local_icv_id2_p0
    Private write_LOCAL_ICV_ID_2_value
    Private read_LOCAL_ICV_ID_2_value
    Private flag_LOCAL_ICV_ID_2

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

    Property Get get_LOCAL_ICV_ID_2
        get_LOCAL_ICV_ID_2 = read_LOCAL_ICV_ID_2_value
    End Property

    Property Let set_LOCAL_ICV_ID_2(aData)
        write_LOCAL_ICV_ID_2_value = aData
        flag_LOCAL_ICV_ID_2        = &H1
    End Property

    Property Get read_LOCAL_ICV_ID_2
        read
        read_LOCAL_ICV_ID_2 = read_LOCAL_ICV_ID_2_value
    End Property

    Property Let write_LOCAL_ICV_ID_2(aData)
        set_LOCAL_ICV_ID_2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_2_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_2_mask = mask then
                read_LOCAL_ICV_ID_2_value = data_low
            else
                read_LOCAL_ICV_ID_2_value = (data_low - H8000_0000) and LOCAL_ICV_ID_2_mask
            end If
        else
            read_LOCAL_ICV_ID_2_value = data_low and LOCAL_ICV_ID_2_mask
        end If

    End Sub

    Sub write
        If flag_LOCAL_ICV_ID_2 = &H0 Then read
        If flag_LOCAL_ICV_ID_2 = &H0 Then write_LOCAL_ICV_ID_2_value = get_LOCAL_ICV_ID_2

        regValue = leftShift((write_LOCAL_ICV_ID_2_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_2_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_2_mask = mask then
                read_LOCAL_ICV_ID_2_value = data_low
            else
                read_LOCAL_ICV_ID_2_value = (data_low - H8000_0000) and LOCAL_ICV_ID_2_mask
            end If
        else
            read_LOCAL_ICV_ID_2_value = data_low and LOCAL_ICV_ID_2_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LOCAL_ICV_ID_2_value = &H0
        flag_LOCAL_ICV_ID_2        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_local_icv_id2_p1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LOCAL_ICV_ID_2                             [15:0]           get_LOCAL_ICV_ID_2
''                                                             set_LOCAL_ICV_ID_2
''                                                             read_LOCAL_ICV_ID_2
''                                                             write_LOCAL_ICV_ID_2
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_local_icv_id2_p1
    Private write_LOCAL_ICV_ID_2_value
    Private read_LOCAL_ICV_ID_2_value
    Private flag_LOCAL_ICV_ID_2

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H42
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_LOCAL_ICV_ID_2
        get_LOCAL_ICV_ID_2 = read_LOCAL_ICV_ID_2_value
    End Property

    Property Let set_LOCAL_ICV_ID_2(aData)
        write_LOCAL_ICV_ID_2_value = aData
        flag_LOCAL_ICV_ID_2        = &H1
    End Property

    Property Get read_LOCAL_ICV_ID_2
        read
        read_LOCAL_ICV_ID_2 = read_LOCAL_ICV_ID_2_value
    End Property

    Property Let write_LOCAL_ICV_ID_2(aData)
        set_LOCAL_ICV_ID_2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_2_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_2_mask = mask then
                read_LOCAL_ICV_ID_2_value = data_low
            else
                read_LOCAL_ICV_ID_2_value = (data_low - H8000_0000) and LOCAL_ICV_ID_2_mask
            end If
        else
            read_LOCAL_ICV_ID_2_value = data_low and LOCAL_ICV_ID_2_mask
        end If

    End Sub

    Sub write
        If flag_LOCAL_ICV_ID_2 = &H0 Then read
        If flag_LOCAL_ICV_ID_2 = &H0 Then write_LOCAL_ICV_ID_2_value = get_LOCAL_ICV_ID_2

        regValue = leftShift((write_LOCAL_ICV_ID_2_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_2_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_2_mask = mask then
                read_LOCAL_ICV_ID_2_value = data_low
            else
                read_LOCAL_ICV_ID_2_value = (data_low - H8000_0000) and LOCAL_ICV_ID_2_mask
            end If
        else
            read_LOCAL_ICV_ID_2_value = data_low and LOCAL_ICV_ID_2_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LOCAL_ICV_ID_2_value = &H0
        flag_LOCAL_ICV_ID_2        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_local_icv_id2_p2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LOCAL_ICV_ID_2                             [15:0]           get_LOCAL_ICV_ID_2
''                                                             set_LOCAL_ICV_ID_2
''                                                             read_LOCAL_ICV_ID_2
''                                                             write_LOCAL_ICV_ID_2
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_local_icv_id2_p2
    Private write_LOCAL_ICV_ID_2_value
    Private read_LOCAL_ICV_ID_2_value
    Private flag_LOCAL_ICV_ID_2

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

    Property Get get_LOCAL_ICV_ID_2
        get_LOCAL_ICV_ID_2 = read_LOCAL_ICV_ID_2_value
    End Property

    Property Let set_LOCAL_ICV_ID_2(aData)
        write_LOCAL_ICV_ID_2_value = aData
        flag_LOCAL_ICV_ID_2        = &H1
    End Property

    Property Get read_LOCAL_ICV_ID_2
        read
        read_LOCAL_ICV_ID_2 = read_LOCAL_ICV_ID_2_value
    End Property

    Property Let write_LOCAL_ICV_ID_2(aData)
        set_LOCAL_ICV_ID_2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_2_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_2_mask = mask then
                read_LOCAL_ICV_ID_2_value = data_low
            else
                read_LOCAL_ICV_ID_2_value = (data_low - H8000_0000) and LOCAL_ICV_ID_2_mask
            end If
        else
            read_LOCAL_ICV_ID_2_value = data_low and LOCAL_ICV_ID_2_mask
        end If

    End Sub

    Sub write
        If flag_LOCAL_ICV_ID_2 = &H0 Then read
        If flag_LOCAL_ICV_ID_2 = &H0 Then write_LOCAL_ICV_ID_2_value = get_LOCAL_ICV_ID_2

        regValue = leftShift((write_LOCAL_ICV_ID_2_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_2_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_2_mask = mask then
                read_LOCAL_ICV_ID_2_value = data_low
            else
                read_LOCAL_ICV_ID_2_value = (data_low - H8000_0000) and LOCAL_ICV_ID_2_mask
            end If
        else
            read_LOCAL_ICV_ID_2_value = data_low and LOCAL_ICV_ID_2_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LOCAL_ICV_ID_2_value = &H0
        flag_LOCAL_ICV_ID_2        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_local_icv_id2_p3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LOCAL_ICV_ID_2                             [15:0]           get_LOCAL_ICV_ID_2
''                                                             set_LOCAL_ICV_ID_2
''                                                             read_LOCAL_ICV_ID_2
''                                                             write_LOCAL_ICV_ID_2
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_local_icv_id2_p3
    Private write_LOCAL_ICV_ID_2_value
    Private read_LOCAL_ICV_ID_2_value
    Private flag_LOCAL_ICV_ID_2

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H46
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_LOCAL_ICV_ID_2
        get_LOCAL_ICV_ID_2 = read_LOCAL_ICV_ID_2_value
    End Property

    Property Let set_LOCAL_ICV_ID_2(aData)
        write_LOCAL_ICV_ID_2_value = aData
        flag_LOCAL_ICV_ID_2        = &H1
    End Property

    Property Get read_LOCAL_ICV_ID_2
        read
        read_LOCAL_ICV_ID_2 = read_LOCAL_ICV_ID_2_value
    End Property

    Property Let write_LOCAL_ICV_ID_2(aData)
        set_LOCAL_ICV_ID_2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_2_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_2_mask = mask then
                read_LOCAL_ICV_ID_2_value = data_low
            else
                read_LOCAL_ICV_ID_2_value = (data_low - H8000_0000) and LOCAL_ICV_ID_2_mask
            end If
        else
            read_LOCAL_ICV_ID_2_value = data_low and LOCAL_ICV_ID_2_mask
        end If

    End Sub

    Sub write
        If flag_LOCAL_ICV_ID_2 = &H0 Then read
        If flag_LOCAL_ICV_ID_2 = &H0 Then write_LOCAL_ICV_ID_2_value = get_LOCAL_ICV_ID_2

        regValue = leftShift((write_LOCAL_ICV_ID_2_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_2_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_2_mask = mask then
                read_LOCAL_ICV_ID_2_value = data_low
            else
                read_LOCAL_ICV_ID_2_value = (data_low - H8000_0000) and LOCAL_ICV_ID_2_mask
            end If
        else
            read_LOCAL_ICV_ID_2_value = data_low and LOCAL_ICV_ID_2_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LOCAL_ICV_ID_2_value = &H0
        flag_LOCAL_ICV_ID_2        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_local_icv_id2_p4
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LOCAL_ICV_ID_2                             [15:0]           get_LOCAL_ICV_ID_2
''                                                             set_LOCAL_ICV_ID_2
''                                                             read_LOCAL_ICV_ID_2
''                                                             write_LOCAL_ICV_ID_2
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_local_icv_id2_p4
    Private write_LOCAL_ICV_ID_2_value
    Private read_LOCAL_ICV_ID_2_value
    Private flag_LOCAL_ICV_ID_2

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

    Property Get get_LOCAL_ICV_ID_2
        get_LOCAL_ICV_ID_2 = read_LOCAL_ICV_ID_2_value
    End Property

    Property Let set_LOCAL_ICV_ID_2(aData)
        write_LOCAL_ICV_ID_2_value = aData
        flag_LOCAL_ICV_ID_2        = &H1
    End Property

    Property Get read_LOCAL_ICV_ID_2
        read
        read_LOCAL_ICV_ID_2 = read_LOCAL_ICV_ID_2_value
    End Property

    Property Let write_LOCAL_ICV_ID_2(aData)
        set_LOCAL_ICV_ID_2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_2_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_2_mask = mask then
                read_LOCAL_ICV_ID_2_value = data_low
            else
                read_LOCAL_ICV_ID_2_value = (data_low - H8000_0000) and LOCAL_ICV_ID_2_mask
            end If
        else
            read_LOCAL_ICV_ID_2_value = data_low and LOCAL_ICV_ID_2_mask
        end If

    End Sub

    Sub write
        If flag_LOCAL_ICV_ID_2 = &H0 Then read
        If flag_LOCAL_ICV_ID_2 = &H0 Then write_LOCAL_ICV_ID_2_value = get_LOCAL_ICV_ID_2

        regValue = leftShift((write_LOCAL_ICV_ID_2_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_2_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_2_mask = mask then
                read_LOCAL_ICV_ID_2_value = data_low
            else
                read_LOCAL_ICV_ID_2_value = (data_low - H8000_0000) and LOCAL_ICV_ID_2_mask
            end If
        else
            read_LOCAL_ICV_ID_2_value = data_low and LOCAL_ICV_ID_2_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LOCAL_ICV_ID_2_value = &H0
        flag_LOCAL_ICV_ID_2        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_local_icv_id2_p5
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LOCAL_ICV_ID_2                             [15:0]           get_LOCAL_ICV_ID_2
''                                                             set_LOCAL_ICV_ID_2
''                                                             read_LOCAL_ICV_ID_2
''                                                             write_LOCAL_ICV_ID_2
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_local_icv_id2_p5
    Private write_LOCAL_ICV_ID_2_value
    Private read_LOCAL_ICV_ID_2_value
    Private flag_LOCAL_ICV_ID_2

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H4a
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_LOCAL_ICV_ID_2
        get_LOCAL_ICV_ID_2 = read_LOCAL_ICV_ID_2_value
    End Property

    Property Let set_LOCAL_ICV_ID_2(aData)
        write_LOCAL_ICV_ID_2_value = aData
        flag_LOCAL_ICV_ID_2        = &H1
    End Property

    Property Get read_LOCAL_ICV_ID_2
        read
        read_LOCAL_ICV_ID_2 = read_LOCAL_ICV_ID_2_value
    End Property

    Property Let write_LOCAL_ICV_ID_2(aData)
        set_LOCAL_ICV_ID_2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_2_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_2_mask = mask then
                read_LOCAL_ICV_ID_2_value = data_low
            else
                read_LOCAL_ICV_ID_2_value = (data_low - H8000_0000) and LOCAL_ICV_ID_2_mask
            end If
        else
            read_LOCAL_ICV_ID_2_value = data_low and LOCAL_ICV_ID_2_mask
        end If

    End Sub

    Sub write
        If flag_LOCAL_ICV_ID_2 = &H0 Then read
        If flag_LOCAL_ICV_ID_2 = &H0 Then write_LOCAL_ICV_ID_2_value = get_LOCAL_ICV_ID_2

        regValue = leftShift((write_LOCAL_ICV_ID_2_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_2_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_2_mask = mask then
                read_LOCAL_ICV_ID_2_value = data_low
            else
                read_LOCAL_ICV_ID_2_value = (data_low - H8000_0000) and LOCAL_ICV_ID_2_mask
            end If
        else
            read_LOCAL_ICV_ID_2_value = data_low and LOCAL_ICV_ID_2_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LOCAL_ICV_ID_2_value = &H0
        flag_LOCAL_ICV_ID_2        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_local_icv_id3_p0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LOCAL_ICV_ID_3                             [15:0]           get_LOCAL_ICV_ID_3
''                                                             set_LOCAL_ICV_ID_3
''                                                             read_LOCAL_ICV_ID_3
''                                                             write_LOCAL_ICV_ID_3
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_local_icv_id3_p0
    Private write_LOCAL_ICV_ID_3_value
    Private read_LOCAL_ICV_ID_3_value
    Private flag_LOCAL_ICV_ID_3

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

    Property Get get_LOCAL_ICV_ID_3
        get_LOCAL_ICV_ID_3 = read_LOCAL_ICV_ID_3_value
    End Property

    Property Let set_LOCAL_ICV_ID_3(aData)
        write_LOCAL_ICV_ID_3_value = aData
        flag_LOCAL_ICV_ID_3        = &H1
    End Property

    Property Get read_LOCAL_ICV_ID_3
        read
        read_LOCAL_ICV_ID_3 = read_LOCAL_ICV_ID_3_value
    End Property

    Property Let write_LOCAL_ICV_ID_3(aData)
        set_LOCAL_ICV_ID_3 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_3_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_3_mask = mask then
                read_LOCAL_ICV_ID_3_value = data_low
            else
                read_LOCAL_ICV_ID_3_value = (data_low - H8000_0000) and LOCAL_ICV_ID_3_mask
            end If
        else
            read_LOCAL_ICV_ID_3_value = data_low and LOCAL_ICV_ID_3_mask
        end If

    End Sub

    Sub write
        If flag_LOCAL_ICV_ID_3 = &H0 Then read
        If flag_LOCAL_ICV_ID_3 = &H0 Then write_LOCAL_ICV_ID_3_value = get_LOCAL_ICV_ID_3

        regValue = leftShift((write_LOCAL_ICV_ID_3_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_3_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_3_mask = mask then
                read_LOCAL_ICV_ID_3_value = data_low
            else
                read_LOCAL_ICV_ID_3_value = (data_low - H8000_0000) and LOCAL_ICV_ID_3_mask
            end If
        else
            read_LOCAL_ICV_ID_3_value = data_low and LOCAL_ICV_ID_3_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LOCAL_ICV_ID_3_value = &H0
        flag_LOCAL_ICV_ID_3        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_local_icv_id3_p1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LOCAL_ICV_ID_3                             [15:0]           get_LOCAL_ICV_ID_3
''                                                             set_LOCAL_ICV_ID_3
''                                                             read_LOCAL_ICV_ID_3
''                                                             write_LOCAL_ICV_ID_3
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_local_icv_id3_p1
    Private write_LOCAL_ICV_ID_3_value
    Private read_LOCAL_ICV_ID_3_value
    Private flag_LOCAL_ICV_ID_3

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H52
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_LOCAL_ICV_ID_3
        get_LOCAL_ICV_ID_3 = read_LOCAL_ICV_ID_3_value
    End Property

    Property Let set_LOCAL_ICV_ID_3(aData)
        write_LOCAL_ICV_ID_3_value = aData
        flag_LOCAL_ICV_ID_3        = &H1
    End Property

    Property Get read_LOCAL_ICV_ID_3
        read
        read_LOCAL_ICV_ID_3 = read_LOCAL_ICV_ID_3_value
    End Property

    Property Let write_LOCAL_ICV_ID_3(aData)
        set_LOCAL_ICV_ID_3 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_3_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_3_mask = mask then
                read_LOCAL_ICV_ID_3_value = data_low
            else
                read_LOCAL_ICV_ID_3_value = (data_low - H8000_0000) and LOCAL_ICV_ID_3_mask
            end If
        else
            read_LOCAL_ICV_ID_3_value = data_low and LOCAL_ICV_ID_3_mask
        end If

    End Sub

    Sub write
        If flag_LOCAL_ICV_ID_3 = &H0 Then read
        If flag_LOCAL_ICV_ID_3 = &H0 Then write_LOCAL_ICV_ID_3_value = get_LOCAL_ICV_ID_3

        regValue = leftShift((write_LOCAL_ICV_ID_3_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_3_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_3_mask = mask then
                read_LOCAL_ICV_ID_3_value = data_low
            else
                read_LOCAL_ICV_ID_3_value = (data_low - H8000_0000) and LOCAL_ICV_ID_3_mask
            end If
        else
            read_LOCAL_ICV_ID_3_value = data_low and LOCAL_ICV_ID_3_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LOCAL_ICV_ID_3_value = &H0
        flag_LOCAL_ICV_ID_3        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_local_icv_id3_p2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LOCAL_ICV_ID_3                             [15:0]           get_LOCAL_ICV_ID_3
''                                                             set_LOCAL_ICV_ID_3
''                                                             read_LOCAL_ICV_ID_3
''                                                             write_LOCAL_ICV_ID_3
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_local_icv_id3_p2
    Private write_LOCAL_ICV_ID_3_value
    Private read_LOCAL_ICV_ID_3_value
    Private flag_LOCAL_ICV_ID_3

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

    Property Get get_LOCAL_ICV_ID_3
        get_LOCAL_ICV_ID_3 = read_LOCAL_ICV_ID_3_value
    End Property

    Property Let set_LOCAL_ICV_ID_3(aData)
        write_LOCAL_ICV_ID_3_value = aData
        flag_LOCAL_ICV_ID_3        = &H1
    End Property

    Property Get read_LOCAL_ICV_ID_3
        read
        read_LOCAL_ICV_ID_3 = read_LOCAL_ICV_ID_3_value
    End Property

    Property Let write_LOCAL_ICV_ID_3(aData)
        set_LOCAL_ICV_ID_3 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_3_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_3_mask = mask then
                read_LOCAL_ICV_ID_3_value = data_low
            else
                read_LOCAL_ICV_ID_3_value = (data_low - H8000_0000) and LOCAL_ICV_ID_3_mask
            end If
        else
            read_LOCAL_ICV_ID_3_value = data_low and LOCAL_ICV_ID_3_mask
        end If

    End Sub

    Sub write
        If flag_LOCAL_ICV_ID_3 = &H0 Then read
        If flag_LOCAL_ICV_ID_3 = &H0 Then write_LOCAL_ICV_ID_3_value = get_LOCAL_ICV_ID_3

        regValue = leftShift((write_LOCAL_ICV_ID_3_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_3_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_3_mask = mask then
                read_LOCAL_ICV_ID_3_value = data_low
            else
                read_LOCAL_ICV_ID_3_value = (data_low - H8000_0000) and LOCAL_ICV_ID_3_mask
            end If
        else
            read_LOCAL_ICV_ID_3_value = data_low and LOCAL_ICV_ID_3_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LOCAL_ICV_ID_3_value = &H0
        flag_LOCAL_ICV_ID_3        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_local_icv_id3_p3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LOCAL_ICV_ID_3                             [15:0]           get_LOCAL_ICV_ID_3
''                                                             set_LOCAL_ICV_ID_3
''                                                             read_LOCAL_ICV_ID_3
''                                                             write_LOCAL_ICV_ID_3
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_local_icv_id3_p3
    Private write_LOCAL_ICV_ID_3_value
    Private read_LOCAL_ICV_ID_3_value
    Private flag_LOCAL_ICV_ID_3

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H56
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_LOCAL_ICV_ID_3
        get_LOCAL_ICV_ID_3 = read_LOCAL_ICV_ID_3_value
    End Property

    Property Let set_LOCAL_ICV_ID_3(aData)
        write_LOCAL_ICV_ID_3_value = aData
        flag_LOCAL_ICV_ID_3        = &H1
    End Property

    Property Get read_LOCAL_ICV_ID_3
        read
        read_LOCAL_ICV_ID_3 = read_LOCAL_ICV_ID_3_value
    End Property

    Property Let write_LOCAL_ICV_ID_3(aData)
        set_LOCAL_ICV_ID_3 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_3_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_3_mask = mask then
                read_LOCAL_ICV_ID_3_value = data_low
            else
                read_LOCAL_ICV_ID_3_value = (data_low - H8000_0000) and LOCAL_ICV_ID_3_mask
            end If
        else
            read_LOCAL_ICV_ID_3_value = data_low and LOCAL_ICV_ID_3_mask
        end If

    End Sub

    Sub write
        If flag_LOCAL_ICV_ID_3 = &H0 Then read
        If flag_LOCAL_ICV_ID_3 = &H0 Then write_LOCAL_ICV_ID_3_value = get_LOCAL_ICV_ID_3

        regValue = leftShift((write_LOCAL_ICV_ID_3_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_3_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_3_mask = mask then
                read_LOCAL_ICV_ID_3_value = data_low
            else
                read_LOCAL_ICV_ID_3_value = (data_low - H8000_0000) and LOCAL_ICV_ID_3_mask
            end If
        else
            read_LOCAL_ICV_ID_3_value = data_low and LOCAL_ICV_ID_3_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LOCAL_ICV_ID_3_value = &H0
        flag_LOCAL_ICV_ID_3        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_local_icv_id3_p4
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LOCAL_ICV_ID_3                             [15:0]           get_LOCAL_ICV_ID_3
''                                                             set_LOCAL_ICV_ID_3
''                                                             read_LOCAL_ICV_ID_3
''                                                             write_LOCAL_ICV_ID_3
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_local_icv_id3_p4
    Private write_LOCAL_ICV_ID_3_value
    Private read_LOCAL_ICV_ID_3_value
    Private flag_LOCAL_ICV_ID_3

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

    Property Get get_LOCAL_ICV_ID_3
        get_LOCAL_ICV_ID_3 = read_LOCAL_ICV_ID_3_value
    End Property

    Property Let set_LOCAL_ICV_ID_3(aData)
        write_LOCAL_ICV_ID_3_value = aData
        flag_LOCAL_ICV_ID_3        = &H1
    End Property

    Property Get read_LOCAL_ICV_ID_3
        read
        read_LOCAL_ICV_ID_3 = read_LOCAL_ICV_ID_3_value
    End Property

    Property Let write_LOCAL_ICV_ID_3(aData)
        set_LOCAL_ICV_ID_3 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_3_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_3_mask = mask then
                read_LOCAL_ICV_ID_3_value = data_low
            else
                read_LOCAL_ICV_ID_3_value = (data_low - H8000_0000) and LOCAL_ICV_ID_3_mask
            end If
        else
            read_LOCAL_ICV_ID_3_value = data_low and LOCAL_ICV_ID_3_mask
        end If

    End Sub

    Sub write
        If flag_LOCAL_ICV_ID_3 = &H0 Then read
        If flag_LOCAL_ICV_ID_3 = &H0 Then write_LOCAL_ICV_ID_3_value = get_LOCAL_ICV_ID_3

        regValue = leftShift((write_LOCAL_ICV_ID_3_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_3_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_3_mask = mask then
                read_LOCAL_ICV_ID_3_value = data_low
            else
                read_LOCAL_ICV_ID_3_value = (data_low - H8000_0000) and LOCAL_ICV_ID_3_mask
            end If
        else
            read_LOCAL_ICV_ID_3_value = data_low and LOCAL_ICV_ID_3_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LOCAL_ICV_ID_3_value = &H0
        flag_LOCAL_ICV_ID_3        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_local_icv_id3_p5
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LOCAL_ICV_ID_3                             [15:0]           get_LOCAL_ICV_ID_3
''                                                             set_LOCAL_ICV_ID_3
''                                                             read_LOCAL_ICV_ID_3
''                                                             write_LOCAL_ICV_ID_3
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_local_icv_id3_p5
    Private write_LOCAL_ICV_ID_3_value
    Private read_LOCAL_ICV_ID_3_value
    Private flag_LOCAL_ICV_ID_3

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H5a
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_LOCAL_ICV_ID_3
        get_LOCAL_ICV_ID_3 = read_LOCAL_ICV_ID_3_value
    End Property

    Property Let set_LOCAL_ICV_ID_3(aData)
        write_LOCAL_ICV_ID_3_value = aData
        flag_LOCAL_ICV_ID_3        = &H1
    End Property

    Property Get read_LOCAL_ICV_ID_3
        read
        read_LOCAL_ICV_ID_3 = read_LOCAL_ICV_ID_3_value
    End Property

    Property Let write_LOCAL_ICV_ID_3(aData)
        set_LOCAL_ICV_ID_3 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_3_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_3_mask = mask then
                read_LOCAL_ICV_ID_3_value = data_low
            else
                read_LOCAL_ICV_ID_3_value = (data_low - H8000_0000) and LOCAL_ICV_ID_3_mask
            end If
        else
            read_LOCAL_ICV_ID_3_value = data_low and LOCAL_ICV_ID_3_mask
        end If

    End Sub

    Sub write
        If flag_LOCAL_ICV_ID_3 = &H0 Then read
        If flag_LOCAL_ICV_ID_3 = &H0 Then write_LOCAL_ICV_ID_3_value = get_LOCAL_ICV_ID_3

        regValue = leftShift((write_LOCAL_ICV_ID_3_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_3_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_3_mask = mask then
                read_LOCAL_ICV_ID_3_value = data_low
            else
                read_LOCAL_ICV_ID_3_value = (data_low - H8000_0000) and LOCAL_ICV_ID_3_mask
            end If
        else
            read_LOCAL_ICV_ID_3_value = data_low and LOCAL_ICV_ID_3_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LOCAL_ICV_ID_3_value = &H0
        flag_LOCAL_ICV_ID_3        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_remote_icv_id0_p0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' REMOTE_ICV_ID_0                            [15:0]           get_REMOTE_ICV_ID_0
''                                                             set_REMOTE_ICV_ID_0
''                                                             read_REMOTE_ICV_ID_0
''                                                             write_REMOTE_ICV_ID_0
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_remote_icv_id0_p0
    Private write_REMOTE_ICV_ID_0_value
    Private read_REMOTE_ICV_ID_0_value
    Private flag_REMOTE_ICV_ID_0

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

    Property Get get_REMOTE_ICV_ID_0
        get_REMOTE_ICV_ID_0 = read_REMOTE_ICV_ID_0_value
    End Property

    Property Let set_REMOTE_ICV_ID_0(aData)
        write_REMOTE_ICV_ID_0_value = aData
        flag_REMOTE_ICV_ID_0        = &H1
    End Property

    Property Get read_REMOTE_ICV_ID_0
        read
        read_REMOTE_ICV_ID_0 = read_REMOTE_ICV_ID_0_value
    End Property

    Property Let write_REMOTE_ICV_ID_0(aData)
        set_REMOTE_ICV_ID_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_0_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_0_mask = mask then
                read_REMOTE_ICV_ID_0_value = data_low
            else
                read_REMOTE_ICV_ID_0_value = (data_low - H8000_0000) and REMOTE_ICV_ID_0_mask
            end If
        else
            read_REMOTE_ICV_ID_0_value = data_low and REMOTE_ICV_ID_0_mask
        end If

    End Sub

    Sub write
        If flag_REMOTE_ICV_ID_0 = &H0 Then read
        If flag_REMOTE_ICV_ID_0 = &H0 Then write_REMOTE_ICV_ID_0_value = get_REMOTE_ICV_ID_0

        regValue = leftShift((write_REMOTE_ICV_ID_0_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_0_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_0_mask = mask then
                read_REMOTE_ICV_ID_0_value = data_low
            else
                read_REMOTE_ICV_ID_0_value = (data_low - H8000_0000) and REMOTE_ICV_ID_0_mask
            end If
        else
            read_REMOTE_ICV_ID_0_value = data_low and REMOTE_ICV_ID_0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_REMOTE_ICV_ID_0_value = &H0
        flag_REMOTE_ICV_ID_0        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_remote_icv_id0_p1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' REMOTE_ICV_ID_0                            [15:0]           get_REMOTE_ICV_ID_0
''                                                             set_REMOTE_ICV_ID_0
''                                                             read_REMOTE_ICV_ID_0
''                                                             write_REMOTE_ICV_ID_0
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_remote_icv_id0_p1
    Private write_REMOTE_ICV_ID_0_value
    Private read_REMOTE_ICV_ID_0_value
    Private flag_REMOTE_ICV_ID_0

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H62
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_REMOTE_ICV_ID_0
        get_REMOTE_ICV_ID_0 = read_REMOTE_ICV_ID_0_value
    End Property

    Property Let set_REMOTE_ICV_ID_0(aData)
        write_REMOTE_ICV_ID_0_value = aData
        flag_REMOTE_ICV_ID_0        = &H1
    End Property

    Property Get read_REMOTE_ICV_ID_0
        read
        read_REMOTE_ICV_ID_0 = read_REMOTE_ICV_ID_0_value
    End Property

    Property Let write_REMOTE_ICV_ID_0(aData)
        set_REMOTE_ICV_ID_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_0_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_0_mask = mask then
                read_REMOTE_ICV_ID_0_value = data_low
            else
                read_REMOTE_ICV_ID_0_value = (data_low - H8000_0000) and REMOTE_ICV_ID_0_mask
            end If
        else
            read_REMOTE_ICV_ID_0_value = data_low and REMOTE_ICV_ID_0_mask
        end If

    End Sub

    Sub write
        If flag_REMOTE_ICV_ID_0 = &H0 Then read
        If flag_REMOTE_ICV_ID_0 = &H0 Then write_REMOTE_ICV_ID_0_value = get_REMOTE_ICV_ID_0

        regValue = leftShift((write_REMOTE_ICV_ID_0_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_0_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_0_mask = mask then
                read_REMOTE_ICV_ID_0_value = data_low
            else
                read_REMOTE_ICV_ID_0_value = (data_low - H8000_0000) and REMOTE_ICV_ID_0_mask
            end If
        else
            read_REMOTE_ICV_ID_0_value = data_low and REMOTE_ICV_ID_0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_REMOTE_ICV_ID_0_value = &H0
        flag_REMOTE_ICV_ID_0        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_remote_icv_id0_p2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' REMOTE_ICV_ID_0                            [15:0]           get_REMOTE_ICV_ID_0
''                                                             set_REMOTE_ICV_ID_0
''                                                             read_REMOTE_ICV_ID_0
''                                                             write_REMOTE_ICV_ID_0
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_remote_icv_id0_p2
    Private write_REMOTE_ICV_ID_0_value
    Private read_REMOTE_ICV_ID_0_value
    Private flag_REMOTE_ICV_ID_0

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

    Property Get get_REMOTE_ICV_ID_0
        get_REMOTE_ICV_ID_0 = read_REMOTE_ICV_ID_0_value
    End Property

    Property Let set_REMOTE_ICV_ID_0(aData)
        write_REMOTE_ICV_ID_0_value = aData
        flag_REMOTE_ICV_ID_0        = &H1
    End Property

    Property Get read_REMOTE_ICV_ID_0
        read
        read_REMOTE_ICV_ID_0 = read_REMOTE_ICV_ID_0_value
    End Property

    Property Let write_REMOTE_ICV_ID_0(aData)
        set_REMOTE_ICV_ID_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_0_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_0_mask = mask then
                read_REMOTE_ICV_ID_0_value = data_low
            else
                read_REMOTE_ICV_ID_0_value = (data_low - H8000_0000) and REMOTE_ICV_ID_0_mask
            end If
        else
            read_REMOTE_ICV_ID_0_value = data_low and REMOTE_ICV_ID_0_mask
        end If

    End Sub

    Sub write
        If flag_REMOTE_ICV_ID_0 = &H0 Then read
        If flag_REMOTE_ICV_ID_0 = &H0 Then write_REMOTE_ICV_ID_0_value = get_REMOTE_ICV_ID_0

        regValue = leftShift((write_REMOTE_ICV_ID_0_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_0_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_0_mask = mask then
                read_REMOTE_ICV_ID_0_value = data_low
            else
                read_REMOTE_ICV_ID_0_value = (data_low - H8000_0000) and REMOTE_ICV_ID_0_mask
            end If
        else
            read_REMOTE_ICV_ID_0_value = data_low and REMOTE_ICV_ID_0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_REMOTE_ICV_ID_0_value = &H0
        flag_REMOTE_ICV_ID_0        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_remote_icv_id0_p3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' REMOTE_ICV_ID_0                            [15:0]           get_REMOTE_ICV_ID_0
''                                                             set_REMOTE_ICV_ID_0
''                                                             read_REMOTE_ICV_ID_0
''                                                             write_REMOTE_ICV_ID_0
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_remote_icv_id0_p3
    Private write_REMOTE_ICV_ID_0_value
    Private read_REMOTE_ICV_ID_0_value
    Private flag_REMOTE_ICV_ID_0

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H66
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_REMOTE_ICV_ID_0
        get_REMOTE_ICV_ID_0 = read_REMOTE_ICV_ID_0_value
    End Property

    Property Let set_REMOTE_ICV_ID_0(aData)
        write_REMOTE_ICV_ID_0_value = aData
        flag_REMOTE_ICV_ID_0        = &H1
    End Property

    Property Get read_REMOTE_ICV_ID_0
        read
        read_REMOTE_ICV_ID_0 = read_REMOTE_ICV_ID_0_value
    End Property

    Property Let write_REMOTE_ICV_ID_0(aData)
        set_REMOTE_ICV_ID_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_0_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_0_mask = mask then
                read_REMOTE_ICV_ID_0_value = data_low
            else
                read_REMOTE_ICV_ID_0_value = (data_low - H8000_0000) and REMOTE_ICV_ID_0_mask
            end If
        else
            read_REMOTE_ICV_ID_0_value = data_low and REMOTE_ICV_ID_0_mask
        end If

    End Sub

    Sub write
        If flag_REMOTE_ICV_ID_0 = &H0 Then read
        If flag_REMOTE_ICV_ID_0 = &H0 Then write_REMOTE_ICV_ID_0_value = get_REMOTE_ICV_ID_0

        regValue = leftShift((write_REMOTE_ICV_ID_0_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_0_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_0_mask = mask then
                read_REMOTE_ICV_ID_0_value = data_low
            else
                read_REMOTE_ICV_ID_0_value = (data_low - H8000_0000) and REMOTE_ICV_ID_0_mask
            end If
        else
            read_REMOTE_ICV_ID_0_value = data_low and REMOTE_ICV_ID_0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_REMOTE_ICV_ID_0_value = &H0
        flag_REMOTE_ICV_ID_0        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_remote_icv_id0_p4
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' REMOTE_ICV_ID_0                            [15:0]           get_REMOTE_ICV_ID_0
''                                                             set_REMOTE_ICV_ID_0
''                                                             read_REMOTE_ICV_ID_0
''                                                             write_REMOTE_ICV_ID_0
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_remote_icv_id0_p4
    Private write_REMOTE_ICV_ID_0_value
    Private read_REMOTE_ICV_ID_0_value
    Private flag_REMOTE_ICV_ID_0

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

    Property Get get_REMOTE_ICV_ID_0
        get_REMOTE_ICV_ID_0 = read_REMOTE_ICV_ID_0_value
    End Property

    Property Let set_REMOTE_ICV_ID_0(aData)
        write_REMOTE_ICV_ID_0_value = aData
        flag_REMOTE_ICV_ID_0        = &H1
    End Property

    Property Get read_REMOTE_ICV_ID_0
        read
        read_REMOTE_ICV_ID_0 = read_REMOTE_ICV_ID_0_value
    End Property

    Property Let write_REMOTE_ICV_ID_0(aData)
        set_REMOTE_ICV_ID_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_0_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_0_mask = mask then
                read_REMOTE_ICV_ID_0_value = data_low
            else
                read_REMOTE_ICV_ID_0_value = (data_low - H8000_0000) and REMOTE_ICV_ID_0_mask
            end If
        else
            read_REMOTE_ICV_ID_0_value = data_low and REMOTE_ICV_ID_0_mask
        end If

    End Sub

    Sub write
        If flag_REMOTE_ICV_ID_0 = &H0 Then read
        If flag_REMOTE_ICV_ID_0 = &H0 Then write_REMOTE_ICV_ID_0_value = get_REMOTE_ICV_ID_0

        regValue = leftShift((write_REMOTE_ICV_ID_0_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_0_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_0_mask = mask then
                read_REMOTE_ICV_ID_0_value = data_low
            else
                read_REMOTE_ICV_ID_0_value = (data_low - H8000_0000) and REMOTE_ICV_ID_0_mask
            end If
        else
            read_REMOTE_ICV_ID_0_value = data_low and REMOTE_ICV_ID_0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_REMOTE_ICV_ID_0_value = &H0
        flag_REMOTE_ICV_ID_0        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_remote_icv_id0_p5
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' REMOTE_ICV_ID_0                            [15:0]           get_REMOTE_ICV_ID_0
''                                                             set_REMOTE_ICV_ID_0
''                                                             read_REMOTE_ICV_ID_0
''                                                             write_REMOTE_ICV_ID_0
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_remote_icv_id0_p5
    Private write_REMOTE_ICV_ID_0_value
    Private read_REMOTE_ICV_ID_0_value
    Private flag_REMOTE_ICV_ID_0

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H6a
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_REMOTE_ICV_ID_0
        get_REMOTE_ICV_ID_0 = read_REMOTE_ICV_ID_0_value
    End Property

    Property Let set_REMOTE_ICV_ID_0(aData)
        write_REMOTE_ICV_ID_0_value = aData
        flag_REMOTE_ICV_ID_0        = &H1
    End Property

    Property Get read_REMOTE_ICV_ID_0
        read
        read_REMOTE_ICV_ID_0 = read_REMOTE_ICV_ID_0_value
    End Property

    Property Let write_REMOTE_ICV_ID_0(aData)
        set_REMOTE_ICV_ID_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_0_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_0_mask = mask then
                read_REMOTE_ICV_ID_0_value = data_low
            else
                read_REMOTE_ICV_ID_0_value = (data_low - H8000_0000) and REMOTE_ICV_ID_0_mask
            end If
        else
            read_REMOTE_ICV_ID_0_value = data_low and REMOTE_ICV_ID_0_mask
        end If

    End Sub

    Sub write
        If flag_REMOTE_ICV_ID_0 = &H0 Then read
        If flag_REMOTE_ICV_ID_0 = &H0 Then write_REMOTE_ICV_ID_0_value = get_REMOTE_ICV_ID_0

        regValue = leftShift((write_REMOTE_ICV_ID_0_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_0_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_0_mask = mask then
                read_REMOTE_ICV_ID_0_value = data_low
            else
                read_REMOTE_ICV_ID_0_value = (data_low - H8000_0000) and REMOTE_ICV_ID_0_mask
            end If
        else
            read_REMOTE_ICV_ID_0_value = data_low and REMOTE_ICV_ID_0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_REMOTE_ICV_ID_0_value = &H0
        flag_REMOTE_ICV_ID_0        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_remote_icv_id1_p0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' REMOTE_ICV_ID_1                            [15:0]           get_REMOTE_ICV_ID_1
''                                                             set_REMOTE_ICV_ID_1
''                                                             read_REMOTE_ICV_ID_1
''                                                             write_REMOTE_ICV_ID_1
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_remote_icv_id1_p0
    Private write_REMOTE_ICV_ID_1_value
    Private read_REMOTE_ICV_ID_1_value
    Private flag_REMOTE_ICV_ID_1

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

    Property Get get_REMOTE_ICV_ID_1
        get_REMOTE_ICV_ID_1 = read_REMOTE_ICV_ID_1_value
    End Property

    Property Let set_REMOTE_ICV_ID_1(aData)
        write_REMOTE_ICV_ID_1_value = aData
        flag_REMOTE_ICV_ID_1        = &H1
    End Property

    Property Get read_REMOTE_ICV_ID_1
        read
        read_REMOTE_ICV_ID_1 = read_REMOTE_ICV_ID_1_value
    End Property

    Property Let write_REMOTE_ICV_ID_1(aData)
        set_REMOTE_ICV_ID_1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_1_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_1_mask = mask then
                read_REMOTE_ICV_ID_1_value = data_low
            else
                read_REMOTE_ICV_ID_1_value = (data_low - H8000_0000) and REMOTE_ICV_ID_1_mask
            end If
        else
            read_REMOTE_ICV_ID_1_value = data_low and REMOTE_ICV_ID_1_mask
        end If

    End Sub

    Sub write
        If flag_REMOTE_ICV_ID_1 = &H0 Then read
        If flag_REMOTE_ICV_ID_1 = &H0 Then write_REMOTE_ICV_ID_1_value = get_REMOTE_ICV_ID_1

        regValue = leftShift((write_REMOTE_ICV_ID_1_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_1_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_1_mask = mask then
                read_REMOTE_ICV_ID_1_value = data_low
            else
                read_REMOTE_ICV_ID_1_value = (data_low - H8000_0000) and REMOTE_ICV_ID_1_mask
            end If
        else
            read_REMOTE_ICV_ID_1_value = data_low and REMOTE_ICV_ID_1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_REMOTE_ICV_ID_1_value = &H0
        flag_REMOTE_ICV_ID_1        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_remote_icv_id1_p1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' REMOTE_ICV_ID_1                            [15:0]           get_REMOTE_ICV_ID_1
''                                                             set_REMOTE_ICV_ID_1
''                                                             read_REMOTE_ICV_ID_1
''                                                             write_REMOTE_ICV_ID_1
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_remote_icv_id1_p1
    Private write_REMOTE_ICV_ID_1_value
    Private read_REMOTE_ICV_ID_1_value
    Private flag_REMOTE_ICV_ID_1

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H72
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_REMOTE_ICV_ID_1
        get_REMOTE_ICV_ID_1 = read_REMOTE_ICV_ID_1_value
    End Property

    Property Let set_REMOTE_ICV_ID_1(aData)
        write_REMOTE_ICV_ID_1_value = aData
        flag_REMOTE_ICV_ID_1        = &H1
    End Property

    Property Get read_REMOTE_ICV_ID_1
        read
        read_REMOTE_ICV_ID_1 = read_REMOTE_ICV_ID_1_value
    End Property

    Property Let write_REMOTE_ICV_ID_1(aData)
        set_REMOTE_ICV_ID_1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_1_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_1_mask = mask then
                read_REMOTE_ICV_ID_1_value = data_low
            else
                read_REMOTE_ICV_ID_1_value = (data_low - H8000_0000) and REMOTE_ICV_ID_1_mask
            end If
        else
            read_REMOTE_ICV_ID_1_value = data_low and REMOTE_ICV_ID_1_mask
        end If

    End Sub

    Sub write
        If flag_REMOTE_ICV_ID_1 = &H0 Then read
        If flag_REMOTE_ICV_ID_1 = &H0 Then write_REMOTE_ICV_ID_1_value = get_REMOTE_ICV_ID_1

        regValue = leftShift((write_REMOTE_ICV_ID_1_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_1_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_1_mask = mask then
                read_REMOTE_ICV_ID_1_value = data_low
            else
                read_REMOTE_ICV_ID_1_value = (data_low - H8000_0000) and REMOTE_ICV_ID_1_mask
            end If
        else
            read_REMOTE_ICV_ID_1_value = data_low and REMOTE_ICV_ID_1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_REMOTE_ICV_ID_1_value = &H0
        flag_REMOTE_ICV_ID_1        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_remote_icv_id1_p2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' REMOTE_ICV_ID_1                            [15:0]           get_REMOTE_ICV_ID_1
''                                                             set_REMOTE_ICV_ID_1
''                                                             read_REMOTE_ICV_ID_1
''                                                             write_REMOTE_ICV_ID_1
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_remote_icv_id1_p2
    Private write_REMOTE_ICV_ID_1_value
    Private read_REMOTE_ICV_ID_1_value
    Private flag_REMOTE_ICV_ID_1

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

    Property Get get_REMOTE_ICV_ID_1
        get_REMOTE_ICV_ID_1 = read_REMOTE_ICV_ID_1_value
    End Property

    Property Let set_REMOTE_ICV_ID_1(aData)
        write_REMOTE_ICV_ID_1_value = aData
        flag_REMOTE_ICV_ID_1        = &H1
    End Property

    Property Get read_REMOTE_ICV_ID_1
        read
        read_REMOTE_ICV_ID_1 = read_REMOTE_ICV_ID_1_value
    End Property

    Property Let write_REMOTE_ICV_ID_1(aData)
        set_REMOTE_ICV_ID_1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_1_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_1_mask = mask then
                read_REMOTE_ICV_ID_1_value = data_low
            else
                read_REMOTE_ICV_ID_1_value = (data_low - H8000_0000) and REMOTE_ICV_ID_1_mask
            end If
        else
            read_REMOTE_ICV_ID_1_value = data_low and REMOTE_ICV_ID_1_mask
        end If

    End Sub

    Sub write
        If flag_REMOTE_ICV_ID_1 = &H0 Then read
        If flag_REMOTE_ICV_ID_1 = &H0 Then write_REMOTE_ICV_ID_1_value = get_REMOTE_ICV_ID_1

        regValue = leftShift((write_REMOTE_ICV_ID_1_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_1_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_1_mask = mask then
                read_REMOTE_ICV_ID_1_value = data_low
            else
                read_REMOTE_ICV_ID_1_value = (data_low - H8000_0000) and REMOTE_ICV_ID_1_mask
            end If
        else
            read_REMOTE_ICV_ID_1_value = data_low and REMOTE_ICV_ID_1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_REMOTE_ICV_ID_1_value = &H0
        flag_REMOTE_ICV_ID_1        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_remote_icv_id1_p3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' REMOTE_ICV_ID_1                            [15:0]           get_REMOTE_ICV_ID_1
''                                                             set_REMOTE_ICV_ID_1
''                                                             read_REMOTE_ICV_ID_1
''                                                             write_REMOTE_ICV_ID_1
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_remote_icv_id1_p3
    Private write_REMOTE_ICV_ID_1_value
    Private read_REMOTE_ICV_ID_1_value
    Private flag_REMOTE_ICV_ID_1

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H76
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_REMOTE_ICV_ID_1
        get_REMOTE_ICV_ID_1 = read_REMOTE_ICV_ID_1_value
    End Property

    Property Let set_REMOTE_ICV_ID_1(aData)
        write_REMOTE_ICV_ID_1_value = aData
        flag_REMOTE_ICV_ID_1        = &H1
    End Property

    Property Get read_REMOTE_ICV_ID_1
        read
        read_REMOTE_ICV_ID_1 = read_REMOTE_ICV_ID_1_value
    End Property

    Property Let write_REMOTE_ICV_ID_1(aData)
        set_REMOTE_ICV_ID_1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_1_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_1_mask = mask then
                read_REMOTE_ICV_ID_1_value = data_low
            else
                read_REMOTE_ICV_ID_1_value = (data_low - H8000_0000) and REMOTE_ICV_ID_1_mask
            end If
        else
            read_REMOTE_ICV_ID_1_value = data_low and REMOTE_ICV_ID_1_mask
        end If

    End Sub

    Sub write
        If flag_REMOTE_ICV_ID_1 = &H0 Then read
        If flag_REMOTE_ICV_ID_1 = &H0 Then write_REMOTE_ICV_ID_1_value = get_REMOTE_ICV_ID_1

        regValue = leftShift((write_REMOTE_ICV_ID_1_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_1_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_1_mask = mask then
                read_REMOTE_ICV_ID_1_value = data_low
            else
                read_REMOTE_ICV_ID_1_value = (data_low - H8000_0000) and REMOTE_ICV_ID_1_mask
            end If
        else
            read_REMOTE_ICV_ID_1_value = data_low and REMOTE_ICV_ID_1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_REMOTE_ICV_ID_1_value = &H0
        flag_REMOTE_ICV_ID_1        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_remote_icv_id1_p4
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' REMOTE_ICV_ID_1                            [15:0]           get_REMOTE_ICV_ID_1
''                                                             set_REMOTE_ICV_ID_1
''                                                             read_REMOTE_ICV_ID_1
''                                                             write_REMOTE_ICV_ID_1
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_remote_icv_id1_p4
    Private write_REMOTE_ICV_ID_1_value
    Private read_REMOTE_ICV_ID_1_value
    Private flag_REMOTE_ICV_ID_1

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

    Property Get get_REMOTE_ICV_ID_1
        get_REMOTE_ICV_ID_1 = read_REMOTE_ICV_ID_1_value
    End Property

    Property Let set_REMOTE_ICV_ID_1(aData)
        write_REMOTE_ICV_ID_1_value = aData
        flag_REMOTE_ICV_ID_1        = &H1
    End Property

    Property Get read_REMOTE_ICV_ID_1
        read
        read_REMOTE_ICV_ID_1 = read_REMOTE_ICV_ID_1_value
    End Property

    Property Let write_REMOTE_ICV_ID_1(aData)
        set_REMOTE_ICV_ID_1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_1_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_1_mask = mask then
                read_REMOTE_ICV_ID_1_value = data_low
            else
                read_REMOTE_ICV_ID_1_value = (data_low - H8000_0000) and REMOTE_ICV_ID_1_mask
            end If
        else
            read_REMOTE_ICV_ID_1_value = data_low and REMOTE_ICV_ID_1_mask
        end If

    End Sub

    Sub write
        If flag_REMOTE_ICV_ID_1 = &H0 Then read
        If flag_REMOTE_ICV_ID_1 = &H0 Then write_REMOTE_ICV_ID_1_value = get_REMOTE_ICV_ID_1

        regValue = leftShift((write_REMOTE_ICV_ID_1_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_1_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_1_mask = mask then
                read_REMOTE_ICV_ID_1_value = data_low
            else
                read_REMOTE_ICV_ID_1_value = (data_low - H8000_0000) and REMOTE_ICV_ID_1_mask
            end If
        else
            read_REMOTE_ICV_ID_1_value = data_low and REMOTE_ICV_ID_1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_REMOTE_ICV_ID_1_value = &H0
        flag_REMOTE_ICV_ID_1        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_remote_icv_id1_p5
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' REMOTE_ICV_ID_1                            [15:0]           get_REMOTE_ICV_ID_1
''                                                             set_REMOTE_ICV_ID_1
''                                                             read_REMOTE_ICV_ID_1
''                                                             write_REMOTE_ICV_ID_1
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_remote_icv_id1_p5
    Private write_REMOTE_ICV_ID_1_value
    Private read_REMOTE_ICV_ID_1_value
    Private flag_REMOTE_ICV_ID_1

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H7a
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_REMOTE_ICV_ID_1
        get_REMOTE_ICV_ID_1 = read_REMOTE_ICV_ID_1_value
    End Property

    Property Let set_REMOTE_ICV_ID_1(aData)
        write_REMOTE_ICV_ID_1_value = aData
        flag_REMOTE_ICV_ID_1        = &H1
    End Property

    Property Get read_REMOTE_ICV_ID_1
        read
        read_REMOTE_ICV_ID_1 = read_REMOTE_ICV_ID_1_value
    End Property

    Property Let write_REMOTE_ICV_ID_1(aData)
        set_REMOTE_ICV_ID_1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_1_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_1_mask = mask then
                read_REMOTE_ICV_ID_1_value = data_low
            else
                read_REMOTE_ICV_ID_1_value = (data_low - H8000_0000) and REMOTE_ICV_ID_1_mask
            end If
        else
            read_REMOTE_ICV_ID_1_value = data_low and REMOTE_ICV_ID_1_mask
        end If

    End Sub

    Sub write
        If flag_REMOTE_ICV_ID_1 = &H0 Then read
        If flag_REMOTE_ICV_ID_1 = &H0 Then write_REMOTE_ICV_ID_1_value = get_REMOTE_ICV_ID_1

        regValue = leftShift((write_REMOTE_ICV_ID_1_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_1_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_1_mask = mask then
                read_REMOTE_ICV_ID_1_value = data_low
            else
                read_REMOTE_ICV_ID_1_value = (data_low - H8000_0000) and REMOTE_ICV_ID_1_mask
            end If
        else
            read_REMOTE_ICV_ID_1_value = data_low and REMOTE_ICV_ID_1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_REMOTE_ICV_ID_1_value = &H0
        flag_REMOTE_ICV_ID_1        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_remote_icv_id2_p0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' REMOTE_ICV_ID_2                            [15:0]           get_REMOTE_ICV_ID_2
''                                                             set_REMOTE_ICV_ID_2
''                                                             read_REMOTE_ICV_ID_2
''                                                             write_REMOTE_ICV_ID_2
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_remote_icv_id2_p0
    Private write_REMOTE_ICV_ID_2_value
    Private read_REMOTE_ICV_ID_2_value
    Private flag_REMOTE_ICV_ID_2

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

    Property Get get_REMOTE_ICV_ID_2
        get_REMOTE_ICV_ID_2 = read_REMOTE_ICV_ID_2_value
    End Property

    Property Let set_REMOTE_ICV_ID_2(aData)
        write_REMOTE_ICV_ID_2_value = aData
        flag_REMOTE_ICV_ID_2        = &H1
    End Property

    Property Get read_REMOTE_ICV_ID_2
        read
        read_REMOTE_ICV_ID_2 = read_REMOTE_ICV_ID_2_value
    End Property

    Property Let write_REMOTE_ICV_ID_2(aData)
        set_REMOTE_ICV_ID_2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_2_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_2_mask = mask then
                read_REMOTE_ICV_ID_2_value = data_low
            else
                read_REMOTE_ICV_ID_2_value = (data_low - H8000_0000) and REMOTE_ICV_ID_2_mask
            end If
        else
            read_REMOTE_ICV_ID_2_value = data_low and REMOTE_ICV_ID_2_mask
        end If

    End Sub

    Sub write
        If flag_REMOTE_ICV_ID_2 = &H0 Then read
        If flag_REMOTE_ICV_ID_2 = &H0 Then write_REMOTE_ICV_ID_2_value = get_REMOTE_ICV_ID_2

        regValue = leftShift((write_REMOTE_ICV_ID_2_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_2_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_2_mask = mask then
                read_REMOTE_ICV_ID_2_value = data_low
            else
                read_REMOTE_ICV_ID_2_value = (data_low - H8000_0000) and REMOTE_ICV_ID_2_mask
            end If
        else
            read_REMOTE_ICV_ID_2_value = data_low and REMOTE_ICV_ID_2_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_REMOTE_ICV_ID_2_value = &H0
        flag_REMOTE_ICV_ID_2        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_remote_icv_id2_p1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' REMOTE_ICV_ID_2                            [15:0]           get_REMOTE_ICV_ID_2
''                                                             set_REMOTE_ICV_ID_2
''                                                             read_REMOTE_ICV_ID_2
''                                                             write_REMOTE_ICV_ID_2
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_remote_icv_id2_p1
    Private write_REMOTE_ICV_ID_2_value
    Private read_REMOTE_ICV_ID_2_value
    Private flag_REMOTE_ICV_ID_2

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H82
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_REMOTE_ICV_ID_2
        get_REMOTE_ICV_ID_2 = read_REMOTE_ICV_ID_2_value
    End Property

    Property Let set_REMOTE_ICV_ID_2(aData)
        write_REMOTE_ICV_ID_2_value = aData
        flag_REMOTE_ICV_ID_2        = &H1
    End Property

    Property Get read_REMOTE_ICV_ID_2
        read
        read_REMOTE_ICV_ID_2 = read_REMOTE_ICV_ID_2_value
    End Property

    Property Let write_REMOTE_ICV_ID_2(aData)
        set_REMOTE_ICV_ID_2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_2_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_2_mask = mask then
                read_REMOTE_ICV_ID_2_value = data_low
            else
                read_REMOTE_ICV_ID_2_value = (data_low - H8000_0000) and REMOTE_ICV_ID_2_mask
            end If
        else
            read_REMOTE_ICV_ID_2_value = data_low and REMOTE_ICV_ID_2_mask
        end If

    End Sub

    Sub write
        If flag_REMOTE_ICV_ID_2 = &H0 Then read
        If flag_REMOTE_ICV_ID_2 = &H0 Then write_REMOTE_ICV_ID_2_value = get_REMOTE_ICV_ID_2

        regValue = leftShift((write_REMOTE_ICV_ID_2_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_2_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_2_mask = mask then
                read_REMOTE_ICV_ID_2_value = data_low
            else
                read_REMOTE_ICV_ID_2_value = (data_low - H8000_0000) and REMOTE_ICV_ID_2_mask
            end If
        else
            read_REMOTE_ICV_ID_2_value = data_low and REMOTE_ICV_ID_2_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_REMOTE_ICV_ID_2_value = &H0
        flag_REMOTE_ICV_ID_2        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_remote_icv_id2_p2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' REMOTE_ICV_ID_2                            [15:0]           get_REMOTE_ICV_ID_2
''                                                             set_REMOTE_ICV_ID_2
''                                                             read_REMOTE_ICV_ID_2
''                                                             write_REMOTE_ICV_ID_2
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_remote_icv_id2_p2
    Private write_REMOTE_ICV_ID_2_value
    Private read_REMOTE_ICV_ID_2_value
    Private flag_REMOTE_ICV_ID_2

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

    Property Get get_REMOTE_ICV_ID_2
        get_REMOTE_ICV_ID_2 = read_REMOTE_ICV_ID_2_value
    End Property

    Property Let set_REMOTE_ICV_ID_2(aData)
        write_REMOTE_ICV_ID_2_value = aData
        flag_REMOTE_ICV_ID_2        = &H1
    End Property

    Property Get read_REMOTE_ICV_ID_2
        read
        read_REMOTE_ICV_ID_2 = read_REMOTE_ICV_ID_2_value
    End Property

    Property Let write_REMOTE_ICV_ID_2(aData)
        set_REMOTE_ICV_ID_2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_2_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_2_mask = mask then
                read_REMOTE_ICV_ID_2_value = data_low
            else
                read_REMOTE_ICV_ID_2_value = (data_low - H8000_0000) and REMOTE_ICV_ID_2_mask
            end If
        else
            read_REMOTE_ICV_ID_2_value = data_low and REMOTE_ICV_ID_2_mask
        end If

    End Sub

    Sub write
        If flag_REMOTE_ICV_ID_2 = &H0 Then read
        If flag_REMOTE_ICV_ID_2 = &H0 Then write_REMOTE_ICV_ID_2_value = get_REMOTE_ICV_ID_2

        regValue = leftShift((write_REMOTE_ICV_ID_2_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_2_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_2_mask = mask then
                read_REMOTE_ICV_ID_2_value = data_low
            else
                read_REMOTE_ICV_ID_2_value = (data_low - H8000_0000) and REMOTE_ICV_ID_2_mask
            end If
        else
            read_REMOTE_ICV_ID_2_value = data_low and REMOTE_ICV_ID_2_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_REMOTE_ICV_ID_2_value = &H0
        flag_REMOTE_ICV_ID_2        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_remote_icv_id2_p3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' REMOTE_ICV_ID_2                            [15:0]           get_REMOTE_ICV_ID_2
''                                                             set_REMOTE_ICV_ID_2
''                                                             read_REMOTE_ICV_ID_2
''                                                             write_REMOTE_ICV_ID_2
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_remote_icv_id2_p3
    Private write_REMOTE_ICV_ID_2_value
    Private read_REMOTE_ICV_ID_2_value
    Private flag_REMOTE_ICV_ID_2

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H86
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_REMOTE_ICV_ID_2
        get_REMOTE_ICV_ID_2 = read_REMOTE_ICV_ID_2_value
    End Property

    Property Let set_REMOTE_ICV_ID_2(aData)
        write_REMOTE_ICV_ID_2_value = aData
        flag_REMOTE_ICV_ID_2        = &H1
    End Property

    Property Get read_REMOTE_ICV_ID_2
        read
        read_REMOTE_ICV_ID_2 = read_REMOTE_ICV_ID_2_value
    End Property

    Property Let write_REMOTE_ICV_ID_2(aData)
        set_REMOTE_ICV_ID_2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_2_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_2_mask = mask then
                read_REMOTE_ICV_ID_2_value = data_low
            else
                read_REMOTE_ICV_ID_2_value = (data_low - H8000_0000) and REMOTE_ICV_ID_2_mask
            end If
        else
            read_REMOTE_ICV_ID_2_value = data_low and REMOTE_ICV_ID_2_mask
        end If

    End Sub

    Sub write
        If flag_REMOTE_ICV_ID_2 = &H0 Then read
        If flag_REMOTE_ICV_ID_2 = &H0 Then write_REMOTE_ICV_ID_2_value = get_REMOTE_ICV_ID_2

        regValue = leftShift((write_REMOTE_ICV_ID_2_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_2_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_2_mask = mask then
                read_REMOTE_ICV_ID_2_value = data_low
            else
                read_REMOTE_ICV_ID_2_value = (data_low - H8000_0000) and REMOTE_ICV_ID_2_mask
            end If
        else
            read_REMOTE_ICV_ID_2_value = data_low and REMOTE_ICV_ID_2_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_REMOTE_ICV_ID_2_value = &H0
        flag_REMOTE_ICV_ID_2        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_remote_icv_id2_p4
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' REMOTE_ICV_ID_2                            [15:0]           get_REMOTE_ICV_ID_2
''                                                             set_REMOTE_ICV_ID_2
''                                                             read_REMOTE_ICV_ID_2
''                                                             write_REMOTE_ICV_ID_2
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_remote_icv_id2_p4
    Private write_REMOTE_ICV_ID_2_value
    Private read_REMOTE_ICV_ID_2_value
    Private flag_REMOTE_ICV_ID_2

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

    Property Get get_REMOTE_ICV_ID_2
        get_REMOTE_ICV_ID_2 = read_REMOTE_ICV_ID_2_value
    End Property

    Property Let set_REMOTE_ICV_ID_2(aData)
        write_REMOTE_ICV_ID_2_value = aData
        flag_REMOTE_ICV_ID_2        = &H1
    End Property

    Property Get read_REMOTE_ICV_ID_2
        read
        read_REMOTE_ICV_ID_2 = read_REMOTE_ICV_ID_2_value
    End Property

    Property Let write_REMOTE_ICV_ID_2(aData)
        set_REMOTE_ICV_ID_2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_2_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_2_mask = mask then
                read_REMOTE_ICV_ID_2_value = data_low
            else
                read_REMOTE_ICV_ID_2_value = (data_low - H8000_0000) and REMOTE_ICV_ID_2_mask
            end If
        else
            read_REMOTE_ICV_ID_2_value = data_low and REMOTE_ICV_ID_2_mask
        end If

    End Sub

    Sub write
        If flag_REMOTE_ICV_ID_2 = &H0 Then read
        If flag_REMOTE_ICV_ID_2 = &H0 Then write_REMOTE_ICV_ID_2_value = get_REMOTE_ICV_ID_2

        regValue = leftShift((write_REMOTE_ICV_ID_2_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_2_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_2_mask = mask then
                read_REMOTE_ICV_ID_2_value = data_low
            else
                read_REMOTE_ICV_ID_2_value = (data_low - H8000_0000) and REMOTE_ICV_ID_2_mask
            end If
        else
            read_REMOTE_ICV_ID_2_value = data_low and REMOTE_ICV_ID_2_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_REMOTE_ICV_ID_2_value = &H0
        flag_REMOTE_ICV_ID_2        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_remote_icv_id2_p5
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' REMOTE_ICV_ID_2                            [15:0]           get_REMOTE_ICV_ID_2
''                                                             set_REMOTE_ICV_ID_2
''                                                             read_REMOTE_ICV_ID_2
''                                                             write_REMOTE_ICV_ID_2
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_remote_icv_id2_p5
    Private write_REMOTE_ICV_ID_2_value
    Private read_REMOTE_ICV_ID_2_value
    Private flag_REMOTE_ICV_ID_2

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H8a
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_REMOTE_ICV_ID_2
        get_REMOTE_ICV_ID_2 = read_REMOTE_ICV_ID_2_value
    End Property

    Property Let set_REMOTE_ICV_ID_2(aData)
        write_REMOTE_ICV_ID_2_value = aData
        flag_REMOTE_ICV_ID_2        = &H1
    End Property

    Property Get read_REMOTE_ICV_ID_2
        read
        read_REMOTE_ICV_ID_2 = read_REMOTE_ICV_ID_2_value
    End Property

    Property Let write_REMOTE_ICV_ID_2(aData)
        set_REMOTE_ICV_ID_2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_2_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_2_mask = mask then
                read_REMOTE_ICV_ID_2_value = data_low
            else
                read_REMOTE_ICV_ID_2_value = (data_low - H8000_0000) and REMOTE_ICV_ID_2_mask
            end If
        else
            read_REMOTE_ICV_ID_2_value = data_low and REMOTE_ICV_ID_2_mask
        end If

    End Sub

    Sub write
        If flag_REMOTE_ICV_ID_2 = &H0 Then read
        If flag_REMOTE_ICV_ID_2 = &H0 Then write_REMOTE_ICV_ID_2_value = get_REMOTE_ICV_ID_2

        regValue = leftShift((write_REMOTE_ICV_ID_2_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_2_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_2_mask = mask then
                read_REMOTE_ICV_ID_2_value = data_low
            else
                read_REMOTE_ICV_ID_2_value = (data_low - H8000_0000) and REMOTE_ICV_ID_2_mask
            end If
        else
            read_REMOTE_ICV_ID_2_value = data_low and REMOTE_ICV_ID_2_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_REMOTE_ICV_ID_2_value = &H0
        flag_REMOTE_ICV_ID_2        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_remote_icv_id3_p0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' REMOTE_ICV_ID_3                            [15:0]           get_REMOTE_ICV_ID_3
''                                                             set_REMOTE_ICV_ID_3
''                                                             read_REMOTE_ICV_ID_3
''                                                             write_REMOTE_ICV_ID_3
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_remote_icv_id3_p0
    Private write_REMOTE_ICV_ID_3_value
    Private read_REMOTE_ICV_ID_3_value
    Private flag_REMOTE_ICV_ID_3

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

    Property Get get_REMOTE_ICV_ID_3
        get_REMOTE_ICV_ID_3 = read_REMOTE_ICV_ID_3_value
    End Property

    Property Let set_REMOTE_ICV_ID_3(aData)
        write_REMOTE_ICV_ID_3_value = aData
        flag_REMOTE_ICV_ID_3        = &H1
    End Property

    Property Get read_REMOTE_ICV_ID_3
        read
        read_REMOTE_ICV_ID_3 = read_REMOTE_ICV_ID_3_value
    End Property

    Property Let write_REMOTE_ICV_ID_3(aData)
        set_REMOTE_ICV_ID_3 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_3_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_3_mask = mask then
                read_REMOTE_ICV_ID_3_value = data_low
            else
                read_REMOTE_ICV_ID_3_value = (data_low - H8000_0000) and REMOTE_ICV_ID_3_mask
            end If
        else
            read_REMOTE_ICV_ID_3_value = data_low and REMOTE_ICV_ID_3_mask
        end If

    End Sub

    Sub write
        If flag_REMOTE_ICV_ID_3 = &H0 Then read
        If flag_REMOTE_ICV_ID_3 = &H0 Then write_REMOTE_ICV_ID_3_value = get_REMOTE_ICV_ID_3

        regValue = leftShift((write_REMOTE_ICV_ID_3_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_3_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_3_mask = mask then
                read_REMOTE_ICV_ID_3_value = data_low
            else
                read_REMOTE_ICV_ID_3_value = (data_low - H8000_0000) and REMOTE_ICV_ID_3_mask
            end If
        else
            read_REMOTE_ICV_ID_3_value = data_low and REMOTE_ICV_ID_3_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_REMOTE_ICV_ID_3_value = &H0
        flag_REMOTE_ICV_ID_3        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_remote_icv_id3_p1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' REMOTE_ICV_ID_3                            [15:0]           get_REMOTE_ICV_ID_3
''                                                             set_REMOTE_ICV_ID_3
''                                                             read_REMOTE_ICV_ID_3
''                                                             write_REMOTE_ICV_ID_3
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_remote_icv_id3_p1
    Private write_REMOTE_ICV_ID_3_value
    Private read_REMOTE_ICV_ID_3_value
    Private flag_REMOTE_ICV_ID_3

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H92
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_REMOTE_ICV_ID_3
        get_REMOTE_ICV_ID_3 = read_REMOTE_ICV_ID_3_value
    End Property

    Property Let set_REMOTE_ICV_ID_3(aData)
        write_REMOTE_ICV_ID_3_value = aData
        flag_REMOTE_ICV_ID_3        = &H1
    End Property

    Property Get read_REMOTE_ICV_ID_3
        read
        read_REMOTE_ICV_ID_3 = read_REMOTE_ICV_ID_3_value
    End Property

    Property Let write_REMOTE_ICV_ID_3(aData)
        set_REMOTE_ICV_ID_3 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_3_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_3_mask = mask then
                read_REMOTE_ICV_ID_3_value = data_low
            else
                read_REMOTE_ICV_ID_3_value = (data_low - H8000_0000) and REMOTE_ICV_ID_3_mask
            end If
        else
            read_REMOTE_ICV_ID_3_value = data_low and REMOTE_ICV_ID_3_mask
        end If

    End Sub

    Sub write
        If flag_REMOTE_ICV_ID_3 = &H0 Then read
        If flag_REMOTE_ICV_ID_3 = &H0 Then write_REMOTE_ICV_ID_3_value = get_REMOTE_ICV_ID_3

        regValue = leftShift((write_REMOTE_ICV_ID_3_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_3_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_3_mask = mask then
                read_REMOTE_ICV_ID_3_value = data_low
            else
                read_REMOTE_ICV_ID_3_value = (data_low - H8000_0000) and REMOTE_ICV_ID_3_mask
            end If
        else
            read_REMOTE_ICV_ID_3_value = data_low and REMOTE_ICV_ID_3_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_REMOTE_ICV_ID_3_value = &H0
        flag_REMOTE_ICV_ID_3        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_remote_icv_id3_p2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' REMOTE_ICV_ID_3                            [15:0]           get_REMOTE_ICV_ID_3
''                                                             set_REMOTE_ICV_ID_3
''                                                             read_REMOTE_ICV_ID_3
''                                                             write_REMOTE_ICV_ID_3
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_remote_icv_id3_p2
    Private write_REMOTE_ICV_ID_3_value
    Private read_REMOTE_ICV_ID_3_value
    Private flag_REMOTE_ICV_ID_3

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

    Property Get get_REMOTE_ICV_ID_3
        get_REMOTE_ICV_ID_3 = read_REMOTE_ICV_ID_3_value
    End Property

    Property Let set_REMOTE_ICV_ID_3(aData)
        write_REMOTE_ICV_ID_3_value = aData
        flag_REMOTE_ICV_ID_3        = &H1
    End Property

    Property Get read_REMOTE_ICV_ID_3
        read
        read_REMOTE_ICV_ID_3 = read_REMOTE_ICV_ID_3_value
    End Property

    Property Let write_REMOTE_ICV_ID_3(aData)
        set_REMOTE_ICV_ID_3 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_3_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_3_mask = mask then
                read_REMOTE_ICV_ID_3_value = data_low
            else
                read_REMOTE_ICV_ID_3_value = (data_low - H8000_0000) and REMOTE_ICV_ID_3_mask
            end If
        else
            read_REMOTE_ICV_ID_3_value = data_low and REMOTE_ICV_ID_3_mask
        end If

    End Sub

    Sub write
        If flag_REMOTE_ICV_ID_3 = &H0 Then read
        If flag_REMOTE_ICV_ID_3 = &H0 Then write_REMOTE_ICV_ID_3_value = get_REMOTE_ICV_ID_3

        regValue = leftShift((write_REMOTE_ICV_ID_3_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_3_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_3_mask = mask then
                read_REMOTE_ICV_ID_3_value = data_low
            else
                read_REMOTE_ICV_ID_3_value = (data_low - H8000_0000) and REMOTE_ICV_ID_3_mask
            end If
        else
            read_REMOTE_ICV_ID_3_value = data_low and REMOTE_ICV_ID_3_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_REMOTE_ICV_ID_3_value = &H0
        flag_REMOTE_ICV_ID_3        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_remote_icv_id3_p3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' REMOTE_ICV_ID_3                            [15:0]           get_REMOTE_ICV_ID_3
''                                                             set_REMOTE_ICV_ID_3
''                                                             read_REMOTE_ICV_ID_3
''                                                             write_REMOTE_ICV_ID_3
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_remote_icv_id3_p3
    Private write_REMOTE_ICV_ID_3_value
    Private read_REMOTE_ICV_ID_3_value
    Private flag_REMOTE_ICV_ID_3

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H96
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_REMOTE_ICV_ID_3
        get_REMOTE_ICV_ID_3 = read_REMOTE_ICV_ID_3_value
    End Property

    Property Let set_REMOTE_ICV_ID_3(aData)
        write_REMOTE_ICV_ID_3_value = aData
        flag_REMOTE_ICV_ID_3        = &H1
    End Property

    Property Get read_REMOTE_ICV_ID_3
        read
        read_REMOTE_ICV_ID_3 = read_REMOTE_ICV_ID_3_value
    End Property

    Property Let write_REMOTE_ICV_ID_3(aData)
        set_REMOTE_ICV_ID_3 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_3_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_3_mask = mask then
                read_REMOTE_ICV_ID_3_value = data_low
            else
                read_REMOTE_ICV_ID_3_value = (data_low - H8000_0000) and REMOTE_ICV_ID_3_mask
            end If
        else
            read_REMOTE_ICV_ID_3_value = data_low and REMOTE_ICV_ID_3_mask
        end If

    End Sub

    Sub write
        If flag_REMOTE_ICV_ID_3 = &H0 Then read
        If flag_REMOTE_ICV_ID_3 = &H0 Then write_REMOTE_ICV_ID_3_value = get_REMOTE_ICV_ID_3

        regValue = leftShift((write_REMOTE_ICV_ID_3_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_3_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_3_mask = mask then
                read_REMOTE_ICV_ID_3_value = data_low
            else
                read_REMOTE_ICV_ID_3_value = (data_low - H8000_0000) and REMOTE_ICV_ID_3_mask
            end If
        else
            read_REMOTE_ICV_ID_3_value = data_low and REMOTE_ICV_ID_3_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_REMOTE_ICV_ID_3_value = &H0
        flag_REMOTE_ICV_ID_3        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_remote_icv_id3_p4
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' REMOTE_ICV_ID_3                            [15:0]           get_REMOTE_ICV_ID_3
''                                                             set_REMOTE_ICV_ID_3
''                                                             read_REMOTE_ICV_ID_3
''                                                             write_REMOTE_ICV_ID_3
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_remote_icv_id3_p4
    Private write_REMOTE_ICV_ID_3_value
    Private read_REMOTE_ICV_ID_3_value
    Private flag_REMOTE_ICV_ID_3

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

    Property Get get_REMOTE_ICV_ID_3
        get_REMOTE_ICV_ID_3 = read_REMOTE_ICV_ID_3_value
    End Property

    Property Let set_REMOTE_ICV_ID_3(aData)
        write_REMOTE_ICV_ID_3_value = aData
        flag_REMOTE_ICV_ID_3        = &H1
    End Property

    Property Get read_REMOTE_ICV_ID_3
        read
        read_REMOTE_ICV_ID_3 = read_REMOTE_ICV_ID_3_value
    End Property

    Property Let write_REMOTE_ICV_ID_3(aData)
        set_REMOTE_ICV_ID_3 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_3_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_3_mask = mask then
                read_REMOTE_ICV_ID_3_value = data_low
            else
                read_REMOTE_ICV_ID_3_value = (data_low - H8000_0000) and REMOTE_ICV_ID_3_mask
            end If
        else
            read_REMOTE_ICV_ID_3_value = data_low and REMOTE_ICV_ID_3_mask
        end If

    End Sub

    Sub write
        If flag_REMOTE_ICV_ID_3 = &H0 Then read
        If flag_REMOTE_ICV_ID_3 = &H0 Then write_REMOTE_ICV_ID_3_value = get_REMOTE_ICV_ID_3

        regValue = leftShift((write_REMOTE_ICV_ID_3_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_3_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_3_mask = mask then
                read_REMOTE_ICV_ID_3_value = data_low
            else
                read_REMOTE_ICV_ID_3_value = (data_low - H8000_0000) and REMOTE_ICV_ID_3_mask
            end If
        else
            read_REMOTE_ICV_ID_3_value = data_low and REMOTE_ICV_ID_3_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_REMOTE_ICV_ID_3_value = &H0
        flag_REMOTE_ICV_ID_3        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_remote_icv_id3_p5
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' REMOTE_ICV_ID_3                            [15:0]           get_REMOTE_ICV_ID_3
''                                                             set_REMOTE_ICV_ID_3
''                                                             read_REMOTE_ICV_ID_3
''                                                             write_REMOTE_ICV_ID_3
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_remote_icv_id3_p5
    Private write_REMOTE_ICV_ID_3_value
    Private read_REMOTE_ICV_ID_3_value
    Private flag_REMOTE_ICV_ID_3

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H9a
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_REMOTE_ICV_ID_3
        get_REMOTE_ICV_ID_3 = read_REMOTE_ICV_ID_3_value
    End Property

    Property Let set_REMOTE_ICV_ID_3(aData)
        write_REMOTE_ICV_ID_3_value = aData
        flag_REMOTE_ICV_ID_3        = &H1
    End Property

    Property Get read_REMOTE_ICV_ID_3
        read
        read_REMOTE_ICV_ID_3 = read_REMOTE_ICV_ID_3_value
    End Property

    Property Let write_REMOTE_ICV_ID_3(aData)
        set_REMOTE_ICV_ID_3 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_3_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_3_mask = mask then
                read_REMOTE_ICV_ID_3_value = data_low
            else
                read_REMOTE_ICV_ID_3_value = (data_low - H8000_0000) and REMOTE_ICV_ID_3_mask
            end If
        else
            read_REMOTE_ICV_ID_3_value = data_low and REMOTE_ICV_ID_3_mask
        end If

    End Sub

    Sub write
        If flag_REMOTE_ICV_ID_3 = &H0 Then read
        If flag_REMOTE_ICV_ID_3 = &H0 Then write_REMOTE_ICV_ID_3_value = get_REMOTE_ICV_ID_3

        regValue = leftShift((write_REMOTE_ICV_ID_3_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_3_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_3_mask = mask then
                read_REMOTE_ICV_ID_3_value = data_low
            else
                read_REMOTE_ICV_ID_3_value = (data_low - H8000_0000) and REMOTE_ICV_ID_3_mask
            end If
        else
            read_REMOTE_ICV_ID_3_value = data_low and REMOTE_ICV_ID_3_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_REMOTE_ICV_ID_3_value = &H0
        flag_REMOTE_ICV_ID_3        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_local_icv_id_ipad0_p0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LOCAL_ICV_ID_IPAD_0                        [15:0]           get_LOCAL_ICV_ID_IPAD_0
''                                                             set_LOCAL_ICV_ID_IPAD_0
''                                                             read_LOCAL_ICV_ID_IPAD_0
''                                                             write_LOCAL_ICV_ID_IPAD_0
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_local_icv_id_ipad0_p0
    Private write_LOCAL_ICV_ID_IPAD_0_value
    Private read_LOCAL_ICV_ID_IPAD_0_value
    Private flag_LOCAL_ICV_ID_IPAD_0

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

    Property Get get_LOCAL_ICV_ID_IPAD_0
        get_LOCAL_ICV_ID_IPAD_0 = read_LOCAL_ICV_ID_IPAD_0_value
    End Property

    Property Let set_LOCAL_ICV_ID_IPAD_0(aData)
        write_LOCAL_ICV_ID_IPAD_0_value = aData
        flag_LOCAL_ICV_ID_IPAD_0        = &H1
    End Property

    Property Get read_LOCAL_ICV_ID_IPAD_0
        read
        read_LOCAL_ICV_ID_IPAD_0 = read_LOCAL_ICV_ID_IPAD_0_value
    End Property

    Property Let write_LOCAL_ICV_ID_IPAD_0(aData)
        set_LOCAL_ICV_ID_IPAD_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_IPAD_0_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_IPAD_0_mask = mask then
                read_LOCAL_ICV_ID_IPAD_0_value = data_low
            else
                read_LOCAL_ICV_ID_IPAD_0_value = (data_low - H8000_0000) and LOCAL_ICV_ID_IPAD_0_mask
            end If
        else
            read_LOCAL_ICV_ID_IPAD_0_value = data_low and LOCAL_ICV_ID_IPAD_0_mask
        end If

    End Sub

    Sub write
        If flag_LOCAL_ICV_ID_IPAD_0 = &H0 Then read
        If flag_LOCAL_ICV_ID_IPAD_0 = &H0 Then write_LOCAL_ICV_ID_IPAD_0_value = get_LOCAL_ICV_ID_IPAD_0

        regValue = leftShift((write_LOCAL_ICV_ID_IPAD_0_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_IPAD_0_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_IPAD_0_mask = mask then
                read_LOCAL_ICV_ID_IPAD_0_value = data_low
            else
                read_LOCAL_ICV_ID_IPAD_0_value = (data_low - H8000_0000) and LOCAL_ICV_ID_IPAD_0_mask
            end If
        else
            read_LOCAL_ICV_ID_IPAD_0_value = data_low and LOCAL_ICV_ID_IPAD_0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LOCAL_ICV_ID_IPAD_0_value = &H0
        flag_LOCAL_ICV_ID_IPAD_0        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_local_icv_id_ipad0_p1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LOCAL_ICV_ID_IPAD_0                        [15:0]           get_LOCAL_ICV_ID_IPAD_0
''                                                             set_LOCAL_ICV_ID_IPAD_0
''                                                             read_LOCAL_ICV_ID_IPAD_0
''                                                             write_LOCAL_ICV_ID_IPAD_0
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_local_icv_id_ipad0_p1
    Private write_LOCAL_ICV_ID_IPAD_0_value
    Private read_LOCAL_ICV_ID_IPAD_0_value
    Private flag_LOCAL_ICV_ID_IPAD_0

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Ha2
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_LOCAL_ICV_ID_IPAD_0
        get_LOCAL_ICV_ID_IPAD_0 = read_LOCAL_ICV_ID_IPAD_0_value
    End Property

    Property Let set_LOCAL_ICV_ID_IPAD_0(aData)
        write_LOCAL_ICV_ID_IPAD_0_value = aData
        flag_LOCAL_ICV_ID_IPAD_0        = &H1
    End Property

    Property Get read_LOCAL_ICV_ID_IPAD_0
        read
        read_LOCAL_ICV_ID_IPAD_0 = read_LOCAL_ICV_ID_IPAD_0_value
    End Property

    Property Let write_LOCAL_ICV_ID_IPAD_0(aData)
        set_LOCAL_ICV_ID_IPAD_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_IPAD_0_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_IPAD_0_mask = mask then
                read_LOCAL_ICV_ID_IPAD_0_value = data_low
            else
                read_LOCAL_ICV_ID_IPAD_0_value = (data_low - H8000_0000) and LOCAL_ICV_ID_IPAD_0_mask
            end If
        else
            read_LOCAL_ICV_ID_IPAD_0_value = data_low and LOCAL_ICV_ID_IPAD_0_mask
        end If

    End Sub

    Sub write
        If flag_LOCAL_ICV_ID_IPAD_0 = &H0 Then read
        If flag_LOCAL_ICV_ID_IPAD_0 = &H0 Then write_LOCAL_ICV_ID_IPAD_0_value = get_LOCAL_ICV_ID_IPAD_0

        regValue = leftShift((write_LOCAL_ICV_ID_IPAD_0_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_IPAD_0_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_IPAD_0_mask = mask then
                read_LOCAL_ICV_ID_IPAD_0_value = data_low
            else
                read_LOCAL_ICV_ID_IPAD_0_value = (data_low - H8000_0000) and LOCAL_ICV_ID_IPAD_0_mask
            end If
        else
            read_LOCAL_ICV_ID_IPAD_0_value = data_low and LOCAL_ICV_ID_IPAD_0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LOCAL_ICV_ID_IPAD_0_value = &H0
        flag_LOCAL_ICV_ID_IPAD_0        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_local_icv_id_ipad0_p2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LOCAL_ICV_ID_IPAD_0                        [15:0]           get_LOCAL_ICV_ID_IPAD_0
''                                                             set_LOCAL_ICV_ID_IPAD_0
''                                                             read_LOCAL_ICV_ID_IPAD_0
''                                                             write_LOCAL_ICV_ID_IPAD_0
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_local_icv_id_ipad0_p2
    Private write_LOCAL_ICV_ID_IPAD_0_value
    Private read_LOCAL_ICV_ID_IPAD_0_value
    Private flag_LOCAL_ICV_ID_IPAD_0

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

    Property Get get_LOCAL_ICV_ID_IPAD_0
        get_LOCAL_ICV_ID_IPAD_0 = read_LOCAL_ICV_ID_IPAD_0_value
    End Property

    Property Let set_LOCAL_ICV_ID_IPAD_0(aData)
        write_LOCAL_ICV_ID_IPAD_0_value = aData
        flag_LOCAL_ICV_ID_IPAD_0        = &H1
    End Property

    Property Get read_LOCAL_ICV_ID_IPAD_0
        read
        read_LOCAL_ICV_ID_IPAD_0 = read_LOCAL_ICV_ID_IPAD_0_value
    End Property

    Property Let write_LOCAL_ICV_ID_IPAD_0(aData)
        set_LOCAL_ICV_ID_IPAD_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_IPAD_0_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_IPAD_0_mask = mask then
                read_LOCAL_ICV_ID_IPAD_0_value = data_low
            else
                read_LOCAL_ICV_ID_IPAD_0_value = (data_low - H8000_0000) and LOCAL_ICV_ID_IPAD_0_mask
            end If
        else
            read_LOCAL_ICV_ID_IPAD_0_value = data_low and LOCAL_ICV_ID_IPAD_0_mask
        end If

    End Sub

    Sub write
        If flag_LOCAL_ICV_ID_IPAD_0 = &H0 Then read
        If flag_LOCAL_ICV_ID_IPAD_0 = &H0 Then write_LOCAL_ICV_ID_IPAD_0_value = get_LOCAL_ICV_ID_IPAD_0

        regValue = leftShift((write_LOCAL_ICV_ID_IPAD_0_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_IPAD_0_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_IPAD_0_mask = mask then
                read_LOCAL_ICV_ID_IPAD_0_value = data_low
            else
                read_LOCAL_ICV_ID_IPAD_0_value = (data_low - H8000_0000) and LOCAL_ICV_ID_IPAD_0_mask
            end If
        else
            read_LOCAL_ICV_ID_IPAD_0_value = data_low and LOCAL_ICV_ID_IPAD_0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LOCAL_ICV_ID_IPAD_0_value = &H0
        flag_LOCAL_ICV_ID_IPAD_0        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_local_icv_id_ipad0_p3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LOCAL_ICV_ID_IPAD_0                        [15:0]           get_LOCAL_ICV_ID_IPAD_0
''                                                             set_LOCAL_ICV_ID_IPAD_0
''                                                             read_LOCAL_ICV_ID_IPAD_0
''                                                             write_LOCAL_ICV_ID_IPAD_0
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_local_icv_id_ipad0_p3
    Private write_LOCAL_ICV_ID_IPAD_0_value
    Private read_LOCAL_ICV_ID_IPAD_0_value
    Private flag_LOCAL_ICV_ID_IPAD_0

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Ha6
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_LOCAL_ICV_ID_IPAD_0
        get_LOCAL_ICV_ID_IPAD_0 = read_LOCAL_ICV_ID_IPAD_0_value
    End Property

    Property Let set_LOCAL_ICV_ID_IPAD_0(aData)
        write_LOCAL_ICV_ID_IPAD_0_value = aData
        flag_LOCAL_ICV_ID_IPAD_0        = &H1
    End Property

    Property Get read_LOCAL_ICV_ID_IPAD_0
        read
        read_LOCAL_ICV_ID_IPAD_0 = read_LOCAL_ICV_ID_IPAD_0_value
    End Property

    Property Let write_LOCAL_ICV_ID_IPAD_0(aData)
        set_LOCAL_ICV_ID_IPAD_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_IPAD_0_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_IPAD_0_mask = mask then
                read_LOCAL_ICV_ID_IPAD_0_value = data_low
            else
                read_LOCAL_ICV_ID_IPAD_0_value = (data_low - H8000_0000) and LOCAL_ICV_ID_IPAD_0_mask
            end If
        else
            read_LOCAL_ICV_ID_IPAD_0_value = data_low and LOCAL_ICV_ID_IPAD_0_mask
        end If

    End Sub

    Sub write
        If flag_LOCAL_ICV_ID_IPAD_0 = &H0 Then read
        If flag_LOCAL_ICV_ID_IPAD_0 = &H0 Then write_LOCAL_ICV_ID_IPAD_0_value = get_LOCAL_ICV_ID_IPAD_0

        regValue = leftShift((write_LOCAL_ICV_ID_IPAD_0_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_IPAD_0_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_IPAD_0_mask = mask then
                read_LOCAL_ICV_ID_IPAD_0_value = data_low
            else
                read_LOCAL_ICV_ID_IPAD_0_value = (data_low - H8000_0000) and LOCAL_ICV_ID_IPAD_0_mask
            end If
        else
            read_LOCAL_ICV_ID_IPAD_0_value = data_low and LOCAL_ICV_ID_IPAD_0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LOCAL_ICV_ID_IPAD_0_value = &H0
        flag_LOCAL_ICV_ID_IPAD_0        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_local_icv_id_ipad0_p4
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LOCAL_ICV_ID_IPAD_0                        [15:0]           get_LOCAL_ICV_ID_IPAD_0
''                                                             set_LOCAL_ICV_ID_IPAD_0
''                                                             read_LOCAL_ICV_ID_IPAD_0
''                                                             write_LOCAL_ICV_ID_IPAD_0
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_local_icv_id_ipad0_p4
    Private write_LOCAL_ICV_ID_IPAD_0_value
    Private read_LOCAL_ICV_ID_IPAD_0_value
    Private flag_LOCAL_ICV_ID_IPAD_0

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

    Property Get get_LOCAL_ICV_ID_IPAD_0
        get_LOCAL_ICV_ID_IPAD_0 = read_LOCAL_ICV_ID_IPAD_0_value
    End Property

    Property Let set_LOCAL_ICV_ID_IPAD_0(aData)
        write_LOCAL_ICV_ID_IPAD_0_value = aData
        flag_LOCAL_ICV_ID_IPAD_0        = &H1
    End Property

    Property Get read_LOCAL_ICV_ID_IPAD_0
        read
        read_LOCAL_ICV_ID_IPAD_0 = read_LOCAL_ICV_ID_IPAD_0_value
    End Property

    Property Let write_LOCAL_ICV_ID_IPAD_0(aData)
        set_LOCAL_ICV_ID_IPAD_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_IPAD_0_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_IPAD_0_mask = mask then
                read_LOCAL_ICV_ID_IPAD_0_value = data_low
            else
                read_LOCAL_ICV_ID_IPAD_0_value = (data_low - H8000_0000) and LOCAL_ICV_ID_IPAD_0_mask
            end If
        else
            read_LOCAL_ICV_ID_IPAD_0_value = data_low and LOCAL_ICV_ID_IPAD_0_mask
        end If

    End Sub

    Sub write
        If flag_LOCAL_ICV_ID_IPAD_0 = &H0 Then read
        If flag_LOCAL_ICV_ID_IPAD_0 = &H0 Then write_LOCAL_ICV_ID_IPAD_0_value = get_LOCAL_ICV_ID_IPAD_0

        regValue = leftShift((write_LOCAL_ICV_ID_IPAD_0_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_IPAD_0_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_IPAD_0_mask = mask then
                read_LOCAL_ICV_ID_IPAD_0_value = data_low
            else
                read_LOCAL_ICV_ID_IPAD_0_value = (data_low - H8000_0000) and LOCAL_ICV_ID_IPAD_0_mask
            end If
        else
            read_LOCAL_ICV_ID_IPAD_0_value = data_low and LOCAL_ICV_ID_IPAD_0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LOCAL_ICV_ID_IPAD_0_value = &H0
        flag_LOCAL_ICV_ID_IPAD_0        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_local_icv_id_ipad0_p5
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LOCAL_ICV_ID_IPAD_0                        [15:0]           get_LOCAL_ICV_ID_IPAD_0
''                                                             set_LOCAL_ICV_ID_IPAD_0
''                                                             read_LOCAL_ICV_ID_IPAD_0
''                                                             write_LOCAL_ICV_ID_IPAD_0
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_local_icv_id_ipad0_p5
    Private write_LOCAL_ICV_ID_IPAD_0_value
    Private read_LOCAL_ICV_ID_IPAD_0_value
    Private flag_LOCAL_ICV_ID_IPAD_0

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Haa
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_LOCAL_ICV_ID_IPAD_0
        get_LOCAL_ICV_ID_IPAD_0 = read_LOCAL_ICV_ID_IPAD_0_value
    End Property

    Property Let set_LOCAL_ICV_ID_IPAD_0(aData)
        write_LOCAL_ICV_ID_IPAD_0_value = aData
        flag_LOCAL_ICV_ID_IPAD_0        = &H1
    End Property

    Property Get read_LOCAL_ICV_ID_IPAD_0
        read
        read_LOCAL_ICV_ID_IPAD_0 = read_LOCAL_ICV_ID_IPAD_0_value
    End Property

    Property Let write_LOCAL_ICV_ID_IPAD_0(aData)
        set_LOCAL_ICV_ID_IPAD_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_IPAD_0_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_IPAD_0_mask = mask then
                read_LOCAL_ICV_ID_IPAD_0_value = data_low
            else
                read_LOCAL_ICV_ID_IPAD_0_value = (data_low - H8000_0000) and LOCAL_ICV_ID_IPAD_0_mask
            end If
        else
            read_LOCAL_ICV_ID_IPAD_0_value = data_low and LOCAL_ICV_ID_IPAD_0_mask
        end If

    End Sub

    Sub write
        If flag_LOCAL_ICV_ID_IPAD_0 = &H0 Then read
        If flag_LOCAL_ICV_ID_IPAD_0 = &H0 Then write_LOCAL_ICV_ID_IPAD_0_value = get_LOCAL_ICV_ID_IPAD_0

        regValue = leftShift((write_LOCAL_ICV_ID_IPAD_0_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_IPAD_0_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_IPAD_0_mask = mask then
                read_LOCAL_ICV_ID_IPAD_0_value = data_low
            else
                read_LOCAL_ICV_ID_IPAD_0_value = (data_low - H8000_0000) and LOCAL_ICV_ID_IPAD_0_mask
            end If
        else
            read_LOCAL_ICV_ID_IPAD_0_value = data_low and LOCAL_ICV_ID_IPAD_0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LOCAL_ICV_ID_IPAD_0_value = &H0
        flag_LOCAL_ICV_ID_IPAD_0        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_local_icv_id_ipad1_p0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LOCAL_ICV_ID_IPAD_1                        [15:0]           get_LOCAL_ICV_ID_IPAD_1
''                                                             set_LOCAL_ICV_ID_IPAD_1
''                                                             read_LOCAL_ICV_ID_IPAD_1
''                                                             write_LOCAL_ICV_ID_IPAD_1
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_local_icv_id_ipad1_p0
    Private write_LOCAL_ICV_ID_IPAD_1_value
    Private read_LOCAL_ICV_ID_IPAD_1_value
    Private flag_LOCAL_ICV_ID_IPAD_1

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

    Property Get get_LOCAL_ICV_ID_IPAD_1
        get_LOCAL_ICV_ID_IPAD_1 = read_LOCAL_ICV_ID_IPAD_1_value
    End Property

    Property Let set_LOCAL_ICV_ID_IPAD_1(aData)
        write_LOCAL_ICV_ID_IPAD_1_value = aData
        flag_LOCAL_ICV_ID_IPAD_1        = &H1
    End Property

    Property Get read_LOCAL_ICV_ID_IPAD_1
        read
        read_LOCAL_ICV_ID_IPAD_1 = read_LOCAL_ICV_ID_IPAD_1_value
    End Property

    Property Let write_LOCAL_ICV_ID_IPAD_1(aData)
        set_LOCAL_ICV_ID_IPAD_1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_IPAD_1_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_IPAD_1_mask = mask then
                read_LOCAL_ICV_ID_IPAD_1_value = data_low
            else
                read_LOCAL_ICV_ID_IPAD_1_value = (data_low - H8000_0000) and LOCAL_ICV_ID_IPAD_1_mask
            end If
        else
            read_LOCAL_ICV_ID_IPAD_1_value = data_low and LOCAL_ICV_ID_IPAD_1_mask
        end If

    End Sub

    Sub write
        If flag_LOCAL_ICV_ID_IPAD_1 = &H0 Then read
        If flag_LOCAL_ICV_ID_IPAD_1 = &H0 Then write_LOCAL_ICV_ID_IPAD_1_value = get_LOCAL_ICV_ID_IPAD_1

        regValue = leftShift((write_LOCAL_ICV_ID_IPAD_1_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_IPAD_1_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_IPAD_1_mask = mask then
                read_LOCAL_ICV_ID_IPAD_1_value = data_low
            else
                read_LOCAL_ICV_ID_IPAD_1_value = (data_low - H8000_0000) and LOCAL_ICV_ID_IPAD_1_mask
            end If
        else
            read_LOCAL_ICV_ID_IPAD_1_value = data_low and LOCAL_ICV_ID_IPAD_1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LOCAL_ICV_ID_IPAD_1_value = &H0
        flag_LOCAL_ICV_ID_IPAD_1        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_local_icv_id_ipad1_p1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LOCAL_ICV_ID_IPAD_1                        [15:0]           get_LOCAL_ICV_ID_IPAD_1
''                                                             set_LOCAL_ICV_ID_IPAD_1
''                                                             read_LOCAL_ICV_ID_IPAD_1
''                                                             write_LOCAL_ICV_ID_IPAD_1
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_local_icv_id_ipad1_p1
    Private write_LOCAL_ICV_ID_IPAD_1_value
    Private read_LOCAL_ICV_ID_IPAD_1_value
    Private flag_LOCAL_ICV_ID_IPAD_1

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hb2
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_LOCAL_ICV_ID_IPAD_1
        get_LOCAL_ICV_ID_IPAD_1 = read_LOCAL_ICV_ID_IPAD_1_value
    End Property

    Property Let set_LOCAL_ICV_ID_IPAD_1(aData)
        write_LOCAL_ICV_ID_IPAD_1_value = aData
        flag_LOCAL_ICV_ID_IPAD_1        = &H1
    End Property

    Property Get read_LOCAL_ICV_ID_IPAD_1
        read
        read_LOCAL_ICV_ID_IPAD_1 = read_LOCAL_ICV_ID_IPAD_1_value
    End Property

    Property Let write_LOCAL_ICV_ID_IPAD_1(aData)
        set_LOCAL_ICV_ID_IPAD_1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_IPAD_1_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_IPAD_1_mask = mask then
                read_LOCAL_ICV_ID_IPAD_1_value = data_low
            else
                read_LOCAL_ICV_ID_IPAD_1_value = (data_low - H8000_0000) and LOCAL_ICV_ID_IPAD_1_mask
            end If
        else
            read_LOCAL_ICV_ID_IPAD_1_value = data_low and LOCAL_ICV_ID_IPAD_1_mask
        end If

    End Sub

    Sub write
        If flag_LOCAL_ICV_ID_IPAD_1 = &H0 Then read
        If flag_LOCAL_ICV_ID_IPAD_1 = &H0 Then write_LOCAL_ICV_ID_IPAD_1_value = get_LOCAL_ICV_ID_IPAD_1

        regValue = leftShift((write_LOCAL_ICV_ID_IPAD_1_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_IPAD_1_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_IPAD_1_mask = mask then
                read_LOCAL_ICV_ID_IPAD_1_value = data_low
            else
                read_LOCAL_ICV_ID_IPAD_1_value = (data_low - H8000_0000) and LOCAL_ICV_ID_IPAD_1_mask
            end If
        else
            read_LOCAL_ICV_ID_IPAD_1_value = data_low and LOCAL_ICV_ID_IPAD_1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LOCAL_ICV_ID_IPAD_1_value = &H0
        flag_LOCAL_ICV_ID_IPAD_1        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_local_icv_id_ipad1_p2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LOCAL_ICV_ID_IPAD_1                        [15:0]           get_LOCAL_ICV_ID_IPAD_1
''                                                             set_LOCAL_ICV_ID_IPAD_1
''                                                             read_LOCAL_ICV_ID_IPAD_1
''                                                             write_LOCAL_ICV_ID_IPAD_1
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_local_icv_id_ipad1_p2
    Private write_LOCAL_ICV_ID_IPAD_1_value
    Private read_LOCAL_ICV_ID_IPAD_1_value
    Private flag_LOCAL_ICV_ID_IPAD_1

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

    Property Get get_LOCAL_ICV_ID_IPAD_1
        get_LOCAL_ICV_ID_IPAD_1 = read_LOCAL_ICV_ID_IPAD_1_value
    End Property

    Property Let set_LOCAL_ICV_ID_IPAD_1(aData)
        write_LOCAL_ICV_ID_IPAD_1_value = aData
        flag_LOCAL_ICV_ID_IPAD_1        = &H1
    End Property

    Property Get read_LOCAL_ICV_ID_IPAD_1
        read
        read_LOCAL_ICV_ID_IPAD_1 = read_LOCAL_ICV_ID_IPAD_1_value
    End Property

    Property Let write_LOCAL_ICV_ID_IPAD_1(aData)
        set_LOCAL_ICV_ID_IPAD_1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_IPAD_1_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_IPAD_1_mask = mask then
                read_LOCAL_ICV_ID_IPAD_1_value = data_low
            else
                read_LOCAL_ICV_ID_IPAD_1_value = (data_low - H8000_0000) and LOCAL_ICV_ID_IPAD_1_mask
            end If
        else
            read_LOCAL_ICV_ID_IPAD_1_value = data_low and LOCAL_ICV_ID_IPAD_1_mask
        end If

    End Sub

    Sub write
        If flag_LOCAL_ICV_ID_IPAD_1 = &H0 Then read
        If flag_LOCAL_ICV_ID_IPAD_1 = &H0 Then write_LOCAL_ICV_ID_IPAD_1_value = get_LOCAL_ICV_ID_IPAD_1

        regValue = leftShift((write_LOCAL_ICV_ID_IPAD_1_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_IPAD_1_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_IPAD_1_mask = mask then
                read_LOCAL_ICV_ID_IPAD_1_value = data_low
            else
                read_LOCAL_ICV_ID_IPAD_1_value = (data_low - H8000_0000) and LOCAL_ICV_ID_IPAD_1_mask
            end If
        else
            read_LOCAL_ICV_ID_IPAD_1_value = data_low and LOCAL_ICV_ID_IPAD_1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LOCAL_ICV_ID_IPAD_1_value = &H0
        flag_LOCAL_ICV_ID_IPAD_1        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_local_icv_id_ipad1_p3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LOCAL_ICV_ID_IPAD_1                        [15:0]           get_LOCAL_ICV_ID_IPAD_1
''                                                             set_LOCAL_ICV_ID_IPAD_1
''                                                             read_LOCAL_ICV_ID_IPAD_1
''                                                             write_LOCAL_ICV_ID_IPAD_1
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_local_icv_id_ipad1_p3
    Private write_LOCAL_ICV_ID_IPAD_1_value
    Private read_LOCAL_ICV_ID_IPAD_1_value
    Private flag_LOCAL_ICV_ID_IPAD_1

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hb6
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_LOCAL_ICV_ID_IPAD_1
        get_LOCAL_ICV_ID_IPAD_1 = read_LOCAL_ICV_ID_IPAD_1_value
    End Property

    Property Let set_LOCAL_ICV_ID_IPAD_1(aData)
        write_LOCAL_ICV_ID_IPAD_1_value = aData
        flag_LOCAL_ICV_ID_IPAD_1        = &H1
    End Property

    Property Get read_LOCAL_ICV_ID_IPAD_1
        read
        read_LOCAL_ICV_ID_IPAD_1 = read_LOCAL_ICV_ID_IPAD_1_value
    End Property

    Property Let write_LOCAL_ICV_ID_IPAD_1(aData)
        set_LOCAL_ICV_ID_IPAD_1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_IPAD_1_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_IPAD_1_mask = mask then
                read_LOCAL_ICV_ID_IPAD_1_value = data_low
            else
                read_LOCAL_ICV_ID_IPAD_1_value = (data_low - H8000_0000) and LOCAL_ICV_ID_IPAD_1_mask
            end If
        else
            read_LOCAL_ICV_ID_IPAD_1_value = data_low and LOCAL_ICV_ID_IPAD_1_mask
        end If

    End Sub

    Sub write
        If flag_LOCAL_ICV_ID_IPAD_1 = &H0 Then read
        If flag_LOCAL_ICV_ID_IPAD_1 = &H0 Then write_LOCAL_ICV_ID_IPAD_1_value = get_LOCAL_ICV_ID_IPAD_1

        regValue = leftShift((write_LOCAL_ICV_ID_IPAD_1_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_IPAD_1_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_IPAD_1_mask = mask then
                read_LOCAL_ICV_ID_IPAD_1_value = data_low
            else
                read_LOCAL_ICV_ID_IPAD_1_value = (data_low - H8000_0000) and LOCAL_ICV_ID_IPAD_1_mask
            end If
        else
            read_LOCAL_ICV_ID_IPAD_1_value = data_low and LOCAL_ICV_ID_IPAD_1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LOCAL_ICV_ID_IPAD_1_value = &H0
        flag_LOCAL_ICV_ID_IPAD_1        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_local_icv_id_ipad1_p4
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LOCAL_ICV_ID_IPAD_1                        [15:0]           get_LOCAL_ICV_ID_IPAD_1
''                                                             set_LOCAL_ICV_ID_IPAD_1
''                                                             read_LOCAL_ICV_ID_IPAD_1
''                                                             write_LOCAL_ICV_ID_IPAD_1
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_local_icv_id_ipad1_p4
    Private write_LOCAL_ICV_ID_IPAD_1_value
    Private read_LOCAL_ICV_ID_IPAD_1_value
    Private flag_LOCAL_ICV_ID_IPAD_1

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

    Property Get get_LOCAL_ICV_ID_IPAD_1
        get_LOCAL_ICV_ID_IPAD_1 = read_LOCAL_ICV_ID_IPAD_1_value
    End Property

    Property Let set_LOCAL_ICV_ID_IPAD_1(aData)
        write_LOCAL_ICV_ID_IPAD_1_value = aData
        flag_LOCAL_ICV_ID_IPAD_1        = &H1
    End Property

    Property Get read_LOCAL_ICV_ID_IPAD_1
        read
        read_LOCAL_ICV_ID_IPAD_1 = read_LOCAL_ICV_ID_IPAD_1_value
    End Property

    Property Let write_LOCAL_ICV_ID_IPAD_1(aData)
        set_LOCAL_ICV_ID_IPAD_1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_IPAD_1_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_IPAD_1_mask = mask then
                read_LOCAL_ICV_ID_IPAD_1_value = data_low
            else
                read_LOCAL_ICV_ID_IPAD_1_value = (data_low - H8000_0000) and LOCAL_ICV_ID_IPAD_1_mask
            end If
        else
            read_LOCAL_ICV_ID_IPAD_1_value = data_low and LOCAL_ICV_ID_IPAD_1_mask
        end If

    End Sub

    Sub write
        If flag_LOCAL_ICV_ID_IPAD_1 = &H0 Then read
        If flag_LOCAL_ICV_ID_IPAD_1 = &H0 Then write_LOCAL_ICV_ID_IPAD_1_value = get_LOCAL_ICV_ID_IPAD_1

        regValue = leftShift((write_LOCAL_ICV_ID_IPAD_1_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_IPAD_1_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_IPAD_1_mask = mask then
                read_LOCAL_ICV_ID_IPAD_1_value = data_low
            else
                read_LOCAL_ICV_ID_IPAD_1_value = (data_low - H8000_0000) and LOCAL_ICV_ID_IPAD_1_mask
            end If
        else
            read_LOCAL_ICV_ID_IPAD_1_value = data_low and LOCAL_ICV_ID_IPAD_1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LOCAL_ICV_ID_IPAD_1_value = &H0
        flag_LOCAL_ICV_ID_IPAD_1        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_local_icv_id_ipad1_p5
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LOCAL_ICV_ID_IPAD_1                        [15:0]           get_LOCAL_ICV_ID_IPAD_1
''                                                             set_LOCAL_ICV_ID_IPAD_1
''                                                             read_LOCAL_ICV_ID_IPAD_1
''                                                             write_LOCAL_ICV_ID_IPAD_1
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_local_icv_id_ipad1_p5
    Private write_LOCAL_ICV_ID_IPAD_1_value
    Private read_LOCAL_ICV_ID_IPAD_1_value
    Private flag_LOCAL_ICV_ID_IPAD_1

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hba
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_LOCAL_ICV_ID_IPAD_1
        get_LOCAL_ICV_ID_IPAD_1 = read_LOCAL_ICV_ID_IPAD_1_value
    End Property

    Property Let set_LOCAL_ICV_ID_IPAD_1(aData)
        write_LOCAL_ICV_ID_IPAD_1_value = aData
        flag_LOCAL_ICV_ID_IPAD_1        = &H1
    End Property

    Property Get read_LOCAL_ICV_ID_IPAD_1
        read
        read_LOCAL_ICV_ID_IPAD_1 = read_LOCAL_ICV_ID_IPAD_1_value
    End Property

    Property Let write_LOCAL_ICV_ID_IPAD_1(aData)
        set_LOCAL_ICV_ID_IPAD_1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_IPAD_1_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_IPAD_1_mask = mask then
                read_LOCAL_ICV_ID_IPAD_1_value = data_low
            else
                read_LOCAL_ICV_ID_IPAD_1_value = (data_low - H8000_0000) and LOCAL_ICV_ID_IPAD_1_mask
            end If
        else
            read_LOCAL_ICV_ID_IPAD_1_value = data_low and LOCAL_ICV_ID_IPAD_1_mask
        end If

    End Sub

    Sub write
        If flag_LOCAL_ICV_ID_IPAD_1 = &H0 Then read
        If flag_LOCAL_ICV_ID_IPAD_1 = &H0 Then write_LOCAL_ICV_ID_IPAD_1_value = get_LOCAL_ICV_ID_IPAD_1

        regValue = leftShift((write_LOCAL_ICV_ID_IPAD_1_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_IPAD_1_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_IPAD_1_mask = mask then
                read_LOCAL_ICV_ID_IPAD_1_value = data_low
            else
                read_LOCAL_ICV_ID_IPAD_1_value = (data_low - H8000_0000) and LOCAL_ICV_ID_IPAD_1_mask
            end If
        else
            read_LOCAL_ICV_ID_IPAD_1_value = data_low and LOCAL_ICV_ID_IPAD_1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LOCAL_ICV_ID_IPAD_1_value = &H0
        flag_LOCAL_ICV_ID_IPAD_1        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_local_icv_id_ipad2_p0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LOCAL_ICV_ID_IPAD_2                        [15:0]           get_LOCAL_ICV_ID_IPAD_2
''                                                             set_LOCAL_ICV_ID_IPAD_2
''                                                             read_LOCAL_ICV_ID_IPAD_2
''                                                             write_LOCAL_ICV_ID_IPAD_2
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_local_icv_id_ipad2_p0
    Private write_LOCAL_ICV_ID_IPAD_2_value
    Private read_LOCAL_ICV_ID_IPAD_2_value
    Private flag_LOCAL_ICV_ID_IPAD_2

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

    Property Get get_LOCAL_ICV_ID_IPAD_2
        get_LOCAL_ICV_ID_IPAD_2 = read_LOCAL_ICV_ID_IPAD_2_value
    End Property

    Property Let set_LOCAL_ICV_ID_IPAD_2(aData)
        write_LOCAL_ICV_ID_IPAD_2_value = aData
        flag_LOCAL_ICV_ID_IPAD_2        = &H1
    End Property

    Property Get read_LOCAL_ICV_ID_IPAD_2
        read
        read_LOCAL_ICV_ID_IPAD_2 = read_LOCAL_ICV_ID_IPAD_2_value
    End Property

    Property Let write_LOCAL_ICV_ID_IPAD_2(aData)
        set_LOCAL_ICV_ID_IPAD_2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_IPAD_2_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_IPAD_2_mask = mask then
                read_LOCAL_ICV_ID_IPAD_2_value = data_low
            else
                read_LOCAL_ICV_ID_IPAD_2_value = (data_low - H8000_0000) and LOCAL_ICV_ID_IPAD_2_mask
            end If
        else
            read_LOCAL_ICV_ID_IPAD_2_value = data_low and LOCAL_ICV_ID_IPAD_2_mask
        end If

    End Sub

    Sub write
        If flag_LOCAL_ICV_ID_IPAD_2 = &H0 Then read
        If flag_LOCAL_ICV_ID_IPAD_2 = &H0 Then write_LOCAL_ICV_ID_IPAD_2_value = get_LOCAL_ICV_ID_IPAD_2

        regValue = leftShift((write_LOCAL_ICV_ID_IPAD_2_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_IPAD_2_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_IPAD_2_mask = mask then
                read_LOCAL_ICV_ID_IPAD_2_value = data_low
            else
                read_LOCAL_ICV_ID_IPAD_2_value = (data_low - H8000_0000) and LOCAL_ICV_ID_IPAD_2_mask
            end If
        else
            read_LOCAL_ICV_ID_IPAD_2_value = data_low and LOCAL_ICV_ID_IPAD_2_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LOCAL_ICV_ID_IPAD_2_value = &H0
        flag_LOCAL_ICV_ID_IPAD_2        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_local_icv_id_ipad2_p1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LOCAL_ICV_ID_IPAD_2                        [15:0]           get_LOCAL_ICV_ID_IPAD_2
''                                                             set_LOCAL_ICV_ID_IPAD_2
''                                                             read_LOCAL_ICV_ID_IPAD_2
''                                                             write_LOCAL_ICV_ID_IPAD_2
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_local_icv_id_ipad2_p1
    Private write_LOCAL_ICV_ID_IPAD_2_value
    Private read_LOCAL_ICV_ID_IPAD_2_value
    Private flag_LOCAL_ICV_ID_IPAD_2

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hc2
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_LOCAL_ICV_ID_IPAD_2
        get_LOCAL_ICV_ID_IPAD_2 = read_LOCAL_ICV_ID_IPAD_2_value
    End Property

    Property Let set_LOCAL_ICV_ID_IPAD_2(aData)
        write_LOCAL_ICV_ID_IPAD_2_value = aData
        flag_LOCAL_ICV_ID_IPAD_2        = &H1
    End Property

    Property Get read_LOCAL_ICV_ID_IPAD_2
        read
        read_LOCAL_ICV_ID_IPAD_2 = read_LOCAL_ICV_ID_IPAD_2_value
    End Property

    Property Let write_LOCAL_ICV_ID_IPAD_2(aData)
        set_LOCAL_ICV_ID_IPAD_2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_IPAD_2_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_IPAD_2_mask = mask then
                read_LOCAL_ICV_ID_IPAD_2_value = data_low
            else
                read_LOCAL_ICV_ID_IPAD_2_value = (data_low - H8000_0000) and LOCAL_ICV_ID_IPAD_2_mask
            end If
        else
            read_LOCAL_ICV_ID_IPAD_2_value = data_low and LOCAL_ICV_ID_IPAD_2_mask
        end If

    End Sub

    Sub write
        If flag_LOCAL_ICV_ID_IPAD_2 = &H0 Then read
        If flag_LOCAL_ICV_ID_IPAD_2 = &H0 Then write_LOCAL_ICV_ID_IPAD_2_value = get_LOCAL_ICV_ID_IPAD_2

        regValue = leftShift((write_LOCAL_ICV_ID_IPAD_2_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_IPAD_2_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_IPAD_2_mask = mask then
                read_LOCAL_ICV_ID_IPAD_2_value = data_low
            else
                read_LOCAL_ICV_ID_IPAD_2_value = (data_low - H8000_0000) and LOCAL_ICV_ID_IPAD_2_mask
            end If
        else
            read_LOCAL_ICV_ID_IPAD_2_value = data_low and LOCAL_ICV_ID_IPAD_2_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LOCAL_ICV_ID_IPAD_2_value = &H0
        flag_LOCAL_ICV_ID_IPAD_2        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_local_icv_id_ipad2_p2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LOCAL_ICV_ID_IPAD_2                        [15:0]           get_LOCAL_ICV_ID_IPAD_2
''                                                             set_LOCAL_ICV_ID_IPAD_2
''                                                             read_LOCAL_ICV_ID_IPAD_2
''                                                             write_LOCAL_ICV_ID_IPAD_2
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_local_icv_id_ipad2_p2
    Private write_LOCAL_ICV_ID_IPAD_2_value
    Private read_LOCAL_ICV_ID_IPAD_2_value
    Private flag_LOCAL_ICV_ID_IPAD_2

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

    Property Get get_LOCAL_ICV_ID_IPAD_2
        get_LOCAL_ICV_ID_IPAD_2 = read_LOCAL_ICV_ID_IPAD_2_value
    End Property

    Property Let set_LOCAL_ICV_ID_IPAD_2(aData)
        write_LOCAL_ICV_ID_IPAD_2_value = aData
        flag_LOCAL_ICV_ID_IPAD_2        = &H1
    End Property

    Property Get read_LOCAL_ICV_ID_IPAD_2
        read
        read_LOCAL_ICV_ID_IPAD_2 = read_LOCAL_ICV_ID_IPAD_2_value
    End Property

    Property Let write_LOCAL_ICV_ID_IPAD_2(aData)
        set_LOCAL_ICV_ID_IPAD_2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_IPAD_2_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_IPAD_2_mask = mask then
                read_LOCAL_ICV_ID_IPAD_2_value = data_low
            else
                read_LOCAL_ICV_ID_IPAD_2_value = (data_low - H8000_0000) and LOCAL_ICV_ID_IPAD_2_mask
            end If
        else
            read_LOCAL_ICV_ID_IPAD_2_value = data_low and LOCAL_ICV_ID_IPAD_2_mask
        end If

    End Sub

    Sub write
        If flag_LOCAL_ICV_ID_IPAD_2 = &H0 Then read
        If flag_LOCAL_ICV_ID_IPAD_2 = &H0 Then write_LOCAL_ICV_ID_IPAD_2_value = get_LOCAL_ICV_ID_IPAD_2

        regValue = leftShift((write_LOCAL_ICV_ID_IPAD_2_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_IPAD_2_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_IPAD_2_mask = mask then
                read_LOCAL_ICV_ID_IPAD_2_value = data_low
            else
                read_LOCAL_ICV_ID_IPAD_2_value = (data_low - H8000_0000) and LOCAL_ICV_ID_IPAD_2_mask
            end If
        else
            read_LOCAL_ICV_ID_IPAD_2_value = data_low and LOCAL_ICV_ID_IPAD_2_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LOCAL_ICV_ID_IPAD_2_value = &H0
        flag_LOCAL_ICV_ID_IPAD_2        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_local_icv_id_ipad2_p3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LOCAL_ICV_ID_IPAD_2                        [15:0]           get_LOCAL_ICV_ID_IPAD_2
''                                                             set_LOCAL_ICV_ID_IPAD_2
''                                                             read_LOCAL_ICV_ID_IPAD_2
''                                                             write_LOCAL_ICV_ID_IPAD_2
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_local_icv_id_ipad2_p3
    Private write_LOCAL_ICV_ID_IPAD_2_value
    Private read_LOCAL_ICV_ID_IPAD_2_value
    Private flag_LOCAL_ICV_ID_IPAD_2

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hc6
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_LOCAL_ICV_ID_IPAD_2
        get_LOCAL_ICV_ID_IPAD_2 = read_LOCAL_ICV_ID_IPAD_2_value
    End Property

    Property Let set_LOCAL_ICV_ID_IPAD_2(aData)
        write_LOCAL_ICV_ID_IPAD_2_value = aData
        flag_LOCAL_ICV_ID_IPAD_2        = &H1
    End Property

    Property Get read_LOCAL_ICV_ID_IPAD_2
        read
        read_LOCAL_ICV_ID_IPAD_2 = read_LOCAL_ICV_ID_IPAD_2_value
    End Property

    Property Let write_LOCAL_ICV_ID_IPAD_2(aData)
        set_LOCAL_ICV_ID_IPAD_2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_IPAD_2_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_IPAD_2_mask = mask then
                read_LOCAL_ICV_ID_IPAD_2_value = data_low
            else
                read_LOCAL_ICV_ID_IPAD_2_value = (data_low - H8000_0000) and LOCAL_ICV_ID_IPAD_2_mask
            end If
        else
            read_LOCAL_ICV_ID_IPAD_2_value = data_low and LOCAL_ICV_ID_IPAD_2_mask
        end If

    End Sub

    Sub write
        If flag_LOCAL_ICV_ID_IPAD_2 = &H0 Then read
        If flag_LOCAL_ICV_ID_IPAD_2 = &H0 Then write_LOCAL_ICV_ID_IPAD_2_value = get_LOCAL_ICV_ID_IPAD_2

        regValue = leftShift((write_LOCAL_ICV_ID_IPAD_2_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_IPAD_2_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_IPAD_2_mask = mask then
                read_LOCAL_ICV_ID_IPAD_2_value = data_low
            else
                read_LOCAL_ICV_ID_IPAD_2_value = (data_low - H8000_0000) and LOCAL_ICV_ID_IPAD_2_mask
            end If
        else
            read_LOCAL_ICV_ID_IPAD_2_value = data_low and LOCAL_ICV_ID_IPAD_2_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LOCAL_ICV_ID_IPAD_2_value = &H0
        flag_LOCAL_ICV_ID_IPAD_2        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_local_icv_id_ipad2_p4
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LOCAL_ICV_ID_IPAD_2                        [15:0]           get_LOCAL_ICV_ID_IPAD_2
''                                                             set_LOCAL_ICV_ID_IPAD_2
''                                                             read_LOCAL_ICV_ID_IPAD_2
''                                                             write_LOCAL_ICV_ID_IPAD_2
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_local_icv_id_ipad2_p4
    Private write_LOCAL_ICV_ID_IPAD_2_value
    Private read_LOCAL_ICV_ID_IPAD_2_value
    Private flag_LOCAL_ICV_ID_IPAD_2

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

    Property Get get_LOCAL_ICV_ID_IPAD_2
        get_LOCAL_ICV_ID_IPAD_2 = read_LOCAL_ICV_ID_IPAD_2_value
    End Property

    Property Let set_LOCAL_ICV_ID_IPAD_2(aData)
        write_LOCAL_ICV_ID_IPAD_2_value = aData
        flag_LOCAL_ICV_ID_IPAD_2        = &H1
    End Property

    Property Get read_LOCAL_ICV_ID_IPAD_2
        read
        read_LOCAL_ICV_ID_IPAD_2 = read_LOCAL_ICV_ID_IPAD_2_value
    End Property

    Property Let write_LOCAL_ICV_ID_IPAD_2(aData)
        set_LOCAL_ICV_ID_IPAD_2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_IPAD_2_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_IPAD_2_mask = mask then
                read_LOCAL_ICV_ID_IPAD_2_value = data_low
            else
                read_LOCAL_ICV_ID_IPAD_2_value = (data_low - H8000_0000) and LOCAL_ICV_ID_IPAD_2_mask
            end If
        else
            read_LOCAL_ICV_ID_IPAD_2_value = data_low and LOCAL_ICV_ID_IPAD_2_mask
        end If

    End Sub

    Sub write
        If flag_LOCAL_ICV_ID_IPAD_2 = &H0 Then read
        If flag_LOCAL_ICV_ID_IPAD_2 = &H0 Then write_LOCAL_ICV_ID_IPAD_2_value = get_LOCAL_ICV_ID_IPAD_2

        regValue = leftShift((write_LOCAL_ICV_ID_IPAD_2_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_IPAD_2_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_IPAD_2_mask = mask then
                read_LOCAL_ICV_ID_IPAD_2_value = data_low
            else
                read_LOCAL_ICV_ID_IPAD_2_value = (data_low - H8000_0000) and LOCAL_ICV_ID_IPAD_2_mask
            end If
        else
            read_LOCAL_ICV_ID_IPAD_2_value = data_low and LOCAL_ICV_ID_IPAD_2_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LOCAL_ICV_ID_IPAD_2_value = &H0
        flag_LOCAL_ICV_ID_IPAD_2        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_local_icv_id_ipad2_p5
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LOCAL_ICV_ID_IPAD_2                        [15:0]           get_LOCAL_ICV_ID_IPAD_2
''                                                             set_LOCAL_ICV_ID_IPAD_2
''                                                             read_LOCAL_ICV_ID_IPAD_2
''                                                             write_LOCAL_ICV_ID_IPAD_2
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_local_icv_id_ipad2_p5
    Private write_LOCAL_ICV_ID_IPAD_2_value
    Private read_LOCAL_ICV_ID_IPAD_2_value
    Private flag_LOCAL_ICV_ID_IPAD_2

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hca
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_LOCAL_ICV_ID_IPAD_2
        get_LOCAL_ICV_ID_IPAD_2 = read_LOCAL_ICV_ID_IPAD_2_value
    End Property

    Property Let set_LOCAL_ICV_ID_IPAD_2(aData)
        write_LOCAL_ICV_ID_IPAD_2_value = aData
        flag_LOCAL_ICV_ID_IPAD_2        = &H1
    End Property

    Property Get read_LOCAL_ICV_ID_IPAD_2
        read
        read_LOCAL_ICV_ID_IPAD_2 = read_LOCAL_ICV_ID_IPAD_2_value
    End Property

    Property Let write_LOCAL_ICV_ID_IPAD_2(aData)
        set_LOCAL_ICV_ID_IPAD_2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_IPAD_2_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_IPAD_2_mask = mask then
                read_LOCAL_ICV_ID_IPAD_2_value = data_low
            else
                read_LOCAL_ICV_ID_IPAD_2_value = (data_low - H8000_0000) and LOCAL_ICV_ID_IPAD_2_mask
            end If
        else
            read_LOCAL_ICV_ID_IPAD_2_value = data_low and LOCAL_ICV_ID_IPAD_2_mask
        end If

    End Sub

    Sub write
        If flag_LOCAL_ICV_ID_IPAD_2 = &H0 Then read
        If flag_LOCAL_ICV_ID_IPAD_2 = &H0 Then write_LOCAL_ICV_ID_IPAD_2_value = get_LOCAL_ICV_ID_IPAD_2

        regValue = leftShift((write_LOCAL_ICV_ID_IPAD_2_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_IPAD_2_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_IPAD_2_mask = mask then
                read_LOCAL_ICV_ID_IPAD_2_value = data_low
            else
                read_LOCAL_ICV_ID_IPAD_2_value = (data_low - H8000_0000) and LOCAL_ICV_ID_IPAD_2_mask
            end If
        else
            read_LOCAL_ICV_ID_IPAD_2_value = data_low and LOCAL_ICV_ID_IPAD_2_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LOCAL_ICV_ID_IPAD_2_value = &H0
        flag_LOCAL_ICV_ID_IPAD_2        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_local_icv_id_ipad3_p0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LOCAL_ICV_ID_IPAD_3                        [15:0]           get_LOCAL_ICV_ID_IPAD_3
''                                                             set_LOCAL_ICV_ID_IPAD_3
''                                                             read_LOCAL_ICV_ID_IPAD_3
''                                                             write_LOCAL_ICV_ID_IPAD_3
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_local_icv_id_ipad3_p0
    Private write_LOCAL_ICV_ID_IPAD_3_value
    Private read_LOCAL_ICV_ID_IPAD_3_value
    Private flag_LOCAL_ICV_ID_IPAD_3

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

    Property Get get_LOCAL_ICV_ID_IPAD_3
        get_LOCAL_ICV_ID_IPAD_3 = read_LOCAL_ICV_ID_IPAD_3_value
    End Property

    Property Let set_LOCAL_ICV_ID_IPAD_3(aData)
        write_LOCAL_ICV_ID_IPAD_3_value = aData
        flag_LOCAL_ICV_ID_IPAD_3        = &H1
    End Property

    Property Get read_LOCAL_ICV_ID_IPAD_3
        read
        read_LOCAL_ICV_ID_IPAD_3 = read_LOCAL_ICV_ID_IPAD_3_value
    End Property

    Property Let write_LOCAL_ICV_ID_IPAD_3(aData)
        set_LOCAL_ICV_ID_IPAD_3 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_IPAD_3_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_IPAD_3_mask = mask then
                read_LOCAL_ICV_ID_IPAD_3_value = data_low
            else
                read_LOCAL_ICV_ID_IPAD_3_value = (data_low - H8000_0000) and LOCAL_ICV_ID_IPAD_3_mask
            end If
        else
            read_LOCAL_ICV_ID_IPAD_3_value = data_low and LOCAL_ICV_ID_IPAD_3_mask
        end If

    End Sub

    Sub write
        If flag_LOCAL_ICV_ID_IPAD_3 = &H0 Then read
        If flag_LOCAL_ICV_ID_IPAD_3 = &H0 Then write_LOCAL_ICV_ID_IPAD_3_value = get_LOCAL_ICV_ID_IPAD_3

        regValue = leftShift((write_LOCAL_ICV_ID_IPAD_3_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_IPAD_3_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_IPAD_3_mask = mask then
                read_LOCAL_ICV_ID_IPAD_3_value = data_low
            else
                read_LOCAL_ICV_ID_IPAD_3_value = (data_low - H8000_0000) and LOCAL_ICV_ID_IPAD_3_mask
            end If
        else
            read_LOCAL_ICV_ID_IPAD_3_value = data_low and LOCAL_ICV_ID_IPAD_3_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LOCAL_ICV_ID_IPAD_3_value = &H0
        flag_LOCAL_ICV_ID_IPAD_3        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_local_icv_id_ipad3_p1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LOCAL_ICV_ID_IPAD_3                        [15:0]           get_LOCAL_ICV_ID_IPAD_3
''                                                             set_LOCAL_ICV_ID_IPAD_3
''                                                             read_LOCAL_ICV_ID_IPAD_3
''                                                             write_LOCAL_ICV_ID_IPAD_3
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_local_icv_id_ipad3_p1
    Private write_LOCAL_ICV_ID_IPAD_3_value
    Private read_LOCAL_ICV_ID_IPAD_3_value
    Private flag_LOCAL_ICV_ID_IPAD_3

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hd2
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_LOCAL_ICV_ID_IPAD_3
        get_LOCAL_ICV_ID_IPAD_3 = read_LOCAL_ICV_ID_IPAD_3_value
    End Property

    Property Let set_LOCAL_ICV_ID_IPAD_3(aData)
        write_LOCAL_ICV_ID_IPAD_3_value = aData
        flag_LOCAL_ICV_ID_IPAD_3        = &H1
    End Property

    Property Get read_LOCAL_ICV_ID_IPAD_3
        read
        read_LOCAL_ICV_ID_IPAD_3 = read_LOCAL_ICV_ID_IPAD_3_value
    End Property

    Property Let write_LOCAL_ICV_ID_IPAD_3(aData)
        set_LOCAL_ICV_ID_IPAD_3 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_IPAD_3_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_IPAD_3_mask = mask then
                read_LOCAL_ICV_ID_IPAD_3_value = data_low
            else
                read_LOCAL_ICV_ID_IPAD_3_value = (data_low - H8000_0000) and LOCAL_ICV_ID_IPAD_3_mask
            end If
        else
            read_LOCAL_ICV_ID_IPAD_3_value = data_low and LOCAL_ICV_ID_IPAD_3_mask
        end If

    End Sub

    Sub write
        If flag_LOCAL_ICV_ID_IPAD_3 = &H0 Then read
        If flag_LOCAL_ICV_ID_IPAD_3 = &H0 Then write_LOCAL_ICV_ID_IPAD_3_value = get_LOCAL_ICV_ID_IPAD_3

        regValue = leftShift((write_LOCAL_ICV_ID_IPAD_3_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_IPAD_3_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_IPAD_3_mask = mask then
                read_LOCAL_ICV_ID_IPAD_3_value = data_low
            else
                read_LOCAL_ICV_ID_IPAD_3_value = (data_low - H8000_0000) and LOCAL_ICV_ID_IPAD_3_mask
            end If
        else
            read_LOCAL_ICV_ID_IPAD_3_value = data_low and LOCAL_ICV_ID_IPAD_3_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LOCAL_ICV_ID_IPAD_3_value = &H0
        flag_LOCAL_ICV_ID_IPAD_3        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_local_icv_id_ipad3_p2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LOCAL_ICV_ID_IPAD_3                        [15:0]           get_LOCAL_ICV_ID_IPAD_3
''                                                             set_LOCAL_ICV_ID_IPAD_3
''                                                             read_LOCAL_ICV_ID_IPAD_3
''                                                             write_LOCAL_ICV_ID_IPAD_3
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_local_icv_id_ipad3_p2
    Private write_LOCAL_ICV_ID_IPAD_3_value
    Private read_LOCAL_ICV_ID_IPAD_3_value
    Private flag_LOCAL_ICV_ID_IPAD_3

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

    Property Get get_LOCAL_ICV_ID_IPAD_3
        get_LOCAL_ICV_ID_IPAD_3 = read_LOCAL_ICV_ID_IPAD_3_value
    End Property

    Property Let set_LOCAL_ICV_ID_IPAD_3(aData)
        write_LOCAL_ICV_ID_IPAD_3_value = aData
        flag_LOCAL_ICV_ID_IPAD_3        = &H1
    End Property

    Property Get read_LOCAL_ICV_ID_IPAD_3
        read
        read_LOCAL_ICV_ID_IPAD_3 = read_LOCAL_ICV_ID_IPAD_3_value
    End Property

    Property Let write_LOCAL_ICV_ID_IPAD_3(aData)
        set_LOCAL_ICV_ID_IPAD_3 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_IPAD_3_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_IPAD_3_mask = mask then
                read_LOCAL_ICV_ID_IPAD_3_value = data_low
            else
                read_LOCAL_ICV_ID_IPAD_3_value = (data_low - H8000_0000) and LOCAL_ICV_ID_IPAD_3_mask
            end If
        else
            read_LOCAL_ICV_ID_IPAD_3_value = data_low and LOCAL_ICV_ID_IPAD_3_mask
        end If

    End Sub

    Sub write
        If flag_LOCAL_ICV_ID_IPAD_3 = &H0 Then read
        If flag_LOCAL_ICV_ID_IPAD_3 = &H0 Then write_LOCAL_ICV_ID_IPAD_3_value = get_LOCAL_ICV_ID_IPAD_3

        regValue = leftShift((write_LOCAL_ICV_ID_IPAD_3_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_IPAD_3_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_IPAD_3_mask = mask then
                read_LOCAL_ICV_ID_IPAD_3_value = data_low
            else
                read_LOCAL_ICV_ID_IPAD_3_value = (data_low - H8000_0000) and LOCAL_ICV_ID_IPAD_3_mask
            end If
        else
            read_LOCAL_ICV_ID_IPAD_3_value = data_low and LOCAL_ICV_ID_IPAD_3_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LOCAL_ICV_ID_IPAD_3_value = &H0
        flag_LOCAL_ICV_ID_IPAD_3        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_local_icv_id_ipad3_p3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LOCAL_ICV_ID_IPAD_3                        [15:0]           get_LOCAL_ICV_ID_IPAD_3
''                                                             set_LOCAL_ICV_ID_IPAD_3
''                                                             read_LOCAL_ICV_ID_IPAD_3
''                                                             write_LOCAL_ICV_ID_IPAD_3
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_local_icv_id_ipad3_p3
    Private write_LOCAL_ICV_ID_IPAD_3_value
    Private read_LOCAL_ICV_ID_IPAD_3_value
    Private flag_LOCAL_ICV_ID_IPAD_3

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hd6
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_LOCAL_ICV_ID_IPAD_3
        get_LOCAL_ICV_ID_IPAD_3 = read_LOCAL_ICV_ID_IPAD_3_value
    End Property

    Property Let set_LOCAL_ICV_ID_IPAD_3(aData)
        write_LOCAL_ICV_ID_IPAD_3_value = aData
        flag_LOCAL_ICV_ID_IPAD_3        = &H1
    End Property

    Property Get read_LOCAL_ICV_ID_IPAD_3
        read
        read_LOCAL_ICV_ID_IPAD_3 = read_LOCAL_ICV_ID_IPAD_3_value
    End Property

    Property Let write_LOCAL_ICV_ID_IPAD_3(aData)
        set_LOCAL_ICV_ID_IPAD_3 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_IPAD_3_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_IPAD_3_mask = mask then
                read_LOCAL_ICV_ID_IPAD_3_value = data_low
            else
                read_LOCAL_ICV_ID_IPAD_3_value = (data_low - H8000_0000) and LOCAL_ICV_ID_IPAD_3_mask
            end If
        else
            read_LOCAL_ICV_ID_IPAD_3_value = data_low and LOCAL_ICV_ID_IPAD_3_mask
        end If

    End Sub

    Sub write
        If flag_LOCAL_ICV_ID_IPAD_3 = &H0 Then read
        If flag_LOCAL_ICV_ID_IPAD_3 = &H0 Then write_LOCAL_ICV_ID_IPAD_3_value = get_LOCAL_ICV_ID_IPAD_3

        regValue = leftShift((write_LOCAL_ICV_ID_IPAD_3_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_IPAD_3_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_IPAD_3_mask = mask then
                read_LOCAL_ICV_ID_IPAD_3_value = data_low
            else
                read_LOCAL_ICV_ID_IPAD_3_value = (data_low - H8000_0000) and LOCAL_ICV_ID_IPAD_3_mask
            end If
        else
            read_LOCAL_ICV_ID_IPAD_3_value = data_low and LOCAL_ICV_ID_IPAD_3_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LOCAL_ICV_ID_IPAD_3_value = &H0
        flag_LOCAL_ICV_ID_IPAD_3        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_local_icv_id_ipad3_p4
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LOCAL_ICV_ID_IPAD_3                        [15:0]           get_LOCAL_ICV_ID_IPAD_3
''                                                             set_LOCAL_ICV_ID_IPAD_3
''                                                             read_LOCAL_ICV_ID_IPAD_3
''                                                             write_LOCAL_ICV_ID_IPAD_3
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_local_icv_id_ipad3_p4
    Private write_LOCAL_ICV_ID_IPAD_3_value
    Private read_LOCAL_ICV_ID_IPAD_3_value
    Private flag_LOCAL_ICV_ID_IPAD_3

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

    Property Get get_LOCAL_ICV_ID_IPAD_3
        get_LOCAL_ICV_ID_IPAD_3 = read_LOCAL_ICV_ID_IPAD_3_value
    End Property

    Property Let set_LOCAL_ICV_ID_IPAD_3(aData)
        write_LOCAL_ICV_ID_IPAD_3_value = aData
        flag_LOCAL_ICV_ID_IPAD_3        = &H1
    End Property

    Property Get read_LOCAL_ICV_ID_IPAD_3
        read
        read_LOCAL_ICV_ID_IPAD_3 = read_LOCAL_ICV_ID_IPAD_3_value
    End Property

    Property Let write_LOCAL_ICV_ID_IPAD_3(aData)
        set_LOCAL_ICV_ID_IPAD_3 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_IPAD_3_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_IPAD_3_mask = mask then
                read_LOCAL_ICV_ID_IPAD_3_value = data_low
            else
                read_LOCAL_ICV_ID_IPAD_3_value = (data_low - H8000_0000) and LOCAL_ICV_ID_IPAD_3_mask
            end If
        else
            read_LOCAL_ICV_ID_IPAD_3_value = data_low and LOCAL_ICV_ID_IPAD_3_mask
        end If

    End Sub

    Sub write
        If flag_LOCAL_ICV_ID_IPAD_3 = &H0 Then read
        If flag_LOCAL_ICV_ID_IPAD_3 = &H0 Then write_LOCAL_ICV_ID_IPAD_3_value = get_LOCAL_ICV_ID_IPAD_3

        regValue = leftShift((write_LOCAL_ICV_ID_IPAD_3_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_IPAD_3_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_IPAD_3_mask = mask then
                read_LOCAL_ICV_ID_IPAD_3_value = data_low
            else
                read_LOCAL_ICV_ID_IPAD_3_value = (data_low - H8000_0000) and LOCAL_ICV_ID_IPAD_3_mask
            end If
        else
            read_LOCAL_ICV_ID_IPAD_3_value = data_low and LOCAL_ICV_ID_IPAD_3_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LOCAL_ICV_ID_IPAD_3_value = &H0
        flag_LOCAL_ICV_ID_IPAD_3        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_local_icv_id_ipad3_p5
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LOCAL_ICV_ID_IPAD_3                        [15:0]           get_LOCAL_ICV_ID_IPAD_3
''                                                             set_LOCAL_ICV_ID_IPAD_3
''                                                             read_LOCAL_ICV_ID_IPAD_3
''                                                             write_LOCAL_ICV_ID_IPAD_3
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_local_icv_id_ipad3_p5
    Private write_LOCAL_ICV_ID_IPAD_3_value
    Private read_LOCAL_ICV_ID_IPAD_3_value
    Private flag_LOCAL_ICV_ID_IPAD_3

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hda
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_LOCAL_ICV_ID_IPAD_3
        get_LOCAL_ICV_ID_IPAD_3 = read_LOCAL_ICV_ID_IPAD_3_value
    End Property

    Property Let set_LOCAL_ICV_ID_IPAD_3(aData)
        write_LOCAL_ICV_ID_IPAD_3_value = aData
        flag_LOCAL_ICV_ID_IPAD_3        = &H1
    End Property

    Property Get read_LOCAL_ICV_ID_IPAD_3
        read
        read_LOCAL_ICV_ID_IPAD_3 = read_LOCAL_ICV_ID_IPAD_3_value
    End Property

    Property Let write_LOCAL_ICV_ID_IPAD_3(aData)
        set_LOCAL_ICV_ID_IPAD_3 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_IPAD_3_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_IPAD_3_mask = mask then
                read_LOCAL_ICV_ID_IPAD_3_value = data_low
            else
                read_LOCAL_ICV_ID_IPAD_3_value = (data_low - H8000_0000) and LOCAL_ICV_ID_IPAD_3_mask
            end If
        else
            read_LOCAL_ICV_ID_IPAD_3_value = data_low and LOCAL_ICV_ID_IPAD_3_mask
        end If

    End Sub

    Sub write
        If flag_LOCAL_ICV_ID_IPAD_3 = &H0 Then read
        If flag_LOCAL_ICV_ID_IPAD_3 = &H0 Then write_LOCAL_ICV_ID_IPAD_3_value = get_LOCAL_ICV_ID_IPAD_3

        regValue = leftShift((write_LOCAL_ICV_ID_IPAD_3_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_IPAD_3_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_IPAD_3_mask = mask then
                read_LOCAL_ICV_ID_IPAD_3_value = data_low
            else
                read_LOCAL_ICV_ID_IPAD_3_value = (data_low - H8000_0000) and LOCAL_ICV_ID_IPAD_3_mask
            end If
        else
            read_LOCAL_ICV_ID_IPAD_3_value = data_low and LOCAL_ICV_ID_IPAD_3_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LOCAL_ICV_ID_IPAD_3_value = &H0
        flag_LOCAL_ICV_ID_IPAD_3        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_remote_icv_id_ipad0_p0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' REMOTE_ICV_ID_IPAD_0                       [15:0]           get_REMOTE_ICV_ID_IPAD_0
''                                                             set_REMOTE_ICV_ID_IPAD_0
''                                                             read_REMOTE_ICV_ID_IPAD_0
''                                                             write_REMOTE_ICV_ID_IPAD_0
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_remote_icv_id_ipad0_p0
    Private write_REMOTE_ICV_ID_IPAD_0_value
    Private read_REMOTE_ICV_ID_IPAD_0_value
    Private flag_REMOTE_ICV_ID_IPAD_0

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

    Property Get get_REMOTE_ICV_ID_IPAD_0
        get_REMOTE_ICV_ID_IPAD_0 = read_REMOTE_ICV_ID_IPAD_0_value
    End Property

    Property Let set_REMOTE_ICV_ID_IPAD_0(aData)
        write_REMOTE_ICV_ID_IPAD_0_value = aData
        flag_REMOTE_ICV_ID_IPAD_0        = &H1
    End Property

    Property Get read_REMOTE_ICV_ID_IPAD_0
        read
        read_REMOTE_ICV_ID_IPAD_0 = read_REMOTE_ICV_ID_IPAD_0_value
    End Property

    Property Let write_REMOTE_ICV_ID_IPAD_0(aData)
        set_REMOTE_ICV_ID_IPAD_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_IPAD_0_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_IPAD_0_mask = mask then
                read_REMOTE_ICV_ID_IPAD_0_value = data_low
            else
                read_REMOTE_ICV_ID_IPAD_0_value = (data_low - H8000_0000) and REMOTE_ICV_ID_IPAD_0_mask
            end If
        else
            read_REMOTE_ICV_ID_IPAD_0_value = data_low and REMOTE_ICV_ID_IPAD_0_mask
        end If

    End Sub

    Sub write
        If flag_REMOTE_ICV_ID_IPAD_0 = &H0 Then read
        If flag_REMOTE_ICV_ID_IPAD_0 = &H0 Then write_REMOTE_ICV_ID_IPAD_0_value = get_REMOTE_ICV_ID_IPAD_0

        regValue = leftShift((write_REMOTE_ICV_ID_IPAD_0_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_IPAD_0_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_IPAD_0_mask = mask then
                read_REMOTE_ICV_ID_IPAD_0_value = data_low
            else
                read_REMOTE_ICV_ID_IPAD_0_value = (data_low - H8000_0000) and REMOTE_ICV_ID_IPAD_0_mask
            end If
        else
            read_REMOTE_ICV_ID_IPAD_0_value = data_low and REMOTE_ICV_ID_IPAD_0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_REMOTE_ICV_ID_IPAD_0_value = &H0
        flag_REMOTE_ICV_ID_IPAD_0        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_remote_icv_id_ipad0_p1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' REMOTE_ICV_ID_IPAD_0                       [15:0]           get_REMOTE_ICV_ID_IPAD_0
''                                                             set_REMOTE_ICV_ID_IPAD_0
''                                                             read_REMOTE_ICV_ID_IPAD_0
''                                                             write_REMOTE_ICV_ID_IPAD_0
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_remote_icv_id_ipad0_p1
    Private write_REMOTE_ICV_ID_IPAD_0_value
    Private read_REMOTE_ICV_ID_IPAD_0_value
    Private flag_REMOTE_ICV_ID_IPAD_0

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &He2
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_REMOTE_ICV_ID_IPAD_0
        get_REMOTE_ICV_ID_IPAD_0 = read_REMOTE_ICV_ID_IPAD_0_value
    End Property

    Property Let set_REMOTE_ICV_ID_IPAD_0(aData)
        write_REMOTE_ICV_ID_IPAD_0_value = aData
        flag_REMOTE_ICV_ID_IPAD_0        = &H1
    End Property

    Property Get read_REMOTE_ICV_ID_IPAD_0
        read
        read_REMOTE_ICV_ID_IPAD_0 = read_REMOTE_ICV_ID_IPAD_0_value
    End Property

    Property Let write_REMOTE_ICV_ID_IPAD_0(aData)
        set_REMOTE_ICV_ID_IPAD_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_IPAD_0_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_IPAD_0_mask = mask then
                read_REMOTE_ICV_ID_IPAD_0_value = data_low
            else
                read_REMOTE_ICV_ID_IPAD_0_value = (data_low - H8000_0000) and REMOTE_ICV_ID_IPAD_0_mask
            end If
        else
            read_REMOTE_ICV_ID_IPAD_0_value = data_low and REMOTE_ICV_ID_IPAD_0_mask
        end If

    End Sub

    Sub write
        If flag_REMOTE_ICV_ID_IPAD_0 = &H0 Then read
        If flag_REMOTE_ICV_ID_IPAD_0 = &H0 Then write_REMOTE_ICV_ID_IPAD_0_value = get_REMOTE_ICV_ID_IPAD_0

        regValue = leftShift((write_REMOTE_ICV_ID_IPAD_0_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_IPAD_0_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_IPAD_0_mask = mask then
                read_REMOTE_ICV_ID_IPAD_0_value = data_low
            else
                read_REMOTE_ICV_ID_IPAD_0_value = (data_low - H8000_0000) and REMOTE_ICV_ID_IPAD_0_mask
            end If
        else
            read_REMOTE_ICV_ID_IPAD_0_value = data_low and REMOTE_ICV_ID_IPAD_0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_REMOTE_ICV_ID_IPAD_0_value = &H0
        flag_REMOTE_ICV_ID_IPAD_0        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_remote_icv_id_ipad0_p2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' REMOTE_ICV_ID_IPAD_0                       [15:0]           get_REMOTE_ICV_ID_IPAD_0
''                                                             set_REMOTE_ICV_ID_IPAD_0
''                                                             read_REMOTE_ICV_ID_IPAD_0
''                                                             write_REMOTE_ICV_ID_IPAD_0
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_remote_icv_id_ipad0_p2
    Private write_REMOTE_ICV_ID_IPAD_0_value
    Private read_REMOTE_ICV_ID_IPAD_0_value
    Private flag_REMOTE_ICV_ID_IPAD_0

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

    Property Get get_REMOTE_ICV_ID_IPAD_0
        get_REMOTE_ICV_ID_IPAD_0 = read_REMOTE_ICV_ID_IPAD_0_value
    End Property

    Property Let set_REMOTE_ICV_ID_IPAD_0(aData)
        write_REMOTE_ICV_ID_IPAD_0_value = aData
        flag_REMOTE_ICV_ID_IPAD_0        = &H1
    End Property

    Property Get read_REMOTE_ICV_ID_IPAD_0
        read
        read_REMOTE_ICV_ID_IPAD_0 = read_REMOTE_ICV_ID_IPAD_0_value
    End Property

    Property Let write_REMOTE_ICV_ID_IPAD_0(aData)
        set_REMOTE_ICV_ID_IPAD_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_IPAD_0_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_IPAD_0_mask = mask then
                read_REMOTE_ICV_ID_IPAD_0_value = data_low
            else
                read_REMOTE_ICV_ID_IPAD_0_value = (data_low - H8000_0000) and REMOTE_ICV_ID_IPAD_0_mask
            end If
        else
            read_REMOTE_ICV_ID_IPAD_0_value = data_low and REMOTE_ICV_ID_IPAD_0_mask
        end If

    End Sub

    Sub write
        If flag_REMOTE_ICV_ID_IPAD_0 = &H0 Then read
        If flag_REMOTE_ICV_ID_IPAD_0 = &H0 Then write_REMOTE_ICV_ID_IPAD_0_value = get_REMOTE_ICV_ID_IPAD_0

        regValue = leftShift((write_REMOTE_ICV_ID_IPAD_0_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_IPAD_0_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_IPAD_0_mask = mask then
                read_REMOTE_ICV_ID_IPAD_0_value = data_low
            else
                read_REMOTE_ICV_ID_IPAD_0_value = (data_low - H8000_0000) and REMOTE_ICV_ID_IPAD_0_mask
            end If
        else
            read_REMOTE_ICV_ID_IPAD_0_value = data_low and REMOTE_ICV_ID_IPAD_0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_REMOTE_ICV_ID_IPAD_0_value = &H0
        flag_REMOTE_ICV_ID_IPAD_0        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_remote_icv_id_ipad0_p3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' REMOTE_ICV_ID_IPAD_0                       [15:0]           get_REMOTE_ICV_ID_IPAD_0
''                                                             set_REMOTE_ICV_ID_IPAD_0
''                                                             read_REMOTE_ICV_ID_IPAD_0
''                                                             write_REMOTE_ICV_ID_IPAD_0
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_remote_icv_id_ipad0_p3
    Private write_REMOTE_ICV_ID_IPAD_0_value
    Private read_REMOTE_ICV_ID_IPAD_0_value
    Private flag_REMOTE_ICV_ID_IPAD_0

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &He6
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_REMOTE_ICV_ID_IPAD_0
        get_REMOTE_ICV_ID_IPAD_0 = read_REMOTE_ICV_ID_IPAD_0_value
    End Property

    Property Let set_REMOTE_ICV_ID_IPAD_0(aData)
        write_REMOTE_ICV_ID_IPAD_0_value = aData
        flag_REMOTE_ICV_ID_IPAD_0        = &H1
    End Property

    Property Get read_REMOTE_ICV_ID_IPAD_0
        read
        read_REMOTE_ICV_ID_IPAD_0 = read_REMOTE_ICV_ID_IPAD_0_value
    End Property

    Property Let write_REMOTE_ICV_ID_IPAD_0(aData)
        set_REMOTE_ICV_ID_IPAD_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_IPAD_0_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_IPAD_0_mask = mask then
                read_REMOTE_ICV_ID_IPAD_0_value = data_low
            else
                read_REMOTE_ICV_ID_IPAD_0_value = (data_low - H8000_0000) and REMOTE_ICV_ID_IPAD_0_mask
            end If
        else
            read_REMOTE_ICV_ID_IPAD_0_value = data_low and REMOTE_ICV_ID_IPAD_0_mask
        end If

    End Sub

    Sub write
        If flag_REMOTE_ICV_ID_IPAD_0 = &H0 Then read
        If flag_REMOTE_ICV_ID_IPAD_0 = &H0 Then write_REMOTE_ICV_ID_IPAD_0_value = get_REMOTE_ICV_ID_IPAD_0

        regValue = leftShift((write_REMOTE_ICV_ID_IPAD_0_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_IPAD_0_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_IPAD_0_mask = mask then
                read_REMOTE_ICV_ID_IPAD_0_value = data_low
            else
                read_REMOTE_ICV_ID_IPAD_0_value = (data_low - H8000_0000) and REMOTE_ICV_ID_IPAD_0_mask
            end If
        else
            read_REMOTE_ICV_ID_IPAD_0_value = data_low and REMOTE_ICV_ID_IPAD_0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_REMOTE_ICV_ID_IPAD_0_value = &H0
        flag_REMOTE_ICV_ID_IPAD_0        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_remote_icv_id_ipad0_p4
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' REMOTE_ICV_ID_IPAD_0                       [15:0]           get_REMOTE_ICV_ID_IPAD_0
''                                                             set_REMOTE_ICV_ID_IPAD_0
''                                                             read_REMOTE_ICV_ID_IPAD_0
''                                                             write_REMOTE_ICV_ID_IPAD_0
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_remote_icv_id_ipad0_p4
    Private write_REMOTE_ICV_ID_IPAD_0_value
    Private read_REMOTE_ICV_ID_IPAD_0_value
    Private flag_REMOTE_ICV_ID_IPAD_0

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

    Property Get get_REMOTE_ICV_ID_IPAD_0
        get_REMOTE_ICV_ID_IPAD_0 = read_REMOTE_ICV_ID_IPAD_0_value
    End Property

    Property Let set_REMOTE_ICV_ID_IPAD_0(aData)
        write_REMOTE_ICV_ID_IPAD_0_value = aData
        flag_REMOTE_ICV_ID_IPAD_0        = &H1
    End Property

    Property Get read_REMOTE_ICV_ID_IPAD_0
        read
        read_REMOTE_ICV_ID_IPAD_0 = read_REMOTE_ICV_ID_IPAD_0_value
    End Property

    Property Let write_REMOTE_ICV_ID_IPAD_0(aData)
        set_REMOTE_ICV_ID_IPAD_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_IPAD_0_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_IPAD_0_mask = mask then
                read_REMOTE_ICV_ID_IPAD_0_value = data_low
            else
                read_REMOTE_ICV_ID_IPAD_0_value = (data_low - H8000_0000) and REMOTE_ICV_ID_IPAD_0_mask
            end If
        else
            read_REMOTE_ICV_ID_IPAD_0_value = data_low and REMOTE_ICV_ID_IPAD_0_mask
        end If

    End Sub

    Sub write
        If flag_REMOTE_ICV_ID_IPAD_0 = &H0 Then read
        If flag_REMOTE_ICV_ID_IPAD_0 = &H0 Then write_REMOTE_ICV_ID_IPAD_0_value = get_REMOTE_ICV_ID_IPAD_0

        regValue = leftShift((write_REMOTE_ICV_ID_IPAD_0_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_IPAD_0_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_IPAD_0_mask = mask then
                read_REMOTE_ICV_ID_IPAD_0_value = data_low
            else
                read_REMOTE_ICV_ID_IPAD_0_value = (data_low - H8000_0000) and REMOTE_ICV_ID_IPAD_0_mask
            end If
        else
            read_REMOTE_ICV_ID_IPAD_0_value = data_low and REMOTE_ICV_ID_IPAD_0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_REMOTE_ICV_ID_IPAD_0_value = &H0
        flag_REMOTE_ICV_ID_IPAD_0        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_remote_icv_id_ipad0_p5
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' REMOTE_ICV_ID_IPAD_0                       [15:0]           get_REMOTE_ICV_ID_IPAD_0
''                                                             set_REMOTE_ICV_ID_IPAD_0
''                                                             read_REMOTE_ICV_ID_IPAD_0
''                                                             write_REMOTE_ICV_ID_IPAD_0
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_remote_icv_id_ipad0_p5
    Private write_REMOTE_ICV_ID_IPAD_0_value
    Private read_REMOTE_ICV_ID_IPAD_0_value
    Private flag_REMOTE_ICV_ID_IPAD_0

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hea
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_REMOTE_ICV_ID_IPAD_0
        get_REMOTE_ICV_ID_IPAD_0 = read_REMOTE_ICV_ID_IPAD_0_value
    End Property

    Property Let set_REMOTE_ICV_ID_IPAD_0(aData)
        write_REMOTE_ICV_ID_IPAD_0_value = aData
        flag_REMOTE_ICV_ID_IPAD_0        = &H1
    End Property

    Property Get read_REMOTE_ICV_ID_IPAD_0
        read
        read_REMOTE_ICV_ID_IPAD_0 = read_REMOTE_ICV_ID_IPAD_0_value
    End Property

    Property Let write_REMOTE_ICV_ID_IPAD_0(aData)
        set_REMOTE_ICV_ID_IPAD_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_IPAD_0_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_IPAD_0_mask = mask then
                read_REMOTE_ICV_ID_IPAD_0_value = data_low
            else
                read_REMOTE_ICV_ID_IPAD_0_value = (data_low - H8000_0000) and REMOTE_ICV_ID_IPAD_0_mask
            end If
        else
            read_REMOTE_ICV_ID_IPAD_0_value = data_low and REMOTE_ICV_ID_IPAD_0_mask
        end If

    End Sub

    Sub write
        If flag_REMOTE_ICV_ID_IPAD_0 = &H0 Then read
        If flag_REMOTE_ICV_ID_IPAD_0 = &H0 Then write_REMOTE_ICV_ID_IPAD_0_value = get_REMOTE_ICV_ID_IPAD_0

        regValue = leftShift((write_REMOTE_ICV_ID_IPAD_0_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_IPAD_0_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_IPAD_0_mask = mask then
                read_REMOTE_ICV_ID_IPAD_0_value = data_low
            else
                read_REMOTE_ICV_ID_IPAD_0_value = (data_low - H8000_0000) and REMOTE_ICV_ID_IPAD_0_mask
            end If
        else
            read_REMOTE_ICV_ID_IPAD_0_value = data_low and REMOTE_ICV_ID_IPAD_0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_REMOTE_ICV_ID_IPAD_0_value = &H0
        flag_REMOTE_ICV_ID_IPAD_0        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_remote_icv_id_ipad1_p0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' REMOTE_ICV_ID_IPAD_1                       [15:0]           get_REMOTE_ICV_ID_IPAD_1
''                                                             set_REMOTE_ICV_ID_IPAD_1
''                                                             read_REMOTE_ICV_ID_IPAD_1
''                                                             write_REMOTE_ICV_ID_IPAD_1
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_remote_icv_id_ipad1_p0
    Private write_REMOTE_ICV_ID_IPAD_1_value
    Private read_REMOTE_ICV_ID_IPAD_1_value
    Private flag_REMOTE_ICV_ID_IPAD_1

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

    Property Get get_REMOTE_ICV_ID_IPAD_1
        get_REMOTE_ICV_ID_IPAD_1 = read_REMOTE_ICV_ID_IPAD_1_value
    End Property

    Property Let set_REMOTE_ICV_ID_IPAD_1(aData)
        write_REMOTE_ICV_ID_IPAD_1_value = aData
        flag_REMOTE_ICV_ID_IPAD_1        = &H1
    End Property

    Property Get read_REMOTE_ICV_ID_IPAD_1
        read
        read_REMOTE_ICV_ID_IPAD_1 = read_REMOTE_ICV_ID_IPAD_1_value
    End Property

    Property Let write_REMOTE_ICV_ID_IPAD_1(aData)
        set_REMOTE_ICV_ID_IPAD_1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_IPAD_1_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_IPAD_1_mask = mask then
                read_REMOTE_ICV_ID_IPAD_1_value = data_low
            else
                read_REMOTE_ICV_ID_IPAD_1_value = (data_low - H8000_0000) and REMOTE_ICV_ID_IPAD_1_mask
            end If
        else
            read_REMOTE_ICV_ID_IPAD_1_value = data_low and REMOTE_ICV_ID_IPAD_1_mask
        end If

    End Sub

    Sub write
        If flag_REMOTE_ICV_ID_IPAD_1 = &H0 Then read
        If flag_REMOTE_ICV_ID_IPAD_1 = &H0 Then write_REMOTE_ICV_ID_IPAD_1_value = get_REMOTE_ICV_ID_IPAD_1

        regValue = leftShift((write_REMOTE_ICV_ID_IPAD_1_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_IPAD_1_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_IPAD_1_mask = mask then
                read_REMOTE_ICV_ID_IPAD_1_value = data_low
            else
                read_REMOTE_ICV_ID_IPAD_1_value = (data_low - H8000_0000) and REMOTE_ICV_ID_IPAD_1_mask
            end If
        else
            read_REMOTE_ICV_ID_IPAD_1_value = data_low and REMOTE_ICV_ID_IPAD_1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_REMOTE_ICV_ID_IPAD_1_value = &H0
        flag_REMOTE_ICV_ID_IPAD_1        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_remote_icv_id_ipad1_p1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' REMOTE_ICV_ID_IPAD_1                       [15:0]           get_REMOTE_ICV_ID_IPAD_1
''                                                             set_REMOTE_ICV_ID_IPAD_1
''                                                             read_REMOTE_ICV_ID_IPAD_1
''                                                             write_REMOTE_ICV_ID_IPAD_1
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_remote_icv_id_ipad1_p1
    Private write_REMOTE_ICV_ID_IPAD_1_value
    Private read_REMOTE_ICV_ID_IPAD_1_value
    Private flag_REMOTE_ICV_ID_IPAD_1

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hf2
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_REMOTE_ICV_ID_IPAD_1
        get_REMOTE_ICV_ID_IPAD_1 = read_REMOTE_ICV_ID_IPAD_1_value
    End Property

    Property Let set_REMOTE_ICV_ID_IPAD_1(aData)
        write_REMOTE_ICV_ID_IPAD_1_value = aData
        flag_REMOTE_ICV_ID_IPAD_1        = &H1
    End Property

    Property Get read_REMOTE_ICV_ID_IPAD_1
        read
        read_REMOTE_ICV_ID_IPAD_1 = read_REMOTE_ICV_ID_IPAD_1_value
    End Property

    Property Let write_REMOTE_ICV_ID_IPAD_1(aData)
        set_REMOTE_ICV_ID_IPAD_1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_IPAD_1_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_IPAD_1_mask = mask then
                read_REMOTE_ICV_ID_IPAD_1_value = data_low
            else
                read_REMOTE_ICV_ID_IPAD_1_value = (data_low - H8000_0000) and REMOTE_ICV_ID_IPAD_1_mask
            end If
        else
            read_REMOTE_ICV_ID_IPAD_1_value = data_low and REMOTE_ICV_ID_IPAD_1_mask
        end If

    End Sub

    Sub write
        If flag_REMOTE_ICV_ID_IPAD_1 = &H0 Then read
        If flag_REMOTE_ICV_ID_IPAD_1 = &H0 Then write_REMOTE_ICV_ID_IPAD_1_value = get_REMOTE_ICV_ID_IPAD_1

        regValue = leftShift((write_REMOTE_ICV_ID_IPAD_1_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_IPAD_1_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_IPAD_1_mask = mask then
                read_REMOTE_ICV_ID_IPAD_1_value = data_low
            else
                read_REMOTE_ICV_ID_IPAD_1_value = (data_low - H8000_0000) and REMOTE_ICV_ID_IPAD_1_mask
            end If
        else
            read_REMOTE_ICV_ID_IPAD_1_value = data_low and REMOTE_ICV_ID_IPAD_1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_REMOTE_ICV_ID_IPAD_1_value = &H0
        flag_REMOTE_ICV_ID_IPAD_1        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_remote_icv_id_ipad1_p2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' REMOTE_ICV_ID_IPAD_1                       [15:0]           get_REMOTE_ICV_ID_IPAD_1
''                                                             set_REMOTE_ICV_ID_IPAD_1
''                                                             read_REMOTE_ICV_ID_IPAD_1
''                                                             write_REMOTE_ICV_ID_IPAD_1
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_remote_icv_id_ipad1_p2
    Private write_REMOTE_ICV_ID_IPAD_1_value
    Private read_REMOTE_ICV_ID_IPAD_1_value
    Private flag_REMOTE_ICV_ID_IPAD_1

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

    Property Get get_REMOTE_ICV_ID_IPAD_1
        get_REMOTE_ICV_ID_IPAD_1 = read_REMOTE_ICV_ID_IPAD_1_value
    End Property

    Property Let set_REMOTE_ICV_ID_IPAD_1(aData)
        write_REMOTE_ICV_ID_IPAD_1_value = aData
        flag_REMOTE_ICV_ID_IPAD_1        = &H1
    End Property

    Property Get read_REMOTE_ICV_ID_IPAD_1
        read
        read_REMOTE_ICV_ID_IPAD_1 = read_REMOTE_ICV_ID_IPAD_1_value
    End Property

    Property Let write_REMOTE_ICV_ID_IPAD_1(aData)
        set_REMOTE_ICV_ID_IPAD_1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_IPAD_1_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_IPAD_1_mask = mask then
                read_REMOTE_ICV_ID_IPAD_1_value = data_low
            else
                read_REMOTE_ICV_ID_IPAD_1_value = (data_low - H8000_0000) and REMOTE_ICV_ID_IPAD_1_mask
            end If
        else
            read_REMOTE_ICV_ID_IPAD_1_value = data_low and REMOTE_ICV_ID_IPAD_1_mask
        end If

    End Sub

    Sub write
        If flag_REMOTE_ICV_ID_IPAD_1 = &H0 Then read
        If flag_REMOTE_ICV_ID_IPAD_1 = &H0 Then write_REMOTE_ICV_ID_IPAD_1_value = get_REMOTE_ICV_ID_IPAD_1

        regValue = leftShift((write_REMOTE_ICV_ID_IPAD_1_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_IPAD_1_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_IPAD_1_mask = mask then
                read_REMOTE_ICV_ID_IPAD_1_value = data_low
            else
                read_REMOTE_ICV_ID_IPAD_1_value = (data_low - H8000_0000) and REMOTE_ICV_ID_IPAD_1_mask
            end If
        else
            read_REMOTE_ICV_ID_IPAD_1_value = data_low and REMOTE_ICV_ID_IPAD_1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_REMOTE_ICV_ID_IPAD_1_value = &H0
        flag_REMOTE_ICV_ID_IPAD_1        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_remote_icv_id_ipad1_p3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' REMOTE_ICV_ID_IPAD_1                       [15:0]           get_REMOTE_ICV_ID_IPAD_1
''                                                             set_REMOTE_ICV_ID_IPAD_1
''                                                             read_REMOTE_ICV_ID_IPAD_1
''                                                             write_REMOTE_ICV_ID_IPAD_1
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_remote_icv_id_ipad1_p3
    Private write_REMOTE_ICV_ID_IPAD_1_value
    Private read_REMOTE_ICV_ID_IPAD_1_value
    Private flag_REMOTE_ICV_ID_IPAD_1

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hf6
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_REMOTE_ICV_ID_IPAD_1
        get_REMOTE_ICV_ID_IPAD_1 = read_REMOTE_ICV_ID_IPAD_1_value
    End Property

    Property Let set_REMOTE_ICV_ID_IPAD_1(aData)
        write_REMOTE_ICV_ID_IPAD_1_value = aData
        flag_REMOTE_ICV_ID_IPAD_1        = &H1
    End Property

    Property Get read_REMOTE_ICV_ID_IPAD_1
        read
        read_REMOTE_ICV_ID_IPAD_1 = read_REMOTE_ICV_ID_IPAD_1_value
    End Property

    Property Let write_REMOTE_ICV_ID_IPAD_1(aData)
        set_REMOTE_ICV_ID_IPAD_1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_IPAD_1_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_IPAD_1_mask = mask then
                read_REMOTE_ICV_ID_IPAD_1_value = data_low
            else
                read_REMOTE_ICV_ID_IPAD_1_value = (data_low - H8000_0000) and REMOTE_ICV_ID_IPAD_1_mask
            end If
        else
            read_REMOTE_ICV_ID_IPAD_1_value = data_low and REMOTE_ICV_ID_IPAD_1_mask
        end If

    End Sub

    Sub write
        If flag_REMOTE_ICV_ID_IPAD_1 = &H0 Then read
        If flag_REMOTE_ICV_ID_IPAD_1 = &H0 Then write_REMOTE_ICV_ID_IPAD_1_value = get_REMOTE_ICV_ID_IPAD_1

        regValue = leftShift((write_REMOTE_ICV_ID_IPAD_1_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_IPAD_1_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_IPAD_1_mask = mask then
                read_REMOTE_ICV_ID_IPAD_1_value = data_low
            else
                read_REMOTE_ICV_ID_IPAD_1_value = (data_low - H8000_0000) and REMOTE_ICV_ID_IPAD_1_mask
            end If
        else
            read_REMOTE_ICV_ID_IPAD_1_value = data_low and REMOTE_ICV_ID_IPAD_1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_REMOTE_ICV_ID_IPAD_1_value = &H0
        flag_REMOTE_ICV_ID_IPAD_1        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_remote_icv_id_ipad1_p4
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' REMOTE_ICV_ID_IPAD_1                       [15:0]           get_REMOTE_ICV_ID_IPAD_1
''                                                             set_REMOTE_ICV_ID_IPAD_1
''                                                             read_REMOTE_ICV_ID_IPAD_1
''                                                             write_REMOTE_ICV_ID_IPAD_1
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_remote_icv_id_ipad1_p4
    Private write_REMOTE_ICV_ID_IPAD_1_value
    Private read_REMOTE_ICV_ID_IPAD_1_value
    Private flag_REMOTE_ICV_ID_IPAD_1

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

    Property Get get_REMOTE_ICV_ID_IPAD_1
        get_REMOTE_ICV_ID_IPAD_1 = read_REMOTE_ICV_ID_IPAD_1_value
    End Property

    Property Let set_REMOTE_ICV_ID_IPAD_1(aData)
        write_REMOTE_ICV_ID_IPAD_1_value = aData
        flag_REMOTE_ICV_ID_IPAD_1        = &H1
    End Property

    Property Get read_REMOTE_ICV_ID_IPAD_1
        read
        read_REMOTE_ICV_ID_IPAD_1 = read_REMOTE_ICV_ID_IPAD_1_value
    End Property

    Property Let write_REMOTE_ICV_ID_IPAD_1(aData)
        set_REMOTE_ICV_ID_IPAD_1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_IPAD_1_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_IPAD_1_mask = mask then
                read_REMOTE_ICV_ID_IPAD_1_value = data_low
            else
                read_REMOTE_ICV_ID_IPAD_1_value = (data_low - H8000_0000) and REMOTE_ICV_ID_IPAD_1_mask
            end If
        else
            read_REMOTE_ICV_ID_IPAD_1_value = data_low and REMOTE_ICV_ID_IPAD_1_mask
        end If

    End Sub

    Sub write
        If flag_REMOTE_ICV_ID_IPAD_1 = &H0 Then read
        If flag_REMOTE_ICV_ID_IPAD_1 = &H0 Then write_REMOTE_ICV_ID_IPAD_1_value = get_REMOTE_ICV_ID_IPAD_1

        regValue = leftShift((write_REMOTE_ICV_ID_IPAD_1_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_IPAD_1_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_IPAD_1_mask = mask then
                read_REMOTE_ICV_ID_IPAD_1_value = data_low
            else
                read_REMOTE_ICV_ID_IPAD_1_value = (data_low - H8000_0000) and REMOTE_ICV_ID_IPAD_1_mask
            end If
        else
            read_REMOTE_ICV_ID_IPAD_1_value = data_low and REMOTE_ICV_ID_IPAD_1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_REMOTE_ICV_ID_IPAD_1_value = &H0
        flag_REMOTE_ICV_ID_IPAD_1        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_remote_icv_id_ipad1_p5
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' REMOTE_ICV_ID_IPAD_1                       [15:0]           get_REMOTE_ICV_ID_IPAD_1
''                                                             set_REMOTE_ICV_ID_IPAD_1
''                                                             read_REMOTE_ICV_ID_IPAD_1
''                                                             write_REMOTE_ICV_ID_IPAD_1
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_remote_icv_id_ipad1_p5
    Private write_REMOTE_ICV_ID_IPAD_1_value
    Private read_REMOTE_ICV_ID_IPAD_1_value
    Private flag_REMOTE_ICV_ID_IPAD_1

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hfa
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_REMOTE_ICV_ID_IPAD_1
        get_REMOTE_ICV_ID_IPAD_1 = read_REMOTE_ICV_ID_IPAD_1_value
    End Property

    Property Let set_REMOTE_ICV_ID_IPAD_1(aData)
        write_REMOTE_ICV_ID_IPAD_1_value = aData
        flag_REMOTE_ICV_ID_IPAD_1        = &H1
    End Property

    Property Get read_REMOTE_ICV_ID_IPAD_1
        read
        read_REMOTE_ICV_ID_IPAD_1 = read_REMOTE_ICV_ID_IPAD_1_value
    End Property

    Property Let write_REMOTE_ICV_ID_IPAD_1(aData)
        set_REMOTE_ICV_ID_IPAD_1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_IPAD_1_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_IPAD_1_mask = mask then
                read_REMOTE_ICV_ID_IPAD_1_value = data_low
            else
                read_REMOTE_ICV_ID_IPAD_1_value = (data_low - H8000_0000) and REMOTE_ICV_ID_IPAD_1_mask
            end If
        else
            read_REMOTE_ICV_ID_IPAD_1_value = data_low and REMOTE_ICV_ID_IPAD_1_mask
        end If

    End Sub

    Sub write
        If flag_REMOTE_ICV_ID_IPAD_1 = &H0 Then read
        If flag_REMOTE_ICV_ID_IPAD_1 = &H0 Then write_REMOTE_ICV_ID_IPAD_1_value = get_REMOTE_ICV_ID_IPAD_1

        regValue = leftShift((write_REMOTE_ICV_ID_IPAD_1_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_IPAD_1_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_IPAD_1_mask = mask then
                read_REMOTE_ICV_ID_IPAD_1_value = data_low
            else
                read_REMOTE_ICV_ID_IPAD_1_value = (data_low - H8000_0000) and REMOTE_ICV_ID_IPAD_1_mask
            end If
        else
            read_REMOTE_ICV_ID_IPAD_1_value = data_low and REMOTE_ICV_ID_IPAD_1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_REMOTE_ICV_ID_IPAD_1_value = &H0
        flag_REMOTE_ICV_ID_IPAD_1        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_remote_icv_id_ipad2_p0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' REMOTE_ICV_ID_IPAD_2                       [15:0]           get_REMOTE_ICV_ID_IPAD_2
''                                                             set_REMOTE_ICV_ID_IPAD_2
''                                                             read_REMOTE_ICV_ID_IPAD_2
''                                                             write_REMOTE_ICV_ID_IPAD_2
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_remote_icv_id_ipad2_p0
    Private write_REMOTE_ICV_ID_IPAD_2_value
    Private read_REMOTE_ICV_ID_IPAD_2_value
    Private flag_REMOTE_ICV_ID_IPAD_2

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

    Property Get get_REMOTE_ICV_ID_IPAD_2
        get_REMOTE_ICV_ID_IPAD_2 = read_REMOTE_ICV_ID_IPAD_2_value
    End Property

    Property Let set_REMOTE_ICV_ID_IPAD_2(aData)
        write_REMOTE_ICV_ID_IPAD_2_value = aData
        flag_REMOTE_ICV_ID_IPAD_2        = &H1
    End Property

    Property Get read_REMOTE_ICV_ID_IPAD_2
        read
        read_REMOTE_ICV_ID_IPAD_2 = read_REMOTE_ICV_ID_IPAD_2_value
    End Property

    Property Let write_REMOTE_ICV_ID_IPAD_2(aData)
        set_REMOTE_ICV_ID_IPAD_2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_IPAD_2_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_IPAD_2_mask = mask then
                read_REMOTE_ICV_ID_IPAD_2_value = data_low
            else
                read_REMOTE_ICV_ID_IPAD_2_value = (data_low - H8000_0000) and REMOTE_ICV_ID_IPAD_2_mask
            end If
        else
            read_REMOTE_ICV_ID_IPAD_2_value = data_low and REMOTE_ICV_ID_IPAD_2_mask
        end If

    End Sub

    Sub write
        If flag_REMOTE_ICV_ID_IPAD_2 = &H0 Then read
        If flag_REMOTE_ICV_ID_IPAD_2 = &H0 Then write_REMOTE_ICV_ID_IPAD_2_value = get_REMOTE_ICV_ID_IPAD_2

        regValue = leftShift((write_REMOTE_ICV_ID_IPAD_2_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_IPAD_2_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_IPAD_2_mask = mask then
                read_REMOTE_ICV_ID_IPAD_2_value = data_low
            else
                read_REMOTE_ICV_ID_IPAD_2_value = (data_low - H8000_0000) and REMOTE_ICV_ID_IPAD_2_mask
            end If
        else
            read_REMOTE_ICV_ID_IPAD_2_value = data_low and REMOTE_ICV_ID_IPAD_2_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_REMOTE_ICV_ID_IPAD_2_value = &H0
        flag_REMOTE_ICV_ID_IPAD_2        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_remote_icv_id_ipad2_p1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' REMOTE_ICV_ID_IPAD_2                       [15:0]           get_REMOTE_ICV_ID_IPAD_2
''                                                             set_REMOTE_ICV_ID_IPAD_2
''                                                             read_REMOTE_ICV_ID_IPAD_2
''                                                             write_REMOTE_ICV_ID_IPAD_2
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_remote_icv_id_ipad2_p1
    Private write_REMOTE_ICV_ID_IPAD_2_value
    Private read_REMOTE_ICV_ID_IPAD_2_value
    Private flag_REMOTE_ICV_ID_IPAD_2

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H102
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_REMOTE_ICV_ID_IPAD_2
        get_REMOTE_ICV_ID_IPAD_2 = read_REMOTE_ICV_ID_IPAD_2_value
    End Property

    Property Let set_REMOTE_ICV_ID_IPAD_2(aData)
        write_REMOTE_ICV_ID_IPAD_2_value = aData
        flag_REMOTE_ICV_ID_IPAD_2        = &H1
    End Property

    Property Get read_REMOTE_ICV_ID_IPAD_2
        read
        read_REMOTE_ICV_ID_IPAD_2 = read_REMOTE_ICV_ID_IPAD_2_value
    End Property

    Property Let write_REMOTE_ICV_ID_IPAD_2(aData)
        set_REMOTE_ICV_ID_IPAD_2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_IPAD_2_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_IPAD_2_mask = mask then
                read_REMOTE_ICV_ID_IPAD_2_value = data_low
            else
                read_REMOTE_ICV_ID_IPAD_2_value = (data_low - H8000_0000) and REMOTE_ICV_ID_IPAD_2_mask
            end If
        else
            read_REMOTE_ICV_ID_IPAD_2_value = data_low and REMOTE_ICV_ID_IPAD_2_mask
        end If

    End Sub

    Sub write
        If flag_REMOTE_ICV_ID_IPAD_2 = &H0 Then read
        If flag_REMOTE_ICV_ID_IPAD_2 = &H0 Then write_REMOTE_ICV_ID_IPAD_2_value = get_REMOTE_ICV_ID_IPAD_2

        regValue = leftShift((write_REMOTE_ICV_ID_IPAD_2_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_IPAD_2_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_IPAD_2_mask = mask then
                read_REMOTE_ICV_ID_IPAD_2_value = data_low
            else
                read_REMOTE_ICV_ID_IPAD_2_value = (data_low - H8000_0000) and REMOTE_ICV_ID_IPAD_2_mask
            end If
        else
            read_REMOTE_ICV_ID_IPAD_2_value = data_low and REMOTE_ICV_ID_IPAD_2_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_REMOTE_ICV_ID_IPAD_2_value = &H0
        flag_REMOTE_ICV_ID_IPAD_2        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_remote_icv_id_ipad2_p2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' REMOTE_ICV_ID_IPAD_2                       [15:0]           get_REMOTE_ICV_ID_IPAD_2
''                                                             set_REMOTE_ICV_ID_IPAD_2
''                                                             read_REMOTE_ICV_ID_IPAD_2
''                                                             write_REMOTE_ICV_ID_IPAD_2
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_remote_icv_id_ipad2_p2
    Private write_REMOTE_ICV_ID_IPAD_2_value
    Private read_REMOTE_ICV_ID_IPAD_2_value
    Private flag_REMOTE_ICV_ID_IPAD_2

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

    Property Get get_REMOTE_ICV_ID_IPAD_2
        get_REMOTE_ICV_ID_IPAD_2 = read_REMOTE_ICV_ID_IPAD_2_value
    End Property

    Property Let set_REMOTE_ICV_ID_IPAD_2(aData)
        write_REMOTE_ICV_ID_IPAD_2_value = aData
        flag_REMOTE_ICV_ID_IPAD_2        = &H1
    End Property

    Property Get read_REMOTE_ICV_ID_IPAD_2
        read
        read_REMOTE_ICV_ID_IPAD_2 = read_REMOTE_ICV_ID_IPAD_2_value
    End Property

    Property Let write_REMOTE_ICV_ID_IPAD_2(aData)
        set_REMOTE_ICV_ID_IPAD_2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_IPAD_2_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_IPAD_2_mask = mask then
                read_REMOTE_ICV_ID_IPAD_2_value = data_low
            else
                read_REMOTE_ICV_ID_IPAD_2_value = (data_low - H8000_0000) and REMOTE_ICV_ID_IPAD_2_mask
            end If
        else
            read_REMOTE_ICV_ID_IPAD_2_value = data_low and REMOTE_ICV_ID_IPAD_2_mask
        end If

    End Sub

    Sub write
        If flag_REMOTE_ICV_ID_IPAD_2 = &H0 Then read
        If flag_REMOTE_ICV_ID_IPAD_2 = &H0 Then write_REMOTE_ICV_ID_IPAD_2_value = get_REMOTE_ICV_ID_IPAD_2

        regValue = leftShift((write_REMOTE_ICV_ID_IPAD_2_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_IPAD_2_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_IPAD_2_mask = mask then
                read_REMOTE_ICV_ID_IPAD_2_value = data_low
            else
                read_REMOTE_ICV_ID_IPAD_2_value = (data_low - H8000_0000) and REMOTE_ICV_ID_IPAD_2_mask
            end If
        else
            read_REMOTE_ICV_ID_IPAD_2_value = data_low and REMOTE_ICV_ID_IPAD_2_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_REMOTE_ICV_ID_IPAD_2_value = &H0
        flag_REMOTE_ICV_ID_IPAD_2        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_remote_icv_id_ipad2_p3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' REMOTE_ICV_ID_IPAD_2                       [15:0]           get_REMOTE_ICV_ID_IPAD_2
''                                                             set_REMOTE_ICV_ID_IPAD_2
''                                                             read_REMOTE_ICV_ID_IPAD_2
''                                                             write_REMOTE_ICV_ID_IPAD_2
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_remote_icv_id_ipad2_p3
    Private write_REMOTE_ICV_ID_IPAD_2_value
    Private read_REMOTE_ICV_ID_IPAD_2_value
    Private flag_REMOTE_ICV_ID_IPAD_2

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H106
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_REMOTE_ICV_ID_IPAD_2
        get_REMOTE_ICV_ID_IPAD_2 = read_REMOTE_ICV_ID_IPAD_2_value
    End Property

    Property Let set_REMOTE_ICV_ID_IPAD_2(aData)
        write_REMOTE_ICV_ID_IPAD_2_value = aData
        flag_REMOTE_ICV_ID_IPAD_2        = &H1
    End Property

    Property Get read_REMOTE_ICV_ID_IPAD_2
        read
        read_REMOTE_ICV_ID_IPAD_2 = read_REMOTE_ICV_ID_IPAD_2_value
    End Property

    Property Let write_REMOTE_ICV_ID_IPAD_2(aData)
        set_REMOTE_ICV_ID_IPAD_2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_IPAD_2_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_IPAD_2_mask = mask then
                read_REMOTE_ICV_ID_IPAD_2_value = data_low
            else
                read_REMOTE_ICV_ID_IPAD_2_value = (data_low - H8000_0000) and REMOTE_ICV_ID_IPAD_2_mask
            end If
        else
            read_REMOTE_ICV_ID_IPAD_2_value = data_low and REMOTE_ICV_ID_IPAD_2_mask
        end If

    End Sub

    Sub write
        If flag_REMOTE_ICV_ID_IPAD_2 = &H0 Then read
        If flag_REMOTE_ICV_ID_IPAD_2 = &H0 Then write_REMOTE_ICV_ID_IPAD_2_value = get_REMOTE_ICV_ID_IPAD_2

        regValue = leftShift((write_REMOTE_ICV_ID_IPAD_2_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_IPAD_2_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_IPAD_2_mask = mask then
                read_REMOTE_ICV_ID_IPAD_2_value = data_low
            else
                read_REMOTE_ICV_ID_IPAD_2_value = (data_low - H8000_0000) and REMOTE_ICV_ID_IPAD_2_mask
            end If
        else
            read_REMOTE_ICV_ID_IPAD_2_value = data_low and REMOTE_ICV_ID_IPAD_2_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_REMOTE_ICV_ID_IPAD_2_value = &H0
        flag_REMOTE_ICV_ID_IPAD_2        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_remote_icv_id_ipad2_p4
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' REMOTE_ICV_ID_IPAD_2                       [15:0]           get_REMOTE_ICV_ID_IPAD_2
''                                                             set_REMOTE_ICV_ID_IPAD_2
''                                                             read_REMOTE_ICV_ID_IPAD_2
''                                                             write_REMOTE_ICV_ID_IPAD_2
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_remote_icv_id_ipad2_p4
    Private write_REMOTE_ICV_ID_IPAD_2_value
    Private read_REMOTE_ICV_ID_IPAD_2_value
    Private flag_REMOTE_ICV_ID_IPAD_2

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

    Property Get get_REMOTE_ICV_ID_IPAD_2
        get_REMOTE_ICV_ID_IPAD_2 = read_REMOTE_ICV_ID_IPAD_2_value
    End Property

    Property Let set_REMOTE_ICV_ID_IPAD_2(aData)
        write_REMOTE_ICV_ID_IPAD_2_value = aData
        flag_REMOTE_ICV_ID_IPAD_2        = &H1
    End Property

    Property Get read_REMOTE_ICV_ID_IPAD_2
        read
        read_REMOTE_ICV_ID_IPAD_2 = read_REMOTE_ICV_ID_IPAD_2_value
    End Property

    Property Let write_REMOTE_ICV_ID_IPAD_2(aData)
        set_REMOTE_ICV_ID_IPAD_2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_IPAD_2_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_IPAD_2_mask = mask then
                read_REMOTE_ICV_ID_IPAD_2_value = data_low
            else
                read_REMOTE_ICV_ID_IPAD_2_value = (data_low - H8000_0000) and REMOTE_ICV_ID_IPAD_2_mask
            end If
        else
            read_REMOTE_ICV_ID_IPAD_2_value = data_low and REMOTE_ICV_ID_IPAD_2_mask
        end If

    End Sub

    Sub write
        If flag_REMOTE_ICV_ID_IPAD_2 = &H0 Then read
        If flag_REMOTE_ICV_ID_IPAD_2 = &H0 Then write_REMOTE_ICV_ID_IPAD_2_value = get_REMOTE_ICV_ID_IPAD_2

        regValue = leftShift((write_REMOTE_ICV_ID_IPAD_2_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_IPAD_2_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_IPAD_2_mask = mask then
                read_REMOTE_ICV_ID_IPAD_2_value = data_low
            else
                read_REMOTE_ICV_ID_IPAD_2_value = (data_low - H8000_0000) and REMOTE_ICV_ID_IPAD_2_mask
            end If
        else
            read_REMOTE_ICV_ID_IPAD_2_value = data_low and REMOTE_ICV_ID_IPAD_2_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_REMOTE_ICV_ID_IPAD_2_value = &H0
        flag_REMOTE_ICV_ID_IPAD_2        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_remote_icv_id_ipad2_p5
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' REMOTE_ICV_ID_IPAD_2                       [15:0]           get_REMOTE_ICV_ID_IPAD_2
''                                                             set_REMOTE_ICV_ID_IPAD_2
''                                                             read_REMOTE_ICV_ID_IPAD_2
''                                                             write_REMOTE_ICV_ID_IPAD_2
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_remote_icv_id_ipad2_p5
    Private write_REMOTE_ICV_ID_IPAD_2_value
    Private read_REMOTE_ICV_ID_IPAD_2_value
    Private flag_REMOTE_ICV_ID_IPAD_2

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H10a
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_REMOTE_ICV_ID_IPAD_2
        get_REMOTE_ICV_ID_IPAD_2 = read_REMOTE_ICV_ID_IPAD_2_value
    End Property

    Property Let set_REMOTE_ICV_ID_IPAD_2(aData)
        write_REMOTE_ICV_ID_IPAD_2_value = aData
        flag_REMOTE_ICV_ID_IPAD_2        = &H1
    End Property

    Property Get read_REMOTE_ICV_ID_IPAD_2
        read
        read_REMOTE_ICV_ID_IPAD_2 = read_REMOTE_ICV_ID_IPAD_2_value
    End Property

    Property Let write_REMOTE_ICV_ID_IPAD_2(aData)
        set_REMOTE_ICV_ID_IPAD_2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_IPAD_2_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_IPAD_2_mask = mask then
                read_REMOTE_ICV_ID_IPAD_2_value = data_low
            else
                read_REMOTE_ICV_ID_IPAD_2_value = (data_low - H8000_0000) and REMOTE_ICV_ID_IPAD_2_mask
            end If
        else
            read_REMOTE_ICV_ID_IPAD_2_value = data_low and REMOTE_ICV_ID_IPAD_2_mask
        end If

    End Sub

    Sub write
        If flag_REMOTE_ICV_ID_IPAD_2 = &H0 Then read
        If flag_REMOTE_ICV_ID_IPAD_2 = &H0 Then write_REMOTE_ICV_ID_IPAD_2_value = get_REMOTE_ICV_ID_IPAD_2

        regValue = leftShift((write_REMOTE_ICV_ID_IPAD_2_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_IPAD_2_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_IPAD_2_mask = mask then
                read_REMOTE_ICV_ID_IPAD_2_value = data_low
            else
                read_REMOTE_ICV_ID_IPAD_2_value = (data_low - H8000_0000) and REMOTE_ICV_ID_IPAD_2_mask
            end If
        else
            read_REMOTE_ICV_ID_IPAD_2_value = data_low and REMOTE_ICV_ID_IPAD_2_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_REMOTE_ICV_ID_IPAD_2_value = &H0
        flag_REMOTE_ICV_ID_IPAD_2        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_remote_icv_id_ipad3_p0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' REMOTE_ICV_ID_IPAD_3                       [15:0]           get_REMOTE_ICV_ID_IPAD_3
''                                                             set_REMOTE_ICV_ID_IPAD_3
''                                                             read_REMOTE_ICV_ID_IPAD_3
''                                                             write_REMOTE_ICV_ID_IPAD_3
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_remote_icv_id_ipad3_p0
    Private write_REMOTE_ICV_ID_IPAD_3_value
    Private read_REMOTE_ICV_ID_IPAD_3_value
    Private flag_REMOTE_ICV_ID_IPAD_3

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

    Property Get get_REMOTE_ICV_ID_IPAD_3
        get_REMOTE_ICV_ID_IPAD_3 = read_REMOTE_ICV_ID_IPAD_3_value
    End Property

    Property Let set_REMOTE_ICV_ID_IPAD_3(aData)
        write_REMOTE_ICV_ID_IPAD_3_value = aData
        flag_REMOTE_ICV_ID_IPAD_3        = &H1
    End Property

    Property Get read_REMOTE_ICV_ID_IPAD_3
        read
        read_REMOTE_ICV_ID_IPAD_3 = read_REMOTE_ICV_ID_IPAD_3_value
    End Property

    Property Let write_REMOTE_ICV_ID_IPAD_3(aData)
        set_REMOTE_ICV_ID_IPAD_3 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_IPAD_3_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_IPAD_3_mask = mask then
                read_REMOTE_ICV_ID_IPAD_3_value = data_low
            else
                read_REMOTE_ICV_ID_IPAD_3_value = (data_low - H8000_0000) and REMOTE_ICV_ID_IPAD_3_mask
            end If
        else
            read_REMOTE_ICV_ID_IPAD_3_value = data_low and REMOTE_ICV_ID_IPAD_3_mask
        end If

    End Sub

    Sub write
        If flag_REMOTE_ICV_ID_IPAD_3 = &H0 Then read
        If flag_REMOTE_ICV_ID_IPAD_3 = &H0 Then write_REMOTE_ICV_ID_IPAD_3_value = get_REMOTE_ICV_ID_IPAD_3

        regValue = leftShift((write_REMOTE_ICV_ID_IPAD_3_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_IPAD_3_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_IPAD_3_mask = mask then
                read_REMOTE_ICV_ID_IPAD_3_value = data_low
            else
                read_REMOTE_ICV_ID_IPAD_3_value = (data_low - H8000_0000) and REMOTE_ICV_ID_IPAD_3_mask
            end If
        else
            read_REMOTE_ICV_ID_IPAD_3_value = data_low and REMOTE_ICV_ID_IPAD_3_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_REMOTE_ICV_ID_IPAD_3_value = &H0
        flag_REMOTE_ICV_ID_IPAD_3        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_remote_icv_id_ipad3_p1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' REMOTE_ICV_ID_IPAD_3                       [15:0]           get_REMOTE_ICV_ID_IPAD_3
''                                                             set_REMOTE_ICV_ID_IPAD_3
''                                                             read_REMOTE_ICV_ID_IPAD_3
''                                                             write_REMOTE_ICV_ID_IPAD_3
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_remote_icv_id_ipad3_p1
    Private write_REMOTE_ICV_ID_IPAD_3_value
    Private read_REMOTE_ICV_ID_IPAD_3_value
    Private flag_REMOTE_ICV_ID_IPAD_3

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H112
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_REMOTE_ICV_ID_IPAD_3
        get_REMOTE_ICV_ID_IPAD_3 = read_REMOTE_ICV_ID_IPAD_3_value
    End Property

    Property Let set_REMOTE_ICV_ID_IPAD_3(aData)
        write_REMOTE_ICV_ID_IPAD_3_value = aData
        flag_REMOTE_ICV_ID_IPAD_3        = &H1
    End Property

    Property Get read_REMOTE_ICV_ID_IPAD_3
        read
        read_REMOTE_ICV_ID_IPAD_3 = read_REMOTE_ICV_ID_IPAD_3_value
    End Property

    Property Let write_REMOTE_ICV_ID_IPAD_3(aData)
        set_REMOTE_ICV_ID_IPAD_3 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_IPAD_3_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_IPAD_3_mask = mask then
                read_REMOTE_ICV_ID_IPAD_3_value = data_low
            else
                read_REMOTE_ICV_ID_IPAD_3_value = (data_low - H8000_0000) and REMOTE_ICV_ID_IPAD_3_mask
            end If
        else
            read_REMOTE_ICV_ID_IPAD_3_value = data_low and REMOTE_ICV_ID_IPAD_3_mask
        end If

    End Sub

    Sub write
        If flag_REMOTE_ICV_ID_IPAD_3 = &H0 Then read
        If flag_REMOTE_ICV_ID_IPAD_3 = &H0 Then write_REMOTE_ICV_ID_IPAD_3_value = get_REMOTE_ICV_ID_IPAD_3

        regValue = leftShift((write_REMOTE_ICV_ID_IPAD_3_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_IPAD_3_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_IPAD_3_mask = mask then
                read_REMOTE_ICV_ID_IPAD_3_value = data_low
            else
                read_REMOTE_ICV_ID_IPAD_3_value = (data_low - H8000_0000) and REMOTE_ICV_ID_IPAD_3_mask
            end If
        else
            read_REMOTE_ICV_ID_IPAD_3_value = data_low and REMOTE_ICV_ID_IPAD_3_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_REMOTE_ICV_ID_IPAD_3_value = &H0
        flag_REMOTE_ICV_ID_IPAD_3        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_remote_icv_id_ipad3_p2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' REMOTE_ICV_ID_IPAD_3                       [15:0]           get_REMOTE_ICV_ID_IPAD_3
''                                                             set_REMOTE_ICV_ID_IPAD_3
''                                                             read_REMOTE_ICV_ID_IPAD_3
''                                                             write_REMOTE_ICV_ID_IPAD_3
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_remote_icv_id_ipad3_p2
    Private write_REMOTE_ICV_ID_IPAD_3_value
    Private read_REMOTE_ICV_ID_IPAD_3_value
    Private flag_REMOTE_ICV_ID_IPAD_3

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

    Property Get get_REMOTE_ICV_ID_IPAD_3
        get_REMOTE_ICV_ID_IPAD_3 = read_REMOTE_ICV_ID_IPAD_3_value
    End Property

    Property Let set_REMOTE_ICV_ID_IPAD_3(aData)
        write_REMOTE_ICV_ID_IPAD_3_value = aData
        flag_REMOTE_ICV_ID_IPAD_3        = &H1
    End Property

    Property Get read_REMOTE_ICV_ID_IPAD_3
        read
        read_REMOTE_ICV_ID_IPAD_3 = read_REMOTE_ICV_ID_IPAD_3_value
    End Property

    Property Let write_REMOTE_ICV_ID_IPAD_3(aData)
        set_REMOTE_ICV_ID_IPAD_3 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_IPAD_3_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_IPAD_3_mask = mask then
                read_REMOTE_ICV_ID_IPAD_3_value = data_low
            else
                read_REMOTE_ICV_ID_IPAD_3_value = (data_low - H8000_0000) and REMOTE_ICV_ID_IPAD_3_mask
            end If
        else
            read_REMOTE_ICV_ID_IPAD_3_value = data_low and REMOTE_ICV_ID_IPAD_3_mask
        end If

    End Sub

    Sub write
        If flag_REMOTE_ICV_ID_IPAD_3 = &H0 Then read
        If flag_REMOTE_ICV_ID_IPAD_3 = &H0 Then write_REMOTE_ICV_ID_IPAD_3_value = get_REMOTE_ICV_ID_IPAD_3

        regValue = leftShift((write_REMOTE_ICV_ID_IPAD_3_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_IPAD_3_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_IPAD_3_mask = mask then
                read_REMOTE_ICV_ID_IPAD_3_value = data_low
            else
                read_REMOTE_ICV_ID_IPAD_3_value = (data_low - H8000_0000) and REMOTE_ICV_ID_IPAD_3_mask
            end If
        else
            read_REMOTE_ICV_ID_IPAD_3_value = data_low and REMOTE_ICV_ID_IPAD_3_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_REMOTE_ICV_ID_IPAD_3_value = &H0
        flag_REMOTE_ICV_ID_IPAD_3        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_remote_icv_id_ipad3_p3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' REMOTE_ICV_ID_IPAD_3                       [15:0]           get_REMOTE_ICV_ID_IPAD_3
''                                                             set_REMOTE_ICV_ID_IPAD_3
''                                                             read_REMOTE_ICV_ID_IPAD_3
''                                                             write_REMOTE_ICV_ID_IPAD_3
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_remote_icv_id_ipad3_p3
    Private write_REMOTE_ICV_ID_IPAD_3_value
    Private read_REMOTE_ICV_ID_IPAD_3_value
    Private flag_REMOTE_ICV_ID_IPAD_3

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H116
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_REMOTE_ICV_ID_IPAD_3
        get_REMOTE_ICV_ID_IPAD_3 = read_REMOTE_ICV_ID_IPAD_3_value
    End Property

    Property Let set_REMOTE_ICV_ID_IPAD_3(aData)
        write_REMOTE_ICV_ID_IPAD_3_value = aData
        flag_REMOTE_ICV_ID_IPAD_3        = &H1
    End Property

    Property Get read_REMOTE_ICV_ID_IPAD_3
        read
        read_REMOTE_ICV_ID_IPAD_3 = read_REMOTE_ICV_ID_IPAD_3_value
    End Property

    Property Let write_REMOTE_ICV_ID_IPAD_3(aData)
        set_REMOTE_ICV_ID_IPAD_3 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_IPAD_3_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_IPAD_3_mask = mask then
                read_REMOTE_ICV_ID_IPAD_3_value = data_low
            else
                read_REMOTE_ICV_ID_IPAD_3_value = (data_low - H8000_0000) and REMOTE_ICV_ID_IPAD_3_mask
            end If
        else
            read_REMOTE_ICV_ID_IPAD_3_value = data_low and REMOTE_ICV_ID_IPAD_3_mask
        end If

    End Sub

    Sub write
        If flag_REMOTE_ICV_ID_IPAD_3 = &H0 Then read
        If flag_REMOTE_ICV_ID_IPAD_3 = &H0 Then write_REMOTE_ICV_ID_IPAD_3_value = get_REMOTE_ICV_ID_IPAD_3

        regValue = leftShift((write_REMOTE_ICV_ID_IPAD_3_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_IPAD_3_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_IPAD_3_mask = mask then
                read_REMOTE_ICV_ID_IPAD_3_value = data_low
            else
                read_REMOTE_ICV_ID_IPAD_3_value = (data_low - H8000_0000) and REMOTE_ICV_ID_IPAD_3_mask
            end If
        else
            read_REMOTE_ICV_ID_IPAD_3_value = data_low and REMOTE_ICV_ID_IPAD_3_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_REMOTE_ICV_ID_IPAD_3_value = &H0
        flag_REMOTE_ICV_ID_IPAD_3        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_remote_icv_id_ipad3_p4
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' REMOTE_ICV_ID_IPAD_3                       [15:0]           get_REMOTE_ICV_ID_IPAD_3
''                                                             set_REMOTE_ICV_ID_IPAD_3
''                                                             read_REMOTE_ICV_ID_IPAD_3
''                                                             write_REMOTE_ICV_ID_IPAD_3
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_remote_icv_id_ipad3_p4
    Private write_REMOTE_ICV_ID_IPAD_3_value
    Private read_REMOTE_ICV_ID_IPAD_3_value
    Private flag_REMOTE_ICV_ID_IPAD_3

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

    Property Get get_REMOTE_ICV_ID_IPAD_3
        get_REMOTE_ICV_ID_IPAD_3 = read_REMOTE_ICV_ID_IPAD_3_value
    End Property

    Property Let set_REMOTE_ICV_ID_IPAD_3(aData)
        write_REMOTE_ICV_ID_IPAD_3_value = aData
        flag_REMOTE_ICV_ID_IPAD_3        = &H1
    End Property

    Property Get read_REMOTE_ICV_ID_IPAD_3
        read
        read_REMOTE_ICV_ID_IPAD_3 = read_REMOTE_ICV_ID_IPAD_3_value
    End Property

    Property Let write_REMOTE_ICV_ID_IPAD_3(aData)
        set_REMOTE_ICV_ID_IPAD_3 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_IPAD_3_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_IPAD_3_mask = mask then
                read_REMOTE_ICV_ID_IPAD_3_value = data_low
            else
                read_REMOTE_ICV_ID_IPAD_3_value = (data_low - H8000_0000) and REMOTE_ICV_ID_IPAD_3_mask
            end If
        else
            read_REMOTE_ICV_ID_IPAD_3_value = data_low and REMOTE_ICV_ID_IPAD_3_mask
        end If

    End Sub

    Sub write
        If flag_REMOTE_ICV_ID_IPAD_3 = &H0 Then read
        If flag_REMOTE_ICV_ID_IPAD_3 = &H0 Then write_REMOTE_ICV_ID_IPAD_3_value = get_REMOTE_ICV_ID_IPAD_3

        regValue = leftShift((write_REMOTE_ICV_ID_IPAD_3_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_IPAD_3_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_IPAD_3_mask = mask then
                read_REMOTE_ICV_ID_IPAD_3_value = data_low
            else
                read_REMOTE_ICV_ID_IPAD_3_value = (data_low - H8000_0000) and REMOTE_ICV_ID_IPAD_3_mask
            end If
        else
            read_REMOTE_ICV_ID_IPAD_3_value = data_low and REMOTE_ICV_ID_IPAD_3_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_REMOTE_ICV_ID_IPAD_3_value = &H0
        flag_REMOTE_ICV_ID_IPAD_3        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_remote_icv_id_ipad3_p5
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' REMOTE_ICV_ID_IPAD_3                       [15:0]           get_REMOTE_ICV_ID_IPAD_3
''                                                             set_REMOTE_ICV_ID_IPAD_3
''                                                             read_REMOTE_ICV_ID_IPAD_3
''                                                             write_REMOTE_ICV_ID_IPAD_3
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_remote_icv_id_ipad3_p5
    Private write_REMOTE_ICV_ID_IPAD_3_value
    Private read_REMOTE_ICV_ID_IPAD_3_value
    Private flag_REMOTE_ICV_ID_IPAD_3

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H11a
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_REMOTE_ICV_ID_IPAD_3
        get_REMOTE_ICV_ID_IPAD_3 = read_REMOTE_ICV_ID_IPAD_3_value
    End Property

    Property Let set_REMOTE_ICV_ID_IPAD_3(aData)
        write_REMOTE_ICV_ID_IPAD_3_value = aData
        flag_REMOTE_ICV_ID_IPAD_3        = &H1
    End Property

    Property Get read_REMOTE_ICV_ID_IPAD_3
        read
        read_REMOTE_ICV_ID_IPAD_3 = read_REMOTE_ICV_ID_IPAD_3_value
    End Property

    Property Let write_REMOTE_ICV_ID_IPAD_3(aData)
        set_REMOTE_ICV_ID_IPAD_3 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_IPAD_3_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_IPAD_3_mask = mask then
                read_REMOTE_ICV_ID_IPAD_3_value = data_low
            else
                read_REMOTE_ICV_ID_IPAD_3_value = (data_low - H8000_0000) and REMOTE_ICV_ID_IPAD_3_mask
            end If
        else
            read_REMOTE_ICV_ID_IPAD_3_value = data_low and REMOTE_ICV_ID_IPAD_3_mask
        end If

    End Sub

    Sub write
        If flag_REMOTE_ICV_ID_IPAD_3 = &H0 Then read
        If flag_REMOTE_ICV_ID_IPAD_3 = &H0 Then write_REMOTE_ICV_ID_IPAD_3_value = get_REMOTE_ICV_ID_IPAD_3

        regValue = leftShift((write_REMOTE_ICV_ID_IPAD_3_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_IPAD_3_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_IPAD_3_mask = mask then
                read_REMOTE_ICV_ID_IPAD_3_value = data_low
            else
                read_REMOTE_ICV_ID_IPAD_3_value = (data_low - H8000_0000) and REMOTE_ICV_ID_IPAD_3_mask
            end If
        else
            read_REMOTE_ICV_ID_IPAD_3_value = data_low and REMOTE_ICV_ID_IPAD_3_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_REMOTE_ICV_ID_IPAD_3_value = &H0
        flag_REMOTE_ICV_ID_IPAD_3        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_local_icv_id_opad0_p0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LOCAL_ICV_ID_OPAD_0                        [15:0]           get_LOCAL_ICV_ID_OPAD_0
''                                                             set_LOCAL_ICV_ID_OPAD_0
''                                                             read_LOCAL_ICV_ID_OPAD_0
''                                                             write_LOCAL_ICV_ID_OPAD_0
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_local_icv_id_opad0_p0
    Private write_LOCAL_ICV_ID_OPAD_0_value
    Private read_LOCAL_ICV_ID_OPAD_0_value
    Private flag_LOCAL_ICV_ID_OPAD_0

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

    Property Get get_LOCAL_ICV_ID_OPAD_0
        get_LOCAL_ICV_ID_OPAD_0 = read_LOCAL_ICV_ID_OPAD_0_value
    End Property

    Property Let set_LOCAL_ICV_ID_OPAD_0(aData)
        write_LOCAL_ICV_ID_OPAD_0_value = aData
        flag_LOCAL_ICV_ID_OPAD_0        = &H1
    End Property

    Property Get read_LOCAL_ICV_ID_OPAD_0
        read
        read_LOCAL_ICV_ID_OPAD_0 = read_LOCAL_ICV_ID_OPAD_0_value
    End Property

    Property Let write_LOCAL_ICV_ID_OPAD_0(aData)
        set_LOCAL_ICV_ID_OPAD_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_OPAD_0_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_OPAD_0_mask = mask then
                read_LOCAL_ICV_ID_OPAD_0_value = data_low
            else
                read_LOCAL_ICV_ID_OPAD_0_value = (data_low - H8000_0000) and LOCAL_ICV_ID_OPAD_0_mask
            end If
        else
            read_LOCAL_ICV_ID_OPAD_0_value = data_low and LOCAL_ICV_ID_OPAD_0_mask
        end If

    End Sub

    Sub write
        If flag_LOCAL_ICV_ID_OPAD_0 = &H0 Then read
        If flag_LOCAL_ICV_ID_OPAD_0 = &H0 Then write_LOCAL_ICV_ID_OPAD_0_value = get_LOCAL_ICV_ID_OPAD_0

        regValue = leftShift((write_LOCAL_ICV_ID_OPAD_0_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_OPAD_0_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_OPAD_0_mask = mask then
                read_LOCAL_ICV_ID_OPAD_0_value = data_low
            else
                read_LOCAL_ICV_ID_OPAD_0_value = (data_low - H8000_0000) and LOCAL_ICV_ID_OPAD_0_mask
            end If
        else
            read_LOCAL_ICV_ID_OPAD_0_value = data_low and LOCAL_ICV_ID_OPAD_0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LOCAL_ICV_ID_OPAD_0_value = &H0
        flag_LOCAL_ICV_ID_OPAD_0        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_local_icv_id_opad0_p1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LOCAL_ICV_ID_OPAD_0                        [15:0]           get_LOCAL_ICV_ID_OPAD_0
''                                                             set_LOCAL_ICV_ID_OPAD_0
''                                                             read_LOCAL_ICV_ID_OPAD_0
''                                                             write_LOCAL_ICV_ID_OPAD_0
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_local_icv_id_opad0_p1
    Private write_LOCAL_ICV_ID_OPAD_0_value
    Private read_LOCAL_ICV_ID_OPAD_0_value
    Private flag_LOCAL_ICV_ID_OPAD_0

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H122
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_LOCAL_ICV_ID_OPAD_0
        get_LOCAL_ICV_ID_OPAD_0 = read_LOCAL_ICV_ID_OPAD_0_value
    End Property

    Property Let set_LOCAL_ICV_ID_OPAD_0(aData)
        write_LOCAL_ICV_ID_OPAD_0_value = aData
        flag_LOCAL_ICV_ID_OPAD_0        = &H1
    End Property

    Property Get read_LOCAL_ICV_ID_OPAD_0
        read
        read_LOCAL_ICV_ID_OPAD_0 = read_LOCAL_ICV_ID_OPAD_0_value
    End Property

    Property Let write_LOCAL_ICV_ID_OPAD_0(aData)
        set_LOCAL_ICV_ID_OPAD_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_OPAD_0_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_OPAD_0_mask = mask then
                read_LOCAL_ICV_ID_OPAD_0_value = data_low
            else
                read_LOCAL_ICV_ID_OPAD_0_value = (data_low - H8000_0000) and LOCAL_ICV_ID_OPAD_0_mask
            end If
        else
            read_LOCAL_ICV_ID_OPAD_0_value = data_low and LOCAL_ICV_ID_OPAD_0_mask
        end If

    End Sub

    Sub write
        If flag_LOCAL_ICV_ID_OPAD_0 = &H0 Then read
        If flag_LOCAL_ICV_ID_OPAD_0 = &H0 Then write_LOCAL_ICV_ID_OPAD_0_value = get_LOCAL_ICV_ID_OPAD_0

        regValue = leftShift((write_LOCAL_ICV_ID_OPAD_0_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_OPAD_0_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_OPAD_0_mask = mask then
                read_LOCAL_ICV_ID_OPAD_0_value = data_low
            else
                read_LOCAL_ICV_ID_OPAD_0_value = (data_low - H8000_0000) and LOCAL_ICV_ID_OPAD_0_mask
            end If
        else
            read_LOCAL_ICV_ID_OPAD_0_value = data_low and LOCAL_ICV_ID_OPAD_0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LOCAL_ICV_ID_OPAD_0_value = &H0
        flag_LOCAL_ICV_ID_OPAD_0        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_local_icv_id_opad0_p2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LOCAL_ICV_ID_OPAD_0                        [15:0]           get_LOCAL_ICV_ID_OPAD_0
''                                                             set_LOCAL_ICV_ID_OPAD_0
''                                                             read_LOCAL_ICV_ID_OPAD_0
''                                                             write_LOCAL_ICV_ID_OPAD_0
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_local_icv_id_opad0_p2
    Private write_LOCAL_ICV_ID_OPAD_0_value
    Private read_LOCAL_ICV_ID_OPAD_0_value
    Private flag_LOCAL_ICV_ID_OPAD_0

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

    Property Get get_LOCAL_ICV_ID_OPAD_0
        get_LOCAL_ICV_ID_OPAD_0 = read_LOCAL_ICV_ID_OPAD_0_value
    End Property

    Property Let set_LOCAL_ICV_ID_OPAD_0(aData)
        write_LOCAL_ICV_ID_OPAD_0_value = aData
        flag_LOCAL_ICV_ID_OPAD_0        = &H1
    End Property

    Property Get read_LOCAL_ICV_ID_OPAD_0
        read
        read_LOCAL_ICV_ID_OPAD_0 = read_LOCAL_ICV_ID_OPAD_0_value
    End Property

    Property Let write_LOCAL_ICV_ID_OPAD_0(aData)
        set_LOCAL_ICV_ID_OPAD_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_OPAD_0_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_OPAD_0_mask = mask then
                read_LOCAL_ICV_ID_OPAD_0_value = data_low
            else
                read_LOCAL_ICV_ID_OPAD_0_value = (data_low - H8000_0000) and LOCAL_ICV_ID_OPAD_0_mask
            end If
        else
            read_LOCAL_ICV_ID_OPAD_0_value = data_low and LOCAL_ICV_ID_OPAD_0_mask
        end If

    End Sub

    Sub write
        If flag_LOCAL_ICV_ID_OPAD_0 = &H0 Then read
        If flag_LOCAL_ICV_ID_OPAD_0 = &H0 Then write_LOCAL_ICV_ID_OPAD_0_value = get_LOCAL_ICV_ID_OPAD_0

        regValue = leftShift((write_LOCAL_ICV_ID_OPAD_0_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_OPAD_0_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_OPAD_0_mask = mask then
                read_LOCAL_ICV_ID_OPAD_0_value = data_low
            else
                read_LOCAL_ICV_ID_OPAD_0_value = (data_low - H8000_0000) and LOCAL_ICV_ID_OPAD_0_mask
            end If
        else
            read_LOCAL_ICV_ID_OPAD_0_value = data_low and LOCAL_ICV_ID_OPAD_0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LOCAL_ICV_ID_OPAD_0_value = &H0
        flag_LOCAL_ICV_ID_OPAD_0        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_local_icv_id_opad0_p3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LOCAL_ICV_ID_OPAD_0                        [15:0]           get_LOCAL_ICV_ID_OPAD_0
''                                                             set_LOCAL_ICV_ID_OPAD_0
''                                                             read_LOCAL_ICV_ID_OPAD_0
''                                                             write_LOCAL_ICV_ID_OPAD_0
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_local_icv_id_opad0_p3
    Private write_LOCAL_ICV_ID_OPAD_0_value
    Private read_LOCAL_ICV_ID_OPAD_0_value
    Private flag_LOCAL_ICV_ID_OPAD_0

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H126
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_LOCAL_ICV_ID_OPAD_0
        get_LOCAL_ICV_ID_OPAD_0 = read_LOCAL_ICV_ID_OPAD_0_value
    End Property

    Property Let set_LOCAL_ICV_ID_OPAD_0(aData)
        write_LOCAL_ICV_ID_OPAD_0_value = aData
        flag_LOCAL_ICV_ID_OPAD_0        = &H1
    End Property

    Property Get read_LOCAL_ICV_ID_OPAD_0
        read
        read_LOCAL_ICV_ID_OPAD_0 = read_LOCAL_ICV_ID_OPAD_0_value
    End Property

    Property Let write_LOCAL_ICV_ID_OPAD_0(aData)
        set_LOCAL_ICV_ID_OPAD_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_OPAD_0_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_OPAD_0_mask = mask then
                read_LOCAL_ICV_ID_OPAD_0_value = data_low
            else
                read_LOCAL_ICV_ID_OPAD_0_value = (data_low - H8000_0000) and LOCAL_ICV_ID_OPAD_0_mask
            end If
        else
            read_LOCAL_ICV_ID_OPAD_0_value = data_low and LOCAL_ICV_ID_OPAD_0_mask
        end If

    End Sub

    Sub write
        If flag_LOCAL_ICV_ID_OPAD_0 = &H0 Then read
        If flag_LOCAL_ICV_ID_OPAD_0 = &H0 Then write_LOCAL_ICV_ID_OPAD_0_value = get_LOCAL_ICV_ID_OPAD_0

        regValue = leftShift((write_LOCAL_ICV_ID_OPAD_0_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_OPAD_0_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_OPAD_0_mask = mask then
                read_LOCAL_ICV_ID_OPAD_0_value = data_low
            else
                read_LOCAL_ICV_ID_OPAD_0_value = (data_low - H8000_0000) and LOCAL_ICV_ID_OPAD_0_mask
            end If
        else
            read_LOCAL_ICV_ID_OPAD_0_value = data_low and LOCAL_ICV_ID_OPAD_0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LOCAL_ICV_ID_OPAD_0_value = &H0
        flag_LOCAL_ICV_ID_OPAD_0        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_local_icv_id_opad0_p4
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LOCAL_ICV_ID_OPAD_0                        [15:0]           get_LOCAL_ICV_ID_OPAD_0
''                                                             set_LOCAL_ICV_ID_OPAD_0
''                                                             read_LOCAL_ICV_ID_OPAD_0
''                                                             write_LOCAL_ICV_ID_OPAD_0
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_local_icv_id_opad0_p4
    Private write_LOCAL_ICV_ID_OPAD_0_value
    Private read_LOCAL_ICV_ID_OPAD_0_value
    Private flag_LOCAL_ICV_ID_OPAD_0

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

    Property Get get_LOCAL_ICV_ID_OPAD_0
        get_LOCAL_ICV_ID_OPAD_0 = read_LOCAL_ICV_ID_OPAD_0_value
    End Property

    Property Let set_LOCAL_ICV_ID_OPAD_0(aData)
        write_LOCAL_ICV_ID_OPAD_0_value = aData
        flag_LOCAL_ICV_ID_OPAD_0        = &H1
    End Property

    Property Get read_LOCAL_ICV_ID_OPAD_0
        read
        read_LOCAL_ICV_ID_OPAD_0 = read_LOCAL_ICV_ID_OPAD_0_value
    End Property

    Property Let write_LOCAL_ICV_ID_OPAD_0(aData)
        set_LOCAL_ICV_ID_OPAD_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_OPAD_0_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_OPAD_0_mask = mask then
                read_LOCAL_ICV_ID_OPAD_0_value = data_low
            else
                read_LOCAL_ICV_ID_OPAD_0_value = (data_low - H8000_0000) and LOCAL_ICV_ID_OPAD_0_mask
            end If
        else
            read_LOCAL_ICV_ID_OPAD_0_value = data_low and LOCAL_ICV_ID_OPAD_0_mask
        end If

    End Sub

    Sub write
        If flag_LOCAL_ICV_ID_OPAD_0 = &H0 Then read
        If flag_LOCAL_ICV_ID_OPAD_0 = &H0 Then write_LOCAL_ICV_ID_OPAD_0_value = get_LOCAL_ICV_ID_OPAD_0

        regValue = leftShift((write_LOCAL_ICV_ID_OPAD_0_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_OPAD_0_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_OPAD_0_mask = mask then
                read_LOCAL_ICV_ID_OPAD_0_value = data_low
            else
                read_LOCAL_ICV_ID_OPAD_0_value = (data_low - H8000_0000) and LOCAL_ICV_ID_OPAD_0_mask
            end If
        else
            read_LOCAL_ICV_ID_OPAD_0_value = data_low and LOCAL_ICV_ID_OPAD_0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LOCAL_ICV_ID_OPAD_0_value = &H0
        flag_LOCAL_ICV_ID_OPAD_0        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_local_icv_id_opad0_p5
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LOCAL_ICV_ID_OPAD_0                        [15:0]           get_LOCAL_ICV_ID_OPAD_0
''                                                             set_LOCAL_ICV_ID_OPAD_0
''                                                             read_LOCAL_ICV_ID_OPAD_0
''                                                             write_LOCAL_ICV_ID_OPAD_0
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_local_icv_id_opad0_p5
    Private write_LOCAL_ICV_ID_OPAD_0_value
    Private read_LOCAL_ICV_ID_OPAD_0_value
    Private flag_LOCAL_ICV_ID_OPAD_0

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H12a
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_LOCAL_ICV_ID_OPAD_0
        get_LOCAL_ICV_ID_OPAD_0 = read_LOCAL_ICV_ID_OPAD_0_value
    End Property

    Property Let set_LOCAL_ICV_ID_OPAD_0(aData)
        write_LOCAL_ICV_ID_OPAD_0_value = aData
        flag_LOCAL_ICV_ID_OPAD_0        = &H1
    End Property

    Property Get read_LOCAL_ICV_ID_OPAD_0
        read
        read_LOCAL_ICV_ID_OPAD_0 = read_LOCAL_ICV_ID_OPAD_0_value
    End Property

    Property Let write_LOCAL_ICV_ID_OPAD_0(aData)
        set_LOCAL_ICV_ID_OPAD_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_OPAD_0_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_OPAD_0_mask = mask then
                read_LOCAL_ICV_ID_OPAD_0_value = data_low
            else
                read_LOCAL_ICV_ID_OPAD_0_value = (data_low - H8000_0000) and LOCAL_ICV_ID_OPAD_0_mask
            end If
        else
            read_LOCAL_ICV_ID_OPAD_0_value = data_low and LOCAL_ICV_ID_OPAD_0_mask
        end If

    End Sub

    Sub write
        If flag_LOCAL_ICV_ID_OPAD_0 = &H0 Then read
        If flag_LOCAL_ICV_ID_OPAD_0 = &H0 Then write_LOCAL_ICV_ID_OPAD_0_value = get_LOCAL_ICV_ID_OPAD_0

        regValue = leftShift((write_LOCAL_ICV_ID_OPAD_0_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_OPAD_0_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_OPAD_0_mask = mask then
                read_LOCAL_ICV_ID_OPAD_0_value = data_low
            else
                read_LOCAL_ICV_ID_OPAD_0_value = (data_low - H8000_0000) and LOCAL_ICV_ID_OPAD_0_mask
            end If
        else
            read_LOCAL_ICV_ID_OPAD_0_value = data_low and LOCAL_ICV_ID_OPAD_0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LOCAL_ICV_ID_OPAD_0_value = &H0
        flag_LOCAL_ICV_ID_OPAD_0        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_local_icv_id_opad1_p0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LOCAL_ICV_ID_OPAD_1                        [15:0]           get_LOCAL_ICV_ID_OPAD_1
''                                                             set_LOCAL_ICV_ID_OPAD_1
''                                                             read_LOCAL_ICV_ID_OPAD_1
''                                                             write_LOCAL_ICV_ID_OPAD_1
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_local_icv_id_opad1_p0
    Private write_LOCAL_ICV_ID_OPAD_1_value
    Private read_LOCAL_ICV_ID_OPAD_1_value
    Private flag_LOCAL_ICV_ID_OPAD_1

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

    Property Get get_LOCAL_ICV_ID_OPAD_1
        get_LOCAL_ICV_ID_OPAD_1 = read_LOCAL_ICV_ID_OPAD_1_value
    End Property

    Property Let set_LOCAL_ICV_ID_OPAD_1(aData)
        write_LOCAL_ICV_ID_OPAD_1_value = aData
        flag_LOCAL_ICV_ID_OPAD_1        = &H1
    End Property

    Property Get read_LOCAL_ICV_ID_OPAD_1
        read
        read_LOCAL_ICV_ID_OPAD_1 = read_LOCAL_ICV_ID_OPAD_1_value
    End Property

    Property Let write_LOCAL_ICV_ID_OPAD_1(aData)
        set_LOCAL_ICV_ID_OPAD_1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_OPAD_1_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_OPAD_1_mask = mask then
                read_LOCAL_ICV_ID_OPAD_1_value = data_low
            else
                read_LOCAL_ICV_ID_OPAD_1_value = (data_low - H8000_0000) and LOCAL_ICV_ID_OPAD_1_mask
            end If
        else
            read_LOCAL_ICV_ID_OPAD_1_value = data_low and LOCAL_ICV_ID_OPAD_1_mask
        end If

    End Sub

    Sub write
        If flag_LOCAL_ICV_ID_OPAD_1 = &H0 Then read
        If flag_LOCAL_ICV_ID_OPAD_1 = &H0 Then write_LOCAL_ICV_ID_OPAD_1_value = get_LOCAL_ICV_ID_OPAD_1

        regValue = leftShift((write_LOCAL_ICV_ID_OPAD_1_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_OPAD_1_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_OPAD_1_mask = mask then
                read_LOCAL_ICV_ID_OPAD_1_value = data_low
            else
                read_LOCAL_ICV_ID_OPAD_1_value = (data_low - H8000_0000) and LOCAL_ICV_ID_OPAD_1_mask
            end If
        else
            read_LOCAL_ICV_ID_OPAD_1_value = data_low and LOCAL_ICV_ID_OPAD_1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LOCAL_ICV_ID_OPAD_1_value = &H0
        flag_LOCAL_ICV_ID_OPAD_1        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_local_icv_id_opad1_p1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LOCAL_ICV_ID_OPAD_1                        [15:0]           get_LOCAL_ICV_ID_OPAD_1
''                                                             set_LOCAL_ICV_ID_OPAD_1
''                                                             read_LOCAL_ICV_ID_OPAD_1
''                                                             write_LOCAL_ICV_ID_OPAD_1
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_local_icv_id_opad1_p1
    Private write_LOCAL_ICV_ID_OPAD_1_value
    Private read_LOCAL_ICV_ID_OPAD_1_value
    Private flag_LOCAL_ICV_ID_OPAD_1

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H132
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_LOCAL_ICV_ID_OPAD_1
        get_LOCAL_ICV_ID_OPAD_1 = read_LOCAL_ICV_ID_OPAD_1_value
    End Property

    Property Let set_LOCAL_ICV_ID_OPAD_1(aData)
        write_LOCAL_ICV_ID_OPAD_1_value = aData
        flag_LOCAL_ICV_ID_OPAD_1        = &H1
    End Property

    Property Get read_LOCAL_ICV_ID_OPAD_1
        read
        read_LOCAL_ICV_ID_OPAD_1 = read_LOCAL_ICV_ID_OPAD_1_value
    End Property

    Property Let write_LOCAL_ICV_ID_OPAD_1(aData)
        set_LOCAL_ICV_ID_OPAD_1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_OPAD_1_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_OPAD_1_mask = mask then
                read_LOCAL_ICV_ID_OPAD_1_value = data_low
            else
                read_LOCAL_ICV_ID_OPAD_1_value = (data_low - H8000_0000) and LOCAL_ICV_ID_OPAD_1_mask
            end If
        else
            read_LOCAL_ICV_ID_OPAD_1_value = data_low and LOCAL_ICV_ID_OPAD_1_mask
        end If

    End Sub

    Sub write
        If flag_LOCAL_ICV_ID_OPAD_1 = &H0 Then read
        If flag_LOCAL_ICV_ID_OPAD_1 = &H0 Then write_LOCAL_ICV_ID_OPAD_1_value = get_LOCAL_ICV_ID_OPAD_1

        regValue = leftShift((write_LOCAL_ICV_ID_OPAD_1_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_OPAD_1_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_OPAD_1_mask = mask then
                read_LOCAL_ICV_ID_OPAD_1_value = data_low
            else
                read_LOCAL_ICV_ID_OPAD_1_value = (data_low - H8000_0000) and LOCAL_ICV_ID_OPAD_1_mask
            end If
        else
            read_LOCAL_ICV_ID_OPAD_1_value = data_low and LOCAL_ICV_ID_OPAD_1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LOCAL_ICV_ID_OPAD_1_value = &H0
        flag_LOCAL_ICV_ID_OPAD_1        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_local_icv_id_opad1_p2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LOCAL_ICV_ID_OPAD_1                        [15:0]           get_LOCAL_ICV_ID_OPAD_1
''                                                             set_LOCAL_ICV_ID_OPAD_1
''                                                             read_LOCAL_ICV_ID_OPAD_1
''                                                             write_LOCAL_ICV_ID_OPAD_1
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_local_icv_id_opad1_p2
    Private write_LOCAL_ICV_ID_OPAD_1_value
    Private read_LOCAL_ICV_ID_OPAD_1_value
    Private flag_LOCAL_ICV_ID_OPAD_1

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

    Property Get get_LOCAL_ICV_ID_OPAD_1
        get_LOCAL_ICV_ID_OPAD_1 = read_LOCAL_ICV_ID_OPAD_1_value
    End Property

    Property Let set_LOCAL_ICV_ID_OPAD_1(aData)
        write_LOCAL_ICV_ID_OPAD_1_value = aData
        flag_LOCAL_ICV_ID_OPAD_1        = &H1
    End Property

    Property Get read_LOCAL_ICV_ID_OPAD_1
        read
        read_LOCAL_ICV_ID_OPAD_1 = read_LOCAL_ICV_ID_OPAD_1_value
    End Property

    Property Let write_LOCAL_ICV_ID_OPAD_1(aData)
        set_LOCAL_ICV_ID_OPAD_1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_OPAD_1_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_OPAD_1_mask = mask then
                read_LOCAL_ICV_ID_OPAD_1_value = data_low
            else
                read_LOCAL_ICV_ID_OPAD_1_value = (data_low - H8000_0000) and LOCAL_ICV_ID_OPAD_1_mask
            end If
        else
            read_LOCAL_ICV_ID_OPAD_1_value = data_low and LOCAL_ICV_ID_OPAD_1_mask
        end If

    End Sub

    Sub write
        If flag_LOCAL_ICV_ID_OPAD_1 = &H0 Then read
        If flag_LOCAL_ICV_ID_OPAD_1 = &H0 Then write_LOCAL_ICV_ID_OPAD_1_value = get_LOCAL_ICV_ID_OPAD_1

        regValue = leftShift((write_LOCAL_ICV_ID_OPAD_1_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_OPAD_1_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_OPAD_1_mask = mask then
                read_LOCAL_ICV_ID_OPAD_1_value = data_low
            else
                read_LOCAL_ICV_ID_OPAD_1_value = (data_low - H8000_0000) and LOCAL_ICV_ID_OPAD_1_mask
            end If
        else
            read_LOCAL_ICV_ID_OPAD_1_value = data_low and LOCAL_ICV_ID_OPAD_1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LOCAL_ICV_ID_OPAD_1_value = &H0
        flag_LOCAL_ICV_ID_OPAD_1        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_local_icv_id_opad1_p3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LOCAL_ICV_ID_OPAD_1                        [15:0]           get_LOCAL_ICV_ID_OPAD_1
''                                                             set_LOCAL_ICV_ID_OPAD_1
''                                                             read_LOCAL_ICV_ID_OPAD_1
''                                                             write_LOCAL_ICV_ID_OPAD_1
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_local_icv_id_opad1_p3
    Private write_LOCAL_ICV_ID_OPAD_1_value
    Private read_LOCAL_ICV_ID_OPAD_1_value
    Private flag_LOCAL_ICV_ID_OPAD_1

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H136
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_LOCAL_ICV_ID_OPAD_1
        get_LOCAL_ICV_ID_OPAD_1 = read_LOCAL_ICV_ID_OPAD_1_value
    End Property

    Property Let set_LOCAL_ICV_ID_OPAD_1(aData)
        write_LOCAL_ICV_ID_OPAD_1_value = aData
        flag_LOCAL_ICV_ID_OPAD_1        = &H1
    End Property

    Property Get read_LOCAL_ICV_ID_OPAD_1
        read
        read_LOCAL_ICV_ID_OPAD_1 = read_LOCAL_ICV_ID_OPAD_1_value
    End Property

    Property Let write_LOCAL_ICV_ID_OPAD_1(aData)
        set_LOCAL_ICV_ID_OPAD_1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_OPAD_1_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_OPAD_1_mask = mask then
                read_LOCAL_ICV_ID_OPAD_1_value = data_low
            else
                read_LOCAL_ICV_ID_OPAD_1_value = (data_low - H8000_0000) and LOCAL_ICV_ID_OPAD_1_mask
            end If
        else
            read_LOCAL_ICV_ID_OPAD_1_value = data_low and LOCAL_ICV_ID_OPAD_1_mask
        end If

    End Sub

    Sub write
        If flag_LOCAL_ICV_ID_OPAD_1 = &H0 Then read
        If flag_LOCAL_ICV_ID_OPAD_1 = &H0 Then write_LOCAL_ICV_ID_OPAD_1_value = get_LOCAL_ICV_ID_OPAD_1

        regValue = leftShift((write_LOCAL_ICV_ID_OPAD_1_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_OPAD_1_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_OPAD_1_mask = mask then
                read_LOCAL_ICV_ID_OPAD_1_value = data_low
            else
                read_LOCAL_ICV_ID_OPAD_1_value = (data_low - H8000_0000) and LOCAL_ICV_ID_OPAD_1_mask
            end If
        else
            read_LOCAL_ICV_ID_OPAD_1_value = data_low and LOCAL_ICV_ID_OPAD_1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LOCAL_ICV_ID_OPAD_1_value = &H0
        flag_LOCAL_ICV_ID_OPAD_1        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_local_icv_id_opad1_p4
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LOCAL_ICV_ID_OPAD_1                        [15:0]           get_LOCAL_ICV_ID_OPAD_1
''                                                             set_LOCAL_ICV_ID_OPAD_1
''                                                             read_LOCAL_ICV_ID_OPAD_1
''                                                             write_LOCAL_ICV_ID_OPAD_1
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_local_icv_id_opad1_p4
    Private write_LOCAL_ICV_ID_OPAD_1_value
    Private read_LOCAL_ICV_ID_OPAD_1_value
    Private flag_LOCAL_ICV_ID_OPAD_1

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

    Property Get get_LOCAL_ICV_ID_OPAD_1
        get_LOCAL_ICV_ID_OPAD_1 = read_LOCAL_ICV_ID_OPAD_1_value
    End Property

    Property Let set_LOCAL_ICV_ID_OPAD_1(aData)
        write_LOCAL_ICV_ID_OPAD_1_value = aData
        flag_LOCAL_ICV_ID_OPAD_1        = &H1
    End Property

    Property Get read_LOCAL_ICV_ID_OPAD_1
        read
        read_LOCAL_ICV_ID_OPAD_1 = read_LOCAL_ICV_ID_OPAD_1_value
    End Property

    Property Let write_LOCAL_ICV_ID_OPAD_1(aData)
        set_LOCAL_ICV_ID_OPAD_1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_OPAD_1_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_OPAD_1_mask = mask then
                read_LOCAL_ICV_ID_OPAD_1_value = data_low
            else
                read_LOCAL_ICV_ID_OPAD_1_value = (data_low - H8000_0000) and LOCAL_ICV_ID_OPAD_1_mask
            end If
        else
            read_LOCAL_ICV_ID_OPAD_1_value = data_low and LOCAL_ICV_ID_OPAD_1_mask
        end If

    End Sub

    Sub write
        If flag_LOCAL_ICV_ID_OPAD_1 = &H0 Then read
        If flag_LOCAL_ICV_ID_OPAD_1 = &H0 Then write_LOCAL_ICV_ID_OPAD_1_value = get_LOCAL_ICV_ID_OPAD_1

        regValue = leftShift((write_LOCAL_ICV_ID_OPAD_1_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_OPAD_1_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_OPAD_1_mask = mask then
                read_LOCAL_ICV_ID_OPAD_1_value = data_low
            else
                read_LOCAL_ICV_ID_OPAD_1_value = (data_low - H8000_0000) and LOCAL_ICV_ID_OPAD_1_mask
            end If
        else
            read_LOCAL_ICV_ID_OPAD_1_value = data_low and LOCAL_ICV_ID_OPAD_1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LOCAL_ICV_ID_OPAD_1_value = &H0
        flag_LOCAL_ICV_ID_OPAD_1        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_local_icv_id_opad1_p5
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LOCAL_ICV_ID_OPAD_1                        [15:0]           get_LOCAL_ICV_ID_OPAD_1
''                                                             set_LOCAL_ICV_ID_OPAD_1
''                                                             read_LOCAL_ICV_ID_OPAD_1
''                                                             write_LOCAL_ICV_ID_OPAD_1
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_local_icv_id_opad1_p5
    Private write_LOCAL_ICV_ID_OPAD_1_value
    Private read_LOCAL_ICV_ID_OPAD_1_value
    Private flag_LOCAL_ICV_ID_OPAD_1

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H13a
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_LOCAL_ICV_ID_OPAD_1
        get_LOCAL_ICV_ID_OPAD_1 = read_LOCAL_ICV_ID_OPAD_1_value
    End Property

    Property Let set_LOCAL_ICV_ID_OPAD_1(aData)
        write_LOCAL_ICV_ID_OPAD_1_value = aData
        flag_LOCAL_ICV_ID_OPAD_1        = &H1
    End Property

    Property Get read_LOCAL_ICV_ID_OPAD_1
        read
        read_LOCAL_ICV_ID_OPAD_1 = read_LOCAL_ICV_ID_OPAD_1_value
    End Property

    Property Let write_LOCAL_ICV_ID_OPAD_1(aData)
        set_LOCAL_ICV_ID_OPAD_1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_OPAD_1_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_OPAD_1_mask = mask then
                read_LOCAL_ICV_ID_OPAD_1_value = data_low
            else
                read_LOCAL_ICV_ID_OPAD_1_value = (data_low - H8000_0000) and LOCAL_ICV_ID_OPAD_1_mask
            end If
        else
            read_LOCAL_ICV_ID_OPAD_1_value = data_low and LOCAL_ICV_ID_OPAD_1_mask
        end If

    End Sub

    Sub write
        If flag_LOCAL_ICV_ID_OPAD_1 = &H0 Then read
        If flag_LOCAL_ICV_ID_OPAD_1 = &H0 Then write_LOCAL_ICV_ID_OPAD_1_value = get_LOCAL_ICV_ID_OPAD_1

        regValue = leftShift((write_LOCAL_ICV_ID_OPAD_1_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_OPAD_1_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_OPAD_1_mask = mask then
                read_LOCAL_ICV_ID_OPAD_1_value = data_low
            else
                read_LOCAL_ICV_ID_OPAD_1_value = (data_low - H8000_0000) and LOCAL_ICV_ID_OPAD_1_mask
            end If
        else
            read_LOCAL_ICV_ID_OPAD_1_value = data_low and LOCAL_ICV_ID_OPAD_1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LOCAL_ICV_ID_OPAD_1_value = &H0
        flag_LOCAL_ICV_ID_OPAD_1        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_local_icv_id_opad2_p0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LOCAL_ICV_ID_OPAD_2                        [15:0]           get_LOCAL_ICV_ID_OPAD_2
''                                                             set_LOCAL_ICV_ID_OPAD_2
''                                                             read_LOCAL_ICV_ID_OPAD_2
''                                                             write_LOCAL_ICV_ID_OPAD_2
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_local_icv_id_opad2_p0
    Private write_LOCAL_ICV_ID_OPAD_2_value
    Private read_LOCAL_ICV_ID_OPAD_2_value
    Private flag_LOCAL_ICV_ID_OPAD_2

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

    Property Get get_LOCAL_ICV_ID_OPAD_2
        get_LOCAL_ICV_ID_OPAD_2 = read_LOCAL_ICV_ID_OPAD_2_value
    End Property

    Property Let set_LOCAL_ICV_ID_OPAD_2(aData)
        write_LOCAL_ICV_ID_OPAD_2_value = aData
        flag_LOCAL_ICV_ID_OPAD_2        = &H1
    End Property

    Property Get read_LOCAL_ICV_ID_OPAD_2
        read
        read_LOCAL_ICV_ID_OPAD_2 = read_LOCAL_ICV_ID_OPAD_2_value
    End Property

    Property Let write_LOCAL_ICV_ID_OPAD_2(aData)
        set_LOCAL_ICV_ID_OPAD_2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_OPAD_2_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_OPAD_2_mask = mask then
                read_LOCAL_ICV_ID_OPAD_2_value = data_low
            else
                read_LOCAL_ICV_ID_OPAD_2_value = (data_low - H8000_0000) and LOCAL_ICV_ID_OPAD_2_mask
            end If
        else
            read_LOCAL_ICV_ID_OPAD_2_value = data_low and LOCAL_ICV_ID_OPAD_2_mask
        end If

    End Sub

    Sub write
        If flag_LOCAL_ICV_ID_OPAD_2 = &H0 Then read
        If flag_LOCAL_ICV_ID_OPAD_2 = &H0 Then write_LOCAL_ICV_ID_OPAD_2_value = get_LOCAL_ICV_ID_OPAD_2

        regValue = leftShift((write_LOCAL_ICV_ID_OPAD_2_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_OPAD_2_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_OPAD_2_mask = mask then
                read_LOCAL_ICV_ID_OPAD_2_value = data_low
            else
                read_LOCAL_ICV_ID_OPAD_2_value = (data_low - H8000_0000) and LOCAL_ICV_ID_OPAD_2_mask
            end If
        else
            read_LOCAL_ICV_ID_OPAD_2_value = data_low and LOCAL_ICV_ID_OPAD_2_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LOCAL_ICV_ID_OPAD_2_value = &H0
        flag_LOCAL_ICV_ID_OPAD_2        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_local_icv_id_opad2_p1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LOCAL_ICV_ID_OPAD_2                        [15:0]           get_LOCAL_ICV_ID_OPAD_2
''                                                             set_LOCAL_ICV_ID_OPAD_2
''                                                             read_LOCAL_ICV_ID_OPAD_2
''                                                             write_LOCAL_ICV_ID_OPAD_2
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_local_icv_id_opad2_p1
    Private write_LOCAL_ICV_ID_OPAD_2_value
    Private read_LOCAL_ICV_ID_OPAD_2_value
    Private flag_LOCAL_ICV_ID_OPAD_2

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H142
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_LOCAL_ICV_ID_OPAD_2
        get_LOCAL_ICV_ID_OPAD_2 = read_LOCAL_ICV_ID_OPAD_2_value
    End Property

    Property Let set_LOCAL_ICV_ID_OPAD_2(aData)
        write_LOCAL_ICV_ID_OPAD_2_value = aData
        flag_LOCAL_ICV_ID_OPAD_2        = &H1
    End Property

    Property Get read_LOCAL_ICV_ID_OPAD_2
        read
        read_LOCAL_ICV_ID_OPAD_2 = read_LOCAL_ICV_ID_OPAD_2_value
    End Property

    Property Let write_LOCAL_ICV_ID_OPAD_2(aData)
        set_LOCAL_ICV_ID_OPAD_2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_OPAD_2_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_OPAD_2_mask = mask then
                read_LOCAL_ICV_ID_OPAD_2_value = data_low
            else
                read_LOCAL_ICV_ID_OPAD_2_value = (data_low - H8000_0000) and LOCAL_ICV_ID_OPAD_2_mask
            end If
        else
            read_LOCAL_ICV_ID_OPAD_2_value = data_low and LOCAL_ICV_ID_OPAD_2_mask
        end If

    End Sub

    Sub write
        If flag_LOCAL_ICV_ID_OPAD_2 = &H0 Then read
        If flag_LOCAL_ICV_ID_OPAD_2 = &H0 Then write_LOCAL_ICV_ID_OPAD_2_value = get_LOCAL_ICV_ID_OPAD_2

        regValue = leftShift((write_LOCAL_ICV_ID_OPAD_2_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_OPAD_2_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_OPAD_2_mask = mask then
                read_LOCAL_ICV_ID_OPAD_2_value = data_low
            else
                read_LOCAL_ICV_ID_OPAD_2_value = (data_low - H8000_0000) and LOCAL_ICV_ID_OPAD_2_mask
            end If
        else
            read_LOCAL_ICV_ID_OPAD_2_value = data_low and LOCAL_ICV_ID_OPAD_2_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LOCAL_ICV_ID_OPAD_2_value = &H0
        flag_LOCAL_ICV_ID_OPAD_2        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_local_icv_id_opad2_p2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LOCAL_ICV_ID_OPAD_2                        [15:0]           get_LOCAL_ICV_ID_OPAD_2
''                                                             set_LOCAL_ICV_ID_OPAD_2
''                                                             read_LOCAL_ICV_ID_OPAD_2
''                                                             write_LOCAL_ICV_ID_OPAD_2
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_local_icv_id_opad2_p2
    Private write_LOCAL_ICV_ID_OPAD_2_value
    Private read_LOCAL_ICV_ID_OPAD_2_value
    Private flag_LOCAL_ICV_ID_OPAD_2

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

    Property Get get_LOCAL_ICV_ID_OPAD_2
        get_LOCAL_ICV_ID_OPAD_2 = read_LOCAL_ICV_ID_OPAD_2_value
    End Property

    Property Let set_LOCAL_ICV_ID_OPAD_2(aData)
        write_LOCAL_ICV_ID_OPAD_2_value = aData
        flag_LOCAL_ICV_ID_OPAD_2        = &H1
    End Property

    Property Get read_LOCAL_ICV_ID_OPAD_2
        read
        read_LOCAL_ICV_ID_OPAD_2 = read_LOCAL_ICV_ID_OPAD_2_value
    End Property

    Property Let write_LOCAL_ICV_ID_OPAD_2(aData)
        set_LOCAL_ICV_ID_OPAD_2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_OPAD_2_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_OPAD_2_mask = mask then
                read_LOCAL_ICV_ID_OPAD_2_value = data_low
            else
                read_LOCAL_ICV_ID_OPAD_2_value = (data_low - H8000_0000) and LOCAL_ICV_ID_OPAD_2_mask
            end If
        else
            read_LOCAL_ICV_ID_OPAD_2_value = data_low and LOCAL_ICV_ID_OPAD_2_mask
        end If

    End Sub

    Sub write
        If flag_LOCAL_ICV_ID_OPAD_2 = &H0 Then read
        If flag_LOCAL_ICV_ID_OPAD_2 = &H0 Then write_LOCAL_ICV_ID_OPAD_2_value = get_LOCAL_ICV_ID_OPAD_2

        regValue = leftShift((write_LOCAL_ICV_ID_OPAD_2_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_OPAD_2_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_OPAD_2_mask = mask then
                read_LOCAL_ICV_ID_OPAD_2_value = data_low
            else
                read_LOCAL_ICV_ID_OPAD_2_value = (data_low - H8000_0000) and LOCAL_ICV_ID_OPAD_2_mask
            end If
        else
            read_LOCAL_ICV_ID_OPAD_2_value = data_low and LOCAL_ICV_ID_OPAD_2_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LOCAL_ICV_ID_OPAD_2_value = &H0
        flag_LOCAL_ICV_ID_OPAD_2        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_local_icv_id_opad2_p3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LOCAL_ICV_ID_OPAD_2                        [15:0]           get_LOCAL_ICV_ID_OPAD_2
''                                                             set_LOCAL_ICV_ID_OPAD_2
''                                                             read_LOCAL_ICV_ID_OPAD_2
''                                                             write_LOCAL_ICV_ID_OPAD_2
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_local_icv_id_opad2_p3
    Private write_LOCAL_ICV_ID_OPAD_2_value
    Private read_LOCAL_ICV_ID_OPAD_2_value
    Private flag_LOCAL_ICV_ID_OPAD_2

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H146
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_LOCAL_ICV_ID_OPAD_2
        get_LOCAL_ICV_ID_OPAD_2 = read_LOCAL_ICV_ID_OPAD_2_value
    End Property

    Property Let set_LOCAL_ICV_ID_OPAD_2(aData)
        write_LOCAL_ICV_ID_OPAD_2_value = aData
        flag_LOCAL_ICV_ID_OPAD_2        = &H1
    End Property

    Property Get read_LOCAL_ICV_ID_OPAD_2
        read
        read_LOCAL_ICV_ID_OPAD_2 = read_LOCAL_ICV_ID_OPAD_2_value
    End Property

    Property Let write_LOCAL_ICV_ID_OPAD_2(aData)
        set_LOCAL_ICV_ID_OPAD_2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_OPAD_2_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_OPAD_2_mask = mask then
                read_LOCAL_ICV_ID_OPAD_2_value = data_low
            else
                read_LOCAL_ICV_ID_OPAD_2_value = (data_low - H8000_0000) and LOCAL_ICV_ID_OPAD_2_mask
            end If
        else
            read_LOCAL_ICV_ID_OPAD_2_value = data_low and LOCAL_ICV_ID_OPAD_2_mask
        end If

    End Sub

    Sub write
        If flag_LOCAL_ICV_ID_OPAD_2 = &H0 Then read
        If flag_LOCAL_ICV_ID_OPAD_2 = &H0 Then write_LOCAL_ICV_ID_OPAD_2_value = get_LOCAL_ICV_ID_OPAD_2

        regValue = leftShift((write_LOCAL_ICV_ID_OPAD_2_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_OPAD_2_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_OPAD_2_mask = mask then
                read_LOCAL_ICV_ID_OPAD_2_value = data_low
            else
                read_LOCAL_ICV_ID_OPAD_2_value = (data_low - H8000_0000) and LOCAL_ICV_ID_OPAD_2_mask
            end If
        else
            read_LOCAL_ICV_ID_OPAD_2_value = data_low and LOCAL_ICV_ID_OPAD_2_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LOCAL_ICV_ID_OPAD_2_value = &H0
        flag_LOCAL_ICV_ID_OPAD_2        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_local_icv_id_opad2_p4
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LOCAL_ICV_ID_OPAD_2                        [15:0]           get_LOCAL_ICV_ID_OPAD_2
''                                                             set_LOCAL_ICV_ID_OPAD_2
''                                                             read_LOCAL_ICV_ID_OPAD_2
''                                                             write_LOCAL_ICV_ID_OPAD_2
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_local_icv_id_opad2_p4
    Private write_LOCAL_ICV_ID_OPAD_2_value
    Private read_LOCAL_ICV_ID_OPAD_2_value
    Private flag_LOCAL_ICV_ID_OPAD_2

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

    Property Get get_LOCAL_ICV_ID_OPAD_2
        get_LOCAL_ICV_ID_OPAD_2 = read_LOCAL_ICV_ID_OPAD_2_value
    End Property

    Property Let set_LOCAL_ICV_ID_OPAD_2(aData)
        write_LOCAL_ICV_ID_OPAD_2_value = aData
        flag_LOCAL_ICV_ID_OPAD_2        = &H1
    End Property

    Property Get read_LOCAL_ICV_ID_OPAD_2
        read
        read_LOCAL_ICV_ID_OPAD_2 = read_LOCAL_ICV_ID_OPAD_2_value
    End Property

    Property Let write_LOCAL_ICV_ID_OPAD_2(aData)
        set_LOCAL_ICV_ID_OPAD_2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_OPAD_2_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_OPAD_2_mask = mask then
                read_LOCAL_ICV_ID_OPAD_2_value = data_low
            else
                read_LOCAL_ICV_ID_OPAD_2_value = (data_low - H8000_0000) and LOCAL_ICV_ID_OPAD_2_mask
            end If
        else
            read_LOCAL_ICV_ID_OPAD_2_value = data_low and LOCAL_ICV_ID_OPAD_2_mask
        end If

    End Sub

    Sub write
        If flag_LOCAL_ICV_ID_OPAD_2 = &H0 Then read
        If flag_LOCAL_ICV_ID_OPAD_2 = &H0 Then write_LOCAL_ICV_ID_OPAD_2_value = get_LOCAL_ICV_ID_OPAD_2

        regValue = leftShift((write_LOCAL_ICV_ID_OPAD_2_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_OPAD_2_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_OPAD_2_mask = mask then
                read_LOCAL_ICV_ID_OPAD_2_value = data_low
            else
                read_LOCAL_ICV_ID_OPAD_2_value = (data_low - H8000_0000) and LOCAL_ICV_ID_OPAD_2_mask
            end If
        else
            read_LOCAL_ICV_ID_OPAD_2_value = data_low and LOCAL_ICV_ID_OPAD_2_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LOCAL_ICV_ID_OPAD_2_value = &H0
        flag_LOCAL_ICV_ID_OPAD_2        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_local_icv_id_opad2_p5
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LOCAL_ICV_ID_OPAD_2                        [15:0]           get_LOCAL_ICV_ID_OPAD_2
''                                                             set_LOCAL_ICV_ID_OPAD_2
''                                                             read_LOCAL_ICV_ID_OPAD_2
''                                                             write_LOCAL_ICV_ID_OPAD_2
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_local_icv_id_opad2_p5
    Private write_LOCAL_ICV_ID_OPAD_2_value
    Private read_LOCAL_ICV_ID_OPAD_2_value
    Private flag_LOCAL_ICV_ID_OPAD_2

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H14a
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_LOCAL_ICV_ID_OPAD_2
        get_LOCAL_ICV_ID_OPAD_2 = read_LOCAL_ICV_ID_OPAD_2_value
    End Property

    Property Let set_LOCAL_ICV_ID_OPAD_2(aData)
        write_LOCAL_ICV_ID_OPAD_2_value = aData
        flag_LOCAL_ICV_ID_OPAD_2        = &H1
    End Property

    Property Get read_LOCAL_ICV_ID_OPAD_2
        read
        read_LOCAL_ICV_ID_OPAD_2 = read_LOCAL_ICV_ID_OPAD_2_value
    End Property

    Property Let write_LOCAL_ICV_ID_OPAD_2(aData)
        set_LOCAL_ICV_ID_OPAD_2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_OPAD_2_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_OPAD_2_mask = mask then
                read_LOCAL_ICV_ID_OPAD_2_value = data_low
            else
                read_LOCAL_ICV_ID_OPAD_2_value = (data_low - H8000_0000) and LOCAL_ICV_ID_OPAD_2_mask
            end If
        else
            read_LOCAL_ICV_ID_OPAD_2_value = data_low and LOCAL_ICV_ID_OPAD_2_mask
        end If

    End Sub

    Sub write
        If flag_LOCAL_ICV_ID_OPAD_2 = &H0 Then read
        If flag_LOCAL_ICV_ID_OPAD_2 = &H0 Then write_LOCAL_ICV_ID_OPAD_2_value = get_LOCAL_ICV_ID_OPAD_2

        regValue = leftShift((write_LOCAL_ICV_ID_OPAD_2_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_OPAD_2_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_OPAD_2_mask = mask then
                read_LOCAL_ICV_ID_OPAD_2_value = data_low
            else
                read_LOCAL_ICV_ID_OPAD_2_value = (data_low - H8000_0000) and LOCAL_ICV_ID_OPAD_2_mask
            end If
        else
            read_LOCAL_ICV_ID_OPAD_2_value = data_low and LOCAL_ICV_ID_OPAD_2_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LOCAL_ICV_ID_OPAD_2_value = &H0
        flag_LOCAL_ICV_ID_OPAD_2        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_local_icv_id_opad3_p0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LOCAL_ICV_ID_OPAD_3                        [15:0]           get_LOCAL_ICV_ID_OPAD_3
''                                                             set_LOCAL_ICV_ID_OPAD_3
''                                                             read_LOCAL_ICV_ID_OPAD_3
''                                                             write_LOCAL_ICV_ID_OPAD_3
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_local_icv_id_opad3_p0
    Private write_LOCAL_ICV_ID_OPAD_3_value
    Private read_LOCAL_ICV_ID_OPAD_3_value
    Private flag_LOCAL_ICV_ID_OPAD_3

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

    Property Get get_LOCAL_ICV_ID_OPAD_3
        get_LOCAL_ICV_ID_OPAD_3 = read_LOCAL_ICV_ID_OPAD_3_value
    End Property

    Property Let set_LOCAL_ICV_ID_OPAD_3(aData)
        write_LOCAL_ICV_ID_OPAD_3_value = aData
        flag_LOCAL_ICV_ID_OPAD_3        = &H1
    End Property

    Property Get read_LOCAL_ICV_ID_OPAD_3
        read
        read_LOCAL_ICV_ID_OPAD_3 = read_LOCAL_ICV_ID_OPAD_3_value
    End Property

    Property Let write_LOCAL_ICV_ID_OPAD_3(aData)
        set_LOCAL_ICV_ID_OPAD_3 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_OPAD_3_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_OPAD_3_mask = mask then
                read_LOCAL_ICV_ID_OPAD_3_value = data_low
            else
                read_LOCAL_ICV_ID_OPAD_3_value = (data_low - H8000_0000) and LOCAL_ICV_ID_OPAD_3_mask
            end If
        else
            read_LOCAL_ICV_ID_OPAD_3_value = data_low and LOCAL_ICV_ID_OPAD_3_mask
        end If

    End Sub

    Sub write
        If flag_LOCAL_ICV_ID_OPAD_3 = &H0 Then read
        If flag_LOCAL_ICV_ID_OPAD_3 = &H0 Then write_LOCAL_ICV_ID_OPAD_3_value = get_LOCAL_ICV_ID_OPAD_3

        regValue = leftShift((write_LOCAL_ICV_ID_OPAD_3_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_OPAD_3_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_OPAD_3_mask = mask then
                read_LOCAL_ICV_ID_OPAD_3_value = data_low
            else
                read_LOCAL_ICV_ID_OPAD_3_value = (data_low - H8000_0000) and LOCAL_ICV_ID_OPAD_3_mask
            end If
        else
            read_LOCAL_ICV_ID_OPAD_3_value = data_low and LOCAL_ICV_ID_OPAD_3_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LOCAL_ICV_ID_OPAD_3_value = &H0
        flag_LOCAL_ICV_ID_OPAD_3        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_local_icv_id_opad3_p1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LOCAL_ICV_ID_OPAD_3                        [15:0]           get_LOCAL_ICV_ID_OPAD_3
''                                                             set_LOCAL_ICV_ID_OPAD_3
''                                                             read_LOCAL_ICV_ID_OPAD_3
''                                                             write_LOCAL_ICV_ID_OPAD_3
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_local_icv_id_opad3_p1
    Private write_LOCAL_ICV_ID_OPAD_3_value
    Private read_LOCAL_ICV_ID_OPAD_3_value
    Private flag_LOCAL_ICV_ID_OPAD_3

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H152
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_LOCAL_ICV_ID_OPAD_3
        get_LOCAL_ICV_ID_OPAD_3 = read_LOCAL_ICV_ID_OPAD_3_value
    End Property

    Property Let set_LOCAL_ICV_ID_OPAD_3(aData)
        write_LOCAL_ICV_ID_OPAD_3_value = aData
        flag_LOCAL_ICV_ID_OPAD_3        = &H1
    End Property

    Property Get read_LOCAL_ICV_ID_OPAD_3
        read
        read_LOCAL_ICV_ID_OPAD_3 = read_LOCAL_ICV_ID_OPAD_3_value
    End Property

    Property Let write_LOCAL_ICV_ID_OPAD_3(aData)
        set_LOCAL_ICV_ID_OPAD_3 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_OPAD_3_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_OPAD_3_mask = mask then
                read_LOCAL_ICV_ID_OPAD_3_value = data_low
            else
                read_LOCAL_ICV_ID_OPAD_3_value = (data_low - H8000_0000) and LOCAL_ICV_ID_OPAD_3_mask
            end If
        else
            read_LOCAL_ICV_ID_OPAD_3_value = data_low and LOCAL_ICV_ID_OPAD_3_mask
        end If

    End Sub

    Sub write
        If flag_LOCAL_ICV_ID_OPAD_3 = &H0 Then read
        If flag_LOCAL_ICV_ID_OPAD_3 = &H0 Then write_LOCAL_ICV_ID_OPAD_3_value = get_LOCAL_ICV_ID_OPAD_3

        regValue = leftShift((write_LOCAL_ICV_ID_OPAD_3_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_OPAD_3_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_OPAD_3_mask = mask then
                read_LOCAL_ICV_ID_OPAD_3_value = data_low
            else
                read_LOCAL_ICV_ID_OPAD_3_value = (data_low - H8000_0000) and LOCAL_ICV_ID_OPAD_3_mask
            end If
        else
            read_LOCAL_ICV_ID_OPAD_3_value = data_low and LOCAL_ICV_ID_OPAD_3_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LOCAL_ICV_ID_OPAD_3_value = &H0
        flag_LOCAL_ICV_ID_OPAD_3        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_local_icv_id_opad3_p2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LOCAL_ICV_ID_OPAD_3                        [15:0]           get_LOCAL_ICV_ID_OPAD_3
''                                                             set_LOCAL_ICV_ID_OPAD_3
''                                                             read_LOCAL_ICV_ID_OPAD_3
''                                                             write_LOCAL_ICV_ID_OPAD_3
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_local_icv_id_opad3_p2
    Private write_LOCAL_ICV_ID_OPAD_3_value
    Private read_LOCAL_ICV_ID_OPAD_3_value
    Private flag_LOCAL_ICV_ID_OPAD_3

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

    Property Get get_LOCAL_ICV_ID_OPAD_3
        get_LOCAL_ICV_ID_OPAD_3 = read_LOCAL_ICV_ID_OPAD_3_value
    End Property

    Property Let set_LOCAL_ICV_ID_OPAD_3(aData)
        write_LOCAL_ICV_ID_OPAD_3_value = aData
        flag_LOCAL_ICV_ID_OPAD_3        = &H1
    End Property

    Property Get read_LOCAL_ICV_ID_OPAD_3
        read
        read_LOCAL_ICV_ID_OPAD_3 = read_LOCAL_ICV_ID_OPAD_3_value
    End Property

    Property Let write_LOCAL_ICV_ID_OPAD_3(aData)
        set_LOCAL_ICV_ID_OPAD_3 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_OPAD_3_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_OPAD_3_mask = mask then
                read_LOCAL_ICV_ID_OPAD_3_value = data_low
            else
                read_LOCAL_ICV_ID_OPAD_3_value = (data_low - H8000_0000) and LOCAL_ICV_ID_OPAD_3_mask
            end If
        else
            read_LOCAL_ICV_ID_OPAD_3_value = data_low and LOCAL_ICV_ID_OPAD_3_mask
        end If

    End Sub

    Sub write
        If flag_LOCAL_ICV_ID_OPAD_3 = &H0 Then read
        If flag_LOCAL_ICV_ID_OPAD_3 = &H0 Then write_LOCAL_ICV_ID_OPAD_3_value = get_LOCAL_ICV_ID_OPAD_3

        regValue = leftShift((write_LOCAL_ICV_ID_OPAD_3_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_OPAD_3_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_OPAD_3_mask = mask then
                read_LOCAL_ICV_ID_OPAD_3_value = data_low
            else
                read_LOCAL_ICV_ID_OPAD_3_value = (data_low - H8000_0000) and LOCAL_ICV_ID_OPAD_3_mask
            end If
        else
            read_LOCAL_ICV_ID_OPAD_3_value = data_low and LOCAL_ICV_ID_OPAD_3_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LOCAL_ICV_ID_OPAD_3_value = &H0
        flag_LOCAL_ICV_ID_OPAD_3        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_local_icv_id_opad3_p3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LOCAL_ICV_ID_OPAD_3                        [15:0]           get_LOCAL_ICV_ID_OPAD_3
''                                                             set_LOCAL_ICV_ID_OPAD_3
''                                                             read_LOCAL_ICV_ID_OPAD_3
''                                                             write_LOCAL_ICV_ID_OPAD_3
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_local_icv_id_opad3_p3
    Private write_LOCAL_ICV_ID_OPAD_3_value
    Private read_LOCAL_ICV_ID_OPAD_3_value
    Private flag_LOCAL_ICV_ID_OPAD_3

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H156
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_LOCAL_ICV_ID_OPAD_3
        get_LOCAL_ICV_ID_OPAD_3 = read_LOCAL_ICV_ID_OPAD_3_value
    End Property

    Property Let set_LOCAL_ICV_ID_OPAD_3(aData)
        write_LOCAL_ICV_ID_OPAD_3_value = aData
        flag_LOCAL_ICV_ID_OPAD_3        = &H1
    End Property

    Property Get read_LOCAL_ICV_ID_OPAD_3
        read
        read_LOCAL_ICV_ID_OPAD_3 = read_LOCAL_ICV_ID_OPAD_3_value
    End Property

    Property Let write_LOCAL_ICV_ID_OPAD_3(aData)
        set_LOCAL_ICV_ID_OPAD_3 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_OPAD_3_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_OPAD_3_mask = mask then
                read_LOCAL_ICV_ID_OPAD_3_value = data_low
            else
                read_LOCAL_ICV_ID_OPAD_3_value = (data_low - H8000_0000) and LOCAL_ICV_ID_OPAD_3_mask
            end If
        else
            read_LOCAL_ICV_ID_OPAD_3_value = data_low and LOCAL_ICV_ID_OPAD_3_mask
        end If

    End Sub

    Sub write
        If flag_LOCAL_ICV_ID_OPAD_3 = &H0 Then read
        If flag_LOCAL_ICV_ID_OPAD_3 = &H0 Then write_LOCAL_ICV_ID_OPAD_3_value = get_LOCAL_ICV_ID_OPAD_3

        regValue = leftShift((write_LOCAL_ICV_ID_OPAD_3_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_OPAD_3_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_OPAD_3_mask = mask then
                read_LOCAL_ICV_ID_OPAD_3_value = data_low
            else
                read_LOCAL_ICV_ID_OPAD_3_value = (data_low - H8000_0000) and LOCAL_ICV_ID_OPAD_3_mask
            end If
        else
            read_LOCAL_ICV_ID_OPAD_3_value = data_low and LOCAL_ICV_ID_OPAD_3_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LOCAL_ICV_ID_OPAD_3_value = &H0
        flag_LOCAL_ICV_ID_OPAD_3        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_local_icv_id_opad3_p4
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LOCAL_ICV_ID_OPAD_3                        [15:0]           get_LOCAL_ICV_ID_OPAD_3
''                                                             set_LOCAL_ICV_ID_OPAD_3
''                                                             read_LOCAL_ICV_ID_OPAD_3
''                                                             write_LOCAL_ICV_ID_OPAD_3
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_local_icv_id_opad3_p4
    Private write_LOCAL_ICV_ID_OPAD_3_value
    Private read_LOCAL_ICV_ID_OPAD_3_value
    Private flag_LOCAL_ICV_ID_OPAD_3

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

    Property Get get_LOCAL_ICV_ID_OPAD_3
        get_LOCAL_ICV_ID_OPAD_3 = read_LOCAL_ICV_ID_OPAD_3_value
    End Property

    Property Let set_LOCAL_ICV_ID_OPAD_3(aData)
        write_LOCAL_ICV_ID_OPAD_3_value = aData
        flag_LOCAL_ICV_ID_OPAD_3        = &H1
    End Property

    Property Get read_LOCAL_ICV_ID_OPAD_3
        read
        read_LOCAL_ICV_ID_OPAD_3 = read_LOCAL_ICV_ID_OPAD_3_value
    End Property

    Property Let write_LOCAL_ICV_ID_OPAD_3(aData)
        set_LOCAL_ICV_ID_OPAD_3 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_OPAD_3_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_OPAD_3_mask = mask then
                read_LOCAL_ICV_ID_OPAD_3_value = data_low
            else
                read_LOCAL_ICV_ID_OPAD_3_value = (data_low - H8000_0000) and LOCAL_ICV_ID_OPAD_3_mask
            end If
        else
            read_LOCAL_ICV_ID_OPAD_3_value = data_low and LOCAL_ICV_ID_OPAD_3_mask
        end If

    End Sub

    Sub write
        If flag_LOCAL_ICV_ID_OPAD_3 = &H0 Then read
        If flag_LOCAL_ICV_ID_OPAD_3 = &H0 Then write_LOCAL_ICV_ID_OPAD_3_value = get_LOCAL_ICV_ID_OPAD_3

        regValue = leftShift((write_LOCAL_ICV_ID_OPAD_3_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_OPAD_3_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_OPAD_3_mask = mask then
                read_LOCAL_ICV_ID_OPAD_3_value = data_low
            else
                read_LOCAL_ICV_ID_OPAD_3_value = (data_low - H8000_0000) and LOCAL_ICV_ID_OPAD_3_mask
            end If
        else
            read_LOCAL_ICV_ID_OPAD_3_value = data_low and LOCAL_ICV_ID_OPAD_3_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LOCAL_ICV_ID_OPAD_3_value = &H0
        flag_LOCAL_ICV_ID_OPAD_3        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_local_icv_id_opad3_p5
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LOCAL_ICV_ID_OPAD_3                        [15:0]           get_LOCAL_ICV_ID_OPAD_3
''                                                             set_LOCAL_ICV_ID_OPAD_3
''                                                             read_LOCAL_ICV_ID_OPAD_3
''                                                             write_LOCAL_ICV_ID_OPAD_3
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_local_icv_id_opad3_p5
    Private write_LOCAL_ICV_ID_OPAD_3_value
    Private read_LOCAL_ICV_ID_OPAD_3_value
    Private flag_LOCAL_ICV_ID_OPAD_3

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H15a
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_LOCAL_ICV_ID_OPAD_3
        get_LOCAL_ICV_ID_OPAD_3 = read_LOCAL_ICV_ID_OPAD_3_value
    End Property

    Property Let set_LOCAL_ICV_ID_OPAD_3(aData)
        write_LOCAL_ICV_ID_OPAD_3_value = aData
        flag_LOCAL_ICV_ID_OPAD_3        = &H1
    End Property

    Property Get read_LOCAL_ICV_ID_OPAD_3
        read
        read_LOCAL_ICV_ID_OPAD_3 = read_LOCAL_ICV_ID_OPAD_3_value
    End Property

    Property Let write_LOCAL_ICV_ID_OPAD_3(aData)
        set_LOCAL_ICV_ID_OPAD_3 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_OPAD_3_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_OPAD_3_mask = mask then
                read_LOCAL_ICV_ID_OPAD_3_value = data_low
            else
                read_LOCAL_ICV_ID_OPAD_3_value = (data_low - H8000_0000) and LOCAL_ICV_ID_OPAD_3_mask
            end If
        else
            read_LOCAL_ICV_ID_OPAD_3_value = data_low and LOCAL_ICV_ID_OPAD_3_mask
        end If

    End Sub

    Sub write
        If flag_LOCAL_ICV_ID_OPAD_3 = &H0 Then read
        If flag_LOCAL_ICV_ID_OPAD_3 = &H0 Then write_LOCAL_ICV_ID_OPAD_3_value = get_LOCAL_ICV_ID_OPAD_3

        regValue = leftShift((write_LOCAL_ICV_ID_OPAD_3_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOCAL_ICV_ID_OPAD_3_mask = &Hffff
        if data_low > LONG_MAX then
            if LOCAL_ICV_ID_OPAD_3_mask = mask then
                read_LOCAL_ICV_ID_OPAD_3_value = data_low
            else
                read_LOCAL_ICV_ID_OPAD_3_value = (data_low - H8000_0000) and LOCAL_ICV_ID_OPAD_3_mask
            end If
        else
            read_LOCAL_ICV_ID_OPAD_3_value = data_low and LOCAL_ICV_ID_OPAD_3_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LOCAL_ICV_ID_OPAD_3_value = &H0
        flag_LOCAL_ICV_ID_OPAD_3        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_remote_icv_id_opad0_p0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' REMOTE_ICV_ID_OPAD_0                       [15:0]           get_REMOTE_ICV_ID_OPAD_0
''                                                             set_REMOTE_ICV_ID_OPAD_0
''                                                             read_REMOTE_ICV_ID_OPAD_0
''                                                             write_REMOTE_ICV_ID_OPAD_0
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_remote_icv_id_opad0_p0
    Private write_REMOTE_ICV_ID_OPAD_0_value
    Private read_REMOTE_ICV_ID_OPAD_0_value
    Private flag_REMOTE_ICV_ID_OPAD_0

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H160
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_REMOTE_ICV_ID_OPAD_0
        get_REMOTE_ICV_ID_OPAD_0 = read_REMOTE_ICV_ID_OPAD_0_value
    End Property

    Property Let set_REMOTE_ICV_ID_OPAD_0(aData)
        write_REMOTE_ICV_ID_OPAD_0_value = aData
        flag_REMOTE_ICV_ID_OPAD_0        = &H1
    End Property

    Property Get read_REMOTE_ICV_ID_OPAD_0
        read
        read_REMOTE_ICV_ID_OPAD_0 = read_REMOTE_ICV_ID_OPAD_0_value
    End Property

    Property Let write_REMOTE_ICV_ID_OPAD_0(aData)
        set_REMOTE_ICV_ID_OPAD_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_OPAD_0_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_OPAD_0_mask = mask then
                read_REMOTE_ICV_ID_OPAD_0_value = data_low
            else
                read_REMOTE_ICV_ID_OPAD_0_value = (data_low - H8000_0000) and REMOTE_ICV_ID_OPAD_0_mask
            end If
        else
            read_REMOTE_ICV_ID_OPAD_0_value = data_low and REMOTE_ICV_ID_OPAD_0_mask
        end If

    End Sub

    Sub write
        If flag_REMOTE_ICV_ID_OPAD_0 = &H0 Then read
        If flag_REMOTE_ICV_ID_OPAD_0 = &H0 Then write_REMOTE_ICV_ID_OPAD_0_value = get_REMOTE_ICV_ID_OPAD_0

        regValue = leftShift((write_REMOTE_ICV_ID_OPAD_0_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_OPAD_0_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_OPAD_0_mask = mask then
                read_REMOTE_ICV_ID_OPAD_0_value = data_low
            else
                read_REMOTE_ICV_ID_OPAD_0_value = (data_low - H8000_0000) and REMOTE_ICV_ID_OPAD_0_mask
            end If
        else
            read_REMOTE_ICV_ID_OPAD_0_value = data_low and REMOTE_ICV_ID_OPAD_0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_REMOTE_ICV_ID_OPAD_0_value = &H0
        flag_REMOTE_ICV_ID_OPAD_0        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_remote_icv_id_opad0_p1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' REMOTE_ICV_ID_OPAD_0                       [15:0]           get_REMOTE_ICV_ID_OPAD_0
''                                                             set_REMOTE_ICV_ID_OPAD_0
''                                                             read_REMOTE_ICV_ID_OPAD_0
''                                                             write_REMOTE_ICV_ID_OPAD_0
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_remote_icv_id_opad0_p1
    Private write_REMOTE_ICV_ID_OPAD_0_value
    Private read_REMOTE_ICV_ID_OPAD_0_value
    Private flag_REMOTE_ICV_ID_OPAD_0

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H162
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_REMOTE_ICV_ID_OPAD_0
        get_REMOTE_ICV_ID_OPAD_0 = read_REMOTE_ICV_ID_OPAD_0_value
    End Property

    Property Let set_REMOTE_ICV_ID_OPAD_0(aData)
        write_REMOTE_ICV_ID_OPAD_0_value = aData
        flag_REMOTE_ICV_ID_OPAD_0        = &H1
    End Property

    Property Get read_REMOTE_ICV_ID_OPAD_0
        read
        read_REMOTE_ICV_ID_OPAD_0 = read_REMOTE_ICV_ID_OPAD_0_value
    End Property

    Property Let write_REMOTE_ICV_ID_OPAD_0(aData)
        set_REMOTE_ICV_ID_OPAD_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_OPAD_0_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_OPAD_0_mask = mask then
                read_REMOTE_ICV_ID_OPAD_0_value = data_low
            else
                read_REMOTE_ICV_ID_OPAD_0_value = (data_low - H8000_0000) and REMOTE_ICV_ID_OPAD_0_mask
            end If
        else
            read_REMOTE_ICV_ID_OPAD_0_value = data_low and REMOTE_ICV_ID_OPAD_0_mask
        end If

    End Sub

    Sub write
        If flag_REMOTE_ICV_ID_OPAD_0 = &H0 Then read
        If flag_REMOTE_ICV_ID_OPAD_0 = &H0 Then write_REMOTE_ICV_ID_OPAD_0_value = get_REMOTE_ICV_ID_OPAD_0

        regValue = leftShift((write_REMOTE_ICV_ID_OPAD_0_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_OPAD_0_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_OPAD_0_mask = mask then
                read_REMOTE_ICV_ID_OPAD_0_value = data_low
            else
                read_REMOTE_ICV_ID_OPAD_0_value = (data_low - H8000_0000) and REMOTE_ICV_ID_OPAD_0_mask
            end If
        else
            read_REMOTE_ICV_ID_OPAD_0_value = data_low and REMOTE_ICV_ID_OPAD_0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_REMOTE_ICV_ID_OPAD_0_value = &H0
        flag_REMOTE_ICV_ID_OPAD_0        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_remote_icv_id_opad0_p2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' REMOTE_ICV_ID_OPAD_0                       [15:0]           get_REMOTE_ICV_ID_OPAD_0
''                                                             set_REMOTE_ICV_ID_OPAD_0
''                                                             read_REMOTE_ICV_ID_OPAD_0
''                                                             write_REMOTE_ICV_ID_OPAD_0
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_remote_icv_id_opad0_p2
    Private write_REMOTE_ICV_ID_OPAD_0_value
    Private read_REMOTE_ICV_ID_OPAD_0_value
    Private flag_REMOTE_ICV_ID_OPAD_0

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H164
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_REMOTE_ICV_ID_OPAD_0
        get_REMOTE_ICV_ID_OPAD_0 = read_REMOTE_ICV_ID_OPAD_0_value
    End Property

    Property Let set_REMOTE_ICV_ID_OPAD_0(aData)
        write_REMOTE_ICV_ID_OPAD_0_value = aData
        flag_REMOTE_ICV_ID_OPAD_0        = &H1
    End Property

    Property Get read_REMOTE_ICV_ID_OPAD_0
        read
        read_REMOTE_ICV_ID_OPAD_0 = read_REMOTE_ICV_ID_OPAD_0_value
    End Property

    Property Let write_REMOTE_ICV_ID_OPAD_0(aData)
        set_REMOTE_ICV_ID_OPAD_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_OPAD_0_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_OPAD_0_mask = mask then
                read_REMOTE_ICV_ID_OPAD_0_value = data_low
            else
                read_REMOTE_ICV_ID_OPAD_0_value = (data_low - H8000_0000) and REMOTE_ICV_ID_OPAD_0_mask
            end If
        else
            read_REMOTE_ICV_ID_OPAD_0_value = data_low and REMOTE_ICV_ID_OPAD_0_mask
        end If

    End Sub

    Sub write
        If flag_REMOTE_ICV_ID_OPAD_0 = &H0 Then read
        If flag_REMOTE_ICV_ID_OPAD_0 = &H0 Then write_REMOTE_ICV_ID_OPAD_0_value = get_REMOTE_ICV_ID_OPAD_0

        regValue = leftShift((write_REMOTE_ICV_ID_OPAD_0_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_OPAD_0_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_OPAD_0_mask = mask then
                read_REMOTE_ICV_ID_OPAD_0_value = data_low
            else
                read_REMOTE_ICV_ID_OPAD_0_value = (data_low - H8000_0000) and REMOTE_ICV_ID_OPAD_0_mask
            end If
        else
            read_REMOTE_ICV_ID_OPAD_0_value = data_low and REMOTE_ICV_ID_OPAD_0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_REMOTE_ICV_ID_OPAD_0_value = &H0
        flag_REMOTE_ICV_ID_OPAD_0        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_remote_icv_id_opad0_p3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' REMOTE_ICV_ID_OPAD_0                       [15:0]           get_REMOTE_ICV_ID_OPAD_0
''                                                             set_REMOTE_ICV_ID_OPAD_0
''                                                             read_REMOTE_ICV_ID_OPAD_0
''                                                             write_REMOTE_ICV_ID_OPAD_0
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_remote_icv_id_opad0_p3
    Private write_REMOTE_ICV_ID_OPAD_0_value
    Private read_REMOTE_ICV_ID_OPAD_0_value
    Private flag_REMOTE_ICV_ID_OPAD_0

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H166
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_REMOTE_ICV_ID_OPAD_0
        get_REMOTE_ICV_ID_OPAD_0 = read_REMOTE_ICV_ID_OPAD_0_value
    End Property

    Property Let set_REMOTE_ICV_ID_OPAD_0(aData)
        write_REMOTE_ICV_ID_OPAD_0_value = aData
        flag_REMOTE_ICV_ID_OPAD_0        = &H1
    End Property

    Property Get read_REMOTE_ICV_ID_OPAD_0
        read
        read_REMOTE_ICV_ID_OPAD_0 = read_REMOTE_ICV_ID_OPAD_0_value
    End Property

    Property Let write_REMOTE_ICV_ID_OPAD_0(aData)
        set_REMOTE_ICV_ID_OPAD_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_OPAD_0_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_OPAD_0_mask = mask then
                read_REMOTE_ICV_ID_OPAD_0_value = data_low
            else
                read_REMOTE_ICV_ID_OPAD_0_value = (data_low - H8000_0000) and REMOTE_ICV_ID_OPAD_0_mask
            end If
        else
            read_REMOTE_ICV_ID_OPAD_0_value = data_low and REMOTE_ICV_ID_OPAD_0_mask
        end If

    End Sub

    Sub write
        If flag_REMOTE_ICV_ID_OPAD_0 = &H0 Then read
        If flag_REMOTE_ICV_ID_OPAD_0 = &H0 Then write_REMOTE_ICV_ID_OPAD_0_value = get_REMOTE_ICV_ID_OPAD_0

        regValue = leftShift((write_REMOTE_ICV_ID_OPAD_0_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_OPAD_0_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_OPAD_0_mask = mask then
                read_REMOTE_ICV_ID_OPAD_0_value = data_low
            else
                read_REMOTE_ICV_ID_OPAD_0_value = (data_low - H8000_0000) and REMOTE_ICV_ID_OPAD_0_mask
            end If
        else
            read_REMOTE_ICV_ID_OPAD_0_value = data_low and REMOTE_ICV_ID_OPAD_0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_REMOTE_ICV_ID_OPAD_0_value = &H0
        flag_REMOTE_ICV_ID_OPAD_0        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_remote_icv_id_opad0_p4
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' REMOTE_ICV_ID_OPAD_0                       [15:0]           get_REMOTE_ICV_ID_OPAD_0
''                                                             set_REMOTE_ICV_ID_OPAD_0
''                                                             read_REMOTE_ICV_ID_OPAD_0
''                                                             write_REMOTE_ICV_ID_OPAD_0
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_remote_icv_id_opad0_p4
    Private write_REMOTE_ICV_ID_OPAD_0_value
    Private read_REMOTE_ICV_ID_OPAD_0_value
    Private flag_REMOTE_ICV_ID_OPAD_0

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H168
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_REMOTE_ICV_ID_OPAD_0
        get_REMOTE_ICV_ID_OPAD_0 = read_REMOTE_ICV_ID_OPAD_0_value
    End Property

    Property Let set_REMOTE_ICV_ID_OPAD_0(aData)
        write_REMOTE_ICV_ID_OPAD_0_value = aData
        flag_REMOTE_ICV_ID_OPAD_0        = &H1
    End Property

    Property Get read_REMOTE_ICV_ID_OPAD_0
        read
        read_REMOTE_ICV_ID_OPAD_0 = read_REMOTE_ICV_ID_OPAD_0_value
    End Property

    Property Let write_REMOTE_ICV_ID_OPAD_0(aData)
        set_REMOTE_ICV_ID_OPAD_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_OPAD_0_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_OPAD_0_mask = mask then
                read_REMOTE_ICV_ID_OPAD_0_value = data_low
            else
                read_REMOTE_ICV_ID_OPAD_0_value = (data_low - H8000_0000) and REMOTE_ICV_ID_OPAD_0_mask
            end If
        else
            read_REMOTE_ICV_ID_OPAD_0_value = data_low and REMOTE_ICV_ID_OPAD_0_mask
        end If

    End Sub

    Sub write
        If flag_REMOTE_ICV_ID_OPAD_0 = &H0 Then read
        If flag_REMOTE_ICV_ID_OPAD_0 = &H0 Then write_REMOTE_ICV_ID_OPAD_0_value = get_REMOTE_ICV_ID_OPAD_0

        regValue = leftShift((write_REMOTE_ICV_ID_OPAD_0_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_OPAD_0_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_OPAD_0_mask = mask then
                read_REMOTE_ICV_ID_OPAD_0_value = data_low
            else
                read_REMOTE_ICV_ID_OPAD_0_value = (data_low - H8000_0000) and REMOTE_ICV_ID_OPAD_0_mask
            end If
        else
            read_REMOTE_ICV_ID_OPAD_0_value = data_low and REMOTE_ICV_ID_OPAD_0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_REMOTE_ICV_ID_OPAD_0_value = &H0
        flag_REMOTE_ICV_ID_OPAD_0        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_remote_icv_id_opad0_p5
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' REMOTE_ICV_ID_OPAD_0                       [15:0]           get_REMOTE_ICV_ID_OPAD_0
''                                                             set_REMOTE_ICV_ID_OPAD_0
''                                                             read_REMOTE_ICV_ID_OPAD_0
''                                                             write_REMOTE_ICV_ID_OPAD_0
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_remote_icv_id_opad0_p5
    Private write_REMOTE_ICV_ID_OPAD_0_value
    Private read_REMOTE_ICV_ID_OPAD_0_value
    Private flag_REMOTE_ICV_ID_OPAD_0

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H16a
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_REMOTE_ICV_ID_OPAD_0
        get_REMOTE_ICV_ID_OPAD_0 = read_REMOTE_ICV_ID_OPAD_0_value
    End Property

    Property Let set_REMOTE_ICV_ID_OPAD_0(aData)
        write_REMOTE_ICV_ID_OPAD_0_value = aData
        flag_REMOTE_ICV_ID_OPAD_0        = &H1
    End Property

    Property Get read_REMOTE_ICV_ID_OPAD_0
        read
        read_REMOTE_ICV_ID_OPAD_0 = read_REMOTE_ICV_ID_OPAD_0_value
    End Property

    Property Let write_REMOTE_ICV_ID_OPAD_0(aData)
        set_REMOTE_ICV_ID_OPAD_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_OPAD_0_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_OPAD_0_mask = mask then
                read_REMOTE_ICV_ID_OPAD_0_value = data_low
            else
                read_REMOTE_ICV_ID_OPAD_0_value = (data_low - H8000_0000) and REMOTE_ICV_ID_OPAD_0_mask
            end If
        else
            read_REMOTE_ICV_ID_OPAD_0_value = data_low and REMOTE_ICV_ID_OPAD_0_mask
        end If

    End Sub

    Sub write
        If flag_REMOTE_ICV_ID_OPAD_0 = &H0 Then read
        If flag_REMOTE_ICV_ID_OPAD_0 = &H0 Then write_REMOTE_ICV_ID_OPAD_0_value = get_REMOTE_ICV_ID_OPAD_0

        regValue = leftShift((write_REMOTE_ICV_ID_OPAD_0_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_OPAD_0_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_OPAD_0_mask = mask then
                read_REMOTE_ICV_ID_OPAD_0_value = data_low
            else
                read_REMOTE_ICV_ID_OPAD_0_value = (data_low - H8000_0000) and REMOTE_ICV_ID_OPAD_0_mask
            end If
        else
            read_REMOTE_ICV_ID_OPAD_0_value = data_low and REMOTE_ICV_ID_OPAD_0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_REMOTE_ICV_ID_OPAD_0_value = &H0
        flag_REMOTE_ICV_ID_OPAD_0        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_remote_icv_id_opad1_p0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' REMOTE_ICV_ID_OPAD_1                       [15:0]           get_REMOTE_ICV_ID_OPAD_1
''                                                             set_REMOTE_ICV_ID_OPAD_1
''                                                             read_REMOTE_ICV_ID_OPAD_1
''                                                             write_REMOTE_ICV_ID_OPAD_1
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_remote_icv_id_opad1_p0
    Private write_REMOTE_ICV_ID_OPAD_1_value
    Private read_REMOTE_ICV_ID_OPAD_1_value
    Private flag_REMOTE_ICV_ID_OPAD_1

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H170
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_REMOTE_ICV_ID_OPAD_1
        get_REMOTE_ICV_ID_OPAD_1 = read_REMOTE_ICV_ID_OPAD_1_value
    End Property

    Property Let set_REMOTE_ICV_ID_OPAD_1(aData)
        write_REMOTE_ICV_ID_OPAD_1_value = aData
        flag_REMOTE_ICV_ID_OPAD_1        = &H1
    End Property

    Property Get read_REMOTE_ICV_ID_OPAD_1
        read
        read_REMOTE_ICV_ID_OPAD_1 = read_REMOTE_ICV_ID_OPAD_1_value
    End Property

    Property Let write_REMOTE_ICV_ID_OPAD_1(aData)
        set_REMOTE_ICV_ID_OPAD_1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_OPAD_1_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_OPAD_1_mask = mask then
                read_REMOTE_ICV_ID_OPAD_1_value = data_low
            else
                read_REMOTE_ICV_ID_OPAD_1_value = (data_low - H8000_0000) and REMOTE_ICV_ID_OPAD_1_mask
            end If
        else
            read_REMOTE_ICV_ID_OPAD_1_value = data_low and REMOTE_ICV_ID_OPAD_1_mask
        end If

    End Sub

    Sub write
        If flag_REMOTE_ICV_ID_OPAD_1 = &H0 Then read
        If flag_REMOTE_ICV_ID_OPAD_1 = &H0 Then write_REMOTE_ICV_ID_OPAD_1_value = get_REMOTE_ICV_ID_OPAD_1

        regValue = leftShift((write_REMOTE_ICV_ID_OPAD_1_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_OPAD_1_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_OPAD_1_mask = mask then
                read_REMOTE_ICV_ID_OPAD_1_value = data_low
            else
                read_REMOTE_ICV_ID_OPAD_1_value = (data_low - H8000_0000) and REMOTE_ICV_ID_OPAD_1_mask
            end If
        else
            read_REMOTE_ICV_ID_OPAD_1_value = data_low and REMOTE_ICV_ID_OPAD_1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_REMOTE_ICV_ID_OPAD_1_value = &H0
        flag_REMOTE_ICV_ID_OPAD_1        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_remote_icv_id_opad1_p1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' REMOTE_ICV_ID_OPAD_1                       [15:0]           get_REMOTE_ICV_ID_OPAD_1
''                                                             set_REMOTE_ICV_ID_OPAD_1
''                                                             read_REMOTE_ICV_ID_OPAD_1
''                                                             write_REMOTE_ICV_ID_OPAD_1
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_remote_icv_id_opad1_p1
    Private write_REMOTE_ICV_ID_OPAD_1_value
    Private read_REMOTE_ICV_ID_OPAD_1_value
    Private flag_REMOTE_ICV_ID_OPAD_1

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H172
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_REMOTE_ICV_ID_OPAD_1
        get_REMOTE_ICV_ID_OPAD_1 = read_REMOTE_ICV_ID_OPAD_1_value
    End Property

    Property Let set_REMOTE_ICV_ID_OPAD_1(aData)
        write_REMOTE_ICV_ID_OPAD_1_value = aData
        flag_REMOTE_ICV_ID_OPAD_1        = &H1
    End Property

    Property Get read_REMOTE_ICV_ID_OPAD_1
        read
        read_REMOTE_ICV_ID_OPAD_1 = read_REMOTE_ICV_ID_OPAD_1_value
    End Property

    Property Let write_REMOTE_ICV_ID_OPAD_1(aData)
        set_REMOTE_ICV_ID_OPAD_1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_OPAD_1_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_OPAD_1_mask = mask then
                read_REMOTE_ICV_ID_OPAD_1_value = data_low
            else
                read_REMOTE_ICV_ID_OPAD_1_value = (data_low - H8000_0000) and REMOTE_ICV_ID_OPAD_1_mask
            end If
        else
            read_REMOTE_ICV_ID_OPAD_1_value = data_low and REMOTE_ICV_ID_OPAD_1_mask
        end If

    End Sub

    Sub write
        If flag_REMOTE_ICV_ID_OPAD_1 = &H0 Then read
        If flag_REMOTE_ICV_ID_OPAD_1 = &H0 Then write_REMOTE_ICV_ID_OPAD_1_value = get_REMOTE_ICV_ID_OPAD_1

        regValue = leftShift((write_REMOTE_ICV_ID_OPAD_1_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_OPAD_1_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_OPAD_1_mask = mask then
                read_REMOTE_ICV_ID_OPAD_1_value = data_low
            else
                read_REMOTE_ICV_ID_OPAD_1_value = (data_low - H8000_0000) and REMOTE_ICV_ID_OPAD_1_mask
            end If
        else
            read_REMOTE_ICV_ID_OPAD_1_value = data_low and REMOTE_ICV_ID_OPAD_1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_REMOTE_ICV_ID_OPAD_1_value = &H0
        flag_REMOTE_ICV_ID_OPAD_1        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_remote_icv_id_opad1_p2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' REMOTE_ICV_ID_OPAD_1                       [15:0]           get_REMOTE_ICV_ID_OPAD_1
''                                                             set_REMOTE_ICV_ID_OPAD_1
''                                                             read_REMOTE_ICV_ID_OPAD_1
''                                                             write_REMOTE_ICV_ID_OPAD_1
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_remote_icv_id_opad1_p2
    Private write_REMOTE_ICV_ID_OPAD_1_value
    Private read_REMOTE_ICV_ID_OPAD_1_value
    Private flag_REMOTE_ICV_ID_OPAD_1

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H174
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_REMOTE_ICV_ID_OPAD_1
        get_REMOTE_ICV_ID_OPAD_1 = read_REMOTE_ICV_ID_OPAD_1_value
    End Property

    Property Let set_REMOTE_ICV_ID_OPAD_1(aData)
        write_REMOTE_ICV_ID_OPAD_1_value = aData
        flag_REMOTE_ICV_ID_OPAD_1        = &H1
    End Property

    Property Get read_REMOTE_ICV_ID_OPAD_1
        read
        read_REMOTE_ICV_ID_OPAD_1 = read_REMOTE_ICV_ID_OPAD_1_value
    End Property

    Property Let write_REMOTE_ICV_ID_OPAD_1(aData)
        set_REMOTE_ICV_ID_OPAD_1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_OPAD_1_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_OPAD_1_mask = mask then
                read_REMOTE_ICV_ID_OPAD_1_value = data_low
            else
                read_REMOTE_ICV_ID_OPAD_1_value = (data_low - H8000_0000) and REMOTE_ICV_ID_OPAD_1_mask
            end If
        else
            read_REMOTE_ICV_ID_OPAD_1_value = data_low and REMOTE_ICV_ID_OPAD_1_mask
        end If

    End Sub

    Sub write
        If flag_REMOTE_ICV_ID_OPAD_1 = &H0 Then read
        If flag_REMOTE_ICV_ID_OPAD_1 = &H0 Then write_REMOTE_ICV_ID_OPAD_1_value = get_REMOTE_ICV_ID_OPAD_1

        regValue = leftShift((write_REMOTE_ICV_ID_OPAD_1_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_OPAD_1_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_OPAD_1_mask = mask then
                read_REMOTE_ICV_ID_OPAD_1_value = data_low
            else
                read_REMOTE_ICV_ID_OPAD_1_value = (data_low - H8000_0000) and REMOTE_ICV_ID_OPAD_1_mask
            end If
        else
            read_REMOTE_ICV_ID_OPAD_1_value = data_low and REMOTE_ICV_ID_OPAD_1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_REMOTE_ICV_ID_OPAD_1_value = &H0
        flag_REMOTE_ICV_ID_OPAD_1        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_remote_icv_id_opad1_p3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' REMOTE_ICV_ID_OPAD_1                       [15:0]           get_REMOTE_ICV_ID_OPAD_1
''                                                             set_REMOTE_ICV_ID_OPAD_1
''                                                             read_REMOTE_ICV_ID_OPAD_1
''                                                             write_REMOTE_ICV_ID_OPAD_1
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_remote_icv_id_opad1_p3
    Private write_REMOTE_ICV_ID_OPAD_1_value
    Private read_REMOTE_ICV_ID_OPAD_1_value
    Private flag_REMOTE_ICV_ID_OPAD_1

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H176
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_REMOTE_ICV_ID_OPAD_1
        get_REMOTE_ICV_ID_OPAD_1 = read_REMOTE_ICV_ID_OPAD_1_value
    End Property

    Property Let set_REMOTE_ICV_ID_OPAD_1(aData)
        write_REMOTE_ICV_ID_OPAD_1_value = aData
        flag_REMOTE_ICV_ID_OPAD_1        = &H1
    End Property

    Property Get read_REMOTE_ICV_ID_OPAD_1
        read
        read_REMOTE_ICV_ID_OPAD_1 = read_REMOTE_ICV_ID_OPAD_1_value
    End Property

    Property Let write_REMOTE_ICV_ID_OPAD_1(aData)
        set_REMOTE_ICV_ID_OPAD_1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_OPAD_1_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_OPAD_1_mask = mask then
                read_REMOTE_ICV_ID_OPAD_1_value = data_low
            else
                read_REMOTE_ICV_ID_OPAD_1_value = (data_low - H8000_0000) and REMOTE_ICV_ID_OPAD_1_mask
            end If
        else
            read_REMOTE_ICV_ID_OPAD_1_value = data_low and REMOTE_ICV_ID_OPAD_1_mask
        end If

    End Sub

    Sub write
        If flag_REMOTE_ICV_ID_OPAD_1 = &H0 Then read
        If flag_REMOTE_ICV_ID_OPAD_1 = &H0 Then write_REMOTE_ICV_ID_OPAD_1_value = get_REMOTE_ICV_ID_OPAD_1

        regValue = leftShift((write_REMOTE_ICV_ID_OPAD_1_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_OPAD_1_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_OPAD_1_mask = mask then
                read_REMOTE_ICV_ID_OPAD_1_value = data_low
            else
                read_REMOTE_ICV_ID_OPAD_1_value = (data_low - H8000_0000) and REMOTE_ICV_ID_OPAD_1_mask
            end If
        else
            read_REMOTE_ICV_ID_OPAD_1_value = data_low and REMOTE_ICV_ID_OPAD_1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_REMOTE_ICV_ID_OPAD_1_value = &H0
        flag_REMOTE_ICV_ID_OPAD_1        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_remote_icv_id_opad1_p4
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' REMOTE_ICV_ID_OPAD_1                       [15:0]           get_REMOTE_ICV_ID_OPAD_1
''                                                             set_REMOTE_ICV_ID_OPAD_1
''                                                             read_REMOTE_ICV_ID_OPAD_1
''                                                             write_REMOTE_ICV_ID_OPAD_1
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_remote_icv_id_opad1_p4
    Private write_REMOTE_ICV_ID_OPAD_1_value
    Private read_REMOTE_ICV_ID_OPAD_1_value
    Private flag_REMOTE_ICV_ID_OPAD_1

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H178
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_REMOTE_ICV_ID_OPAD_1
        get_REMOTE_ICV_ID_OPAD_1 = read_REMOTE_ICV_ID_OPAD_1_value
    End Property

    Property Let set_REMOTE_ICV_ID_OPAD_1(aData)
        write_REMOTE_ICV_ID_OPAD_1_value = aData
        flag_REMOTE_ICV_ID_OPAD_1        = &H1
    End Property

    Property Get read_REMOTE_ICV_ID_OPAD_1
        read
        read_REMOTE_ICV_ID_OPAD_1 = read_REMOTE_ICV_ID_OPAD_1_value
    End Property

    Property Let write_REMOTE_ICV_ID_OPAD_1(aData)
        set_REMOTE_ICV_ID_OPAD_1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_OPAD_1_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_OPAD_1_mask = mask then
                read_REMOTE_ICV_ID_OPAD_1_value = data_low
            else
                read_REMOTE_ICV_ID_OPAD_1_value = (data_low - H8000_0000) and REMOTE_ICV_ID_OPAD_1_mask
            end If
        else
            read_REMOTE_ICV_ID_OPAD_1_value = data_low and REMOTE_ICV_ID_OPAD_1_mask
        end If

    End Sub

    Sub write
        If flag_REMOTE_ICV_ID_OPAD_1 = &H0 Then read
        If flag_REMOTE_ICV_ID_OPAD_1 = &H0 Then write_REMOTE_ICV_ID_OPAD_1_value = get_REMOTE_ICV_ID_OPAD_1

        regValue = leftShift((write_REMOTE_ICV_ID_OPAD_1_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_OPAD_1_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_OPAD_1_mask = mask then
                read_REMOTE_ICV_ID_OPAD_1_value = data_low
            else
                read_REMOTE_ICV_ID_OPAD_1_value = (data_low - H8000_0000) and REMOTE_ICV_ID_OPAD_1_mask
            end If
        else
            read_REMOTE_ICV_ID_OPAD_1_value = data_low and REMOTE_ICV_ID_OPAD_1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_REMOTE_ICV_ID_OPAD_1_value = &H0
        flag_REMOTE_ICV_ID_OPAD_1        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_remote_icv_id_opad1_p5
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' REMOTE_ICV_ID_OPAD_1                       [15:0]           get_REMOTE_ICV_ID_OPAD_1
''                                                             set_REMOTE_ICV_ID_OPAD_1
''                                                             read_REMOTE_ICV_ID_OPAD_1
''                                                             write_REMOTE_ICV_ID_OPAD_1
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_remote_icv_id_opad1_p5
    Private write_REMOTE_ICV_ID_OPAD_1_value
    Private read_REMOTE_ICV_ID_OPAD_1_value
    Private flag_REMOTE_ICV_ID_OPAD_1

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H17a
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_REMOTE_ICV_ID_OPAD_1
        get_REMOTE_ICV_ID_OPAD_1 = read_REMOTE_ICV_ID_OPAD_1_value
    End Property

    Property Let set_REMOTE_ICV_ID_OPAD_1(aData)
        write_REMOTE_ICV_ID_OPAD_1_value = aData
        flag_REMOTE_ICV_ID_OPAD_1        = &H1
    End Property

    Property Get read_REMOTE_ICV_ID_OPAD_1
        read
        read_REMOTE_ICV_ID_OPAD_1 = read_REMOTE_ICV_ID_OPAD_1_value
    End Property

    Property Let write_REMOTE_ICV_ID_OPAD_1(aData)
        set_REMOTE_ICV_ID_OPAD_1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_OPAD_1_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_OPAD_1_mask = mask then
                read_REMOTE_ICV_ID_OPAD_1_value = data_low
            else
                read_REMOTE_ICV_ID_OPAD_1_value = (data_low - H8000_0000) and REMOTE_ICV_ID_OPAD_1_mask
            end If
        else
            read_REMOTE_ICV_ID_OPAD_1_value = data_low and REMOTE_ICV_ID_OPAD_1_mask
        end If

    End Sub

    Sub write
        If flag_REMOTE_ICV_ID_OPAD_1 = &H0 Then read
        If flag_REMOTE_ICV_ID_OPAD_1 = &H0 Then write_REMOTE_ICV_ID_OPAD_1_value = get_REMOTE_ICV_ID_OPAD_1

        regValue = leftShift((write_REMOTE_ICV_ID_OPAD_1_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_OPAD_1_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_OPAD_1_mask = mask then
                read_REMOTE_ICV_ID_OPAD_1_value = data_low
            else
                read_REMOTE_ICV_ID_OPAD_1_value = (data_low - H8000_0000) and REMOTE_ICV_ID_OPAD_1_mask
            end If
        else
            read_REMOTE_ICV_ID_OPAD_1_value = data_low and REMOTE_ICV_ID_OPAD_1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_REMOTE_ICV_ID_OPAD_1_value = &H0
        flag_REMOTE_ICV_ID_OPAD_1        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_remote_icv_id_opad2_p0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' REMOTE_ICV_ID_OPAD_2                       [15:0]           get_REMOTE_ICV_ID_OPAD_2
''                                                             set_REMOTE_ICV_ID_OPAD_2
''                                                             read_REMOTE_ICV_ID_OPAD_2
''                                                             write_REMOTE_ICV_ID_OPAD_2
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_remote_icv_id_opad2_p0
    Private write_REMOTE_ICV_ID_OPAD_2_value
    Private read_REMOTE_ICV_ID_OPAD_2_value
    Private flag_REMOTE_ICV_ID_OPAD_2

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H180
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_REMOTE_ICV_ID_OPAD_2
        get_REMOTE_ICV_ID_OPAD_2 = read_REMOTE_ICV_ID_OPAD_2_value
    End Property

    Property Let set_REMOTE_ICV_ID_OPAD_2(aData)
        write_REMOTE_ICV_ID_OPAD_2_value = aData
        flag_REMOTE_ICV_ID_OPAD_2        = &H1
    End Property

    Property Get read_REMOTE_ICV_ID_OPAD_2
        read
        read_REMOTE_ICV_ID_OPAD_2 = read_REMOTE_ICV_ID_OPAD_2_value
    End Property

    Property Let write_REMOTE_ICV_ID_OPAD_2(aData)
        set_REMOTE_ICV_ID_OPAD_2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_OPAD_2_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_OPAD_2_mask = mask then
                read_REMOTE_ICV_ID_OPAD_2_value = data_low
            else
                read_REMOTE_ICV_ID_OPAD_2_value = (data_low - H8000_0000) and REMOTE_ICV_ID_OPAD_2_mask
            end If
        else
            read_REMOTE_ICV_ID_OPAD_2_value = data_low and REMOTE_ICV_ID_OPAD_2_mask
        end If

    End Sub

    Sub write
        If flag_REMOTE_ICV_ID_OPAD_2 = &H0 Then read
        If flag_REMOTE_ICV_ID_OPAD_2 = &H0 Then write_REMOTE_ICV_ID_OPAD_2_value = get_REMOTE_ICV_ID_OPAD_2

        regValue = leftShift((write_REMOTE_ICV_ID_OPAD_2_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_OPAD_2_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_OPAD_2_mask = mask then
                read_REMOTE_ICV_ID_OPAD_2_value = data_low
            else
                read_REMOTE_ICV_ID_OPAD_2_value = (data_low - H8000_0000) and REMOTE_ICV_ID_OPAD_2_mask
            end If
        else
            read_REMOTE_ICV_ID_OPAD_2_value = data_low and REMOTE_ICV_ID_OPAD_2_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_REMOTE_ICV_ID_OPAD_2_value = &H0
        flag_REMOTE_ICV_ID_OPAD_2        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_remote_icv_id_opad2_p1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' REMOTE_ICV_ID_OPAD_2                       [15:0]           get_REMOTE_ICV_ID_OPAD_2
''                                                             set_REMOTE_ICV_ID_OPAD_2
''                                                             read_REMOTE_ICV_ID_OPAD_2
''                                                             write_REMOTE_ICV_ID_OPAD_2
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_remote_icv_id_opad2_p1
    Private write_REMOTE_ICV_ID_OPAD_2_value
    Private read_REMOTE_ICV_ID_OPAD_2_value
    Private flag_REMOTE_ICV_ID_OPAD_2

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H182
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_REMOTE_ICV_ID_OPAD_2
        get_REMOTE_ICV_ID_OPAD_2 = read_REMOTE_ICV_ID_OPAD_2_value
    End Property

    Property Let set_REMOTE_ICV_ID_OPAD_2(aData)
        write_REMOTE_ICV_ID_OPAD_2_value = aData
        flag_REMOTE_ICV_ID_OPAD_2        = &H1
    End Property

    Property Get read_REMOTE_ICV_ID_OPAD_2
        read
        read_REMOTE_ICV_ID_OPAD_2 = read_REMOTE_ICV_ID_OPAD_2_value
    End Property

    Property Let write_REMOTE_ICV_ID_OPAD_2(aData)
        set_REMOTE_ICV_ID_OPAD_2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_OPAD_2_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_OPAD_2_mask = mask then
                read_REMOTE_ICV_ID_OPAD_2_value = data_low
            else
                read_REMOTE_ICV_ID_OPAD_2_value = (data_low - H8000_0000) and REMOTE_ICV_ID_OPAD_2_mask
            end If
        else
            read_REMOTE_ICV_ID_OPAD_2_value = data_low and REMOTE_ICV_ID_OPAD_2_mask
        end If

    End Sub

    Sub write
        If flag_REMOTE_ICV_ID_OPAD_2 = &H0 Then read
        If flag_REMOTE_ICV_ID_OPAD_2 = &H0 Then write_REMOTE_ICV_ID_OPAD_2_value = get_REMOTE_ICV_ID_OPAD_2

        regValue = leftShift((write_REMOTE_ICV_ID_OPAD_2_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_OPAD_2_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_OPAD_2_mask = mask then
                read_REMOTE_ICV_ID_OPAD_2_value = data_low
            else
                read_REMOTE_ICV_ID_OPAD_2_value = (data_low - H8000_0000) and REMOTE_ICV_ID_OPAD_2_mask
            end If
        else
            read_REMOTE_ICV_ID_OPAD_2_value = data_low and REMOTE_ICV_ID_OPAD_2_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_REMOTE_ICV_ID_OPAD_2_value = &H0
        flag_REMOTE_ICV_ID_OPAD_2        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_remote_icv_id_opad2_p2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' REMOTE_ICV_ID_OPAD_2                       [15:0]           get_REMOTE_ICV_ID_OPAD_2
''                                                             set_REMOTE_ICV_ID_OPAD_2
''                                                             read_REMOTE_ICV_ID_OPAD_2
''                                                             write_REMOTE_ICV_ID_OPAD_2
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_remote_icv_id_opad2_p2
    Private write_REMOTE_ICV_ID_OPAD_2_value
    Private read_REMOTE_ICV_ID_OPAD_2_value
    Private flag_REMOTE_ICV_ID_OPAD_2

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H184
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_REMOTE_ICV_ID_OPAD_2
        get_REMOTE_ICV_ID_OPAD_2 = read_REMOTE_ICV_ID_OPAD_2_value
    End Property

    Property Let set_REMOTE_ICV_ID_OPAD_2(aData)
        write_REMOTE_ICV_ID_OPAD_2_value = aData
        flag_REMOTE_ICV_ID_OPAD_2        = &H1
    End Property

    Property Get read_REMOTE_ICV_ID_OPAD_2
        read
        read_REMOTE_ICV_ID_OPAD_2 = read_REMOTE_ICV_ID_OPAD_2_value
    End Property

    Property Let write_REMOTE_ICV_ID_OPAD_2(aData)
        set_REMOTE_ICV_ID_OPAD_2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_OPAD_2_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_OPAD_2_mask = mask then
                read_REMOTE_ICV_ID_OPAD_2_value = data_low
            else
                read_REMOTE_ICV_ID_OPAD_2_value = (data_low - H8000_0000) and REMOTE_ICV_ID_OPAD_2_mask
            end If
        else
            read_REMOTE_ICV_ID_OPAD_2_value = data_low and REMOTE_ICV_ID_OPAD_2_mask
        end If

    End Sub

    Sub write
        If flag_REMOTE_ICV_ID_OPAD_2 = &H0 Then read
        If flag_REMOTE_ICV_ID_OPAD_2 = &H0 Then write_REMOTE_ICV_ID_OPAD_2_value = get_REMOTE_ICV_ID_OPAD_2

        regValue = leftShift((write_REMOTE_ICV_ID_OPAD_2_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_OPAD_2_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_OPAD_2_mask = mask then
                read_REMOTE_ICV_ID_OPAD_2_value = data_low
            else
                read_REMOTE_ICV_ID_OPAD_2_value = (data_low - H8000_0000) and REMOTE_ICV_ID_OPAD_2_mask
            end If
        else
            read_REMOTE_ICV_ID_OPAD_2_value = data_low and REMOTE_ICV_ID_OPAD_2_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_REMOTE_ICV_ID_OPAD_2_value = &H0
        flag_REMOTE_ICV_ID_OPAD_2        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_remote_icv_id_opad2_p3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' REMOTE_ICV_ID_OPAD_2                       [15:0]           get_REMOTE_ICV_ID_OPAD_2
''                                                             set_REMOTE_ICV_ID_OPAD_2
''                                                             read_REMOTE_ICV_ID_OPAD_2
''                                                             write_REMOTE_ICV_ID_OPAD_2
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_remote_icv_id_opad2_p3
    Private write_REMOTE_ICV_ID_OPAD_2_value
    Private read_REMOTE_ICV_ID_OPAD_2_value
    Private flag_REMOTE_ICV_ID_OPAD_2

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H186
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_REMOTE_ICV_ID_OPAD_2
        get_REMOTE_ICV_ID_OPAD_2 = read_REMOTE_ICV_ID_OPAD_2_value
    End Property

    Property Let set_REMOTE_ICV_ID_OPAD_2(aData)
        write_REMOTE_ICV_ID_OPAD_2_value = aData
        flag_REMOTE_ICV_ID_OPAD_2        = &H1
    End Property

    Property Get read_REMOTE_ICV_ID_OPAD_2
        read
        read_REMOTE_ICV_ID_OPAD_2 = read_REMOTE_ICV_ID_OPAD_2_value
    End Property

    Property Let write_REMOTE_ICV_ID_OPAD_2(aData)
        set_REMOTE_ICV_ID_OPAD_2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_OPAD_2_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_OPAD_2_mask = mask then
                read_REMOTE_ICV_ID_OPAD_2_value = data_low
            else
                read_REMOTE_ICV_ID_OPAD_2_value = (data_low - H8000_0000) and REMOTE_ICV_ID_OPAD_2_mask
            end If
        else
            read_REMOTE_ICV_ID_OPAD_2_value = data_low and REMOTE_ICV_ID_OPAD_2_mask
        end If

    End Sub

    Sub write
        If flag_REMOTE_ICV_ID_OPAD_2 = &H0 Then read
        If flag_REMOTE_ICV_ID_OPAD_2 = &H0 Then write_REMOTE_ICV_ID_OPAD_2_value = get_REMOTE_ICV_ID_OPAD_2

        regValue = leftShift((write_REMOTE_ICV_ID_OPAD_2_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_OPAD_2_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_OPAD_2_mask = mask then
                read_REMOTE_ICV_ID_OPAD_2_value = data_low
            else
                read_REMOTE_ICV_ID_OPAD_2_value = (data_low - H8000_0000) and REMOTE_ICV_ID_OPAD_2_mask
            end If
        else
            read_REMOTE_ICV_ID_OPAD_2_value = data_low and REMOTE_ICV_ID_OPAD_2_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_REMOTE_ICV_ID_OPAD_2_value = &H0
        flag_REMOTE_ICV_ID_OPAD_2        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_remote_icv_id_opad2_p4
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' REMOTE_ICV_ID_OPAD_2                       [15:0]           get_REMOTE_ICV_ID_OPAD_2
''                                                             set_REMOTE_ICV_ID_OPAD_2
''                                                             read_REMOTE_ICV_ID_OPAD_2
''                                                             write_REMOTE_ICV_ID_OPAD_2
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_remote_icv_id_opad2_p4
    Private write_REMOTE_ICV_ID_OPAD_2_value
    Private read_REMOTE_ICV_ID_OPAD_2_value
    Private flag_REMOTE_ICV_ID_OPAD_2

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H188
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_REMOTE_ICV_ID_OPAD_2
        get_REMOTE_ICV_ID_OPAD_2 = read_REMOTE_ICV_ID_OPAD_2_value
    End Property

    Property Let set_REMOTE_ICV_ID_OPAD_2(aData)
        write_REMOTE_ICV_ID_OPAD_2_value = aData
        flag_REMOTE_ICV_ID_OPAD_2        = &H1
    End Property

    Property Get read_REMOTE_ICV_ID_OPAD_2
        read
        read_REMOTE_ICV_ID_OPAD_2 = read_REMOTE_ICV_ID_OPAD_2_value
    End Property

    Property Let write_REMOTE_ICV_ID_OPAD_2(aData)
        set_REMOTE_ICV_ID_OPAD_2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_OPAD_2_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_OPAD_2_mask = mask then
                read_REMOTE_ICV_ID_OPAD_2_value = data_low
            else
                read_REMOTE_ICV_ID_OPAD_2_value = (data_low - H8000_0000) and REMOTE_ICV_ID_OPAD_2_mask
            end If
        else
            read_REMOTE_ICV_ID_OPAD_2_value = data_low and REMOTE_ICV_ID_OPAD_2_mask
        end If

    End Sub

    Sub write
        If flag_REMOTE_ICV_ID_OPAD_2 = &H0 Then read
        If flag_REMOTE_ICV_ID_OPAD_2 = &H0 Then write_REMOTE_ICV_ID_OPAD_2_value = get_REMOTE_ICV_ID_OPAD_2

        regValue = leftShift((write_REMOTE_ICV_ID_OPAD_2_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_OPAD_2_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_OPAD_2_mask = mask then
                read_REMOTE_ICV_ID_OPAD_2_value = data_low
            else
                read_REMOTE_ICV_ID_OPAD_2_value = (data_low - H8000_0000) and REMOTE_ICV_ID_OPAD_2_mask
            end If
        else
            read_REMOTE_ICV_ID_OPAD_2_value = data_low and REMOTE_ICV_ID_OPAD_2_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_REMOTE_ICV_ID_OPAD_2_value = &H0
        flag_REMOTE_ICV_ID_OPAD_2        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_remote_icv_id_opad2_p5
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' REMOTE_ICV_ID_OPAD_2                       [15:0]           get_REMOTE_ICV_ID_OPAD_2
''                                                             set_REMOTE_ICV_ID_OPAD_2
''                                                             read_REMOTE_ICV_ID_OPAD_2
''                                                             write_REMOTE_ICV_ID_OPAD_2
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_remote_icv_id_opad2_p5
    Private write_REMOTE_ICV_ID_OPAD_2_value
    Private read_REMOTE_ICV_ID_OPAD_2_value
    Private flag_REMOTE_ICV_ID_OPAD_2

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18a
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_REMOTE_ICV_ID_OPAD_2
        get_REMOTE_ICV_ID_OPAD_2 = read_REMOTE_ICV_ID_OPAD_2_value
    End Property

    Property Let set_REMOTE_ICV_ID_OPAD_2(aData)
        write_REMOTE_ICV_ID_OPAD_2_value = aData
        flag_REMOTE_ICV_ID_OPAD_2        = &H1
    End Property

    Property Get read_REMOTE_ICV_ID_OPAD_2
        read
        read_REMOTE_ICV_ID_OPAD_2 = read_REMOTE_ICV_ID_OPAD_2_value
    End Property

    Property Let write_REMOTE_ICV_ID_OPAD_2(aData)
        set_REMOTE_ICV_ID_OPAD_2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_OPAD_2_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_OPAD_2_mask = mask then
                read_REMOTE_ICV_ID_OPAD_2_value = data_low
            else
                read_REMOTE_ICV_ID_OPAD_2_value = (data_low - H8000_0000) and REMOTE_ICV_ID_OPAD_2_mask
            end If
        else
            read_REMOTE_ICV_ID_OPAD_2_value = data_low and REMOTE_ICV_ID_OPAD_2_mask
        end If

    End Sub

    Sub write
        If flag_REMOTE_ICV_ID_OPAD_2 = &H0 Then read
        If flag_REMOTE_ICV_ID_OPAD_2 = &H0 Then write_REMOTE_ICV_ID_OPAD_2_value = get_REMOTE_ICV_ID_OPAD_2

        regValue = leftShift((write_REMOTE_ICV_ID_OPAD_2_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_OPAD_2_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_OPAD_2_mask = mask then
                read_REMOTE_ICV_ID_OPAD_2_value = data_low
            else
                read_REMOTE_ICV_ID_OPAD_2_value = (data_low - H8000_0000) and REMOTE_ICV_ID_OPAD_2_mask
            end If
        else
            read_REMOTE_ICV_ID_OPAD_2_value = data_low and REMOTE_ICV_ID_OPAD_2_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_REMOTE_ICV_ID_OPAD_2_value = &H0
        flag_REMOTE_ICV_ID_OPAD_2        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_remote_icv_id_opad3_p0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' REMOTE_ICV_ID_OPAD_3                       [15:0]           get_REMOTE_ICV_ID_OPAD_3
''                                                             set_REMOTE_ICV_ID_OPAD_3
''                                                             read_REMOTE_ICV_ID_OPAD_3
''                                                             write_REMOTE_ICV_ID_OPAD_3
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_remote_icv_id_opad3_p0
    Private write_REMOTE_ICV_ID_OPAD_3_value
    Private read_REMOTE_ICV_ID_OPAD_3_value
    Private flag_REMOTE_ICV_ID_OPAD_3

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H190
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_REMOTE_ICV_ID_OPAD_3
        get_REMOTE_ICV_ID_OPAD_3 = read_REMOTE_ICV_ID_OPAD_3_value
    End Property

    Property Let set_REMOTE_ICV_ID_OPAD_3(aData)
        write_REMOTE_ICV_ID_OPAD_3_value = aData
        flag_REMOTE_ICV_ID_OPAD_3        = &H1
    End Property

    Property Get read_REMOTE_ICV_ID_OPAD_3
        read
        read_REMOTE_ICV_ID_OPAD_3 = read_REMOTE_ICV_ID_OPAD_3_value
    End Property

    Property Let write_REMOTE_ICV_ID_OPAD_3(aData)
        set_REMOTE_ICV_ID_OPAD_3 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_OPAD_3_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_OPAD_3_mask = mask then
                read_REMOTE_ICV_ID_OPAD_3_value = data_low
            else
                read_REMOTE_ICV_ID_OPAD_3_value = (data_low - H8000_0000) and REMOTE_ICV_ID_OPAD_3_mask
            end If
        else
            read_REMOTE_ICV_ID_OPAD_3_value = data_low and REMOTE_ICV_ID_OPAD_3_mask
        end If

    End Sub

    Sub write
        If flag_REMOTE_ICV_ID_OPAD_3 = &H0 Then read
        If flag_REMOTE_ICV_ID_OPAD_3 = &H0 Then write_REMOTE_ICV_ID_OPAD_3_value = get_REMOTE_ICV_ID_OPAD_3

        regValue = leftShift((write_REMOTE_ICV_ID_OPAD_3_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_OPAD_3_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_OPAD_3_mask = mask then
                read_REMOTE_ICV_ID_OPAD_3_value = data_low
            else
                read_REMOTE_ICV_ID_OPAD_3_value = (data_low - H8000_0000) and REMOTE_ICV_ID_OPAD_3_mask
            end If
        else
            read_REMOTE_ICV_ID_OPAD_3_value = data_low and REMOTE_ICV_ID_OPAD_3_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_REMOTE_ICV_ID_OPAD_3_value = &H0
        flag_REMOTE_ICV_ID_OPAD_3        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_remote_icv_id_opad3_p1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' REMOTE_ICV_ID_OPAD_3                       [15:0]           get_REMOTE_ICV_ID_OPAD_3
''                                                             set_REMOTE_ICV_ID_OPAD_3
''                                                             read_REMOTE_ICV_ID_OPAD_3
''                                                             write_REMOTE_ICV_ID_OPAD_3
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_remote_icv_id_opad3_p1
    Private write_REMOTE_ICV_ID_OPAD_3_value
    Private read_REMOTE_ICV_ID_OPAD_3_value
    Private flag_REMOTE_ICV_ID_OPAD_3

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H192
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_REMOTE_ICV_ID_OPAD_3
        get_REMOTE_ICV_ID_OPAD_3 = read_REMOTE_ICV_ID_OPAD_3_value
    End Property

    Property Let set_REMOTE_ICV_ID_OPAD_3(aData)
        write_REMOTE_ICV_ID_OPAD_3_value = aData
        flag_REMOTE_ICV_ID_OPAD_3        = &H1
    End Property

    Property Get read_REMOTE_ICV_ID_OPAD_3
        read
        read_REMOTE_ICV_ID_OPAD_3 = read_REMOTE_ICV_ID_OPAD_3_value
    End Property

    Property Let write_REMOTE_ICV_ID_OPAD_3(aData)
        set_REMOTE_ICV_ID_OPAD_3 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_OPAD_3_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_OPAD_3_mask = mask then
                read_REMOTE_ICV_ID_OPAD_3_value = data_low
            else
                read_REMOTE_ICV_ID_OPAD_3_value = (data_low - H8000_0000) and REMOTE_ICV_ID_OPAD_3_mask
            end If
        else
            read_REMOTE_ICV_ID_OPAD_3_value = data_low and REMOTE_ICV_ID_OPAD_3_mask
        end If

    End Sub

    Sub write
        If flag_REMOTE_ICV_ID_OPAD_3 = &H0 Then read
        If flag_REMOTE_ICV_ID_OPAD_3 = &H0 Then write_REMOTE_ICV_ID_OPAD_3_value = get_REMOTE_ICV_ID_OPAD_3

        regValue = leftShift((write_REMOTE_ICV_ID_OPAD_3_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_OPAD_3_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_OPAD_3_mask = mask then
                read_REMOTE_ICV_ID_OPAD_3_value = data_low
            else
                read_REMOTE_ICV_ID_OPAD_3_value = (data_low - H8000_0000) and REMOTE_ICV_ID_OPAD_3_mask
            end If
        else
            read_REMOTE_ICV_ID_OPAD_3_value = data_low and REMOTE_ICV_ID_OPAD_3_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_REMOTE_ICV_ID_OPAD_3_value = &H0
        flag_REMOTE_ICV_ID_OPAD_3        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_remote_icv_id_opad3_p2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' REMOTE_ICV_ID_OPAD_3                       [15:0]           get_REMOTE_ICV_ID_OPAD_3
''                                                             set_REMOTE_ICV_ID_OPAD_3
''                                                             read_REMOTE_ICV_ID_OPAD_3
''                                                             write_REMOTE_ICV_ID_OPAD_3
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_remote_icv_id_opad3_p2
    Private write_REMOTE_ICV_ID_OPAD_3_value
    Private read_REMOTE_ICV_ID_OPAD_3_value
    Private flag_REMOTE_ICV_ID_OPAD_3

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H194
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_REMOTE_ICV_ID_OPAD_3
        get_REMOTE_ICV_ID_OPAD_3 = read_REMOTE_ICV_ID_OPAD_3_value
    End Property

    Property Let set_REMOTE_ICV_ID_OPAD_3(aData)
        write_REMOTE_ICV_ID_OPAD_3_value = aData
        flag_REMOTE_ICV_ID_OPAD_3        = &H1
    End Property

    Property Get read_REMOTE_ICV_ID_OPAD_3
        read
        read_REMOTE_ICV_ID_OPAD_3 = read_REMOTE_ICV_ID_OPAD_3_value
    End Property

    Property Let write_REMOTE_ICV_ID_OPAD_3(aData)
        set_REMOTE_ICV_ID_OPAD_3 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_OPAD_3_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_OPAD_3_mask = mask then
                read_REMOTE_ICV_ID_OPAD_3_value = data_low
            else
                read_REMOTE_ICV_ID_OPAD_3_value = (data_low - H8000_0000) and REMOTE_ICV_ID_OPAD_3_mask
            end If
        else
            read_REMOTE_ICV_ID_OPAD_3_value = data_low and REMOTE_ICV_ID_OPAD_3_mask
        end If

    End Sub

    Sub write
        If flag_REMOTE_ICV_ID_OPAD_3 = &H0 Then read
        If flag_REMOTE_ICV_ID_OPAD_3 = &H0 Then write_REMOTE_ICV_ID_OPAD_3_value = get_REMOTE_ICV_ID_OPAD_3

        regValue = leftShift((write_REMOTE_ICV_ID_OPAD_3_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_OPAD_3_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_OPAD_3_mask = mask then
                read_REMOTE_ICV_ID_OPAD_3_value = data_low
            else
                read_REMOTE_ICV_ID_OPAD_3_value = (data_low - H8000_0000) and REMOTE_ICV_ID_OPAD_3_mask
            end If
        else
            read_REMOTE_ICV_ID_OPAD_3_value = data_low and REMOTE_ICV_ID_OPAD_3_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_REMOTE_ICV_ID_OPAD_3_value = &H0
        flag_REMOTE_ICV_ID_OPAD_3        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_remote_icv_id_opad3_p3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' REMOTE_ICV_ID_OPAD_3                       [15:0]           get_REMOTE_ICV_ID_OPAD_3
''                                                             set_REMOTE_ICV_ID_OPAD_3
''                                                             read_REMOTE_ICV_ID_OPAD_3
''                                                             write_REMOTE_ICV_ID_OPAD_3
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_remote_icv_id_opad3_p3
    Private write_REMOTE_ICV_ID_OPAD_3_value
    Private read_REMOTE_ICV_ID_OPAD_3_value
    Private flag_REMOTE_ICV_ID_OPAD_3

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H196
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_REMOTE_ICV_ID_OPAD_3
        get_REMOTE_ICV_ID_OPAD_3 = read_REMOTE_ICV_ID_OPAD_3_value
    End Property

    Property Let set_REMOTE_ICV_ID_OPAD_3(aData)
        write_REMOTE_ICV_ID_OPAD_3_value = aData
        flag_REMOTE_ICV_ID_OPAD_3        = &H1
    End Property

    Property Get read_REMOTE_ICV_ID_OPAD_3
        read
        read_REMOTE_ICV_ID_OPAD_3 = read_REMOTE_ICV_ID_OPAD_3_value
    End Property

    Property Let write_REMOTE_ICV_ID_OPAD_3(aData)
        set_REMOTE_ICV_ID_OPAD_3 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_OPAD_3_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_OPAD_3_mask = mask then
                read_REMOTE_ICV_ID_OPAD_3_value = data_low
            else
                read_REMOTE_ICV_ID_OPAD_3_value = (data_low - H8000_0000) and REMOTE_ICV_ID_OPAD_3_mask
            end If
        else
            read_REMOTE_ICV_ID_OPAD_3_value = data_low and REMOTE_ICV_ID_OPAD_3_mask
        end If

    End Sub

    Sub write
        If flag_REMOTE_ICV_ID_OPAD_3 = &H0 Then read
        If flag_REMOTE_ICV_ID_OPAD_3 = &H0 Then write_REMOTE_ICV_ID_OPAD_3_value = get_REMOTE_ICV_ID_OPAD_3

        regValue = leftShift((write_REMOTE_ICV_ID_OPAD_3_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_OPAD_3_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_OPAD_3_mask = mask then
                read_REMOTE_ICV_ID_OPAD_3_value = data_low
            else
                read_REMOTE_ICV_ID_OPAD_3_value = (data_low - H8000_0000) and REMOTE_ICV_ID_OPAD_3_mask
            end If
        else
            read_REMOTE_ICV_ID_OPAD_3_value = data_low and REMOTE_ICV_ID_OPAD_3_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_REMOTE_ICV_ID_OPAD_3_value = &H0
        flag_REMOTE_ICV_ID_OPAD_3        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_remote_icv_id_opad3_p4
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' REMOTE_ICV_ID_OPAD_3                       [15:0]           get_REMOTE_ICV_ID_OPAD_3
''                                                             set_REMOTE_ICV_ID_OPAD_3
''                                                             read_REMOTE_ICV_ID_OPAD_3
''                                                             write_REMOTE_ICV_ID_OPAD_3
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_remote_icv_id_opad3_p4
    Private write_REMOTE_ICV_ID_OPAD_3_value
    Private read_REMOTE_ICV_ID_OPAD_3_value
    Private flag_REMOTE_ICV_ID_OPAD_3

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H198
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_REMOTE_ICV_ID_OPAD_3
        get_REMOTE_ICV_ID_OPAD_3 = read_REMOTE_ICV_ID_OPAD_3_value
    End Property

    Property Let set_REMOTE_ICV_ID_OPAD_3(aData)
        write_REMOTE_ICV_ID_OPAD_3_value = aData
        flag_REMOTE_ICV_ID_OPAD_3        = &H1
    End Property

    Property Get read_REMOTE_ICV_ID_OPAD_3
        read
        read_REMOTE_ICV_ID_OPAD_3 = read_REMOTE_ICV_ID_OPAD_3_value
    End Property

    Property Let write_REMOTE_ICV_ID_OPAD_3(aData)
        set_REMOTE_ICV_ID_OPAD_3 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_OPAD_3_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_OPAD_3_mask = mask then
                read_REMOTE_ICV_ID_OPAD_3_value = data_low
            else
                read_REMOTE_ICV_ID_OPAD_3_value = (data_low - H8000_0000) and REMOTE_ICV_ID_OPAD_3_mask
            end If
        else
            read_REMOTE_ICV_ID_OPAD_3_value = data_low and REMOTE_ICV_ID_OPAD_3_mask
        end If

    End Sub

    Sub write
        If flag_REMOTE_ICV_ID_OPAD_3 = &H0 Then read
        If flag_REMOTE_ICV_ID_OPAD_3 = &H0 Then write_REMOTE_ICV_ID_OPAD_3_value = get_REMOTE_ICV_ID_OPAD_3

        regValue = leftShift((write_REMOTE_ICV_ID_OPAD_3_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_OPAD_3_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_OPAD_3_mask = mask then
                read_REMOTE_ICV_ID_OPAD_3_value = data_low
            else
                read_REMOTE_ICV_ID_OPAD_3_value = (data_low - H8000_0000) and REMOTE_ICV_ID_OPAD_3_mask
            end If
        else
            read_REMOTE_ICV_ID_OPAD_3_value = data_low and REMOTE_ICV_ID_OPAD_3_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_REMOTE_ICV_ID_OPAD_3_value = &H0
        flag_REMOTE_ICV_ID_OPAD_3        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_remote_icv_id_opad3_p5
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' REMOTE_ICV_ID_OPAD_3                       [15:0]           get_REMOTE_ICV_ID_OPAD_3
''                                                             set_REMOTE_ICV_ID_OPAD_3
''                                                             read_REMOTE_ICV_ID_OPAD_3
''                                                             write_REMOTE_ICV_ID_OPAD_3
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_remote_icv_id_opad3_p5
    Private write_REMOTE_ICV_ID_OPAD_3_value
    Private read_REMOTE_ICV_ID_OPAD_3_value
    Private flag_REMOTE_ICV_ID_OPAD_3

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H19a
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_REMOTE_ICV_ID_OPAD_3
        get_REMOTE_ICV_ID_OPAD_3 = read_REMOTE_ICV_ID_OPAD_3_value
    End Property

    Property Let set_REMOTE_ICV_ID_OPAD_3(aData)
        write_REMOTE_ICV_ID_OPAD_3_value = aData
        flag_REMOTE_ICV_ID_OPAD_3        = &H1
    End Property

    Property Get read_REMOTE_ICV_ID_OPAD_3
        read
        read_REMOTE_ICV_ID_OPAD_3 = read_REMOTE_ICV_ID_OPAD_3_value
    End Property

    Property Let write_REMOTE_ICV_ID_OPAD_3(aData)
        set_REMOTE_ICV_ID_OPAD_3 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_OPAD_3_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_OPAD_3_mask = mask then
                read_REMOTE_ICV_ID_OPAD_3_value = data_low
            else
                read_REMOTE_ICV_ID_OPAD_3_value = (data_low - H8000_0000) and REMOTE_ICV_ID_OPAD_3_mask
            end If
        else
            read_REMOTE_ICV_ID_OPAD_3_value = data_low and REMOTE_ICV_ID_OPAD_3_mask
        end If

    End Sub

    Sub write
        If flag_REMOTE_ICV_ID_OPAD_3 = &H0 Then read
        If flag_REMOTE_ICV_ID_OPAD_3 = &H0 Then write_REMOTE_ICV_ID_OPAD_3_value = get_REMOTE_ICV_ID_OPAD_3

        regValue = leftShift((write_REMOTE_ICV_ID_OPAD_3_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REMOTE_ICV_ID_OPAD_3_mask = &Hffff
        if data_low > LONG_MAX then
            if REMOTE_ICV_ID_OPAD_3_mask = mask then
                read_REMOTE_ICV_ID_OPAD_3_value = data_low
            else
                read_REMOTE_ICV_ID_OPAD_3_value = (data_low - H8000_0000) and REMOTE_ICV_ID_OPAD_3_mask
            end If
        else
            read_REMOTE_ICV_ID_OPAD_3_value = data_low and REMOTE_ICV_ID_OPAD_3_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_REMOTE_ICV_ID_OPAD_3_value = &H0
        flag_REMOTE_ICV_ID_OPAD_3        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_icv_tx_counter_p0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ICV_TX_COUNTER                             [15:0]           get_ICV_TX_COUNTER
''                                                             set_ICV_TX_COUNTER
''                                                             read_ICV_TX_COUNTER
''                                                             write_ICV_TX_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_icv_tx_counter_p0
    Private write_ICV_TX_COUNTER_value
    Private read_ICV_TX_COUNTER_value
    Private flag_ICV_TX_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1a0
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ICV_TX_COUNTER
        get_ICV_TX_COUNTER = read_ICV_TX_COUNTER_value
    End Property

    Property Let set_ICV_TX_COUNTER(aData)
        write_ICV_TX_COUNTER_value = aData
        flag_ICV_TX_COUNTER        = &H1
    End Property

    Property Get read_ICV_TX_COUNTER
        read
        read_ICV_TX_COUNTER = read_ICV_TX_COUNTER_value
    End Property

    Property Let write_ICV_TX_COUNTER(aData)
        set_ICV_TX_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ICV_TX_COUNTER_mask = &Hffff
        if data_low > LONG_MAX then
            if ICV_TX_COUNTER_mask = mask then
                read_ICV_TX_COUNTER_value = data_low
            else
                read_ICV_TX_COUNTER_value = (data_low - H8000_0000) and ICV_TX_COUNTER_mask
            end If
        else
            read_ICV_TX_COUNTER_value = data_low and ICV_TX_COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_ICV_TX_COUNTER = &H0 Then read
        If flag_ICV_TX_COUNTER = &H0 Then write_ICV_TX_COUNTER_value = get_ICV_TX_COUNTER

        regValue = leftShift((write_ICV_TX_COUNTER_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ICV_TX_COUNTER_mask = &Hffff
        if data_low > LONG_MAX then
            if ICV_TX_COUNTER_mask = mask then
                read_ICV_TX_COUNTER_value = data_low
            else
                read_ICV_TX_COUNTER_value = (data_low - H8000_0000) and ICV_TX_COUNTER_mask
            end If
        else
            read_ICV_TX_COUNTER_value = data_low and ICV_TX_COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ICV_TX_COUNTER_value = &H0
        flag_ICV_TX_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_icv_tx_counter_p1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ICV_TX_COUNTER                             [15:0]           get_ICV_TX_COUNTER
''                                                             set_ICV_TX_COUNTER
''                                                             read_ICV_TX_COUNTER
''                                                             write_ICV_TX_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_icv_tx_counter_p1
    Private write_ICV_TX_COUNTER_value
    Private read_ICV_TX_COUNTER_value
    Private flag_ICV_TX_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1a2
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ICV_TX_COUNTER
        get_ICV_TX_COUNTER = read_ICV_TX_COUNTER_value
    End Property

    Property Let set_ICV_TX_COUNTER(aData)
        write_ICV_TX_COUNTER_value = aData
        flag_ICV_TX_COUNTER        = &H1
    End Property

    Property Get read_ICV_TX_COUNTER
        read
        read_ICV_TX_COUNTER = read_ICV_TX_COUNTER_value
    End Property

    Property Let write_ICV_TX_COUNTER(aData)
        set_ICV_TX_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ICV_TX_COUNTER_mask = &Hffff
        if data_low > LONG_MAX then
            if ICV_TX_COUNTER_mask = mask then
                read_ICV_TX_COUNTER_value = data_low
            else
                read_ICV_TX_COUNTER_value = (data_low - H8000_0000) and ICV_TX_COUNTER_mask
            end If
        else
            read_ICV_TX_COUNTER_value = data_low and ICV_TX_COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_ICV_TX_COUNTER = &H0 Then read
        If flag_ICV_TX_COUNTER = &H0 Then write_ICV_TX_COUNTER_value = get_ICV_TX_COUNTER

        regValue = leftShift((write_ICV_TX_COUNTER_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ICV_TX_COUNTER_mask = &Hffff
        if data_low > LONG_MAX then
            if ICV_TX_COUNTER_mask = mask then
                read_ICV_TX_COUNTER_value = data_low
            else
                read_ICV_TX_COUNTER_value = (data_low - H8000_0000) and ICV_TX_COUNTER_mask
            end If
        else
            read_ICV_TX_COUNTER_value = data_low and ICV_TX_COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ICV_TX_COUNTER_value = &H0
        flag_ICV_TX_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_icv_tx_counter_p2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ICV_TX_COUNTER                             [15:0]           get_ICV_TX_COUNTER
''                                                             set_ICV_TX_COUNTER
''                                                             read_ICV_TX_COUNTER
''                                                             write_ICV_TX_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_icv_tx_counter_p2
    Private write_ICV_TX_COUNTER_value
    Private read_ICV_TX_COUNTER_value
    Private flag_ICV_TX_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1a4
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ICV_TX_COUNTER
        get_ICV_TX_COUNTER = read_ICV_TX_COUNTER_value
    End Property

    Property Let set_ICV_TX_COUNTER(aData)
        write_ICV_TX_COUNTER_value = aData
        flag_ICV_TX_COUNTER        = &H1
    End Property

    Property Get read_ICV_TX_COUNTER
        read
        read_ICV_TX_COUNTER = read_ICV_TX_COUNTER_value
    End Property

    Property Let write_ICV_TX_COUNTER(aData)
        set_ICV_TX_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ICV_TX_COUNTER_mask = &Hffff
        if data_low > LONG_MAX then
            if ICV_TX_COUNTER_mask = mask then
                read_ICV_TX_COUNTER_value = data_low
            else
                read_ICV_TX_COUNTER_value = (data_low - H8000_0000) and ICV_TX_COUNTER_mask
            end If
        else
            read_ICV_TX_COUNTER_value = data_low and ICV_TX_COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_ICV_TX_COUNTER = &H0 Then read
        If flag_ICV_TX_COUNTER = &H0 Then write_ICV_TX_COUNTER_value = get_ICV_TX_COUNTER

        regValue = leftShift((write_ICV_TX_COUNTER_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ICV_TX_COUNTER_mask = &Hffff
        if data_low > LONG_MAX then
            if ICV_TX_COUNTER_mask = mask then
                read_ICV_TX_COUNTER_value = data_low
            else
                read_ICV_TX_COUNTER_value = (data_low - H8000_0000) and ICV_TX_COUNTER_mask
            end If
        else
            read_ICV_TX_COUNTER_value = data_low and ICV_TX_COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ICV_TX_COUNTER_value = &H0
        flag_ICV_TX_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_icv_tx_counter_p3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ICV_TX_COUNTER                             [15:0]           get_ICV_TX_COUNTER
''                                                             set_ICV_TX_COUNTER
''                                                             read_ICV_TX_COUNTER
''                                                             write_ICV_TX_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_icv_tx_counter_p3
    Private write_ICV_TX_COUNTER_value
    Private read_ICV_TX_COUNTER_value
    Private flag_ICV_TX_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1a6
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ICV_TX_COUNTER
        get_ICV_TX_COUNTER = read_ICV_TX_COUNTER_value
    End Property

    Property Let set_ICV_TX_COUNTER(aData)
        write_ICV_TX_COUNTER_value = aData
        flag_ICV_TX_COUNTER        = &H1
    End Property

    Property Get read_ICV_TX_COUNTER
        read
        read_ICV_TX_COUNTER = read_ICV_TX_COUNTER_value
    End Property

    Property Let write_ICV_TX_COUNTER(aData)
        set_ICV_TX_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ICV_TX_COUNTER_mask = &Hffff
        if data_low > LONG_MAX then
            if ICV_TX_COUNTER_mask = mask then
                read_ICV_TX_COUNTER_value = data_low
            else
                read_ICV_TX_COUNTER_value = (data_low - H8000_0000) and ICV_TX_COUNTER_mask
            end If
        else
            read_ICV_TX_COUNTER_value = data_low and ICV_TX_COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_ICV_TX_COUNTER = &H0 Then read
        If flag_ICV_TX_COUNTER = &H0 Then write_ICV_TX_COUNTER_value = get_ICV_TX_COUNTER

        regValue = leftShift((write_ICV_TX_COUNTER_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ICV_TX_COUNTER_mask = &Hffff
        if data_low > LONG_MAX then
            if ICV_TX_COUNTER_mask = mask then
                read_ICV_TX_COUNTER_value = data_low
            else
                read_ICV_TX_COUNTER_value = (data_low - H8000_0000) and ICV_TX_COUNTER_mask
            end If
        else
            read_ICV_TX_COUNTER_value = data_low and ICV_TX_COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ICV_TX_COUNTER_value = &H0
        flag_ICV_TX_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_icv_tx_counter_p4
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ICV_TX_COUNTER                             [15:0]           get_ICV_TX_COUNTER
''                                                             set_ICV_TX_COUNTER
''                                                             read_ICV_TX_COUNTER
''                                                             write_ICV_TX_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_icv_tx_counter_p4
    Private write_ICV_TX_COUNTER_value
    Private read_ICV_TX_COUNTER_value
    Private flag_ICV_TX_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1a8
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ICV_TX_COUNTER
        get_ICV_TX_COUNTER = read_ICV_TX_COUNTER_value
    End Property

    Property Let set_ICV_TX_COUNTER(aData)
        write_ICV_TX_COUNTER_value = aData
        flag_ICV_TX_COUNTER        = &H1
    End Property

    Property Get read_ICV_TX_COUNTER
        read
        read_ICV_TX_COUNTER = read_ICV_TX_COUNTER_value
    End Property

    Property Let write_ICV_TX_COUNTER(aData)
        set_ICV_TX_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ICV_TX_COUNTER_mask = &Hffff
        if data_low > LONG_MAX then
            if ICV_TX_COUNTER_mask = mask then
                read_ICV_TX_COUNTER_value = data_low
            else
                read_ICV_TX_COUNTER_value = (data_low - H8000_0000) and ICV_TX_COUNTER_mask
            end If
        else
            read_ICV_TX_COUNTER_value = data_low and ICV_TX_COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_ICV_TX_COUNTER = &H0 Then read
        If flag_ICV_TX_COUNTER = &H0 Then write_ICV_TX_COUNTER_value = get_ICV_TX_COUNTER

        regValue = leftShift((write_ICV_TX_COUNTER_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ICV_TX_COUNTER_mask = &Hffff
        if data_low > LONG_MAX then
            if ICV_TX_COUNTER_mask = mask then
                read_ICV_TX_COUNTER_value = data_low
            else
                read_ICV_TX_COUNTER_value = (data_low - H8000_0000) and ICV_TX_COUNTER_mask
            end If
        else
            read_ICV_TX_COUNTER_value = data_low and ICV_TX_COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ICV_TX_COUNTER_value = &H0
        flag_ICV_TX_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_icv_tx_counter_p5
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ICV_TX_COUNTER                             [15:0]           get_ICV_TX_COUNTER
''                                                             set_ICV_TX_COUNTER
''                                                             read_ICV_TX_COUNTER
''                                                             write_ICV_TX_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_icv_tx_counter_p5
    Private write_ICV_TX_COUNTER_value
    Private read_ICV_TX_COUNTER_value
    Private flag_ICV_TX_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1aa
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ICV_TX_COUNTER
        get_ICV_TX_COUNTER = read_ICV_TX_COUNTER_value
    End Property

    Property Let set_ICV_TX_COUNTER(aData)
        write_ICV_TX_COUNTER_value = aData
        flag_ICV_TX_COUNTER        = &H1
    End Property

    Property Get read_ICV_TX_COUNTER
        read
        read_ICV_TX_COUNTER = read_ICV_TX_COUNTER_value
    End Property

    Property Let write_ICV_TX_COUNTER(aData)
        set_ICV_TX_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ICV_TX_COUNTER_mask = &Hffff
        if data_low > LONG_MAX then
            if ICV_TX_COUNTER_mask = mask then
                read_ICV_TX_COUNTER_value = data_low
            else
                read_ICV_TX_COUNTER_value = (data_low - H8000_0000) and ICV_TX_COUNTER_mask
            end If
        else
            read_ICV_TX_COUNTER_value = data_low and ICV_TX_COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_ICV_TX_COUNTER = &H0 Then read
        If flag_ICV_TX_COUNTER = &H0 Then write_ICV_TX_COUNTER_value = get_ICV_TX_COUNTER

        regValue = leftShift((write_ICV_TX_COUNTER_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ICV_TX_COUNTER_mask = &Hffff
        if data_low > LONG_MAX then
            if ICV_TX_COUNTER_mask = mask then
                read_ICV_TX_COUNTER_value = data_low
            else
                read_ICV_TX_COUNTER_value = (data_low - H8000_0000) and ICV_TX_COUNTER_mask
            end If
        else
            read_ICV_TX_COUNTER_value = data_low and ICV_TX_COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ICV_TX_COUNTER_value = &H0
        flag_ICV_TX_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_icv_rx_pass_counter_p0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ICV_RX_PASS_COUNTER                        [15:0]           get_ICV_RX_PASS_COUNTER
''                                                             set_ICV_RX_PASS_COUNTER
''                                                             read_ICV_RX_PASS_COUNTER
''                                                             write_ICV_RX_PASS_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_icv_rx_pass_counter_p0
    Private write_ICV_RX_PASS_COUNTER_value
    Private read_ICV_RX_PASS_COUNTER_value
    Private flag_ICV_RX_PASS_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1b0
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ICV_RX_PASS_COUNTER
        get_ICV_RX_PASS_COUNTER = read_ICV_RX_PASS_COUNTER_value
    End Property

    Property Let set_ICV_RX_PASS_COUNTER(aData)
        write_ICV_RX_PASS_COUNTER_value = aData
        flag_ICV_RX_PASS_COUNTER        = &H1
    End Property

    Property Get read_ICV_RX_PASS_COUNTER
        read
        read_ICV_RX_PASS_COUNTER = read_ICV_RX_PASS_COUNTER_value
    End Property

    Property Let write_ICV_RX_PASS_COUNTER(aData)
        set_ICV_RX_PASS_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ICV_RX_PASS_COUNTER_mask = &Hffff
        if data_low > LONG_MAX then
            if ICV_RX_PASS_COUNTER_mask = mask then
                read_ICV_RX_PASS_COUNTER_value = data_low
            else
                read_ICV_RX_PASS_COUNTER_value = (data_low - H8000_0000) and ICV_RX_PASS_COUNTER_mask
            end If
        else
            read_ICV_RX_PASS_COUNTER_value = data_low and ICV_RX_PASS_COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_ICV_RX_PASS_COUNTER = &H0 Then read
        If flag_ICV_RX_PASS_COUNTER = &H0 Then write_ICV_RX_PASS_COUNTER_value = get_ICV_RX_PASS_COUNTER

        regValue = leftShift((write_ICV_RX_PASS_COUNTER_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ICV_RX_PASS_COUNTER_mask = &Hffff
        if data_low > LONG_MAX then
            if ICV_RX_PASS_COUNTER_mask = mask then
                read_ICV_RX_PASS_COUNTER_value = data_low
            else
                read_ICV_RX_PASS_COUNTER_value = (data_low - H8000_0000) and ICV_RX_PASS_COUNTER_mask
            end If
        else
            read_ICV_RX_PASS_COUNTER_value = data_low and ICV_RX_PASS_COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ICV_RX_PASS_COUNTER_value = &H0
        flag_ICV_RX_PASS_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_icv_rx_pass_counter_p1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ICV_RX_PASS_COUNTER                        [15:0]           get_ICV_RX_PASS_COUNTER
''                                                             set_ICV_RX_PASS_COUNTER
''                                                             read_ICV_RX_PASS_COUNTER
''                                                             write_ICV_RX_PASS_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_icv_rx_pass_counter_p1
    Private write_ICV_RX_PASS_COUNTER_value
    Private read_ICV_RX_PASS_COUNTER_value
    Private flag_ICV_RX_PASS_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1b2
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ICV_RX_PASS_COUNTER
        get_ICV_RX_PASS_COUNTER = read_ICV_RX_PASS_COUNTER_value
    End Property

    Property Let set_ICV_RX_PASS_COUNTER(aData)
        write_ICV_RX_PASS_COUNTER_value = aData
        flag_ICV_RX_PASS_COUNTER        = &H1
    End Property

    Property Get read_ICV_RX_PASS_COUNTER
        read
        read_ICV_RX_PASS_COUNTER = read_ICV_RX_PASS_COUNTER_value
    End Property

    Property Let write_ICV_RX_PASS_COUNTER(aData)
        set_ICV_RX_PASS_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ICV_RX_PASS_COUNTER_mask = &Hffff
        if data_low > LONG_MAX then
            if ICV_RX_PASS_COUNTER_mask = mask then
                read_ICV_RX_PASS_COUNTER_value = data_low
            else
                read_ICV_RX_PASS_COUNTER_value = (data_low - H8000_0000) and ICV_RX_PASS_COUNTER_mask
            end If
        else
            read_ICV_RX_PASS_COUNTER_value = data_low and ICV_RX_PASS_COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_ICV_RX_PASS_COUNTER = &H0 Then read
        If flag_ICV_RX_PASS_COUNTER = &H0 Then write_ICV_RX_PASS_COUNTER_value = get_ICV_RX_PASS_COUNTER

        regValue = leftShift((write_ICV_RX_PASS_COUNTER_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ICV_RX_PASS_COUNTER_mask = &Hffff
        if data_low > LONG_MAX then
            if ICV_RX_PASS_COUNTER_mask = mask then
                read_ICV_RX_PASS_COUNTER_value = data_low
            else
                read_ICV_RX_PASS_COUNTER_value = (data_low - H8000_0000) and ICV_RX_PASS_COUNTER_mask
            end If
        else
            read_ICV_RX_PASS_COUNTER_value = data_low and ICV_RX_PASS_COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ICV_RX_PASS_COUNTER_value = &H0
        flag_ICV_RX_PASS_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_icv_rx_pass_counter_p2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ICV_RX_PASS_COUNTER                        [15:0]           get_ICV_RX_PASS_COUNTER
''                                                             set_ICV_RX_PASS_COUNTER
''                                                             read_ICV_RX_PASS_COUNTER
''                                                             write_ICV_RX_PASS_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_icv_rx_pass_counter_p2
    Private write_ICV_RX_PASS_COUNTER_value
    Private read_ICV_RX_PASS_COUNTER_value
    Private flag_ICV_RX_PASS_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1b4
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ICV_RX_PASS_COUNTER
        get_ICV_RX_PASS_COUNTER = read_ICV_RX_PASS_COUNTER_value
    End Property

    Property Let set_ICV_RX_PASS_COUNTER(aData)
        write_ICV_RX_PASS_COUNTER_value = aData
        flag_ICV_RX_PASS_COUNTER        = &H1
    End Property

    Property Get read_ICV_RX_PASS_COUNTER
        read
        read_ICV_RX_PASS_COUNTER = read_ICV_RX_PASS_COUNTER_value
    End Property

    Property Let write_ICV_RX_PASS_COUNTER(aData)
        set_ICV_RX_PASS_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ICV_RX_PASS_COUNTER_mask = &Hffff
        if data_low > LONG_MAX then
            if ICV_RX_PASS_COUNTER_mask = mask then
                read_ICV_RX_PASS_COUNTER_value = data_low
            else
                read_ICV_RX_PASS_COUNTER_value = (data_low - H8000_0000) and ICV_RX_PASS_COUNTER_mask
            end If
        else
            read_ICV_RX_PASS_COUNTER_value = data_low and ICV_RX_PASS_COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_ICV_RX_PASS_COUNTER = &H0 Then read
        If flag_ICV_RX_PASS_COUNTER = &H0 Then write_ICV_RX_PASS_COUNTER_value = get_ICV_RX_PASS_COUNTER

        regValue = leftShift((write_ICV_RX_PASS_COUNTER_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ICV_RX_PASS_COUNTER_mask = &Hffff
        if data_low > LONG_MAX then
            if ICV_RX_PASS_COUNTER_mask = mask then
                read_ICV_RX_PASS_COUNTER_value = data_low
            else
                read_ICV_RX_PASS_COUNTER_value = (data_low - H8000_0000) and ICV_RX_PASS_COUNTER_mask
            end If
        else
            read_ICV_RX_PASS_COUNTER_value = data_low and ICV_RX_PASS_COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ICV_RX_PASS_COUNTER_value = &H0
        flag_ICV_RX_PASS_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_icv_rx_pass_counter_p3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ICV_RX_PASS_COUNTER                        [15:0]           get_ICV_RX_PASS_COUNTER
''                                                             set_ICV_RX_PASS_COUNTER
''                                                             read_ICV_RX_PASS_COUNTER
''                                                             write_ICV_RX_PASS_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_icv_rx_pass_counter_p3
    Private write_ICV_RX_PASS_COUNTER_value
    Private read_ICV_RX_PASS_COUNTER_value
    Private flag_ICV_RX_PASS_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1b6
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ICV_RX_PASS_COUNTER
        get_ICV_RX_PASS_COUNTER = read_ICV_RX_PASS_COUNTER_value
    End Property

    Property Let set_ICV_RX_PASS_COUNTER(aData)
        write_ICV_RX_PASS_COUNTER_value = aData
        flag_ICV_RX_PASS_COUNTER        = &H1
    End Property

    Property Get read_ICV_RX_PASS_COUNTER
        read
        read_ICV_RX_PASS_COUNTER = read_ICV_RX_PASS_COUNTER_value
    End Property

    Property Let write_ICV_RX_PASS_COUNTER(aData)
        set_ICV_RX_PASS_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ICV_RX_PASS_COUNTER_mask = &Hffff
        if data_low > LONG_MAX then
            if ICV_RX_PASS_COUNTER_mask = mask then
                read_ICV_RX_PASS_COUNTER_value = data_low
            else
                read_ICV_RX_PASS_COUNTER_value = (data_low - H8000_0000) and ICV_RX_PASS_COUNTER_mask
            end If
        else
            read_ICV_RX_PASS_COUNTER_value = data_low and ICV_RX_PASS_COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_ICV_RX_PASS_COUNTER = &H0 Then read
        If flag_ICV_RX_PASS_COUNTER = &H0 Then write_ICV_RX_PASS_COUNTER_value = get_ICV_RX_PASS_COUNTER

        regValue = leftShift((write_ICV_RX_PASS_COUNTER_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ICV_RX_PASS_COUNTER_mask = &Hffff
        if data_low > LONG_MAX then
            if ICV_RX_PASS_COUNTER_mask = mask then
                read_ICV_RX_PASS_COUNTER_value = data_low
            else
                read_ICV_RX_PASS_COUNTER_value = (data_low - H8000_0000) and ICV_RX_PASS_COUNTER_mask
            end If
        else
            read_ICV_RX_PASS_COUNTER_value = data_low and ICV_RX_PASS_COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ICV_RX_PASS_COUNTER_value = &H0
        flag_ICV_RX_PASS_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_icv_rx_pass_counter_p4
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ICV_RX_PASS_COUNTER                        [15:0]           get_ICV_RX_PASS_COUNTER
''                                                             set_ICV_RX_PASS_COUNTER
''                                                             read_ICV_RX_PASS_COUNTER
''                                                             write_ICV_RX_PASS_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_icv_rx_pass_counter_p4
    Private write_ICV_RX_PASS_COUNTER_value
    Private read_ICV_RX_PASS_COUNTER_value
    Private flag_ICV_RX_PASS_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1b8
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ICV_RX_PASS_COUNTER
        get_ICV_RX_PASS_COUNTER = read_ICV_RX_PASS_COUNTER_value
    End Property

    Property Let set_ICV_RX_PASS_COUNTER(aData)
        write_ICV_RX_PASS_COUNTER_value = aData
        flag_ICV_RX_PASS_COUNTER        = &H1
    End Property

    Property Get read_ICV_RX_PASS_COUNTER
        read
        read_ICV_RX_PASS_COUNTER = read_ICV_RX_PASS_COUNTER_value
    End Property

    Property Let write_ICV_RX_PASS_COUNTER(aData)
        set_ICV_RX_PASS_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ICV_RX_PASS_COUNTER_mask = &Hffff
        if data_low > LONG_MAX then
            if ICV_RX_PASS_COUNTER_mask = mask then
                read_ICV_RX_PASS_COUNTER_value = data_low
            else
                read_ICV_RX_PASS_COUNTER_value = (data_low - H8000_0000) and ICV_RX_PASS_COUNTER_mask
            end If
        else
            read_ICV_RX_PASS_COUNTER_value = data_low and ICV_RX_PASS_COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_ICV_RX_PASS_COUNTER = &H0 Then read
        If flag_ICV_RX_PASS_COUNTER = &H0 Then write_ICV_RX_PASS_COUNTER_value = get_ICV_RX_PASS_COUNTER

        regValue = leftShift((write_ICV_RX_PASS_COUNTER_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ICV_RX_PASS_COUNTER_mask = &Hffff
        if data_low > LONG_MAX then
            if ICV_RX_PASS_COUNTER_mask = mask then
                read_ICV_RX_PASS_COUNTER_value = data_low
            else
                read_ICV_RX_PASS_COUNTER_value = (data_low - H8000_0000) and ICV_RX_PASS_COUNTER_mask
            end If
        else
            read_ICV_RX_PASS_COUNTER_value = data_low and ICV_RX_PASS_COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ICV_RX_PASS_COUNTER_value = &H0
        flag_ICV_RX_PASS_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_icv_rx_pass_counter_p5
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ICV_RX_PASS_COUNTER                        [15:0]           get_ICV_RX_PASS_COUNTER
''                                                             set_ICV_RX_PASS_COUNTER
''                                                             read_ICV_RX_PASS_COUNTER
''                                                             write_ICV_RX_PASS_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_icv_rx_pass_counter_p5
    Private write_ICV_RX_PASS_COUNTER_value
    Private read_ICV_RX_PASS_COUNTER_value
    Private flag_ICV_RX_PASS_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1ba
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ICV_RX_PASS_COUNTER
        get_ICV_RX_PASS_COUNTER = read_ICV_RX_PASS_COUNTER_value
    End Property

    Property Let set_ICV_RX_PASS_COUNTER(aData)
        write_ICV_RX_PASS_COUNTER_value = aData
        flag_ICV_RX_PASS_COUNTER        = &H1
    End Property

    Property Get read_ICV_RX_PASS_COUNTER
        read
        read_ICV_RX_PASS_COUNTER = read_ICV_RX_PASS_COUNTER_value
    End Property

    Property Let write_ICV_RX_PASS_COUNTER(aData)
        set_ICV_RX_PASS_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ICV_RX_PASS_COUNTER_mask = &Hffff
        if data_low > LONG_MAX then
            if ICV_RX_PASS_COUNTER_mask = mask then
                read_ICV_RX_PASS_COUNTER_value = data_low
            else
                read_ICV_RX_PASS_COUNTER_value = (data_low - H8000_0000) and ICV_RX_PASS_COUNTER_mask
            end If
        else
            read_ICV_RX_PASS_COUNTER_value = data_low and ICV_RX_PASS_COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_ICV_RX_PASS_COUNTER = &H0 Then read
        If flag_ICV_RX_PASS_COUNTER = &H0 Then write_ICV_RX_PASS_COUNTER_value = get_ICV_RX_PASS_COUNTER

        regValue = leftShift((write_ICV_RX_PASS_COUNTER_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ICV_RX_PASS_COUNTER_mask = &Hffff
        if data_low > LONG_MAX then
            if ICV_RX_PASS_COUNTER_mask = mask then
                read_ICV_RX_PASS_COUNTER_value = data_low
            else
                read_ICV_RX_PASS_COUNTER_value = (data_low - H8000_0000) and ICV_RX_PASS_COUNTER_mask
            end If
        else
            read_ICV_RX_PASS_COUNTER_value = data_low and ICV_RX_PASS_COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ICV_RX_PASS_COUNTER_value = &H0
        flag_ICV_RX_PASS_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_icv_rx_fail_counter_p0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ICV_RX_FAIL_COUNTER                        [15:0]           get_ICV_RX_FAIL_COUNTER
''                                                             set_ICV_RX_FAIL_COUNTER
''                                                             read_ICV_RX_FAIL_COUNTER
''                                                             write_ICV_RX_FAIL_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_icv_rx_fail_counter_p0
    Private write_ICV_RX_FAIL_COUNTER_value
    Private read_ICV_RX_FAIL_COUNTER_value
    Private flag_ICV_RX_FAIL_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1c0
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ICV_RX_FAIL_COUNTER
        get_ICV_RX_FAIL_COUNTER = read_ICV_RX_FAIL_COUNTER_value
    End Property

    Property Let set_ICV_RX_FAIL_COUNTER(aData)
        write_ICV_RX_FAIL_COUNTER_value = aData
        flag_ICV_RX_FAIL_COUNTER        = &H1
    End Property

    Property Get read_ICV_RX_FAIL_COUNTER
        read
        read_ICV_RX_FAIL_COUNTER = read_ICV_RX_FAIL_COUNTER_value
    End Property

    Property Let write_ICV_RX_FAIL_COUNTER(aData)
        set_ICV_RX_FAIL_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ICV_RX_FAIL_COUNTER_mask = &Hffff
        if data_low > LONG_MAX then
            if ICV_RX_FAIL_COUNTER_mask = mask then
                read_ICV_RX_FAIL_COUNTER_value = data_low
            else
                read_ICV_RX_FAIL_COUNTER_value = (data_low - H8000_0000) and ICV_RX_FAIL_COUNTER_mask
            end If
        else
            read_ICV_RX_FAIL_COUNTER_value = data_low and ICV_RX_FAIL_COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_ICV_RX_FAIL_COUNTER = &H0 Then read
        If flag_ICV_RX_FAIL_COUNTER = &H0 Then write_ICV_RX_FAIL_COUNTER_value = get_ICV_RX_FAIL_COUNTER

        regValue = leftShift((write_ICV_RX_FAIL_COUNTER_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ICV_RX_FAIL_COUNTER_mask = &Hffff
        if data_low > LONG_MAX then
            if ICV_RX_FAIL_COUNTER_mask = mask then
                read_ICV_RX_FAIL_COUNTER_value = data_low
            else
                read_ICV_RX_FAIL_COUNTER_value = (data_low - H8000_0000) and ICV_RX_FAIL_COUNTER_mask
            end If
        else
            read_ICV_RX_FAIL_COUNTER_value = data_low and ICV_RX_FAIL_COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ICV_RX_FAIL_COUNTER_value = &H0
        flag_ICV_RX_FAIL_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_icv_rx_fail_counter_p1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ICV_RX_FAIL_COUNTER                        [15:0]           get_ICV_RX_FAIL_COUNTER
''                                                             set_ICV_RX_FAIL_COUNTER
''                                                             read_ICV_RX_FAIL_COUNTER
''                                                             write_ICV_RX_FAIL_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_icv_rx_fail_counter_p1
    Private write_ICV_RX_FAIL_COUNTER_value
    Private read_ICV_RX_FAIL_COUNTER_value
    Private flag_ICV_RX_FAIL_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1c2
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ICV_RX_FAIL_COUNTER
        get_ICV_RX_FAIL_COUNTER = read_ICV_RX_FAIL_COUNTER_value
    End Property

    Property Let set_ICV_RX_FAIL_COUNTER(aData)
        write_ICV_RX_FAIL_COUNTER_value = aData
        flag_ICV_RX_FAIL_COUNTER        = &H1
    End Property

    Property Get read_ICV_RX_FAIL_COUNTER
        read
        read_ICV_RX_FAIL_COUNTER = read_ICV_RX_FAIL_COUNTER_value
    End Property

    Property Let write_ICV_RX_FAIL_COUNTER(aData)
        set_ICV_RX_FAIL_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ICV_RX_FAIL_COUNTER_mask = &Hffff
        if data_low > LONG_MAX then
            if ICV_RX_FAIL_COUNTER_mask = mask then
                read_ICV_RX_FAIL_COUNTER_value = data_low
            else
                read_ICV_RX_FAIL_COUNTER_value = (data_low - H8000_0000) and ICV_RX_FAIL_COUNTER_mask
            end If
        else
            read_ICV_RX_FAIL_COUNTER_value = data_low and ICV_RX_FAIL_COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_ICV_RX_FAIL_COUNTER = &H0 Then read
        If flag_ICV_RX_FAIL_COUNTER = &H0 Then write_ICV_RX_FAIL_COUNTER_value = get_ICV_RX_FAIL_COUNTER

        regValue = leftShift((write_ICV_RX_FAIL_COUNTER_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ICV_RX_FAIL_COUNTER_mask = &Hffff
        if data_low > LONG_MAX then
            if ICV_RX_FAIL_COUNTER_mask = mask then
                read_ICV_RX_FAIL_COUNTER_value = data_low
            else
                read_ICV_RX_FAIL_COUNTER_value = (data_low - H8000_0000) and ICV_RX_FAIL_COUNTER_mask
            end If
        else
            read_ICV_RX_FAIL_COUNTER_value = data_low and ICV_RX_FAIL_COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ICV_RX_FAIL_COUNTER_value = &H0
        flag_ICV_RX_FAIL_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_icv_rx_fail_counter_p2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ICV_RX_FAIL_COUNTER                        [15:0]           get_ICV_RX_FAIL_COUNTER
''                                                             set_ICV_RX_FAIL_COUNTER
''                                                             read_ICV_RX_FAIL_COUNTER
''                                                             write_ICV_RX_FAIL_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_icv_rx_fail_counter_p2
    Private write_ICV_RX_FAIL_COUNTER_value
    Private read_ICV_RX_FAIL_COUNTER_value
    Private flag_ICV_RX_FAIL_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1c4
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ICV_RX_FAIL_COUNTER
        get_ICV_RX_FAIL_COUNTER = read_ICV_RX_FAIL_COUNTER_value
    End Property

    Property Let set_ICV_RX_FAIL_COUNTER(aData)
        write_ICV_RX_FAIL_COUNTER_value = aData
        flag_ICV_RX_FAIL_COUNTER        = &H1
    End Property

    Property Get read_ICV_RX_FAIL_COUNTER
        read
        read_ICV_RX_FAIL_COUNTER = read_ICV_RX_FAIL_COUNTER_value
    End Property

    Property Let write_ICV_RX_FAIL_COUNTER(aData)
        set_ICV_RX_FAIL_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ICV_RX_FAIL_COUNTER_mask = &Hffff
        if data_low > LONG_MAX then
            if ICV_RX_FAIL_COUNTER_mask = mask then
                read_ICV_RX_FAIL_COUNTER_value = data_low
            else
                read_ICV_RX_FAIL_COUNTER_value = (data_low - H8000_0000) and ICV_RX_FAIL_COUNTER_mask
            end If
        else
            read_ICV_RX_FAIL_COUNTER_value = data_low and ICV_RX_FAIL_COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_ICV_RX_FAIL_COUNTER = &H0 Then read
        If flag_ICV_RX_FAIL_COUNTER = &H0 Then write_ICV_RX_FAIL_COUNTER_value = get_ICV_RX_FAIL_COUNTER

        regValue = leftShift((write_ICV_RX_FAIL_COUNTER_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ICV_RX_FAIL_COUNTER_mask = &Hffff
        if data_low > LONG_MAX then
            if ICV_RX_FAIL_COUNTER_mask = mask then
                read_ICV_RX_FAIL_COUNTER_value = data_low
            else
                read_ICV_RX_FAIL_COUNTER_value = (data_low - H8000_0000) and ICV_RX_FAIL_COUNTER_mask
            end If
        else
            read_ICV_RX_FAIL_COUNTER_value = data_low and ICV_RX_FAIL_COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ICV_RX_FAIL_COUNTER_value = &H0
        flag_ICV_RX_FAIL_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_icv_rx_fail_counter_p3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ICV_RX_FAIL_COUNTER                        [15:0]           get_ICV_RX_FAIL_COUNTER
''                                                             set_ICV_RX_FAIL_COUNTER
''                                                             read_ICV_RX_FAIL_COUNTER
''                                                             write_ICV_RX_FAIL_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_icv_rx_fail_counter_p3
    Private write_ICV_RX_FAIL_COUNTER_value
    Private read_ICV_RX_FAIL_COUNTER_value
    Private flag_ICV_RX_FAIL_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1c6
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ICV_RX_FAIL_COUNTER
        get_ICV_RX_FAIL_COUNTER = read_ICV_RX_FAIL_COUNTER_value
    End Property

    Property Let set_ICV_RX_FAIL_COUNTER(aData)
        write_ICV_RX_FAIL_COUNTER_value = aData
        flag_ICV_RX_FAIL_COUNTER        = &H1
    End Property

    Property Get read_ICV_RX_FAIL_COUNTER
        read
        read_ICV_RX_FAIL_COUNTER = read_ICV_RX_FAIL_COUNTER_value
    End Property

    Property Let write_ICV_RX_FAIL_COUNTER(aData)
        set_ICV_RX_FAIL_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ICV_RX_FAIL_COUNTER_mask = &Hffff
        if data_low > LONG_MAX then
            if ICV_RX_FAIL_COUNTER_mask = mask then
                read_ICV_RX_FAIL_COUNTER_value = data_low
            else
                read_ICV_RX_FAIL_COUNTER_value = (data_low - H8000_0000) and ICV_RX_FAIL_COUNTER_mask
            end If
        else
            read_ICV_RX_FAIL_COUNTER_value = data_low and ICV_RX_FAIL_COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_ICV_RX_FAIL_COUNTER = &H0 Then read
        If flag_ICV_RX_FAIL_COUNTER = &H0 Then write_ICV_RX_FAIL_COUNTER_value = get_ICV_RX_FAIL_COUNTER

        regValue = leftShift((write_ICV_RX_FAIL_COUNTER_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ICV_RX_FAIL_COUNTER_mask = &Hffff
        if data_low > LONG_MAX then
            if ICV_RX_FAIL_COUNTER_mask = mask then
                read_ICV_RX_FAIL_COUNTER_value = data_low
            else
                read_ICV_RX_FAIL_COUNTER_value = (data_low - H8000_0000) and ICV_RX_FAIL_COUNTER_mask
            end If
        else
            read_ICV_RX_FAIL_COUNTER_value = data_low and ICV_RX_FAIL_COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ICV_RX_FAIL_COUNTER_value = &H0
        flag_ICV_RX_FAIL_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_icv_rx_fail_counter_p4
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ICV_RX_FAIL_COUNTER                        [15:0]           get_ICV_RX_FAIL_COUNTER
''                                                             set_ICV_RX_FAIL_COUNTER
''                                                             read_ICV_RX_FAIL_COUNTER
''                                                             write_ICV_RX_FAIL_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_icv_rx_fail_counter_p4
    Private write_ICV_RX_FAIL_COUNTER_value
    Private read_ICV_RX_FAIL_COUNTER_value
    Private flag_ICV_RX_FAIL_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1c8
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ICV_RX_FAIL_COUNTER
        get_ICV_RX_FAIL_COUNTER = read_ICV_RX_FAIL_COUNTER_value
    End Property

    Property Let set_ICV_RX_FAIL_COUNTER(aData)
        write_ICV_RX_FAIL_COUNTER_value = aData
        flag_ICV_RX_FAIL_COUNTER        = &H1
    End Property

    Property Get read_ICV_RX_FAIL_COUNTER
        read
        read_ICV_RX_FAIL_COUNTER = read_ICV_RX_FAIL_COUNTER_value
    End Property

    Property Let write_ICV_RX_FAIL_COUNTER(aData)
        set_ICV_RX_FAIL_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ICV_RX_FAIL_COUNTER_mask = &Hffff
        if data_low > LONG_MAX then
            if ICV_RX_FAIL_COUNTER_mask = mask then
                read_ICV_RX_FAIL_COUNTER_value = data_low
            else
                read_ICV_RX_FAIL_COUNTER_value = (data_low - H8000_0000) and ICV_RX_FAIL_COUNTER_mask
            end If
        else
            read_ICV_RX_FAIL_COUNTER_value = data_low and ICV_RX_FAIL_COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_ICV_RX_FAIL_COUNTER = &H0 Then read
        If flag_ICV_RX_FAIL_COUNTER = &H0 Then write_ICV_RX_FAIL_COUNTER_value = get_ICV_RX_FAIL_COUNTER

        regValue = leftShift((write_ICV_RX_FAIL_COUNTER_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ICV_RX_FAIL_COUNTER_mask = &Hffff
        if data_low > LONG_MAX then
            if ICV_RX_FAIL_COUNTER_mask = mask then
                read_ICV_RX_FAIL_COUNTER_value = data_low
            else
                read_ICV_RX_FAIL_COUNTER_value = (data_low - H8000_0000) and ICV_RX_FAIL_COUNTER_mask
            end If
        else
            read_ICV_RX_FAIL_COUNTER_value = data_low and ICV_RX_FAIL_COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ICV_RX_FAIL_COUNTER_value = &H0
        flag_ICV_RX_FAIL_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_icv_rx_fail_counter_p5
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ICV_RX_FAIL_COUNTER                        [15:0]           get_ICV_RX_FAIL_COUNTER
''                                                             set_ICV_RX_FAIL_COUNTER
''                                                             read_ICV_RX_FAIL_COUNTER
''                                                             write_ICV_RX_FAIL_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_icv_rx_fail_counter_p5
    Private write_ICV_RX_FAIL_COUNTER_value
    Private read_ICV_RX_FAIL_COUNTER_value
    Private flag_ICV_RX_FAIL_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1ca
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ICV_RX_FAIL_COUNTER
        get_ICV_RX_FAIL_COUNTER = read_ICV_RX_FAIL_COUNTER_value
    End Property

    Property Let set_ICV_RX_FAIL_COUNTER(aData)
        write_ICV_RX_FAIL_COUNTER_value = aData
        flag_ICV_RX_FAIL_COUNTER        = &H1
    End Property

    Property Get read_ICV_RX_FAIL_COUNTER
        read
        read_ICV_RX_FAIL_COUNTER = read_ICV_RX_FAIL_COUNTER_value
    End Property

    Property Let write_ICV_RX_FAIL_COUNTER(aData)
        set_ICV_RX_FAIL_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ICV_RX_FAIL_COUNTER_mask = &Hffff
        if data_low > LONG_MAX then
            if ICV_RX_FAIL_COUNTER_mask = mask then
                read_ICV_RX_FAIL_COUNTER_value = data_low
            else
                read_ICV_RX_FAIL_COUNTER_value = (data_low - H8000_0000) and ICV_RX_FAIL_COUNTER_mask
            end If
        else
            read_ICV_RX_FAIL_COUNTER_value = data_low and ICV_RX_FAIL_COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_ICV_RX_FAIL_COUNTER = &H0 Then read
        If flag_ICV_RX_FAIL_COUNTER = &H0 Then write_ICV_RX_FAIL_COUNTER_value = get_ICV_RX_FAIL_COUNTER

        regValue = leftShift((write_ICV_RX_FAIL_COUNTER_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ICV_RX_FAIL_COUNTER_mask = &Hffff
        if data_low > LONG_MAX then
            if ICV_RX_FAIL_COUNTER_mask = mask then
                read_ICV_RX_FAIL_COUNTER_value = data_low
            else
                read_ICV_RX_FAIL_COUNTER_value = (data_low - H8000_0000) and ICV_RX_FAIL_COUNTER_mask
            end If
        else
            read_ICV_RX_FAIL_COUNTER_value = data_low and ICV_RX_FAIL_COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ICV_RX_FAIL_COUNTER_value = &H0
        flag_ICV_RX_FAIL_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_fxed_pkt_index
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' FIXED_PKT_INDEX                            [15:0]           get_FIXED_PKT_INDEX
''                                                             set_FIXED_PKT_INDEX
''                                                             read_FIXED_PKT_INDEX
''                                                             write_FIXED_PKT_INDEX
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_fxed_pkt_index
    Private write_FIXED_PKT_INDEX_value
    Private read_FIXED_PKT_INDEX_value
    Private flag_FIXED_PKT_INDEX

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1d0
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_FIXED_PKT_INDEX
        get_FIXED_PKT_INDEX = read_FIXED_PKT_INDEX_value
    End Property

    Property Let set_FIXED_PKT_INDEX(aData)
        write_FIXED_PKT_INDEX_value = aData
        flag_FIXED_PKT_INDEX        = &H1
    End Property

    Property Get read_FIXED_PKT_INDEX
        read
        read_FIXED_PKT_INDEX = read_FIXED_PKT_INDEX_value
    End Property

    Property Let write_FIXED_PKT_INDEX(aData)
        set_FIXED_PKT_INDEX = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        FIXED_PKT_INDEX_mask = &Hffff
        if data_low > LONG_MAX then
            if FIXED_PKT_INDEX_mask = mask then
                read_FIXED_PKT_INDEX_value = data_low
            else
                read_FIXED_PKT_INDEX_value = (data_low - H8000_0000) and FIXED_PKT_INDEX_mask
            end If
        else
            read_FIXED_PKT_INDEX_value = data_low and FIXED_PKT_INDEX_mask
        end If

    End Sub

    Sub write
        If flag_FIXED_PKT_INDEX = &H0 Then read
        If flag_FIXED_PKT_INDEX = &H0 Then write_FIXED_PKT_INDEX_value = get_FIXED_PKT_INDEX

        regValue = leftShift((write_FIXED_PKT_INDEX_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        FIXED_PKT_INDEX_mask = &Hffff
        if data_low > LONG_MAX then
            if FIXED_PKT_INDEX_mask = mask then
                read_FIXED_PKT_INDEX_value = data_low
            else
                read_FIXED_PKT_INDEX_value = (data_low - H8000_0000) and FIXED_PKT_INDEX_mask
            end If
        else
            read_FIXED_PKT_INDEX_value = data_low and FIXED_PKT_INDEX_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_FIXED_PKT_INDEX_value = &H0
        flag_FIXED_PKT_INDEX        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_icv_bypass_ethtype1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ICV_BYPASS_ETYPE1                          [15:0]           get_ICV_BYPASS_ETYPE1
''                                                             set_ICV_BYPASS_ETYPE1
''                                                             read_ICV_BYPASS_ETYPE1
''                                                             write_ICV_BYPASS_ETYPE1
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_icv_bypass_ethtype1
    Private write_ICV_BYPASS_ETYPE1_value
    Private read_ICV_BYPASS_ETYPE1_value
    Private flag_ICV_BYPASS_ETYPE1

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1d2
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ICV_BYPASS_ETYPE1
        get_ICV_BYPASS_ETYPE1 = read_ICV_BYPASS_ETYPE1_value
    End Property

    Property Let set_ICV_BYPASS_ETYPE1(aData)
        write_ICV_BYPASS_ETYPE1_value = aData
        flag_ICV_BYPASS_ETYPE1        = &H1
    End Property

    Property Get read_ICV_BYPASS_ETYPE1
        read
        read_ICV_BYPASS_ETYPE1 = read_ICV_BYPASS_ETYPE1_value
    End Property

    Property Let write_ICV_BYPASS_ETYPE1(aData)
        set_ICV_BYPASS_ETYPE1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ICV_BYPASS_ETYPE1_mask = &Hffff
        if data_low > LONG_MAX then
            if ICV_BYPASS_ETYPE1_mask = mask then
                read_ICV_BYPASS_ETYPE1_value = data_low
            else
                read_ICV_BYPASS_ETYPE1_value = (data_low - H8000_0000) and ICV_BYPASS_ETYPE1_mask
            end If
        else
            read_ICV_BYPASS_ETYPE1_value = data_low and ICV_BYPASS_ETYPE1_mask
        end If

    End Sub

    Sub write
        If flag_ICV_BYPASS_ETYPE1 = &H0 Then read
        If flag_ICV_BYPASS_ETYPE1 = &H0 Then write_ICV_BYPASS_ETYPE1_value = get_ICV_BYPASS_ETYPE1

        regValue = leftShift((write_ICV_BYPASS_ETYPE1_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ICV_BYPASS_ETYPE1_mask = &Hffff
        if data_low > LONG_MAX then
            if ICV_BYPASS_ETYPE1_mask = mask then
                read_ICV_BYPASS_ETYPE1_value = data_low
            else
                read_ICV_BYPASS_ETYPE1_value = (data_low - H8000_0000) and ICV_BYPASS_ETYPE1_mask
            end If
        else
            read_ICV_BYPASS_ETYPE1_value = data_low and ICV_BYPASS_ETYPE1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ICV_BYPASS_ETYPE1_value = &H0
        flag_ICV_BYPASS_ETYPE1        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_icv_bypass_ethtype2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ICV_BYPASS_ETYPE2                          [15:0]           get_ICV_BYPASS_ETYPE2
''                                                             set_ICV_BYPASS_ETYPE2
''                                                             read_ICV_BYPASS_ETYPE2
''                                                             write_ICV_BYPASS_ETYPE2
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_icv_bypass_ethtype2
    Private write_ICV_BYPASS_ETYPE2_value
    Private read_ICV_BYPASS_ETYPE2_value
    Private flag_ICV_BYPASS_ETYPE2

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1d4
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ICV_BYPASS_ETYPE2
        get_ICV_BYPASS_ETYPE2 = read_ICV_BYPASS_ETYPE2_value
    End Property

    Property Let set_ICV_BYPASS_ETYPE2(aData)
        write_ICV_BYPASS_ETYPE2_value = aData
        flag_ICV_BYPASS_ETYPE2        = &H1
    End Property

    Property Get read_ICV_BYPASS_ETYPE2
        read
        read_ICV_BYPASS_ETYPE2 = read_ICV_BYPASS_ETYPE2_value
    End Property

    Property Let write_ICV_BYPASS_ETYPE2(aData)
        set_ICV_BYPASS_ETYPE2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ICV_BYPASS_ETYPE2_mask = &Hffff
        if data_low > LONG_MAX then
            if ICV_BYPASS_ETYPE2_mask = mask then
                read_ICV_BYPASS_ETYPE2_value = data_low
            else
                read_ICV_BYPASS_ETYPE2_value = (data_low - H8000_0000) and ICV_BYPASS_ETYPE2_mask
            end If
        else
            read_ICV_BYPASS_ETYPE2_value = data_low and ICV_BYPASS_ETYPE2_mask
        end If

    End Sub

    Sub write
        If flag_ICV_BYPASS_ETYPE2 = &H0 Then read
        If flag_ICV_BYPASS_ETYPE2 = &H0 Then write_ICV_BYPASS_ETYPE2_value = get_ICV_BYPASS_ETYPE2

        regValue = leftShift((write_ICV_BYPASS_ETYPE2_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ICV_BYPASS_ETYPE2_mask = &Hffff
        if data_low > LONG_MAX then
            if ICV_BYPASS_ETYPE2_mask = mask then
                read_ICV_BYPASS_ETYPE2_value = data_low
            else
                read_ICV_BYPASS_ETYPE2_value = (data_low - H8000_0000) and ICV_BYPASS_ETYPE2_mask
            end If
        else
            read_ICV_BYPASS_ETYPE2_value = data_low and ICV_BYPASS_ETYPE2_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ICV_BYPASS_ETYPE2_value = &H0
        flag_ICV_BYPASS_ETYPE2        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_icv_debug
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DEBUG                                      [15:0]           get_DEBUG
''                                                             set_DEBUG
''                                                             read_DEBUG
''                                                             write_DEBUG
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_icv_debug
    Private write_DEBUG_value
    Private read_DEBUG_value
    Private flag_DEBUG

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1d6
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_DEBUG
        get_DEBUG = read_DEBUG_value
    End Property

    Property Let set_DEBUG(aData)
        write_DEBUG_value = aData
        flag_DEBUG        = &H1
    End Property

    Property Get read_DEBUG
        read
        read_DEBUG = read_DEBUG_value
    End Property

    Property Let write_DEBUG(aData)
        set_DEBUG = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DEBUG_mask = &Hffff
        if data_low > LONG_MAX then
            if DEBUG_mask = mask then
                read_DEBUG_value = data_low
            else
                read_DEBUG_value = (data_low - H8000_0000) and DEBUG_mask
            end If
        else
            read_DEBUG_value = data_low and DEBUG_mask
        end If

    End Sub

    Sub write
        If flag_DEBUG = &H0 Then read
        If flag_DEBUG = &H0 Then write_DEBUG_value = get_DEBUG

        regValue = leftShift((write_DEBUG_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DEBUG_mask = &Hffff
        if data_low > LONG_MAX then
            if DEBUG_mask = mask then
                read_DEBUG_value = data_low
            else
                read_DEBUG_value = (data_low - H8000_0000) and DEBUG_mask
            end If
        else
            read_DEBUG_value = data_low and DEBUG_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DEBUG_value = &H0
        flag_DEBUG        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_icv_cnter_rst1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' CNTER_RST                                  [15:0]           get_CNTER_RST
''                                                             set_CNTER_RST
''                                                             read_CNTER_RST
''                                                             write_CNTER_RST
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_icv_cnter_rst1
    Private write_CNTER_RST_value
    Private read_CNTER_RST_value
    Private flag_CNTER_RST

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1d8
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_CNTER_RST
        get_CNTER_RST = read_CNTER_RST_value
    End Property

    Property Let set_CNTER_RST(aData)
        write_CNTER_RST_value = aData
        flag_CNTER_RST        = &H1
    End Property

    Property Get read_CNTER_RST
        read
        read_CNTER_RST = read_CNTER_RST_value
    End Property

    Property Let write_CNTER_RST(aData)
        set_CNTER_RST = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        CNTER_RST_mask = &Hffff
        if data_low > LONG_MAX then
            if CNTER_RST_mask = mask then
                read_CNTER_RST_value = data_low
            else
                read_CNTER_RST_value = (data_low - H8000_0000) and CNTER_RST_mask
            end If
        else
            read_CNTER_RST_value = data_low and CNTER_RST_mask
        end If

    End Sub

    Sub write
        If flag_CNTER_RST = &H0 Then read
        If flag_CNTER_RST = &H0 Then write_CNTER_RST_value = get_CNTER_RST

        regValue = leftShift((write_CNTER_RST_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        CNTER_RST_mask = &Hffff
        if data_low > LONG_MAX then
            if CNTER_RST_mask = mask then
                read_CNTER_RST_value = data_low
            else
                read_CNTER_RST_value = (data_low - H8000_0000) and CNTER_RST_mask
            end If
        else
            read_CNTER_RST_value = data_low and CNTER_RST_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_CNTER_RST_value = &H0
        flag_CNTER_RST        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_icv_cnter_rst2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' CNTER_RST                                  [15:0]           get_CNTER_RST
''                                                             set_CNTER_RST
''                                                             read_CNTER_RST
''                                                             write_CNTER_RST
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_icv_cnter_rst2
    Private write_CNTER_RST_value
    Private read_CNTER_RST_value
    Private flag_CNTER_RST

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1da
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_CNTER_RST
        get_CNTER_RST = read_CNTER_RST_value
    End Property

    Property Let set_CNTER_RST(aData)
        write_CNTER_RST_value = aData
        flag_CNTER_RST        = &H1
    End Property

    Property Get read_CNTER_RST
        read
        read_CNTER_RST = read_CNTER_RST_value
    End Property

    Property Let write_CNTER_RST(aData)
        set_CNTER_RST = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        CNTER_RST_mask = &Hffff
        if data_low > LONG_MAX then
            if CNTER_RST_mask = mask then
                read_CNTER_RST_value = data_low
            else
                read_CNTER_RST_value = (data_low - H8000_0000) and CNTER_RST_mask
            end If
        else
            read_CNTER_RST_value = data_low and CNTER_RST_mask
        end If

    End Sub

    Sub write
        If flag_CNTER_RST = &H0 Then read
        If flag_CNTER_RST = &H0 Then write_CNTER_RST_value = get_CNTER_RST

        regValue = leftShift((write_CNTER_RST_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        CNTER_RST_mask = &Hffff
        if data_low > LONG_MAX then
            if CNTER_RST_mask = mask then
                read_CNTER_RST_value = data_low
            else
                read_CNTER_RST_value = (data_low - H8000_0000) and CNTER_RST_mask
            end If
        else
            read_CNTER_RST_value = data_low and CNTER_RST_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_CNTER_RST_value = &H0
        flag_CNTER_RST        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_icv_cnter_threshold
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' CNTER_TH                                   [15:0]           get_CNTER_TH
''                                                             set_CNTER_TH
''                                                             read_CNTER_TH
''                                                             write_CNTER_TH
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_icv_cnter_threshold
    Private write_CNTER_TH_value
    Private read_CNTER_TH_value
    Private flag_CNTER_TH

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1dc
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_CNTER_TH
        get_CNTER_TH = read_CNTER_TH_value
    End Property

    Property Let set_CNTER_TH(aData)
        write_CNTER_TH_value = aData
        flag_CNTER_TH        = &H1
    End Property

    Property Get read_CNTER_TH
        read
        read_CNTER_TH = read_CNTER_TH_value
    End Property

    Property Let write_CNTER_TH(aData)
        set_CNTER_TH = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        CNTER_TH_mask = &Hffff
        if data_low > LONG_MAX then
            if CNTER_TH_mask = mask then
                read_CNTER_TH_value = data_low
            else
                read_CNTER_TH_value = (data_low - H8000_0000) and CNTER_TH_mask
            end If
        else
            read_CNTER_TH_value = data_low and CNTER_TH_mask
        end If

    End Sub

    Sub write
        If flag_CNTER_TH = &H0 Then read
        If flag_CNTER_TH = &H0 Then write_CNTER_TH_value = get_CNTER_TH

        regValue = leftShift((write_CNTER_TH_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        CNTER_TH_mask = &Hffff
        if data_low > LONG_MAX then
            if CNTER_TH_mask = mask then
                read_CNTER_TH_value = data_low
            else
                read_CNTER_TH_value = (data_low - H8000_0000) and CNTER_TH_mask
            end If
        else
            read_CNTER_TH_value = data_low and CNTER_TH_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_CNTER_TH_value = &H0
        flag_CNTER_TH        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_icv_int
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ICV_CNTER_MASK                             [15:8]           get_ICV_CNTER_MASK
''                                                             set_ICV_CNTER_MASK
''                                                             read_ICV_CNTER_MASK
''                                                             write_ICV_CNTER_MASK
''---------------------------------------------------------------------------------
'' ICV_CNTER_STAT                             [7:0]            get_ICV_CNTER_STAT
''                                                             set_ICV_CNTER_STAT
''                                                             read_ICV_CNTER_STAT
''                                                             write_ICV_CNTER_STAT
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_icv_int
    Private write_ICV_CNTER_MASK_value
    Private read_ICV_CNTER_MASK_value
    Private flag_ICV_CNTER_MASK
    Private write_ICV_CNTER_STAT_value
    Private read_ICV_CNTER_STAT_value
    Private flag_ICV_CNTER_STAT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1de
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ICV_CNTER_MASK
        get_ICV_CNTER_MASK = read_ICV_CNTER_MASK_value
    End Property

    Property Let set_ICV_CNTER_MASK(aData)
        write_ICV_CNTER_MASK_value = aData
        flag_ICV_CNTER_MASK        = &H1
    End Property

    Property Get read_ICV_CNTER_MASK
        read
        read_ICV_CNTER_MASK = read_ICV_CNTER_MASK_value
    End Property

    Property Let write_ICV_CNTER_MASK(aData)
        set_ICV_CNTER_MASK = aData
        write
    End Property

    Property Get get_ICV_CNTER_STAT
        get_ICV_CNTER_STAT = read_ICV_CNTER_STAT_value
    End Property

    Property Let set_ICV_CNTER_STAT(aData)
        write_ICV_CNTER_STAT_value = aData
        flag_ICV_CNTER_STAT        = &H1
    End Property

    Property Get read_ICV_CNTER_STAT
        read
        read_ICV_CNTER_STAT = read_ICV_CNTER_STAT_value
    End Property

    Property Let write_ICV_CNTER_STAT(aData)
        set_ICV_CNTER_STAT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ICV_CNTER_MASK_value = rightShift(data_low, 8) and &Hff
        ICV_CNTER_STAT_mask = &Hff
        if data_low > LONG_MAX then
            if ICV_CNTER_STAT_mask = mask then
                read_ICV_CNTER_STAT_value = data_low
            else
                read_ICV_CNTER_STAT_value = (data_low - H8000_0000) and ICV_CNTER_STAT_mask
            end If
        else
            read_ICV_CNTER_STAT_value = data_low and ICV_CNTER_STAT_mask
        end If

    End Sub

    Sub write
        If flag_ICV_CNTER_MASK = &H0 or flag_ICV_CNTER_STAT = &H0 Then read
        If flag_ICV_CNTER_MASK = &H0 Then write_ICV_CNTER_MASK_value = get_ICV_CNTER_MASK
        If flag_ICV_CNTER_STAT = &H0 Then write_ICV_CNTER_STAT_value = get_ICV_CNTER_STAT

        regValue = leftShift((write_ICV_CNTER_MASK_value and &Hff), 8) + leftShift((write_ICV_CNTER_STAT_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ICV_CNTER_MASK_value = rightShift(data_low, 8) and &Hff
        ICV_CNTER_STAT_mask = &Hff
        if data_low > LONG_MAX then
            if ICV_CNTER_STAT_mask = mask then
                read_ICV_CNTER_STAT_value = data_low
            else
                read_ICV_CNTER_STAT_value = (data_low - H8000_0000) and ICV_CNTER_STAT_mask
            end If
        else
            read_ICV_CNTER_STAT_value = data_low and ICV_CNTER_STAT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ICV_CNTER_MASK_value = &H0
        flag_ICV_CNTER_MASK        = &H0
        write_ICV_CNTER_STAT_value = &H0
        flag_ICV_CNTER_STAT        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_icv_debug_sel
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ICV_DEBUG_SEL                              [15:0]           get_ICV_DEBUG_SEL
''                                                             set_ICV_DEBUG_SEL
''                                                             read_ICV_DEBUG_SEL
''                                                             write_ICV_DEBUG_SEL
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_icv_debug_sel
    Private write_ICV_DEBUG_SEL_value
    Private read_ICV_DEBUG_SEL_value
    Private flag_ICV_DEBUG_SEL

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1e0
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ICV_DEBUG_SEL
        get_ICV_DEBUG_SEL = read_ICV_DEBUG_SEL_value
    End Property

    Property Let set_ICV_DEBUG_SEL(aData)
        write_ICV_DEBUG_SEL_value = aData
        flag_ICV_DEBUG_SEL        = &H1
    End Property

    Property Get read_ICV_DEBUG_SEL
        read
        read_ICV_DEBUG_SEL = read_ICV_DEBUG_SEL_value
    End Property

    Property Let write_ICV_DEBUG_SEL(aData)
        set_ICV_DEBUG_SEL = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ICV_DEBUG_SEL_mask = &Hffff
        if data_low > LONG_MAX then
            if ICV_DEBUG_SEL_mask = mask then
                read_ICV_DEBUG_SEL_value = data_low
            else
                read_ICV_DEBUG_SEL_value = (data_low - H8000_0000) and ICV_DEBUG_SEL_mask
            end If
        else
            read_ICV_DEBUG_SEL_value = data_low and ICV_DEBUG_SEL_mask
        end If

    End Sub

    Sub write
        If flag_ICV_DEBUG_SEL = &H0 Then read
        If flag_ICV_DEBUG_SEL = &H0 Then write_ICV_DEBUG_SEL_value = get_ICV_DEBUG_SEL

        regValue = leftShift((write_ICV_DEBUG_SEL_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ICV_DEBUG_SEL_mask = &Hffff
        if data_low > LONG_MAX then
            if ICV_DEBUG_SEL_mask = mask then
                read_ICV_DEBUG_SEL_value = data_low
            else
                read_ICV_DEBUG_SEL_value = (data_low - H8000_0000) and ICV_DEBUG_SEL_mask
            end If
        else
            read_ICV_DEBUG_SEL_value = data_low and ICV_DEBUG_SEL_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ICV_DEBUG_SEL_value = &H0
        flag_ICV_DEBUG_SEL        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_icv_debug1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ICV_DEBUG1                                 [15:0]           get_ICV_DEBUG1
''                                                             set_ICV_DEBUG1
''                                                             read_ICV_DEBUG1
''                                                             write_ICV_DEBUG1
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_icv_debug1
    Private write_ICV_DEBUG1_value
    Private read_ICV_DEBUG1_value
    Private flag_ICV_DEBUG1

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1e2
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ICV_DEBUG1
        get_ICV_DEBUG1 = read_ICV_DEBUG1_value
    End Property

    Property Let set_ICV_DEBUG1(aData)
        write_ICV_DEBUG1_value = aData
        flag_ICV_DEBUG1        = &H1
    End Property

    Property Get read_ICV_DEBUG1
        read
        read_ICV_DEBUG1 = read_ICV_DEBUG1_value
    End Property

    Property Let write_ICV_DEBUG1(aData)
        set_ICV_DEBUG1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ICV_DEBUG1_mask = &Hffff
        if data_low > LONG_MAX then
            if ICV_DEBUG1_mask = mask then
                read_ICV_DEBUG1_value = data_low
            else
                read_ICV_DEBUG1_value = (data_low - H8000_0000) and ICV_DEBUG1_mask
            end If
        else
            read_ICV_DEBUG1_value = data_low and ICV_DEBUG1_mask
        end If

    End Sub

    Sub write
        If flag_ICV_DEBUG1 = &H0 Then read
        If flag_ICV_DEBUG1 = &H0 Then write_ICV_DEBUG1_value = get_ICV_DEBUG1

        regValue = leftShift((write_ICV_DEBUG1_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ICV_DEBUG1_mask = &Hffff
        if data_low > LONG_MAX then
            if ICV_DEBUG1_mask = mask then
                read_ICV_DEBUG1_value = data_low
            else
                read_ICV_DEBUG1_value = (data_low - H8000_0000) and ICV_DEBUG1_mask
            end If
        else
            read_ICV_DEBUG1_value = data_low and ICV_DEBUG1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ICV_DEBUG1_value = &H0
        flag_ICV_DEBUG1        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_icv_debug2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ICV_DEBUG2                                 [15:0]           get_ICV_DEBUG2
''                                                             set_ICV_DEBUG2
''                                                             read_ICV_DEBUG2
''                                                             write_ICV_DEBUG2
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_icv_debug2
    Private write_ICV_DEBUG2_value
    Private read_ICV_DEBUG2_value
    Private flag_ICV_DEBUG2

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1e4
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ICV_DEBUG2
        get_ICV_DEBUG2 = read_ICV_DEBUG2_value
    End Property

    Property Let set_ICV_DEBUG2(aData)
        write_ICV_DEBUG2_value = aData
        flag_ICV_DEBUG2        = &H1
    End Property

    Property Get read_ICV_DEBUG2
        read
        read_ICV_DEBUG2 = read_ICV_DEBUG2_value
    End Property

    Property Let write_ICV_DEBUG2(aData)
        set_ICV_DEBUG2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ICV_DEBUG2_mask = &Hffff
        if data_low > LONG_MAX then
            if ICV_DEBUG2_mask = mask then
                read_ICV_DEBUG2_value = data_low
            else
                read_ICV_DEBUG2_value = (data_low - H8000_0000) and ICV_DEBUG2_mask
            end If
        else
            read_ICV_DEBUG2_value = data_low and ICV_DEBUG2_mask
        end If

    End Sub

    Sub write
        If flag_ICV_DEBUG2 = &H0 Then read
        If flag_ICV_DEBUG2 = &H0 Then write_ICV_DEBUG2_value = get_ICV_DEBUG2

        regValue = leftShift((write_ICV_DEBUG2_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ICV_DEBUG2_mask = &Hffff
        if data_low > LONG_MAX then
            if ICV_DEBUG2_mask = mask then
                read_ICV_DEBUG2_value = data_low
            else
                read_ICV_DEBUG2_value = (data_low - H8000_0000) and ICV_DEBUG2_mask
            end If
        else
            read_ICV_DEBUG2_value = data_low and ICV_DEBUG2_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ICV_DEBUG2_value = &H0
        flag_ICV_DEBUG2        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_icv_debug3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ICV_DEBUG3                                 [15:0]           get_ICV_DEBUG3
''                                                             set_ICV_DEBUG3
''                                                             read_ICV_DEBUG3
''                                                             write_ICV_DEBUG3
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_icv_debug3
    Private write_ICV_DEBUG3_value
    Private read_ICV_DEBUG3_value
    Private flag_ICV_DEBUG3

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1e6
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ICV_DEBUG3
        get_ICV_DEBUG3 = read_ICV_DEBUG3_value
    End Property

    Property Let set_ICV_DEBUG3(aData)
        write_ICV_DEBUG3_value = aData
        flag_ICV_DEBUG3        = &H1
    End Property

    Property Get read_ICV_DEBUG3
        read
        read_ICV_DEBUG3 = read_ICV_DEBUG3_value
    End Property

    Property Let write_ICV_DEBUG3(aData)
        set_ICV_DEBUG3 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ICV_DEBUG3_mask = &Hffff
        if data_low > LONG_MAX then
            if ICV_DEBUG3_mask = mask then
                read_ICV_DEBUG3_value = data_low
            else
                read_ICV_DEBUG3_value = (data_low - H8000_0000) and ICV_DEBUG3_mask
            end If
        else
            read_ICV_DEBUG3_value = data_low and ICV_DEBUG3_mask
        end If

    End Sub

    Sub write
        If flag_ICV_DEBUG3 = &H0 Then read
        If flag_ICV_DEBUG3 = &H0 Then write_ICV_DEBUG3_value = get_ICV_DEBUG3

        regValue = leftShift((write_ICV_DEBUG3_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ICV_DEBUG3_mask = &Hffff
        if data_low > LONG_MAX then
            if ICV_DEBUG3_mask = mask then
                read_ICV_DEBUG3_value = data_low
            else
                read_ICV_DEBUG3_value = (data_low - H8000_0000) and ICV_DEBUG3_mask
            end If
        else
            read_ICV_DEBUG3_value = data_low and ICV_DEBUG3_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ICV_DEBUG3_value = &H0
        flag_ICV_DEBUG3        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_icv_debug4
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ICV_DEBUG4                                 [15:0]           get_ICV_DEBUG4
''                                                             set_ICV_DEBUG4
''                                                             read_ICV_DEBUG4
''                                                             write_ICV_DEBUG4
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_icv_debug4
    Private write_ICV_DEBUG4_value
    Private read_ICV_DEBUG4_value
    Private flag_ICV_DEBUG4

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1e8
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ICV_DEBUG4
        get_ICV_DEBUG4 = read_ICV_DEBUG4_value
    End Property

    Property Let set_ICV_DEBUG4(aData)
        write_ICV_DEBUG4_value = aData
        flag_ICV_DEBUG4        = &H1
    End Property

    Property Get read_ICV_DEBUG4
        read
        read_ICV_DEBUG4 = read_ICV_DEBUG4_value
    End Property

    Property Let write_ICV_DEBUG4(aData)
        set_ICV_DEBUG4 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ICV_DEBUG4_mask = &Hffff
        if data_low > LONG_MAX then
            if ICV_DEBUG4_mask = mask then
                read_ICV_DEBUG4_value = data_low
            else
                read_ICV_DEBUG4_value = (data_low - H8000_0000) and ICV_DEBUG4_mask
            end If
        else
            read_ICV_DEBUG4_value = data_low and ICV_DEBUG4_mask
        end If

    End Sub

    Sub write
        If flag_ICV_DEBUG4 = &H0 Then read
        If flag_ICV_DEBUG4 = &H0 Then write_ICV_DEBUG4_value = get_ICV_DEBUG4

        regValue = leftShift((write_ICV_DEBUG4_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ICV_DEBUG4_mask = &Hffff
        if data_low > LONG_MAX then
            if ICV_DEBUG4_mask = mask then
                read_ICV_DEBUG4_value = data_low
            else
                read_ICV_DEBUG4_value = (data_low - H8000_0000) and ICV_DEBUG4_mask
            end If
        else
            read_ICV_DEBUG4_value = data_low and ICV_DEBUG4_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ICV_DEBUG4_value = &H0
        flag_ICV_DEBUG4        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_icv_learn
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ICV_LEARN                                  [15:0]           get_ICV_LEARN
''                                                             set_ICV_LEARN
''                                                             read_ICV_LEARN
''                                                             write_ICV_LEARN
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_icv_learn
    Private write_ICV_LEARN_value
    Private read_ICV_LEARN_value
    Private flag_ICV_LEARN

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1ea
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ICV_LEARN
        get_ICV_LEARN = read_ICV_LEARN_value
    End Property

    Property Let set_ICV_LEARN(aData)
        write_ICV_LEARN_value = aData
        flag_ICV_LEARN        = &H1
    End Property

    Property Get read_ICV_LEARN
        read
        read_ICV_LEARN = read_ICV_LEARN_value
    End Property

    Property Let write_ICV_LEARN(aData)
        set_ICV_LEARN = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ICV_LEARN_mask = &Hffff
        if data_low > LONG_MAX then
            if ICV_LEARN_mask = mask then
                read_ICV_LEARN_value = data_low
            else
                read_ICV_LEARN_value = (data_low - H8000_0000) and ICV_LEARN_mask
            end If
        else
            read_ICV_LEARN_value = data_low and ICV_LEARN_mask
        end If

    End Sub

    Sub write
        If flag_ICV_LEARN = &H0 Then read
        If flag_ICV_LEARN = &H0 Then write_ICV_LEARN_value = get_ICV_LEARN

        regValue = leftShift((write_ICV_LEARN_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ICV_LEARN_mask = &Hffff
        if data_low > LONG_MAX then
            if ICV_LEARN_mask = mask then
                read_ICV_LEARN_value = data_low
            else
                read_ICV_LEARN_value = (data_low - H8000_0000) and ICV_LEARN_mask
            end If
        else
            read_ICV_LEARN_value = data_low and ICV_LEARN_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ICV_LEARN_value = &H0
        flag_ICV_LEARN        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_icv_learn_int
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PKT_LEARN_TIMEOUT_MASK                     [15:8]           get_PKT_LEARN_TIMEOUT_MASK
''                                                             set_PKT_LEARN_TIMEOUT_MASK
''                                                             read_PKT_LEARN_TIMEOUT_MASK
''                                                             write_PKT_LEARN_TIMEOUT_MASK
''---------------------------------------------------------------------------------
'' PKT_LEARN_TIMEOUT_STAT                     [7:0]            get_PKT_LEARN_TIMEOUT_STAT
''                                                             set_PKT_LEARN_TIMEOUT_STAT
''                                                             read_PKT_LEARN_TIMEOUT_STAT
''                                                             write_PKT_LEARN_TIMEOUT_STAT
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_icv_learn_int
    Private write_PKT_LEARN_TIMEOUT_MASK_value
    Private read_PKT_LEARN_TIMEOUT_MASK_value
    Private flag_PKT_LEARN_TIMEOUT_MASK
    Private write_PKT_LEARN_TIMEOUT_STAT_value
    Private read_PKT_LEARN_TIMEOUT_STAT_value
    Private flag_PKT_LEARN_TIMEOUT_STAT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1ec
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_PKT_LEARN_TIMEOUT_MASK
        get_PKT_LEARN_TIMEOUT_MASK = read_PKT_LEARN_TIMEOUT_MASK_value
    End Property

    Property Let set_PKT_LEARN_TIMEOUT_MASK(aData)
        write_PKT_LEARN_TIMEOUT_MASK_value = aData
        flag_PKT_LEARN_TIMEOUT_MASK        = &H1
    End Property

    Property Get read_PKT_LEARN_TIMEOUT_MASK
        read
        read_PKT_LEARN_TIMEOUT_MASK = read_PKT_LEARN_TIMEOUT_MASK_value
    End Property

    Property Let write_PKT_LEARN_TIMEOUT_MASK(aData)
        set_PKT_LEARN_TIMEOUT_MASK = aData
        write
    End Property

    Property Get get_PKT_LEARN_TIMEOUT_STAT
        get_PKT_LEARN_TIMEOUT_STAT = read_PKT_LEARN_TIMEOUT_STAT_value
    End Property

    Property Let set_PKT_LEARN_TIMEOUT_STAT(aData)
        write_PKT_LEARN_TIMEOUT_STAT_value = aData
        flag_PKT_LEARN_TIMEOUT_STAT        = &H1
    End Property

    Property Get read_PKT_LEARN_TIMEOUT_STAT
        read
        read_PKT_LEARN_TIMEOUT_STAT = read_PKT_LEARN_TIMEOUT_STAT_value
    End Property

    Property Let write_PKT_LEARN_TIMEOUT_STAT(aData)
        set_PKT_LEARN_TIMEOUT_STAT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_PKT_LEARN_TIMEOUT_MASK_value = rightShift(data_low, 8) and &Hff
        PKT_LEARN_TIMEOUT_STAT_mask = &Hff
        if data_low > LONG_MAX then
            if PKT_LEARN_TIMEOUT_STAT_mask = mask then
                read_PKT_LEARN_TIMEOUT_STAT_value = data_low
            else
                read_PKT_LEARN_TIMEOUT_STAT_value = (data_low - H8000_0000) and PKT_LEARN_TIMEOUT_STAT_mask
            end If
        else
            read_PKT_LEARN_TIMEOUT_STAT_value = data_low and PKT_LEARN_TIMEOUT_STAT_mask
        end If

    End Sub

    Sub write
        If flag_PKT_LEARN_TIMEOUT_MASK = &H0 or flag_PKT_LEARN_TIMEOUT_STAT = &H0 Then read
        If flag_PKT_LEARN_TIMEOUT_MASK = &H0 Then write_PKT_LEARN_TIMEOUT_MASK_value = get_PKT_LEARN_TIMEOUT_MASK
        If flag_PKT_LEARN_TIMEOUT_STAT = &H0 Then write_PKT_LEARN_TIMEOUT_STAT_value = get_PKT_LEARN_TIMEOUT_STAT

        regValue = leftShift((write_PKT_LEARN_TIMEOUT_MASK_value and &Hff), 8) + leftShift((write_PKT_LEARN_TIMEOUT_STAT_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_PKT_LEARN_TIMEOUT_MASK_value = rightShift(data_low, 8) and &Hff
        PKT_LEARN_TIMEOUT_STAT_mask = &Hff
        if data_low > LONG_MAX then
            if PKT_LEARN_TIMEOUT_STAT_mask = mask then
                read_PKT_LEARN_TIMEOUT_STAT_value = data_low
            else
                read_PKT_LEARN_TIMEOUT_STAT_value = (data_low - H8000_0000) and PKT_LEARN_TIMEOUT_STAT_mask
            end If
        else
            read_PKT_LEARN_TIMEOUT_STAT_value = data_low and PKT_LEARN_TIMEOUT_STAT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PKT_LEARN_TIMEOUT_MASK_value = &H0
        flag_PKT_LEARN_TIMEOUT_MASK        = &H0
        write_PKT_LEARN_TIMEOUT_STAT_value = &H0
        flag_PKT_LEARN_TIMEOUT_STAT        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_icv_spare8
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SPARE                                      [15:0]           get_SPARE
''                                                             set_SPARE
''                                                             read_SPARE
''                                                             write_SPARE
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_icv_spare8
    Private write_SPARE_value
    Private read_SPARE_value
    Private flag_SPARE

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1ee
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_SPARE
        get_SPARE = read_SPARE_value
    End Property

    Property Let set_SPARE(aData)
        write_SPARE_value = aData
        flag_SPARE        = &H1
    End Property

    Property Get read_SPARE
        read
        read_SPARE = read_SPARE_value
    End Property

    Property Let write_SPARE(aData)
        set_SPARE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SPARE_mask = &Hffff
        if data_low > LONG_MAX then
            if SPARE_mask = mask then
                read_SPARE_value = data_low
            else
                read_SPARE_value = (data_low - H8000_0000) and SPARE_mask
            end If
        else
            read_SPARE_value = data_low and SPARE_mask
        end If

    End Sub

    Sub write
        If flag_SPARE = &H0 Then read
        If flag_SPARE = &H0 Then write_SPARE_value = get_SPARE

        regValue = leftShift((write_SPARE_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SPARE_mask = &Hffff
        if data_low > LONG_MAX then
            if SPARE_mask = mask then
                read_SPARE_value = data_low
            else
                read_SPARE_value = (data_low - H8000_0000) and SPARE_mask
            end If
        else
            read_SPARE_value = data_low and SPARE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SPARE_value = &H0
        flag_SPARE        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_icv_spare9
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SPARE                                      [15:0]           get_SPARE
''                                                             set_SPARE
''                                                             read_SPARE
''                                                             write_SPARE
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_icv_spare9
    Private write_SPARE_value
    Private read_SPARE_value
    Private flag_SPARE

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1f0
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_SPARE
        get_SPARE = read_SPARE_value
    End Property

    Property Let set_SPARE(aData)
        write_SPARE_value = aData
        flag_SPARE        = &H1
    End Property

    Property Get read_SPARE
        read
        read_SPARE = read_SPARE_value
    End Property

    Property Let write_SPARE(aData)
        set_SPARE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SPARE_mask = &Hffff
        if data_low > LONG_MAX then
            if SPARE_mask = mask then
                read_SPARE_value = data_low
            else
                read_SPARE_value = (data_low - H8000_0000) and SPARE_mask
            end If
        else
            read_SPARE_value = data_low and SPARE_mask
        end If

    End Sub

    Sub write
        If flag_SPARE = &H0 Then read
        If flag_SPARE = &H0 Then write_SPARE_value = get_SPARE

        regValue = leftShift((write_SPARE_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SPARE_mask = &Hffff
        if data_low > LONG_MAX then
            if SPARE_mask = mask then
                read_SPARE_value = data_low
            else
                read_SPARE_value = (data_low - H8000_0000) and SPARE_mask
            end If
        else
            read_SPARE_value = data_low and SPARE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SPARE_value = &H0
        flag_SPARE        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_icv_spare10
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SPARE                                      [15:0]           get_SPARE
''                                                             set_SPARE
''                                                             read_SPARE
''                                                             write_SPARE
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_icv_spare10
    Private write_SPARE_value
    Private read_SPARE_value
    Private flag_SPARE

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1f2
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_SPARE
        get_SPARE = read_SPARE_value
    End Property

    Property Let set_SPARE(aData)
        write_SPARE_value = aData
        flag_SPARE        = &H1
    End Property

    Property Get read_SPARE
        read
        read_SPARE = read_SPARE_value
    End Property

    Property Let write_SPARE(aData)
        set_SPARE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SPARE_mask = &Hffff
        if data_low > LONG_MAX then
            if SPARE_mask = mask then
                read_SPARE_value = data_low
            else
                read_SPARE_value = (data_low - H8000_0000) and SPARE_mask
            end If
        else
            read_SPARE_value = data_low and SPARE_mask
        end If

    End Sub

    Sub write
        If flag_SPARE = &H0 Then read
        If flag_SPARE = &H0 Then write_SPARE_value = get_SPARE

        regValue = leftShift((write_SPARE_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SPARE_mask = &Hffff
        if data_low > LONG_MAX then
            if SPARE_mask = mask then
                read_SPARE_value = data_low
            else
                read_SPARE_value = (data_low - H8000_0000) and SPARE_mask
            end If
        else
            read_SPARE_value = data_low and SPARE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SPARE_value = &H0
        flag_SPARE        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_icv_spare11
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SPARE                                      [15:0]           get_SPARE
''                                                             set_SPARE
''                                                             read_SPARE
''                                                             write_SPARE
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_icv_spare11
    Private write_SPARE_value
    Private read_SPARE_value
    Private flag_SPARE

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1f4
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_SPARE
        get_SPARE = read_SPARE_value
    End Property

    Property Let set_SPARE(aData)
        write_SPARE_value = aData
        flag_SPARE        = &H1
    End Property

    Property Get read_SPARE
        read
        read_SPARE = read_SPARE_value
    End Property

    Property Let write_SPARE(aData)
        set_SPARE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SPARE_mask = &Hffff
        if data_low > LONG_MAX then
            if SPARE_mask = mask then
                read_SPARE_value = data_low
            else
                read_SPARE_value = (data_low - H8000_0000) and SPARE_mask
            end If
        else
            read_SPARE_value = data_low and SPARE_mask
        end If

    End Sub

    Sub write
        If flag_SPARE = &H0 Then read
        If flag_SPARE = &H0 Then write_SPARE_value = get_SPARE

        regValue = leftShift((write_SPARE_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SPARE_mask = &Hffff
        if data_low > LONG_MAX then
            if SPARE_mask = mask then
                read_SPARE_value = data_low
            else
                read_SPARE_value = (data_low - H8000_0000) and SPARE_mask
            end If
        else
            read_SPARE_value = data_low and SPARE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SPARE_value = &H0
        flag_SPARE        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_icv_spare12
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SPARE                                      [15:0]           get_SPARE
''                                                             set_SPARE
''                                                             read_SPARE
''                                                             write_SPARE
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_icv_spare12
    Private write_SPARE_value
    Private read_SPARE_value
    Private flag_SPARE

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1f6
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_SPARE
        get_SPARE = read_SPARE_value
    End Property

    Property Let set_SPARE(aData)
        write_SPARE_value = aData
        flag_SPARE        = &H1
    End Property

    Property Get read_SPARE
        read
        read_SPARE = read_SPARE_value
    End Property

    Property Let write_SPARE(aData)
        set_SPARE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SPARE_mask = &Hffff
        if data_low > LONG_MAX then
            if SPARE_mask = mask then
                read_SPARE_value = data_low
            else
                read_SPARE_value = (data_low - H8000_0000) and SPARE_mask
            end If
        else
            read_SPARE_value = data_low and SPARE_mask
        end If

    End Sub

    Sub write
        If flag_SPARE = &H0 Then read
        If flag_SPARE = &H0 Then write_SPARE_value = get_SPARE

        regValue = leftShift((write_SPARE_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SPARE_mask = &Hffff
        if data_low > LONG_MAX then
            if SPARE_mask = mask then
                read_SPARE_value = data_low
            else
                read_SPARE_value = (data_low - H8000_0000) and SPARE_mask
            end If
        else
            read_SPARE_value = data_low and SPARE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SPARE_value = &H0
        flag_SPARE        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_icv_spare13
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SPARE                                      [15:0]           get_SPARE
''                                                             set_SPARE
''                                                             read_SPARE
''                                                             write_SPARE
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_icv_spare13
    Private write_SPARE_value
    Private read_SPARE_value
    Private flag_SPARE

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1f8
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_SPARE
        get_SPARE = read_SPARE_value
    End Property

    Property Let set_SPARE(aData)
        write_SPARE_value = aData
        flag_SPARE        = &H1
    End Property

    Property Get read_SPARE
        read
        read_SPARE = read_SPARE_value
    End Property

    Property Let write_SPARE(aData)
        set_SPARE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SPARE_mask = &Hffff
        if data_low > LONG_MAX then
            if SPARE_mask = mask then
                read_SPARE_value = data_low
            else
                read_SPARE_value = (data_low - H8000_0000) and SPARE_mask
            end If
        else
            read_SPARE_value = data_low and SPARE_mask
        end If

    End Sub

    Sub write
        If flag_SPARE = &H0 Then read
        If flag_SPARE = &H0 Then write_SPARE_value = get_SPARE

        regValue = leftShift((write_SPARE_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SPARE_mask = &Hffff
        if data_low > LONG_MAX then
            if SPARE_mask = mask then
                read_SPARE_value = data_low
            else
                read_SPARE_value = (data_low - H8000_0000) and SPARE_mask
            end If
        else
            read_SPARE_value = data_low and SPARE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SPARE_value = &H0
        flag_SPARE        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_icv_spare14
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SPARE                                      [15:0]           get_SPARE
''                                                             set_SPARE
''                                                             read_SPARE
''                                                             write_SPARE
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_icv_spare14
    Private write_SPARE_value
    Private read_SPARE_value
    Private flag_SPARE

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1fa
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_SPARE
        get_SPARE = read_SPARE_value
    End Property

    Property Let set_SPARE(aData)
        write_SPARE_value = aData
        flag_SPARE        = &H1
    End Property

    Property Get read_SPARE
        read
        read_SPARE = read_SPARE_value
    End Property

    Property Let write_SPARE(aData)
        set_SPARE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SPARE_mask = &Hffff
        if data_low > LONG_MAX then
            if SPARE_mask = mask then
                read_SPARE_value = data_low
            else
                read_SPARE_value = (data_low - H8000_0000) and SPARE_mask
            end If
        else
            read_SPARE_value = data_low and SPARE_mask
        end If

    End Sub

    Sub write
        If flag_SPARE = &H0 Then read
        If flag_SPARE = &H0 Then write_SPARE_value = get_SPARE

        regValue = leftShift((write_SPARE_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SPARE_mask = &Hffff
        if data_low > LONG_MAX then
            if SPARE_mask = mask then
                read_SPARE_value = data_low
            else
                read_SPARE_value = (data_low - H8000_0000) and SPARE_mask
            end If
        else
            read_SPARE_value = data_low and SPARE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SPARE_value = &H0
        flag_SPARE        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_icv_spare15
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SPARE                                      [15:0]           get_SPARE
''                                                             set_SPARE
''                                                             read_SPARE
''                                                             write_SPARE
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_icv_spare15
    Private write_SPARE_value
    Private read_SPARE_value
    Private flag_SPARE

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1fc
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_SPARE
        get_SPARE = read_SPARE_value
    End Property

    Property Let set_SPARE(aData)
        write_SPARE_value = aData
        flag_SPARE        = &H1
    End Property

    Property Get read_SPARE
        read
        read_SPARE = read_SPARE_value
    End Property

    Property Let write_SPARE(aData)
        set_SPARE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SPARE_mask = &Hffff
        if data_low > LONG_MAX then
            if SPARE_mask = mask then
                read_SPARE_value = data_low
            else
                read_SPARE_value = (data_low - H8000_0000) and SPARE_mask
            end If
        else
            read_SPARE_value = data_low and SPARE_mask
        end If

    End Sub

    Sub write
        If flag_SPARE = &H0 Then read
        If flag_SPARE = &H0 Then write_SPARE_value = get_SPARE

        regValue = leftShift((write_SPARE_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SPARE_mask = &Hffff
        if data_low > LONG_MAX then
            if SPARE_mask = mask then
                read_SPARE_value = data_low
            else
                read_SPARE_value = (data_low - H8000_0000) and SPARE_mask
            end If
        else
            read_SPARE_value = data_low and SPARE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SPARE_value = &H0
        flag_SPARE        = &H0
    End Sub
End Class


'' @REGISTER : P1588_8P_ICV_icv_spare16
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SPARE                                      [15:0]           get_SPARE
''                                                             set_SPARE
''                                                             read_SPARE
''                                                             write_SPARE
''---------------------------------------------------------------------------------
Class REGISTER_P1588_8P_ICV_icv_spare16
    Private write_SPARE_value
    Private read_SPARE_value
    Private flag_SPARE

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1fe
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_SPARE
        get_SPARE = read_SPARE_value
    End Property

    Property Let set_SPARE(aData)
        write_SPARE_value = aData
        flag_SPARE        = &H1
    End Property

    Property Get read_SPARE
        read
        read_SPARE = read_SPARE_value
    End Property

    Property Let write_SPARE(aData)
        set_SPARE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SPARE_mask = &Hffff
        if data_low > LONG_MAX then
            if SPARE_mask = mask then
                read_SPARE_value = data_low
            else
                read_SPARE_value = (data_low - H8000_0000) and SPARE_mask
            end If
        else
            read_SPARE_value = data_low and SPARE_mask
        end If

    End Sub

    Sub write
        If flag_SPARE = &H0 Then read
        If flag_SPARE = &H0 Then write_SPARE_value = get_SPARE

        regValue = leftShift((write_SPARE_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SPARE_mask = &Hffff
        if data_low > LONG_MAX then
            if SPARE_mask = mask then
                read_SPARE_value = data_low
            else
                read_SPARE_value = (data_low - H8000_0000) and SPARE_mask
            end If
        else
            read_SPARE_value = data_low and SPARE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SPARE_value = &H0
        flag_SPARE        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class P1588_8P_ICV_INSTANCE

    Public icv_tx_cntl_p0
    Public icv_tx_cntl_p1
    Public icv_tx_cntl_p2
    Public icv_tx_cntl_p3
    Public icv_tx_cntl_p4
    Public icv_tx_cntl_p5
    Public icv_rx_cntl_p0
    Public icv_rx_cntl_p1
    Public icv_rx_cntl_p2
    Public icv_rx_cntl_p3
    Public icv_rx_cntl_p4
    Public icv_rx_cntl_p5
    Public local_icv_id0_p0
    Public local_icv_id0_p1
    Public local_icv_id0_p2
    Public local_icv_id0_p3
    Public local_icv_id0_p4
    Public local_icv_id0_p5
    Public local_icv_id1_p0
    Public local_icv_id1_p1
    Public local_icv_id1_p2
    Public local_icv_id1_p3
    Public local_icv_id1_p4
    Public local_icv_id1_p5
    Public local_icv_id2_p0
    Public local_icv_id2_p1
    Public local_icv_id2_p2
    Public local_icv_id2_p3
    Public local_icv_id2_p4
    Public local_icv_id2_p5
    Public local_icv_id3_p0
    Public local_icv_id3_p1
    Public local_icv_id3_p2
    Public local_icv_id3_p3
    Public local_icv_id3_p4
    Public local_icv_id3_p5
    Public remote_icv_id0_p0
    Public remote_icv_id0_p1
    Public remote_icv_id0_p2
    Public remote_icv_id0_p3
    Public remote_icv_id0_p4
    Public remote_icv_id0_p5
    Public remote_icv_id1_p0
    Public remote_icv_id1_p1
    Public remote_icv_id1_p2
    Public remote_icv_id1_p3
    Public remote_icv_id1_p4
    Public remote_icv_id1_p5
    Public remote_icv_id2_p0
    Public remote_icv_id2_p1
    Public remote_icv_id2_p2
    Public remote_icv_id2_p3
    Public remote_icv_id2_p4
    Public remote_icv_id2_p5
    Public remote_icv_id3_p0
    Public remote_icv_id3_p1
    Public remote_icv_id3_p2
    Public remote_icv_id3_p3
    Public remote_icv_id3_p4
    Public remote_icv_id3_p5
    Public local_icv_id_ipad0_p0
    Public local_icv_id_ipad0_p1
    Public local_icv_id_ipad0_p2
    Public local_icv_id_ipad0_p3
    Public local_icv_id_ipad0_p4
    Public local_icv_id_ipad0_p5
    Public local_icv_id_ipad1_p0
    Public local_icv_id_ipad1_p1
    Public local_icv_id_ipad1_p2
    Public local_icv_id_ipad1_p3
    Public local_icv_id_ipad1_p4
    Public local_icv_id_ipad1_p5
    Public local_icv_id_ipad2_p0
    Public local_icv_id_ipad2_p1
    Public local_icv_id_ipad2_p2
    Public local_icv_id_ipad2_p3
    Public local_icv_id_ipad2_p4
    Public local_icv_id_ipad2_p5
    Public local_icv_id_ipad3_p0
    Public local_icv_id_ipad3_p1
    Public local_icv_id_ipad3_p2
    Public local_icv_id_ipad3_p3
    Public local_icv_id_ipad3_p4
    Public local_icv_id_ipad3_p5
    Public remote_icv_id_ipad0_p0
    Public remote_icv_id_ipad0_p1
    Public remote_icv_id_ipad0_p2
    Public remote_icv_id_ipad0_p3
    Public remote_icv_id_ipad0_p4
    Public remote_icv_id_ipad0_p5
    Public remote_icv_id_ipad1_p0
    Public remote_icv_id_ipad1_p1
    Public remote_icv_id_ipad1_p2
    Public remote_icv_id_ipad1_p3
    Public remote_icv_id_ipad1_p4
    Public remote_icv_id_ipad1_p5
    Public remote_icv_id_ipad2_p0
    Public remote_icv_id_ipad2_p1
    Public remote_icv_id_ipad2_p2
    Public remote_icv_id_ipad2_p3
    Public remote_icv_id_ipad2_p4
    Public remote_icv_id_ipad2_p5
    Public remote_icv_id_ipad3_p0
    Public remote_icv_id_ipad3_p1
    Public remote_icv_id_ipad3_p2
    Public remote_icv_id_ipad3_p3
    Public remote_icv_id_ipad3_p4
    Public remote_icv_id_ipad3_p5
    Public local_icv_id_opad0_p0
    Public local_icv_id_opad0_p1
    Public local_icv_id_opad0_p2
    Public local_icv_id_opad0_p3
    Public local_icv_id_opad0_p4
    Public local_icv_id_opad0_p5
    Public local_icv_id_opad1_p0
    Public local_icv_id_opad1_p1
    Public local_icv_id_opad1_p2
    Public local_icv_id_opad1_p3
    Public local_icv_id_opad1_p4
    Public local_icv_id_opad1_p5
    Public local_icv_id_opad2_p0
    Public local_icv_id_opad2_p1
    Public local_icv_id_opad2_p2
    Public local_icv_id_opad2_p3
    Public local_icv_id_opad2_p4
    Public local_icv_id_opad2_p5
    Public local_icv_id_opad3_p0
    Public local_icv_id_opad3_p1
    Public local_icv_id_opad3_p2
    Public local_icv_id_opad3_p3
    Public local_icv_id_opad3_p4
    Public local_icv_id_opad3_p5
    Public remote_icv_id_opad0_p0
    Public remote_icv_id_opad0_p1
    Public remote_icv_id_opad0_p2
    Public remote_icv_id_opad0_p3
    Public remote_icv_id_opad0_p4
    Public remote_icv_id_opad0_p5
    Public remote_icv_id_opad1_p0
    Public remote_icv_id_opad1_p1
    Public remote_icv_id_opad1_p2
    Public remote_icv_id_opad1_p3
    Public remote_icv_id_opad1_p4
    Public remote_icv_id_opad1_p5
    Public remote_icv_id_opad2_p0
    Public remote_icv_id_opad2_p1
    Public remote_icv_id_opad2_p2
    Public remote_icv_id_opad2_p3
    Public remote_icv_id_opad2_p4
    Public remote_icv_id_opad2_p5
    Public remote_icv_id_opad3_p0
    Public remote_icv_id_opad3_p1
    Public remote_icv_id_opad3_p2
    Public remote_icv_id_opad3_p3
    Public remote_icv_id_opad3_p4
    Public remote_icv_id_opad3_p5
    Public icv_tx_counter_p0
    Public icv_tx_counter_p1
    Public icv_tx_counter_p2
    Public icv_tx_counter_p3
    Public icv_tx_counter_p4
    Public icv_tx_counter_p5
    Public icv_rx_pass_counter_p0
    Public icv_rx_pass_counter_p1
    Public icv_rx_pass_counter_p2
    Public icv_rx_pass_counter_p3
    Public icv_rx_pass_counter_p4
    Public icv_rx_pass_counter_p5
    Public icv_rx_fail_counter_p0
    Public icv_rx_fail_counter_p1
    Public icv_rx_fail_counter_p2
    Public icv_rx_fail_counter_p3
    Public icv_rx_fail_counter_p4
    Public icv_rx_fail_counter_p5
    Public fxed_pkt_index
    Public icv_bypass_ethtype1
    Public icv_bypass_ethtype2
    Public icv_debug
    Public icv_cnter_rst1
    Public icv_cnter_rst2
    Public icv_cnter_threshold
    Public icv_int
    Public icv_debug_sel
    Public icv_debug1
    Public icv_debug2
    Public icv_debug3
    Public icv_debug4
    Public icv_learn
    Public icv_learn_int
    Public icv_spare8
    Public icv_spare9
    Public icv_spare10
    Public icv_spare11
    Public icv_spare12
    Public icv_spare13
    Public icv_spare14
    Public icv_spare15
    Public icv_spare16


    Public default function Init(aBaseAddr)
        Set icv_tx_cntl_p0 = (New REGISTER_P1588_8P_ICV_icv_tx_cntl_p0)(aBaseAddr, 16)
        Set icv_tx_cntl_p1 = (New REGISTER_P1588_8P_ICV_icv_tx_cntl_p1)(aBaseAddr, 16)
        Set icv_tx_cntl_p2 = (New REGISTER_P1588_8P_ICV_icv_tx_cntl_p2)(aBaseAddr, 16)
        Set icv_tx_cntl_p3 = (New REGISTER_P1588_8P_ICV_icv_tx_cntl_p3)(aBaseAddr, 16)
        Set icv_tx_cntl_p4 = (New REGISTER_P1588_8P_ICV_icv_tx_cntl_p4)(aBaseAddr, 16)
        Set icv_tx_cntl_p5 = (New REGISTER_P1588_8P_ICV_icv_tx_cntl_p5)(aBaseAddr, 16)
        Set icv_rx_cntl_p0 = (New REGISTER_P1588_8P_ICV_icv_rx_cntl_p0)(aBaseAddr, 16)
        Set icv_rx_cntl_p1 = (New REGISTER_P1588_8P_ICV_icv_rx_cntl_p1)(aBaseAddr, 16)
        Set icv_rx_cntl_p2 = (New REGISTER_P1588_8P_ICV_icv_rx_cntl_p2)(aBaseAddr, 16)
        Set icv_rx_cntl_p3 = (New REGISTER_P1588_8P_ICV_icv_rx_cntl_p3)(aBaseAddr, 16)
        Set icv_rx_cntl_p4 = (New REGISTER_P1588_8P_ICV_icv_rx_cntl_p4)(aBaseAddr, 16)
        Set icv_rx_cntl_p5 = (New REGISTER_P1588_8P_ICV_icv_rx_cntl_p5)(aBaseAddr, 16)
        Set local_icv_id0_p0 = (New REGISTER_P1588_8P_ICV_local_icv_id0_p0)(aBaseAddr, 16)
        Set local_icv_id0_p1 = (New REGISTER_P1588_8P_ICV_local_icv_id0_p1)(aBaseAddr, 16)
        Set local_icv_id0_p2 = (New REGISTER_P1588_8P_ICV_local_icv_id0_p2)(aBaseAddr, 16)
        Set local_icv_id0_p3 = (New REGISTER_P1588_8P_ICV_local_icv_id0_p3)(aBaseAddr, 16)
        Set local_icv_id0_p4 = (New REGISTER_P1588_8P_ICV_local_icv_id0_p4)(aBaseAddr, 16)
        Set local_icv_id0_p5 = (New REGISTER_P1588_8P_ICV_local_icv_id0_p5)(aBaseAddr, 16)
        Set local_icv_id1_p0 = (New REGISTER_P1588_8P_ICV_local_icv_id1_p0)(aBaseAddr, 16)
        Set local_icv_id1_p1 = (New REGISTER_P1588_8P_ICV_local_icv_id1_p1)(aBaseAddr, 16)
        Set local_icv_id1_p2 = (New REGISTER_P1588_8P_ICV_local_icv_id1_p2)(aBaseAddr, 16)
        Set local_icv_id1_p3 = (New REGISTER_P1588_8P_ICV_local_icv_id1_p3)(aBaseAddr, 16)
        Set local_icv_id1_p4 = (New REGISTER_P1588_8P_ICV_local_icv_id1_p4)(aBaseAddr, 16)
        Set local_icv_id1_p5 = (New REGISTER_P1588_8P_ICV_local_icv_id1_p5)(aBaseAddr, 16)
        Set local_icv_id2_p0 = (New REGISTER_P1588_8P_ICV_local_icv_id2_p0)(aBaseAddr, 16)
        Set local_icv_id2_p1 = (New REGISTER_P1588_8P_ICV_local_icv_id2_p1)(aBaseAddr, 16)
        Set local_icv_id2_p2 = (New REGISTER_P1588_8P_ICV_local_icv_id2_p2)(aBaseAddr, 16)
        Set local_icv_id2_p3 = (New REGISTER_P1588_8P_ICV_local_icv_id2_p3)(aBaseAddr, 16)
        Set local_icv_id2_p4 = (New REGISTER_P1588_8P_ICV_local_icv_id2_p4)(aBaseAddr, 16)
        Set local_icv_id2_p5 = (New REGISTER_P1588_8P_ICV_local_icv_id2_p5)(aBaseAddr, 16)
        Set local_icv_id3_p0 = (New REGISTER_P1588_8P_ICV_local_icv_id3_p0)(aBaseAddr, 16)
        Set local_icv_id3_p1 = (New REGISTER_P1588_8P_ICV_local_icv_id3_p1)(aBaseAddr, 16)
        Set local_icv_id3_p2 = (New REGISTER_P1588_8P_ICV_local_icv_id3_p2)(aBaseAddr, 16)
        Set local_icv_id3_p3 = (New REGISTER_P1588_8P_ICV_local_icv_id3_p3)(aBaseAddr, 16)
        Set local_icv_id3_p4 = (New REGISTER_P1588_8P_ICV_local_icv_id3_p4)(aBaseAddr, 16)
        Set local_icv_id3_p5 = (New REGISTER_P1588_8P_ICV_local_icv_id3_p5)(aBaseAddr, 16)
        Set remote_icv_id0_p0 = (New REGISTER_P1588_8P_ICV_remote_icv_id0_p0)(aBaseAddr, 16)
        Set remote_icv_id0_p1 = (New REGISTER_P1588_8P_ICV_remote_icv_id0_p1)(aBaseAddr, 16)
        Set remote_icv_id0_p2 = (New REGISTER_P1588_8P_ICV_remote_icv_id0_p2)(aBaseAddr, 16)
        Set remote_icv_id0_p3 = (New REGISTER_P1588_8P_ICV_remote_icv_id0_p3)(aBaseAddr, 16)
        Set remote_icv_id0_p4 = (New REGISTER_P1588_8P_ICV_remote_icv_id0_p4)(aBaseAddr, 16)
        Set remote_icv_id0_p5 = (New REGISTER_P1588_8P_ICV_remote_icv_id0_p5)(aBaseAddr, 16)
        Set remote_icv_id1_p0 = (New REGISTER_P1588_8P_ICV_remote_icv_id1_p0)(aBaseAddr, 16)
        Set remote_icv_id1_p1 = (New REGISTER_P1588_8P_ICV_remote_icv_id1_p1)(aBaseAddr, 16)
        Set remote_icv_id1_p2 = (New REGISTER_P1588_8P_ICV_remote_icv_id1_p2)(aBaseAddr, 16)
        Set remote_icv_id1_p3 = (New REGISTER_P1588_8P_ICV_remote_icv_id1_p3)(aBaseAddr, 16)
        Set remote_icv_id1_p4 = (New REGISTER_P1588_8P_ICV_remote_icv_id1_p4)(aBaseAddr, 16)
        Set remote_icv_id1_p5 = (New REGISTER_P1588_8P_ICV_remote_icv_id1_p5)(aBaseAddr, 16)
        Set remote_icv_id2_p0 = (New REGISTER_P1588_8P_ICV_remote_icv_id2_p0)(aBaseAddr, 16)
        Set remote_icv_id2_p1 = (New REGISTER_P1588_8P_ICV_remote_icv_id2_p1)(aBaseAddr, 16)
        Set remote_icv_id2_p2 = (New REGISTER_P1588_8P_ICV_remote_icv_id2_p2)(aBaseAddr, 16)
        Set remote_icv_id2_p3 = (New REGISTER_P1588_8P_ICV_remote_icv_id2_p3)(aBaseAddr, 16)
        Set remote_icv_id2_p4 = (New REGISTER_P1588_8P_ICV_remote_icv_id2_p4)(aBaseAddr, 16)
        Set remote_icv_id2_p5 = (New REGISTER_P1588_8P_ICV_remote_icv_id2_p5)(aBaseAddr, 16)
        Set remote_icv_id3_p0 = (New REGISTER_P1588_8P_ICV_remote_icv_id3_p0)(aBaseAddr, 16)
        Set remote_icv_id3_p1 = (New REGISTER_P1588_8P_ICV_remote_icv_id3_p1)(aBaseAddr, 16)
        Set remote_icv_id3_p2 = (New REGISTER_P1588_8P_ICV_remote_icv_id3_p2)(aBaseAddr, 16)
        Set remote_icv_id3_p3 = (New REGISTER_P1588_8P_ICV_remote_icv_id3_p3)(aBaseAddr, 16)
        Set remote_icv_id3_p4 = (New REGISTER_P1588_8P_ICV_remote_icv_id3_p4)(aBaseAddr, 16)
        Set remote_icv_id3_p5 = (New REGISTER_P1588_8P_ICV_remote_icv_id3_p5)(aBaseAddr, 16)
        Set local_icv_id_ipad0_p0 = (New REGISTER_P1588_8P_ICV_local_icv_id_ipad0_p0)(aBaseAddr, 16)
        Set local_icv_id_ipad0_p1 = (New REGISTER_P1588_8P_ICV_local_icv_id_ipad0_p1)(aBaseAddr, 16)
        Set local_icv_id_ipad0_p2 = (New REGISTER_P1588_8P_ICV_local_icv_id_ipad0_p2)(aBaseAddr, 16)
        Set local_icv_id_ipad0_p3 = (New REGISTER_P1588_8P_ICV_local_icv_id_ipad0_p3)(aBaseAddr, 16)
        Set local_icv_id_ipad0_p4 = (New REGISTER_P1588_8P_ICV_local_icv_id_ipad0_p4)(aBaseAddr, 16)
        Set local_icv_id_ipad0_p5 = (New REGISTER_P1588_8P_ICV_local_icv_id_ipad0_p5)(aBaseAddr, 16)
        Set local_icv_id_ipad1_p0 = (New REGISTER_P1588_8P_ICV_local_icv_id_ipad1_p0)(aBaseAddr, 16)
        Set local_icv_id_ipad1_p1 = (New REGISTER_P1588_8P_ICV_local_icv_id_ipad1_p1)(aBaseAddr, 16)
        Set local_icv_id_ipad1_p2 = (New REGISTER_P1588_8P_ICV_local_icv_id_ipad1_p2)(aBaseAddr, 16)
        Set local_icv_id_ipad1_p3 = (New REGISTER_P1588_8P_ICV_local_icv_id_ipad1_p3)(aBaseAddr, 16)
        Set local_icv_id_ipad1_p4 = (New REGISTER_P1588_8P_ICV_local_icv_id_ipad1_p4)(aBaseAddr, 16)
        Set local_icv_id_ipad1_p5 = (New REGISTER_P1588_8P_ICV_local_icv_id_ipad1_p5)(aBaseAddr, 16)
        Set local_icv_id_ipad2_p0 = (New REGISTER_P1588_8P_ICV_local_icv_id_ipad2_p0)(aBaseAddr, 16)
        Set local_icv_id_ipad2_p1 = (New REGISTER_P1588_8P_ICV_local_icv_id_ipad2_p1)(aBaseAddr, 16)
        Set local_icv_id_ipad2_p2 = (New REGISTER_P1588_8P_ICV_local_icv_id_ipad2_p2)(aBaseAddr, 16)
        Set local_icv_id_ipad2_p3 = (New REGISTER_P1588_8P_ICV_local_icv_id_ipad2_p3)(aBaseAddr, 16)
        Set local_icv_id_ipad2_p4 = (New REGISTER_P1588_8P_ICV_local_icv_id_ipad2_p4)(aBaseAddr, 16)
        Set local_icv_id_ipad2_p5 = (New REGISTER_P1588_8P_ICV_local_icv_id_ipad2_p5)(aBaseAddr, 16)
        Set local_icv_id_ipad3_p0 = (New REGISTER_P1588_8P_ICV_local_icv_id_ipad3_p0)(aBaseAddr, 16)
        Set local_icv_id_ipad3_p1 = (New REGISTER_P1588_8P_ICV_local_icv_id_ipad3_p1)(aBaseAddr, 16)
        Set local_icv_id_ipad3_p2 = (New REGISTER_P1588_8P_ICV_local_icv_id_ipad3_p2)(aBaseAddr, 16)
        Set local_icv_id_ipad3_p3 = (New REGISTER_P1588_8P_ICV_local_icv_id_ipad3_p3)(aBaseAddr, 16)
        Set local_icv_id_ipad3_p4 = (New REGISTER_P1588_8P_ICV_local_icv_id_ipad3_p4)(aBaseAddr, 16)
        Set local_icv_id_ipad3_p5 = (New REGISTER_P1588_8P_ICV_local_icv_id_ipad3_p5)(aBaseAddr, 16)
        Set remote_icv_id_ipad0_p0 = (New REGISTER_P1588_8P_ICV_remote_icv_id_ipad0_p0)(aBaseAddr, 16)
        Set remote_icv_id_ipad0_p1 = (New REGISTER_P1588_8P_ICV_remote_icv_id_ipad0_p1)(aBaseAddr, 16)
        Set remote_icv_id_ipad0_p2 = (New REGISTER_P1588_8P_ICV_remote_icv_id_ipad0_p2)(aBaseAddr, 16)
        Set remote_icv_id_ipad0_p3 = (New REGISTER_P1588_8P_ICV_remote_icv_id_ipad0_p3)(aBaseAddr, 16)
        Set remote_icv_id_ipad0_p4 = (New REGISTER_P1588_8P_ICV_remote_icv_id_ipad0_p4)(aBaseAddr, 16)
        Set remote_icv_id_ipad0_p5 = (New REGISTER_P1588_8P_ICV_remote_icv_id_ipad0_p5)(aBaseAddr, 16)
        Set remote_icv_id_ipad1_p0 = (New REGISTER_P1588_8P_ICV_remote_icv_id_ipad1_p0)(aBaseAddr, 16)
        Set remote_icv_id_ipad1_p1 = (New REGISTER_P1588_8P_ICV_remote_icv_id_ipad1_p1)(aBaseAddr, 16)
        Set remote_icv_id_ipad1_p2 = (New REGISTER_P1588_8P_ICV_remote_icv_id_ipad1_p2)(aBaseAddr, 16)
        Set remote_icv_id_ipad1_p3 = (New REGISTER_P1588_8P_ICV_remote_icv_id_ipad1_p3)(aBaseAddr, 16)
        Set remote_icv_id_ipad1_p4 = (New REGISTER_P1588_8P_ICV_remote_icv_id_ipad1_p4)(aBaseAddr, 16)
        Set remote_icv_id_ipad1_p5 = (New REGISTER_P1588_8P_ICV_remote_icv_id_ipad1_p5)(aBaseAddr, 16)
        Set remote_icv_id_ipad2_p0 = (New REGISTER_P1588_8P_ICV_remote_icv_id_ipad2_p0)(aBaseAddr, 16)
        Set remote_icv_id_ipad2_p1 = (New REGISTER_P1588_8P_ICV_remote_icv_id_ipad2_p1)(aBaseAddr, 16)
        Set remote_icv_id_ipad2_p2 = (New REGISTER_P1588_8P_ICV_remote_icv_id_ipad2_p2)(aBaseAddr, 16)
        Set remote_icv_id_ipad2_p3 = (New REGISTER_P1588_8P_ICV_remote_icv_id_ipad2_p3)(aBaseAddr, 16)
        Set remote_icv_id_ipad2_p4 = (New REGISTER_P1588_8P_ICV_remote_icv_id_ipad2_p4)(aBaseAddr, 16)
        Set remote_icv_id_ipad2_p5 = (New REGISTER_P1588_8P_ICV_remote_icv_id_ipad2_p5)(aBaseAddr, 16)
        Set remote_icv_id_ipad3_p0 = (New REGISTER_P1588_8P_ICV_remote_icv_id_ipad3_p0)(aBaseAddr, 16)
        Set remote_icv_id_ipad3_p1 = (New REGISTER_P1588_8P_ICV_remote_icv_id_ipad3_p1)(aBaseAddr, 16)
        Set remote_icv_id_ipad3_p2 = (New REGISTER_P1588_8P_ICV_remote_icv_id_ipad3_p2)(aBaseAddr, 16)
        Set remote_icv_id_ipad3_p3 = (New REGISTER_P1588_8P_ICV_remote_icv_id_ipad3_p3)(aBaseAddr, 16)
        Set remote_icv_id_ipad3_p4 = (New REGISTER_P1588_8P_ICV_remote_icv_id_ipad3_p4)(aBaseAddr, 16)
        Set remote_icv_id_ipad3_p5 = (New REGISTER_P1588_8P_ICV_remote_icv_id_ipad3_p5)(aBaseAddr, 16)
        Set local_icv_id_opad0_p0 = (New REGISTER_P1588_8P_ICV_local_icv_id_opad0_p0)(aBaseAddr, 16)
        Set local_icv_id_opad0_p1 = (New REGISTER_P1588_8P_ICV_local_icv_id_opad0_p1)(aBaseAddr, 16)
        Set local_icv_id_opad0_p2 = (New REGISTER_P1588_8P_ICV_local_icv_id_opad0_p2)(aBaseAddr, 16)
        Set local_icv_id_opad0_p3 = (New REGISTER_P1588_8P_ICV_local_icv_id_opad0_p3)(aBaseAddr, 16)
        Set local_icv_id_opad0_p4 = (New REGISTER_P1588_8P_ICV_local_icv_id_opad0_p4)(aBaseAddr, 16)
        Set local_icv_id_opad0_p5 = (New REGISTER_P1588_8P_ICV_local_icv_id_opad0_p5)(aBaseAddr, 16)
        Set local_icv_id_opad1_p0 = (New REGISTER_P1588_8P_ICV_local_icv_id_opad1_p0)(aBaseAddr, 16)
        Set local_icv_id_opad1_p1 = (New REGISTER_P1588_8P_ICV_local_icv_id_opad1_p1)(aBaseAddr, 16)
        Set local_icv_id_opad1_p2 = (New REGISTER_P1588_8P_ICV_local_icv_id_opad1_p2)(aBaseAddr, 16)
        Set local_icv_id_opad1_p3 = (New REGISTER_P1588_8P_ICV_local_icv_id_opad1_p3)(aBaseAddr, 16)
        Set local_icv_id_opad1_p4 = (New REGISTER_P1588_8P_ICV_local_icv_id_opad1_p4)(aBaseAddr, 16)
        Set local_icv_id_opad1_p5 = (New REGISTER_P1588_8P_ICV_local_icv_id_opad1_p5)(aBaseAddr, 16)
        Set local_icv_id_opad2_p0 = (New REGISTER_P1588_8P_ICV_local_icv_id_opad2_p0)(aBaseAddr, 16)
        Set local_icv_id_opad2_p1 = (New REGISTER_P1588_8P_ICV_local_icv_id_opad2_p1)(aBaseAddr, 16)
        Set local_icv_id_opad2_p2 = (New REGISTER_P1588_8P_ICV_local_icv_id_opad2_p2)(aBaseAddr, 16)
        Set local_icv_id_opad2_p3 = (New REGISTER_P1588_8P_ICV_local_icv_id_opad2_p3)(aBaseAddr, 16)
        Set local_icv_id_opad2_p4 = (New REGISTER_P1588_8P_ICV_local_icv_id_opad2_p4)(aBaseAddr, 16)
        Set local_icv_id_opad2_p5 = (New REGISTER_P1588_8P_ICV_local_icv_id_opad2_p5)(aBaseAddr, 16)
        Set local_icv_id_opad3_p0 = (New REGISTER_P1588_8P_ICV_local_icv_id_opad3_p0)(aBaseAddr, 16)
        Set local_icv_id_opad3_p1 = (New REGISTER_P1588_8P_ICV_local_icv_id_opad3_p1)(aBaseAddr, 16)
        Set local_icv_id_opad3_p2 = (New REGISTER_P1588_8P_ICV_local_icv_id_opad3_p2)(aBaseAddr, 16)
        Set local_icv_id_opad3_p3 = (New REGISTER_P1588_8P_ICV_local_icv_id_opad3_p3)(aBaseAddr, 16)
        Set local_icv_id_opad3_p4 = (New REGISTER_P1588_8P_ICV_local_icv_id_opad3_p4)(aBaseAddr, 16)
        Set local_icv_id_opad3_p5 = (New REGISTER_P1588_8P_ICV_local_icv_id_opad3_p5)(aBaseAddr, 16)
        Set remote_icv_id_opad0_p0 = (New REGISTER_P1588_8P_ICV_remote_icv_id_opad0_p0)(aBaseAddr, 16)
        Set remote_icv_id_opad0_p1 = (New REGISTER_P1588_8P_ICV_remote_icv_id_opad0_p1)(aBaseAddr, 16)
        Set remote_icv_id_opad0_p2 = (New REGISTER_P1588_8P_ICV_remote_icv_id_opad0_p2)(aBaseAddr, 16)
        Set remote_icv_id_opad0_p3 = (New REGISTER_P1588_8P_ICV_remote_icv_id_opad0_p3)(aBaseAddr, 16)
        Set remote_icv_id_opad0_p4 = (New REGISTER_P1588_8P_ICV_remote_icv_id_opad0_p4)(aBaseAddr, 16)
        Set remote_icv_id_opad0_p5 = (New REGISTER_P1588_8P_ICV_remote_icv_id_opad0_p5)(aBaseAddr, 16)
        Set remote_icv_id_opad1_p0 = (New REGISTER_P1588_8P_ICV_remote_icv_id_opad1_p0)(aBaseAddr, 16)
        Set remote_icv_id_opad1_p1 = (New REGISTER_P1588_8P_ICV_remote_icv_id_opad1_p1)(aBaseAddr, 16)
        Set remote_icv_id_opad1_p2 = (New REGISTER_P1588_8P_ICV_remote_icv_id_opad1_p2)(aBaseAddr, 16)
        Set remote_icv_id_opad1_p3 = (New REGISTER_P1588_8P_ICV_remote_icv_id_opad1_p3)(aBaseAddr, 16)
        Set remote_icv_id_opad1_p4 = (New REGISTER_P1588_8P_ICV_remote_icv_id_opad1_p4)(aBaseAddr, 16)
        Set remote_icv_id_opad1_p5 = (New REGISTER_P1588_8P_ICV_remote_icv_id_opad1_p5)(aBaseAddr, 16)
        Set remote_icv_id_opad2_p0 = (New REGISTER_P1588_8P_ICV_remote_icv_id_opad2_p0)(aBaseAddr, 16)
        Set remote_icv_id_opad2_p1 = (New REGISTER_P1588_8P_ICV_remote_icv_id_opad2_p1)(aBaseAddr, 16)
        Set remote_icv_id_opad2_p2 = (New REGISTER_P1588_8P_ICV_remote_icv_id_opad2_p2)(aBaseAddr, 16)
        Set remote_icv_id_opad2_p3 = (New REGISTER_P1588_8P_ICV_remote_icv_id_opad2_p3)(aBaseAddr, 16)
        Set remote_icv_id_opad2_p4 = (New REGISTER_P1588_8P_ICV_remote_icv_id_opad2_p4)(aBaseAddr, 16)
        Set remote_icv_id_opad2_p5 = (New REGISTER_P1588_8P_ICV_remote_icv_id_opad2_p5)(aBaseAddr, 16)
        Set remote_icv_id_opad3_p0 = (New REGISTER_P1588_8P_ICV_remote_icv_id_opad3_p0)(aBaseAddr, 16)
        Set remote_icv_id_opad3_p1 = (New REGISTER_P1588_8P_ICV_remote_icv_id_opad3_p1)(aBaseAddr, 16)
        Set remote_icv_id_opad3_p2 = (New REGISTER_P1588_8P_ICV_remote_icv_id_opad3_p2)(aBaseAddr, 16)
        Set remote_icv_id_opad3_p3 = (New REGISTER_P1588_8P_ICV_remote_icv_id_opad3_p3)(aBaseAddr, 16)
        Set remote_icv_id_opad3_p4 = (New REGISTER_P1588_8P_ICV_remote_icv_id_opad3_p4)(aBaseAddr, 16)
        Set remote_icv_id_opad3_p5 = (New REGISTER_P1588_8P_ICV_remote_icv_id_opad3_p5)(aBaseAddr, 16)
        Set icv_tx_counter_p0 = (New REGISTER_P1588_8P_ICV_icv_tx_counter_p0)(aBaseAddr, 16)
        Set icv_tx_counter_p1 = (New REGISTER_P1588_8P_ICV_icv_tx_counter_p1)(aBaseAddr, 16)
        Set icv_tx_counter_p2 = (New REGISTER_P1588_8P_ICV_icv_tx_counter_p2)(aBaseAddr, 16)
        Set icv_tx_counter_p3 = (New REGISTER_P1588_8P_ICV_icv_tx_counter_p3)(aBaseAddr, 16)
        Set icv_tx_counter_p4 = (New REGISTER_P1588_8P_ICV_icv_tx_counter_p4)(aBaseAddr, 16)
        Set icv_tx_counter_p5 = (New REGISTER_P1588_8P_ICV_icv_tx_counter_p5)(aBaseAddr, 16)
        Set icv_rx_pass_counter_p0 = (New REGISTER_P1588_8P_ICV_icv_rx_pass_counter_p0)(aBaseAddr, 16)
        Set icv_rx_pass_counter_p1 = (New REGISTER_P1588_8P_ICV_icv_rx_pass_counter_p1)(aBaseAddr, 16)
        Set icv_rx_pass_counter_p2 = (New REGISTER_P1588_8P_ICV_icv_rx_pass_counter_p2)(aBaseAddr, 16)
        Set icv_rx_pass_counter_p3 = (New REGISTER_P1588_8P_ICV_icv_rx_pass_counter_p3)(aBaseAddr, 16)
        Set icv_rx_pass_counter_p4 = (New REGISTER_P1588_8P_ICV_icv_rx_pass_counter_p4)(aBaseAddr, 16)
        Set icv_rx_pass_counter_p5 = (New REGISTER_P1588_8P_ICV_icv_rx_pass_counter_p5)(aBaseAddr, 16)
        Set icv_rx_fail_counter_p0 = (New REGISTER_P1588_8P_ICV_icv_rx_fail_counter_p0)(aBaseAddr, 16)
        Set icv_rx_fail_counter_p1 = (New REGISTER_P1588_8P_ICV_icv_rx_fail_counter_p1)(aBaseAddr, 16)
        Set icv_rx_fail_counter_p2 = (New REGISTER_P1588_8P_ICV_icv_rx_fail_counter_p2)(aBaseAddr, 16)
        Set icv_rx_fail_counter_p3 = (New REGISTER_P1588_8P_ICV_icv_rx_fail_counter_p3)(aBaseAddr, 16)
        Set icv_rx_fail_counter_p4 = (New REGISTER_P1588_8P_ICV_icv_rx_fail_counter_p4)(aBaseAddr, 16)
        Set icv_rx_fail_counter_p5 = (New REGISTER_P1588_8P_ICV_icv_rx_fail_counter_p5)(aBaseAddr, 16)
        Set fxed_pkt_index = (New REGISTER_P1588_8P_ICV_fxed_pkt_index)(aBaseAddr, 16)
        Set icv_bypass_ethtype1 = (New REGISTER_P1588_8P_ICV_icv_bypass_ethtype1)(aBaseAddr, 16)
        Set icv_bypass_ethtype2 = (New REGISTER_P1588_8P_ICV_icv_bypass_ethtype2)(aBaseAddr, 16)
        Set icv_debug = (New REGISTER_P1588_8P_ICV_icv_debug)(aBaseAddr, 16)
        Set icv_cnter_rst1 = (New REGISTER_P1588_8P_ICV_icv_cnter_rst1)(aBaseAddr, 16)
        Set icv_cnter_rst2 = (New REGISTER_P1588_8P_ICV_icv_cnter_rst2)(aBaseAddr, 16)
        Set icv_cnter_threshold = (New REGISTER_P1588_8P_ICV_icv_cnter_threshold)(aBaseAddr, 16)
        Set icv_int = (New REGISTER_P1588_8P_ICV_icv_int)(aBaseAddr, 16)
        Set icv_debug_sel = (New REGISTER_P1588_8P_ICV_icv_debug_sel)(aBaseAddr, 16)
        Set icv_debug1 = (New REGISTER_P1588_8P_ICV_icv_debug1)(aBaseAddr, 16)
        Set icv_debug2 = (New REGISTER_P1588_8P_ICV_icv_debug2)(aBaseAddr, 16)
        Set icv_debug3 = (New REGISTER_P1588_8P_ICV_icv_debug3)(aBaseAddr, 16)
        Set icv_debug4 = (New REGISTER_P1588_8P_ICV_icv_debug4)(aBaseAddr, 16)
        Set icv_learn = (New REGISTER_P1588_8P_ICV_icv_learn)(aBaseAddr, 16)
        Set icv_learn_int = (New REGISTER_P1588_8P_ICV_icv_learn_int)(aBaseAddr, 16)
        Set icv_spare8 = (New REGISTER_P1588_8P_ICV_icv_spare8)(aBaseAddr, 16)
        Set icv_spare9 = (New REGISTER_P1588_8P_ICV_icv_spare9)(aBaseAddr, 16)
        Set icv_spare10 = (New REGISTER_P1588_8P_ICV_icv_spare10)(aBaseAddr, 16)
        Set icv_spare11 = (New REGISTER_P1588_8P_ICV_icv_spare11)(aBaseAddr, 16)
        Set icv_spare12 = (New REGISTER_P1588_8P_ICV_icv_spare12)(aBaseAddr, 16)
        Set icv_spare13 = (New REGISTER_P1588_8P_ICV_icv_spare13)(aBaseAddr, 16)
        Set icv_spare14 = (New REGISTER_P1588_8P_ICV_icv_spare14)(aBaseAddr, 16)
        Set icv_spare15 = (New REGISTER_P1588_8P_ICV_icv_spare15)(aBaseAddr, 16)
        Set icv_spare16 = (New REGISTER_P1588_8P_ICV_icv_spare16)(aBaseAddr, 16)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set P1588_8P_ICV = CreateObject("System.Collections.ArrayList")
P1588_8P_ICV.Add ((New P1588_8P_ICV_INSTANCE)(&H4a860200))


