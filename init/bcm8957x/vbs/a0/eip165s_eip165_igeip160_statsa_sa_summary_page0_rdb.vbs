

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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSA_SA_SUMMARY_PAGE0_sa_count_summary_0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SA_CNT                                     [31:0]           get_SA_CNT
''                                                             set_SA_CNT
''                                                             read_SA_CNT
''                                                             write_SA_CNT
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSA_SA_SUMMARY_PAGE0_sa_count_summary_0
    Private write_SA_CNT_value
    Private read_SA_CNT_value
    Private flag_SA_CNT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &He300
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_SA_CNT
        get_SA_CNT = read_SA_CNT_value
    End Property

    Property Let set_SA_CNT(aData)
        write_SA_CNT_value = aData
        flag_SA_CNT        = &H1
    End Property

    Property Get read_SA_CNT
        read
        read_SA_CNT = read_SA_CNT_value
    End Property

    Property Let write_SA_CNT(aData)
        set_SA_CNT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SA_CNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SA_CNT_mask = mask then
                read_SA_CNT_value = data_low
            else
                read_SA_CNT_value = (data_low - H8000_0000) and SA_CNT_mask
            end If
        else
            read_SA_CNT_value = data_low and SA_CNT_mask
        end If

    End Sub

    Sub write
        If flag_SA_CNT = &H0 Then read
        If flag_SA_CNT = &H0 Then write_SA_CNT_value = get_SA_CNT

        regValue = leftShift(write_SA_CNT_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SA_CNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SA_CNT_mask = mask then
                read_SA_CNT_value = data_low
            else
                read_SA_CNT_value = (data_low - H8000_0000) and SA_CNT_mask
            end If
        else
            read_SA_CNT_value = data_low and SA_CNT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SA_CNT_value = &H0
        flag_SA_CNT        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSA_SA_SUMMARY_PAGE0_sa_count_summary_1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SA_CNT                                     [31:0]           get_SA_CNT
''                                                             set_SA_CNT
''                                                             read_SA_CNT
''                                                             write_SA_CNT
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSA_SA_SUMMARY_PAGE0_sa_count_summary_1
    Private write_SA_CNT_value
    Private read_SA_CNT_value
    Private flag_SA_CNT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &He304
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_SA_CNT
        get_SA_CNT = read_SA_CNT_value
    End Property

    Property Let set_SA_CNT(aData)
        write_SA_CNT_value = aData
        flag_SA_CNT        = &H1
    End Property

    Property Get read_SA_CNT
        read
        read_SA_CNT = read_SA_CNT_value
    End Property

    Property Let write_SA_CNT(aData)
        set_SA_CNT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SA_CNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SA_CNT_mask = mask then
                read_SA_CNT_value = data_low
            else
                read_SA_CNT_value = (data_low - H8000_0000) and SA_CNT_mask
            end If
        else
            read_SA_CNT_value = data_low and SA_CNT_mask
        end If

    End Sub

    Sub write
        If flag_SA_CNT = &H0 Then read
        If flag_SA_CNT = &H0 Then write_SA_CNT_value = get_SA_CNT

        regValue = leftShift(write_SA_CNT_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SA_CNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SA_CNT_mask = mask then
                read_SA_CNT_value = data_low
            else
                read_SA_CNT_value = (data_low - H8000_0000) and SA_CNT_mask
            end If
        else
            read_SA_CNT_value = data_low and SA_CNT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SA_CNT_value = &H0
        flag_SA_CNT        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSA_SA_SUMMARY_PAGE0_sa_count_summary_2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SA_CNT                                     [31:0]           get_SA_CNT
''                                                             set_SA_CNT
''                                                             read_SA_CNT
''                                                             write_SA_CNT
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSA_SA_SUMMARY_PAGE0_sa_count_summary_2
    Private write_SA_CNT_value
    Private read_SA_CNT_value
    Private flag_SA_CNT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &He308
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_SA_CNT
        get_SA_CNT = read_SA_CNT_value
    End Property

    Property Let set_SA_CNT(aData)
        write_SA_CNT_value = aData
        flag_SA_CNT        = &H1
    End Property

    Property Get read_SA_CNT
        read
        read_SA_CNT = read_SA_CNT_value
    End Property

    Property Let write_SA_CNT(aData)
        set_SA_CNT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SA_CNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SA_CNT_mask = mask then
                read_SA_CNT_value = data_low
            else
                read_SA_CNT_value = (data_low - H8000_0000) and SA_CNT_mask
            end If
        else
            read_SA_CNT_value = data_low and SA_CNT_mask
        end If

    End Sub

    Sub write
        If flag_SA_CNT = &H0 Then read
        If flag_SA_CNT = &H0 Then write_SA_CNT_value = get_SA_CNT

        regValue = leftShift(write_SA_CNT_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SA_CNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SA_CNT_mask = mask then
                read_SA_CNT_value = data_low
            else
                read_SA_CNT_value = (data_low - H8000_0000) and SA_CNT_mask
            end If
        else
            read_SA_CNT_value = data_low and SA_CNT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SA_CNT_value = &H0
        flag_SA_CNT        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSA_SA_SUMMARY_PAGE0_sa_count_summary_3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SA_CNT                                     [31:0]           get_SA_CNT
''                                                             set_SA_CNT
''                                                             read_SA_CNT
''                                                             write_SA_CNT
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSA_SA_SUMMARY_PAGE0_sa_count_summary_3
    Private write_SA_CNT_value
    Private read_SA_CNT_value
    Private flag_SA_CNT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &He30c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_SA_CNT
        get_SA_CNT = read_SA_CNT_value
    End Property

    Property Let set_SA_CNT(aData)
        write_SA_CNT_value = aData
        flag_SA_CNT        = &H1
    End Property

    Property Get read_SA_CNT
        read
        read_SA_CNT = read_SA_CNT_value
    End Property

    Property Let write_SA_CNT(aData)
        set_SA_CNT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SA_CNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SA_CNT_mask = mask then
                read_SA_CNT_value = data_low
            else
                read_SA_CNT_value = (data_low - H8000_0000) and SA_CNT_mask
            end If
        else
            read_SA_CNT_value = data_low and SA_CNT_mask
        end If

    End Sub

    Sub write
        If flag_SA_CNT = &H0 Then read
        If flag_SA_CNT = &H0 Then write_SA_CNT_value = get_SA_CNT

        regValue = leftShift(write_SA_CNT_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SA_CNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SA_CNT_mask = mask then
                read_SA_CNT_value = data_low
            else
                read_SA_CNT_value = (data_low - H8000_0000) and SA_CNT_mask
            end If
        else
            read_SA_CNT_value = data_low and SA_CNT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SA_CNT_value = &H0
        flag_SA_CNT        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSA_SA_SUMMARY_PAGE0_sa_count_summary_4
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SA_CNT                                     [31:0]           get_SA_CNT
''                                                             set_SA_CNT
''                                                             read_SA_CNT
''                                                             write_SA_CNT
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSA_SA_SUMMARY_PAGE0_sa_count_summary_4
    Private write_SA_CNT_value
    Private read_SA_CNT_value
    Private flag_SA_CNT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &He310
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_SA_CNT
        get_SA_CNT = read_SA_CNT_value
    End Property

    Property Let set_SA_CNT(aData)
        write_SA_CNT_value = aData
        flag_SA_CNT        = &H1
    End Property

    Property Get read_SA_CNT
        read
        read_SA_CNT = read_SA_CNT_value
    End Property

    Property Let write_SA_CNT(aData)
        set_SA_CNT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SA_CNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SA_CNT_mask = mask then
                read_SA_CNT_value = data_low
            else
                read_SA_CNT_value = (data_low - H8000_0000) and SA_CNT_mask
            end If
        else
            read_SA_CNT_value = data_low and SA_CNT_mask
        end If

    End Sub

    Sub write
        If flag_SA_CNT = &H0 Then read
        If flag_SA_CNT = &H0 Then write_SA_CNT_value = get_SA_CNT

        regValue = leftShift(write_SA_CNT_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SA_CNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SA_CNT_mask = mask then
                read_SA_CNT_value = data_low
            else
                read_SA_CNT_value = (data_low - H8000_0000) and SA_CNT_mask
            end If
        else
            read_SA_CNT_value = data_low and SA_CNT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SA_CNT_value = &H0
        flag_SA_CNT        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSA_SA_SUMMARY_PAGE0_sa_count_summary_5
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SA_CNT                                     [31:0]           get_SA_CNT
''                                                             set_SA_CNT
''                                                             read_SA_CNT
''                                                             write_SA_CNT
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSA_SA_SUMMARY_PAGE0_sa_count_summary_5
    Private write_SA_CNT_value
    Private read_SA_CNT_value
    Private flag_SA_CNT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &He314
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_SA_CNT
        get_SA_CNT = read_SA_CNT_value
    End Property

    Property Let set_SA_CNT(aData)
        write_SA_CNT_value = aData
        flag_SA_CNT        = &H1
    End Property

    Property Get read_SA_CNT
        read
        read_SA_CNT = read_SA_CNT_value
    End Property

    Property Let write_SA_CNT(aData)
        set_SA_CNT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SA_CNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SA_CNT_mask = mask then
                read_SA_CNT_value = data_low
            else
                read_SA_CNT_value = (data_low - H8000_0000) and SA_CNT_mask
            end If
        else
            read_SA_CNT_value = data_low and SA_CNT_mask
        end If

    End Sub

    Sub write
        If flag_SA_CNT = &H0 Then read
        If flag_SA_CNT = &H0 Then write_SA_CNT_value = get_SA_CNT

        regValue = leftShift(write_SA_CNT_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SA_CNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SA_CNT_mask = mask then
                read_SA_CNT_value = data_low
            else
                read_SA_CNT_value = (data_low - H8000_0000) and SA_CNT_mask
            end If
        else
            read_SA_CNT_value = data_low and SA_CNT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SA_CNT_value = &H0
        flag_SA_CNT        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSA_SA_SUMMARY_PAGE0_sa_count_summary_6
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SA_CNT                                     [31:0]           get_SA_CNT
''                                                             set_SA_CNT
''                                                             read_SA_CNT
''                                                             write_SA_CNT
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSA_SA_SUMMARY_PAGE0_sa_count_summary_6
    Private write_SA_CNT_value
    Private read_SA_CNT_value
    Private flag_SA_CNT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &He318
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_SA_CNT
        get_SA_CNT = read_SA_CNT_value
    End Property

    Property Let set_SA_CNT(aData)
        write_SA_CNT_value = aData
        flag_SA_CNT        = &H1
    End Property

    Property Get read_SA_CNT
        read
        read_SA_CNT = read_SA_CNT_value
    End Property

    Property Let write_SA_CNT(aData)
        set_SA_CNT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SA_CNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SA_CNT_mask = mask then
                read_SA_CNT_value = data_low
            else
                read_SA_CNT_value = (data_low - H8000_0000) and SA_CNT_mask
            end If
        else
            read_SA_CNT_value = data_low and SA_CNT_mask
        end If

    End Sub

    Sub write
        If flag_SA_CNT = &H0 Then read
        If flag_SA_CNT = &H0 Then write_SA_CNT_value = get_SA_CNT

        regValue = leftShift(write_SA_CNT_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SA_CNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SA_CNT_mask = mask then
                read_SA_CNT_value = data_low
            else
                read_SA_CNT_value = (data_low - H8000_0000) and SA_CNT_mask
            end If
        else
            read_SA_CNT_value = data_low and SA_CNT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SA_CNT_value = &H0
        flag_SA_CNT        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSA_SA_SUMMARY_PAGE0_sa_count_summary_7
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SA_CNT                                     [31:0]           get_SA_CNT
''                                                             set_SA_CNT
''                                                             read_SA_CNT
''                                                             write_SA_CNT
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSA_SA_SUMMARY_PAGE0_sa_count_summary_7
    Private write_SA_CNT_value
    Private read_SA_CNT_value
    Private flag_SA_CNT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &He31c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_SA_CNT
        get_SA_CNT = read_SA_CNT_value
    End Property

    Property Let set_SA_CNT(aData)
        write_SA_CNT_value = aData
        flag_SA_CNT        = &H1
    End Property

    Property Get read_SA_CNT
        read
        read_SA_CNT = read_SA_CNT_value
    End Property

    Property Let write_SA_CNT(aData)
        set_SA_CNT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SA_CNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SA_CNT_mask = mask then
                read_SA_CNT_value = data_low
            else
                read_SA_CNT_value = (data_low - H8000_0000) and SA_CNT_mask
            end If
        else
            read_SA_CNT_value = data_low and SA_CNT_mask
        end If

    End Sub

    Sub write
        If flag_SA_CNT = &H0 Then read
        If flag_SA_CNT = &H0 Then write_SA_CNT_value = get_SA_CNT

        regValue = leftShift(write_SA_CNT_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SA_CNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SA_CNT_mask = mask then
                read_SA_CNT_value = data_low
            else
                read_SA_CNT_value = (data_low - H8000_0000) and SA_CNT_mask
            end If
        else
            read_SA_CNT_value = data_low and SA_CNT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SA_CNT_value = &H0
        flag_SA_CNT        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSA_SA_SUMMARY_PAGE0_sa_count_summary_8
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SA_CNT                                     [31:0]           get_SA_CNT
''                                                             set_SA_CNT
''                                                             read_SA_CNT
''                                                             write_SA_CNT
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSA_SA_SUMMARY_PAGE0_sa_count_summary_8
    Private write_SA_CNT_value
    Private read_SA_CNT_value
    Private flag_SA_CNT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &He320
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_SA_CNT
        get_SA_CNT = read_SA_CNT_value
    End Property

    Property Let set_SA_CNT(aData)
        write_SA_CNT_value = aData
        flag_SA_CNT        = &H1
    End Property

    Property Get read_SA_CNT
        read
        read_SA_CNT = read_SA_CNT_value
    End Property

    Property Let write_SA_CNT(aData)
        set_SA_CNT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SA_CNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SA_CNT_mask = mask then
                read_SA_CNT_value = data_low
            else
                read_SA_CNT_value = (data_low - H8000_0000) and SA_CNT_mask
            end If
        else
            read_SA_CNT_value = data_low and SA_CNT_mask
        end If

    End Sub

    Sub write
        If flag_SA_CNT = &H0 Then read
        If flag_SA_CNT = &H0 Then write_SA_CNT_value = get_SA_CNT

        regValue = leftShift(write_SA_CNT_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SA_CNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SA_CNT_mask = mask then
                read_SA_CNT_value = data_low
            else
                read_SA_CNT_value = (data_low - H8000_0000) and SA_CNT_mask
            end If
        else
            read_SA_CNT_value = data_low and SA_CNT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SA_CNT_value = &H0
        flag_SA_CNT        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSA_SA_SUMMARY_PAGE0_sa_count_summary_9
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SA_CNT                                     [31:0]           get_SA_CNT
''                                                             set_SA_CNT
''                                                             read_SA_CNT
''                                                             write_SA_CNT
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSA_SA_SUMMARY_PAGE0_sa_count_summary_9
    Private write_SA_CNT_value
    Private read_SA_CNT_value
    Private flag_SA_CNT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &He324
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_SA_CNT
        get_SA_CNT = read_SA_CNT_value
    End Property

    Property Let set_SA_CNT(aData)
        write_SA_CNT_value = aData
        flag_SA_CNT        = &H1
    End Property

    Property Get read_SA_CNT
        read
        read_SA_CNT = read_SA_CNT_value
    End Property

    Property Let write_SA_CNT(aData)
        set_SA_CNT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SA_CNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SA_CNT_mask = mask then
                read_SA_CNT_value = data_low
            else
                read_SA_CNT_value = (data_low - H8000_0000) and SA_CNT_mask
            end If
        else
            read_SA_CNT_value = data_low and SA_CNT_mask
        end If

    End Sub

    Sub write
        If flag_SA_CNT = &H0 Then read
        If flag_SA_CNT = &H0 Then write_SA_CNT_value = get_SA_CNT

        regValue = leftShift(write_SA_CNT_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SA_CNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SA_CNT_mask = mask then
                read_SA_CNT_value = data_low
            else
                read_SA_CNT_value = (data_low - H8000_0000) and SA_CNT_mask
            end If
        else
            read_SA_CNT_value = data_low and SA_CNT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SA_CNT_value = &H0
        flag_SA_CNT        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSA_SA_SUMMARY_PAGE0_sa_count_summary_10
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SA_CNT                                     [31:0]           get_SA_CNT
''                                                             set_SA_CNT
''                                                             read_SA_CNT
''                                                             write_SA_CNT
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSA_SA_SUMMARY_PAGE0_sa_count_summary_10
    Private write_SA_CNT_value
    Private read_SA_CNT_value
    Private flag_SA_CNT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &He328
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_SA_CNT
        get_SA_CNT = read_SA_CNT_value
    End Property

    Property Let set_SA_CNT(aData)
        write_SA_CNT_value = aData
        flag_SA_CNT        = &H1
    End Property

    Property Get read_SA_CNT
        read
        read_SA_CNT = read_SA_CNT_value
    End Property

    Property Let write_SA_CNT(aData)
        set_SA_CNT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SA_CNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SA_CNT_mask = mask then
                read_SA_CNT_value = data_low
            else
                read_SA_CNT_value = (data_low - H8000_0000) and SA_CNT_mask
            end If
        else
            read_SA_CNT_value = data_low and SA_CNT_mask
        end If

    End Sub

    Sub write
        If flag_SA_CNT = &H0 Then read
        If flag_SA_CNT = &H0 Then write_SA_CNT_value = get_SA_CNT

        regValue = leftShift(write_SA_CNT_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SA_CNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SA_CNT_mask = mask then
                read_SA_CNT_value = data_low
            else
                read_SA_CNT_value = (data_low - H8000_0000) and SA_CNT_mask
            end If
        else
            read_SA_CNT_value = data_low and SA_CNT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SA_CNT_value = &H0
        flag_SA_CNT        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSA_SA_SUMMARY_PAGE0_sa_count_summary_11
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SA_CNT                                     [31:0]           get_SA_CNT
''                                                             set_SA_CNT
''                                                             read_SA_CNT
''                                                             write_SA_CNT
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSA_SA_SUMMARY_PAGE0_sa_count_summary_11
    Private write_SA_CNT_value
    Private read_SA_CNT_value
    Private flag_SA_CNT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &He32c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_SA_CNT
        get_SA_CNT = read_SA_CNT_value
    End Property

    Property Let set_SA_CNT(aData)
        write_SA_CNT_value = aData
        flag_SA_CNT        = &H1
    End Property

    Property Get read_SA_CNT
        read
        read_SA_CNT = read_SA_CNT_value
    End Property

    Property Let write_SA_CNT(aData)
        set_SA_CNT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SA_CNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SA_CNT_mask = mask then
                read_SA_CNT_value = data_low
            else
                read_SA_CNT_value = (data_low - H8000_0000) and SA_CNT_mask
            end If
        else
            read_SA_CNT_value = data_low and SA_CNT_mask
        end If

    End Sub

    Sub write
        If flag_SA_CNT = &H0 Then read
        If flag_SA_CNT = &H0 Then write_SA_CNT_value = get_SA_CNT

        regValue = leftShift(write_SA_CNT_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SA_CNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SA_CNT_mask = mask then
                read_SA_CNT_value = data_low
            else
                read_SA_CNT_value = (data_low - H8000_0000) and SA_CNT_mask
            end If
        else
            read_SA_CNT_value = data_low and SA_CNT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SA_CNT_value = &H0
        flag_SA_CNT        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSA_SA_SUMMARY_PAGE0_sa_count_summary_12
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SA_CNT                                     [31:0]           get_SA_CNT
''                                                             set_SA_CNT
''                                                             read_SA_CNT
''                                                             write_SA_CNT
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSA_SA_SUMMARY_PAGE0_sa_count_summary_12
    Private write_SA_CNT_value
    Private read_SA_CNT_value
    Private flag_SA_CNT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &He330
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_SA_CNT
        get_SA_CNT = read_SA_CNT_value
    End Property

    Property Let set_SA_CNT(aData)
        write_SA_CNT_value = aData
        flag_SA_CNT        = &H1
    End Property

    Property Get read_SA_CNT
        read
        read_SA_CNT = read_SA_CNT_value
    End Property

    Property Let write_SA_CNT(aData)
        set_SA_CNT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SA_CNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SA_CNT_mask = mask then
                read_SA_CNT_value = data_low
            else
                read_SA_CNT_value = (data_low - H8000_0000) and SA_CNT_mask
            end If
        else
            read_SA_CNT_value = data_low and SA_CNT_mask
        end If

    End Sub

    Sub write
        If flag_SA_CNT = &H0 Then read
        If flag_SA_CNT = &H0 Then write_SA_CNT_value = get_SA_CNT

        regValue = leftShift(write_SA_CNT_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SA_CNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SA_CNT_mask = mask then
                read_SA_CNT_value = data_low
            else
                read_SA_CNT_value = (data_low - H8000_0000) and SA_CNT_mask
            end If
        else
            read_SA_CNT_value = data_low and SA_CNT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SA_CNT_value = &H0
        flag_SA_CNT        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSA_SA_SUMMARY_PAGE0_sa_count_summary_13
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SA_CNT                                     [31:0]           get_SA_CNT
''                                                             set_SA_CNT
''                                                             read_SA_CNT
''                                                             write_SA_CNT
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSA_SA_SUMMARY_PAGE0_sa_count_summary_13
    Private write_SA_CNT_value
    Private read_SA_CNT_value
    Private flag_SA_CNT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &He334
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_SA_CNT
        get_SA_CNT = read_SA_CNT_value
    End Property

    Property Let set_SA_CNT(aData)
        write_SA_CNT_value = aData
        flag_SA_CNT        = &H1
    End Property

    Property Get read_SA_CNT
        read
        read_SA_CNT = read_SA_CNT_value
    End Property

    Property Let write_SA_CNT(aData)
        set_SA_CNT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SA_CNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SA_CNT_mask = mask then
                read_SA_CNT_value = data_low
            else
                read_SA_CNT_value = (data_low - H8000_0000) and SA_CNT_mask
            end If
        else
            read_SA_CNT_value = data_low and SA_CNT_mask
        end If

    End Sub

    Sub write
        If flag_SA_CNT = &H0 Then read
        If flag_SA_CNT = &H0 Then write_SA_CNT_value = get_SA_CNT

        regValue = leftShift(write_SA_CNT_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SA_CNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SA_CNT_mask = mask then
                read_SA_CNT_value = data_low
            else
                read_SA_CNT_value = (data_low - H8000_0000) and SA_CNT_mask
            end If
        else
            read_SA_CNT_value = data_low and SA_CNT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SA_CNT_value = &H0
        flag_SA_CNT        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSA_SA_SUMMARY_PAGE0_sa_count_summary_14
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SA_CNT                                     [31:0]           get_SA_CNT
''                                                             set_SA_CNT
''                                                             read_SA_CNT
''                                                             write_SA_CNT
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSA_SA_SUMMARY_PAGE0_sa_count_summary_14
    Private write_SA_CNT_value
    Private read_SA_CNT_value
    Private flag_SA_CNT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &He338
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_SA_CNT
        get_SA_CNT = read_SA_CNT_value
    End Property

    Property Let set_SA_CNT(aData)
        write_SA_CNT_value = aData
        flag_SA_CNT        = &H1
    End Property

    Property Get read_SA_CNT
        read
        read_SA_CNT = read_SA_CNT_value
    End Property

    Property Let write_SA_CNT(aData)
        set_SA_CNT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SA_CNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SA_CNT_mask = mask then
                read_SA_CNT_value = data_low
            else
                read_SA_CNT_value = (data_low - H8000_0000) and SA_CNT_mask
            end If
        else
            read_SA_CNT_value = data_low and SA_CNT_mask
        end If

    End Sub

    Sub write
        If flag_SA_CNT = &H0 Then read
        If flag_SA_CNT = &H0 Then write_SA_CNT_value = get_SA_CNT

        regValue = leftShift(write_SA_CNT_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SA_CNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SA_CNT_mask = mask then
                read_SA_CNT_value = data_low
            else
                read_SA_CNT_value = (data_low - H8000_0000) and SA_CNT_mask
            end If
        else
            read_SA_CNT_value = data_low and SA_CNT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SA_CNT_value = &H0
        flag_SA_CNT        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSA_SA_SUMMARY_PAGE0_sa_count_summary_15
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SA_CNT                                     [31:0]           get_SA_CNT
''                                                             set_SA_CNT
''                                                             read_SA_CNT
''                                                             write_SA_CNT
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSA_SA_SUMMARY_PAGE0_sa_count_summary_15
    Private write_SA_CNT_value
    Private read_SA_CNT_value
    Private flag_SA_CNT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &He33c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_SA_CNT
        get_SA_CNT = read_SA_CNT_value
    End Property

    Property Let set_SA_CNT(aData)
        write_SA_CNT_value = aData
        flag_SA_CNT        = &H1
    End Property

    Property Get read_SA_CNT
        read
        read_SA_CNT = read_SA_CNT_value
    End Property

    Property Let write_SA_CNT(aData)
        set_SA_CNT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SA_CNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SA_CNT_mask = mask then
                read_SA_CNT_value = data_low
            else
                read_SA_CNT_value = (data_low - H8000_0000) and SA_CNT_mask
            end If
        else
            read_SA_CNT_value = data_low and SA_CNT_mask
        end If

    End Sub

    Sub write
        If flag_SA_CNT = &H0 Then read
        If flag_SA_CNT = &H0 Then write_SA_CNT_value = get_SA_CNT

        regValue = leftShift(write_SA_CNT_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SA_CNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SA_CNT_mask = mask then
                read_SA_CNT_value = data_low
            else
                read_SA_CNT_value = (data_low - H8000_0000) and SA_CNT_mask
            end If
        else
            read_SA_CNT_value = data_low and SA_CNT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SA_CNT_value = &H0
        flag_SA_CNT        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSA_SA_SUMMARY_PAGE0_sa_count_summary_16
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SA_CNT                                     [31:0]           get_SA_CNT
''                                                             set_SA_CNT
''                                                             read_SA_CNT
''                                                             write_SA_CNT
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSA_SA_SUMMARY_PAGE0_sa_count_summary_16
    Private write_SA_CNT_value
    Private read_SA_CNT_value
    Private flag_SA_CNT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &He340
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_SA_CNT
        get_SA_CNT = read_SA_CNT_value
    End Property

    Property Let set_SA_CNT(aData)
        write_SA_CNT_value = aData
        flag_SA_CNT        = &H1
    End Property

    Property Get read_SA_CNT
        read
        read_SA_CNT = read_SA_CNT_value
    End Property

    Property Let write_SA_CNT(aData)
        set_SA_CNT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SA_CNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SA_CNT_mask = mask then
                read_SA_CNT_value = data_low
            else
                read_SA_CNT_value = (data_low - H8000_0000) and SA_CNT_mask
            end If
        else
            read_SA_CNT_value = data_low and SA_CNT_mask
        end If

    End Sub

    Sub write
        If flag_SA_CNT = &H0 Then read
        If flag_SA_CNT = &H0 Then write_SA_CNT_value = get_SA_CNT

        regValue = leftShift(write_SA_CNT_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SA_CNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SA_CNT_mask = mask then
                read_SA_CNT_value = data_low
            else
                read_SA_CNT_value = (data_low - H8000_0000) and SA_CNT_mask
            end If
        else
            read_SA_CNT_value = data_low and SA_CNT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SA_CNT_value = &H0
        flag_SA_CNT        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSA_SA_SUMMARY_PAGE0_sa_count_summary_17
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SA_CNT                                     [31:0]           get_SA_CNT
''                                                             set_SA_CNT
''                                                             read_SA_CNT
''                                                             write_SA_CNT
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSA_SA_SUMMARY_PAGE0_sa_count_summary_17
    Private write_SA_CNT_value
    Private read_SA_CNT_value
    Private flag_SA_CNT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &He344
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_SA_CNT
        get_SA_CNT = read_SA_CNT_value
    End Property

    Property Let set_SA_CNT(aData)
        write_SA_CNT_value = aData
        flag_SA_CNT        = &H1
    End Property

    Property Get read_SA_CNT
        read
        read_SA_CNT = read_SA_CNT_value
    End Property

    Property Let write_SA_CNT(aData)
        set_SA_CNT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SA_CNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SA_CNT_mask = mask then
                read_SA_CNT_value = data_low
            else
                read_SA_CNT_value = (data_low - H8000_0000) and SA_CNT_mask
            end If
        else
            read_SA_CNT_value = data_low and SA_CNT_mask
        end If

    End Sub

    Sub write
        If flag_SA_CNT = &H0 Then read
        If flag_SA_CNT = &H0 Then write_SA_CNT_value = get_SA_CNT

        regValue = leftShift(write_SA_CNT_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SA_CNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SA_CNT_mask = mask then
                read_SA_CNT_value = data_low
            else
                read_SA_CNT_value = (data_low - H8000_0000) and SA_CNT_mask
            end If
        else
            read_SA_CNT_value = data_low and SA_CNT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SA_CNT_value = &H0
        flag_SA_CNT        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSA_SA_SUMMARY_PAGE0_sa_count_summary_18
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SA_CNT                                     [31:0]           get_SA_CNT
''                                                             set_SA_CNT
''                                                             read_SA_CNT
''                                                             write_SA_CNT
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSA_SA_SUMMARY_PAGE0_sa_count_summary_18
    Private write_SA_CNT_value
    Private read_SA_CNT_value
    Private flag_SA_CNT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &He348
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_SA_CNT
        get_SA_CNT = read_SA_CNT_value
    End Property

    Property Let set_SA_CNT(aData)
        write_SA_CNT_value = aData
        flag_SA_CNT        = &H1
    End Property

    Property Get read_SA_CNT
        read
        read_SA_CNT = read_SA_CNT_value
    End Property

    Property Let write_SA_CNT(aData)
        set_SA_CNT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SA_CNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SA_CNT_mask = mask then
                read_SA_CNT_value = data_low
            else
                read_SA_CNT_value = (data_low - H8000_0000) and SA_CNT_mask
            end If
        else
            read_SA_CNT_value = data_low and SA_CNT_mask
        end If

    End Sub

    Sub write
        If flag_SA_CNT = &H0 Then read
        If flag_SA_CNT = &H0 Then write_SA_CNT_value = get_SA_CNT

        regValue = leftShift(write_SA_CNT_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SA_CNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SA_CNT_mask = mask then
                read_SA_CNT_value = data_low
            else
                read_SA_CNT_value = (data_low - H8000_0000) and SA_CNT_mask
            end If
        else
            read_SA_CNT_value = data_low and SA_CNT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SA_CNT_value = &H0
        flag_SA_CNT        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSA_SA_SUMMARY_PAGE0_sa_count_summary_19
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SA_CNT                                     [31:0]           get_SA_CNT
''                                                             set_SA_CNT
''                                                             read_SA_CNT
''                                                             write_SA_CNT
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSA_SA_SUMMARY_PAGE0_sa_count_summary_19
    Private write_SA_CNT_value
    Private read_SA_CNT_value
    Private flag_SA_CNT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &He34c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_SA_CNT
        get_SA_CNT = read_SA_CNT_value
    End Property

    Property Let set_SA_CNT(aData)
        write_SA_CNT_value = aData
        flag_SA_CNT        = &H1
    End Property

    Property Get read_SA_CNT
        read
        read_SA_CNT = read_SA_CNT_value
    End Property

    Property Let write_SA_CNT(aData)
        set_SA_CNT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SA_CNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SA_CNT_mask = mask then
                read_SA_CNT_value = data_low
            else
                read_SA_CNT_value = (data_low - H8000_0000) and SA_CNT_mask
            end If
        else
            read_SA_CNT_value = data_low and SA_CNT_mask
        end If

    End Sub

    Sub write
        If flag_SA_CNT = &H0 Then read
        If flag_SA_CNT = &H0 Then write_SA_CNT_value = get_SA_CNT

        regValue = leftShift(write_SA_CNT_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SA_CNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SA_CNT_mask = mask then
                read_SA_CNT_value = data_low
            else
                read_SA_CNT_value = (data_low - H8000_0000) and SA_CNT_mask
            end If
        else
            read_SA_CNT_value = data_low and SA_CNT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SA_CNT_value = &H0
        flag_SA_CNT        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSA_SA_SUMMARY_PAGE0_sa_count_summary_20
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SA_CNT                                     [31:0]           get_SA_CNT
''                                                             set_SA_CNT
''                                                             read_SA_CNT
''                                                             write_SA_CNT
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSA_SA_SUMMARY_PAGE0_sa_count_summary_20
    Private write_SA_CNT_value
    Private read_SA_CNT_value
    Private flag_SA_CNT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &He350
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_SA_CNT
        get_SA_CNT = read_SA_CNT_value
    End Property

    Property Let set_SA_CNT(aData)
        write_SA_CNT_value = aData
        flag_SA_CNT        = &H1
    End Property

    Property Get read_SA_CNT
        read
        read_SA_CNT = read_SA_CNT_value
    End Property

    Property Let write_SA_CNT(aData)
        set_SA_CNT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SA_CNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SA_CNT_mask = mask then
                read_SA_CNT_value = data_low
            else
                read_SA_CNT_value = (data_low - H8000_0000) and SA_CNT_mask
            end If
        else
            read_SA_CNT_value = data_low and SA_CNT_mask
        end If

    End Sub

    Sub write
        If flag_SA_CNT = &H0 Then read
        If flag_SA_CNT = &H0 Then write_SA_CNT_value = get_SA_CNT

        regValue = leftShift(write_SA_CNT_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SA_CNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SA_CNT_mask = mask then
                read_SA_CNT_value = data_low
            else
                read_SA_CNT_value = (data_low - H8000_0000) and SA_CNT_mask
            end If
        else
            read_SA_CNT_value = data_low and SA_CNT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SA_CNT_value = &H0
        flag_SA_CNT        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSA_SA_SUMMARY_PAGE0_sa_count_summary_21
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SA_CNT                                     [31:0]           get_SA_CNT
''                                                             set_SA_CNT
''                                                             read_SA_CNT
''                                                             write_SA_CNT
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSA_SA_SUMMARY_PAGE0_sa_count_summary_21
    Private write_SA_CNT_value
    Private read_SA_CNT_value
    Private flag_SA_CNT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &He354
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_SA_CNT
        get_SA_CNT = read_SA_CNT_value
    End Property

    Property Let set_SA_CNT(aData)
        write_SA_CNT_value = aData
        flag_SA_CNT        = &H1
    End Property

    Property Get read_SA_CNT
        read
        read_SA_CNT = read_SA_CNT_value
    End Property

    Property Let write_SA_CNT(aData)
        set_SA_CNT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SA_CNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SA_CNT_mask = mask then
                read_SA_CNT_value = data_low
            else
                read_SA_CNT_value = (data_low - H8000_0000) and SA_CNT_mask
            end If
        else
            read_SA_CNT_value = data_low and SA_CNT_mask
        end If

    End Sub

    Sub write
        If flag_SA_CNT = &H0 Then read
        If flag_SA_CNT = &H0 Then write_SA_CNT_value = get_SA_CNT

        regValue = leftShift(write_SA_CNT_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SA_CNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SA_CNT_mask = mask then
                read_SA_CNT_value = data_low
            else
                read_SA_CNT_value = (data_low - H8000_0000) and SA_CNT_mask
            end If
        else
            read_SA_CNT_value = data_low and SA_CNT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SA_CNT_value = &H0
        flag_SA_CNT        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSA_SA_SUMMARY_PAGE0_sa_count_summary_22
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SA_CNT                                     [31:0]           get_SA_CNT
''                                                             set_SA_CNT
''                                                             read_SA_CNT
''                                                             write_SA_CNT
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSA_SA_SUMMARY_PAGE0_sa_count_summary_22
    Private write_SA_CNT_value
    Private read_SA_CNT_value
    Private flag_SA_CNT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &He358
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_SA_CNT
        get_SA_CNT = read_SA_CNT_value
    End Property

    Property Let set_SA_CNT(aData)
        write_SA_CNT_value = aData
        flag_SA_CNT        = &H1
    End Property

    Property Get read_SA_CNT
        read
        read_SA_CNT = read_SA_CNT_value
    End Property

    Property Let write_SA_CNT(aData)
        set_SA_CNT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SA_CNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SA_CNT_mask = mask then
                read_SA_CNT_value = data_low
            else
                read_SA_CNT_value = (data_low - H8000_0000) and SA_CNT_mask
            end If
        else
            read_SA_CNT_value = data_low and SA_CNT_mask
        end If

    End Sub

    Sub write
        If flag_SA_CNT = &H0 Then read
        If flag_SA_CNT = &H0 Then write_SA_CNT_value = get_SA_CNT

        regValue = leftShift(write_SA_CNT_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SA_CNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SA_CNT_mask = mask then
                read_SA_CNT_value = data_low
            else
                read_SA_CNT_value = (data_low - H8000_0000) and SA_CNT_mask
            end If
        else
            read_SA_CNT_value = data_low and SA_CNT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SA_CNT_value = &H0
        flag_SA_CNT        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSA_SA_SUMMARY_PAGE0_sa_count_summary_23
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SA_CNT                                     [31:0]           get_SA_CNT
''                                                             set_SA_CNT
''                                                             read_SA_CNT
''                                                             write_SA_CNT
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSA_SA_SUMMARY_PAGE0_sa_count_summary_23
    Private write_SA_CNT_value
    Private read_SA_CNT_value
    Private flag_SA_CNT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &He35c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_SA_CNT
        get_SA_CNT = read_SA_CNT_value
    End Property

    Property Let set_SA_CNT(aData)
        write_SA_CNT_value = aData
        flag_SA_CNT        = &H1
    End Property

    Property Get read_SA_CNT
        read
        read_SA_CNT = read_SA_CNT_value
    End Property

    Property Let write_SA_CNT(aData)
        set_SA_CNT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SA_CNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SA_CNT_mask = mask then
                read_SA_CNT_value = data_low
            else
                read_SA_CNT_value = (data_low - H8000_0000) and SA_CNT_mask
            end If
        else
            read_SA_CNT_value = data_low and SA_CNT_mask
        end If

    End Sub

    Sub write
        If flag_SA_CNT = &H0 Then read
        If flag_SA_CNT = &H0 Then write_SA_CNT_value = get_SA_CNT

        regValue = leftShift(write_SA_CNT_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SA_CNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SA_CNT_mask = mask then
                read_SA_CNT_value = data_low
            else
                read_SA_CNT_value = (data_low - H8000_0000) and SA_CNT_mask
            end If
        else
            read_SA_CNT_value = data_low and SA_CNT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SA_CNT_value = &H0
        flag_SA_CNT        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSA_SA_SUMMARY_PAGE0_sa_count_summary_24
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SA_CNT                                     [31:0]           get_SA_CNT
''                                                             set_SA_CNT
''                                                             read_SA_CNT
''                                                             write_SA_CNT
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSA_SA_SUMMARY_PAGE0_sa_count_summary_24
    Private write_SA_CNT_value
    Private read_SA_CNT_value
    Private flag_SA_CNT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &He360
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_SA_CNT
        get_SA_CNT = read_SA_CNT_value
    End Property

    Property Let set_SA_CNT(aData)
        write_SA_CNT_value = aData
        flag_SA_CNT        = &H1
    End Property

    Property Get read_SA_CNT
        read
        read_SA_CNT = read_SA_CNT_value
    End Property

    Property Let write_SA_CNT(aData)
        set_SA_CNT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SA_CNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SA_CNT_mask = mask then
                read_SA_CNT_value = data_low
            else
                read_SA_CNT_value = (data_low - H8000_0000) and SA_CNT_mask
            end If
        else
            read_SA_CNT_value = data_low and SA_CNT_mask
        end If

    End Sub

    Sub write
        If flag_SA_CNT = &H0 Then read
        If flag_SA_CNT = &H0 Then write_SA_CNT_value = get_SA_CNT

        regValue = leftShift(write_SA_CNT_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SA_CNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SA_CNT_mask = mask then
                read_SA_CNT_value = data_low
            else
                read_SA_CNT_value = (data_low - H8000_0000) and SA_CNT_mask
            end If
        else
            read_SA_CNT_value = data_low and SA_CNT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SA_CNT_value = &H0
        flag_SA_CNT        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSA_SA_SUMMARY_PAGE0_sa_count_summary_25
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SA_CNT                                     [31:0]           get_SA_CNT
''                                                             set_SA_CNT
''                                                             read_SA_CNT
''                                                             write_SA_CNT
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSA_SA_SUMMARY_PAGE0_sa_count_summary_25
    Private write_SA_CNT_value
    Private read_SA_CNT_value
    Private flag_SA_CNT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &He364
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_SA_CNT
        get_SA_CNT = read_SA_CNT_value
    End Property

    Property Let set_SA_CNT(aData)
        write_SA_CNT_value = aData
        flag_SA_CNT        = &H1
    End Property

    Property Get read_SA_CNT
        read
        read_SA_CNT = read_SA_CNT_value
    End Property

    Property Let write_SA_CNT(aData)
        set_SA_CNT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SA_CNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SA_CNT_mask = mask then
                read_SA_CNT_value = data_low
            else
                read_SA_CNT_value = (data_low - H8000_0000) and SA_CNT_mask
            end If
        else
            read_SA_CNT_value = data_low and SA_CNT_mask
        end If

    End Sub

    Sub write
        If flag_SA_CNT = &H0 Then read
        If flag_SA_CNT = &H0 Then write_SA_CNT_value = get_SA_CNT

        regValue = leftShift(write_SA_CNT_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SA_CNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SA_CNT_mask = mask then
                read_SA_CNT_value = data_low
            else
                read_SA_CNT_value = (data_low - H8000_0000) and SA_CNT_mask
            end If
        else
            read_SA_CNT_value = data_low and SA_CNT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SA_CNT_value = &H0
        flag_SA_CNT        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSA_SA_SUMMARY_PAGE0_sa_count_summary_26
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SA_CNT                                     [31:0]           get_SA_CNT
''                                                             set_SA_CNT
''                                                             read_SA_CNT
''                                                             write_SA_CNT
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSA_SA_SUMMARY_PAGE0_sa_count_summary_26
    Private write_SA_CNT_value
    Private read_SA_CNT_value
    Private flag_SA_CNT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &He368
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_SA_CNT
        get_SA_CNT = read_SA_CNT_value
    End Property

    Property Let set_SA_CNT(aData)
        write_SA_CNT_value = aData
        flag_SA_CNT        = &H1
    End Property

    Property Get read_SA_CNT
        read
        read_SA_CNT = read_SA_CNT_value
    End Property

    Property Let write_SA_CNT(aData)
        set_SA_CNT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SA_CNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SA_CNT_mask = mask then
                read_SA_CNT_value = data_low
            else
                read_SA_CNT_value = (data_low - H8000_0000) and SA_CNT_mask
            end If
        else
            read_SA_CNT_value = data_low and SA_CNT_mask
        end If

    End Sub

    Sub write
        If flag_SA_CNT = &H0 Then read
        If flag_SA_CNT = &H0 Then write_SA_CNT_value = get_SA_CNT

        regValue = leftShift(write_SA_CNT_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SA_CNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SA_CNT_mask = mask then
                read_SA_CNT_value = data_low
            else
                read_SA_CNT_value = (data_low - H8000_0000) and SA_CNT_mask
            end If
        else
            read_SA_CNT_value = data_low and SA_CNT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SA_CNT_value = &H0
        flag_SA_CNT        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSA_SA_SUMMARY_PAGE0_sa_count_summary_27
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SA_CNT                                     [31:0]           get_SA_CNT
''                                                             set_SA_CNT
''                                                             read_SA_CNT
''                                                             write_SA_CNT
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSA_SA_SUMMARY_PAGE0_sa_count_summary_27
    Private write_SA_CNT_value
    Private read_SA_CNT_value
    Private flag_SA_CNT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &He36c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_SA_CNT
        get_SA_CNT = read_SA_CNT_value
    End Property

    Property Let set_SA_CNT(aData)
        write_SA_CNT_value = aData
        flag_SA_CNT        = &H1
    End Property

    Property Get read_SA_CNT
        read
        read_SA_CNT = read_SA_CNT_value
    End Property

    Property Let write_SA_CNT(aData)
        set_SA_CNT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SA_CNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SA_CNT_mask = mask then
                read_SA_CNT_value = data_low
            else
                read_SA_CNT_value = (data_low - H8000_0000) and SA_CNT_mask
            end If
        else
            read_SA_CNT_value = data_low and SA_CNT_mask
        end If

    End Sub

    Sub write
        If flag_SA_CNT = &H0 Then read
        If flag_SA_CNT = &H0 Then write_SA_CNT_value = get_SA_CNT

        regValue = leftShift(write_SA_CNT_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SA_CNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SA_CNT_mask = mask then
                read_SA_CNT_value = data_low
            else
                read_SA_CNT_value = (data_low - H8000_0000) and SA_CNT_mask
            end If
        else
            read_SA_CNT_value = data_low and SA_CNT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SA_CNT_value = &H0
        flag_SA_CNT        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSA_SA_SUMMARY_PAGE0_sa_count_summary_28
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SA_CNT                                     [31:0]           get_SA_CNT
''                                                             set_SA_CNT
''                                                             read_SA_CNT
''                                                             write_SA_CNT
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSA_SA_SUMMARY_PAGE0_sa_count_summary_28
    Private write_SA_CNT_value
    Private read_SA_CNT_value
    Private flag_SA_CNT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &He370
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_SA_CNT
        get_SA_CNT = read_SA_CNT_value
    End Property

    Property Let set_SA_CNT(aData)
        write_SA_CNT_value = aData
        flag_SA_CNT        = &H1
    End Property

    Property Get read_SA_CNT
        read
        read_SA_CNT = read_SA_CNT_value
    End Property

    Property Let write_SA_CNT(aData)
        set_SA_CNT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SA_CNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SA_CNT_mask = mask then
                read_SA_CNT_value = data_low
            else
                read_SA_CNT_value = (data_low - H8000_0000) and SA_CNT_mask
            end If
        else
            read_SA_CNT_value = data_low and SA_CNT_mask
        end If

    End Sub

    Sub write
        If flag_SA_CNT = &H0 Then read
        If flag_SA_CNT = &H0 Then write_SA_CNT_value = get_SA_CNT

        regValue = leftShift(write_SA_CNT_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SA_CNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SA_CNT_mask = mask then
                read_SA_CNT_value = data_low
            else
                read_SA_CNT_value = (data_low - H8000_0000) and SA_CNT_mask
            end If
        else
            read_SA_CNT_value = data_low and SA_CNT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SA_CNT_value = &H0
        flag_SA_CNT        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSA_SA_SUMMARY_PAGE0_sa_count_summary_29
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SA_CNT                                     [31:0]           get_SA_CNT
''                                                             set_SA_CNT
''                                                             read_SA_CNT
''                                                             write_SA_CNT
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSA_SA_SUMMARY_PAGE0_sa_count_summary_29
    Private write_SA_CNT_value
    Private read_SA_CNT_value
    Private flag_SA_CNT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &He374
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_SA_CNT
        get_SA_CNT = read_SA_CNT_value
    End Property

    Property Let set_SA_CNT(aData)
        write_SA_CNT_value = aData
        flag_SA_CNT        = &H1
    End Property

    Property Get read_SA_CNT
        read
        read_SA_CNT = read_SA_CNT_value
    End Property

    Property Let write_SA_CNT(aData)
        set_SA_CNT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SA_CNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SA_CNT_mask = mask then
                read_SA_CNT_value = data_low
            else
                read_SA_CNT_value = (data_low - H8000_0000) and SA_CNT_mask
            end If
        else
            read_SA_CNT_value = data_low and SA_CNT_mask
        end If

    End Sub

    Sub write
        If flag_SA_CNT = &H0 Then read
        If flag_SA_CNT = &H0 Then write_SA_CNT_value = get_SA_CNT

        regValue = leftShift(write_SA_CNT_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SA_CNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SA_CNT_mask = mask then
                read_SA_CNT_value = data_low
            else
                read_SA_CNT_value = (data_low - H8000_0000) and SA_CNT_mask
            end If
        else
            read_SA_CNT_value = data_low and SA_CNT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SA_CNT_value = &H0
        flag_SA_CNT        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSA_SA_SUMMARY_PAGE0_sa_count_summary_30
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SA_CNT                                     [31:0]           get_SA_CNT
''                                                             set_SA_CNT
''                                                             read_SA_CNT
''                                                             write_SA_CNT
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSA_SA_SUMMARY_PAGE0_sa_count_summary_30
    Private write_SA_CNT_value
    Private read_SA_CNT_value
    Private flag_SA_CNT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &He378
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_SA_CNT
        get_SA_CNT = read_SA_CNT_value
    End Property

    Property Let set_SA_CNT(aData)
        write_SA_CNT_value = aData
        flag_SA_CNT        = &H1
    End Property

    Property Get read_SA_CNT
        read
        read_SA_CNT = read_SA_CNT_value
    End Property

    Property Let write_SA_CNT(aData)
        set_SA_CNT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SA_CNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SA_CNT_mask = mask then
                read_SA_CNT_value = data_low
            else
                read_SA_CNT_value = (data_low - H8000_0000) and SA_CNT_mask
            end If
        else
            read_SA_CNT_value = data_low and SA_CNT_mask
        end If

    End Sub

    Sub write
        If flag_SA_CNT = &H0 Then read
        If flag_SA_CNT = &H0 Then write_SA_CNT_value = get_SA_CNT

        regValue = leftShift(write_SA_CNT_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SA_CNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SA_CNT_mask = mask then
                read_SA_CNT_value = data_low
            else
                read_SA_CNT_value = (data_low - H8000_0000) and SA_CNT_mask
            end If
        else
            read_SA_CNT_value = data_low and SA_CNT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SA_CNT_value = &H0
        flag_SA_CNT        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSA_SA_SUMMARY_PAGE0_sa_count_summary_31
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SA_CNT                                     [31:0]           get_SA_CNT
''                                                             set_SA_CNT
''                                                             read_SA_CNT
''                                                             write_SA_CNT
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSA_SA_SUMMARY_PAGE0_sa_count_summary_31
    Private write_SA_CNT_value
    Private read_SA_CNT_value
    Private flag_SA_CNT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &He37c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_SA_CNT
        get_SA_CNT = read_SA_CNT_value
    End Property

    Property Let set_SA_CNT(aData)
        write_SA_CNT_value = aData
        flag_SA_CNT        = &H1
    End Property

    Property Get read_SA_CNT
        read
        read_SA_CNT = read_SA_CNT_value
    End Property

    Property Let write_SA_CNT(aData)
        set_SA_CNT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SA_CNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SA_CNT_mask = mask then
                read_SA_CNT_value = data_low
            else
                read_SA_CNT_value = (data_low - H8000_0000) and SA_CNT_mask
            end If
        else
            read_SA_CNT_value = data_low and SA_CNT_mask
        end If

    End Sub

    Sub write
        If flag_SA_CNT = &H0 Then read
        If flag_SA_CNT = &H0 Then write_SA_CNT_value = get_SA_CNT

        regValue = leftShift(write_SA_CNT_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SA_CNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SA_CNT_mask = mask then
                read_SA_CNT_value = data_low
            else
                read_SA_CNT_value = (data_low - H8000_0000) and SA_CNT_mask
            end If
        else
            read_SA_CNT_value = data_low and SA_CNT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SA_CNT_value = &H0
        flag_SA_CNT        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class EIP165S_EIP165_IGEIP160_STATSA_SA_SUMMARY_PAGE0_INSTANCE

    Public sa_count_summary_0
    Public sa_count_summary_1
    Public sa_count_summary_2
    Public sa_count_summary_3
    Public sa_count_summary_4
    Public sa_count_summary_5
    Public sa_count_summary_6
    Public sa_count_summary_7
    Public sa_count_summary_8
    Public sa_count_summary_9
    Public sa_count_summary_10
    Public sa_count_summary_11
    Public sa_count_summary_12
    Public sa_count_summary_13
    Public sa_count_summary_14
    Public sa_count_summary_15
    Public sa_count_summary_16
    Public sa_count_summary_17
    Public sa_count_summary_18
    Public sa_count_summary_19
    Public sa_count_summary_20
    Public sa_count_summary_21
    Public sa_count_summary_22
    Public sa_count_summary_23
    Public sa_count_summary_24
    Public sa_count_summary_25
    Public sa_count_summary_26
    Public sa_count_summary_27
    Public sa_count_summary_28
    Public sa_count_summary_29
    Public sa_count_summary_30
    Public sa_count_summary_31


    Public default function Init(aBaseAddr)
        Set sa_count_summary_0 = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSA_SA_SUMMARY_PAGE0_sa_count_summary_0)(aBaseAddr, 32)
        Set sa_count_summary_1 = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSA_SA_SUMMARY_PAGE0_sa_count_summary_1)(aBaseAddr, 32)
        Set sa_count_summary_2 = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSA_SA_SUMMARY_PAGE0_sa_count_summary_2)(aBaseAddr, 32)
        Set sa_count_summary_3 = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSA_SA_SUMMARY_PAGE0_sa_count_summary_3)(aBaseAddr, 32)
        Set sa_count_summary_4 = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSA_SA_SUMMARY_PAGE0_sa_count_summary_4)(aBaseAddr, 32)
        Set sa_count_summary_5 = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSA_SA_SUMMARY_PAGE0_sa_count_summary_5)(aBaseAddr, 32)
        Set sa_count_summary_6 = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSA_SA_SUMMARY_PAGE0_sa_count_summary_6)(aBaseAddr, 32)
        Set sa_count_summary_7 = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSA_SA_SUMMARY_PAGE0_sa_count_summary_7)(aBaseAddr, 32)
        Set sa_count_summary_8 = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSA_SA_SUMMARY_PAGE0_sa_count_summary_8)(aBaseAddr, 32)
        Set sa_count_summary_9 = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSA_SA_SUMMARY_PAGE0_sa_count_summary_9)(aBaseAddr, 32)
        Set sa_count_summary_10 = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSA_SA_SUMMARY_PAGE0_sa_count_summary_10)(aBaseAddr, 32)
        Set sa_count_summary_11 = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSA_SA_SUMMARY_PAGE0_sa_count_summary_11)(aBaseAddr, 32)
        Set sa_count_summary_12 = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSA_SA_SUMMARY_PAGE0_sa_count_summary_12)(aBaseAddr, 32)
        Set sa_count_summary_13 = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSA_SA_SUMMARY_PAGE0_sa_count_summary_13)(aBaseAddr, 32)
        Set sa_count_summary_14 = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSA_SA_SUMMARY_PAGE0_sa_count_summary_14)(aBaseAddr, 32)
        Set sa_count_summary_15 = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSA_SA_SUMMARY_PAGE0_sa_count_summary_15)(aBaseAddr, 32)
        Set sa_count_summary_16 = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSA_SA_SUMMARY_PAGE0_sa_count_summary_16)(aBaseAddr, 32)
        Set sa_count_summary_17 = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSA_SA_SUMMARY_PAGE0_sa_count_summary_17)(aBaseAddr, 32)
        Set sa_count_summary_18 = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSA_SA_SUMMARY_PAGE0_sa_count_summary_18)(aBaseAddr, 32)
        Set sa_count_summary_19 = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSA_SA_SUMMARY_PAGE0_sa_count_summary_19)(aBaseAddr, 32)
        Set sa_count_summary_20 = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSA_SA_SUMMARY_PAGE0_sa_count_summary_20)(aBaseAddr, 32)
        Set sa_count_summary_21 = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSA_SA_SUMMARY_PAGE0_sa_count_summary_21)(aBaseAddr, 32)
        Set sa_count_summary_22 = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSA_SA_SUMMARY_PAGE0_sa_count_summary_22)(aBaseAddr, 32)
        Set sa_count_summary_23 = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSA_SA_SUMMARY_PAGE0_sa_count_summary_23)(aBaseAddr, 32)
        Set sa_count_summary_24 = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSA_SA_SUMMARY_PAGE0_sa_count_summary_24)(aBaseAddr, 32)
        Set sa_count_summary_25 = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSA_SA_SUMMARY_PAGE0_sa_count_summary_25)(aBaseAddr, 32)
        Set sa_count_summary_26 = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSA_SA_SUMMARY_PAGE0_sa_count_summary_26)(aBaseAddr, 32)
        Set sa_count_summary_27 = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSA_SA_SUMMARY_PAGE0_sa_count_summary_27)(aBaseAddr, 32)
        Set sa_count_summary_28 = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSA_SA_SUMMARY_PAGE0_sa_count_summary_28)(aBaseAddr, 32)
        Set sa_count_summary_29 = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSA_SA_SUMMARY_PAGE0_sa_count_summary_29)(aBaseAddr, 32)
        Set sa_count_summary_30 = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSA_SA_SUMMARY_PAGE0_sa_count_summary_30)(aBaseAddr, 32)
        Set sa_count_summary_31 = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSA_SA_SUMMARY_PAGE0_sa_count_summary_31)(aBaseAddr, 32)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set EIP165S_EIP165_IGEIP160_STATSA_SA_SUMMARY_PAGE0 = CreateObject("System.Collections.ArrayList")
EIP165S_EIP165_IGEIP160_STATSA_SA_SUMMARY_PAGE0.Add ((New EIP165S_EIP165_IGEIP160_STATSA_SA_SUMMARY_PAGE0_INSTANCE)(&H4d010000))
EIP165S_EIP165_IGEIP160_STATSA_SA_SUMMARY_PAGE0.Add ((New EIP165S_EIP165_IGEIP160_STATSA_SA_SUMMARY_PAGE0_INSTANCE)(&H4d110000))
EIP165S_EIP165_IGEIP160_STATSA_SA_SUMMARY_PAGE0.Add ((New EIP165S_EIP165_IGEIP160_STATSA_SA_SUMMARY_PAGE0_INSTANCE)(&H4d210000))
EIP165S_EIP165_IGEIP160_STATSA_SA_SUMMARY_PAGE0.Add ((New EIP165S_EIP165_IGEIP160_STATSA_SA_SUMMARY_PAGE0_INSTANCE)(&H4d310000))
EIP165S_EIP165_IGEIP160_STATSA_SA_SUMMARY_PAGE0.Add ((New EIP165S_EIP165_IGEIP160_STATSA_SA_SUMMARY_PAGE0_INSTANCE)(&H4d410000))
EIP165S_EIP165_IGEIP160_STATSA_SA_SUMMARY_PAGE0.Add ((New EIP165S_EIP165_IGEIP160_STATSA_SA_SUMMARY_PAGE0_INSTANCE)(&H4d510000))


