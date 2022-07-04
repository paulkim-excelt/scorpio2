

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


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_addr_0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_ADDR                                   [31:0]           get_MSG_ADDR
''                                                             set_MSG_ADDR
''                                                             read_MSG_ADDR
''                                                             write_MSG_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_addr_0
    Private write_MSG_ADDR_value
    Private read_MSG_ADDR_value
    Private flag_MSG_ADDR

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

    Property Get get_MSG_ADDR
        get_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let set_MSG_ADDR(aData)
        write_MSG_ADDR_value = aData
        flag_MSG_ADDR        = &H1
    End Property

    Property Get read_MSG_ADDR
        read
        read_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let write_MSG_ADDR(aData)
        set_MSG_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_ADDR = &H0 Then read
        If flag_MSG_ADDR = &H0 Then write_MSG_ADDR_value = get_MSG_ADDR

        regValue = leftShift(write_MSG_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_ADDR_value = &H0
        flag_MSG_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_uppr_addr_0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_UPPR_ADDR                              [31:0]           get_MSG_UPPR_ADDR
''                                                             set_MSG_UPPR_ADDR
''                                                             read_MSG_UPPR_ADDR
''                                                             write_MSG_UPPR_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_0
    Private write_MSG_UPPR_ADDR_value
    Private read_MSG_UPPR_ADDR_value
    Private flag_MSG_UPPR_ADDR

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

    Property Get get_MSG_UPPR_ADDR
        get_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let set_MSG_UPPR_ADDR(aData)
        write_MSG_UPPR_ADDR_value = aData
        flag_MSG_UPPR_ADDR        = &H1
    End Property

    Property Get read_MSG_UPPR_ADDR
        read
        read_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let write_MSG_UPPR_ADDR(aData)
        set_MSG_UPPR_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_UPPR_ADDR = &H0 Then read
        If flag_MSG_UPPR_ADDR = &H0 Then write_MSG_UPPR_ADDR_value = get_MSG_UPPR_ADDR

        regValue = leftShift(write_MSG_UPPR_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_UPPR_ADDR_value = &H0
        flag_MSG_UPPR_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_data_0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_DATA                                   [31:0]           get_MSG_DATA
''                                                             set_MSG_DATA
''                                                             read_MSG_DATA
''                                                             write_MSG_DATA
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_data_0
    Private write_MSG_DATA_value
    Private read_MSG_DATA_value
    Private flag_MSG_DATA

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

    Property Get get_MSG_DATA
        get_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let set_MSG_DATA(aData)
        write_MSG_DATA_value = aData
        flag_MSG_DATA        = &H1
    End Property

    Property Get read_MSG_DATA
        read
        read_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let write_MSG_DATA(aData)
        set_MSG_DATA = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

    End Sub

    Sub write
        If flag_MSG_DATA = &H0 Then read
        If flag_MSG_DATA = &H0 Then write_MSG_DATA_value = get_MSG_DATA

        regValue = leftShift(write_MSG_DATA_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_DATA_value = &H0
        flag_MSG_DATA        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_vect_ctl_0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MASK_BIT                                   [0:0]            get_MASK_BIT
''                                                             set_MASK_BIT
''                                                             read_MASK_BIT
''                                                             write_MASK_BIT
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_0
    Private write_MASK_BIT_value
    Private read_MASK_BIT_value
    Private flag_MASK_BIT

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

    Property Get get_MASK_BIT
        get_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let set_MASK_BIT(aData)
        write_MASK_BIT_value = aData
        flag_MASK_BIT        = &H1
    End Property

    Property Get read_MASK_BIT
        read
        read_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let write_MASK_BIT(aData)
        set_MASK_BIT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

    End Sub

    Sub write
        If flag_MASK_BIT = &H0 Then read
        If flag_MASK_BIT = &H0 Then write_MASK_BIT_value = get_MASK_BIT

        regValue = leftShift((write_MASK_BIT_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MASK_BIT_value = &H0
        flag_MASK_BIT        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_addr_1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_ADDR                                   [31:0]           get_MSG_ADDR
''                                                             set_MSG_ADDR
''                                                             read_MSG_ADDR
''                                                             write_MSG_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_addr_1
    Private write_MSG_ADDR_value
    Private read_MSG_ADDR_value
    Private flag_MSG_ADDR

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

    Property Get get_MSG_ADDR
        get_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let set_MSG_ADDR(aData)
        write_MSG_ADDR_value = aData
        flag_MSG_ADDR        = &H1
    End Property

    Property Get read_MSG_ADDR
        read
        read_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let write_MSG_ADDR(aData)
        set_MSG_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_ADDR = &H0 Then read
        If flag_MSG_ADDR = &H0 Then write_MSG_ADDR_value = get_MSG_ADDR

        regValue = leftShift(write_MSG_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_ADDR_value = &H0
        flag_MSG_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_uppr_addr_1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_UPPR_ADDR                              [31:0]           get_MSG_UPPR_ADDR
''                                                             set_MSG_UPPR_ADDR
''                                                             read_MSG_UPPR_ADDR
''                                                             write_MSG_UPPR_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_1
    Private write_MSG_UPPR_ADDR_value
    Private read_MSG_UPPR_ADDR_value
    Private flag_MSG_UPPR_ADDR

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

    Property Get get_MSG_UPPR_ADDR
        get_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let set_MSG_UPPR_ADDR(aData)
        write_MSG_UPPR_ADDR_value = aData
        flag_MSG_UPPR_ADDR        = &H1
    End Property

    Property Get read_MSG_UPPR_ADDR
        read
        read_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let write_MSG_UPPR_ADDR(aData)
        set_MSG_UPPR_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_UPPR_ADDR = &H0 Then read
        If flag_MSG_UPPR_ADDR = &H0 Then write_MSG_UPPR_ADDR_value = get_MSG_UPPR_ADDR

        regValue = leftShift(write_MSG_UPPR_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_UPPR_ADDR_value = &H0
        flag_MSG_UPPR_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_data_1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_DATA                                   [31:0]           get_MSG_DATA
''                                                             set_MSG_DATA
''                                                             read_MSG_DATA
''                                                             write_MSG_DATA
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_data_1
    Private write_MSG_DATA_value
    Private read_MSG_DATA_value
    Private flag_MSG_DATA

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

    Property Get get_MSG_DATA
        get_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let set_MSG_DATA(aData)
        write_MSG_DATA_value = aData
        flag_MSG_DATA        = &H1
    End Property

    Property Get read_MSG_DATA
        read
        read_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let write_MSG_DATA(aData)
        set_MSG_DATA = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

    End Sub

    Sub write
        If flag_MSG_DATA = &H0 Then read
        If flag_MSG_DATA = &H0 Then write_MSG_DATA_value = get_MSG_DATA

        regValue = leftShift(write_MSG_DATA_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_DATA_value = &H0
        flag_MSG_DATA        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_vect_ctl_1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MASK_BIT                                   [0:0]            get_MASK_BIT
''                                                             set_MASK_BIT
''                                                             read_MASK_BIT
''                                                             write_MASK_BIT
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_1
    Private write_MASK_BIT_value
    Private read_MASK_BIT_value
    Private flag_MASK_BIT

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

    Property Get get_MASK_BIT
        get_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let set_MASK_BIT(aData)
        write_MASK_BIT_value = aData
        flag_MASK_BIT        = &H1
    End Property

    Property Get read_MASK_BIT
        read
        read_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let write_MASK_BIT(aData)
        set_MASK_BIT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

    End Sub

    Sub write
        If flag_MASK_BIT = &H0 Then read
        If flag_MASK_BIT = &H0 Then write_MASK_BIT_value = get_MASK_BIT

        regValue = leftShift((write_MASK_BIT_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MASK_BIT_value = &H0
        flag_MASK_BIT        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_addr_2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_ADDR                                   [31:0]           get_MSG_ADDR
''                                                             set_MSG_ADDR
''                                                             read_MSG_ADDR
''                                                             write_MSG_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_addr_2
    Private write_MSG_ADDR_value
    Private read_MSG_ADDR_value
    Private flag_MSG_ADDR

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

    Property Get get_MSG_ADDR
        get_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let set_MSG_ADDR(aData)
        write_MSG_ADDR_value = aData
        flag_MSG_ADDR        = &H1
    End Property

    Property Get read_MSG_ADDR
        read
        read_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let write_MSG_ADDR(aData)
        set_MSG_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_ADDR = &H0 Then read
        If flag_MSG_ADDR = &H0 Then write_MSG_ADDR_value = get_MSG_ADDR

        regValue = leftShift(write_MSG_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_ADDR_value = &H0
        flag_MSG_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_uppr_addr_2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_UPPR_ADDR                              [31:0]           get_MSG_UPPR_ADDR
''                                                             set_MSG_UPPR_ADDR
''                                                             read_MSG_UPPR_ADDR
''                                                             write_MSG_UPPR_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_2
    Private write_MSG_UPPR_ADDR_value
    Private read_MSG_UPPR_ADDR_value
    Private flag_MSG_UPPR_ADDR

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

    Property Get get_MSG_UPPR_ADDR
        get_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let set_MSG_UPPR_ADDR(aData)
        write_MSG_UPPR_ADDR_value = aData
        flag_MSG_UPPR_ADDR        = &H1
    End Property

    Property Get read_MSG_UPPR_ADDR
        read
        read_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let write_MSG_UPPR_ADDR(aData)
        set_MSG_UPPR_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_UPPR_ADDR = &H0 Then read
        If flag_MSG_UPPR_ADDR = &H0 Then write_MSG_UPPR_ADDR_value = get_MSG_UPPR_ADDR

        regValue = leftShift(write_MSG_UPPR_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_UPPR_ADDR_value = &H0
        flag_MSG_UPPR_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_data_2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_DATA                                   [31:0]           get_MSG_DATA
''                                                             set_MSG_DATA
''                                                             read_MSG_DATA
''                                                             write_MSG_DATA
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_data_2
    Private write_MSG_DATA_value
    Private read_MSG_DATA_value
    Private flag_MSG_DATA

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

    Property Get get_MSG_DATA
        get_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let set_MSG_DATA(aData)
        write_MSG_DATA_value = aData
        flag_MSG_DATA        = &H1
    End Property

    Property Get read_MSG_DATA
        read
        read_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let write_MSG_DATA(aData)
        set_MSG_DATA = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

    End Sub

    Sub write
        If flag_MSG_DATA = &H0 Then read
        If flag_MSG_DATA = &H0 Then write_MSG_DATA_value = get_MSG_DATA

        regValue = leftShift(write_MSG_DATA_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_DATA_value = &H0
        flag_MSG_DATA        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_vect_ctl_2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MASK_BIT                                   [0:0]            get_MASK_BIT
''                                                             set_MASK_BIT
''                                                             read_MASK_BIT
''                                                             write_MASK_BIT
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_2
    Private write_MASK_BIT_value
    Private read_MASK_BIT_value
    Private flag_MASK_BIT

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

    Property Get get_MASK_BIT
        get_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let set_MASK_BIT(aData)
        write_MASK_BIT_value = aData
        flag_MASK_BIT        = &H1
    End Property

    Property Get read_MASK_BIT
        read
        read_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let write_MASK_BIT(aData)
        set_MASK_BIT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

    End Sub

    Sub write
        If flag_MASK_BIT = &H0 Then read
        If flag_MASK_BIT = &H0 Then write_MASK_BIT_value = get_MASK_BIT

        regValue = leftShift((write_MASK_BIT_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MASK_BIT_value = &H0
        flag_MASK_BIT        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_addr_3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_ADDR                                   [31:0]           get_MSG_ADDR
''                                                             set_MSG_ADDR
''                                                             read_MSG_ADDR
''                                                             write_MSG_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_addr_3
    Private write_MSG_ADDR_value
    Private read_MSG_ADDR_value
    Private flag_MSG_ADDR

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

    Property Get get_MSG_ADDR
        get_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let set_MSG_ADDR(aData)
        write_MSG_ADDR_value = aData
        flag_MSG_ADDR        = &H1
    End Property

    Property Get read_MSG_ADDR
        read
        read_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let write_MSG_ADDR(aData)
        set_MSG_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_ADDR = &H0 Then read
        If flag_MSG_ADDR = &H0 Then write_MSG_ADDR_value = get_MSG_ADDR

        regValue = leftShift(write_MSG_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_ADDR_value = &H0
        flag_MSG_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_uppr_addr_3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_UPPR_ADDR                              [31:0]           get_MSG_UPPR_ADDR
''                                                             set_MSG_UPPR_ADDR
''                                                             read_MSG_UPPR_ADDR
''                                                             write_MSG_UPPR_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_3
    Private write_MSG_UPPR_ADDR_value
    Private read_MSG_UPPR_ADDR_value
    Private flag_MSG_UPPR_ADDR

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

    Property Get get_MSG_UPPR_ADDR
        get_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let set_MSG_UPPR_ADDR(aData)
        write_MSG_UPPR_ADDR_value = aData
        flag_MSG_UPPR_ADDR        = &H1
    End Property

    Property Get read_MSG_UPPR_ADDR
        read
        read_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let write_MSG_UPPR_ADDR(aData)
        set_MSG_UPPR_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_UPPR_ADDR = &H0 Then read
        If flag_MSG_UPPR_ADDR = &H0 Then write_MSG_UPPR_ADDR_value = get_MSG_UPPR_ADDR

        regValue = leftShift(write_MSG_UPPR_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_UPPR_ADDR_value = &H0
        flag_MSG_UPPR_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_data_3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_DATA                                   [31:0]           get_MSG_DATA
''                                                             set_MSG_DATA
''                                                             read_MSG_DATA
''                                                             write_MSG_DATA
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_data_3
    Private write_MSG_DATA_value
    Private read_MSG_DATA_value
    Private flag_MSG_DATA

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

    Property Get get_MSG_DATA
        get_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let set_MSG_DATA(aData)
        write_MSG_DATA_value = aData
        flag_MSG_DATA        = &H1
    End Property

    Property Get read_MSG_DATA
        read
        read_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let write_MSG_DATA(aData)
        set_MSG_DATA = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

    End Sub

    Sub write
        If flag_MSG_DATA = &H0 Then read
        If flag_MSG_DATA = &H0 Then write_MSG_DATA_value = get_MSG_DATA

        regValue = leftShift(write_MSG_DATA_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_DATA_value = &H0
        flag_MSG_DATA        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_vect_ctl_3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MASK_BIT                                   [0:0]            get_MASK_BIT
''                                                             set_MASK_BIT
''                                                             read_MASK_BIT
''                                                             write_MASK_BIT
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_3
    Private write_MASK_BIT_value
    Private read_MASK_BIT_value
    Private flag_MASK_BIT

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

    Property Get get_MASK_BIT
        get_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let set_MASK_BIT(aData)
        write_MASK_BIT_value = aData
        flag_MASK_BIT        = &H1
    End Property

    Property Get read_MASK_BIT
        read
        read_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let write_MASK_BIT(aData)
        set_MASK_BIT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

    End Sub

    Sub write
        If flag_MASK_BIT = &H0 Then read
        If flag_MASK_BIT = &H0 Then write_MASK_BIT_value = get_MASK_BIT

        regValue = leftShift((write_MASK_BIT_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MASK_BIT_value = &H0
        flag_MASK_BIT        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_addr_4
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_ADDR                                   [31:0]           get_MSG_ADDR
''                                                             set_MSG_ADDR
''                                                             read_MSG_ADDR
''                                                             write_MSG_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_addr_4
    Private write_MSG_ADDR_value
    Private read_MSG_ADDR_value
    Private flag_MSG_ADDR

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

    Property Get get_MSG_ADDR
        get_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let set_MSG_ADDR(aData)
        write_MSG_ADDR_value = aData
        flag_MSG_ADDR        = &H1
    End Property

    Property Get read_MSG_ADDR
        read
        read_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let write_MSG_ADDR(aData)
        set_MSG_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_ADDR = &H0 Then read
        If flag_MSG_ADDR = &H0 Then write_MSG_ADDR_value = get_MSG_ADDR

        regValue = leftShift(write_MSG_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_ADDR_value = &H0
        flag_MSG_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_uppr_addr_4
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_UPPR_ADDR                              [31:0]           get_MSG_UPPR_ADDR
''                                                             set_MSG_UPPR_ADDR
''                                                             read_MSG_UPPR_ADDR
''                                                             write_MSG_UPPR_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_4
    Private write_MSG_UPPR_ADDR_value
    Private read_MSG_UPPR_ADDR_value
    Private flag_MSG_UPPR_ADDR

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

    Property Get get_MSG_UPPR_ADDR
        get_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let set_MSG_UPPR_ADDR(aData)
        write_MSG_UPPR_ADDR_value = aData
        flag_MSG_UPPR_ADDR        = &H1
    End Property

    Property Get read_MSG_UPPR_ADDR
        read
        read_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let write_MSG_UPPR_ADDR(aData)
        set_MSG_UPPR_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_UPPR_ADDR = &H0 Then read
        If flag_MSG_UPPR_ADDR = &H0 Then write_MSG_UPPR_ADDR_value = get_MSG_UPPR_ADDR

        regValue = leftShift(write_MSG_UPPR_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_UPPR_ADDR_value = &H0
        flag_MSG_UPPR_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_data_4
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_DATA                                   [31:0]           get_MSG_DATA
''                                                             set_MSG_DATA
''                                                             read_MSG_DATA
''                                                             write_MSG_DATA
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_data_4
    Private write_MSG_DATA_value
    Private read_MSG_DATA_value
    Private flag_MSG_DATA

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

    Property Get get_MSG_DATA
        get_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let set_MSG_DATA(aData)
        write_MSG_DATA_value = aData
        flag_MSG_DATA        = &H1
    End Property

    Property Get read_MSG_DATA
        read
        read_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let write_MSG_DATA(aData)
        set_MSG_DATA = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

    End Sub

    Sub write
        If flag_MSG_DATA = &H0 Then read
        If flag_MSG_DATA = &H0 Then write_MSG_DATA_value = get_MSG_DATA

        regValue = leftShift(write_MSG_DATA_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_DATA_value = &H0
        flag_MSG_DATA        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_vect_ctl_4
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MASK_BIT                                   [0:0]            get_MASK_BIT
''                                                             set_MASK_BIT
''                                                             read_MASK_BIT
''                                                             write_MASK_BIT
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_4
    Private write_MASK_BIT_value
    Private read_MASK_BIT_value
    Private flag_MASK_BIT

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

    Property Get get_MASK_BIT
        get_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let set_MASK_BIT(aData)
        write_MASK_BIT_value = aData
        flag_MASK_BIT        = &H1
    End Property

    Property Get read_MASK_BIT
        read
        read_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let write_MASK_BIT(aData)
        set_MASK_BIT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

    End Sub

    Sub write
        If flag_MASK_BIT = &H0 Then read
        If flag_MASK_BIT = &H0 Then write_MASK_BIT_value = get_MASK_BIT

        regValue = leftShift((write_MASK_BIT_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MASK_BIT_value = &H0
        flag_MASK_BIT        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_addr_5
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_ADDR                                   [31:0]           get_MSG_ADDR
''                                                             set_MSG_ADDR
''                                                             read_MSG_ADDR
''                                                             write_MSG_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_addr_5
    Private write_MSG_ADDR_value
    Private read_MSG_ADDR_value
    Private flag_MSG_ADDR

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

    Property Get get_MSG_ADDR
        get_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let set_MSG_ADDR(aData)
        write_MSG_ADDR_value = aData
        flag_MSG_ADDR        = &H1
    End Property

    Property Get read_MSG_ADDR
        read
        read_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let write_MSG_ADDR(aData)
        set_MSG_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_ADDR = &H0 Then read
        If flag_MSG_ADDR = &H0 Then write_MSG_ADDR_value = get_MSG_ADDR

        regValue = leftShift(write_MSG_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_ADDR_value = &H0
        flag_MSG_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_uppr_addr_5
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_UPPR_ADDR                              [31:0]           get_MSG_UPPR_ADDR
''                                                             set_MSG_UPPR_ADDR
''                                                             read_MSG_UPPR_ADDR
''                                                             write_MSG_UPPR_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_5
    Private write_MSG_UPPR_ADDR_value
    Private read_MSG_UPPR_ADDR_value
    Private flag_MSG_UPPR_ADDR

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

    Property Get get_MSG_UPPR_ADDR
        get_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let set_MSG_UPPR_ADDR(aData)
        write_MSG_UPPR_ADDR_value = aData
        flag_MSG_UPPR_ADDR        = &H1
    End Property

    Property Get read_MSG_UPPR_ADDR
        read
        read_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let write_MSG_UPPR_ADDR(aData)
        set_MSG_UPPR_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_UPPR_ADDR = &H0 Then read
        If flag_MSG_UPPR_ADDR = &H0 Then write_MSG_UPPR_ADDR_value = get_MSG_UPPR_ADDR

        regValue = leftShift(write_MSG_UPPR_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_UPPR_ADDR_value = &H0
        flag_MSG_UPPR_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_data_5
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_DATA                                   [31:0]           get_MSG_DATA
''                                                             set_MSG_DATA
''                                                             read_MSG_DATA
''                                                             write_MSG_DATA
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_data_5
    Private write_MSG_DATA_value
    Private read_MSG_DATA_value
    Private flag_MSG_DATA

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

    Property Get get_MSG_DATA
        get_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let set_MSG_DATA(aData)
        write_MSG_DATA_value = aData
        flag_MSG_DATA        = &H1
    End Property

    Property Get read_MSG_DATA
        read
        read_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let write_MSG_DATA(aData)
        set_MSG_DATA = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

    End Sub

    Sub write
        If flag_MSG_DATA = &H0 Then read
        If flag_MSG_DATA = &H0 Then write_MSG_DATA_value = get_MSG_DATA

        regValue = leftShift(write_MSG_DATA_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_DATA_value = &H0
        flag_MSG_DATA        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_vect_ctl_5
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MASK_BIT                                   [0:0]            get_MASK_BIT
''                                                             set_MASK_BIT
''                                                             read_MASK_BIT
''                                                             write_MASK_BIT
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_5
    Private write_MASK_BIT_value
    Private read_MASK_BIT_value
    Private flag_MASK_BIT

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

    Property Get get_MASK_BIT
        get_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let set_MASK_BIT(aData)
        write_MASK_BIT_value = aData
        flag_MASK_BIT        = &H1
    End Property

    Property Get read_MASK_BIT
        read
        read_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let write_MASK_BIT(aData)
        set_MASK_BIT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

    End Sub

    Sub write
        If flag_MASK_BIT = &H0 Then read
        If flag_MASK_BIT = &H0 Then write_MASK_BIT_value = get_MASK_BIT

        regValue = leftShift((write_MASK_BIT_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MASK_BIT_value = &H0
        flag_MASK_BIT        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_addr_6
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_ADDR                                   [31:0]           get_MSG_ADDR
''                                                             set_MSG_ADDR
''                                                             read_MSG_ADDR
''                                                             write_MSG_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_addr_6
    Private write_MSG_ADDR_value
    Private read_MSG_ADDR_value
    Private flag_MSG_ADDR

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

    Property Get get_MSG_ADDR
        get_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let set_MSG_ADDR(aData)
        write_MSG_ADDR_value = aData
        flag_MSG_ADDR        = &H1
    End Property

    Property Get read_MSG_ADDR
        read
        read_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let write_MSG_ADDR(aData)
        set_MSG_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_ADDR = &H0 Then read
        If flag_MSG_ADDR = &H0 Then write_MSG_ADDR_value = get_MSG_ADDR

        regValue = leftShift(write_MSG_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_ADDR_value = &H0
        flag_MSG_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_uppr_addr_6
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_UPPR_ADDR                              [31:0]           get_MSG_UPPR_ADDR
''                                                             set_MSG_UPPR_ADDR
''                                                             read_MSG_UPPR_ADDR
''                                                             write_MSG_UPPR_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_6
    Private write_MSG_UPPR_ADDR_value
    Private read_MSG_UPPR_ADDR_value
    Private flag_MSG_UPPR_ADDR

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

    Property Get get_MSG_UPPR_ADDR
        get_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let set_MSG_UPPR_ADDR(aData)
        write_MSG_UPPR_ADDR_value = aData
        flag_MSG_UPPR_ADDR        = &H1
    End Property

    Property Get read_MSG_UPPR_ADDR
        read
        read_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let write_MSG_UPPR_ADDR(aData)
        set_MSG_UPPR_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_UPPR_ADDR = &H0 Then read
        If flag_MSG_UPPR_ADDR = &H0 Then write_MSG_UPPR_ADDR_value = get_MSG_UPPR_ADDR

        regValue = leftShift(write_MSG_UPPR_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_UPPR_ADDR_value = &H0
        flag_MSG_UPPR_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_data_6
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_DATA                                   [31:0]           get_MSG_DATA
''                                                             set_MSG_DATA
''                                                             read_MSG_DATA
''                                                             write_MSG_DATA
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_data_6
    Private write_MSG_DATA_value
    Private read_MSG_DATA_value
    Private flag_MSG_DATA

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

    Property Get get_MSG_DATA
        get_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let set_MSG_DATA(aData)
        write_MSG_DATA_value = aData
        flag_MSG_DATA        = &H1
    End Property

    Property Get read_MSG_DATA
        read
        read_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let write_MSG_DATA(aData)
        set_MSG_DATA = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

    End Sub

    Sub write
        If flag_MSG_DATA = &H0 Then read
        If flag_MSG_DATA = &H0 Then write_MSG_DATA_value = get_MSG_DATA

        regValue = leftShift(write_MSG_DATA_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_DATA_value = &H0
        flag_MSG_DATA        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_vect_ctl_6
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MASK_BIT                                   [0:0]            get_MASK_BIT
''                                                             set_MASK_BIT
''                                                             read_MASK_BIT
''                                                             write_MASK_BIT
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_6
    Private write_MASK_BIT_value
    Private read_MASK_BIT_value
    Private flag_MASK_BIT

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

    Property Get get_MASK_BIT
        get_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let set_MASK_BIT(aData)
        write_MASK_BIT_value = aData
        flag_MASK_BIT        = &H1
    End Property

    Property Get read_MASK_BIT
        read
        read_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let write_MASK_BIT(aData)
        set_MASK_BIT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

    End Sub

    Sub write
        If flag_MASK_BIT = &H0 Then read
        If flag_MASK_BIT = &H0 Then write_MASK_BIT_value = get_MASK_BIT

        regValue = leftShift((write_MASK_BIT_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MASK_BIT_value = &H0
        flag_MASK_BIT        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_addr_7
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_ADDR                                   [31:0]           get_MSG_ADDR
''                                                             set_MSG_ADDR
''                                                             read_MSG_ADDR
''                                                             write_MSG_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_addr_7
    Private write_MSG_ADDR_value
    Private read_MSG_ADDR_value
    Private flag_MSG_ADDR

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

    Property Get get_MSG_ADDR
        get_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let set_MSG_ADDR(aData)
        write_MSG_ADDR_value = aData
        flag_MSG_ADDR        = &H1
    End Property

    Property Get read_MSG_ADDR
        read
        read_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let write_MSG_ADDR(aData)
        set_MSG_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_ADDR = &H0 Then read
        If flag_MSG_ADDR = &H0 Then write_MSG_ADDR_value = get_MSG_ADDR

        regValue = leftShift(write_MSG_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_ADDR_value = &H0
        flag_MSG_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_uppr_addr_7
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_UPPR_ADDR                              [31:0]           get_MSG_UPPR_ADDR
''                                                             set_MSG_UPPR_ADDR
''                                                             read_MSG_UPPR_ADDR
''                                                             write_MSG_UPPR_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_7
    Private write_MSG_UPPR_ADDR_value
    Private read_MSG_UPPR_ADDR_value
    Private flag_MSG_UPPR_ADDR

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

    Property Get get_MSG_UPPR_ADDR
        get_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let set_MSG_UPPR_ADDR(aData)
        write_MSG_UPPR_ADDR_value = aData
        flag_MSG_UPPR_ADDR        = &H1
    End Property

    Property Get read_MSG_UPPR_ADDR
        read
        read_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let write_MSG_UPPR_ADDR(aData)
        set_MSG_UPPR_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_UPPR_ADDR = &H0 Then read
        If flag_MSG_UPPR_ADDR = &H0 Then write_MSG_UPPR_ADDR_value = get_MSG_UPPR_ADDR

        regValue = leftShift(write_MSG_UPPR_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_UPPR_ADDR_value = &H0
        flag_MSG_UPPR_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_data_7
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_DATA                                   [31:0]           get_MSG_DATA
''                                                             set_MSG_DATA
''                                                             read_MSG_DATA
''                                                             write_MSG_DATA
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_data_7
    Private write_MSG_DATA_value
    Private read_MSG_DATA_value
    Private flag_MSG_DATA

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

    Property Get get_MSG_DATA
        get_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let set_MSG_DATA(aData)
        write_MSG_DATA_value = aData
        flag_MSG_DATA        = &H1
    End Property

    Property Get read_MSG_DATA
        read
        read_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let write_MSG_DATA(aData)
        set_MSG_DATA = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

    End Sub

    Sub write
        If flag_MSG_DATA = &H0 Then read
        If flag_MSG_DATA = &H0 Then write_MSG_DATA_value = get_MSG_DATA

        regValue = leftShift(write_MSG_DATA_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_DATA_value = &H0
        flag_MSG_DATA        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_vect_ctl_7
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MASK_BIT                                   [0:0]            get_MASK_BIT
''                                                             set_MASK_BIT
''                                                             read_MASK_BIT
''                                                             write_MASK_BIT
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_7
    Private write_MASK_BIT_value
    Private read_MASK_BIT_value
    Private flag_MASK_BIT

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

    Property Get get_MASK_BIT
        get_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let set_MASK_BIT(aData)
        write_MASK_BIT_value = aData
        flag_MASK_BIT        = &H1
    End Property

    Property Get read_MASK_BIT
        read
        read_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let write_MASK_BIT(aData)
        set_MASK_BIT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

    End Sub

    Sub write
        If flag_MASK_BIT = &H0 Then read
        If flag_MASK_BIT = &H0 Then write_MASK_BIT_value = get_MASK_BIT

        regValue = leftShift((write_MASK_BIT_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MASK_BIT_value = &H0
        flag_MASK_BIT        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_addr_8
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_ADDR                                   [31:0]           get_MSG_ADDR
''                                                             set_MSG_ADDR
''                                                             read_MSG_ADDR
''                                                             write_MSG_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_addr_8
    Private write_MSG_ADDR_value
    Private read_MSG_ADDR_value
    Private flag_MSG_ADDR

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

    Property Get get_MSG_ADDR
        get_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let set_MSG_ADDR(aData)
        write_MSG_ADDR_value = aData
        flag_MSG_ADDR        = &H1
    End Property

    Property Get read_MSG_ADDR
        read
        read_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let write_MSG_ADDR(aData)
        set_MSG_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_ADDR = &H0 Then read
        If flag_MSG_ADDR = &H0 Then write_MSG_ADDR_value = get_MSG_ADDR

        regValue = leftShift(write_MSG_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_ADDR_value = &H0
        flag_MSG_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_uppr_addr_8
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_UPPR_ADDR                              [31:0]           get_MSG_UPPR_ADDR
''                                                             set_MSG_UPPR_ADDR
''                                                             read_MSG_UPPR_ADDR
''                                                             write_MSG_UPPR_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_8
    Private write_MSG_UPPR_ADDR_value
    Private read_MSG_UPPR_ADDR_value
    Private flag_MSG_UPPR_ADDR

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

    Property Get get_MSG_UPPR_ADDR
        get_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let set_MSG_UPPR_ADDR(aData)
        write_MSG_UPPR_ADDR_value = aData
        flag_MSG_UPPR_ADDR        = &H1
    End Property

    Property Get read_MSG_UPPR_ADDR
        read
        read_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let write_MSG_UPPR_ADDR(aData)
        set_MSG_UPPR_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_UPPR_ADDR = &H0 Then read
        If flag_MSG_UPPR_ADDR = &H0 Then write_MSG_UPPR_ADDR_value = get_MSG_UPPR_ADDR

        regValue = leftShift(write_MSG_UPPR_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_UPPR_ADDR_value = &H0
        flag_MSG_UPPR_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_data_8
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_DATA                                   [31:0]           get_MSG_DATA
''                                                             set_MSG_DATA
''                                                             read_MSG_DATA
''                                                             write_MSG_DATA
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_data_8
    Private write_MSG_DATA_value
    Private read_MSG_DATA_value
    Private flag_MSG_DATA

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

    Property Get get_MSG_DATA
        get_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let set_MSG_DATA(aData)
        write_MSG_DATA_value = aData
        flag_MSG_DATA        = &H1
    End Property

    Property Get read_MSG_DATA
        read
        read_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let write_MSG_DATA(aData)
        set_MSG_DATA = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

    End Sub

    Sub write
        If flag_MSG_DATA = &H0 Then read
        If flag_MSG_DATA = &H0 Then write_MSG_DATA_value = get_MSG_DATA

        regValue = leftShift(write_MSG_DATA_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_DATA_value = &H0
        flag_MSG_DATA        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_vect_ctl_8
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MASK_BIT                                   [0:0]            get_MASK_BIT
''                                                             set_MASK_BIT
''                                                             read_MASK_BIT
''                                                             write_MASK_BIT
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_8
    Private write_MASK_BIT_value
    Private read_MASK_BIT_value
    Private flag_MASK_BIT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H8c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MASK_BIT
        get_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let set_MASK_BIT(aData)
        write_MASK_BIT_value = aData
        flag_MASK_BIT        = &H1
    End Property

    Property Get read_MASK_BIT
        read
        read_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let write_MASK_BIT(aData)
        set_MASK_BIT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

    End Sub

    Sub write
        If flag_MASK_BIT = &H0 Then read
        If flag_MASK_BIT = &H0 Then write_MASK_BIT_value = get_MASK_BIT

        regValue = leftShift((write_MASK_BIT_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MASK_BIT_value = &H0
        flag_MASK_BIT        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_addr_9
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_ADDR                                   [31:0]           get_MSG_ADDR
''                                                             set_MSG_ADDR
''                                                             read_MSG_ADDR
''                                                             write_MSG_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_addr_9
    Private write_MSG_ADDR_value
    Private read_MSG_ADDR_value
    Private flag_MSG_ADDR

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

    Property Get get_MSG_ADDR
        get_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let set_MSG_ADDR(aData)
        write_MSG_ADDR_value = aData
        flag_MSG_ADDR        = &H1
    End Property

    Property Get read_MSG_ADDR
        read
        read_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let write_MSG_ADDR(aData)
        set_MSG_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_ADDR = &H0 Then read
        If flag_MSG_ADDR = &H0 Then write_MSG_ADDR_value = get_MSG_ADDR

        regValue = leftShift(write_MSG_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_ADDR_value = &H0
        flag_MSG_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_uppr_addr_9
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_UPPR_ADDR                              [31:0]           get_MSG_UPPR_ADDR
''                                                             set_MSG_UPPR_ADDR
''                                                             read_MSG_UPPR_ADDR
''                                                             write_MSG_UPPR_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_9
    Private write_MSG_UPPR_ADDR_value
    Private read_MSG_UPPR_ADDR_value
    Private flag_MSG_UPPR_ADDR

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

    Property Get get_MSG_UPPR_ADDR
        get_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let set_MSG_UPPR_ADDR(aData)
        write_MSG_UPPR_ADDR_value = aData
        flag_MSG_UPPR_ADDR        = &H1
    End Property

    Property Get read_MSG_UPPR_ADDR
        read
        read_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let write_MSG_UPPR_ADDR(aData)
        set_MSG_UPPR_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_UPPR_ADDR = &H0 Then read
        If flag_MSG_UPPR_ADDR = &H0 Then write_MSG_UPPR_ADDR_value = get_MSG_UPPR_ADDR

        regValue = leftShift(write_MSG_UPPR_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_UPPR_ADDR_value = &H0
        flag_MSG_UPPR_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_data_9
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_DATA                                   [31:0]           get_MSG_DATA
''                                                             set_MSG_DATA
''                                                             read_MSG_DATA
''                                                             write_MSG_DATA
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_data_9
    Private write_MSG_DATA_value
    Private read_MSG_DATA_value
    Private flag_MSG_DATA

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

    Property Get get_MSG_DATA
        get_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let set_MSG_DATA(aData)
        write_MSG_DATA_value = aData
        flag_MSG_DATA        = &H1
    End Property

    Property Get read_MSG_DATA
        read
        read_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let write_MSG_DATA(aData)
        set_MSG_DATA = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

    End Sub

    Sub write
        If flag_MSG_DATA = &H0 Then read
        If flag_MSG_DATA = &H0 Then write_MSG_DATA_value = get_MSG_DATA

        regValue = leftShift(write_MSG_DATA_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_DATA_value = &H0
        flag_MSG_DATA        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_vect_ctl_9
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MASK_BIT                                   [0:0]            get_MASK_BIT
''                                                             set_MASK_BIT
''                                                             read_MASK_BIT
''                                                             write_MASK_BIT
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_9
    Private write_MASK_BIT_value
    Private read_MASK_BIT_value
    Private flag_MASK_BIT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H9c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MASK_BIT
        get_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let set_MASK_BIT(aData)
        write_MASK_BIT_value = aData
        flag_MASK_BIT        = &H1
    End Property

    Property Get read_MASK_BIT
        read
        read_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let write_MASK_BIT(aData)
        set_MASK_BIT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

    End Sub

    Sub write
        If flag_MASK_BIT = &H0 Then read
        If flag_MASK_BIT = &H0 Then write_MASK_BIT_value = get_MASK_BIT

        regValue = leftShift((write_MASK_BIT_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MASK_BIT_value = &H0
        flag_MASK_BIT        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_addr_10
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_ADDR                                   [31:0]           get_MSG_ADDR
''                                                             set_MSG_ADDR
''                                                             read_MSG_ADDR
''                                                             write_MSG_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_addr_10
    Private write_MSG_ADDR_value
    Private read_MSG_ADDR_value
    Private flag_MSG_ADDR

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

    Property Get get_MSG_ADDR
        get_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let set_MSG_ADDR(aData)
        write_MSG_ADDR_value = aData
        flag_MSG_ADDR        = &H1
    End Property

    Property Get read_MSG_ADDR
        read
        read_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let write_MSG_ADDR(aData)
        set_MSG_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_ADDR = &H0 Then read
        If flag_MSG_ADDR = &H0 Then write_MSG_ADDR_value = get_MSG_ADDR

        regValue = leftShift(write_MSG_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_ADDR_value = &H0
        flag_MSG_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_uppr_addr_10
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_UPPR_ADDR                              [31:0]           get_MSG_UPPR_ADDR
''                                                             set_MSG_UPPR_ADDR
''                                                             read_MSG_UPPR_ADDR
''                                                             write_MSG_UPPR_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_10
    Private write_MSG_UPPR_ADDR_value
    Private read_MSG_UPPR_ADDR_value
    Private flag_MSG_UPPR_ADDR

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

    Property Get get_MSG_UPPR_ADDR
        get_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let set_MSG_UPPR_ADDR(aData)
        write_MSG_UPPR_ADDR_value = aData
        flag_MSG_UPPR_ADDR        = &H1
    End Property

    Property Get read_MSG_UPPR_ADDR
        read
        read_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let write_MSG_UPPR_ADDR(aData)
        set_MSG_UPPR_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_UPPR_ADDR = &H0 Then read
        If flag_MSG_UPPR_ADDR = &H0 Then write_MSG_UPPR_ADDR_value = get_MSG_UPPR_ADDR

        regValue = leftShift(write_MSG_UPPR_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_UPPR_ADDR_value = &H0
        flag_MSG_UPPR_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_data_10
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_DATA                                   [31:0]           get_MSG_DATA
''                                                             set_MSG_DATA
''                                                             read_MSG_DATA
''                                                             write_MSG_DATA
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_data_10
    Private write_MSG_DATA_value
    Private read_MSG_DATA_value
    Private flag_MSG_DATA

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

    Property Get get_MSG_DATA
        get_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let set_MSG_DATA(aData)
        write_MSG_DATA_value = aData
        flag_MSG_DATA        = &H1
    End Property

    Property Get read_MSG_DATA
        read
        read_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let write_MSG_DATA(aData)
        set_MSG_DATA = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

    End Sub

    Sub write
        If flag_MSG_DATA = &H0 Then read
        If flag_MSG_DATA = &H0 Then write_MSG_DATA_value = get_MSG_DATA

        regValue = leftShift(write_MSG_DATA_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_DATA_value = &H0
        flag_MSG_DATA        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_vect_ctl_10
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MASK_BIT                                   [0:0]            get_MASK_BIT
''                                                             set_MASK_BIT
''                                                             read_MASK_BIT
''                                                             write_MASK_BIT
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_10
    Private write_MASK_BIT_value
    Private read_MASK_BIT_value
    Private flag_MASK_BIT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hac
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MASK_BIT
        get_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let set_MASK_BIT(aData)
        write_MASK_BIT_value = aData
        flag_MASK_BIT        = &H1
    End Property

    Property Get read_MASK_BIT
        read
        read_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let write_MASK_BIT(aData)
        set_MASK_BIT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

    End Sub

    Sub write
        If flag_MASK_BIT = &H0 Then read
        If flag_MASK_BIT = &H0 Then write_MASK_BIT_value = get_MASK_BIT

        regValue = leftShift((write_MASK_BIT_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MASK_BIT_value = &H0
        flag_MASK_BIT        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_addr_11
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_ADDR                                   [31:0]           get_MSG_ADDR
''                                                             set_MSG_ADDR
''                                                             read_MSG_ADDR
''                                                             write_MSG_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_addr_11
    Private write_MSG_ADDR_value
    Private read_MSG_ADDR_value
    Private flag_MSG_ADDR

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

    Property Get get_MSG_ADDR
        get_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let set_MSG_ADDR(aData)
        write_MSG_ADDR_value = aData
        flag_MSG_ADDR        = &H1
    End Property

    Property Get read_MSG_ADDR
        read
        read_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let write_MSG_ADDR(aData)
        set_MSG_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_ADDR = &H0 Then read
        If flag_MSG_ADDR = &H0 Then write_MSG_ADDR_value = get_MSG_ADDR

        regValue = leftShift(write_MSG_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_ADDR_value = &H0
        flag_MSG_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_uppr_addr_11
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_UPPR_ADDR                              [31:0]           get_MSG_UPPR_ADDR
''                                                             set_MSG_UPPR_ADDR
''                                                             read_MSG_UPPR_ADDR
''                                                             write_MSG_UPPR_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_11
    Private write_MSG_UPPR_ADDR_value
    Private read_MSG_UPPR_ADDR_value
    Private flag_MSG_UPPR_ADDR

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

    Property Get get_MSG_UPPR_ADDR
        get_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let set_MSG_UPPR_ADDR(aData)
        write_MSG_UPPR_ADDR_value = aData
        flag_MSG_UPPR_ADDR        = &H1
    End Property

    Property Get read_MSG_UPPR_ADDR
        read
        read_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let write_MSG_UPPR_ADDR(aData)
        set_MSG_UPPR_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_UPPR_ADDR = &H0 Then read
        If flag_MSG_UPPR_ADDR = &H0 Then write_MSG_UPPR_ADDR_value = get_MSG_UPPR_ADDR

        regValue = leftShift(write_MSG_UPPR_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_UPPR_ADDR_value = &H0
        flag_MSG_UPPR_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_data_11
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_DATA                                   [31:0]           get_MSG_DATA
''                                                             set_MSG_DATA
''                                                             read_MSG_DATA
''                                                             write_MSG_DATA
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_data_11
    Private write_MSG_DATA_value
    Private read_MSG_DATA_value
    Private flag_MSG_DATA

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

    Property Get get_MSG_DATA
        get_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let set_MSG_DATA(aData)
        write_MSG_DATA_value = aData
        flag_MSG_DATA        = &H1
    End Property

    Property Get read_MSG_DATA
        read
        read_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let write_MSG_DATA(aData)
        set_MSG_DATA = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

    End Sub

    Sub write
        If flag_MSG_DATA = &H0 Then read
        If flag_MSG_DATA = &H0 Then write_MSG_DATA_value = get_MSG_DATA

        regValue = leftShift(write_MSG_DATA_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_DATA_value = &H0
        flag_MSG_DATA        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_vect_ctl_11
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MASK_BIT                                   [0:0]            get_MASK_BIT
''                                                             set_MASK_BIT
''                                                             read_MASK_BIT
''                                                             write_MASK_BIT
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_11
    Private write_MASK_BIT_value
    Private read_MASK_BIT_value
    Private flag_MASK_BIT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hbc
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MASK_BIT
        get_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let set_MASK_BIT(aData)
        write_MASK_BIT_value = aData
        flag_MASK_BIT        = &H1
    End Property

    Property Get read_MASK_BIT
        read
        read_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let write_MASK_BIT(aData)
        set_MASK_BIT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

    End Sub

    Sub write
        If flag_MASK_BIT = &H0 Then read
        If flag_MASK_BIT = &H0 Then write_MASK_BIT_value = get_MASK_BIT

        regValue = leftShift((write_MASK_BIT_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MASK_BIT_value = &H0
        flag_MASK_BIT        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_addr_12
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_ADDR                                   [31:0]           get_MSG_ADDR
''                                                             set_MSG_ADDR
''                                                             read_MSG_ADDR
''                                                             write_MSG_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_addr_12
    Private write_MSG_ADDR_value
    Private read_MSG_ADDR_value
    Private flag_MSG_ADDR

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

    Property Get get_MSG_ADDR
        get_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let set_MSG_ADDR(aData)
        write_MSG_ADDR_value = aData
        flag_MSG_ADDR        = &H1
    End Property

    Property Get read_MSG_ADDR
        read
        read_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let write_MSG_ADDR(aData)
        set_MSG_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_ADDR = &H0 Then read
        If flag_MSG_ADDR = &H0 Then write_MSG_ADDR_value = get_MSG_ADDR

        regValue = leftShift(write_MSG_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_ADDR_value = &H0
        flag_MSG_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_uppr_addr_12
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_UPPR_ADDR                              [31:0]           get_MSG_UPPR_ADDR
''                                                             set_MSG_UPPR_ADDR
''                                                             read_MSG_UPPR_ADDR
''                                                             write_MSG_UPPR_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_12
    Private write_MSG_UPPR_ADDR_value
    Private read_MSG_UPPR_ADDR_value
    Private flag_MSG_UPPR_ADDR

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

    Property Get get_MSG_UPPR_ADDR
        get_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let set_MSG_UPPR_ADDR(aData)
        write_MSG_UPPR_ADDR_value = aData
        flag_MSG_UPPR_ADDR        = &H1
    End Property

    Property Get read_MSG_UPPR_ADDR
        read
        read_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let write_MSG_UPPR_ADDR(aData)
        set_MSG_UPPR_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_UPPR_ADDR = &H0 Then read
        If flag_MSG_UPPR_ADDR = &H0 Then write_MSG_UPPR_ADDR_value = get_MSG_UPPR_ADDR

        regValue = leftShift(write_MSG_UPPR_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_UPPR_ADDR_value = &H0
        flag_MSG_UPPR_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_data_12
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_DATA                                   [31:0]           get_MSG_DATA
''                                                             set_MSG_DATA
''                                                             read_MSG_DATA
''                                                             write_MSG_DATA
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_data_12
    Private write_MSG_DATA_value
    Private read_MSG_DATA_value
    Private flag_MSG_DATA

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

    Property Get get_MSG_DATA
        get_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let set_MSG_DATA(aData)
        write_MSG_DATA_value = aData
        flag_MSG_DATA        = &H1
    End Property

    Property Get read_MSG_DATA
        read
        read_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let write_MSG_DATA(aData)
        set_MSG_DATA = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

    End Sub

    Sub write
        If flag_MSG_DATA = &H0 Then read
        If flag_MSG_DATA = &H0 Then write_MSG_DATA_value = get_MSG_DATA

        regValue = leftShift(write_MSG_DATA_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_DATA_value = &H0
        flag_MSG_DATA        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_vect_ctl_12
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MASK_BIT                                   [0:0]            get_MASK_BIT
''                                                             set_MASK_BIT
''                                                             read_MASK_BIT
''                                                             write_MASK_BIT
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_12
    Private write_MASK_BIT_value
    Private read_MASK_BIT_value
    Private flag_MASK_BIT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hcc
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MASK_BIT
        get_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let set_MASK_BIT(aData)
        write_MASK_BIT_value = aData
        flag_MASK_BIT        = &H1
    End Property

    Property Get read_MASK_BIT
        read
        read_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let write_MASK_BIT(aData)
        set_MASK_BIT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

    End Sub

    Sub write
        If flag_MASK_BIT = &H0 Then read
        If flag_MASK_BIT = &H0 Then write_MASK_BIT_value = get_MASK_BIT

        regValue = leftShift((write_MASK_BIT_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MASK_BIT_value = &H0
        flag_MASK_BIT        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_addr_13
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_ADDR                                   [31:0]           get_MSG_ADDR
''                                                             set_MSG_ADDR
''                                                             read_MSG_ADDR
''                                                             write_MSG_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_addr_13
    Private write_MSG_ADDR_value
    Private read_MSG_ADDR_value
    Private flag_MSG_ADDR

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

    Property Get get_MSG_ADDR
        get_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let set_MSG_ADDR(aData)
        write_MSG_ADDR_value = aData
        flag_MSG_ADDR        = &H1
    End Property

    Property Get read_MSG_ADDR
        read
        read_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let write_MSG_ADDR(aData)
        set_MSG_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_ADDR = &H0 Then read
        If flag_MSG_ADDR = &H0 Then write_MSG_ADDR_value = get_MSG_ADDR

        regValue = leftShift(write_MSG_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_ADDR_value = &H0
        flag_MSG_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_uppr_addr_13
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_UPPR_ADDR                              [31:0]           get_MSG_UPPR_ADDR
''                                                             set_MSG_UPPR_ADDR
''                                                             read_MSG_UPPR_ADDR
''                                                             write_MSG_UPPR_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_13
    Private write_MSG_UPPR_ADDR_value
    Private read_MSG_UPPR_ADDR_value
    Private flag_MSG_UPPR_ADDR

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

    Property Get get_MSG_UPPR_ADDR
        get_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let set_MSG_UPPR_ADDR(aData)
        write_MSG_UPPR_ADDR_value = aData
        flag_MSG_UPPR_ADDR        = &H1
    End Property

    Property Get read_MSG_UPPR_ADDR
        read
        read_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let write_MSG_UPPR_ADDR(aData)
        set_MSG_UPPR_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_UPPR_ADDR = &H0 Then read
        If flag_MSG_UPPR_ADDR = &H0 Then write_MSG_UPPR_ADDR_value = get_MSG_UPPR_ADDR

        regValue = leftShift(write_MSG_UPPR_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_UPPR_ADDR_value = &H0
        flag_MSG_UPPR_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_data_13
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_DATA                                   [31:0]           get_MSG_DATA
''                                                             set_MSG_DATA
''                                                             read_MSG_DATA
''                                                             write_MSG_DATA
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_data_13
    Private write_MSG_DATA_value
    Private read_MSG_DATA_value
    Private flag_MSG_DATA

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

    Property Get get_MSG_DATA
        get_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let set_MSG_DATA(aData)
        write_MSG_DATA_value = aData
        flag_MSG_DATA        = &H1
    End Property

    Property Get read_MSG_DATA
        read
        read_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let write_MSG_DATA(aData)
        set_MSG_DATA = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

    End Sub

    Sub write
        If flag_MSG_DATA = &H0 Then read
        If flag_MSG_DATA = &H0 Then write_MSG_DATA_value = get_MSG_DATA

        regValue = leftShift(write_MSG_DATA_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_DATA_value = &H0
        flag_MSG_DATA        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_vect_ctl_13
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MASK_BIT                                   [0:0]            get_MASK_BIT
''                                                             set_MASK_BIT
''                                                             read_MASK_BIT
''                                                             write_MASK_BIT
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_13
    Private write_MASK_BIT_value
    Private read_MASK_BIT_value
    Private flag_MASK_BIT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hdc
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MASK_BIT
        get_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let set_MASK_BIT(aData)
        write_MASK_BIT_value = aData
        flag_MASK_BIT        = &H1
    End Property

    Property Get read_MASK_BIT
        read
        read_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let write_MASK_BIT(aData)
        set_MASK_BIT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

    End Sub

    Sub write
        If flag_MASK_BIT = &H0 Then read
        If flag_MASK_BIT = &H0 Then write_MASK_BIT_value = get_MASK_BIT

        regValue = leftShift((write_MASK_BIT_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MASK_BIT_value = &H0
        flag_MASK_BIT        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_addr_14
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_ADDR                                   [31:0]           get_MSG_ADDR
''                                                             set_MSG_ADDR
''                                                             read_MSG_ADDR
''                                                             write_MSG_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_addr_14
    Private write_MSG_ADDR_value
    Private read_MSG_ADDR_value
    Private flag_MSG_ADDR

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

    Property Get get_MSG_ADDR
        get_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let set_MSG_ADDR(aData)
        write_MSG_ADDR_value = aData
        flag_MSG_ADDR        = &H1
    End Property

    Property Get read_MSG_ADDR
        read
        read_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let write_MSG_ADDR(aData)
        set_MSG_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_ADDR = &H0 Then read
        If flag_MSG_ADDR = &H0 Then write_MSG_ADDR_value = get_MSG_ADDR

        regValue = leftShift(write_MSG_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_ADDR_value = &H0
        flag_MSG_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_uppr_addr_14
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_UPPR_ADDR                              [31:0]           get_MSG_UPPR_ADDR
''                                                             set_MSG_UPPR_ADDR
''                                                             read_MSG_UPPR_ADDR
''                                                             write_MSG_UPPR_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_14
    Private write_MSG_UPPR_ADDR_value
    Private read_MSG_UPPR_ADDR_value
    Private flag_MSG_UPPR_ADDR

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

    Property Get get_MSG_UPPR_ADDR
        get_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let set_MSG_UPPR_ADDR(aData)
        write_MSG_UPPR_ADDR_value = aData
        flag_MSG_UPPR_ADDR        = &H1
    End Property

    Property Get read_MSG_UPPR_ADDR
        read
        read_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let write_MSG_UPPR_ADDR(aData)
        set_MSG_UPPR_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_UPPR_ADDR = &H0 Then read
        If flag_MSG_UPPR_ADDR = &H0 Then write_MSG_UPPR_ADDR_value = get_MSG_UPPR_ADDR

        regValue = leftShift(write_MSG_UPPR_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_UPPR_ADDR_value = &H0
        flag_MSG_UPPR_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_data_14
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_DATA                                   [31:0]           get_MSG_DATA
''                                                             set_MSG_DATA
''                                                             read_MSG_DATA
''                                                             write_MSG_DATA
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_data_14
    Private write_MSG_DATA_value
    Private read_MSG_DATA_value
    Private flag_MSG_DATA

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

    Property Get get_MSG_DATA
        get_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let set_MSG_DATA(aData)
        write_MSG_DATA_value = aData
        flag_MSG_DATA        = &H1
    End Property

    Property Get read_MSG_DATA
        read
        read_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let write_MSG_DATA(aData)
        set_MSG_DATA = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

    End Sub

    Sub write
        If flag_MSG_DATA = &H0 Then read
        If flag_MSG_DATA = &H0 Then write_MSG_DATA_value = get_MSG_DATA

        regValue = leftShift(write_MSG_DATA_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_DATA_value = &H0
        flag_MSG_DATA        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_vect_ctl_14
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MASK_BIT                                   [0:0]            get_MASK_BIT
''                                                             set_MASK_BIT
''                                                             read_MASK_BIT
''                                                             write_MASK_BIT
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_14
    Private write_MASK_BIT_value
    Private read_MASK_BIT_value
    Private flag_MASK_BIT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hec
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MASK_BIT
        get_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let set_MASK_BIT(aData)
        write_MASK_BIT_value = aData
        flag_MASK_BIT        = &H1
    End Property

    Property Get read_MASK_BIT
        read
        read_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let write_MASK_BIT(aData)
        set_MASK_BIT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

    End Sub

    Sub write
        If flag_MASK_BIT = &H0 Then read
        If flag_MASK_BIT = &H0 Then write_MASK_BIT_value = get_MASK_BIT

        regValue = leftShift((write_MASK_BIT_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MASK_BIT_value = &H0
        flag_MASK_BIT        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_addr_15
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_ADDR                                   [31:0]           get_MSG_ADDR
''                                                             set_MSG_ADDR
''                                                             read_MSG_ADDR
''                                                             write_MSG_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_addr_15
    Private write_MSG_ADDR_value
    Private read_MSG_ADDR_value
    Private flag_MSG_ADDR

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

    Property Get get_MSG_ADDR
        get_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let set_MSG_ADDR(aData)
        write_MSG_ADDR_value = aData
        flag_MSG_ADDR        = &H1
    End Property

    Property Get read_MSG_ADDR
        read
        read_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let write_MSG_ADDR(aData)
        set_MSG_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_ADDR = &H0 Then read
        If flag_MSG_ADDR = &H0 Then write_MSG_ADDR_value = get_MSG_ADDR

        regValue = leftShift(write_MSG_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_ADDR_value = &H0
        flag_MSG_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_uppr_addr_15
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_UPPR_ADDR                              [31:0]           get_MSG_UPPR_ADDR
''                                                             set_MSG_UPPR_ADDR
''                                                             read_MSG_UPPR_ADDR
''                                                             write_MSG_UPPR_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_15
    Private write_MSG_UPPR_ADDR_value
    Private read_MSG_UPPR_ADDR_value
    Private flag_MSG_UPPR_ADDR

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

    Property Get get_MSG_UPPR_ADDR
        get_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let set_MSG_UPPR_ADDR(aData)
        write_MSG_UPPR_ADDR_value = aData
        flag_MSG_UPPR_ADDR        = &H1
    End Property

    Property Get read_MSG_UPPR_ADDR
        read
        read_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let write_MSG_UPPR_ADDR(aData)
        set_MSG_UPPR_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_UPPR_ADDR = &H0 Then read
        If flag_MSG_UPPR_ADDR = &H0 Then write_MSG_UPPR_ADDR_value = get_MSG_UPPR_ADDR

        regValue = leftShift(write_MSG_UPPR_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_UPPR_ADDR_value = &H0
        flag_MSG_UPPR_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_data_15
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_DATA                                   [31:0]           get_MSG_DATA
''                                                             set_MSG_DATA
''                                                             read_MSG_DATA
''                                                             write_MSG_DATA
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_data_15
    Private write_MSG_DATA_value
    Private read_MSG_DATA_value
    Private flag_MSG_DATA

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

    Property Get get_MSG_DATA
        get_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let set_MSG_DATA(aData)
        write_MSG_DATA_value = aData
        flag_MSG_DATA        = &H1
    End Property

    Property Get read_MSG_DATA
        read
        read_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let write_MSG_DATA(aData)
        set_MSG_DATA = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

    End Sub

    Sub write
        If flag_MSG_DATA = &H0 Then read
        If flag_MSG_DATA = &H0 Then write_MSG_DATA_value = get_MSG_DATA

        regValue = leftShift(write_MSG_DATA_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_DATA_value = &H0
        flag_MSG_DATA        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_vect_ctl_15
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MASK_BIT                                   [0:0]            get_MASK_BIT
''                                                             set_MASK_BIT
''                                                             read_MASK_BIT
''                                                             write_MASK_BIT
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_15
    Private write_MASK_BIT_value
    Private read_MASK_BIT_value
    Private flag_MASK_BIT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hfc
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MASK_BIT
        get_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let set_MASK_BIT(aData)
        write_MASK_BIT_value = aData
        flag_MASK_BIT        = &H1
    End Property

    Property Get read_MASK_BIT
        read
        read_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let write_MASK_BIT(aData)
        set_MASK_BIT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

    End Sub

    Sub write
        If flag_MASK_BIT = &H0 Then read
        If flag_MASK_BIT = &H0 Then write_MASK_BIT_value = get_MASK_BIT

        regValue = leftShift((write_MASK_BIT_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MASK_BIT_value = &H0
        flag_MASK_BIT        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_addr_16
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_ADDR                                   [31:0]           get_MSG_ADDR
''                                                             set_MSG_ADDR
''                                                             read_MSG_ADDR
''                                                             write_MSG_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_addr_16
    Private write_MSG_ADDR_value
    Private read_MSG_ADDR_value
    Private flag_MSG_ADDR

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

    Property Get get_MSG_ADDR
        get_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let set_MSG_ADDR(aData)
        write_MSG_ADDR_value = aData
        flag_MSG_ADDR        = &H1
    End Property

    Property Get read_MSG_ADDR
        read
        read_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let write_MSG_ADDR(aData)
        set_MSG_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_ADDR = &H0 Then read
        If flag_MSG_ADDR = &H0 Then write_MSG_ADDR_value = get_MSG_ADDR

        regValue = leftShift(write_MSG_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_ADDR_value = &H0
        flag_MSG_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_uppr_addr_16
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_UPPR_ADDR                              [31:0]           get_MSG_UPPR_ADDR
''                                                             set_MSG_UPPR_ADDR
''                                                             read_MSG_UPPR_ADDR
''                                                             write_MSG_UPPR_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_16
    Private write_MSG_UPPR_ADDR_value
    Private read_MSG_UPPR_ADDR_value
    Private flag_MSG_UPPR_ADDR

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

    Property Get get_MSG_UPPR_ADDR
        get_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let set_MSG_UPPR_ADDR(aData)
        write_MSG_UPPR_ADDR_value = aData
        flag_MSG_UPPR_ADDR        = &H1
    End Property

    Property Get read_MSG_UPPR_ADDR
        read
        read_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let write_MSG_UPPR_ADDR(aData)
        set_MSG_UPPR_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_UPPR_ADDR = &H0 Then read
        If flag_MSG_UPPR_ADDR = &H0 Then write_MSG_UPPR_ADDR_value = get_MSG_UPPR_ADDR

        regValue = leftShift(write_MSG_UPPR_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_UPPR_ADDR_value = &H0
        flag_MSG_UPPR_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_data_16
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_DATA                                   [31:0]           get_MSG_DATA
''                                                             set_MSG_DATA
''                                                             read_MSG_DATA
''                                                             write_MSG_DATA
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_data_16
    Private write_MSG_DATA_value
    Private read_MSG_DATA_value
    Private flag_MSG_DATA

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

    Property Get get_MSG_DATA
        get_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let set_MSG_DATA(aData)
        write_MSG_DATA_value = aData
        flag_MSG_DATA        = &H1
    End Property

    Property Get read_MSG_DATA
        read
        read_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let write_MSG_DATA(aData)
        set_MSG_DATA = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

    End Sub

    Sub write
        If flag_MSG_DATA = &H0 Then read
        If flag_MSG_DATA = &H0 Then write_MSG_DATA_value = get_MSG_DATA

        regValue = leftShift(write_MSG_DATA_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_DATA_value = &H0
        flag_MSG_DATA        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_vect_ctl_16
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MASK_BIT                                   [0:0]            get_MASK_BIT
''                                                             set_MASK_BIT
''                                                             read_MASK_BIT
''                                                             write_MASK_BIT
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_16
    Private write_MASK_BIT_value
    Private read_MASK_BIT_value
    Private flag_MASK_BIT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H10c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MASK_BIT
        get_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let set_MASK_BIT(aData)
        write_MASK_BIT_value = aData
        flag_MASK_BIT        = &H1
    End Property

    Property Get read_MASK_BIT
        read
        read_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let write_MASK_BIT(aData)
        set_MASK_BIT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

    End Sub

    Sub write
        If flag_MASK_BIT = &H0 Then read
        If flag_MASK_BIT = &H0 Then write_MASK_BIT_value = get_MASK_BIT

        regValue = leftShift((write_MASK_BIT_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MASK_BIT_value = &H0
        flag_MASK_BIT        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_addr_17
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_ADDR                                   [31:0]           get_MSG_ADDR
''                                                             set_MSG_ADDR
''                                                             read_MSG_ADDR
''                                                             write_MSG_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_addr_17
    Private write_MSG_ADDR_value
    Private read_MSG_ADDR_value
    Private flag_MSG_ADDR

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

    Property Get get_MSG_ADDR
        get_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let set_MSG_ADDR(aData)
        write_MSG_ADDR_value = aData
        flag_MSG_ADDR        = &H1
    End Property

    Property Get read_MSG_ADDR
        read
        read_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let write_MSG_ADDR(aData)
        set_MSG_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_ADDR = &H0 Then read
        If flag_MSG_ADDR = &H0 Then write_MSG_ADDR_value = get_MSG_ADDR

        regValue = leftShift(write_MSG_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_ADDR_value = &H0
        flag_MSG_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_uppr_addr_17
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_UPPR_ADDR                              [31:0]           get_MSG_UPPR_ADDR
''                                                             set_MSG_UPPR_ADDR
''                                                             read_MSG_UPPR_ADDR
''                                                             write_MSG_UPPR_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_17
    Private write_MSG_UPPR_ADDR_value
    Private read_MSG_UPPR_ADDR_value
    Private flag_MSG_UPPR_ADDR

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

    Property Get get_MSG_UPPR_ADDR
        get_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let set_MSG_UPPR_ADDR(aData)
        write_MSG_UPPR_ADDR_value = aData
        flag_MSG_UPPR_ADDR        = &H1
    End Property

    Property Get read_MSG_UPPR_ADDR
        read
        read_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let write_MSG_UPPR_ADDR(aData)
        set_MSG_UPPR_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_UPPR_ADDR = &H0 Then read
        If flag_MSG_UPPR_ADDR = &H0 Then write_MSG_UPPR_ADDR_value = get_MSG_UPPR_ADDR

        regValue = leftShift(write_MSG_UPPR_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_UPPR_ADDR_value = &H0
        flag_MSG_UPPR_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_data_17
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_DATA                                   [31:0]           get_MSG_DATA
''                                                             set_MSG_DATA
''                                                             read_MSG_DATA
''                                                             write_MSG_DATA
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_data_17
    Private write_MSG_DATA_value
    Private read_MSG_DATA_value
    Private flag_MSG_DATA

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

    Property Get get_MSG_DATA
        get_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let set_MSG_DATA(aData)
        write_MSG_DATA_value = aData
        flag_MSG_DATA        = &H1
    End Property

    Property Get read_MSG_DATA
        read
        read_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let write_MSG_DATA(aData)
        set_MSG_DATA = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

    End Sub

    Sub write
        If flag_MSG_DATA = &H0 Then read
        If flag_MSG_DATA = &H0 Then write_MSG_DATA_value = get_MSG_DATA

        regValue = leftShift(write_MSG_DATA_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_DATA_value = &H0
        flag_MSG_DATA        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_vect_ctl_17
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MASK_BIT                                   [0:0]            get_MASK_BIT
''                                                             set_MASK_BIT
''                                                             read_MASK_BIT
''                                                             write_MASK_BIT
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_17
    Private write_MASK_BIT_value
    Private read_MASK_BIT_value
    Private flag_MASK_BIT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H11c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MASK_BIT
        get_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let set_MASK_BIT(aData)
        write_MASK_BIT_value = aData
        flag_MASK_BIT        = &H1
    End Property

    Property Get read_MASK_BIT
        read
        read_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let write_MASK_BIT(aData)
        set_MASK_BIT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

    End Sub

    Sub write
        If flag_MASK_BIT = &H0 Then read
        If flag_MASK_BIT = &H0 Then write_MASK_BIT_value = get_MASK_BIT

        regValue = leftShift((write_MASK_BIT_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MASK_BIT_value = &H0
        flag_MASK_BIT        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_addr_18
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_ADDR                                   [31:0]           get_MSG_ADDR
''                                                             set_MSG_ADDR
''                                                             read_MSG_ADDR
''                                                             write_MSG_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_addr_18
    Private write_MSG_ADDR_value
    Private read_MSG_ADDR_value
    Private flag_MSG_ADDR

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

    Property Get get_MSG_ADDR
        get_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let set_MSG_ADDR(aData)
        write_MSG_ADDR_value = aData
        flag_MSG_ADDR        = &H1
    End Property

    Property Get read_MSG_ADDR
        read
        read_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let write_MSG_ADDR(aData)
        set_MSG_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_ADDR = &H0 Then read
        If flag_MSG_ADDR = &H0 Then write_MSG_ADDR_value = get_MSG_ADDR

        regValue = leftShift(write_MSG_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_ADDR_value = &H0
        flag_MSG_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_uppr_addr_18
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_UPPR_ADDR                              [31:0]           get_MSG_UPPR_ADDR
''                                                             set_MSG_UPPR_ADDR
''                                                             read_MSG_UPPR_ADDR
''                                                             write_MSG_UPPR_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_18
    Private write_MSG_UPPR_ADDR_value
    Private read_MSG_UPPR_ADDR_value
    Private flag_MSG_UPPR_ADDR

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

    Property Get get_MSG_UPPR_ADDR
        get_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let set_MSG_UPPR_ADDR(aData)
        write_MSG_UPPR_ADDR_value = aData
        flag_MSG_UPPR_ADDR        = &H1
    End Property

    Property Get read_MSG_UPPR_ADDR
        read
        read_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let write_MSG_UPPR_ADDR(aData)
        set_MSG_UPPR_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_UPPR_ADDR = &H0 Then read
        If flag_MSG_UPPR_ADDR = &H0 Then write_MSG_UPPR_ADDR_value = get_MSG_UPPR_ADDR

        regValue = leftShift(write_MSG_UPPR_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_UPPR_ADDR_value = &H0
        flag_MSG_UPPR_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_data_18
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_DATA                                   [31:0]           get_MSG_DATA
''                                                             set_MSG_DATA
''                                                             read_MSG_DATA
''                                                             write_MSG_DATA
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_data_18
    Private write_MSG_DATA_value
    Private read_MSG_DATA_value
    Private flag_MSG_DATA

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

    Property Get get_MSG_DATA
        get_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let set_MSG_DATA(aData)
        write_MSG_DATA_value = aData
        flag_MSG_DATA        = &H1
    End Property

    Property Get read_MSG_DATA
        read
        read_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let write_MSG_DATA(aData)
        set_MSG_DATA = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

    End Sub

    Sub write
        If flag_MSG_DATA = &H0 Then read
        If flag_MSG_DATA = &H0 Then write_MSG_DATA_value = get_MSG_DATA

        regValue = leftShift(write_MSG_DATA_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_DATA_value = &H0
        flag_MSG_DATA        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_vect_ctl_18
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MASK_BIT                                   [0:0]            get_MASK_BIT
''                                                             set_MASK_BIT
''                                                             read_MASK_BIT
''                                                             write_MASK_BIT
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_18
    Private write_MASK_BIT_value
    Private read_MASK_BIT_value
    Private flag_MASK_BIT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H12c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MASK_BIT
        get_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let set_MASK_BIT(aData)
        write_MASK_BIT_value = aData
        flag_MASK_BIT        = &H1
    End Property

    Property Get read_MASK_BIT
        read
        read_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let write_MASK_BIT(aData)
        set_MASK_BIT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

    End Sub

    Sub write
        If flag_MASK_BIT = &H0 Then read
        If flag_MASK_BIT = &H0 Then write_MASK_BIT_value = get_MASK_BIT

        regValue = leftShift((write_MASK_BIT_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MASK_BIT_value = &H0
        flag_MASK_BIT        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_addr_19
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_ADDR                                   [31:0]           get_MSG_ADDR
''                                                             set_MSG_ADDR
''                                                             read_MSG_ADDR
''                                                             write_MSG_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_addr_19
    Private write_MSG_ADDR_value
    Private read_MSG_ADDR_value
    Private flag_MSG_ADDR

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

    Property Get get_MSG_ADDR
        get_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let set_MSG_ADDR(aData)
        write_MSG_ADDR_value = aData
        flag_MSG_ADDR        = &H1
    End Property

    Property Get read_MSG_ADDR
        read
        read_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let write_MSG_ADDR(aData)
        set_MSG_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_ADDR = &H0 Then read
        If flag_MSG_ADDR = &H0 Then write_MSG_ADDR_value = get_MSG_ADDR

        regValue = leftShift(write_MSG_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_ADDR_value = &H0
        flag_MSG_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_uppr_addr_19
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_UPPR_ADDR                              [31:0]           get_MSG_UPPR_ADDR
''                                                             set_MSG_UPPR_ADDR
''                                                             read_MSG_UPPR_ADDR
''                                                             write_MSG_UPPR_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_19
    Private write_MSG_UPPR_ADDR_value
    Private read_MSG_UPPR_ADDR_value
    Private flag_MSG_UPPR_ADDR

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

    Property Get get_MSG_UPPR_ADDR
        get_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let set_MSG_UPPR_ADDR(aData)
        write_MSG_UPPR_ADDR_value = aData
        flag_MSG_UPPR_ADDR        = &H1
    End Property

    Property Get read_MSG_UPPR_ADDR
        read
        read_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let write_MSG_UPPR_ADDR(aData)
        set_MSG_UPPR_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_UPPR_ADDR = &H0 Then read
        If flag_MSG_UPPR_ADDR = &H0 Then write_MSG_UPPR_ADDR_value = get_MSG_UPPR_ADDR

        regValue = leftShift(write_MSG_UPPR_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_UPPR_ADDR_value = &H0
        flag_MSG_UPPR_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_data_19
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_DATA                                   [31:0]           get_MSG_DATA
''                                                             set_MSG_DATA
''                                                             read_MSG_DATA
''                                                             write_MSG_DATA
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_data_19
    Private write_MSG_DATA_value
    Private read_MSG_DATA_value
    Private flag_MSG_DATA

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

    Property Get get_MSG_DATA
        get_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let set_MSG_DATA(aData)
        write_MSG_DATA_value = aData
        flag_MSG_DATA        = &H1
    End Property

    Property Get read_MSG_DATA
        read
        read_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let write_MSG_DATA(aData)
        set_MSG_DATA = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

    End Sub

    Sub write
        If flag_MSG_DATA = &H0 Then read
        If flag_MSG_DATA = &H0 Then write_MSG_DATA_value = get_MSG_DATA

        regValue = leftShift(write_MSG_DATA_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_DATA_value = &H0
        flag_MSG_DATA        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_vect_ctl_19
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MASK_BIT                                   [0:0]            get_MASK_BIT
''                                                             set_MASK_BIT
''                                                             read_MASK_BIT
''                                                             write_MASK_BIT
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_19
    Private write_MASK_BIT_value
    Private read_MASK_BIT_value
    Private flag_MASK_BIT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H13c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MASK_BIT
        get_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let set_MASK_BIT(aData)
        write_MASK_BIT_value = aData
        flag_MASK_BIT        = &H1
    End Property

    Property Get read_MASK_BIT
        read
        read_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let write_MASK_BIT(aData)
        set_MASK_BIT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

    End Sub

    Sub write
        If flag_MASK_BIT = &H0 Then read
        If flag_MASK_BIT = &H0 Then write_MASK_BIT_value = get_MASK_BIT

        regValue = leftShift((write_MASK_BIT_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MASK_BIT_value = &H0
        flag_MASK_BIT        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_addr_20
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_ADDR                                   [31:0]           get_MSG_ADDR
''                                                             set_MSG_ADDR
''                                                             read_MSG_ADDR
''                                                             write_MSG_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_addr_20
    Private write_MSG_ADDR_value
    Private read_MSG_ADDR_value
    Private flag_MSG_ADDR

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

    Property Get get_MSG_ADDR
        get_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let set_MSG_ADDR(aData)
        write_MSG_ADDR_value = aData
        flag_MSG_ADDR        = &H1
    End Property

    Property Get read_MSG_ADDR
        read
        read_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let write_MSG_ADDR(aData)
        set_MSG_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_ADDR = &H0 Then read
        If flag_MSG_ADDR = &H0 Then write_MSG_ADDR_value = get_MSG_ADDR

        regValue = leftShift(write_MSG_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_ADDR_value = &H0
        flag_MSG_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_uppr_addr_20
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_UPPR_ADDR                              [31:0]           get_MSG_UPPR_ADDR
''                                                             set_MSG_UPPR_ADDR
''                                                             read_MSG_UPPR_ADDR
''                                                             write_MSG_UPPR_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_20
    Private write_MSG_UPPR_ADDR_value
    Private read_MSG_UPPR_ADDR_value
    Private flag_MSG_UPPR_ADDR

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

    Property Get get_MSG_UPPR_ADDR
        get_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let set_MSG_UPPR_ADDR(aData)
        write_MSG_UPPR_ADDR_value = aData
        flag_MSG_UPPR_ADDR        = &H1
    End Property

    Property Get read_MSG_UPPR_ADDR
        read
        read_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let write_MSG_UPPR_ADDR(aData)
        set_MSG_UPPR_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_UPPR_ADDR = &H0 Then read
        If flag_MSG_UPPR_ADDR = &H0 Then write_MSG_UPPR_ADDR_value = get_MSG_UPPR_ADDR

        regValue = leftShift(write_MSG_UPPR_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_UPPR_ADDR_value = &H0
        flag_MSG_UPPR_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_data_20
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_DATA                                   [31:0]           get_MSG_DATA
''                                                             set_MSG_DATA
''                                                             read_MSG_DATA
''                                                             write_MSG_DATA
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_data_20
    Private write_MSG_DATA_value
    Private read_MSG_DATA_value
    Private flag_MSG_DATA

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

    Property Get get_MSG_DATA
        get_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let set_MSG_DATA(aData)
        write_MSG_DATA_value = aData
        flag_MSG_DATA        = &H1
    End Property

    Property Get read_MSG_DATA
        read
        read_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let write_MSG_DATA(aData)
        set_MSG_DATA = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

    End Sub

    Sub write
        If flag_MSG_DATA = &H0 Then read
        If flag_MSG_DATA = &H0 Then write_MSG_DATA_value = get_MSG_DATA

        regValue = leftShift(write_MSG_DATA_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_DATA_value = &H0
        flag_MSG_DATA        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_vect_ctl_20
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MASK_BIT                                   [0:0]            get_MASK_BIT
''                                                             set_MASK_BIT
''                                                             read_MASK_BIT
''                                                             write_MASK_BIT
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_20
    Private write_MASK_BIT_value
    Private read_MASK_BIT_value
    Private flag_MASK_BIT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H14c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MASK_BIT
        get_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let set_MASK_BIT(aData)
        write_MASK_BIT_value = aData
        flag_MASK_BIT        = &H1
    End Property

    Property Get read_MASK_BIT
        read
        read_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let write_MASK_BIT(aData)
        set_MASK_BIT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

    End Sub

    Sub write
        If flag_MASK_BIT = &H0 Then read
        If flag_MASK_BIT = &H0 Then write_MASK_BIT_value = get_MASK_BIT

        regValue = leftShift((write_MASK_BIT_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MASK_BIT_value = &H0
        flag_MASK_BIT        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_addr_21
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_ADDR                                   [31:0]           get_MSG_ADDR
''                                                             set_MSG_ADDR
''                                                             read_MSG_ADDR
''                                                             write_MSG_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_addr_21
    Private write_MSG_ADDR_value
    Private read_MSG_ADDR_value
    Private flag_MSG_ADDR

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

    Property Get get_MSG_ADDR
        get_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let set_MSG_ADDR(aData)
        write_MSG_ADDR_value = aData
        flag_MSG_ADDR        = &H1
    End Property

    Property Get read_MSG_ADDR
        read
        read_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let write_MSG_ADDR(aData)
        set_MSG_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_ADDR = &H0 Then read
        If flag_MSG_ADDR = &H0 Then write_MSG_ADDR_value = get_MSG_ADDR

        regValue = leftShift(write_MSG_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_ADDR_value = &H0
        flag_MSG_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_uppr_addr_21
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_UPPR_ADDR                              [31:0]           get_MSG_UPPR_ADDR
''                                                             set_MSG_UPPR_ADDR
''                                                             read_MSG_UPPR_ADDR
''                                                             write_MSG_UPPR_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_21
    Private write_MSG_UPPR_ADDR_value
    Private read_MSG_UPPR_ADDR_value
    Private flag_MSG_UPPR_ADDR

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

    Property Get get_MSG_UPPR_ADDR
        get_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let set_MSG_UPPR_ADDR(aData)
        write_MSG_UPPR_ADDR_value = aData
        flag_MSG_UPPR_ADDR        = &H1
    End Property

    Property Get read_MSG_UPPR_ADDR
        read
        read_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let write_MSG_UPPR_ADDR(aData)
        set_MSG_UPPR_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_UPPR_ADDR = &H0 Then read
        If flag_MSG_UPPR_ADDR = &H0 Then write_MSG_UPPR_ADDR_value = get_MSG_UPPR_ADDR

        regValue = leftShift(write_MSG_UPPR_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_UPPR_ADDR_value = &H0
        flag_MSG_UPPR_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_data_21
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_DATA                                   [31:0]           get_MSG_DATA
''                                                             set_MSG_DATA
''                                                             read_MSG_DATA
''                                                             write_MSG_DATA
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_data_21
    Private write_MSG_DATA_value
    Private read_MSG_DATA_value
    Private flag_MSG_DATA

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

    Property Get get_MSG_DATA
        get_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let set_MSG_DATA(aData)
        write_MSG_DATA_value = aData
        flag_MSG_DATA        = &H1
    End Property

    Property Get read_MSG_DATA
        read
        read_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let write_MSG_DATA(aData)
        set_MSG_DATA = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

    End Sub

    Sub write
        If flag_MSG_DATA = &H0 Then read
        If flag_MSG_DATA = &H0 Then write_MSG_DATA_value = get_MSG_DATA

        regValue = leftShift(write_MSG_DATA_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_DATA_value = &H0
        flag_MSG_DATA        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_vect_ctl_21
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MASK_BIT                                   [0:0]            get_MASK_BIT
''                                                             set_MASK_BIT
''                                                             read_MASK_BIT
''                                                             write_MASK_BIT
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_21
    Private write_MASK_BIT_value
    Private read_MASK_BIT_value
    Private flag_MASK_BIT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H15c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MASK_BIT
        get_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let set_MASK_BIT(aData)
        write_MASK_BIT_value = aData
        flag_MASK_BIT        = &H1
    End Property

    Property Get read_MASK_BIT
        read
        read_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let write_MASK_BIT(aData)
        set_MASK_BIT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

    End Sub

    Sub write
        If flag_MASK_BIT = &H0 Then read
        If flag_MASK_BIT = &H0 Then write_MASK_BIT_value = get_MASK_BIT

        regValue = leftShift((write_MASK_BIT_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MASK_BIT_value = &H0
        flag_MASK_BIT        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_addr_22
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_ADDR                                   [31:0]           get_MSG_ADDR
''                                                             set_MSG_ADDR
''                                                             read_MSG_ADDR
''                                                             write_MSG_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_addr_22
    Private write_MSG_ADDR_value
    Private read_MSG_ADDR_value
    Private flag_MSG_ADDR

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

    Property Get get_MSG_ADDR
        get_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let set_MSG_ADDR(aData)
        write_MSG_ADDR_value = aData
        flag_MSG_ADDR        = &H1
    End Property

    Property Get read_MSG_ADDR
        read
        read_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let write_MSG_ADDR(aData)
        set_MSG_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_ADDR = &H0 Then read
        If flag_MSG_ADDR = &H0 Then write_MSG_ADDR_value = get_MSG_ADDR

        regValue = leftShift(write_MSG_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_ADDR_value = &H0
        flag_MSG_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_uppr_addr_22
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_UPPR_ADDR                              [31:0]           get_MSG_UPPR_ADDR
''                                                             set_MSG_UPPR_ADDR
''                                                             read_MSG_UPPR_ADDR
''                                                             write_MSG_UPPR_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_22
    Private write_MSG_UPPR_ADDR_value
    Private read_MSG_UPPR_ADDR_value
    Private flag_MSG_UPPR_ADDR

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

    Property Get get_MSG_UPPR_ADDR
        get_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let set_MSG_UPPR_ADDR(aData)
        write_MSG_UPPR_ADDR_value = aData
        flag_MSG_UPPR_ADDR        = &H1
    End Property

    Property Get read_MSG_UPPR_ADDR
        read
        read_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let write_MSG_UPPR_ADDR(aData)
        set_MSG_UPPR_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_UPPR_ADDR = &H0 Then read
        If flag_MSG_UPPR_ADDR = &H0 Then write_MSG_UPPR_ADDR_value = get_MSG_UPPR_ADDR

        regValue = leftShift(write_MSG_UPPR_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_UPPR_ADDR_value = &H0
        flag_MSG_UPPR_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_data_22
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_DATA                                   [31:0]           get_MSG_DATA
''                                                             set_MSG_DATA
''                                                             read_MSG_DATA
''                                                             write_MSG_DATA
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_data_22
    Private write_MSG_DATA_value
    Private read_MSG_DATA_value
    Private flag_MSG_DATA

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

    Property Get get_MSG_DATA
        get_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let set_MSG_DATA(aData)
        write_MSG_DATA_value = aData
        flag_MSG_DATA        = &H1
    End Property

    Property Get read_MSG_DATA
        read
        read_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let write_MSG_DATA(aData)
        set_MSG_DATA = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

    End Sub

    Sub write
        If flag_MSG_DATA = &H0 Then read
        If flag_MSG_DATA = &H0 Then write_MSG_DATA_value = get_MSG_DATA

        regValue = leftShift(write_MSG_DATA_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_DATA_value = &H0
        flag_MSG_DATA        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_vect_ctl_22
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MASK_BIT                                   [0:0]            get_MASK_BIT
''                                                             set_MASK_BIT
''                                                             read_MASK_BIT
''                                                             write_MASK_BIT
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_22
    Private write_MASK_BIT_value
    Private read_MASK_BIT_value
    Private flag_MASK_BIT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H16c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MASK_BIT
        get_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let set_MASK_BIT(aData)
        write_MASK_BIT_value = aData
        flag_MASK_BIT        = &H1
    End Property

    Property Get read_MASK_BIT
        read
        read_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let write_MASK_BIT(aData)
        set_MASK_BIT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

    End Sub

    Sub write
        If flag_MASK_BIT = &H0 Then read
        If flag_MASK_BIT = &H0 Then write_MASK_BIT_value = get_MASK_BIT

        regValue = leftShift((write_MASK_BIT_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MASK_BIT_value = &H0
        flag_MASK_BIT        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_addr_23
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_ADDR                                   [31:0]           get_MSG_ADDR
''                                                             set_MSG_ADDR
''                                                             read_MSG_ADDR
''                                                             write_MSG_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_addr_23
    Private write_MSG_ADDR_value
    Private read_MSG_ADDR_value
    Private flag_MSG_ADDR

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

    Property Get get_MSG_ADDR
        get_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let set_MSG_ADDR(aData)
        write_MSG_ADDR_value = aData
        flag_MSG_ADDR        = &H1
    End Property

    Property Get read_MSG_ADDR
        read
        read_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let write_MSG_ADDR(aData)
        set_MSG_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_ADDR = &H0 Then read
        If flag_MSG_ADDR = &H0 Then write_MSG_ADDR_value = get_MSG_ADDR

        regValue = leftShift(write_MSG_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_ADDR_value = &H0
        flag_MSG_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_uppr_addr_23
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_UPPR_ADDR                              [31:0]           get_MSG_UPPR_ADDR
''                                                             set_MSG_UPPR_ADDR
''                                                             read_MSG_UPPR_ADDR
''                                                             write_MSG_UPPR_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_23
    Private write_MSG_UPPR_ADDR_value
    Private read_MSG_UPPR_ADDR_value
    Private flag_MSG_UPPR_ADDR

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

    Property Get get_MSG_UPPR_ADDR
        get_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let set_MSG_UPPR_ADDR(aData)
        write_MSG_UPPR_ADDR_value = aData
        flag_MSG_UPPR_ADDR        = &H1
    End Property

    Property Get read_MSG_UPPR_ADDR
        read
        read_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let write_MSG_UPPR_ADDR(aData)
        set_MSG_UPPR_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_UPPR_ADDR = &H0 Then read
        If flag_MSG_UPPR_ADDR = &H0 Then write_MSG_UPPR_ADDR_value = get_MSG_UPPR_ADDR

        regValue = leftShift(write_MSG_UPPR_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_UPPR_ADDR_value = &H0
        flag_MSG_UPPR_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_data_23
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_DATA                                   [31:0]           get_MSG_DATA
''                                                             set_MSG_DATA
''                                                             read_MSG_DATA
''                                                             write_MSG_DATA
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_data_23
    Private write_MSG_DATA_value
    Private read_MSG_DATA_value
    Private flag_MSG_DATA

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

    Property Get get_MSG_DATA
        get_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let set_MSG_DATA(aData)
        write_MSG_DATA_value = aData
        flag_MSG_DATA        = &H1
    End Property

    Property Get read_MSG_DATA
        read
        read_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let write_MSG_DATA(aData)
        set_MSG_DATA = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

    End Sub

    Sub write
        If flag_MSG_DATA = &H0 Then read
        If flag_MSG_DATA = &H0 Then write_MSG_DATA_value = get_MSG_DATA

        regValue = leftShift(write_MSG_DATA_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_DATA_value = &H0
        flag_MSG_DATA        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_vect_ctl_23
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MASK_BIT                                   [0:0]            get_MASK_BIT
''                                                             set_MASK_BIT
''                                                             read_MASK_BIT
''                                                             write_MASK_BIT
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_23
    Private write_MASK_BIT_value
    Private read_MASK_BIT_value
    Private flag_MASK_BIT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H17c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MASK_BIT
        get_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let set_MASK_BIT(aData)
        write_MASK_BIT_value = aData
        flag_MASK_BIT        = &H1
    End Property

    Property Get read_MASK_BIT
        read
        read_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let write_MASK_BIT(aData)
        set_MASK_BIT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

    End Sub

    Sub write
        If flag_MASK_BIT = &H0 Then read
        If flag_MASK_BIT = &H0 Then write_MASK_BIT_value = get_MASK_BIT

        regValue = leftShift((write_MASK_BIT_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MASK_BIT_value = &H0
        flag_MASK_BIT        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_addr_24
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_ADDR                                   [31:0]           get_MSG_ADDR
''                                                             set_MSG_ADDR
''                                                             read_MSG_ADDR
''                                                             write_MSG_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_addr_24
    Private write_MSG_ADDR_value
    Private read_MSG_ADDR_value
    Private flag_MSG_ADDR

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

    Property Get get_MSG_ADDR
        get_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let set_MSG_ADDR(aData)
        write_MSG_ADDR_value = aData
        flag_MSG_ADDR        = &H1
    End Property

    Property Get read_MSG_ADDR
        read
        read_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let write_MSG_ADDR(aData)
        set_MSG_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_ADDR = &H0 Then read
        If flag_MSG_ADDR = &H0 Then write_MSG_ADDR_value = get_MSG_ADDR

        regValue = leftShift(write_MSG_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_ADDR_value = &H0
        flag_MSG_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_uppr_addr_24
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_UPPR_ADDR                              [31:0]           get_MSG_UPPR_ADDR
''                                                             set_MSG_UPPR_ADDR
''                                                             read_MSG_UPPR_ADDR
''                                                             write_MSG_UPPR_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_24
    Private write_MSG_UPPR_ADDR_value
    Private read_MSG_UPPR_ADDR_value
    Private flag_MSG_UPPR_ADDR

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

    Property Get get_MSG_UPPR_ADDR
        get_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let set_MSG_UPPR_ADDR(aData)
        write_MSG_UPPR_ADDR_value = aData
        flag_MSG_UPPR_ADDR        = &H1
    End Property

    Property Get read_MSG_UPPR_ADDR
        read
        read_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let write_MSG_UPPR_ADDR(aData)
        set_MSG_UPPR_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_UPPR_ADDR = &H0 Then read
        If flag_MSG_UPPR_ADDR = &H0 Then write_MSG_UPPR_ADDR_value = get_MSG_UPPR_ADDR

        regValue = leftShift(write_MSG_UPPR_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_UPPR_ADDR_value = &H0
        flag_MSG_UPPR_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_data_24
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_DATA                                   [31:0]           get_MSG_DATA
''                                                             set_MSG_DATA
''                                                             read_MSG_DATA
''                                                             write_MSG_DATA
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_data_24
    Private write_MSG_DATA_value
    Private read_MSG_DATA_value
    Private flag_MSG_DATA

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

    Property Get get_MSG_DATA
        get_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let set_MSG_DATA(aData)
        write_MSG_DATA_value = aData
        flag_MSG_DATA        = &H1
    End Property

    Property Get read_MSG_DATA
        read
        read_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let write_MSG_DATA(aData)
        set_MSG_DATA = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

    End Sub

    Sub write
        If flag_MSG_DATA = &H0 Then read
        If flag_MSG_DATA = &H0 Then write_MSG_DATA_value = get_MSG_DATA

        regValue = leftShift(write_MSG_DATA_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_DATA_value = &H0
        flag_MSG_DATA        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_vect_ctl_24
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MASK_BIT                                   [0:0]            get_MASK_BIT
''                                                             set_MASK_BIT
''                                                             read_MASK_BIT
''                                                             write_MASK_BIT
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_24
    Private write_MASK_BIT_value
    Private read_MASK_BIT_value
    Private flag_MASK_BIT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MASK_BIT
        get_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let set_MASK_BIT(aData)
        write_MASK_BIT_value = aData
        flag_MASK_BIT        = &H1
    End Property

    Property Get read_MASK_BIT
        read
        read_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let write_MASK_BIT(aData)
        set_MASK_BIT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

    End Sub

    Sub write
        If flag_MASK_BIT = &H0 Then read
        If flag_MASK_BIT = &H0 Then write_MASK_BIT_value = get_MASK_BIT

        regValue = leftShift((write_MASK_BIT_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MASK_BIT_value = &H0
        flag_MASK_BIT        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_addr_25
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_ADDR                                   [31:0]           get_MSG_ADDR
''                                                             set_MSG_ADDR
''                                                             read_MSG_ADDR
''                                                             write_MSG_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_addr_25
    Private write_MSG_ADDR_value
    Private read_MSG_ADDR_value
    Private flag_MSG_ADDR

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

    Property Get get_MSG_ADDR
        get_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let set_MSG_ADDR(aData)
        write_MSG_ADDR_value = aData
        flag_MSG_ADDR        = &H1
    End Property

    Property Get read_MSG_ADDR
        read
        read_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let write_MSG_ADDR(aData)
        set_MSG_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_ADDR = &H0 Then read
        If flag_MSG_ADDR = &H0 Then write_MSG_ADDR_value = get_MSG_ADDR

        regValue = leftShift(write_MSG_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_ADDR_value = &H0
        flag_MSG_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_uppr_addr_25
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_UPPR_ADDR                              [31:0]           get_MSG_UPPR_ADDR
''                                                             set_MSG_UPPR_ADDR
''                                                             read_MSG_UPPR_ADDR
''                                                             write_MSG_UPPR_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_25
    Private write_MSG_UPPR_ADDR_value
    Private read_MSG_UPPR_ADDR_value
    Private flag_MSG_UPPR_ADDR

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

    Property Get get_MSG_UPPR_ADDR
        get_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let set_MSG_UPPR_ADDR(aData)
        write_MSG_UPPR_ADDR_value = aData
        flag_MSG_UPPR_ADDR        = &H1
    End Property

    Property Get read_MSG_UPPR_ADDR
        read
        read_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let write_MSG_UPPR_ADDR(aData)
        set_MSG_UPPR_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_UPPR_ADDR = &H0 Then read
        If flag_MSG_UPPR_ADDR = &H0 Then write_MSG_UPPR_ADDR_value = get_MSG_UPPR_ADDR

        regValue = leftShift(write_MSG_UPPR_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_UPPR_ADDR_value = &H0
        flag_MSG_UPPR_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_data_25
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_DATA                                   [31:0]           get_MSG_DATA
''                                                             set_MSG_DATA
''                                                             read_MSG_DATA
''                                                             write_MSG_DATA
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_data_25
    Private write_MSG_DATA_value
    Private read_MSG_DATA_value
    Private flag_MSG_DATA

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

    Property Get get_MSG_DATA
        get_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let set_MSG_DATA(aData)
        write_MSG_DATA_value = aData
        flag_MSG_DATA        = &H1
    End Property

    Property Get read_MSG_DATA
        read
        read_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let write_MSG_DATA(aData)
        set_MSG_DATA = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

    End Sub

    Sub write
        If flag_MSG_DATA = &H0 Then read
        If flag_MSG_DATA = &H0 Then write_MSG_DATA_value = get_MSG_DATA

        regValue = leftShift(write_MSG_DATA_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_DATA_value = &H0
        flag_MSG_DATA        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_vect_ctl_25
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MASK_BIT                                   [0:0]            get_MASK_BIT
''                                                             set_MASK_BIT
''                                                             read_MASK_BIT
''                                                             write_MASK_BIT
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_25
    Private write_MASK_BIT_value
    Private read_MASK_BIT_value
    Private flag_MASK_BIT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H19c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MASK_BIT
        get_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let set_MASK_BIT(aData)
        write_MASK_BIT_value = aData
        flag_MASK_BIT        = &H1
    End Property

    Property Get read_MASK_BIT
        read
        read_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let write_MASK_BIT(aData)
        set_MASK_BIT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

    End Sub

    Sub write
        If flag_MASK_BIT = &H0 Then read
        If flag_MASK_BIT = &H0 Then write_MASK_BIT_value = get_MASK_BIT

        regValue = leftShift((write_MASK_BIT_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MASK_BIT_value = &H0
        flag_MASK_BIT        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_addr_26
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_ADDR                                   [31:0]           get_MSG_ADDR
''                                                             set_MSG_ADDR
''                                                             read_MSG_ADDR
''                                                             write_MSG_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_addr_26
    Private write_MSG_ADDR_value
    Private read_MSG_ADDR_value
    Private flag_MSG_ADDR

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

    Property Get get_MSG_ADDR
        get_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let set_MSG_ADDR(aData)
        write_MSG_ADDR_value = aData
        flag_MSG_ADDR        = &H1
    End Property

    Property Get read_MSG_ADDR
        read
        read_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let write_MSG_ADDR(aData)
        set_MSG_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_ADDR = &H0 Then read
        If flag_MSG_ADDR = &H0 Then write_MSG_ADDR_value = get_MSG_ADDR

        regValue = leftShift(write_MSG_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_ADDR_value = &H0
        flag_MSG_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_uppr_addr_26
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_UPPR_ADDR                              [31:0]           get_MSG_UPPR_ADDR
''                                                             set_MSG_UPPR_ADDR
''                                                             read_MSG_UPPR_ADDR
''                                                             write_MSG_UPPR_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_26
    Private write_MSG_UPPR_ADDR_value
    Private read_MSG_UPPR_ADDR_value
    Private flag_MSG_UPPR_ADDR

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

    Property Get get_MSG_UPPR_ADDR
        get_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let set_MSG_UPPR_ADDR(aData)
        write_MSG_UPPR_ADDR_value = aData
        flag_MSG_UPPR_ADDR        = &H1
    End Property

    Property Get read_MSG_UPPR_ADDR
        read
        read_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let write_MSG_UPPR_ADDR(aData)
        set_MSG_UPPR_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_UPPR_ADDR = &H0 Then read
        If flag_MSG_UPPR_ADDR = &H0 Then write_MSG_UPPR_ADDR_value = get_MSG_UPPR_ADDR

        regValue = leftShift(write_MSG_UPPR_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_UPPR_ADDR_value = &H0
        flag_MSG_UPPR_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_data_26
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_DATA                                   [31:0]           get_MSG_DATA
''                                                             set_MSG_DATA
''                                                             read_MSG_DATA
''                                                             write_MSG_DATA
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_data_26
    Private write_MSG_DATA_value
    Private read_MSG_DATA_value
    Private flag_MSG_DATA

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

    Property Get get_MSG_DATA
        get_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let set_MSG_DATA(aData)
        write_MSG_DATA_value = aData
        flag_MSG_DATA        = &H1
    End Property

    Property Get read_MSG_DATA
        read
        read_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let write_MSG_DATA(aData)
        set_MSG_DATA = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

    End Sub

    Sub write
        If flag_MSG_DATA = &H0 Then read
        If flag_MSG_DATA = &H0 Then write_MSG_DATA_value = get_MSG_DATA

        regValue = leftShift(write_MSG_DATA_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_DATA_value = &H0
        flag_MSG_DATA        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_vect_ctl_26
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MASK_BIT                                   [0:0]            get_MASK_BIT
''                                                             set_MASK_BIT
''                                                             read_MASK_BIT
''                                                             write_MASK_BIT
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_26
    Private write_MASK_BIT_value
    Private read_MASK_BIT_value
    Private flag_MASK_BIT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1ac
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MASK_BIT
        get_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let set_MASK_BIT(aData)
        write_MASK_BIT_value = aData
        flag_MASK_BIT        = &H1
    End Property

    Property Get read_MASK_BIT
        read
        read_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let write_MASK_BIT(aData)
        set_MASK_BIT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

    End Sub

    Sub write
        If flag_MASK_BIT = &H0 Then read
        If flag_MASK_BIT = &H0 Then write_MASK_BIT_value = get_MASK_BIT

        regValue = leftShift((write_MASK_BIT_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MASK_BIT_value = &H0
        flag_MASK_BIT        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_addr_27
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_ADDR                                   [31:0]           get_MSG_ADDR
''                                                             set_MSG_ADDR
''                                                             read_MSG_ADDR
''                                                             write_MSG_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_addr_27
    Private write_MSG_ADDR_value
    Private read_MSG_ADDR_value
    Private flag_MSG_ADDR

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

    Property Get get_MSG_ADDR
        get_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let set_MSG_ADDR(aData)
        write_MSG_ADDR_value = aData
        flag_MSG_ADDR        = &H1
    End Property

    Property Get read_MSG_ADDR
        read
        read_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let write_MSG_ADDR(aData)
        set_MSG_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_ADDR = &H0 Then read
        If flag_MSG_ADDR = &H0 Then write_MSG_ADDR_value = get_MSG_ADDR

        regValue = leftShift(write_MSG_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_ADDR_value = &H0
        flag_MSG_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_uppr_addr_27
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_UPPR_ADDR                              [31:0]           get_MSG_UPPR_ADDR
''                                                             set_MSG_UPPR_ADDR
''                                                             read_MSG_UPPR_ADDR
''                                                             write_MSG_UPPR_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_27
    Private write_MSG_UPPR_ADDR_value
    Private read_MSG_UPPR_ADDR_value
    Private flag_MSG_UPPR_ADDR

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

    Property Get get_MSG_UPPR_ADDR
        get_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let set_MSG_UPPR_ADDR(aData)
        write_MSG_UPPR_ADDR_value = aData
        flag_MSG_UPPR_ADDR        = &H1
    End Property

    Property Get read_MSG_UPPR_ADDR
        read
        read_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let write_MSG_UPPR_ADDR(aData)
        set_MSG_UPPR_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_UPPR_ADDR = &H0 Then read
        If flag_MSG_UPPR_ADDR = &H0 Then write_MSG_UPPR_ADDR_value = get_MSG_UPPR_ADDR

        regValue = leftShift(write_MSG_UPPR_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_UPPR_ADDR_value = &H0
        flag_MSG_UPPR_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_data_27
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_DATA                                   [31:0]           get_MSG_DATA
''                                                             set_MSG_DATA
''                                                             read_MSG_DATA
''                                                             write_MSG_DATA
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_data_27
    Private write_MSG_DATA_value
    Private read_MSG_DATA_value
    Private flag_MSG_DATA

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

    Property Get get_MSG_DATA
        get_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let set_MSG_DATA(aData)
        write_MSG_DATA_value = aData
        flag_MSG_DATA        = &H1
    End Property

    Property Get read_MSG_DATA
        read
        read_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let write_MSG_DATA(aData)
        set_MSG_DATA = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

    End Sub

    Sub write
        If flag_MSG_DATA = &H0 Then read
        If flag_MSG_DATA = &H0 Then write_MSG_DATA_value = get_MSG_DATA

        regValue = leftShift(write_MSG_DATA_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_DATA_value = &H0
        flag_MSG_DATA        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_vect_ctl_27
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MASK_BIT                                   [0:0]            get_MASK_BIT
''                                                             set_MASK_BIT
''                                                             read_MASK_BIT
''                                                             write_MASK_BIT
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_27
    Private write_MASK_BIT_value
    Private read_MASK_BIT_value
    Private flag_MASK_BIT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1bc
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MASK_BIT
        get_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let set_MASK_BIT(aData)
        write_MASK_BIT_value = aData
        flag_MASK_BIT        = &H1
    End Property

    Property Get read_MASK_BIT
        read
        read_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let write_MASK_BIT(aData)
        set_MASK_BIT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

    End Sub

    Sub write
        If flag_MASK_BIT = &H0 Then read
        If flag_MASK_BIT = &H0 Then write_MASK_BIT_value = get_MASK_BIT

        regValue = leftShift((write_MASK_BIT_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MASK_BIT_value = &H0
        flag_MASK_BIT        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_addr_28
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_ADDR                                   [31:0]           get_MSG_ADDR
''                                                             set_MSG_ADDR
''                                                             read_MSG_ADDR
''                                                             write_MSG_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_addr_28
    Private write_MSG_ADDR_value
    Private read_MSG_ADDR_value
    Private flag_MSG_ADDR

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

    Property Get get_MSG_ADDR
        get_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let set_MSG_ADDR(aData)
        write_MSG_ADDR_value = aData
        flag_MSG_ADDR        = &H1
    End Property

    Property Get read_MSG_ADDR
        read
        read_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let write_MSG_ADDR(aData)
        set_MSG_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_ADDR = &H0 Then read
        If flag_MSG_ADDR = &H0 Then write_MSG_ADDR_value = get_MSG_ADDR

        regValue = leftShift(write_MSG_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_ADDR_value = &H0
        flag_MSG_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_uppr_addr_28
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_UPPR_ADDR                              [31:0]           get_MSG_UPPR_ADDR
''                                                             set_MSG_UPPR_ADDR
''                                                             read_MSG_UPPR_ADDR
''                                                             write_MSG_UPPR_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_28
    Private write_MSG_UPPR_ADDR_value
    Private read_MSG_UPPR_ADDR_value
    Private flag_MSG_UPPR_ADDR

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

    Property Get get_MSG_UPPR_ADDR
        get_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let set_MSG_UPPR_ADDR(aData)
        write_MSG_UPPR_ADDR_value = aData
        flag_MSG_UPPR_ADDR        = &H1
    End Property

    Property Get read_MSG_UPPR_ADDR
        read
        read_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let write_MSG_UPPR_ADDR(aData)
        set_MSG_UPPR_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_UPPR_ADDR = &H0 Then read
        If flag_MSG_UPPR_ADDR = &H0 Then write_MSG_UPPR_ADDR_value = get_MSG_UPPR_ADDR

        regValue = leftShift(write_MSG_UPPR_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_UPPR_ADDR_value = &H0
        flag_MSG_UPPR_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_data_28
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_DATA                                   [31:0]           get_MSG_DATA
''                                                             set_MSG_DATA
''                                                             read_MSG_DATA
''                                                             write_MSG_DATA
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_data_28
    Private write_MSG_DATA_value
    Private read_MSG_DATA_value
    Private flag_MSG_DATA

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

    Property Get get_MSG_DATA
        get_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let set_MSG_DATA(aData)
        write_MSG_DATA_value = aData
        flag_MSG_DATA        = &H1
    End Property

    Property Get read_MSG_DATA
        read
        read_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let write_MSG_DATA(aData)
        set_MSG_DATA = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

    End Sub

    Sub write
        If flag_MSG_DATA = &H0 Then read
        If flag_MSG_DATA = &H0 Then write_MSG_DATA_value = get_MSG_DATA

        regValue = leftShift(write_MSG_DATA_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_DATA_value = &H0
        flag_MSG_DATA        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_vect_ctl_28
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MASK_BIT                                   [0:0]            get_MASK_BIT
''                                                             set_MASK_BIT
''                                                             read_MASK_BIT
''                                                             write_MASK_BIT
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_28
    Private write_MASK_BIT_value
    Private read_MASK_BIT_value
    Private flag_MASK_BIT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1cc
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MASK_BIT
        get_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let set_MASK_BIT(aData)
        write_MASK_BIT_value = aData
        flag_MASK_BIT        = &H1
    End Property

    Property Get read_MASK_BIT
        read
        read_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let write_MASK_BIT(aData)
        set_MASK_BIT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

    End Sub

    Sub write
        If flag_MASK_BIT = &H0 Then read
        If flag_MASK_BIT = &H0 Then write_MASK_BIT_value = get_MASK_BIT

        regValue = leftShift((write_MASK_BIT_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MASK_BIT_value = &H0
        flag_MASK_BIT        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_addr_29
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_ADDR                                   [31:0]           get_MSG_ADDR
''                                                             set_MSG_ADDR
''                                                             read_MSG_ADDR
''                                                             write_MSG_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_addr_29
    Private write_MSG_ADDR_value
    Private read_MSG_ADDR_value
    Private flag_MSG_ADDR

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

    Property Get get_MSG_ADDR
        get_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let set_MSG_ADDR(aData)
        write_MSG_ADDR_value = aData
        flag_MSG_ADDR        = &H1
    End Property

    Property Get read_MSG_ADDR
        read
        read_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let write_MSG_ADDR(aData)
        set_MSG_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_ADDR = &H0 Then read
        If flag_MSG_ADDR = &H0 Then write_MSG_ADDR_value = get_MSG_ADDR

        regValue = leftShift(write_MSG_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_ADDR_value = &H0
        flag_MSG_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_uppr_addr_29
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_UPPR_ADDR                              [31:0]           get_MSG_UPPR_ADDR
''                                                             set_MSG_UPPR_ADDR
''                                                             read_MSG_UPPR_ADDR
''                                                             write_MSG_UPPR_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_29
    Private write_MSG_UPPR_ADDR_value
    Private read_MSG_UPPR_ADDR_value
    Private flag_MSG_UPPR_ADDR

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

    Property Get get_MSG_UPPR_ADDR
        get_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let set_MSG_UPPR_ADDR(aData)
        write_MSG_UPPR_ADDR_value = aData
        flag_MSG_UPPR_ADDR        = &H1
    End Property

    Property Get read_MSG_UPPR_ADDR
        read
        read_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let write_MSG_UPPR_ADDR(aData)
        set_MSG_UPPR_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_UPPR_ADDR = &H0 Then read
        If flag_MSG_UPPR_ADDR = &H0 Then write_MSG_UPPR_ADDR_value = get_MSG_UPPR_ADDR

        regValue = leftShift(write_MSG_UPPR_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_UPPR_ADDR_value = &H0
        flag_MSG_UPPR_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_data_29
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_DATA                                   [31:0]           get_MSG_DATA
''                                                             set_MSG_DATA
''                                                             read_MSG_DATA
''                                                             write_MSG_DATA
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_data_29
    Private write_MSG_DATA_value
    Private read_MSG_DATA_value
    Private flag_MSG_DATA

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

    Property Get get_MSG_DATA
        get_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let set_MSG_DATA(aData)
        write_MSG_DATA_value = aData
        flag_MSG_DATA        = &H1
    End Property

    Property Get read_MSG_DATA
        read
        read_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let write_MSG_DATA(aData)
        set_MSG_DATA = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

    End Sub

    Sub write
        If flag_MSG_DATA = &H0 Then read
        If flag_MSG_DATA = &H0 Then write_MSG_DATA_value = get_MSG_DATA

        regValue = leftShift(write_MSG_DATA_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_DATA_value = &H0
        flag_MSG_DATA        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_vect_ctl_29
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MASK_BIT                                   [0:0]            get_MASK_BIT
''                                                             set_MASK_BIT
''                                                             read_MASK_BIT
''                                                             write_MASK_BIT
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_29
    Private write_MASK_BIT_value
    Private read_MASK_BIT_value
    Private flag_MASK_BIT

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

    Property Get get_MASK_BIT
        get_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let set_MASK_BIT(aData)
        write_MASK_BIT_value = aData
        flag_MASK_BIT        = &H1
    End Property

    Property Get read_MASK_BIT
        read
        read_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let write_MASK_BIT(aData)
        set_MASK_BIT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

    End Sub

    Sub write
        If flag_MASK_BIT = &H0 Then read
        If flag_MASK_BIT = &H0 Then write_MASK_BIT_value = get_MASK_BIT

        regValue = leftShift((write_MASK_BIT_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MASK_BIT_value = &H0
        flag_MASK_BIT        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_addr_30
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_ADDR                                   [31:0]           get_MSG_ADDR
''                                                             set_MSG_ADDR
''                                                             read_MSG_ADDR
''                                                             write_MSG_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_addr_30
    Private write_MSG_ADDR_value
    Private read_MSG_ADDR_value
    Private flag_MSG_ADDR

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

    Property Get get_MSG_ADDR
        get_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let set_MSG_ADDR(aData)
        write_MSG_ADDR_value = aData
        flag_MSG_ADDR        = &H1
    End Property

    Property Get read_MSG_ADDR
        read
        read_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let write_MSG_ADDR(aData)
        set_MSG_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_ADDR = &H0 Then read
        If flag_MSG_ADDR = &H0 Then write_MSG_ADDR_value = get_MSG_ADDR

        regValue = leftShift(write_MSG_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_ADDR_value = &H0
        flag_MSG_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_uppr_addr_30
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_UPPR_ADDR                              [31:0]           get_MSG_UPPR_ADDR
''                                                             set_MSG_UPPR_ADDR
''                                                             read_MSG_UPPR_ADDR
''                                                             write_MSG_UPPR_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_30
    Private write_MSG_UPPR_ADDR_value
    Private read_MSG_UPPR_ADDR_value
    Private flag_MSG_UPPR_ADDR

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

    Property Get get_MSG_UPPR_ADDR
        get_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let set_MSG_UPPR_ADDR(aData)
        write_MSG_UPPR_ADDR_value = aData
        flag_MSG_UPPR_ADDR        = &H1
    End Property

    Property Get read_MSG_UPPR_ADDR
        read
        read_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let write_MSG_UPPR_ADDR(aData)
        set_MSG_UPPR_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_UPPR_ADDR = &H0 Then read
        If flag_MSG_UPPR_ADDR = &H0 Then write_MSG_UPPR_ADDR_value = get_MSG_UPPR_ADDR

        regValue = leftShift(write_MSG_UPPR_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_UPPR_ADDR_value = &H0
        flag_MSG_UPPR_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_data_30
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_DATA                                   [31:0]           get_MSG_DATA
''                                                             set_MSG_DATA
''                                                             read_MSG_DATA
''                                                             write_MSG_DATA
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_data_30
    Private write_MSG_DATA_value
    Private read_MSG_DATA_value
    Private flag_MSG_DATA

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

    Property Get get_MSG_DATA
        get_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let set_MSG_DATA(aData)
        write_MSG_DATA_value = aData
        flag_MSG_DATA        = &H1
    End Property

    Property Get read_MSG_DATA
        read
        read_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let write_MSG_DATA(aData)
        set_MSG_DATA = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

    End Sub

    Sub write
        If flag_MSG_DATA = &H0 Then read
        If flag_MSG_DATA = &H0 Then write_MSG_DATA_value = get_MSG_DATA

        regValue = leftShift(write_MSG_DATA_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_DATA_value = &H0
        flag_MSG_DATA        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_vect_ctl_30
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MASK_BIT                                   [0:0]            get_MASK_BIT
''                                                             set_MASK_BIT
''                                                             read_MASK_BIT
''                                                             write_MASK_BIT
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_30
    Private write_MASK_BIT_value
    Private read_MASK_BIT_value
    Private flag_MASK_BIT

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

    Property Get get_MASK_BIT
        get_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let set_MASK_BIT(aData)
        write_MASK_BIT_value = aData
        flag_MASK_BIT        = &H1
    End Property

    Property Get read_MASK_BIT
        read
        read_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let write_MASK_BIT(aData)
        set_MASK_BIT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

    End Sub

    Sub write
        If flag_MASK_BIT = &H0 Then read
        If flag_MASK_BIT = &H0 Then write_MASK_BIT_value = get_MASK_BIT

        regValue = leftShift((write_MASK_BIT_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MASK_BIT_value = &H0
        flag_MASK_BIT        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_addr_31
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_ADDR                                   [31:0]           get_MSG_ADDR
''                                                             set_MSG_ADDR
''                                                             read_MSG_ADDR
''                                                             write_MSG_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_addr_31
    Private write_MSG_ADDR_value
    Private read_MSG_ADDR_value
    Private flag_MSG_ADDR

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

    Property Get get_MSG_ADDR
        get_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let set_MSG_ADDR(aData)
        write_MSG_ADDR_value = aData
        flag_MSG_ADDR        = &H1
    End Property

    Property Get read_MSG_ADDR
        read
        read_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let write_MSG_ADDR(aData)
        set_MSG_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_ADDR = &H0 Then read
        If flag_MSG_ADDR = &H0 Then write_MSG_ADDR_value = get_MSG_ADDR

        regValue = leftShift(write_MSG_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_ADDR_value = &H0
        flag_MSG_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_uppr_addr_31
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_UPPR_ADDR                              [31:0]           get_MSG_UPPR_ADDR
''                                                             set_MSG_UPPR_ADDR
''                                                             read_MSG_UPPR_ADDR
''                                                             write_MSG_UPPR_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_31
    Private write_MSG_UPPR_ADDR_value
    Private read_MSG_UPPR_ADDR_value
    Private flag_MSG_UPPR_ADDR

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

    Property Get get_MSG_UPPR_ADDR
        get_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let set_MSG_UPPR_ADDR(aData)
        write_MSG_UPPR_ADDR_value = aData
        flag_MSG_UPPR_ADDR        = &H1
    End Property

    Property Get read_MSG_UPPR_ADDR
        read
        read_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let write_MSG_UPPR_ADDR(aData)
        set_MSG_UPPR_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_UPPR_ADDR = &H0 Then read
        If flag_MSG_UPPR_ADDR = &H0 Then write_MSG_UPPR_ADDR_value = get_MSG_UPPR_ADDR

        regValue = leftShift(write_MSG_UPPR_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_UPPR_ADDR_value = &H0
        flag_MSG_UPPR_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_data_31
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_DATA                                   [31:0]           get_MSG_DATA
''                                                             set_MSG_DATA
''                                                             read_MSG_DATA
''                                                             write_MSG_DATA
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_data_31
    Private write_MSG_DATA_value
    Private read_MSG_DATA_value
    Private flag_MSG_DATA

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

    Property Get get_MSG_DATA
        get_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let set_MSG_DATA(aData)
        write_MSG_DATA_value = aData
        flag_MSG_DATA        = &H1
    End Property

    Property Get read_MSG_DATA
        read
        read_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let write_MSG_DATA(aData)
        set_MSG_DATA = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

    End Sub

    Sub write
        If flag_MSG_DATA = &H0 Then read
        If flag_MSG_DATA = &H0 Then write_MSG_DATA_value = get_MSG_DATA

        regValue = leftShift(write_MSG_DATA_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_DATA_value = &H0
        flag_MSG_DATA        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_vect_ctl_31
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MASK_BIT                                   [0:0]            get_MASK_BIT
''                                                             set_MASK_BIT
''                                                             read_MASK_BIT
''                                                             write_MASK_BIT
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_31
    Private write_MASK_BIT_value
    Private read_MASK_BIT_value
    Private flag_MASK_BIT

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

    Property Get get_MASK_BIT
        get_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let set_MASK_BIT(aData)
        write_MASK_BIT_value = aData
        flag_MASK_BIT        = &H1
    End Property

    Property Get read_MASK_BIT
        read
        read_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let write_MASK_BIT(aData)
        set_MASK_BIT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

    End Sub

    Sub write
        If flag_MASK_BIT = &H0 Then read
        If flag_MASK_BIT = &H0 Then write_MASK_BIT_value = get_MASK_BIT

        regValue = leftShift((write_MASK_BIT_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MASK_BIT_value = &H0
        flag_MASK_BIT        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_addr_32
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_ADDR                                   [31:0]           get_MSG_ADDR
''                                                             set_MSG_ADDR
''                                                             read_MSG_ADDR
''                                                             write_MSG_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_addr_32
    Private write_MSG_ADDR_value
    Private read_MSG_ADDR_value
    Private flag_MSG_ADDR

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H200
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MSG_ADDR
        get_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let set_MSG_ADDR(aData)
        write_MSG_ADDR_value = aData
        flag_MSG_ADDR        = &H1
    End Property

    Property Get read_MSG_ADDR
        read
        read_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let write_MSG_ADDR(aData)
        set_MSG_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_ADDR = &H0 Then read
        If flag_MSG_ADDR = &H0 Then write_MSG_ADDR_value = get_MSG_ADDR

        regValue = leftShift(write_MSG_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_ADDR_value = &H0
        flag_MSG_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_uppr_addr_32
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_UPPR_ADDR                              [31:0]           get_MSG_UPPR_ADDR
''                                                             set_MSG_UPPR_ADDR
''                                                             read_MSG_UPPR_ADDR
''                                                             write_MSG_UPPR_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_32
    Private write_MSG_UPPR_ADDR_value
    Private read_MSG_UPPR_ADDR_value
    Private flag_MSG_UPPR_ADDR

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H204
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MSG_UPPR_ADDR
        get_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let set_MSG_UPPR_ADDR(aData)
        write_MSG_UPPR_ADDR_value = aData
        flag_MSG_UPPR_ADDR        = &H1
    End Property

    Property Get read_MSG_UPPR_ADDR
        read
        read_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let write_MSG_UPPR_ADDR(aData)
        set_MSG_UPPR_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_UPPR_ADDR = &H0 Then read
        If flag_MSG_UPPR_ADDR = &H0 Then write_MSG_UPPR_ADDR_value = get_MSG_UPPR_ADDR

        regValue = leftShift(write_MSG_UPPR_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_UPPR_ADDR_value = &H0
        flag_MSG_UPPR_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_data_32
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_DATA                                   [31:0]           get_MSG_DATA
''                                                             set_MSG_DATA
''                                                             read_MSG_DATA
''                                                             write_MSG_DATA
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_data_32
    Private write_MSG_DATA_value
    Private read_MSG_DATA_value
    Private flag_MSG_DATA

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H208
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MSG_DATA
        get_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let set_MSG_DATA(aData)
        write_MSG_DATA_value = aData
        flag_MSG_DATA        = &H1
    End Property

    Property Get read_MSG_DATA
        read
        read_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let write_MSG_DATA(aData)
        set_MSG_DATA = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

    End Sub

    Sub write
        If flag_MSG_DATA = &H0 Then read
        If flag_MSG_DATA = &H0 Then write_MSG_DATA_value = get_MSG_DATA

        regValue = leftShift(write_MSG_DATA_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_DATA_value = &H0
        flag_MSG_DATA        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_vect_ctl_32
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MASK_BIT                                   [0:0]            get_MASK_BIT
''                                                             set_MASK_BIT
''                                                             read_MASK_BIT
''                                                             write_MASK_BIT
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_32
    Private write_MASK_BIT_value
    Private read_MASK_BIT_value
    Private flag_MASK_BIT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H20c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MASK_BIT
        get_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let set_MASK_BIT(aData)
        write_MASK_BIT_value = aData
        flag_MASK_BIT        = &H1
    End Property

    Property Get read_MASK_BIT
        read
        read_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let write_MASK_BIT(aData)
        set_MASK_BIT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

    End Sub

    Sub write
        If flag_MASK_BIT = &H0 Then read
        If flag_MASK_BIT = &H0 Then write_MASK_BIT_value = get_MASK_BIT

        regValue = leftShift((write_MASK_BIT_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MASK_BIT_value = &H0
        flag_MASK_BIT        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_addr_33
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_ADDR                                   [31:0]           get_MSG_ADDR
''                                                             set_MSG_ADDR
''                                                             read_MSG_ADDR
''                                                             write_MSG_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_addr_33
    Private write_MSG_ADDR_value
    Private read_MSG_ADDR_value
    Private flag_MSG_ADDR

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H210
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MSG_ADDR
        get_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let set_MSG_ADDR(aData)
        write_MSG_ADDR_value = aData
        flag_MSG_ADDR        = &H1
    End Property

    Property Get read_MSG_ADDR
        read
        read_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let write_MSG_ADDR(aData)
        set_MSG_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_ADDR = &H0 Then read
        If flag_MSG_ADDR = &H0 Then write_MSG_ADDR_value = get_MSG_ADDR

        regValue = leftShift(write_MSG_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_ADDR_value = &H0
        flag_MSG_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_uppr_addr_33
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_UPPR_ADDR                              [31:0]           get_MSG_UPPR_ADDR
''                                                             set_MSG_UPPR_ADDR
''                                                             read_MSG_UPPR_ADDR
''                                                             write_MSG_UPPR_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_33
    Private write_MSG_UPPR_ADDR_value
    Private read_MSG_UPPR_ADDR_value
    Private flag_MSG_UPPR_ADDR

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H214
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MSG_UPPR_ADDR
        get_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let set_MSG_UPPR_ADDR(aData)
        write_MSG_UPPR_ADDR_value = aData
        flag_MSG_UPPR_ADDR        = &H1
    End Property

    Property Get read_MSG_UPPR_ADDR
        read
        read_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let write_MSG_UPPR_ADDR(aData)
        set_MSG_UPPR_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_UPPR_ADDR = &H0 Then read
        If flag_MSG_UPPR_ADDR = &H0 Then write_MSG_UPPR_ADDR_value = get_MSG_UPPR_ADDR

        regValue = leftShift(write_MSG_UPPR_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_UPPR_ADDR_value = &H0
        flag_MSG_UPPR_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_data_33
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_DATA                                   [31:0]           get_MSG_DATA
''                                                             set_MSG_DATA
''                                                             read_MSG_DATA
''                                                             write_MSG_DATA
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_data_33
    Private write_MSG_DATA_value
    Private read_MSG_DATA_value
    Private flag_MSG_DATA

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H218
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MSG_DATA
        get_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let set_MSG_DATA(aData)
        write_MSG_DATA_value = aData
        flag_MSG_DATA        = &H1
    End Property

    Property Get read_MSG_DATA
        read
        read_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let write_MSG_DATA(aData)
        set_MSG_DATA = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

    End Sub

    Sub write
        If flag_MSG_DATA = &H0 Then read
        If flag_MSG_DATA = &H0 Then write_MSG_DATA_value = get_MSG_DATA

        regValue = leftShift(write_MSG_DATA_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_DATA_value = &H0
        flag_MSG_DATA        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_vect_ctl_33
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MASK_BIT                                   [0:0]            get_MASK_BIT
''                                                             set_MASK_BIT
''                                                             read_MASK_BIT
''                                                             write_MASK_BIT
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_33
    Private write_MASK_BIT_value
    Private read_MASK_BIT_value
    Private flag_MASK_BIT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H21c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MASK_BIT
        get_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let set_MASK_BIT(aData)
        write_MASK_BIT_value = aData
        flag_MASK_BIT        = &H1
    End Property

    Property Get read_MASK_BIT
        read
        read_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let write_MASK_BIT(aData)
        set_MASK_BIT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

    End Sub

    Sub write
        If flag_MASK_BIT = &H0 Then read
        If flag_MASK_BIT = &H0 Then write_MASK_BIT_value = get_MASK_BIT

        regValue = leftShift((write_MASK_BIT_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MASK_BIT_value = &H0
        flag_MASK_BIT        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_addr_34
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_ADDR                                   [31:0]           get_MSG_ADDR
''                                                             set_MSG_ADDR
''                                                             read_MSG_ADDR
''                                                             write_MSG_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_addr_34
    Private write_MSG_ADDR_value
    Private read_MSG_ADDR_value
    Private flag_MSG_ADDR

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H220
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MSG_ADDR
        get_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let set_MSG_ADDR(aData)
        write_MSG_ADDR_value = aData
        flag_MSG_ADDR        = &H1
    End Property

    Property Get read_MSG_ADDR
        read
        read_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let write_MSG_ADDR(aData)
        set_MSG_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_ADDR = &H0 Then read
        If flag_MSG_ADDR = &H0 Then write_MSG_ADDR_value = get_MSG_ADDR

        regValue = leftShift(write_MSG_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_ADDR_value = &H0
        flag_MSG_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_uppr_addr_34
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_UPPR_ADDR                              [31:0]           get_MSG_UPPR_ADDR
''                                                             set_MSG_UPPR_ADDR
''                                                             read_MSG_UPPR_ADDR
''                                                             write_MSG_UPPR_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_34
    Private write_MSG_UPPR_ADDR_value
    Private read_MSG_UPPR_ADDR_value
    Private flag_MSG_UPPR_ADDR

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H224
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MSG_UPPR_ADDR
        get_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let set_MSG_UPPR_ADDR(aData)
        write_MSG_UPPR_ADDR_value = aData
        flag_MSG_UPPR_ADDR        = &H1
    End Property

    Property Get read_MSG_UPPR_ADDR
        read
        read_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let write_MSG_UPPR_ADDR(aData)
        set_MSG_UPPR_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_UPPR_ADDR = &H0 Then read
        If flag_MSG_UPPR_ADDR = &H0 Then write_MSG_UPPR_ADDR_value = get_MSG_UPPR_ADDR

        regValue = leftShift(write_MSG_UPPR_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_UPPR_ADDR_value = &H0
        flag_MSG_UPPR_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_data_34
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_DATA                                   [31:0]           get_MSG_DATA
''                                                             set_MSG_DATA
''                                                             read_MSG_DATA
''                                                             write_MSG_DATA
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_data_34
    Private write_MSG_DATA_value
    Private read_MSG_DATA_value
    Private flag_MSG_DATA

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H228
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MSG_DATA
        get_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let set_MSG_DATA(aData)
        write_MSG_DATA_value = aData
        flag_MSG_DATA        = &H1
    End Property

    Property Get read_MSG_DATA
        read
        read_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let write_MSG_DATA(aData)
        set_MSG_DATA = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

    End Sub

    Sub write
        If flag_MSG_DATA = &H0 Then read
        If flag_MSG_DATA = &H0 Then write_MSG_DATA_value = get_MSG_DATA

        regValue = leftShift(write_MSG_DATA_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_DATA_value = &H0
        flag_MSG_DATA        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_vect_ctl_34
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MASK_BIT                                   [0:0]            get_MASK_BIT
''                                                             set_MASK_BIT
''                                                             read_MASK_BIT
''                                                             write_MASK_BIT
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_34
    Private write_MASK_BIT_value
    Private read_MASK_BIT_value
    Private flag_MASK_BIT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H22c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MASK_BIT
        get_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let set_MASK_BIT(aData)
        write_MASK_BIT_value = aData
        flag_MASK_BIT        = &H1
    End Property

    Property Get read_MASK_BIT
        read
        read_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let write_MASK_BIT(aData)
        set_MASK_BIT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

    End Sub

    Sub write
        If flag_MASK_BIT = &H0 Then read
        If flag_MASK_BIT = &H0 Then write_MASK_BIT_value = get_MASK_BIT

        regValue = leftShift((write_MASK_BIT_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MASK_BIT_value = &H0
        flag_MASK_BIT        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_addr_35
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_ADDR                                   [31:0]           get_MSG_ADDR
''                                                             set_MSG_ADDR
''                                                             read_MSG_ADDR
''                                                             write_MSG_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_addr_35
    Private write_MSG_ADDR_value
    Private read_MSG_ADDR_value
    Private flag_MSG_ADDR

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H230
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MSG_ADDR
        get_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let set_MSG_ADDR(aData)
        write_MSG_ADDR_value = aData
        flag_MSG_ADDR        = &H1
    End Property

    Property Get read_MSG_ADDR
        read
        read_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let write_MSG_ADDR(aData)
        set_MSG_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_ADDR = &H0 Then read
        If flag_MSG_ADDR = &H0 Then write_MSG_ADDR_value = get_MSG_ADDR

        regValue = leftShift(write_MSG_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_ADDR_value = &H0
        flag_MSG_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_uppr_addr_35
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_UPPR_ADDR                              [31:0]           get_MSG_UPPR_ADDR
''                                                             set_MSG_UPPR_ADDR
''                                                             read_MSG_UPPR_ADDR
''                                                             write_MSG_UPPR_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_35
    Private write_MSG_UPPR_ADDR_value
    Private read_MSG_UPPR_ADDR_value
    Private flag_MSG_UPPR_ADDR

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H234
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MSG_UPPR_ADDR
        get_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let set_MSG_UPPR_ADDR(aData)
        write_MSG_UPPR_ADDR_value = aData
        flag_MSG_UPPR_ADDR        = &H1
    End Property

    Property Get read_MSG_UPPR_ADDR
        read
        read_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let write_MSG_UPPR_ADDR(aData)
        set_MSG_UPPR_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_UPPR_ADDR = &H0 Then read
        If flag_MSG_UPPR_ADDR = &H0 Then write_MSG_UPPR_ADDR_value = get_MSG_UPPR_ADDR

        regValue = leftShift(write_MSG_UPPR_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_UPPR_ADDR_value = &H0
        flag_MSG_UPPR_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_data_35
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_DATA                                   [31:0]           get_MSG_DATA
''                                                             set_MSG_DATA
''                                                             read_MSG_DATA
''                                                             write_MSG_DATA
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_data_35
    Private write_MSG_DATA_value
    Private read_MSG_DATA_value
    Private flag_MSG_DATA

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H238
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MSG_DATA
        get_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let set_MSG_DATA(aData)
        write_MSG_DATA_value = aData
        flag_MSG_DATA        = &H1
    End Property

    Property Get read_MSG_DATA
        read
        read_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let write_MSG_DATA(aData)
        set_MSG_DATA = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

    End Sub

    Sub write
        If flag_MSG_DATA = &H0 Then read
        If flag_MSG_DATA = &H0 Then write_MSG_DATA_value = get_MSG_DATA

        regValue = leftShift(write_MSG_DATA_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_DATA_value = &H0
        flag_MSG_DATA        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_vect_ctl_35
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MASK_BIT                                   [0:0]            get_MASK_BIT
''                                                             set_MASK_BIT
''                                                             read_MASK_BIT
''                                                             write_MASK_BIT
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_35
    Private write_MASK_BIT_value
    Private read_MASK_BIT_value
    Private flag_MASK_BIT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H23c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MASK_BIT
        get_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let set_MASK_BIT(aData)
        write_MASK_BIT_value = aData
        flag_MASK_BIT        = &H1
    End Property

    Property Get read_MASK_BIT
        read
        read_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let write_MASK_BIT(aData)
        set_MASK_BIT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

    End Sub

    Sub write
        If flag_MASK_BIT = &H0 Then read
        If flag_MASK_BIT = &H0 Then write_MASK_BIT_value = get_MASK_BIT

        regValue = leftShift((write_MASK_BIT_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MASK_BIT_value = &H0
        flag_MASK_BIT        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_addr_36
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_ADDR                                   [31:0]           get_MSG_ADDR
''                                                             set_MSG_ADDR
''                                                             read_MSG_ADDR
''                                                             write_MSG_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_addr_36
    Private write_MSG_ADDR_value
    Private read_MSG_ADDR_value
    Private flag_MSG_ADDR

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H240
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MSG_ADDR
        get_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let set_MSG_ADDR(aData)
        write_MSG_ADDR_value = aData
        flag_MSG_ADDR        = &H1
    End Property

    Property Get read_MSG_ADDR
        read
        read_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let write_MSG_ADDR(aData)
        set_MSG_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_ADDR = &H0 Then read
        If flag_MSG_ADDR = &H0 Then write_MSG_ADDR_value = get_MSG_ADDR

        regValue = leftShift(write_MSG_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_ADDR_value = &H0
        flag_MSG_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_uppr_addr_36
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_UPPR_ADDR                              [31:0]           get_MSG_UPPR_ADDR
''                                                             set_MSG_UPPR_ADDR
''                                                             read_MSG_UPPR_ADDR
''                                                             write_MSG_UPPR_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_36
    Private write_MSG_UPPR_ADDR_value
    Private read_MSG_UPPR_ADDR_value
    Private flag_MSG_UPPR_ADDR

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H244
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MSG_UPPR_ADDR
        get_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let set_MSG_UPPR_ADDR(aData)
        write_MSG_UPPR_ADDR_value = aData
        flag_MSG_UPPR_ADDR        = &H1
    End Property

    Property Get read_MSG_UPPR_ADDR
        read
        read_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let write_MSG_UPPR_ADDR(aData)
        set_MSG_UPPR_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_UPPR_ADDR = &H0 Then read
        If flag_MSG_UPPR_ADDR = &H0 Then write_MSG_UPPR_ADDR_value = get_MSG_UPPR_ADDR

        regValue = leftShift(write_MSG_UPPR_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_UPPR_ADDR_value = &H0
        flag_MSG_UPPR_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_data_36
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_DATA                                   [31:0]           get_MSG_DATA
''                                                             set_MSG_DATA
''                                                             read_MSG_DATA
''                                                             write_MSG_DATA
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_data_36
    Private write_MSG_DATA_value
    Private read_MSG_DATA_value
    Private flag_MSG_DATA

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H248
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MSG_DATA
        get_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let set_MSG_DATA(aData)
        write_MSG_DATA_value = aData
        flag_MSG_DATA        = &H1
    End Property

    Property Get read_MSG_DATA
        read
        read_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let write_MSG_DATA(aData)
        set_MSG_DATA = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

    End Sub

    Sub write
        If flag_MSG_DATA = &H0 Then read
        If flag_MSG_DATA = &H0 Then write_MSG_DATA_value = get_MSG_DATA

        regValue = leftShift(write_MSG_DATA_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_DATA_value = &H0
        flag_MSG_DATA        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_vect_ctl_36
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MASK_BIT                                   [0:0]            get_MASK_BIT
''                                                             set_MASK_BIT
''                                                             read_MASK_BIT
''                                                             write_MASK_BIT
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_36
    Private write_MASK_BIT_value
    Private read_MASK_BIT_value
    Private flag_MASK_BIT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H24c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MASK_BIT
        get_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let set_MASK_BIT(aData)
        write_MASK_BIT_value = aData
        flag_MASK_BIT        = &H1
    End Property

    Property Get read_MASK_BIT
        read
        read_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let write_MASK_BIT(aData)
        set_MASK_BIT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

    End Sub

    Sub write
        If flag_MASK_BIT = &H0 Then read
        If flag_MASK_BIT = &H0 Then write_MASK_BIT_value = get_MASK_BIT

        regValue = leftShift((write_MASK_BIT_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MASK_BIT_value = &H0
        flag_MASK_BIT        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_addr_37
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_ADDR                                   [31:0]           get_MSG_ADDR
''                                                             set_MSG_ADDR
''                                                             read_MSG_ADDR
''                                                             write_MSG_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_addr_37
    Private write_MSG_ADDR_value
    Private read_MSG_ADDR_value
    Private flag_MSG_ADDR

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H250
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MSG_ADDR
        get_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let set_MSG_ADDR(aData)
        write_MSG_ADDR_value = aData
        flag_MSG_ADDR        = &H1
    End Property

    Property Get read_MSG_ADDR
        read
        read_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let write_MSG_ADDR(aData)
        set_MSG_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_ADDR = &H0 Then read
        If flag_MSG_ADDR = &H0 Then write_MSG_ADDR_value = get_MSG_ADDR

        regValue = leftShift(write_MSG_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_ADDR_value = &H0
        flag_MSG_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_uppr_addr_37
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_UPPR_ADDR                              [31:0]           get_MSG_UPPR_ADDR
''                                                             set_MSG_UPPR_ADDR
''                                                             read_MSG_UPPR_ADDR
''                                                             write_MSG_UPPR_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_37
    Private write_MSG_UPPR_ADDR_value
    Private read_MSG_UPPR_ADDR_value
    Private flag_MSG_UPPR_ADDR

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H254
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MSG_UPPR_ADDR
        get_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let set_MSG_UPPR_ADDR(aData)
        write_MSG_UPPR_ADDR_value = aData
        flag_MSG_UPPR_ADDR        = &H1
    End Property

    Property Get read_MSG_UPPR_ADDR
        read
        read_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let write_MSG_UPPR_ADDR(aData)
        set_MSG_UPPR_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_UPPR_ADDR = &H0 Then read
        If flag_MSG_UPPR_ADDR = &H0 Then write_MSG_UPPR_ADDR_value = get_MSG_UPPR_ADDR

        regValue = leftShift(write_MSG_UPPR_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_UPPR_ADDR_value = &H0
        flag_MSG_UPPR_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_data_37
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_DATA                                   [31:0]           get_MSG_DATA
''                                                             set_MSG_DATA
''                                                             read_MSG_DATA
''                                                             write_MSG_DATA
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_data_37
    Private write_MSG_DATA_value
    Private read_MSG_DATA_value
    Private flag_MSG_DATA

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H258
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MSG_DATA
        get_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let set_MSG_DATA(aData)
        write_MSG_DATA_value = aData
        flag_MSG_DATA        = &H1
    End Property

    Property Get read_MSG_DATA
        read
        read_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let write_MSG_DATA(aData)
        set_MSG_DATA = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

    End Sub

    Sub write
        If flag_MSG_DATA = &H0 Then read
        If flag_MSG_DATA = &H0 Then write_MSG_DATA_value = get_MSG_DATA

        regValue = leftShift(write_MSG_DATA_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_DATA_value = &H0
        flag_MSG_DATA        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_vect_ctl_37
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MASK_BIT                                   [0:0]            get_MASK_BIT
''                                                             set_MASK_BIT
''                                                             read_MASK_BIT
''                                                             write_MASK_BIT
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_37
    Private write_MASK_BIT_value
    Private read_MASK_BIT_value
    Private flag_MASK_BIT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H25c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MASK_BIT
        get_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let set_MASK_BIT(aData)
        write_MASK_BIT_value = aData
        flag_MASK_BIT        = &H1
    End Property

    Property Get read_MASK_BIT
        read
        read_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let write_MASK_BIT(aData)
        set_MASK_BIT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

    End Sub

    Sub write
        If flag_MASK_BIT = &H0 Then read
        If flag_MASK_BIT = &H0 Then write_MASK_BIT_value = get_MASK_BIT

        regValue = leftShift((write_MASK_BIT_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MASK_BIT_value = &H0
        flag_MASK_BIT        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_addr_38
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_ADDR                                   [31:0]           get_MSG_ADDR
''                                                             set_MSG_ADDR
''                                                             read_MSG_ADDR
''                                                             write_MSG_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_addr_38
    Private write_MSG_ADDR_value
    Private read_MSG_ADDR_value
    Private flag_MSG_ADDR

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H260
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MSG_ADDR
        get_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let set_MSG_ADDR(aData)
        write_MSG_ADDR_value = aData
        flag_MSG_ADDR        = &H1
    End Property

    Property Get read_MSG_ADDR
        read
        read_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let write_MSG_ADDR(aData)
        set_MSG_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_ADDR = &H0 Then read
        If flag_MSG_ADDR = &H0 Then write_MSG_ADDR_value = get_MSG_ADDR

        regValue = leftShift(write_MSG_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_ADDR_value = &H0
        flag_MSG_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_uppr_addr_38
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_UPPR_ADDR                              [31:0]           get_MSG_UPPR_ADDR
''                                                             set_MSG_UPPR_ADDR
''                                                             read_MSG_UPPR_ADDR
''                                                             write_MSG_UPPR_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_38
    Private write_MSG_UPPR_ADDR_value
    Private read_MSG_UPPR_ADDR_value
    Private flag_MSG_UPPR_ADDR

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H264
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MSG_UPPR_ADDR
        get_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let set_MSG_UPPR_ADDR(aData)
        write_MSG_UPPR_ADDR_value = aData
        flag_MSG_UPPR_ADDR        = &H1
    End Property

    Property Get read_MSG_UPPR_ADDR
        read
        read_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let write_MSG_UPPR_ADDR(aData)
        set_MSG_UPPR_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_UPPR_ADDR = &H0 Then read
        If flag_MSG_UPPR_ADDR = &H0 Then write_MSG_UPPR_ADDR_value = get_MSG_UPPR_ADDR

        regValue = leftShift(write_MSG_UPPR_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_UPPR_ADDR_value = &H0
        flag_MSG_UPPR_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_data_38
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_DATA                                   [31:0]           get_MSG_DATA
''                                                             set_MSG_DATA
''                                                             read_MSG_DATA
''                                                             write_MSG_DATA
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_data_38
    Private write_MSG_DATA_value
    Private read_MSG_DATA_value
    Private flag_MSG_DATA

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H268
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MSG_DATA
        get_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let set_MSG_DATA(aData)
        write_MSG_DATA_value = aData
        flag_MSG_DATA        = &H1
    End Property

    Property Get read_MSG_DATA
        read
        read_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let write_MSG_DATA(aData)
        set_MSG_DATA = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

    End Sub

    Sub write
        If flag_MSG_DATA = &H0 Then read
        If flag_MSG_DATA = &H0 Then write_MSG_DATA_value = get_MSG_DATA

        regValue = leftShift(write_MSG_DATA_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_DATA_value = &H0
        flag_MSG_DATA        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_vect_ctl_38
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MASK_BIT                                   [0:0]            get_MASK_BIT
''                                                             set_MASK_BIT
''                                                             read_MASK_BIT
''                                                             write_MASK_BIT
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_38
    Private write_MASK_BIT_value
    Private read_MASK_BIT_value
    Private flag_MASK_BIT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H26c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MASK_BIT
        get_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let set_MASK_BIT(aData)
        write_MASK_BIT_value = aData
        flag_MASK_BIT        = &H1
    End Property

    Property Get read_MASK_BIT
        read
        read_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let write_MASK_BIT(aData)
        set_MASK_BIT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

    End Sub

    Sub write
        If flag_MASK_BIT = &H0 Then read
        If flag_MASK_BIT = &H0 Then write_MASK_BIT_value = get_MASK_BIT

        regValue = leftShift((write_MASK_BIT_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MASK_BIT_value = &H0
        flag_MASK_BIT        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_addr_39
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_ADDR                                   [31:0]           get_MSG_ADDR
''                                                             set_MSG_ADDR
''                                                             read_MSG_ADDR
''                                                             write_MSG_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_addr_39
    Private write_MSG_ADDR_value
    Private read_MSG_ADDR_value
    Private flag_MSG_ADDR

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H270
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MSG_ADDR
        get_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let set_MSG_ADDR(aData)
        write_MSG_ADDR_value = aData
        flag_MSG_ADDR        = &H1
    End Property

    Property Get read_MSG_ADDR
        read
        read_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let write_MSG_ADDR(aData)
        set_MSG_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_ADDR = &H0 Then read
        If flag_MSG_ADDR = &H0 Then write_MSG_ADDR_value = get_MSG_ADDR

        regValue = leftShift(write_MSG_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_ADDR_value = &H0
        flag_MSG_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_uppr_addr_39
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_UPPR_ADDR                              [31:0]           get_MSG_UPPR_ADDR
''                                                             set_MSG_UPPR_ADDR
''                                                             read_MSG_UPPR_ADDR
''                                                             write_MSG_UPPR_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_39
    Private write_MSG_UPPR_ADDR_value
    Private read_MSG_UPPR_ADDR_value
    Private flag_MSG_UPPR_ADDR

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H274
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MSG_UPPR_ADDR
        get_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let set_MSG_UPPR_ADDR(aData)
        write_MSG_UPPR_ADDR_value = aData
        flag_MSG_UPPR_ADDR        = &H1
    End Property

    Property Get read_MSG_UPPR_ADDR
        read
        read_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let write_MSG_UPPR_ADDR(aData)
        set_MSG_UPPR_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_UPPR_ADDR = &H0 Then read
        If flag_MSG_UPPR_ADDR = &H0 Then write_MSG_UPPR_ADDR_value = get_MSG_UPPR_ADDR

        regValue = leftShift(write_MSG_UPPR_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_UPPR_ADDR_value = &H0
        flag_MSG_UPPR_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_data_39
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_DATA                                   [31:0]           get_MSG_DATA
''                                                             set_MSG_DATA
''                                                             read_MSG_DATA
''                                                             write_MSG_DATA
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_data_39
    Private write_MSG_DATA_value
    Private read_MSG_DATA_value
    Private flag_MSG_DATA

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H278
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MSG_DATA
        get_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let set_MSG_DATA(aData)
        write_MSG_DATA_value = aData
        flag_MSG_DATA        = &H1
    End Property

    Property Get read_MSG_DATA
        read
        read_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let write_MSG_DATA(aData)
        set_MSG_DATA = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

    End Sub

    Sub write
        If flag_MSG_DATA = &H0 Then read
        If flag_MSG_DATA = &H0 Then write_MSG_DATA_value = get_MSG_DATA

        regValue = leftShift(write_MSG_DATA_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_DATA_value = &H0
        flag_MSG_DATA        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_vect_ctl_39
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MASK_BIT                                   [0:0]            get_MASK_BIT
''                                                             set_MASK_BIT
''                                                             read_MASK_BIT
''                                                             write_MASK_BIT
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_39
    Private write_MASK_BIT_value
    Private read_MASK_BIT_value
    Private flag_MASK_BIT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H27c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MASK_BIT
        get_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let set_MASK_BIT(aData)
        write_MASK_BIT_value = aData
        flag_MASK_BIT        = &H1
    End Property

    Property Get read_MASK_BIT
        read
        read_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let write_MASK_BIT(aData)
        set_MASK_BIT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

    End Sub

    Sub write
        If flag_MASK_BIT = &H0 Then read
        If flag_MASK_BIT = &H0 Then write_MASK_BIT_value = get_MASK_BIT

        regValue = leftShift((write_MASK_BIT_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MASK_BIT_value = &H0
        flag_MASK_BIT        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_addr_40
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_ADDR                                   [31:0]           get_MSG_ADDR
''                                                             set_MSG_ADDR
''                                                             read_MSG_ADDR
''                                                             write_MSG_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_addr_40
    Private write_MSG_ADDR_value
    Private read_MSG_ADDR_value
    Private flag_MSG_ADDR

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H280
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MSG_ADDR
        get_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let set_MSG_ADDR(aData)
        write_MSG_ADDR_value = aData
        flag_MSG_ADDR        = &H1
    End Property

    Property Get read_MSG_ADDR
        read
        read_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let write_MSG_ADDR(aData)
        set_MSG_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_ADDR = &H0 Then read
        If flag_MSG_ADDR = &H0 Then write_MSG_ADDR_value = get_MSG_ADDR

        regValue = leftShift(write_MSG_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_ADDR_value = &H0
        flag_MSG_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_uppr_addr_40
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_UPPR_ADDR                              [31:0]           get_MSG_UPPR_ADDR
''                                                             set_MSG_UPPR_ADDR
''                                                             read_MSG_UPPR_ADDR
''                                                             write_MSG_UPPR_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_40
    Private write_MSG_UPPR_ADDR_value
    Private read_MSG_UPPR_ADDR_value
    Private flag_MSG_UPPR_ADDR

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H284
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MSG_UPPR_ADDR
        get_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let set_MSG_UPPR_ADDR(aData)
        write_MSG_UPPR_ADDR_value = aData
        flag_MSG_UPPR_ADDR        = &H1
    End Property

    Property Get read_MSG_UPPR_ADDR
        read
        read_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let write_MSG_UPPR_ADDR(aData)
        set_MSG_UPPR_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_UPPR_ADDR = &H0 Then read
        If flag_MSG_UPPR_ADDR = &H0 Then write_MSG_UPPR_ADDR_value = get_MSG_UPPR_ADDR

        regValue = leftShift(write_MSG_UPPR_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_UPPR_ADDR_value = &H0
        flag_MSG_UPPR_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_data_40
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_DATA                                   [31:0]           get_MSG_DATA
''                                                             set_MSG_DATA
''                                                             read_MSG_DATA
''                                                             write_MSG_DATA
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_data_40
    Private write_MSG_DATA_value
    Private read_MSG_DATA_value
    Private flag_MSG_DATA

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H288
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MSG_DATA
        get_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let set_MSG_DATA(aData)
        write_MSG_DATA_value = aData
        flag_MSG_DATA        = &H1
    End Property

    Property Get read_MSG_DATA
        read
        read_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let write_MSG_DATA(aData)
        set_MSG_DATA = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

    End Sub

    Sub write
        If flag_MSG_DATA = &H0 Then read
        If flag_MSG_DATA = &H0 Then write_MSG_DATA_value = get_MSG_DATA

        regValue = leftShift(write_MSG_DATA_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_DATA_value = &H0
        flag_MSG_DATA        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_vect_ctl_40
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MASK_BIT                                   [0:0]            get_MASK_BIT
''                                                             set_MASK_BIT
''                                                             read_MASK_BIT
''                                                             write_MASK_BIT
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_40
    Private write_MASK_BIT_value
    Private read_MASK_BIT_value
    Private flag_MASK_BIT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H28c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MASK_BIT
        get_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let set_MASK_BIT(aData)
        write_MASK_BIT_value = aData
        flag_MASK_BIT        = &H1
    End Property

    Property Get read_MASK_BIT
        read
        read_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let write_MASK_BIT(aData)
        set_MASK_BIT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

    End Sub

    Sub write
        If flag_MASK_BIT = &H0 Then read
        If flag_MASK_BIT = &H0 Then write_MASK_BIT_value = get_MASK_BIT

        regValue = leftShift((write_MASK_BIT_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MASK_BIT_value = &H0
        flag_MASK_BIT        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_addr_41
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_ADDR                                   [31:0]           get_MSG_ADDR
''                                                             set_MSG_ADDR
''                                                             read_MSG_ADDR
''                                                             write_MSG_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_addr_41
    Private write_MSG_ADDR_value
    Private read_MSG_ADDR_value
    Private flag_MSG_ADDR

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H290
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MSG_ADDR
        get_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let set_MSG_ADDR(aData)
        write_MSG_ADDR_value = aData
        flag_MSG_ADDR        = &H1
    End Property

    Property Get read_MSG_ADDR
        read
        read_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let write_MSG_ADDR(aData)
        set_MSG_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_ADDR = &H0 Then read
        If flag_MSG_ADDR = &H0 Then write_MSG_ADDR_value = get_MSG_ADDR

        regValue = leftShift(write_MSG_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_ADDR_value = &H0
        flag_MSG_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_uppr_addr_41
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_UPPR_ADDR                              [31:0]           get_MSG_UPPR_ADDR
''                                                             set_MSG_UPPR_ADDR
''                                                             read_MSG_UPPR_ADDR
''                                                             write_MSG_UPPR_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_41
    Private write_MSG_UPPR_ADDR_value
    Private read_MSG_UPPR_ADDR_value
    Private flag_MSG_UPPR_ADDR

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H294
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MSG_UPPR_ADDR
        get_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let set_MSG_UPPR_ADDR(aData)
        write_MSG_UPPR_ADDR_value = aData
        flag_MSG_UPPR_ADDR        = &H1
    End Property

    Property Get read_MSG_UPPR_ADDR
        read
        read_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let write_MSG_UPPR_ADDR(aData)
        set_MSG_UPPR_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_UPPR_ADDR = &H0 Then read
        If flag_MSG_UPPR_ADDR = &H0 Then write_MSG_UPPR_ADDR_value = get_MSG_UPPR_ADDR

        regValue = leftShift(write_MSG_UPPR_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_UPPR_ADDR_value = &H0
        flag_MSG_UPPR_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_data_41
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_DATA                                   [31:0]           get_MSG_DATA
''                                                             set_MSG_DATA
''                                                             read_MSG_DATA
''                                                             write_MSG_DATA
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_data_41
    Private write_MSG_DATA_value
    Private read_MSG_DATA_value
    Private flag_MSG_DATA

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H298
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MSG_DATA
        get_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let set_MSG_DATA(aData)
        write_MSG_DATA_value = aData
        flag_MSG_DATA        = &H1
    End Property

    Property Get read_MSG_DATA
        read
        read_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let write_MSG_DATA(aData)
        set_MSG_DATA = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

    End Sub

    Sub write
        If flag_MSG_DATA = &H0 Then read
        If flag_MSG_DATA = &H0 Then write_MSG_DATA_value = get_MSG_DATA

        regValue = leftShift(write_MSG_DATA_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_DATA_value = &H0
        flag_MSG_DATA        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_vect_ctl_41
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MASK_BIT                                   [0:0]            get_MASK_BIT
''                                                             set_MASK_BIT
''                                                             read_MASK_BIT
''                                                             write_MASK_BIT
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_41
    Private write_MASK_BIT_value
    Private read_MASK_BIT_value
    Private flag_MASK_BIT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H29c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MASK_BIT
        get_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let set_MASK_BIT(aData)
        write_MASK_BIT_value = aData
        flag_MASK_BIT        = &H1
    End Property

    Property Get read_MASK_BIT
        read
        read_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let write_MASK_BIT(aData)
        set_MASK_BIT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

    End Sub

    Sub write
        If flag_MASK_BIT = &H0 Then read
        If flag_MASK_BIT = &H0 Then write_MASK_BIT_value = get_MASK_BIT

        regValue = leftShift((write_MASK_BIT_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MASK_BIT_value = &H0
        flag_MASK_BIT        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_addr_42
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_ADDR                                   [31:0]           get_MSG_ADDR
''                                                             set_MSG_ADDR
''                                                             read_MSG_ADDR
''                                                             write_MSG_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_addr_42
    Private write_MSG_ADDR_value
    Private read_MSG_ADDR_value
    Private flag_MSG_ADDR

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H2a0
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MSG_ADDR
        get_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let set_MSG_ADDR(aData)
        write_MSG_ADDR_value = aData
        flag_MSG_ADDR        = &H1
    End Property

    Property Get read_MSG_ADDR
        read
        read_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let write_MSG_ADDR(aData)
        set_MSG_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_ADDR = &H0 Then read
        If flag_MSG_ADDR = &H0 Then write_MSG_ADDR_value = get_MSG_ADDR

        regValue = leftShift(write_MSG_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_ADDR_value = &H0
        flag_MSG_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_uppr_addr_42
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_UPPR_ADDR                              [31:0]           get_MSG_UPPR_ADDR
''                                                             set_MSG_UPPR_ADDR
''                                                             read_MSG_UPPR_ADDR
''                                                             write_MSG_UPPR_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_42
    Private write_MSG_UPPR_ADDR_value
    Private read_MSG_UPPR_ADDR_value
    Private flag_MSG_UPPR_ADDR

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H2a4
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MSG_UPPR_ADDR
        get_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let set_MSG_UPPR_ADDR(aData)
        write_MSG_UPPR_ADDR_value = aData
        flag_MSG_UPPR_ADDR        = &H1
    End Property

    Property Get read_MSG_UPPR_ADDR
        read
        read_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let write_MSG_UPPR_ADDR(aData)
        set_MSG_UPPR_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_UPPR_ADDR = &H0 Then read
        If flag_MSG_UPPR_ADDR = &H0 Then write_MSG_UPPR_ADDR_value = get_MSG_UPPR_ADDR

        regValue = leftShift(write_MSG_UPPR_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_UPPR_ADDR_value = &H0
        flag_MSG_UPPR_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_data_42
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_DATA                                   [31:0]           get_MSG_DATA
''                                                             set_MSG_DATA
''                                                             read_MSG_DATA
''                                                             write_MSG_DATA
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_data_42
    Private write_MSG_DATA_value
    Private read_MSG_DATA_value
    Private flag_MSG_DATA

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H2a8
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MSG_DATA
        get_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let set_MSG_DATA(aData)
        write_MSG_DATA_value = aData
        flag_MSG_DATA        = &H1
    End Property

    Property Get read_MSG_DATA
        read
        read_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let write_MSG_DATA(aData)
        set_MSG_DATA = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

    End Sub

    Sub write
        If flag_MSG_DATA = &H0 Then read
        If flag_MSG_DATA = &H0 Then write_MSG_DATA_value = get_MSG_DATA

        regValue = leftShift(write_MSG_DATA_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_DATA_value = &H0
        flag_MSG_DATA        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_vect_ctl_42
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MASK_BIT                                   [0:0]            get_MASK_BIT
''                                                             set_MASK_BIT
''                                                             read_MASK_BIT
''                                                             write_MASK_BIT
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_42
    Private write_MASK_BIT_value
    Private read_MASK_BIT_value
    Private flag_MASK_BIT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H2ac
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MASK_BIT
        get_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let set_MASK_BIT(aData)
        write_MASK_BIT_value = aData
        flag_MASK_BIT        = &H1
    End Property

    Property Get read_MASK_BIT
        read
        read_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let write_MASK_BIT(aData)
        set_MASK_BIT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

    End Sub

    Sub write
        If flag_MASK_BIT = &H0 Then read
        If flag_MASK_BIT = &H0 Then write_MASK_BIT_value = get_MASK_BIT

        regValue = leftShift((write_MASK_BIT_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MASK_BIT_value = &H0
        flag_MASK_BIT        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_addr_43
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_ADDR                                   [31:0]           get_MSG_ADDR
''                                                             set_MSG_ADDR
''                                                             read_MSG_ADDR
''                                                             write_MSG_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_addr_43
    Private write_MSG_ADDR_value
    Private read_MSG_ADDR_value
    Private flag_MSG_ADDR

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H2b0
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MSG_ADDR
        get_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let set_MSG_ADDR(aData)
        write_MSG_ADDR_value = aData
        flag_MSG_ADDR        = &H1
    End Property

    Property Get read_MSG_ADDR
        read
        read_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let write_MSG_ADDR(aData)
        set_MSG_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_ADDR = &H0 Then read
        If flag_MSG_ADDR = &H0 Then write_MSG_ADDR_value = get_MSG_ADDR

        regValue = leftShift(write_MSG_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_ADDR_value = &H0
        flag_MSG_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_uppr_addr_43
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_UPPR_ADDR                              [31:0]           get_MSG_UPPR_ADDR
''                                                             set_MSG_UPPR_ADDR
''                                                             read_MSG_UPPR_ADDR
''                                                             write_MSG_UPPR_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_43
    Private write_MSG_UPPR_ADDR_value
    Private read_MSG_UPPR_ADDR_value
    Private flag_MSG_UPPR_ADDR

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H2b4
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MSG_UPPR_ADDR
        get_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let set_MSG_UPPR_ADDR(aData)
        write_MSG_UPPR_ADDR_value = aData
        flag_MSG_UPPR_ADDR        = &H1
    End Property

    Property Get read_MSG_UPPR_ADDR
        read
        read_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let write_MSG_UPPR_ADDR(aData)
        set_MSG_UPPR_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_UPPR_ADDR = &H0 Then read
        If flag_MSG_UPPR_ADDR = &H0 Then write_MSG_UPPR_ADDR_value = get_MSG_UPPR_ADDR

        regValue = leftShift(write_MSG_UPPR_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_UPPR_ADDR_value = &H0
        flag_MSG_UPPR_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_data_43
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_DATA                                   [31:0]           get_MSG_DATA
''                                                             set_MSG_DATA
''                                                             read_MSG_DATA
''                                                             write_MSG_DATA
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_data_43
    Private write_MSG_DATA_value
    Private read_MSG_DATA_value
    Private flag_MSG_DATA

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H2b8
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MSG_DATA
        get_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let set_MSG_DATA(aData)
        write_MSG_DATA_value = aData
        flag_MSG_DATA        = &H1
    End Property

    Property Get read_MSG_DATA
        read
        read_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let write_MSG_DATA(aData)
        set_MSG_DATA = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

    End Sub

    Sub write
        If flag_MSG_DATA = &H0 Then read
        If flag_MSG_DATA = &H0 Then write_MSG_DATA_value = get_MSG_DATA

        regValue = leftShift(write_MSG_DATA_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_DATA_value = &H0
        flag_MSG_DATA        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_vect_ctl_43
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MASK_BIT                                   [0:0]            get_MASK_BIT
''                                                             set_MASK_BIT
''                                                             read_MASK_BIT
''                                                             write_MASK_BIT
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_43
    Private write_MASK_BIT_value
    Private read_MASK_BIT_value
    Private flag_MASK_BIT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H2bc
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MASK_BIT
        get_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let set_MASK_BIT(aData)
        write_MASK_BIT_value = aData
        flag_MASK_BIT        = &H1
    End Property

    Property Get read_MASK_BIT
        read
        read_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let write_MASK_BIT(aData)
        set_MASK_BIT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

    End Sub

    Sub write
        If flag_MASK_BIT = &H0 Then read
        If flag_MASK_BIT = &H0 Then write_MASK_BIT_value = get_MASK_BIT

        regValue = leftShift((write_MASK_BIT_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MASK_BIT_value = &H0
        flag_MASK_BIT        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_addr_44
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_ADDR                                   [31:0]           get_MSG_ADDR
''                                                             set_MSG_ADDR
''                                                             read_MSG_ADDR
''                                                             write_MSG_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_addr_44
    Private write_MSG_ADDR_value
    Private read_MSG_ADDR_value
    Private flag_MSG_ADDR

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H2c0
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MSG_ADDR
        get_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let set_MSG_ADDR(aData)
        write_MSG_ADDR_value = aData
        flag_MSG_ADDR        = &H1
    End Property

    Property Get read_MSG_ADDR
        read
        read_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let write_MSG_ADDR(aData)
        set_MSG_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_ADDR = &H0 Then read
        If flag_MSG_ADDR = &H0 Then write_MSG_ADDR_value = get_MSG_ADDR

        regValue = leftShift(write_MSG_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_ADDR_value = &H0
        flag_MSG_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_uppr_addr_44
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_UPPR_ADDR                              [31:0]           get_MSG_UPPR_ADDR
''                                                             set_MSG_UPPR_ADDR
''                                                             read_MSG_UPPR_ADDR
''                                                             write_MSG_UPPR_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_44
    Private write_MSG_UPPR_ADDR_value
    Private read_MSG_UPPR_ADDR_value
    Private flag_MSG_UPPR_ADDR

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H2c4
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MSG_UPPR_ADDR
        get_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let set_MSG_UPPR_ADDR(aData)
        write_MSG_UPPR_ADDR_value = aData
        flag_MSG_UPPR_ADDR        = &H1
    End Property

    Property Get read_MSG_UPPR_ADDR
        read
        read_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let write_MSG_UPPR_ADDR(aData)
        set_MSG_UPPR_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_UPPR_ADDR = &H0 Then read
        If flag_MSG_UPPR_ADDR = &H0 Then write_MSG_UPPR_ADDR_value = get_MSG_UPPR_ADDR

        regValue = leftShift(write_MSG_UPPR_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_UPPR_ADDR_value = &H0
        flag_MSG_UPPR_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_data_44
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_DATA                                   [31:0]           get_MSG_DATA
''                                                             set_MSG_DATA
''                                                             read_MSG_DATA
''                                                             write_MSG_DATA
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_data_44
    Private write_MSG_DATA_value
    Private read_MSG_DATA_value
    Private flag_MSG_DATA

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H2c8
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MSG_DATA
        get_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let set_MSG_DATA(aData)
        write_MSG_DATA_value = aData
        flag_MSG_DATA        = &H1
    End Property

    Property Get read_MSG_DATA
        read
        read_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let write_MSG_DATA(aData)
        set_MSG_DATA = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

    End Sub

    Sub write
        If flag_MSG_DATA = &H0 Then read
        If flag_MSG_DATA = &H0 Then write_MSG_DATA_value = get_MSG_DATA

        regValue = leftShift(write_MSG_DATA_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_DATA_value = &H0
        flag_MSG_DATA        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_vect_ctl_44
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MASK_BIT                                   [0:0]            get_MASK_BIT
''                                                             set_MASK_BIT
''                                                             read_MASK_BIT
''                                                             write_MASK_BIT
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_44
    Private write_MASK_BIT_value
    Private read_MASK_BIT_value
    Private flag_MASK_BIT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H2cc
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MASK_BIT
        get_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let set_MASK_BIT(aData)
        write_MASK_BIT_value = aData
        flag_MASK_BIT        = &H1
    End Property

    Property Get read_MASK_BIT
        read
        read_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let write_MASK_BIT(aData)
        set_MASK_BIT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

    End Sub

    Sub write
        If flag_MASK_BIT = &H0 Then read
        If flag_MASK_BIT = &H0 Then write_MASK_BIT_value = get_MASK_BIT

        regValue = leftShift((write_MASK_BIT_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MASK_BIT_value = &H0
        flag_MASK_BIT        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_addr_45
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_ADDR                                   [31:0]           get_MSG_ADDR
''                                                             set_MSG_ADDR
''                                                             read_MSG_ADDR
''                                                             write_MSG_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_addr_45
    Private write_MSG_ADDR_value
    Private read_MSG_ADDR_value
    Private flag_MSG_ADDR

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H2d0
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MSG_ADDR
        get_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let set_MSG_ADDR(aData)
        write_MSG_ADDR_value = aData
        flag_MSG_ADDR        = &H1
    End Property

    Property Get read_MSG_ADDR
        read
        read_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let write_MSG_ADDR(aData)
        set_MSG_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_ADDR = &H0 Then read
        If flag_MSG_ADDR = &H0 Then write_MSG_ADDR_value = get_MSG_ADDR

        regValue = leftShift(write_MSG_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_ADDR_value = &H0
        flag_MSG_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_uppr_addr_45
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_UPPR_ADDR                              [31:0]           get_MSG_UPPR_ADDR
''                                                             set_MSG_UPPR_ADDR
''                                                             read_MSG_UPPR_ADDR
''                                                             write_MSG_UPPR_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_45
    Private write_MSG_UPPR_ADDR_value
    Private read_MSG_UPPR_ADDR_value
    Private flag_MSG_UPPR_ADDR

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H2d4
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MSG_UPPR_ADDR
        get_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let set_MSG_UPPR_ADDR(aData)
        write_MSG_UPPR_ADDR_value = aData
        flag_MSG_UPPR_ADDR        = &H1
    End Property

    Property Get read_MSG_UPPR_ADDR
        read
        read_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let write_MSG_UPPR_ADDR(aData)
        set_MSG_UPPR_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_UPPR_ADDR = &H0 Then read
        If flag_MSG_UPPR_ADDR = &H0 Then write_MSG_UPPR_ADDR_value = get_MSG_UPPR_ADDR

        regValue = leftShift(write_MSG_UPPR_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_UPPR_ADDR_value = &H0
        flag_MSG_UPPR_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_data_45
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_DATA                                   [31:0]           get_MSG_DATA
''                                                             set_MSG_DATA
''                                                             read_MSG_DATA
''                                                             write_MSG_DATA
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_data_45
    Private write_MSG_DATA_value
    Private read_MSG_DATA_value
    Private flag_MSG_DATA

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H2d8
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MSG_DATA
        get_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let set_MSG_DATA(aData)
        write_MSG_DATA_value = aData
        flag_MSG_DATA        = &H1
    End Property

    Property Get read_MSG_DATA
        read
        read_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let write_MSG_DATA(aData)
        set_MSG_DATA = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

    End Sub

    Sub write
        If flag_MSG_DATA = &H0 Then read
        If flag_MSG_DATA = &H0 Then write_MSG_DATA_value = get_MSG_DATA

        regValue = leftShift(write_MSG_DATA_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_DATA_value = &H0
        flag_MSG_DATA        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_vect_ctl_45
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MASK_BIT                                   [0:0]            get_MASK_BIT
''                                                             set_MASK_BIT
''                                                             read_MASK_BIT
''                                                             write_MASK_BIT
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_45
    Private write_MASK_BIT_value
    Private read_MASK_BIT_value
    Private flag_MASK_BIT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H2dc
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MASK_BIT
        get_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let set_MASK_BIT(aData)
        write_MASK_BIT_value = aData
        flag_MASK_BIT        = &H1
    End Property

    Property Get read_MASK_BIT
        read
        read_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let write_MASK_BIT(aData)
        set_MASK_BIT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

    End Sub

    Sub write
        If flag_MASK_BIT = &H0 Then read
        If flag_MASK_BIT = &H0 Then write_MASK_BIT_value = get_MASK_BIT

        regValue = leftShift((write_MASK_BIT_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MASK_BIT_value = &H0
        flag_MASK_BIT        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_addr_46
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_ADDR                                   [31:0]           get_MSG_ADDR
''                                                             set_MSG_ADDR
''                                                             read_MSG_ADDR
''                                                             write_MSG_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_addr_46
    Private write_MSG_ADDR_value
    Private read_MSG_ADDR_value
    Private flag_MSG_ADDR

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H2e0
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MSG_ADDR
        get_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let set_MSG_ADDR(aData)
        write_MSG_ADDR_value = aData
        flag_MSG_ADDR        = &H1
    End Property

    Property Get read_MSG_ADDR
        read
        read_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let write_MSG_ADDR(aData)
        set_MSG_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_ADDR = &H0 Then read
        If flag_MSG_ADDR = &H0 Then write_MSG_ADDR_value = get_MSG_ADDR

        regValue = leftShift(write_MSG_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_ADDR_value = &H0
        flag_MSG_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_uppr_addr_46
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_UPPR_ADDR                              [31:0]           get_MSG_UPPR_ADDR
''                                                             set_MSG_UPPR_ADDR
''                                                             read_MSG_UPPR_ADDR
''                                                             write_MSG_UPPR_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_46
    Private write_MSG_UPPR_ADDR_value
    Private read_MSG_UPPR_ADDR_value
    Private flag_MSG_UPPR_ADDR

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H2e4
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MSG_UPPR_ADDR
        get_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let set_MSG_UPPR_ADDR(aData)
        write_MSG_UPPR_ADDR_value = aData
        flag_MSG_UPPR_ADDR        = &H1
    End Property

    Property Get read_MSG_UPPR_ADDR
        read
        read_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let write_MSG_UPPR_ADDR(aData)
        set_MSG_UPPR_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_UPPR_ADDR = &H0 Then read
        If flag_MSG_UPPR_ADDR = &H0 Then write_MSG_UPPR_ADDR_value = get_MSG_UPPR_ADDR

        regValue = leftShift(write_MSG_UPPR_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_UPPR_ADDR_value = &H0
        flag_MSG_UPPR_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_data_46
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_DATA                                   [31:0]           get_MSG_DATA
''                                                             set_MSG_DATA
''                                                             read_MSG_DATA
''                                                             write_MSG_DATA
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_data_46
    Private write_MSG_DATA_value
    Private read_MSG_DATA_value
    Private flag_MSG_DATA

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H2e8
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MSG_DATA
        get_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let set_MSG_DATA(aData)
        write_MSG_DATA_value = aData
        flag_MSG_DATA        = &H1
    End Property

    Property Get read_MSG_DATA
        read
        read_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let write_MSG_DATA(aData)
        set_MSG_DATA = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

    End Sub

    Sub write
        If flag_MSG_DATA = &H0 Then read
        If flag_MSG_DATA = &H0 Then write_MSG_DATA_value = get_MSG_DATA

        regValue = leftShift(write_MSG_DATA_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_DATA_value = &H0
        flag_MSG_DATA        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_vect_ctl_46
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MASK_BIT                                   [0:0]            get_MASK_BIT
''                                                             set_MASK_BIT
''                                                             read_MASK_BIT
''                                                             write_MASK_BIT
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_46
    Private write_MASK_BIT_value
    Private read_MASK_BIT_value
    Private flag_MASK_BIT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H2ec
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MASK_BIT
        get_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let set_MASK_BIT(aData)
        write_MASK_BIT_value = aData
        flag_MASK_BIT        = &H1
    End Property

    Property Get read_MASK_BIT
        read
        read_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let write_MASK_BIT(aData)
        set_MASK_BIT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

    End Sub

    Sub write
        If flag_MASK_BIT = &H0 Then read
        If flag_MASK_BIT = &H0 Then write_MASK_BIT_value = get_MASK_BIT

        regValue = leftShift((write_MASK_BIT_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MASK_BIT_value = &H0
        flag_MASK_BIT        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_addr_47
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_ADDR                                   [31:0]           get_MSG_ADDR
''                                                             set_MSG_ADDR
''                                                             read_MSG_ADDR
''                                                             write_MSG_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_addr_47
    Private write_MSG_ADDR_value
    Private read_MSG_ADDR_value
    Private flag_MSG_ADDR

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H2f0
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MSG_ADDR
        get_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let set_MSG_ADDR(aData)
        write_MSG_ADDR_value = aData
        flag_MSG_ADDR        = &H1
    End Property

    Property Get read_MSG_ADDR
        read
        read_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let write_MSG_ADDR(aData)
        set_MSG_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_ADDR = &H0 Then read
        If flag_MSG_ADDR = &H0 Then write_MSG_ADDR_value = get_MSG_ADDR

        regValue = leftShift(write_MSG_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_ADDR_value = &H0
        flag_MSG_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_uppr_addr_47
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_UPPR_ADDR                              [31:0]           get_MSG_UPPR_ADDR
''                                                             set_MSG_UPPR_ADDR
''                                                             read_MSG_UPPR_ADDR
''                                                             write_MSG_UPPR_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_47
    Private write_MSG_UPPR_ADDR_value
    Private read_MSG_UPPR_ADDR_value
    Private flag_MSG_UPPR_ADDR

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H2f4
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MSG_UPPR_ADDR
        get_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let set_MSG_UPPR_ADDR(aData)
        write_MSG_UPPR_ADDR_value = aData
        flag_MSG_UPPR_ADDR        = &H1
    End Property

    Property Get read_MSG_UPPR_ADDR
        read
        read_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let write_MSG_UPPR_ADDR(aData)
        set_MSG_UPPR_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_UPPR_ADDR = &H0 Then read
        If flag_MSG_UPPR_ADDR = &H0 Then write_MSG_UPPR_ADDR_value = get_MSG_UPPR_ADDR

        regValue = leftShift(write_MSG_UPPR_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_UPPR_ADDR_value = &H0
        flag_MSG_UPPR_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_data_47
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_DATA                                   [31:0]           get_MSG_DATA
''                                                             set_MSG_DATA
''                                                             read_MSG_DATA
''                                                             write_MSG_DATA
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_data_47
    Private write_MSG_DATA_value
    Private read_MSG_DATA_value
    Private flag_MSG_DATA

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H2f8
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MSG_DATA
        get_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let set_MSG_DATA(aData)
        write_MSG_DATA_value = aData
        flag_MSG_DATA        = &H1
    End Property

    Property Get read_MSG_DATA
        read
        read_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let write_MSG_DATA(aData)
        set_MSG_DATA = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

    End Sub

    Sub write
        If flag_MSG_DATA = &H0 Then read
        If flag_MSG_DATA = &H0 Then write_MSG_DATA_value = get_MSG_DATA

        regValue = leftShift(write_MSG_DATA_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_DATA_value = &H0
        flag_MSG_DATA        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_vect_ctl_47
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MASK_BIT                                   [0:0]            get_MASK_BIT
''                                                             set_MASK_BIT
''                                                             read_MASK_BIT
''                                                             write_MASK_BIT
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_47
    Private write_MASK_BIT_value
    Private read_MASK_BIT_value
    Private flag_MASK_BIT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H2fc
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MASK_BIT
        get_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let set_MASK_BIT(aData)
        write_MASK_BIT_value = aData
        flag_MASK_BIT        = &H1
    End Property

    Property Get read_MASK_BIT
        read
        read_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let write_MASK_BIT(aData)
        set_MASK_BIT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

    End Sub

    Sub write
        If flag_MASK_BIT = &H0 Then read
        If flag_MASK_BIT = &H0 Then write_MASK_BIT_value = get_MASK_BIT

        regValue = leftShift((write_MASK_BIT_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MASK_BIT_value = &H0
        flag_MASK_BIT        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_addr_48
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_ADDR                                   [31:0]           get_MSG_ADDR
''                                                             set_MSG_ADDR
''                                                             read_MSG_ADDR
''                                                             write_MSG_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_addr_48
    Private write_MSG_ADDR_value
    Private read_MSG_ADDR_value
    Private flag_MSG_ADDR

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H300
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MSG_ADDR
        get_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let set_MSG_ADDR(aData)
        write_MSG_ADDR_value = aData
        flag_MSG_ADDR        = &H1
    End Property

    Property Get read_MSG_ADDR
        read
        read_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let write_MSG_ADDR(aData)
        set_MSG_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_ADDR = &H0 Then read
        If flag_MSG_ADDR = &H0 Then write_MSG_ADDR_value = get_MSG_ADDR

        regValue = leftShift(write_MSG_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_ADDR_value = &H0
        flag_MSG_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_uppr_addr_48
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_UPPR_ADDR                              [31:0]           get_MSG_UPPR_ADDR
''                                                             set_MSG_UPPR_ADDR
''                                                             read_MSG_UPPR_ADDR
''                                                             write_MSG_UPPR_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_48
    Private write_MSG_UPPR_ADDR_value
    Private read_MSG_UPPR_ADDR_value
    Private flag_MSG_UPPR_ADDR

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H304
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MSG_UPPR_ADDR
        get_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let set_MSG_UPPR_ADDR(aData)
        write_MSG_UPPR_ADDR_value = aData
        flag_MSG_UPPR_ADDR        = &H1
    End Property

    Property Get read_MSG_UPPR_ADDR
        read
        read_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let write_MSG_UPPR_ADDR(aData)
        set_MSG_UPPR_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_UPPR_ADDR = &H0 Then read
        If flag_MSG_UPPR_ADDR = &H0 Then write_MSG_UPPR_ADDR_value = get_MSG_UPPR_ADDR

        regValue = leftShift(write_MSG_UPPR_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_UPPR_ADDR_value = &H0
        flag_MSG_UPPR_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_data_48
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_DATA                                   [31:0]           get_MSG_DATA
''                                                             set_MSG_DATA
''                                                             read_MSG_DATA
''                                                             write_MSG_DATA
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_data_48
    Private write_MSG_DATA_value
    Private read_MSG_DATA_value
    Private flag_MSG_DATA

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H308
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MSG_DATA
        get_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let set_MSG_DATA(aData)
        write_MSG_DATA_value = aData
        flag_MSG_DATA        = &H1
    End Property

    Property Get read_MSG_DATA
        read
        read_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let write_MSG_DATA(aData)
        set_MSG_DATA = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

    End Sub

    Sub write
        If flag_MSG_DATA = &H0 Then read
        If flag_MSG_DATA = &H0 Then write_MSG_DATA_value = get_MSG_DATA

        regValue = leftShift(write_MSG_DATA_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_DATA_value = &H0
        flag_MSG_DATA        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_vect_ctl_48
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MASK_BIT                                   [0:0]            get_MASK_BIT
''                                                             set_MASK_BIT
''                                                             read_MASK_BIT
''                                                             write_MASK_BIT
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_48
    Private write_MASK_BIT_value
    Private read_MASK_BIT_value
    Private flag_MASK_BIT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H30c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MASK_BIT
        get_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let set_MASK_BIT(aData)
        write_MASK_BIT_value = aData
        flag_MASK_BIT        = &H1
    End Property

    Property Get read_MASK_BIT
        read
        read_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let write_MASK_BIT(aData)
        set_MASK_BIT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

    End Sub

    Sub write
        If flag_MASK_BIT = &H0 Then read
        If flag_MASK_BIT = &H0 Then write_MASK_BIT_value = get_MASK_BIT

        regValue = leftShift((write_MASK_BIT_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MASK_BIT_value = &H0
        flag_MASK_BIT        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_addr_49
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_ADDR                                   [31:0]           get_MSG_ADDR
''                                                             set_MSG_ADDR
''                                                             read_MSG_ADDR
''                                                             write_MSG_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_addr_49
    Private write_MSG_ADDR_value
    Private read_MSG_ADDR_value
    Private flag_MSG_ADDR

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H310
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MSG_ADDR
        get_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let set_MSG_ADDR(aData)
        write_MSG_ADDR_value = aData
        flag_MSG_ADDR        = &H1
    End Property

    Property Get read_MSG_ADDR
        read
        read_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let write_MSG_ADDR(aData)
        set_MSG_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_ADDR = &H0 Then read
        If flag_MSG_ADDR = &H0 Then write_MSG_ADDR_value = get_MSG_ADDR

        regValue = leftShift(write_MSG_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_ADDR_value = &H0
        flag_MSG_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_uppr_addr_49
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_UPPR_ADDR                              [31:0]           get_MSG_UPPR_ADDR
''                                                             set_MSG_UPPR_ADDR
''                                                             read_MSG_UPPR_ADDR
''                                                             write_MSG_UPPR_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_49
    Private write_MSG_UPPR_ADDR_value
    Private read_MSG_UPPR_ADDR_value
    Private flag_MSG_UPPR_ADDR

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H314
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MSG_UPPR_ADDR
        get_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let set_MSG_UPPR_ADDR(aData)
        write_MSG_UPPR_ADDR_value = aData
        flag_MSG_UPPR_ADDR        = &H1
    End Property

    Property Get read_MSG_UPPR_ADDR
        read
        read_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let write_MSG_UPPR_ADDR(aData)
        set_MSG_UPPR_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_UPPR_ADDR = &H0 Then read
        If flag_MSG_UPPR_ADDR = &H0 Then write_MSG_UPPR_ADDR_value = get_MSG_UPPR_ADDR

        regValue = leftShift(write_MSG_UPPR_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_UPPR_ADDR_value = &H0
        flag_MSG_UPPR_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_data_49
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_DATA                                   [31:0]           get_MSG_DATA
''                                                             set_MSG_DATA
''                                                             read_MSG_DATA
''                                                             write_MSG_DATA
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_data_49
    Private write_MSG_DATA_value
    Private read_MSG_DATA_value
    Private flag_MSG_DATA

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H318
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MSG_DATA
        get_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let set_MSG_DATA(aData)
        write_MSG_DATA_value = aData
        flag_MSG_DATA        = &H1
    End Property

    Property Get read_MSG_DATA
        read
        read_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let write_MSG_DATA(aData)
        set_MSG_DATA = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

    End Sub

    Sub write
        If flag_MSG_DATA = &H0 Then read
        If flag_MSG_DATA = &H0 Then write_MSG_DATA_value = get_MSG_DATA

        regValue = leftShift(write_MSG_DATA_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_DATA_value = &H0
        flag_MSG_DATA        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_vect_ctl_49
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MASK_BIT                                   [0:0]            get_MASK_BIT
''                                                             set_MASK_BIT
''                                                             read_MASK_BIT
''                                                             write_MASK_BIT
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_49
    Private write_MASK_BIT_value
    Private read_MASK_BIT_value
    Private flag_MASK_BIT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H31c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MASK_BIT
        get_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let set_MASK_BIT(aData)
        write_MASK_BIT_value = aData
        flag_MASK_BIT        = &H1
    End Property

    Property Get read_MASK_BIT
        read
        read_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let write_MASK_BIT(aData)
        set_MASK_BIT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

    End Sub

    Sub write
        If flag_MASK_BIT = &H0 Then read
        If flag_MASK_BIT = &H0 Then write_MASK_BIT_value = get_MASK_BIT

        regValue = leftShift((write_MASK_BIT_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MASK_BIT_value = &H0
        flag_MASK_BIT        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_addr_50
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_ADDR                                   [31:0]           get_MSG_ADDR
''                                                             set_MSG_ADDR
''                                                             read_MSG_ADDR
''                                                             write_MSG_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_addr_50
    Private write_MSG_ADDR_value
    Private read_MSG_ADDR_value
    Private flag_MSG_ADDR

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H320
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MSG_ADDR
        get_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let set_MSG_ADDR(aData)
        write_MSG_ADDR_value = aData
        flag_MSG_ADDR        = &H1
    End Property

    Property Get read_MSG_ADDR
        read
        read_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let write_MSG_ADDR(aData)
        set_MSG_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_ADDR = &H0 Then read
        If flag_MSG_ADDR = &H0 Then write_MSG_ADDR_value = get_MSG_ADDR

        regValue = leftShift(write_MSG_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_ADDR_value = &H0
        flag_MSG_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_uppr_addr_50
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_UPPR_ADDR                              [31:0]           get_MSG_UPPR_ADDR
''                                                             set_MSG_UPPR_ADDR
''                                                             read_MSG_UPPR_ADDR
''                                                             write_MSG_UPPR_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_50
    Private write_MSG_UPPR_ADDR_value
    Private read_MSG_UPPR_ADDR_value
    Private flag_MSG_UPPR_ADDR

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H324
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MSG_UPPR_ADDR
        get_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let set_MSG_UPPR_ADDR(aData)
        write_MSG_UPPR_ADDR_value = aData
        flag_MSG_UPPR_ADDR        = &H1
    End Property

    Property Get read_MSG_UPPR_ADDR
        read
        read_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let write_MSG_UPPR_ADDR(aData)
        set_MSG_UPPR_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_UPPR_ADDR = &H0 Then read
        If flag_MSG_UPPR_ADDR = &H0 Then write_MSG_UPPR_ADDR_value = get_MSG_UPPR_ADDR

        regValue = leftShift(write_MSG_UPPR_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_UPPR_ADDR_value = &H0
        flag_MSG_UPPR_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_data_50
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_DATA                                   [31:0]           get_MSG_DATA
''                                                             set_MSG_DATA
''                                                             read_MSG_DATA
''                                                             write_MSG_DATA
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_data_50
    Private write_MSG_DATA_value
    Private read_MSG_DATA_value
    Private flag_MSG_DATA

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H328
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MSG_DATA
        get_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let set_MSG_DATA(aData)
        write_MSG_DATA_value = aData
        flag_MSG_DATA        = &H1
    End Property

    Property Get read_MSG_DATA
        read
        read_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let write_MSG_DATA(aData)
        set_MSG_DATA = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

    End Sub

    Sub write
        If flag_MSG_DATA = &H0 Then read
        If flag_MSG_DATA = &H0 Then write_MSG_DATA_value = get_MSG_DATA

        regValue = leftShift(write_MSG_DATA_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_DATA_value = &H0
        flag_MSG_DATA        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_vect_ctl_50
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MASK_BIT                                   [0:0]            get_MASK_BIT
''                                                             set_MASK_BIT
''                                                             read_MASK_BIT
''                                                             write_MASK_BIT
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_50
    Private write_MASK_BIT_value
    Private read_MASK_BIT_value
    Private flag_MASK_BIT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H32c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MASK_BIT
        get_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let set_MASK_BIT(aData)
        write_MASK_BIT_value = aData
        flag_MASK_BIT        = &H1
    End Property

    Property Get read_MASK_BIT
        read
        read_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let write_MASK_BIT(aData)
        set_MASK_BIT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

    End Sub

    Sub write
        If flag_MASK_BIT = &H0 Then read
        If flag_MASK_BIT = &H0 Then write_MASK_BIT_value = get_MASK_BIT

        regValue = leftShift((write_MASK_BIT_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MASK_BIT_value = &H0
        flag_MASK_BIT        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_addr_51
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_ADDR                                   [31:0]           get_MSG_ADDR
''                                                             set_MSG_ADDR
''                                                             read_MSG_ADDR
''                                                             write_MSG_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_addr_51
    Private write_MSG_ADDR_value
    Private read_MSG_ADDR_value
    Private flag_MSG_ADDR

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H330
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MSG_ADDR
        get_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let set_MSG_ADDR(aData)
        write_MSG_ADDR_value = aData
        flag_MSG_ADDR        = &H1
    End Property

    Property Get read_MSG_ADDR
        read
        read_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let write_MSG_ADDR(aData)
        set_MSG_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_ADDR = &H0 Then read
        If flag_MSG_ADDR = &H0 Then write_MSG_ADDR_value = get_MSG_ADDR

        regValue = leftShift(write_MSG_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_ADDR_value = &H0
        flag_MSG_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_uppr_addr_51
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_UPPR_ADDR                              [31:0]           get_MSG_UPPR_ADDR
''                                                             set_MSG_UPPR_ADDR
''                                                             read_MSG_UPPR_ADDR
''                                                             write_MSG_UPPR_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_51
    Private write_MSG_UPPR_ADDR_value
    Private read_MSG_UPPR_ADDR_value
    Private flag_MSG_UPPR_ADDR

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H334
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MSG_UPPR_ADDR
        get_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let set_MSG_UPPR_ADDR(aData)
        write_MSG_UPPR_ADDR_value = aData
        flag_MSG_UPPR_ADDR        = &H1
    End Property

    Property Get read_MSG_UPPR_ADDR
        read
        read_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let write_MSG_UPPR_ADDR(aData)
        set_MSG_UPPR_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_UPPR_ADDR = &H0 Then read
        If flag_MSG_UPPR_ADDR = &H0 Then write_MSG_UPPR_ADDR_value = get_MSG_UPPR_ADDR

        regValue = leftShift(write_MSG_UPPR_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_UPPR_ADDR_value = &H0
        flag_MSG_UPPR_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_data_51
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_DATA                                   [31:0]           get_MSG_DATA
''                                                             set_MSG_DATA
''                                                             read_MSG_DATA
''                                                             write_MSG_DATA
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_data_51
    Private write_MSG_DATA_value
    Private read_MSG_DATA_value
    Private flag_MSG_DATA

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H338
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MSG_DATA
        get_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let set_MSG_DATA(aData)
        write_MSG_DATA_value = aData
        flag_MSG_DATA        = &H1
    End Property

    Property Get read_MSG_DATA
        read
        read_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let write_MSG_DATA(aData)
        set_MSG_DATA = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

    End Sub

    Sub write
        If flag_MSG_DATA = &H0 Then read
        If flag_MSG_DATA = &H0 Then write_MSG_DATA_value = get_MSG_DATA

        regValue = leftShift(write_MSG_DATA_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_DATA_value = &H0
        flag_MSG_DATA        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_vect_ctl_51
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MASK_BIT                                   [0:0]            get_MASK_BIT
''                                                             set_MASK_BIT
''                                                             read_MASK_BIT
''                                                             write_MASK_BIT
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_51
    Private write_MASK_BIT_value
    Private read_MASK_BIT_value
    Private flag_MASK_BIT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H33c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MASK_BIT
        get_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let set_MASK_BIT(aData)
        write_MASK_BIT_value = aData
        flag_MASK_BIT        = &H1
    End Property

    Property Get read_MASK_BIT
        read
        read_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let write_MASK_BIT(aData)
        set_MASK_BIT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

    End Sub

    Sub write
        If flag_MASK_BIT = &H0 Then read
        If flag_MASK_BIT = &H0 Then write_MASK_BIT_value = get_MASK_BIT

        regValue = leftShift((write_MASK_BIT_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MASK_BIT_value = &H0
        flag_MASK_BIT        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_addr_52
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_ADDR                                   [31:0]           get_MSG_ADDR
''                                                             set_MSG_ADDR
''                                                             read_MSG_ADDR
''                                                             write_MSG_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_addr_52
    Private write_MSG_ADDR_value
    Private read_MSG_ADDR_value
    Private flag_MSG_ADDR

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H340
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MSG_ADDR
        get_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let set_MSG_ADDR(aData)
        write_MSG_ADDR_value = aData
        flag_MSG_ADDR        = &H1
    End Property

    Property Get read_MSG_ADDR
        read
        read_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let write_MSG_ADDR(aData)
        set_MSG_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_ADDR = &H0 Then read
        If flag_MSG_ADDR = &H0 Then write_MSG_ADDR_value = get_MSG_ADDR

        regValue = leftShift(write_MSG_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_ADDR_value = &H0
        flag_MSG_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_uppr_addr_52
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_UPPR_ADDR                              [31:0]           get_MSG_UPPR_ADDR
''                                                             set_MSG_UPPR_ADDR
''                                                             read_MSG_UPPR_ADDR
''                                                             write_MSG_UPPR_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_52
    Private write_MSG_UPPR_ADDR_value
    Private read_MSG_UPPR_ADDR_value
    Private flag_MSG_UPPR_ADDR

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H344
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MSG_UPPR_ADDR
        get_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let set_MSG_UPPR_ADDR(aData)
        write_MSG_UPPR_ADDR_value = aData
        flag_MSG_UPPR_ADDR        = &H1
    End Property

    Property Get read_MSG_UPPR_ADDR
        read
        read_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let write_MSG_UPPR_ADDR(aData)
        set_MSG_UPPR_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_UPPR_ADDR = &H0 Then read
        If flag_MSG_UPPR_ADDR = &H0 Then write_MSG_UPPR_ADDR_value = get_MSG_UPPR_ADDR

        regValue = leftShift(write_MSG_UPPR_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_UPPR_ADDR_value = &H0
        flag_MSG_UPPR_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_data_52
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_DATA                                   [31:0]           get_MSG_DATA
''                                                             set_MSG_DATA
''                                                             read_MSG_DATA
''                                                             write_MSG_DATA
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_data_52
    Private write_MSG_DATA_value
    Private read_MSG_DATA_value
    Private flag_MSG_DATA

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H348
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MSG_DATA
        get_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let set_MSG_DATA(aData)
        write_MSG_DATA_value = aData
        flag_MSG_DATA        = &H1
    End Property

    Property Get read_MSG_DATA
        read
        read_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let write_MSG_DATA(aData)
        set_MSG_DATA = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

    End Sub

    Sub write
        If flag_MSG_DATA = &H0 Then read
        If flag_MSG_DATA = &H0 Then write_MSG_DATA_value = get_MSG_DATA

        regValue = leftShift(write_MSG_DATA_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_DATA_value = &H0
        flag_MSG_DATA        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_vect_ctl_52
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MASK_BIT                                   [0:0]            get_MASK_BIT
''                                                             set_MASK_BIT
''                                                             read_MASK_BIT
''                                                             write_MASK_BIT
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_52
    Private write_MASK_BIT_value
    Private read_MASK_BIT_value
    Private flag_MASK_BIT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H34c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MASK_BIT
        get_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let set_MASK_BIT(aData)
        write_MASK_BIT_value = aData
        flag_MASK_BIT        = &H1
    End Property

    Property Get read_MASK_BIT
        read
        read_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let write_MASK_BIT(aData)
        set_MASK_BIT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

    End Sub

    Sub write
        If flag_MASK_BIT = &H0 Then read
        If flag_MASK_BIT = &H0 Then write_MASK_BIT_value = get_MASK_BIT

        regValue = leftShift((write_MASK_BIT_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MASK_BIT_value = &H0
        flag_MASK_BIT        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_addr_53
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_ADDR                                   [31:0]           get_MSG_ADDR
''                                                             set_MSG_ADDR
''                                                             read_MSG_ADDR
''                                                             write_MSG_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_addr_53
    Private write_MSG_ADDR_value
    Private read_MSG_ADDR_value
    Private flag_MSG_ADDR

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H350
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MSG_ADDR
        get_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let set_MSG_ADDR(aData)
        write_MSG_ADDR_value = aData
        flag_MSG_ADDR        = &H1
    End Property

    Property Get read_MSG_ADDR
        read
        read_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let write_MSG_ADDR(aData)
        set_MSG_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_ADDR = &H0 Then read
        If flag_MSG_ADDR = &H0 Then write_MSG_ADDR_value = get_MSG_ADDR

        regValue = leftShift(write_MSG_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_ADDR_value = &H0
        flag_MSG_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_uppr_addr_53
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_UPPR_ADDR                              [31:0]           get_MSG_UPPR_ADDR
''                                                             set_MSG_UPPR_ADDR
''                                                             read_MSG_UPPR_ADDR
''                                                             write_MSG_UPPR_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_53
    Private write_MSG_UPPR_ADDR_value
    Private read_MSG_UPPR_ADDR_value
    Private flag_MSG_UPPR_ADDR

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H354
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MSG_UPPR_ADDR
        get_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let set_MSG_UPPR_ADDR(aData)
        write_MSG_UPPR_ADDR_value = aData
        flag_MSG_UPPR_ADDR        = &H1
    End Property

    Property Get read_MSG_UPPR_ADDR
        read
        read_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let write_MSG_UPPR_ADDR(aData)
        set_MSG_UPPR_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_UPPR_ADDR = &H0 Then read
        If flag_MSG_UPPR_ADDR = &H0 Then write_MSG_UPPR_ADDR_value = get_MSG_UPPR_ADDR

        regValue = leftShift(write_MSG_UPPR_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_UPPR_ADDR_value = &H0
        flag_MSG_UPPR_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_data_53
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_DATA                                   [31:0]           get_MSG_DATA
''                                                             set_MSG_DATA
''                                                             read_MSG_DATA
''                                                             write_MSG_DATA
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_data_53
    Private write_MSG_DATA_value
    Private read_MSG_DATA_value
    Private flag_MSG_DATA

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H358
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MSG_DATA
        get_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let set_MSG_DATA(aData)
        write_MSG_DATA_value = aData
        flag_MSG_DATA        = &H1
    End Property

    Property Get read_MSG_DATA
        read
        read_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let write_MSG_DATA(aData)
        set_MSG_DATA = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

    End Sub

    Sub write
        If flag_MSG_DATA = &H0 Then read
        If flag_MSG_DATA = &H0 Then write_MSG_DATA_value = get_MSG_DATA

        regValue = leftShift(write_MSG_DATA_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_DATA_value = &H0
        flag_MSG_DATA        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_vect_ctl_53
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MASK_BIT                                   [0:0]            get_MASK_BIT
''                                                             set_MASK_BIT
''                                                             read_MASK_BIT
''                                                             write_MASK_BIT
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_53
    Private write_MASK_BIT_value
    Private read_MASK_BIT_value
    Private flag_MASK_BIT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H35c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MASK_BIT
        get_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let set_MASK_BIT(aData)
        write_MASK_BIT_value = aData
        flag_MASK_BIT        = &H1
    End Property

    Property Get read_MASK_BIT
        read
        read_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let write_MASK_BIT(aData)
        set_MASK_BIT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

    End Sub

    Sub write
        If flag_MASK_BIT = &H0 Then read
        If flag_MASK_BIT = &H0 Then write_MASK_BIT_value = get_MASK_BIT

        regValue = leftShift((write_MASK_BIT_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MASK_BIT_value = &H0
        flag_MASK_BIT        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_addr_54
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_ADDR                                   [31:0]           get_MSG_ADDR
''                                                             set_MSG_ADDR
''                                                             read_MSG_ADDR
''                                                             write_MSG_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_addr_54
    Private write_MSG_ADDR_value
    Private read_MSG_ADDR_value
    Private flag_MSG_ADDR

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H360
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MSG_ADDR
        get_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let set_MSG_ADDR(aData)
        write_MSG_ADDR_value = aData
        flag_MSG_ADDR        = &H1
    End Property

    Property Get read_MSG_ADDR
        read
        read_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let write_MSG_ADDR(aData)
        set_MSG_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_ADDR = &H0 Then read
        If flag_MSG_ADDR = &H0 Then write_MSG_ADDR_value = get_MSG_ADDR

        regValue = leftShift(write_MSG_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_ADDR_value = &H0
        flag_MSG_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_uppr_addr_54
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_UPPR_ADDR                              [31:0]           get_MSG_UPPR_ADDR
''                                                             set_MSG_UPPR_ADDR
''                                                             read_MSG_UPPR_ADDR
''                                                             write_MSG_UPPR_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_54
    Private write_MSG_UPPR_ADDR_value
    Private read_MSG_UPPR_ADDR_value
    Private flag_MSG_UPPR_ADDR

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H364
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MSG_UPPR_ADDR
        get_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let set_MSG_UPPR_ADDR(aData)
        write_MSG_UPPR_ADDR_value = aData
        flag_MSG_UPPR_ADDR        = &H1
    End Property

    Property Get read_MSG_UPPR_ADDR
        read
        read_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let write_MSG_UPPR_ADDR(aData)
        set_MSG_UPPR_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_UPPR_ADDR = &H0 Then read
        If flag_MSG_UPPR_ADDR = &H0 Then write_MSG_UPPR_ADDR_value = get_MSG_UPPR_ADDR

        regValue = leftShift(write_MSG_UPPR_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_UPPR_ADDR_value = &H0
        flag_MSG_UPPR_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_data_54
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_DATA                                   [31:0]           get_MSG_DATA
''                                                             set_MSG_DATA
''                                                             read_MSG_DATA
''                                                             write_MSG_DATA
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_data_54
    Private write_MSG_DATA_value
    Private read_MSG_DATA_value
    Private flag_MSG_DATA

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H368
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MSG_DATA
        get_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let set_MSG_DATA(aData)
        write_MSG_DATA_value = aData
        flag_MSG_DATA        = &H1
    End Property

    Property Get read_MSG_DATA
        read
        read_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let write_MSG_DATA(aData)
        set_MSG_DATA = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

    End Sub

    Sub write
        If flag_MSG_DATA = &H0 Then read
        If flag_MSG_DATA = &H0 Then write_MSG_DATA_value = get_MSG_DATA

        regValue = leftShift(write_MSG_DATA_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_DATA_value = &H0
        flag_MSG_DATA        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_vect_ctl_54
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MASK_BIT                                   [0:0]            get_MASK_BIT
''                                                             set_MASK_BIT
''                                                             read_MASK_BIT
''                                                             write_MASK_BIT
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_54
    Private write_MASK_BIT_value
    Private read_MASK_BIT_value
    Private flag_MASK_BIT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H36c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MASK_BIT
        get_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let set_MASK_BIT(aData)
        write_MASK_BIT_value = aData
        flag_MASK_BIT        = &H1
    End Property

    Property Get read_MASK_BIT
        read
        read_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let write_MASK_BIT(aData)
        set_MASK_BIT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

    End Sub

    Sub write
        If flag_MASK_BIT = &H0 Then read
        If flag_MASK_BIT = &H0 Then write_MASK_BIT_value = get_MASK_BIT

        regValue = leftShift((write_MASK_BIT_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MASK_BIT_value = &H0
        flag_MASK_BIT        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_addr_55
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_ADDR                                   [31:0]           get_MSG_ADDR
''                                                             set_MSG_ADDR
''                                                             read_MSG_ADDR
''                                                             write_MSG_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_addr_55
    Private write_MSG_ADDR_value
    Private read_MSG_ADDR_value
    Private flag_MSG_ADDR

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H370
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MSG_ADDR
        get_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let set_MSG_ADDR(aData)
        write_MSG_ADDR_value = aData
        flag_MSG_ADDR        = &H1
    End Property

    Property Get read_MSG_ADDR
        read
        read_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let write_MSG_ADDR(aData)
        set_MSG_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_ADDR = &H0 Then read
        If flag_MSG_ADDR = &H0 Then write_MSG_ADDR_value = get_MSG_ADDR

        regValue = leftShift(write_MSG_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_ADDR_value = &H0
        flag_MSG_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_uppr_addr_55
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_UPPR_ADDR                              [31:0]           get_MSG_UPPR_ADDR
''                                                             set_MSG_UPPR_ADDR
''                                                             read_MSG_UPPR_ADDR
''                                                             write_MSG_UPPR_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_55
    Private write_MSG_UPPR_ADDR_value
    Private read_MSG_UPPR_ADDR_value
    Private flag_MSG_UPPR_ADDR

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H374
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MSG_UPPR_ADDR
        get_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let set_MSG_UPPR_ADDR(aData)
        write_MSG_UPPR_ADDR_value = aData
        flag_MSG_UPPR_ADDR        = &H1
    End Property

    Property Get read_MSG_UPPR_ADDR
        read
        read_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let write_MSG_UPPR_ADDR(aData)
        set_MSG_UPPR_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_UPPR_ADDR = &H0 Then read
        If flag_MSG_UPPR_ADDR = &H0 Then write_MSG_UPPR_ADDR_value = get_MSG_UPPR_ADDR

        regValue = leftShift(write_MSG_UPPR_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_UPPR_ADDR_value = &H0
        flag_MSG_UPPR_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_data_55
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_DATA                                   [31:0]           get_MSG_DATA
''                                                             set_MSG_DATA
''                                                             read_MSG_DATA
''                                                             write_MSG_DATA
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_data_55
    Private write_MSG_DATA_value
    Private read_MSG_DATA_value
    Private flag_MSG_DATA

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H378
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MSG_DATA
        get_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let set_MSG_DATA(aData)
        write_MSG_DATA_value = aData
        flag_MSG_DATA        = &H1
    End Property

    Property Get read_MSG_DATA
        read
        read_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let write_MSG_DATA(aData)
        set_MSG_DATA = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

    End Sub

    Sub write
        If flag_MSG_DATA = &H0 Then read
        If flag_MSG_DATA = &H0 Then write_MSG_DATA_value = get_MSG_DATA

        regValue = leftShift(write_MSG_DATA_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_DATA_value = &H0
        flag_MSG_DATA        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_vect_ctl_55
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MASK_BIT                                   [0:0]            get_MASK_BIT
''                                                             set_MASK_BIT
''                                                             read_MASK_BIT
''                                                             write_MASK_BIT
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_55
    Private write_MASK_BIT_value
    Private read_MASK_BIT_value
    Private flag_MASK_BIT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H37c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MASK_BIT
        get_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let set_MASK_BIT(aData)
        write_MASK_BIT_value = aData
        flag_MASK_BIT        = &H1
    End Property

    Property Get read_MASK_BIT
        read
        read_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let write_MASK_BIT(aData)
        set_MASK_BIT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

    End Sub

    Sub write
        If flag_MASK_BIT = &H0 Then read
        If flag_MASK_BIT = &H0 Then write_MASK_BIT_value = get_MASK_BIT

        regValue = leftShift((write_MASK_BIT_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MASK_BIT_value = &H0
        flag_MASK_BIT        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_addr_56
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_ADDR                                   [31:0]           get_MSG_ADDR
''                                                             set_MSG_ADDR
''                                                             read_MSG_ADDR
''                                                             write_MSG_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_addr_56
    Private write_MSG_ADDR_value
    Private read_MSG_ADDR_value
    Private flag_MSG_ADDR

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H380
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MSG_ADDR
        get_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let set_MSG_ADDR(aData)
        write_MSG_ADDR_value = aData
        flag_MSG_ADDR        = &H1
    End Property

    Property Get read_MSG_ADDR
        read
        read_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let write_MSG_ADDR(aData)
        set_MSG_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_ADDR = &H0 Then read
        If flag_MSG_ADDR = &H0 Then write_MSG_ADDR_value = get_MSG_ADDR

        regValue = leftShift(write_MSG_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_ADDR_value = &H0
        flag_MSG_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_uppr_addr_56
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_UPPR_ADDR                              [31:0]           get_MSG_UPPR_ADDR
''                                                             set_MSG_UPPR_ADDR
''                                                             read_MSG_UPPR_ADDR
''                                                             write_MSG_UPPR_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_56
    Private write_MSG_UPPR_ADDR_value
    Private read_MSG_UPPR_ADDR_value
    Private flag_MSG_UPPR_ADDR

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H384
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MSG_UPPR_ADDR
        get_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let set_MSG_UPPR_ADDR(aData)
        write_MSG_UPPR_ADDR_value = aData
        flag_MSG_UPPR_ADDR        = &H1
    End Property

    Property Get read_MSG_UPPR_ADDR
        read
        read_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let write_MSG_UPPR_ADDR(aData)
        set_MSG_UPPR_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_UPPR_ADDR = &H0 Then read
        If flag_MSG_UPPR_ADDR = &H0 Then write_MSG_UPPR_ADDR_value = get_MSG_UPPR_ADDR

        regValue = leftShift(write_MSG_UPPR_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_UPPR_ADDR_value = &H0
        flag_MSG_UPPR_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_data_56
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_DATA                                   [31:0]           get_MSG_DATA
''                                                             set_MSG_DATA
''                                                             read_MSG_DATA
''                                                             write_MSG_DATA
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_data_56
    Private write_MSG_DATA_value
    Private read_MSG_DATA_value
    Private flag_MSG_DATA

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H388
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MSG_DATA
        get_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let set_MSG_DATA(aData)
        write_MSG_DATA_value = aData
        flag_MSG_DATA        = &H1
    End Property

    Property Get read_MSG_DATA
        read
        read_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let write_MSG_DATA(aData)
        set_MSG_DATA = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

    End Sub

    Sub write
        If flag_MSG_DATA = &H0 Then read
        If flag_MSG_DATA = &H0 Then write_MSG_DATA_value = get_MSG_DATA

        regValue = leftShift(write_MSG_DATA_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_DATA_value = &H0
        flag_MSG_DATA        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_vect_ctl_56
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MASK_BIT                                   [0:0]            get_MASK_BIT
''                                                             set_MASK_BIT
''                                                             read_MASK_BIT
''                                                             write_MASK_BIT
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_56
    Private write_MASK_BIT_value
    Private read_MASK_BIT_value
    Private flag_MASK_BIT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H38c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MASK_BIT
        get_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let set_MASK_BIT(aData)
        write_MASK_BIT_value = aData
        flag_MASK_BIT        = &H1
    End Property

    Property Get read_MASK_BIT
        read
        read_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let write_MASK_BIT(aData)
        set_MASK_BIT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

    End Sub

    Sub write
        If flag_MASK_BIT = &H0 Then read
        If flag_MASK_BIT = &H0 Then write_MASK_BIT_value = get_MASK_BIT

        regValue = leftShift((write_MASK_BIT_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MASK_BIT_value = &H0
        flag_MASK_BIT        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_addr_57
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_ADDR                                   [31:0]           get_MSG_ADDR
''                                                             set_MSG_ADDR
''                                                             read_MSG_ADDR
''                                                             write_MSG_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_addr_57
    Private write_MSG_ADDR_value
    Private read_MSG_ADDR_value
    Private flag_MSG_ADDR

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H390
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MSG_ADDR
        get_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let set_MSG_ADDR(aData)
        write_MSG_ADDR_value = aData
        flag_MSG_ADDR        = &H1
    End Property

    Property Get read_MSG_ADDR
        read
        read_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let write_MSG_ADDR(aData)
        set_MSG_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_ADDR = &H0 Then read
        If flag_MSG_ADDR = &H0 Then write_MSG_ADDR_value = get_MSG_ADDR

        regValue = leftShift(write_MSG_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_ADDR_value = &H0
        flag_MSG_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_uppr_addr_57
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_UPPR_ADDR                              [31:0]           get_MSG_UPPR_ADDR
''                                                             set_MSG_UPPR_ADDR
''                                                             read_MSG_UPPR_ADDR
''                                                             write_MSG_UPPR_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_57
    Private write_MSG_UPPR_ADDR_value
    Private read_MSG_UPPR_ADDR_value
    Private flag_MSG_UPPR_ADDR

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H394
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MSG_UPPR_ADDR
        get_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let set_MSG_UPPR_ADDR(aData)
        write_MSG_UPPR_ADDR_value = aData
        flag_MSG_UPPR_ADDR        = &H1
    End Property

    Property Get read_MSG_UPPR_ADDR
        read
        read_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let write_MSG_UPPR_ADDR(aData)
        set_MSG_UPPR_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_UPPR_ADDR = &H0 Then read
        If flag_MSG_UPPR_ADDR = &H0 Then write_MSG_UPPR_ADDR_value = get_MSG_UPPR_ADDR

        regValue = leftShift(write_MSG_UPPR_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_UPPR_ADDR_value = &H0
        flag_MSG_UPPR_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_data_57
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_DATA                                   [31:0]           get_MSG_DATA
''                                                             set_MSG_DATA
''                                                             read_MSG_DATA
''                                                             write_MSG_DATA
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_data_57
    Private write_MSG_DATA_value
    Private read_MSG_DATA_value
    Private flag_MSG_DATA

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H398
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MSG_DATA
        get_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let set_MSG_DATA(aData)
        write_MSG_DATA_value = aData
        flag_MSG_DATA        = &H1
    End Property

    Property Get read_MSG_DATA
        read
        read_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let write_MSG_DATA(aData)
        set_MSG_DATA = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

    End Sub

    Sub write
        If flag_MSG_DATA = &H0 Then read
        If flag_MSG_DATA = &H0 Then write_MSG_DATA_value = get_MSG_DATA

        regValue = leftShift(write_MSG_DATA_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_DATA_value = &H0
        flag_MSG_DATA        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_vect_ctl_57
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MASK_BIT                                   [0:0]            get_MASK_BIT
''                                                             set_MASK_BIT
''                                                             read_MASK_BIT
''                                                             write_MASK_BIT
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_57
    Private write_MASK_BIT_value
    Private read_MASK_BIT_value
    Private flag_MASK_BIT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H39c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MASK_BIT
        get_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let set_MASK_BIT(aData)
        write_MASK_BIT_value = aData
        flag_MASK_BIT        = &H1
    End Property

    Property Get read_MASK_BIT
        read
        read_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let write_MASK_BIT(aData)
        set_MASK_BIT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

    End Sub

    Sub write
        If flag_MASK_BIT = &H0 Then read
        If flag_MASK_BIT = &H0 Then write_MASK_BIT_value = get_MASK_BIT

        regValue = leftShift((write_MASK_BIT_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MASK_BIT_value = &H0
        flag_MASK_BIT        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_addr_58
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_ADDR                                   [31:0]           get_MSG_ADDR
''                                                             set_MSG_ADDR
''                                                             read_MSG_ADDR
''                                                             write_MSG_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_addr_58
    Private write_MSG_ADDR_value
    Private read_MSG_ADDR_value
    Private flag_MSG_ADDR

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3a0
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MSG_ADDR
        get_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let set_MSG_ADDR(aData)
        write_MSG_ADDR_value = aData
        flag_MSG_ADDR        = &H1
    End Property

    Property Get read_MSG_ADDR
        read
        read_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let write_MSG_ADDR(aData)
        set_MSG_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_ADDR = &H0 Then read
        If flag_MSG_ADDR = &H0 Then write_MSG_ADDR_value = get_MSG_ADDR

        regValue = leftShift(write_MSG_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_ADDR_value = &H0
        flag_MSG_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_uppr_addr_58
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_UPPR_ADDR                              [31:0]           get_MSG_UPPR_ADDR
''                                                             set_MSG_UPPR_ADDR
''                                                             read_MSG_UPPR_ADDR
''                                                             write_MSG_UPPR_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_58
    Private write_MSG_UPPR_ADDR_value
    Private read_MSG_UPPR_ADDR_value
    Private flag_MSG_UPPR_ADDR

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3a4
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MSG_UPPR_ADDR
        get_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let set_MSG_UPPR_ADDR(aData)
        write_MSG_UPPR_ADDR_value = aData
        flag_MSG_UPPR_ADDR        = &H1
    End Property

    Property Get read_MSG_UPPR_ADDR
        read
        read_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let write_MSG_UPPR_ADDR(aData)
        set_MSG_UPPR_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_UPPR_ADDR = &H0 Then read
        If flag_MSG_UPPR_ADDR = &H0 Then write_MSG_UPPR_ADDR_value = get_MSG_UPPR_ADDR

        regValue = leftShift(write_MSG_UPPR_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_UPPR_ADDR_value = &H0
        flag_MSG_UPPR_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_data_58
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_DATA                                   [31:0]           get_MSG_DATA
''                                                             set_MSG_DATA
''                                                             read_MSG_DATA
''                                                             write_MSG_DATA
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_data_58
    Private write_MSG_DATA_value
    Private read_MSG_DATA_value
    Private flag_MSG_DATA

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3a8
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MSG_DATA
        get_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let set_MSG_DATA(aData)
        write_MSG_DATA_value = aData
        flag_MSG_DATA        = &H1
    End Property

    Property Get read_MSG_DATA
        read
        read_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let write_MSG_DATA(aData)
        set_MSG_DATA = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

    End Sub

    Sub write
        If flag_MSG_DATA = &H0 Then read
        If flag_MSG_DATA = &H0 Then write_MSG_DATA_value = get_MSG_DATA

        regValue = leftShift(write_MSG_DATA_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_DATA_value = &H0
        flag_MSG_DATA        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_vect_ctl_58
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MASK_BIT                                   [0:0]            get_MASK_BIT
''                                                             set_MASK_BIT
''                                                             read_MASK_BIT
''                                                             write_MASK_BIT
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_58
    Private write_MASK_BIT_value
    Private read_MASK_BIT_value
    Private flag_MASK_BIT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3ac
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MASK_BIT
        get_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let set_MASK_BIT(aData)
        write_MASK_BIT_value = aData
        flag_MASK_BIT        = &H1
    End Property

    Property Get read_MASK_BIT
        read
        read_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let write_MASK_BIT(aData)
        set_MASK_BIT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

    End Sub

    Sub write
        If flag_MASK_BIT = &H0 Then read
        If flag_MASK_BIT = &H0 Then write_MASK_BIT_value = get_MASK_BIT

        regValue = leftShift((write_MASK_BIT_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MASK_BIT_value = &H0
        flag_MASK_BIT        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_addr_59
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_ADDR                                   [31:0]           get_MSG_ADDR
''                                                             set_MSG_ADDR
''                                                             read_MSG_ADDR
''                                                             write_MSG_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_addr_59
    Private write_MSG_ADDR_value
    Private read_MSG_ADDR_value
    Private flag_MSG_ADDR

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3b0
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MSG_ADDR
        get_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let set_MSG_ADDR(aData)
        write_MSG_ADDR_value = aData
        flag_MSG_ADDR        = &H1
    End Property

    Property Get read_MSG_ADDR
        read
        read_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let write_MSG_ADDR(aData)
        set_MSG_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_ADDR = &H0 Then read
        If flag_MSG_ADDR = &H0 Then write_MSG_ADDR_value = get_MSG_ADDR

        regValue = leftShift(write_MSG_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_ADDR_value = &H0
        flag_MSG_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_uppr_addr_59
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_UPPR_ADDR                              [31:0]           get_MSG_UPPR_ADDR
''                                                             set_MSG_UPPR_ADDR
''                                                             read_MSG_UPPR_ADDR
''                                                             write_MSG_UPPR_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_59
    Private write_MSG_UPPR_ADDR_value
    Private read_MSG_UPPR_ADDR_value
    Private flag_MSG_UPPR_ADDR

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3b4
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MSG_UPPR_ADDR
        get_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let set_MSG_UPPR_ADDR(aData)
        write_MSG_UPPR_ADDR_value = aData
        flag_MSG_UPPR_ADDR        = &H1
    End Property

    Property Get read_MSG_UPPR_ADDR
        read
        read_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let write_MSG_UPPR_ADDR(aData)
        set_MSG_UPPR_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_UPPR_ADDR = &H0 Then read
        If flag_MSG_UPPR_ADDR = &H0 Then write_MSG_UPPR_ADDR_value = get_MSG_UPPR_ADDR

        regValue = leftShift(write_MSG_UPPR_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_UPPR_ADDR_value = &H0
        flag_MSG_UPPR_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_data_59
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_DATA                                   [31:0]           get_MSG_DATA
''                                                             set_MSG_DATA
''                                                             read_MSG_DATA
''                                                             write_MSG_DATA
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_data_59
    Private write_MSG_DATA_value
    Private read_MSG_DATA_value
    Private flag_MSG_DATA

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3b8
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MSG_DATA
        get_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let set_MSG_DATA(aData)
        write_MSG_DATA_value = aData
        flag_MSG_DATA        = &H1
    End Property

    Property Get read_MSG_DATA
        read
        read_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let write_MSG_DATA(aData)
        set_MSG_DATA = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

    End Sub

    Sub write
        If flag_MSG_DATA = &H0 Then read
        If flag_MSG_DATA = &H0 Then write_MSG_DATA_value = get_MSG_DATA

        regValue = leftShift(write_MSG_DATA_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_DATA_value = &H0
        flag_MSG_DATA        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_vect_ctl_59
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MASK_BIT                                   [0:0]            get_MASK_BIT
''                                                             set_MASK_BIT
''                                                             read_MASK_BIT
''                                                             write_MASK_BIT
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_59
    Private write_MASK_BIT_value
    Private read_MASK_BIT_value
    Private flag_MASK_BIT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3bc
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MASK_BIT
        get_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let set_MASK_BIT(aData)
        write_MASK_BIT_value = aData
        flag_MASK_BIT        = &H1
    End Property

    Property Get read_MASK_BIT
        read
        read_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let write_MASK_BIT(aData)
        set_MASK_BIT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

    End Sub

    Sub write
        If flag_MASK_BIT = &H0 Then read
        If flag_MASK_BIT = &H0 Then write_MASK_BIT_value = get_MASK_BIT

        regValue = leftShift((write_MASK_BIT_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MASK_BIT_value = &H0
        flag_MASK_BIT        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_addr_60
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_ADDR                                   [31:0]           get_MSG_ADDR
''                                                             set_MSG_ADDR
''                                                             read_MSG_ADDR
''                                                             write_MSG_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_addr_60
    Private write_MSG_ADDR_value
    Private read_MSG_ADDR_value
    Private flag_MSG_ADDR

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3c0
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MSG_ADDR
        get_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let set_MSG_ADDR(aData)
        write_MSG_ADDR_value = aData
        flag_MSG_ADDR        = &H1
    End Property

    Property Get read_MSG_ADDR
        read
        read_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let write_MSG_ADDR(aData)
        set_MSG_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_ADDR = &H0 Then read
        If flag_MSG_ADDR = &H0 Then write_MSG_ADDR_value = get_MSG_ADDR

        regValue = leftShift(write_MSG_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_ADDR_value = &H0
        flag_MSG_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_uppr_addr_60
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_UPPR_ADDR                              [31:0]           get_MSG_UPPR_ADDR
''                                                             set_MSG_UPPR_ADDR
''                                                             read_MSG_UPPR_ADDR
''                                                             write_MSG_UPPR_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_60
    Private write_MSG_UPPR_ADDR_value
    Private read_MSG_UPPR_ADDR_value
    Private flag_MSG_UPPR_ADDR

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3c4
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MSG_UPPR_ADDR
        get_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let set_MSG_UPPR_ADDR(aData)
        write_MSG_UPPR_ADDR_value = aData
        flag_MSG_UPPR_ADDR        = &H1
    End Property

    Property Get read_MSG_UPPR_ADDR
        read
        read_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let write_MSG_UPPR_ADDR(aData)
        set_MSG_UPPR_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_UPPR_ADDR = &H0 Then read
        If flag_MSG_UPPR_ADDR = &H0 Then write_MSG_UPPR_ADDR_value = get_MSG_UPPR_ADDR

        regValue = leftShift(write_MSG_UPPR_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_UPPR_ADDR_value = &H0
        flag_MSG_UPPR_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_data_60
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_DATA                                   [31:0]           get_MSG_DATA
''                                                             set_MSG_DATA
''                                                             read_MSG_DATA
''                                                             write_MSG_DATA
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_data_60
    Private write_MSG_DATA_value
    Private read_MSG_DATA_value
    Private flag_MSG_DATA

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3c8
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MSG_DATA
        get_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let set_MSG_DATA(aData)
        write_MSG_DATA_value = aData
        flag_MSG_DATA        = &H1
    End Property

    Property Get read_MSG_DATA
        read
        read_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let write_MSG_DATA(aData)
        set_MSG_DATA = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

    End Sub

    Sub write
        If flag_MSG_DATA = &H0 Then read
        If flag_MSG_DATA = &H0 Then write_MSG_DATA_value = get_MSG_DATA

        regValue = leftShift(write_MSG_DATA_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_DATA_value = &H0
        flag_MSG_DATA        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_vect_ctl_60
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MASK_BIT                                   [0:0]            get_MASK_BIT
''                                                             set_MASK_BIT
''                                                             read_MASK_BIT
''                                                             write_MASK_BIT
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_60
    Private write_MASK_BIT_value
    Private read_MASK_BIT_value
    Private flag_MASK_BIT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3cc
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MASK_BIT
        get_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let set_MASK_BIT(aData)
        write_MASK_BIT_value = aData
        flag_MASK_BIT        = &H1
    End Property

    Property Get read_MASK_BIT
        read
        read_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let write_MASK_BIT(aData)
        set_MASK_BIT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

    End Sub

    Sub write
        If flag_MASK_BIT = &H0 Then read
        If flag_MASK_BIT = &H0 Then write_MASK_BIT_value = get_MASK_BIT

        regValue = leftShift((write_MASK_BIT_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MASK_BIT_value = &H0
        flag_MASK_BIT        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_addr_61
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_ADDR                                   [31:0]           get_MSG_ADDR
''                                                             set_MSG_ADDR
''                                                             read_MSG_ADDR
''                                                             write_MSG_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_addr_61
    Private write_MSG_ADDR_value
    Private read_MSG_ADDR_value
    Private flag_MSG_ADDR

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3d0
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MSG_ADDR
        get_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let set_MSG_ADDR(aData)
        write_MSG_ADDR_value = aData
        flag_MSG_ADDR        = &H1
    End Property

    Property Get read_MSG_ADDR
        read
        read_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let write_MSG_ADDR(aData)
        set_MSG_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_ADDR = &H0 Then read
        If flag_MSG_ADDR = &H0 Then write_MSG_ADDR_value = get_MSG_ADDR

        regValue = leftShift(write_MSG_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_ADDR_value = &H0
        flag_MSG_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_uppr_addr_61
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_UPPR_ADDR                              [31:0]           get_MSG_UPPR_ADDR
''                                                             set_MSG_UPPR_ADDR
''                                                             read_MSG_UPPR_ADDR
''                                                             write_MSG_UPPR_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_61
    Private write_MSG_UPPR_ADDR_value
    Private read_MSG_UPPR_ADDR_value
    Private flag_MSG_UPPR_ADDR

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3d4
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MSG_UPPR_ADDR
        get_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let set_MSG_UPPR_ADDR(aData)
        write_MSG_UPPR_ADDR_value = aData
        flag_MSG_UPPR_ADDR        = &H1
    End Property

    Property Get read_MSG_UPPR_ADDR
        read
        read_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let write_MSG_UPPR_ADDR(aData)
        set_MSG_UPPR_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_UPPR_ADDR = &H0 Then read
        If flag_MSG_UPPR_ADDR = &H0 Then write_MSG_UPPR_ADDR_value = get_MSG_UPPR_ADDR

        regValue = leftShift(write_MSG_UPPR_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_UPPR_ADDR_value = &H0
        flag_MSG_UPPR_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_data_61
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_DATA                                   [31:0]           get_MSG_DATA
''                                                             set_MSG_DATA
''                                                             read_MSG_DATA
''                                                             write_MSG_DATA
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_data_61
    Private write_MSG_DATA_value
    Private read_MSG_DATA_value
    Private flag_MSG_DATA

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3d8
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MSG_DATA
        get_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let set_MSG_DATA(aData)
        write_MSG_DATA_value = aData
        flag_MSG_DATA        = &H1
    End Property

    Property Get read_MSG_DATA
        read
        read_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let write_MSG_DATA(aData)
        set_MSG_DATA = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

    End Sub

    Sub write
        If flag_MSG_DATA = &H0 Then read
        If flag_MSG_DATA = &H0 Then write_MSG_DATA_value = get_MSG_DATA

        regValue = leftShift(write_MSG_DATA_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_DATA_value = &H0
        flag_MSG_DATA        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_vect_ctl_61
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MASK_BIT                                   [0:0]            get_MASK_BIT
''                                                             set_MASK_BIT
''                                                             read_MASK_BIT
''                                                             write_MASK_BIT
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_61
    Private write_MASK_BIT_value
    Private read_MASK_BIT_value
    Private flag_MASK_BIT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3dc
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MASK_BIT
        get_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let set_MASK_BIT(aData)
        write_MASK_BIT_value = aData
        flag_MASK_BIT        = &H1
    End Property

    Property Get read_MASK_BIT
        read
        read_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let write_MASK_BIT(aData)
        set_MASK_BIT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

    End Sub

    Sub write
        If flag_MASK_BIT = &H0 Then read
        If flag_MASK_BIT = &H0 Then write_MASK_BIT_value = get_MASK_BIT

        regValue = leftShift((write_MASK_BIT_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MASK_BIT_value = &H0
        flag_MASK_BIT        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_addr_62
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_ADDR                                   [31:0]           get_MSG_ADDR
''                                                             set_MSG_ADDR
''                                                             read_MSG_ADDR
''                                                             write_MSG_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_addr_62
    Private write_MSG_ADDR_value
    Private read_MSG_ADDR_value
    Private flag_MSG_ADDR

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3e0
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MSG_ADDR
        get_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let set_MSG_ADDR(aData)
        write_MSG_ADDR_value = aData
        flag_MSG_ADDR        = &H1
    End Property

    Property Get read_MSG_ADDR
        read
        read_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let write_MSG_ADDR(aData)
        set_MSG_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_ADDR = &H0 Then read
        If flag_MSG_ADDR = &H0 Then write_MSG_ADDR_value = get_MSG_ADDR

        regValue = leftShift(write_MSG_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_ADDR_value = &H0
        flag_MSG_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_uppr_addr_62
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_UPPR_ADDR                              [31:0]           get_MSG_UPPR_ADDR
''                                                             set_MSG_UPPR_ADDR
''                                                             read_MSG_UPPR_ADDR
''                                                             write_MSG_UPPR_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_62
    Private write_MSG_UPPR_ADDR_value
    Private read_MSG_UPPR_ADDR_value
    Private flag_MSG_UPPR_ADDR

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3e4
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MSG_UPPR_ADDR
        get_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let set_MSG_UPPR_ADDR(aData)
        write_MSG_UPPR_ADDR_value = aData
        flag_MSG_UPPR_ADDR        = &H1
    End Property

    Property Get read_MSG_UPPR_ADDR
        read
        read_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let write_MSG_UPPR_ADDR(aData)
        set_MSG_UPPR_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_UPPR_ADDR = &H0 Then read
        If flag_MSG_UPPR_ADDR = &H0 Then write_MSG_UPPR_ADDR_value = get_MSG_UPPR_ADDR

        regValue = leftShift(write_MSG_UPPR_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_UPPR_ADDR_value = &H0
        flag_MSG_UPPR_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_data_62
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_DATA                                   [31:0]           get_MSG_DATA
''                                                             set_MSG_DATA
''                                                             read_MSG_DATA
''                                                             write_MSG_DATA
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_data_62
    Private write_MSG_DATA_value
    Private read_MSG_DATA_value
    Private flag_MSG_DATA

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3e8
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MSG_DATA
        get_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let set_MSG_DATA(aData)
        write_MSG_DATA_value = aData
        flag_MSG_DATA        = &H1
    End Property

    Property Get read_MSG_DATA
        read
        read_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let write_MSG_DATA(aData)
        set_MSG_DATA = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

    End Sub

    Sub write
        If flag_MSG_DATA = &H0 Then read
        If flag_MSG_DATA = &H0 Then write_MSG_DATA_value = get_MSG_DATA

        regValue = leftShift(write_MSG_DATA_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_DATA_value = &H0
        flag_MSG_DATA        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_vect_ctl_62
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MASK_BIT                                   [0:0]            get_MASK_BIT
''                                                             set_MASK_BIT
''                                                             read_MASK_BIT
''                                                             write_MASK_BIT
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_62
    Private write_MASK_BIT_value
    Private read_MASK_BIT_value
    Private flag_MASK_BIT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3ec
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MASK_BIT
        get_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let set_MASK_BIT(aData)
        write_MASK_BIT_value = aData
        flag_MASK_BIT        = &H1
    End Property

    Property Get read_MASK_BIT
        read
        read_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let write_MASK_BIT(aData)
        set_MASK_BIT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

    End Sub

    Sub write
        If flag_MASK_BIT = &H0 Then read
        If flag_MASK_BIT = &H0 Then write_MASK_BIT_value = get_MASK_BIT

        regValue = leftShift((write_MASK_BIT_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MASK_BIT_value = &H0
        flag_MASK_BIT        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_addr_63
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_ADDR                                   [31:0]           get_MSG_ADDR
''                                                             set_MSG_ADDR
''                                                             read_MSG_ADDR
''                                                             write_MSG_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_addr_63
    Private write_MSG_ADDR_value
    Private read_MSG_ADDR_value
    Private flag_MSG_ADDR

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3f0
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MSG_ADDR
        get_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let set_MSG_ADDR(aData)
        write_MSG_ADDR_value = aData
        flag_MSG_ADDR        = &H1
    End Property

    Property Get read_MSG_ADDR
        read
        read_MSG_ADDR = read_MSG_ADDR_value
    End Property

    Property Let write_MSG_ADDR(aData)
        set_MSG_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_ADDR = &H0 Then read
        If flag_MSG_ADDR = &H0 Then write_MSG_ADDR_value = get_MSG_ADDR

        regValue = leftShift(write_MSG_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_ADDR_mask = mask then
                read_MSG_ADDR_value = data_low
            else
                read_MSG_ADDR_value = (data_low - H8000_0000) and MSG_ADDR_mask
            end If
        else
            read_MSG_ADDR_value = data_low and MSG_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_ADDR_value = &H0
        flag_MSG_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_uppr_addr_63
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_UPPR_ADDR                              [31:0]           get_MSG_UPPR_ADDR
''                                                             set_MSG_UPPR_ADDR
''                                                             read_MSG_UPPR_ADDR
''                                                             write_MSG_UPPR_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_63
    Private write_MSG_UPPR_ADDR_value
    Private read_MSG_UPPR_ADDR_value
    Private flag_MSG_UPPR_ADDR

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3f4
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MSG_UPPR_ADDR
        get_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let set_MSG_UPPR_ADDR(aData)
        write_MSG_UPPR_ADDR_value = aData
        flag_MSG_UPPR_ADDR        = &H1
    End Property

    Property Get read_MSG_UPPR_ADDR
        read
        read_MSG_UPPR_ADDR = read_MSG_UPPR_ADDR_value
    End Property

    Property Let write_MSG_UPPR_ADDR(aData)
        set_MSG_UPPR_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_MSG_UPPR_ADDR = &H0 Then read
        If flag_MSG_UPPR_ADDR = &H0 Then write_MSG_UPPR_ADDR_value = get_MSG_UPPR_ADDR

        regValue = leftShift(write_MSG_UPPR_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_UPPR_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_UPPR_ADDR_mask = mask then
                read_MSG_UPPR_ADDR_value = data_low
            else
                read_MSG_UPPR_ADDR_value = (data_low - H8000_0000) and MSG_UPPR_ADDR_mask
            end If
        else
            read_MSG_UPPR_ADDR_value = data_low and MSG_UPPR_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_UPPR_ADDR_value = &H0
        flag_MSG_UPPR_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_msg_data_63
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_DATA                                   [31:0]           get_MSG_DATA
''                                                             set_MSG_DATA
''                                                             read_MSG_DATA
''                                                             write_MSG_DATA
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_msg_data_63
    Private write_MSG_DATA_value
    Private read_MSG_DATA_value
    Private flag_MSG_DATA

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3f8
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MSG_DATA
        get_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let set_MSG_DATA(aData)
        write_MSG_DATA_value = aData
        flag_MSG_DATA        = &H1
    End Property

    Property Get read_MSG_DATA
        read
        read_MSG_DATA = read_MSG_DATA_value
    End Property

    Property Let write_MSG_DATA(aData)
        set_MSG_DATA = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

    End Sub

    Sub write
        If flag_MSG_DATA = &H0 Then read
        If flag_MSG_DATA = &H0 Then write_MSG_DATA_value = get_MSG_DATA

        regValue = leftShift(write_MSG_DATA_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MSG_DATA_mask = mask then
                read_MSG_DATA_value = data_low
            else
                read_MSG_DATA_value = (data_low - H8000_0000) and MSG_DATA_mask
            end If
        else
            read_MSG_DATA_value = data_low and MSG_DATA_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_DATA_value = &H0
        flag_MSG_DATA        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_vect_ctl_63
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MASK_BIT                                   [0:0]            get_MASK_BIT
''                                                             set_MASK_BIT
''                                                             read_MASK_BIT
''                                                             write_MASK_BIT
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_63
    Private write_MASK_BIT_value
    Private read_MASK_BIT_value
    Private flag_MASK_BIT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3fc
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MASK_BIT
        get_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let set_MASK_BIT(aData)
        write_MASK_BIT_value = aData
        flag_MASK_BIT        = &H1
    End Property

    Property Get read_MASK_BIT
        read
        read_MASK_BIT = read_MASK_BIT_value
    End Property

    Property Let write_MASK_BIT(aData)
        set_MASK_BIT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

    End Sub

    Sub write
        If flag_MASK_BIT = &H0 Then read
        If flag_MASK_BIT = &H0 Then write_MASK_BIT_value = get_MASK_BIT

        regValue = leftShift((write_MASK_BIT_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_BIT_mask = &H1
        if data_low > LONG_MAX then
            if MASK_BIT_mask = mask then
                read_MASK_BIT_value = data_low
            else
                read_MASK_BIT_value = (data_low - H8000_0000) and MASK_BIT_mask
            end If
        else
            read_MASK_BIT_value = data_low and MASK_BIT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MASK_BIT_value = &H0
        flag_MASK_BIT        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_pba_31_0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PBA                                        [31:0]           get_PBA
''                                                             set_PBA
''                                                             read_PBA
''                                                             write_PBA
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_pba_31_0
    Private write_PBA_value
    Private read_PBA_value
    Private flag_PBA

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H800
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_PBA
        get_PBA = read_PBA_value
    End Property

    Property Let set_PBA(aData)
        write_PBA_value = aData
        flag_PBA        = &H1
    End Property

    Property Get read_PBA
        read
        read_PBA = read_PBA_value
    End Property

    Property Let write_PBA(aData)
        set_PBA = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PBA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if PBA_mask = mask then
                read_PBA_value = data_low
            else
                read_PBA_value = (data_low - H8000_0000) and PBA_mask
            end If
        else
            read_PBA_value = data_low and PBA_mask
        end If

    End Sub

    Sub write
        If flag_PBA = &H0 Then read
        If flag_PBA = &H0 Then write_PBA_value = get_PBA

        regValue = leftShift(write_PBA_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PBA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if PBA_mask = mask then
                read_PBA_value = data_low
            else
                read_PBA_value = (data_low - H8000_0000) and PBA_mask
            end If
        else
            read_PBA_value = data_low and PBA_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PBA_value = &H0
        flag_PBA        = &H0
    End Sub
End Class


'' @REGISTER : GEN2_TOP_MSIX_msix_pba_63_32
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PBA                                        [31:0]           get_PBA
''                                                             set_PBA
''                                                             read_PBA
''                                                             write_PBA
''---------------------------------------------------------------------------------
Class REGISTER_GEN2_TOP_MSIX_msix_pba_63_32
    Private write_PBA_value
    Private read_PBA_value
    Private flag_PBA

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H804
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_PBA
        get_PBA = read_PBA_value
    End Property

    Property Let set_PBA(aData)
        write_PBA_value = aData
        flag_PBA        = &H1
    End Property

    Property Get read_PBA
        read
        read_PBA = read_PBA_value
    End Property

    Property Let write_PBA(aData)
        set_PBA = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PBA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if PBA_mask = mask then
                read_PBA_value = data_low
            else
                read_PBA_value = (data_low - H8000_0000) and PBA_mask
            end If
        else
            read_PBA_value = data_low and PBA_mask
        end If

    End Sub

    Sub write
        If flag_PBA = &H0 Then read
        If flag_PBA = &H0 Then write_PBA_value = get_PBA

        regValue = leftShift(write_PBA_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PBA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if PBA_mask = mask then
                read_PBA_value = data_low
            else
                read_PBA_value = (data_low - H8000_0000) and PBA_mask
            end If
        else
            read_PBA_value = data_low and PBA_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PBA_value = &H0
        flag_PBA        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class GEN2_TOP_MSIX_INSTANCE

    Public msix_msg_addr_0
    Public msix_msg_uppr_addr_0
    Public msix_msg_data_0
    Public msix_vect_ctl_0
    Public msix_msg_addr_1
    Public msix_msg_uppr_addr_1
    Public msix_msg_data_1
    Public msix_vect_ctl_1
    Public msix_msg_addr_2
    Public msix_msg_uppr_addr_2
    Public msix_msg_data_2
    Public msix_vect_ctl_2
    Public msix_msg_addr_3
    Public msix_msg_uppr_addr_3
    Public msix_msg_data_3
    Public msix_vect_ctl_3
    Public msix_msg_addr_4
    Public msix_msg_uppr_addr_4
    Public msix_msg_data_4
    Public msix_vect_ctl_4
    Public msix_msg_addr_5
    Public msix_msg_uppr_addr_5
    Public msix_msg_data_5
    Public msix_vect_ctl_5
    Public msix_msg_addr_6
    Public msix_msg_uppr_addr_6
    Public msix_msg_data_6
    Public msix_vect_ctl_6
    Public msix_msg_addr_7
    Public msix_msg_uppr_addr_7
    Public msix_msg_data_7
    Public msix_vect_ctl_7
    Public msix_msg_addr_8
    Public msix_msg_uppr_addr_8
    Public msix_msg_data_8
    Public msix_vect_ctl_8
    Public msix_msg_addr_9
    Public msix_msg_uppr_addr_9
    Public msix_msg_data_9
    Public msix_vect_ctl_9
    Public msix_msg_addr_10
    Public msix_msg_uppr_addr_10
    Public msix_msg_data_10
    Public msix_vect_ctl_10
    Public msix_msg_addr_11
    Public msix_msg_uppr_addr_11
    Public msix_msg_data_11
    Public msix_vect_ctl_11
    Public msix_msg_addr_12
    Public msix_msg_uppr_addr_12
    Public msix_msg_data_12
    Public msix_vect_ctl_12
    Public msix_msg_addr_13
    Public msix_msg_uppr_addr_13
    Public msix_msg_data_13
    Public msix_vect_ctl_13
    Public msix_msg_addr_14
    Public msix_msg_uppr_addr_14
    Public msix_msg_data_14
    Public msix_vect_ctl_14
    Public msix_msg_addr_15
    Public msix_msg_uppr_addr_15
    Public msix_msg_data_15
    Public msix_vect_ctl_15
    Public msix_msg_addr_16
    Public msix_msg_uppr_addr_16
    Public msix_msg_data_16
    Public msix_vect_ctl_16
    Public msix_msg_addr_17
    Public msix_msg_uppr_addr_17
    Public msix_msg_data_17
    Public msix_vect_ctl_17
    Public msix_msg_addr_18
    Public msix_msg_uppr_addr_18
    Public msix_msg_data_18
    Public msix_vect_ctl_18
    Public msix_msg_addr_19
    Public msix_msg_uppr_addr_19
    Public msix_msg_data_19
    Public msix_vect_ctl_19
    Public msix_msg_addr_20
    Public msix_msg_uppr_addr_20
    Public msix_msg_data_20
    Public msix_vect_ctl_20
    Public msix_msg_addr_21
    Public msix_msg_uppr_addr_21
    Public msix_msg_data_21
    Public msix_vect_ctl_21
    Public msix_msg_addr_22
    Public msix_msg_uppr_addr_22
    Public msix_msg_data_22
    Public msix_vect_ctl_22
    Public msix_msg_addr_23
    Public msix_msg_uppr_addr_23
    Public msix_msg_data_23
    Public msix_vect_ctl_23
    Public msix_msg_addr_24
    Public msix_msg_uppr_addr_24
    Public msix_msg_data_24
    Public msix_vect_ctl_24
    Public msix_msg_addr_25
    Public msix_msg_uppr_addr_25
    Public msix_msg_data_25
    Public msix_vect_ctl_25
    Public msix_msg_addr_26
    Public msix_msg_uppr_addr_26
    Public msix_msg_data_26
    Public msix_vect_ctl_26
    Public msix_msg_addr_27
    Public msix_msg_uppr_addr_27
    Public msix_msg_data_27
    Public msix_vect_ctl_27
    Public msix_msg_addr_28
    Public msix_msg_uppr_addr_28
    Public msix_msg_data_28
    Public msix_vect_ctl_28
    Public msix_msg_addr_29
    Public msix_msg_uppr_addr_29
    Public msix_msg_data_29
    Public msix_vect_ctl_29
    Public msix_msg_addr_30
    Public msix_msg_uppr_addr_30
    Public msix_msg_data_30
    Public msix_vect_ctl_30
    Public msix_msg_addr_31
    Public msix_msg_uppr_addr_31
    Public msix_msg_data_31
    Public msix_vect_ctl_31
    Public msix_msg_addr_32
    Public msix_msg_uppr_addr_32
    Public msix_msg_data_32
    Public msix_vect_ctl_32
    Public msix_msg_addr_33
    Public msix_msg_uppr_addr_33
    Public msix_msg_data_33
    Public msix_vect_ctl_33
    Public msix_msg_addr_34
    Public msix_msg_uppr_addr_34
    Public msix_msg_data_34
    Public msix_vect_ctl_34
    Public msix_msg_addr_35
    Public msix_msg_uppr_addr_35
    Public msix_msg_data_35
    Public msix_vect_ctl_35
    Public msix_msg_addr_36
    Public msix_msg_uppr_addr_36
    Public msix_msg_data_36
    Public msix_vect_ctl_36
    Public msix_msg_addr_37
    Public msix_msg_uppr_addr_37
    Public msix_msg_data_37
    Public msix_vect_ctl_37
    Public msix_msg_addr_38
    Public msix_msg_uppr_addr_38
    Public msix_msg_data_38
    Public msix_vect_ctl_38
    Public msix_msg_addr_39
    Public msix_msg_uppr_addr_39
    Public msix_msg_data_39
    Public msix_vect_ctl_39
    Public msix_msg_addr_40
    Public msix_msg_uppr_addr_40
    Public msix_msg_data_40
    Public msix_vect_ctl_40
    Public msix_msg_addr_41
    Public msix_msg_uppr_addr_41
    Public msix_msg_data_41
    Public msix_vect_ctl_41
    Public msix_msg_addr_42
    Public msix_msg_uppr_addr_42
    Public msix_msg_data_42
    Public msix_vect_ctl_42
    Public msix_msg_addr_43
    Public msix_msg_uppr_addr_43
    Public msix_msg_data_43
    Public msix_vect_ctl_43
    Public msix_msg_addr_44
    Public msix_msg_uppr_addr_44
    Public msix_msg_data_44
    Public msix_vect_ctl_44
    Public msix_msg_addr_45
    Public msix_msg_uppr_addr_45
    Public msix_msg_data_45
    Public msix_vect_ctl_45
    Public msix_msg_addr_46
    Public msix_msg_uppr_addr_46
    Public msix_msg_data_46
    Public msix_vect_ctl_46
    Public msix_msg_addr_47
    Public msix_msg_uppr_addr_47
    Public msix_msg_data_47
    Public msix_vect_ctl_47
    Public msix_msg_addr_48
    Public msix_msg_uppr_addr_48
    Public msix_msg_data_48
    Public msix_vect_ctl_48
    Public msix_msg_addr_49
    Public msix_msg_uppr_addr_49
    Public msix_msg_data_49
    Public msix_vect_ctl_49
    Public msix_msg_addr_50
    Public msix_msg_uppr_addr_50
    Public msix_msg_data_50
    Public msix_vect_ctl_50
    Public msix_msg_addr_51
    Public msix_msg_uppr_addr_51
    Public msix_msg_data_51
    Public msix_vect_ctl_51
    Public msix_msg_addr_52
    Public msix_msg_uppr_addr_52
    Public msix_msg_data_52
    Public msix_vect_ctl_52
    Public msix_msg_addr_53
    Public msix_msg_uppr_addr_53
    Public msix_msg_data_53
    Public msix_vect_ctl_53
    Public msix_msg_addr_54
    Public msix_msg_uppr_addr_54
    Public msix_msg_data_54
    Public msix_vect_ctl_54
    Public msix_msg_addr_55
    Public msix_msg_uppr_addr_55
    Public msix_msg_data_55
    Public msix_vect_ctl_55
    Public msix_msg_addr_56
    Public msix_msg_uppr_addr_56
    Public msix_msg_data_56
    Public msix_vect_ctl_56
    Public msix_msg_addr_57
    Public msix_msg_uppr_addr_57
    Public msix_msg_data_57
    Public msix_vect_ctl_57
    Public msix_msg_addr_58
    Public msix_msg_uppr_addr_58
    Public msix_msg_data_58
    Public msix_vect_ctl_58
    Public msix_msg_addr_59
    Public msix_msg_uppr_addr_59
    Public msix_msg_data_59
    Public msix_vect_ctl_59
    Public msix_msg_addr_60
    Public msix_msg_uppr_addr_60
    Public msix_msg_data_60
    Public msix_vect_ctl_60
    Public msix_msg_addr_61
    Public msix_msg_uppr_addr_61
    Public msix_msg_data_61
    Public msix_vect_ctl_61
    Public msix_msg_addr_62
    Public msix_msg_uppr_addr_62
    Public msix_msg_data_62
    Public msix_vect_ctl_62
    Public msix_msg_addr_63
    Public msix_msg_uppr_addr_63
    Public msix_msg_data_63
    Public msix_vect_ctl_63
    Public msix_pba_31_0
    Public msix_pba_63_32


    Public default function Init(aBaseAddr)
        Set msix_msg_addr_0 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_addr_0)(aBaseAddr, 32)
        Set msix_msg_uppr_addr_0 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_0)(aBaseAddr, 32)
        Set msix_msg_data_0 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_data_0)(aBaseAddr, 32)
        Set msix_vect_ctl_0 = (New REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_0)(aBaseAddr, 32)
        Set msix_msg_addr_1 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_addr_1)(aBaseAddr, 32)
        Set msix_msg_uppr_addr_1 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_1)(aBaseAddr, 32)
        Set msix_msg_data_1 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_data_1)(aBaseAddr, 32)
        Set msix_vect_ctl_1 = (New REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_1)(aBaseAddr, 32)
        Set msix_msg_addr_2 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_addr_2)(aBaseAddr, 32)
        Set msix_msg_uppr_addr_2 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_2)(aBaseAddr, 32)
        Set msix_msg_data_2 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_data_2)(aBaseAddr, 32)
        Set msix_vect_ctl_2 = (New REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_2)(aBaseAddr, 32)
        Set msix_msg_addr_3 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_addr_3)(aBaseAddr, 32)
        Set msix_msg_uppr_addr_3 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_3)(aBaseAddr, 32)
        Set msix_msg_data_3 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_data_3)(aBaseAddr, 32)
        Set msix_vect_ctl_3 = (New REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_3)(aBaseAddr, 32)
        Set msix_msg_addr_4 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_addr_4)(aBaseAddr, 32)
        Set msix_msg_uppr_addr_4 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_4)(aBaseAddr, 32)
        Set msix_msg_data_4 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_data_4)(aBaseAddr, 32)
        Set msix_vect_ctl_4 = (New REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_4)(aBaseAddr, 32)
        Set msix_msg_addr_5 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_addr_5)(aBaseAddr, 32)
        Set msix_msg_uppr_addr_5 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_5)(aBaseAddr, 32)
        Set msix_msg_data_5 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_data_5)(aBaseAddr, 32)
        Set msix_vect_ctl_5 = (New REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_5)(aBaseAddr, 32)
        Set msix_msg_addr_6 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_addr_6)(aBaseAddr, 32)
        Set msix_msg_uppr_addr_6 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_6)(aBaseAddr, 32)
        Set msix_msg_data_6 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_data_6)(aBaseAddr, 32)
        Set msix_vect_ctl_6 = (New REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_6)(aBaseAddr, 32)
        Set msix_msg_addr_7 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_addr_7)(aBaseAddr, 32)
        Set msix_msg_uppr_addr_7 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_7)(aBaseAddr, 32)
        Set msix_msg_data_7 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_data_7)(aBaseAddr, 32)
        Set msix_vect_ctl_7 = (New REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_7)(aBaseAddr, 32)
        Set msix_msg_addr_8 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_addr_8)(aBaseAddr, 32)
        Set msix_msg_uppr_addr_8 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_8)(aBaseAddr, 32)
        Set msix_msg_data_8 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_data_8)(aBaseAddr, 32)
        Set msix_vect_ctl_8 = (New REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_8)(aBaseAddr, 32)
        Set msix_msg_addr_9 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_addr_9)(aBaseAddr, 32)
        Set msix_msg_uppr_addr_9 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_9)(aBaseAddr, 32)
        Set msix_msg_data_9 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_data_9)(aBaseAddr, 32)
        Set msix_vect_ctl_9 = (New REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_9)(aBaseAddr, 32)
        Set msix_msg_addr_10 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_addr_10)(aBaseAddr, 32)
        Set msix_msg_uppr_addr_10 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_10)(aBaseAddr, 32)
        Set msix_msg_data_10 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_data_10)(aBaseAddr, 32)
        Set msix_vect_ctl_10 = (New REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_10)(aBaseAddr, 32)
        Set msix_msg_addr_11 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_addr_11)(aBaseAddr, 32)
        Set msix_msg_uppr_addr_11 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_11)(aBaseAddr, 32)
        Set msix_msg_data_11 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_data_11)(aBaseAddr, 32)
        Set msix_vect_ctl_11 = (New REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_11)(aBaseAddr, 32)
        Set msix_msg_addr_12 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_addr_12)(aBaseAddr, 32)
        Set msix_msg_uppr_addr_12 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_12)(aBaseAddr, 32)
        Set msix_msg_data_12 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_data_12)(aBaseAddr, 32)
        Set msix_vect_ctl_12 = (New REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_12)(aBaseAddr, 32)
        Set msix_msg_addr_13 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_addr_13)(aBaseAddr, 32)
        Set msix_msg_uppr_addr_13 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_13)(aBaseAddr, 32)
        Set msix_msg_data_13 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_data_13)(aBaseAddr, 32)
        Set msix_vect_ctl_13 = (New REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_13)(aBaseAddr, 32)
        Set msix_msg_addr_14 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_addr_14)(aBaseAddr, 32)
        Set msix_msg_uppr_addr_14 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_14)(aBaseAddr, 32)
        Set msix_msg_data_14 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_data_14)(aBaseAddr, 32)
        Set msix_vect_ctl_14 = (New REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_14)(aBaseAddr, 32)
        Set msix_msg_addr_15 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_addr_15)(aBaseAddr, 32)
        Set msix_msg_uppr_addr_15 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_15)(aBaseAddr, 32)
        Set msix_msg_data_15 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_data_15)(aBaseAddr, 32)
        Set msix_vect_ctl_15 = (New REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_15)(aBaseAddr, 32)
        Set msix_msg_addr_16 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_addr_16)(aBaseAddr, 32)
        Set msix_msg_uppr_addr_16 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_16)(aBaseAddr, 32)
        Set msix_msg_data_16 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_data_16)(aBaseAddr, 32)
        Set msix_vect_ctl_16 = (New REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_16)(aBaseAddr, 32)
        Set msix_msg_addr_17 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_addr_17)(aBaseAddr, 32)
        Set msix_msg_uppr_addr_17 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_17)(aBaseAddr, 32)
        Set msix_msg_data_17 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_data_17)(aBaseAddr, 32)
        Set msix_vect_ctl_17 = (New REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_17)(aBaseAddr, 32)
        Set msix_msg_addr_18 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_addr_18)(aBaseAddr, 32)
        Set msix_msg_uppr_addr_18 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_18)(aBaseAddr, 32)
        Set msix_msg_data_18 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_data_18)(aBaseAddr, 32)
        Set msix_vect_ctl_18 = (New REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_18)(aBaseAddr, 32)
        Set msix_msg_addr_19 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_addr_19)(aBaseAddr, 32)
        Set msix_msg_uppr_addr_19 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_19)(aBaseAddr, 32)
        Set msix_msg_data_19 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_data_19)(aBaseAddr, 32)
        Set msix_vect_ctl_19 = (New REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_19)(aBaseAddr, 32)
        Set msix_msg_addr_20 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_addr_20)(aBaseAddr, 32)
        Set msix_msg_uppr_addr_20 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_20)(aBaseAddr, 32)
        Set msix_msg_data_20 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_data_20)(aBaseAddr, 32)
        Set msix_vect_ctl_20 = (New REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_20)(aBaseAddr, 32)
        Set msix_msg_addr_21 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_addr_21)(aBaseAddr, 32)
        Set msix_msg_uppr_addr_21 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_21)(aBaseAddr, 32)
        Set msix_msg_data_21 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_data_21)(aBaseAddr, 32)
        Set msix_vect_ctl_21 = (New REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_21)(aBaseAddr, 32)
        Set msix_msg_addr_22 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_addr_22)(aBaseAddr, 32)
        Set msix_msg_uppr_addr_22 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_22)(aBaseAddr, 32)
        Set msix_msg_data_22 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_data_22)(aBaseAddr, 32)
        Set msix_vect_ctl_22 = (New REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_22)(aBaseAddr, 32)
        Set msix_msg_addr_23 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_addr_23)(aBaseAddr, 32)
        Set msix_msg_uppr_addr_23 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_23)(aBaseAddr, 32)
        Set msix_msg_data_23 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_data_23)(aBaseAddr, 32)
        Set msix_vect_ctl_23 = (New REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_23)(aBaseAddr, 32)
        Set msix_msg_addr_24 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_addr_24)(aBaseAddr, 32)
        Set msix_msg_uppr_addr_24 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_24)(aBaseAddr, 32)
        Set msix_msg_data_24 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_data_24)(aBaseAddr, 32)
        Set msix_vect_ctl_24 = (New REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_24)(aBaseAddr, 32)
        Set msix_msg_addr_25 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_addr_25)(aBaseAddr, 32)
        Set msix_msg_uppr_addr_25 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_25)(aBaseAddr, 32)
        Set msix_msg_data_25 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_data_25)(aBaseAddr, 32)
        Set msix_vect_ctl_25 = (New REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_25)(aBaseAddr, 32)
        Set msix_msg_addr_26 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_addr_26)(aBaseAddr, 32)
        Set msix_msg_uppr_addr_26 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_26)(aBaseAddr, 32)
        Set msix_msg_data_26 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_data_26)(aBaseAddr, 32)
        Set msix_vect_ctl_26 = (New REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_26)(aBaseAddr, 32)
        Set msix_msg_addr_27 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_addr_27)(aBaseAddr, 32)
        Set msix_msg_uppr_addr_27 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_27)(aBaseAddr, 32)
        Set msix_msg_data_27 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_data_27)(aBaseAddr, 32)
        Set msix_vect_ctl_27 = (New REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_27)(aBaseAddr, 32)
        Set msix_msg_addr_28 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_addr_28)(aBaseAddr, 32)
        Set msix_msg_uppr_addr_28 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_28)(aBaseAddr, 32)
        Set msix_msg_data_28 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_data_28)(aBaseAddr, 32)
        Set msix_vect_ctl_28 = (New REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_28)(aBaseAddr, 32)
        Set msix_msg_addr_29 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_addr_29)(aBaseAddr, 32)
        Set msix_msg_uppr_addr_29 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_29)(aBaseAddr, 32)
        Set msix_msg_data_29 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_data_29)(aBaseAddr, 32)
        Set msix_vect_ctl_29 = (New REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_29)(aBaseAddr, 32)
        Set msix_msg_addr_30 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_addr_30)(aBaseAddr, 32)
        Set msix_msg_uppr_addr_30 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_30)(aBaseAddr, 32)
        Set msix_msg_data_30 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_data_30)(aBaseAddr, 32)
        Set msix_vect_ctl_30 = (New REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_30)(aBaseAddr, 32)
        Set msix_msg_addr_31 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_addr_31)(aBaseAddr, 32)
        Set msix_msg_uppr_addr_31 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_31)(aBaseAddr, 32)
        Set msix_msg_data_31 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_data_31)(aBaseAddr, 32)
        Set msix_vect_ctl_31 = (New REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_31)(aBaseAddr, 32)
        Set msix_msg_addr_32 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_addr_32)(aBaseAddr, 32)
        Set msix_msg_uppr_addr_32 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_32)(aBaseAddr, 32)
        Set msix_msg_data_32 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_data_32)(aBaseAddr, 32)
        Set msix_vect_ctl_32 = (New REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_32)(aBaseAddr, 32)
        Set msix_msg_addr_33 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_addr_33)(aBaseAddr, 32)
        Set msix_msg_uppr_addr_33 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_33)(aBaseAddr, 32)
        Set msix_msg_data_33 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_data_33)(aBaseAddr, 32)
        Set msix_vect_ctl_33 = (New REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_33)(aBaseAddr, 32)
        Set msix_msg_addr_34 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_addr_34)(aBaseAddr, 32)
        Set msix_msg_uppr_addr_34 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_34)(aBaseAddr, 32)
        Set msix_msg_data_34 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_data_34)(aBaseAddr, 32)
        Set msix_vect_ctl_34 = (New REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_34)(aBaseAddr, 32)
        Set msix_msg_addr_35 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_addr_35)(aBaseAddr, 32)
        Set msix_msg_uppr_addr_35 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_35)(aBaseAddr, 32)
        Set msix_msg_data_35 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_data_35)(aBaseAddr, 32)
        Set msix_vect_ctl_35 = (New REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_35)(aBaseAddr, 32)
        Set msix_msg_addr_36 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_addr_36)(aBaseAddr, 32)
        Set msix_msg_uppr_addr_36 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_36)(aBaseAddr, 32)
        Set msix_msg_data_36 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_data_36)(aBaseAddr, 32)
        Set msix_vect_ctl_36 = (New REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_36)(aBaseAddr, 32)
        Set msix_msg_addr_37 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_addr_37)(aBaseAddr, 32)
        Set msix_msg_uppr_addr_37 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_37)(aBaseAddr, 32)
        Set msix_msg_data_37 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_data_37)(aBaseAddr, 32)
        Set msix_vect_ctl_37 = (New REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_37)(aBaseAddr, 32)
        Set msix_msg_addr_38 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_addr_38)(aBaseAddr, 32)
        Set msix_msg_uppr_addr_38 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_38)(aBaseAddr, 32)
        Set msix_msg_data_38 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_data_38)(aBaseAddr, 32)
        Set msix_vect_ctl_38 = (New REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_38)(aBaseAddr, 32)
        Set msix_msg_addr_39 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_addr_39)(aBaseAddr, 32)
        Set msix_msg_uppr_addr_39 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_39)(aBaseAddr, 32)
        Set msix_msg_data_39 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_data_39)(aBaseAddr, 32)
        Set msix_vect_ctl_39 = (New REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_39)(aBaseAddr, 32)
        Set msix_msg_addr_40 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_addr_40)(aBaseAddr, 32)
        Set msix_msg_uppr_addr_40 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_40)(aBaseAddr, 32)
        Set msix_msg_data_40 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_data_40)(aBaseAddr, 32)
        Set msix_vect_ctl_40 = (New REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_40)(aBaseAddr, 32)
        Set msix_msg_addr_41 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_addr_41)(aBaseAddr, 32)
        Set msix_msg_uppr_addr_41 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_41)(aBaseAddr, 32)
        Set msix_msg_data_41 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_data_41)(aBaseAddr, 32)
        Set msix_vect_ctl_41 = (New REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_41)(aBaseAddr, 32)
        Set msix_msg_addr_42 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_addr_42)(aBaseAddr, 32)
        Set msix_msg_uppr_addr_42 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_42)(aBaseAddr, 32)
        Set msix_msg_data_42 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_data_42)(aBaseAddr, 32)
        Set msix_vect_ctl_42 = (New REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_42)(aBaseAddr, 32)
        Set msix_msg_addr_43 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_addr_43)(aBaseAddr, 32)
        Set msix_msg_uppr_addr_43 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_43)(aBaseAddr, 32)
        Set msix_msg_data_43 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_data_43)(aBaseAddr, 32)
        Set msix_vect_ctl_43 = (New REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_43)(aBaseAddr, 32)
        Set msix_msg_addr_44 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_addr_44)(aBaseAddr, 32)
        Set msix_msg_uppr_addr_44 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_44)(aBaseAddr, 32)
        Set msix_msg_data_44 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_data_44)(aBaseAddr, 32)
        Set msix_vect_ctl_44 = (New REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_44)(aBaseAddr, 32)
        Set msix_msg_addr_45 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_addr_45)(aBaseAddr, 32)
        Set msix_msg_uppr_addr_45 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_45)(aBaseAddr, 32)
        Set msix_msg_data_45 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_data_45)(aBaseAddr, 32)
        Set msix_vect_ctl_45 = (New REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_45)(aBaseAddr, 32)
        Set msix_msg_addr_46 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_addr_46)(aBaseAddr, 32)
        Set msix_msg_uppr_addr_46 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_46)(aBaseAddr, 32)
        Set msix_msg_data_46 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_data_46)(aBaseAddr, 32)
        Set msix_vect_ctl_46 = (New REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_46)(aBaseAddr, 32)
        Set msix_msg_addr_47 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_addr_47)(aBaseAddr, 32)
        Set msix_msg_uppr_addr_47 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_47)(aBaseAddr, 32)
        Set msix_msg_data_47 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_data_47)(aBaseAddr, 32)
        Set msix_vect_ctl_47 = (New REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_47)(aBaseAddr, 32)
        Set msix_msg_addr_48 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_addr_48)(aBaseAddr, 32)
        Set msix_msg_uppr_addr_48 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_48)(aBaseAddr, 32)
        Set msix_msg_data_48 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_data_48)(aBaseAddr, 32)
        Set msix_vect_ctl_48 = (New REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_48)(aBaseAddr, 32)
        Set msix_msg_addr_49 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_addr_49)(aBaseAddr, 32)
        Set msix_msg_uppr_addr_49 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_49)(aBaseAddr, 32)
        Set msix_msg_data_49 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_data_49)(aBaseAddr, 32)
        Set msix_vect_ctl_49 = (New REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_49)(aBaseAddr, 32)
        Set msix_msg_addr_50 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_addr_50)(aBaseAddr, 32)
        Set msix_msg_uppr_addr_50 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_50)(aBaseAddr, 32)
        Set msix_msg_data_50 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_data_50)(aBaseAddr, 32)
        Set msix_vect_ctl_50 = (New REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_50)(aBaseAddr, 32)
        Set msix_msg_addr_51 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_addr_51)(aBaseAddr, 32)
        Set msix_msg_uppr_addr_51 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_51)(aBaseAddr, 32)
        Set msix_msg_data_51 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_data_51)(aBaseAddr, 32)
        Set msix_vect_ctl_51 = (New REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_51)(aBaseAddr, 32)
        Set msix_msg_addr_52 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_addr_52)(aBaseAddr, 32)
        Set msix_msg_uppr_addr_52 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_52)(aBaseAddr, 32)
        Set msix_msg_data_52 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_data_52)(aBaseAddr, 32)
        Set msix_vect_ctl_52 = (New REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_52)(aBaseAddr, 32)
        Set msix_msg_addr_53 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_addr_53)(aBaseAddr, 32)
        Set msix_msg_uppr_addr_53 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_53)(aBaseAddr, 32)
        Set msix_msg_data_53 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_data_53)(aBaseAddr, 32)
        Set msix_vect_ctl_53 = (New REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_53)(aBaseAddr, 32)
        Set msix_msg_addr_54 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_addr_54)(aBaseAddr, 32)
        Set msix_msg_uppr_addr_54 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_54)(aBaseAddr, 32)
        Set msix_msg_data_54 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_data_54)(aBaseAddr, 32)
        Set msix_vect_ctl_54 = (New REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_54)(aBaseAddr, 32)
        Set msix_msg_addr_55 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_addr_55)(aBaseAddr, 32)
        Set msix_msg_uppr_addr_55 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_55)(aBaseAddr, 32)
        Set msix_msg_data_55 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_data_55)(aBaseAddr, 32)
        Set msix_vect_ctl_55 = (New REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_55)(aBaseAddr, 32)
        Set msix_msg_addr_56 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_addr_56)(aBaseAddr, 32)
        Set msix_msg_uppr_addr_56 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_56)(aBaseAddr, 32)
        Set msix_msg_data_56 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_data_56)(aBaseAddr, 32)
        Set msix_vect_ctl_56 = (New REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_56)(aBaseAddr, 32)
        Set msix_msg_addr_57 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_addr_57)(aBaseAddr, 32)
        Set msix_msg_uppr_addr_57 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_57)(aBaseAddr, 32)
        Set msix_msg_data_57 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_data_57)(aBaseAddr, 32)
        Set msix_vect_ctl_57 = (New REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_57)(aBaseAddr, 32)
        Set msix_msg_addr_58 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_addr_58)(aBaseAddr, 32)
        Set msix_msg_uppr_addr_58 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_58)(aBaseAddr, 32)
        Set msix_msg_data_58 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_data_58)(aBaseAddr, 32)
        Set msix_vect_ctl_58 = (New REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_58)(aBaseAddr, 32)
        Set msix_msg_addr_59 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_addr_59)(aBaseAddr, 32)
        Set msix_msg_uppr_addr_59 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_59)(aBaseAddr, 32)
        Set msix_msg_data_59 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_data_59)(aBaseAddr, 32)
        Set msix_vect_ctl_59 = (New REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_59)(aBaseAddr, 32)
        Set msix_msg_addr_60 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_addr_60)(aBaseAddr, 32)
        Set msix_msg_uppr_addr_60 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_60)(aBaseAddr, 32)
        Set msix_msg_data_60 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_data_60)(aBaseAddr, 32)
        Set msix_vect_ctl_60 = (New REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_60)(aBaseAddr, 32)
        Set msix_msg_addr_61 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_addr_61)(aBaseAddr, 32)
        Set msix_msg_uppr_addr_61 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_61)(aBaseAddr, 32)
        Set msix_msg_data_61 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_data_61)(aBaseAddr, 32)
        Set msix_vect_ctl_61 = (New REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_61)(aBaseAddr, 32)
        Set msix_msg_addr_62 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_addr_62)(aBaseAddr, 32)
        Set msix_msg_uppr_addr_62 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_62)(aBaseAddr, 32)
        Set msix_msg_data_62 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_data_62)(aBaseAddr, 32)
        Set msix_vect_ctl_62 = (New REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_62)(aBaseAddr, 32)
        Set msix_msg_addr_63 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_addr_63)(aBaseAddr, 32)
        Set msix_msg_uppr_addr_63 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_uppr_addr_63)(aBaseAddr, 32)
        Set msix_msg_data_63 = (New REGISTER_GEN2_TOP_MSIX_msix_msg_data_63)(aBaseAddr, 32)
        Set msix_vect_ctl_63 = (New REGISTER_GEN2_TOP_MSIX_msix_vect_ctl_63)(aBaseAddr, 32)
        Set msix_pba_31_0 = (New REGISTER_GEN2_TOP_MSIX_msix_pba_31_0)(aBaseAddr, 32)
        Set msix_pba_63_32 = (New REGISTER_GEN2_TOP_MSIX_msix_pba_63_32)(aBaseAddr, 32)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set GEN2_TOP_MSIX = CreateObject("System.Collections.ArrayList")
GEN2_TOP_MSIX.Add ((New GEN2_TOP_MSIX_INSTANCE)(&H4c108000))


