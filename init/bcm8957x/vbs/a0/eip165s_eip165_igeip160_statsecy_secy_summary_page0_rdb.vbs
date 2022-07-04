

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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SUMMARY_PAGE0_secy_count_summary_0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SECY_CNT                                   [31:0]           get_SECY_CNT
''                                                             set_SECY_CNT
''                                                             read_SECY_CNT
''                                                             write_SECY_CNT
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SUMMARY_PAGE0_secy_count_summary_0
    Private write_SECY_CNT_value
    Private read_SECY_CNT_value
    Private flag_SECY_CNT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &He500
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_SECY_CNT
        get_SECY_CNT = read_SECY_CNT_value
    End Property

    Property Let set_SECY_CNT(aData)
        write_SECY_CNT_value = aData
        flag_SECY_CNT        = &H1
    End Property

    Property Get read_SECY_CNT
        read
        read_SECY_CNT = read_SECY_CNT_value
    End Property

    Property Let write_SECY_CNT(aData)
        set_SECY_CNT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SECY_CNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SECY_CNT_mask = mask then
                read_SECY_CNT_value = data_low
            else
                read_SECY_CNT_value = (data_low - H8000_0000) and SECY_CNT_mask
            end If
        else
            read_SECY_CNT_value = data_low and SECY_CNT_mask
        end If

    End Sub

    Sub write
        If flag_SECY_CNT = &H0 Then read
        If flag_SECY_CNT = &H0 Then write_SECY_CNT_value = get_SECY_CNT

        regValue = leftShift(write_SECY_CNT_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SECY_CNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SECY_CNT_mask = mask then
                read_SECY_CNT_value = data_low
            else
                read_SECY_CNT_value = (data_low - H8000_0000) and SECY_CNT_mask
            end If
        else
            read_SECY_CNT_value = data_low and SECY_CNT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SECY_CNT_value = &H0
        flag_SECY_CNT        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SUMMARY_PAGE0_secy_count_summary_1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SECY_CNT                                   [31:0]           get_SECY_CNT
''                                                             set_SECY_CNT
''                                                             read_SECY_CNT
''                                                             write_SECY_CNT
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SUMMARY_PAGE0_secy_count_summary_1
    Private write_SECY_CNT_value
    Private read_SECY_CNT_value
    Private flag_SECY_CNT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &He504
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_SECY_CNT
        get_SECY_CNT = read_SECY_CNT_value
    End Property

    Property Let set_SECY_CNT(aData)
        write_SECY_CNT_value = aData
        flag_SECY_CNT        = &H1
    End Property

    Property Get read_SECY_CNT
        read
        read_SECY_CNT = read_SECY_CNT_value
    End Property

    Property Let write_SECY_CNT(aData)
        set_SECY_CNT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SECY_CNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SECY_CNT_mask = mask then
                read_SECY_CNT_value = data_low
            else
                read_SECY_CNT_value = (data_low - H8000_0000) and SECY_CNT_mask
            end If
        else
            read_SECY_CNT_value = data_low and SECY_CNT_mask
        end If

    End Sub

    Sub write
        If flag_SECY_CNT = &H0 Then read
        If flag_SECY_CNT = &H0 Then write_SECY_CNT_value = get_SECY_CNT

        regValue = leftShift(write_SECY_CNT_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SECY_CNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SECY_CNT_mask = mask then
                read_SECY_CNT_value = data_low
            else
                read_SECY_CNT_value = (data_low - H8000_0000) and SECY_CNT_mask
            end If
        else
            read_SECY_CNT_value = data_low and SECY_CNT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SECY_CNT_value = &H0
        flag_SECY_CNT        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SUMMARY_PAGE0_secy_count_summary_2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SECY_CNT                                   [31:0]           get_SECY_CNT
''                                                             set_SECY_CNT
''                                                             read_SECY_CNT
''                                                             write_SECY_CNT
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SUMMARY_PAGE0_secy_count_summary_2
    Private write_SECY_CNT_value
    Private read_SECY_CNT_value
    Private flag_SECY_CNT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &He508
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_SECY_CNT
        get_SECY_CNT = read_SECY_CNT_value
    End Property

    Property Let set_SECY_CNT(aData)
        write_SECY_CNT_value = aData
        flag_SECY_CNT        = &H1
    End Property

    Property Get read_SECY_CNT
        read
        read_SECY_CNT = read_SECY_CNT_value
    End Property

    Property Let write_SECY_CNT(aData)
        set_SECY_CNT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SECY_CNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SECY_CNT_mask = mask then
                read_SECY_CNT_value = data_low
            else
                read_SECY_CNT_value = (data_low - H8000_0000) and SECY_CNT_mask
            end If
        else
            read_SECY_CNT_value = data_low and SECY_CNT_mask
        end If

    End Sub

    Sub write
        If flag_SECY_CNT = &H0 Then read
        If flag_SECY_CNT = &H0 Then write_SECY_CNT_value = get_SECY_CNT

        regValue = leftShift(write_SECY_CNT_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SECY_CNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SECY_CNT_mask = mask then
                read_SECY_CNT_value = data_low
            else
                read_SECY_CNT_value = (data_low - H8000_0000) and SECY_CNT_mask
            end If
        else
            read_SECY_CNT_value = data_low and SECY_CNT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SECY_CNT_value = &H0
        flag_SECY_CNT        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SUMMARY_PAGE0_secy_count_summary_3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SECY_CNT                                   [31:0]           get_SECY_CNT
''                                                             set_SECY_CNT
''                                                             read_SECY_CNT
''                                                             write_SECY_CNT
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SUMMARY_PAGE0_secy_count_summary_3
    Private write_SECY_CNT_value
    Private read_SECY_CNT_value
    Private flag_SECY_CNT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &He50c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_SECY_CNT
        get_SECY_CNT = read_SECY_CNT_value
    End Property

    Property Let set_SECY_CNT(aData)
        write_SECY_CNT_value = aData
        flag_SECY_CNT        = &H1
    End Property

    Property Get read_SECY_CNT
        read
        read_SECY_CNT = read_SECY_CNT_value
    End Property

    Property Let write_SECY_CNT(aData)
        set_SECY_CNT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SECY_CNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SECY_CNT_mask = mask then
                read_SECY_CNT_value = data_low
            else
                read_SECY_CNT_value = (data_low - H8000_0000) and SECY_CNT_mask
            end If
        else
            read_SECY_CNT_value = data_low and SECY_CNT_mask
        end If

    End Sub

    Sub write
        If flag_SECY_CNT = &H0 Then read
        If flag_SECY_CNT = &H0 Then write_SECY_CNT_value = get_SECY_CNT

        regValue = leftShift(write_SECY_CNT_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SECY_CNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SECY_CNT_mask = mask then
                read_SECY_CNT_value = data_low
            else
                read_SECY_CNT_value = (data_low - H8000_0000) and SECY_CNT_mask
            end If
        else
            read_SECY_CNT_value = data_low and SECY_CNT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SECY_CNT_value = &H0
        flag_SECY_CNT        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SUMMARY_PAGE0_secy_count_summary_4
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SECY_CNT                                   [31:0]           get_SECY_CNT
''                                                             set_SECY_CNT
''                                                             read_SECY_CNT
''                                                             write_SECY_CNT
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SUMMARY_PAGE0_secy_count_summary_4
    Private write_SECY_CNT_value
    Private read_SECY_CNT_value
    Private flag_SECY_CNT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &He510
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_SECY_CNT
        get_SECY_CNT = read_SECY_CNT_value
    End Property

    Property Let set_SECY_CNT(aData)
        write_SECY_CNT_value = aData
        flag_SECY_CNT        = &H1
    End Property

    Property Get read_SECY_CNT
        read
        read_SECY_CNT = read_SECY_CNT_value
    End Property

    Property Let write_SECY_CNT(aData)
        set_SECY_CNT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SECY_CNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SECY_CNT_mask = mask then
                read_SECY_CNT_value = data_low
            else
                read_SECY_CNT_value = (data_low - H8000_0000) and SECY_CNT_mask
            end If
        else
            read_SECY_CNT_value = data_low and SECY_CNT_mask
        end If

    End Sub

    Sub write
        If flag_SECY_CNT = &H0 Then read
        If flag_SECY_CNT = &H0 Then write_SECY_CNT_value = get_SECY_CNT

        regValue = leftShift(write_SECY_CNT_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SECY_CNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SECY_CNT_mask = mask then
                read_SECY_CNT_value = data_low
            else
                read_SECY_CNT_value = (data_low - H8000_0000) and SECY_CNT_mask
            end If
        else
            read_SECY_CNT_value = data_low and SECY_CNT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SECY_CNT_value = &H0
        flag_SECY_CNT        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SUMMARY_PAGE0_secy_count_summary_5
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SECY_CNT                                   [31:0]           get_SECY_CNT
''                                                             set_SECY_CNT
''                                                             read_SECY_CNT
''                                                             write_SECY_CNT
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SUMMARY_PAGE0_secy_count_summary_5
    Private write_SECY_CNT_value
    Private read_SECY_CNT_value
    Private flag_SECY_CNT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &He514
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_SECY_CNT
        get_SECY_CNT = read_SECY_CNT_value
    End Property

    Property Let set_SECY_CNT(aData)
        write_SECY_CNT_value = aData
        flag_SECY_CNT        = &H1
    End Property

    Property Get read_SECY_CNT
        read
        read_SECY_CNT = read_SECY_CNT_value
    End Property

    Property Let write_SECY_CNT(aData)
        set_SECY_CNT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SECY_CNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SECY_CNT_mask = mask then
                read_SECY_CNT_value = data_low
            else
                read_SECY_CNT_value = (data_low - H8000_0000) and SECY_CNT_mask
            end If
        else
            read_SECY_CNT_value = data_low and SECY_CNT_mask
        end If

    End Sub

    Sub write
        If flag_SECY_CNT = &H0 Then read
        If flag_SECY_CNT = &H0 Then write_SECY_CNT_value = get_SECY_CNT

        regValue = leftShift(write_SECY_CNT_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SECY_CNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SECY_CNT_mask = mask then
                read_SECY_CNT_value = data_low
            else
                read_SECY_CNT_value = (data_low - H8000_0000) and SECY_CNT_mask
            end If
        else
            read_SECY_CNT_value = data_low and SECY_CNT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SECY_CNT_value = &H0
        flag_SECY_CNT        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SUMMARY_PAGE0_secy_count_summary_6
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SECY_CNT                                   [31:0]           get_SECY_CNT
''                                                             set_SECY_CNT
''                                                             read_SECY_CNT
''                                                             write_SECY_CNT
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SUMMARY_PAGE0_secy_count_summary_6
    Private write_SECY_CNT_value
    Private read_SECY_CNT_value
    Private flag_SECY_CNT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &He518
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_SECY_CNT
        get_SECY_CNT = read_SECY_CNT_value
    End Property

    Property Let set_SECY_CNT(aData)
        write_SECY_CNT_value = aData
        flag_SECY_CNT        = &H1
    End Property

    Property Get read_SECY_CNT
        read
        read_SECY_CNT = read_SECY_CNT_value
    End Property

    Property Let write_SECY_CNT(aData)
        set_SECY_CNT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SECY_CNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SECY_CNT_mask = mask then
                read_SECY_CNT_value = data_low
            else
                read_SECY_CNT_value = (data_low - H8000_0000) and SECY_CNT_mask
            end If
        else
            read_SECY_CNT_value = data_low and SECY_CNT_mask
        end If

    End Sub

    Sub write
        If flag_SECY_CNT = &H0 Then read
        If flag_SECY_CNT = &H0 Then write_SECY_CNT_value = get_SECY_CNT

        regValue = leftShift(write_SECY_CNT_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SECY_CNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SECY_CNT_mask = mask then
                read_SECY_CNT_value = data_low
            else
                read_SECY_CNT_value = (data_low - H8000_0000) and SECY_CNT_mask
            end If
        else
            read_SECY_CNT_value = data_low and SECY_CNT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SECY_CNT_value = &H0
        flag_SECY_CNT        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SUMMARY_PAGE0_secy_count_summary_7
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SECY_CNT                                   [31:0]           get_SECY_CNT
''                                                             set_SECY_CNT
''                                                             read_SECY_CNT
''                                                             write_SECY_CNT
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SUMMARY_PAGE0_secy_count_summary_7
    Private write_SECY_CNT_value
    Private read_SECY_CNT_value
    Private flag_SECY_CNT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &He51c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_SECY_CNT
        get_SECY_CNT = read_SECY_CNT_value
    End Property

    Property Let set_SECY_CNT(aData)
        write_SECY_CNT_value = aData
        flag_SECY_CNT        = &H1
    End Property

    Property Get read_SECY_CNT
        read
        read_SECY_CNT = read_SECY_CNT_value
    End Property

    Property Let write_SECY_CNT(aData)
        set_SECY_CNT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SECY_CNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SECY_CNT_mask = mask then
                read_SECY_CNT_value = data_low
            else
                read_SECY_CNT_value = (data_low - H8000_0000) and SECY_CNT_mask
            end If
        else
            read_SECY_CNT_value = data_low and SECY_CNT_mask
        end If

    End Sub

    Sub write
        If flag_SECY_CNT = &H0 Then read
        If flag_SECY_CNT = &H0 Then write_SECY_CNT_value = get_SECY_CNT

        regValue = leftShift(write_SECY_CNT_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SECY_CNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SECY_CNT_mask = mask then
                read_SECY_CNT_value = data_low
            else
                read_SECY_CNT_value = (data_low - H8000_0000) and SECY_CNT_mask
            end If
        else
            read_SECY_CNT_value = data_low and SECY_CNT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SECY_CNT_value = &H0
        flag_SECY_CNT        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SUMMARY_PAGE0_secy_count_summary_8
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SECY_CNT                                   [31:0]           get_SECY_CNT
''                                                             set_SECY_CNT
''                                                             read_SECY_CNT
''                                                             write_SECY_CNT
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SUMMARY_PAGE0_secy_count_summary_8
    Private write_SECY_CNT_value
    Private read_SECY_CNT_value
    Private flag_SECY_CNT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &He520
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_SECY_CNT
        get_SECY_CNT = read_SECY_CNT_value
    End Property

    Property Let set_SECY_CNT(aData)
        write_SECY_CNT_value = aData
        flag_SECY_CNT        = &H1
    End Property

    Property Get read_SECY_CNT
        read
        read_SECY_CNT = read_SECY_CNT_value
    End Property

    Property Let write_SECY_CNT(aData)
        set_SECY_CNT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SECY_CNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SECY_CNT_mask = mask then
                read_SECY_CNT_value = data_low
            else
                read_SECY_CNT_value = (data_low - H8000_0000) and SECY_CNT_mask
            end If
        else
            read_SECY_CNT_value = data_low and SECY_CNT_mask
        end If

    End Sub

    Sub write
        If flag_SECY_CNT = &H0 Then read
        If flag_SECY_CNT = &H0 Then write_SECY_CNT_value = get_SECY_CNT

        regValue = leftShift(write_SECY_CNT_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SECY_CNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SECY_CNT_mask = mask then
                read_SECY_CNT_value = data_low
            else
                read_SECY_CNT_value = (data_low - H8000_0000) and SECY_CNT_mask
            end If
        else
            read_SECY_CNT_value = data_low and SECY_CNT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SECY_CNT_value = &H0
        flag_SECY_CNT        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SUMMARY_PAGE0_secy_count_summary_9
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SECY_CNT                                   [31:0]           get_SECY_CNT
''                                                             set_SECY_CNT
''                                                             read_SECY_CNT
''                                                             write_SECY_CNT
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SUMMARY_PAGE0_secy_count_summary_9
    Private write_SECY_CNT_value
    Private read_SECY_CNT_value
    Private flag_SECY_CNT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &He524
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_SECY_CNT
        get_SECY_CNT = read_SECY_CNT_value
    End Property

    Property Let set_SECY_CNT(aData)
        write_SECY_CNT_value = aData
        flag_SECY_CNT        = &H1
    End Property

    Property Get read_SECY_CNT
        read
        read_SECY_CNT = read_SECY_CNT_value
    End Property

    Property Let write_SECY_CNT(aData)
        set_SECY_CNT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SECY_CNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SECY_CNT_mask = mask then
                read_SECY_CNT_value = data_low
            else
                read_SECY_CNT_value = (data_low - H8000_0000) and SECY_CNT_mask
            end If
        else
            read_SECY_CNT_value = data_low and SECY_CNT_mask
        end If

    End Sub

    Sub write
        If flag_SECY_CNT = &H0 Then read
        If flag_SECY_CNT = &H0 Then write_SECY_CNT_value = get_SECY_CNT

        regValue = leftShift(write_SECY_CNT_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SECY_CNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SECY_CNT_mask = mask then
                read_SECY_CNT_value = data_low
            else
                read_SECY_CNT_value = (data_low - H8000_0000) and SECY_CNT_mask
            end If
        else
            read_SECY_CNT_value = data_low and SECY_CNT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SECY_CNT_value = &H0
        flag_SECY_CNT        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SUMMARY_PAGE0_secy_count_summary_10
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SECY_CNT                                   [31:0]           get_SECY_CNT
''                                                             set_SECY_CNT
''                                                             read_SECY_CNT
''                                                             write_SECY_CNT
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SUMMARY_PAGE0_secy_count_summary_10
    Private write_SECY_CNT_value
    Private read_SECY_CNT_value
    Private flag_SECY_CNT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &He528
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_SECY_CNT
        get_SECY_CNT = read_SECY_CNT_value
    End Property

    Property Let set_SECY_CNT(aData)
        write_SECY_CNT_value = aData
        flag_SECY_CNT        = &H1
    End Property

    Property Get read_SECY_CNT
        read
        read_SECY_CNT = read_SECY_CNT_value
    End Property

    Property Let write_SECY_CNT(aData)
        set_SECY_CNT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SECY_CNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SECY_CNT_mask = mask then
                read_SECY_CNT_value = data_low
            else
                read_SECY_CNT_value = (data_low - H8000_0000) and SECY_CNT_mask
            end If
        else
            read_SECY_CNT_value = data_low and SECY_CNT_mask
        end If

    End Sub

    Sub write
        If flag_SECY_CNT = &H0 Then read
        If flag_SECY_CNT = &H0 Then write_SECY_CNT_value = get_SECY_CNT

        regValue = leftShift(write_SECY_CNT_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SECY_CNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SECY_CNT_mask = mask then
                read_SECY_CNT_value = data_low
            else
                read_SECY_CNT_value = (data_low - H8000_0000) and SECY_CNT_mask
            end If
        else
            read_SECY_CNT_value = data_low and SECY_CNT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SECY_CNT_value = &H0
        flag_SECY_CNT        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SUMMARY_PAGE0_secy_count_summary_11
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SECY_CNT                                   [31:0]           get_SECY_CNT
''                                                             set_SECY_CNT
''                                                             read_SECY_CNT
''                                                             write_SECY_CNT
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SUMMARY_PAGE0_secy_count_summary_11
    Private write_SECY_CNT_value
    Private read_SECY_CNT_value
    Private flag_SECY_CNT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &He52c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_SECY_CNT
        get_SECY_CNT = read_SECY_CNT_value
    End Property

    Property Let set_SECY_CNT(aData)
        write_SECY_CNT_value = aData
        flag_SECY_CNT        = &H1
    End Property

    Property Get read_SECY_CNT
        read
        read_SECY_CNT = read_SECY_CNT_value
    End Property

    Property Let write_SECY_CNT(aData)
        set_SECY_CNT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SECY_CNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SECY_CNT_mask = mask then
                read_SECY_CNT_value = data_low
            else
                read_SECY_CNT_value = (data_low - H8000_0000) and SECY_CNT_mask
            end If
        else
            read_SECY_CNT_value = data_low and SECY_CNT_mask
        end If

    End Sub

    Sub write
        If flag_SECY_CNT = &H0 Then read
        If flag_SECY_CNT = &H0 Then write_SECY_CNT_value = get_SECY_CNT

        regValue = leftShift(write_SECY_CNT_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SECY_CNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SECY_CNT_mask = mask then
                read_SECY_CNT_value = data_low
            else
                read_SECY_CNT_value = (data_low - H8000_0000) and SECY_CNT_mask
            end If
        else
            read_SECY_CNT_value = data_low and SECY_CNT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SECY_CNT_value = &H0
        flag_SECY_CNT        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SUMMARY_PAGE0_secy_count_summary_12
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SECY_CNT                                   [31:0]           get_SECY_CNT
''                                                             set_SECY_CNT
''                                                             read_SECY_CNT
''                                                             write_SECY_CNT
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SUMMARY_PAGE0_secy_count_summary_12
    Private write_SECY_CNT_value
    Private read_SECY_CNT_value
    Private flag_SECY_CNT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &He530
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_SECY_CNT
        get_SECY_CNT = read_SECY_CNT_value
    End Property

    Property Let set_SECY_CNT(aData)
        write_SECY_CNT_value = aData
        flag_SECY_CNT        = &H1
    End Property

    Property Get read_SECY_CNT
        read
        read_SECY_CNT = read_SECY_CNT_value
    End Property

    Property Let write_SECY_CNT(aData)
        set_SECY_CNT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SECY_CNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SECY_CNT_mask = mask then
                read_SECY_CNT_value = data_low
            else
                read_SECY_CNT_value = (data_low - H8000_0000) and SECY_CNT_mask
            end If
        else
            read_SECY_CNT_value = data_low and SECY_CNT_mask
        end If

    End Sub

    Sub write
        If flag_SECY_CNT = &H0 Then read
        If flag_SECY_CNT = &H0 Then write_SECY_CNT_value = get_SECY_CNT

        regValue = leftShift(write_SECY_CNT_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SECY_CNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SECY_CNT_mask = mask then
                read_SECY_CNT_value = data_low
            else
                read_SECY_CNT_value = (data_low - H8000_0000) and SECY_CNT_mask
            end If
        else
            read_SECY_CNT_value = data_low and SECY_CNT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SECY_CNT_value = &H0
        flag_SECY_CNT        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SUMMARY_PAGE0_secy_count_summary_13
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SECY_CNT                                   [31:0]           get_SECY_CNT
''                                                             set_SECY_CNT
''                                                             read_SECY_CNT
''                                                             write_SECY_CNT
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SUMMARY_PAGE0_secy_count_summary_13
    Private write_SECY_CNT_value
    Private read_SECY_CNT_value
    Private flag_SECY_CNT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &He534
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_SECY_CNT
        get_SECY_CNT = read_SECY_CNT_value
    End Property

    Property Let set_SECY_CNT(aData)
        write_SECY_CNT_value = aData
        flag_SECY_CNT        = &H1
    End Property

    Property Get read_SECY_CNT
        read
        read_SECY_CNT = read_SECY_CNT_value
    End Property

    Property Let write_SECY_CNT(aData)
        set_SECY_CNT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SECY_CNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SECY_CNT_mask = mask then
                read_SECY_CNT_value = data_low
            else
                read_SECY_CNT_value = (data_low - H8000_0000) and SECY_CNT_mask
            end If
        else
            read_SECY_CNT_value = data_low and SECY_CNT_mask
        end If

    End Sub

    Sub write
        If flag_SECY_CNT = &H0 Then read
        If flag_SECY_CNT = &H0 Then write_SECY_CNT_value = get_SECY_CNT

        regValue = leftShift(write_SECY_CNT_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SECY_CNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SECY_CNT_mask = mask then
                read_SECY_CNT_value = data_low
            else
                read_SECY_CNT_value = (data_low - H8000_0000) and SECY_CNT_mask
            end If
        else
            read_SECY_CNT_value = data_low and SECY_CNT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SECY_CNT_value = &H0
        flag_SECY_CNT        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SUMMARY_PAGE0_secy_count_summary_14
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SECY_CNT                                   [31:0]           get_SECY_CNT
''                                                             set_SECY_CNT
''                                                             read_SECY_CNT
''                                                             write_SECY_CNT
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SUMMARY_PAGE0_secy_count_summary_14
    Private write_SECY_CNT_value
    Private read_SECY_CNT_value
    Private flag_SECY_CNT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &He538
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_SECY_CNT
        get_SECY_CNT = read_SECY_CNT_value
    End Property

    Property Let set_SECY_CNT(aData)
        write_SECY_CNT_value = aData
        flag_SECY_CNT        = &H1
    End Property

    Property Get read_SECY_CNT
        read
        read_SECY_CNT = read_SECY_CNT_value
    End Property

    Property Let write_SECY_CNT(aData)
        set_SECY_CNT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SECY_CNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SECY_CNT_mask = mask then
                read_SECY_CNT_value = data_low
            else
                read_SECY_CNT_value = (data_low - H8000_0000) and SECY_CNT_mask
            end If
        else
            read_SECY_CNT_value = data_low and SECY_CNT_mask
        end If

    End Sub

    Sub write
        If flag_SECY_CNT = &H0 Then read
        If flag_SECY_CNT = &H0 Then write_SECY_CNT_value = get_SECY_CNT

        regValue = leftShift(write_SECY_CNT_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SECY_CNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SECY_CNT_mask = mask then
                read_SECY_CNT_value = data_low
            else
                read_SECY_CNT_value = (data_low - H8000_0000) and SECY_CNT_mask
            end If
        else
            read_SECY_CNT_value = data_low and SECY_CNT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SECY_CNT_value = &H0
        flag_SECY_CNT        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SUMMARY_PAGE0_secy_count_summary_15
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SECY_CNT                                   [31:0]           get_SECY_CNT
''                                                             set_SECY_CNT
''                                                             read_SECY_CNT
''                                                             write_SECY_CNT
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SUMMARY_PAGE0_secy_count_summary_15
    Private write_SECY_CNT_value
    Private read_SECY_CNT_value
    Private flag_SECY_CNT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &He53c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_SECY_CNT
        get_SECY_CNT = read_SECY_CNT_value
    End Property

    Property Let set_SECY_CNT(aData)
        write_SECY_CNT_value = aData
        flag_SECY_CNT        = &H1
    End Property

    Property Get read_SECY_CNT
        read
        read_SECY_CNT = read_SECY_CNT_value
    End Property

    Property Let write_SECY_CNT(aData)
        set_SECY_CNT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SECY_CNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SECY_CNT_mask = mask then
                read_SECY_CNT_value = data_low
            else
                read_SECY_CNT_value = (data_low - H8000_0000) and SECY_CNT_mask
            end If
        else
            read_SECY_CNT_value = data_low and SECY_CNT_mask
        end If

    End Sub

    Sub write
        If flag_SECY_CNT = &H0 Then read
        If flag_SECY_CNT = &H0 Then write_SECY_CNT_value = get_SECY_CNT

        regValue = leftShift(write_SECY_CNT_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SECY_CNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SECY_CNT_mask = mask then
                read_SECY_CNT_value = data_low
            else
                read_SECY_CNT_value = (data_low - H8000_0000) and SECY_CNT_mask
            end If
        else
            read_SECY_CNT_value = data_low and SECY_CNT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SECY_CNT_value = &H0
        flag_SECY_CNT        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class EIP165S_EIP165_IGEIP160_STATSECY_SECY_SUMMARY_PAGE0_INSTANCE

    Public secy_count_summary_0
    Public secy_count_summary_1
    Public secy_count_summary_2
    Public secy_count_summary_3
    Public secy_count_summary_4
    Public secy_count_summary_5
    Public secy_count_summary_6
    Public secy_count_summary_7
    Public secy_count_summary_8
    Public secy_count_summary_9
    Public secy_count_summary_10
    Public secy_count_summary_11
    Public secy_count_summary_12
    Public secy_count_summary_13
    Public secy_count_summary_14
    Public secy_count_summary_15


    Public default function Init(aBaseAddr)
        Set secy_count_summary_0 = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SUMMARY_PAGE0_secy_count_summary_0)(aBaseAddr, 32)
        Set secy_count_summary_1 = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SUMMARY_PAGE0_secy_count_summary_1)(aBaseAddr, 32)
        Set secy_count_summary_2 = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SUMMARY_PAGE0_secy_count_summary_2)(aBaseAddr, 32)
        Set secy_count_summary_3 = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SUMMARY_PAGE0_secy_count_summary_3)(aBaseAddr, 32)
        Set secy_count_summary_4 = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SUMMARY_PAGE0_secy_count_summary_4)(aBaseAddr, 32)
        Set secy_count_summary_5 = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SUMMARY_PAGE0_secy_count_summary_5)(aBaseAddr, 32)
        Set secy_count_summary_6 = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SUMMARY_PAGE0_secy_count_summary_6)(aBaseAddr, 32)
        Set secy_count_summary_7 = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SUMMARY_PAGE0_secy_count_summary_7)(aBaseAddr, 32)
        Set secy_count_summary_8 = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SUMMARY_PAGE0_secy_count_summary_8)(aBaseAddr, 32)
        Set secy_count_summary_9 = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SUMMARY_PAGE0_secy_count_summary_9)(aBaseAddr, 32)
        Set secy_count_summary_10 = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SUMMARY_PAGE0_secy_count_summary_10)(aBaseAddr, 32)
        Set secy_count_summary_11 = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SUMMARY_PAGE0_secy_count_summary_11)(aBaseAddr, 32)
        Set secy_count_summary_12 = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SUMMARY_PAGE0_secy_count_summary_12)(aBaseAddr, 32)
        Set secy_count_summary_13 = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SUMMARY_PAGE0_secy_count_summary_13)(aBaseAddr, 32)
        Set secy_count_summary_14 = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SUMMARY_PAGE0_secy_count_summary_14)(aBaseAddr, 32)
        Set secy_count_summary_15 = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SUMMARY_PAGE0_secy_count_summary_15)(aBaseAddr, 32)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set EIP165S_EIP165_IGEIP160_STATSECY_SECY_SUMMARY_PAGE0 = CreateObject("System.Collections.ArrayList")
EIP165S_EIP165_IGEIP160_STATSECY_SECY_SUMMARY_PAGE0.Add ((New EIP165S_EIP165_IGEIP160_STATSECY_SECY_SUMMARY_PAGE0_INSTANCE)(&H4d010000))
EIP165S_EIP165_IGEIP160_STATSECY_SECY_SUMMARY_PAGE0.Add ((New EIP165S_EIP165_IGEIP160_STATSECY_SECY_SUMMARY_PAGE0_INSTANCE)(&H4d110000))
EIP165S_EIP165_IGEIP160_STATSECY_SECY_SUMMARY_PAGE0.Add ((New EIP165S_EIP165_IGEIP160_STATSECY_SECY_SUMMARY_PAGE0_INSTANCE)(&H4d210000))
EIP165S_EIP165_IGEIP160_STATSECY_SECY_SUMMARY_PAGE0.Add ((New EIP165S_EIP165_IGEIP160_STATSECY_SECY_SUMMARY_PAGE0_INSTANCE)(&H4d310000))
EIP165S_EIP165_IGEIP160_STATSECY_SECY_SUMMARY_PAGE0.Add ((New EIP165S_EIP165_IGEIP160_STATSECY_SECY_SUMMARY_PAGE0_INSTANCE)(&H4d410000))
EIP165S_EIP165_IGEIP160_STATSECY_SECY_SUMMARY_PAGE0.Add ((New EIP165S_EIP165_IGEIP160_STATSECY_SECY_SUMMARY_PAGE0_INSTANCE)(&H4d510000))


