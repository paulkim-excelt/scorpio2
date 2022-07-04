

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


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_sci_lo_0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' rxsc_sci_31_0                              [31:0]           get_rxsc_sci_31_0
''                                                             set_rxsc_sci_31_0
''                                                             read_rxsc_sci_31_0
''                                                             write_rxsc_sci_31_0
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_sci_lo_0
    Private write_rxsc_sci_31_0_value
    Private read_rxsc_sci_31_0_value
    Private flag_rxsc_sci_31_0

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3400
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_rxsc_sci_31_0
        get_rxsc_sci_31_0 = read_rxsc_sci_31_0_value
    End Property

    Property Let set_rxsc_sci_31_0(aData)
        write_rxsc_sci_31_0_value = aData
        flag_rxsc_sci_31_0        = &H1
    End Property

    Property Get read_rxsc_sci_31_0
        read
        read_rxsc_sci_31_0 = read_rxsc_sci_31_0_value
    End Property

    Property Let write_rxsc_sci_31_0(aData)
        set_rxsc_sci_31_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rxsc_sci_31_0_mask = &Hffffffff
        if data_low > LONG_MAX then
            if rxsc_sci_31_0_mask = mask then
                read_rxsc_sci_31_0_value = data_low
            else
                read_rxsc_sci_31_0_value = (data_low - H8000_0000) and rxsc_sci_31_0_mask
            end If
        else
            read_rxsc_sci_31_0_value = data_low and rxsc_sci_31_0_mask
        end If

    End Sub

    Sub write
        If flag_rxsc_sci_31_0 = &H0 Then read
        If flag_rxsc_sci_31_0 = &H0 Then write_rxsc_sci_31_0_value = get_rxsc_sci_31_0

        regValue = leftShift(write_rxsc_sci_31_0_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rxsc_sci_31_0_mask = &Hffffffff
        if data_low > LONG_MAX then
            if rxsc_sci_31_0_mask = mask then
                read_rxsc_sci_31_0_value = data_low
            else
                read_rxsc_sci_31_0_value = (data_low - H8000_0000) and rxsc_sci_31_0_mask
            end If
        else
            read_rxsc_sci_31_0_value = data_low and rxsc_sci_31_0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_rxsc_sci_31_0_value = &H0
        flag_rxsc_sci_31_0        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_sci_hi_0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' rxsc_sci_63_32                             [31:0]           get_rxsc_sci_63_32
''                                                             set_rxsc_sci_63_32
''                                                             read_rxsc_sci_63_32
''                                                             write_rxsc_sci_63_32
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_sci_hi_0
    Private write_rxsc_sci_63_32_value
    Private read_rxsc_sci_63_32_value
    Private flag_rxsc_sci_63_32

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3404
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_rxsc_sci_63_32
        get_rxsc_sci_63_32 = read_rxsc_sci_63_32_value
    End Property

    Property Let set_rxsc_sci_63_32(aData)
        write_rxsc_sci_63_32_value = aData
        flag_rxsc_sci_63_32        = &H1
    End Property

    Property Get read_rxsc_sci_63_32
        read
        read_rxsc_sci_63_32 = read_rxsc_sci_63_32_value
    End Property

    Property Let write_rxsc_sci_63_32(aData)
        set_rxsc_sci_63_32 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rxsc_sci_63_32_mask = &Hffffffff
        if data_low > LONG_MAX then
            if rxsc_sci_63_32_mask = mask then
                read_rxsc_sci_63_32_value = data_low
            else
                read_rxsc_sci_63_32_value = (data_low - H8000_0000) and rxsc_sci_63_32_mask
            end If
        else
            read_rxsc_sci_63_32_value = data_low and rxsc_sci_63_32_mask
        end If

    End Sub

    Sub write
        If flag_rxsc_sci_63_32 = &H0 Then read
        If flag_rxsc_sci_63_32 = &H0 Then write_rxsc_sci_63_32_value = get_rxsc_sci_63_32

        regValue = leftShift(write_rxsc_sci_63_32_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rxsc_sci_63_32_mask = &Hffffffff
        if data_low > LONG_MAX then
            if rxsc_sci_63_32_mask = mask then
                read_rxsc_sci_63_32_value = data_low
            else
                read_rxsc_sci_63_32_value = (data_low - H8000_0000) and rxsc_sci_63_32_mask
            end If
        else
            read_rxsc_sci_63_32_value = data_low and rxsc_sci_63_32_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_rxsc_sci_63_32_value = &H0
        flag_rxsc_sci_63_32        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_ctrl_0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' vport_index                                [3:0]            get_vport_index
''                                                             set_vport_index
''                                                             read_vport_index
''                                                             write_vport_index
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_ctrl_0
    Private write_vport_index_value
    Private read_vport_index_value
    Private flag_vport_index

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3408
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_vport_index
        get_vport_index = read_vport_index_value
    End Property

    Property Let set_vport_index(aData)
        write_vport_index_value = aData
        flag_vport_index        = &H1
    End Property

    Property Get read_vport_index
        read
        read_vport_index = read_vport_index_value
    End Property

    Property Let write_vport_index(aData)
        set_vport_index = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        vport_index_mask = &Hf
        if data_low > LONG_MAX then
            if vport_index_mask = mask then
                read_vport_index_value = data_low
            else
                read_vport_index_value = (data_low - H8000_0000) and vport_index_mask
            end If
        else
            read_vport_index_value = data_low and vport_index_mask
        end If

    End Sub

    Sub write
        If flag_vport_index = &H0 Then read
        If flag_vport_index = &H0 Then write_vport_index_value = get_vport_index

        regValue = leftShift((write_vport_index_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        vport_index_mask = &Hf
        if data_low > LONG_MAX then
            if vport_index_mask = mask then
                read_vport_index_value = data_low
            else
                read_vport_index_value = (data_low - H8000_0000) and vport_index_mask
            end If
        else
            read_vport_index_value = data_low and vport_index_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_vport_index_value = &H0
        flag_vport_index        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_sci_lo_1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' rxsc_sci_31_0                              [31:0]           get_rxsc_sci_31_0
''                                                             set_rxsc_sci_31_0
''                                                             read_rxsc_sci_31_0
''                                                             write_rxsc_sci_31_0
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_sci_lo_1
    Private write_rxsc_sci_31_0_value
    Private read_rxsc_sci_31_0_value
    Private flag_rxsc_sci_31_0

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3410
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_rxsc_sci_31_0
        get_rxsc_sci_31_0 = read_rxsc_sci_31_0_value
    End Property

    Property Let set_rxsc_sci_31_0(aData)
        write_rxsc_sci_31_0_value = aData
        flag_rxsc_sci_31_0        = &H1
    End Property

    Property Get read_rxsc_sci_31_0
        read
        read_rxsc_sci_31_0 = read_rxsc_sci_31_0_value
    End Property

    Property Let write_rxsc_sci_31_0(aData)
        set_rxsc_sci_31_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rxsc_sci_31_0_mask = &Hffffffff
        if data_low > LONG_MAX then
            if rxsc_sci_31_0_mask = mask then
                read_rxsc_sci_31_0_value = data_low
            else
                read_rxsc_sci_31_0_value = (data_low - H8000_0000) and rxsc_sci_31_0_mask
            end If
        else
            read_rxsc_sci_31_0_value = data_low and rxsc_sci_31_0_mask
        end If

    End Sub

    Sub write
        If flag_rxsc_sci_31_0 = &H0 Then read
        If flag_rxsc_sci_31_0 = &H0 Then write_rxsc_sci_31_0_value = get_rxsc_sci_31_0

        regValue = leftShift(write_rxsc_sci_31_0_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rxsc_sci_31_0_mask = &Hffffffff
        if data_low > LONG_MAX then
            if rxsc_sci_31_0_mask = mask then
                read_rxsc_sci_31_0_value = data_low
            else
                read_rxsc_sci_31_0_value = (data_low - H8000_0000) and rxsc_sci_31_0_mask
            end If
        else
            read_rxsc_sci_31_0_value = data_low and rxsc_sci_31_0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_rxsc_sci_31_0_value = &H0
        flag_rxsc_sci_31_0        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_sci_hi_1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' rxsc_sci_63_32                             [31:0]           get_rxsc_sci_63_32
''                                                             set_rxsc_sci_63_32
''                                                             read_rxsc_sci_63_32
''                                                             write_rxsc_sci_63_32
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_sci_hi_1
    Private write_rxsc_sci_63_32_value
    Private read_rxsc_sci_63_32_value
    Private flag_rxsc_sci_63_32

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3414
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_rxsc_sci_63_32
        get_rxsc_sci_63_32 = read_rxsc_sci_63_32_value
    End Property

    Property Let set_rxsc_sci_63_32(aData)
        write_rxsc_sci_63_32_value = aData
        flag_rxsc_sci_63_32        = &H1
    End Property

    Property Get read_rxsc_sci_63_32
        read
        read_rxsc_sci_63_32 = read_rxsc_sci_63_32_value
    End Property

    Property Let write_rxsc_sci_63_32(aData)
        set_rxsc_sci_63_32 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rxsc_sci_63_32_mask = &Hffffffff
        if data_low > LONG_MAX then
            if rxsc_sci_63_32_mask = mask then
                read_rxsc_sci_63_32_value = data_low
            else
                read_rxsc_sci_63_32_value = (data_low - H8000_0000) and rxsc_sci_63_32_mask
            end If
        else
            read_rxsc_sci_63_32_value = data_low and rxsc_sci_63_32_mask
        end If

    End Sub

    Sub write
        If flag_rxsc_sci_63_32 = &H0 Then read
        If flag_rxsc_sci_63_32 = &H0 Then write_rxsc_sci_63_32_value = get_rxsc_sci_63_32

        regValue = leftShift(write_rxsc_sci_63_32_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rxsc_sci_63_32_mask = &Hffffffff
        if data_low > LONG_MAX then
            if rxsc_sci_63_32_mask = mask then
                read_rxsc_sci_63_32_value = data_low
            else
                read_rxsc_sci_63_32_value = (data_low - H8000_0000) and rxsc_sci_63_32_mask
            end If
        else
            read_rxsc_sci_63_32_value = data_low and rxsc_sci_63_32_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_rxsc_sci_63_32_value = &H0
        flag_rxsc_sci_63_32        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_ctrl_1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' vport_index                                [3:0]            get_vport_index
''                                                             set_vport_index
''                                                             read_vport_index
''                                                             write_vport_index
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_ctrl_1
    Private write_vport_index_value
    Private read_vport_index_value
    Private flag_vport_index

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3418
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_vport_index
        get_vport_index = read_vport_index_value
    End Property

    Property Let set_vport_index(aData)
        write_vport_index_value = aData
        flag_vport_index        = &H1
    End Property

    Property Get read_vport_index
        read
        read_vport_index = read_vport_index_value
    End Property

    Property Let write_vport_index(aData)
        set_vport_index = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        vport_index_mask = &Hf
        if data_low > LONG_MAX then
            if vport_index_mask = mask then
                read_vport_index_value = data_low
            else
                read_vport_index_value = (data_low - H8000_0000) and vport_index_mask
            end If
        else
            read_vport_index_value = data_low and vport_index_mask
        end If

    End Sub

    Sub write
        If flag_vport_index = &H0 Then read
        If flag_vport_index = &H0 Then write_vport_index_value = get_vport_index

        regValue = leftShift((write_vport_index_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        vport_index_mask = &Hf
        if data_low > LONG_MAX then
            if vport_index_mask = mask then
                read_vport_index_value = data_low
            else
                read_vport_index_value = (data_low - H8000_0000) and vport_index_mask
            end If
        else
            read_vport_index_value = data_low and vport_index_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_vport_index_value = &H0
        flag_vport_index        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_sci_lo_2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' rxsc_sci_31_0                              [31:0]           get_rxsc_sci_31_0
''                                                             set_rxsc_sci_31_0
''                                                             read_rxsc_sci_31_0
''                                                             write_rxsc_sci_31_0
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_sci_lo_2
    Private write_rxsc_sci_31_0_value
    Private read_rxsc_sci_31_0_value
    Private flag_rxsc_sci_31_0

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3420
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_rxsc_sci_31_0
        get_rxsc_sci_31_0 = read_rxsc_sci_31_0_value
    End Property

    Property Let set_rxsc_sci_31_0(aData)
        write_rxsc_sci_31_0_value = aData
        flag_rxsc_sci_31_0        = &H1
    End Property

    Property Get read_rxsc_sci_31_0
        read
        read_rxsc_sci_31_0 = read_rxsc_sci_31_0_value
    End Property

    Property Let write_rxsc_sci_31_0(aData)
        set_rxsc_sci_31_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rxsc_sci_31_0_mask = &Hffffffff
        if data_low > LONG_MAX then
            if rxsc_sci_31_0_mask = mask then
                read_rxsc_sci_31_0_value = data_low
            else
                read_rxsc_sci_31_0_value = (data_low - H8000_0000) and rxsc_sci_31_0_mask
            end If
        else
            read_rxsc_sci_31_0_value = data_low and rxsc_sci_31_0_mask
        end If

    End Sub

    Sub write
        If flag_rxsc_sci_31_0 = &H0 Then read
        If flag_rxsc_sci_31_0 = &H0 Then write_rxsc_sci_31_0_value = get_rxsc_sci_31_0

        regValue = leftShift(write_rxsc_sci_31_0_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rxsc_sci_31_0_mask = &Hffffffff
        if data_low > LONG_MAX then
            if rxsc_sci_31_0_mask = mask then
                read_rxsc_sci_31_0_value = data_low
            else
                read_rxsc_sci_31_0_value = (data_low - H8000_0000) and rxsc_sci_31_0_mask
            end If
        else
            read_rxsc_sci_31_0_value = data_low and rxsc_sci_31_0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_rxsc_sci_31_0_value = &H0
        flag_rxsc_sci_31_0        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_sci_hi_2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' rxsc_sci_63_32                             [31:0]           get_rxsc_sci_63_32
''                                                             set_rxsc_sci_63_32
''                                                             read_rxsc_sci_63_32
''                                                             write_rxsc_sci_63_32
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_sci_hi_2
    Private write_rxsc_sci_63_32_value
    Private read_rxsc_sci_63_32_value
    Private flag_rxsc_sci_63_32

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3424
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_rxsc_sci_63_32
        get_rxsc_sci_63_32 = read_rxsc_sci_63_32_value
    End Property

    Property Let set_rxsc_sci_63_32(aData)
        write_rxsc_sci_63_32_value = aData
        flag_rxsc_sci_63_32        = &H1
    End Property

    Property Get read_rxsc_sci_63_32
        read
        read_rxsc_sci_63_32 = read_rxsc_sci_63_32_value
    End Property

    Property Let write_rxsc_sci_63_32(aData)
        set_rxsc_sci_63_32 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rxsc_sci_63_32_mask = &Hffffffff
        if data_low > LONG_MAX then
            if rxsc_sci_63_32_mask = mask then
                read_rxsc_sci_63_32_value = data_low
            else
                read_rxsc_sci_63_32_value = (data_low - H8000_0000) and rxsc_sci_63_32_mask
            end If
        else
            read_rxsc_sci_63_32_value = data_low and rxsc_sci_63_32_mask
        end If

    End Sub

    Sub write
        If flag_rxsc_sci_63_32 = &H0 Then read
        If flag_rxsc_sci_63_32 = &H0 Then write_rxsc_sci_63_32_value = get_rxsc_sci_63_32

        regValue = leftShift(write_rxsc_sci_63_32_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rxsc_sci_63_32_mask = &Hffffffff
        if data_low > LONG_MAX then
            if rxsc_sci_63_32_mask = mask then
                read_rxsc_sci_63_32_value = data_low
            else
                read_rxsc_sci_63_32_value = (data_low - H8000_0000) and rxsc_sci_63_32_mask
            end If
        else
            read_rxsc_sci_63_32_value = data_low and rxsc_sci_63_32_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_rxsc_sci_63_32_value = &H0
        flag_rxsc_sci_63_32        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_ctrl_2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' vport_index                                [3:0]            get_vport_index
''                                                             set_vport_index
''                                                             read_vport_index
''                                                             write_vport_index
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_ctrl_2
    Private write_vport_index_value
    Private read_vport_index_value
    Private flag_vport_index

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3428
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_vport_index
        get_vport_index = read_vport_index_value
    End Property

    Property Let set_vport_index(aData)
        write_vport_index_value = aData
        flag_vport_index        = &H1
    End Property

    Property Get read_vport_index
        read
        read_vport_index = read_vport_index_value
    End Property

    Property Let write_vport_index(aData)
        set_vport_index = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        vport_index_mask = &Hf
        if data_low > LONG_MAX then
            if vport_index_mask = mask then
                read_vport_index_value = data_low
            else
                read_vport_index_value = (data_low - H8000_0000) and vport_index_mask
            end If
        else
            read_vport_index_value = data_low and vport_index_mask
        end If

    End Sub

    Sub write
        If flag_vport_index = &H0 Then read
        If flag_vport_index = &H0 Then write_vport_index_value = get_vport_index

        regValue = leftShift((write_vport_index_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        vport_index_mask = &Hf
        if data_low > LONG_MAX then
            if vport_index_mask = mask then
                read_vport_index_value = data_low
            else
                read_vport_index_value = (data_low - H8000_0000) and vport_index_mask
            end If
        else
            read_vport_index_value = data_low and vport_index_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_vport_index_value = &H0
        flag_vport_index        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_sci_lo_3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' rxsc_sci_31_0                              [31:0]           get_rxsc_sci_31_0
''                                                             set_rxsc_sci_31_0
''                                                             read_rxsc_sci_31_0
''                                                             write_rxsc_sci_31_0
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_sci_lo_3
    Private write_rxsc_sci_31_0_value
    Private read_rxsc_sci_31_0_value
    Private flag_rxsc_sci_31_0

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3430
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_rxsc_sci_31_0
        get_rxsc_sci_31_0 = read_rxsc_sci_31_0_value
    End Property

    Property Let set_rxsc_sci_31_0(aData)
        write_rxsc_sci_31_0_value = aData
        flag_rxsc_sci_31_0        = &H1
    End Property

    Property Get read_rxsc_sci_31_0
        read
        read_rxsc_sci_31_0 = read_rxsc_sci_31_0_value
    End Property

    Property Let write_rxsc_sci_31_0(aData)
        set_rxsc_sci_31_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rxsc_sci_31_0_mask = &Hffffffff
        if data_low > LONG_MAX then
            if rxsc_sci_31_0_mask = mask then
                read_rxsc_sci_31_0_value = data_low
            else
                read_rxsc_sci_31_0_value = (data_low - H8000_0000) and rxsc_sci_31_0_mask
            end If
        else
            read_rxsc_sci_31_0_value = data_low and rxsc_sci_31_0_mask
        end If

    End Sub

    Sub write
        If flag_rxsc_sci_31_0 = &H0 Then read
        If flag_rxsc_sci_31_0 = &H0 Then write_rxsc_sci_31_0_value = get_rxsc_sci_31_0

        regValue = leftShift(write_rxsc_sci_31_0_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rxsc_sci_31_0_mask = &Hffffffff
        if data_low > LONG_MAX then
            if rxsc_sci_31_0_mask = mask then
                read_rxsc_sci_31_0_value = data_low
            else
                read_rxsc_sci_31_0_value = (data_low - H8000_0000) and rxsc_sci_31_0_mask
            end If
        else
            read_rxsc_sci_31_0_value = data_low and rxsc_sci_31_0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_rxsc_sci_31_0_value = &H0
        flag_rxsc_sci_31_0        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_sci_hi_3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' rxsc_sci_63_32                             [31:0]           get_rxsc_sci_63_32
''                                                             set_rxsc_sci_63_32
''                                                             read_rxsc_sci_63_32
''                                                             write_rxsc_sci_63_32
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_sci_hi_3
    Private write_rxsc_sci_63_32_value
    Private read_rxsc_sci_63_32_value
    Private flag_rxsc_sci_63_32

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3434
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_rxsc_sci_63_32
        get_rxsc_sci_63_32 = read_rxsc_sci_63_32_value
    End Property

    Property Let set_rxsc_sci_63_32(aData)
        write_rxsc_sci_63_32_value = aData
        flag_rxsc_sci_63_32        = &H1
    End Property

    Property Get read_rxsc_sci_63_32
        read
        read_rxsc_sci_63_32 = read_rxsc_sci_63_32_value
    End Property

    Property Let write_rxsc_sci_63_32(aData)
        set_rxsc_sci_63_32 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rxsc_sci_63_32_mask = &Hffffffff
        if data_low > LONG_MAX then
            if rxsc_sci_63_32_mask = mask then
                read_rxsc_sci_63_32_value = data_low
            else
                read_rxsc_sci_63_32_value = (data_low - H8000_0000) and rxsc_sci_63_32_mask
            end If
        else
            read_rxsc_sci_63_32_value = data_low and rxsc_sci_63_32_mask
        end If

    End Sub

    Sub write
        If flag_rxsc_sci_63_32 = &H0 Then read
        If flag_rxsc_sci_63_32 = &H0 Then write_rxsc_sci_63_32_value = get_rxsc_sci_63_32

        regValue = leftShift(write_rxsc_sci_63_32_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rxsc_sci_63_32_mask = &Hffffffff
        if data_low > LONG_MAX then
            if rxsc_sci_63_32_mask = mask then
                read_rxsc_sci_63_32_value = data_low
            else
                read_rxsc_sci_63_32_value = (data_low - H8000_0000) and rxsc_sci_63_32_mask
            end If
        else
            read_rxsc_sci_63_32_value = data_low and rxsc_sci_63_32_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_rxsc_sci_63_32_value = &H0
        flag_rxsc_sci_63_32        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_ctrl_3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' vport_index                                [3:0]            get_vport_index
''                                                             set_vport_index
''                                                             read_vport_index
''                                                             write_vport_index
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_ctrl_3
    Private write_vport_index_value
    Private read_vport_index_value
    Private flag_vport_index

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3438
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_vport_index
        get_vport_index = read_vport_index_value
    End Property

    Property Let set_vport_index(aData)
        write_vport_index_value = aData
        flag_vport_index        = &H1
    End Property

    Property Get read_vport_index
        read
        read_vport_index = read_vport_index_value
    End Property

    Property Let write_vport_index(aData)
        set_vport_index = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        vport_index_mask = &Hf
        if data_low > LONG_MAX then
            if vport_index_mask = mask then
                read_vport_index_value = data_low
            else
                read_vport_index_value = (data_low - H8000_0000) and vport_index_mask
            end If
        else
            read_vport_index_value = data_low and vport_index_mask
        end If

    End Sub

    Sub write
        If flag_vport_index = &H0 Then read
        If flag_vport_index = &H0 Then write_vport_index_value = get_vport_index

        regValue = leftShift((write_vport_index_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        vport_index_mask = &Hf
        if data_low > LONG_MAX then
            if vport_index_mask = mask then
                read_vport_index_value = data_low
            else
                read_vport_index_value = (data_low - H8000_0000) and vport_index_mask
            end If
        else
            read_vport_index_value = data_low and vport_index_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_vport_index_value = &H0
        flag_vport_index        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_sci_lo_4
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' rxsc_sci_31_0                              [31:0]           get_rxsc_sci_31_0
''                                                             set_rxsc_sci_31_0
''                                                             read_rxsc_sci_31_0
''                                                             write_rxsc_sci_31_0
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_sci_lo_4
    Private write_rxsc_sci_31_0_value
    Private read_rxsc_sci_31_0_value
    Private flag_rxsc_sci_31_0

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3440
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_rxsc_sci_31_0
        get_rxsc_sci_31_0 = read_rxsc_sci_31_0_value
    End Property

    Property Let set_rxsc_sci_31_0(aData)
        write_rxsc_sci_31_0_value = aData
        flag_rxsc_sci_31_0        = &H1
    End Property

    Property Get read_rxsc_sci_31_0
        read
        read_rxsc_sci_31_0 = read_rxsc_sci_31_0_value
    End Property

    Property Let write_rxsc_sci_31_0(aData)
        set_rxsc_sci_31_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rxsc_sci_31_0_mask = &Hffffffff
        if data_low > LONG_MAX then
            if rxsc_sci_31_0_mask = mask then
                read_rxsc_sci_31_0_value = data_low
            else
                read_rxsc_sci_31_0_value = (data_low - H8000_0000) and rxsc_sci_31_0_mask
            end If
        else
            read_rxsc_sci_31_0_value = data_low and rxsc_sci_31_0_mask
        end If

    End Sub

    Sub write
        If flag_rxsc_sci_31_0 = &H0 Then read
        If flag_rxsc_sci_31_0 = &H0 Then write_rxsc_sci_31_0_value = get_rxsc_sci_31_0

        regValue = leftShift(write_rxsc_sci_31_0_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rxsc_sci_31_0_mask = &Hffffffff
        if data_low > LONG_MAX then
            if rxsc_sci_31_0_mask = mask then
                read_rxsc_sci_31_0_value = data_low
            else
                read_rxsc_sci_31_0_value = (data_low - H8000_0000) and rxsc_sci_31_0_mask
            end If
        else
            read_rxsc_sci_31_0_value = data_low and rxsc_sci_31_0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_rxsc_sci_31_0_value = &H0
        flag_rxsc_sci_31_0        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_sci_hi_4
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' rxsc_sci_63_32                             [31:0]           get_rxsc_sci_63_32
''                                                             set_rxsc_sci_63_32
''                                                             read_rxsc_sci_63_32
''                                                             write_rxsc_sci_63_32
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_sci_hi_4
    Private write_rxsc_sci_63_32_value
    Private read_rxsc_sci_63_32_value
    Private flag_rxsc_sci_63_32

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3444
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_rxsc_sci_63_32
        get_rxsc_sci_63_32 = read_rxsc_sci_63_32_value
    End Property

    Property Let set_rxsc_sci_63_32(aData)
        write_rxsc_sci_63_32_value = aData
        flag_rxsc_sci_63_32        = &H1
    End Property

    Property Get read_rxsc_sci_63_32
        read
        read_rxsc_sci_63_32 = read_rxsc_sci_63_32_value
    End Property

    Property Let write_rxsc_sci_63_32(aData)
        set_rxsc_sci_63_32 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rxsc_sci_63_32_mask = &Hffffffff
        if data_low > LONG_MAX then
            if rxsc_sci_63_32_mask = mask then
                read_rxsc_sci_63_32_value = data_low
            else
                read_rxsc_sci_63_32_value = (data_low - H8000_0000) and rxsc_sci_63_32_mask
            end If
        else
            read_rxsc_sci_63_32_value = data_low and rxsc_sci_63_32_mask
        end If

    End Sub

    Sub write
        If flag_rxsc_sci_63_32 = &H0 Then read
        If flag_rxsc_sci_63_32 = &H0 Then write_rxsc_sci_63_32_value = get_rxsc_sci_63_32

        regValue = leftShift(write_rxsc_sci_63_32_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rxsc_sci_63_32_mask = &Hffffffff
        if data_low > LONG_MAX then
            if rxsc_sci_63_32_mask = mask then
                read_rxsc_sci_63_32_value = data_low
            else
                read_rxsc_sci_63_32_value = (data_low - H8000_0000) and rxsc_sci_63_32_mask
            end If
        else
            read_rxsc_sci_63_32_value = data_low and rxsc_sci_63_32_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_rxsc_sci_63_32_value = &H0
        flag_rxsc_sci_63_32        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_ctrl_4
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' vport_index                                [3:0]            get_vport_index
''                                                             set_vport_index
''                                                             read_vport_index
''                                                             write_vport_index
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_ctrl_4
    Private write_vport_index_value
    Private read_vport_index_value
    Private flag_vport_index

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3448
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_vport_index
        get_vport_index = read_vport_index_value
    End Property

    Property Let set_vport_index(aData)
        write_vport_index_value = aData
        flag_vport_index        = &H1
    End Property

    Property Get read_vport_index
        read
        read_vport_index = read_vport_index_value
    End Property

    Property Let write_vport_index(aData)
        set_vport_index = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        vport_index_mask = &Hf
        if data_low > LONG_MAX then
            if vport_index_mask = mask then
                read_vport_index_value = data_low
            else
                read_vport_index_value = (data_low - H8000_0000) and vport_index_mask
            end If
        else
            read_vport_index_value = data_low and vport_index_mask
        end If

    End Sub

    Sub write
        If flag_vport_index = &H0 Then read
        If flag_vport_index = &H0 Then write_vport_index_value = get_vport_index

        regValue = leftShift((write_vport_index_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        vport_index_mask = &Hf
        if data_low > LONG_MAX then
            if vport_index_mask = mask then
                read_vport_index_value = data_low
            else
                read_vport_index_value = (data_low - H8000_0000) and vport_index_mask
            end If
        else
            read_vport_index_value = data_low and vport_index_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_vport_index_value = &H0
        flag_vport_index        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_sci_lo_5
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' rxsc_sci_31_0                              [31:0]           get_rxsc_sci_31_0
''                                                             set_rxsc_sci_31_0
''                                                             read_rxsc_sci_31_0
''                                                             write_rxsc_sci_31_0
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_sci_lo_5
    Private write_rxsc_sci_31_0_value
    Private read_rxsc_sci_31_0_value
    Private flag_rxsc_sci_31_0

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3450
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_rxsc_sci_31_0
        get_rxsc_sci_31_0 = read_rxsc_sci_31_0_value
    End Property

    Property Let set_rxsc_sci_31_0(aData)
        write_rxsc_sci_31_0_value = aData
        flag_rxsc_sci_31_0        = &H1
    End Property

    Property Get read_rxsc_sci_31_0
        read
        read_rxsc_sci_31_0 = read_rxsc_sci_31_0_value
    End Property

    Property Let write_rxsc_sci_31_0(aData)
        set_rxsc_sci_31_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rxsc_sci_31_0_mask = &Hffffffff
        if data_low > LONG_MAX then
            if rxsc_sci_31_0_mask = mask then
                read_rxsc_sci_31_0_value = data_low
            else
                read_rxsc_sci_31_0_value = (data_low - H8000_0000) and rxsc_sci_31_0_mask
            end If
        else
            read_rxsc_sci_31_0_value = data_low and rxsc_sci_31_0_mask
        end If

    End Sub

    Sub write
        If flag_rxsc_sci_31_0 = &H0 Then read
        If flag_rxsc_sci_31_0 = &H0 Then write_rxsc_sci_31_0_value = get_rxsc_sci_31_0

        regValue = leftShift(write_rxsc_sci_31_0_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rxsc_sci_31_0_mask = &Hffffffff
        if data_low > LONG_MAX then
            if rxsc_sci_31_0_mask = mask then
                read_rxsc_sci_31_0_value = data_low
            else
                read_rxsc_sci_31_0_value = (data_low - H8000_0000) and rxsc_sci_31_0_mask
            end If
        else
            read_rxsc_sci_31_0_value = data_low and rxsc_sci_31_0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_rxsc_sci_31_0_value = &H0
        flag_rxsc_sci_31_0        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_sci_hi_5
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' rxsc_sci_63_32                             [31:0]           get_rxsc_sci_63_32
''                                                             set_rxsc_sci_63_32
''                                                             read_rxsc_sci_63_32
''                                                             write_rxsc_sci_63_32
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_sci_hi_5
    Private write_rxsc_sci_63_32_value
    Private read_rxsc_sci_63_32_value
    Private flag_rxsc_sci_63_32

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3454
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_rxsc_sci_63_32
        get_rxsc_sci_63_32 = read_rxsc_sci_63_32_value
    End Property

    Property Let set_rxsc_sci_63_32(aData)
        write_rxsc_sci_63_32_value = aData
        flag_rxsc_sci_63_32        = &H1
    End Property

    Property Get read_rxsc_sci_63_32
        read
        read_rxsc_sci_63_32 = read_rxsc_sci_63_32_value
    End Property

    Property Let write_rxsc_sci_63_32(aData)
        set_rxsc_sci_63_32 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rxsc_sci_63_32_mask = &Hffffffff
        if data_low > LONG_MAX then
            if rxsc_sci_63_32_mask = mask then
                read_rxsc_sci_63_32_value = data_low
            else
                read_rxsc_sci_63_32_value = (data_low - H8000_0000) and rxsc_sci_63_32_mask
            end If
        else
            read_rxsc_sci_63_32_value = data_low and rxsc_sci_63_32_mask
        end If

    End Sub

    Sub write
        If flag_rxsc_sci_63_32 = &H0 Then read
        If flag_rxsc_sci_63_32 = &H0 Then write_rxsc_sci_63_32_value = get_rxsc_sci_63_32

        regValue = leftShift(write_rxsc_sci_63_32_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rxsc_sci_63_32_mask = &Hffffffff
        if data_low > LONG_MAX then
            if rxsc_sci_63_32_mask = mask then
                read_rxsc_sci_63_32_value = data_low
            else
                read_rxsc_sci_63_32_value = (data_low - H8000_0000) and rxsc_sci_63_32_mask
            end If
        else
            read_rxsc_sci_63_32_value = data_low and rxsc_sci_63_32_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_rxsc_sci_63_32_value = &H0
        flag_rxsc_sci_63_32        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_ctrl_5
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' vport_index                                [3:0]            get_vport_index
''                                                             set_vport_index
''                                                             read_vport_index
''                                                             write_vport_index
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_ctrl_5
    Private write_vport_index_value
    Private read_vport_index_value
    Private flag_vport_index

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3458
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_vport_index
        get_vport_index = read_vport_index_value
    End Property

    Property Let set_vport_index(aData)
        write_vport_index_value = aData
        flag_vport_index        = &H1
    End Property

    Property Get read_vport_index
        read
        read_vport_index = read_vport_index_value
    End Property

    Property Let write_vport_index(aData)
        set_vport_index = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        vport_index_mask = &Hf
        if data_low > LONG_MAX then
            if vport_index_mask = mask then
                read_vport_index_value = data_low
            else
                read_vport_index_value = (data_low - H8000_0000) and vport_index_mask
            end If
        else
            read_vport_index_value = data_low and vport_index_mask
        end If

    End Sub

    Sub write
        If flag_vport_index = &H0 Then read
        If flag_vport_index = &H0 Then write_vport_index_value = get_vport_index

        regValue = leftShift((write_vport_index_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        vport_index_mask = &Hf
        if data_low > LONG_MAX then
            if vport_index_mask = mask then
                read_vport_index_value = data_low
            else
                read_vport_index_value = (data_low - H8000_0000) and vport_index_mask
            end If
        else
            read_vport_index_value = data_low and vport_index_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_vport_index_value = &H0
        flag_vport_index        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_sci_lo_6
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' rxsc_sci_31_0                              [31:0]           get_rxsc_sci_31_0
''                                                             set_rxsc_sci_31_0
''                                                             read_rxsc_sci_31_0
''                                                             write_rxsc_sci_31_0
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_sci_lo_6
    Private write_rxsc_sci_31_0_value
    Private read_rxsc_sci_31_0_value
    Private flag_rxsc_sci_31_0

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3460
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_rxsc_sci_31_0
        get_rxsc_sci_31_0 = read_rxsc_sci_31_0_value
    End Property

    Property Let set_rxsc_sci_31_0(aData)
        write_rxsc_sci_31_0_value = aData
        flag_rxsc_sci_31_0        = &H1
    End Property

    Property Get read_rxsc_sci_31_0
        read
        read_rxsc_sci_31_0 = read_rxsc_sci_31_0_value
    End Property

    Property Let write_rxsc_sci_31_0(aData)
        set_rxsc_sci_31_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rxsc_sci_31_0_mask = &Hffffffff
        if data_low > LONG_MAX then
            if rxsc_sci_31_0_mask = mask then
                read_rxsc_sci_31_0_value = data_low
            else
                read_rxsc_sci_31_0_value = (data_low - H8000_0000) and rxsc_sci_31_0_mask
            end If
        else
            read_rxsc_sci_31_0_value = data_low and rxsc_sci_31_0_mask
        end If

    End Sub

    Sub write
        If flag_rxsc_sci_31_0 = &H0 Then read
        If flag_rxsc_sci_31_0 = &H0 Then write_rxsc_sci_31_0_value = get_rxsc_sci_31_0

        regValue = leftShift(write_rxsc_sci_31_0_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rxsc_sci_31_0_mask = &Hffffffff
        if data_low > LONG_MAX then
            if rxsc_sci_31_0_mask = mask then
                read_rxsc_sci_31_0_value = data_low
            else
                read_rxsc_sci_31_0_value = (data_low - H8000_0000) and rxsc_sci_31_0_mask
            end If
        else
            read_rxsc_sci_31_0_value = data_low and rxsc_sci_31_0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_rxsc_sci_31_0_value = &H0
        flag_rxsc_sci_31_0        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_sci_hi_6
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' rxsc_sci_63_32                             [31:0]           get_rxsc_sci_63_32
''                                                             set_rxsc_sci_63_32
''                                                             read_rxsc_sci_63_32
''                                                             write_rxsc_sci_63_32
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_sci_hi_6
    Private write_rxsc_sci_63_32_value
    Private read_rxsc_sci_63_32_value
    Private flag_rxsc_sci_63_32

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3464
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_rxsc_sci_63_32
        get_rxsc_sci_63_32 = read_rxsc_sci_63_32_value
    End Property

    Property Let set_rxsc_sci_63_32(aData)
        write_rxsc_sci_63_32_value = aData
        flag_rxsc_sci_63_32        = &H1
    End Property

    Property Get read_rxsc_sci_63_32
        read
        read_rxsc_sci_63_32 = read_rxsc_sci_63_32_value
    End Property

    Property Let write_rxsc_sci_63_32(aData)
        set_rxsc_sci_63_32 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rxsc_sci_63_32_mask = &Hffffffff
        if data_low > LONG_MAX then
            if rxsc_sci_63_32_mask = mask then
                read_rxsc_sci_63_32_value = data_low
            else
                read_rxsc_sci_63_32_value = (data_low - H8000_0000) and rxsc_sci_63_32_mask
            end If
        else
            read_rxsc_sci_63_32_value = data_low and rxsc_sci_63_32_mask
        end If

    End Sub

    Sub write
        If flag_rxsc_sci_63_32 = &H0 Then read
        If flag_rxsc_sci_63_32 = &H0 Then write_rxsc_sci_63_32_value = get_rxsc_sci_63_32

        regValue = leftShift(write_rxsc_sci_63_32_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rxsc_sci_63_32_mask = &Hffffffff
        if data_low > LONG_MAX then
            if rxsc_sci_63_32_mask = mask then
                read_rxsc_sci_63_32_value = data_low
            else
                read_rxsc_sci_63_32_value = (data_low - H8000_0000) and rxsc_sci_63_32_mask
            end If
        else
            read_rxsc_sci_63_32_value = data_low and rxsc_sci_63_32_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_rxsc_sci_63_32_value = &H0
        flag_rxsc_sci_63_32        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_ctrl_6
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' vport_index                                [3:0]            get_vport_index
''                                                             set_vport_index
''                                                             read_vport_index
''                                                             write_vport_index
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_ctrl_6
    Private write_vport_index_value
    Private read_vport_index_value
    Private flag_vport_index

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3468
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_vport_index
        get_vport_index = read_vport_index_value
    End Property

    Property Let set_vport_index(aData)
        write_vport_index_value = aData
        flag_vport_index        = &H1
    End Property

    Property Get read_vport_index
        read
        read_vport_index = read_vport_index_value
    End Property

    Property Let write_vport_index(aData)
        set_vport_index = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        vport_index_mask = &Hf
        if data_low > LONG_MAX then
            if vport_index_mask = mask then
                read_vport_index_value = data_low
            else
                read_vport_index_value = (data_low - H8000_0000) and vport_index_mask
            end If
        else
            read_vport_index_value = data_low and vport_index_mask
        end If

    End Sub

    Sub write
        If flag_vport_index = &H0 Then read
        If flag_vport_index = &H0 Then write_vport_index_value = get_vport_index

        regValue = leftShift((write_vport_index_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        vport_index_mask = &Hf
        if data_low > LONG_MAX then
            if vport_index_mask = mask then
                read_vport_index_value = data_low
            else
                read_vport_index_value = (data_low - H8000_0000) and vport_index_mask
            end If
        else
            read_vport_index_value = data_low and vport_index_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_vport_index_value = &H0
        flag_vport_index        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_sci_lo_7
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' rxsc_sci_31_0                              [31:0]           get_rxsc_sci_31_0
''                                                             set_rxsc_sci_31_0
''                                                             read_rxsc_sci_31_0
''                                                             write_rxsc_sci_31_0
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_sci_lo_7
    Private write_rxsc_sci_31_0_value
    Private read_rxsc_sci_31_0_value
    Private flag_rxsc_sci_31_0

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3470
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_rxsc_sci_31_0
        get_rxsc_sci_31_0 = read_rxsc_sci_31_0_value
    End Property

    Property Let set_rxsc_sci_31_0(aData)
        write_rxsc_sci_31_0_value = aData
        flag_rxsc_sci_31_0        = &H1
    End Property

    Property Get read_rxsc_sci_31_0
        read
        read_rxsc_sci_31_0 = read_rxsc_sci_31_0_value
    End Property

    Property Let write_rxsc_sci_31_0(aData)
        set_rxsc_sci_31_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rxsc_sci_31_0_mask = &Hffffffff
        if data_low > LONG_MAX then
            if rxsc_sci_31_0_mask = mask then
                read_rxsc_sci_31_0_value = data_low
            else
                read_rxsc_sci_31_0_value = (data_low - H8000_0000) and rxsc_sci_31_0_mask
            end If
        else
            read_rxsc_sci_31_0_value = data_low and rxsc_sci_31_0_mask
        end If

    End Sub

    Sub write
        If flag_rxsc_sci_31_0 = &H0 Then read
        If flag_rxsc_sci_31_0 = &H0 Then write_rxsc_sci_31_0_value = get_rxsc_sci_31_0

        regValue = leftShift(write_rxsc_sci_31_0_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rxsc_sci_31_0_mask = &Hffffffff
        if data_low > LONG_MAX then
            if rxsc_sci_31_0_mask = mask then
                read_rxsc_sci_31_0_value = data_low
            else
                read_rxsc_sci_31_0_value = (data_low - H8000_0000) and rxsc_sci_31_0_mask
            end If
        else
            read_rxsc_sci_31_0_value = data_low and rxsc_sci_31_0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_rxsc_sci_31_0_value = &H0
        flag_rxsc_sci_31_0        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_sci_hi_7
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' rxsc_sci_63_32                             [31:0]           get_rxsc_sci_63_32
''                                                             set_rxsc_sci_63_32
''                                                             read_rxsc_sci_63_32
''                                                             write_rxsc_sci_63_32
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_sci_hi_7
    Private write_rxsc_sci_63_32_value
    Private read_rxsc_sci_63_32_value
    Private flag_rxsc_sci_63_32

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3474
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_rxsc_sci_63_32
        get_rxsc_sci_63_32 = read_rxsc_sci_63_32_value
    End Property

    Property Let set_rxsc_sci_63_32(aData)
        write_rxsc_sci_63_32_value = aData
        flag_rxsc_sci_63_32        = &H1
    End Property

    Property Get read_rxsc_sci_63_32
        read
        read_rxsc_sci_63_32 = read_rxsc_sci_63_32_value
    End Property

    Property Let write_rxsc_sci_63_32(aData)
        set_rxsc_sci_63_32 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rxsc_sci_63_32_mask = &Hffffffff
        if data_low > LONG_MAX then
            if rxsc_sci_63_32_mask = mask then
                read_rxsc_sci_63_32_value = data_low
            else
                read_rxsc_sci_63_32_value = (data_low - H8000_0000) and rxsc_sci_63_32_mask
            end If
        else
            read_rxsc_sci_63_32_value = data_low and rxsc_sci_63_32_mask
        end If

    End Sub

    Sub write
        If flag_rxsc_sci_63_32 = &H0 Then read
        If flag_rxsc_sci_63_32 = &H0 Then write_rxsc_sci_63_32_value = get_rxsc_sci_63_32

        regValue = leftShift(write_rxsc_sci_63_32_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rxsc_sci_63_32_mask = &Hffffffff
        if data_low > LONG_MAX then
            if rxsc_sci_63_32_mask = mask then
                read_rxsc_sci_63_32_value = data_low
            else
                read_rxsc_sci_63_32_value = (data_low - H8000_0000) and rxsc_sci_63_32_mask
            end If
        else
            read_rxsc_sci_63_32_value = data_low and rxsc_sci_63_32_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_rxsc_sci_63_32_value = &H0
        flag_rxsc_sci_63_32        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_ctrl_7
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' vport_index                                [3:0]            get_vport_index
''                                                             set_vport_index
''                                                             read_vport_index
''                                                             write_vport_index
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_ctrl_7
    Private write_vport_index_value
    Private read_vport_index_value
    Private flag_vport_index

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3478
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_vport_index
        get_vport_index = read_vport_index_value
    End Property

    Property Let set_vport_index(aData)
        write_vport_index_value = aData
        flag_vport_index        = &H1
    End Property

    Property Get read_vport_index
        read
        read_vport_index = read_vport_index_value
    End Property

    Property Let write_vport_index(aData)
        set_vport_index = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        vport_index_mask = &Hf
        if data_low > LONG_MAX then
            if vport_index_mask = mask then
                read_vport_index_value = data_low
            else
                read_vport_index_value = (data_low - H8000_0000) and vport_index_mask
            end If
        else
            read_vport_index_value = data_low and vport_index_mask
        end If

    End Sub

    Sub write
        If flag_vport_index = &H0 Then read
        If flag_vport_index = &H0 Then write_vport_index_value = get_vport_index

        regValue = leftShift((write_vport_index_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        vport_index_mask = &Hf
        if data_low > LONG_MAX then
            if vport_index_mask = mask then
                read_vport_index_value = data_low
            else
                read_vport_index_value = (data_low - H8000_0000) and vport_index_mask
            end If
        else
            read_vport_index_value = data_low and vport_index_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_vport_index_value = &H0
        flag_vport_index        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_sci_lo_8
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' rxsc_sci_31_0                              [31:0]           get_rxsc_sci_31_0
''                                                             set_rxsc_sci_31_0
''                                                             read_rxsc_sci_31_0
''                                                             write_rxsc_sci_31_0
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_sci_lo_8
    Private write_rxsc_sci_31_0_value
    Private read_rxsc_sci_31_0_value
    Private flag_rxsc_sci_31_0

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3480
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_rxsc_sci_31_0
        get_rxsc_sci_31_0 = read_rxsc_sci_31_0_value
    End Property

    Property Let set_rxsc_sci_31_0(aData)
        write_rxsc_sci_31_0_value = aData
        flag_rxsc_sci_31_0        = &H1
    End Property

    Property Get read_rxsc_sci_31_0
        read
        read_rxsc_sci_31_0 = read_rxsc_sci_31_0_value
    End Property

    Property Let write_rxsc_sci_31_0(aData)
        set_rxsc_sci_31_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rxsc_sci_31_0_mask = &Hffffffff
        if data_low > LONG_MAX then
            if rxsc_sci_31_0_mask = mask then
                read_rxsc_sci_31_0_value = data_low
            else
                read_rxsc_sci_31_0_value = (data_low - H8000_0000) and rxsc_sci_31_0_mask
            end If
        else
            read_rxsc_sci_31_0_value = data_low and rxsc_sci_31_0_mask
        end If

    End Sub

    Sub write
        If flag_rxsc_sci_31_0 = &H0 Then read
        If flag_rxsc_sci_31_0 = &H0 Then write_rxsc_sci_31_0_value = get_rxsc_sci_31_0

        regValue = leftShift(write_rxsc_sci_31_0_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rxsc_sci_31_0_mask = &Hffffffff
        if data_low > LONG_MAX then
            if rxsc_sci_31_0_mask = mask then
                read_rxsc_sci_31_0_value = data_low
            else
                read_rxsc_sci_31_0_value = (data_low - H8000_0000) and rxsc_sci_31_0_mask
            end If
        else
            read_rxsc_sci_31_0_value = data_low and rxsc_sci_31_0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_rxsc_sci_31_0_value = &H0
        flag_rxsc_sci_31_0        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_sci_hi_8
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' rxsc_sci_63_32                             [31:0]           get_rxsc_sci_63_32
''                                                             set_rxsc_sci_63_32
''                                                             read_rxsc_sci_63_32
''                                                             write_rxsc_sci_63_32
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_sci_hi_8
    Private write_rxsc_sci_63_32_value
    Private read_rxsc_sci_63_32_value
    Private flag_rxsc_sci_63_32

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3484
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_rxsc_sci_63_32
        get_rxsc_sci_63_32 = read_rxsc_sci_63_32_value
    End Property

    Property Let set_rxsc_sci_63_32(aData)
        write_rxsc_sci_63_32_value = aData
        flag_rxsc_sci_63_32        = &H1
    End Property

    Property Get read_rxsc_sci_63_32
        read
        read_rxsc_sci_63_32 = read_rxsc_sci_63_32_value
    End Property

    Property Let write_rxsc_sci_63_32(aData)
        set_rxsc_sci_63_32 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rxsc_sci_63_32_mask = &Hffffffff
        if data_low > LONG_MAX then
            if rxsc_sci_63_32_mask = mask then
                read_rxsc_sci_63_32_value = data_low
            else
                read_rxsc_sci_63_32_value = (data_low - H8000_0000) and rxsc_sci_63_32_mask
            end If
        else
            read_rxsc_sci_63_32_value = data_low and rxsc_sci_63_32_mask
        end If

    End Sub

    Sub write
        If flag_rxsc_sci_63_32 = &H0 Then read
        If flag_rxsc_sci_63_32 = &H0 Then write_rxsc_sci_63_32_value = get_rxsc_sci_63_32

        regValue = leftShift(write_rxsc_sci_63_32_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rxsc_sci_63_32_mask = &Hffffffff
        if data_low > LONG_MAX then
            if rxsc_sci_63_32_mask = mask then
                read_rxsc_sci_63_32_value = data_low
            else
                read_rxsc_sci_63_32_value = (data_low - H8000_0000) and rxsc_sci_63_32_mask
            end If
        else
            read_rxsc_sci_63_32_value = data_low and rxsc_sci_63_32_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_rxsc_sci_63_32_value = &H0
        flag_rxsc_sci_63_32        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_ctrl_8
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' vport_index                                [3:0]            get_vport_index
''                                                             set_vport_index
''                                                             read_vport_index
''                                                             write_vport_index
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_ctrl_8
    Private write_vport_index_value
    Private read_vport_index_value
    Private flag_vport_index

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3488
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_vport_index
        get_vport_index = read_vport_index_value
    End Property

    Property Let set_vport_index(aData)
        write_vport_index_value = aData
        flag_vport_index        = &H1
    End Property

    Property Get read_vport_index
        read
        read_vport_index = read_vport_index_value
    End Property

    Property Let write_vport_index(aData)
        set_vport_index = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        vport_index_mask = &Hf
        if data_low > LONG_MAX then
            if vport_index_mask = mask then
                read_vport_index_value = data_low
            else
                read_vport_index_value = (data_low - H8000_0000) and vport_index_mask
            end If
        else
            read_vport_index_value = data_low and vport_index_mask
        end If

    End Sub

    Sub write
        If flag_vport_index = &H0 Then read
        If flag_vport_index = &H0 Then write_vport_index_value = get_vport_index

        regValue = leftShift((write_vport_index_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        vport_index_mask = &Hf
        if data_low > LONG_MAX then
            if vport_index_mask = mask then
                read_vport_index_value = data_low
            else
                read_vport_index_value = (data_low - H8000_0000) and vport_index_mask
            end If
        else
            read_vport_index_value = data_low and vport_index_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_vport_index_value = &H0
        flag_vport_index        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_sci_lo_9
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' rxsc_sci_31_0                              [31:0]           get_rxsc_sci_31_0
''                                                             set_rxsc_sci_31_0
''                                                             read_rxsc_sci_31_0
''                                                             write_rxsc_sci_31_0
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_sci_lo_9
    Private write_rxsc_sci_31_0_value
    Private read_rxsc_sci_31_0_value
    Private flag_rxsc_sci_31_0

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3490
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_rxsc_sci_31_0
        get_rxsc_sci_31_0 = read_rxsc_sci_31_0_value
    End Property

    Property Let set_rxsc_sci_31_0(aData)
        write_rxsc_sci_31_0_value = aData
        flag_rxsc_sci_31_0        = &H1
    End Property

    Property Get read_rxsc_sci_31_0
        read
        read_rxsc_sci_31_0 = read_rxsc_sci_31_0_value
    End Property

    Property Let write_rxsc_sci_31_0(aData)
        set_rxsc_sci_31_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rxsc_sci_31_0_mask = &Hffffffff
        if data_low > LONG_MAX then
            if rxsc_sci_31_0_mask = mask then
                read_rxsc_sci_31_0_value = data_low
            else
                read_rxsc_sci_31_0_value = (data_low - H8000_0000) and rxsc_sci_31_0_mask
            end If
        else
            read_rxsc_sci_31_0_value = data_low and rxsc_sci_31_0_mask
        end If

    End Sub

    Sub write
        If flag_rxsc_sci_31_0 = &H0 Then read
        If flag_rxsc_sci_31_0 = &H0 Then write_rxsc_sci_31_0_value = get_rxsc_sci_31_0

        regValue = leftShift(write_rxsc_sci_31_0_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rxsc_sci_31_0_mask = &Hffffffff
        if data_low > LONG_MAX then
            if rxsc_sci_31_0_mask = mask then
                read_rxsc_sci_31_0_value = data_low
            else
                read_rxsc_sci_31_0_value = (data_low - H8000_0000) and rxsc_sci_31_0_mask
            end If
        else
            read_rxsc_sci_31_0_value = data_low and rxsc_sci_31_0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_rxsc_sci_31_0_value = &H0
        flag_rxsc_sci_31_0        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_sci_hi_9
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' rxsc_sci_63_32                             [31:0]           get_rxsc_sci_63_32
''                                                             set_rxsc_sci_63_32
''                                                             read_rxsc_sci_63_32
''                                                             write_rxsc_sci_63_32
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_sci_hi_9
    Private write_rxsc_sci_63_32_value
    Private read_rxsc_sci_63_32_value
    Private flag_rxsc_sci_63_32

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3494
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_rxsc_sci_63_32
        get_rxsc_sci_63_32 = read_rxsc_sci_63_32_value
    End Property

    Property Let set_rxsc_sci_63_32(aData)
        write_rxsc_sci_63_32_value = aData
        flag_rxsc_sci_63_32        = &H1
    End Property

    Property Get read_rxsc_sci_63_32
        read
        read_rxsc_sci_63_32 = read_rxsc_sci_63_32_value
    End Property

    Property Let write_rxsc_sci_63_32(aData)
        set_rxsc_sci_63_32 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rxsc_sci_63_32_mask = &Hffffffff
        if data_low > LONG_MAX then
            if rxsc_sci_63_32_mask = mask then
                read_rxsc_sci_63_32_value = data_low
            else
                read_rxsc_sci_63_32_value = (data_low - H8000_0000) and rxsc_sci_63_32_mask
            end If
        else
            read_rxsc_sci_63_32_value = data_low and rxsc_sci_63_32_mask
        end If

    End Sub

    Sub write
        If flag_rxsc_sci_63_32 = &H0 Then read
        If flag_rxsc_sci_63_32 = &H0 Then write_rxsc_sci_63_32_value = get_rxsc_sci_63_32

        regValue = leftShift(write_rxsc_sci_63_32_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rxsc_sci_63_32_mask = &Hffffffff
        if data_low > LONG_MAX then
            if rxsc_sci_63_32_mask = mask then
                read_rxsc_sci_63_32_value = data_low
            else
                read_rxsc_sci_63_32_value = (data_low - H8000_0000) and rxsc_sci_63_32_mask
            end If
        else
            read_rxsc_sci_63_32_value = data_low and rxsc_sci_63_32_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_rxsc_sci_63_32_value = &H0
        flag_rxsc_sci_63_32        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_ctrl_9
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' vport_index                                [3:0]            get_vport_index
''                                                             set_vport_index
''                                                             read_vport_index
''                                                             write_vport_index
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_ctrl_9
    Private write_vport_index_value
    Private read_vport_index_value
    Private flag_vport_index

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3498
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_vport_index
        get_vport_index = read_vport_index_value
    End Property

    Property Let set_vport_index(aData)
        write_vport_index_value = aData
        flag_vport_index        = &H1
    End Property

    Property Get read_vport_index
        read
        read_vport_index = read_vport_index_value
    End Property

    Property Let write_vport_index(aData)
        set_vport_index = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        vport_index_mask = &Hf
        if data_low > LONG_MAX then
            if vport_index_mask = mask then
                read_vport_index_value = data_low
            else
                read_vport_index_value = (data_low - H8000_0000) and vport_index_mask
            end If
        else
            read_vport_index_value = data_low and vport_index_mask
        end If

    End Sub

    Sub write
        If flag_vport_index = &H0 Then read
        If flag_vport_index = &H0 Then write_vport_index_value = get_vport_index

        regValue = leftShift((write_vport_index_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        vport_index_mask = &Hf
        if data_low > LONG_MAX then
            if vport_index_mask = mask then
                read_vport_index_value = data_low
            else
                read_vport_index_value = (data_low - H8000_0000) and vport_index_mask
            end If
        else
            read_vport_index_value = data_low and vport_index_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_vport_index_value = &H0
        flag_vport_index        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_sci_lo_10
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' rxsc_sci_31_0                              [31:0]           get_rxsc_sci_31_0
''                                                             set_rxsc_sci_31_0
''                                                             read_rxsc_sci_31_0
''                                                             write_rxsc_sci_31_0
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_sci_lo_10
    Private write_rxsc_sci_31_0_value
    Private read_rxsc_sci_31_0_value
    Private flag_rxsc_sci_31_0

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H34a0
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_rxsc_sci_31_0
        get_rxsc_sci_31_0 = read_rxsc_sci_31_0_value
    End Property

    Property Let set_rxsc_sci_31_0(aData)
        write_rxsc_sci_31_0_value = aData
        flag_rxsc_sci_31_0        = &H1
    End Property

    Property Get read_rxsc_sci_31_0
        read
        read_rxsc_sci_31_0 = read_rxsc_sci_31_0_value
    End Property

    Property Let write_rxsc_sci_31_0(aData)
        set_rxsc_sci_31_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rxsc_sci_31_0_mask = &Hffffffff
        if data_low > LONG_MAX then
            if rxsc_sci_31_0_mask = mask then
                read_rxsc_sci_31_0_value = data_low
            else
                read_rxsc_sci_31_0_value = (data_low - H8000_0000) and rxsc_sci_31_0_mask
            end If
        else
            read_rxsc_sci_31_0_value = data_low and rxsc_sci_31_0_mask
        end If

    End Sub

    Sub write
        If flag_rxsc_sci_31_0 = &H0 Then read
        If flag_rxsc_sci_31_0 = &H0 Then write_rxsc_sci_31_0_value = get_rxsc_sci_31_0

        regValue = leftShift(write_rxsc_sci_31_0_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rxsc_sci_31_0_mask = &Hffffffff
        if data_low > LONG_MAX then
            if rxsc_sci_31_0_mask = mask then
                read_rxsc_sci_31_0_value = data_low
            else
                read_rxsc_sci_31_0_value = (data_low - H8000_0000) and rxsc_sci_31_0_mask
            end If
        else
            read_rxsc_sci_31_0_value = data_low and rxsc_sci_31_0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_rxsc_sci_31_0_value = &H0
        flag_rxsc_sci_31_0        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_sci_hi_10
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' rxsc_sci_63_32                             [31:0]           get_rxsc_sci_63_32
''                                                             set_rxsc_sci_63_32
''                                                             read_rxsc_sci_63_32
''                                                             write_rxsc_sci_63_32
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_sci_hi_10
    Private write_rxsc_sci_63_32_value
    Private read_rxsc_sci_63_32_value
    Private flag_rxsc_sci_63_32

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H34a4
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_rxsc_sci_63_32
        get_rxsc_sci_63_32 = read_rxsc_sci_63_32_value
    End Property

    Property Let set_rxsc_sci_63_32(aData)
        write_rxsc_sci_63_32_value = aData
        flag_rxsc_sci_63_32        = &H1
    End Property

    Property Get read_rxsc_sci_63_32
        read
        read_rxsc_sci_63_32 = read_rxsc_sci_63_32_value
    End Property

    Property Let write_rxsc_sci_63_32(aData)
        set_rxsc_sci_63_32 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rxsc_sci_63_32_mask = &Hffffffff
        if data_low > LONG_MAX then
            if rxsc_sci_63_32_mask = mask then
                read_rxsc_sci_63_32_value = data_low
            else
                read_rxsc_sci_63_32_value = (data_low - H8000_0000) and rxsc_sci_63_32_mask
            end If
        else
            read_rxsc_sci_63_32_value = data_low and rxsc_sci_63_32_mask
        end If

    End Sub

    Sub write
        If flag_rxsc_sci_63_32 = &H0 Then read
        If flag_rxsc_sci_63_32 = &H0 Then write_rxsc_sci_63_32_value = get_rxsc_sci_63_32

        regValue = leftShift(write_rxsc_sci_63_32_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rxsc_sci_63_32_mask = &Hffffffff
        if data_low > LONG_MAX then
            if rxsc_sci_63_32_mask = mask then
                read_rxsc_sci_63_32_value = data_low
            else
                read_rxsc_sci_63_32_value = (data_low - H8000_0000) and rxsc_sci_63_32_mask
            end If
        else
            read_rxsc_sci_63_32_value = data_low and rxsc_sci_63_32_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_rxsc_sci_63_32_value = &H0
        flag_rxsc_sci_63_32        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_ctrl_10
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' vport_index                                [3:0]            get_vport_index
''                                                             set_vport_index
''                                                             read_vport_index
''                                                             write_vport_index
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_ctrl_10
    Private write_vport_index_value
    Private read_vport_index_value
    Private flag_vport_index

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H34a8
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_vport_index
        get_vport_index = read_vport_index_value
    End Property

    Property Let set_vport_index(aData)
        write_vport_index_value = aData
        flag_vport_index        = &H1
    End Property

    Property Get read_vport_index
        read
        read_vport_index = read_vport_index_value
    End Property

    Property Let write_vport_index(aData)
        set_vport_index = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        vport_index_mask = &Hf
        if data_low > LONG_MAX then
            if vport_index_mask = mask then
                read_vport_index_value = data_low
            else
                read_vport_index_value = (data_low - H8000_0000) and vport_index_mask
            end If
        else
            read_vport_index_value = data_low and vport_index_mask
        end If

    End Sub

    Sub write
        If flag_vport_index = &H0 Then read
        If flag_vport_index = &H0 Then write_vport_index_value = get_vport_index

        regValue = leftShift((write_vport_index_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        vport_index_mask = &Hf
        if data_low > LONG_MAX then
            if vport_index_mask = mask then
                read_vport_index_value = data_low
            else
                read_vport_index_value = (data_low - H8000_0000) and vport_index_mask
            end If
        else
            read_vport_index_value = data_low and vport_index_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_vport_index_value = &H0
        flag_vport_index        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_sci_lo_11
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' rxsc_sci_31_0                              [31:0]           get_rxsc_sci_31_0
''                                                             set_rxsc_sci_31_0
''                                                             read_rxsc_sci_31_0
''                                                             write_rxsc_sci_31_0
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_sci_lo_11
    Private write_rxsc_sci_31_0_value
    Private read_rxsc_sci_31_0_value
    Private flag_rxsc_sci_31_0

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H34b0
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_rxsc_sci_31_0
        get_rxsc_sci_31_0 = read_rxsc_sci_31_0_value
    End Property

    Property Let set_rxsc_sci_31_0(aData)
        write_rxsc_sci_31_0_value = aData
        flag_rxsc_sci_31_0        = &H1
    End Property

    Property Get read_rxsc_sci_31_0
        read
        read_rxsc_sci_31_0 = read_rxsc_sci_31_0_value
    End Property

    Property Let write_rxsc_sci_31_0(aData)
        set_rxsc_sci_31_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rxsc_sci_31_0_mask = &Hffffffff
        if data_low > LONG_MAX then
            if rxsc_sci_31_0_mask = mask then
                read_rxsc_sci_31_0_value = data_low
            else
                read_rxsc_sci_31_0_value = (data_low - H8000_0000) and rxsc_sci_31_0_mask
            end If
        else
            read_rxsc_sci_31_0_value = data_low and rxsc_sci_31_0_mask
        end If

    End Sub

    Sub write
        If flag_rxsc_sci_31_0 = &H0 Then read
        If flag_rxsc_sci_31_0 = &H0 Then write_rxsc_sci_31_0_value = get_rxsc_sci_31_0

        regValue = leftShift(write_rxsc_sci_31_0_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rxsc_sci_31_0_mask = &Hffffffff
        if data_low > LONG_MAX then
            if rxsc_sci_31_0_mask = mask then
                read_rxsc_sci_31_0_value = data_low
            else
                read_rxsc_sci_31_0_value = (data_low - H8000_0000) and rxsc_sci_31_0_mask
            end If
        else
            read_rxsc_sci_31_0_value = data_low and rxsc_sci_31_0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_rxsc_sci_31_0_value = &H0
        flag_rxsc_sci_31_0        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_sci_hi_11
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' rxsc_sci_63_32                             [31:0]           get_rxsc_sci_63_32
''                                                             set_rxsc_sci_63_32
''                                                             read_rxsc_sci_63_32
''                                                             write_rxsc_sci_63_32
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_sci_hi_11
    Private write_rxsc_sci_63_32_value
    Private read_rxsc_sci_63_32_value
    Private flag_rxsc_sci_63_32

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H34b4
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_rxsc_sci_63_32
        get_rxsc_sci_63_32 = read_rxsc_sci_63_32_value
    End Property

    Property Let set_rxsc_sci_63_32(aData)
        write_rxsc_sci_63_32_value = aData
        flag_rxsc_sci_63_32        = &H1
    End Property

    Property Get read_rxsc_sci_63_32
        read
        read_rxsc_sci_63_32 = read_rxsc_sci_63_32_value
    End Property

    Property Let write_rxsc_sci_63_32(aData)
        set_rxsc_sci_63_32 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rxsc_sci_63_32_mask = &Hffffffff
        if data_low > LONG_MAX then
            if rxsc_sci_63_32_mask = mask then
                read_rxsc_sci_63_32_value = data_low
            else
                read_rxsc_sci_63_32_value = (data_low - H8000_0000) and rxsc_sci_63_32_mask
            end If
        else
            read_rxsc_sci_63_32_value = data_low and rxsc_sci_63_32_mask
        end If

    End Sub

    Sub write
        If flag_rxsc_sci_63_32 = &H0 Then read
        If flag_rxsc_sci_63_32 = &H0 Then write_rxsc_sci_63_32_value = get_rxsc_sci_63_32

        regValue = leftShift(write_rxsc_sci_63_32_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rxsc_sci_63_32_mask = &Hffffffff
        if data_low > LONG_MAX then
            if rxsc_sci_63_32_mask = mask then
                read_rxsc_sci_63_32_value = data_low
            else
                read_rxsc_sci_63_32_value = (data_low - H8000_0000) and rxsc_sci_63_32_mask
            end If
        else
            read_rxsc_sci_63_32_value = data_low and rxsc_sci_63_32_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_rxsc_sci_63_32_value = &H0
        flag_rxsc_sci_63_32        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_ctrl_11
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' vport_index                                [3:0]            get_vport_index
''                                                             set_vport_index
''                                                             read_vport_index
''                                                             write_vport_index
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_ctrl_11
    Private write_vport_index_value
    Private read_vport_index_value
    Private flag_vport_index

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H34b8
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_vport_index
        get_vport_index = read_vport_index_value
    End Property

    Property Let set_vport_index(aData)
        write_vport_index_value = aData
        flag_vport_index        = &H1
    End Property

    Property Get read_vport_index
        read
        read_vport_index = read_vport_index_value
    End Property

    Property Let write_vport_index(aData)
        set_vport_index = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        vport_index_mask = &Hf
        if data_low > LONG_MAX then
            if vport_index_mask = mask then
                read_vport_index_value = data_low
            else
                read_vport_index_value = (data_low - H8000_0000) and vport_index_mask
            end If
        else
            read_vport_index_value = data_low and vport_index_mask
        end If

    End Sub

    Sub write
        If flag_vport_index = &H0 Then read
        If flag_vport_index = &H0 Then write_vport_index_value = get_vport_index

        regValue = leftShift((write_vport_index_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        vport_index_mask = &Hf
        if data_low > LONG_MAX then
            if vport_index_mask = mask then
                read_vport_index_value = data_low
            else
                read_vport_index_value = (data_low - H8000_0000) and vport_index_mask
            end If
        else
            read_vport_index_value = data_low and vport_index_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_vport_index_value = &H0
        flag_vport_index        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_sci_lo_12
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' rxsc_sci_31_0                              [31:0]           get_rxsc_sci_31_0
''                                                             set_rxsc_sci_31_0
''                                                             read_rxsc_sci_31_0
''                                                             write_rxsc_sci_31_0
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_sci_lo_12
    Private write_rxsc_sci_31_0_value
    Private read_rxsc_sci_31_0_value
    Private flag_rxsc_sci_31_0

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H34c0
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_rxsc_sci_31_0
        get_rxsc_sci_31_0 = read_rxsc_sci_31_0_value
    End Property

    Property Let set_rxsc_sci_31_0(aData)
        write_rxsc_sci_31_0_value = aData
        flag_rxsc_sci_31_0        = &H1
    End Property

    Property Get read_rxsc_sci_31_0
        read
        read_rxsc_sci_31_0 = read_rxsc_sci_31_0_value
    End Property

    Property Let write_rxsc_sci_31_0(aData)
        set_rxsc_sci_31_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rxsc_sci_31_0_mask = &Hffffffff
        if data_low > LONG_MAX then
            if rxsc_sci_31_0_mask = mask then
                read_rxsc_sci_31_0_value = data_low
            else
                read_rxsc_sci_31_0_value = (data_low - H8000_0000) and rxsc_sci_31_0_mask
            end If
        else
            read_rxsc_sci_31_0_value = data_low and rxsc_sci_31_0_mask
        end If

    End Sub

    Sub write
        If flag_rxsc_sci_31_0 = &H0 Then read
        If flag_rxsc_sci_31_0 = &H0 Then write_rxsc_sci_31_0_value = get_rxsc_sci_31_0

        regValue = leftShift(write_rxsc_sci_31_0_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rxsc_sci_31_0_mask = &Hffffffff
        if data_low > LONG_MAX then
            if rxsc_sci_31_0_mask = mask then
                read_rxsc_sci_31_0_value = data_low
            else
                read_rxsc_sci_31_0_value = (data_low - H8000_0000) and rxsc_sci_31_0_mask
            end If
        else
            read_rxsc_sci_31_0_value = data_low and rxsc_sci_31_0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_rxsc_sci_31_0_value = &H0
        flag_rxsc_sci_31_0        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_sci_hi_12
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' rxsc_sci_63_32                             [31:0]           get_rxsc_sci_63_32
''                                                             set_rxsc_sci_63_32
''                                                             read_rxsc_sci_63_32
''                                                             write_rxsc_sci_63_32
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_sci_hi_12
    Private write_rxsc_sci_63_32_value
    Private read_rxsc_sci_63_32_value
    Private flag_rxsc_sci_63_32

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H34c4
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_rxsc_sci_63_32
        get_rxsc_sci_63_32 = read_rxsc_sci_63_32_value
    End Property

    Property Let set_rxsc_sci_63_32(aData)
        write_rxsc_sci_63_32_value = aData
        flag_rxsc_sci_63_32        = &H1
    End Property

    Property Get read_rxsc_sci_63_32
        read
        read_rxsc_sci_63_32 = read_rxsc_sci_63_32_value
    End Property

    Property Let write_rxsc_sci_63_32(aData)
        set_rxsc_sci_63_32 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rxsc_sci_63_32_mask = &Hffffffff
        if data_low > LONG_MAX then
            if rxsc_sci_63_32_mask = mask then
                read_rxsc_sci_63_32_value = data_low
            else
                read_rxsc_sci_63_32_value = (data_low - H8000_0000) and rxsc_sci_63_32_mask
            end If
        else
            read_rxsc_sci_63_32_value = data_low and rxsc_sci_63_32_mask
        end If

    End Sub

    Sub write
        If flag_rxsc_sci_63_32 = &H0 Then read
        If flag_rxsc_sci_63_32 = &H0 Then write_rxsc_sci_63_32_value = get_rxsc_sci_63_32

        regValue = leftShift(write_rxsc_sci_63_32_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rxsc_sci_63_32_mask = &Hffffffff
        if data_low > LONG_MAX then
            if rxsc_sci_63_32_mask = mask then
                read_rxsc_sci_63_32_value = data_low
            else
                read_rxsc_sci_63_32_value = (data_low - H8000_0000) and rxsc_sci_63_32_mask
            end If
        else
            read_rxsc_sci_63_32_value = data_low and rxsc_sci_63_32_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_rxsc_sci_63_32_value = &H0
        flag_rxsc_sci_63_32        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_ctrl_12
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' vport_index                                [3:0]            get_vport_index
''                                                             set_vport_index
''                                                             read_vport_index
''                                                             write_vport_index
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_ctrl_12
    Private write_vport_index_value
    Private read_vport_index_value
    Private flag_vport_index

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H34c8
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_vport_index
        get_vport_index = read_vport_index_value
    End Property

    Property Let set_vport_index(aData)
        write_vport_index_value = aData
        flag_vport_index        = &H1
    End Property

    Property Get read_vport_index
        read
        read_vport_index = read_vport_index_value
    End Property

    Property Let write_vport_index(aData)
        set_vport_index = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        vport_index_mask = &Hf
        if data_low > LONG_MAX then
            if vport_index_mask = mask then
                read_vport_index_value = data_low
            else
                read_vport_index_value = (data_low - H8000_0000) and vport_index_mask
            end If
        else
            read_vport_index_value = data_low and vport_index_mask
        end If

    End Sub

    Sub write
        If flag_vport_index = &H0 Then read
        If flag_vport_index = &H0 Then write_vport_index_value = get_vport_index

        regValue = leftShift((write_vport_index_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        vport_index_mask = &Hf
        if data_low > LONG_MAX then
            if vport_index_mask = mask then
                read_vport_index_value = data_low
            else
                read_vport_index_value = (data_low - H8000_0000) and vport_index_mask
            end If
        else
            read_vport_index_value = data_low and vport_index_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_vport_index_value = &H0
        flag_vport_index        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_sci_lo_13
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' rxsc_sci_31_0                              [31:0]           get_rxsc_sci_31_0
''                                                             set_rxsc_sci_31_0
''                                                             read_rxsc_sci_31_0
''                                                             write_rxsc_sci_31_0
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_sci_lo_13
    Private write_rxsc_sci_31_0_value
    Private read_rxsc_sci_31_0_value
    Private flag_rxsc_sci_31_0

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H34d0
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_rxsc_sci_31_0
        get_rxsc_sci_31_0 = read_rxsc_sci_31_0_value
    End Property

    Property Let set_rxsc_sci_31_0(aData)
        write_rxsc_sci_31_0_value = aData
        flag_rxsc_sci_31_0        = &H1
    End Property

    Property Get read_rxsc_sci_31_0
        read
        read_rxsc_sci_31_0 = read_rxsc_sci_31_0_value
    End Property

    Property Let write_rxsc_sci_31_0(aData)
        set_rxsc_sci_31_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rxsc_sci_31_0_mask = &Hffffffff
        if data_low > LONG_MAX then
            if rxsc_sci_31_0_mask = mask then
                read_rxsc_sci_31_0_value = data_low
            else
                read_rxsc_sci_31_0_value = (data_low - H8000_0000) and rxsc_sci_31_0_mask
            end If
        else
            read_rxsc_sci_31_0_value = data_low and rxsc_sci_31_0_mask
        end If

    End Sub

    Sub write
        If flag_rxsc_sci_31_0 = &H0 Then read
        If flag_rxsc_sci_31_0 = &H0 Then write_rxsc_sci_31_0_value = get_rxsc_sci_31_0

        regValue = leftShift(write_rxsc_sci_31_0_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rxsc_sci_31_0_mask = &Hffffffff
        if data_low > LONG_MAX then
            if rxsc_sci_31_0_mask = mask then
                read_rxsc_sci_31_0_value = data_low
            else
                read_rxsc_sci_31_0_value = (data_low - H8000_0000) and rxsc_sci_31_0_mask
            end If
        else
            read_rxsc_sci_31_0_value = data_low and rxsc_sci_31_0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_rxsc_sci_31_0_value = &H0
        flag_rxsc_sci_31_0        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_sci_hi_13
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' rxsc_sci_63_32                             [31:0]           get_rxsc_sci_63_32
''                                                             set_rxsc_sci_63_32
''                                                             read_rxsc_sci_63_32
''                                                             write_rxsc_sci_63_32
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_sci_hi_13
    Private write_rxsc_sci_63_32_value
    Private read_rxsc_sci_63_32_value
    Private flag_rxsc_sci_63_32

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H34d4
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_rxsc_sci_63_32
        get_rxsc_sci_63_32 = read_rxsc_sci_63_32_value
    End Property

    Property Let set_rxsc_sci_63_32(aData)
        write_rxsc_sci_63_32_value = aData
        flag_rxsc_sci_63_32        = &H1
    End Property

    Property Get read_rxsc_sci_63_32
        read
        read_rxsc_sci_63_32 = read_rxsc_sci_63_32_value
    End Property

    Property Let write_rxsc_sci_63_32(aData)
        set_rxsc_sci_63_32 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rxsc_sci_63_32_mask = &Hffffffff
        if data_low > LONG_MAX then
            if rxsc_sci_63_32_mask = mask then
                read_rxsc_sci_63_32_value = data_low
            else
                read_rxsc_sci_63_32_value = (data_low - H8000_0000) and rxsc_sci_63_32_mask
            end If
        else
            read_rxsc_sci_63_32_value = data_low and rxsc_sci_63_32_mask
        end If

    End Sub

    Sub write
        If flag_rxsc_sci_63_32 = &H0 Then read
        If flag_rxsc_sci_63_32 = &H0 Then write_rxsc_sci_63_32_value = get_rxsc_sci_63_32

        regValue = leftShift(write_rxsc_sci_63_32_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rxsc_sci_63_32_mask = &Hffffffff
        if data_low > LONG_MAX then
            if rxsc_sci_63_32_mask = mask then
                read_rxsc_sci_63_32_value = data_low
            else
                read_rxsc_sci_63_32_value = (data_low - H8000_0000) and rxsc_sci_63_32_mask
            end If
        else
            read_rxsc_sci_63_32_value = data_low and rxsc_sci_63_32_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_rxsc_sci_63_32_value = &H0
        flag_rxsc_sci_63_32        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_ctrl_13
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' vport_index                                [3:0]            get_vport_index
''                                                             set_vport_index
''                                                             read_vport_index
''                                                             write_vport_index
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_ctrl_13
    Private write_vport_index_value
    Private read_vport_index_value
    Private flag_vport_index

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H34d8
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_vport_index
        get_vport_index = read_vport_index_value
    End Property

    Property Let set_vport_index(aData)
        write_vport_index_value = aData
        flag_vport_index        = &H1
    End Property

    Property Get read_vport_index
        read
        read_vport_index = read_vport_index_value
    End Property

    Property Let write_vport_index(aData)
        set_vport_index = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        vport_index_mask = &Hf
        if data_low > LONG_MAX then
            if vport_index_mask = mask then
                read_vport_index_value = data_low
            else
                read_vport_index_value = (data_low - H8000_0000) and vport_index_mask
            end If
        else
            read_vport_index_value = data_low and vport_index_mask
        end If

    End Sub

    Sub write
        If flag_vport_index = &H0 Then read
        If flag_vport_index = &H0 Then write_vport_index_value = get_vport_index

        regValue = leftShift((write_vport_index_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        vport_index_mask = &Hf
        if data_low > LONG_MAX then
            if vport_index_mask = mask then
                read_vport_index_value = data_low
            else
                read_vport_index_value = (data_low - H8000_0000) and vport_index_mask
            end If
        else
            read_vport_index_value = data_low and vport_index_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_vport_index_value = &H0
        flag_vport_index        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_sci_lo_14
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' rxsc_sci_31_0                              [31:0]           get_rxsc_sci_31_0
''                                                             set_rxsc_sci_31_0
''                                                             read_rxsc_sci_31_0
''                                                             write_rxsc_sci_31_0
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_sci_lo_14
    Private write_rxsc_sci_31_0_value
    Private read_rxsc_sci_31_0_value
    Private flag_rxsc_sci_31_0

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H34e0
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_rxsc_sci_31_0
        get_rxsc_sci_31_0 = read_rxsc_sci_31_0_value
    End Property

    Property Let set_rxsc_sci_31_0(aData)
        write_rxsc_sci_31_0_value = aData
        flag_rxsc_sci_31_0        = &H1
    End Property

    Property Get read_rxsc_sci_31_0
        read
        read_rxsc_sci_31_0 = read_rxsc_sci_31_0_value
    End Property

    Property Let write_rxsc_sci_31_0(aData)
        set_rxsc_sci_31_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rxsc_sci_31_0_mask = &Hffffffff
        if data_low > LONG_MAX then
            if rxsc_sci_31_0_mask = mask then
                read_rxsc_sci_31_0_value = data_low
            else
                read_rxsc_sci_31_0_value = (data_low - H8000_0000) and rxsc_sci_31_0_mask
            end If
        else
            read_rxsc_sci_31_0_value = data_low and rxsc_sci_31_0_mask
        end If

    End Sub

    Sub write
        If flag_rxsc_sci_31_0 = &H0 Then read
        If flag_rxsc_sci_31_0 = &H0 Then write_rxsc_sci_31_0_value = get_rxsc_sci_31_0

        regValue = leftShift(write_rxsc_sci_31_0_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rxsc_sci_31_0_mask = &Hffffffff
        if data_low > LONG_MAX then
            if rxsc_sci_31_0_mask = mask then
                read_rxsc_sci_31_0_value = data_low
            else
                read_rxsc_sci_31_0_value = (data_low - H8000_0000) and rxsc_sci_31_0_mask
            end If
        else
            read_rxsc_sci_31_0_value = data_low and rxsc_sci_31_0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_rxsc_sci_31_0_value = &H0
        flag_rxsc_sci_31_0        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_sci_hi_14
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' rxsc_sci_63_32                             [31:0]           get_rxsc_sci_63_32
''                                                             set_rxsc_sci_63_32
''                                                             read_rxsc_sci_63_32
''                                                             write_rxsc_sci_63_32
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_sci_hi_14
    Private write_rxsc_sci_63_32_value
    Private read_rxsc_sci_63_32_value
    Private flag_rxsc_sci_63_32

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H34e4
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_rxsc_sci_63_32
        get_rxsc_sci_63_32 = read_rxsc_sci_63_32_value
    End Property

    Property Let set_rxsc_sci_63_32(aData)
        write_rxsc_sci_63_32_value = aData
        flag_rxsc_sci_63_32        = &H1
    End Property

    Property Get read_rxsc_sci_63_32
        read
        read_rxsc_sci_63_32 = read_rxsc_sci_63_32_value
    End Property

    Property Let write_rxsc_sci_63_32(aData)
        set_rxsc_sci_63_32 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rxsc_sci_63_32_mask = &Hffffffff
        if data_low > LONG_MAX then
            if rxsc_sci_63_32_mask = mask then
                read_rxsc_sci_63_32_value = data_low
            else
                read_rxsc_sci_63_32_value = (data_low - H8000_0000) and rxsc_sci_63_32_mask
            end If
        else
            read_rxsc_sci_63_32_value = data_low and rxsc_sci_63_32_mask
        end If

    End Sub

    Sub write
        If flag_rxsc_sci_63_32 = &H0 Then read
        If flag_rxsc_sci_63_32 = &H0 Then write_rxsc_sci_63_32_value = get_rxsc_sci_63_32

        regValue = leftShift(write_rxsc_sci_63_32_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rxsc_sci_63_32_mask = &Hffffffff
        if data_low > LONG_MAX then
            if rxsc_sci_63_32_mask = mask then
                read_rxsc_sci_63_32_value = data_low
            else
                read_rxsc_sci_63_32_value = (data_low - H8000_0000) and rxsc_sci_63_32_mask
            end If
        else
            read_rxsc_sci_63_32_value = data_low and rxsc_sci_63_32_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_rxsc_sci_63_32_value = &H0
        flag_rxsc_sci_63_32        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_ctrl_14
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' vport_index                                [3:0]            get_vport_index
''                                                             set_vport_index
''                                                             read_vport_index
''                                                             write_vport_index
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_ctrl_14
    Private write_vport_index_value
    Private read_vport_index_value
    Private flag_vport_index

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H34e8
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_vport_index
        get_vport_index = read_vport_index_value
    End Property

    Property Let set_vport_index(aData)
        write_vport_index_value = aData
        flag_vport_index        = &H1
    End Property

    Property Get read_vport_index
        read
        read_vport_index = read_vport_index_value
    End Property

    Property Let write_vport_index(aData)
        set_vport_index = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        vport_index_mask = &Hf
        if data_low > LONG_MAX then
            if vport_index_mask = mask then
                read_vport_index_value = data_low
            else
                read_vport_index_value = (data_low - H8000_0000) and vport_index_mask
            end If
        else
            read_vport_index_value = data_low and vport_index_mask
        end If

    End Sub

    Sub write
        If flag_vport_index = &H0 Then read
        If flag_vport_index = &H0 Then write_vport_index_value = get_vport_index

        regValue = leftShift((write_vport_index_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        vport_index_mask = &Hf
        if data_low > LONG_MAX then
            if vport_index_mask = mask then
                read_vport_index_value = data_low
            else
                read_vport_index_value = (data_low - H8000_0000) and vport_index_mask
            end If
        else
            read_vport_index_value = data_low and vport_index_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_vport_index_value = &H0
        flag_vport_index        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_sci_lo_15
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' rxsc_sci_31_0                              [31:0]           get_rxsc_sci_31_0
''                                                             set_rxsc_sci_31_0
''                                                             read_rxsc_sci_31_0
''                                                             write_rxsc_sci_31_0
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_sci_lo_15
    Private write_rxsc_sci_31_0_value
    Private read_rxsc_sci_31_0_value
    Private flag_rxsc_sci_31_0

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H34f0
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_rxsc_sci_31_0
        get_rxsc_sci_31_0 = read_rxsc_sci_31_0_value
    End Property

    Property Let set_rxsc_sci_31_0(aData)
        write_rxsc_sci_31_0_value = aData
        flag_rxsc_sci_31_0        = &H1
    End Property

    Property Get read_rxsc_sci_31_0
        read
        read_rxsc_sci_31_0 = read_rxsc_sci_31_0_value
    End Property

    Property Let write_rxsc_sci_31_0(aData)
        set_rxsc_sci_31_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rxsc_sci_31_0_mask = &Hffffffff
        if data_low > LONG_MAX then
            if rxsc_sci_31_0_mask = mask then
                read_rxsc_sci_31_0_value = data_low
            else
                read_rxsc_sci_31_0_value = (data_low - H8000_0000) and rxsc_sci_31_0_mask
            end If
        else
            read_rxsc_sci_31_0_value = data_low and rxsc_sci_31_0_mask
        end If

    End Sub

    Sub write
        If flag_rxsc_sci_31_0 = &H0 Then read
        If flag_rxsc_sci_31_0 = &H0 Then write_rxsc_sci_31_0_value = get_rxsc_sci_31_0

        regValue = leftShift(write_rxsc_sci_31_0_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rxsc_sci_31_0_mask = &Hffffffff
        if data_low > LONG_MAX then
            if rxsc_sci_31_0_mask = mask then
                read_rxsc_sci_31_0_value = data_low
            else
                read_rxsc_sci_31_0_value = (data_low - H8000_0000) and rxsc_sci_31_0_mask
            end If
        else
            read_rxsc_sci_31_0_value = data_low and rxsc_sci_31_0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_rxsc_sci_31_0_value = &H0
        flag_rxsc_sci_31_0        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_sci_hi_15
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' rxsc_sci_63_32                             [31:0]           get_rxsc_sci_63_32
''                                                             set_rxsc_sci_63_32
''                                                             read_rxsc_sci_63_32
''                                                             write_rxsc_sci_63_32
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_sci_hi_15
    Private write_rxsc_sci_63_32_value
    Private read_rxsc_sci_63_32_value
    Private flag_rxsc_sci_63_32

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H34f4
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_rxsc_sci_63_32
        get_rxsc_sci_63_32 = read_rxsc_sci_63_32_value
    End Property

    Property Let set_rxsc_sci_63_32(aData)
        write_rxsc_sci_63_32_value = aData
        flag_rxsc_sci_63_32        = &H1
    End Property

    Property Get read_rxsc_sci_63_32
        read
        read_rxsc_sci_63_32 = read_rxsc_sci_63_32_value
    End Property

    Property Let write_rxsc_sci_63_32(aData)
        set_rxsc_sci_63_32 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rxsc_sci_63_32_mask = &Hffffffff
        if data_low > LONG_MAX then
            if rxsc_sci_63_32_mask = mask then
                read_rxsc_sci_63_32_value = data_low
            else
                read_rxsc_sci_63_32_value = (data_low - H8000_0000) and rxsc_sci_63_32_mask
            end If
        else
            read_rxsc_sci_63_32_value = data_low and rxsc_sci_63_32_mask
        end If

    End Sub

    Sub write
        If flag_rxsc_sci_63_32 = &H0 Then read
        If flag_rxsc_sci_63_32 = &H0 Then write_rxsc_sci_63_32_value = get_rxsc_sci_63_32

        regValue = leftShift(write_rxsc_sci_63_32_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rxsc_sci_63_32_mask = &Hffffffff
        if data_low > LONG_MAX then
            if rxsc_sci_63_32_mask = mask then
                read_rxsc_sci_63_32_value = data_low
            else
                read_rxsc_sci_63_32_value = (data_low - H8000_0000) and rxsc_sci_63_32_mask
            end If
        else
            read_rxsc_sci_63_32_value = data_low and rxsc_sci_63_32_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_rxsc_sci_63_32_value = &H0
        flag_rxsc_sci_63_32        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_ctrl_15
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' vport_index                                [3:0]            get_vport_index
''                                                             set_vport_index
''                                                             read_vport_index
''                                                             write_vport_index
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_ctrl_15
    Private write_vport_index_value
    Private read_vport_index_value
    Private flag_vport_index

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H34f8
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_vport_index
        get_vport_index = read_vport_index_value
    End Property

    Property Let set_vport_index(aData)
        write_vport_index_value = aData
        flag_vport_index        = &H1
    End Property

    Property Get read_vport_index
        read
        read_vport_index = read_vport_index_value
    End Property

    Property Let write_vport_index(aData)
        set_vport_index = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        vport_index_mask = &Hf
        if data_low > LONG_MAX then
            if vport_index_mask = mask then
                read_vport_index_value = data_low
            else
                read_vport_index_value = (data_low - H8000_0000) and vport_index_mask
            end If
        else
            read_vport_index_value = data_low and vport_index_mask
        end If

    End Sub

    Sub write
        If flag_vport_index = &H0 Then read
        If flag_vport_index = &H0 Then write_vport_index_value = get_vport_index

        regValue = leftShift((write_vport_index_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        vport_index_mask = &Hf
        if data_low > LONG_MAX then
            if vport_index_mask = mask then
                read_vport_index_value = data_low
            else
                read_vport_index_value = (data_low - H8000_0000) and vport_index_mask
            end If
        else
            read_vport_index_value = data_low and vport_index_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_vport_index_value = &H0
        flag_vport_index        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_INSTANCE

    Public rxsc_cam_sci_lo_0
    Public rxsc_cam_sci_hi_0
    Public rxsc_cam_ctrl_0
    Public rxsc_cam_sci_lo_1
    Public rxsc_cam_sci_hi_1
    Public rxsc_cam_ctrl_1
    Public rxsc_cam_sci_lo_2
    Public rxsc_cam_sci_hi_2
    Public rxsc_cam_ctrl_2
    Public rxsc_cam_sci_lo_3
    Public rxsc_cam_sci_hi_3
    Public rxsc_cam_ctrl_3
    Public rxsc_cam_sci_lo_4
    Public rxsc_cam_sci_hi_4
    Public rxsc_cam_ctrl_4
    Public rxsc_cam_sci_lo_5
    Public rxsc_cam_sci_hi_5
    Public rxsc_cam_ctrl_5
    Public rxsc_cam_sci_lo_6
    Public rxsc_cam_sci_hi_6
    Public rxsc_cam_ctrl_6
    Public rxsc_cam_sci_lo_7
    Public rxsc_cam_sci_hi_7
    Public rxsc_cam_ctrl_7
    Public rxsc_cam_sci_lo_8
    Public rxsc_cam_sci_hi_8
    Public rxsc_cam_ctrl_8
    Public rxsc_cam_sci_lo_9
    Public rxsc_cam_sci_hi_9
    Public rxsc_cam_ctrl_9
    Public rxsc_cam_sci_lo_10
    Public rxsc_cam_sci_hi_10
    Public rxsc_cam_ctrl_10
    Public rxsc_cam_sci_lo_11
    Public rxsc_cam_sci_hi_11
    Public rxsc_cam_ctrl_11
    Public rxsc_cam_sci_lo_12
    Public rxsc_cam_sci_hi_12
    Public rxsc_cam_ctrl_12
    Public rxsc_cam_sci_lo_13
    Public rxsc_cam_sci_hi_13
    Public rxsc_cam_ctrl_13
    Public rxsc_cam_sci_lo_14
    Public rxsc_cam_sci_hi_14
    Public rxsc_cam_ctrl_14
    Public rxsc_cam_sci_lo_15
    Public rxsc_cam_sci_hi_15
    Public rxsc_cam_ctrl_15


    Public default function Init(aBaseAddr)
        Set rxsc_cam_sci_lo_0 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_sci_lo_0)(aBaseAddr, 32)
        Set rxsc_cam_sci_hi_0 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_sci_hi_0)(aBaseAddr, 32)
        Set rxsc_cam_ctrl_0 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_ctrl_0)(aBaseAddr, 32)
        Set rxsc_cam_sci_lo_1 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_sci_lo_1)(aBaseAddr, 32)
        Set rxsc_cam_sci_hi_1 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_sci_hi_1)(aBaseAddr, 32)
        Set rxsc_cam_ctrl_1 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_ctrl_1)(aBaseAddr, 32)
        Set rxsc_cam_sci_lo_2 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_sci_lo_2)(aBaseAddr, 32)
        Set rxsc_cam_sci_hi_2 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_sci_hi_2)(aBaseAddr, 32)
        Set rxsc_cam_ctrl_2 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_ctrl_2)(aBaseAddr, 32)
        Set rxsc_cam_sci_lo_3 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_sci_lo_3)(aBaseAddr, 32)
        Set rxsc_cam_sci_hi_3 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_sci_hi_3)(aBaseAddr, 32)
        Set rxsc_cam_ctrl_3 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_ctrl_3)(aBaseAddr, 32)
        Set rxsc_cam_sci_lo_4 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_sci_lo_4)(aBaseAddr, 32)
        Set rxsc_cam_sci_hi_4 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_sci_hi_4)(aBaseAddr, 32)
        Set rxsc_cam_ctrl_4 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_ctrl_4)(aBaseAddr, 32)
        Set rxsc_cam_sci_lo_5 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_sci_lo_5)(aBaseAddr, 32)
        Set rxsc_cam_sci_hi_5 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_sci_hi_5)(aBaseAddr, 32)
        Set rxsc_cam_ctrl_5 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_ctrl_5)(aBaseAddr, 32)
        Set rxsc_cam_sci_lo_6 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_sci_lo_6)(aBaseAddr, 32)
        Set rxsc_cam_sci_hi_6 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_sci_hi_6)(aBaseAddr, 32)
        Set rxsc_cam_ctrl_6 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_ctrl_6)(aBaseAddr, 32)
        Set rxsc_cam_sci_lo_7 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_sci_lo_7)(aBaseAddr, 32)
        Set rxsc_cam_sci_hi_7 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_sci_hi_7)(aBaseAddr, 32)
        Set rxsc_cam_ctrl_7 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_ctrl_7)(aBaseAddr, 32)
        Set rxsc_cam_sci_lo_8 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_sci_lo_8)(aBaseAddr, 32)
        Set rxsc_cam_sci_hi_8 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_sci_hi_8)(aBaseAddr, 32)
        Set rxsc_cam_ctrl_8 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_ctrl_8)(aBaseAddr, 32)
        Set rxsc_cam_sci_lo_9 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_sci_lo_9)(aBaseAddr, 32)
        Set rxsc_cam_sci_hi_9 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_sci_hi_9)(aBaseAddr, 32)
        Set rxsc_cam_ctrl_9 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_ctrl_9)(aBaseAddr, 32)
        Set rxsc_cam_sci_lo_10 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_sci_lo_10)(aBaseAddr, 32)
        Set rxsc_cam_sci_hi_10 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_sci_hi_10)(aBaseAddr, 32)
        Set rxsc_cam_ctrl_10 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_ctrl_10)(aBaseAddr, 32)
        Set rxsc_cam_sci_lo_11 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_sci_lo_11)(aBaseAddr, 32)
        Set rxsc_cam_sci_hi_11 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_sci_hi_11)(aBaseAddr, 32)
        Set rxsc_cam_ctrl_11 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_ctrl_11)(aBaseAddr, 32)
        Set rxsc_cam_sci_lo_12 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_sci_lo_12)(aBaseAddr, 32)
        Set rxsc_cam_sci_hi_12 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_sci_hi_12)(aBaseAddr, 32)
        Set rxsc_cam_ctrl_12 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_ctrl_12)(aBaseAddr, 32)
        Set rxsc_cam_sci_lo_13 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_sci_lo_13)(aBaseAddr, 32)
        Set rxsc_cam_sci_hi_13 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_sci_hi_13)(aBaseAddr, 32)
        Set rxsc_cam_ctrl_13 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_ctrl_13)(aBaseAddr, 32)
        Set rxsc_cam_sci_lo_14 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_sci_lo_14)(aBaseAddr, 32)
        Set rxsc_cam_sci_hi_14 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_sci_hi_14)(aBaseAddr, 32)
        Set rxsc_cam_ctrl_14 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_ctrl_14)(aBaseAddr, 32)
        Set rxsc_cam_sci_lo_15 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_sci_lo_15)(aBaseAddr, 32)
        Set rxsc_cam_sci_hi_15 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_sci_hi_15)(aBaseAddr, 32)
        Set rxsc_cam_ctrl_15 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_rxsc_cam_ctrl_15)(aBaseAddr, 32)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY = CreateObject("System.Collections.ArrayList")
EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY.Add ((New EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_INSTANCE)(&H4d010000))
EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY.Add ((New EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_INSTANCE)(&H4d110000))
EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY.Add ((New EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_INSTANCE)(&H4d210000))
EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY.Add ((New EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_INSTANCE)(&H4d310000))
EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY.Add ((New EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_INSTANCE)(&H4d410000))
EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY.Add ((New EIP165S_EIP_160S_I_32_BRCM_RXSC_CAM_KEY_INSTANCE)(&H4d510000))


