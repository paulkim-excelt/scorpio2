

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


'' @REGISTER : GIO0_gpio_g0_din
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' GPIO_G0_DIN_GPIO_DATA_IN                   [1:0]            get_GPIO_G0_DIN_GPIO_DATA_IN
''                                                             set_GPIO_G0_DIN_GPIO_DATA_IN
''                                                             read_GPIO_G0_DIN_GPIO_DATA_IN
''                                                             write_GPIO_G0_DIN_GPIO_DATA_IN
''---------------------------------------------------------------------------------
Class REGISTER_GIO0_gpio_g0_din
    Private write_GPIO_G0_DIN_GPIO_DATA_IN_value
    Private read_GPIO_G0_DIN_GPIO_DATA_IN_value
    Private flag_GPIO_G0_DIN_GPIO_DATA_IN

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

    Property Get get_GPIO_G0_DIN_GPIO_DATA_IN
        get_GPIO_G0_DIN_GPIO_DATA_IN = read_GPIO_G0_DIN_GPIO_DATA_IN_value
    End Property

    Property Let set_GPIO_G0_DIN_GPIO_DATA_IN(aData)
        write_GPIO_G0_DIN_GPIO_DATA_IN_value = aData
        flag_GPIO_G0_DIN_GPIO_DATA_IN        = &H1
    End Property

    Property Get read_GPIO_G0_DIN_GPIO_DATA_IN
        read
        read_GPIO_G0_DIN_GPIO_DATA_IN = read_GPIO_G0_DIN_GPIO_DATA_IN_value
    End Property

    Property Let write_GPIO_G0_DIN_GPIO_DATA_IN(aData)
        set_GPIO_G0_DIN_GPIO_DATA_IN = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        GPIO_G0_DIN_GPIO_DATA_IN_mask = &H3
        if data_low > LONG_MAX then
            if GPIO_G0_DIN_GPIO_DATA_IN_mask = mask then
                read_GPIO_G0_DIN_GPIO_DATA_IN_value = data_low
            else
                read_GPIO_G0_DIN_GPIO_DATA_IN_value = (data_low - H8000_0000) and GPIO_G0_DIN_GPIO_DATA_IN_mask
            end If
        else
            read_GPIO_G0_DIN_GPIO_DATA_IN_value = data_low and GPIO_G0_DIN_GPIO_DATA_IN_mask
        end If

    End Sub

    Sub write
        If flag_GPIO_G0_DIN_GPIO_DATA_IN = &H0 Then read
        If flag_GPIO_G0_DIN_GPIO_DATA_IN = &H0 Then write_GPIO_G0_DIN_GPIO_DATA_IN_value = get_GPIO_G0_DIN_GPIO_DATA_IN

        regValue = leftShift((write_GPIO_G0_DIN_GPIO_DATA_IN_value and &H3), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        GPIO_G0_DIN_GPIO_DATA_IN_mask = &H3
        if data_low > LONG_MAX then
            if GPIO_G0_DIN_GPIO_DATA_IN_mask = mask then
                read_GPIO_G0_DIN_GPIO_DATA_IN_value = data_low
            else
                read_GPIO_G0_DIN_GPIO_DATA_IN_value = (data_low - H8000_0000) and GPIO_G0_DIN_GPIO_DATA_IN_mask
            end If
        else
            read_GPIO_G0_DIN_GPIO_DATA_IN_value = data_low and GPIO_G0_DIN_GPIO_DATA_IN_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_GPIO_G0_DIN_GPIO_DATA_IN_value = &H0
        flag_GPIO_G0_DIN_GPIO_DATA_IN        = &H0
    End Sub
End Class


'' @REGISTER : GIO0_gpio_g0_dout
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' GPIO_G0_DOUT_GPIO_DATA_OUT                 [1:0]            get_GPIO_G0_DOUT_GPIO_DATA_OUT
''                                                             set_GPIO_G0_DOUT_GPIO_DATA_OUT
''                                                             read_GPIO_G0_DOUT_GPIO_DATA_OUT
''                                                             write_GPIO_G0_DOUT_GPIO_DATA_OUT
''---------------------------------------------------------------------------------
Class REGISTER_GIO0_gpio_g0_dout
    Private write_GPIO_G0_DOUT_GPIO_DATA_OUT_value
    Private read_GPIO_G0_DOUT_GPIO_DATA_OUT_value
    Private flag_GPIO_G0_DOUT_GPIO_DATA_OUT

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

    Property Get get_GPIO_G0_DOUT_GPIO_DATA_OUT
        get_GPIO_G0_DOUT_GPIO_DATA_OUT = read_GPIO_G0_DOUT_GPIO_DATA_OUT_value
    End Property

    Property Let set_GPIO_G0_DOUT_GPIO_DATA_OUT(aData)
        write_GPIO_G0_DOUT_GPIO_DATA_OUT_value = aData
        flag_GPIO_G0_DOUT_GPIO_DATA_OUT        = &H1
    End Property

    Property Get read_GPIO_G0_DOUT_GPIO_DATA_OUT
        read
        read_GPIO_G0_DOUT_GPIO_DATA_OUT = read_GPIO_G0_DOUT_GPIO_DATA_OUT_value
    End Property

    Property Let write_GPIO_G0_DOUT_GPIO_DATA_OUT(aData)
        set_GPIO_G0_DOUT_GPIO_DATA_OUT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        GPIO_G0_DOUT_GPIO_DATA_OUT_mask = &H3
        if data_low > LONG_MAX then
            if GPIO_G0_DOUT_GPIO_DATA_OUT_mask = mask then
                read_GPIO_G0_DOUT_GPIO_DATA_OUT_value = data_low
            else
                read_GPIO_G0_DOUT_GPIO_DATA_OUT_value = (data_low - H8000_0000) and GPIO_G0_DOUT_GPIO_DATA_OUT_mask
            end If
        else
            read_GPIO_G0_DOUT_GPIO_DATA_OUT_value = data_low and GPIO_G0_DOUT_GPIO_DATA_OUT_mask
        end If

    End Sub

    Sub write
        If flag_GPIO_G0_DOUT_GPIO_DATA_OUT = &H0 Then read
        If flag_GPIO_G0_DOUT_GPIO_DATA_OUT = &H0 Then write_GPIO_G0_DOUT_GPIO_DATA_OUT_value = get_GPIO_G0_DOUT_GPIO_DATA_OUT

        regValue = leftShift((write_GPIO_G0_DOUT_GPIO_DATA_OUT_value and &H3), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        GPIO_G0_DOUT_GPIO_DATA_OUT_mask = &H3
        if data_low > LONG_MAX then
            if GPIO_G0_DOUT_GPIO_DATA_OUT_mask = mask then
                read_GPIO_G0_DOUT_GPIO_DATA_OUT_value = data_low
            else
                read_GPIO_G0_DOUT_GPIO_DATA_OUT_value = (data_low - H8000_0000) and GPIO_G0_DOUT_GPIO_DATA_OUT_mask
            end If
        else
            read_GPIO_G0_DOUT_GPIO_DATA_OUT_value = data_low and GPIO_G0_DOUT_GPIO_DATA_OUT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_GPIO_G0_DOUT_GPIO_DATA_OUT_value = &H0
        flag_GPIO_G0_DOUT_GPIO_DATA_OUT        = &H0
    End Sub
End Class


'' @REGISTER : GIO0_gpio_g0_drv_en
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' GPIO_G0_DRV_EN_GPIO_DRV_EN                 [1:0]            get_GPIO_G0_DRV_EN_GPIO_DRV_EN
''                                                             set_GPIO_G0_DRV_EN_GPIO_DRV_EN
''                                                             read_GPIO_G0_DRV_EN_GPIO_DRV_EN
''                                                             write_GPIO_G0_DRV_EN_GPIO_DRV_EN
''---------------------------------------------------------------------------------
Class REGISTER_GIO0_gpio_g0_drv_en
    Private write_GPIO_G0_DRV_EN_GPIO_DRV_EN_value
    Private read_GPIO_G0_DRV_EN_GPIO_DRV_EN_value
    Private flag_GPIO_G0_DRV_EN_GPIO_DRV_EN

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

    Property Get get_GPIO_G0_DRV_EN_GPIO_DRV_EN
        get_GPIO_G0_DRV_EN_GPIO_DRV_EN = read_GPIO_G0_DRV_EN_GPIO_DRV_EN_value
    End Property

    Property Let set_GPIO_G0_DRV_EN_GPIO_DRV_EN(aData)
        write_GPIO_G0_DRV_EN_GPIO_DRV_EN_value = aData
        flag_GPIO_G0_DRV_EN_GPIO_DRV_EN        = &H1
    End Property

    Property Get read_GPIO_G0_DRV_EN_GPIO_DRV_EN
        read
        read_GPIO_G0_DRV_EN_GPIO_DRV_EN = read_GPIO_G0_DRV_EN_GPIO_DRV_EN_value
    End Property

    Property Let write_GPIO_G0_DRV_EN_GPIO_DRV_EN(aData)
        set_GPIO_G0_DRV_EN_GPIO_DRV_EN = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        GPIO_G0_DRV_EN_GPIO_DRV_EN_mask = &H3
        if data_low > LONG_MAX then
            if GPIO_G0_DRV_EN_GPIO_DRV_EN_mask = mask then
                read_GPIO_G0_DRV_EN_GPIO_DRV_EN_value = data_low
            else
                read_GPIO_G0_DRV_EN_GPIO_DRV_EN_value = (data_low - H8000_0000) and GPIO_G0_DRV_EN_GPIO_DRV_EN_mask
            end If
        else
            read_GPIO_G0_DRV_EN_GPIO_DRV_EN_value = data_low and GPIO_G0_DRV_EN_GPIO_DRV_EN_mask
        end If

    End Sub

    Sub write
        If flag_GPIO_G0_DRV_EN_GPIO_DRV_EN = &H0 Then read
        If flag_GPIO_G0_DRV_EN_GPIO_DRV_EN = &H0 Then write_GPIO_G0_DRV_EN_GPIO_DRV_EN_value = get_GPIO_G0_DRV_EN_GPIO_DRV_EN

        regValue = leftShift((write_GPIO_G0_DRV_EN_GPIO_DRV_EN_value and &H3), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        GPIO_G0_DRV_EN_GPIO_DRV_EN_mask = &H3
        if data_low > LONG_MAX then
            if GPIO_G0_DRV_EN_GPIO_DRV_EN_mask = mask then
                read_GPIO_G0_DRV_EN_GPIO_DRV_EN_value = data_low
            else
                read_GPIO_G0_DRV_EN_GPIO_DRV_EN_value = (data_low - H8000_0000) and GPIO_G0_DRV_EN_GPIO_DRV_EN_mask
            end If
        else
            read_GPIO_G0_DRV_EN_GPIO_DRV_EN_value = data_low and GPIO_G0_DRV_EN_GPIO_DRV_EN_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_GPIO_G0_DRV_EN_GPIO_DRV_EN_value = &H0
        flag_GPIO_G0_DRV_EN_GPIO_DRV_EN        = &H0
    End Sub
End Class


'' @REGISTER : GIO0_gpio_g0_int_typ
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' GPIO_G0_INT_TYP_GPIO_INT_TYP               [1:0]            get_GPIO_G0_INT_TYP_GPIO_INT_TYP
''                                                             set_GPIO_G0_INT_TYP_GPIO_INT_TYP
''                                                             read_GPIO_G0_INT_TYP_GPIO_INT_TYP
''                                                             write_GPIO_G0_INT_TYP_GPIO_INT_TYP
''---------------------------------------------------------------------------------
Class REGISTER_GIO0_gpio_g0_int_typ
    Private write_GPIO_G0_INT_TYP_GPIO_INT_TYP_value
    Private read_GPIO_G0_INT_TYP_GPIO_INT_TYP_value
    Private flag_GPIO_G0_INT_TYP_GPIO_INT_TYP

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

    Property Get get_GPIO_G0_INT_TYP_GPIO_INT_TYP
        get_GPIO_G0_INT_TYP_GPIO_INT_TYP = read_GPIO_G0_INT_TYP_GPIO_INT_TYP_value
    End Property

    Property Let set_GPIO_G0_INT_TYP_GPIO_INT_TYP(aData)
        write_GPIO_G0_INT_TYP_GPIO_INT_TYP_value = aData
        flag_GPIO_G0_INT_TYP_GPIO_INT_TYP        = &H1
    End Property

    Property Get read_GPIO_G0_INT_TYP_GPIO_INT_TYP
        read
        read_GPIO_G0_INT_TYP_GPIO_INT_TYP = read_GPIO_G0_INT_TYP_GPIO_INT_TYP_value
    End Property

    Property Let write_GPIO_G0_INT_TYP_GPIO_INT_TYP(aData)
        set_GPIO_G0_INT_TYP_GPIO_INT_TYP = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        GPIO_G0_INT_TYP_GPIO_INT_TYP_mask = &H3
        if data_low > LONG_MAX then
            if GPIO_G0_INT_TYP_GPIO_INT_TYP_mask = mask then
                read_GPIO_G0_INT_TYP_GPIO_INT_TYP_value = data_low
            else
                read_GPIO_G0_INT_TYP_GPIO_INT_TYP_value = (data_low - H8000_0000) and GPIO_G0_INT_TYP_GPIO_INT_TYP_mask
            end If
        else
            read_GPIO_G0_INT_TYP_GPIO_INT_TYP_value = data_low and GPIO_G0_INT_TYP_GPIO_INT_TYP_mask
        end If

    End Sub

    Sub write
        If flag_GPIO_G0_INT_TYP_GPIO_INT_TYP = &H0 Then read
        If flag_GPIO_G0_INT_TYP_GPIO_INT_TYP = &H0 Then write_GPIO_G0_INT_TYP_GPIO_INT_TYP_value = get_GPIO_G0_INT_TYP_GPIO_INT_TYP

        regValue = leftShift((write_GPIO_G0_INT_TYP_GPIO_INT_TYP_value and &H3), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        GPIO_G0_INT_TYP_GPIO_INT_TYP_mask = &H3
        if data_low > LONG_MAX then
            if GPIO_G0_INT_TYP_GPIO_INT_TYP_mask = mask then
                read_GPIO_G0_INT_TYP_GPIO_INT_TYP_value = data_low
            else
                read_GPIO_G0_INT_TYP_GPIO_INT_TYP_value = (data_low - H8000_0000) and GPIO_G0_INT_TYP_GPIO_INT_TYP_mask
            end If
        else
            read_GPIO_G0_INT_TYP_GPIO_INT_TYP_value = data_low and GPIO_G0_INT_TYP_GPIO_INT_TYP_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_GPIO_G0_INT_TYP_GPIO_INT_TYP_value = &H0
        flag_GPIO_G0_INT_TYP_GPIO_INT_TYP        = &H0
    End Sub
End Class


'' @REGISTER : GIO0_gpio_g0_int_du_edg
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' GPIO_G0_INT_DU_EDG_GPIO_INT_DU_EDGE        [1:0]            get_GPIO_G0_INT_DU_EDG_GPIO_INT_DU_EDGE
''                                                             set_GPIO_G0_INT_DU_EDG_GPIO_INT_DU_EDGE
''                                                             read_GPIO_G0_INT_DU_EDG_GPIO_INT_DU_EDGE
''                                                             write_GPIO_G0_INT_DU_EDG_GPIO_INT_DU_EDGE
''---------------------------------------------------------------------------------
Class REGISTER_GIO0_gpio_g0_int_du_edg
    Private write_GPIO_G0_INT_DU_EDG_GPIO_INT_DU_EDGE_value
    Private read_GPIO_G0_INT_DU_EDG_GPIO_INT_DU_EDGE_value
    Private flag_GPIO_G0_INT_DU_EDG_GPIO_INT_DU_EDGE

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

    Property Get get_GPIO_G0_INT_DU_EDG_GPIO_INT_DU_EDGE
        get_GPIO_G0_INT_DU_EDG_GPIO_INT_DU_EDGE = read_GPIO_G0_INT_DU_EDG_GPIO_INT_DU_EDGE_value
    End Property

    Property Let set_GPIO_G0_INT_DU_EDG_GPIO_INT_DU_EDGE(aData)
        write_GPIO_G0_INT_DU_EDG_GPIO_INT_DU_EDGE_value = aData
        flag_GPIO_G0_INT_DU_EDG_GPIO_INT_DU_EDGE        = &H1
    End Property

    Property Get read_GPIO_G0_INT_DU_EDG_GPIO_INT_DU_EDGE
        read
        read_GPIO_G0_INT_DU_EDG_GPIO_INT_DU_EDGE = read_GPIO_G0_INT_DU_EDG_GPIO_INT_DU_EDGE_value
    End Property

    Property Let write_GPIO_G0_INT_DU_EDG_GPIO_INT_DU_EDGE(aData)
        set_GPIO_G0_INT_DU_EDG_GPIO_INT_DU_EDGE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        GPIO_G0_INT_DU_EDG_GPIO_INT_DU_EDGE_mask = &H3
        if data_low > LONG_MAX then
            if GPIO_G0_INT_DU_EDG_GPIO_INT_DU_EDGE_mask = mask then
                read_GPIO_G0_INT_DU_EDG_GPIO_INT_DU_EDGE_value = data_low
            else
                read_GPIO_G0_INT_DU_EDG_GPIO_INT_DU_EDGE_value = (data_low - H8000_0000) and GPIO_G0_INT_DU_EDG_GPIO_INT_DU_EDGE_mask
            end If
        else
            read_GPIO_G0_INT_DU_EDG_GPIO_INT_DU_EDGE_value = data_low and GPIO_G0_INT_DU_EDG_GPIO_INT_DU_EDGE_mask
        end If

    End Sub

    Sub write
        If flag_GPIO_G0_INT_DU_EDG_GPIO_INT_DU_EDGE = &H0 Then read
        If flag_GPIO_G0_INT_DU_EDG_GPIO_INT_DU_EDGE = &H0 Then write_GPIO_G0_INT_DU_EDG_GPIO_INT_DU_EDGE_value = get_GPIO_G0_INT_DU_EDG_GPIO_INT_DU_EDGE

        regValue = leftShift((write_GPIO_G0_INT_DU_EDG_GPIO_INT_DU_EDGE_value and &H3), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        GPIO_G0_INT_DU_EDG_GPIO_INT_DU_EDGE_mask = &H3
        if data_low > LONG_MAX then
            if GPIO_G0_INT_DU_EDG_GPIO_INT_DU_EDGE_mask = mask then
                read_GPIO_G0_INT_DU_EDG_GPIO_INT_DU_EDGE_value = data_low
            else
                read_GPIO_G0_INT_DU_EDG_GPIO_INT_DU_EDGE_value = (data_low - H8000_0000) and GPIO_G0_INT_DU_EDG_GPIO_INT_DU_EDGE_mask
            end If
        else
            read_GPIO_G0_INT_DU_EDG_GPIO_INT_DU_EDGE_value = data_low and GPIO_G0_INT_DU_EDG_GPIO_INT_DU_EDGE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_GPIO_G0_INT_DU_EDG_GPIO_INT_DU_EDGE_value = &H0
        flag_GPIO_G0_INT_DU_EDG_GPIO_INT_DU_EDGE        = &H0
    End Sub
End Class


'' @REGISTER : GIO0_gpio_g0_int_edg_lvl_sel
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' GPIO_G0_INT_EDG_LVL_SEL_GPIO_INT_EDGE      [1:0]            get_GPIO_G0_INT_EDG_LVL_SEL_GPIO_INT_EDGE
''                                                             set_GPIO_G0_INT_EDG_LVL_SEL_GPIO_INT_EDGE
''                                                             read_GPIO_G0_INT_EDG_LVL_SEL_GPIO_INT_EDGE
''                                                             write_GPIO_G0_INT_EDG_LVL_SEL_GPIO_INT_EDGE
''---------------------------------------------------------------------------------
Class REGISTER_GIO0_gpio_g0_int_edg_lvl_sel
    Private write_GPIO_G0_INT_EDG_LVL_SEL_GPIO_INT_EDGE_value
    Private read_GPIO_G0_INT_EDG_LVL_SEL_GPIO_INT_EDGE_value
    Private flag_GPIO_G0_INT_EDG_LVL_SEL_GPIO_INT_EDGE

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

    Property Get get_GPIO_G0_INT_EDG_LVL_SEL_GPIO_INT_EDGE
        get_GPIO_G0_INT_EDG_LVL_SEL_GPIO_INT_EDGE = read_GPIO_G0_INT_EDG_LVL_SEL_GPIO_INT_EDGE_value
    End Property

    Property Let set_GPIO_G0_INT_EDG_LVL_SEL_GPIO_INT_EDGE(aData)
        write_GPIO_G0_INT_EDG_LVL_SEL_GPIO_INT_EDGE_value = aData
        flag_GPIO_G0_INT_EDG_LVL_SEL_GPIO_INT_EDGE        = &H1
    End Property

    Property Get read_GPIO_G0_INT_EDG_LVL_SEL_GPIO_INT_EDGE
        read
        read_GPIO_G0_INT_EDG_LVL_SEL_GPIO_INT_EDGE = read_GPIO_G0_INT_EDG_LVL_SEL_GPIO_INT_EDGE_value
    End Property

    Property Let write_GPIO_G0_INT_EDG_LVL_SEL_GPIO_INT_EDGE(aData)
        set_GPIO_G0_INT_EDG_LVL_SEL_GPIO_INT_EDGE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        GPIO_G0_INT_EDG_LVL_SEL_GPIO_INT_EDGE_mask = &H3
        if data_low > LONG_MAX then
            if GPIO_G0_INT_EDG_LVL_SEL_GPIO_INT_EDGE_mask = mask then
                read_GPIO_G0_INT_EDG_LVL_SEL_GPIO_INT_EDGE_value = data_low
            else
                read_GPIO_G0_INT_EDG_LVL_SEL_GPIO_INT_EDGE_value = (data_low - H8000_0000) and GPIO_G0_INT_EDG_LVL_SEL_GPIO_INT_EDGE_mask
            end If
        else
            read_GPIO_G0_INT_EDG_LVL_SEL_GPIO_INT_EDGE_value = data_low and GPIO_G0_INT_EDG_LVL_SEL_GPIO_INT_EDGE_mask
        end If

    End Sub

    Sub write
        If flag_GPIO_G0_INT_EDG_LVL_SEL_GPIO_INT_EDGE = &H0 Then read
        If flag_GPIO_G0_INT_EDG_LVL_SEL_GPIO_INT_EDGE = &H0 Then write_GPIO_G0_INT_EDG_LVL_SEL_GPIO_INT_EDGE_value = get_GPIO_G0_INT_EDG_LVL_SEL_GPIO_INT_EDGE

        regValue = leftShift((write_GPIO_G0_INT_EDG_LVL_SEL_GPIO_INT_EDGE_value and &H3), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        GPIO_G0_INT_EDG_LVL_SEL_GPIO_INT_EDGE_mask = &H3
        if data_low > LONG_MAX then
            if GPIO_G0_INT_EDG_LVL_SEL_GPIO_INT_EDGE_mask = mask then
                read_GPIO_G0_INT_EDG_LVL_SEL_GPIO_INT_EDGE_value = data_low
            else
                read_GPIO_G0_INT_EDG_LVL_SEL_GPIO_INT_EDGE_value = (data_low - H8000_0000) and GPIO_G0_INT_EDG_LVL_SEL_GPIO_INT_EDGE_mask
            end If
        else
            read_GPIO_G0_INT_EDG_LVL_SEL_GPIO_INT_EDGE_value = data_low and GPIO_G0_INT_EDG_LVL_SEL_GPIO_INT_EDGE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_GPIO_G0_INT_EDG_LVL_SEL_GPIO_INT_EDGE_value = &H0
        flag_GPIO_G0_INT_EDG_LVL_SEL_GPIO_INT_EDGE        = &H0
    End Sub
End Class


'' @REGISTER : GIO0_gpio_g0_int_msk
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' GPIO_G0_INT_MSK_GPIO_INT_MSK               [1:0]            get_GPIO_G0_INT_MSK_GPIO_INT_MSK
''                                                             set_GPIO_G0_INT_MSK_GPIO_INT_MSK
''                                                             read_GPIO_G0_INT_MSK_GPIO_INT_MSK
''                                                             write_GPIO_G0_INT_MSK_GPIO_INT_MSK
''---------------------------------------------------------------------------------
Class REGISTER_GIO0_gpio_g0_int_msk
    Private write_GPIO_G0_INT_MSK_GPIO_INT_MSK_value
    Private read_GPIO_G0_INT_MSK_GPIO_INT_MSK_value
    Private flag_GPIO_G0_INT_MSK_GPIO_INT_MSK

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

    Property Get get_GPIO_G0_INT_MSK_GPIO_INT_MSK
        get_GPIO_G0_INT_MSK_GPIO_INT_MSK = read_GPIO_G0_INT_MSK_GPIO_INT_MSK_value
    End Property

    Property Let set_GPIO_G0_INT_MSK_GPIO_INT_MSK(aData)
        write_GPIO_G0_INT_MSK_GPIO_INT_MSK_value = aData
        flag_GPIO_G0_INT_MSK_GPIO_INT_MSK        = &H1
    End Property

    Property Get read_GPIO_G0_INT_MSK_GPIO_INT_MSK
        read
        read_GPIO_G0_INT_MSK_GPIO_INT_MSK = read_GPIO_G0_INT_MSK_GPIO_INT_MSK_value
    End Property

    Property Let write_GPIO_G0_INT_MSK_GPIO_INT_MSK(aData)
        set_GPIO_G0_INT_MSK_GPIO_INT_MSK = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        GPIO_G0_INT_MSK_GPIO_INT_MSK_mask = &H3
        if data_low > LONG_MAX then
            if GPIO_G0_INT_MSK_GPIO_INT_MSK_mask = mask then
                read_GPIO_G0_INT_MSK_GPIO_INT_MSK_value = data_low
            else
                read_GPIO_G0_INT_MSK_GPIO_INT_MSK_value = (data_low - H8000_0000) and GPIO_G0_INT_MSK_GPIO_INT_MSK_mask
            end If
        else
            read_GPIO_G0_INT_MSK_GPIO_INT_MSK_value = data_low and GPIO_G0_INT_MSK_GPIO_INT_MSK_mask
        end If

    End Sub

    Sub write
        If flag_GPIO_G0_INT_MSK_GPIO_INT_MSK = &H0 Then read
        If flag_GPIO_G0_INT_MSK_GPIO_INT_MSK = &H0 Then write_GPIO_G0_INT_MSK_GPIO_INT_MSK_value = get_GPIO_G0_INT_MSK_GPIO_INT_MSK

        regValue = leftShift((write_GPIO_G0_INT_MSK_GPIO_INT_MSK_value and &H3), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        GPIO_G0_INT_MSK_GPIO_INT_MSK_mask = &H3
        if data_low > LONG_MAX then
            if GPIO_G0_INT_MSK_GPIO_INT_MSK_mask = mask then
                read_GPIO_G0_INT_MSK_GPIO_INT_MSK_value = data_low
            else
                read_GPIO_G0_INT_MSK_GPIO_INT_MSK_value = (data_low - H8000_0000) and GPIO_G0_INT_MSK_GPIO_INT_MSK_mask
            end If
        else
            read_GPIO_G0_INT_MSK_GPIO_INT_MSK_value = data_low and GPIO_G0_INT_MSK_GPIO_INT_MSK_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_GPIO_G0_INT_MSK_GPIO_INT_MSK_value = &H0
        flag_GPIO_G0_INT_MSK_GPIO_INT_MSK        = &H0
    End Sub
End Class


'' @REGISTER : GIO0_gpio_g0_int_sts
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' GPIO_G0_INT_STS_GPIO_INT_STS               [1:0]            get_GPIO_G0_INT_STS_GPIO_INT_STS
''                                                             set_GPIO_G0_INT_STS_GPIO_INT_STS
''                                                             read_GPIO_G0_INT_STS_GPIO_INT_STS
''                                                             write_GPIO_G0_INT_STS_GPIO_INT_STS
''---------------------------------------------------------------------------------
Class REGISTER_GIO0_gpio_g0_int_sts
    Private write_GPIO_G0_INT_STS_GPIO_INT_STS_value
    Private read_GPIO_G0_INT_STS_GPIO_INT_STS_value
    Private flag_GPIO_G0_INT_STS_GPIO_INT_STS

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

    Property Get get_GPIO_G0_INT_STS_GPIO_INT_STS
        get_GPIO_G0_INT_STS_GPIO_INT_STS = read_GPIO_G0_INT_STS_GPIO_INT_STS_value
    End Property

    Property Let set_GPIO_G0_INT_STS_GPIO_INT_STS(aData)
        write_GPIO_G0_INT_STS_GPIO_INT_STS_value = aData
        flag_GPIO_G0_INT_STS_GPIO_INT_STS        = &H1
    End Property

    Property Get read_GPIO_G0_INT_STS_GPIO_INT_STS
        read
        read_GPIO_G0_INT_STS_GPIO_INT_STS = read_GPIO_G0_INT_STS_GPIO_INT_STS_value
    End Property

    Property Let write_GPIO_G0_INT_STS_GPIO_INT_STS(aData)
        set_GPIO_G0_INT_STS_GPIO_INT_STS = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        GPIO_G0_INT_STS_GPIO_INT_STS_mask = &H3
        if data_low > LONG_MAX then
            if GPIO_G0_INT_STS_GPIO_INT_STS_mask = mask then
                read_GPIO_G0_INT_STS_GPIO_INT_STS_value = data_low
            else
                read_GPIO_G0_INT_STS_GPIO_INT_STS_value = (data_low - H8000_0000) and GPIO_G0_INT_STS_GPIO_INT_STS_mask
            end If
        else
            read_GPIO_G0_INT_STS_GPIO_INT_STS_value = data_low and GPIO_G0_INT_STS_GPIO_INT_STS_mask
        end If

    End Sub

    Sub write
        If flag_GPIO_G0_INT_STS_GPIO_INT_STS = &H0 Then read
        If flag_GPIO_G0_INT_STS_GPIO_INT_STS = &H0 Then write_GPIO_G0_INT_STS_GPIO_INT_STS_value = get_GPIO_G0_INT_STS_GPIO_INT_STS

        regValue = leftShift((write_GPIO_G0_INT_STS_GPIO_INT_STS_value and &H3), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        GPIO_G0_INT_STS_GPIO_INT_STS_mask = &H3
        if data_low > LONG_MAX then
            if GPIO_G0_INT_STS_GPIO_INT_STS_mask = mask then
                read_GPIO_G0_INT_STS_GPIO_INT_STS_value = data_low
            else
                read_GPIO_G0_INT_STS_GPIO_INT_STS_value = (data_low - H8000_0000) and GPIO_G0_INT_STS_GPIO_INT_STS_mask
            end If
        else
            read_GPIO_G0_INT_STS_GPIO_INT_STS_value = data_low and GPIO_G0_INT_STS_GPIO_INT_STS_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_GPIO_G0_INT_STS_GPIO_INT_STS_value = &H0
        flag_GPIO_G0_INT_STS_GPIO_INT_STS        = &H0
    End Sub
End Class


'' @REGISTER : GIO0_gpio_g0_int_msk_sts
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' GPIO_G0_INT_MSK_STS_GPIO_INT_MSK_STS       [1:0]            get_GPIO_G0_INT_MSK_STS_GPIO_INT_MSK_STS
''                                                             set_GPIO_G0_INT_MSK_STS_GPIO_INT_MSK_STS
''                                                             read_GPIO_G0_INT_MSK_STS_GPIO_INT_MSK_STS
''                                                             write_GPIO_G0_INT_MSK_STS_GPIO_INT_MSK_STS
''---------------------------------------------------------------------------------
Class REGISTER_GIO0_gpio_g0_int_msk_sts
    Private write_GPIO_G0_INT_MSK_STS_GPIO_INT_MSK_STS_value
    Private read_GPIO_G0_INT_MSK_STS_GPIO_INT_MSK_STS_value
    Private flag_GPIO_G0_INT_MSK_STS_GPIO_INT_MSK_STS

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

    Property Get get_GPIO_G0_INT_MSK_STS_GPIO_INT_MSK_STS
        get_GPIO_G0_INT_MSK_STS_GPIO_INT_MSK_STS = read_GPIO_G0_INT_MSK_STS_GPIO_INT_MSK_STS_value
    End Property

    Property Let set_GPIO_G0_INT_MSK_STS_GPIO_INT_MSK_STS(aData)
        write_GPIO_G0_INT_MSK_STS_GPIO_INT_MSK_STS_value = aData
        flag_GPIO_G0_INT_MSK_STS_GPIO_INT_MSK_STS        = &H1
    End Property

    Property Get read_GPIO_G0_INT_MSK_STS_GPIO_INT_MSK_STS
        read
        read_GPIO_G0_INT_MSK_STS_GPIO_INT_MSK_STS = read_GPIO_G0_INT_MSK_STS_GPIO_INT_MSK_STS_value
    End Property

    Property Let write_GPIO_G0_INT_MSK_STS_GPIO_INT_MSK_STS(aData)
        set_GPIO_G0_INT_MSK_STS_GPIO_INT_MSK_STS = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        GPIO_G0_INT_MSK_STS_GPIO_INT_MSK_STS_mask = &H3
        if data_low > LONG_MAX then
            if GPIO_G0_INT_MSK_STS_GPIO_INT_MSK_STS_mask = mask then
                read_GPIO_G0_INT_MSK_STS_GPIO_INT_MSK_STS_value = data_low
            else
                read_GPIO_G0_INT_MSK_STS_GPIO_INT_MSK_STS_value = (data_low - H8000_0000) and GPIO_G0_INT_MSK_STS_GPIO_INT_MSK_STS_mask
            end If
        else
            read_GPIO_G0_INT_MSK_STS_GPIO_INT_MSK_STS_value = data_low and GPIO_G0_INT_MSK_STS_GPIO_INT_MSK_STS_mask
        end If

    End Sub

    Sub write
        If flag_GPIO_G0_INT_MSK_STS_GPIO_INT_MSK_STS = &H0 Then read
        If flag_GPIO_G0_INT_MSK_STS_GPIO_INT_MSK_STS = &H0 Then write_GPIO_G0_INT_MSK_STS_GPIO_INT_MSK_STS_value = get_GPIO_G0_INT_MSK_STS_GPIO_INT_MSK_STS

        regValue = leftShift((write_GPIO_G0_INT_MSK_STS_GPIO_INT_MSK_STS_value and &H3), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        GPIO_G0_INT_MSK_STS_GPIO_INT_MSK_STS_mask = &H3
        if data_low > LONG_MAX then
            if GPIO_G0_INT_MSK_STS_GPIO_INT_MSK_STS_mask = mask then
                read_GPIO_G0_INT_MSK_STS_GPIO_INT_MSK_STS_value = data_low
            else
                read_GPIO_G0_INT_MSK_STS_GPIO_INT_MSK_STS_value = (data_low - H8000_0000) and GPIO_G0_INT_MSK_STS_GPIO_INT_MSK_STS_mask
            end If
        else
            read_GPIO_G0_INT_MSK_STS_GPIO_INT_MSK_STS_value = data_low and GPIO_G0_INT_MSK_STS_GPIO_INT_MSK_STS_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_GPIO_G0_INT_MSK_STS_GPIO_INT_MSK_STS_value = &H0
        flag_GPIO_G0_INT_MSK_STS_GPIO_INT_MSK_STS        = &H0
    End Sub
End Class


'' @REGISTER : GIO0_gpio_g0_int_clr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' GPIO_G0_INT_CLR_GPIO_INT_CLR               [1:0]            get_GPIO_G0_INT_CLR_GPIO_INT_CLR
''                                                             set_GPIO_G0_INT_CLR_GPIO_INT_CLR
''                                                             read_GPIO_G0_INT_CLR_GPIO_INT_CLR
''                                                             write_GPIO_G0_INT_CLR_GPIO_INT_CLR
''---------------------------------------------------------------------------------
Class REGISTER_GIO0_gpio_g0_int_clr
    Private write_GPIO_G0_INT_CLR_GPIO_INT_CLR_value
    Private read_GPIO_G0_INT_CLR_GPIO_INT_CLR_value
    Private flag_GPIO_G0_INT_CLR_GPIO_INT_CLR

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

    Property Get get_GPIO_G0_INT_CLR_GPIO_INT_CLR
        get_GPIO_G0_INT_CLR_GPIO_INT_CLR = read_GPIO_G0_INT_CLR_GPIO_INT_CLR_value
    End Property

    Property Let set_GPIO_G0_INT_CLR_GPIO_INT_CLR(aData)
        write_GPIO_G0_INT_CLR_GPIO_INT_CLR_value = aData
        flag_GPIO_G0_INT_CLR_GPIO_INT_CLR        = &H1
    End Property

    Property Get read_GPIO_G0_INT_CLR_GPIO_INT_CLR
        read
        read_GPIO_G0_INT_CLR_GPIO_INT_CLR = read_GPIO_G0_INT_CLR_GPIO_INT_CLR_value
    End Property

    Property Let write_GPIO_G0_INT_CLR_GPIO_INT_CLR(aData)
        set_GPIO_G0_INT_CLR_GPIO_INT_CLR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        GPIO_G0_INT_CLR_GPIO_INT_CLR_mask = &H3
        if data_low > LONG_MAX then
            if GPIO_G0_INT_CLR_GPIO_INT_CLR_mask = mask then
                read_GPIO_G0_INT_CLR_GPIO_INT_CLR_value = data_low
            else
                read_GPIO_G0_INT_CLR_GPIO_INT_CLR_value = (data_low - H8000_0000) and GPIO_G0_INT_CLR_GPIO_INT_CLR_mask
            end If
        else
            read_GPIO_G0_INT_CLR_GPIO_INT_CLR_value = data_low and GPIO_G0_INT_CLR_GPIO_INT_CLR_mask
        end If

    End Sub

    Sub write
        If flag_GPIO_G0_INT_CLR_GPIO_INT_CLR = &H0 Then read
        If flag_GPIO_G0_INT_CLR_GPIO_INT_CLR = &H0 Then write_GPIO_G0_INT_CLR_GPIO_INT_CLR_value = get_GPIO_G0_INT_CLR_GPIO_INT_CLR

        regValue = leftShift((write_GPIO_G0_INT_CLR_GPIO_INT_CLR_value and &H3), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        GPIO_G0_INT_CLR_GPIO_INT_CLR_mask = &H3
        if data_low > LONG_MAX then
            if GPIO_G0_INT_CLR_GPIO_INT_CLR_mask = mask then
                read_GPIO_G0_INT_CLR_GPIO_INT_CLR_value = data_low
            else
                read_GPIO_G0_INT_CLR_GPIO_INT_CLR_value = (data_low - H8000_0000) and GPIO_G0_INT_CLR_GPIO_INT_CLR_mask
            end If
        else
            read_GPIO_G0_INT_CLR_GPIO_INT_CLR_value = data_low and GPIO_G0_INT_CLR_GPIO_INT_CLR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_GPIO_G0_INT_CLR_GPIO_INT_CLR_value = &H0
        flag_GPIO_G0_INT_CLR_GPIO_INT_CLR        = &H0
    End Sub
End Class


'' @REGISTER : GIO0_gpio_g0_i2c_sel
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' GPIO_G0_I2C_SEL_RESERVED_1                 [3:2]            get_GPIO_G0_I2C_SEL_RESERVED_1
''                                                             set_GPIO_G0_I2C_SEL_RESERVED_1
''                                                             read_GPIO_G0_I2C_SEL_RESERVED_1
''                                                             write_GPIO_G0_I2C_SEL_RESERVED_1
''---------------------------------------------------------------------------------
'' GPIO_I2C_MUX_SEL                           [1:0]            get_GPIO_I2C_MUX_SEL
''                                                             set_GPIO_I2C_MUX_SEL
''                                                             read_GPIO_I2C_MUX_SEL
''                                                             write_GPIO_I2C_MUX_SEL
''---------------------------------------------------------------------------------
Class REGISTER_GIO0_gpio_g0_i2c_sel
    Private write_GPIO_G0_I2C_SEL_RESERVED_1_value
    Private read_GPIO_G0_I2C_SEL_RESERVED_1_value
    Private flag_GPIO_G0_I2C_SEL_RESERVED_1
    Private write_GPIO_I2C_MUX_SEL_value
    Private read_GPIO_I2C_MUX_SEL_value
    Private flag_GPIO_I2C_MUX_SEL

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

    Property Get get_GPIO_G0_I2C_SEL_RESERVED_1
        get_GPIO_G0_I2C_SEL_RESERVED_1 = read_GPIO_G0_I2C_SEL_RESERVED_1_value
    End Property

    Property Let set_GPIO_G0_I2C_SEL_RESERVED_1(aData)
        write_GPIO_G0_I2C_SEL_RESERVED_1_value = aData
        flag_GPIO_G0_I2C_SEL_RESERVED_1        = &H1
    End Property

    Property Get read_GPIO_G0_I2C_SEL_RESERVED_1
        read
        read_GPIO_G0_I2C_SEL_RESERVED_1 = read_GPIO_G0_I2C_SEL_RESERVED_1_value
    End Property

    Property Let write_GPIO_G0_I2C_SEL_RESERVED_1(aData)
        set_GPIO_G0_I2C_SEL_RESERVED_1 = aData
        write
    End Property

    Property Get get_GPIO_I2C_MUX_SEL
        get_GPIO_I2C_MUX_SEL = read_GPIO_I2C_MUX_SEL_value
    End Property

    Property Let set_GPIO_I2C_MUX_SEL(aData)
        write_GPIO_I2C_MUX_SEL_value = aData
        flag_GPIO_I2C_MUX_SEL        = &H1
    End Property

    Property Get read_GPIO_I2C_MUX_SEL
        read
        read_GPIO_I2C_MUX_SEL = read_GPIO_I2C_MUX_SEL_value
    End Property

    Property Let write_GPIO_I2C_MUX_SEL(aData)
        set_GPIO_I2C_MUX_SEL = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_GPIO_G0_I2C_SEL_RESERVED_1_value = rightShift(data_low, 2) and &H3
        GPIO_I2C_MUX_SEL_mask = &H3
        if data_low > LONG_MAX then
            if GPIO_I2C_MUX_SEL_mask = mask then
                read_GPIO_I2C_MUX_SEL_value = data_low
            else
                read_GPIO_I2C_MUX_SEL_value = (data_low - H8000_0000) and GPIO_I2C_MUX_SEL_mask
            end If
        else
            read_GPIO_I2C_MUX_SEL_value = data_low and GPIO_I2C_MUX_SEL_mask
        end If

    End Sub

    Sub write
        If flag_GPIO_G0_I2C_SEL_RESERVED_1 = &H0 or flag_GPIO_I2C_MUX_SEL = &H0 Then read
        If flag_GPIO_G0_I2C_SEL_RESERVED_1 = &H0 Then write_GPIO_G0_I2C_SEL_RESERVED_1_value = get_GPIO_G0_I2C_SEL_RESERVED_1
        If flag_GPIO_I2C_MUX_SEL = &H0 Then write_GPIO_I2C_MUX_SEL_value = get_GPIO_I2C_MUX_SEL

        regValue = leftShift((write_GPIO_G0_I2C_SEL_RESERVED_1_value and &H3), 2) + leftShift((write_GPIO_I2C_MUX_SEL_value and &H3), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_GPIO_G0_I2C_SEL_RESERVED_1_value = rightShift(data_low, 2) and &H3
        GPIO_I2C_MUX_SEL_mask = &H3
        if data_low > LONG_MAX then
            if GPIO_I2C_MUX_SEL_mask = mask then
                read_GPIO_I2C_MUX_SEL_value = data_low
            else
                read_GPIO_I2C_MUX_SEL_value = (data_low - H8000_0000) and GPIO_I2C_MUX_SEL_mask
            end If
        else
            read_GPIO_I2C_MUX_SEL_value = data_low and GPIO_I2C_MUX_SEL_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_GPIO_G0_I2C_SEL_RESERVED_1_value = &H0
        flag_GPIO_G0_I2C_SEL_RESERVED_1        = &H0
        write_GPIO_I2C_MUX_SEL_value = &H0
        flag_GPIO_I2C_MUX_SEL        = &H0
    End Sub
End Class


'' @REGISTER : GIO0_gpio_g0_int_pol
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' GPIO_G0_INT_POL_RESERVED_1                 [4:2]            get_GPIO_G0_INT_POL_RESERVED_1
''                                                             set_GPIO_G0_INT_POL_RESERVED_1
''                                                             read_GPIO_G0_INT_POL_RESERVED_1
''                                                             write_GPIO_G0_INT_POL_RESERVED_1
''---------------------------------------------------------------------------------
'' GPIO_G0_INT_POL_GPIO_INT_POL               [1:1]            get_GPIO_G0_INT_POL_GPIO_INT_POL
''                                                             set_GPIO_G0_INT_POL_GPIO_INT_POL
''                                                             read_GPIO_G0_INT_POL_GPIO_INT_POL
''                                                             write_GPIO_G0_INT_POL_GPIO_INT_POL
''---------------------------------------------------------------------------------
Class REGISTER_GIO0_gpio_g0_int_pol
    Private write_GPIO_G0_INT_POL_RESERVED_1_value
    Private read_GPIO_G0_INT_POL_RESERVED_1_value
    Private flag_GPIO_G0_INT_POL_RESERVED_1
    Private write_GPIO_G0_INT_POL_GPIO_INT_POL_value
    Private read_GPIO_G0_INT_POL_GPIO_INT_POL_value
    Private flag_GPIO_G0_INT_POL_GPIO_INT_POL

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

    Property Get get_GPIO_G0_INT_POL_RESERVED_1
        get_GPIO_G0_INT_POL_RESERVED_1 = read_GPIO_G0_INT_POL_RESERVED_1_value
    End Property

    Property Let set_GPIO_G0_INT_POL_RESERVED_1(aData)
        write_GPIO_G0_INT_POL_RESERVED_1_value = aData
        flag_GPIO_G0_INT_POL_RESERVED_1        = &H1
    End Property

    Property Get read_GPIO_G0_INT_POL_RESERVED_1
        read
        read_GPIO_G0_INT_POL_RESERVED_1 = read_GPIO_G0_INT_POL_RESERVED_1_value
    End Property

    Property Let write_GPIO_G0_INT_POL_RESERVED_1(aData)
        set_GPIO_G0_INT_POL_RESERVED_1 = aData
        write
    End Property

    Property Get get_GPIO_G0_INT_POL_GPIO_INT_POL
        get_GPIO_G0_INT_POL_GPIO_INT_POL = read_GPIO_G0_INT_POL_GPIO_INT_POL_value
    End Property

    Property Let set_GPIO_G0_INT_POL_GPIO_INT_POL(aData)
        write_GPIO_G0_INT_POL_GPIO_INT_POL_value = aData
        flag_GPIO_G0_INT_POL_GPIO_INT_POL        = &H1
    End Property

    Property Get read_GPIO_G0_INT_POL_GPIO_INT_POL
        read
        read_GPIO_G0_INT_POL_GPIO_INT_POL = read_GPIO_G0_INT_POL_GPIO_INT_POL_value
    End Property

    Property Let write_GPIO_G0_INT_POL_GPIO_INT_POL(aData)
        set_GPIO_G0_INT_POL_GPIO_INT_POL = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_GPIO_G0_INT_POL_RESERVED_1_value = rightShift(data_low, 2) and &H7
        read_GPIO_G0_INT_POL_GPIO_INT_POL_value = rightShift(data_low, 1) and &H1

    End Sub

    Sub write
        If flag_GPIO_G0_INT_POL_RESERVED_1 = &H0 or flag_GPIO_G0_INT_POL_GPIO_INT_POL = &H0 Then read
        If flag_GPIO_G0_INT_POL_RESERVED_1 = &H0 Then write_GPIO_G0_INT_POL_RESERVED_1_value = get_GPIO_G0_INT_POL_RESERVED_1
        If flag_GPIO_G0_INT_POL_GPIO_INT_POL = &H0 Then write_GPIO_G0_INT_POL_GPIO_INT_POL_value = get_GPIO_G0_INT_POL_GPIO_INT_POL

        regValue = leftShift((write_GPIO_G0_INT_POL_RESERVED_1_value and &H7), 2) + leftShift((write_GPIO_G0_INT_POL_GPIO_INT_POL_value and &H1), 1)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_GPIO_G0_INT_POL_RESERVED_1_value = rightShift(data_low, 2) and &H7
        read_GPIO_G0_INT_POL_GPIO_INT_POL_value = rightShift(data_low, 1) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_GPIO_G0_INT_POL_RESERVED_1_value = &H0
        flag_GPIO_G0_INT_POL_RESERVED_1        = &H0
        write_GPIO_G0_INT_POL_GPIO_INT_POL_value = &H0
        flag_GPIO_G0_INT_POL_GPIO_INT_POL        = &H0
    End Sub
End Class


'' @REGISTER : GIO0_gpio_g1_din
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' GPIO_DATA_IN                               [3:0]            get_GPIO_DATA_IN
''                                                             set_GPIO_DATA_IN
''                                                             read_GPIO_DATA_IN
''                                                             write_GPIO_DATA_IN
''---------------------------------------------------------------------------------
Class REGISTER_GIO0_gpio_g1_din
    Private write_GPIO_DATA_IN_value
    Private read_GPIO_DATA_IN_value
    Private flag_GPIO_DATA_IN

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

    Property Get get_GPIO_DATA_IN
        get_GPIO_DATA_IN = read_GPIO_DATA_IN_value
    End Property

    Property Let set_GPIO_DATA_IN(aData)
        write_GPIO_DATA_IN_value = aData
        flag_GPIO_DATA_IN        = &H1
    End Property

    Property Get read_GPIO_DATA_IN
        read
        read_GPIO_DATA_IN = read_GPIO_DATA_IN_value
    End Property

    Property Let write_GPIO_DATA_IN(aData)
        set_GPIO_DATA_IN = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        GPIO_DATA_IN_mask = &Hf
        if data_low > LONG_MAX then
            if GPIO_DATA_IN_mask = mask then
                read_GPIO_DATA_IN_value = data_low
            else
                read_GPIO_DATA_IN_value = (data_low - H8000_0000) and GPIO_DATA_IN_mask
            end If
        else
            read_GPIO_DATA_IN_value = data_low and GPIO_DATA_IN_mask
        end If

    End Sub

    Sub write
        If flag_GPIO_DATA_IN = &H0 Then read
        If flag_GPIO_DATA_IN = &H0 Then write_GPIO_DATA_IN_value = get_GPIO_DATA_IN

        regValue = leftShift((write_GPIO_DATA_IN_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        GPIO_DATA_IN_mask = &Hf
        if data_low > LONG_MAX then
            if GPIO_DATA_IN_mask = mask then
                read_GPIO_DATA_IN_value = data_low
            else
                read_GPIO_DATA_IN_value = (data_low - H8000_0000) and GPIO_DATA_IN_mask
            end If
        else
            read_GPIO_DATA_IN_value = data_low and GPIO_DATA_IN_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_GPIO_DATA_IN_value = &H0
        flag_GPIO_DATA_IN        = &H0
    End Sub
End Class


'' @REGISTER : GIO0_gpio_g1_dout
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' GPIO_DATA_OUT                              [3:0]            get_GPIO_DATA_OUT
''                                                             set_GPIO_DATA_OUT
''                                                             read_GPIO_DATA_OUT
''                                                             write_GPIO_DATA_OUT
''---------------------------------------------------------------------------------
Class REGISTER_GIO0_gpio_g1_dout
    Private write_GPIO_DATA_OUT_value
    Private read_GPIO_DATA_OUT_value
    Private flag_GPIO_DATA_OUT

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

    Property Get get_GPIO_DATA_OUT
        get_GPIO_DATA_OUT = read_GPIO_DATA_OUT_value
    End Property

    Property Let set_GPIO_DATA_OUT(aData)
        write_GPIO_DATA_OUT_value = aData
        flag_GPIO_DATA_OUT        = &H1
    End Property

    Property Get read_GPIO_DATA_OUT
        read
        read_GPIO_DATA_OUT = read_GPIO_DATA_OUT_value
    End Property

    Property Let write_GPIO_DATA_OUT(aData)
        set_GPIO_DATA_OUT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        GPIO_DATA_OUT_mask = &Hf
        if data_low > LONG_MAX then
            if GPIO_DATA_OUT_mask = mask then
                read_GPIO_DATA_OUT_value = data_low
            else
                read_GPIO_DATA_OUT_value = (data_low - H8000_0000) and GPIO_DATA_OUT_mask
            end If
        else
            read_GPIO_DATA_OUT_value = data_low and GPIO_DATA_OUT_mask
        end If

    End Sub

    Sub write
        If flag_GPIO_DATA_OUT = &H0 Then read
        If flag_GPIO_DATA_OUT = &H0 Then write_GPIO_DATA_OUT_value = get_GPIO_DATA_OUT

        regValue = leftShift((write_GPIO_DATA_OUT_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        GPIO_DATA_OUT_mask = &Hf
        if data_low > LONG_MAX then
            if GPIO_DATA_OUT_mask = mask then
                read_GPIO_DATA_OUT_value = data_low
            else
                read_GPIO_DATA_OUT_value = (data_low - H8000_0000) and GPIO_DATA_OUT_mask
            end If
        else
            read_GPIO_DATA_OUT_value = data_low and GPIO_DATA_OUT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_GPIO_DATA_OUT_value = &H0
        flag_GPIO_DATA_OUT        = &H0
    End Sub
End Class


'' @REGISTER : GIO0_gpio_g1_drv_en
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' GPIO_DRV_EN                                [3:0]            get_GPIO_DRV_EN
''                                                             set_GPIO_DRV_EN
''                                                             read_GPIO_DRV_EN
''                                                             write_GPIO_DRV_EN
''---------------------------------------------------------------------------------
Class REGISTER_GIO0_gpio_g1_drv_en
    Private write_GPIO_DRV_EN_value
    Private read_GPIO_DRV_EN_value
    Private flag_GPIO_DRV_EN

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

    Property Get get_GPIO_DRV_EN
        get_GPIO_DRV_EN = read_GPIO_DRV_EN_value
    End Property

    Property Let set_GPIO_DRV_EN(aData)
        write_GPIO_DRV_EN_value = aData
        flag_GPIO_DRV_EN        = &H1
    End Property

    Property Get read_GPIO_DRV_EN
        read
        read_GPIO_DRV_EN = read_GPIO_DRV_EN_value
    End Property

    Property Let write_GPIO_DRV_EN(aData)
        set_GPIO_DRV_EN = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        GPIO_DRV_EN_mask = &Hf
        if data_low > LONG_MAX then
            if GPIO_DRV_EN_mask = mask then
                read_GPIO_DRV_EN_value = data_low
            else
                read_GPIO_DRV_EN_value = (data_low - H8000_0000) and GPIO_DRV_EN_mask
            end If
        else
            read_GPIO_DRV_EN_value = data_low and GPIO_DRV_EN_mask
        end If

    End Sub

    Sub write
        If flag_GPIO_DRV_EN = &H0 Then read
        If flag_GPIO_DRV_EN = &H0 Then write_GPIO_DRV_EN_value = get_GPIO_DRV_EN

        regValue = leftShift((write_GPIO_DRV_EN_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        GPIO_DRV_EN_mask = &Hf
        if data_low > LONG_MAX then
            if GPIO_DRV_EN_mask = mask then
                read_GPIO_DRV_EN_value = data_low
            else
                read_GPIO_DRV_EN_value = (data_low - H8000_0000) and GPIO_DRV_EN_mask
            end If
        else
            read_GPIO_DRV_EN_value = data_low and GPIO_DRV_EN_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_GPIO_DRV_EN_value = &H0
        flag_GPIO_DRV_EN        = &H0
    End Sub
End Class


'' @REGISTER : GIO0_gpio_g1_int_typ
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' GPIO_INT_TYP                               [3:0]            get_GPIO_INT_TYP
''                                                             set_GPIO_INT_TYP
''                                                             read_GPIO_INT_TYP
''                                                             write_GPIO_INT_TYP
''---------------------------------------------------------------------------------
Class REGISTER_GIO0_gpio_g1_int_typ
    Private write_GPIO_INT_TYP_value
    Private read_GPIO_INT_TYP_value
    Private flag_GPIO_INT_TYP

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

    Property Get get_GPIO_INT_TYP
        get_GPIO_INT_TYP = read_GPIO_INT_TYP_value
    End Property

    Property Let set_GPIO_INT_TYP(aData)
        write_GPIO_INT_TYP_value = aData
        flag_GPIO_INT_TYP        = &H1
    End Property

    Property Get read_GPIO_INT_TYP
        read
        read_GPIO_INT_TYP = read_GPIO_INT_TYP_value
    End Property

    Property Let write_GPIO_INT_TYP(aData)
        set_GPIO_INT_TYP = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        GPIO_INT_TYP_mask = &Hf
        if data_low > LONG_MAX then
            if GPIO_INT_TYP_mask = mask then
                read_GPIO_INT_TYP_value = data_low
            else
                read_GPIO_INT_TYP_value = (data_low - H8000_0000) and GPIO_INT_TYP_mask
            end If
        else
            read_GPIO_INT_TYP_value = data_low and GPIO_INT_TYP_mask
        end If

    End Sub

    Sub write
        If flag_GPIO_INT_TYP = &H0 Then read
        If flag_GPIO_INT_TYP = &H0 Then write_GPIO_INT_TYP_value = get_GPIO_INT_TYP

        regValue = leftShift((write_GPIO_INT_TYP_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        GPIO_INT_TYP_mask = &Hf
        if data_low > LONG_MAX then
            if GPIO_INT_TYP_mask = mask then
                read_GPIO_INT_TYP_value = data_low
            else
                read_GPIO_INT_TYP_value = (data_low - H8000_0000) and GPIO_INT_TYP_mask
            end If
        else
            read_GPIO_INT_TYP_value = data_low and GPIO_INT_TYP_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_GPIO_INT_TYP_value = &H0
        flag_GPIO_INT_TYP        = &H0
    End Sub
End Class


'' @REGISTER : GIO0_gpio_g1_int_du_edg
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' GPIO_INT_DU_EDGE                           [3:0]            get_GPIO_INT_DU_EDGE
''                                                             set_GPIO_INT_DU_EDGE
''                                                             read_GPIO_INT_DU_EDGE
''                                                             write_GPIO_INT_DU_EDGE
''---------------------------------------------------------------------------------
Class REGISTER_GIO0_gpio_g1_int_du_edg
    Private write_GPIO_INT_DU_EDGE_value
    Private read_GPIO_INT_DU_EDGE_value
    Private flag_GPIO_INT_DU_EDGE

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

    Property Get get_GPIO_INT_DU_EDGE
        get_GPIO_INT_DU_EDGE = read_GPIO_INT_DU_EDGE_value
    End Property

    Property Let set_GPIO_INT_DU_EDGE(aData)
        write_GPIO_INT_DU_EDGE_value = aData
        flag_GPIO_INT_DU_EDGE        = &H1
    End Property

    Property Get read_GPIO_INT_DU_EDGE
        read
        read_GPIO_INT_DU_EDGE = read_GPIO_INT_DU_EDGE_value
    End Property

    Property Let write_GPIO_INT_DU_EDGE(aData)
        set_GPIO_INT_DU_EDGE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        GPIO_INT_DU_EDGE_mask = &Hf
        if data_low > LONG_MAX then
            if GPIO_INT_DU_EDGE_mask = mask then
                read_GPIO_INT_DU_EDGE_value = data_low
            else
                read_GPIO_INT_DU_EDGE_value = (data_low - H8000_0000) and GPIO_INT_DU_EDGE_mask
            end If
        else
            read_GPIO_INT_DU_EDGE_value = data_low and GPIO_INT_DU_EDGE_mask
        end If

    End Sub

    Sub write
        If flag_GPIO_INT_DU_EDGE = &H0 Then read
        If flag_GPIO_INT_DU_EDGE = &H0 Then write_GPIO_INT_DU_EDGE_value = get_GPIO_INT_DU_EDGE

        regValue = leftShift((write_GPIO_INT_DU_EDGE_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        GPIO_INT_DU_EDGE_mask = &Hf
        if data_low > LONG_MAX then
            if GPIO_INT_DU_EDGE_mask = mask then
                read_GPIO_INT_DU_EDGE_value = data_low
            else
                read_GPIO_INT_DU_EDGE_value = (data_low - H8000_0000) and GPIO_INT_DU_EDGE_mask
            end If
        else
            read_GPIO_INT_DU_EDGE_value = data_low and GPIO_INT_DU_EDGE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_GPIO_INT_DU_EDGE_value = &H0
        flag_GPIO_INT_DU_EDGE        = &H0
    End Sub
End Class


'' @REGISTER : GIO0_gpio_g1_int_edg_lvl_sel
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' GPIO_INT_EDGE                              [3:0]            get_GPIO_INT_EDGE
''                                                             set_GPIO_INT_EDGE
''                                                             read_GPIO_INT_EDGE
''                                                             write_GPIO_INT_EDGE
''---------------------------------------------------------------------------------
Class REGISTER_GIO0_gpio_g1_int_edg_lvl_sel
    Private write_GPIO_INT_EDGE_value
    Private read_GPIO_INT_EDGE_value
    Private flag_GPIO_INT_EDGE

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

    Property Get get_GPIO_INT_EDGE
        get_GPIO_INT_EDGE = read_GPIO_INT_EDGE_value
    End Property

    Property Let set_GPIO_INT_EDGE(aData)
        write_GPIO_INT_EDGE_value = aData
        flag_GPIO_INT_EDGE        = &H1
    End Property

    Property Get read_GPIO_INT_EDGE
        read
        read_GPIO_INT_EDGE = read_GPIO_INT_EDGE_value
    End Property

    Property Let write_GPIO_INT_EDGE(aData)
        set_GPIO_INT_EDGE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        GPIO_INT_EDGE_mask = &Hf
        if data_low > LONG_MAX then
            if GPIO_INT_EDGE_mask = mask then
                read_GPIO_INT_EDGE_value = data_low
            else
                read_GPIO_INT_EDGE_value = (data_low - H8000_0000) and GPIO_INT_EDGE_mask
            end If
        else
            read_GPIO_INT_EDGE_value = data_low and GPIO_INT_EDGE_mask
        end If

    End Sub

    Sub write
        If flag_GPIO_INT_EDGE = &H0 Then read
        If flag_GPIO_INT_EDGE = &H0 Then write_GPIO_INT_EDGE_value = get_GPIO_INT_EDGE

        regValue = leftShift((write_GPIO_INT_EDGE_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        GPIO_INT_EDGE_mask = &Hf
        if data_low > LONG_MAX then
            if GPIO_INT_EDGE_mask = mask then
                read_GPIO_INT_EDGE_value = data_low
            else
                read_GPIO_INT_EDGE_value = (data_low - H8000_0000) and GPIO_INT_EDGE_mask
            end If
        else
            read_GPIO_INT_EDGE_value = data_low and GPIO_INT_EDGE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_GPIO_INT_EDGE_value = &H0
        flag_GPIO_INT_EDGE        = &H0
    End Sub
End Class


'' @REGISTER : GIO0_gpio_g1_int_msk
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' GPIO_INT_MSK                               [3:0]            get_GPIO_INT_MSK
''                                                             set_GPIO_INT_MSK
''                                                             read_GPIO_INT_MSK
''                                                             write_GPIO_INT_MSK
''---------------------------------------------------------------------------------
Class REGISTER_GIO0_gpio_g1_int_msk
    Private write_GPIO_INT_MSK_value
    Private read_GPIO_INT_MSK_value
    Private flag_GPIO_INT_MSK

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

    Property Get get_GPIO_INT_MSK
        get_GPIO_INT_MSK = read_GPIO_INT_MSK_value
    End Property

    Property Let set_GPIO_INT_MSK(aData)
        write_GPIO_INT_MSK_value = aData
        flag_GPIO_INT_MSK        = &H1
    End Property

    Property Get read_GPIO_INT_MSK
        read
        read_GPIO_INT_MSK = read_GPIO_INT_MSK_value
    End Property

    Property Let write_GPIO_INT_MSK(aData)
        set_GPIO_INT_MSK = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        GPIO_INT_MSK_mask = &Hf
        if data_low > LONG_MAX then
            if GPIO_INT_MSK_mask = mask then
                read_GPIO_INT_MSK_value = data_low
            else
                read_GPIO_INT_MSK_value = (data_low - H8000_0000) and GPIO_INT_MSK_mask
            end If
        else
            read_GPIO_INT_MSK_value = data_low and GPIO_INT_MSK_mask
        end If

    End Sub

    Sub write
        If flag_GPIO_INT_MSK = &H0 Then read
        If flag_GPIO_INT_MSK = &H0 Then write_GPIO_INT_MSK_value = get_GPIO_INT_MSK

        regValue = leftShift((write_GPIO_INT_MSK_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        GPIO_INT_MSK_mask = &Hf
        if data_low > LONG_MAX then
            if GPIO_INT_MSK_mask = mask then
                read_GPIO_INT_MSK_value = data_low
            else
                read_GPIO_INT_MSK_value = (data_low - H8000_0000) and GPIO_INT_MSK_mask
            end If
        else
            read_GPIO_INT_MSK_value = data_low and GPIO_INT_MSK_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_GPIO_INT_MSK_value = &H0
        flag_GPIO_INT_MSK        = &H0
    End Sub
End Class


'' @REGISTER : GIO0_gpio_g1_int_sts
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' GPIO_INT_STS                               [3:0]            get_GPIO_INT_STS
''                                                             set_GPIO_INT_STS
''                                                             read_GPIO_INT_STS
''                                                             write_GPIO_INT_STS
''---------------------------------------------------------------------------------
Class REGISTER_GIO0_gpio_g1_int_sts
    Private write_GPIO_INT_STS_value
    Private read_GPIO_INT_STS_value
    Private flag_GPIO_INT_STS

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

    Property Get get_GPIO_INT_STS
        get_GPIO_INT_STS = read_GPIO_INT_STS_value
    End Property

    Property Let set_GPIO_INT_STS(aData)
        write_GPIO_INT_STS_value = aData
        flag_GPIO_INT_STS        = &H1
    End Property

    Property Get read_GPIO_INT_STS
        read
        read_GPIO_INT_STS = read_GPIO_INT_STS_value
    End Property

    Property Let write_GPIO_INT_STS(aData)
        set_GPIO_INT_STS = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        GPIO_INT_STS_mask = &Hf
        if data_low > LONG_MAX then
            if GPIO_INT_STS_mask = mask then
                read_GPIO_INT_STS_value = data_low
            else
                read_GPIO_INT_STS_value = (data_low - H8000_0000) and GPIO_INT_STS_mask
            end If
        else
            read_GPIO_INT_STS_value = data_low and GPIO_INT_STS_mask
        end If

    End Sub

    Sub write
        If flag_GPIO_INT_STS = &H0 Then read
        If flag_GPIO_INT_STS = &H0 Then write_GPIO_INT_STS_value = get_GPIO_INT_STS

        regValue = leftShift((write_GPIO_INT_STS_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        GPIO_INT_STS_mask = &Hf
        if data_low > LONG_MAX then
            if GPIO_INT_STS_mask = mask then
                read_GPIO_INT_STS_value = data_low
            else
                read_GPIO_INT_STS_value = (data_low - H8000_0000) and GPIO_INT_STS_mask
            end If
        else
            read_GPIO_INT_STS_value = data_low and GPIO_INT_STS_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_GPIO_INT_STS_value = &H0
        flag_GPIO_INT_STS        = &H0
    End Sub
End Class


'' @REGISTER : GIO0_gpio_g1_int_msk_sts
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' GPIO_INT_MSK_STS                           [3:0]            get_GPIO_INT_MSK_STS
''                                                             set_GPIO_INT_MSK_STS
''                                                             read_GPIO_INT_MSK_STS
''                                                             write_GPIO_INT_MSK_STS
''---------------------------------------------------------------------------------
Class REGISTER_GIO0_gpio_g1_int_msk_sts
    Private write_GPIO_INT_MSK_STS_value
    Private read_GPIO_INT_MSK_STS_value
    Private flag_GPIO_INT_MSK_STS

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

    Property Get get_GPIO_INT_MSK_STS
        get_GPIO_INT_MSK_STS = read_GPIO_INT_MSK_STS_value
    End Property

    Property Let set_GPIO_INT_MSK_STS(aData)
        write_GPIO_INT_MSK_STS_value = aData
        flag_GPIO_INT_MSK_STS        = &H1
    End Property

    Property Get read_GPIO_INT_MSK_STS
        read
        read_GPIO_INT_MSK_STS = read_GPIO_INT_MSK_STS_value
    End Property

    Property Let write_GPIO_INT_MSK_STS(aData)
        set_GPIO_INT_MSK_STS = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        GPIO_INT_MSK_STS_mask = &Hf
        if data_low > LONG_MAX then
            if GPIO_INT_MSK_STS_mask = mask then
                read_GPIO_INT_MSK_STS_value = data_low
            else
                read_GPIO_INT_MSK_STS_value = (data_low - H8000_0000) and GPIO_INT_MSK_STS_mask
            end If
        else
            read_GPIO_INT_MSK_STS_value = data_low and GPIO_INT_MSK_STS_mask
        end If

    End Sub

    Sub write
        If flag_GPIO_INT_MSK_STS = &H0 Then read
        If flag_GPIO_INT_MSK_STS = &H0 Then write_GPIO_INT_MSK_STS_value = get_GPIO_INT_MSK_STS

        regValue = leftShift((write_GPIO_INT_MSK_STS_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        GPIO_INT_MSK_STS_mask = &Hf
        if data_low > LONG_MAX then
            if GPIO_INT_MSK_STS_mask = mask then
                read_GPIO_INT_MSK_STS_value = data_low
            else
                read_GPIO_INT_MSK_STS_value = (data_low - H8000_0000) and GPIO_INT_MSK_STS_mask
            end If
        else
            read_GPIO_INT_MSK_STS_value = data_low and GPIO_INT_MSK_STS_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_GPIO_INT_MSK_STS_value = &H0
        flag_GPIO_INT_MSK_STS        = &H0
    End Sub
End Class


'' @REGISTER : GIO0_gpio_g1_int_clr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' GPIO_INT_CLR                               [3:0]            get_GPIO_INT_CLR
''                                                             set_GPIO_INT_CLR
''                                                             read_GPIO_INT_CLR
''                                                             write_GPIO_INT_CLR
''---------------------------------------------------------------------------------
Class REGISTER_GIO0_gpio_g1_int_clr
    Private write_GPIO_INT_CLR_value
    Private read_GPIO_INT_CLR_value
    Private flag_GPIO_INT_CLR

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

    Property Get get_GPIO_INT_CLR
        get_GPIO_INT_CLR = read_GPIO_INT_CLR_value
    End Property

    Property Let set_GPIO_INT_CLR(aData)
        write_GPIO_INT_CLR_value = aData
        flag_GPIO_INT_CLR        = &H1
    End Property

    Property Get read_GPIO_INT_CLR
        read
        read_GPIO_INT_CLR = read_GPIO_INT_CLR_value
    End Property

    Property Let write_GPIO_INT_CLR(aData)
        set_GPIO_INT_CLR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        GPIO_INT_CLR_mask = &Hf
        if data_low > LONG_MAX then
            if GPIO_INT_CLR_mask = mask then
                read_GPIO_INT_CLR_value = data_low
            else
                read_GPIO_INT_CLR_value = (data_low - H8000_0000) and GPIO_INT_CLR_mask
            end If
        else
            read_GPIO_INT_CLR_value = data_low and GPIO_INT_CLR_mask
        end If

    End Sub

    Sub write
        If flag_GPIO_INT_CLR = &H0 Then read
        If flag_GPIO_INT_CLR = &H0 Then write_GPIO_INT_CLR_value = get_GPIO_INT_CLR

        regValue = leftShift((write_GPIO_INT_CLR_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        GPIO_INT_CLR_mask = &Hf
        if data_low > LONG_MAX then
            if GPIO_INT_CLR_mask = mask then
                read_GPIO_INT_CLR_value = data_low
            else
                read_GPIO_INT_CLR_value = (data_low - H8000_0000) and GPIO_INT_CLR_mask
            end If
        else
            read_GPIO_INT_CLR_value = data_low and GPIO_INT_CLR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_GPIO_INT_CLR_value = &H0
        flag_GPIO_INT_CLR        = &H0
    End Sub
End Class


'' @REGISTER : GIO0_gpio_g1_pwm_sel
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' GPIO_PWM_MUX_SEL                           [3:0]            get_GPIO_PWM_MUX_SEL
''                                                             set_GPIO_PWM_MUX_SEL
''                                                             read_GPIO_PWM_MUX_SEL
''                                                             write_GPIO_PWM_MUX_SEL
''---------------------------------------------------------------------------------
Class REGISTER_GIO0_gpio_g1_pwm_sel
    Private write_GPIO_PWM_MUX_SEL_value
    Private read_GPIO_PWM_MUX_SEL_value
    Private flag_GPIO_PWM_MUX_SEL

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

    Property Get get_GPIO_PWM_MUX_SEL
        get_GPIO_PWM_MUX_SEL = read_GPIO_PWM_MUX_SEL_value
    End Property

    Property Let set_GPIO_PWM_MUX_SEL(aData)
        write_GPIO_PWM_MUX_SEL_value = aData
        flag_GPIO_PWM_MUX_SEL        = &H1
    End Property

    Property Get read_GPIO_PWM_MUX_SEL
        read
        read_GPIO_PWM_MUX_SEL = read_GPIO_PWM_MUX_SEL_value
    End Property

    Property Let write_GPIO_PWM_MUX_SEL(aData)
        set_GPIO_PWM_MUX_SEL = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        GPIO_PWM_MUX_SEL_mask = &Hf
        if data_low > LONG_MAX then
            if GPIO_PWM_MUX_SEL_mask = mask then
                read_GPIO_PWM_MUX_SEL_value = data_low
            else
                read_GPIO_PWM_MUX_SEL_value = (data_low - H8000_0000) and GPIO_PWM_MUX_SEL_mask
            end If
        else
            read_GPIO_PWM_MUX_SEL_value = data_low and GPIO_PWM_MUX_SEL_mask
        end If

    End Sub

    Sub write
        If flag_GPIO_PWM_MUX_SEL = &H0 Then read
        If flag_GPIO_PWM_MUX_SEL = &H0 Then write_GPIO_PWM_MUX_SEL_value = get_GPIO_PWM_MUX_SEL

        regValue = leftShift((write_GPIO_PWM_MUX_SEL_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        GPIO_PWM_MUX_SEL_mask = &Hf
        if data_low > LONG_MAX then
            if GPIO_PWM_MUX_SEL_mask = mask then
                read_GPIO_PWM_MUX_SEL_value = data_low
            else
                read_GPIO_PWM_MUX_SEL_value = (data_low - H8000_0000) and GPIO_PWM_MUX_SEL_mask
            end If
        else
            read_GPIO_PWM_MUX_SEL_value = data_low and GPIO_PWM_MUX_SEL_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_GPIO_PWM_MUX_SEL_value = &H0
        flag_GPIO_PWM_MUX_SEL        = &H0
    End Sub
End Class


'' @REGISTER : GIO0_gpio_g1_sec_cfg
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' GPIO_SEC_CFG                               [4:0]            get_GPIO_SEC_CFG
''                                                             set_GPIO_SEC_CFG
''                                                             read_GPIO_SEC_CFG
''                                                             write_GPIO_SEC_CFG
''---------------------------------------------------------------------------------
Class REGISTER_GIO0_gpio_g1_sec_cfg
    Private write_GPIO_SEC_CFG_value
    Private read_GPIO_SEC_CFG_value
    Private flag_GPIO_SEC_CFG

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

    Property Get get_GPIO_SEC_CFG
        get_GPIO_SEC_CFG = read_GPIO_SEC_CFG_value
    End Property

    Property Let set_GPIO_SEC_CFG(aData)
        write_GPIO_SEC_CFG_value = aData
        flag_GPIO_SEC_CFG        = &H1
    End Property

    Property Get read_GPIO_SEC_CFG
        read
        read_GPIO_SEC_CFG = read_GPIO_SEC_CFG_value
    End Property

    Property Let write_GPIO_SEC_CFG(aData)
        set_GPIO_SEC_CFG = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        GPIO_SEC_CFG_mask = &H1f
        if data_low > LONG_MAX then
            if GPIO_SEC_CFG_mask = mask then
                read_GPIO_SEC_CFG_value = data_low
            else
                read_GPIO_SEC_CFG_value = (data_low - H8000_0000) and GPIO_SEC_CFG_mask
            end If
        else
            read_GPIO_SEC_CFG_value = data_low and GPIO_SEC_CFG_mask
        end If

    End Sub

    Sub write
        If flag_GPIO_SEC_CFG = &H0 Then read
        If flag_GPIO_SEC_CFG = &H0 Then write_GPIO_SEC_CFG_value = get_GPIO_SEC_CFG

        regValue = leftShift((write_GPIO_SEC_CFG_value and &H1f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        GPIO_SEC_CFG_mask = &H1f
        if data_low > LONG_MAX then
            if GPIO_SEC_CFG_mask = mask then
                read_GPIO_SEC_CFG_value = data_low
            else
                read_GPIO_SEC_CFG_value = (data_low - H8000_0000) and GPIO_SEC_CFG_mask
            end If
        else
            read_GPIO_SEC_CFG_value = data_low and GPIO_SEC_CFG_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_GPIO_SEC_CFG_value = &H0
        flag_GPIO_SEC_CFG        = &H0
    End Sub
End Class


'' @REGISTER : GIO0_gpio_g1_init
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' GPIO_INIT_VAL                              [3:0]            get_GPIO_INIT_VAL
''                                                             set_GPIO_INIT_VAL
''                                                             read_GPIO_INIT_VAL
''                                                             write_GPIO_INIT_VAL
''---------------------------------------------------------------------------------
Class REGISTER_GIO0_gpio_g1_init
    Private write_GPIO_INIT_VAL_value
    Private read_GPIO_INIT_VAL_value
    Private flag_GPIO_INIT_VAL

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

    Property Get get_GPIO_INIT_VAL
        get_GPIO_INIT_VAL = read_GPIO_INIT_VAL_value
    End Property

    Property Let set_GPIO_INIT_VAL(aData)
        write_GPIO_INIT_VAL_value = aData
        flag_GPIO_INIT_VAL        = &H1
    End Property

    Property Get read_GPIO_INIT_VAL
        read
        read_GPIO_INIT_VAL = read_GPIO_INIT_VAL_value
    End Property

    Property Let write_GPIO_INIT_VAL(aData)
        set_GPIO_INIT_VAL = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        GPIO_INIT_VAL_mask = &Hf
        if data_low > LONG_MAX then
            if GPIO_INIT_VAL_mask = mask then
                read_GPIO_INIT_VAL_value = data_low
            else
                read_GPIO_INIT_VAL_value = (data_low - H8000_0000) and GPIO_INIT_VAL_mask
            end If
        else
            read_GPIO_INIT_VAL_value = data_low and GPIO_INIT_VAL_mask
        end If

    End Sub

    Sub write
        If flag_GPIO_INIT_VAL = &H0 Then read
        If flag_GPIO_INIT_VAL = &H0 Then write_GPIO_INIT_VAL_value = get_GPIO_INIT_VAL

        regValue = leftShift((write_GPIO_INIT_VAL_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        GPIO_INIT_VAL_mask = &Hf
        if data_low > LONG_MAX then
            if GPIO_INIT_VAL_mask = mask then
                read_GPIO_INIT_VAL_value = data_low
            else
                read_GPIO_INIT_VAL_value = (data_low - H8000_0000) and GPIO_INIT_VAL_mask
            end If
        else
            read_GPIO_INIT_VAL_value = data_low and GPIO_INIT_VAL_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_GPIO_INIT_VAL_value = &H0
        flag_GPIO_INIT_VAL        = &H0
    End Sub
End Class


'' @REGISTER : GIO0_gpio_g1_pad_res
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' GPIO_PAD_RES                               [3:0]            get_GPIO_PAD_RES
''                                                             set_GPIO_PAD_RES
''                                                             read_GPIO_PAD_RES
''                                                             write_GPIO_PAD_RES
''---------------------------------------------------------------------------------
Class REGISTER_GIO0_gpio_g1_pad_res
    Private write_GPIO_PAD_RES_value
    Private read_GPIO_PAD_RES_value
    Private flag_GPIO_PAD_RES

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

    Property Get get_GPIO_PAD_RES
        get_GPIO_PAD_RES = read_GPIO_PAD_RES_value
    End Property

    Property Let set_GPIO_PAD_RES(aData)
        write_GPIO_PAD_RES_value = aData
        flag_GPIO_PAD_RES        = &H1
    End Property

    Property Get read_GPIO_PAD_RES
        read
        read_GPIO_PAD_RES = read_GPIO_PAD_RES_value
    End Property

    Property Let write_GPIO_PAD_RES(aData)
        set_GPIO_PAD_RES = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        GPIO_PAD_RES_mask = &Hf
        if data_low > LONG_MAX then
            if GPIO_PAD_RES_mask = mask then
                read_GPIO_PAD_RES_value = data_low
            else
                read_GPIO_PAD_RES_value = (data_low - H8000_0000) and GPIO_PAD_RES_mask
            end If
        else
            read_GPIO_PAD_RES_value = data_low and GPIO_PAD_RES_mask
        end If

    End Sub

    Sub write
        If flag_GPIO_PAD_RES = &H0 Then read
        If flag_GPIO_PAD_RES = &H0 Then write_GPIO_PAD_RES_value = get_GPIO_PAD_RES

        regValue = leftShift((write_GPIO_PAD_RES_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        GPIO_PAD_RES_mask = &Hf
        if data_low > LONG_MAX then
            if GPIO_PAD_RES_mask = mask then
                read_GPIO_PAD_RES_value = data_low
            else
                read_GPIO_PAD_RES_value = (data_low - H8000_0000) and GPIO_PAD_RES_mask
            end If
        else
            read_GPIO_PAD_RES_value = data_low and GPIO_PAD_RES_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_GPIO_PAD_RES_value = &H0
        flag_GPIO_PAD_RES        = &H0
    End Sub
End Class


'' @REGISTER : GIO0_gpio_g1_pad_resis_en
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' GPIO_PAD_RESIS_EN                          [3:0]            get_GPIO_PAD_RESIS_EN
''                                                             set_GPIO_PAD_RESIS_EN
''                                                             read_GPIO_PAD_RESIS_EN
''                                                             write_GPIO_PAD_RESIS_EN
''---------------------------------------------------------------------------------
Class REGISTER_GIO0_gpio_g1_pad_resis_en
    Private write_GPIO_PAD_RESIS_EN_value
    Private read_GPIO_PAD_RESIS_EN_value
    Private flag_GPIO_PAD_RESIS_EN

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

    Property Get get_GPIO_PAD_RESIS_EN
        get_GPIO_PAD_RESIS_EN = read_GPIO_PAD_RESIS_EN_value
    End Property

    Property Let set_GPIO_PAD_RESIS_EN(aData)
        write_GPIO_PAD_RESIS_EN_value = aData
        flag_GPIO_PAD_RESIS_EN        = &H1
    End Property

    Property Get read_GPIO_PAD_RESIS_EN
        read
        read_GPIO_PAD_RESIS_EN = read_GPIO_PAD_RESIS_EN_value
    End Property

    Property Let write_GPIO_PAD_RESIS_EN(aData)
        set_GPIO_PAD_RESIS_EN = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        GPIO_PAD_RESIS_EN_mask = &Hf
        if data_low > LONG_MAX then
            if GPIO_PAD_RESIS_EN_mask = mask then
                read_GPIO_PAD_RESIS_EN_value = data_low
            else
                read_GPIO_PAD_RESIS_EN_value = (data_low - H8000_0000) and GPIO_PAD_RESIS_EN_mask
            end If
        else
            read_GPIO_PAD_RESIS_EN_value = data_low and GPIO_PAD_RESIS_EN_mask
        end If

    End Sub

    Sub write
        If flag_GPIO_PAD_RESIS_EN = &H0 Then read
        If flag_GPIO_PAD_RESIS_EN = &H0 Then write_GPIO_PAD_RESIS_EN_value = get_GPIO_PAD_RESIS_EN

        regValue = leftShift((write_GPIO_PAD_RESIS_EN_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        GPIO_PAD_RESIS_EN_mask = &Hf
        if data_low > LONG_MAX then
            if GPIO_PAD_RESIS_EN_mask = mask then
                read_GPIO_PAD_RESIS_EN_value = data_low
            else
                read_GPIO_PAD_RESIS_EN_value = (data_low - H8000_0000) and GPIO_PAD_RESIS_EN_mask
            end If
        else
            read_GPIO_PAD_RESIS_EN_value = data_low and GPIO_PAD_RESIS_EN_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_GPIO_PAD_RESIS_EN_value = &H0
        flag_GPIO_PAD_RESIS_EN        = &H0
    End Sub
End Class


'' @REGISTER : GIO0_gpio_g1_tst_in
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' GPIO_TST_IN                                [3:0]            get_GPIO_TST_IN
''                                                             set_GPIO_TST_IN
''                                                             read_GPIO_TST_IN
''                                                             write_GPIO_TST_IN
''---------------------------------------------------------------------------------
Class REGISTER_GIO0_gpio_g1_tst_in
    Private write_GPIO_TST_IN_value
    Private read_GPIO_TST_IN_value
    Private flag_GPIO_TST_IN

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

    Property Get get_GPIO_TST_IN
        get_GPIO_TST_IN = read_GPIO_TST_IN_value
    End Property

    Property Let set_GPIO_TST_IN(aData)
        write_GPIO_TST_IN_value = aData
        flag_GPIO_TST_IN        = &H1
    End Property

    Property Get read_GPIO_TST_IN
        read
        read_GPIO_TST_IN = read_GPIO_TST_IN_value
    End Property

    Property Let write_GPIO_TST_IN(aData)
        set_GPIO_TST_IN = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        GPIO_TST_IN_mask = &Hf
        if data_low > LONG_MAX then
            if GPIO_TST_IN_mask = mask then
                read_GPIO_TST_IN_value = data_low
            else
                read_GPIO_TST_IN_value = (data_low - H8000_0000) and GPIO_TST_IN_mask
            end If
        else
            read_GPIO_TST_IN_value = data_low and GPIO_TST_IN_mask
        end If

    End Sub

    Sub write
        If flag_GPIO_TST_IN = &H0 Then read
        If flag_GPIO_TST_IN = &H0 Then write_GPIO_TST_IN_value = get_GPIO_TST_IN

        regValue = leftShift((write_GPIO_TST_IN_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        GPIO_TST_IN_mask = &Hf
        if data_low > LONG_MAX then
            if GPIO_TST_IN_mask = mask then
                read_GPIO_TST_IN_value = data_low
            else
                read_GPIO_TST_IN_value = (data_low - H8000_0000) and GPIO_TST_IN_mask
            end If
        else
            read_GPIO_TST_IN_value = data_low and GPIO_TST_IN_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_GPIO_TST_IN_value = &H0
        flag_GPIO_TST_IN        = &H0
    End Sub
End Class


'' @REGISTER : GIO0_gpio_g1_tst_out
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' GPIO_TST_OUT                               [3:0]            get_GPIO_TST_OUT
''                                                             set_GPIO_TST_OUT
''                                                             read_GPIO_TST_OUT
''                                                             write_GPIO_TST_OUT
''---------------------------------------------------------------------------------
Class REGISTER_GIO0_gpio_g1_tst_out
    Private write_GPIO_TST_OUT_value
    Private read_GPIO_TST_OUT_value
    Private flag_GPIO_TST_OUT

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

    Property Get get_GPIO_TST_OUT
        get_GPIO_TST_OUT = read_GPIO_TST_OUT_value
    End Property

    Property Let set_GPIO_TST_OUT(aData)
        write_GPIO_TST_OUT_value = aData
        flag_GPIO_TST_OUT        = &H1
    End Property

    Property Get read_GPIO_TST_OUT
        read
        read_GPIO_TST_OUT = read_GPIO_TST_OUT_value
    End Property

    Property Let write_GPIO_TST_OUT(aData)
        set_GPIO_TST_OUT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        GPIO_TST_OUT_mask = &Hf
        if data_low > LONG_MAX then
            if GPIO_TST_OUT_mask = mask then
                read_GPIO_TST_OUT_value = data_low
            else
                read_GPIO_TST_OUT_value = (data_low - H8000_0000) and GPIO_TST_OUT_mask
            end If
        else
            read_GPIO_TST_OUT_value = data_low and GPIO_TST_OUT_mask
        end If

    End Sub

    Sub write
        If flag_GPIO_TST_OUT = &H0 Then read
        If flag_GPIO_TST_OUT = &H0 Then write_GPIO_TST_OUT_value = get_GPIO_TST_OUT

        regValue = leftShift((write_GPIO_TST_OUT_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        GPIO_TST_OUT_mask = &Hf
        if data_low > LONG_MAX then
            if GPIO_TST_OUT_mask = mask then
                read_GPIO_TST_OUT_value = data_low
            else
                read_GPIO_TST_OUT_value = (data_low - H8000_0000) and GPIO_TST_OUT_mask
            end If
        else
            read_GPIO_TST_OUT_value = data_low and GPIO_TST_OUT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_GPIO_TST_OUT_value = &H0
        flag_GPIO_TST_OUT        = &H0
    End Sub
End Class


'' @REGISTER : GIO0_gpio_g1_tst_in_en
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' GPIO_TST_EN                                [3:0]            get_GPIO_TST_EN
''                                                             set_GPIO_TST_EN
''                                                             read_GPIO_TST_EN
''                                                             write_GPIO_TST_EN
''---------------------------------------------------------------------------------
Class REGISTER_GIO0_gpio_g1_tst_in_en
    Private write_GPIO_TST_EN_value
    Private read_GPIO_TST_EN_value
    Private flag_GPIO_TST_EN

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

    Property Get get_GPIO_TST_EN
        get_GPIO_TST_EN = read_GPIO_TST_EN_value
    End Property

    Property Let set_GPIO_TST_EN(aData)
        write_GPIO_TST_EN_value = aData
        flag_GPIO_TST_EN        = &H1
    End Property

    Property Get read_GPIO_TST_EN
        read
        read_GPIO_TST_EN = read_GPIO_TST_EN_value
    End Property

    Property Let write_GPIO_TST_EN(aData)
        set_GPIO_TST_EN = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        GPIO_TST_EN_mask = &Hf
        if data_low > LONG_MAX then
            if GPIO_TST_EN_mask = mask then
                read_GPIO_TST_EN_value = data_low
            else
                read_GPIO_TST_EN_value = (data_low - H8000_0000) and GPIO_TST_EN_mask
            end If
        else
            read_GPIO_TST_EN_value = data_low and GPIO_TST_EN_mask
        end If

    End Sub

    Sub write
        If flag_GPIO_TST_EN = &H0 Then read
        If flag_GPIO_TST_EN = &H0 Then write_GPIO_TST_EN_value = get_GPIO_TST_EN

        regValue = leftShift((write_GPIO_TST_EN_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        GPIO_TST_EN_mask = &Hf
        if data_low > LONG_MAX then
            if GPIO_TST_EN_mask = mask then
                read_GPIO_TST_EN_value = data_low
            else
                read_GPIO_TST_EN_value = (data_low - H8000_0000) and GPIO_TST_EN_mask
            end If
        else
            read_GPIO_TST_EN_value = data_low and GPIO_TST_EN_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_GPIO_TST_EN_value = &H0
        flag_GPIO_TST_EN        = &H0
    End Sub
End Class


'' @REGISTER : GIO0_gpio_g1_pwr_fail_tri_sts
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' GPIO_PWR_FAIL_TRI_STS                      [3:0]            get_GPIO_PWR_FAIL_TRI_STS
''                                                             set_GPIO_PWR_FAIL_TRI_STS
''                                                             read_GPIO_PWR_FAIL_TRI_STS
''                                                             write_GPIO_PWR_FAIL_TRI_STS
''---------------------------------------------------------------------------------
Class REGISTER_GIO0_gpio_g1_pwr_fail_tri_sts
    Private write_GPIO_PWR_FAIL_TRI_STS_value
    Private read_GPIO_PWR_FAIL_TRI_STS_value
    Private flag_GPIO_PWR_FAIL_TRI_STS

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

    Property Get get_GPIO_PWR_FAIL_TRI_STS
        get_GPIO_PWR_FAIL_TRI_STS = read_GPIO_PWR_FAIL_TRI_STS_value
    End Property

    Property Let set_GPIO_PWR_FAIL_TRI_STS(aData)
        write_GPIO_PWR_FAIL_TRI_STS_value = aData
        flag_GPIO_PWR_FAIL_TRI_STS        = &H1
    End Property

    Property Get read_GPIO_PWR_FAIL_TRI_STS
        read
        read_GPIO_PWR_FAIL_TRI_STS = read_GPIO_PWR_FAIL_TRI_STS_value
    End Property

    Property Let write_GPIO_PWR_FAIL_TRI_STS(aData)
        set_GPIO_PWR_FAIL_TRI_STS = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        GPIO_PWR_FAIL_TRI_STS_mask = &Hf
        if data_low > LONG_MAX then
            if GPIO_PWR_FAIL_TRI_STS_mask = mask then
                read_GPIO_PWR_FAIL_TRI_STS_value = data_low
            else
                read_GPIO_PWR_FAIL_TRI_STS_value = (data_low - H8000_0000) and GPIO_PWR_FAIL_TRI_STS_mask
            end If
        else
            read_GPIO_PWR_FAIL_TRI_STS_value = data_low and GPIO_PWR_FAIL_TRI_STS_mask
        end If

    End Sub

    Sub write
        If flag_GPIO_PWR_FAIL_TRI_STS = &H0 Then read
        If flag_GPIO_PWR_FAIL_TRI_STS = &H0 Then write_GPIO_PWR_FAIL_TRI_STS_value = get_GPIO_PWR_FAIL_TRI_STS

        regValue = leftShift((write_GPIO_PWR_FAIL_TRI_STS_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        GPIO_PWR_FAIL_TRI_STS_mask = &Hf
        if data_low > LONG_MAX then
            if GPIO_PWR_FAIL_TRI_STS_mask = mask then
                read_GPIO_PWR_FAIL_TRI_STS_value = data_low
            else
                read_GPIO_PWR_FAIL_TRI_STS_value = (data_low - H8000_0000) and GPIO_PWR_FAIL_TRI_STS_mask
            end If
        else
            read_GPIO_PWR_FAIL_TRI_STS_value = data_low and GPIO_PWR_FAIL_TRI_STS_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_GPIO_PWR_FAIL_TRI_STS_value = &H0
        flag_GPIO_PWR_FAIL_TRI_STS        = &H0
    End Sub
End Class


'' @REGISTER : GIO0_gpio_g1_pwr_fail_tri_en
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' GPIO_PWR_FAIL_TRI_EN                       [4:0]            get_GPIO_PWR_FAIL_TRI_EN
''                                                             set_GPIO_PWR_FAIL_TRI_EN
''                                                             read_GPIO_PWR_FAIL_TRI_EN
''                                                             write_GPIO_PWR_FAIL_TRI_EN
''---------------------------------------------------------------------------------
Class REGISTER_GIO0_gpio_g1_pwr_fail_tri_en
    Private write_GPIO_PWR_FAIL_TRI_EN_value
    Private read_GPIO_PWR_FAIL_TRI_EN_value
    Private flag_GPIO_PWR_FAIL_TRI_EN

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

    Property Get get_GPIO_PWR_FAIL_TRI_EN
        get_GPIO_PWR_FAIL_TRI_EN = read_GPIO_PWR_FAIL_TRI_EN_value
    End Property

    Property Let set_GPIO_PWR_FAIL_TRI_EN(aData)
        write_GPIO_PWR_FAIL_TRI_EN_value = aData
        flag_GPIO_PWR_FAIL_TRI_EN        = &H1
    End Property

    Property Get read_GPIO_PWR_FAIL_TRI_EN
        read
        read_GPIO_PWR_FAIL_TRI_EN = read_GPIO_PWR_FAIL_TRI_EN_value
    End Property

    Property Let write_GPIO_PWR_FAIL_TRI_EN(aData)
        set_GPIO_PWR_FAIL_TRI_EN = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        GPIO_PWR_FAIL_TRI_EN_mask = &H1f
        if data_low > LONG_MAX then
            if GPIO_PWR_FAIL_TRI_EN_mask = mask then
                read_GPIO_PWR_FAIL_TRI_EN_value = data_low
            else
                read_GPIO_PWR_FAIL_TRI_EN_value = (data_low - H8000_0000) and GPIO_PWR_FAIL_TRI_EN_mask
            end If
        else
            read_GPIO_PWR_FAIL_TRI_EN_value = data_low and GPIO_PWR_FAIL_TRI_EN_mask
        end If

    End Sub

    Sub write
        If flag_GPIO_PWR_FAIL_TRI_EN = &H0 Then read
        If flag_GPIO_PWR_FAIL_TRI_EN = &H0 Then write_GPIO_PWR_FAIL_TRI_EN_value = get_GPIO_PWR_FAIL_TRI_EN

        regValue = leftShift((write_GPIO_PWR_FAIL_TRI_EN_value and &H1f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        GPIO_PWR_FAIL_TRI_EN_mask = &H1f
        if data_low > LONG_MAX then
            if GPIO_PWR_FAIL_TRI_EN_mask = mask then
                read_GPIO_PWR_FAIL_TRI_EN_value = data_low
            else
                read_GPIO_PWR_FAIL_TRI_EN_value = (data_low - H8000_0000) and GPIO_PWR_FAIL_TRI_EN_mask
            end If
        else
            read_GPIO_PWR_FAIL_TRI_EN_value = data_low and GPIO_PWR_FAIL_TRI_EN_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_GPIO_PWR_FAIL_TRI_EN_value = &H0
        flag_GPIO_PWR_FAIL_TRI_EN        = &H0
    End Sub
End Class


'' @REGISTER : GIO0_gpio_g1_hyster_en
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' GPIO_HYSTER_EN                             [3:0]            get_GPIO_HYSTER_EN
''                                                             set_GPIO_HYSTER_EN
''                                                             read_GPIO_HYSTER_EN
''                                                             write_GPIO_HYSTER_EN
''---------------------------------------------------------------------------------
Class REGISTER_GIO0_gpio_g1_hyster_en
    Private write_GPIO_HYSTER_EN_value
    Private read_GPIO_HYSTER_EN_value
    Private flag_GPIO_HYSTER_EN

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

    Property Get get_GPIO_HYSTER_EN
        get_GPIO_HYSTER_EN = read_GPIO_HYSTER_EN_value
    End Property

    Property Let set_GPIO_HYSTER_EN(aData)
        write_GPIO_HYSTER_EN_value = aData
        flag_GPIO_HYSTER_EN        = &H1
    End Property

    Property Get read_GPIO_HYSTER_EN
        read
        read_GPIO_HYSTER_EN = read_GPIO_HYSTER_EN_value
    End Property

    Property Let write_GPIO_HYSTER_EN(aData)
        set_GPIO_HYSTER_EN = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        GPIO_HYSTER_EN_mask = &Hf
        if data_low > LONG_MAX then
            if GPIO_HYSTER_EN_mask = mask then
                read_GPIO_HYSTER_EN_value = data_low
            else
                read_GPIO_HYSTER_EN_value = (data_low - H8000_0000) and GPIO_HYSTER_EN_mask
            end If
        else
            read_GPIO_HYSTER_EN_value = data_low and GPIO_HYSTER_EN_mask
        end If

    End Sub

    Sub write
        If flag_GPIO_HYSTER_EN = &H0 Then read
        If flag_GPIO_HYSTER_EN = &H0 Then write_GPIO_HYSTER_EN_value = get_GPIO_HYSTER_EN

        regValue = leftShift((write_GPIO_HYSTER_EN_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        GPIO_HYSTER_EN_mask = &Hf
        if data_low > LONG_MAX then
            if GPIO_HYSTER_EN_mask = mask then
                read_GPIO_HYSTER_EN_value = data_low
            else
                read_GPIO_HYSTER_EN_value = (data_low - H8000_0000) and GPIO_HYSTER_EN_mask
            end If
        else
            read_GPIO_HYSTER_EN_value = data_low and GPIO_HYSTER_EN_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_GPIO_HYSTER_EN_value = &H0
        flag_GPIO_HYSTER_EN        = &H0
    End Sub
End Class


'' @REGISTER : GIO0_gpio_g1_slew_ctrl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' GPIO_SLEW_CTRL                             [3:0]            get_GPIO_SLEW_CTRL
''                                                             set_GPIO_SLEW_CTRL
''                                                             read_GPIO_SLEW_CTRL
''                                                             write_GPIO_SLEW_CTRL
''---------------------------------------------------------------------------------
Class REGISTER_GIO0_gpio_g1_slew_ctrl
    Private write_GPIO_SLEW_CTRL_value
    Private read_GPIO_SLEW_CTRL_value
    Private flag_GPIO_SLEW_CTRL

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

    Property Get get_GPIO_SLEW_CTRL
        get_GPIO_SLEW_CTRL = read_GPIO_SLEW_CTRL_value
    End Property

    Property Let set_GPIO_SLEW_CTRL(aData)
        write_GPIO_SLEW_CTRL_value = aData
        flag_GPIO_SLEW_CTRL        = &H1
    End Property

    Property Get read_GPIO_SLEW_CTRL
        read
        read_GPIO_SLEW_CTRL = read_GPIO_SLEW_CTRL_value
    End Property

    Property Let write_GPIO_SLEW_CTRL(aData)
        set_GPIO_SLEW_CTRL = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        GPIO_SLEW_CTRL_mask = &Hf
        if data_low > LONG_MAX then
            if GPIO_SLEW_CTRL_mask = mask then
                read_GPIO_SLEW_CTRL_value = data_low
            else
                read_GPIO_SLEW_CTRL_value = (data_low - H8000_0000) and GPIO_SLEW_CTRL_mask
            end If
        else
            read_GPIO_SLEW_CTRL_value = data_low and GPIO_SLEW_CTRL_mask
        end If

    End Sub

    Sub write
        If flag_GPIO_SLEW_CTRL = &H0 Then read
        If flag_GPIO_SLEW_CTRL = &H0 Then write_GPIO_SLEW_CTRL_value = get_GPIO_SLEW_CTRL

        regValue = leftShift((write_GPIO_SLEW_CTRL_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        GPIO_SLEW_CTRL_mask = &Hf
        if data_low > LONG_MAX then
            if GPIO_SLEW_CTRL_mask = mask then
                read_GPIO_SLEW_CTRL_value = data_low
            else
                read_GPIO_SLEW_CTRL_value = (data_low - H8000_0000) and GPIO_SLEW_CTRL_mask
            end If
        else
            read_GPIO_SLEW_CTRL_value = data_low and GPIO_SLEW_CTRL_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_GPIO_SLEW_CTRL_value = &H0
        flag_GPIO_SLEW_CTRL        = &H0
    End Sub
End Class


'' @REGISTER : GIO0_gpio_g1_drv_sel_0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' GPIO_DRV_SEL_0                             [3:0]            get_GPIO_DRV_SEL_0
''                                                             set_GPIO_DRV_SEL_0
''                                                             read_GPIO_DRV_SEL_0
''                                                             write_GPIO_DRV_SEL_0
''---------------------------------------------------------------------------------
Class REGISTER_GIO0_gpio_g1_drv_sel_0
    Private write_GPIO_DRV_SEL_0_value
    Private read_GPIO_DRV_SEL_0_value
    Private flag_GPIO_DRV_SEL_0

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

    Property Get get_GPIO_DRV_SEL_0
        get_GPIO_DRV_SEL_0 = read_GPIO_DRV_SEL_0_value
    End Property

    Property Let set_GPIO_DRV_SEL_0(aData)
        write_GPIO_DRV_SEL_0_value = aData
        flag_GPIO_DRV_SEL_0        = &H1
    End Property

    Property Get read_GPIO_DRV_SEL_0
        read
        read_GPIO_DRV_SEL_0 = read_GPIO_DRV_SEL_0_value
    End Property

    Property Let write_GPIO_DRV_SEL_0(aData)
        set_GPIO_DRV_SEL_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        GPIO_DRV_SEL_0_mask = &Hf
        if data_low > LONG_MAX then
            if GPIO_DRV_SEL_0_mask = mask then
                read_GPIO_DRV_SEL_0_value = data_low
            else
                read_GPIO_DRV_SEL_0_value = (data_low - H8000_0000) and GPIO_DRV_SEL_0_mask
            end If
        else
            read_GPIO_DRV_SEL_0_value = data_low and GPIO_DRV_SEL_0_mask
        end If

    End Sub

    Sub write
        If flag_GPIO_DRV_SEL_0 = &H0 Then read
        If flag_GPIO_DRV_SEL_0 = &H0 Then write_GPIO_DRV_SEL_0_value = get_GPIO_DRV_SEL_0

        regValue = leftShift((write_GPIO_DRV_SEL_0_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        GPIO_DRV_SEL_0_mask = &Hf
        if data_low > LONG_MAX then
            if GPIO_DRV_SEL_0_mask = mask then
                read_GPIO_DRV_SEL_0_value = data_low
            else
                read_GPIO_DRV_SEL_0_value = (data_low - H8000_0000) and GPIO_DRV_SEL_0_mask
            end If
        else
            read_GPIO_DRV_SEL_0_value = data_low and GPIO_DRV_SEL_0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_GPIO_DRV_SEL_0_value = &H0
        flag_GPIO_DRV_SEL_0        = &H0
    End Sub
End Class


'' @REGISTER : GIO0_gpio_g1_drv_sel_1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' GPIO_DRV_SEL_1                             [3:0]            get_GPIO_DRV_SEL_1
''                                                             set_GPIO_DRV_SEL_1
''                                                             read_GPIO_DRV_SEL_1
''                                                             write_GPIO_DRV_SEL_1
''---------------------------------------------------------------------------------
Class REGISTER_GIO0_gpio_g1_drv_sel_1
    Private write_GPIO_DRV_SEL_1_value
    Private read_GPIO_DRV_SEL_1_value
    Private flag_GPIO_DRV_SEL_1

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

    Property Get get_GPIO_DRV_SEL_1
        get_GPIO_DRV_SEL_1 = read_GPIO_DRV_SEL_1_value
    End Property

    Property Let set_GPIO_DRV_SEL_1(aData)
        write_GPIO_DRV_SEL_1_value = aData
        flag_GPIO_DRV_SEL_1        = &H1
    End Property

    Property Get read_GPIO_DRV_SEL_1
        read
        read_GPIO_DRV_SEL_1 = read_GPIO_DRV_SEL_1_value
    End Property

    Property Let write_GPIO_DRV_SEL_1(aData)
        set_GPIO_DRV_SEL_1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        GPIO_DRV_SEL_1_mask = &Hf
        if data_low > LONG_MAX then
            if GPIO_DRV_SEL_1_mask = mask then
                read_GPIO_DRV_SEL_1_value = data_low
            else
                read_GPIO_DRV_SEL_1_value = (data_low - H8000_0000) and GPIO_DRV_SEL_1_mask
            end If
        else
            read_GPIO_DRV_SEL_1_value = data_low and GPIO_DRV_SEL_1_mask
        end If

    End Sub

    Sub write
        If flag_GPIO_DRV_SEL_1 = &H0 Then read
        If flag_GPIO_DRV_SEL_1 = &H0 Then write_GPIO_DRV_SEL_1_value = get_GPIO_DRV_SEL_1

        regValue = leftShift((write_GPIO_DRV_SEL_1_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        GPIO_DRV_SEL_1_mask = &Hf
        if data_low > LONG_MAX then
            if GPIO_DRV_SEL_1_mask = mask then
                read_GPIO_DRV_SEL_1_value = data_low
            else
                read_GPIO_DRV_SEL_1_value = (data_low - H8000_0000) and GPIO_DRV_SEL_1_mask
            end If
        else
            read_GPIO_DRV_SEL_1_value = data_low and GPIO_DRV_SEL_1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_GPIO_DRV_SEL_1_value = &H0
        flag_GPIO_DRV_SEL_1        = &H0
    End Sub
End Class


'' @REGISTER : GIO0_gpio_g1_drv_sel_2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' GPIO_DRV_SEL_2                             [3:0]            get_GPIO_DRV_SEL_2
''                                                             set_GPIO_DRV_SEL_2
''                                                             read_GPIO_DRV_SEL_2
''                                                             write_GPIO_DRV_SEL_2
''---------------------------------------------------------------------------------
Class REGISTER_GIO0_gpio_g1_drv_sel_2
    Private write_GPIO_DRV_SEL_2_value
    Private read_GPIO_DRV_SEL_2_value
    Private flag_GPIO_DRV_SEL_2

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

    Property Get get_GPIO_DRV_SEL_2
        get_GPIO_DRV_SEL_2 = read_GPIO_DRV_SEL_2_value
    End Property

    Property Let set_GPIO_DRV_SEL_2(aData)
        write_GPIO_DRV_SEL_2_value = aData
        flag_GPIO_DRV_SEL_2        = &H1
    End Property

    Property Get read_GPIO_DRV_SEL_2
        read
        read_GPIO_DRV_SEL_2 = read_GPIO_DRV_SEL_2_value
    End Property

    Property Let write_GPIO_DRV_SEL_2(aData)
        set_GPIO_DRV_SEL_2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        GPIO_DRV_SEL_2_mask = &Hf
        if data_low > LONG_MAX then
            if GPIO_DRV_SEL_2_mask = mask then
                read_GPIO_DRV_SEL_2_value = data_low
            else
                read_GPIO_DRV_SEL_2_value = (data_low - H8000_0000) and GPIO_DRV_SEL_2_mask
            end If
        else
            read_GPIO_DRV_SEL_2_value = data_low and GPIO_DRV_SEL_2_mask
        end If

    End Sub

    Sub write
        If flag_GPIO_DRV_SEL_2 = &H0 Then read
        If flag_GPIO_DRV_SEL_2 = &H0 Then write_GPIO_DRV_SEL_2_value = get_GPIO_DRV_SEL_2

        regValue = leftShift((write_GPIO_DRV_SEL_2_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        GPIO_DRV_SEL_2_mask = &Hf
        if data_low > LONG_MAX then
            if GPIO_DRV_SEL_2_mask = mask then
                read_GPIO_DRV_SEL_2_value = data_low
            else
                read_GPIO_DRV_SEL_2_value = (data_low - H8000_0000) and GPIO_DRV_SEL_2_mask
            end If
        else
            read_GPIO_DRV_SEL_2_value = data_low and GPIO_DRV_SEL_2_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_GPIO_DRV_SEL_2_value = &H0
        flag_GPIO_DRV_SEL_2        = &H0
    End Sub
End Class


'' @REGISTER : GIO0_gpio_g1_aux_sel
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' GPIO_AUX01_SEL                             [3:0]            get_GPIO_AUX01_SEL
''                                                             set_GPIO_AUX01_SEL
''                                                             read_GPIO_AUX01_SEL
''                                                             write_GPIO_AUX01_SEL
''---------------------------------------------------------------------------------
Class REGISTER_GIO0_gpio_g1_aux_sel
    Private write_GPIO_AUX01_SEL_value
    Private read_GPIO_AUX01_SEL_value
    Private flag_GPIO_AUX01_SEL

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

    Property Get get_GPIO_AUX01_SEL
        get_GPIO_AUX01_SEL = read_GPIO_AUX01_SEL_value
    End Property

    Property Let set_GPIO_AUX01_SEL(aData)
        write_GPIO_AUX01_SEL_value = aData
        flag_GPIO_AUX01_SEL        = &H1
    End Property

    Property Get read_GPIO_AUX01_SEL
        read
        read_GPIO_AUX01_SEL = read_GPIO_AUX01_SEL_value
    End Property

    Property Let write_GPIO_AUX01_SEL(aData)
        set_GPIO_AUX01_SEL = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        GPIO_AUX01_SEL_mask = &Hf
        if data_low > LONG_MAX then
            if GPIO_AUX01_SEL_mask = mask then
                read_GPIO_AUX01_SEL_value = data_low
            else
                read_GPIO_AUX01_SEL_value = (data_low - H8000_0000) and GPIO_AUX01_SEL_mask
            end If
        else
            read_GPIO_AUX01_SEL_value = data_low and GPIO_AUX01_SEL_mask
        end If

    End Sub

    Sub write
        If flag_GPIO_AUX01_SEL = &H0 Then read
        If flag_GPIO_AUX01_SEL = &H0 Then write_GPIO_AUX01_SEL_value = get_GPIO_AUX01_SEL

        regValue = leftShift((write_GPIO_AUX01_SEL_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        GPIO_AUX01_SEL_mask = &Hf
        if data_low > LONG_MAX then
            if GPIO_AUX01_SEL_mask = mask then
                read_GPIO_AUX01_SEL_value = data_low
            else
                read_GPIO_AUX01_SEL_value = (data_low - H8000_0000) and GPIO_AUX01_SEL_mask
            end If
        else
            read_GPIO_AUX01_SEL_value = data_low and GPIO_AUX01_SEL_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_GPIO_AUX01_SEL_value = &H0
        flag_GPIO_AUX01_SEL        = &H0
    End Sub
End Class


'' @REGISTER : GIO0_gpio_g1_int_pol
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' GPIO_G1_INT_POL_RESERVED_1                 [4:2]            get_GPIO_G1_INT_POL_RESERVED_1
''                                                             set_GPIO_G1_INT_POL_RESERVED_1
''                                                             read_GPIO_G1_INT_POL_RESERVED_1
''                                                             write_GPIO_G1_INT_POL_RESERVED_1
''---------------------------------------------------------------------------------
'' GPIO_INT_POL                               [1:1]            get_GPIO_INT_POL
''                                                             set_GPIO_INT_POL
''                                                             read_GPIO_INT_POL
''                                                             write_GPIO_INT_POL
''---------------------------------------------------------------------------------
Class REGISTER_GIO0_gpio_g1_int_pol
    Private write_GPIO_G1_INT_POL_RESERVED_1_value
    Private read_GPIO_G1_INT_POL_RESERVED_1_value
    Private flag_GPIO_G1_INT_POL_RESERVED_1
    Private write_GPIO_INT_POL_value
    Private read_GPIO_INT_POL_value
    Private flag_GPIO_INT_POL

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

    Property Get get_GPIO_G1_INT_POL_RESERVED_1
        get_GPIO_G1_INT_POL_RESERVED_1 = read_GPIO_G1_INT_POL_RESERVED_1_value
    End Property

    Property Let set_GPIO_G1_INT_POL_RESERVED_1(aData)
        write_GPIO_G1_INT_POL_RESERVED_1_value = aData
        flag_GPIO_G1_INT_POL_RESERVED_1        = &H1
    End Property

    Property Get read_GPIO_G1_INT_POL_RESERVED_1
        read
        read_GPIO_G1_INT_POL_RESERVED_1 = read_GPIO_G1_INT_POL_RESERVED_1_value
    End Property

    Property Let write_GPIO_G1_INT_POL_RESERVED_1(aData)
        set_GPIO_G1_INT_POL_RESERVED_1 = aData
        write
    End Property

    Property Get get_GPIO_INT_POL
        get_GPIO_INT_POL = read_GPIO_INT_POL_value
    End Property

    Property Let set_GPIO_INT_POL(aData)
        write_GPIO_INT_POL_value = aData
        flag_GPIO_INT_POL        = &H1
    End Property

    Property Get read_GPIO_INT_POL
        read
        read_GPIO_INT_POL = read_GPIO_INT_POL_value
    End Property

    Property Let write_GPIO_INT_POL(aData)
        set_GPIO_INT_POL = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_GPIO_G1_INT_POL_RESERVED_1_value = rightShift(data_low, 2) and &H7
        read_GPIO_INT_POL_value = rightShift(data_low, 1) and &H1

    End Sub

    Sub write
        If flag_GPIO_G1_INT_POL_RESERVED_1 = &H0 or flag_GPIO_INT_POL = &H0 Then read
        If flag_GPIO_G1_INT_POL_RESERVED_1 = &H0 Then write_GPIO_G1_INT_POL_RESERVED_1_value = get_GPIO_G1_INT_POL_RESERVED_1
        If flag_GPIO_INT_POL = &H0 Then write_GPIO_INT_POL_value = get_GPIO_INT_POL

        regValue = leftShift((write_GPIO_G1_INT_POL_RESERVED_1_value and &H7), 2) + leftShift((write_GPIO_INT_POL_value and &H1), 1)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_GPIO_G1_INT_POL_RESERVED_1_value = rightShift(data_low, 2) and &H7
        read_GPIO_INT_POL_value = rightShift(data_low, 1) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_GPIO_G1_INT_POL_RESERVED_1_value = &H0
        flag_GPIO_G1_INT_POL_RESERVED_1        = &H0
        write_GPIO_INT_POL_value = &H0
        flag_GPIO_INT_POL        = &H0
    End Sub
End Class


'' @REGISTER : GIO0_flash_cs_din
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' FLASH_CS_DIN_RESERVED_1                    [3:1]            get_FLASH_CS_DIN_RESERVED_1
''                                                             set_FLASH_CS_DIN_RESERVED_1
''                                                             read_FLASH_CS_DIN_RESERVED_1
''                                                             write_FLASH_CS_DIN_RESERVED_1
''---------------------------------------------------------------------------------
'' FLASH_CS_DATA_IN                           [0:0]            get_FLASH_CS_DATA_IN
''                                                             set_FLASH_CS_DATA_IN
''                                                             read_FLASH_CS_DATA_IN
''                                                             write_FLASH_CS_DATA_IN
''---------------------------------------------------------------------------------
Class REGISTER_GIO0_flash_cs_din
    Private write_FLASH_CS_DIN_RESERVED_1_value
    Private read_FLASH_CS_DIN_RESERVED_1_value
    Private flag_FLASH_CS_DIN_RESERVED_1
    Private write_FLASH_CS_DATA_IN_value
    Private read_FLASH_CS_DATA_IN_value
    Private flag_FLASH_CS_DATA_IN

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

    Property Get get_FLASH_CS_DIN_RESERVED_1
        get_FLASH_CS_DIN_RESERVED_1 = read_FLASH_CS_DIN_RESERVED_1_value
    End Property

    Property Let set_FLASH_CS_DIN_RESERVED_1(aData)
        write_FLASH_CS_DIN_RESERVED_1_value = aData
        flag_FLASH_CS_DIN_RESERVED_1        = &H1
    End Property

    Property Get read_FLASH_CS_DIN_RESERVED_1
        read
        read_FLASH_CS_DIN_RESERVED_1 = read_FLASH_CS_DIN_RESERVED_1_value
    End Property

    Property Let write_FLASH_CS_DIN_RESERVED_1(aData)
        set_FLASH_CS_DIN_RESERVED_1 = aData
        write
    End Property

    Property Get get_FLASH_CS_DATA_IN
        get_FLASH_CS_DATA_IN = read_FLASH_CS_DATA_IN_value
    End Property

    Property Let set_FLASH_CS_DATA_IN(aData)
        write_FLASH_CS_DATA_IN_value = aData
        flag_FLASH_CS_DATA_IN        = &H1
    End Property

    Property Get read_FLASH_CS_DATA_IN
        read
        read_FLASH_CS_DATA_IN = read_FLASH_CS_DATA_IN_value
    End Property

    Property Let write_FLASH_CS_DATA_IN(aData)
        set_FLASH_CS_DATA_IN = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_FLASH_CS_DIN_RESERVED_1_value = rightShift(data_low, 1) and &H7
        FLASH_CS_DATA_IN_mask = &H1
        if data_low > LONG_MAX then
            if FLASH_CS_DATA_IN_mask = mask then
                read_FLASH_CS_DATA_IN_value = data_low
            else
                read_FLASH_CS_DATA_IN_value = (data_low - H8000_0000) and FLASH_CS_DATA_IN_mask
            end If
        else
            read_FLASH_CS_DATA_IN_value = data_low and FLASH_CS_DATA_IN_mask
        end If

    End Sub

    Sub write
        If flag_FLASH_CS_DIN_RESERVED_1 = &H0 or flag_FLASH_CS_DATA_IN = &H0 Then read
        If flag_FLASH_CS_DIN_RESERVED_1 = &H0 Then write_FLASH_CS_DIN_RESERVED_1_value = get_FLASH_CS_DIN_RESERVED_1
        If flag_FLASH_CS_DATA_IN = &H0 Then write_FLASH_CS_DATA_IN_value = get_FLASH_CS_DATA_IN

        regValue = leftShift((write_FLASH_CS_DIN_RESERVED_1_value and &H7), 1) + leftShift((write_FLASH_CS_DATA_IN_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_FLASH_CS_DIN_RESERVED_1_value = rightShift(data_low, 1) and &H7
        FLASH_CS_DATA_IN_mask = &H1
        if data_low > LONG_MAX then
            if FLASH_CS_DATA_IN_mask = mask then
                read_FLASH_CS_DATA_IN_value = data_low
            else
                read_FLASH_CS_DATA_IN_value = (data_low - H8000_0000) and FLASH_CS_DATA_IN_mask
            end If
        else
            read_FLASH_CS_DATA_IN_value = data_low and FLASH_CS_DATA_IN_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_FLASH_CS_DIN_RESERVED_1_value = &H0
        flag_FLASH_CS_DIN_RESERVED_1        = &H0
        write_FLASH_CS_DATA_IN_value = &H0
        flag_FLASH_CS_DATA_IN        = &H0
    End Sub
End Class


'' @REGISTER : GIO0_flash_cs_dout
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' FLASH_CS_DOUT_RESERVED_1                   [3:1]            get_FLASH_CS_DOUT_RESERVED_1
''                                                             set_FLASH_CS_DOUT_RESERVED_1
''                                                             read_FLASH_CS_DOUT_RESERVED_1
''                                                             write_FLASH_CS_DOUT_RESERVED_1
''---------------------------------------------------------------------------------
'' FLASH_CS_DATA_OUT                          [0:0]            get_FLASH_CS_DATA_OUT
''                                                             set_FLASH_CS_DATA_OUT
''                                                             read_FLASH_CS_DATA_OUT
''                                                             write_FLASH_CS_DATA_OUT
''---------------------------------------------------------------------------------
Class REGISTER_GIO0_flash_cs_dout
    Private write_FLASH_CS_DOUT_RESERVED_1_value
    Private read_FLASH_CS_DOUT_RESERVED_1_value
    Private flag_FLASH_CS_DOUT_RESERVED_1
    Private write_FLASH_CS_DATA_OUT_value
    Private read_FLASH_CS_DATA_OUT_value
    Private flag_FLASH_CS_DATA_OUT

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

    Property Get get_FLASH_CS_DOUT_RESERVED_1
        get_FLASH_CS_DOUT_RESERVED_1 = read_FLASH_CS_DOUT_RESERVED_1_value
    End Property

    Property Let set_FLASH_CS_DOUT_RESERVED_1(aData)
        write_FLASH_CS_DOUT_RESERVED_1_value = aData
        flag_FLASH_CS_DOUT_RESERVED_1        = &H1
    End Property

    Property Get read_FLASH_CS_DOUT_RESERVED_1
        read
        read_FLASH_CS_DOUT_RESERVED_1 = read_FLASH_CS_DOUT_RESERVED_1_value
    End Property

    Property Let write_FLASH_CS_DOUT_RESERVED_1(aData)
        set_FLASH_CS_DOUT_RESERVED_1 = aData
        write
    End Property

    Property Get get_FLASH_CS_DATA_OUT
        get_FLASH_CS_DATA_OUT = read_FLASH_CS_DATA_OUT_value
    End Property

    Property Let set_FLASH_CS_DATA_OUT(aData)
        write_FLASH_CS_DATA_OUT_value = aData
        flag_FLASH_CS_DATA_OUT        = &H1
    End Property

    Property Get read_FLASH_CS_DATA_OUT
        read
        read_FLASH_CS_DATA_OUT = read_FLASH_CS_DATA_OUT_value
    End Property

    Property Let write_FLASH_CS_DATA_OUT(aData)
        set_FLASH_CS_DATA_OUT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_FLASH_CS_DOUT_RESERVED_1_value = rightShift(data_low, 1) and &H7
        FLASH_CS_DATA_OUT_mask = &H1
        if data_low > LONG_MAX then
            if FLASH_CS_DATA_OUT_mask = mask then
                read_FLASH_CS_DATA_OUT_value = data_low
            else
                read_FLASH_CS_DATA_OUT_value = (data_low - H8000_0000) and FLASH_CS_DATA_OUT_mask
            end If
        else
            read_FLASH_CS_DATA_OUT_value = data_low and FLASH_CS_DATA_OUT_mask
        end If

    End Sub

    Sub write
        If flag_FLASH_CS_DOUT_RESERVED_1 = &H0 or flag_FLASH_CS_DATA_OUT = &H0 Then read
        If flag_FLASH_CS_DOUT_RESERVED_1 = &H0 Then write_FLASH_CS_DOUT_RESERVED_1_value = get_FLASH_CS_DOUT_RESERVED_1
        If flag_FLASH_CS_DATA_OUT = &H0 Then write_FLASH_CS_DATA_OUT_value = get_FLASH_CS_DATA_OUT

        regValue = leftShift((write_FLASH_CS_DOUT_RESERVED_1_value and &H7), 1) + leftShift((write_FLASH_CS_DATA_OUT_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_FLASH_CS_DOUT_RESERVED_1_value = rightShift(data_low, 1) and &H7
        FLASH_CS_DATA_OUT_mask = &H1
        if data_low > LONG_MAX then
            if FLASH_CS_DATA_OUT_mask = mask then
                read_FLASH_CS_DATA_OUT_value = data_low
            else
                read_FLASH_CS_DATA_OUT_value = (data_low - H8000_0000) and FLASH_CS_DATA_OUT_mask
            end If
        else
            read_FLASH_CS_DATA_OUT_value = data_low and FLASH_CS_DATA_OUT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_FLASH_CS_DOUT_RESERVED_1_value = &H0
        flag_FLASH_CS_DOUT_RESERVED_1        = &H0
        write_FLASH_CS_DATA_OUT_value = &H0
        flag_FLASH_CS_DATA_OUT        = &H0
    End Sub
End Class


'' @REGISTER : GIO0_flash_cs_oe
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' FLASH_CS_OE_RESERVED_1                     [3:1]            get_FLASH_CS_OE_RESERVED_1
''                                                             set_FLASH_CS_OE_RESERVED_1
''                                                             read_FLASH_CS_OE_RESERVED_1
''                                                             write_FLASH_CS_OE_RESERVED_1
''---------------------------------------------------------------------------------
'' FLASH_CS_DATA_OE                           [0:0]            get_FLASH_CS_DATA_OE
''                                                             set_FLASH_CS_DATA_OE
''                                                             read_FLASH_CS_DATA_OE
''                                                             write_FLASH_CS_DATA_OE
''---------------------------------------------------------------------------------
Class REGISTER_GIO0_flash_cs_oe
    Private write_FLASH_CS_OE_RESERVED_1_value
    Private read_FLASH_CS_OE_RESERVED_1_value
    Private flag_FLASH_CS_OE_RESERVED_1
    Private write_FLASH_CS_DATA_OE_value
    Private read_FLASH_CS_DATA_OE_value
    Private flag_FLASH_CS_DATA_OE

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

    Property Get get_FLASH_CS_OE_RESERVED_1
        get_FLASH_CS_OE_RESERVED_1 = read_FLASH_CS_OE_RESERVED_1_value
    End Property

    Property Let set_FLASH_CS_OE_RESERVED_1(aData)
        write_FLASH_CS_OE_RESERVED_1_value = aData
        flag_FLASH_CS_OE_RESERVED_1        = &H1
    End Property

    Property Get read_FLASH_CS_OE_RESERVED_1
        read
        read_FLASH_CS_OE_RESERVED_1 = read_FLASH_CS_OE_RESERVED_1_value
    End Property

    Property Let write_FLASH_CS_OE_RESERVED_1(aData)
        set_FLASH_CS_OE_RESERVED_1 = aData
        write
    End Property

    Property Get get_FLASH_CS_DATA_OE
        get_FLASH_CS_DATA_OE = read_FLASH_CS_DATA_OE_value
    End Property

    Property Let set_FLASH_CS_DATA_OE(aData)
        write_FLASH_CS_DATA_OE_value = aData
        flag_FLASH_CS_DATA_OE        = &H1
    End Property

    Property Get read_FLASH_CS_DATA_OE
        read
        read_FLASH_CS_DATA_OE = read_FLASH_CS_DATA_OE_value
    End Property

    Property Let write_FLASH_CS_DATA_OE(aData)
        set_FLASH_CS_DATA_OE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_FLASH_CS_OE_RESERVED_1_value = rightShift(data_low, 1) and &H7
        FLASH_CS_DATA_OE_mask = &H1
        if data_low > LONG_MAX then
            if FLASH_CS_DATA_OE_mask = mask then
                read_FLASH_CS_DATA_OE_value = data_low
            else
                read_FLASH_CS_DATA_OE_value = (data_low - H8000_0000) and FLASH_CS_DATA_OE_mask
            end If
        else
            read_FLASH_CS_DATA_OE_value = data_low and FLASH_CS_DATA_OE_mask
        end If

    End Sub

    Sub write
        If flag_FLASH_CS_OE_RESERVED_1 = &H0 or flag_FLASH_CS_DATA_OE = &H0 Then read
        If flag_FLASH_CS_OE_RESERVED_1 = &H0 Then write_FLASH_CS_OE_RESERVED_1_value = get_FLASH_CS_OE_RESERVED_1
        If flag_FLASH_CS_DATA_OE = &H0 Then write_FLASH_CS_DATA_OE_value = get_FLASH_CS_DATA_OE

        regValue = leftShift((write_FLASH_CS_OE_RESERVED_1_value and &H7), 1) + leftShift((write_FLASH_CS_DATA_OE_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_FLASH_CS_OE_RESERVED_1_value = rightShift(data_low, 1) and &H7
        FLASH_CS_DATA_OE_mask = &H1
        if data_low > LONG_MAX then
            if FLASH_CS_DATA_OE_mask = mask then
                read_FLASH_CS_DATA_OE_value = data_low
            else
                read_FLASH_CS_DATA_OE_value = (data_low - H8000_0000) and FLASH_CS_DATA_OE_mask
            end If
        else
            read_FLASH_CS_DATA_OE_value = data_low and FLASH_CS_DATA_OE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_FLASH_CS_OE_RESERVED_1_value = &H0
        flag_FLASH_CS_OE_RESERVED_1        = &H0
        write_FLASH_CS_DATA_OE_value = &H0
        flag_FLASH_CS_DATA_OE        = &H0
    End Sub
End Class


'' @REGISTER : GIO0_gpio_g2_int_typ
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' GPIO_G2_INT_TYP_GPIO_INT_TYP               [0:0]            get_GPIO_G2_INT_TYP_GPIO_INT_TYP
''                                                             set_GPIO_G2_INT_TYP_GPIO_INT_TYP
''                                                             read_GPIO_G2_INT_TYP_GPIO_INT_TYP
''                                                             write_GPIO_G2_INT_TYP_GPIO_INT_TYP
''---------------------------------------------------------------------------------
Class REGISTER_GIO0_gpio_g2_int_typ
    Private write_GPIO_G2_INT_TYP_GPIO_INT_TYP_value
    Private read_GPIO_G2_INT_TYP_GPIO_INT_TYP_value
    Private flag_GPIO_G2_INT_TYP_GPIO_INT_TYP

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

    Property Get get_GPIO_G2_INT_TYP_GPIO_INT_TYP
        get_GPIO_G2_INT_TYP_GPIO_INT_TYP = read_GPIO_G2_INT_TYP_GPIO_INT_TYP_value
    End Property

    Property Let set_GPIO_G2_INT_TYP_GPIO_INT_TYP(aData)
        write_GPIO_G2_INT_TYP_GPIO_INT_TYP_value = aData
        flag_GPIO_G2_INT_TYP_GPIO_INT_TYP        = &H1
    End Property

    Property Get read_GPIO_G2_INT_TYP_GPIO_INT_TYP
        read
        read_GPIO_G2_INT_TYP_GPIO_INT_TYP = read_GPIO_G2_INT_TYP_GPIO_INT_TYP_value
    End Property

    Property Let write_GPIO_G2_INT_TYP_GPIO_INT_TYP(aData)
        set_GPIO_G2_INT_TYP_GPIO_INT_TYP = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        GPIO_G2_INT_TYP_GPIO_INT_TYP_mask = &H1
        if data_low > LONG_MAX then
            if GPIO_G2_INT_TYP_GPIO_INT_TYP_mask = mask then
                read_GPIO_G2_INT_TYP_GPIO_INT_TYP_value = data_low
            else
                read_GPIO_G2_INT_TYP_GPIO_INT_TYP_value = (data_low - H8000_0000) and GPIO_G2_INT_TYP_GPIO_INT_TYP_mask
            end If
        else
            read_GPIO_G2_INT_TYP_GPIO_INT_TYP_value = data_low and GPIO_G2_INT_TYP_GPIO_INT_TYP_mask
        end If

    End Sub

    Sub write
        If flag_GPIO_G2_INT_TYP_GPIO_INT_TYP = &H0 Then read
        If flag_GPIO_G2_INT_TYP_GPIO_INT_TYP = &H0 Then write_GPIO_G2_INT_TYP_GPIO_INT_TYP_value = get_GPIO_G2_INT_TYP_GPIO_INT_TYP

        regValue = leftShift((write_GPIO_G2_INT_TYP_GPIO_INT_TYP_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        GPIO_G2_INT_TYP_GPIO_INT_TYP_mask = &H1
        if data_low > LONG_MAX then
            if GPIO_G2_INT_TYP_GPIO_INT_TYP_mask = mask then
                read_GPIO_G2_INT_TYP_GPIO_INT_TYP_value = data_low
            else
                read_GPIO_G2_INT_TYP_GPIO_INT_TYP_value = (data_low - H8000_0000) and GPIO_G2_INT_TYP_GPIO_INT_TYP_mask
            end If
        else
            read_GPIO_G2_INT_TYP_GPIO_INT_TYP_value = data_low and GPIO_G2_INT_TYP_GPIO_INT_TYP_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_GPIO_G2_INT_TYP_GPIO_INT_TYP_value = &H0
        flag_GPIO_G2_INT_TYP_GPIO_INT_TYP        = &H0
    End Sub
End Class


'' @REGISTER : GIO0_gpio_g2_int_du_edg
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' GPIO_G2_INT_DU_EDG_GPIO_INT_DU_EDGE        [0:0]            get_GPIO_G2_INT_DU_EDG_GPIO_INT_DU_EDGE
''                                                             set_GPIO_G2_INT_DU_EDG_GPIO_INT_DU_EDGE
''                                                             read_GPIO_G2_INT_DU_EDG_GPIO_INT_DU_EDGE
''                                                             write_GPIO_G2_INT_DU_EDG_GPIO_INT_DU_EDGE
''---------------------------------------------------------------------------------
Class REGISTER_GIO0_gpio_g2_int_du_edg
    Private write_GPIO_G2_INT_DU_EDG_GPIO_INT_DU_EDGE_value
    Private read_GPIO_G2_INT_DU_EDG_GPIO_INT_DU_EDGE_value
    Private flag_GPIO_G2_INT_DU_EDG_GPIO_INT_DU_EDGE

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

    Property Get get_GPIO_G2_INT_DU_EDG_GPIO_INT_DU_EDGE
        get_GPIO_G2_INT_DU_EDG_GPIO_INT_DU_EDGE = read_GPIO_G2_INT_DU_EDG_GPIO_INT_DU_EDGE_value
    End Property

    Property Let set_GPIO_G2_INT_DU_EDG_GPIO_INT_DU_EDGE(aData)
        write_GPIO_G2_INT_DU_EDG_GPIO_INT_DU_EDGE_value = aData
        flag_GPIO_G2_INT_DU_EDG_GPIO_INT_DU_EDGE        = &H1
    End Property

    Property Get read_GPIO_G2_INT_DU_EDG_GPIO_INT_DU_EDGE
        read
        read_GPIO_G2_INT_DU_EDG_GPIO_INT_DU_EDGE = read_GPIO_G2_INT_DU_EDG_GPIO_INT_DU_EDGE_value
    End Property

    Property Let write_GPIO_G2_INT_DU_EDG_GPIO_INT_DU_EDGE(aData)
        set_GPIO_G2_INT_DU_EDG_GPIO_INT_DU_EDGE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        GPIO_G2_INT_DU_EDG_GPIO_INT_DU_EDGE_mask = &H1
        if data_low > LONG_MAX then
            if GPIO_G2_INT_DU_EDG_GPIO_INT_DU_EDGE_mask = mask then
                read_GPIO_G2_INT_DU_EDG_GPIO_INT_DU_EDGE_value = data_low
            else
                read_GPIO_G2_INT_DU_EDG_GPIO_INT_DU_EDGE_value = (data_low - H8000_0000) and GPIO_G2_INT_DU_EDG_GPIO_INT_DU_EDGE_mask
            end If
        else
            read_GPIO_G2_INT_DU_EDG_GPIO_INT_DU_EDGE_value = data_low and GPIO_G2_INT_DU_EDG_GPIO_INT_DU_EDGE_mask
        end If

    End Sub

    Sub write
        If flag_GPIO_G2_INT_DU_EDG_GPIO_INT_DU_EDGE = &H0 Then read
        If flag_GPIO_G2_INT_DU_EDG_GPIO_INT_DU_EDGE = &H0 Then write_GPIO_G2_INT_DU_EDG_GPIO_INT_DU_EDGE_value = get_GPIO_G2_INT_DU_EDG_GPIO_INT_DU_EDGE

        regValue = leftShift((write_GPIO_G2_INT_DU_EDG_GPIO_INT_DU_EDGE_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        GPIO_G2_INT_DU_EDG_GPIO_INT_DU_EDGE_mask = &H1
        if data_low > LONG_MAX then
            if GPIO_G2_INT_DU_EDG_GPIO_INT_DU_EDGE_mask = mask then
                read_GPIO_G2_INT_DU_EDG_GPIO_INT_DU_EDGE_value = data_low
            else
                read_GPIO_G2_INT_DU_EDG_GPIO_INT_DU_EDGE_value = (data_low - H8000_0000) and GPIO_G2_INT_DU_EDG_GPIO_INT_DU_EDGE_mask
            end If
        else
            read_GPIO_G2_INT_DU_EDG_GPIO_INT_DU_EDGE_value = data_low and GPIO_G2_INT_DU_EDG_GPIO_INT_DU_EDGE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_GPIO_G2_INT_DU_EDG_GPIO_INT_DU_EDGE_value = &H0
        flag_GPIO_G2_INT_DU_EDG_GPIO_INT_DU_EDGE        = &H0
    End Sub
End Class


'' @REGISTER : GIO0_gpio_g2_int_edg_lvl_sel
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' GPIO_G2_INT_EDG_LVL_SEL_GPIO_INT_EDGE      [0:0]            get_GPIO_G2_INT_EDG_LVL_SEL_GPIO_INT_EDGE
''                                                             set_GPIO_G2_INT_EDG_LVL_SEL_GPIO_INT_EDGE
''                                                             read_GPIO_G2_INT_EDG_LVL_SEL_GPIO_INT_EDGE
''                                                             write_GPIO_G2_INT_EDG_LVL_SEL_GPIO_INT_EDGE
''---------------------------------------------------------------------------------
Class REGISTER_GIO0_gpio_g2_int_edg_lvl_sel
    Private write_GPIO_G2_INT_EDG_LVL_SEL_GPIO_INT_EDGE_value
    Private read_GPIO_G2_INT_EDG_LVL_SEL_GPIO_INT_EDGE_value
    Private flag_GPIO_G2_INT_EDG_LVL_SEL_GPIO_INT_EDGE

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

    Property Get get_GPIO_G2_INT_EDG_LVL_SEL_GPIO_INT_EDGE
        get_GPIO_G2_INT_EDG_LVL_SEL_GPIO_INT_EDGE = read_GPIO_G2_INT_EDG_LVL_SEL_GPIO_INT_EDGE_value
    End Property

    Property Let set_GPIO_G2_INT_EDG_LVL_SEL_GPIO_INT_EDGE(aData)
        write_GPIO_G2_INT_EDG_LVL_SEL_GPIO_INT_EDGE_value = aData
        flag_GPIO_G2_INT_EDG_LVL_SEL_GPIO_INT_EDGE        = &H1
    End Property

    Property Get read_GPIO_G2_INT_EDG_LVL_SEL_GPIO_INT_EDGE
        read
        read_GPIO_G2_INT_EDG_LVL_SEL_GPIO_INT_EDGE = read_GPIO_G2_INT_EDG_LVL_SEL_GPIO_INT_EDGE_value
    End Property

    Property Let write_GPIO_G2_INT_EDG_LVL_SEL_GPIO_INT_EDGE(aData)
        set_GPIO_G2_INT_EDG_LVL_SEL_GPIO_INT_EDGE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        GPIO_G2_INT_EDG_LVL_SEL_GPIO_INT_EDGE_mask = &H1
        if data_low > LONG_MAX then
            if GPIO_G2_INT_EDG_LVL_SEL_GPIO_INT_EDGE_mask = mask then
                read_GPIO_G2_INT_EDG_LVL_SEL_GPIO_INT_EDGE_value = data_low
            else
                read_GPIO_G2_INT_EDG_LVL_SEL_GPIO_INT_EDGE_value = (data_low - H8000_0000) and GPIO_G2_INT_EDG_LVL_SEL_GPIO_INT_EDGE_mask
            end If
        else
            read_GPIO_G2_INT_EDG_LVL_SEL_GPIO_INT_EDGE_value = data_low and GPIO_G2_INT_EDG_LVL_SEL_GPIO_INT_EDGE_mask
        end If

    End Sub

    Sub write
        If flag_GPIO_G2_INT_EDG_LVL_SEL_GPIO_INT_EDGE = &H0 Then read
        If flag_GPIO_G2_INT_EDG_LVL_SEL_GPIO_INT_EDGE = &H0 Then write_GPIO_G2_INT_EDG_LVL_SEL_GPIO_INT_EDGE_value = get_GPIO_G2_INT_EDG_LVL_SEL_GPIO_INT_EDGE

        regValue = leftShift((write_GPIO_G2_INT_EDG_LVL_SEL_GPIO_INT_EDGE_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        GPIO_G2_INT_EDG_LVL_SEL_GPIO_INT_EDGE_mask = &H1
        if data_low > LONG_MAX then
            if GPIO_G2_INT_EDG_LVL_SEL_GPIO_INT_EDGE_mask = mask then
                read_GPIO_G2_INT_EDG_LVL_SEL_GPIO_INT_EDGE_value = data_low
            else
                read_GPIO_G2_INT_EDG_LVL_SEL_GPIO_INT_EDGE_value = (data_low - H8000_0000) and GPIO_G2_INT_EDG_LVL_SEL_GPIO_INT_EDGE_mask
            end If
        else
            read_GPIO_G2_INT_EDG_LVL_SEL_GPIO_INT_EDGE_value = data_low and GPIO_G2_INT_EDG_LVL_SEL_GPIO_INT_EDGE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_GPIO_G2_INT_EDG_LVL_SEL_GPIO_INT_EDGE_value = &H0
        flag_GPIO_G2_INT_EDG_LVL_SEL_GPIO_INT_EDGE        = &H0
    End Sub
End Class


'' @REGISTER : GIO0_gpio_g2_int_msk
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' GPIO_G2_INT_MSK_GPIO_INT_MSK               [0:0]            get_GPIO_G2_INT_MSK_GPIO_INT_MSK
''                                                             set_GPIO_G2_INT_MSK_GPIO_INT_MSK
''                                                             read_GPIO_G2_INT_MSK_GPIO_INT_MSK
''                                                             write_GPIO_G2_INT_MSK_GPIO_INT_MSK
''---------------------------------------------------------------------------------
Class REGISTER_GIO0_gpio_g2_int_msk
    Private write_GPIO_G2_INT_MSK_GPIO_INT_MSK_value
    Private read_GPIO_G2_INT_MSK_GPIO_INT_MSK_value
    Private flag_GPIO_G2_INT_MSK_GPIO_INT_MSK

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

    Property Get get_GPIO_G2_INT_MSK_GPIO_INT_MSK
        get_GPIO_G2_INT_MSK_GPIO_INT_MSK = read_GPIO_G2_INT_MSK_GPIO_INT_MSK_value
    End Property

    Property Let set_GPIO_G2_INT_MSK_GPIO_INT_MSK(aData)
        write_GPIO_G2_INT_MSK_GPIO_INT_MSK_value = aData
        flag_GPIO_G2_INT_MSK_GPIO_INT_MSK        = &H1
    End Property

    Property Get read_GPIO_G2_INT_MSK_GPIO_INT_MSK
        read
        read_GPIO_G2_INT_MSK_GPIO_INT_MSK = read_GPIO_G2_INT_MSK_GPIO_INT_MSK_value
    End Property

    Property Let write_GPIO_G2_INT_MSK_GPIO_INT_MSK(aData)
        set_GPIO_G2_INT_MSK_GPIO_INT_MSK = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        GPIO_G2_INT_MSK_GPIO_INT_MSK_mask = &H1
        if data_low > LONG_MAX then
            if GPIO_G2_INT_MSK_GPIO_INT_MSK_mask = mask then
                read_GPIO_G2_INT_MSK_GPIO_INT_MSK_value = data_low
            else
                read_GPIO_G2_INT_MSK_GPIO_INT_MSK_value = (data_low - H8000_0000) and GPIO_G2_INT_MSK_GPIO_INT_MSK_mask
            end If
        else
            read_GPIO_G2_INT_MSK_GPIO_INT_MSK_value = data_low and GPIO_G2_INT_MSK_GPIO_INT_MSK_mask
        end If

    End Sub

    Sub write
        If flag_GPIO_G2_INT_MSK_GPIO_INT_MSK = &H0 Then read
        If flag_GPIO_G2_INT_MSK_GPIO_INT_MSK = &H0 Then write_GPIO_G2_INT_MSK_GPIO_INT_MSK_value = get_GPIO_G2_INT_MSK_GPIO_INT_MSK

        regValue = leftShift((write_GPIO_G2_INT_MSK_GPIO_INT_MSK_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        GPIO_G2_INT_MSK_GPIO_INT_MSK_mask = &H1
        if data_low > LONG_MAX then
            if GPIO_G2_INT_MSK_GPIO_INT_MSK_mask = mask then
                read_GPIO_G2_INT_MSK_GPIO_INT_MSK_value = data_low
            else
                read_GPIO_G2_INT_MSK_GPIO_INT_MSK_value = (data_low - H8000_0000) and GPIO_G2_INT_MSK_GPIO_INT_MSK_mask
            end If
        else
            read_GPIO_G2_INT_MSK_GPIO_INT_MSK_value = data_low and GPIO_G2_INT_MSK_GPIO_INT_MSK_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_GPIO_G2_INT_MSK_GPIO_INT_MSK_value = &H0
        flag_GPIO_G2_INT_MSK_GPIO_INT_MSK        = &H0
    End Sub
End Class


'' @REGISTER : GIO0_gpio_g2_int_sts
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' GPIO_G2_INT_STS_GPIO_INT_STS               [0:0]            get_GPIO_G2_INT_STS_GPIO_INT_STS
''                                                             set_GPIO_G2_INT_STS_GPIO_INT_STS
''                                                             read_GPIO_G2_INT_STS_GPIO_INT_STS
''                                                             write_GPIO_G2_INT_STS_GPIO_INT_STS
''---------------------------------------------------------------------------------
Class REGISTER_GIO0_gpio_g2_int_sts
    Private write_GPIO_G2_INT_STS_GPIO_INT_STS_value
    Private read_GPIO_G2_INT_STS_GPIO_INT_STS_value
    Private flag_GPIO_G2_INT_STS_GPIO_INT_STS

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

    Property Get get_GPIO_G2_INT_STS_GPIO_INT_STS
        get_GPIO_G2_INT_STS_GPIO_INT_STS = read_GPIO_G2_INT_STS_GPIO_INT_STS_value
    End Property

    Property Let set_GPIO_G2_INT_STS_GPIO_INT_STS(aData)
        write_GPIO_G2_INT_STS_GPIO_INT_STS_value = aData
        flag_GPIO_G2_INT_STS_GPIO_INT_STS        = &H1
    End Property

    Property Get read_GPIO_G2_INT_STS_GPIO_INT_STS
        read
        read_GPIO_G2_INT_STS_GPIO_INT_STS = read_GPIO_G2_INT_STS_GPIO_INT_STS_value
    End Property

    Property Let write_GPIO_G2_INT_STS_GPIO_INT_STS(aData)
        set_GPIO_G2_INT_STS_GPIO_INT_STS = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        GPIO_G2_INT_STS_GPIO_INT_STS_mask = &H1
        if data_low > LONG_MAX then
            if GPIO_G2_INT_STS_GPIO_INT_STS_mask = mask then
                read_GPIO_G2_INT_STS_GPIO_INT_STS_value = data_low
            else
                read_GPIO_G2_INT_STS_GPIO_INT_STS_value = (data_low - H8000_0000) and GPIO_G2_INT_STS_GPIO_INT_STS_mask
            end If
        else
            read_GPIO_G2_INT_STS_GPIO_INT_STS_value = data_low and GPIO_G2_INT_STS_GPIO_INT_STS_mask
        end If

    End Sub

    Sub write
        If flag_GPIO_G2_INT_STS_GPIO_INT_STS = &H0 Then read
        If flag_GPIO_G2_INT_STS_GPIO_INT_STS = &H0 Then write_GPIO_G2_INT_STS_GPIO_INT_STS_value = get_GPIO_G2_INT_STS_GPIO_INT_STS

        regValue = leftShift((write_GPIO_G2_INT_STS_GPIO_INT_STS_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        GPIO_G2_INT_STS_GPIO_INT_STS_mask = &H1
        if data_low > LONG_MAX then
            if GPIO_G2_INT_STS_GPIO_INT_STS_mask = mask then
                read_GPIO_G2_INT_STS_GPIO_INT_STS_value = data_low
            else
                read_GPIO_G2_INT_STS_GPIO_INT_STS_value = (data_low - H8000_0000) and GPIO_G2_INT_STS_GPIO_INT_STS_mask
            end If
        else
            read_GPIO_G2_INT_STS_GPIO_INT_STS_value = data_low and GPIO_G2_INT_STS_GPIO_INT_STS_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_GPIO_G2_INT_STS_GPIO_INT_STS_value = &H0
        flag_GPIO_G2_INT_STS_GPIO_INT_STS        = &H0
    End Sub
End Class


'' @REGISTER : GIO0_gpio_g2_int_msk_sts
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' GPIO_G2_INT_MSK_STS_GPIO_INT_MSK_STS       [0:0]            get_GPIO_G2_INT_MSK_STS_GPIO_INT_MSK_STS
''                                                             set_GPIO_G2_INT_MSK_STS_GPIO_INT_MSK_STS
''                                                             read_GPIO_G2_INT_MSK_STS_GPIO_INT_MSK_STS
''                                                             write_GPIO_G2_INT_MSK_STS_GPIO_INT_MSK_STS
''---------------------------------------------------------------------------------
Class REGISTER_GIO0_gpio_g2_int_msk_sts
    Private write_GPIO_G2_INT_MSK_STS_GPIO_INT_MSK_STS_value
    Private read_GPIO_G2_INT_MSK_STS_GPIO_INT_MSK_STS_value
    Private flag_GPIO_G2_INT_MSK_STS_GPIO_INT_MSK_STS

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

    Property Get get_GPIO_G2_INT_MSK_STS_GPIO_INT_MSK_STS
        get_GPIO_G2_INT_MSK_STS_GPIO_INT_MSK_STS = read_GPIO_G2_INT_MSK_STS_GPIO_INT_MSK_STS_value
    End Property

    Property Let set_GPIO_G2_INT_MSK_STS_GPIO_INT_MSK_STS(aData)
        write_GPIO_G2_INT_MSK_STS_GPIO_INT_MSK_STS_value = aData
        flag_GPIO_G2_INT_MSK_STS_GPIO_INT_MSK_STS        = &H1
    End Property

    Property Get read_GPIO_G2_INT_MSK_STS_GPIO_INT_MSK_STS
        read
        read_GPIO_G2_INT_MSK_STS_GPIO_INT_MSK_STS = read_GPIO_G2_INT_MSK_STS_GPIO_INT_MSK_STS_value
    End Property

    Property Let write_GPIO_G2_INT_MSK_STS_GPIO_INT_MSK_STS(aData)
        set_GPIO_G2_INT_MSK_STS_GPIO_INT_MSK_STS = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        GPIO_G2_INT_MSK_STS_GPIO_INT_MSK_STS_mask = &H1
        if data_low > LONG_MAX then
            if GPIO_G2_INT_MSK_STS_GPIO_INT_MSK_STS_mask = mask then
                read_GPIO_G2_INT_MSK_STS_GPIO_INT_MSK_STS_value = data_low
            else
                read_GPIO_G2_INT_MSK_STS_GPIO_INT_MSK_STS_value = (data_low - H8000_0000) and GPIO_G2_INT_MSK_STS_GPIO_INT_MSK_STS_mask
            end If
        else
            read_GPIO_G2_INT_MSK_STS_GPIO_INT_MSK_STS_value = data_low and GPIO_G2_INT_MSK_STS_GPIO_INT_MSK_STS_mask
        end If

    End Sub

    Sub write
        If flag_GPIO_G2_INT_MSK_STS_GPIO_INT_MSK_STS = &H0 Then read
        If flag_GPIO_G2_INT_MSK_STS_GPIO_INT_MSK_STS = &H0 Then write_GPIO_G2_INT_MSK_STS_GPIO_INT_MSK_STS_value = get_GPIO_G2_INT_MSK_STS_GPIO_INT_MSK_STS

        regValue = leftShift((write_GPIO_G2_INT_MSK_STS_GPIO_INT_MSK_STS_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        GPIO_G2_INT_MSK_STS_GPIO_INT_MSK_STS_mask = &H1
        if data_low > LONG_MAX then
            if GPIO_G2_INT_MSK_STS_GPIO_INT_MSK_STS_mask = mask then
                read_GPIO_G2_INT_MSK_STS_GPIO_INT_MSK_STS_value = data_low
            else
                read_GPIO_G2_INT_MSK_STS_GPIO_INT_MSK_STS_value = (data_low - H8000_0000) and GPIO_G2_INT_MSK_STS_GPIO_INT_MSK_STS_mask
            end If
        else
            read_GPIO_G2_INT_MSK_STS_GPIO_INT_MSK_STS_value = data_low and GPIO_G2_INT_MSK_STS_GPIO_INT_MSK_STS_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_GPIO_G2_INT_MSK_STS_GPIO_INT_MSK_STS_value = &H0
        flag_GPIO_G2_INT_MSK_STS_GPIO_INT_MSK_STS        = &H0
    End Sub
End Class


'' @REGISTER : GIO0_gpio_g2_int_clr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' GPIO_G2_INT_CLR_GPIO_INT_CLR               [0:0]            get_GPIO_G2_INT_CLR_GPIO_INT_CLR
''                                                             set_GPIO_G2_INT_CLR_GPIO_INT_CLR
''                                                             read_GPIO_G2_INT_CLR_GPIO_INT_CLR
''                                                             write_GPIO_G2_INT_CLR_GPIO_INT_CLR
''---------------------------------------------------------------------------------
Class REGISTER_GIO0_gpio_g2_int_clr
    Private write_GPIO_G2_INT_CLR_GPIO_INT_CLR_value
    Private read_GPIO_G2_INT_CLR_GPIO_INT_CLR_value
    Private flag_GPIO_G2_INT_CLR_GPIO_INT_CLR

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

    Property Get get_GPIO_G2_INT_CLR_GPIO_INT_CLR
        get_GPIO_G2_INT_CLR_GPIO_INT_CLR = read_GPIO_G2_INT_CLR_GPIO_INT_CLR_value
    End Property

    Property Let set_GPIO_G2_INT_CLR_GPIO_INT_CLR(aData)
        write_GPIO_G2_INT_CLR_GPIO_INT_CLR_value = aData
        flag_GPIO_G2_INT_CLR_GPIO_INT_CLR        = &H1
    End Property

    Property Get read_GPIO_G2_INT_CLR_GPIO_INT_CLR
        read
        read_GPIO_G2_INT_CLR_GPIO_INT_CLR = read_GPIO_G2_INT_CLR_GPIO_INT_CLR_value
    End Property

    Property Let write_GPIO_G2_INT_CLR_GPIO_INT_CLR(aData)
        set_GPIO_G2_INT_CLR_GPIO_INT_CLR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        GPIO_G2_INT_CLR_GPIO_INT_CLR_mask = &H1
        if data_low > LONG_MAX then
            if GPIO_G2_INT_CLR_GPIO_INT_CLR_mask = mask then
                read_GPIO_G2_INT_CLR_GPIO_INT_CLR_value = data_low
            else
                read_GPIO_G2_INT_CLR_GPIO_INT_CLR_value = (data_low - H8000_0000) and GPIO_G2_INT_CLR_GPIO_INT_CLR_mask
            end If
        else
            read_GPIO_G2_INT_CLR_GPIO_INT_CLR_value = data_low and GPIO_G2_INT_CLR_GPIO_INT_CLR_mask
        end If

    End Sub

    Sub write
        If flag_GPIO_G2_INT_CLR_GPIO_INT_CLR = &H0 Then read
        If flag_GPIO_G2_INT_CLR_GPIO_INT_CLR = &H0 Then write_GPIO_G2_INT_CLR_GPIO_INT_CLR_value = get_GPIO_G2_INT_CLR_GPIO_INT_CLR

        regValue = leftShift((write_GPIO_G2_INT_CLR_GPIO_INT_CLR_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        GPIO_G2_INT_CLR_GPIO_INT_CLR_mask = &H1
        if data_low > LONG_MAX then
            if GPIO_G2_INT_CLR_GPIO_INT_CLR_mask = mask then
                read_GPIO_G2_INT_CLR_GPIO_INT_CLR_value = data_low
            else
                read_GPIO_G2_INT_CLR_GPIO_INT_CLR_value = (data_low - H8000_0000) and GPIO_G2_INT_CLR_GPIO_INT_CLR_mask
            end If
        else
            read_GPIO_G2_INT_CLR_GPIO_INT_CLR_value = data_low and GPIO_G2_INT_CLR_GPIO_INT_CLR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_GPIO_G2_INT_CLR_GPIO_INT_CLR_value = &H0
        flag_GPIO_G2_INT_CLR_GPIO_INT_CLR        = &H0
    End Sub
End Class


'' @REGISTER : GIO0_gpio_g2_flash_sel
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' GPIO_G2_FLASH_SEL_RESERVED_1               [3:1]            get_GPIO_G2_FLASH_SEL_RESERVED_1
''                                                             set_GPIO_G2_FLASH_SEL_RESERVED_1
''                                                             read_GPIO_G2_FLASH_SEL_RESERVED_1
''                                                             write_GPIO_G2_FLASH_SEL_RESERVED_1
''---------------------------------------------------------------------------------
'' GPIO_FLASH_CS_MUX_SEL                      [0:0]            get_GPIO_FLASH_CS_MUX_SEL
''                                                             set_GPIO_FLASH_CS_MUX_SEL
''                                                             read_GPIO_FLASH_CS_MUX_SEL
''                                                             write_GPIO_FLASH_CS_MUX_SEL
''---------------------------------------------------------------------------------
Class REGISTER_GIO0_gpio_g2_flash_sel
    Private write_GPIO_G2_FLASH_SEL_RESERVED_1_value
    Private read_GPIO_G2_FLASH_SEL_RESERVED_1_value
    Private flag_GPIO_G2_FLASH_SEL_RESERVED_1
    Private write_GPIO_FLASH_CS_MUX_SEL_value
    Private read_GPIO_FLASH_CS_MUX_SEL_value
    Private flag_GPIO_FLASH_CS_MUX_SEL

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

    Property Get get_GPIO_G2_FLASH_SEL_RESERVED_1
        get_GPIO_G2_FLASH_SEL_RESERVED_1 = read_GPIO_G2_FLASH_SEL_RESERVED_1_value
    End Property

    Property Let set_GPIO_G2_FLASH_SEL_RESERVED_1(aData)
        write_GPIO_G2_FLASH_SEL_RESERVED_1_value = aData
        flag_GPIO_G2_FLASH_SEL_RESERVED_1        = &H1
    End Property

    Property Get read_GPIO_G2_FLASH_SEL_RESERVED_1
        read
        read_GPIO_G2_FLASH_SEL_RESERVED_1 = read_GPIO_G2_FLASH_SEL_RESERVED_1_value
    End Property

    Property Let write_GPIO_G2_FLASH_SEL_RESERVED_1(aData)
        set_GPIO_G2_FLASH_SEL_RESERVED_1 = aData
        write
    End Property

    Property Get get_GPIO_FLASH_CS_MUX_SEL
        get_GPIO_FLASH_CS_MUX_SEL = read_GPIO_FLASH_CS_MUX_SEL_value
    End Property

    Property Let set_GPIO_FLASH_CS_MUX_SEL(aData)
        write_GPIO_FLASH_CS_MUX_SEL_value = aData
        flag_GPIO_FLASH_CS_MUX_SEL        = &H1
    End Property

    Property Get read_GPIO_FLASH_CS_MUX_SEL
        read
        read_GPIO_FLASH_CS_MUX_SEL = read_GPIO_FLASH_CS_MUX_SEL_value
    End Property

    Property Let write_GPIO_FLASH_CS_MUX_SEL(aData)
        set_GPIO_FLASH_CS_MUX_SEL = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_GPIO_G2_FLASH_SEL_RESERVED_1_value = rightShift(data_low, 1) and &H7
        GPIO_FLASH_CS_MUX_SEL_mask = &H1
        if data_low > LONG_MAX then
            if GPIO_FLASH_CS_MUX_SEL_mask = mask then
                read_GPIO_FLASH_CS_MUX_SEL_value = data_low
            else
                read_GPIO_FLASH_CS_MUX_SEL_value = (data_low - H8000_0000) and GPIO_FLASH_CS_MUX_SEL_mask
            end If
        else
            read_GPIO_FLASH_CS_MUX_SEL_value = data_low and GPIO_FLASH_CS_MUX_SEL_mask
        end If

    End Sub

    Sub write
        If flag_GPIO_G2_FLASH_SEL_RESERVED_1 = &H0 or flag_GPIO_FLASH_CS_MUX_SEL = &H0 Then read
        If flag_GPIO_G2_FLASH_SEL_RESERVED_1 = &H0 Then write_GPIO_G2_FLASH_SEL_RESERVED_1_value = get_GPIO_G2_FLASH_SEL_RESERVED_1
        If flag_GPIO_FLASH_CS_MUX_SEL = &H0 Then write_GPIO_FLASH_CS_MUX_SEL_value = get_GPIO_FLASH_CS_MUX_SEL

        regValue = leftShift((write_GPIO_G2_FLASH_SEL_RESERVED_1_value and &H7), 1) + leftShift((write_GPIO_FLASH_CS_MUX_SEL_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_GPIO_G2_FLASH_SEL_RESERVED_1_value = rightShift(data_low, 1) and &H7
        GPIO_FLASH_CS_MUX_SEL_mask = &H1
        if data_low > LONG_MAX then
            if GPIO_FLASH_CS_MUX_SEL_mask = mask then
                read_GPIO_FLASH_CS_MUX_SEL_value = data_low
            else
                read_GPIO_FLASH_CS_MUX_SEL_value = (data_low - H8000_0000) and GPIO_FLASH_CS_MUX_SEL_mask
            end If
        else
            read_GPIO_FLASH_CS_MUX_SEL_value = data_low and GPIO_FLASH_CS_MUX_SEL_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_GPIO_G2_FLASH_SEL_RESERVED_1_value = &H0
        flag_GPIO_G2_FLASH_SEL_RESERVED_1        = &H0
        write_GPIO_FLASH_CS_MUX_SEL_value = &H0
        flag_GPIO_FLASH_CS_MUX_SEL        = &H0
    End Sub
End Class


'' @REGISTER : GIO0_gpio_g2_int_pol
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' GPIO_G2_INT_POL_RESERVED_1                 [4:2]            get_GPIO_G2_INT_POL_RESERVED_1
''                                                             set_GPIO_G2_INT_POL_RESERVED_1
''                                                             read_GPIO_G2_INT_POL_RESERVED_1
''                                                             write_GPIO_G2_INT_POL_RESERVED_1
''---------------------------------------------------------------------------------
'' GPIO_G2_INT_POL_GPIO_INT_POL               [1:1]            get_GPIO_G2_INT_POL_GPIO_INT_POL
''                                                             set_GPIO_G2_INT_POL_GPIO_INT_POL
''                                                             read_GPIO_G2_INT_POL_GPIO_INT_POL
''                                                             write_GPIO_G2_INT_POL_GPIO_INT_POL
''---------------------------------------------------------------------------------
Class REGISTER_GIO0_gpio_g2_int_pol
    Private write_GPIO_G2_INT_POL_RESERVED_1_value
    Private read_GPIO_G2_INT_POL_RESERVED_1_value
    Private flag_GPIO_G2_INT_POL_RESERVED_1
    Private write_GPIO_G2_INT_POL_GPIO_INT_POL_value
    Private read_GPIO_G2_INT_POL_GPIO_INT_POL_value
    Private flag_GPIO_G2_INT_POL_GPIO_INT_POL

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

    Property Get get_GPIO_G2_INT_POL_RESERVED_1
        get_GPIO_G2_INT_POL_RESERVED_1 = read_GPIO_G2_INT_POL_RESERVED_1_value
    End Property

    Property Let set_GPIO_G2_INT_POL_RESERVED_1(aData)
        write_GPIO_G2_INT_POL_RESERVED_1_value = aData
        flag_GPIO_G2_INT_POL_RESERVED_1        = &H1
    End Property

    Property Get read_GPIO_G2_INT_POL_RESERVED_1
        read
        read_GPIO_G2_INT_POL_RESERVED_1 = read_GPIO_G2_INT_POL_RESERVED_1_value
    End Property

    Property Let write_GPIO_G2_INT_POL_RESERVED_1(aData)
        set_GPIO_G2_INT_POL_RESERVED_1 = aData
        write
    End Property

    Property Get get_GPIO_G2_INT_POL_GPIO_INT_POL
        get_GPIO_G2_INT_POL_GPIO_INT_POL = read_GPIO_G2_INT_POL_GPIO_INT_POL_value
    End Property

    Property Let set_GPIO_G2_INT_POL_GPIO_INT_POL(aData)
        write_GPIO_G2_INT_POL_GPIO_INT_POL_value = aData
        flag_GPIO_G2_INT_POL_GPIO_INT_POL        = &H1
    End Property

    Property Get read_GPIO_G2_INT_POL_GPIO_INT_POL
        read
        read_GPIO_G2_INT_POL_GPIO_INT_POL = read_GPIO_G2_INT_POL_GPIO_INT_POL_value
    End Property

    Property Let write_GPIO_G2_INT_POL_GPIO_INT_POL(aData)
        set_GPIO_G2_INT_POL_GPIO_INT_POL = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_GPIO_G2_INT_POL_RESERVED_1_value = rightShift(data_low, 2) and &H7
        read_GPIO_G2_INT_POL_GPIO_INT_POL_value = rightShift(data_low, 1) and &H1

    End Sub

    Sub write
        If flag_GPIO_G2_INT_POL_RESERVED_1 = &H0 or flag_GPIO_G2_INT_POL_GPIO_INT_POL = &H0 Then read
        If flag_GPIO_G2_INT_POL_RESERVED_1 = &H0 Then write_GPIO_G2_INT_POL_RESERVED_1_value = get_GPIO_G2_INT_POL_RESERVED_1
        If flag_GPIO_G2_INT_POL_GPIO_INT_POL = &H0 Then write_GPIO_G2_INT_POL_GPIO_INT_POL_value = get_GPIO_G2_INT_POL_GPIO_INT_POL

        regValue = leftShift((write_GPIO_G2_INT_POL_RESERVED_1_value and &H7), 2) + leftShift((write_GPIO_G2_INT_POL_GPIO_INT_POL_value and &H1), 1)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_GPIO_G2_INT_POL_RESERVED_1_value = rightShift(data_low, 2) and &H7
        read_GPIO_G2_INT_POL_GPIO_INT_POL_value = rightShift(data_low, 1) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_GPIO_G2_INT_POL_RESERVED_1_value = &H0
        flag_GPIO_G2_INT_POL_RESERVED_1        = &H0
        write_GPIO_G2_INT_POL_GPIO_INT_POL_value = &H0
        flag_GPIO_G2_INT_POL_GPIO_INT_POL        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class GIO0_INSTANCE

    Public gpio_g0_din
    Public gpio_g0_dout
    Public gpio_g0_drv_en
    Public gpio_g0_int_typ
    Public gpio_g0_int_du_edg
    Public gpio_g0_int_edg_lvl_sel
    Public gpio_g0_int_msk
    Public gpio_g0_int_sts
    Public gpio_g0_int_msk_sts
    Public gpio_g0_int_clr
    Public gpio_g0_i2c_sel
    Public gpio_g0_int_pol
    Public gpio_g1_din
    Public gpio_g1_dout
    Public gpio_g1_drv_en
    Public gpio_g1_int_typ
    Public gpio_g1_int_du_edg
    Public gpio_g1_int_edg_lvl_sel
    Public gpio_g1_int_msk
    Public gpio_g1_int_sts
    Public gpio_g1_int_msk_sts
    Public gpio_g1_int_clr
    Public gpio_g1_pwm_sel
    Public gpio_g1_sec_cfg
    Public gpio_g1_init
    Public gpio_g1_pad_res
    Public gpio_g1_pad_resis_en
    Public gpio_g1_tst_in
    Public gpio_g1_tst_out
    Public gpio_g1_tst_in_en
    Public gpio_g1_pwr_fail_tri_sts
    Public gpio_g1_pwr_fail_tri_en
    Public gpio_g1_hyster_en
    Public gpio_g1_slew_ctrl
    Public gpio_g1_drv_sel_0
    Public gpio_g1_drv_sel_1
    Public gpio_g1_drv_sel_2
    Public gpio_g1_aux_sel
    Public gpio_g1_int_pol
    Public flash_cs_din
    Public flash_cs_dout
    Public flash_cs_oe
    Public gpio_g2_int_typ
    Public gpio_g2_int_du_edg
    Public gpio_g2_int_edg_lvl_sel
    Public gpio_g2_int_msk
    Public gpio_g2_int_sts
    Public gpio_g2_int_msk_sts
    Public gpio_g2_int_clr
    Public gpio_g2_flash_sel
    Public gpio_g2_int_pol


    Public default function Init(aBaseAddr)
        Set gpio_g0_din = (New REGISTER_GIO0_gpio_g0_din)(aBaseAddr, 32)
        Set gpio_g0_dout = (New REGISTER_GIO0_gpio_g0_dout)(aBaseAddr, 32)
        Set gpio_g0_drv_en = (New REGISTER_GIO0_gpio_g0_drv_en)(aBaseAddr, 32)
        Set gpio_g0_int_typ = (New REGISTER_GIO0_gpio_g0_int_typ)(aBaseAddr, 32)
        Set gpio_g0_int_du_edg = (New REGISTER_GIO0_gpio_g0_int_du_edg)(aBaseAddr, 32)
        Set gpio_g0_int_edg_lvl_sel = (New REGISTER_GIO0_gpio_g0_int_edg_lvl_sel)(aBaseAddr, 32)
        Set gpio_g0_int_msk = (New REGISTER_GIO0_gpio_g0_int_msk)(aBaseAddr, 32)
        Set gpio_g0_int_sts = (New REGISTER_GIO0_gpio_g0_int_sts)(aBaseAddr, 32)
        Set gpio_g0_int_msk_sts = (New REGISTER_GIO0_gpio_g0_int_msk_sts)(aBaseAddr, 32)
        Set gpio_g0_int_clr = (New REGISTER_GIO0_gpio_g0_int_clr)(aBaseAddr, 32)
        Set gpio_g0_i2c_sel = (New REGISTER_GIO0_gpio_g0_i2c_sel)(aBaseAddr, 32)
        Set gpio_g0_int_pol = (New REGISTER_GIO0_gpio_g0_int_pol)(aBaseAddr, 32)
        Set gpio_g1_din = (New REGISTER_GIO0_gpio_g1_din)(aBaseAddr, 32)
        Set gpio_g1_dout = (New REGISTER_GIO0_gpio_g1_dout)(aBaseAddr, 32)
        Set gpio_g1_drv_en = (New REGISTER_GIO0_gpio_g1_drv_en)(aBaseAddr, 32)
        Set gpio_g1_int_typ = (New REGISTER_GIO0_gpio_g1_int_typ)(aBaseAddr, 32)
        Set gpio_g1_int_du_edg = (New REGISTER_GIO0_gpio_g1_int_du_edg)(aBaseAddr, 32)
        Set gpio_g1_int_edg_lvl_sel = (New REGISTER_GIO0_gpio_g1_int_edg_lvl_sel)(aBaseAddr, 32)
        Set gpio_g1_int_msk = (New REGISTER_GIO0_gpio_g1_int_msk)(aBaseAddr, 32)
        Set gpio_g1_int_sts = (New REGISTER_GIO0_gpio_g1_int_sts)(aBaseAddr, 32)
        Set gpio_g1_int_msk_sts = (New REGISTER_GIO0_gpio_g1_int_msk_sts)(aBaseAddr, 32)
        Set gpio_g1_int_clr = (New REGISTER_GIO0_gpio_g1_int_clr)(aBaseAddr, 32)
        Set gpio_g1_pwm_sel = (New REGISTER_GIO0_gpio_g1_pwm_sel)(aBaseAddr, 32)
        Set gpio_g1_sec_cfg = (New REGISTER_GIO0_gpio_g1_sec_cfg)(aBaseAddr, 32)
        Set gpio_g1_init = (New REGISTER_GIO0_gpio_g1_init)(aBaseAddr, 32)
        Set gpio_g1_pad_res = (New REGISTER_GIO0_gpio_g1_pad_res)(aBaseAddr, 32)
        Set gpio_g1_pad_resis_en = (New REGISTER_GIO0_gpio_g1_pad_resis_en)(aBaseAddr, 32)
        Set gpio_g1_tst_in = (New REGISTER_GIO0_gpio_g1_tst_in)(aBaseAddr, 32)
        Set gpio_g1_tst_out = (New REGISTER_GIO0_gpio_g1_tst_out)(aBaseAddr, 32)
        Set gpio_g1_tst_in_en = (New REGISTER_GIO0_gpio_g1_tst_in_en)(aBaseAddr, 32)
        Set gpio_g1_pwr_fail_tri_sts = (New REGISTER_GIO0_gpio_g1_pwr_fail_tri_sts)(aBaseAddr, 32)
        Set gpio_g1_pwr_fail_tri_en = (New REGISTER_GIO0_gpio_g1_pwr_fail_tri_en)(aBaseAddr, 32)
        Set gpio_g1_hyster_en = (New REGISTER_GIO0_gpio_g1_hyster_en)(aBaseAddr, 32)
        Set gpio_g1_slew_ctrl = (New REGISTER_GIO0_gpio_g1_slew_ctrl)(aBaseAddr, 32)
        Set gpio_g1_drv_sel_0 = (New REGISTER_GIO0_gpio_g1_drv_sel_0)(aBaseAddr, 32)
        Set gpio_g1_drv_sel_1 = (New REGISTER_GIO0_gpio_g1_drv_sel_1)(aBaseAddr, 32)
        Set gpio_g1_drv_sel_2 = (New REGISTER_GIO0_gpio_g1_drv_sel_2)(aBaseAddr, 32)
        Set gpio_g1_aux_sel = (New REGISTER_GIO0_gpio_g1_aux_sel)(aBaseAddr, 32)
        Set gpio_g1_int_pol = (New REGISTER_GIO0_gpio_g1_int_pol)(aBaseAddr, 32)
        Set flash_cs_din = (New REGISTER_GIO0_flash_cs_din)(aBaseAddr, 32)
        Set flash_cs_dout = (New REGISTER_GIO0_flash_cs_dout)(aBaseAddr, 32)
        Set flash_cs_oe = (New REGISTER_GIO0_flash_cs_oe)(aBaseAddr, 32)
        Set gpio_g2_int_typ = (New REGISTER_GIO0_gpio_g2_int_typ)(aBaseAddr, 32)
        Set gpio_g2_int_du_edg = (New REGISTER_GIO0_gpio_g2_int_du_edg)(aBaseAddr, 32)
        Set gpio_g2_int_edg_lvl_sel = (New REGISTER_GIO0_gpio_g2_int_edg_lvl_sel)(aBaseAddr, 32)
        Set gpio_g2_int_msk = (New REGISTER_GIO0_gpio_g2_int_msk)(aBaseAddr, 32)
        Set gpio_g2_int_sts = (New REGISTER_GIO0_gpio_g2_int_sts)(aBaseAddr, 32)
        Set gpio_g2_int_msk_sts = (New REGISTER_GIO0_gpio_g2_int_msk_sts)(aBaseAddr, 32)
        Set gpio_g2_int_clr = (New REGISTER_GIO0_gpio_g2_int_clr)(aBaseAddr, 32)
        Set gpio_g2_flash_sel = (New REGISTER_GIO0_gpio_g2_flash_sel)(aBaseAddr, 32)
        Set gpio_g2_int_pol = (New REGISTER_GIO0_gpio_g2_int_pol)(aBaseAddr, 32)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set GIO0 = CreateObject("System.Collections.ArrayList")
GIO0.Add ((New GIO0_INSTANCE)(&H4014c000))


