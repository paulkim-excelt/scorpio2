

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


'' @REGISTER : EC32TAP_coeff_00_lsb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COEFF_LSB                                  [15:0]           get_COEFF_LSB
''                                                             set_COEFF_LSB
''                                                             read_COEFF_LSB
''                                                             write_COEFF_LSB
''---------------------------------------------------------------------------------
Class REGISTER_EC32TAP_coeff_00_lsb
    Private write_COEFF_LSB_value
    Private read_COEFF_LSB_value
    Private flag_COEFF_LSB

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

    Property Get get_COEFF_LSB
        get_COEFF_LSB = read_COEFF_LSB_value
    End Property

    Property Let set_COEFF_LSB(aData)
        write_COEFF_LSB_value = aData
        flag_COEFF_LSB        = &H1
    End Property

    Property Get read_COEFF_LSB
        read
        read_COEFF_LSB = read_COEFF_LSB_value
    End Property

    Property Let write_COEFF_LSB(aData)
        set_COEFF_LSB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_LSB_mask = &Hffff
        if data_low > LONG_MAX then
            if COEFF_LSB_mask = mask then
                read_COEFF_LSB_value = data_low
            else
                read_COEFF_LSB_value = (data_low - H8000_0000) and COEFF_LSB_mask
            end If
        else
            read_COEFF_LSB_value = data_low and COEFF_LSB_mask
        end If

    End Sub

    Sub write
        If flag_COEFF_LSB = &H0 Then read
        If flag_COEFF_LSB = &H0 Then write_COEFF_LSB_value = get_COEFF_LSB

        regValue = leftShift((write_COEFF_LSB_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_LSB_mask = &Hffff
        if data_low > LONG_MAX then
            if COEFF_LSB_mask = mask then
                read_COEFF_LSB_value = data_low
            else
                read_COEFF_LSB_value = (data_low - H8000_0000) and COEFF_LSB_mask
            end If
        else
            read_COEFF_LSB_value = data_low and COEFF_LSB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COEFF_LSB_value = &H0
        flag_COEFF_LSB        = &H0
    End Sub
End Class


'' @REGISTER : EC32TAP_coeff_00_msb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COEFF_MSB                                  [2:0]            get_COEFF_MSB
''                                                             set_COEFF_MSB
''                                                             read_COEFF_MSB
''                                                             write_COEFF_MSB
''---------------------------------------------------------------------------------
Class REGISTER_EC32TAP_coeff_00_msb
    Private write_COEFF_MSB_value
    Private read_COEFF_MSB_value
    Private flag_COEFF_MSB

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

    Property Get get_COEFF_MSB
        get_COEFF_MSB = read_COEFF_MSB_value
    End Property

    Property Let set_COEFF_MSB(aData)
        write_COEFF_MSB_value = aData
        flag_COEFF_MSB        = &H1
    End Property

    Property Get read_COEFF_MSB
        read
        read_COEFF_MSB = read_COEFF_MSB_value
    End Property

    Property Let write_COEFF_MSB(aData)
        set_COEFF_MSB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_MSB_mask = &H7
        if data_low > LONG_MAX then
            if COEFF_MSB_mask = mask then
                read_COEFF_MSB_value = data_low
            else
                read_COEFF_MSB_value = (data_low - H8000_0000) and COEFF_MSB_mask
            end If
        else
            read_COEFF_MSB_value = data_low and COEFF_MSB_mask
        end If

    End Sub

    Sub write
        If flag_COEFF_MSB = &H0 Then read
        If flag_COEFF_MSB = &H0 Then write_COEFF_MSB_value = get_COEFF_MSB

        regValue = leftShift((write_COEFF_MSB_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_MSB_mask = &H7
        if data_low > LONG_MAX then
            if COEFF_MSB_mask = mask then
                read_COEFF_MSB_value = data_low
            else
                read_COEFF_MSB_value = (data_low - H8000_0000) and COEFF_MSB_mask
            end If
        else
            read_COEFF_MSB_value = data_low and COEFF_MSB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COEFF_MSB_value = &H0
        flag_COEFF_MSB        = &H0
    End Sub
End Class


'' @REGISTER : EC32TAP_coeff_01_lsb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COEFF_LSB                                  [15:0]           get_COEFF_LSB
''                                                             set_COEFF_LSB
''                                                             read_COEFF_LSB
''                                                             write_COEFF_LSB
''---------------------------------------------------------------------------------
Class REGISTER_EC32TAP_coeff_01_lsb
    Private write_COEFF_LSB_value
    Private read_COEFF_LSB_value
    Private flag_COEFF_LSB

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

    Property Get get_COEFF_LSB
        get_COEFF_LSB = read_COEFF_LSB_value
    End Property

    Property Let set_COEFF_LSB(aData)
        write_COEFF_LSB_value = aData
        flag_COEFF_LSB        = &H1
    End Property

    Property Get read_COEFF_LSB
        read
        read_COEFF_LSB = read_COEFF_LSB_value
    End Property

    Property Let write_COEFF_LSB(aData)
        set_COEFF_LSB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_LSB_mask = &Hffff
        if data_low > LONG_MAX then
            if COEFF_LSB_mask = mask then
                read_COEFF_LSB_value = data_low
            else
                read_COEFF_LSB_value = (data_low - H8000_0000) and COEFF_LSB_mask
            end If
        else
            read_COEFF_LSB_value = data_low and COEFF_LSB_mask
        end If

    End Sub

    Sub write
        If flag_COEFF_LSB = &H0 Then read
        If flag_COEFF_LSB = &H0 Then write_COEFF_LSB_value = get_COEFF_LSB

        regValue = leftShift((write_COEFF_LSB_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_LSB_mask = &Hffff
        if data_low > LONG_MAX then
            if COEFF_LSB_mask = mask then
                read_COEFF_LSB_value = data_low
            else
                read_COEFF_LSB_value = (data_low - H8000_0000) and COEFF_LSB_mask
            end If
        else
            read_COEFF_LSB_value = data_low and COEFF_LSB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COEFF_LSB_value = &H0
        flag_COEFF_LSB        = &H0
    End Sub
End Class


'' @REGISTER : EC32TAP_coeff_01_msb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COEFF_MSB                                  [2:0]            get_COEFF_MSB
''                                                             set_COEFF_MSB
''                                                             read_COEFF_MSB
''                                                             write_COEFF_MSB
''---------------------------------------------------------------------------------
Class REGISTER_EC32TAP_coeff_01_msb
    Private write_COEFF_MSB_value
    Private read_COEFF_MSB_value
    Private flag_COEFF_MSB

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

    Property Get get_COEFF_MSB
        get_COEFF_MSB = read_COEFF_MSB_value
    End Property

    Property Let set_COEFF_MSB(aData)
        write_COEFF_MSB_value = aData
        flag_COEFF_MSB        = &H1
    End Property

    Property Get read_COEFF_MSB
        read
        read_COEFF_MSB = read_COEFF_MSB_value
    End Property

    Property Let write_COEFF_MSB(aData)
        set_COEFF_MSB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_MSB_mask = &H7
        if data_low > LONG_MAX then
            if COEFF_MSB_mask = mask then
                read_COEFF_MSB_value = data_low
            else
                read_COEFF_MSB_value = (data_low - H8000_0000) and COEFF_MSB_mask
            end If
        else
            read_COEFF_MSB_value = data_low and COEFF_MSB_mask
        end If

    End Sub

    Sub write
        If flag_COEFF_MSB = &H0 Then read
        If flag_COEFF_MSB = &H0 Then write_COEFF_MSB_value = get_COEFF_MSB

        regValue = leftShift((write_COEFF_MSB_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_MSB_mask = &H7
        if data_low > LONG_MAX then
            if COEFF_MSB_mask = mask then
                read_COEFF_MSB_value = data_low
            else
                read_COEFF_MSB_value = (data_low - H8000_0000) and COEFF_MSB_mask
            end If
        else
            read_COEFF_MSB_value = data_low and COEFF_MSB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COEFF_MSB_value = &H0
        flag_COEFF_MSB        = &H0
    End Sub
End Class


'' @REGISTER : EC32TAP_coeff_02_lsb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COEFF_LSB                                  [15:0]           get_COEFF_LSB
''                                                             set_COEFF_LSB
''                                                             read_COEFF_LSB
''                                                             write_COEFF_LSB
''---------------------------------------------------------------------------------
Class REGISTER_EC32TAP_coeff_02_lsb
    Private write_COEFF_LSB_value
    Private read_COEFF_LSB_value
    Private flag_COEFF_LSB

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

    Property Get get_COEFF_LSB
        get_COEFF_LSB = read_COEFF_LSB_value
    End Property

    Property Let set_COEFF_LSB(aData)
        write_COEFF_LSB_value = aData
        flag_COEFF_LSB        = &H1
    End Property

    Property Get read_COEFF_LSB
        read
        read_COEFF_LSB = read_COEFF_LSB_value
    End Property

    Property Let write_COEFF_LSB(aData)
        set_COEFF_LSB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_LSB_mask = &Hffff
        if data_low > LONG_MAX then
            if COEFF_LSB_mask = mask then
                read_COEFF_LSB_value = data_low
            else
                read_COEFF_LSB_value = (data_low - H8000_0000) and COEFF_LSB_mask
            end If
        else
            read_COEFF_LSB_value = data_low and COEFF_LSB_mask
        end If

    End Sub

    Sub write
        If flag_COEFF_LSB = &H0 Then read
        If flag_COEFF_LSB = &H0 Then write_COEFF_LSB_value = get_COEFF_LSB

        regValue = leftShift((write_COEFF_LSB_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_LSB_mask = &Hffff
        if data_low > LONG_MAX then
            if COEFF_LSB_mask = mask then
                read_COEFF_LSB_value = data_low
            else
                read_COEFF_LSB_value = (data_low - H8000_0000) and COEFF_LSB_mask
            end If
        else
            read_COEFF_LSB_value = data_low and COEFF_LSB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COEFF_LSB_value = &H0
        flag_COEFF_LSB        = &H0
    End Sub
End Class


'' @REGISTER : EC32TAP_coeff_02_msb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COEFF_MSB                                  [2:0]            get_COEFF_MSB
''                                                             set_COEFF_MSB
''                                                             read_COEFF_MSB
''                                                             write_COEFF_MSB
''---------------------------------------------------------------------------------
Class REGISTER_EC32TAP_coeff_02_msb
    Private write_COEFF_MSB_value
    Private read_COEFF_MSB_value
    Private flag_COEFF_MSB

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

    Property Get get_COEFF_MSB
        get_COEFF_MSB = read_COEFF_MSB_value
    End Property

    Property Let set_COEFF_MSB(aData)
        write_COEFF_MSB_value = aData
        flag_COEFF_MSB        = &H1
    End Property

    Property Get read_COEFF_MSB
        read
        read_COEFF_MSB = read_COEFF_MSB_value
    End Property

    Property Let write_COEFF_MSB(aData)
        set_COEFF_MSB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_MSB_mask = &H7
        if data_low > LONG_MAX then
            if COEFF_MSB_mask = mask then
                read_COEFF_MSB_value = data_low
            else
                read_COEFF_MSB_value = (data_low - H8000_0000) and COEFF_MSB_mask
            end If
        else
            read_COEFF_MSB_value = data_low and COEFF_MSB_mask
        end If

    End Sub

    Sub write
        If flag_COEFF_MSB = &H0 Then read
        If flag_COEFF_MSB = &H0 Then write_COEFF_MSB_value = get_COEFF_MSB

        regValue = leftShift((write_COEFF_MSB_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_MSB_mask = &H7
        if data_low > LONG_MAX then
            if COEFF_MSB_mask = mask then
                read_COEFF_MSB_value = data_low
            else
                read_COEFF_MSB_value = (data_low - H8000_0000) and COEFF_MSB_mask
            end If
        else
            read_COEFF_MSB_value = data_low and COEFF_MSB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COEFF_MSB_value = &H0
        flag_COEFF_MSB        = &H0
    End Sub
End Class


'' @REGISTER : EC32TAP_coeff_03_lsb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COEFF_LSB                                  [15:0]           get_COEFF_LSB
''                                                             set_COEFF_LSB
''                                                             read_COEFF_LSB
''                                                             write_COEFF_LSB
''---------------------------------------------------------------------------------
Class REGISTER_EC32TAP_coeff_03_lsb
    Private write_COEFF_LSB_value
    Private read_COEFF_LSB_value
    Private flag_COEFF_LSB

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

    Property Get get_COEFF_LSB
        get_COEFF_LSB = read_COEFF_LSB_value
    End Property

    Property Let set_COEFF_LSB(aData)
        write_COEFF_LSB_value = aData
        flag_COEFF_LSB        = &H1
    End Property

    Property Get read_COEFF_LSB
        read
        read_COEFF_LSB = read_COEFF_LSB_value
    End Property

    Property Let write_COEFF_LSB(aData)
        set_COEFF_LSB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_LSB_mask = &Hffff
        if data_low > LONG_MAX then
            if COEFF_LSB_mask = mask then
                read_COEFF_LSB_value = data_low
            else
                read_COEFF_LSB_value = (data_low - H8000_0000) and COEFF_LSB_mask
            end If
        else
            read_COEFF_LSB_value = data_low and COEFF_LSB_mask
        end If

    End Sub

    Sub write
        If flag_COEFF_LSB = &H0 Then read
        If flag_COEFF_LSB = &H0 Then write_COEFF_LSB_value = get_COEFF_LSB

        regValue = leftShift((write_COEFF_LSB_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_LSB_mask = &Hffff
        if data_low > LONG_MAX then
            if COEFF_LSB_mask = mask then
                read_COEFF_LSB_value = data_low
            else
                read_COEFF_LSB_value = (data_low - H8000_0000) and COEFF_LSB_mask
            end If
        else
            read_COEFF_LSB_value = data_low and COEFF_LSB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COEFF_LSB_value = &H0
        flag_COEFF_LSB        = &H0
    End Sub
End Class


'' @REGISTER : EC32TAP_coeff_03_msb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COEFF_MSB                                  [2:0]            get_COEFF_MSB
''                                                             set_COEFF_MSB
''                                                             read_COEFF_MSB
''                                                             write_COEFF_MSB
''---------------------------------------------------------------------------------
Class REGISTER_EC32TAP_coeff_03_msb
    Private write_COEFF_MSB_value
    Private read_COEFF_MSB_value
    Private flag_COEFF_MSB

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

    Property Get get_COEFF_MSB
        get_COEFF_MSB = read_COEFF_MSB_value
    End Property

    Property Let set_COEFF_MSB(aData)
        write_COEFF_MSB_value = aData
        flag_COEFF_MSB        = &H1
    End Property

    Property Get read_COEFF_MSB
        read
        read_COEFF_MSB = read_COEFF_MSB_value
    End Property

    Property Let write_COEFF_MSB(aData)
        set_COEFF_MSB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_MSB_mask = &H7
        if data_low > LONG_MAX then
            if COEFF_MSB_mask = mask then
                read_COEFF_MSB_value = data_low
            else
                read_COEFF_MSB_value = (data_low - H8000_0000) and COEFF_MSB_mask
            end If
        else
            read_COEFF_MSB_value = data_low and COEFF_MSB_mask
        end If

    End Sub

    Sub write
        If flag_COEFF_MSB = &H0 Then read
        If flag_COEFF_MSB = &H0 Then write_COEFF_MSB_value = get_COEFF_MSB

        regValue = leftShift((write_COEFF_MSB_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_MSB_mask = &H7
        if data_low > LONG_MAX then
            if COEFF_MSB_mask = mask then
                read_COEFF_MSB_value = data_low
            else
                read_COEFF_MSB_value = (data_low - H8000_0000) and COEFF_MSB_mask
            end If
        else
            read_COEFF_MSB_value = data_low and COEFF_MSB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COEFF_MSB_value = &H0
        flag_COEFF_MSB        = &H0
    End Sub
End Class


'' @REGISTER : EC32TAP_coeff_04_lsb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COEFF_LSB                                  [15:0]           get_COEFF_LSB
''                                                             set_COEFF_LSB
''                                                             read_COEFF_LSB
''                                                             write_COEFF_LSB
''---------------------------------------------------------------------------------
Class REGISTER_EC32TAP_coeff_04_lsb
    Private write_COEFF_LSB_value
    Private read_COEFF_LSB_value
    Private flag_COEFF_LSB

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

    Property Get get_COEFF_LSB
        get_COEFF_LSB = read_COEFF_LSB_value
    End Property

    Property Let set_COEFF_LSB(aData)
        write_COEFF_LSB_value = aData
        flag_COEFF_LSB        = &H1
    End Property

    Property Get read_COEFF_LSB
        read
        read_COEFF_LSB = read_COEFF_LSB_value
    End Property

    Property Let write_COEFF_LSB(aData)
        set_COEFF_LSB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_LSB_mask = &Hffff
        if data_low > LONG_MAX then
            if COEFF_LSB_mask = mask then
                read_COEFF_LSB_value = data_low
            else
                read_COEFF_LSB_value = (data_low - H8000_0000) and COEFF_LSB_mask
            end If
        else
            read_COEFF_LSB_value = data_low and COEFF_LSB_mask
        end If

    End Sub

    Sub write
        If flag_COEFF_LSB = &H0 Then read
        If flag_COEFF_LSB = &H0 Then write_COEFF_LSB_value = get_COEFF_LSB

        regValue = leftShift((write_COEFF_LSB_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_LSB_mask = &Hffff
        if data_low > LONG_MAX then
            if COEFF_LSB_mask = mask then
                read_COEFF_LSB_value = data_low
            else
                read_COEFF_LSB_value = (data_low - H8000_0000) and COEFF_LSB_mask
            end If
        else
            read_COEFF_LSB_value = data_low and COEFF_LSB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COEFF_LSB_value = &H0
        flag_COEFF_LSB        = &H0
    End Sub
End Class


'' @REGISTER : EC32TAP_coeff_04_msb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COEFF_MSB                                  [2:0]            get_COEFF_MSB
''                                                             set_COEFF_MSB
''                                                             read_COEFF_MSB
''                                                             write_COEFF_MSB
''---------------------------------------------------------------------------------
Class REGISTER_EC32TAP_coeff_04_msb
    Private write_COEFF_MSB_value
    Private read_COEFF_MSB_value
    Private flag_COEFF_MSB

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

    Property Get get_COEFF_MSB
        get_COEFF_MSB = read_COEFF_MSB_value
    End Property

    Property Let set_COEFF_MSB(aData)
        write_COEFF_MSB_value = aData
        flag_COEFF_MSB        = &H1
    End Property

    Property Get read_COEFF_MSB
        read
        read_COEFF_MSB = read_COEFF_MSB_value
    End Property

    Property Let write_COEFF_MSB(aData)
        set_COEFF_MSB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_MSB_mask = &H7
        if data_low > LONG_MAX then
            if COEFF_MSB_mask = mask then
                read_COEFF_MSB_value = data_low
            else
                read_COEFF_MSB_value = (data_low - H8000_0000) and COEFF_MSB_mask
            end If
        else
            read_COEFF_MSB_value = data_low and COEFF_MSB_mask
        end If

    End Sub

    Sub write
        If flag_COEFF_MSB = &H0 Then read
        If flag_COEFF_MSB = &H0 Then write_COEFF_MSB_value = get_COEFF_MSB

        regValue = leftShift((write_COEFF_MSB_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_MSB_mask = &H7
        if data_low > LONG_MAX then
            if COEFF_MSB_mask = mask then
                read_COEFF_MSB_value = data_low
            else
                read_COEFF_MSB_value = (data_low - H8000_0000) and COEFF_MSB_mask
            end If
        else
            read_COEFF_MSB_value = data_low and COEFF_MSB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COEFF_MSB_value = &H0
        flag_COEFF_MSB        = &H0
    End Sub
End Class


'' @REGISTER : EC32TAP_coeff_05_lsb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COEFF_LSB                                  [15:0]           get_COEFF_LSB
''                                                             set_COEFF_LSB
''                                                             read_COEFF_LSB
''                                                             write_COEFF_LSB
''---------------------------------------------------------------------------------
Class REGISTER_EC32TAP_coeff_05_lsb
    Private write_COEFF_LSB_value
    Private read_COEFF_LSB_value
    Private flag_COEFF_LSB

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

    Property Get get_COEFF_LSB
        get_COEFF_LSB = read_COEFF_LSB_value
    End Property

    Property Let set_COEFF_LSB(aData)
        write_COEFF_LSB_value = aData
        flag_COEFF_LSB        = &H1
    End Property

    Property Get read_COEFF_LSB
        read
        read_COEFF_LSB = read_COEFF_LSB_value
    End Property

    Property Let write_COEFF_LSB(aData)
        set_COEFF_LSB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_LSB_mask = &Hffff
        if data_low > LONG_MAX then
            if COEFF_LSB_mask = mask then
                read_COEFF_LSB_value = data_low
            else
                read_COEFF_LSB_value = (data_low - H8000_0000) and COEFF_LSB_mask
            end If
        else
            read_COEFF_LSB_value = data_low and COEFF_LSB_mask
        end If

    End Sub

    Sub write
        If flag_COEFF_LSB = &H0 Then read
        If flag_COEFF_LSB = &H0 Then write_COEFF_LSB_value = get_COEFF_LSB

        regValue = leftShift((write_COEFF_LSB_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_LSB_mask = &Hffff
        if data_low > LONG_MAX then
            if COEFF_LSB_mask = mask then
                read_COEFF_LSB_value = data_low
            else
                read_COEFF_LSB_value = (data_low - H8000_0000) and COEFF_LSB_mask
            end If
        else
            read_COEFF_LSB_value = data_low and COEFF_LSB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COEFF_LSB_value = &H0
        flag_COEFF_LSB        = &H0
    End Sub
End Class


'' @REGISTER : EC32TAP_coeff_05_msb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COEFF_MSB                                  [2:0]            get_COEFF_MSB
''                                                             set_COEFF_MSB
''                                                             read_COEFF_MSB
''                                                             write_COEFF_MSB
''---------------------------------------------------------------------------------
Class REGISTER_EC32TAP_coeff_05_msb
    Private write_COEFF_MSB_value
    Private read_COEFF_MSB_value
    Private flag_COEFF_MSB

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

    Property Get get_COEFF_MSB
        get_COEFF_MSB = read_COEFF_MSB_value
    End Property

    Property Let set_COEFF_MSB(aData)
        write_COEFF_MSB_value = aData
        flag_COEFF_MSB        = &H1
    End Property

    Property Get read_COEFF_MSB
        read
        read_COEFF_MSB = read_COEFF_MSB_value
    End Property

    Property Let write_COEFF_MSB(aData)
        set_COEFF_MSB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_MSB_mask = &H7
        if data_low > LONG_MAX then
            if COEFF_MSB_mask = mask then
                read_COEFF_MSB_value = data_low
            else
                read_COEFF_MSB_value = (data_low - H8000_0000) and COEFF_MSB_mask
            end If
        else
            read_COEFF_MSB_value = data_low and COEFF_MSB_mask
        end If

    End Sub

    Sub write
        If flag_COEFF_MSB = &H0 Then read
        If flag_COEFF_MSB = &H0 Then write_COEFF_MSB_value = get_COEFF_MSB

        regValue = leftShift((write_COEFF_MSB_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_MSB_mask = &H7
        if data_low > LONG_MAX then
            if COEFF_MSB_mask = mask then
                read_COEFF_MSB_value = data_low
            else
                read_COEFF_MSB_value = (data_low - H8000_0000) and COEFF_MSB_mask
            end If
        else
            read_COEFF_MSB_value = data_low and COEFF_MSB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COEFF_MSB_value = &H0
        flag_COEFF_MSB        = &H0
    End Sub
End Class


'' @REGISTER : EC32TAP_coeff_06_lsb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COEFF_LSB                                  [15:0]           get_COEFF_LSB
''                                                             set_COEFF_LSB
''                                                             read_COEFF_LSB
''                                                             write_COEFF_LSB
''---------------------------------------------------------------------------------
Class REGISTER_EC32TAP_coeff_06_lsb
    Private write_COEFF_LSB_value
    Private read_COEFF_LSB_value
    Private flag_COEFF_LSB

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

    Property Get get_COEFF_LSB
        get_COEFF_LSB = read_COEFF_LSB_value
    End Property

    Property Let set_COEFF_LSB(aData)
        write_COEFF_LSB_value = aData
        flag_COEFF_LSB        = &H1
    End Property

    Property Get read_COEFF_LSB
        read
        read_COEFF_LSB = read_COEFF_LSB_value
    End Property

    Property Let write_COEFF_LSB(aData)
        set_COEFF_LSB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_LSB_mask = &Hffff
        if data_low > LONG_MAX then
            if COEFF_LSB_mask = mask then
                read_COEFF_LSB_value = data_low
            else
                read_COEFF_LSB_value = (data_low - H8000_0000) and COEFF_LSB_mask
            end If
        else
            read_COEFF_LSB_value = data_low and COEFF_LSB_mask
        end If

    End Sub

    Sub write
        If flag_COEFF_LSB = &H0 Then read
        If flag_COEFF_LSB = &H0 Then write_COEFF_LSB_value = get_COEFF_LSB

        regValue = leftShift((write_COEFF_LSB_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_LSB_mask = &Hffff
        if data_low > LONG_MAX then
            if COEFF_LSB_mask = mask then
                read_COEFF_LSB_value = data_low
            else
                read_COEFF_LSB_value = (data_low - H8000_0000) and COEFF_LSB_mask
            end If
        else
            read_COEFF_LSB_value = data_low and COEFF_LSB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COEFF_LSB_value = &H0
        flag_COEFF_LSB        = &H0
    End Sub
End Class


'' @REGISTER : EC32TAP_coeff_06_msb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COEFF_MSB                                  [2:0]            get_COEFF_MSB
''                                                             set_COEFF_MSB
''                                                             read_COEFF_MSB
''                                                             write_COEFF_MSB
''---------------------------------------------------------------------------------
Class REGISTER_EC32TAP_coeff_06_msb
    Private write_COEFF_MSB_value
    Private read_COEFF_MSB_value
    Private flag_COEFF_MSB

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

    Property Get get_COEFF_MSB
        get_COEFF_MSB = read_COEFF_MSB_value
    End Property

    Property Let set_COEFF_MSB(aData)
        write_COEFF_MSB_value = aData
        flag_COEFF_MSB        = &H1
    End Property

    Property Get read_COEFF_MSB
        read
        read_COEFF_MSB = read_COEFF_MSB_value
    End Property

    Property Let write_COEFF_MSB(aData)
        set_COEFF_MSB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_MSB_mask = &H7
        if data_low > LONG_MAX then
            if COEFF_MSB_mask = mask then
                read_COEFF_MSB_value = data_low
            else
                read_COEFF_MSB_value = (data_low - H8000_0000) and COEFF_MSB_mask
            end If
        else
            read_COEFF_MSB_value = data_low and COEFF_MSB_mask
        end If

    End Sub

    Sub write
        If flag_COEFF_MSB = &H0 Then read
        If flag_COEFF_MSB = &H0 Then write_COEFF_MSB_value = get_COEFF_MSB

        regValue = leftShift((write_COEFF_MSB_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_MSB_mask = &H7
        if data_low > LONG_MAX then
            if COEFF_MSB_mask = mask then
                read_COEFF_MSB_value = data_low
            else
                read_COEFF_MSB_value = (data_low - H8000_0000) and COEFF_MSB_mask
            end If
        else
            read_COEFF_MSB_value = data_low and COEFF_MSB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COEFF_MSB_value = &H0
        flag_COEFF_MSB        = &H0
    End Sub
End Class


'' @REGISTER : EC32TAP_coeff_07_lsb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COEFF_LSB                                  [15:0]           get_COEFF_LSB
''                                                             set_COEFF_LSB
''                                                             read_COEFF_LSB
''                                                             write_COEFF_LSB
''---------------------------------------------------------------------------------
Class REGISTER_EC32TAP_coeff_07_lsb
    Private write_COEFF_LSB_value
    Private read_COEFF_LSB_value
    Private flag_COEFF_LSB

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

    Property Get get_COEFF_LSB
        get_COEFF_LSB = read_COEFF_LSB_value
    End Property

    Property Let set_COEFF_LSB(aData)
        write_COEFF_LSB_value = aData
        flag_COEFF_LSB        = &H1
    End Property

    Property Get read_COEFF_LSB
        read
        read_COEFF_LSB = read_COEFF_LSB_value
    End Property

    Property Let write_COEFF_LSB(aData)
        set_COEFF_LSB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_LSB_mask = &Hffff
        if data_low > LONG_MAX then
            if COEFF_LSB_mask = mask then
                read_COEFF_LSB_value = data_low
            else
                read_COEFF_LSB_value = (data_low - H8000_0000) and COEFF_LSB_mask
            end If
        else
            read_COEFF_LSB_value = data_low and COEFF_LSB_mask
        end If

    End Sub

    Sub write
        If flag_COEFF_LSB = &H0 Then read
        If flag_COEFF_LSB = &H0 Then write_COEFF_LSB_value = get_COEFF_LSB

        regValue = leftShift((write_COEFF_LSB_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_LSB_mask = &Hffff
        if data_low > LONG_MAX then
            if COEFF_LSB_mask = mask then
                read_COEFF_LSB_value = data_low
            else
                read_COEFF_LSB_value = (data_low - H8000_0000) and COEFF_LSB_mask
            end If
        else
            read_COEFF_LSB_value = data_low and COEFF_LSB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COEFF_LSB_value = &H0
        flag_COEFF_LSB        = &H0
    End Sub
End Class


'' @REGISTER : EC32TAP_coeff_07_msb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COEFF_MSB                                  [2:0]            get_COEFF_MSB
''                                                             set_COEFF_MSB
''                                                             read_COEFF_MSB
''                                                             write_COEFF_MSB
''---------------------------------------------------------------------------------
Class REGISTER_EC32TAP_coeff_07_msb
    Private write_COEFF_MSB_value
    Private read_COEFF_MSB_value
    Private flag_COEFF_MSB

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

    Property Get get_COEFF_MSB
        get_COEFF_MSB = read_COEFF_MSB_value
    End Property

    Property Let set_COEFF_MSB(aData)
        write_COEFF_MSB_value = aData
        flag_COEFF_MSB        = &H1
    End Property

    Property Get read_COEFF_MSB
        read
        read_COEFF_MSB = read_COEFF_MSB_value
    End Property

    Property Let write_COEFF_MSB(aData)
        set_COEFF_MSB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_MSB_mask = &H7
        if data_low > LONG_MAX then
            if COEFF_MSB_mask = mask then
                read_COEFF_MSB_value = data_low
            else
                read_COEFF_MSB_value = (data_low - H8000_0000) and COEFF_MSB_mask
            end If
        else
            read_COEFF_MSB_value = data_low and COEFF_MSB_mask
        end If

    End Sub

    Sub write
        If flag_COEFF_MSB = &H0 Then read
        If flag_COEFF_MSB = &H0 Then write_COEFF_MSB_value = get_COEFF_MSB

        regValue = leftShift((write_COEFF_MSB_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_MSB_mask = &H7
        if data_low > LONG_MAX then
            if COEFF_MSB_mask = mask then
                read_COEFF_MSB_value = data_low
            else
                read_COEFF_MSB_value = (data_low - H8000_0000) and COEFF_MSB_mask
            end If
        else
            read_COEFF_MSB_value = data_low and COEFF_MSB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COEFF_MSB_value = &H0
        flag_COEFF_MSB        = &H0
    End Sub
End Class


'' @REGISTER : EC32TAP_coeff_08_lsb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COEFF_LSB                                  [15:0]           get_COEFF_LSB
''                                                             set_COEFF_LSB
''                                                             read_COEFF_LSB
''                                                             write_COEFF_LSB
''---------------------------------------------------------------------------------
Class REGISTER_EC32TAP_coeff_08_lsb
    Private write_COEFF_LSB_value
    Private read_COEFF_LSB_value
    Private flag_COEFF_LSB

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

    Property Get get_COEFF_LSB
        get_COEFF_LSB = read_COEFF_LSB_value
    End Property

    Property Let set_COEFF_LSB(aData)
        write_COEFF_LSB_value = aData
        flag_COEFF_LSB        = &H1
    End Property

    Property Get read_COEFF_LSB
        read
        read_COEFF_LSB = read_COEFF_LSB_value
    End Property

    Property Let write_COEFF_LSB(aData)
        set_COEFF_LSB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_LSB_mask = &Hffff
        if data_low > LONG_MAX then
            if COEFF_LSB_mask = mask then
                read_COEFF_LSB_value = data_low
            else
                read_COEFF_LSB_value = (data_low - H8000_0000) and COEFF_LSB_mask
            end If
        else
            read_COEFF_LSB_value = data_low and COEFF_LSB_mask
        end If

    End Sub

    Sub write
        If flag_COEFF_LSB = &H0 Then read
        If flag_COEFF_LSB = &H0 Then write_COEFF_LSB_value = get_COEFF_LSB

        regValue = leftShift((write_COEFF_LSB_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_LSB_mask = &Hffff
        if data_low > LONG_MAX then
            if COEFF_LSB_mask = mask then
                read_COEFF_LSB_value = data_low
            else
                read_COEFF_LSB_value = (data_low - H8000_0000) and COEFF_LSB_mask
            end If
        else
            read_COEFF_LSB_value = data_low and COEFF_LSB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COEFF_LSB_value = &H0
        flag_COEFF_LSB        = &H0
    End Sub
End Class


'' @REGISTER : EC32TAP_coeff_08_msb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COEFF_MSB                                  [2:0]            get_COEFF_MSB
''                                                             set_COEFF_MSB
''                                                             read_COEFF_MSB
''                                                             write_COEFF_MSB
''---------------------------------------------------------------------------------
Class REGISTER_EC32TAP_coeff_08_msb
    Private write_COEFF_MSB_value
    Private read_COEFF_MSB_value
    Private flag_COEFF_MSB

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

    Property Get get_COEFF_MSB
        get_COEFF_MSB = read_COEFF_MSB_value
    End Property

    Property Let set_COEFF_MSB(aData)
        write_COEFF_MSB_value = aData
        flag_COEFF_MSB        = &H1
    End Property

    Property Get read_COEFF_MSB
        read
        read_COEFF_MSB = read_COEFF_MSB_value
    End Property

    Property Let write_COEFF_MSB(aData)
        set_COEFF_MSB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_MSB_mask = &H7
        if data_low > LONG_MAX then
            if COEFF_MSB_mask = mask then
                read_COEFF_MSB_value = data_low
            else
                read_COEFF_MSB_value = (data_low - H8000_0000) and COEFF_MSB_mask
            end If
        else
            read_COEFF_MSB_value = data_low and COEFF_MSB_mask
        end If

    End Sub

    Sub write
        If flag_COEFF_MSB = &H0 Then read
        If flag_COEFF_MSB = &H0 Then write_COEFF_MSB_value = get_COEFF_MSB

        regValue = leftShift((write_COEFF_MSB_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_MSB_mask = &H7
        if data_low > LONG_MAX then
            if COEFF_MSB_mask = mask then
                read_COEFF_MSB_value = data_low
            else
                read_COEFF_MSB_value = (data_low - H8000_0000) and COEFF_MSB_mask
            end If
        else
            read_COEFF_MSB_value = data_low and COEFF_MSB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COEFF_MSB_value = &H0
        flag_COEFF_MSB        = &H0
    End Sub
End Class


'' @REGISTER : EC32TAP_coeff_09_lsb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COEFF_LSB                                  [15:0]           get_COEFF_LSB
''                                                             set_COEFF_LSB
''                                                             read_COEFF_LSB
''                                                             write_COEFF_LSB
''---------------------------------------------------------------------------------
Class REGISTER_EC32TAP_coeff_09_lsb
    Private write_COEFF_LSB_value
    Private read_COEFF_LSB_value
    Private flag_COEFF_LSB

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

    Property Get get_COEFF_LSB
        get_COEFF_LSB = read_COEFF_LSB_value
    End Property

    Property Let set_COEFF_LSB(aData)
        write_COEFF_LSB_value = aData
        flag_COEFF_LSB        = &H1
    End Property

    Property Get read_COEFF_LSB
        read
        read_COEFF_LSB = read_COEFF_LSB_value
    End Property

    Property Let write_COEFF_LSB(aData)
        set_COEFF_LSB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_LSB_mask = &Hffff
        if data_low > LONG_MAX then
            if COEFF_LSB_mask = mask then
                read_COEFF_LSB_value = data_low
            else
                read_COEFF_LSB_value = (data_low - H8000_0000) and COEFF_LSB_mask
            end If
        else
            read_COEFF_LSB_value = data_low and COEFF_LSB_mask
        end If

    End Sub

    Sub write
        If flag_COEFF_LSB = &H0 Then read
        If flag_COEFF_LSB = &H0 Then write_COEFF_LSB_value = get_COEFF_LSB

        regValue = leftShift((write_COEFF_LSB_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_LSB_mask = &Hffff
        if data_low > LONG_MAX then
            if COEFF_LSB_mask = mask then
                read_COEFF_LSB_value = data_low
            else
                read_COEFF_LSB_value = (data_low - H8000_0000) and COEFF_LSB_mask
            end If
        else
            read_COEFF_LSB_value = data_low and COEFF_LSB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COEFF_LSB_value = &H0
        flag_COEFF_LSB        = &H0
    End Sub
End Class


'' @REGISTER : EC32TAP_coeff_09_msb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COEFF_MSB                                  [2:0]            get_COEFF_MSB
''                                                             set_COEFF_MSB
''                                                             read_COEFF_MSB
''                                                             write_COEFF_MSB
''---------------------------------------------------------------------------------
Class REGISTER_EC32TAP_coeff_09_msb
    Private write_COEFF_MSB_value
    Private read_COEFF_MSB_value
    Private flag_COEFF_MSB

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

    Property Get get_COEFF_MSB
        get_COEFF_MSB = read_COEFF_MSB_value
    End Property

    Property Let set_COEFF_MSB(aData)
        write_COEFF_MSB_value = aData
        flag_COEFF_MSB        = &H1
    End Property

    Property Get read_COEFF_MSB
        read
        read_COEFF_MSB = read_COEFF_MSB_value
    End Property

    Property Let write_COEFF_MSB(aData)
        set_COEFF_MSB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_MSB_mask = &H7
        if data_low > LONG_MAX then
            if COEFF_MSB_mask = mask then
                read_COEFF_MSB_value = data_low
            else
                read_COEFF_MSB_value = (data_low - H8000_0000) and COEFF_MSB_mask
            end If
        else
            read_COEFF_MSB_value = data_low and COEFF_MSB_mask
        end If

    End Sub

    Sub write
        If flag_COEFF_MSB = &H0 Then read
        If flag_COEFF_MSB = &H0 Then write_COEFF_MSB_value = get_COEFF_MSB

        regValue = leftShift((write_COEFF_MSB_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_MSB_mask = &H7
        if data_low > LONG_MAX then
            if COEFF_MSB_mask = mask then
                read_COEFF_MSB_value = data_low
            else
                read_COEFF_MSB_value = (data_low - H8000_0000) and COEFF_MSB_mask
            end If
        else
            read_COEFF_MSB_value = data_low and COEFF_MSB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COEFF_MSB_value = &H0
        flag_COEFF_MSB        = &H0
    End Sub
End Class


'' @REGISTER : EC32TAP_coeff_10_lsb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COEFF_LSB                                  [15:0]           get_COEFF_LSB
''                                                             set_COEFF_LSB
''                                                             read_COEFF_LSB
''                                                             write_COEFF_LSB
''---------------------------------------------------------------------------------
Class REGISTER_EC32TAP_coeff_10_lsb
    Private write_COEFF_LSB_value
    Private read_COEFF_LSB_value
    Private flag_COEFF_LSB

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

    Property Get get_COEFF_LSB
        get_COEFF_LSB = read_COEFF_LSB_value
    End Property

    Property Let set_COEFF_LSB(aData)
        write_COEFF_LSB_value = aData
        flag_COEFF_LSB        = &H1
    End Property

    Property Get read_COEFF_LSB
        read
        read_COEFF_LSB = read_COEFF_LSB_value
    End Property

    Property Let write_COEFF_LSB(aData)
        set_COEFF_LSB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_LSB_mask = &Hffff
        if data_low > LONG_MAX then
            if COEFF_LSB_mask = mask then
                read_COEFF_LSB_value = data_low
            else
                read_COEFF_LSB_value = (data_low - H8000_0000) and COEFF_LSB_mask
            end If
        else
            read_COEFF_LSB_value = data_low and COEFF_LSB_mask
        end If

    End Sub

    Sub write
        If flag_COEFF_LSB = &H0 Then read
        If flag_COEFF_LSB = &H0 Then write_COEFF_LSB_value = get_COEFF_LSB

        regValue = leftShift((write_COEFF_LSB_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_LSB_mask = &Hffff
        if data_low > LONG_MAX then
            if COEFF_LSB_mask = mask then
                read_COEFF_LSB_value = data_low
            else
                read_COEFF_LSB_value = (data_low - H8000_0000) and COEFF_LSB_mask
            end If
        else
            read_COEFF_LSB_value = data_low and COEFF_LSB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COEFF_LSB_value = &H0
        flag_COEFF_LSB        = &H0
    End Sub
End Class


'' @REGISTER : EC32TAP_coeff_10_msb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COEFF_MSB                                  [2:0]            get_COEFF_MSB
''                                                             set_COEFF_MSB
''                                                             read_COEFF_MSB
''                                                             write_COEFF_MSB
''---------------------------------------------------------------------------------
Class REGISTER_EC32TAP_coeff_10_msb
    Private write_COEFF_MSB_value
    Private read_COEFF_MSB_value
    Private flag_COEFF_MSB

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

    Property Get get_COEFF_MSB
        get_COEFF_MSB = read_COEFF_MSB_value
    End Property

    Property Let set_COEFF_MSB(aData)
        write_COEFF_MSB_value = aData
        flag_COEFF_MSB        = &H1
    End Property

    Property Get read_COEFF_MSB
        read
        read_COEFF_MSB = read_COEFF_MSB_value
    End Property

    Property Let write_COEFF_MSB(aData)
        set_COEFF_MSB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_MSB_mask = &H7
        if data_low > LONG_MAX then
            if COEFF_MSB_mask = mask then
                read_COEFF_MSB_value = data_low
            else
                read_COEFF_MSB_value = (data_low - H8000_0000) and COEFF_MSB_mask
            end If
        else
            read_COEFF_MSB_value = data_low and COEFF_MSB_mask
        end If

    End Sub

    Sub write
        If flag_COEFF_MSB = &H0 Then read
        If flag_COEFF_MSB = &H0 Then write_COEFF_MSB_value = get_COEFF_MSB

        regValue = leftShift((write_COEFF_MSB_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_MSB_mask = &H7
        if data_low > LONG_MAX then
            if COEFF_MSB_mask = mask then
                read_COEFF_MSB_value = data_low
            else
                read_COEFF_MSB_value = (data_low - H8000_0000) and COEFF_MSB_mask
            end If
        else
            read_COEFF_MSB_value = data_low and COEFF_MSB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COEFF_MSB_value = &H0
        flag_COEFF_MSB        = &H0
    End Sub
End Class


'' @REGISTER : EC32TAP_coeff_11_lsb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COEFF_LSB                                  [15:0]           get_COEFF_LSB
''                                                             set_COEFF_LSB
''                                                             read_COEFF_LSB
''                                                             write_COEFF_LSB
''---------------------------------------------------------------------------------
Class REGISTER_EC32TAP_coeff_11_lsb
    Private write_COEFF_LSB_value
    Private read_COEFF_LSB_value
    Private flag_COEFF_LSB

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

    Property Get get_COEFF_LSB
        get_COEFF_LSB = read_COEFF_LSB_value
    End Property

    Property Let set_COEFF_LSB(aData)
        write_COEFF_LSB_value = aData
        flag_COEFF_LSB        = &H1
    End Property

    Property Get read_COEFF_LSB
        read
        read_COEFF_LSB = read_COEFF_LSB_value
    End Property

    Property Let write_COEFF_LSB(aData)
        set_COEFF_LSB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_LSB_mask = &Hffff
        if data_low > LONG_MAX then
            if COEFF_LSB_mask = mask then
                read_COEFF_LSB_value = data_low
            else
                read_COEFF_LSB_value = (data_low - H8000_0000) and COEFF_LSB_mask
            end If
        else
            read_COEFF_LSB_value = data_low and COEFF_LSB_mask
        end If

    End Sub

    Sub write
        If flag_COEFF_LSB = &H0 Then read
        If flag_COEFF_LSB = &H0 Then write_COEFF_LSB_value = get_COEFF_LSB

        regValue = leftShift((write_COEFF_LSB_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_LSB_mask = &Hffff
        if data_low > LONG_MAX then
            if COEFF_LSB_mask = mask then
                read_COEFF_LSB_value = data_low
            else
                read_COEFF_LSB_value = (data_low - H8000_0000) and COEFF_LSB_mask
            end If
        else
            read_COEFF_LSB_value = data_low and COEFF_LSB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COEFF_LSB_value = &H0
        flag_COEFF_LSB        = &H0
    End Sub
End Class


'' @REGISTER : EC32TAP_coeff_11_msb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COEFF_MSB                                  [2:0]            get_COEFF_MSB
''                                                             set_COEFF_MSB
''                                                             read_COEFF_MSB
''                                                             write_COEFF_MSB
''---------------------------------------------------------------------------------
Class REGISTER_EC32TAP_coeff_11_msb
    Private write_COEFF_MSB_value
    Private read_COEFF_MSB_value
    Private flag_COEFF_MSB

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H2e
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COEFF_MSB
        get_COEFF_MSB = read_COEFF_MSB_value
    End Property

    Property Let set_COEFF_MSB(aData)
        write_COEFF_MSB_value = aData
        flag_COEFF_MSB        = &H1
    End Property

    Property Get read_COEFF_MSB
        read
        read_COEFF_MSB = read_COEFF_MSB_value
    End Property

    Property Let write_COEFF_MSB(aData)
        set_COEFF_MSB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_MSB_mask = &H7
        if data_low > LONG_MAX then
            if COEFF_MSB_mask = mask then
                read_COEFF_MSB_value = data_low
            else
                read_COEFF_MSB_value = (data_low - H8000_0000) and COEFF_MSB_mask
            end If
        else
            read_COEFF_MSB_value = data_low and COEFF_MSB_mask
        end If

    End Sub

    Sub write
        If flag_COEFF_MSB = &H0 Then read
        If flag_COEFF_MSB = &H0 Then write_COEFF_MSB_value = get_COEFF_MSB

        regValue = leftShift((write_COEFF_MSB_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_MSB_mask = &H7
        if data_low > LONG_MAX then
            if COEFF_MSB_mask = mask then
                read_COEFF_MSB_value = data_low
            else
                read_COEFF_MSB_value = (data_low - H8000_0000) and COEFF_MSB_mask
            end If
        else
            read_COEFF_MSB_value = data_low and COEFF_MSB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COEFF_MSB_value = &H0
        flag_COEFF_MSB        = &H0
    End Sub
End Class


'' @REGISTER : EC32TAP_coeff_12_lsb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COEFF_LSB                                  [15:0]           get_COEFF_LSB
''                                                             set_COEFF_LSB
''                                                             read_COEFF_LSB
''                                                             write_COEFF_LSB
''---------------------------------------------------------------------------------
Class REGISTER_EC32TAP_coeff_12_lsb
    Private write_COEFF_LSB_value
    Private read_COEFF_LSB_value
    Private flag_COEFF_LSB

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

    Property Get get_COEFF_LSB
        get_COEFF_LSB = read_COEFF_LSB_value
    End Property

    Property Let set_COEFF_LSB(aData)
        write_COEFF_LSB_value = aData
        flag_COEFF_LSB        = &H1
    End Property

    Property Get read_COEFF_LSB
        read
        read_COEFF_LSB = read_COEFF_LSB_value
    End Property

    Property Let write_COEFF_LSB(aData)
        set_COEFF_LSB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_LSB_mask = &Hffff
        if data_low > LONG_MAX then
            if COEFF_LSB_mask = mask then
                read_COEFF_LSB_value = data_low
            else
                read_COEFF_LSB_value = (data_low - H8000_0000) and COEFF_LSB_mask
            end If
        else
            read_COEFF_LSB_value = data_low and COEFF_LSB_mask
        end If

    End Sub

    Sub write
        If flag_COEFF_LSB = &H0 Then read
        If flag_COEFF_LSB = &H0 Then write_COEFF_LSB_value = get_COEFF_LSB

        regValue = leftShift((write_COEFF_LSB_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_LSB_mask = &Hffff
        if data_low > LONG_MAX then
            if COEFF_LSB_mask = mask then
                read_COEFF_LSB_value = data_low
            else
                read_COEFF_LSB_value = (data_low - H8000_0000) and COEFF_LSB_mask
            end If
        else
            read_COEFF_LSB_value = data_low and COEFF_LSB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COEFF_LSB_value = &H0
        flag_COEFF_LSB        = &H0
    End Sub
End Class


'' @REGISTER : EC32TAP_coeff_12_msb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COEFF_MSB                                  [2:0]            get_COEFF_MSB
''                                                             set_COEFF_MSB
''                                                             read_COEFF_MSB
''                                                             write_COEFF_MSB
''---------------------------------------------------------------------------------
Class REGISTER_EC32TAP_coeff_12_msb
    Private write_COEFF_MSB_value
    Private read_COEFF_MSB_value
    Private flag_COEFF_MSB

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

    Property Get get_COEFF_MSB
        get_COEFF_MSB = read_COEFF_MSB_value
    End Property

    Property Let set_COEFF_MSB(aData)
        write_COEFF_MSB_value = aData
        flag_COEFF_MSB        = &H1
    End Property

    Property Get read_COEFF_MSB
        read
        read_COEFF_MSB = read_COEFF_MSB_value
    End Property

    Property Let write_COEFF_MSB(aData)
        set_COEFF_MSB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_MSB_mask = &H7
        if data_low > LONG_MAX then
            if COEFF_MSB_mask = mask then
                read_COEFF_MSB_value = data_low
            else
                read_COEFF_MSB_value = (data_low - H8000_0000) and COEFF_MSB_mask
            end If
        else
            read_COEFF_MSB_value = data_low and COEFF_MSB_mask
        end If

    End Sub

    Sub write
        If flag_COEFF_MSB = &H0 Then read
        If flag_COEFF_MSB = &H0 Then write_COEFF_MSB_value = get_COEFF_MSB

        regValue = leftShift((write_COEFF_MSB_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_MSB_mask = &H7
        if data_low > LONG_MAX then
            if COEFF_MSB_mask = mask then
                read_COEFF_MSB_value = data_low
            else
                read_COEFF_MSB_value = (data_low - H8000_0000) and COEFF_MSB_mask
            end If
        else
            read_COEFF_MSB_value = data_low and COEFF_MSB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COEFF_MSB_value = &H0
        flag_COEFF_MSB        = &H0
    End Sub
End Class


'' @REGISTER : EC32TAP_coeff_13_lsb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COEFF_LSB                                  [15:0]           get_COEFF_LSB
''                                                             set_COEFF_LSB
''                                                             read_COEFF_LSB
''                                                             write_COEFF_LSB
''---------------------------------------------------------------------------------
Class REGISTER_EC32TAP_coeff_13_lsb
    Private write_COEFF_LSB_value
    Private read_COEFF_LSB_value
    Private flag_COEFF_LSB

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

    Property Get get_COEFF_LSB
        get_COEFF_LSB = read_COEFF_LSB_value
    End Property

    Property Let set_COEFF_LSB(aData)
        write_COEFF_LSB_value = aData
        flag_COEFF_LSB        = &H1
    End Property

    Property Get read_COEFF_LSB
        read
        read_COEFF_LSB = read_COEFF_LSB_value
    End Property

    Property Let write_COEFF_LSB(aData)
        set_COEFF_LSB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_LSB_mask = &Hffff
        if data_low > LONG_MAX then
            if COEFF_LSB_mask = mask then
                read_COEFF_LSB_value = data_low
            else
                read_COEFF_LSB_value = (data_low - H8000_0000) and COEFF_LSB_mask
            end If
        else
            read_COEFF_LSB_value = data_low and COEFF_LSB_mask
        end If

    End Sub

    Sub write
        If flag_COEFF_LSB = &H0 Then read
        If flag_COEFF_LSB = &H0 Then write_COEFF_LSB_value = get_COEFF_LSB

        regValue = leftShift((write_COEFF_LSB_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_LSB_mask = &Hffff
        if data_low > LONG_MAX then
            if COEFF_LSB_mask = mask then
                read_COEFF_LSB_value = data_low
            else
                read_COEFF_LSB_value = (data_low - H8000_0000) and COEFF_LSB_mask
            end If
        else
            read_COEFF_LSB_value = data_low and COEFF_LSB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COEFF_LSB_value = &H0
        flag_COEFF_LSB        = &H0
    End Sub
End Class


'' @REGISTER : EC32TAP_coeff_13_msb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COEFF_MSB                                  [2:0]            get_COEFF_MSB
''                                                             set_COEFF_MSB
''                                                             read_COEFF_MSB
''                                                             write_COEFF_MSB
''---------------------------------------------------------------------------------
Class REGISTER_EC32TAP_coeff_13_msb
    Private write_COEFF_MSB_value
    Private read_COEFF_MSB_value
    Private flag_COEFF_MSB

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

    Property Get get_COEFF_MSB
        get_COEFF_MSB = read_COEFF_MSB_value
    End Property

    Property Let set_COEFF_MSB(aData)
        write_COEFF_MSB_value = aData
        flag_COEFF_MSB        = &H1
    End Property

    Property Get read_COEFF_MSB
        read
        read_COEFF_MSB = read_COEFF_MSB_value
    End Property

    Property Let write_COEFF_MSB(aData)
        set_COEFF_MSB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_MSB_mask = &H7
        if data_low > LONG_MAX then
            if COEFF_MSB_mask = mask then
                read_COEFF_MSB_value = data_low
            else
                read_COEFF_MSB_value = (data_low - H8000_0000) and COEFF_MSB_mask
            end If
        else
            read_COEFF_MSB_value = data_low and COEFF_MSB_mask
        end If

    End Sub

    Sub write
        If flag_COEFF_MSB = &H0 Then read
        If flag_COEFF_MSB = &H0 Then write_COEFF_MSB_value = get_COEFF_MSB

        regValue = leftShift((write_COEFF_MSB_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_MSB_mask = &H7
        if data_low > LONG_MAX then
            if COEFF_MSB_mask = mask then
                read_COEFF_MSB_value = data_low
            else
                read_COEFF_MSB_value = (data_low - H8000_0000) and COEFF_MSB_mask
            end If
        else
            read_COEFF_MSB_value = data_low and COEFF_MSB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COEFF_MSB_value = &H0
        flag_COEFF_MSB        = &H0
    End Sub
End Class


'' @REGISTER : EC32TAP_coeff_14_lsb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COEFF_LSB                                  [15:0]           get_COEFF_LSB
''                                                             set_COEFF_LSB
''                                                             read_COEFF_LSB
''                                                             write_COEFF_LSB
''---------------------------------------------------------------------------------
Class REGISTER_EC32TAP_coeff_14_lsb
    Private write_COEFF_LSB_value
    Private read_COEFF_LSB_value
    Private flag_COEFF_LSB

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

    Property Get get_COEFF_LSB
        get_COEFF_LSB = read_COEFF_LSB_value
    End Property

    Property Let set_COEFF_LSB(aData)
        write_COEFF_LSB_value = aData
        flag_COEFF_LSB        = &H1
    End Property

    Property Get read_COEFF_LSB
        read
        read_COEFF_LSB = read_COEFF_LSB_value
    End Property

    Property Let write_COEFF_LSB(aData)
        set_COEFF_LSB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_LSB_mask = &Hffff
        if data_low > LONG_MAX then
            if COEFF_LSB_mask = mask then
                read_COEFF_LSB_value = data_low
            else
                read_COEFF_LSB_value = (data_low - H8000_0000) and COEFF_LSB_mask
            end If
        else
            read_COEFF_LSB_value = data_low and COEFF_LSB_mask
        end If

    End Sub

    Sub write
        If flag_COEFF_LSB = &H0 Then read
        If flag_COEFF_LSB = &H0 Then write_COEFF_LSB_value = get_COEFF_LSB

        regValue = leftShift((write_COEFF_LSB_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_LSB_mask = &Hffff
        if data_low > LONG_MAX then
            if COEFF_LSB_mask = mask then
                read_COEFF_LSB_value = data_low
            else
                read_COEFF_LSB_value = (data_low - H8000_0000) and COEFF_LSB_mask
            end If
        else
            read_COEFF_LSB_value = data_low and COEFF_LSB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COEFF_LSB_value = &H0
        flag_COEFF_LSB        = &H0
    End Sub
End Class


'' @REGISTER : EC32TAP_coeff_14_msb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COEFF_MSB                                  [2:0]            get_COEFF_MSB
''                                                             set_COEFF_MSB
''                                                             read_COEFF_MSB
''                                                             write_COEFF_MSB
''---------------------------------------------------------------------------------
Class REGISTER_EC32TAP_coeff_14_msb
    Private write_COEFF_MSB_value
    Private read_COEFF_MSB_value
    Private flag_COEFF_MSB

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

    Property Get get_COEFF_MSB
        get_COEFF_MSB = read_COEFF_MSB_value
    End Property

    Property Let set_COEFF_MSB(aData)
        write_COEFF_MSB_value = aData
        flag_COEFF_MSB        = &H1
    End Property

    Property Get read_COEFF_MSB
        read
        read_COEFF_MSB = read_COEFF_MSB_value
    End Property

    Property Let write_COEFF_MSB(aData)
        set_COEFF_MSB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_MSB_mask = &H7
        if data_low > LONG_MAX then
            if COEFF_MSB_mask = mask then
                read_COEFF_MSB_value = data_low
            else
                read_COEFF_MSB_value = (data_low - H8000_0000) and COEFF_MSB_mask
            end If
        else
            read_COEFF_MSB_value = data_low and COEFF_MSB_mask
        end If

    End Sub

    Sub write
        If flag_COEFF_MSB = &H0 Then read
        If flag_COEFF_MSB = &H0 Then write_COEFF_MSB_value = get_COEFF_MSB

        regValue = leftShift((write_COEFF_MSB_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_MSB_mask = &H7
        if data_low > LONG_MAX then
            if COEFF_MSB_mask = mask then
                read_COEFF_MSB_value = data_low
            else
                read_COEFF_MSB_value = (data_low - H8000_0000) and COEFF_MSB_mask
            end If
        else
            read_COEFF_MSB_value = data_low and COEFF_MSB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COEFF_MSB_value = &H0
        flag_COEFF_MSB        = &H0
    End Sub
End Class


'' @REGISTER : EC32TAP_coeff_15_lsb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COEFF_LSB                                  [15:0]           get_COEFF_LSB
''                                                             set_COEFF_LSB
''                                                             read_COEFF_LSB
''                                                             write_COEFF_LSB
''---------------------------------------------------------------------------------
Class REGISTER_EC32TAP_coeff_15_lsb
    Private write_COEFF_LSB_value
    Private read_COEFF_LSB_value
    Private flag_COEFF_LSB

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

    Property Get get_COEFF_LSB
        get_COEFF_LSB = read_COEFF_LSB_value
    End Property

    Property Let set_COEFF_LSB(aData)
        write_COEFF_LSB_value = aData
        flag_COEFF_LSB        = &H1
    End Property

    Property Get read_COEFF_LSB
        read
        read_COEFF_LSB = read_COEFF_LSB_value
    End Property

    Property Let write_COEFF_LSB(aData)
        set_COEFF_LSB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_LSB_mask = &Hffff
        if data_low > LONG_MAX then
            if COEFF_LSB_mask = mask then
                read_COEFF_LSB_value = data_low
            else
                read_COEFF_LSB_value = (data_low - H8000_0000) and COEFF_LSB_mask
            end If
        else
            read_COEFF_LSB_value = data_low and COEFF_LSB_mask
        end If

    End Sub

    Sub write
        If flag_COEFF_LSB = &H0 Then read
        If flag_COEFF_LSB = &H0 Then write_COEFF_LSB_value = get_COEFF_LSB

        regValue = leftShift((write_COEFF_LSB_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_LSB_mask = &Hffff
        if data_low > LONG_MAX then
            if COEFF_LSB_mask = mask then
                read_COEFF_LSB_value = data_low
            else
                read_COEFF_LSB_value = (data_low - H8000_0000) and COEFF_LSB_mask
            end If
        else
            read_COEFF_LSB_value = data_low and COEFF_LSB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COEFF_LSB_value = &H0
        flag_COEFF_LSB        = &H0
    End Sub
End Class


'' @REGISTER : EC32TAP_coeff_15_msb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COEFF_MSB                                  [2:0]            get_COEFF_MSB
''                                                             set_COEFF_MSB
''                                                             read_COEFF_MSB
''                                                             write_COEFF_MSB
''---------------------------------------------------------------------------------
Class REGISTER_EC32TAP_coeff_15_msb
    Private write_COEFF_MSB_value
    Private read_COEFF_MSB_value
    Private flag_COEFF_MSB

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3e
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COEFF_MSB
        get_COEFF_MSB = read_COEFF_MSB_value
    End Property

    Property Let set_COEFF_MSB(aData)
        write_COEFF_MSB_value = aData
        flag_COEFF_MSB        = &H1
    End Property

    Property Get read_COEFF_MSB
        read
        read_COEFF_MSB = read_COEFF_MSB_value
    End Property

    Property Let write_COEFF_MSB(aData)
        set_COEFF_MSB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_MSB_mask = &H7
        if data_low > LONG_MAX then
            if COEFF_MSB_mask = mask then
                read_COEFF_MSB_value = data_low
            else
                read_COEFF_MSB_value = (data_low - H8000_0000) and COEFF_MSB_mask
            end If
        else
            read_COEFF_MSB_value = data_low and COEFF_MSB_mask
        end If

    End Sub

    Sub write
        If flag_COEFF_MSB = &H0 Then read
        If flag_COEFF_MSB = &H0 Then write_COEFF_MSB_value = get_COEFF_MSB

        regValue = leftShift((write_COEFF_MSB_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_MSB_mask = &H7
        if data_low > LONG_MAX then
            if COEFF_MSB_mask = mask then
                read_COEFF_MSB_value = data_low
            else
                read_COEFF_MSB_value = (data_low - H8000_0000) and COEFF_MSB_mask
            end If
        else
            read_COEFF_MSB_value = data_low and COEFF_MSB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COEFF_MSB_value = &H0
        flag_COEFF_MSB        = &H0
    End Sub
End Class


'' @REGISTER : EC32TAP_coeff_16_lsb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COEFF_LSB                                  [15:0]           get_COEFF_LSB
''                                                             set_COEFF_LSB
''                                                             read_COEFF_LSB
''                                                             write_COEFF_LSB
''---------------------------------------------------------------------------------
Class REGISTER_EC32TAP_coeff_16_lsb
    Private write_COEFF_LSB_value
    Private read_COEFF_LSB_value
    Private flag_COEFF_LSB

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

    Property Get get_COEFF_LSB
        get_COEFF_LSB = read_COEFF_LSB_value
    End Property

    Property Let set_COEFF_LSB(aData)
        write_COEFF_LSB_value = aData
        flag_COEFF_LSB        = &H1
    End Property

    Property Get read_COEFF_LSB
        read
        read_COEFF_LSB = read_COEFF_LSB_value
    End Property

    Property Let write_COEFF_LSB(aData)
        set_COEFF_LSB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_LSB_mask = &Hffff
        if data_low > LONG_MAX then
            if COEFF_LSB_mask = mask then
                read_COEFF_LSB_value = data_low
            else
                read_COEFF_LSB_value = (data_low - H8000_0000) and COEFF_LSB_mask
            end If
        else
            read_COEFF_LSB_value = data_low and COEFF_LSB_mask
        end If

    End Sub

    Sub write
        If flag_COEFF_LSB = &H0 Then read
        If flag_COEFF_LSB = &H0 Then write_COEFF_LSB_value = get_COEFF_LSB

        regValue = leftShift((write_COEFF_LSB_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_LSB_mask = &Hffff
        if data_low > LONG_MAX then
            if COEFF_LSB_mask = mask then
                read_COEFF_LSB_value = data_low
            else
                read_COEFF_LSB_value = (data_low - H8000_0000) and COEFF_LSB_mask
            end If
        else
            read_COEFF_LSB_value = data_low and COEFF_LSB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COEFF_LSB_value = &H0
        flag_COEFF_LSB        = &H0
    End Sub
End Class


'' @REGISTER : EC32TAP_coeff_16_msb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COEFF_MSB                                  [2:0]            get_COEFF_MSB
''                                                             set_COEFF_MSB
''                                                             read_COEFF_MSB
''                                                             write_COEFF_MSB
''---------------------------------------------------------------------------------
Class REGISTER_EC32TAP_coeff_16_msb
    Private write_COEFF_MSB_value
    Private read_COEFF_MSB_value
    Private flag_COEFF_MSB

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

    Property Get get_COEFF_MSB
        get_COEFF_MSB = read_COEFF_MSB_value
    End Property

    Property Let set_COEFF_MSB(aData)
        write_COEFF_MSB_value = aData
        flag_COEFF_MSB        = &H1
    End Property

    Property Get read_COEFF_MSB
        read
        read_COEFF_MSB = read_COEFF_MSB_value
    End Property

    Property Let write_COEFF_MSB(aData)
        set_COEFF_MSB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_MSB_mask = &H7
        if data_low > LONG_MAX then
            if COEFF_MSB_mask = mask then
                read_COEFF_MSB_value = data_low
            else
                read_COEFF_MSB_value = (data_low - H8000_0000) and COEFF_MSB_mask
            end If
        else
            read_COEFF_MSB_value = data_low and COEFF_MSB_mask
        end If

    End Sub

    Sub write
        If flag_COEFF_MSB = &H0 Then read
        If flag_COEFF_MSB = &H0 Then write_COEFF_MSB_value = get_COEFF_MSB

        regValue = leftShift((write_COEFF_MSB_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_MSB_mask = &H7
        if data_low > LONG_MAX then
            if COEFF_MSB_mask = mask then
                read_COEFF_MSB_value = data_low
            else
                read_COEFF_MSB_value = (data_low - H8000_0000) and COEFF_MSB_mask
            end If
        else
            read_COEFF_MSB_value = data_low and COEFF_MSB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COEFF_MSB_value = &H0
        flag_COEFF_MSB        = &H0
    End Sub
End Class


'' @REGISTER : EC32TAP_coeff_17_lsb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COEFF_LSB                                  [15:0]           get_COEFF_LSB
''                                                             set_COEFF_LSB
''                                                             read_COEFF_LSB
''                                                             write_COEFF_LSB
''---------------------------------------------------------------------------------
Class REGISTER_EC32TAP_coeff_17_lsb
    Private write_COEFF_LSB_value
    Private read_COEFF_LSB_value
    Private flag_COEFF_LSB

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

    Property Get get_COEFF_LSB
        get_COEFF_LSB = read_COEFF_LSB_value
    End Property

    Property Let set_COEFF_LSB(aData)
        write_COEFF_LSB_value = aData
        flag_COEFF_LSB        = &H1
    End Property

    Property Get read_COEFF_LSB
        read
        read_COEFF_LSB = read_COEFF_LSB_value
    End Property

    Property Let write_COEFF_LSB(aData)
        set_COEFF_LSB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_LSB_mask = &Hffff
        if data_low > LONG_MAX then
            if COEFF_LSB_mask = mask then
                read_COEFF_LSB_value = data_low
            else
                read_COEFF_LSB_value = (data_low - H8000_0000) and COEFF_LSB_mask
            end If
        else
            read_COEFF_LSB_value = data_low and COEFF_LSB_mask
        end If

    End Sub

    Sub write
        If flag_COEFF_LSB = &H0 Then read
        If flag_COEFF_LSB = &H0 Then write_COEFF_LSB_value = get_COEFF_LSB

        regValue = leftShift((write_COEFF_LSB_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_LSB_mask = &Hffff
        if data_low > LONG_MAX then
            if COEFF_LSB_mask = mask then
                read_COEFF_LSB_value = data_low
            else
                read_COEFF_LSB_value = (data_low - H8000_0000) and COEFF_LSB_mask
            end If
        else
            read_COEFF_LSB_value = data_low and COEFF_LSB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COEFF_LSB_value = &H0
        flag_COEFF_LSB        = &H0
    End Sub
End Class


'' @REGISTER : EC32TAP_coeff_17_msb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COEFF_MSB                                  [2:0]            get_COEFF_MSB
''                                                             set_COEFF_MSB
''                                                             read_COEFF_MSB
''                                                             write_COEFF_MSB
''---------------------------------------------------------------------------------
Class REGISTER_EC32TAP_coeff_17_msb
    Private write_COEFF_MSB_value
    Private read_COEFF_MSB_value
    Private flag_COEFF_MSB

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

    Property Get get_COEFF_MSB
        get_COEFF_MSB = read_COEFF_MSB_value
    End Property

    Property Let set_COEFF_MSB(aData)
        write_COEFF_MSB_value = aData
        flag_COEFF_MSB        = &H1
    End Property

    Property Get read_COEFF_MSB
        read
        read_COEFF_MSB = read_COEFF_MSB_value
    End Property

    Property Let write_COEFF_MSB(aData)
        set_COEFF_MSB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_MSB_mask = &H7
        if data_low > LONG_MAX then
            if COEFF_MSB_mask = mask then
                read_COEFF_MSB_value = data_low
            else
                read_COEFF_MSB_value = (data_low - H8000_0000) and COEFF_MSB_mask
            end If
        else
            read_COEFF_MSB_value = data_low and COEFF_MSB_mask
        end If

    End Sub

    Sub write
        If flag_COEFF_MSB = &H0 Then read
        If flag_COEFF_MSB = &H0 Then write_COEFF_MSB_value = get_COEFF_MSB

        regValue = leftShift((write_COEFF_MSB_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_MSB_mask = &H7
        if data_low > LONG_MAX then
            if COEFF_MSB_mask = mask then
                read_COEFF_MSB_value = data_low
            else
                read_COEFF_MSB_value = (data_low - H8000_0000) and COEFF_MSB_mask
            end If
        else
            read_COEFF_MSB_value = data_low and COEFF_MSB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COEFF_MSB_value = &H0
        flag_COEFF_MSB        = &H0
    End Sub
End Class


'' @REGISTER : EC32TAP_coeff_18_lsb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COEFF_LSB                                  [15:0]           get_COEFF_LSB
''                                                             set_COEFF_LSB
''                                                             read_COEFF_LSB
''                                                             write_COEFF_LSB
''---------------------------------------------------------------------------------
Class REGISTER_EC32TAP_coeff_18_lsb
    Private write_COEFF_LSB_value
    Private read_COEFF_LSB_value
    Private flag_COEFF_LSB

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

    Property Get get_COEFF_LSB
        get_COEFF_LSB = read_COEFF_LSB_value
    End Property

    Property Let set_COEFF_LSB(aData)
        write_COEFF_LSB_value = aData
        flag_COEFF_LSB        = &H1
    End Property

    Property Get read_COEFF_LSB
        read
        read_COEFF_LSB = read_COEFF_LSB_value
    End Property

    Property Let write_COEFF_LSB(aData)
        set_COEFF_LSB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_LSB_mask = &Hffff
        if data_low > LONG_MAX then
            if COEFF_LSB_mask = mask then
                read_COEFF_LSB_value = data_low
            else
                read_COEFF_LSB_value = (data_low - H8000_0000) and COEFF_LSB_mask
            end If
        else
            read_COEFF_LSB_value = data_low and COEFF_LSB_mask
        end If

    End Sub

    Sub write
        If flag_COEFF_LSB = &H0 Then read
        If flag_COEFF_LSB = &H0 Then write_COEFF_LSB_value = get_COEFF_LSB

        regValue = leftShift((write_COEFF_LSB_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_LSB_mask = &Hffff
        if data_low > LONG_MAX then
            if COEFF_LSB_mask = mask then
                read_COEFF_LSB_value = data_low
            else
                read_COEFF_LSB_value = (data_low - H8000_0000) and COEFF_LSB_mask
            end If
        else
            read_COEFF_LSB_value = data_low and COEFF_LSB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COEFF_LSB_value = &H0
        flag_COEFF_LSB        = &H0
    End Sub
End Class


'' @REGISTER : EC32TAP_coeff_18_msb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COEFF_MSB                                  [2:0]            get_COEFF_MSB
''                                                             set_COEFF_MSB
''                                                             read_COEFF_MSB
''                                                             write_COEFF_MSB
''---------------------------------------------------------------------------------
Class REGISTER_EC32TAP_coeff_18_msb
    Private write_COEFF_MSB_value
    Private read_COEFF_MSB_value
    Private flag_COEFF_MSB

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

    Property Get get_COEFF_MSB
        get_COEFF_MSB = read_COEFF_MSB_value
    End Property

    Property Let set_COEFF_MSB(aData)
        write_COEFF_MSB_value = aData
        flag_COEFF_MSB        = &H1
    End Property

    Property Get read_COEFF_MSB
        read
        read_COEFF_MSB = read_COEFF_MSB_value
    End Property

    Property Let write_COEFF_MSB(aData)
        set_COEFF_MSB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_MSB_mask = &H7
        if data_low > LONG_MAX then
            if COEFF_MSB_mask = mask then
                read_COEFF_MSB_value = data_low
            else
                read_COEFF_MSB_value = (data_low - H8000_0000) and COEFF_MSB_mask
            end If
        else
            read_COEFF_MSB_value = data_low and COEFF_MSB_mask
        end If

    End Sub

    Sub write
        If flag_COEFF_MSB = &H0 Then read
        If flag_COEFF_MSB = &H0 Then write_COEFF_MSB_value = get_COEFF_MSB

        regValue = leftShift((write_COEFF_MSB_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_MSB_mask = &H7
        if data_low > LONG_MAX then
            if COEFF_MSB_mask = mask then
                read_COEFF_MSB_value = data_low
            else
                read_COEFF_MSB_value = (data_low - H8000_0000) and COEFF_MSB_mask
            end If
        else
            read_COEFF_MSB_value = data_low and COEFF_MSB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COEFF_MSB_value = &H0
        flag_COEFF_MSB        = &H0
    End Sub
End Class


'' @REGISTER : EC32TAP_coeff_19_lsb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COEFF_LSB                                  [15:0]           get_COEFF_LSB
''                                                             set_COEFF_LSB
''                                                             read_COEFF_LSB
''                                                             write_COEFF_LSB
''---------------------------------------------------------------------------------
Class REGISTER_EC32TAP_coeff_19_lsb
    Private write_COEFF_LSB_value
    Private read_COEFF_LSB_value
    Private flag_COEFF_LSB

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

    Property Get get_COEFF_LSB
        get_COEFF_LSB = read_COEFF_LSB_value
    End Property

    Property Let set_COEFF_LSB(aData)
        write_COEFF_LSB_value = aData
        flag_COEFF_LSB        = &H1
    End Property

    Property Get read_COEFF_LSB
        read
        read_COEFF_LSB = read_COEFF_LSB_value
    End Property

    Property Let write_COEFF_LSB(aData)
        set_COEFF_LSB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_LSB_mask = &Hffff
        if data_low > LONG_MAX then
            if COEFF_LSB_mask = mask then
                read_COEFF_LSB_value = data_low
            else
                read_COEFF_LSB_value = (data_low - H8000_0000) and COEFF_LSB_mask
            end If
        else
            read_COEFF_LSB_value = data_low and COEFF_LSB_mask
        end If

    End Sub

    Sub write
        If flag_COEFF_LSB = &H0 Then read
        If flag_COEFF_LSB = &H0 Then write_COEFF_LSB_value = get_COEFF_LSB

        regValue = leftShift((write_COEFF_LSB_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_LSB_mask = &Hffff
        if data_low > LONG_MAX then
            if COEFF_LSB_mask = mask then
                read_COEFF_LSB_value = data_low
            else
                read_COEFF_LSB_value = (data_low - H8000_0000) and COEFF_LSB_mask
            end If
        else
            read_COEFF_LSB_value = data_low and COEFF_LSB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COEFF_LSB_value = &H0
        flag_COEFF_LSB        = &H0
    End Sub
End Class


'' @REGISTER : EC32TAP_coeff_19_msb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COEFF_MSB                                  [2:0]            get_COEFF_MSB
''                                                             set_COEFF_MSB
''                                                             read_COEFF_MSB
''                                                             write_COEFF_MSB
''---------------------------------------------------------------------------------
Class REGISTER_EC32TAP_coeff_19_msb
    Private write_COEFF_MSB_value
    Private read_COEFF_MSB_value
    Private flag_COEFF_MSB

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H4e
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COEFF_MSB
        get_COEFF_MSB = read_COEFF_MSB_value
    End Property

    Property Let set_COEFF_MSB(aData)
        write_COEFF_MSB_value = aData
        flag_COEFF_MSB        = &H1
    End Property

    Property Get read_COEFF_MSB
        read
        read_COEFF_MSB = read_COEFF_MSB_value
    End Property

    Property Let write_COEFF_MSB(aData)
        set_COEFF_MSB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_MSB_mask = &H7
        if data_low > LONG_MAX then
            if COEFF_MSB_mask = mask then
                read_COEFF_MSB_value = data_low
            else
                read_COEFF_MSB_value = (data_low - H8000_0000) and COEFF_MSB_mask
            end If
        else
            read_COEFF_MSB_value = data_low and COEFF_MSB_mask
        end If

    End Sub

    Sub write
        If flag_COEFF_MSB = &H0 Then read
        If flag_COEFF_MSB = &H0 Then write_COEFF_MSB_value = get_COEFF_MSB

        regValue = leftShift((write_COEFF_MSB_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_MSB_mask = &H7
        if data_low > LONG_MAX then
            if COEFF_MSB_mask = mask then
                read_COEFF_MSB_value = data_low
            else
                read_COEFF_MSB_value = (data_low - H8000_0000) and COEFF_MSB_mask
            end If
        else
            read_COEFF_MSB_value = data_low and COEFF_MSB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COEFF_MSB_value = &H0
        flag_COEFF_MSB        = &H0
    End Sub
End Class


'' @REGISTER : EC32TAP_coeff_20_lsb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COEFF_LSB                                  [15:0]           get_COEFF_LSB
''                                                             set_COEFF_LSB
''                                                             read_COEFF_LSB
''                                                             write_COEFF_LSB
''---------------------------------------------------------------------------------
Class REGISTER_EC32TAP_coeff_20_lsb
    Private write_COEFF_LSB_value
    Private read_COEFF_LSB_value
    Private flag_COEFF_LSB

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

    Property Get get_COEFF_LSB
        get_COEFF_LSB = read_COEFF_LSB_value
    End Property

    Property Let set_COEFF_LSB(aData)
        write_COEFF_LSB_value = aData
        flag_COEFF_LSB        = &H1
    End Property

    Property Get read_COEFF_LSB
        read
        read_COEFF_LSB = read_COEFF_LSB_value
    End Property

    Property Let write_COEFF_LSB(aData)
        set_COEFF_LSB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_LSB_mask = &Hffff
        if data_low > LONG_MAX then
            if COEFF_LSB_mask = mask then
                read_COEFF_LSB_value = data_low
            else
                read_COEFF_LSB_value = (data_low - H8000_0000) and COEFF_LSB_mask
            end If
        else
            read_COEFF_LSB_value = data_low and COEFF_LSB_mask
        end If

    End Sub

    Sub write
        If flag_COEFF_LSB = &H0 Then read
        If flag_COEFF_LSB = &H0 Then write_COEFF_LSB_value = get_COEFF_LSB

        regValue = leftShift((write_COEFF_LSB_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_LSB_mask = &Hffff
        if data_low > LONG_MAX then
            if COEFF_LSB_mask = mask then
                read_COEFF_LSB_value = data_low
            else
                read_COEFF_LSB_value = (data_low - H8000_0000) and COEFF_LSB_mask
            end If
        else
            read_COEFF_LSB_value = data_low and COEFF_LSB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COEFF_LSB_value = &H0
        flag_COEFF_LSB        = &H0
    End Sub
End Class


'' @REGISTER : EC32TAP_coeff_20_msb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COEFF_MSB                                  [2:0]            get_COEFF_MSB
''                                                             set_COEFF_MSB
''                                                             read_COEFF_MSB
''                                                             write_COEFF_MSB
''---------------------------------------------------------------------------------
Class REGISTER_EC32TAP_coeff_20_msb
    Private write_COEFF_MSB_value
    Private read_COEFF_MSB_value
    Private flag_COEFF_MSB

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

    Property Get get_COEFF_MSB
        get_COEFF_MSB = read_COEFF_MSB_value
    End Property

    Property Let set_COEFF_MSB(aData)
        write_COEFF_MSB_value = aData
        flag_COEFF_MSB        = &H1
    End Property

    Property Get read_COEFF_MSB
        read
        read_COEFF_MSB = read_COEFF_MSB_value
    End Property

    Property Let write_COEFF_MSB(aData)
        set_COEFF_MSB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_MSB_mask = &H7
        if data_low > LONG_MAX then
            if COEFF_MSB_mask = mask then
                read_COEFF_MSB_value = data_low
            else
                read_COEFF_MSB_value = (data_low - H8000_0000) and COEFF_MSB_mask
            end If
        else
            read_COEFF_MSB_value = data_low and COEFF_MSB_mask
        end If

    End Sub

    Sub write
        If flag_COEFF_MSB = &H0 Then read
        If flag_COEFF_MSB = &H0 Then write_COEFF_MSB_value = get_COEFF_MSB

        regValue = leftShift((write_COEFF_MSB_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_MSB_mask = &H7
        if data_low > LONG_MAX then
            if COEFF_MSB_mask = mask then
                read_COEFF_MSB_value = data_low
            else
                read_COEFF_MSB_value = (data_low - H8000_0000) and COEFF_MSB_mask
            end If
        else
            read_COEFF_MSB_value = data_low and COEFF_MSB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COEFF_MSB_value = &H0
        flag_COEFF_MSB        = &H0
    End Sub
End Class


'' @REGISTER : EC32TAP_coeff_21_lsb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COEFF_LSB                                  [15:0]           get_COEFF_LSB
''                                                             set_COEFF_LSB
''                                                             read_COEFF_LSB
''                                                             write_COEFF_LSB
''---------------------------------------------------------------------------------
Class REGISTER_EC32TAP_coeff_21_lsb
    Private write_COEFF_LSB_value
    Private read_COEFF_LSB_value
    Private flag_COEFF_LSB

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

    Property Get get_COEFF_LSB
        get_COEFF_LSB = read_COEFF_LSB_value
    End Property

    Property Let set_COEFF_LSB(aData)
        write_COEFF_LSB_value = aData
        flag_COEFF_LSB        = &H1
    End Property

    Property Get read_COEFF_LSB
        read
        read_COEFF_LSB = read_COEFF_LSB_value
    End Property

    Property Let write_COEFF_LSB(aData)
        set_COEFF_LSB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_LSB_mask = &Hffff
        if data_low > LONG_MAX then
            if COEFF_LSB_mask = mask then
                read_COEFF_LSB_value = data_low
            else
                read_COEFF_LSB_value = (data_low - H8000_0000) and COEFF_LSB_mask
            end If
        else
            read_COEFF_LSB_value = data_low and COEFF_LSB_mask
        end If

    End Sub

    Sub write
        If flag_COEFF_LSB = &H0 Then read
        If flag_COEFF_LSB = &H0 Then write_COEFF_LSB_value = get_COEFF_LSB

        regValue = leftShift((write_COEFF_LSB_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_LSB_mask = &Hffff
        if data_low > LONG_MAX then
            if COEFF_LSB_mask = mask then
                read_COEFF_LSB_value = data_low
            else
                read_COEFF_LSB_value = (data_low - H8000_0000) and COEFF_LSB_mask
            end If
        else
            read_COEFF_LSB_value = data_low and COEFF_LSB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COEFF_LSB_value = &H0
        flag_COEFF_LSB        = &H0
    End Sub
End Class


'' @REGISTER : EC32TAP_coeff_21_msb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COEFF_MSB                                  [2:0]            get_COEFF_MSB
''                                                             set_COEFF_MSB
''                                                             read_COEFF_MSB
''                                                             write_COEFF_MSB
''---------------------------------------------------------------------------------
Class REGISTER_EC32TAP_coeff_21_msb
    Private write_COEFF_MSB_value
    Private read_COEFF_MSB_value
    Private flag_COEFF_MSB

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

    Property Get get_COEFF_MSB
        get_COEFF_MSB = read_COEFF_MSB_value
    End Property

    Property Let set_COEFF_MSB(aData)
        write_COEFF_MSB_value = aData
        flag_COEFF_MSB        = &H1
    End Property

    Property Get read_COEFF_MSB
        read
        read_COEFF_MSB = read_COEFF_MSB_value
    End Property

    Property Let write_COEFF_MSB(aData)
        set_COEFF_MSB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_MSB_mask = &H7
        if data_low > LONG_MAX then
            if COEFF_MSB_mask = mask then
                read_COEFF_MSB_value = data_low
            else
                read_COEFF_MSB_value = (data_low - H8000_0000) and COEFF_MSB_mask
            end If
        else
            read_COEFF_MSB_value = data_low and COEFF_MSB_mask
        end If

    End Sub

    Sub write
        If flag_COEFF_MSB = &H0 Then read
        If flag_COEFF_MSB = &H0 Then write_COEFF_MSB_value = get_COEFF_MSB

        regValue = leftShift((write_COEFF_MSB_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_MSB_mask = &H7
        if data_low > LONG_MAX then
            if COEFF_MSB_mask = mask then
                read_COEFF_MSB_value = data_low
            else
                read_COEFF_MSB_value = (data_low - H8000_0000) and COEFF_MSB_mask
            end If
        else
            read_COEFF_MSB_value = data_low and COEFF_MSB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COEFF_MSB_value = &H0
        flag_COEFF_MSB        = &H0
    End Sub
End Class


'' @REGISTER : EC32TAP_coeff_22_lsb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COEFF_LSB                                  [15:0]           get_COEFF_LSB
''                                                             set_COEFF_LSB
''                                                             read_COEFF_LSB
''                                                             write_COEFF_LSB
''---------------------------------------------------------------------------------
Class REGISTER_EC32TAP_coeff_22_lsb
    Private write_COEFF_LSB_value
    Private read_COEFF_LSB_value
    Private flag_COEFF_LSB

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

    Property Get get_COEFF_LSB
        get_COEFF_LSB = read_COEFF_LSB_value
    End Property

    Property Let set_COEFF_LSB(aData)
        write_COEFF_LSB_value = aData
        flag_COEFF_LSB        = &H1
    End Property

    Property Get read_COEFF_LSB
        read
        read_COEFF_LSB = read_COEFF_LSB_value
    End Property

    Property Let write_COEFF_LSB(aData)
        set_COEFF_LSB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_LSB_mask = &Hffff
        if data_low > LONG_MAX then
            if COEFF_LSB_mask = mask then
                read_COEFF_LSB_value = data_low
            else
                read_COEFF_LSB_value = (data_low - H8000_0000) and COEFF_LSB_mask
            end If
        else
            read_COEFF_LSB_value = data_low and COEFF_LSB_mask
        end If

    End Sub

    Sub write
        If flag_COEFF_LSB = &H0 Then read
        If flag_COEFF_LSB = &H0 Then write_COEFF_LSB_value = get_COEFF_LSB

        regValue = leftShift((write_COEFF_LSB_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_LSB_mask = &Hffff
        if data_low > LONG_MAX then
            if COEFF_LSB_mask = mask then
                read_COEFF_LSB_value = data_low
            else
                read_COEFF_LSB_value = (data_low - H8000_0000) and COEFF_LSB_mask
            end If
        else
            read_COEFF_LSB_value = data_low and COEFF_LSB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COEFF_LSB_value = &H0
        flag_COEFF_LSB        = &H0
    End Sub
End Class


'' @REGISTER : EC32TAP_coeff_22_msb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COEFF_MSB                                  [2:0]            get_COEFF_MSB
''                                                             set_COEFF_MSB
''                                                             read_COEFF_MSB
''                                                             write_COEFF_MSB
''---------------------------------------------------------------------------------
Class REGISTER_EC32TAP_coeff_22_msb
    Private write_COEFF_MSB_value
    Private read_COEFF_MSB_value
    Private flag_COEFF_MSB

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

    Property Get get_COEFF_MSB
        get_COEFF_MSB = read_COEFF_MSB_value
    End Property

    Property Let set_COEFF_MSB(aData)
        write_COEFF_MSB_value = aData
        flag_COEFF_MSB        = &H1
    End Property

    Property Get read_COEFF_MSB
        read
        read_COEFF_MSB = read_COEFF_MSB_value
    End Property

    Property Let write_COEFF_MSB(aData)
        set_COEFF_MSB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_MSB_mask = &H7
        if data_low > LONG_MAX then
            if COEFF_MSB_mask = mask then
                read_COEFF_MSB_value = data_low
            else
                read_COEFF_MSB_value = (data_low - H8000_0000) and COEFF_MSB_mask
            end If
        else
            read_COEFF_MSB_value = data_low and COEFF_MSB_mask
        end If

    End Sub

    Sub write
        If flag_COEFF_MSB = &H0 Then read
        If flag_COEFF_MSB = &H0 Then write_COEFF_MSB_value = get_COEFF_MSB

        regValue = leftShift((write_COEFF_MSB_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_MSB_mask = &H7
        if data_low > LONG_MAX then
            if COEFF_MSB_mask = mask then
                read_COEFF_MSB_value = data_low
            else
                read_COEFF_MSB_value = (data_low - H8000_0000) and COEFF_MSB_mask
            end If
        else
            read_COEFF_MSB_value = data_low and COEFF_MSB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COEFF_MSB_value = &H0
        flag_COEFF_MSB        = &H0
    End Sub
End Class


'' @REGISTER : EC32TAP_coeff_23_lsb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COEFF_LSB                                  [15:0]           get_COEFF_LSB
''                                                             set_COEFF_LSB
''                                                             read_COEFF_LSB
''                                                             write_COEFF_LSB
''---------------------------------------------------------------------------------
Class REGISTER_EC32TAP_coeff_23_lsb
    Private write_COEFF_LSB_value
    Private read_COEFF_LSB_value
    Private flag_COEFF_LSB

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

    Property Get get_COEFF_LSB
        get_COEFF_LSB = read_COEFF_LSB_value
    End Property

    Property Let set_COEFF_LSB(aData)
        write_COEFF_LSB_value = aData
        flag_COEFF_LSB        = &H1
    End Property

    Property Get read_COEFF_LSB
        read
        read_COEFF_LSB = read_COEFF_LSB_value
    End Property

    Property Let write_COEFF_LSB(aData)
        set_COEFF_LSB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_LSB_mask = &Hffff
        if data_low > LONG_MAX then
            if COEFF_LSB_mask = mask then
                read_COEFF_LSB_value = data_low
            else
                read_COEFF_LSB_value = (data_low - H8000_0000) and COEFF_LSB_mask
            end If
        else
            read_COEFF_LSB_value = data_low and COEFF_LSB_mask
        end If

    End Sub

    Sub write
        If flag_COEFF_LSB = &H0 Then read
        If flag_COEFF_LSB = &H0 Then write_COEFF_LSB_value = get_COEFF_LSB

        regValue = leftShift((write_COEFF_LSB_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_LSB_mask = &Hffff
        if data_low > LONG_MAX then
            if COEFF_LSB_mask = mask then
                read_COEFF_LSB_value = data_low
            else
                read_COEFF_LSB_value = (data_low - H8000_0000) and COEFF_LSB_mask
            end If
        else
            read_COEFF_LSB_value = data_low and COEFF_LSB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COEFF_LSB_value = &H0
        flag_COEFF_LSB        = &H0
    End Sub
End Class


'' @REGISTER : EC32TAP_coeff_23_msb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COEFF_MSB                                  [2:0]            get_COEFF_MSB
''                                                             set_COEFF_MSB
''                                                             read_COEFF_MSB
''                                                             write_COEFF_MSB
''---------------------------------------------------------------------------------
Class REGISTER_EC32TAP_coeff_23_msb
    Private write_COEFF_MSB_value
    Private read_COEFF_MSB_value
    Private flag_COEFF_MSB

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H5e
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COEFF_MSB
        get_COEFF_MSB = read_COEFF_MSB_value
    End Property

    Property Let set_COEFF_MSB(aData)
        write_COEFF_MSB_value = aData
        flag_COEFF_MSB        = &H1
    End Property

    Property Get read_COEFF_MSB
        read
        read_COEFF_MSB = read_COEFF_MSB_value
    End Property

    Property Let write_COEFF_MSB(aData)
        set_COEFF_MSB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_MSB_mask = &H7
        if data_low > LONG_MAX then
            if COEFF_MSB_mask = mask then
                read_COEFF_MSB_value = data_low
            else
                read_COEFF_MSB_value = (data_low - H8000_0000) and COEFF_MSB_mask
            end If
        else
            read_COEFF_MSB_value = data_low and COEFF_MSB_mask
        end If

    End Sub

    Sub write
        If flag_COEFF_MSB = &H0 Then read
        If flag_COEFF_MSB = &H0 Then write_COEFF_MSB_value = get_COEFF_MSB

        regValue = leftShift((write_COEFF_MSB_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_MSB_mask = &H7
        if data_low > LONG_MAX then
            if COEFF_MSB_mask = mask then
                read_COEFF_MSB_value = data_low
            else
                read_COEFF_MSB_value = (data_low - H8000_0000) and COEFF_MSB_mask
            end If
        else
            read_COEFF_MSB_value = data_low and COEFF_MSB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COEFF_MSB_value = &H0
        flag_COEFF_MSB        = &H0
    End Sub
End Class


'' @REGISTER : EC32TAP_coeff_24_lsb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COEFF_LSB                                  [15:0]           get_COEFF_LSB
''                                                             set_COEFF_LSB
''                                                             read_COEFF_LSB
''                                                             write_COEFF_LSB
''---------------------------------------------------------------------------------
Class REGISTER_EC32TAP_coeff_24_lsb
    Private write_COEFF_LSB_value
    Private read_COEFF_LSB_value
    Private flag_COEFF_LSB

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

    Property Get get_COEFF_LSB
        get_COEFF_LSB = read_COEFF_LSB_value
    End Property

    Property Let set_COEFF_LSB(aData)
        write_COEFF_LSB_value = aData
        flag_COEFF_LSB        = &H1
    End Property

    Property Get read_COEFF_LSB
        read
        read_COEFF_LSB = read_COEFF_LSB_value
    End Property

    Property Let write_COEFF_LSB(aData)
        set_COEFF_LSB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_LSB_mask = &Hffff
        if data_low > LONG_MAX then
            if COEFF_LSB_mask = mask then
                read_COEFF_LSB_value = data_low
            else
                read_COEFF_LSB_value = (data_low - H8000_0000) and COEFF_LSB_mask
            end If
        else
            read_COEFF_LSB_value = data_low and COEFF_LSB_mask
        end If

    End Sub

    Sub write
        If flag_COEFF_LSB = &H0 Then read
        If flag_COEFF_LSB = &H0 Then write_COEFF_LSB_value = get_COEFF_LSB

        regValue = leftShift((write_COEFF_LSB_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_LSB_mask = &Hffff
        if data_low > LONG_MAX then
            if COEFF_LSB_mask = mask then
                read_COEFF_LSB_value = data_low
            else
                read_COEFF_LSB_value = (data_low - H8000_0000) and COEFF_LSB_mask
            end If
        else
            read_COEFF_LSB_value = data_low and COEFF_LSB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COEFF_LSB_value = &H0
        flag_COEFF_LSB        = &H0
    End Sub
End Class


'' @REGISTER : EC32TAP_coeff_24_msb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COEFF_MSB                                  [2:0]            get_COEFF_MSB
''                                                             set_COEFF_MSB
''                                                             read_COEFF_MSB
''                                                             write_COEFF_MSB
''---------------------------------------------------------------------------------
Class REGISTER_EC32TAP_coeff_24_msb
    Private write_COEFF_MSB_value
    Private read_COEFF_MSB_value
    Private flag_COEFF_MSB

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

    Property Get get_COEFF_MSB
        get_COEFF_MSB = read_COEFF_MSB_value
    End Property

    Property Let set_COEFF_MSB(aData)
        write_COEFF_MSB_value = aData
        flag_COEFF_MSB        = &H1
    End Property

    Property Get read_COEFF_MSB
        read
        read_COEFF_MSB = read_COEFF_MSB_value
    End Property

    Property Let write_COEFF_MSB(aData)
        set_COEFF_MSB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_MSB_mask = &H7
        if data_low > LONG_MAX then
            if COEFF_MSB_mask = mask then
                read_COEFF_MSB_value = data_low
            else
                read_COEFF_MSB_value = (data_low - H8000_0000) and COEFF_MSB_mask
            end If
        else
            read_COEFF_MSB_value = data_low and COEFF_MSB_mask
        end If

    End Sub

    Sub write
        If flag_COEFF_MSB = &H0 Then read
        If flag_COEFF_MSB = &H0 Then write_COEFF_MSB_value = get_COEFF_MSB

        regValue = leftShift((write_COEFF_MSB_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_MSB_mask = &H7
        if data_low > LONG_MAX then
            if COEFF_MSB_mask = mask then
                read_COEFF_MSB_value = data_low
            else
                read_COEFF_MSB_value = (data_low - H8000_0000) and COEFF_MSB_mask
            end If
        else
            read_COEFF_MSB_value = data_low and COEFF_MSB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COEFF_MSB_value = &H0
        flag_COEFF_MSB        = &H0
    End Sub
End Class


'' @REGISTER : EC32TAP_coeff_25_lsb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COEFF_LSB                                  [15:0]           get_COEFF_LSB
''                                                             set_COEFF_LSB
''                                                             read_COEFF_LSB
''                                                             write_COEFF_LSB
''---------------------------------------------------------------------------------
Class REGISTER_EC32TAP_coeff_25_lsb
    Private write_COEFF_LSB_value
    Private read_COEFF_LSB_value
    Private flag_COEFF_LSB

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

    Property Get get_COEFF_LSB
        get_COEFF_LSB = read_COEFF_LSB_value
    End Property

    Property Let set_COEFF_LSB(aData)
        write_COEFF_LSB_value = aData
        flag_COEFF_LSB        = &H1
    End Property

    Property Get read_COEFF_LSB
        read
        read_COEFF_LSB = read_COEFF_LSB_value
    End Property

    Property Let write_COEFF_LSB(aData)
        set_COEFF_LSB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_LSB_mask = &Hffff
        if data_low > LONG_MAX then
            if COEFF_LSB_mask = mask then
                read_COEFF_LSB_value = data_low
            else
                read_COEFF_LSB_value = (data_low - H8000_0000) and COEFF_LSB_mask
            end If
        else
            read_COEFF_LSB_value = data_low and COEFF_LSB_mask
        end If

    End Sub

    Sub write
        If flag_COEFF_LSB = &H0 Then read
        If flag_COEFF_LSB = &H0 Then write_COEFF_LSB_value = get_COEFF_LSB

        regValue = leftShift((write_COEFF_LSB_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_LSB_mask = &Hffff
        if data_low > LONG_MAX then
            if COEFF_LSB_mask = mask then
                read_COEFF_LSB_value = data_low
            else
                read_COEFF_LSB_value = (data_low - H8000_0000) and COEFF_LSB_mask
            end If
        else
            read_COEFF_LSB_value = data_low and COEFF_LSB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COEFF_LSB_value = &H0
        flag_COEFF_LSB        = &H0
    End Sub
End Class


'' @REGISTER : EC32TAP_coeff_25_msb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COEFF_MSB                                  [2:0]            get_COEFF_MSB
''                                                             set_COEFF_MSB
''                                                             read_COEFF_MSB
''                                                             write_COEFF_MSB
''---------------------------------------------------------------------------------
Class REGISTER_EC32TAP_coeff_25_msb
    Private write_COEFF_MSB_value
    Private read_COEFF_MSB_value
    Private flag_COEFF_MSB

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

    Property Get get_COEFF_MSB
        get_COEFF_MSB = read_COEFF_MSB_value
    End Property

    Property Let set_COEFF_MSB(aData)
        write_COEFF_MSB_value = aData
        flag_COEFF_MSB        = &H1
    End Property

    Property Get read_COEFF_MSB
        read
        read_COEFF_MSB = read_COEFF_MSB_value
    End Property

    Property Let write_COEFF_MSB(aData)
        set_COEFF_MSB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_MSB_mask = &H7
        if data_low > LONG_MAX then
            if COEFF_MSB_mask = mask then
                read_COEFF_MSB_value = data_low
            else
                read_COEFF_MSB_value = (data_low - H8000_0000) and COEFF_MSB_mask
            end If
        else
            read_COEFF_MSB_value = data_low and COEFF_MSB_mask
        end If

    End Sub

    Sub write
        If flag_COEFF_MSB = &H0 Then read
        If flag_COEFF_MSB = &H0 Then write_COEFF_MSB_value = get_COEFF_MSB

        regValue = leftShift((write_COEFF_MSB_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_MSB_mask = &H7
        if data_low > LONG_MAX then
            if COEFF_MSB_mask = mask then
                read_COEFF_MSB_value = data_low
            else
                read_COEFF_MSB_value = (data_low - H8000_0000) and COEFF_MSB_mask
            end If
        else
            read_COEFF_MSB_value = data_low and COEFF_MSB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COEFF_MSB_value = &H0
        flag_COEFF_MSB        = &H0
    End Sub
End Class


'' @REGISTER : EC32TAP_coeff_26_lsb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COEFF_LSB                                  [15:0]           get_COEFF_LSB
''                                                             set_COEFF_LSB
''                                                             read_COEFF_LSB
''                                                             write_COEFF_LSB
''---------------------------------------------------------------------------------
Class REGISTER_EC32TAP_coeff_26_lsb
    Private write_COEFF_LSB_value
    Private read_COEFF_LSB_value
    Private flag_COEFF_LSB

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

    Property Get get_COEFF_LSB
        get_COEFF_LSB = read_COEFF_LSB_value
    End Property

    Property Let set_COEFF_LSB(aData)
        write_COEFF_LSB_value = aData
        flag_COEFF_LSB        = &H1
    End Property

    Property Get read_COEFF_LSB
        read
        read_COEFF_LSB = read_COEFF_LSB_value
    End Property

    Property Let write_COEFF_LSB(aData)
        set_COEFF_LSB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_LSB_mask = &Hffff
        if data_low > LONG_MAX then
            if COEFF_LSB_mask = mask then
                read_COEFF_LSB_value = data_low
            else
                read_COEFF_LSB_value = (data_low - H8000_0000) and COEFF_LSB_mask
            end If
        else
            read_COEFF_LSB_value = data_low and COEFF_LSB_mask
        end If

    End Sub

    Sub write
        If flag_COEFF_LSB = &H0 Then read
        If flag_COEFF_LSB = &H0 Then write_COEFF_LSB_value = get_COEFF_LSB

        regValue = leftShift((write_COEFF_LSB_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_LSB_mask = &Hffff
        if data_low > LONG_MAX then
            if COEFF_LSB_mask = mask then
                read_COEFF_LSB_value = data_low
            else
                read_COEFF_LSB_value = (data_low - H8000_0000) and COEFF_LSB_mask
            end If
        else
            read_COEFF_LSB_value = data_low and COEFF_LSB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COEFF_LSB_value = &H0
        flag_COEFF_LSB        = &H0
    End Sub
End Class


'' @REGISTER : EC32TAP_coeff_26_msb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COEFF_MSB                                  [2:0]            get_COEFF_MSB
''                                                             set_COEFF_MSB
''                                                             read_COEFF_MSB
''                                                             write_COEFF_MSB
''---------------------------------------------------------------------------------
Class REGISTER_EC32TAP_coeff_26_msb
    Private write_COEFF_MSB_value
    Private read_COEFF_MSB_value
    Private flag_COEFF_MSB

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

    Property Get get_COEFF_MSB
        get_COEFF_MSB = read_COEFF_MSB_value
    End Property

    Property Let set_COEFF_MSB(aData)
        write_COEFF_MSB_value = aData
        flag_COEFF_MSB        = &H1
    End Property

    Property Get read_COEFF_MSB
        read
        read_COEFF_MSB = read_COEFF_MSB_value
    End Property

    Property Let write_COEFF_MSB(aData)
        set_COEFF_MSB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_MSB_mask = &H7
        if data_low > LONG_MAX then
            if COEFF_MSB_mask = mask then
                read_COEFF_MSB_value = data_low
            else
                read_COEFF_MSB_value = (data_low - H8000_0000) and COEFF_MSB_mask
            end If
        else
            read_COEFF_MSB_value = data_low and COEFF_MSB_mask
        end If

    End Sub

    Sub write
        If flag_COEFF_MSB = &H0 Then read
        If flag_COEFF_MSB = &H0 Then write_COEFF_MSB_value = get_COEFF_MSB

        regValue = leftShift((write_COEFF_MSB_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_MSB_mask = &H7
        if data_low > LONG_MAX then
            if COEFF_MSB_mask = mask then
                read_COEFF_MSB_value = data_low
            else
                read_COEFF_MSB_value = (data_low - H8000_0000) and COEFF_MSB_mask
            end If
        else
            read_COEFF_MSB_value = data_low and COEFF_MSB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COEFF_MSB_value = &H0
        flag_COEFF_MSB        = &H0
    End Sub
End Class


'' @REGISTER : EC32TAP_coeff_27_lsb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COEFF_LSB                                  [15:0]           get_COEFF_LSB
''                                                             set_COEFF_LSB
''                                                             read_COEFF_LSB
''                                                             write_COEFF_LSB
''---------------------------------------------------------------------------------
Class REGISTER_EC32TAP_coeff_27_lsb
    Private write_COEFF_LSB_value
    Private read_COEFF_LSB_value
    Private flag_COEFF_LSB

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

    Property Get get_COEFF_LSB
        get_COEFF_LSB = read_COEFF_LSB_value
    End Property

    Property Let set_COEFF_LSB(aData)
        write_COEFF_LSB_value = aData
        flag_COEFF_LSB        = &H1
    End Property

    Property Get read_COEFF_LSB
        read
        read_COEFF_LSB = read_COEFF_LSB_value
    End Property

    Property Let write_COEFF_LSB(aData)
        set_COEFF_LSB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_LSB_mask = &Hffff
        if data_low > LONG_MAX then
            if COEFF_LSB_mask = mask then
                read_COEFF_LSB_value = data_low
            else
                read_COEFF_LSB_value = (data_low - H8000_0000) and COEFF_LSB_mask
            end If
        else
            read_COEFF_LSB_value = data_low and COEFF_LSB_mask
        end If

    End Sub

    Sub write
        If flag_COEFF_LSB = &H0 Then read
        If flag_COEFF_LSB = &H0 Then write_COEFF_LSB_value = get_COEFF_LSB

        regValue = leftShift((write_COEFF_LSB_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_LSB_mask = &Hffff
        if data_low > LONG_MAX then
            if COEFF_LSB_mask = mask then
                read_COEFF_LSB_value = data_low
            else
                read_COEFF_LSB_value = (data_low - H8000_0000) and COEFF_LSB_mask
            end If
        else
            read_COEFF_LSB_value = data_low and COEFF_LSB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COEFF_LSB_value = &H0
        flag_COEFF_LSB        = &H0
    End Sub
End Class


'' @REGISTER : EC32TAP_coeff_27_msb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COEFF_MSB                                  [2:0]            get_COEFF_MSB
''                                                             set_COEFF_MSB
''                                                             read_COEFF_MSB
''                                                             write_COEFF_MSB
''---------------------------------------------------------------------------------
Class REGISTER_EC32TAP_coeff_27_msb
    Private write_COEFF_MSB_value
    Private read_COEFF_MSB_value
    Private flag_COEFF_MSB

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H6e
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COEFF_MSB
        get_COEFF_MSB = read_COEFF_MSB_value
    End Property

    Property Let set_COEFF_MSB(aData)
        write_COEFF_MSB_value = aData
        flag_COEFF_MSB        = &H1
    End Property

    Property Get read_COEFF_MSB
        read
        read_COEFF_MSB = read_COEFF_MSB_value
    End Property

    Property Let write_COEFF_MSB(aData)
        set_COEFF_MSB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_MSB_mask = &H7
        if data_low > LONG_MAX then
            if COEFF_MSB_mask = mask then
                read_COEFF_MSB_value = data_low
            else
                read_COEFF_MSB_value = (data_low - H8000_0000) and COEFF_MSB_mask
            end If
        else
            read_COEFF_MSB_value = data_low and COEFF_MSB_mask
        end If

    End Sub

    Sub write
        If flag_COEFF_MSB = &H0 Then read
        If flag_COEFF_MSB = &H0 Then write_COEFF_MSB_value = get_COEFF_MSB

        regValue = leftShift((write_COEFF_MSB_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_MSB_mask = &H7
        if data_low > LONG_MAX then
            if COEFF_MSB_mask = mask then
                read_COEFF_MSB_value = data_low
            else
                read_COEFF_MSB_value = (data_low - H8000_0000) and COEFF_MSB_mask
            end If
        else
            read_COEFF_MSB_value = data_low and COEFF_MSB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COEFF_MSB_value = &H0
        flag_COEFF_MSB        = &H0
    End Sub
End Class


'' @REGISTER : EC32TAP_coeff_28_lsb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COEFF_LSB                                  [15:0]           get_COEFF_LSB
''                                                             set_COEFF_LSB
''                                                             read_COEFF_LSB
''                                                             write_COEFF_LSB
''---------------------------------------------------------------------------------
Class REGISTER_EC32TAP_coeff_28_lsb
    Private write_COEFF_LSB_value
    Private read_COEFF_LSB_value
    Private flag_COEFF_LSB

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

    Property Get get_COEFF_LSB
        get_COEFF_LSB = read_COEFF_LSB_value
    End Property

    Property Let set_COEFF_LSB(aData)
        write_COEFF_LSB_value = aData
        flag_COEFF_LSB        = &H1
    End Property

    Property Get read_COEFF_LSB
        read
        read_COEFF_LSB = read_COEFF_LSB_value
    End Property

    Property Let write_COEFF_LSB(aData)
        set_COEFF_LSB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_LSB_mask = &Hffff
        if data_low > LONG_MAX then
            if COEFF_LSB_mask = mask then
                read_COEFF_LSB_value = data_low
            else
                read_COEFF_LSB_value = (data_low - H8000_0000) and COEFF_LSB_mask
            end If
        else
            read_COEFF_LSB_value = data_low and COEFF_LSB_mask
        end If

    End Sub

    Sub write
        If flag_COEFF_LSB = &H0 Then read
        If flag_COEFF_LSB = &H0 Then write_COEFF_LSB_value = get_COEFF_LSB

        regValue = leftShift((write_COEFF_LSB_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_LSB_mask = &Hffff
        if data_low > LONG_MAX then
            if COEFF_LSB_mask = mask then
                read_COEFF_LSB_value = data_low
            else
                read_COEFF_LSB_value = (data_low - H8000_0000) and COEFF_LSB_mask
            end If
        else
            read_COEFF_LSB_value = data_low and COEFF_LSB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COEFF_LSB_value = &H0
        flag_COEFF_LSB        = &H0
    End Sub
End Class


'' @REGISTER : EC32TAP_coeff_28_msb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COEFF_MSB                                  [2:0]            get_COEFF_MSB
''                                                             set_COEFF_MSB
''                                                             read_COEFF_MSB
''                                                             write_COEFF_MSB
''---------------------------------------------------------------------------------
Class REGISTER_EC32TAP_coeff_28_msb
    Private write_COEFF_MSB_value
    Private read_COEFF_MSB_value
    Private flag_COEFF_MSB

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

    Property Get get_COEFF_MSB
        get_COEFF_MSB = read_COEFF_MSB_value
    End Property

    Property Let set_COEFF_MSB(aData)
        write_COEFF_MSB_value = aData
        flag_COEFF_MSB        = &H1
    End Property

    Property Get read_COEFF_MSB
        read
        read_COEFF_MSB = read_COEFF_MSB_value
    End Property

    Property Let write_COEFF_MSB(aData)
        set_COEFF_MSB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_MSB_mask = &H7
        if data_low > LONG_MAX then
            if COEFF_MSB_mask = mask then
                read_COEFF_MSB_value = data_low
            else
                read_COEFF_MSB_value = (data_low - H8000_0000) and COEFF_MSB_mask
            end If
        else
            read_COEFF_MSB_value = data_low and COEFF_MSB_mask
        end If

    End Sub

    Sub write
        If flag_COEFF_MSB = &H0 Then read
        If flag_COEFF_MSB = &H0 Then write_COEFF_MSB_value = get_COEFF_MSB

        regValue = leftShift((write_COEFF_MSB_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_MSB_mask = &H7
        if data_low > LONG_MAX then
            if COEFF_MSB_mask = mask then
                read_COEFF_MSB_value = data_low
            else
                read_COEFF_MSB_value = (data_low - H8000_0000) and COEFF_MSB_mask
            end If
        else
            read_COEFF_MSB_value = data_low and COEFF_MSB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COEFF_MSB_value = &H0
        flag_COEFF_MSB        = &H0
    End Sub
End Class


'' @REGISTER : EC32TAP_coeff_29_lsb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COEFF_LSB                                  [15:0]           get_COEFF_LSB
''                                                             set_COEFF_LSB
''                                                             read_COEFF_LSB
''                                                             write_COEFF_LSB
''---------------------------------------------------------------------------------
Class REGISTER_EC32TAP_coeff_29_lsb
    Private write_COEFF_LSB_value
    Private read_COEFF_LSB_value
    Private flag_COEFF_LSB

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

    Property Get get_COEFF_LSB
        get_COEFF_LSB = read_COEFF_LSB_value
    End Property

    Property Let set_COEFF_LSB(aData)
        write_COEFF_LSB_value = aData
        flag_COEFF_LSB        = &H1
    End Property

    Property Get read_COEFF_LSB
        read
        read_COEFF_LSB = read_COEFF_LSB_value
    End Property

    Property Let write_COEFF_LSB(aData)
        set_COEFF_LSB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_LSB_mask = &Hffff
        if data_low > LONG_MAX then
            if COEFF_LSB_mask = mask then
                read_COEFF_LSB_value = data_low
            else
                read_COEFF_LSB_value = (data_low - H8000_0000) and COEFF_LSB_mask
            end If
        else
            read_COEFF_LSB_value = data_low and COEFF_LSB_mask
        end If

    End Sub

    Sub write
        If flag_COEFF_LSB = &H0 Then read
        If flag_COEFF_LSB = &H0 Then write_COEFF_LSB_value = get_COEFF_LSB

        regValue = leftShift((write_COEFF_LSB_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_LSB_mask = &Hffff
        if data_low > LONG_MAX then
            if COEFF_LSB_mask = mask then
                read_COEFF_LSB_value = data_low
            else
                read_COEFF_LSB_value = (data_low - H8000_0000) and COEFF_LSB_mask
            end If
        else
            read_COEFF_LSB_value = data_low and COEFF_LSB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COEFF_LSB_value = &H0
        flag_COEFF_LSB        = &H0
    End Sub
End Class


'' @REGISTER : EC32TAP_coeff_29_msb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COEFF_MSB                                  [2:0]            get_COEFF_MSB
''                                                             set_COEFF_MSB
''                                                             read_COEFF_MSB
''                                                             write_COEFF_MSB
''---------------------------------------------------------------------------------
Class REGISTER_EC32TAP_coeff_29_msb
    Private write_COEFF_MSB_value
    Private read_COEFF_MSB_value
    Private flag_COEFF_MSB

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

    Property Get get_COEFF_MSB
        get_COEFF_MSB = read_COEFF_MSB_value
    End Property

    Property Let set_COEFF_MSB(aData)
        write_COEFF_MSB_value = aData
        flag_COEFF_MSB        = &H1
    End Property

    Property Get read_COEFF_MSB
        read
        read_COEFF_MSB = read_COEFF_MSB_value
    End Property

    Property Let write_COEFF_MSB(aData)
        set_COEFF_MSB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_MSB_mask = &H7
        if data_low > LONG_MAX then
            if COEFF_MSB_mask = mask then
                read_COEFF_MSB_value = data_low
            else
                read_COEFF_MSB_value = (data_low - H8000_0000) and COEFF_MSB_mask
            end If
        else
            read_COEFF_MSB_value = data_low and COEFF_MSB_mask
        end If

    End Sub

    Sub write
        If flag_COEFF_MSB = &H0 Then read
        If flag_COEFF_MSB = &H0 Then write_COEFF_MSB_value = get_COEFF_MSB

        regValue = leftShift((write_COEFF_MSB_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_MSB_mask = &H7
        if data_low > LONG_MAX then
            if COEFF_MSB_mask = mask then
                read_COEFF_MSB_value = data_low
            else
                read_COEFF_MSB_value = (data_low - H8000_0000) and COEFF_MSB_mask
            end If
        else
            read_COEFF_MSB_value = data_low and COEFF_MSB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COEFF_MSB_value = &H0
        flag_COEFF_MSB        = &H0
    End Sub
End Class


'' @REGISTER : EC32TAP_coeff_30_lsb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COEFF_LSB                                  [15:0]           get_COEFF_LSB
''                                                             set_COEFF_LSB
''                                                             read_COEFF_LSB
''                                                             write_COEFF_LSB
''---------------------------------------------------------------------------------
Class REGISTER_EC32TAP_coeff_30_lsb
    Private write_COEFF_LSB_value
    Private read_COEFF_LSB_value
    Private flag_COEFF_LSB

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

    Property Get get_COEFF_LSB
        get_COEFF_LSB = read_COEFF_LSB_value
    End Property

    Property Let set_COEFF_LSB(aData)
        write_COEFF_LSB_value = aData
        flag_COEFF_LSB        = &H1
    End Property

    Property Get read_COEFF_LSB
        read
        read_COEFF_LSB = read_COEFF_LSB_value
    End Property

    Property Let write_COEFF_LSB(aData)
        set_COEFF_LSB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_LSB_mask = &Hffff
        if data_low > LONG_MAX then
            if COEFF_LSB_mask = mask then
                read_COEFF_LSB_value = data_low
            else
                read_COEFF_LSB_value = (data_low - H8000_0000) and COEFF_LSB_mask
            end If
        else
            read_COEFF_LSB_value = data_low and COEFF_LSB_mask
        end If

    End Sub

    Sub write
        If flag_COEFF_LSB = &H0 Then read
        If flag_COEFF_LSB = &H0 Then write_COEFF_LSB_value = get_COEFF_LSB

        regValue = leftShift((write_COEFF_LSB_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_LSB_mask = &Hffff
        if data_low > LONG_MAX then
            if COEFF_LSB_mask = mask then
                read_COEFF_LSB_value = data_low
            else
                read_COEFF_LSB_value = (data_low - H8000_0000) and COEFF_LSB_mask
            end If
        else
            read_COEFF_LSB_value = data_low and COEFF_LSB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COEFF_LSB_value = &H0
        flag_COEFF_LSB        = &H0
    End Sub
End Class


'' @REGISTER : EC32TAP_coeff_30_msb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COEFF_MSB                                  [2:0]            get_COEFF_MSB
''                                                             set_COEFF_MSB
''                                                             read_COEFF_MSB
''                                                             write_COEFF_MSB
''---------------------------------------------------------------------------------
Class REGISTER_EC32TAP_coeff_30_msb
    Private write_COEFF_MSB_value
    Private read_COEFF_MSB_value
    Private flag_COEFF_MSB

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

    Property Get get_COEFF_MSB
        get_COEFF_MSB = read_COEFF_MSB_value
    End Property

    Property Let set_COEFF_MSB(aData)
        write_COEFF_MSB_value = aData
        flag_COEFF_MSB        = &H1
    End Property

    Property Get read_COEFF_MSB
        read
        read_COEFF_MSB = read_COEFF_MSB_value
    End Property

    Property Let write_COEFF_MSB(aData)
        set_COEFF_MSB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_MSB_mask = &H7
        if data_low > LONG_MAX then
            if COEFF_MSB_mask = mask then
                read_COEFF_MSB_value = data_low
            else
                read_COEFF_MSB_value = (data_low - H8000_0000) and COEFF_MSB_mask
            end If
        else
            read_COEFF_MSB_value = data_low and COEFF_MSB_mask
        end If

    End Sub

    Sub write
        If flag_COEFF_MSB = &H0 Then read
        If flag_COEFF_MSB = &H0 Then write_COEFF_MSB_value = get_COEFF_MSB

        regValue = leftShift((write_COEFF_MSB_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_MSB_mask = &H7
        if data_low > LONG_MAX then
            if COEFF_MSB_mask = mask then
                read_COEFF_MSB_value = data_low
            else
                read_COEFF_MSB_value = (data_low - H8000_0000) and COEFF_MSB_mask
            end If
        else
            read_COEFF_MSB_value = data_low and COEFF_MSB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COEFF_MSB_value = &H0
        flag_COEFF_MSB        = &H0
    End Sub
End Class


'' @REGISTER : EC32TAP_coeff_31_lsb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COEFF_LSB                                  [15:0]           get_COEFF_LSB
''                                                             set_COEFF_LSB
''                                                             read_COEFF_LSB
''                                                             write_COEFF_LSB
''---------------------------------------------------------------------------------
Class REGISTER_EC32TAP_coeff_31_lsb
    Private write_COEFF_LSB_value
    Private read_COEFF_LSB_value
    Private flag_COEFF_LSB

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

    Property Get get_COEFF_LSB
        get_COEFF_LSB = read_COEFF_LSB_value
    End Property

    Property Let set_COEFF_LSB(aData)
        write_COEFF_LSB_value = aData
        flag_COEFF_LSB        = &H1
    End Property

    Property Get read_COEFF_LSB
        read
        read_COEFF_LSB = read_COEFF_LSB_value
    End Property

    Property Let write_COEFF_LSB(aData)
        set_COEFF_LSB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_LSB_mask = &Hffff
        if data_low > LONG_MAX then
            if COEFF_LSB_mask = mask then
                read_COEFF_LSB_value = data_low
            else
                read_COEFF_LSB_value = (data_low - H8000_0000) and COEFF_LSB_mask
            end If
        else
            read_COEFF_LSB_value = data_low and COEFF_LSB_mask
        end If

    End Sub

    Sub write
        If flag_COEFF_LSB = &H0 Then read
        If flag_COEFF_LSB = &H0 Then write_COEFF_LSB_value = get_COEFF_LSB

        regValue = leftShift((write_COEFF_LSB_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_LSB_mask = &Hffff
        if data_low > LONG_MAX then
            if COEFF_LSB_mask = mask then
                read_COEFF_LSB_value = data_low
            else
                read_COEFF_LSB_value = (data_low - H8000_0000) and COEFF_LSB_mask
            end If
        else
            read_COEFF_LSB_value = data_low and COEFF_LSB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COEFF_LSB_value = &H0
        flag_COEFF_LSB        = &H0
    End Sub
End Class


'' @REGISTER : EC32TAP_coeff_31_msb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COEFF_MSB                                  [2:0]            get_COEFF_MSB
''                                                             set_COEFF_MSB
''                                                             read_COEFF_MSB
''                                                             write_COEFF_MSB
''---------------------------------------------------------------------------------
Class REGISTER_EC32TAP_coeff_31_msb
    Private write_COEFF_MSB_value
    Private read_COEFF_MSB_value
    Private flag_COEFF_MSB

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H7e
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COEFF_MSB
        get_COEFF_MSB = read_COEFF_MSB_value
    End Property

    Property Let set_COEFF_MSB(aData)
        write_COEFF_MSB_value = aData
        flag_COEFF_MSB        = &H1
    End Property

    Property Get read_COEFF_MSB
        read
        read_COEFF_MSB = read_COEFF_MSB_value
    End Property

    Property Let write_COEFF_MSB(aData)
        set_COEFF_MSB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_MSB_mask = &H7
        if data_low > LONG_MAX then
            if COEFF_MSB_mask = mask then
                read_COEFF_MSB_value = data_low
            else
                read_COEFF_MSB_value = (data_low - H8000_0000) and COEFF_MSB_mask
            end If
        else
            read_COEFF_MSB_value = data_low and COEFF_MSB_mask
        end If

    End Sub

    Sub write
        If flag_COEFF_MSB = &H0 Then read
        If flag_COEFF_MSB = &H0 Then write_COEFF_MSB_value = get_COEFF_MSB

        regValue = leftShift((write_COEFF_MSB_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_MSB_mask = &H7
        if data_low > LONG_MAX then
            if COEFF_MSB_mask = mask then
                read_COEFF_MSB_value = data_low
            else
                read_COEFF_MSB_value = (data_low - H8000_0000) and COEFF_MSB_mask
            end If
        else
            read_COEFF_MSB_value = data_low and COEFF_MSB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COEFF_MSB_value = &H0
        flag_COEFF_MSB        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class EC32TAP_INSTANCE

    Public coeff_00_lsb
    Public coeff_00_msb
    Public coeff_01_lsb
    Public coeff_01_msb
    Public coeff_02_lsb
    Public coeff_02_msb
    Public coeff_03_lsb
    Public coeff_03_msb
    Public coeff_04_lsb
    Public coeff_04_msb
    Public coeff_05_lsb
    Public coeff_05_msb
    Public coeff_06_lsb
    Public coeff_06_msb
    Public coeff_07_lsb
    Public coeff_07_msb
    Public coeff_08_lsb
    Public coeff_08_msb
    Public coeff_09_lsb
    Public coeff_09_msb
    Public coeff_10_lsb
    Public coeff_10_msb
    Public coeff_11_lsb
    Public coeff_11_msb
    Public coeff_12_lsb
    Public coeff_12_msb
    Public coeff_13_lsb
    Public coeff_13_msb
    Public coeff_14_lsb
    Public coeff_14_msb
    Public coeff_15_lsb
    Public coeff_15_msb
    Public coeff_16_lsb
    Public coeff_16_msb
    Public coeff_17_lsb
    Public coeff_17_msb
    Public coeff_18_lsb
    Public coeff_18_msb
    Public coeff_19_lsb
    Public coeff_19_msb
    Public coeff_20_lsb
    Public coeff_20_msb
    Public coeff_21_lsb
    Public coeff_21_msb
    Public coeff_22_lsb
    Public coeff_22_msb
    Public coeff_23_lsb
    Public coeff_23_msb
    Public coeff_24_lsb
    Public coeff_24_msb
    Public coeff_25_lsb
    Public coeff_25_msb
    Public coeff_26_lsb
    Public coeff_26_msb
    Public coeff_27_lsb
    Public coeff_27_msb
    Public coeff_28_lsb
    Public coeff_28_msb
    Public coeff_29_lsb
    Public coeff_29_msb
    Public coeff_30_lsb
    Public coeff_30_msb
    Public coeff_31_lsb
    Public coeff_31_msb


    Public default function Init(aBaseAddr)
        Set coeff_00_lsb = (New REGISTER_EC32TAP_coeff_00_lsb)(aBaseAddr, 16)
        Set coeff_00_msb = (New REGISTER_EC32TAP_coeff_00_msb)(aBaseAddr, 16)
        Set coeff_01_lsb = (New REGISTER_EC32TAP_coeff_01_lsb)(aBaseAddr, 16)
        Set coeff_01_msb = (New REGISTER_EC32TAP_coeff_01_msb)(aBaseAddr, 16)
        Set coeff_02_lsb = (New REGISTER_EC32TAP_coeff_02_lsb)(aBaseAddr, 16)
        Set coeff_02_msb = (New REGISTER_EC32TAP_coeff_02_msb)(aBaseAddr, 16)
        Set coeff_03_lsb = (New REGISTER_EC32TAP_coeff_03_lsb)(aBaseAddr, 16)
        Set coeff_03_msb = (New REGISTER_EC32TAP_coeff_03_msb)(aBaseAddr, 16)
        Set coeff_04_lsb = (New REGISTER_EC32TAP_coeff_04_lsb)(aBaseAddr, 16)
        Set coeff_04_msb = (New REGISTER_EC32TAP_coeff_04_msb)(aBaseAddr, 16)
        Set coeff_05_lsb = (New REGISTER_EC32TAP_coeff_05_lsb)(aBaseAddr, 16)
        Set coeff_05_msb = (New REGISTER_EC32TAP_coeff_05_msb)(aBaseAddr, 16)
        Set coeff_06_lsb = (New REGISTER_EC32TAP_coeff_06_lsb)(aBaseAddr, 16)
        Set coeff_06_msb = (New REGISTER_EC32TAP_coeff_06_msb)(aBaseAddr, 16)
        Set coeff_07_lsb = (New REGISTER_EC32TAP_coeff_07_lsb)(aBaseAddr, 16)
        Set coeff_07_msb = (New REGISTER_EC32TAP_coeff_07_msb)(aBaseAddr, 16)
        Set coeff_08_lsb = (New REGISTER_EC32TAP_coeff_08_lsb)(aBaseAddr, 16)
        Set coeff_08_msb = (New REGISTER_EC32TAP_coeff_08_msb)(aBaseAddr, 16)
        Set coeff_09_lsb = (New REGISTER_EC32TAP_coeff_09_lsb)(aBaseAddr, 16)
        Set coeff_09_msb = (New REGISTER_EC32TAP_coeff_09_msb)(aBaseAddr, 16)
        Set coeff_10_lsb = (New REGISTER_EC32TAP_coeff_10_lsb)(aBaseAddr, 16)
        Set coeff_10_msb = (New REGISTER_EC32TAP_coeff_10_msb)(aBaseAddr, 16)
        Set coeff_11_lsb = (New REGISTER_EC32TAP_coeff_11_lsb)(aBaseAddr, 16)
        Set coeff_11_msb = (New REGISTER_EC32TAP_coeff_11_msb)(aBaseAddr, 16)
        Set coeff_12_lsb = (New REGISTER_EC32TAP_coeff_12_lsb)(aBaseAddr, 16)
        Set coeff_12_msb = (New REGISTER_EC32TAP_coeff_12_msb)(aBaseAddr, 16)
        Set coeff_13_lsb = (New REGISTER_EC32TAP_coeff_13_lsb)(aBaseAddr, 16)
        Set coeff_13_msb = (New REGISTER_EC32TAP_coeff_13_msb)(aBaseAddr, 16)
        Set coeff_14_lsb = (New REGISTER_EC32TAP_coeff_14_lsb)(aBaseAddr, 16)
        Set coeff_14_msb = (New REGISTER_EC32TAP_coeff_14_msb)(aBaseAddr, 16)
        Set coeff_15_lsb = (New REGISTER_EC32TAP_coeff_15_lsb)(aBaseAddr, 16)
        Set coeff_15_msb = (New REGISTER_EC32TAP_coeff_15_msb)(aBaseAddr, 16)
        Set coeff_16_lsb = (New REGISTER_EC32TAP_coeff_16_lsb)(aBaseAddr, 16)
        Set coeff_16_msb = (New REGISTER_EC32TAP_coeff_16_msb)(aBaseAddr, 16)
        Set coeff_17_lsb = (New REGISTER_EC32TAP_coeff_17_lsb)(aBaseAddr, 16)
        Set coeff_17_msb = (New REGISTER_EC32TAP_coeff_17_msb)(aBaseAddr, 16)
        Set coeff_18_lsb = (New REGISTER_EC32TAP_coeff_18_lsb)(aBaseAddr, 16)
        Set coeff_18_msb = (New REGISTER_EC32TAP_coeff_18_msb)(aBaseAddr, 16)
        Set coeff_19_lsb = (New REGISTER_EC32TAP_coeff_19_lsb)(aBaseAddr, 16)
        Set coeff_19_msb = (New REGISTER_EC32TAP_coeff_19_msb)(aBaseAddr, 16)
        Set coeff_20_lsb = (New REGISTER_EC32TAP_coeff_20_lsb)(aBaseAddr, 16)
        Set coeff_20_msb = (New REGISTER_EC32TAP_coeff_20_msb)(aBaseAddr, 16)
        Set coeff_21_lsb = (New REGISTER_EC32TAP_coeff_21_lsb)(aBaseAddr, 16)
        Set coeff_21_msb = (New REGISTER_EC32TAP_coeff_21_msb)(aBaseAddr, 16)
        Set coeff_22_lsb = (New REGISTER_EC32TAP_coeff_22_lsb)(aBaseAddr, 16)
        Set coeff_22_msb = (New REGISTER_EC32TAP_coeff_22_msb)(aBaseAddr, 16)
        Set coeff_23_lsb = (New REGISTER_EC32TAP_coeff_23_lsb)(aBaseAddr, 16)
        Set coeff_23_msb = (New REGISTER_EC32TAP_coeff_23_msb)(aBaseAddr, 16)
        Set coeff_24_lsb = (New REGISTER_EC32TAP_coeff_24_lsb)(aBaseAddr, 16)
        Set coeff_24_msb = (New REGISTER_EC32TAP_coeff_24_msb)(aBaseAddr, 16)
        Set coeff_25_lsb = (New REGISTER_EC32TAP_coeff_25_lsb)(aBaseAddr, 16)
        Set coeff_25_msb = (New REGISTER_EC32TAP_coeff_25_msb)(aBaseAddr, 16)
        Set coeff_26_lsb = (New REGISTER_EC32TAP_coeff_26_lsb)(aBaseAddr, 16)
        Set coeff_26_msb = (New REGISTER_EC32TAP_coeff_26_msb)(aBaseAddr, 16)
        Set coeff_27_lsb = (New REGISTER_EC32TAP_coeff_27_lsb)(aBaseAddr, 16)
        Set coeff_27_msb = (New REGISTER_EC32TAP_coeff_27_msb)(aBaseAddr, 16)
        Set coeff_28_lsb = (New REGISTER_EC32TAP_coeff_28_lsb)(aBaseAddr, 16)
        Set coeff_28_msb = (New REGISTER_EC32TAP_coeff_28_msb)(aBaseAddr, 16)
        Set coeff_29_lsb = (New REGISTER_EC32TAP_coeff_29_lsb)(aBaseAddr, 16)
        Set coeff_29_msb = (New REGISTER_EC32TAP_coeff_29_msb)(aBaseAddr, 16)
        Set coeff_30_lsb = (New REGISTER_EC32TAP_coeff_30_lsb)(aBaseAddr, 16)
        Set coeff_30_msb = (New REGISTER_EC32TAP_coeff_30_msb)(aBaseAddr, 16)
        Set coeff_31_lsb = (New REGISTER_EC32TAP_coeff_31_lsb)(aBaseAddr, 16)
        Set coeff_31_msb = (New REGISTER_EC32TAP_coeff_31_msb)(aBaseAddr, 16)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set EC32TAP = CreateObject("System.Collections.ArrayList")
EC32TAP.Add ((New EC32TAP_INSTANCE)(&H49031100))
EC32TAP.Add ((New EC32TAP_INSTANCE)(&H49031180))
EC32TAP.Add ((New EC32TAP_INSTANCE)(&H49031200))
EC32TAP.Add ((New EC32TAP_INSTANCE)(&H49031280))
EC32TAP.Add ((New EC32TAP_INSTANCE)(&H49031300))


