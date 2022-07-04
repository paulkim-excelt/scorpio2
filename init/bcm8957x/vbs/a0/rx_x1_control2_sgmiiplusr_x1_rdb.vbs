

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


'' @REGISTER : RX_X1_CONTROL2_SGMIIPLUSR_X1_reg10m_modulo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' reg10M_modulo                              [8:0]            get_reg10M_modulo
''                                                             set_reg10M_modulo
''                                                             read_reg10M_modulo
''                                                             write_reg10M_modulo
''---------------------------------------------------------------------------------
Class REGISTER_RX_X1_CONTROL2_SGMIIPLUSR_X1_reg10m_modulo
    Private write_reg10M_modulo_value
    Private read_reg10M_modulo_value
    Private flag_reg10M_modulo

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

    Property Get get_reg10M_modulo
        get_reg10M_modulo = read_reg10M_modulo_value
    End Property

    Property Let set_reg10M_modulo(aData)
        write_reg10M_modulo_value = aData
        flag_reg10M_modulo        = &H1
    End Property

    Property Get read_reg10M_modulo
        read
        read_reg10M_modulo = read_reg10M_modulo_value
    End Property

    Property Let write_reg10M_modulo(aData)
        set_reg10M_modulo = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        reg10M_modulo_mask = &H1ff
        if data_low > LONG_MAX then
            if reg10M_modulo_mask = mask then
                read_reg10M_modulo_value = data_low
            else
                read_reg10M_modulo_value = (data_low - H8000_0000) and reg10M_modulo_mask
            end If
        else
            read_reg10M_modulo_value = data_low and reg10M_modulo_mask
        end If

    End Sub

    Sub write
        If flag_reg10M_modulo = &H0 Then read
        If flag_reg10M_modulo = &H0 Then write_reg10M_modulo_value = get_reg10M_modulo

        regValue = leftShift((write_reg10M_modulo_value and &H1ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        reg10M_modulo_mask = &H1ff
        if data_low > LONG_MAX then
            if reg10M_modulo_mask = mask then
                read_reg10M_modulo_value = data_low
            else
                read_reg10M_modulo_value = (data_low - H8000_0000) and reg10M_modulo_mask
            end If
        else
            read_reg10M_modulo_value = data_low and reg10M_modulo_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_reg10M_modulo_value = &H0
        flag_reg10M_modulo        = &H0
    End Sub
End Class


'' @REGISTER : RX_X1_CONTROL2_SGMIIPLUSR_X1_reg100m_modulo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' reg100M_modulo                             [8:0]            get_reg100M_modulo
''                                                             set_reg100M_modulo
''                                                             read_reg100M_modulo
''                                                             write_reg100M_modulo
''---------------------------------------------------------------------------------
Class REGISTER_RX_X1_CONTROL2_SGMIIPLUSR_X1_reg100m_modulo
    Private write_reg100M_modulo_value
    Private read_reg100M_modulo_value
    Private flag_reg100M_modulo

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

    Property Get get_reg100M_modulo
        get_reg100M_modulo = read_reg100M_modulo_value
    End Property

    Property Let set_reg100M_modulo(aData)
        write_reg100M_modulo_value = aData
        flag_reg100M_modulo        = &H1
    End Property

    Property Get read_reg100M_modulo
        read
        read_reg100M_modulo = read_reg100M_modulo_value
    End Property

    Property Let write_reg100M_modulo(aData)
        set_reg100M_modulo = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        reg100M_modulo_mask = &H1ff
        if data_low > LONG_MAX then
            if reg100M_modulo_mask = mask then
                read_reg100M_modulo_value = data_low
            else
                read_reg100M_modulo_value = (data_low - H8000_0000) and reg100M_modulo_mask
            end If
        else
            read_reg100M_modulo_value = data_low and reg100M_modulo_mask
        end If

    End Sub

    Sub write
        If flag_reg100M_modulo = &H0 Then read
        If flag_reg100M_modulo = &H0 Then write_reg100M_modulo_value = get_reg100M_modulo

        regValue = leftShift((write_reg100M_modulo_value and &H1ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        reg100M_modulo_mask = &H1ff
        if data_low > LONG_MAX then
            if reg100M_modulo_mask = mask then
                read_reg100M_modulo_value = data_low
            else
                read_reg100M_modulo_value = (data_low - H8000_0000) and reg100M_modulo_mask
            end If
        else
            read_reg100M_modulo_value = data_low and reg100M_modulo_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_reg100M_modulo_value = &H0
        flag_reg100M_modulo        = &H0
    End Sub
End Class


'' @REGISTER : RX_X1_CONTROL2_SGMIIPLUSR_X1_reg1g_modulo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' reg1G_modulo                               [8:0]            get_reg1G_modulo
''                                                             set_reg1G_modulo
''                                                             read_reg1G_modulo
''                                                             write_reg1G_modulo
''---------------------------------------------------------------------------------
Class REGISTER_RX_X1_CONTROL2_SGMIIPLUSR_X1_reg1g_modulo
    Private write_reg1G_modulo_value
    Private read_reg1G_modulo_value
    Private flag_reg1G_modulo

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

    Property Get get_reg1G_modulo
        get_reg1G_modulo = read_reg1G_modulo_value
    End Property

    Property Let set_reg1G_modulo(aData)
        write_reg1G_modulo_value = aData
        flag_reg1G_modulo        = &H1
    End Property

    Property Get read_reg1G_modulo
        read
        read_reg1G_modulo = read_reg1G_modulo_value
    End Property

    Property Let write_reg1G_modulo(aData)
        set_reg1G_modulo = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        reg1G_modulo_mask = &H1ff
        if data_low > LONG_MAX then
            if reg1G_modulo_mask = mask then
                read_reg1G_modulo_value = data_low
            else
                read_reg1G_modulo_value = (data_low - H8000_0000) and reg1G_modulo_mask
            end If
        else
            read_reg1G_modulo_value = data_low and reg1G_modulo_mask
        end If

    End Sub

    Sub write
        If flag_reg1G_modulo = &H0 Then read
        If flag_reg1G_modulo = &H0 Then write_reg1G_modulo_value = get_reg1G_modulo

        regValue = leftShift((write_reg1G_modulo_value and &H1ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        reg1G_modulo_mask = &H1ff
        if data_low > LONG_MAX then
            if reg1G_modulo_mask = mask then
                read_reg1G_modulo_value = data_low
            else
                read_reg1G_modulo_value = (data_low - H8000_0000) and reg1G_modulo_mask
            end If
        else
            read_reg1G_modulo_value = data_low and reg1G_modulo_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_reg1G_modulo_value = &H0
        flag_reg1G_modulo        = &H0
    End Sub
End Class


'' @REGISTER : RX_X1_CONTROL2_SGMIIPLUSR_X1_reg2p5g_modulo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' reg2p5G_modulo                             [8:0]            get_reg2p5G_modulo
''                                                             set_reg2p5G_modulo
''                                                             read_reg2p5G_modulo
''                                                             write_reg2p5G_modulo
''---------------------------------------------------------------------------------
Class REGISTER_RX_X1_CONTROL2_SGMIIPLUSR_X1_reg2p5g_modulo
    Private write_reg2p5G_modulo_value
    Private read_reg2p5G_modulo_value
    Private flag_reg2p5G_modulo

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

    Property Get get_reg2p5G_modulo
        get_reg2p5G_modulo = read_reg2p5G_modulo_value
    End Property

    Property Let set_reg2p5G_modulo(aData)
        write_reg2p5G_modulo_value = aData
        flag_reg2p5G_modulo        = &H1
    End Property

    Property Get read_reg2p5G_modulo
        read
        read_reg2p5G_modulo = read_reg2p5G_modulo_value
    End Property

    Property Let write_reg2p5G_modulo(aData)
        set_reg2p5G_modulo = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        reg2p5G_modulo_mask = &H1ff
        if data_low > LONG_MAX then
            if reg2p5G_modulo_mask = mask then
                read_reg2p5G_modulo_value = data_low
            else
                read_reg2p5G_modulo_value = (data_low - H8000_0000) and reg2p5G_modulo_mask
            end If
        else
            read_reg2p5G_modulo_value = data_low and reg2p5G_modulo_mask
        end If

    End Sub

    Sub write
        If flag_reg2p5G_modulo = &H0 Then read
        If flag_reg2p5G_modulo = &H0 Then write_reg2p5G_modulo_value = get_reg2p5G_modulo

        regValue = leftShift((write_reg2p5G_modulo_value and &H1ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        reg2p5G_modulo_mask = &H1ff
        if data_low > LONG_MAX then
            if reg2p5G_modulo_mask = mask then
                read_reg2p5G_modulo_value = data_low
            else
                read_reg2p5G_modulo_value = (data_low - H8000_0000) and reg2p5G_modulo_mask
            end If
        else
            read_reg2p5G_modulo_value = data_low and reg2p5G_modulo_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_reg2p5G_modulo_value = &H0
        flag_reg2p5G_modulo        = &H0
    End Sub
End Class


'' @REGISTER : RX_X1_CONTROL2_SGMIIPLUSR_X1_reguserdefinedspd_modulo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' REGU_MODU                                  [8:0]            get_REGU_MODU
''                                                             set_REGU_MODU
''                                                             read_REGU_MODU
''                                                             write_REGU_MODU
''---------------------------------------------------------------------------------
Class REGISTER_RX_X1_CONTROL2_SGMIIPLUSR_X1_reguserdefinedspd_modulo
    Private write_REGU_MODU_value
    Private read_REGU_MODU_value
    Private flag_REGU_MODU

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

    Property Get get_REGU_MODU
        get_REGU_MODU = read_REGU_MODU_value
    End Property

    Property Let set_REGU_MODU(aData)
        write_REGU_MODU_value = aData
        flag_REGU_MODU        = &H1
    End Property

    Property Get read_REGU_MODU
        read
        read_REGU_MODU = read_REGU_MODU_value
    End Property

    Property Let write_REGU_MODU(aData)
        set_REGU_MODU = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REGU_MODU_mask = &H1ff
        if data_low > LONG_MAX then
            if REGU_MODU_mask = mask then
                read_REGU_MODU_value = data_low
            else
                read_REGU_MODU_value = (data_low - H8000_0000) and REGU_MODU_mask
            end If
        else
            read_REGU_MODU_value = data_low and REGU_MODU_mask
        end If

    End Sub

    Sub write
        If flag_REGU_MODU = &H0 Then read
        If flag_REGU_MODU = &H0 Then write_REGU_MODU_value = get_REGU_MODU

        regValue = leftShift((write_REGU_MODU_value and &H1ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REGU_MODU_mask = &H1ff
        if data_low > LONG_MAX then
            if REGU_MODU_mask = mask then
                read_REGU_MODU_value = data_low
            else
                read_REGU_MODU_value = (data_low - H8000_0000) and REGU_MODU_mask
            end If
        else
            read_REGU_MODU_value = data_low and REGU_MODU_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_REGU_MODU_value = &H0
        flag_REGU_MODU        = &H0
    End Sub
End Class


'' @REGISTER : RX_X1_CONTROL2_SGMIIPLUSR_X1_reg5g_modulo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' reg5G_modulo                               [8:0]            get_reg5G_modulo
''                                                             set_reg5G_modulo
''                                                             read_reg5G_modulo
''                                                             write_reg5G_modulo
''---------------------------------------------------------------------------------
Class REGISTER_RX_X1_CONTROL2_SGMIIPLUSR_X1_reg5g_modulo
    Private write_reg5G_modulo_value
    Private read_reg5G_modulo_value
    Private flag_reg5G_modulo

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

    Property Get get_reg5G_modulo
        get_reg5G_modulo = read_reg5G_modulo_value
    End Property

    Property Let set_reg5G_modulo(aData)
        write_reg5G_modulo_value = aData
        flag_reg5G_modulo        = &H1
    End Property

    Property Get read_reg5G_modulo
        read
        read_reg5G_modulo = read_reg5G_modulo_value
    End Property

    Property Let write_reg5G_modulo(aData)
        set_reg5G_modulo = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        reg5G_modulo_mask = &H1ff
        if data_low > LONG_MAX then
            if reg5G_modulo_mask = mask then
                read_reg5G_modulo_value = data_low
            else
                read_reg5G_modulo_value = (data_low - H8000_0000) and reg5G_modulo_mask
            end If
        else
            read_reg5G_modulo_value = data_low and reg5G_modulo_mask
        end If

    End Sub

    Sub write
        If flag_reg5G_modulo = &H0 Then read
        If flag_reg5G_modulo = &H0 Then write_reg5G_modulo_value = get_reg5G_modulo

        regValue = leftShift((write_reg5G_modulo_value and &H1ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        reg5G_modulo_mask = &H1ff
        if data_low > LONG_MAX then
            if reg5G_modulo_mask = mask then
                read_reg5G_modulo_value = data_low
            else
                read_reg5G_modulo_value = (data_low - H8000_0000) and reg5G_modulo_mask
            end If
        else
            read_reg5G_modulo_value = data_low and reg5G_modulo_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_reg5G_modulo_value = &H0
        flag_reg5G_modulo        = &H0
    End Sub
End Class


'' @REGISTER : RX_X1_CONTROL2_SGMIIPLUSR_X1_blockaddress
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
Class REGISTER_RX_X1_CONTROL2_SGMIIPLUSR_X1_blockaddress
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

Class RX_X1_CONTROL2_SGMIIPLUSR_X1_INSTANCE

    Public reg10m_modulo
    Public reg100m_modulo
    Public reg1g_modulo
    Public reg2p5g_modulo
    Public reguserdefinedspd_modulo
    Public reg5g_modulo
    Public blockaddress


    Public default function Init(aBaseAddr)
        Set reg10m_modulo = (New REGISTER_RX_X1_CONTROL2_SGMIIPLUSR_X1_reg10m_modulo)(aBaseAddr, 16)
        Set reg100m_modulo = (New REGISTER_RX_X1_CONTROL2_SGMIIPLUSR_X1_reg100m_modulo)(aBaseAddr, 16)
        Set reg1g_modulo = (New REGISTER_RX_X1_CONTROL2_SGMIIPLUSR_X1_reg1g_modulo)(aBaseAddr, 16)
        Set reg2p5g_modulo = (New REGISTER_RX_X1_CONTROL2_SGMIIPLUSR_X1_reg2p5g_modulo)(aBaseAddr, 16)
        Set reguserdefinedspd_modulo = (New REGISTER_RX_X1_CONTROL2_SGMIIPLUSR_X1_reguserdefinedspd_modulo)(aBaseAddr, 16)
        Set reg5g_modulo = (New REGISTER_RX_X1_CONTROL2_SGMIIPLUSR_X1_reg5g_modulo)(aBaseAddr, 16)
        Set blockaddress = (New REGISTER_RX_X1_CONTROL2_SGMIIPLUSR_X1_blockaddress)(aBaseAddr, 16)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set RX_X1_CONTROL2_SGMIIPLUSR_X1 = CreateObject("System.Collections.ArrayList")
RX_X1_CONTROL2_SGMIIPLUSR_X1.Add ((New RX_X1_CONTROL2_SGMIIPLUSR_X1_INSTANCE)(&H4aed2460))


