

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


'' @REGISTER : BRPHY_1G_1PORT_MISC_top_misc_register_1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TOP_MISC_REGISTER_BITS                     [15:3]           get_TOP_MISC_REGISTER_BITS
''                                                             set_TOP_MISC_REGISTER_BITS
''                                                             read_TOP_MISC_REGISTER_BITS
''                                                             write_TOP_MISC_REGISTER_BITS
''---------------------------------------------------------------------------------
'' ACD_mode                                   [2:2]            get_ACD_mode
''                                                             set_ACD_mode
''                                                             read_ACD_mode
''                                                             write_ACD_mode
''---------------------------------------------------------------------------------
'' Not_used                                   [1:1]            get_Not_used
''                                                             set_Not_used
''                                                             read_Not_used
''                                                             write_Not_used
''---------------------------------------------------------------------------------
'' DISABLE_MDIO_PREAMBLE                      [0:0]            get_DISABLE_MDIO_PREAMBLE
''                                                             set_DISABLE_MDIO_PREAMBLE
''                                                             read_DISABLE_MDIO_PREAMBLE
''                                                             write_DISABLE_MDIO_PREAMBLE
''---------------------------------------------------------------------------------
Class REGISTER_BRPHY_1G_1PORT_MISC_top_misc_register_1
    Private write_TOP_MISC_REGISTER_BITS_value
    Private read_TOP_MISC_REGISTER_BITS_value
    Private flag_TOP_MISC_REGISTER_BITS
    Private write_ACD_mode_value
    Private read_ACD_mode_value
    Private flag_ACD_mode
    Private write_Not_used_value
    Private read_Not_used_value
    Private flag_Not_used
    Private write_DISABLE_MDIO_PREAMBLE_value
    Private read_DISABLE_MDIO_PREAMBLE_value
    Private flag_DISABLE_MDIO_PREAMBLE

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

    Property Get get_TOP_MISC_REGISTER_BITS
        get_TOP_MISC_REGISTER_BITS = read_TOP_MISC_REGISTER_BITS_value
    End Property

    Property Let set_TOP_MISC_REGISTER_BITS(aData)
        write_TOP_MISC_REGISTER_BITS_value = aData
        flag_TOP_MISC_REGISTER_BITS        = &H1
    End Property

    Property Get read_TOP_MISC_REGISTER_BITS
        read
        read_TOP_MISC_REGISTER_BITS = read_TOP_MISC_REGISTER_BITS_value
    End Property

    Property Let write_TOP_MISC_REGISTER_BITS(aData)
        set_TOP_MISC_REGISTER_BITS = aData
        write
    End Property

    Property Get get_ACD_mode
        get_ACD_mode = read_ACD_mode_value
    End Property

    Property Let set_ACD_mode(aData)
        write_ACD_mode_value = aData
        flag_ACD_mode        = &H1
    End Property

    Property Get read_ACD_mode
        read
        read_ACD_mode = read_ACD_mode_value
    End Property

    Property Let write_ACD_mode(aData)
        set_ACD_mode = aData
        write
    End Property

    Property Get get_Not_used
        get_Not_used = read_Not_used_value
    End Property

    Property Let set_Not_used(aData)
        write_Not_used_value = aData
        flag_Not_used        = &H1
    End Property

    Property Get read_Not_used
        read
        read_Not_used = read_Not_used_value
    End Property

    Property Let write_Not_used(aData)
        set_Not_used = aData
        write
    End Property

    Property Get get_DISABLE_MDIO_PREAMBLE
        get_DISABLE_MDIO_PREAMBLE = read_DISABLE_MDIO_PREAMBLE_value
    End Property

    Property Let set_DISABLE_MDIO_PREAMBLE(aData)
        write_DISABLE_MDIO_PREAMBLE_value = aData
        flag_DISABLE_MDIO_PREAMBLE        = &H1
    End Property

    Property Get read_DISABLE_MDIO_PREAMBLE
        read
        read_DISABLE_MDIO_PREAMBLE = read_DISABLE_MDIO_PREAMBLE_value
    End Property

    Property Let write_DISABLE_MDIO_PREAMBLE(aData)
        set_DISABLE_MDIO_PREAMBLE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TOP_MISC_REGISTER_BITS_value = rightShift(data_low, 3) and &H1fff
        read_ACD_mode_value = rightShift(data_low, 2) and &H1
        read_Not_used_value = rightShift(data_low, 1) and &H1
        DISABLE_MDIO_PREAMBLE_mask = &H1
        if data_low > LONG_MAX then
            if DISABLE_MDIO_PREAMBLE_mask = mask then
                read_DISABLE_MDIO_PREAMBLE_value = data_low
            else
                read_DISABLE_MDIO_PREAMBLE_value = (data_low - H8000_0000) and DISABLE_MDIO_PREAMBLE_mask
            end If
        else
            read_DISABLE_MDIO_PREAMBLE_value = data_low and DISABLE_MDIO_PREAMBLE_mask
        end If

    End Sub

    Sub write
        If flag_TOP_MISC_REGISTER_BITS = &H0 or flag_ACD_mode = &H0 or flag_Not_used = &H0 or flag_DISABLE_MDIO_PREAMBLE = &H0 Then read
        If flag_TOP_MISC_REGISTER_BITS = &H0 Then write_TOP_MISC_REGISTER_BITS_value = get_TOP_MISC_REGISTER_BITS
        If flag_ACD_mode = &H0 Then write_ACD_mode_value = get_ACD_mode
        If flag_Not_used = &H0 Then write_Not_used_value = get_Not_used
        If flag_DISABLE_MDIO_PREAMBLE = &H0 Then write_DISABLE_MDIO_PREAMBLE_value = get_DISABLE_MDIO_PREAMBLE

        regValue = leftShift((write_TOP_MISC_REGISTER_BITS_value and &H1fff), 3) + leftShift((write_ACD_mode_value and &H1), 2) + leftShift((write_Not_used_value and &H1), 1) + leftShift((write_DISABLE_MDIO_PREAMBLE_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TOP_MISC_REGISTER_BITS_value = rightShift(data_low, 3) and &H1fff
        read_ACD_mode_value = rightShift(data_low, 2) and &H1
        read_Not_used_value = rightShift(data_low, 1) and &H1
        DISABLE_MDIO_PREAMBLE_mask = &H1
        if data_low > LONG_MAX then
            if DISABLE_MDIO_PREAMBLE_mask = mask then
                read_DISABLE_MDIO_PREAMBLE_value = data_low
            else
                read_DISABLE_MDIO_PREAMBLE_value = (data_low - H8000_0000) and DISABLE_MDIO_PREAMBLE_mask
            end If
        else
            read_DISABLE_MDIO_PREAMBLE_value = data_low and DISABLE_MDIO_PREAMBLE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TOP_MISC_REGISTER_BITS_value = &H0
        flag_TOP_MISC_REGISTER_BITS        = &H0
        write_ACD_mode_value = &H0
        flag_ACD_mode        = &H0
        write_Not_used_value = &H0
        flag_Not_used        = &H0
        write_DISABLE_MDIO_PREAMBLE_value = &H0
        flag_DISABLE_MDIO_PREAMBLE        = &H0
    End Sub
End Class


'' @REGISTER : BRPHY_1G_1PORT_MISC_test_select_mode
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TEST_BUS_MODE                              [7:4]            get_TEST_BUS_MODE
''                                                             set_TEST_BUS_MODE
''                                                             read_TEST_BUS_MODE
''                                                             write_TEST_BUS_MODE
''---------------------------------------------------------------------------------
'' XORTREE_MODE                               [1:1]            get_XORTREE_MODE
''                                                             set_XORTREE_MODE
''                                                             read_XORTREE_MODE
''                                                             write_XORTREE_MODE
''---------------------------------------------------------------------------------
'' IDDQ_MODE                                  [0:0]            get_IDDQ_MODE
''                                                             set_IDDQ_MODE
''                                                             read_IDDQ_MODE
''                                                             write_IDDQ_MODE
''---------------------------------------------------------------------------------
Class REGISTER_BRPHY_1G_1PORT_MISC_test_select_mode
    Private write_TEST_BUS_MODE_value
    Private read_TEST_BUS_MODE_value
    Private flag_TEST_BUS_MODE
    Private write_XORTREE_MODE_value
    Private read_XORTREE_MODE_value
    Private flag_XORTREE_MODE
    Private write_IDDQ_MODE_value
    Private read_IDDQ_MODE_value
    Private flag_IDDQ_MODE

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

    Property Get get_TEST_BUS_MODE
        get_TEST_BUS_MODE = read_TEST_BUS_MODE_value
    End Property

    Property Let set_TEST_BUS_MODE(aData)
        write_TEST_BUS_MODE_value = aData
        flag_TEST_BUS_MODE        = &H1
    End Property

    Property Get read_TEST_BUS_MODE
        read
        read_TEST_BUS_MODE = read_TEST_BUS_MODE_value
    End Property

    Property Let write_TEST_BUS_MODE(aData)
        set_TEST_BUS_MODE = aData
        write
    End Property

    Property Get get_XORTREE_MODE
        get_XORTREE_MODE = read_XORTREE_MODE_value
    End Property

    Property Let set_XORTREE_MODE(aData)
        write_XORTREE_MODE_value = aData
        flag_XORTREE_MODE        = &H1
    End Property

    Property Get read_XORTREE_MODE
        read
        read_XORTREE_MODE = read_XORTREE_MODE_value
    End Property

    Property Let write_XORTREE_MODE(aData)
        set_XORTREE_MODE = aData
        write
    End Property

    Property Get get_IDDQ_MODE
        get_IDDQ_MODE = read_IDDQ_MODE_value
    End Property

    Property Let set_IDDQ_MODE(aData)
        write_IDDQ_MODE_value = aData
        flag_IDDQ_MODE        = &H1
    End Property

    Property Get read_IDDQ_MODE
        read
        read_IDDQ_MODE = read_IDDQ_MODE_value
    End Property

    Property Let write_IDDQ_MODE(aData)
        set_IDDQ_MODE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TEST_BUS_MODE_value = rightShift(data_low, 4) and &Hf
        read_XORTREE_MODE_value = rightShift(data_low, 1) and &H1
        IDDQ_MODE_mask = &H1
        if data_low > LONG_MAX then
            if IDDQ_MODE_mask = mask then
                read_IDDQ_MODE_value = data_low
            else
                read_IDDQ_MODE_value = (data_low - H8000_0000) and IDDQ_MODE_mask
            end If
        else
            read_IDDQ_MODE_value = data_low and IDDQ_MODE_mask
        end If

    End Sub

    Sub write
        If flag_TEST_BUS_MODE = &H0 or flag_XORTREE_MODE = &H0 or flag_IDDQ_MODE = &H0 Then read
        If flag_TEST_BUS_MODE = &H0 Then write_TEST_BUS_MODE_value = get_TEST_BUS_MODE
        If flag_XORTREE_MODE = &H0 Then write_XORTREE_MODE_value = get_XORTREE_MODE
        If flag_IDDQ_MODE = &H0 Then write_IDDQ_MODE_value = get_IDDQ_MODE

        regValue = leftShift((write_TEST_BUS_MODE_value and &Hf), 4) + leftShift((write_XORTREE_MODE_value and &H1), 1) + leftShift((write_IDDQ_MODE_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TEST_BUS_MODE_value = rightShift(data_low, 4) and &Hf
        read_XORTREE_MODE_value = rightShift(data_low, 1) and &H1
        IDDQ_MODE_mask = &H1
        if data_low > LONG_MAX then
            if IDDQ_MODE_mask = mask then
                read_IDDQ_MODE_value = data_low
            else
                read_IDDQ_MODE_value = (data_low - H8000_0000) and IDDQ_MODE_mask
            end If
        else
            read_IDDQ_MODE_value = data_low and IDDQ_MODE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TEST_BUS_MODE_value = &H0
        flag_TEST_BUS_MODE        = &H0
        write_XORTREE_MODE_value = &H0
        flag_XORTREE_MODE        = &H0
        write_IDDQ_MODE_value = &H0
        flag_IDDQ_MODE        = &H0
    End Sub
End Class


'' @REGISTER : BRPHY_1G_1PORT_MISC_tpin_sel_15_00
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TPIN_SEL                                   [15:0]           get_TPIN_SEL
''                                                             set_TPIN_SEL
''                                                             read_TPIN_SEL
''                                                             write_TPIN_SEL
''---------------------------------------------------------------------------------
Class REGISTER_BRPHY_1G_1PORT_MISC_tpin_sel_15_00
    Private write_TPIN_SEL_value
    Private read_TPIN_SEL_value
    Private flag_TPIN_SEL

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

    Property Get get_TPIN_SEL
        get_TPIN_SEL = read_TPIN_SEL_value
    End Property

    Property Let set_TPIN_SEL(aData)
        write_TPIN_SEL_value = aData
        flag_TPIN_SEL        = &H1
    End Property

    Property Get read_TPIN_SEL
        read
        read_TPIN_SEL = read_TPIN_SEL_value
    End Property

    Property Let write_TPIN_SEL(aData)
        set_TPIN_SEL = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TPIN_SEL_mask = &Hffff
        if data_low > LONG_MAX then
            if TPIN_SEL_mask = mask then
                read_TPIN_SEL_value = data_low
            else
                read_TPIN_SEL_value = (data_low - H8000_0000) and TPIN_SEL_mask
            end If
        else
            read_TPIN_SEL_value = data_low and TPIN_SEL_mask
        end If

    End Sub

    Sub write
        If flag_TPIN_SEL = &H0 Then read
        If flag_TPIN_SEL = &H0 Then write_TPIN_SEL_value = get_TPIN_SEL

        regValue = leftShift((write_TPIN_SEL_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TPIN_SEL_mask = &Hffff
        if data_low > LONG_MAX then
            if TPIN_SEL_mask = mask then
                read_TPIN_SEL_value = data_low
            else
                read_TPIN_SEL_value = (data_low - H8000_0000) and TPIN_SEL_mask
            end If
        else
            read_TPIN_SEL_value = data_low and TPIN_SEL_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TPIN_SEL_value = &H0
        flag_TPIN_SEL        = &H0
    End Sub
End Class


'' @REGISTER : BRPHY_1G_1PORT_MISC_tpin_sel_18_16
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TPIN_SEL                                   [2:0]            get_TPIN_SEL
''                                                             set_TPIN_SEL
''                                                             read_TPIN_SEL
''                                                             write_TPIN_SEL
''---------------------------------------------------------------------------------
Class REGISTER_BRPHY_1G_1PORT_MISC_tpin_sel_18_16
    Private write_TPIN_SEL_value
    Private read_TPIN_SEL_value
    Private flag_TPIN_SEL

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

    Property Get get_TPIN_SEL
        get_TPIN_SEL = read_TPIN_SEL_value
    End Property

    Property Let set_TPIN_SEL(aData)
        write_TPIN_SEL_value = aData
        flag_TPIN_SEL        = &H1
    End Property

    Property Get read_TPIN_SEL
        read
        read_TPIN_SEL = read_TPIN_SEL_value
    End Property

    Property Let write_TPIN_SEL(aData)
        set_TPIN_SEL = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TPIN_SEL_mask = &H7
        if data_low > LONG_MAX then
            if TPIN_SEL_mask = mask then
                read_TPIN_SEL_value = data_low
            else
                read_TPIN_SEL_value = (data_low - H8000_0000) and TPIN_SEL_mask
            end If
        else
            read_TPIN_SEL_value = data_low and TPIN_SEL_mask
        end If

    End Sub

    Sub write
        If flag_TPIN_SEL = &H0 Then read
        If flag_TPIN_SEL = &H0 Then write_TPIN_SEL_value = get_TPIN_SEL

        regValue = leftShift((write_TPIN_SEL_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TPIN_SEL_mask = &H7
        if data_low > LONG_MAX then
            if TPIN_SEL_mask = mask then
                read_TPIN_SEL_value = data_low
            else
                read_TPIN_SEL_value = (data_low - H8000_0000) and TPIN_SEL_mask
            end If
        else
            read_TPIN_SEL_value = data_low and TPIN_SEL_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TPIN_SEL_value = &H0
        flag_TPIN_SEL        = &H0
    End Sub
End Class


'' @REGISTER : BRPHY_1G_1PORT_MISC_tpin_reg_15_00
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TPIN_REG_15_00                             [15:0]           get_TPIN_REG_15_00
''                                                             set_TPIN_REG_15_00
''                                                             read_TPIN_REG_15_00
''                                                             write_TPIN_REG_15_00
''---------------------------------------------------------------------------------
Class REGISTER_BRPHY_1G_1PORT_MISC_tpin_reg_15_00
    Private write_TPIN_REG_15_00_value
    Private read_TPIN_REG_15_00_value
    Private flag_TPIN_REG_15_00

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

    Property Get get_TPIN_REG_15_00
        get_TPIN_REG_15_00 = read_TPIN_REG_15_00_value
    End Property

    Property Let set_TPIN_REG_15_00(aData)
        write_TPIN_REG_15_00_value = aData
        flag_TPIN_REG_15_00        = &H1
    End Property

    Property Get read_TPIN_REG_15_00
        read
        read_TPIN_REG_15_00 = read_TPIN_REG_15_00_value
    End Property

    Property Let write_TPIN_REG_15_00(aData)
        set_TPIN_REG_15_00 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TPIN_REG_15_00_mask = &Hffff
        if data_low > LONG_MAX then
            if TPIN_REG_15_00_mask = mask then
                read_TPIN_REG_15_00_value = data_low
            else
                read_TPIN_REG_15_00_value = (data_low - H8000_0000) and TPIN_REG_15_00_mask
            end If
        else
            read_TPIN_REG_15_00_value = data_low and TPIN_REG_15_00_mask
        end If

    End Sub

    Sub write
        If flag_TPIN_REG_15_00 = &H0 Then read
        If flag_TPIN_REG_15_00 = &H0 Then write_TPIN_REG_15_00_value = get_TPIN_REG_15_00

        regValue = leftShift((write_TPIN_REG_15_00_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TPIN_REG_15_00_mask = &Hffff
        if data_low > LONG_MAX then
            if TPIN_REG_15_00_mask = mask then
                read_TPIN_REG_15_00_value = data_low
            else
                read_TPIN_REG_15_00_value = (data_low - H8000_0000) and TPIN_REG_15_00_mask
            end If
        else
            read_TPIN_REG_15_00_value = data_low and TPIN_REG_15_00_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TPIN_REG_15_00_value = &H0
        flag_TPIN_REG_15_00        = &H0
    End Sub
End Class


'' @REGISTER : BRPHY_1G_1PORT_MISC_tpin_reg_18_16
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TPIN_REG_18_16                             [2:0]            get_TPIN_REG_18_16
''                                                             set_TPIN_REG_18_16
''                                                             read_TPIN_REG_18_16
''                                                             write_TPIN_REG_18_16
''---------------------------------------------------------------------------------
Class REGISTER_BRPHY_1G_1PORT_MISC_tpin_reg_18_16
    Private write_TPIN_REG_18_16_value
    Private read_TPIN_REG_18_16_value
    Private flag_TPIN_REG_18_16

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

    Property Get get_TPIN_REG_18_16
        get_TPIN_REG_18_16 = read_TPIN_REG_18_16_value
    End Property

    Property Let set_TPIN_REG_18_16(aData)
        write_TPIN_REG_18_16_value = aData
        flag_TPIN_REG_18_16        = &H1
    End Property

    Property Get read_TPIN_REG_18_16
        read
        read_TPIN_REG_18_16 = read_TPIN_REG_18_16_value
    End Property

    Property Let write_TPIN_REG_18_16(aData)
        set_TPIN_REG_18_16 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TPIN_REG_18_16_mask = &H7
        if data_low > LONG_MAX then
            if TPIN_REG_18_16_mask = mask then
                read_TPIN_REG_18_16_value = data_low
            else
                read_TPIN_REG_18_16_value = (data_low - H8000_0000) and TPIN_REG_18_16_mask
            end If
        else
            read_TPIN_REG_18_16_value = data_low and TPIN_REG_18_16_mask
        end If

    End Sub

    Sub write
        If flag_TPIN_REG_18_16 = &H0 Then read
        If flag_TPIN_REG_18_16 = &H0 Then write_TPIN_REG_18_16_value = get_TPIN_REG_18_16

        regValue = leftShift((write_TPIN_REG_18_16_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TPIN_REG_18_16_mask = &H7
        if data_low > LONG_MAX then
            if TPIN_REG_18_16_mask = mask then
                read_TPIN_REG_18_16_value = data_low
            else
                read_TPIN_REG_18_16_value = (data_low - H8000_0000) and TPIN_REG_18_16_mask
            end If
        else
            read_TPIN_REG_18_16_value = data_low and TPIN_REG_18_16_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TPIN_REG_18_16_value = &H0
        flag_TPIN_REG_18_16        = &H0
    End Sub
End Class


'' @REGISTER : BRPHY_1G_1PORT_MISC_tpout_reg_15_00
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TPOUT_REG_15_00                            [15:0]           get_TPOUT_REG_15_00
''                                                             set_TPOUT_REG_15_00
''                                                             read_TPOUT_REG_15_00
''                                                             write_TPOUT_REG_15_00
''---------------------------------------------------------------------------------
Class REGISTER_BRPHY_1G_1PORT_MISC_tpout_reg_15_00
    Private write_TPOUT_REG_15_00_value
    Private read_TPOUT_REG_15_00_value
    Private flag_TPOUT_REG_15_00

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

    Property Get get_TPOUT_REG_15_00
        get_TPOUT_REG_15_00 = read_TPOUT_REG_15_00_value
    End Property

    Property Let set_TPOUT_REG_15_00(aData)
        write_TPOUT_REG_15_00_value = aData
        flag_TPOUT_REG_15_00        = &H1
    End Property

    Property Get read_TPOUT_REG_15_00
        read
        read_TPOUT_REG_15_00 = read_TPOUT_REG_15_00_value
    End Property

    Property Let write_TPOUT_REG_15_00(aData)
        set_TPOUT_REG_15_00 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TPOUT_REG_15_00_mask = &Hffff
        if data_low > LONG_MAX then
            if TPOUT_REG_15_00_mask = mask then
                read_TPOUT_REG_15_00_value = data_low
            else
                read_TPOUT_REG_15_00_value = (data_low - H8000_0000) and TPOUT_REG_15_00_mask
            end If
        else
            read_TPOUT_REG_15_00_value = data_low and TPOUT_REG_15_00_mask
        end If

    End Sub

    Sub write
        If flag_TPOUT_REG_15_00 = &H0 Then read
        If flag_TPOUT_REG_15_00 = &H0 Then write_TPOUT_REG_15_00_value = get_TPOUT_REG_15_00

        regValue = leftShift((write_TPOUT_REG_15_00_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TPOUT_REG_15_00_mask = &Hffff
        if data_low > LONG_MAX then
            if TPOUT_REG_15_00_mask = mask then
                read_TPOUT_REG_15_00_value = data_low
            else
                read_TPOUT_REG_15_00_value = (data_low - H8000_0000) and TPOUT_REG_15_00_mask
            end If
        else
            read_TPOUT_REG_15_00_value = data_low and TPOUT_REG_15_00_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TPOUT_REG_15_00_value = &H0
        flag_TPOUT_REG_15_00        = &H0
    End Sub
End Class


'' @REGISTER : BRPHY_1G_1PORT_MISC_tpout_reg_18_16
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TPOUT_REG_18_16                            [2:0]            get_TPOUT_REG_18_16
''                                                             set_TPOUT_REG_18_16
''                                                             read_TPOUT_REG_18_16
''                                                             write_TPOUT_REG_18_16
''---------------------------------------------------------------------------------
Class REGISTER_BRPHY_1G_1PORT_MISC_tpout_reg_18_16
    Private write_TPOUT_REG_18_16_value
    Private read_TPOUT_REG_18_16_value
    Private flag_TPOUT_REG_18_16

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

    Property Get get_TPOUT_REG_18_16
        get_TPOUT_REG_18_16 = read_TPOUT_REG_18_16_value
    End Property

    Property Let set_TPOUT_REG_18_16(aData)
        write_TPOUT_REG_18_16_value = aData
        flag_TPOUT_REG_18_16        = &H1
    End Property

    Property Get read_TPOUT_REG_18_16
        read
        read_TPOUT_REG_18_16 = read_TPOUT_REG_18_16_value
    End Property

    Property Let write_TPOUT_REG_18_16(aData)
        set_TPOUT_REG_18_16 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TPOUT_REG_18_16_mask = &H7
        if data_low > LONG_MAX then
            if TPOUT_REG_18_16_mask = mask then
                read_TPOUT_REG_18_16_value = data_low
            else
                read_TPOUT_REG_18_16_value = (data_low - H8000_0000) and TPOUT_REG_18_16_mask
            end If
        else
            read_TPOUT_REG_18_16_value = data_low and TPOUT_REG_18_16_mask
        end If

    End Sub

    Sub write
        If flag_TPOUT_REG_18_16 = &H0 Then read
        If flag_TPOUT_REG_18_16 = &H0 Then write_TPOUT_REG_18_16_value = get_TPOUT_REG_18_16

        regValue = leftShift((write_TPOUT_REG_18_16_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TPOUT_REG_18_16_mask = &H7
        if data_low > LONG_MAX then
            if TPOUT_REG_18_16_mask = mask then
                read_TPOUT_REG_18_16_value = data_low
            else
                read_TPOUT_REG_18_16_value = (data_low - H8000_0000) and TPOUT_REG_18_16_mask
            end If
        else
            read_TPOUT_REG_18_16_value = data_low and TPOUT_REG_18_16_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TPOUT_REG_18_16_value = &H0
        flag_TPOUT_REG_18_16        = &H0
    End Sub
End Class


'' @REGISTER : BRPHY_1G_1PORT_MISC_rgmii_control
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' RGMII_RX_DIS_IN_RMT_LPBK                   [14:14]          get_RGMII_RX_DIS_IN_RMT_LPBK
''                                                             set_RGMII_RX_DIS_IN_RMT_LPBK
''                                                             read_RGMII_RX_DIS_IN_RMT_LPBK
''                                                             write_RGMII_RX_DIS_IN_RMT_LPBK
''---------------------------------------------------------------------------------
'' RGMII_TX_ER_MODE                           [13:13]          get_RGMII_TX_ER_MODE
''                                                             set_RGMII_TX_ER_MODE
''                                                             read_RGMII_TX_ER_MODE
''                                                             write_RGMII_TX_ER_MODE
''---------------------------------------------------------------------------------
'' RGMII_DLL_TEST_DI                          [12:12]          get_RGMII_DLL_TEST_DI
''                                                             set_RGMII_DLL_TEST_DI
''                                                             read_RGMII_DLL_TEST_DI
''                                                             write_RGMII_DLL_TEST_DI
''---------------------------------------------------------------------------------
'' RGMII_DLL_IDDQ                             [11:11]          get_RGMII_DLL_IDDQ
''                                                             set_RGMII_DLL_IDDQ
''                                                             read_RGMII_DLL_IDDQ
''                                                             write_RGMII_DLL_IDDQ
''---------------------------------------------------------------------------------
'' RGMII_TX_CHARACTERIZATION                  [10:10]          get_RGMII_TX_CHARACTERIZATION
''                                                             set_RGMII_TX_CHARACTERIZATION
''                                                             read_RGMII_TX_CHARACTERIZATION
''                                                             write_RGMII_TX_CHARACTERIZATION
''---------------------------------------------------------------------------------
'' RGMII_GTX_DEGREES                          [9:8]            get_RGMII_GTX_DEGREES
''                                                             set_RGMII_GTX_DEGREES
''                                                             read_RGMII_GTX_DEGREES
''                                                             write_RGMII_GTX_DEGREES
''---------------------------------------------------------------------------------
'' RGMII_RX_DIS                               [4:4]            get_RGMII_RX_DIS
''                                                             set_RGMII_RX_DIS
''                                                             read_RGMII_RX_DIS
''                                                             write_RGMII_RX_DIS
''---------------------------------------------------------------------------------
'' RGMII_RX_ER_MODE                           [3:3]            get_RGMII_RX_ER_MODE
''                                                             set_RGMII_RX_ER_MODE
''                                                             read_RGMII_RX_ER_MODE
''                                                             write_RGMII_RX_ER_MODE
''---------------------------------------------------------------------------------
'' RGMII_RX_CHARACTERIZATION                  [2:2]            get_RGMII_RX_CHARACTERIZATION
''                                                             set_RGMII_RX_CHARACTERIZATION
''                                                             read_RGMII_RX_CHARACTERIZATION
''                                                             write_RGMII_RX_CHARACTERIZATION
''---------------------------------------------------------------------------------
'' RGMII_RXC_DEGREES                          [1:0]            get_RGMII_RXC_DEGREES
''                                                             set_RGMII_RXC_DEGREES
''                                                             read_RGMII_RXC_DEGREES
''                                                             write_RGMII_RXC_DEGREES
''---------------------------------------------------------------------------------
Class REGISTER_BRPHY_1G_1PORT_MISC_rgmii_control
    Private write_RGMII_RX_DIS_IN_RMT_LPBK_value
    Private read_RGMII_RX_DIS_IN_RMT_LPBK_value
    Private flag_RGMII_RX_DIS_IN_RMT_LPBK
    Private write_RGMII_TX_ER_MODE_value
    Private read_RGMII_TX_ER_MODE_value
    Private flag_RGMII_TX_ER_MODE
    Private write_RGMII_DLL_TEST_DI_value
    Private read_RGMII_DLL_TEST_DI_value
    Private flag_RGMII_DLL_TEST_DI
    Private write_RGMII_DLL_IDDQ_value
    Private read_RGMII_DLL_IDDQ_value
    Private flag_RGMII_DLL_IDDQ
    Private write_RGMII_TX_CHARACTERIZATION_value
    Private read_RGMII_TX_CHARACTERIZATION_value
    Private flag_RGMII_TX_CHARACTERIZATION
    Private write_RGMII_GTX_DEGREES_value
    Private read_RGMII_GTX_DEGREES_value
    Private flag_RGMII_GTX_DEGREES
    Private write_RGMII_RX_DIS_value
    Private read_RGMII_RX_DIS_value
    Private flag_RGMII_RX_DIS
    Private write_RGMII_RX_ER_MODE_value
    Private read_RGMII_RX_ER_MODE_value
    Private flag_RGMII_RX_ER_MODE
    Private write_RGMII_RX_CHARACTERIZATION_value
    Private read_RGMII_RX_CHARACTERIZATION_value
    Private flag_RGMII_RX_CHARACTERIZATION
    Private write_RGMII_RXC_DEGREES_value
    Private read_RGMII_RXC_DEGREES_value
    Private flag_RGMII_RXC_DEGREES

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

    Property Get get_RGMII_RX_DIS_IN_RMT_LPBK
        get_RGMII_RX_DIS_IN_RMT_LPBK = read_RGMII_RX_DIS_IN_RMT_LPBK_value
    End Property

    Property Let set_RGMII_RX_DIS_IN_RMT_LPBK(aData)
        write_RGMII_RX_DIS_IN_RMT_LPBK_value = aData
        flag_RGMII_RX_DIS_IN_RMT_LPBK        = &H1
    End Property

    Property Get read_RGMII_RX_DIS_IN_RMT_LPBK
        read
        read_RGMII_RX_DIS_IN_RMT_LPBK = read_RGMII_RX_DIS_IN_RMT_LPBK_value
    End Property

    Property Let write_RGMII_RX_DIS_IN_RMT_LPBK(aData)
        set_RGMII_RX_DIS_IN_RMT_LPBK = aData
        write
    End Property

    Property Get get_RGMII_TX_ER_MODE
        get_RGMII_TX_ER_MODE = read_RGMII_TX_ER_MODE_value
    End Property

    Property Let set_RGMII_TX_ER_MODE(aData)
        write_RGMII_TX_ER_MODE_value = aData
        flag_RGMII_TX_ER_MODE        = &H1
    End Property

    Property Get read_RGMII_TX_ER_MODE
        read
        read_RGMII_TX_ER_MODE = read_RGMII_TX_ER_MODE_value
    End Property

    Property Let write_RGMII_TX_ER_MODE(aData)
        set_RGMII_TX_ER_MODE = aData
        write
    End Property

    Property Get get_RGMII_DLL_TEST_DI
        get_RGMII_DLL_TEST_DI = read_RGMII_DLL_TEST_DI_value
    End Property

    Property Let set_RGMII_DLL_TEST_DI(aData)
        write_RGMII_DLL_TEST_DI_value = aData
        flag_RGMII_DLL_TEST_DI        = &H1
    End Property

    Property Get read_RGMII_DLL_TEST_DI
        read
        read_RGMII_DLL_TEST_DI = read_RGMII_DLL_TEST_DI_value
    End Property

    Property Let write_RGMII_DLL_TEST_DI(aData)
        set_RGMII_DLL_TEST_DI = aData
        write
    End Property

    Property Get get_RGMII_DLL_IDDQ
        get_RGMII_DLL_IDDQ = read_RGMII_DLL_IDDQ_value
    End Property

    Property Let set_RGMII_DLL_IDDQ(aData)
        write_RGMII_DLL_IDDQ_value = aData
        flag_RGMII_DLL_IDDQ        = &H1
    End Property

    Property Get read_RGMII_DLL_IDDQ
        read
        read_RGMII_DLL_IDDQ = read_RGMII_DLL_IDDQ_value
    End Property

    Property Let write_RGMII_DLL_IDDQ(aData)
        set_RGMII_DLL_IDDQ = aData
        write
    End Property

    Property Get get_RGMII_TX_CHARACTERIZATION
        get_RGMII_TX_CHARACTERIZATION = read_RGMII_TX_CHARACTERIZATION_value
    End Property

    Property Let set_RGMII_TX_CHARACTERIZATION(aData)
        write_RGMII_TX_CHARACTERIZATION_value = aData
        flag_RGMII_TX_CHARACTERIZATION        = &H1
    End Property

    Property Get read_RGMII_TX_CHARACTERIZATION
        read
        read_RGMII_TX_CHARACTERIZATION = read_RGMII_TX_CHARACTERIZATION_value
    End Property

    Property Let write_RGMII_TX_CHARACTERIZATION(aData)
        set_RGMII_TX_CHARACTERIZATION = aData
        write
    End Property

    Property Get get_RGMII_GTX_DEGREES
        get_RGMII_GTX_DEGREES = read_RGMII_GTX_DEGREES_value
    End Property

    Property Let set_RGMII_GTX_DEGREES(aData)
        write_RGMII_GTX_DEGREES_value = aData
        flag_RGMII_GTX_DEGREES        = &H1
    End Property

    Property Get read_RGMII_GTX_DEGREES
        read
        read_RGMII_GTX_DEGREES = read_RGMII_GTX_DEGREES_value
    End Property

    Property Let write_RGMII_GTX_DEGREES(aData)
        set_RGMII_GTX_DEGREES = aData
        write
    End Property

    Property Get get_RGMII_RX_DIS
        get_RGMII_RX_DIS = read_RGMII_RX_DIS_value
    End Property

    Property Let set_RGMII_RX_DIS(aData)
        write_RGMII_RX_DIS_value = aData
        flag_RGMII_RX_DIS        = &H1
    End Property

    Property Get read_RGMII_RX_DIS
        read
        read_RGMII_RX_DIS = read_RGMII_RX_DIS_value
    End Property

    Property Let write_RGMII_RX_DIS(aData)
        set_RGMII_RX_DIS = aData
        write
    End Property

    Property Get get_RGMII_RX_ER_MODE
        get_RGMII_RX_ER_MODE = read_RGMII_RX_ER_MODE_value
    End Property

    Property Let set_RGMII_RX_ER_MODE(aData)
        write_RGMII_RX_ER_MODE_value = aData
        flag_RGMII_RX_ER_MODE        = &H1
    End Property

    Property Get read_RGMII_RX_ER_MODE
        read
        read_RGMII_RX_ER_MODE = read_RGMII_RX_ER_MODE_value
    End Property

    Property Let write_RGMII_RX_ER_MODE(aData)
        set_RGMII_RX_ER_MODE = aData
        write
    End Property

    Property Get get_RGMII_RX_CHARACTERIZATION
        get_RGMII_RX_CHARACTERIZATION = read_RGMII_RX_CHARACTERIZATION_value
    End Property

    Property Let set_RGMII_RX_CHARACTERIZATION(aData)
        write_RGMII_RX_CHARACTERIZATION_value = aData
        flag_RGMII_RX_CHARACTERIZATION        = &H1
    End Property

    Property Get read_RGMII_RX_CHARACTERIZATION
        read
        read_RGMII_RX_CHARACTERIZATION = read_RGMII_RX_CHARACTERIZATION_value
    End Property

    Property Let write_RGMII_RX_CHARACTERIZATION(aData)
        set_RGMII_RX_CHARACTERIZATION = aData
        write
    End Property

    Property Get get_RGMII_RXC_DEGREES
        get_RGMII_RXC_DEGREES = read_RGMII_RXC_DEGREES_value
    End Property

    Property Let set_RGMII_RXC_DEGREES(aData)
        write_RGMII_RXC_DEGREES_value = aData
        flag_RGMII_RXC_DEGREES        = &H1
    End Property

    Property Get read_RGMII_RXC_DEGREES
        read
        read_RGMII_RXC_DEGREES = read_RGMII_RXC_DEGREES_value
    End Property

    Property Let write_RGMII_RXC_DEGREES(aData)
        set_RGMII_RXC_DEGREES = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_RGMII_RX_DIS_IN_RMT_LPBK_value = rightShift(data_low, 14) and &H1
        read_RGMII_TX_ER_MODE_value = rightShift(data_low, 13) and &H1
        read_RGMII_DLL_TEST_DI_value = rightShift(data_low, 12) and &H1
        read_RGMII_DLL_IDDQ_value = rightShift(data_low, 11) and &H1
        read_RGMII_TX_CHARACTERIZATION_value = rightShift(data_low, 10) and &H1
        read_RGMII_GTX_DEGREES_value = rightShift(data_low, 8) and &H3
        read_RGMII_RX_DIS_value = rightShift(data_low, 4) and &H1
        read_RGMII_RX_ER_MODE_value = rightShift(data_low, 3) and &H1
        read_RGMII_RX_CHARACTERIZATION_value = rightShift(data_low, 2) and &H1
        RGMII_RXC_DEGREES_mask = &H3
        if data_low > LONG_MAX then
            if RGMII_RXC_DEGREES_mask = mask then
                read_RGMII_RXC_DEGREES_value = data_low
            else
                read_RGMII_RXC_DEGREES_value = (data_low - H8000_0000) and RGMII_RXC_DEGREES_mask
            end If
        else
            read_RGMII_RXC_DEGREES_value = data_low and RGMII_RXC_DEGREES_mask
        end If

    End Sub

    Sub write
        If flag_RGMII_RX_DIS_IN_RMT_LPBK = &H0 or flag_RGMII_TX_ER_MODE = &H0 or flag_RGMII_DLL_TEST_DI = &H0 or flag_RGMII_DLL_IDDQ = &H0 or flag_RGMII_TX_CHARACTERIZATION = &H0 or flag_RGMII_GTX_DEGREES = &H0 or flag_RGMII_RX_DIS = &H0 or flag_RGMII_RX_ER_MODE = &H0 or flag_RGMII_RX_CHARACTERIZATION = &H0 or flag_RGMII_RXC_DEGREES = &H0 Then read
        If flag_RGMII_RX_DIS_IN_RMT_LPBK = &H0 Then write_RGMII_RX_DIS_IN_RMT_LPBK_value = get_RGMII_RX_DIS_IN_RMT_LPBK
        If flag_RGMII_TX_ER_MODE = &H0 Then write_RGMII_TX_ER_MODE_value = get_RGMII_TX_ER_MODE
        If flag_RGMII_DLL_TEST_DI = &H0 Then write_RGMII_DLL_TEST_DI_value = get_RGMII_DLL_TEST_DI
        If flag_RGMII_DLL_IDDQ = &H0 Then write_RGMII_DLL_IDDQ_value = get_RGMII_DLL_IDDQ
        If flag_RGMII_TX_CHARACTERIZATION = &H0 Then write_RGMII_TX_CHARACTERIZATION_value = get_RGMII_TX_CHARACTERIZATION
        If flag_RGMII_GTX_DEGREES = &H0 Then write_RGMII_GTX_DEGREES_value = get_RGMII_GTX_DEGREES
        If flag_RGMII_RX_DIS = &H0 Then write_RGMII_RX_DIS_value = get_RGMII_RX_DIS
        If flag_RGMII_RX_ER_MODE = &H0 Then write_RGMII_RX_ER_MODE_value = get_RGMII_RX_ER_MODE
        If flag_RGMII_RX_CHARACTERIZATION = &H0 Then write_RGMII_RX_CHARACTERIZATION_value = get_RGMII_RX_CHARACTERIZATION
        If flag_RGMII_RXC_DEGREES = &H0 Then write_RGMII_RXC_DEGREES_value = get_RGMII_RXC_DEGREES

        regValue = leftShift((write_RGMII_RX_DIS_IN_RMT_LPBK_value and &H1), 14) + leftShift((write_RGMII_TX_ER_MODE_value and &H1), 13) + leftShift((write_RGMII_DLL_TEST_DI_value and &H1), 12) + leftShift((write_RGMII_DLL_IDDQ_value and &H1), 11) + leftShift((write_RGMII_TX_CHARACTERIZATION_value and &H1), 10) + leftShift((write_RGMII_GTX_DEGREES_value and &H3), 8) + leftShift((write_RGMII_RX_DIS_value and &H1), 4) + leftShift((write_RGMII_RX_ER_MODE_value and &H1), 3) + leftShift((write_RGMII_RX_CHARACTERIZATION_value and &H1), 2) + leftShift((write_RGMII_RXC_DEGREES_value and &H3), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_RGMII_RX_DIS_IN_RMT_LPBK_value = rightShift(data_low, 14) and &H1
        read_RGMII_TX_ER_MODE_value = rightShift(data_low, 13) and &H1
        read_RGMII_DLL_TEST_DI_value = rightShift(data_low, 12) and &H1
        read_RGMII_DLL_IDDQ_value = rightShift(data_low, 11) and &H1
        read_RGMII_TX_CHARACTERIZATION_value = rightShift(data_low, 10) and &H1
        read_RGMII_GTX_DEGREES_value = rightShift(data_low, 8) and &H3
        read_RGMII_RX_DIS_value = rightShift(data_low, 4) and &H1
        read_RGMII_RX_ER_MODE_value = rightShift(data_low, 3) and &H1
        read_RGMII_RX_CHARACTERIZATION_value = rightShift(data_low, 2) and &H1
        RGMII_RXC_DEGREES_mask = &H3
        if data_low > LONG_MAX then
            if RGMII_RXC_DEGREES_mask = mask then
                read_RGMII_RXC_DEGREES_value = data_low
            else
                read_RGMII_RXC_DEGREES_value = (data_low - H8000_0000) and RGMII_RXC_DEGREES_mask
            end If
        else
            read_RGMII_RXC_DEGREES_value = data_low and RGMII_RXC_DEGREES_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_RGMII_RX_DIS_IN_RMT_LPBK_value = &H0
        flag_RGMII_RX_DIS_IN_RMT_LPBK        = &H0
        write_RGMII_TX_ER_MODE_value = &H0
        flag_RGMII_TX_ER_MODE        = &H0
        write_RGMII_DLL_TEST_DI_value = &H0
        flag_RGMII_DLL_TEST_DI        = &H0
        write_RGMII_DLL_IDDQ_value = &H0
        flag_RGMII_DLL_IDDQ        = &H0
        write_RGMII_TX_CHARACTERIZATION_value = &H0
        flag_RGMII_TX_CHARACTERIZATION        = &H0
        write_RGMII_GTX_DEGREES_value = &H0
        flag_RGMII_GTX_DEGREES        = &H0
        write_RGMII_RX_DIS_value = &H0
        flag_RGMII_RX_DIS        = &H0
        write_RGMII_RX_ER_MODE_value = &H0
        flag_RGMII_RX_ER_MODE        = &H0
        write_RGMII_RX_CHARACTERIZATION_value = &H0
        flag_RGMII_RX_CHARACTERIZATION        = &H0
        write_RGMII_RXC_DEGREES_value = &H0
        flag_RGMII_RXC_DEGREES        = &H0
    End Sub
End Class


'' @REGISTER : BRPHY_1G_1PORT_MISC_rgmii_control2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SRC_GPIO                                   [15:15]          get_SRC_GPIO
''                                                             set_SRC_GPIO
''                                                             read_SRC_GPIO
''                                                             write_SRC_GPIO
''---------------------------------------------------------------------------------
'' SEL_GPIO                                   [14:12]          get_SEL_GPIO
''                                                             set_SEL_GPIO
''                                                             read_SEL_GPIO
''                                                             write_SEL_GPIO
''---------------------------------------------------------------------------------
'' RESERVE_1109                               [11:9]           get_RESERVE_1109
''                                                             set_RESERVE_1109
''                                                             read_RESERVE_1109
''                                                             write_RESERVE_1109
''---------------------------------------------------------------------------------
'' DIS_RGMII_AUTO_PWRDN                       [8:8]            get_DIS_RGMII_AUTO_PWRDN
''                                                             set_DIS_RGMII_AUTO_PWRDN
''                                                             read_DIS_RGMII_AUTO_PWRDN
''                                                             write_DIS_RGMII_AUTO_PWRDN
''---------------------------------------------------------------------------------
'' AMP_EN_RGMII                               [7:7]            get_AMP_EN_RGMII
''                                                             set_AMP_EN_RGMII
''                                                             read_AMP_EN_RGMII
''                                                             write_AMP_EN_RGMII
''---------------------------------------------------------------------------------
'' IND_RGMII                                  [6:6]            get_IND_RGMII
''                                                             set_IND_RGMII
''                                                             read_IND_RGMII
''                                                             write_IND_RGMII
''---------------------------------------------------------------------------------
'' SEL_RGMII                                  [5:3]            get_SEL_RGMII
''                                                             set_SEL_RGMII
''                                                             read_SEL_RGMII
''                                                             write_SEL_RGMII
''---------------------------------------------------------------------------------
'' SRC_RGMII                                  [2:1]            get_SRC_RGMII
''                                                             set_SRC_RGMII
''                                                             read_SRC_RGMII
''                                                             write_SRC_RGMII
''---------------------------------------------------------------------------------
'' SEL_GMII                                   [0:0]            get_SEL_GMII
''                                                             set_SEL_GMII
''                                                             read_SEL_GMII
''                                                             write_SEL_GMII
''---------------------------------------------------------------------------------
Class REGISTER_BRPHY_1G_1PORT_MISC_rgmii_control2
    Private write_SRC_GPIO_value
    Private read_SRC_GPIO_value
    Private flag_SRC_GPIO
    Private write_SEL_GPIO_value
    Private read_SEL_GPIO_value
    Private flag_SEL_GPIO
    Private write_RESERVE_1109_value
    Private read_RESERVE_1109_value
    Private flag_RESERVE_1109
    Private write_DIS_RGMII_AUTO_PWRDN_value
    Private read_DIS_RGMII_AUTO_PWRDN_value
    Private flag_DIS_RGMII_AUTO_PWRDN
    Private write_AMP_EN_RGMII_value
    Private read_AMP_EN_RGMII_value
    Private flag_AMP_EN_RGMII
    Private write_IND_RGMII_value
    Private read_IND_RGMII_value
    Private flag_IND_RGMII
    Private write_SEL_RGMII_value
    Private read_SEL_RGMII_value
    Private flag_SEL_RGMII
    Private write_SRC_RGMII_value
    Private read_SRC_RGMII_value
    Private flag_SRC_RGMII
    Private write_SEL_GMII_value
    Private read_SEL_GMII_value
    Private flag_SEL_GMII

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

    Property Get get_SRC_GPIO
        get_SRC_GPIO = read_SRC_GPIO_value
    End Property

    Property Let set_SRC_GPIO(aData)
        write_SRC_GPIO_value = aData
        flag_SRC_GPIO        = &H1
    End Property

    Property Get read_SRC_GPIO
        read
        read_SRC_GPIO = read_SRC_GPIO_value
    End Property

    Property Let write_SRC_GPIO(aData)
        set_SRC_GPIO = aData
        write
    End Property

    Property Get get_SEL_GPIO
        get_SEL_GPIO = read_SEL_GPIO_value
    End Property

    Property Let set_SEL_GPIO(aData)
        write_SEL_GPIO_value = aData
        flag_SEL_GPIO        = &H1
    End Property

    Property Get read_SEL_GPIO
        read
        read_SEL_GPIO = read_SEL_GPIO_value
    End Property

    Property Let write_SEL_GPIO(aData)
        set_SEL_GPIO = aData
        write
    End Property

    Property Get get_RESERVE_1109
        get_RESERVE_1109 = read_RESERVE_1109_value
    End Property

    Property Let set_RESERVE_1109(aData)
        write_RESERVE_1109_value = aData
        flag_RESERVE_1109        = &H1
    End Property

    Property Get read_RESERVE_1109
        read
        read_RESERVE_1109 = read_RESERVE_1109_value
    End Property

    Property Let write_RESERVE_1109(aData)
        set_RESERVE_1109 = aData
        write
    End Property

    Property Get get_DIS_RGMII_AUTO_PWRDN
        get_DIS_RGMII_AUTO_PWRDN = read_DIS_RGMII_AUTO_PWRDN_value
    End Property

    Property Let set_DIS_RGMII_AUTO_PWRDN(aData)
        write_DIS_RGMII_AUTO_PWRDN_value = aData
        flag_DIS_RGMII_AUTO_PWRDN        = &H1
    End Property

    Property Get read_DIS_RGMII_AUTO_PWRDN
        read
        read_DIS_RGMII_AUTO_PWRDN = read_DIS_RGMII_AUTO_PWRDN_value
    End Property

    Property Let write_DIS_RGMII_AUTO_PWRDN(aData)
        set_DIS_RGMII_AUTO_PWRDN = aData
        write
    End Property

    Property Get get_AMP_EN_RGMII
        get_AMP_EN_RGMII = read_AMP_EN_RGMII_value
    End Property

    Property Let set_AMP_EN_RGMII(aData)
        write_AMP_EN_RGMII_value = aData
        flag_AMP_EN_RGMII        = &H1
    End Property

    Property Get read_AMP_EN_RGMII
        read
        read_AMP_EN_RGMII = read_AMP_EN_RGMII_value
    End Property

    Property Let write_AMP_EN_RGMII(aData)
        set_AMP_EN_RGMII = aData
        write
    End Property

    Property Get get_IND_RGMII
        get_IND_RGMII = read_IND_RGMII_value
    End Property

    Property Let set_IND_RGMII(aData)
        write_IND_RGMII_value = aData
        flag_IND_RGMII        = &H1
    End Property

    Property Get read_IND_RGMII
        read
        read_IND_RGMII = read_IND_RGMII_value
    End Property

    Property Let write_IND_RGMII(aData)
        set_IND_RGMII = aData
        write
    End Property

    Property Get get_SEL_RGMII
        get_SEL_RGMII = read_SEL_RGMII_value
    End Property

    Property Let set_SEL_RGMII(aData)
        write_SEL_RGMII_value = aData
        flag_SEL_RGMII        = &H1
    End Property

    Property Get read_SEL_RGMII
        read
        read_SEL_RGMII = read_SEL_RGMII_value
    End Property

    Property Let write_SEL_RGMII(aData)
        set_SEL_RGMII = aData
        write
    End Property

    Property Get get_SRC_RGMII
        get_SRC_RGMII = read_SRC_RGMII_value
    End Property

    Property Let set_SRC_RGMII(aData)
        write_SRC_RGMII_value = aData
        flag_SRC_RGMII        = &H1
    End Property

    Property Get read_SRC_RGMII
        read
        read_SRC_RGMII = read_SRC_RGMII_value
    End Property

    Property Let write_SRC_RGMII(aData)
        set_SRC_RGMII = aData
        write
    End Property

    Property Get get_SEL_GMII
        get_SEL_GMII = read_SEL_GMII_value
    End Property

    Property Let set_SEL_GMII(aData)
        write_SEL_GMII_value = aData
        flag_SEL_GMII        = &H1
    End Property

    Property Get read_SEL_GMII
        read
        read_SEL_GMII = read_SEL_GMII_value
    End Property

    Property Let write_SEL_GMII(aData)
        set_SEL_GMII = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_SRC_GPIO_value = rightShift(data_low, 15) and &H1
        read_SEL_GPIO_value = rightShift(data_low, 12) and &H7
        read_RESERVE_1109_value = rightShift(data_low, 9) and &H7
        read_DIS_RGMII_AUTO_PWRDN_value = rightShift(data_low, 8) and &H1
        read_AMP_EN_RGMII_value = rightShift(data_low, 7) and &H1
        read_IND_RGMII_value = rightShift(data_low, 6) and &H1
        read_SEL_RGMII_value = rightShift(data_low, 3) and &H7
        read_SRC_RGMII_value = rightShift(data_low, 1) and &H3
        SEL_GMII_mask = &H1
        if data_low > LONG_MAX then
            if SEL_GMII_mask = mask then
                read_SEL_GMII_value = data_low
            else
                read_SEL_GMII_value = (data_low - H8000_0000) and SEL_GMII_mask
            end If
        else
            read_SEL_GMII_value = data_low and SEL_GMII_mask
        end If

    End Sub

    Sub write
        If flag_SRC_GPIO = &H0 or flag_SEL_GPIO = &H0 or flag_RESERVE_1109 = &H0 or flag_DIS_RGMII_AUTO_PWRDN = &H0 or flag_AMP_EN_RGMII = &H0 or flag_IND_RGMII = &H0 or flag_SEL_RGMII = &H0 or flag_SRC_RGMII = &H0 or flag_SEL_GMII = &H0 Then read
        If flag_SRC_GPIO = &H0 Then write_SRC_GPIO_value = get_SRC_GPIO
        If flag_SEL_GPIO = &H0 Then write_SEL_GPIO_value = get_SEL_GPIO
        If flag_RESERVE_1109 = &H0 Then write_RESERVE_1109_value = get_RESERVE_1109
        If flag_DIS_RGMII_AUTO_PWRDN = &H0 Then write_DIS_RGMII_AUTO_PWRDN_value = get_DIS_RGMII_AUTO_PWRDN
        If flag_AMP_EN_RGMII = &H0 Then write_AMP_EN_RGMII_value = get_AMP_EN_RGMII
        If flag_IND_RGMII = &H0 Then write_IND_RGMII_value = get_IND_RGMII
        If flag_SEL_RGMII = &H0 Then write_SEL_RGMII_value = get_SEL_RGMII
        If flag_SRC_RGMII = &H0 Then write_SRC_RGMII_value = get_SRC_RGMII
        If flag_SEL_GMII = &H0 Then write_SEL_GMII_value = get_SEL_GMII

        regValue = leftShift((write_SRC_GPIO_value and &H1), 15) + leftShift((write_SEL_GPIO_value and &H7), 12) + leftShift((write_RESERVE_1109_value and &H7), 9) + leftShift((write_DIS_RGMII_AUTO_PWRDN_value and &H1), 8) + leftShift((write_AMP_EN_RGMII_value and &H1), 7) + leftShift((write_IND_RGMII_value and &H1), 6) + leftShift((write_SEL_RGMII_value and &H7), 3) + leftShift((write_SRC_RGMII_value and &H3), 1) + leftShift((write_SEL_GMII_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_SRC_GPIO_value = rightShift(data_low, 15) and &H1
        read_SEL_GPIO_value = rightShift(data_low, 12) and &H7
        read_RESERVE_1109_value = rightShift(data_low, 9) and &H7
        read_DIS_RGMII_AUTO_PWRDN_value = rightShift(data_low, 8) and &H1
        read_AMP_EN_RGMII_value = rightShift(data_low, 7) and &H1
        read_IND_RGMII_value = rightShift(data_low, 6) and &H1
        read_SEL_RGMII_value = rightShift(data_low, 3) and &H7
        read_SRC_RGMII_value = rightShift(data_low, 1) and &H3
        SEL_GMII_mask = &H1
        if data_low > LONG_MAX then
            if SEL_GMII_mask = mask then
                read_SEL_GMII_value = data_low
            else
                read_SEL_GMII_value = (data_low - H8000_0000) and SEL_GMII_mask
            end If
        else
            read_SEL_GMII_value = data_low and SEL_GMII_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SRC_GPIO_value = &H0
        flag_SRC_GPIO        = &H0
        write_SEL_GPIO_value = &H0
        flag_SEL_GPIO        = &H0
        write_RESERVE_1109_value = &H0
        flag_RESERVE_1109        = &H0
        write_DIS_RGMII_AUTO_PWRDN_value = &H0
        flag_DIS_RGMII_AUTO_PWRDN        = &H0
        write_AMP_EN_RGMII_value = &H0
        flag_AMP_EN_RGMII        = &H0
        write_IND_RGMII_value = &H0
        flag_IND_RGMII        = &H0
        write_SEL_RGMII_value = &H0
        flag_SEL_RGMII        = &H0
        write_SRC_RGMII_value = &H0
        flag_SRC_RGMII        = &H0
        write_SEL_GMII_value = &H0
        flag_SEL_GMII        = &H0
    End Sub
End Class


'' @REGISTER : BRPHY_1G_1PORT_MISC_rgmii_rx_char_pattern
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' RGMII_RX_CHAR_PATTERN                      [9:0]            get_RGMII_RX_CHAR_PATTERN
''                                                             set_RGMII_RX_CHAR_PATTERN
''                                                             read_RGMII_RX_CHAR_PATTERN
''                                                             write_RGMII_RX_CHAR_PATTERN
''---------------------------------------------------------------------------------
Class REGISTER_BRPHY_1G_1PORT_MISC_rgmii_rx_char_pattern
    Private write_RGMII_RX_CHAR_PATTERN_value
    Private read_RGMII_RX_CHAR_PATTERN_value
    Private flag_RGMII_RX_CHAR_PATTERN

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

    Property Get get_RGMII_RX_CHAR_PATTERN
        get_RGMII_RX_CHAR_PATTERN = read_RGMII_RX_CHAR_PATTERN_value
    End Property

    Property Let set_RGMII_RX_CHAR_PATTERN(aData)
        write_RGMII_RX_CHAR_PATTERN_value = aData
        flag_RGMII_RX_CHAR_PATTERN        = &H1
    End Property

    Property Get read_RGMII_RX_CHAR_PATTERN
        read
        read_RGMII_RX_CHAR_PATTERN = read_RGMII_RX_CHAR_PATTERN_value
    End Property

    Property Let write_RGMII_RX_CHAR_PATTERN(aData)
        set_RGMII_RX_CHAR_PATTERN = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        RGMII_RX_CHAR_PATTERN_mask = &H3ff
        if data_low > LONG_MAX then
            if RGMII_RX_CHAR_PATTERN_mask = mask then
                read_RGMII_RX_CHAR_PATTERN_value = data_low
            else
                read_RGMII_RX_CHAR_PATTERN_value = (data_low - H8000_0000) and RGMII_RX_CHAR_PATTERN_mask
            end If
        else
            read_RGMII_RX_CHAR_PATTERN_value = data_low and RGMII_RX_CHAR_PATTERN_mask
        end If

    End Sub

    Sub write
        If flag_RGMII_RX_CHAR_PATTERN = &H0 Then read
        If flag_RGMII_RX_CHAR_PATTERN = &H0 Then write_RGMII_RX_CHAR_PATTERN_value = get_RGMII_RX_CHAR_PATTERN

        regValue = leftShift((write_RGMII_RX_CHAR_PATTERN_value and &H3ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        RGMII_RX_CHAR_PATTERN_mask = &H3ff
        if data_low > LONG_MAX then
            if RGMII_RX_CHAR_PATTERN_mask = mask then
                read_RGMII_RX_CHAR_PATTERN_value = data_low
            else
                read_RGMII_RX_CHAR_PATTERN_value = (data_low - H8000_0000) and RGMII_RX_CHAR_PATTERN_mask
            end If
        else
            read_RGMII_RX_CHAR_PATTERN_value = data_low and RGMII_RX_CHAR_PATTERN_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_RGMII_RX_CHAR_PATTERN_value = &H0
        flag_RGMII_RX_CHAR_PATTERN        = &H0
    End Sub
End Class


'' @REGISTER : BRPHY_1G_1PORT_MISC_rgmii_tx_char_pattern_cmp
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' RGMII_TX_CHAR_PATTERN_CMP                  [9:0]            get_RGMII_TX_CHAR_PATTERN_CMP
''                                                             set_RGMII_TX_CHAR_PATTERN_CMP
''                                                             read_RGMII_TX_CHAR_PATTERN_CMP
''                                                             write_RGMII_TX_CHAR_PATTERN_CMP
''---------------------------------------------------------------------------------
Class REGISTER_BRPHY_1G_1PORT_MISC_rgmii_tx_char_pattern_cmp
    Private write_RGMII_TX_CHAR_PATTERN_CMP_value
    Private read_RGMII_TX_CHAR_PATTERN_CMP_value
    Private flag_RGMII_TX_CHAR_PATTERN_CMP

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

    Property Get get_RGMII_TX_CHAR_PATTERN_CMP
        get_RGMII_TX_CHAR_PATTERN_CMP = read_RGMII_TX_CHAR_PATTERN_CMP_value
    End Property

    Property Let set_RGMII_TX_CHAR_PATTERN_CMP(aData)
        write_RGMII_TX_CHAR_PATTERN_CMP_value = aData
        flag_RGMII_TX_CHAR_PATTERN_CMP        = &H1
    End Property

    Property Get read_RGMII_TX_CHAR_PATTERN_CMP
        read
        read_RGMII_TX_CHAR_PATTERN_CMP = read_RGMII_TX_CHAR_PATTERN_CMP_value
    End Property

    Property Let write_RGMII_TX_CHAR_PATTERN_CMP(aData)
        set_RGMII_TX_CHAR_PATTERN_CMP = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        RGMII_TX_CHAR_PATTERN_CMP_mask = &H3ff
        if data_low > LONG_MAX then
            if RGMII_TX_CHAR_PATTERN_CMP_mask = mask then
                read_RGMII_TX_CHAR_PATTERN_CMP_value = data_low
            else
                read_RGMII_TX_CHAR_PATTERN_CMP_value = (data_low - H8000_0000) and RGMII_TX_CHAR_PATTERN_CMP_mask
            end If
        else
            read_RGMII_TX_CHAR_PATTERN_CMP_value = data_low and RGMII_TX_CHAR_PATTERN_CMP_mask
        end If

    End Sub

    Sub write
        If flag_RGMII_TX_CHAR_PATTERN_CMP = &H0 Then read
        If flag_RGMII_TX_CHAR_PATTERN_CMP = &H0 Then write_RGMII_TX_CHAR_PATTERN_CMP_value = get_RGMII_TX_CHAR_PATTERN_CMP

        regValue = leftShift((write_RGMII_TX_CHAR_PATTERN_CMP_value and &H3ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        RGMII_TX_CHAR_PATTERN_CMP_mask = &H3ff
        if data_low > LONG_MAX then
            if RGMII_TX_CHAR_PATTERN_CMP_mask = mask then
                read_RGMII_TX_CHAR_PATTERN_CMP_value = data_low
            else
                read_RGMII_TX_CHAR_PATTERN_CMP_value = (data_low - H8000_0000) and RGMII_TX_CHAR_PATTERN_CMP_mask
            end If
        else
            read_RGMII_TX_CHAR_PATTERN_CMP_value = data_low and RGMII_TX_CHAR_PATTERN_CMP_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_RGMII_TX_CHAR_PATTERN_CMP_value = &H0
        flag_RGMII_TX_CHAR_PATTERN_CMP        = &H0
    End Sub
End Class


'' @REGISTER : BRPHY_1G_1PORT_MISC_rgmii_tx_char_pattern
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' RGMII_TX_CHAR_PATTERN                      [9:0]            get_RGMII_TX_CHAR_PATTERN
''                                                             set_RGMII_TX_CHAR_PATTERN
''                                                             read_RGMII_TX_CHAR_PATTERN
''                                                             write_RGMII_TX_CHAR_PATTERN
''---------------------------------------------------------------------------------
Class REGISTER_BRPHY_1G_1PORT_MISC_rgmii_tx_char_pattern
    Private write_RGMII_TX_CHAR_PATTERN_value
    Private read_RGMII_TX_CHAR_PATTERN_value
    Private flag_RGMII_TX_CHAR_PATTERN

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

    Property Get get_RGMII_TX_CHAR_PATTERN
        get_RGMII_TX_CHAR_PATTERN = read_RGMII_TX_CHAR_PATTERN_value
    End Property

    Property Let set_RGMII_TX_CHAR_PATTERN(aData)
        write_RGMII_TX_CHAR_PATTERN_value = aData
        flag_RGMII_TX_CHAR_PATTERN        = &H1
    End Property

    Property Get read_RGMII_TX_CHAR_PATTERN
        read
        read_RGMII_TX_CHAR_PATTERN = read_RGMII_TX_CHAR_PATTERN_value
    End Property

    Property Let write_RGMII_TX_CHAR_PATTERN(aData)
        set_RGMII_TX_CHAR_PATTERN = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        RGMII_TX_CHAR_PATTERN_mask = &H3ff
        if data_low > LONG_MAX then
            if RGMII_TX_CHAR_PATTERN_mask = mask then
                read_RGMII_TX_CHAR_PATTERN_value = data_low
            else
                read_RGMII_TX_CHAR_PATTERN_value = (data_low - H8000_0000) and RGMII_TX_CHAR_PATTERN_mask
            end If
        else
            read_RGMII_TX_CHAR_PATTERN_value = data_low and RGMII_TX_CHAR_PATTERN_mask
        end If

    End Sub

    Sub write
        If flag_RGMII_TX_CHAR_PATTERN = &H0 Then read
        If flag_RGMII_TX_CHAR_PATTERN = &H0 Then write_RGMII_TX_CHAR_PATTERN_value = get_RGMII_TX_CHAR_PATTERN

        regValue = leftShift((write_RGMII_TX_CHAR_PATTERN_value and &H3ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        RGMII_TX_CHAR_PATTERN_mask = &H3ff
        if data_low > LONG_MAX then
            if RGMII_TX_CHAR_PATTERN_mask = mask then
                read_RGMII_TX_CHAR_PATTERN_value = data_low
            else
                read_RGMII_TX_CHAR_PATTERN_value = (data_low - H8000_0000) and RGMII_TX_CHAR_PATTERN_mask
            end If
        else
            read_RGMII_TX_CHAR_PATTERN_value = data_low and RGMII_TX_CHAR_PATTERN_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_RGMII_TX_CHAR_PATTERN_value = &H0
        flag_RGMII_TX_CHAR_PATTERN        = &H0
    End Sub
End Class


'' @REGISTER : BRPHY_1G_1PORT_MISC_swreg_cntl_rgmii_sgmii_sel
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SGMII_PWRDN_VAL                            [7:7]            get_SGMII_PWRDN_VAL
''                                                             set_SGMII_PWRDN_VAL
''                                                             read_SGMII_PWRDN_VAL
''                                                             write_SGMII_PWRDN_VAL
''---------------------------------------------------------------------------------
'' SGMII_PWRDN_OV                             [6:6]            get_SGMII_PWRDN_OV
''                                                             set_SGMII_PWRDN_OV
''                                                             read_SGMII_PWRDN_OV
''                                                             write_SGMII_PWRDN_OV
''---------------------------------------------------------------------------------
'' RGMII_SGMII_sel                            [5:4]            get_RGMII_SGMII_sel
''                                                             set_RGMII_SGMII_sel
''                                                             read_RGMII_SGMII_sel
''                                                             write_RGMII_SGMII_sel
''---------------------------------------------------------------------------------
'' SWREG_SOFT_RESET                           [2:2]            get_SWREG_SOFT_RESET
''                                                             set_SWREG_SOFT_RESET
''                                                             read_SWREG_SOFT_RESET
''                                                             write_SWREG_SOFT_RESET
''---------------------------------------------------------------------------------
'' SWREG_SCLK_ENABLE                          [1:1]            get_SWREG_SCLK_ENABLE
''                                                             set_SWREG_SCLK_ENABLE
''                                                             read_SWREG_SCLK_ENABLE
''                                                             write_SWREG_SCLK_ENABLE
''---------------------------------------------------------------------------------
'' SWREG_MDIO_MODE                            [0:0]            get_SWREG_MDIO_MODE
''                                                             set_SWREG_MDIO_MODE
''                                                             read_SWREG_MDIO_MODE
''                                                             write_SWREG_MDIO_MODE
''---------------------------------------------------------------------------------
Class REGISTER_BRPHY_1G_1PORT_MISC_swreg_cntl_rgmii_sgmii_sel
    Private write_SGMII_PWRDN_VAL_value
    Private read_SGMII_PWRDN_VAL_value
    Private flag_SGMII_PWRDN_VAL
    Private write_SGMII_PWRDN_OV_value
    Private read_SGMII_PWRDN_OV_value
    Private flag_SGMII_PWRDN_OV
    Private write_RGMII_SGMII_sel_value
    Private read_RGMII_SGMII_sel_value
    Private flag_RGMII_SGMII_sel
    Private write_SWREG_SOFT_RESET_value
    Private read_SWREG_SOFT_RESET_value
    Private flag_SWREG_SOFT_RESET
    Private write_SWREG_SCLK_ENABLE_value
    Private read_SWREG_SCLK_ENABLE_value
    Private flag_SWREG_SCLK_ENABLE
    Private write_SWREG_MDIO_MODE_value
    Private read_SWREG_MDIO_MODE_value
    Private flag_SWREG_MDIO_MODE

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

    Property Get get_SGMII_PWRDN_VAL
        get_SGMII_PWRDN_VAL = read_SGMII_PWRDN_VAL_value
    End Property

    Property Let set_SGMII_PWRDN_VAL(aData)
        write_SGMII_PWRDN_VAL_value = aData
        flag_SGMII_PWRDN_VAL        = &H1
    End Property

    Property Get read_SGMII_PWRDN_VAL
        read
        read_SGMII_PWRDN_VAL = read_SGMII_PWRDN_VAL_value
    End Property

    Property Let write_SGMII_PWRDN_VAL(aData)
        set_SGMII_PWRDN_VAL = aData
        write
    End Property

    Property Get get_SGMII_PWRDN_OV
        get_SGMII_PWRDN_OV = read_SGMII_PWRDN_OV_value
    End Property

    Property Let set_SGMII_PWRDN_OV(aData)
        write_SGMII_PWRDN_OV_value = aData
        flag_SGMII_PWRDN_OV        = &H1
    End Property

    Property Get read_SGMII_PWRDN_OV
        read
        read_SGMII_PWRDN_OV = read_SGMII_PWRDN_OV_value
    End Property

    Property Let write_SGMII_PWRDN_OV(aData)
        set_SGMII_PWRDN_OV = aData
        write
    End Property

    Property Get get_RGMII_SGMII_sel
        get_RGMII_SGMII_sel = read_RGMII_SGMII_sel_value
    End Property

    Property Let set_RGMII_SGMII_sel(aData)
        write_RGMII_SGMII_sel_value = aData
        flag_RGMII_SGMII_sel        = &H1
    End Property

    Property Get read_RGMII_SGMII_sel
        read
        read_RGMII_SGMII_sel = read_RGMII_SGMII_sel_value
    End Property

    Property Let write_RGMII_SGMII_sel(aData)
        set_RGMII_SGMII_sel = aData
        write
    End Property

    Property Get get_SWREG_SOFT_RESET
        get_SWREG_SOFT_RESET = read_SWREG_SOFT_RESET_value
    End Property

    Property Let set_SWREG_SOFT_RESET(aData)
        write_SWREG_SOFT_RESET_value = aData
        flag_SWREG_SOFT_RESET        = &H1
    End Property

    Property Get read_SWREG_SOFT_RESET
        read
        read_SWREG_SOFT_RESET = read_SWREG_SOFT_RESET_value
    End Property

    Property Let write_SWREG_SOFT_RESET(aData)
        set_SWREG_SOFT_RESET = aData
        write
    End Property

    Property Get get_SWREG_SCLK_ENABLE
        get_SWREG_SCLK_ENABLE = read_SWREG_SCLK_ENABLE_value
    End Property

    Property Let set_SWREG_SCLK_ENABLE(aData)
        write_SWREG_SCLK_ENABLE_value = aData
        flag_SWREG_SCLK_ENABLE        = &H1
    End Property

    Property Get read_SWREG_SCLK_ENABLE
        read
        read_SWREG_SCLK_ENABLE = read_SWREG_SCLK_ENABLE_value
    End Property

    Property Let write_SWREG_SCLK_ENABLE(aData)
        set_SWREG_SCLK_ENABLE = aData
        write
    End Property

    Property Get get_SWREG_MDIO_MODE
        get_SWREG_MDIO_MODE = read_SWREG_MDIO_MODE_value
    End Property

    Property Let set_SWREG_MDIO_MODE(aData)
        write_SWREG_MDIO_MODE_value = aData
        flag_SWREG_MDIO_MODE        = &H1
    End Property

    Property Get read_SWREG_MDIO_MODE
        read
        read_SWREG_MDIO_MODE = read_SWREG_MDIO_MODE_value
    End Property

    Property Let write_SWREG_MDIO_MODE(aData)
        set_SWREG_MDIO_MODE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_SGMII_PWRDN_VAL_value = rightShift(data_low, 7) and &H1
        read_SGMII_PWRDN_OV_value = rightShift(data_low, 6) and &H1
        read_RGMII_SGMII_sel_value = rightShift(data_low, 4) and &H3
        read_SWREG_SOFT_RESET_value = rightShift(data_low, 2) and &H1
        read_SWREG_SCLK_ENABLE_value = rightShift(data_low, 1) and &H1
        SWREG_MDIO_MODE_mask = &H1
        if data_low > LONG_MAX then
            if SWREG_MDIO_MODE_mask = mask then
                read_SWREG_MDIO_MODE_value = data_low
            else
                read_SWREG_MDIO_MODE_value = (data_low - H8000_0000) and SWREG_MDIO_MODE_mask
            end If
        else
            read_SWREG_MDIO_MODE_value = data_low and SWREG_MDIO_MODE_mask
        end If

    End Sub

    Sub write
        If flag_SGMII_PWRDN_VAL = &H0 or flag_SGMII_PWRDN_OV = &H0 or flag_RGMII_SGMII_sel = &H0 or flag_SWREG_SOFT_RESET = &H0 or flag_SWREG_SCLK_ENABLE = &H0 or flag_SWREG_MDIO_MODE = &H0 Then read
        If flag_SGMII_PWRDN_VAL = &H0 Then write_SGMII_PWRDN_VAL_value = get_SGMII_PWRDN_VAL
        If flag_SGMII_PWRDN_OV = &H0 Then write_SGMII_PWRDN_OV_value = get_SGMII_PWRDN_OV
        If flag_RGMII_SGMII_sel = &H0 Then write_RGMII_SGMII_sel_value = get_RGMII_SGMII_sel
        If flag_SWREG_SOFT_RESET = &H0 Then write_SWREG_SOFT_RESET_value = get_SWREG_SOFT_RESET
        If flag_SWREG_SCLK_ENABLE = &H0 Then write_SWREG_SCLK_ENABLE_value = get_SWREG_SCLK_ENABLE
        If flag_SWREG_MDIO_MODE = &H0 Then write_SWREG_MDIO_MODE_value = get_SWREG_MDIO_MODE

        regValue = leftShift((write_SGMII_PWRDN_VAL_value and &H1), 7) + leftShift((write_SGMII_PWRDN_OV_value and &H1), 6) + leftShift((write_RGMII_SGMII_sel_value and &H3), 4) + leftShift((write_SWREG_SOFT_RESET_value and &H1), 2) + leftShift((write_SWREG_SCLK_ENABLE_value and &H1), 1) + leftShift((write_SWREG_MDIO_MODE_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_SGMII_PWRDN_VAL_value = rightShift(data_low, 7) and &H1
        read_SGMII_PWRDN_OV_value = rightShift(data_low, 6) and &H1
        read_RGMII_SGMII_sel_value = rightShift(data_low, 4) and &H3
        read_SWREG_SOFT_RESET_value = rightShift(data_low, 2) and &H1
        read_SWREG_SCLK_ENABLE_value = rightShift(data_low, 1) and &H1
        SWREG_MDIO_MODE_mask = &H1
        if data_low > LONG_MAX then
            if SWREG_MDIO_MODE_mask = mask then
                read_SWREG_MDIO_MODE_value = data_low
            else
                read_SWREG_MDIO_MODE_value = (data_low - H8000_0000) and SWREG_MDIO_MODE_mask
            end If
        else
            read_SWREG_MDIO_MODE_value = data_low and SWREG_MDIO_MODE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SGMII_PWRDN_VAL_value = &H0
        flag_SGMII_PWRDN_VAL        = &H0
        write_SGMII_PWRDN_OV_value = &H0
        flag_SGMII_PWRDN_OV        = &H0
        write_RGMII_SGMII_sel_value = &H0
        flag_RGMII_SGMII_sel        = &H0
        write_SWREG_SOFT_RESET_value = &H0
        flag_SWREG_SOFT_RESET        = &H0
        write_SWREG_SCLK_ENABLE_value = &H0
        flag_SWREG_SCLK_ENABLE        = &H0
        write_SWREG_MDIO_MODE_value = &H0
        flag_SWREG_MDIO_MODE        = &H0
    End Sub
End Class


'' @REGISTER : BRPHY_1G_1PORT_MISC_sgmii_aux_ctl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SGMII_RESCALE                              [15:12]          get_SGMII_RESCALE
''                                                             set_SGMII_RESCALE
''                                                             read_SGMII_RESCALE
''                                                             write_SGMII_RESCALE
''---------------------------------------------------------------------------------
'' SGMII_EXT_SELECT                           [8:8]            get_SGMII_EXT_SELECT
''                                                             set_SGMII_EXT_SELECT
''                                                             read_SGMII_EXT_SELECT
''                                                             write_SGMII_EXT_SELECT
''---------------------------------------------------------------------------------
'' SGMII_CLAUSE_SELECT                        [5:5]            get_SGMII_CLAUSE_SELECT
''                                                             set_SGMII_CLAUSE_SELECT
''                                                             read_SGMII_CLAUSE_SELECT
''                                                             write_SGMII_CLAUSE_SELECT
''---------------------------------------------------------------------------------
'' SGMII_MDIO_DEVAD                           [4:0]            get_SGMII_MDIO_DEVAD
''                                                             set_SGMII_MDIO_DEVAD
''                                                             read_SGMII_MDIO_DEVAD
''                                                             write_SGMII_MDIO_DEVAD
''---------------------------------------------------------------------------------
Class REGISTER_BRPHY_1G_1PORT_MISC_sgmii_aux_ctl
    Private write_SGMII_RESCALE_value
    Private read_SGMII_RESCALE_value
    Private flag_SGMII_RESCALE
    Private write_SGMII_EXT_SELECT_value
    Private read_SGMII_EXT_SELECT_value
    Private flag_SGMII_EXT_SELECT
    Private write_SGMII_CLAUSE_SELECT_value
    Private read_SGMII_CLAUSE_SELECT_value
    Private flag_SGMII_CLAUSE_SELECT
    Private write_SGMII_MDIO_DEVAD_value
    Private read_SGMII_MDIO_DEVAD_value
    Private flag_SGMII_MDIO_DEVAD

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

    Property Get get_SGMII_RESCALE
        get_SGMII_RESCALE = read_SGMII_RESCALE_value
    End Property

    Property Let set_SGMII_RESCALE(aData)
        write_SGMII_RESCALE_value = aData
        flag_SGMII_RESCALE        = &H1
    End Property

    Property Get read_SGMII_RESCALE
        read
        read_SGMII_RESCALE = read_SGMII_RESCALE_value
    End Property

    Property Let write_SGMII_RESCALE(aData)
        set_SGMII_RESCALE = aData
        write
    End Property

    Property Get get_SGMII_EXT_SELECT
        get_SGMII_EXT_SELECT = read_SGMII_EXT_SELECT_value
    End Property

    Property Let set_SGMII_EXT_SELECT(aData)
        write_SGMII_EXT_SELECT_value = aData
        flag_SGMII_EXT_SELECT        = &H1
    End Property

    Property Get read_SGMII_EXT_SELECT
        read
        read_SGMII_EXT_SELECT = read_SGMII_EXT_SELECT_value
    End Property

    Property Let write_SGMII_EXT_SELECT(aData)
        set_SGMII_EXT_SELECT = aData
        write
    End Property

    Property Get get_SGMII_CLAUSE_SELECT
        get_SGMII_CLAUSE_SELECT = read_SGMII_CLAUSE_SELECT_value
    End Property

    Property Let set_SGMII_CLAUSE_SELECT(aData)
        write_SGMII_CLAUSE_SELECT_value = aData
        flag_SGMII_CLAUSE_SELECT        = &H1
    End Property

    Property Get read_SGMII_CLAUSE_SELECT
        read
        read_SGMII_CLAUSE_SELECT = read_SGMII_CLAUSE_SELECT_value
    End Property

    Property Let write_SGMII_CLAUSE_SELECT(aData)
        set_SGMII_CLAUSE_SELECT = aData
        write
    End Property

    Property Get get_SGMII_MDIO_DEVAD
        get_SGMII_MDIO_DEVAD = read_SGMII_MDIO_DEVAD_value
    End Property

    Property Let set_SGMII_MDIO_DEVAD(aData)
        write_SGMII_MDIO_DEVAD_value = aData
        flag_SGMII_MDIO_DEVAD        = &H1
    End Property

    Property Get read_SGMII_MDIO_DEVAD
        read
        read_SGMII_MDIO_DEVAD = read_SGMII_MDIO_DEVAD_value
    End Property

    Property Let write_SGMII_MDIO_DEVAD(aData)
        set_SGMII_MDIO_DEVAD = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_SGMII_RESCALE_value = rightShift(data_low, 12) and &Hf
        read_SGMII_EXT_SELECT_value = rightShift(data_low, 8) and &H1
        read_SGMII_CLAUSE_SELECT_value = rightShift(data_low, 5) and &H1
        SGMII_MDIO_DEVAD_mask = &H1f
        if data_low > LONG_MAX then
            if SGMII_MDIO_DEVAD_mask = mask then
                read_SGMII_MDIO_DEVAD_value = data_low
            else
                read_SGMII_MDIO_DEVAD_value = (data_low - H8000_0000) and SGMII_MDIO_DEVAD_mask
            end If
        else
            read_SGMII_MDIO_DEVAD_value = data_low and SGMII_MDIO_DEVAD_mask
        end If

    End Sub

    Sub write
        If flag_SGMII_RESCALE = &H0 or flag_SGMII_EXT_SELECT = &H0 or flag_SGMII_CLAUSE_SELECT = &H0 or flag_SGMII_MDIO_DEVAD = &H0 Then read
        If flag_SGMII_RESCALE = &H0 Then write_SGMII_RESCALE_value = get_SGMII_RESCALE
        If flag_SGMII_EXT_SELECT = &H0 Then write_SGMII_EXT_SELECT_value = get_SGMII_EXT_SELECT
        If flag_SGMII_CLAUSE_SELECT = &H0 Then write_SGMII_CLAUSE_SELECT_value = get_SGMII_CLAUSE_SELECT
        If flag_SGMII_MDIO_DEVAD = &H0 Then write_SGMII_MDIO_DEVAD_value = get_SGMII_MDIO_DEVAD

        regValue = leftShift((write_SGMII_RESCALE_value and &Hf), 12) + leftShift((write_SGMII_EXT_SELECT_value and &H1), 8) + leftShift((write_SGMII_CLAUSE_SELECT_value and &H1), 5) + leftShift((write_SGMII_MDIO_DEVAD_value and &H1f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_SGMII_RESCALE_value = rightShift(data_low, 12) and &Hf
        read_SGMII_EXT_SELECT_value = rightShift(data_low, 8) and &H1
        read_SGMII_CLAUSE_SELECT_value = rightShift(data_low, 5) and &H1
        SGMII_MDIO_DEVAD_mask = &H1f
        if data_low > LONG_MAX then
            if SGMII_MDIO_DEVAD_mask = mask then
                read_SGMII_MDIO_DEVAD_value = data_low
            else
                read_SGMII_MDIO_DEVAD_value = (data_low - H8000_0000) and SGMII_MDIO_DEVAD_mask
            end If
        else
            read_SGMII_MDIO_DEVAD_value = data_low and SGMII_MDIO_DEVAD_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SGMII_RESCALE_value = &H0
        flag_SGMII_RESCALE        = &H0
        write_SGMII_EXT_SELECT_value = &H0
        flag_SGMII_EXT_SELECT        = &H0
        write_SGMII_CLAUSE_SELECT_value = &H0
        flag_SGMII_CLAUSE_SELECT        = &H0
        write_SGMII_MDIO_DEVAD_value = &H0
        flag_SGMII_MDIO_DEVAD        = &H0
    End Sub
End Class


'' @REGISTER : BRPHY_1G_1PORT_MISC_sgmii_hw_rst_dly_val
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SGMII_HW_RST_DLY_VALUE                     [14:0]           get_SGMII_HW_RST_DLY_VALUE
''                                                             set_SGMII_HW_RST_DLY_VALUE
''                                                             read_SGMII_HW_RST_DLY_VALUE
''                                                             write_SGMII_HW_RST_DLY_VALUE
''---------------------------------------------------------------------------------
Class REGISTER_BRPHY_1G_1PORT_MISC_sgmii_hw_rst_dly_val
    Private write_SGMII_HW_RST_DLY_VALUE_value
    Private read_SGMII_HW_RST_DLY_VALUE_value
    Private flag_SGMII_HW_RST_DLY_VALUE

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

    Property Get get_SGMII_HW_RST_DLY_VALUE
        get_SGMII_HW_RST_DLY_VALUE = read_SGMII_HW_RST_DLY_VALUE_value
    End Property

    Property Let set_SGMII_HW_RST_DLY_VALUE(aData)
        write_SGMII_HW_RST_DLY_VALUE_value = aData
        flag_SGMII_HW_RST_DLY_VALUE        = &H1
    End Property

    Property Get read_SGMII_HW_RST_DLY_VALUE
        read
        read_SGMII_HW_RST_DLY_VALUE = read_SGMII_HW_RST_DLY_VALUE_value
    End Property

    Property Let write_SGMII_HW_RST_DLY_VALUE(aData)
        set_SGMII_HW_RST_DLY_VALUE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SGMII_HW_RST_DLY_VALUE_mask = &H7fff
        if data_low > LONG_MAX then
            if SGMII_HW_RST_DLY_VALUE_mask = mask then
                read_SGMII_HW_RST_DLY_VALUE_value = data_low
            else
                read_SGMII_HW_RST_DLY_VALUE_value = (data_low - H8000_0000) and SGMII_HW_RST_DLY_VALUE_mask
            end If
        else
            read_SGMII_HW_RST_DLY_VALUE_value = data_low and SGMII_HW_RST_DLY_VALUE_mask
        end If

    End Sub

    Sub write
        If flag_SGMII_HW_RST_DLY_VALUE = &H0 Then read
        If flag_SGMII_HW_RST_DLY_VALUE = &H0 Then write_SGMII_HW_RST_DLY_VALUE_value = get_SGMII_HW_RST_DLY_VALUE

        regValue = leftShift((write_SGMII_HW_RST_DLY_VALUE_value and &H7fff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SGMII_HW_RST_DLY_VALUE_mask = &H7fff
        if data_low > LONG_MAX then
            if SGMII_HW_RST_DLY_VALUE_mask = mask then
                read_SGMII_HW_RST_DLY_VALUE_value = data_low
            else
                read_SGMII_HW_RST_DLY_VALUE_value = (data_low - H8000_0000) and SGMII_HW_RST_DLY_VALUE_mask
            end If
        else
            read_SGMII_HW_RST_DLY_VALUE_value = data_low and SGMII_HW_RST_DLY_VALUE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SGMII_HW_RST_DLY_VALUE_value = &H0
        flag_SGMII_HW_RST_DLY_VALUE        = &H0
    End Sub
End Class


'' @REGISTER : BRPHY_1G_1PORT_MISC_sgmii_mdio_rst_dly_val
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SGMII_MDIO_RST_DLY_VALUE                   [14:0]           get_SGMII_MDIO_RST_DLY_VALUE
''                                                             set_SGMII_MDIO_RST_DLY_VALUE
''                                                             read_SGMII_MDIO_RST_DLY_VALUE
''                                                             write_SGMII_MDIO_RST_DLY_VALUE
''---------------------------------------------------------------------------------
Class REGISTER_BRPHY_1G_1PORT_MISC_sgmii_mdio_rst_dly_val
    Private write_SGMII_MDIO_RST_DLY_VALUE_value
    Private read_SGMII_MDIO_RST_DLY_VALUE_value
    Private flag_SGMII_MDIO_RST_DLY_VALUE

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

    Property Get get_SGMII_MDIO_RST_DLY_VALUE
        get_SGMII_MDIO_RST_DLY_VALUE = read_SGMII_MDIO_RST_DLY_VALUE_value
    End Property

    Property Let set_SGMII_MDIO_RST_DLY_VALUE(aData)
        write_SGMII_MDIO_RST_DLY_VALUE_value = aData
        flag_SGMII_MDIO_RST_DLY_VALUE        = &H1
    End Property

    Property Get read_SGMII_MDIO_RST_DLY_VALUE
        read
        read_SGMII_MDIO_RST_DLY_VALUE = read_SGMII_MDIO_RST_DLY_VALUE_value
    End Property

    Property Let write_SGMII_MDIO_RST_DLY_VALUE(aData)
        set_SGMII_MDIO_RST_DLY_VALUE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SGMII_MDIO_RST_DLY_VALUE_mask = &H7fff
        if data_low > LONG_MAX then
            if SGMII_MDIO_RST_DLY_VALUE_mask = mask then
                read_SGMII_MDIO_RST_DLY_VALUE_value = data_low
            else
                read_SGMII_MDIO_RST_DLY_VALUE_value = (data_low - H8000_0000) and SGMII_MDIO_RST_DLY_VALUE_mask
            end If
        else
            read_SGMII_MDIO_RST_DLY_VALUE_value = data_low and SGMII_MDIO_RST_DLY_VALUE_mask
        end If

    End Sub

    Sub write
        If flag_SGMII_MDIO_RST_DLY_VALUE = &H0 Then read
        If flag_SGMII_MDIO_RST_DLY_VALUE = &H0 Then write_SGMII_MDIO_RST_DLY_VALUE_value = get_SGMII_MDIO_RST_DLY_VALUE

        regValue = leftShift((write_SGMII_MDIO_RST_DLY_VALUE_value and &H7fff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SGMII_MDIO_RST_DLY_VALUE_mask = &H7fff
        if data_low > LONG_MAX then
            if SGMII_MDIO_RST_DLY_VALUE_mask = mask then
                read_SGMII_MDIO_RST_DLY_VALUE_value = data_low
            else
                read_SGMII_MDIO_RST_DLY_VALUE_value = (data_low - H8000_0000) and SGMII_MDIO_RST_DLY_VALUE_mask
            end If
        else
            read_SGMII_MDIO_RST_DLY_VALUE_value = data_low and SGMII_MDIO_RST_DLY_VALUE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SGMII_MDIO_RST_DLY_VALUE_value = &H0
        flag_SGMII_MDIO_RST_DLY_VALUE        = &H0
    End Sub
End Class


'' @REGISTER : BRPHY_1G_1PORT_MISC_sgmii_pll_rst_dly_val
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SGMII_PLL_RST_DLY_VALUE                    [14:0]           get_SGMII_PLL_RST_DLY_VALUE
''                                                             set_SGMII_PLL_RST_DLY_VALUE
''                                                             read_SGMII_PLL_RST_DLY_VALUE
''                                                             write_SGMII_PLL_RST_DLY_VALUE
''---------------------------------------------------------------------------------
Class REGISTER_BRPHY_1G_1PORT_MISC_sgmii_pll_rst_dly_val
    Private write_SGMII_PLL_RST_DLY_VALUE_value
    Private read_SGMII_PLL_RST_DLY_VALUE_value
    Private flag_SGMII_PLL_RST_DLY_VALUE

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

    Property Get get_SGMII_PLL_RST_DLY_VALUE
        get_SGMII_PLL_RST_DLY_VALUE = read_SGMII_PLL_RST_DLY_VALUE_value
    End Property

    Property Let set_SGMII_PLL_RST_DLY_VALUE(aData)
        write_SGMII_PLL_RST_DLY_VALUE_value = aData
        flag_SGMII_PLL_RST_DLY_VALUE        = &H1
    End Property

    Property Get read_SGMII_PLL_RST_DLY_VALUE
        read
        read_SGMII_PLL_RST_DLY_VALUE = read_SGMII_PLL_RST_DLY_VALUE_value
    End Property

    Property Let write_SGMII_PLL_RST_DLY_VALUE(aData)
        set_SGMII_PLL_RST_DLY_VALUE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SGMII_PLL_RST_DLY_VALUE_mask = &H7fff
        if data_low > LONG_MAX then
            if SGMII_PLL_RST_DLY_VALUE_mask = mask then
                read_SGMII_PLL_RST_DLY_VALUE_value = data_low
            else
                read_SGMII_PLL_RST_DLY_VALUE_value = (data_low - H8000_0000) and SGMII_PLL_RST_DLY_VALUE_mask
            end If
        else
            read_SGMII_PLL_RST_DLY_VALUE_value = data_low and SGMII_PLL_RST_DLY_VALUE_mask
        end If

    End Sub

    Sub write
        If flag_SGMII_PLL_RST_DLY_VALUE = &H0 Then read
        If flag_SGMII_PLL_RST_DLY_VALUE = &H0 Then write_SGMII_PLL_RST_DLY_VALUE_value = get_SGMII_PLL_RST_DLY_VALUE

        regValue = leftShift((write_SGMII_PLL_RST_DLY_VALUE_value and &H7fff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SGMII_PLL_RST_DLY_VALUE_mask = &H7fff
        if data_low > LONG_MAX then
            if SGMII_PLL_RST_DLY_VALUE_mask = mask then
                read_SGMII_PLL_RST_DLY_VALUE_value = data_low
            else
                read_SGMII_PLL_RST_DLY_VALUE_value = (data_low - H8000_0000) and SGMII_PLL_RST_DLY_VALUE_mask
            end If
        else
            read_SGMII_PLL_RST_DLY_VALUE_value = data_low and SGMII_PLL_RST_DLY_VALUE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SGMII_PLL_RST_DLY_VALUE_value = &H0
        flag_SGMII_PLL_RST_DLY_VALUE        = &H0
    End Sub
End Class


'' @REGISTER : BRPHY_1G_1PORT_MISC_sgmii_base_page
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' BASE_PAGE_LINK_STATUS                      [15:15]          get_BASE_PAGE_LINK_STATUS
''                                                             set_BASE_PAGE_LINK_STATUS
''                                                             read_BASE_PAGE_LINK_STATUS
''                                                             write_BASE_PAGE_LINK_STATUS
''---------------------------------------------------------------------------------
'' BASE_PAGE_ACKNOWLEDGE                      [14:14]          get_BASE_PAGE_ACKNOWLEDGE
''                                                             set_BASE_PAGE_ACKNOWLEDGE
''                                                             read_BASE_PAGE_ACKNOWLEDGE
''                                                             write_BASE_PAGE_ACKNOWLEDGE
''---------------------------------------------------------------------------------
'' BPB13CV                                    [13:13]          get_BPB13CV
''                                                             set_BPB13CV
''                                                             read_BPB13CV
''                                                             write_BPB13CV
''---------------------------------------------------------------------------------
'' BASE_PAGE_DUPLEX                           [12:12]          get_BASE_PAGE_DUPLEX
''                                                             set_BASE_PAGE_DUPLEX
''                                                             read_BASE_PAGE_DUPLEX
''                                                             write_BASE_PAGE_DUPLEX
''---------------------------------------------------------------------------------
'' BPFSS                                      [11:10]          get_BPFSS
''                                                             set_BPFSS
''                                                             read_BPFSS
''                                                             write_BPFSS
''---------------------------------------------------------------------------------
'' BPCV                                       [9:0]            get_BPCV
''                                                             set_BPCV
''                                                             read_BPCV
''                                                             write_BPCV
''---------------------------------------------------------------------------------
Class REGISTER_BRPHY_1G_1PORT_MISC_sgmii_base_page
    Private write_BASE_PAGE_LINK_STATUS_value
    Private read_BASE_PAGE_LINK_STATUS_value
    Private flag_BASE_PAGE_LINK_STATUS
    Private write_BASE_PAGE_ACKNOWLEDGE_value
    Private read_BASE_PAGE_ACKNOWLEDGE_value
    Private flag_BASE_PAGE_ACKNOWLEDGE
    Private write_BPB13CV_value
    Private read_BPB13CV_value
    Private flag_BPB13CV
    Private write_BASE_PAGE_DUPLEX_value
    Private read_BASE_PAGE_DUPLEX_value
    Private flag_BASE_PAGE_DUPLEX
    Private write_BPFSS_value
    Private read_BPFSS_value
    Private flag_BPFSS
    Private write_BPCV_value
    Private read_BPCV_value
    Private flag_BPCV

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

    Property Get get_BASE_PAGE_LINK_STATUS
        get_BASE_PAGE_LINK_STATUS = read_BASE_PAGE_LINK_STATUS_value
    End Property

    Property Let set_BASE_PAGE_LINK_STATUS(aData)
        write_BASE_PAGE_LINK_STATUS_value = aData
        flag_BASE_PAGE_LINK_STATUS        = &H1
    End Property

    Property Get read_BASE_PAGE_LINK_STATUS
        read
        read_BASE_PAGE_LINK_STATUS = read_BASE_PAGE_LINK_STATUS_value
    End Property

    Property Let write_BASE_PAGE_LINK_STATUS(aData)
        set_BASE_PAGE_LINK_STATUS = aData
        write
    End Property

    Property Get get_BASE_PAGE_ACKNOWLEDGE
        get_BASE_PAGE_ACKNOWLEDGE = read_BASE_PAGE_ACKNOWLEDGE_value
    End Property

    Property Let set_BASE_PAGE_ACKNOWLEDGE(aData)
        write_BASE_PAGE_ACKNOWLEDGE_value = aData
        flag_BASE_PAGE_ACKNOWLEDGE        = &H1
    End Property

    Property Get read_BASE_PAGE_ACKNOWLEDGE
        read
        read_BASE_PAGE_ACKNOWLEDGE = read_BASE_PAGE_ACKNOWLEDGE_value
    End Property

    Property Let write_BASE_PAGE_ACKNOWLEDGE(aData)
        set_BASE_PAGE_ACKNOWLEDGE = aData
        write
    End Property

    Property Get get_BPB13CV
        get_BPB13CV = read_BPB13CV_value
    End Property

    Property Let set_BPB13CV(aData)
        write_BPB13CV_value = aData
        flag_BPB13CV        = &H1
    End Property

    Property Get read_BPB13CV
        read
        read_BPB13CV = read_BPB13CV_value
    End Property

    Property Let write_BPB13CV(aData)
        set_BPB13CV = aData
        write
    End Property

    Property Get get_BASE_PAGE_DUPLEX
        get_BASE_PAGE_DUPLEX = read_BASE_PAGE_DUPLEX_value
    End Property

    Property Let set_BASE_PAGE_DUPLEX(aData)
        write_BASE_PAGE_DUPLEX_value = aData
        flag_BASE_PAGE_DUPLEX        = &H1
    End Property

    Property Get read_BASE_PAGE_DUPLEX
        read
        read_BASE_PAGE_DUPLEX = read_BASE_PAGE_DUPLEX_value
    End Property

    Property Let write_BASE_PAGE_DUPLEX(aData)
        set_BASE_PAGE_DUPLEX = aData
        write
    End Property

    Property Get get_BPFSS
        get_BPFSS = read_BPFSS_value
    End Property

    Property Let set_BPFSS(aData)
        write_BPFSS_value = aData
        flag_BPFSS        = &H1
    End Property

    Property Get read_BPFSS
        read
        read_BPFSS = read_BPFSS_value
    End Property

    Property Let write_BPFSS(aData)
        set_BPFSS = aData
        write
    End Property

    Property Get get_BPCV
        get_BPCV = read_BPCV_value
    End Property

    Property Let set_BPCV(aData)
        write_BPCV_value = aData
        flag_BPCV        = &H1
    End Property

    Property Get read_BPCV
        read
        read_BPCV = read_BPCV_value
    End Property

    Property Let write_BPCV(aData)
        set_BPCV = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_BASE_PAGE_LINK_STATUS_value = rightShift(data_low, 15) and &H1
        read_BASE_PAGE_ACKNOWLEDGE_value = rightShift(data_low, 14) and &H1
        read_BPB13CV_value = rightShift(data_low, 13) and &H1
        read_BASE_PAGE_DUPLEX_value = rightShift(data_low, 12) and &H1
        read_BPFSS_value = rightShift(data_low, 10) and &H3
        BPCV_mask = &H3ff
        if data_low > LONG_MAX then
            if BPCV_mask = mask then
                read_BPCV_value = data_low
            else
                read_BPCV_value = (data_low - H8000_0000) and BPCV_mask
            end If
        else
            read_BPCV_value = data_low and BPCV_mask
        end If

    End Sub

    Sub write
        If flag_BASE_PAGE_LINK_STATUS = &H0 or flag_BASE_PAGE_ACKNOWLEDGE = &H0 or flag_BPB13CV = &H0 or flag_BASE_PAGE_DUPLEX = &H0 or flag_BPFSS = &H0 or flag_BPCV = &H0 Then read
        If flag_BASE_PAGE_LINK_STATUS = &H0 Then write_BASE_PAGE_LINK_STATUS_value = get_BASE_PAGE_LINK_STATUS
        If flag_BASE_PAGE_ACKNOWLEDGE = &H0 Then write_BASE_PAGE_ACKNOWLEDGE_value = get_BASE_PAGE_ACKNOWLEDGE
        If flag_BPB13CV = &H0 Then write_BPB13CV_value = get_BPB13CV
        If flag_BASE_PAGE_DUPLEX = &H0 Then write_BASE_PAGE_DUPLEX_value = get_BASE_PAGE_DUPLEX
        If flag_BPFSS = &H0 Then write_BPFSS_value = get_BPFSS
        If flag_BPCV = &H0 Then write_BPCV_value = get_BPCV

        regValue = leftShift((write_BASE_PAGE_LINK_STATUS_value and &H1), 15) + leftShift((write_BASE_PAGE_ACKNOWLEDGE_value and &H1), 14) + leftShift((write_BPB13CV_value and &H1), 13) + leftShift((write_BASE_PAGE_DUPLEX_value and &H1), 12) + leftShift((write_BPFSS_value and &H3), 10) + leftShift((write_BPCV_value and &H3ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_BASE_PAGE_LINK_STATUS_value = rightShift(data_low, 15) and &H1
        read_BASE_PAGE_ACKNOWLEDGE_value = rightShift(data_low, 14) and &H1
        read_BPB13CV_value = rightShift(data_low, 13) and &H1
        read_BASE_PAGE_DUPLEX_value = rightShift(data_low, 12) and &H1
        read_BPFSS_value = rightShift(data_low, 10) and &H3
        BPCV_mask = &H3ff
        if data_low > LONG_MAX then
            if BPCV_mask = mask then
                read_BPCV_value = data_low
            else
                read_BPCV_value = (data_low - H8000_0000) and BPCV_mask
            end If
        else
            read_BPCV_value = data_low and BPCV_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_BASE_PAGE_LINK_STATUS_value = &H0
        flag_BASE_PAGE_LINK_STATUS        = &H0
        write_BASE_PAGE_ACKNOWLEDGE_value = &H0
        flag_BASE_PAGE_ACKNOWLEDGE        = &H0
        write_BPB13CV_value = &H0
        flag_BPB13CV        = &H0
        write_BASE_PAGE_DUPLEX_value = &H0
        flag_BASE_PAGE_DUPLEX        = &H0
        write_BPFSS_value = &H0
        flag_BPFSS        = &H0
        write_BPCV_value = &H0
        flag_BPCV        = &H0
    End Sub
End Class


'' @REGISTER : BRPHY_1G_1PORT_MISC_sgmii_aux_status
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SGMII_LINK                                 [15:15]          get_SGMII_LINK
''                                                             set_SGMII_LINK
''                                                             read_SGMII_LINK
''                                                             write_SGMII_LINK
''---------------------------------------------------------------------------------
'' SGMII_SPD                                  [11:10]          get_SGMII_SPD
''                                                             set_SGMII_SPD
''                                                             read_SGMII_SPD
''                                                             write_SGMII_SPD
''---------------------------------------------------------------------------------
'' SGMII_TX_PAUSE                             [2:2]            get_SGMII_TX_PAUSE
''                                                             set_SGMII_TX_PAUSE
''                                                             read_SGMII_TX_PAUSE
''                                                             write_SGMII_TX_PAUSE
''---------------------------------------------------------------------------------
'' SGMII_RX_PAUSE                             [1:1]            get_SGMII_RX_PAUSE
''                                                             set_SGMII_RX_PAUSE
''                                                             read_SGMII_RX_PAUSE
''                                                             write_SGMII_RX_PAUSE
''---------------------------------------------------------------------------------
'' SGMII_TXPLL_LOCK                           [0:0]            get_SGMII_TXPLL_LOCK
''                                                             set_SGMII_TXPLL_LOCK
''                                                             read_SGMII_TXPLL_LOCK
''                                                             write_SGMII_TXPLL_LOCK
''---------------------------------------------------------------------------------
Class REGISTER_BRPHY_1G_1PORT_MISC_sgmii_aux_status
    Private write_SGMII_LINK_value
    Private read_SGMII_LINK_value
    Private flag_SGMII_LINK
    Private write_SGMII_SPD_value
    Private read_SGMII_SPD_value
    Private flag_SGMII_SPD
    Private write_SGMII_TX_PAUSE_value
    Private read_SGMII_TX_PAUSE_value
    Private flag_SGMII_TX_PAUSE
    Private write_SGMII_RX_PAUSE_value
    Private read_SGMII_RX_PAUSE_value
    Private flag_SGMII_RX_PAUSE
    Private write_SGMII_TXPLL_LOCK_value
    Private read_SGMII_TXPLL_LOCK_value
    Private flag_SGMII_TXPLL_LOCK

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

    Property Get get_SGMII_LINK
        get_SGMII_LINK = read_SGMII_LINK_value
    End Property

    Property Let set_SGMII_LINK(aData)
        write_SGMII_LINK_value = aData
        flag_SGMII_LINK        = &H1
    End Property

    Property Get read_SGMII_LINK
        read
        read_SGMII_LINK = read_SGMII_LINK_value
    End Property

    Property Let write_SGMII_LINK(aData)
        set_SGMII_LINK = aData
        write
    End Property

    Property Get get_SGMII_SPD
        get_SGMII_SPD = read_SGMII_SPD_value
    End Property

    Property Let set_SGMII_SPD(aData)
        write_SGMII_SPD_value = aData
        flag_SGMII_SPD        = &H1
    End Property

    Property Get read_SGMII_SPD
        read
        read_SGMII_SPD = read_SGMII_SPD_value
    End Property

    Property Let write_SGMII_SPD(aData)
        set_SGMII_SPD = aData
        write
    End Property

    Property Get get_SGMII_TX_PAUSE
        get_SGMII_TX_PAUSE = read_SGMII_TX_PAUSE_value
    End Property

    Property Let set_SGMII_TX_PAUSE(aData)
        write_SGMII_TX_PAUSE_value = aData
        flag_SGMII_TX_PAUSE        = &H1
    End Property

    Property Get read_SGMII_TX_PAUSE
        read
        read_SGMII_TX_PAUSE = read_SGMII_TX_PAUSE_value
    End Property

    Property Let write_SGMII_TX_PAUSE(aData)
        set_SGMII_TX_PAUSE = aData
        write
    End Property

    Property Get get_SGMII_RX_PAUSE
        get_SGMII_RX_PAUSE = read_SGMII_RX_PAUSE_value
    End Property

    Property Let set_SGMII_RX_PAUSE(aData)
        write_SGMII_RX_PAUSE_value = aData
        flag_SGMII_RX_PAUSE        = &H1
    End Property

    Property Get read_SGMII_RX_PAUSE
        read
        read_SGMII_RX_PAUSE = read_SGMII_RX_PAUSE_value
    End Property

    Property Let write_SGMII_RX_PAUSE(aData)
        set_SGMII_RX_PAUSE = aData
        write
    End Property

    Property Get get_SGMII_TXPLL_LOCK
        get_SGMII_TXPLL_LOCK = read_SGMII_TXPLL_LOCK_value
    End Property

    Property Let set_SGMII_TXPLL_LOCK(aData)
        write_SGMII_TXPLL_LOCK_value = aData
        flag_SGMII_TXPLL_LOCK        = &H1
    End Property

    Property Get read_SGMII_TXPLL_LOCK
        read
        read_SGMII_TXPLL_LOCK = read_SGMII_TXPLL_LOCK_value
    End Property

    Property Let write_SGMII_TXPLL_LOCK(aData)
        set_SGMII_TXPLL_LOCK = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_SGMII_LINK_value = rightShift(data_low, 15) and &H1
        read_SGMII_SPD_value = rightShift(data_low, 10) and &H3
        read_SGMII_TX_PAUSE_value = rightShift(data_low, 2) and &H1
        read_SGMII_RX_PAUSE_value = rightShift(data_low, 1) and &H1
        SGMII_TXPLL_LOCK_mask = &H1
        if data_low > LONG_MAX then
            if SGMII_TXPLL_LOCK_mask = mask then
                read_SGMII_TXPLL_LOCK_value = data_low
            else
                read_SGMII_TXPLL_LOCK_value = (data_low - H8000_0000) and SGMII_TXPLL_LOCK_mask
            end If
        else
            read_SGMII_TXPLL_LOCK_value = data_low and SGMII_TXPLL_LOCK_mask
        end If

    End Sub

    Sub write
        If flag_SGMII_LINK = &H0 or flag_SGMII_SPD = &H0 or flag_SGMII_TX_PAUSE = &H0 or flag_SGMII_RX_PAUSE = &H0 or flag_SGMII_TXPLL_LOCK = &H0 Then read
        If flag_SGMII_LINK = &H0 Then write_SGMII_LINK_value = get_SGMII_LINK
        If flag_SGMII_SPD = &H0 Then write_SGMII_SPD_value = get_SGMII_SPD
        If flag_SGMII_TX_PAUSE = &H0 Then write_SGMII_TX_PAUSE_value = get_SGMII_TX_PAUSE
        If flag_SGMII_RX_PAUSE = &H0 Then write_SGMII_RX_PAUSE_value = get_SGMII_RX_PAUSE
        If flag_SGMII_TXPLL_LOCK = &H0 Then write_SGMII_TXPLL_LOCK_value = get_SGMII_TXPLL_LOCK

        regValue = leftShift((write_SGMII_LINK_value and &H1), 15) + leftShift((write_SGMII_SPD_value and &H3), 10) + leftShift((write_SGMII_TX_PAUSE_value and &H1), 2) + leftShift((write_SGMII_RX_PAUSE_value and &H1), 1) + leftShift((write_SGMII_TXPLL_LOCK_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_SGMII_LINK_value = rightShift(data_low, 15) and &H1
        read_SGMII_SPD_value = rightShift(data_low, 10) and &H3
        read_SGMII_TX_PAUSE_value = rightShift(data_low, 2) and &H1
        read_SGMII_RX_PAUSE_value = rightShift(data_low, 1) and &H1
        SGMII_TXPLL_LOCK_mask = &H1
        if data_low > LONG_MAX then
            if SGMII_TXPLL_LOCK_mask = mask then
                read_SGMII_TXPLL_LOCK_value = data_low
            else
                read_SGMII_TXPLL_LOCK_value = (data_low - H8000_0000) and SGMII_TXPLL_LOCK_mask
            end If
        else
            read_SGMII_TXPLL_LOCK_value = data_low and SGMII_TXPLL_LOCK_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SGMII_LINK_value = &H0
        flag_SGMII_LINK        = &H0
        write_SGMII_SPD_value = &H0
        flag_SGMII_SPD        = &H0
        write_SGMII_TX_PAUSE_value = &H0
        flag_SGMII_TX_PAUSE        = &H0
        write_SGMII_RX_PAUSE_value = &H0
        flag_SGMII_RX_PAUSE        = &H0
        write_SGMII_TXPLL_LOCK_value = &H0
        flag_SGMII_TXPLL_LOCK        = &H0
    End Sub
End Class


'' @REGISTER : BRPHY_1G_1PORT_MISC_sgmii_tmux
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SGMII_TMUX_VALUES                          [11:0]           get_SGMII_TMUX_VALUES
''                                                             set_SGMII_TMUX_VALUES
''                                                             read_SGMII_TMUX_VALUES
''                                                             write_SGMII_TMUX_VALUES
''---------------------------------------------------------------------------------
Class REGISTER_BRPHY_1G_1PORT_MISC_sgmii_tmux
    Private write_SGMII_TMUX_VALUES_value
    Private read_SGMII_TMUX_VALUES_value
    Private flag_SGMII_TMUX_VALUES

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

    Property Get get_SGMII_TMUX_VALUES
        get_SGMII_TMUX_VALUES = read_SGMII_TMUX_VALUES_value
    End Property

    Property Let set_SGMII_TMUX_VALUES(aData)
        write_SGMII_TMUX_VALUES_value = aData
        flag_SGMII_TMUX_VALUES        = &H1
    End Property

    Property Get read_SGMII_TMUX_VALUES
        read
        read_SGMII_TMUX_VALUES = read_SGMII_TMUX_VALUES_value
    End Property

    Property Let write_SGMII_TMUX_VALUES(aData)
        set_SGMII_TMUX_VALUES = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SGMII_TMUX_VALUES_mask = &Hfff
        if data_low > LONG_MAX then
            if SGMII_TMUX_VALUES_mask = mask then
                read_SGMII_TMUX_VALUES_value = data_low
            else
                read_SGMII_TMUX_VALUES_value = (data_low - H8000_0000) and SGMII_TMUX_VALUES_mask
            end If
        else
            read_SGMII_TMUX_VALUES_value = data_low and SGMII_TMUX_VALUES_mask
        end If

    End Sub

    Sub write
        If flag_SGMII_TMUX_VALUES = &H0 Then read
        If flag_SGMII_TMUX_VALUES = &H0 Then write_SGMII_TMUX_VALUES_value = get_SGMII_TMUX_VALUES

        regValue = leftShift((write_SGMII_TMUX_VALUES_value and &Hfff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SGMII_TMUX_VALUES_mask = &Hfff
        if data_low > LONG_MAX then
            if SGMII_TMUX_VALUES_mask = mask then
                read_SGMII_TMUX_VALUES_value = data_low
            else
                read_SGMII_TMUX_VALUES_value = (data_low - H8000_0000) and SGMII_TMUX_VALUES_mask
            end If
        else
            read_SGMII_TMUX_VALUES_value = data_low and SGMII_TMUX_VALUES_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SGMII_TMUX_VALUES_value = &H0
        flag_SGMII_TMUX_VALUES        = &H0
    End Sub
End Class


'' @REGISTER : BRPHY_1G_1PORT_MISC_led_intr_ctl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' reset_1588                                 [14:14]          get_reset_1588
''                                                             set_reset_1588
''                                                             read_reset_1588
''                                                             write_reset_1588
''---------------------------------------------------------------------------------
'' intr_1588                                  [13:13]          get_intr_1588
''                                                             set_intr_1588
''                                                             read_intr_1588
''                                                             write_intr_1588
''---------------------------------------------------------------------------------
'' p1588s_sel_led                             [12:12]          get_p1588s_sel_led
''                                                             set_p1588s_sel_led
''                                                             read_p1588s_sel_led
''                                                             write_p1588s_sel_led
''---------------------------------------------------------------------------------
'' led_pol_ctl                                [11:8]           get_led_pol_ctl
''                                                             set_led_pol_ctl
''                                                             read_led_pol_ctl
''                                                             write_led_pol_ctl
''---------------------------------------------------------------------------------
'' intr_sel_tsync                             [7:7]            get_intr_sel_tsync
''                                                             set_intr_sel_tsync
''                                                             read_intr_sel_tsync
''                                                             write_intr_sel_tsync
''---------------------------------------------------------------------------------
'' intr_sel_ed                                [6:6]            get_intr_sel_ed
''                                                             set_intr_sel_ed
''                                                             read_intr_sel_ed
''                                                             write_intr_sel_ed
''---------------------------------------------------------------------------------
'' led4_sel_intr                              [5:5]            get_led4_sel_intr
''                                                             set_led4_sel_intr
''                                                             read_led4_sel_intr
''                                                             write_led4_sel_intr
''---------------------------------------------------------------------------------
'' led1_intr_sel                              [4:4]            get_led1_intr_sel
''                                                             set_led1_intr_sel
''                                                             read_led1_intr_sel
''                                                             write_led1_intr_sel
''---------------------------------------------------------------------------------
'' P1588_INTR_MASK                            [2:2]            get_P1588_INTR_MASK
''                                                             set_P1588_INTR_MASK
''                                                             read_P1588_INTR_MASK
''                                                             write_P1588_INTR_MASK
''---------------------------------------------------------------------------------
'' VTMON_INTR_MASK                            [1:1]            get_VTMON_INTR_MASK
''                                                             set_VTMON_INTR_MASK
''                                                             read_VTMON_INTR_MASK
''                                                             write_VTMON_INTR_MASK
''---------------------------------------------------------------------------------
'' GPHY_INTR_MASK                             [0:0]            get_GPHY_INTR_MASK
''                                                             set_GPHY_INTR_MASK
''                                                             read_GPHY_INTR_MASK
''                                                             write_GPHY_INTR_MASK
''---------------------------------------------------------------------------------
Class REGISTER_BRPHY_1G_1PORT_MISC_led_intr_ctl
    Private write_reset_1588_value
    Private read_reset_1588_value
    Private flag_reset_1588
    Private write_intr_1588_value
    Private read_intr_1588_value
    Private flag_intr_1588
    Private write_p1588s_sel_led_value
    Private read_p1588s_sel_led_value
    Private flag_p1588s_sel_led
    Private write_led_pol_ctl_value
    Private read_led_pol_ctl_value
    Private flag_led_pol_ctl
    Private write_intr_sel_tsync_value
    Private read_intr_sel_tsync_value
    Private flag_intr_sel_tsync
    Private write_intr_sel_ed_value
    Private read_intr_sel_ed_value
    Private flag_intr_sel_ed
    Private write_led4_sel_intr_value
    Private read_led4_sel_intr_value
    Private flag_led4_sel_intr
    Private write_led1_intr_sel_value
    Private read_led1_intr_sel_value
    Private flag_led1_intr_sel
    Private write_P1588_INTR_MASK_value
    Private read_P1588_INTR_MASK_value
    Private flag_P1588_INTR_MASK
    Private write_VTMON_INTR_MASK_value
    Private read_VTMON_INTR_MASK_value
    Private flag_VTMON_INTR_MASK
    Private write_GPHY_INTR_MASK_value
    Private read_GPHY_INTR_MASK_value
    Private flag_GPHY_INTR_MASK

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

    Property Get get_reset_1588
        get_reset_1588 = read_reset_1588_value
    End Property

    Property Let set_reset_1588(aData)
        write_reset_1588_value = aData
        flag_reset_1588        = &H1
    End Property

    Property Get read_reset_1588
        read
        read_reset_1588 = read_reset_1588_value
    End Property

    Property Let write_reset_1588(aData)
        set_reset_1588 = aData
        write
    End Property

    Property Get get_intr_1588
        get_intr_1588 = read_intr_1588_value
    End Property

    Property Let set_intr_1588(aData)
        write_intr_1588_value = aData
        flag_intr_1588        = &H1
    End Property

    Property Get read_intr_1588
        read
        read_intr_1588 = read_intr_1588_value
    End Property

    Property Let write_intr_1588(aData)
        set_intr_1588 = aData
        write
    End Property

    Property Get get_p1588s_sel_led
        get_p1588s_sel_led = read_p1588s_sel_led_value
    End Property

    Property Let set_p1588s_sel_led(aData)
        write_p1588s_sel_led_value = aData
        flag_p1588s_sel_led        = &H1
    End Property

    Property Get read_p1588s_sel_led
        read
        read_p1588s_sel_led = read_p1588s_sel_led_value
    End Property

    Property Let write_p1588s_sel_led(aData)
        set_p1588s_sel_led = aData
        write
    End Property

    Property Get get_led_pol_ctl
        get_led_pol_ctl = read_led_pol_ctl_value
    End Property

    Property Let set_led_pol_ctl(aData)
        write_led_pol_ctl_value = aData
        flag_led_pol_ctl        = &H1
    End Property

    Property Get read_led_pol_ctl
        read
        read_led_pol_ctl = read_led_pol_ctl_value
    End Property

    Property Let write_led_pol_ctl(aData)
        set_led_pol_ctl = aData
        write
    End Property

    Property Get get_intr_sel_tsync
        get_intr_sel_tsync = read_intr_sel_tsync_value
    End Property

    Property Let set_intr_sel_tsync(aData)
        write_intr_sel_tsync_value = aData
        flag_intr_sel_tsync        = &H1
    End Property

    Property Get read_intr_sel_tsync
        read
        read_intr_sel_tsync = read_intr_sel_tsync_value
    End Property

    Property Let write_intr_sel_tsync(aData)
        set_intr_sel_tsync = aData
        write
    End Property

    Property Get get_intr_sel_ed
        get_intr_sel_ed = read_intr_sel_ed_value
    End Property

    Property Let set_intr_sel_ed(aData)
        write_intr_sel_ed_value = aData
        flag_intr_sel_ed        = &H1
    End Property

    Property Get read_intr_sel_ed
        read
        read_intr_sel_ed = read_intr_sel_ed_value
    End Property

    Property Let write_intr_sel_ed(aData)
        set_intr_sel_ed = aData
        write
    End Property

    Property Get get_led4_sel_intr
        get_led4_sel_intr = read_led4_sel_intr_value
    End Property

    Property Let set_led4_sel_intr(aData)
        write_led4_sel_intr_value = aData
        flag_led4_sel_intr        = &H1
    End Property

    Property Get read_led4_sel_intr
        read
        read_led4_sel_intr = read_led4_sel_intr_value
    End Property

    Property Let write_led4_sel_intr(aData)
        set_led4_sel_intr = aData
        write
    End Property

    Property Get get_led1_intr_sel
        get_led1_intr_sel = read_led1_intr_sel_value
    End Property

    Property Let set_led1_intr_sel(aData)
        write_led1_intr_sel_value = aData
        flag_led1_intr_sel        = &H1
    End Property

    Property Get read_led1_intr_sel
        read
        read_led1_intr_sel = read_led1_intr_sel_value
    End Property

    Property Let write_led1_intr_sel(aData)
        set_led1_intr_sel = aData
        write
    End Property

    Property Get get_P1588_INTR_MASK
        get_P1588_INTR_MASK = read_P1588_INTR_MASK_value
    End Property

    Property Let set_P1588_INTR_MASK(aData)
        write_P1588_INTR_MASK_value = aData
        flag_P1588_INTR_MASK        = &H1
    End Property

    Property Get read_P1588_INTR_MASK
        read
        read_P1588_INTR_MASK = read_P1588_INTR_MASK_value
    End Property

    Property Let write_P1588_INTR_MASK(aData)
        set_P1588_INTR_MASK = aData
        write
    End Property

    Property Get get_VTMON_INTR_MASK
        get_VTMON_INTR_MASK = read_VTMON_INTR_MASK_value
    End Property

    Property Let set_VTMON_INTR_MASK(aData)
        write_VTMON_INTR_MASK_value = aData
        flag_VTMON_INTR_MASK        = &H1
    End Property

    Property Get read_VTMON_INTR_MASK
        read
        read_VTMON_INTR_MASK = read_VTMON_INTR_MASK_value
    End Property

    Property Let write_VTMON_INTR_MASK(aData)
        set_VTMON_INTR_MASK = aData
        write
    End Property

    Property Get get_GPHY_INTR_MASK
        get_GPHY_INTR_MASK = read_GPHY_INTR_MASK_value
    End Property

    Property Let set_GPHY_INTR_MASK(aData)
        write_GPHY_INTR_MASK_value = aData
        flag_GPHY_INTR_MASK        = &H1
    End Property

    Property Get read_GPHY_INTR_MASK
        read
        read_GPHY_INTR_MASK = read_GPHY_INTR_MASK_value
    End Property

    Property Let write_GPHY_INTR_MASK(aData)
        set_GPHY_INTR_MASK = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_reset_1588_value = rightShift(data_low, 14) and &H1
        read_intr_1588_value = rightShift(data_low, 13) and &H1
        read_p1588s_sel_led_value = rightShift(data_low, 12) and &H1
        read_led_pol_ctl_value = rightShift(data_low, 8) and &Hf
        read_intr_sel_tsync_value = rightShift(data_low, 7) and &H1
        read_intr_sel_ed_value = rightShift(data_low, 6) and &H1
        read_led4_sel_intr_value = rightShift(data_low, 5) and &H1
        read_led1_intr_sel_value = rightShift(data_low, 4) and &H1
        read_P1588_INTR_MASK_value = rightShift(data_low, 2) and &H1
        read_VTMON_INTR_MASK_value = rightShift(data_low, 1) and &H1
        GPHY_INTR_MASK_mask = &H1
        if data_low > LONG_MAX then
            if GPHY_INTR_MASK_mask = mask then
                read_GPHY_INTR_MASK_value = data_low
            else
                read_GPHY_INTR_MASK_value = (data_low - H8000_0000) and GPHY_INTR_MASK_mask
            end If
        else
            read_GPHY_INTR_MASK_value = data_low and GPHY_INTR_MASK_mask
        end If

    End Sub

    Sub write
        If flag_reset_1588 = &H0 or flag_intr_1588 = &H0 or flag_p1588s_sel_led = &H0 or flag_led_pol_ctl = &H0 or flag_intr_sel_tsync = &H0 or flag_intr_sel_ed = &H0 or flag_led4_sel_intr = &H0 or flag_led1_intr_sel = &H0 or flag_P1588_INTR_MASK = &H0 or flag_VTMON_INTR_MASK = &H0 or flag_GPHY_INTR_MASK = &H0 Then read
        If flag_reset_1588 = &H0 Then write_reset_1588_value = get_reset_1588
        If flag_intr_1588 = &H0 Then write_intr_1588_value = get_intr_1588
        If flag_p1588s_sel_led = &H0 Then write_p1588s_sel_led_value = get_p1588s_sel_led
        If flag_led_pol_ctl = &H0 Then write_led_pol_ctl_value = get_led_pol_ctl
        If flag_intr_sel_tsync = &H0 Then write_intr_sel_tsync_value = get_intr_sel_tsync
        If flag_intr_sel_ed = &H0 Then write_intr_sel_ed_value = get_intr_sel_ed
        If flag_led4_sel_intr = &H0 Then write_led4_sel_intr_value = get_led4_sel_intr
        If flag_led1_intr_sel = &H0 Then write_led1_intr_sel_value = get_led1_intr_sel
        If flag_P1588_INTR_MASK = &H0 Then write_P1588_INTR_MASK_value = get_P1588_INTR_MASK
        If flag_VTMON_INTR_MASK = &H0 Then write_VTMON_INTR_MASK_value = get_VTMON_INTR_MASK
        If flag_GPHY_INTR_MASK = &H0 Then write_GPHY_INTR_MASK_value = get_GPHY_INTR_MASK

        regValue = leftShift((write_reset_1588_value and &H1), 14) + leftShift((write_intr_1588_value and &H1), 13) + leftShift((write_p1588s_sel_led_value and &H1), 12) + leftShift((write_led_pol_ctl_value and &Hf), 8) + leftShift((write_intr_sel_tsync_value and &H1), 7) + leftShift((write_intr_sel_ed_value and &H1), 6) + leftShift((write_led4_sel_intr_value and &H1), 5) + leftShift((write_led1_intr_sel_value and &H1), 4) + leftShift((write_P1588_INTR_MASK_value and &H1), 2) + leftShift((write_VTMON_INTR_MASK_value and &H1), 1) + leftShift((write_GPHY_INTR_MASK_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_reset_1588_value = rightShift(data_low, 14) and &H1
        read_intr_1588_value = rightShift(data_low, 13) and &H1
        read_p1588s_sel_led_value = rightShift(data_low, 12) and &H1
        read_led_pol_ctl_value = rightShift(data_low, 8) and &Hf
        read_intr_sel_tsync_value = rightShift(data_low, 7) and &H1
        read_intr_sel_ed_value = rightShift(data_low, 6) and &H1
        read_led4_sel_intr_value = rightShift(data_low, 5) and &H1
        read_led1_intr_sel_value = rightShift(data_low, 4) and &H1
        read_P1588_INTR_MASK_value = rightShift(data_low, 2) and &H1
        read_VTMON_INTR_MASK_value = rightShift(data_low, 1) and &H1
        GPHY_INTR_MASK_mask = &H1
        if data_low > LONG_MAX then
            if GPHY_INTR_MASK_mask = mask then
                read_GPHY_INTR_MASK_value = data_low
            else
                read_GPHY_INTR_MASK_value = (data_low - H8000_0000) and GPHY_INTR_MASK_mask
            end If
        else
            read_GPHY_INTR_MASK_value = data_low and GPHY_INTR_MASK_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_reset_1588_value = &H0
        flag_reset_1588        = &H0
        write_intr_1588_value = &H0
        flag_intr_1588        = &H0
        write_p1588s_sel_led_value = &H0
        flag_p1588s_sel_led        = &H0
        write_led_pol_ctl_value = &H0
        flag_led_pol_ctl        = &H0
        write_intr_sel_tsync_value = &H0
        flag_intr_sel_tsync        = &H0
        write_intr_sel_ed_value = &H0
        flag_intr_sel_ed        = &H0
        write_led4_sel_intr_value = &H0
        flag_led4_sel_intr        = &H0
        write_led1_intr_sel_value = &H0
        flag_led1_intr_sel        = &H0
        write_P1588_INTR_MASK_value = &H0
        flag_P1588_INTR_MASK        = &H0
        write_VTMON_INTR_MASK_value = &H0
        flag_VTMON_INTR_MASK        = &H0
        write_GPHY_INTR_MASK_value = &H0
        flag_GPHY_INTR_MASK        = &H0
    End Sub
End Class


'' @REGISTER : BRPHY_1G_1PORT_MISC_man_pga_ctl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MAN_PGA_EN                                 [15:15]          get_MAN_PGA_EN
''                                                             set_MAN_PGA_EN
''                                                             read_MAN_PGA_EN
''                                                             write_MAN_PGA_EN
''---------------------------------------------------------------------------------
'' MAN_PGA_STROBE                             [14:14]          get_MAN_PGA_STROBE
''                                                             set_MAN_PGA_STROBE
''                                                             read_MAN_PGA_STROBE
''                                                             write_MAN_PGA_STROBE
''---------------------------------------------------------------------------------
'' MAN_PGA_VAL1                               [12:8]           get_MAN_PGA_VAL1
''                                                             set_MAN_PGA_VAL1
''                                                             read_MAN_PGA_VAL1
''                                                             write_MAN_PGA_VAL1
''---------------------------------------------------------------------------------
'' MAN_PGA_VAL0                               [6:0]            get_MAN_PGA_VAL0
''                                                             set_MAN_PGA_VAL0
''                                                             read_MAN_PGA_VAL0
''                                                             write_MAN_PGA_VAL0
''---------------------------------------------------------------------------------
Class REGISTER_BRPHY_1G_1PORT_MISC_man_pga_ctl
    Private write_MAN_PGA_EN_value
    Private read_MAN_PGA_EN_value
    Private flag_MAN_PGA_EN
    Private write_MAN_PGA_STROBE_value
    Private read_MAN_PGA_STROBE_value
    Private flag_MAN_PGA_STROBE
    Private write_MAN_PGA_VAL1_value
    Private read_MAN_PGA_VAL1_value
    Private flag_MAN_PGA_VAL1
    Private write_MAN_PGA_VAL0_value
    Private read_MAN_PGA_VAL0_value
    Private flag_MAN_PGA_VAL0

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

    Property Get get_MAN_PGA_EN
        get_MAN_PGA_EN = read_MAN_PGA_EN_value
    End Property

    Property Let set_MAN_PGA_EN(aData)
        write_MAN_PGA_EN_value = aData
        flag_MAN_PGA_EN        = &H1
    End Property

    Property Get read_MAN_PGA_EN
        read
        read_MAN_PGA_EN = read_MAN_PGA_EN_value
    End Property

    Property Let write_MAN_PGA_EN(aData)
        set_MAN_PGA_EN = aData
        write
    End Property

    Property Get get_MAN_PGA_STROBE
        get_MAN_PGA_STROBE = read_MAN_PGA_STROBE_value
    End Property

    Property Let set_MAN_PGA_STROBE(aData)
        write_MAN_PGA_STROBE_value = aData
        flag_MAN_PGA_STROBE        = &H1
    End Property

    Property Get read_MAN_PGA_STROBE
        read
        read_MAN_PGA_STROBE = read_MAN_PGA_STROBE_value
    End Property

    Property Let write_MAN_PGA_STROBE(aData)
        set_MAN_PGA_STROBE = aData
        write
    End Property

    Property Get get_MAN_PGA_VAL1
        get_MAN_PGA_VAL1 = read_MAN_PGA_VAL1_value
    End Property

    Property Let set_MAN_PGA_VAL1(aData)
        write_MAN_PGA_VAL1_value = aData
        flag_MAN_PGA_VAL1        = &H1
    End Property

    Property Get read_MAN_PGA_VAL1
        read
        read_MAN_PGA_VAL1 = read_MAN_PGA_VAL1_value
    End Property

    Property Let write_MAN_PGA_VAL1(aData)
        set_MAN_PGA_VAL1 = aData
        write
    End Property

    Property Get get_MAN_PGA_VAL0
        get_MAN_PGA_VAL0 = read_MAN_PGA_VAL0_value
    End Property

    Property Let set_MAN_PGA_VAL0(aData)
        write_MAN_PGA_VAL0_value = aData
        flag_MAN_PGA_VAL0        = &H1
    End Property

    Property Get read_MAN_PGA_VAL0
        read
        read_MAN_PGA_VAL0 = read_MAN_PGA_VAL0_value
    End Property

    Property Let write_MAN_PGA_VAL0(aData)
        set_MAN_PGA_VAL0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_MAN_PGA_EN_value = rightShift(data_low, 15) and &H1
        read_MAN_PGA_STROBE_value = rightShift(data_low, 14) and &H1
        read_MAN_PGA_VAL1_value = rightShift(data_low, 8) and &H1f
        MAN_PGA_VAL0_mask = &H7f
        if data_low > LONG_MAX then
            if MAN_PGA_VAL0_mask = mask then
                read_MAN_PGA_VAL0_value = data_low
            else
                read_MAN_PGA_VAL0_value = (data_low - H8000_0000) and MAN_PGA_VAL0_mask
            end If
        else
            read_MAN_PGA_VAL0_value = data_low and MAN_PGA_VAL0_mask
        end If

    End Sub

    Sub write
        If flag_MAN_PGA_EN = &H0 or flag_MAN_PGA_STROBE = &H0 or flag_MAN_PGA_VAL1 = &H0 or flag_MAN_PGA_VAL0 = &H0 Then read
        If flag_MAN_PGA_EN = &H0 Then write_MAN_PGA_EN_value = get_MAN_PGA_EN
        If flag_MAN_PGA_STROBE = &H0 Then write_MAN_PGA_STROBE_value = get_MAN_PGA_STROBE
        If flag_MAN_PGA_VAL1 = &H0 Then write_MAN_PGA_VAL1_value = get_MAN_PGA_VAL1
        If flag_MAN_PGA_VAL0 = &H0 Then write_MAN_PGA_VAL0_value = get_MAN_PGA_VAL0

        regValue = leftShift((write_MAN_PGA_EN_value and &H1), 15) + leftShift((write_MAN_PGA_STROBE_value and &H1), 14) + leftShift((write_MAN_PGA_VAL1_value and &H1f), 8) + leftShift((write_MAN_PGA_VAL0_value and &H7f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_MAN_PGA_EN_value = rightShift(data_low, 15) and &H1
        read_MAN_PGA_STROBE_value = rightShift(data_low, 14) and &H1
        read_MAN_PGA_VAL1_value = rightShift(data_low, 8) and &H1f
        MAN_PGA_VAL0_mask = &H7f
        if data_low > LONG_MAX then
            if MAN_PGA_VAL0_mask = mask then
                read_MAN_PGA_VAL0_value = data_low
            else
                read_MAN_PGA_VAL0_value = (data_low - H8000_0000) and MAN_PGA_VAL0_mask
            end If
        else
            read_MAN_PGA_VAL0_value = data_low and MAN_PGA_VAL0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MAN_PGA_EN_value = &H0
        flag_MAN_PGA_EN        = &H0
        write_MAN_PGA_STROBE_value = &H0
        flag_MAN_PGA_STROBE        = &H0
        write_MAN_PGA_VAL1_value = &H0
        flag_MAN_PGA_VAL1        = &H0
        write_MAN_PGA_VAL0_value = &H0
        flag_MAN_PGA_VAL0        = &H0
    End Sub
End Class


'' @REGISTER : BRPHY_1G_1PORT_MISC_vtmon_ana_cntrl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SPARE_REG                                  [15:14]          get_SPARE_REG
''                                                             set_SPARE_REG
''                                                             read_SPARE_REG
''                                                             write_SPARE_REG
''---------------------------------------------------------------------------------
'' VVRM1                                      [13:11]          get_VVRM1
''                                                             set_VVRM1
''                                                             read_VVRM1
''                                                             write_VVRM1
''---------------------------------------------------------------------------------
'' VVRM0                                      [10:7]           get_VVRM0
''                                                             set_VVRM0
''                                                             read_VVRM0
''                                                             write_VVRM0
''---------------------------------------------------------------------------------
'' VTMON_Vtest_sel                            [6:3]            get_VTMON_Vtest_sel
''                                                             set_VTMON_Vtest_sel
''                                                             read_VTMON_Vtest_sel
''                                                             write_VTMON_Vtest_sel
''---------------------------------------------------------------------------------
'' VTMON_BG_ADJ                               [2:0]            get_VTMON_BG_ADJ
''                                                             set_VTMON_BG_ADJ
''                                                             read_VTMON_BG_ADJ
''                                                             write_VTMON_BG_ADJ
''---------------------------------------------------------------------------------
Class REGISTER_BRPHY_1G_1PORT_MISC_vtmon_ana_cntrl
    Private write_SPARE_REG_value
    Private read_SPARE_REG_value
    Private flag_SPARE_REG
    Private write_VVRM1_value
    Private read_VVRM1_value
    Private flag_VVRM1
    Private write_VVRM0_value
    Private read_VVRM0_value
    Private flag_VVRM0
    Private write_VTMON_Vtest_sel_value
    Private read_VTMON_Vtest_sel_value
    Private flag_VTMON_Vtest_sel
    Private write_VTMON_BG_ADJ_value
    Private read_VTMON_BG_ADJ_value
    Private flag_VTMON_BG_ADJ

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

    Property Get get_SPARE_REG
        get_SPARE_REG = read_SPARE_REG_value
    End Property

    Property Let set_SPARE_REG(aData)
        write_SPARE_REG_value = aData
        flag_SPARE_REG        = &H1
    End Property

    Property Get read_SPARE_REG
        read
        read_SPARE_REG = read_SPARE_REG_value
    End Property

    Property Let write_SPARE_REG(aData)
        set_SPARE_REG = aData
        write
    End Property

    Property Get get_VVRM1
        get_VVRM1 = read_VVRM1_value
    End Property

    Property Let set_VVRM1(aData)
        write_VVRM1_value = aData
        flag_VVRM1        = &H1
    End Property

    Property Get read_VVRM1
        read
        read_VVRM1 = read_VVRM1_value
    End Property

    Property Let write_VVRM1(aData)
        set_VVRM1 = aData
        write
    End Property

    Property Get get_VVRM0
        get_VVRM0 = read_VVRM0_value
    End Property

    Property Let set_VVRM0(aData)
        write_VVRM0_value = aData
        flag_VVRM0        = &H1
    End Property

    Property Get read_VVRM0
        read
        read_VVRM0 = read_VVRM0_value
    End Property

    Property Let write_VVRM0(aData)
        set_VVRM0 = aData
        write
    End Property

    Property Get get_VTMON_Vtest_sel
        get_VTMON_Vtest_sel = read_VTMON_Vtest_sel_value
    End Property

    Property Let set_VTMON_Vtest_sel(aData)
        write_VTMON_Vtest_sel_value = aData
        flag_VTMON_Vtest_sel        = &H1
    End Property

    Property Get read_VTMON_Vtest_sel
        read
        read_VTMON_Vtest_sel = read_VTMON_Vtest_sel_value
    End Property

    Property Let write_VTMON_Vtest_sel(aData)
        set_VTMON_Vtest_sel = aData
        write
    End Property

    Property Get get_VTMON_BG_ADJ
        get_VTMON_BG_ADJ = read_VTMON_BG_ADJ_value
    End Property

    Property Let set_VTMON_BG_ADJ(aData)
        write_VTMON_BG_ADJ_value = aData
        flag_VTMON_BG_ADJ        = &H1
    End Property

    Property Get read_VTMON_BG_ADJ
        read
        read_VTMON_BG_ADJ = read_VTMON_BG_ADJ_value
    End Property

    Property Let write_VTMON_BG_ADJ(aData)
        set_VTMON_BG_ADJ = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_SPARE_REG_value = rightShift(data_low, 14) and &H3
        read_VVRM1_value = rightShift(data_low, 11) and &H7
        read_VVRM0_value = rightShift(data_low, 7) and &Hf
        read_VTMON_Vtest_sel_value = rightShift(data_low, 3) and &Hf
        VTMON_BG_ADJ_mask = &H7
        if data_low > LONG_MAX then
            if VTMON_BG_ADJ_mask = mask then
                read_VTMON_BG_ADJ_value = data_low
            else
                read_VTMON_BG_ADJ_value = (data_low - H8000_0000) and VTMON_BG_ADJ_mask
            end If
        else
            read_VTMON_BG_ADJ_value = data_low and VTMON_BG_ADJ_mask
        end If

    End Sub

    Sub write
        If flag_SPARE_REG = &H0 or flag_VVRM1 = &H0 or flag_VVRM0 = &H0 or flag_VTMON_Vtest_sel = &H0 or flag_VTMON_BG_ADJ = &H0 Then read
        If flag_SPARE_REG = &H0 Then write_SPARE_REG_value = get_SPARE_REG
        If flag_VVRM1 = &H0 Then write_VVRM1_value = get_VVRM1
        If flag_VVRM0 = &H0 Then write_VVRM0_value = get_VVRM0
        If flag_VTMON_Vtest_sel = &H0 Then write_VTMON_Vtest_sel_value = get_VTMON_Vtest_sel
        If flag_VTMON_BG_ADJ = &H0 Then write_VTMON_BG_ADJ_value = get_VTMON_BG_ADJ

        regValue = leftShift((write_SPARE_REG_value and &H3), 14) + leftShift((write_VVRM1_value and &H7), 11) + leftShift((write_VVRM0_value and &Hf), 7) + leftShift((write_VTMON_Vtest_sel_value and &Hf), 3) + leftShift((write_VTMON_BG_ADJ_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_SPARE_REG_value = rightShift(data_low, 14) and &H3
        read_VVRM1_value = rightShift(data_low, 11) and &H7
        read_VVRM0_value = rightShift(data_low, 7) and &Hf
        read_VTMON_Vtest_sel_value = rightShift(data_low, 3) and &Hf
        VTMON_BG_ADJ_mask = &H7
        if data_low > LONG_MAX then
            if VTMON_BG_ADJ_mask = mask then
                read_VTMON_BG_ADJ_value = data_low
            else
                read_VTMON_BG_ADJ_value = (data_low - H8000_0000) and VTMON_BG_ADJ_mask
            end If
        else
            read_VTMON_BG_ADJ_value = data_low and VTMON_BG_ADJ_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SPARE_REG_value = &H0
        flag_SPARE_REG        = &H0
        write_VVRM1_value = &H0
        flag_VVRM1        = &H0
        write_VVRM0_value = &H0
        flag_VVRM0        = &H0
        write_VTMON_Vtest_sel_value = &H0
        flag_VTMON_Vtest_sel        = &H0
        write_VTMON_BG_ADJ_value = &H0
        flag_VTMON_BG_ADJ        = &H0
    End Sub
End Class


'' @REGISTER : BRPHY_1G_1PORT_MISC_vtmon_cntrl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ANA_VTMON_OV_EN                            [15:15]          get_ANA_VTMON_OV_EN
''                                                             set_ANA_VTMON_OV_EN
''                                                             read_ANA_VTMON_OV_EN
''                                                             write_ANA_VTMON_OV_EN
''---------------------------------------------------------------------------------
'' ANA_VTMON_SEL_OV                           [14:12]          get_ANA_VTMON_SEL_OV
''                                                             set_ANA_VTMON_SEL_OV
''                                                             read_ANA_VTMON_SEL_OV
''                                                             write_ANA_VTMON_SEL_OV
''---------------------------------------------------------------------------------
'' ANA_VTMON_RESET_OV                         [11:11]          get_ANA_VTMON_RESET_OV
''                                                             set_ANA_VTMON_RESET_OV
''                                                             read_ANA_VTMON_RESET_OV
''                                                             write_ANA_VTMON_RESET_OV
''---------------------------------------------------------------------------------
'' ANA_VTMON_BURN_IN                          [10:10]          get_ANA_VTMON_BURN_IN
''                                                             set_ANA_VTMON_BURN_IN
''                                                             read_ANA_VTMON_BURN_IN
''                                                             write_ANA_VTMON_BURN_IN
''---------------------------------------------------------------------------------
'' ANA_VTMON_1V_MODE                          [9:9]            get_ANA_VTMON_1V_MODE
''                                                             set_ANA_VTMON_1V_MODE
''                                                             read_ANA_VTMON_1V_MODE
''                                                             write_ANA_VTMON_1V_MODE
''---------------------------------------------------------------------------------
'' VTMON_PHY_CNTRL_MODE                       [8:7]            get_VTMON_PHY_CNTRL_MODE
''                                                             set_VTMON_PHY_CNTRL_MODE
''                                                             read_VTMON_PHY_CNTRL_MODE
''                                                             write_VTMON_PHY_CNTRL_MODE
''---------------------------------------------------------------------------------
'' VTMON_PHY_VOLT_ENB                         [6:6]            get_VTMON_PHY_VOLT_ENB
''                                                             set_VTMON_PHY_VOLT_ENB
''                                                             read_VTMON_PHY_VOLT_ENB
''                                                             write_VTMON_PHY_VOLT_ENB
''---------------------------------------------------------------------------------
'' VTMON_PHY_TEMP_ENB                         [5:5]            get_VTMON_PHY_TEMP_ENB
''                                                             set_VTMON_PHY_TEMP_ENB
''                                                             read_VTMON_PHY_TEMP_ENB
''                                                             write_VTMON_PHY_TEMP_ENB
''---------------------------------------------------------------------------------
'' VTMON_TESTMODE                             [4:4]            get_VTMON_TESTMODE
''                                                             set_VTMON_TESTMODE
''                                                             read_VTMON_TESTMODE
''                                                             write_VTMON_TESTMODE
''---------------------------------------------------------------------------------
'' VTMON_SEL                                  [3:1]            get_VTMON_SEL
''                                                             set_VTMON_SEL
''                                                             read_VTMON_SEL
''                                                             write_VTMON_SEL
''---------------------------------------------------------------------------------
'' VTMON_PWRDN                                [0:0]            get_VTMON_PWRDN
''                                                             set_VTMON_PWRDN
''                                                             read_VTMON_PWRDN
''                                                             write_VTMON_PWRDN
''---------------------------------------------------------------------------------
Class REGISTER_BRPHY_1G_1PORT_MISC_vtmon_cntrl
    Private write_ANA_VTMON_OV_EN_value
    Private read_ANA_VTMON_OV_EN_value
    Private flag_ANA_VTMON_OV_EN
    Private write_ANA_VTMON_SEL_OV_value
    Private read_ANA_VTMON_SEL_OV_value
    Private flag_ANA_VTMON_SEL_OV
    Private write_ANA_VTMON_RESET_OV_value
    Private read_ANA_VTMON_RESET_OV_value
    Private flag_ANA_VTMON_RESET_OV
    Private write_ANA_VTMON_BURN_IN_value
    Private read_ANA_VTMON_BURN_IN_value
    Private flag_ANA_VTMON_BURN_IN
    Private write_ANA_VTMON_1V_MODE_value
    Private read_ANA_VTMON_1V_MODE_value
    Private flag_ANA_VTMON_1V_MODE
    Private write_VTMON_PHY_CNTRL_MODE_value
    Private read_VTMON_PHY_CNTRL_MODE_value
    Private flag_VTMON_PHY_CNTRL_MODE
    Private write_VTMON_PHY_VOLT_ENB_value
    Private read_VTMON_PHY_VOLT_ENB_value
    Private flag_VTMON_PHY_VOLT_ENB
    Private write_VTMON_PHY_TEMP_ENB_value
    Private read_VTMON_PHY_TEMP_ENB_value
    Private flag_VTMON_PHY_TEMP_ENB
    Private write_VTMON_TESTMODE_value
    Private read_VTMON_TESTMODE_value
    Private flag_VTMON_TESTMODE
    Private write_VTMON_SEL_value
    Private read_VTMON_SEL_value
    Private flag_VTMON_SEL
    Private write_VTMON_PWRDN_value
    Private read_VTMON_PWRDN_value
    Private flag_VTMON_PWRDN

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

    Property Get get_ANA_VTMON_OV_EN
        get_ANA_VTMON_OV_EN = read_ANA_VTMON_OV_EN_value
    End Property

    Property Let set_ANA_VTMON_OV_EN(aData)
        write_ANA_VTMON_OV_EN_value = aData
        flag_ANA_VTMON_OV_EN        = &H1
    End Property

    Property Get read_ANA_VTMON_OV_EN
        read
        read_ANA_VTMON_OV_EN = read_ANA_VTMON_OV_EN_value
    End Property

    Property Let write_ANA_VTMON_OV_EN(aData)
        set_ANA_VTMON_OV_EN = aData
        write
    End Property

    Property Get get_ANA_VTMON_SEL_OV
        get_ANA_VTMON_SEL_OV = read_ANA_VTMON_SEL_OV_value
    End Property

    Property Let set_ANA_VTMON_SEL_OV(aData)
        write_ANA_VTMON_SEL_OV_value = aData
        flag_ANA_VTMON_SEL_OV        = &H1
    End Property

    Property Get read_ANA_VTMON_SEL_OV
        read
        read_ANA_VTMON_SEL_OV = read_ANA_VTMON_SEL_OV_value
    End Property

    Property Let write_ANA_VTMON_SEL_OV(aData)
        set_ANA_VTMON_SEL_OV = aData
        write
    End Property

    Property Get get_ANA_VTMON_RESET_OV
        get_ANA_VTMON_RESET_OV = read_ANA_VTMON_RESET_OV_value
    End Property

    Property Let set_ANA_VTMON_RESET_OV(aData)
        write_ANA_VTMON_RESET_OV_value = aData
        flag_ANA_VTMON_RESET_OV        = &H1
    End Property

    Property Get read_ANA_VTMON_RESET_OV
        read
        read_ANA_VTMON_RESET_OV = read_ANA_VTMON_RESET_OV_value
    End Property

    Property Let write_ANA_VTMON_RESET_OV(aData)
        set_ANA_VTMON_RESET_OV = aData
        write
    End Property

    Property Get get_ANA_VTMON_BURN_IN
        get_ANA_VTMON_BURN_IN = read_ANA_VTMON_BURN_IN_value
    End Property

    Property Let set_ANA_VTMON_BURN_IN(aData)
        write_ANA_VTMON_BURN_IN_value = aData
        flag_ANA_VTMON_BURN_IN        = &H1
    End Property

    Property Get read_ANA_VTMON_BURN_IN
        read
        read_ANA_VTMON_BURN_IN = read_ANA_VTMON_BURN_IN_value
    End Property

    Property Let write_ANA_VTMON_BURN_IN(aData)
        set_ANA_VTMON_BURN_IN = aData
        write
    End Property

    Property Get get_ANA_VTMON_1V_MODE
        get_ANA_VTMON_1V_MODE = read_ANA_VTMON_1V_MODE_value
    End Property

    Property Let set_ANA_VTMON_1V_MODE(aData)
        write_ANA_VTMON_1V_MODE_value = aData
        flag_ANA_VTMON_1V_MODE        = &H1
    End Property

    Property Get read_ANA_VTMON_1V_MODE
        read
        read_ANA_VTMON_1V_MODE = read_ANA_VTMON_1V_MODE_value
    End Property

    Property Let write_ANA_VTMON_1V_MODE(aData)
        set_ANA_VTMON_1V_MODE = aData
        write
    End Property

    Property Get get_VTMON_PHY_CNTRL_MODE
        get_VTMON_PHY_CNTRL_MODE = read_VTMON_PHY_CNTRL_MODE_value
    End Property

    Property Let set_VTMON_PHY_CNTRL_MODE(aData)
        write_VTMON_PHY_CNTRL_MODE_value = aData
        flag_VTMON_PHY_CNTRL_MODE        = &H1
    End Property

    Property Get read_VTMON_PHY_CNTRL_MODE
        read
        read_VTMON_PHY_CNTRL_MODE = read_VTMON_PHY_CNTRL_MODE_value
    End Property

    Property Let write_VTMON_PHY_CNTRL_MODE(aData)
        set_VTMON_PHY_CNTRL_MODE = aData
        write
    End Property

    Property Get get_VTMON_PHY_VOLT_ENB
        get_VTMON_PHY_VOLT_ENB = read_VTMON_PHY_VOLT_ENB_value
    End Property

    Property Let set_VTMON_PHY_VOLT_ENB(aData)
        write_VTMON_PHY_VOLT_ENB_value = aData
        flag_VTMON_PHY_VOLT_ENB        = &H1
    End Property

    Property Get read_VTMON_PHY_VOLT_ENB
        read
        read_VTMON_PHY_VOLT_ENB = read_VTMON_PHY_VOLT_ENB_value
    End Property

    Property Let write_VTMON_PHY_VOLT_ENB(aData)
        set_VTMON_PHY_VOLT_ENB = aData
        write
    End Property

    Property Get get_VTMON_PHY_TEMP_ENB
        get_VTMON_PHY_TEMP_ENB = read_VTMON_PHY_TEMP_ENB_value
    End Property

    Property Let set_VTMON_PHY_TEMP_ENB(aData)
        write_VTMON_PHY_TEMP_ENB_value = aData
        flag_VTMON_PHY_TEMP_ENB        = &H1
    End Property

    Property Get read_VTMON_PHY_TEMP_ENB
        read
        read_VTMON_PHY_TEMP_ENB = read_VTMON_PHY_TEMP_ENB_value
    End Property

    Property Let write_VTMON_PHY_TEMP_ENB(aData)
        set_VTMON_PHY_TEMP_ENB = aData
        write
    End Property

    Property Get get_VTMON_TESTMODE
        get_VTMON_TESTMODE = read_VTMON_TESTMODE_value
    End Property

    Property Let set_VTMON_TESTMODE(aData)
        write_VTMON_TESTMODE_value = aData
        flag_VTMON_TESTMODE        = &H1
    End Property

    Property Get read_VTMON_TESTMODE
        read
        read_VTMON_TESTMODE = read_VTMON_TESTMODE_value
    End Property

    Property Let write_VTMON_TESTMODE(aData)
        set_VTMON_TESTMODE = aData
        write
    End Property

    Property Get get_VTMON_SEL
        get_VTMON_SEL = read_VTMON_SEL_value
    End Property

    Property Let set_VTMON_SEL(aData)
        write_VTMON_SEL_value = aData
        flag_VTMON_SEL        = &H1
    End Property

    Property Get read_VTMON_SEL
        read
        read_VTMON_SEL = read_VTMON_SEL_value
    End Property

    Property Let write_VTMON_SEL(aData)
        set_VTMON_SEL = aData
        write
    End Property

    Property Get get_VTMON_PWRDN
        get_VTMON_PWRDN = read_VTMON_PWRDN_value
    End Property

    Property Let set_VTMON_PWRDN(aData)
        write_VTMON_PWRDN_value = aData
        flag_VTMON_PWRDN        = &H1
    End Property

    Property Get read_VTMON_PWRDN
        read
        read_VTMON_PWRDN = read_VTMON_PWRDN_value
    End Property

    Property Let write_VTMON_PWRDN(aData)
        set_VTMON_PWRDN = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ANA_VTMON_OV_EN_value = rightShift(data_low, 15) and &H1
        read_ANA_VTMON_SEL_OV_value = rightShift(data_low, 12) and &H7
        read_ANA_VTMON_RESET_OV_value = rightShift(data_low, 11) and &H1
        read_ANA_VTMON_BURN_IN_value = rightShift(data_low, 10) and &H1
        read_ANA_VTMON_1V_MODE_value = rightShift(data_low, 9) and &H1
        read_VTMON_PHY_CNTRL_MODE_value = rightShift(data_low, 7) and &H3
        read_VTMON_PHY_VOLT_ENB_value = rightShift(data_low, 6) and &H1
        read_VTMON_PHY_TEMP_ENB_value = rightShift(data_low, 5) and &H1
        read_VTMON_TESTMODE_value = rightShift(data_low, 4) and &H1
        read_VTMON_SEL_value = rightShift(data_low, 1) and &H7
        VTMON_PWRDN_mask = &H1
        if data_low > LONG_MAX then
            if VTMON_PWRDN_mask = mask then
                read_VTMON_PWRDN_value = data_low
            else
                read_VTMON_PWRDN_value = (data_low - H8000_0000) and VTMON_PWRDN_mask
            end If
        else
            read_VTMON_PWRDN_value = data_low and VTMON_PWRDN_mask
        end If

    End Sub

    Sub write
        If flag_ANA_VTMON_OV_EN = &H0 or flag_ANA_VTMON_SEL_OV = &H0 or flag_ANA_VTMON_RESET_OV = &H0 or flag_ANA_VTMON_BURN_IN = &H0 or flag_ANA_VTMON_1V_MODE = &H0 or flag_VTMON_PHY_CNTRL_MODE = &H0 or flag_VTMON_PHY_VOLT_ENB = &H0 or flag_VTMON_PHY_TEMP_ENB = &H0 or flag_VTMON_TESTMODE = &H0 or flag_VTMON_SEL = &H0 or flag_VTMON_PWRDN = &H0 Then read
        If flag_ANA_VTMON_OV_EN = &H0 Then write_ANA_VTMON_OV_EN_value = get_ANA_VTMON_OV_EN
        If flag_ANA_VTMON_SEL_OV = &H0 Then write_ANA_VTMON_SEL_OV_value = get_ANA_VTMON_SEL_OV
        If flag_ANA_VTMON_RESET_OV = &H0 Then write_ANA_VTMON_RESET_OV_value = get_ANA_VTMON_RESET_OV
        If flag_ANA_VTMON_BURN_IN = &H0 Then write_ANA_VTMON_BURN_IN_value = get_ANA_VTMON_BURN_IN
        If flag_ANA_VTMON_1V_MODE = &H0 Then write_ANA_VTMON_1V_MODE_value = get_ANA_VTMON_1V_MODE
        If flag_VTMON_PHY_CNTRL_MODE = &H0 Then write_VTMON_PHY_CNTRL_MODE_value = get_VTMON_PHY_CNTRL_MODE
        If flag_VTMON_PHY_VOLT_ENB = &H0 Then write_VTMON_PHY_VOLT_ENB_value = get_VTMON_PHY_VOLT_ENB
        If flag_VTMON_PHY_TEMP_ENB = &H0 Then write_VTMON_PHY_TEMP_ENB_value = get_VTMON_PHY_TEMP_ENB
        If flag_VTMON_TESTMODE = &H0 Then write_VTMON_TESTMODE_value = get_VTMON_TESTMODE
        If flag_VTMON_SEL = &H0 Then write_VTMON_SEL_value = get_VTMON_SEL
        If flag_VTMON_PWRDN = &H0 Then write_VTMON_PWRDN_value = get_VTMON_PWRDN

        regValue = leftShift((write_ANA_VTMON_OV_EN_value and &H1), 15) + leftShift((write_ANA_VTMON_SEL_OV_value and &H7), 12) + leftShift((write_ANA_VTMON_RESET_OV_value and &H1), 11) + leftShift((write_ANA_VTMON_BURN_IN_value and &H1), 10) + leftShift((write_ANA_VTMON_1V_MODE_value and &H1), 9) + leftShift((write_VTMON_PHY_CNTRL_MODE_value and &H3), 7) + leftShift((write_VTMON_PHY_VOLT_ENB_value and &H1), 6) + leftShift((write_VTMON_PHY_TEMP_ENB_value and &H1), 5) + leftShift((write_VTMON_TESTMODE_value and &H1), 4) + leftShift((write_VTMON_SEL_value and &H7), 1) + leftShift((write_VTMON_PWRDN_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ANA_VTMON_OV_EN_value = rightShift(data_low, 15) and &H1
        read_ANA_VTMON_SEL_OV_value = rightShift(data_low, 12) and &H7
        read_ANA_VTMON_RESET_OV_value = rightShift(data_low, 11) and &H1
        read_ANA_VTMON_BURN_IN_value = rightShift(data_low, 10) and &H1
        read_ANA_VTMON_1V_MODE_value = rightShift(data_low, 9) and &H1
        read_VTMON_PHY_CNTRL_MODE_value = rightShift(data_low, 7) and &H3
        read_VTMON_PHY_VOLT_ENB_value = rightShift(data_low, 6) and &H1
        read_VTMON_PHY_TEMP_ENB_value = rightShift(data_low, 5) and &H1
        read_VTMON_TESTMODE_value = rightShift(data_low, 4) and &H1
        read_VTMON_SEL_value = rightShift(data_low, 1) and &H7
        VTMON_PWRDN_mask = &H1
        if data_low > LONG_MAX then
            if VTMON_PWRDN_mask = mask then
                read_VTMON_PWRDN_value = data_low
            else
                read_VTMON_PWRDN_value = (data_low - H8000_0000) and VTMON_PWRDN_mask
            end If
        else
            read_VTMON_PWRDN_value = data_low and VTMON_PWRDN_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ANA_VTMON_OV_EN_value = &H0
        flag_ANA_VTMON_OV_EN        = &H0
        write_ANA_VTMON_SEL_OV_value = &H0
        flag_ANA_VTMON_SEL_OV        = &H0
        write_ANA_VTMON_RESET_OV_value = &H0
        flag_ANA_VTMON_RESET_OV        = &H0
        write_ANA_VTMON_BURN_IN_value = &H0
        flag_ANA_VTMON_BURN_IN        = &H0
        write_ANA_VTMON_1V_MODE_value = &H0
        flag_ANA_VTMON_1V_MODE        = &H0
        write_VTMON_PHY_CNTRL_MODE_value = &H0
        flag_VTMON_PHY_CNTRL_MODE        = &H0
        write_VTMON_PHY_VOLT_ENB_value = &H0
        flag_VTMON_PHY_VOLT_ENB        = &H0
        write_VTMON_PHY_TEMP_ENB_value = &H0
        flag_VTMON_PHY_TEMP_ENB        = &H0
        write_VTMON_TESTMODE_value = &H0
        flag_VTMON_TESTMODE        = &H0
        write_VTMON_SEL_value = &H0
        flag_VTMON_SEL        = &H0
        write_VTMON_PWRDN_value = &H0
        flag_VTMON_PWRDN        = &H0
    End Sub
End Class


'' @REGISTER : BRPHY_1G_1PORT_MISC_temp_data
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' VTMON_PHY_PWRDN_STS                        [15:15]          get_VTMON_PHY_PWRDN_STS
''                                                             set_VTMON_PHY_PWRDN_STS
''                                                             read_VTMON_PHY_PWRDN_STS
''                                                             write_VTMON_PHY_PWRDN_STS
''---------------------------------------------------------------------------------
'' TEMP_DATA                                  [9:0]            get_TEMP_DATA
''                                                             set_TEMP_DATA
''                                                             read_TEMP_DATA
''                                                             write_TEMP_DATA
''---------------------------------------------------------------------------------
Class REGISTER_BRPHY_1G_1PORT_MISC_temp_data
    Private write_VTMON_PHY_PWRDN_STS_value
    Private read_VTMON_PHY_PWRDN_STS_value
    Private flag_VTMON_PHY_PWRDN_STS
    Private write_TEMP_DATA_value
    Private read_TEMP_DATA_value
    Private flag_TEMP_DATA

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

    Property Get get_VTMON_PHY_PWRDN_STS
        get_VTMON_PHY_PWRDN_STS = read_VTMON_PHY_PWRDN_STS_value
    End Property

    Property Let set_VTMON_PHY_PWRDN_STS(aData)
        write_VTMON_PHY_PWRDN_STS_value = aData
        flag_VTMON_PHY_PWRDN_STS        = &H1
    End Property

    Property Get read_VTMON_PHY_PWRDN_STS
        read
        read_VTMON_PHY_PWRDN_STS = read_VTMON_PHY_PWRDN_STS_value
    End Property

    Property Let write_VTMON_PHY_PWRDN_STS(aData)
        set_VTMON_PHY_PWRDN_STS = aData
        write
    End Property

    Property Get get_TEMP_DATA
        get_TEMP_DATA = read_TEMP_DATA_value
    End Property

    Property Let set_TEMP_DATA(aData)
        write_TEMP_DATA_value = aData
        flag_TEMP_DATA        = &H1
    End Property

    Property Get read_TEMP_DATA
        read
        read_TEMP_DATA = read_TEMP_DATA_value
    End Property

    Property Let write_TEMP_DATA(aData)
        set_TEMP_DATA = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_VTMON_PHY_PWRDN_STS_value = rightShift(data_low, 15) and &H1
        TEMP_DATA_mask = &H3ff
        if data_low > LONG_MAX then
            if TEMP_DATA_mask = mask then
                read_TEMP_DATA_value = data_low
            else
                read_TEMP_DATA_value = (data_low - H8000_0000) and TEMP_DATA_mask
            end If
        else
            read_TEMP_DATA_value = data_low and TEMP_DATA_mask
        end If

    End Sub

    Sub write
        If flag_VTMON_PHY_PWRDN_STS = &H0 or flag_TEMP_DATA = &H0 Then read
        If flag_VTMON_PHY_PWRDN_STS = &H0 Then write_VTMON_PHY_PWRDN_STS_value = get_VTMON_PHY_PWRDN_STS
        If flag_TEMP_DATA = &H0 Then write_TEMP_DATA_value = get_TEMP_DATA

        regValue = leftShift((write_VTMON_PHY_PWRDN_STS_value and &H1), 15) + leftShift((write_TEMP_DATA_value and &H3ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_VTMON_PHY_PWRDN_STS_value = rightShift(data_low, 15) and &H1
        TEMP_DATA_mask = &H3ff
        if data_low > LONG_MAX then
            if TEMP_DATA_mask = mask then
                read_TEMP_DATA_value = data_low
            else
                read_TEMP_DATA_value = (data_low - H8000_0000) and TEMP_DATA_mask
            end If
        else
            read_TEMP_DATA_value = data_low and TEMP_DATA_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_VTMON_PHY_PWRDN_STS_value = &H0
        flag_VTMON_PHY_PWRDN_STS        = &H0
        write_TEMP_DATA_value = &H0
        flag_TEMP_DATA        = &H0
    End Sub
End Class


'' @REGISTER : BRPHY_1G_1PORT_MISC_temp_thresh_high
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TEMP_THRESH_HIGH                           [9:0]            get_TEMP_THRESH_HIGH
''                                                             set_TEMP_THRESH_HIGH
''                                                             read_TEMP_THRESH_HIGH
''                                                             write_TEMP_THRESH_HIGH
''---------------------------------------------------------------------------------
Class REGISTER_BRPHY_1G_1PORT_MISC_temp_thresh_high
    Private write_TEMP_THRESH_HIGH_value
    Private read_TEMP_THRESH_HIGH_value
    Private flag_TEMP_THRESH_HIGH

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

    Property Get get_TEMP_THRESH_HIGH
        get_TEMP_THRESH_HIGH = read_TEMP_THRESH_HIGH_value
    End Property

    Property Let set_TEMP_THRESH_HIGH(aData)
        write_TEMP_THRESH_HIGH_value = aData
        flag_TEMP_THRESH_HIGH        = &H1
    End Property

    Property Get read_TEMP_THRESH_HIGH
        read
        read_TEMP_THRESH_HIGH = read_TEMP_THRESH_HIGH_value
    End Property

    Property Let write_TEMP_THRESH_HIGH(aData)
        set_TEMP_THRESH_HIGH = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TEMP_THRESH_HIGH_mask = &H3ff
        if data_low > LONG_MAX then
            if TEMP_THRESH_HIGH_mask = mask then
                read_TEMP_THRESH_HIGH_value = data_low
            else
                read_TEMP_THRESH_HIGH_value = (data_low - H8000_0000) and TEMP_THRESH_HIGH_mask
            end If
        else
            read_TEMP_THRESH_HIGH_value = data_low and TEMP_THRESH_HIGH_mask
        end If

    End Sub

    Sub write
        If flag_TEMP_THRESH_HIGH = &H0 Then read
        If flag_TEMP_THRESH_HIGH = &H0 Then write_TEMP_THRESH_HIGH_value = get_TEMP_THRESH_HIGH

        regValue = leftShift((write_TEMP_THRESH_HIGH_value and &H3ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TEMP_THRESH_HIGH_mask = &H3ff
        if data_low > LONG_MAX then
            if TEMP_THRESH_HIGH_mask = mask then
                read_TEMP_THRESH_HIGH_value = data_low
            else
                read_TEMP_THRESH_HIGH_value = (data_low - H8000_0000) and TEMP_THRESH_HIGH_mask
            end If
        else
            read_TEMP_THRESH_HIGH_value = data_low and TEMP_THRESH_HIGH_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TEMP_THRESH_HIGH_value = &H0
        flag_TEMP_THRESH_HIGH        = &H0
    End Sub
End Class


'' @REGISTER : BRPHY_1G_1PORT_MISC_temp_thresh_low
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TEMP_THRESH_LOW                            [9:0]            get_TEMP_THRESH_LOW
''                                                             set_TEMP_THRESH_LOW
''                                                             read_TEMP_THRESH_LOW
''                                                             write_TEMP_THRESH_LOW
''---------------------------------------------------------------------------------
Class REGISTER_BRPHY_1G_1PORT_MISC_temp_thresh_low
    Private write_TEMP_THRESH_LOW_value
    Private read_TEMP_THRESH_LOW_value
    Private flag_TEMP_THRESH_LOW

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

    Property Get get_TEMP_THRESH_LOW
        get_TEMP_THRESH_LOW = read_TEMP_THRESH_LOW_value
    End Property

    Property Let set_TEMP_THRESH_LOW(aData)
        write_TEMP_THRESH_LOW_value = aData
        flag_TEMP_THRESH_LOW        = &H1
    End Property

    Property Get read_TEMP_THRESH_LOW
        read
        read_TEMP_THRESH_LOW = read_TEMP_THRESH_LOW_value
    End Property

    Property Let write_TEMP_THRESH_LOW(aData)
        set_TEMP_THRESH_LOW = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TEMP_THRESH_LOW_mask = &H3ff
        if data_low > LONG_MAX then
            if TEMP_THRESH_LOW_mask = mask then
                read_TEMP_THRESH_LOW_value = data_low
            else
                read_TEMP_THRESH_LOW_value = (data_low - H8000_0000) and TEMP_THRESH_LOW_mask
            end If
        else
            read_TEMP_THRESH_LOW_value = data_low and TEMP_THRESH_LOW_mask
        end If

    End Sub

    Sub write
        If flag_TEMP_THRESH_LOW = &H0 Then read
        If flag_TEMP_THRESH_LOW = &H0 Then write_TEMP_THRESH_LOW_value = get_TEMP_THRESH_LOW

        regValue = leftShift((write_TEMP_THRESH_LOW_value and &H3ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TEMP_THRESH_LOW_mask = &H3ff
        if data_low > LONG_MAX then
            if TEMP_THRESH_LOW_mask = mask then
                read_TEMP_THRESH_LOW_value = data_low
            else
                read_TEMP_THRESH_LOW_value = (data_low - H8000_0000) and TEMP_THRESH_LOW_mask
            end If
        else
            read_TEMP_THRESH_LOW_value = data_low and TEMP_THRESH_LOW_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TEMP_THRESH_LOW_value = &H0
        flag_TEMP_THRESH_LOW        = &H0
    End Sub
End Class


'' @REGISTER : BRPHY_1G_1PORT_MISC_v1p0_data
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' V1P0_DATA                                  [10:0]           get_V1P0_DATA
''                                                             set_V1P0_DATA
''                                                             read_V1P0_DATA
''                                                             write_V1P0_DATA
''---------------------------------------------------------------------------------
Class REGISTER_BRPHY_1G_1PORT_MISC_v1p0_data
    Private write_V1P0_DATA_value
    Private read_V1P0_DATA_value
    Private flag_V1P0_DATA

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

    Property Get get_V1P0_DATA
        get_V1P0_DATA = read_V1P0_DATA_value
    End Property

    Property Let set_V1P0_DATA(aData)
        write_V1P0_DATA_value = aData
        flag_V1P0_DATA        = &H1
    End Property

    Property Get read_V1P0_DATA
        read
        read_V1P0_DATA = read_V1P0_DATA_value
    End Property

    Property Let write_V1P0_DATA(aData)
        set_V1P0_DATA = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        V1P0_DATA_mask = &H7ff
        if data_low > LONG_MAX then
            if V1P0_DATA_mask = mask then
                read_V1P0_DATA_value = data_low
            else
                read_V1P0_DATA_value = (data_low - H8000_0000) and V1P0_DATA_mask
            end If
        else
            read_V1P0_DATA_value = data_low and V1P0_DATA_mask
        end If

    End Sub

    Sub write
        If flag_V1P0_DATA = &H0 Then read
        If flag_V1P0_DATA = &H0 Then write_V1P0_DATA_value = get_V1P0_DATA

        regValue = leftShift((write_V1P0_DATA_value and &H7ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        V1P0_DATA_mask = &H7ff
        if data_low > LONG_MAX then
            if V1P0_DATA_mask = mask then
                read_V1P0_DATA_value = data_low
            else
                read_V1P0_DATA_value = (data_low - H8000_0000) and V1P0_DATA_mask
            end If
        else
            read_V1P0_DATA_value = data_low and V1P0_DATA_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_V1P0_DATA_value = &H0
        flag_V1P0_DATA        = &H0
    End Sub
End Class


'' @REGISTER : BRPHY_1G_1PORT_MISC_v1p0_thresh_high
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' VTMON_VDDCMON_refadj_max                   [13:11]          get_VTMON_VDDCMON_refadj_max
''                                                             set_VTMON_VDDCMON_refadj_max
''                                                             read_VTMON_VDDCMON_refadj_max
''                                                             write_VTMON_VDDCMON_refadj_max
''---------------------------------------------------------------------------------
'' V1P0_THRESH_HIGH                           [10:0]           get_V1P0_THRESH_HIGH
''                                                             set_V1P0_THRESH_HIGH
''                                                             read_V1P0_THRESH_HIGH
''                                                             write_V1P0_THRESH_HIGH
''---------------------------------------------------------------------------------
Class REGISTER_BRPHY_1G_1PORT_MISC_v1p0_thresh_high
    Private write_VTMON_VDDCMON_refadj_max_value
    Private read_VTMON_VDDCMON_refadj_max_value
    Private flag_VTMON_VDDCMON_refadj_max
    Private write_V1P0_THRESH_HIGH_value
    Private read_V1P0_THRESH_HIGH_value
    Private flag_V1P0_THRESH_HIGH

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

    Property Get get_VTMON_VDDCMON_refadj_max
        get_VTMON_VDDCMON_refadj_max = read_VTMON_VDDCMON_refadj_max_value
    End Property

    Property Let set_VTMON_VDDCMON_refadj_max(aData)
        write_VTMON_VDDCMON_refadj_max_value = aData
        flag_VTMON_VDDCMON_refadj_max        = &H1
    End Property

    Property Get read_VTMON_VDDCMON_refadj_max
        read
        read_VTMON_VDDCMON_refadj_max = read_VTMON_VDDCMON_refadj_max_value
    End Property

    Property Let write_VTMON_VDDCMON_refadj_max(aData)
        set_VTMON_VDDCMON_refadj_max = aData
        write
    End Property

    Property Get get_V1P0_THRESH_HIGH
        get_V1P0_THRESH_HIGH = read_V1P0_THRESH_HIGH_value
    End Property

    Property Let set_V1P0_THRESH_HIGH(aData)
        write_V1P0_THRESH_HIGH_value = aData
        flag_V1P0_THRESH_HIGH        = &H1
    End Property

    Property Get read_V1P0_THRESH_HIGH
        read
        read_V1P0_THRESH_HIGH = read_V1P0_THRESH_HIGH_value
    End Property

    Property Let write_V1P0_THRESH_HIGH(aData)
        set_V1P0_THRESH_HIGH = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_VTMON_VDDCMON_refadj_max_value = rightShift(data_low, 11) and &H7
        V1P0_THRESH_HIGH_mask = &H7ff
        if data_low > LONG_MAX then
            if V1P0_THRESH_HIGH_mask = mask then
                read_V1P0_THRESH_HIGH_value = data_low
            else
                read_V1P0_THRESH_HIGH_value = (data_low - H8000_0000) and V1P0_THRESH_HIGH_mask
            end If
        else
            read_V1P0_THRESH_HIGH_value = data_low and V1P0_THRESH_HIGH_mask
        end If

    End Sub

    Sub write
        If flag_VTMON_VDDCMON_refadj_max = &H0 or flag_V1P0_THRESH_HIGH = &H0 Then read
        If flag_VTMON_VDDCMON_refadj_max = &H0 Then write_VTMON_VDDCMON_refadj_max_value = get_VTMON_VDDCMON_refadj_max
        If flag_V1P0_THRESH_HIGH = &H0 Then write_V1P0_THRESH_HIGH_value = get_V1P0_THRESH_HIGH

        regValue = leftShift((write_VTMON_VDDCMON_refadj_max_value and &H7), 11) + leftShift((write_V1P0_THRESH_HIGH_value and &H7ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_VTMON_VDDCMON_refadj_max_value = rightShift(data_low, 11) and &H7
        V1P0_THRESH_HIGH_mask = &H7ff
        if data_low > LONG_MAX then
            if V1P0_THRESH_HIGH_mask = mask then
                read_V1P0_THRESH_HIGH_value = data_low
            else
                read_V1P0_THRESH_HIGH_value = (data_low - H8000_0000) and V1P0_THRESH_HIGH_mask
            end If
        else
            read_V1P0_THRESH_HIGH_value = data_low and V1P0_THRESH_HIGH_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_VTMON_VDDCMON_refadj_max_value = &H0
        flag_VTMON_VDDCMON_refadj_max        = &H0
        write_V1P0_THRESH_HIGH_value = &H0
        flag_V1P0_THRESH_HIGH        = &H0
    End Sub
End Class


'' @REGISTER : BRPHY_1G_1PORT_MISC_v1p0_thresh_low
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' V1P0_THRESH_LOW                            [10:0]           get_V1P0_THRESH_LOW
''                                                             set_V1P0_THRESH_LOW
''                                                             read_V1P0_THRESH_LOW
''                                                             write_V1P0_THRESH_LOW
''---------------------------------------------------------------------------------
Class REGISTER_BRPHY_1G_1PORT_MISC_v1p0_thresh_low
    Private write_V1P0_THRESH_LOW_value
    Private read_V1P0_THRESH_LOW_value
    Private flag_V1P0_THRESH_LOW

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hee
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_V1P0_THRESH_LOW
        get_V1P0_THRESH_LOW = read_V1P0_THRESH_LOW_value
    End Property

    Property Let set_V1P0_THRESH_LOW(aData)
        write_V1P0_THRESH_LOW_value = aData
        flag_V1P0_THRESH_LOW        = &H1
    End Property

    Property Get read_V1P0_THRESH_LOW
        read
        read_V1P0_THRESH_LOW = read_V1P0_THRESH_LOW_value
    End Property

    Property Let write_V1P0_THRESH_LOW(aData)
        set_V1P0_THRESH_LOW = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        V1P0_THRESH_LOW_mask = &H7ff
        if data_low > LONG_MAX then
            if V1P0_THRESH_LOW_mask = mask then
                read_V1P0_THRESH_LOW_value = data_low
            else
                read_V1P0_THRESH_LOW_value = (data_low - H8000_0000) and V1P0_THRESH_LOW_mask
            end If
        else
            read_V1P0_THRESH_LOW_value = data_low and V1P0_THRESH_LOW_mask
        end If

    End Sub

    Sub write
        If flag_V1P0_THRESH_LOW = &H0 Then read
        If flag_V1P0_THRESH_LOW = &H0 Then write_V1P0_THRESH_LOW_value = get_V1P0_THRESH_LOW

        regValue = leftShift((write_V1P0_THRESH_LOW_value and &H7ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        V1P0_THRESH_LOW_mask = &H7ff
        if data_low > LONG_MAX then
            if V1P0_THRESH_LOW_mask = mask then
                read_V1P0_THRESH_LOW_value = data_low
            else
                read_V1P0_THRESH_LOW_value = (data_low - H8000_0000) and V1P0_THRESH_LOW_mask
            end If
        else
            read_V1P0_THRESH_LOW_value = data_low and V1P0_THRESH_LOW_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_V1P0_THRESH_LOW_value = &H0
        flag_V1P0_THRESH_LOW        = &H0
    End Sub
End Class


'' @REGISTER : BRPHY_1G_1PORT_MISC_v3p3_2p5_data
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' V3P3_2P5_DATA                              [11:0]           get_V3P3_2P5_DATA
''                                                             set_V3P3_2P5_DATA
''                                                             read_V3P3_2P5_DATA
''                                                             write_V3P3_2P5_DATA
''---------------------------------------------------------------------------------
Class REGISTER_BRPHY_1G_1PORT_MISC_v3p3_2p5_data
    Private write_V3P3_2P5_DATA_value
    Private read_V3P3_2P5_DATA_value
    Private flag_V3P3_2P5_DATA

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

    Property Get get_V3P3_2P5_DATA
        get_V3P3_2P5_DATA = read_V3P3_2P5_DATA_value
    End Property

    Property Let set_V3P3_2P5_DATA(aData)
        write_V3P3_2P5_DATA_value = aData
        flag_V3P3_2P5_DATA        = &H1
    End Property

    Property Get read_V3P3_2P5_DATA
        read
        read_V3P3_2P5_DATA = read_V3P3_2P5_DATA_value
    End Property

    Property Let write_V3P3_2P5_DATA(aData)
        set_V3P3_2P5_DATA = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        V3P3_2P5_DATA_mask = &Hfff
        if data_low > LONG_MAX then
            if V3P3_2P5_DATA_mask = mask then
                read_V3P3_2P5_DATA_value = data_low
            else
                read_V3P3_2P5_DATA_value = (data_low - H8000_0000) and V3P3_2P5_DATA_mask
            end If
        else
            read_V3P3_2P5_DATA_value = data_low and V3P3_2P5_DATA_mask
        end If

    End Sub

    Sub write
        If flag_V3P3_2P5_DATA = &H0 Then read
        If flag_V3P3_2P5_DATA = &H0 Then write_V3P3_2P5_DATA_value = get_V3P3_2P5_DATA

        regValue = leftShift((write_V3P3_2P5_DATA_value and &Hfff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        V3P3_2P5_DATA_mask = &Hfff
        if data_low > LONG_MAX then
            if V3P3_2P5_DATA_mask = mask then
                read_V3P3_2P5_DATA_value = data_low
            else
                read_V3P3_2P5_DATA_value = (data_low - H8000_0000) and V3P3_2P5_DATA_mask
            end If
        else
            read_V3P3_2P5_DATA_value = data_low and V3P3_2P5_DATA_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_V3P3_2P5_DATA_value = &H0
        flag_V3P3_2P5_DATA        = &H0
    End Sub
End Class


'' @REGISTER : BRPHY_1G_1PORT_MISC_v3p3_2p5_thresh_high
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' V1P0_THRESH_HIGH                           [11:0]           get_V1P0_THRESH_HIGH
''                                                             set_V1P0_THRESH_HIGH
''                                                             read_V1P0_THRESH_HIGH
''                                                             write_V1P0_THRESH_HIGH
''---------------------------------------------------------------------------------
Class REGISTER_BRPHY_1G_1PORT_MISC_v3p3_2p5_thresh_high
    Private write_V1P0_THRESH_HIGH_value
    Private read_V1P0_THRESH_HIGH_value
    Private flag_V1P0_THRESH_HIGH

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

    Property Get get_V1P0_THRESH_HIGH
        get_V1P0_THRESH_HIGH = read_V1P0_THRESH_HIGH_value
    End Property

    Property Let set_V1P0_THRESH_HIGH(aData)
        write_V1P0_THRESH_HIGH_value = aData
        flag_V1P0_THRESH_HIGH        = &H1
    End Property

    Property Get read_V1P0_THRESH_HIGH
        read
        read_V1P0_THRESH_HIGH = read_V1P0_THRESH_HIGH_value
    End Property

    Property Let write_V1P0_THRESH_HIGH(aData)
        set_V1P0_THRESH_HIGH = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        V1P0_THRESH_HIGH_mask = &Hfff
        if data_low > LONG_MAX then
            if V1P0_THRESH_HIGH_mask = mask then
                read_V1P0_THRESH_HIGH_value = data_low
            else
                read_V1P0_THRESH_HIGH_value = (data_low - H8000_0000) and V1P0_THRESH_HIGH_mask
            end If
        else
            read_V1P0_THRESH_HIGH_value = data_low and V1P0_THRESH_HIGH_mask
        end If

    End Sub

    Sub write
        If flag_V1P0_THRESH_HIGH = &H0 Then read
        If flag_V1P0_THRESH_HIGH = &H0 Then write_V1P0_THRESH_HIGH_value = get_V1P0_THRESH_HIGH

        regValue = leftShift((write_V1P0_THRESH_HIGH_value and &Hfff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        V1P0_THRESH_HIGH_mask = &Hfff
        if data_low > LONG_MAX then
            if V1P0_THRESH_HIGH_mask = mask then
                read_V1P0_THRESH_HIGH_value = data_low
            else
                read_V1P0_THRESH_HIGH_value = (data_low - H8000_0000) and V1P0_THRESH_HIGH_mask
            end If
        else
            read_V1P0_THRESH_HIGH_value = data_low and V1P0_THRESH_HIGH_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_V1P0_THRESH_HIGH_value = &H0
        flag_V1P0_THRESH_HIGH        = &H0
    End Sub
End Class


'' @REGISTER : BRPHY_1G_1PORT_MISC_v3p3_2p5_thresh_low
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' V1P0_THRESH_LOW                            [11:0]           get_V1P0_THRESH_LOW
''                                                             set_V1P0_THRESH_LOW
''                                                             read_V1P0_THRESH_LOW
''                                                             write_V1P0_THRESH_LOW
''---------------------------------------------------------------------------------
Class REGISTER_BRPHY_1G_1PORT_MISC_v3p3_2p5_thresh_low
    Private write_V1P0_THRESH_LOW_value
    Private read_V1P0_THRESH_LOW_value
    Private flag_V1P0_THRESH_LOW

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

    Property Get get_V1P0_THRESH_LOW
        get_V1P0_THRESH_LOW = read_V1P0_THRESH_LOW_value
    End Property

    Property Let set_V1P0_THRESH_LOW(aData)
        write_V1P0_THRESH_LOW_value = aData
        flag_V1P0_THRESH_LOW        = &H1
    End Property

    Property Get read_V1P0_THRESH_LOW
        read
        read_V1P0_THRESH_LOW = read_V1P0_THRESH_LOW_value
    End Property

    Property Let write_V1P0_THRESH_LOW(aData)
        set_V1P0_THRESH_LOW = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        V1P0_THRESH_LOW_mask = &Hfff
        if data_low > LONG_MAX then
            if V1P0_THRESH_LOW_mask = mask then
                read_V1P0_THRESH_LOW_value = data_low
            else
                read_V1P0_THRESH_LOW_value = (data_low - H8000_0000) and V1P0_THRESH_LOW_mask
            end If
        else
            read_V1P0_THRESH_LOW_value = data_low and V1P0_THRESH_LOW_mask
        end If

    End Sub

    Sub write
        If flag_V1P0_THRESH_LOW = &H0 Then read
        If flag_V1P0_THRESH_LOW = &H0 Then write_V1P0_THRESH_LOW_value = get_V1P0_THRESH_LOW

        regValue = leftShift((write_V1P0_THRESH_LOW_value and &Hfff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        V1P0_THRESH_LOW_mask = &Hfff
        if data_low > LONG_MAX then
            if V1P0_THRESH_LOW_mask = mask then
                read_V1P0_THRESH_LOW_value = data_low
            else
                read_V1P0_THRESH_LOW_value = (data_low - H8000_0000) and V1P0_THRESH_LOW_mask
            end If
        else
            read_V1P0_THRESH_LOW_value = data_low and V1P0_THRESH_LOW_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_V1P0_THRESH_LOW_value = &H0
        flag_V1P0_THRESH_LOW        = &H0
    End Sub
End Class


'' @REGISTER : BRPHY_1G_1PORT_MISC_vtmon_intr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' VTMON_V3P3_2P5_INTR_MASK                   [11:11]          get_VTMON_V3P3_2P5_INTR_MASK
''                                                             set_VTMON_V3P3_2P5_INTR_MASK
''                                                             read_VTMON_V3P3_2P5_INTR_MASK
''                                                             write_VTMON_V3P3_2P5_INTR_MASK
''---------------------------------------------------------------------------------
'' VTMON_V1P8_INTR_MASK                       [10:10]          get_VTMON_V1P8_INTR_MASK
''                                                             set_VTMON_V1P8_INTR_MASK
''                                                             read_VTMON_V1P8_INTR_MASK
''                                                             write_VTMON_V1P8_INTR_MASK
''---------------------------------------------------------------------------------
'' VTMON_V1P0_INTR_MASK                       [9:9]            get_VTMON_V1P0_INTR_MASK
''                                                             set_VTMON_V1P0_INTR_MASK
''                                                             read_VTMON_V1P0_INTR_MASK
''                                                             write_VTMON_V1P0_INTR_MASK
''---------------------------------------------------------------------------------
'' VTMON_TEMP_INTR_MASK                       [8:8]            get_VTMON_TEMP_INTR_MASK
''                                                             set_VTMON_TEMP_INTR_MASK
''                                                             read_VTMON_TEMP_INTR_MASK
''                                                             write_VTMON_TEMP_INTR_MASK
''---------------------------------------------------------------------------------
'' VTMON_V3P3_2P5_INTR                        [3:3]            get_VTMON_V3P3_2P5_INTR
''                                                             set_VTMON_V3P3_2P5_INTR
''                                                             read_VTMON_V3P3_2P5_INTR
''                                                             write_VTMON_V3P3_2P5_INTR
''---------------------------------------------------------------------------------
'' VTMON_V1P8_INTR                            [2:2]            get_VTMON_V1P8_INTR
''                                                             set_VTMON_V1P8_INTR
''                                                             read_VTMON_V1P8_INTR
''                                                             write_VTMON_V1P8_INTR
''---------------------------------------------------------------------------------
'' VTMON_V1P0_INTR                            [1:1]            get_VTMON_V1P0_INTR
''                                                             set_VTMON_V1P0_INTR
''                                                             read_VTMON_V1P0_INTR
''                                                             write_VTMON_V1P0_INTR
''---------------------------------------------------------------------------------
'' VTMON_TEMP_INTR                            [0:0]            get_VTMON_TEMP_INTR
''                                                             set_VTMON_TEMP_INTR
''                                                             read_VTMON_TEMP_INTR
''                                                             write_VTMON_TEMP_INTR
''---------------------------------------------------------------------------------
Class REGISTER_BRPHY_1G_1PORT_MISC_vtmon_intr
    Private write_VTMON_V3P3_2P5_INTR_MASK_value
    Private read_VTMON_V3P3_2P5_INTR_MASK_value
    Private flag_VTMON_V3P3_2P5_INTR_MASK
    Private write_VTMON_V1P8_INTR_MASK_value
    Private read_VTMON_V1P8_INTR_MASK_value
    Private flag_VTMON_V1P8_INTR_MASK
    Private write_VTMON_V1P0_INTR_MASK_value
    Private read_VTMON_V1P0_INTR_MASK_value
    Private flag_VTMON_V1P0_INTR_MASK
    Private write_VTMON_TEMP_INTR_MASK_value
    Private read_VTMON_TEMP_INTR_MASK_value
    Private flag_VTMON_TEMP_INTR_MASK
    Private write_VTMON_V3P3_2P5_INTR_value
    Private read_VTMON_V3P3_2P5_INTR_value
    Private flag_VTMON_V3P3_2P5_INTR
    Private write_VTMON_V1P8_INTR_value
    Private read_VTMON_V1P8_INTR_value
    Private flag_VTMON_V1P8_INTR
    Private write_VTMON_V1P0_INTR_value
    Private read_VTMON_V1P0_INTR_value
    Private flag_VTMON_V1P0_INTR
    Private write_VTMON_TEMP_INTR_value
    Private read_VTMON_TEMP_INTR_value
    Private flag_VTMON_TEMP_INTR

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

    Property Get get_VTMON_V3P3_2P5_INTR_MASK
        get_VTMON_V3P3_2P5_INTR_MASK = read_VTMON_V3P3_2P5_INTR_MASK_value
    End Property

    Property Let set_VTMON_V3P3_2P5_INTR_MASK(aData)
        write_VTMON_V3P3_2P5_INTR_MASK_value = aData
        flag_VTMON_V3P3_2P5_INTR_MASK        = &H1
    End Property

    Property Get read_VTMON_V3P3_2P5_INTR_MASK
        read
        read_VTMON_V3P3_2P5_INTR_MASK = read_VTMON_V3P3_2P5_INTR_MASK_value
    End Property

    Property Let write_VTMON_V3P3_2P5_INTR_MASK(aData)
        set_VTMON_V3P3_2P5_INTR_MASK = aData
        write
    End Property

    Property Get get_VTMON_V1P8_INTR_MASK
        get_VTMON_V1P8_INTR_MASK = read_VTMON_V1P8_INTR_MASK_value
    End Property

    Property Let set_VTMON_V1P8_INTR_MASK(aData)
        write_VTMON_V1P8_INTR_MASK_value = aData
        flag_VTMON_V1P8_INTR_MASK        = &H1
    End Property

    Property Get read_VTMON_V1P8_INTR_MASK
        read
        read_VTMON_V1P8_INTR_MASK = read_VTMON_V1P8_INTR_MASK_value
    End Property

    Property Let write_VTMON_V1P8_INTR_MASK(aData)
        set_VTMON_V1P8_INTR_MASK = aData
        write
    End Property

    Property Get get_VTMON_V1P0_INTR_MASK
        get_VTMON_V1P0_INTR_MASK = read_VTMON_V1P0_INTR_MASK_value
    End Property

    Property Let set_VTMON_V1P0_INTR_MASK(aData)
        write_VTMON_V1P0_INTR_MASK_value = aData
        flag_VTMON_V1P0_INTR_MASK        = &H1
    End Property

    Property Get read_VTMON_V1P0_INTR_MASK
        read
        read_VTMON_V1P0_INTR_MASK = read_VTMON_V1P0_INTR_MASK_value
    End Property

    Property Let write_VTMON_V1P0_INTR_MASK(aData)
        set_VTMON_V1P0_INTR_MASK = aData
        write
    End Property

    Property Get get_VTMON_TEMP_INTR_MASK
        get_VTMON_TEMP_INTR_MASK = read_VTMON_TEMP_INTR_MASK_value
    End Property

    Property Let set_VTMON_TEMP_INTR_MASK(aData)
        write_VTMON_TEMP_INTR_MASK_value = aData
        flag_VTMON_TEMP_INTR_MASK        = &H1
    End Property

    Property Get read_VTMON_TEMP_INTR_MASK
        read
        read_VTMON_TEMP_INTR_MASK = read_VTMON_TEMP_INTR_MASK_value
    End Property

    Property Let write_VTMON_TEMP_INTR_MASK(aData)
        set_VTMON_TEMP_INTR_MASK = aData
        write
    End Property

    Property Get get_VTMON_V3P3_2P5_INTR
        get_VTMON_V3P3_2P5_INTR = read_VTMON_V3P3_2P5_INTR_value
    End Property

    Property Let set_VTMON_V3P3_2P5_INTR(aData)
        write_VTMON_V3P3_2P5_INTR_value = aData
        flag_VTMON_V3P3_2P5_INTR        = &H1
    End Property

    Property Get read_VTMON_V3P3_2P5_INTR
        read
        read_VTMON_V3P3_2P5_INTR = read_VTMON_V3P3_2P5_INTR_value
    End Property

    Property Let write_VTMON_V3P3_2P5_INTR(aData)
        set_VTMON_V3P3_2P5_INTR = aData
        write
    End Property

    Property Get get_VTMON_V1P8_INTR
        get_VTMON_V1P8_INTR = read_VTMON_V1P8_INTR_value
    End Property

    Property Let set_VTMON_V1P8_INTR(aData)
        write_VTMON_V1P8_INTR_value = aData
        flag_VTMON_V1P8_INTR        = &H1
    End Property

    Property Get read_VTMON_V1P8_INTR
        read
        read_VTMON_V1P8_INTR = read_VTMON_V1P8_INTR_value
    End Property

    Property Let write_VTMON_V1P8_INTR(aData)
        set_VTMON_V1P8_INTR = aData
        write
    End Property

    Property Get get_VTMON_V1P0_INTR
        get_VTMON_V1P0_INTR = read_VTMON_V1P0_INTR_value
    End Property

    Property Let set_VTMON_V1P0_INTR(aData)
        write_VTMON_V1P0_INTR_value = aData
        flag_VTMON_V1P0_INTR        = &H1
    End Property

    Property Get read_VTMON_V1P0_INTR
        read
        read_VTMON_V1P0_INTR = read_VTMON_V1P0_INTR_value
    End Property

    Property Let write_VTMON_V1P0_INTR(aData)
        set_VTMON_V1P0_INTR = aData
        write
    End Property

    Property Get get_VTMON_TEMP_INTR
        get_VTMON_TEMP_INTR = read_VTMON_TEMP_INTR_value
    End Property

    Property Let set_VTMON_TEMP_INTR(aData)
        write_VTMON_TEMP_INTR_value = aData
        flag_VTMON_TEMP_INTR        = &H1
    End Property

    Property Get read_VTMON_TEMP_INTR
        read
        read_VTMON_TEMP_INTR = read_VTMON_TEMP_INTR_value
    End Property

    Property Let write_VTMON_TEMP_INTR(aData)
        set_VTMON_TEMP_INTR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_VTMON_V3P3_2P5_INTR_MASK_value = rightShift(data_low, 11) and &H1
        read_VTMON_V1P8_INTR_MASK_value = rightShift(data_low, 10) and &H1
        read_VTMON_V1P0_INTR_MASK_value = rightShift(data_low, 9) and &H1
        read_VTMON_TEMP_INTR_MASK_value = rightShift(data_low, 8) and &H1
        read_VTMON_V3P3_2P5_INTR_value = rightShift(data_low, 3) and &H1
        read_VTMON_V1P8_INTR_value = rightShift(data_low, 2) and &H1
        read_VTMON_V1P0_INTR_value = rightShift(data_low, 1) and &H1
        VTMON_TEMP_INTR_mask = &H1
        if data_low > LONG_MAX then
            if VTMON_TEMP_INTR_mask = mask then
                read_VTMON_TEMP_INTR_value = data_low
            else
                read_VTMON_TEMP_INTR_value = (data_low - H8000_0000) and VTMON_TEMP_INTR_mask
            end If
        else
            read_VTMON_TEMP_INTR_value = data_low and VTMON_TEMP_INTR_mask
        end If

    End Sub

    Sub write
        If flag_VTMON_V3P3_2P5_INTR_MASK = &H0 or flag_VTMON_V1P8_INTR_MASK = &H0 or flag_VTMON_V1P0_INTR_MASK = &H0 or flag_VTMON_TEMP_INTR_MASK = &H0 or flag_VTMON_V3P3_2P5_INTR = &H0 or flag_VTMON_V1P8_INTR = &H0 or flag_VTMON_V1P0_INTR = &H0 or flag_VTMON_TEMP_INTR = &H0 Then read
        If flag_VTMON_V3P3_2P5_INTR_MASK = &H0 Then write_VTMON_V3P3_2P5_INTR_MASK_value = get_VTMON_V3P3_2P5_INTR_MASK
        If flag_VTMON_V1P8_INTR_MASK = &H0 Then write_VTMON_V1P8_INTR_MASK_value = get_VTMON_V1P8_INTR_MASK
        If flag_VTMON_V1P0_INTR_MASK = &H0 Then write_VTMON_V1P0_INTR_MASK_value = get_VTMON_V1P0_INTR_MASK
        If flag_VTMON_TEMP_INTR_MASK = &H0 Then write_VTMON_TEMP_INTR_MASK_value = get_VTMON_TEMP_INTR_MASK
        If flag_VTMON_V3P3_2P5_INTR = &H0 Then write_VTMON_V3P3_2P5_INTR_value = get_VTMON_V3P3_2P5_INTR
        If flag_VTMON_V1P8_INTR = &H0 Then write_VTMON_V1P8_INTR_value = get_VTMON_V1P8_INTR
        If flag_VTMON_V1P0_INTR = &H0 Then write_VTMON_V1P0_INTR_value = get_VTMON_V1P0_INTR
        If flag_VTMON_TEMP_INTR = &H0 Then write_VTMON_TEMP_INTR_value = get_VTMON_TEMP_INTR

        regValue = leftShift((write_VTMON_V3P3_2P5_INTR_MASK_value and &H1), 11) + leftShift((write_VTMON_V1P8_INTR_MASK_value and &H1), 10) + leftShift((write_VTMON_V1P0_INTR_MASK_value and &H1), 9) + leftShift((write_VTMON_TEMP_INTR_MASK_value and &H1), 8) + leftShift((write_VTMON_V3P3_2P5_INTR_value and &H1), 3) + leftShift((write_VTMON_V1P8_INTR_value and &H1), 2) + leftShift((write_VTMON_V1P0_INTR_value and &H1), 1) + leftShift((write_VTMON_TEMP_INTR_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_VTMON_V3P3_2P5_INTR_MASK_value = rightShift(data_low, 11) and &H1
        read_VTMON_V1P8_INTR_MASK_value = rightShift(data_low, 10) and &H1
        read_VTMON_V1P0_INTR_MASK_value = rightShift(data_low, 9) and &H1
        read_VTMON_TEMP_INTR_MASK_value = rightShift(data_low, 8) and &H1
        read_VTMON_V3P3_2P5_INTR_value = rightShift(data_low, 3) and &H1
        read_VTMON_V1P8_INTR_value = rightShift(data_low, 2) and &H1
        read_VTMON_V1P0_INTR_value = rightShift(data_low, 1) and &H1
        VTMON_TEMP_INTR_mask = &H1
        if data_low > LONG_MAX then
            if VTMON_TEMP_INTR_mask = mask then
                read_VTMON_TEMP_INTR_value = data_low
            else
                read_VTMON_TEMP_INTR_value = (data_low - H8000_0000) and VTMON_TEMP_INTR_mask
            end If
        else
            read_VTMON_TEMP_INTR_value = data_low and VTMON_TEMP_INTR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_VTMON_V3P3_2P5_INTR_MASK_value = &H0
        flag_VTMON_V3P3_2P5_INTR_MASK        = &H0
        write_VTMON_V1P8_INTR_MASK_value = &H0
        flag_VTMON_V1P8_INTR_MASK        = &H0
        write_VTMON_V1P0_INTR_MASK_value = &H0
        flag_VTMON_V1P0_INTR_MASK        = &H0
        write_VTMON_TEMP_INTR_MASK_value = &H0
        flag_VTMON_TEMP_INTR_MASK        = &H0
        write_VTMON_V3P3_2P5_INTR_value = &H0
        flag_VTMON_V3P3_2P5_INTR        = &H0
        write_VTMON_V1P8_INTR_value = &H0
        flag_VTMON_V1P8_INTR        = &H0
        write_VTMON_V1P0_INTR_value = &H0
        flag_VTMON_V1P0_INTR        = &H0
        write_VTMON_TEMP_INTR_value = &H0
        flag_VTMON_TEMP_INTR        = &H0
    End Sub
End Class


'' @REGISTER : BRPHY_1G_1PORT_MISC_v1p8_data
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' V1P8_DATA                                  [11:0]           get_V1P8_DATA
''                                                             set_V1P8_DATA
''                                                             read_V1P8_DATA
''                                                             write_V1P8_DATA
''---------------------------------------------------------------------------------
Class REGISTER_BRPHY_1G_1PORT_MISC_v1p8_data
    Private write_V1P8_DATA_value
    Private read_V1P8_DATA_value
    Private flag_V1P8_DATA

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

    Property Get get_V1P8_DATA
        get_V1P8_DATA = read_V1P8_DATA_value
    End Property

    Property Let set_V1P8_DATA(aData)
        write_V1P8_DATA_value = aData
        flag_V1P8_DATA        = &H1
    End Property

    Property Get read_V1P8_DATA
        read
        read_V1P8_DATA = read_V1P8_DATA_value
    End Property

    Property Let write_V1P8_DATA(aData)
        set_V1P8_DATA = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        V1P8_DATA_mask = &Hfff
        if data_low > LONG_MAX then
            if V1P8_DATA_mask = mask then
                read_V1P8_DATA_value = data_low
            else
                read_V1P8_DATA_value = (data_low - H8000_0000) and V1P8_DATA_mask
            end If
        else
            read_V1P8_DATA_value = data_low and V1P8_DATA_mask
        end If

    End Sub

    Sub write
        If flag_V1P8_DATA = &H0 Then read
        If flag_V1P8_DATA = &H0 Then write_V1P8_DATA_value = get_V1P8_DATA

        regValue = leftShift((write_V1P8_DATA_value and &Hfff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        V1P8_DATA_mask = &Hfff
        if data_low > LONG_MAX then
            if V1P8_DATA_mask = mask then
                read_V1P8_DATA_value = data_low
            else
                read_V1P8_DATA_value = (data_low - H8000_0000) and V1P8_DATA_mask
            end If
        else
            read_V1P8_DATA_value = data_low and V1P8_DATA_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_V1P8_DATA_value = &H0
        flag_V1P8_DATA        = &H0
    End Sub
End Class


'' @REGISTER : BRPHY_1G_1PORT_MISC_v1p8_thresh_high
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' V1P0_THRESH_HIGH                           [11:0]           get_V1P0_THRESH_HIGH
''                                                             set_V1P0_THRESH_HIGH
''                                                             read_V1P0_THRESH_HIGH
''                                                             write_V1P0_THRESH_HIGH
''---------------------------------------------------------------------------------
Class REGISTER_BRPHY_1G_1PORT_MISC_v1p8_thresh_high
    Private write_V1P0_THRESH_HIGH_value
    Private read_V1P0_THRESH_HIGH_value
    Private flag_V1P0_THRESH_HIGH

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

    Property Get get_V1P0_THRESH_HIGH
        get_V1P0_THRESH_HIGH = read_V1P0_THRESH_HIGH_value
    End Property

    Property Let set_V1P0_THRESH_HIGH(aData)
        write_V1P0_THRESH_HIGH_value = aData
        flag_V1P0_THRESH_HIGH        = &H1
    End Property

    Property Get read_V1P0_THRESH_HIGH
        read
        read_V1P0_THRESH_HIGH = read_V1P0_THRESH_HIGH_value
    End Property

    Property Let write_V1P0_THRESH_HIGH(aData)
        set_V1P0_THRESH_HIGH = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        V1P0_THRESH_HIGH_mask = &Hfff
        if data_low > LONG_MAX then
            if V1P0_THRESH_HIGH_mask = mask then
                read_V1P0_THRESH_HIGH_value = data_low
            else
                read_V1P0_THRESH_HIGH_value = (data_low - H8000_0000) and V1P0_THRESH_HIGH_mask
            end If
        else
            read_V1P0_THRESH_HIGH_value = data_low and V1P0_THRESH_HIGH_mask
        end If

    End Sub

    Sub write
        If flag_V1P0_THRESH_HIGH = &H0 Then read
        If flag_V1P0_THRESH_HIGH = &H0 Then write_V1P0_THRESH_HIGH_value = get_V1P0_THRESH_HIGH

        regValue = leftShift((write_V1P0_THRESH_HIGH_value and &Hfff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        V1P0_THRESH_HIGH_mask = &Hfff
        if data_low > LONG_MAX then
            if V1P0_THRESH_HIGH_mask = mask then
                read_V1P0_THRESH_HIGH_value = data_low
            else
                read_V1P0_THRESH_HIGH_value = (data_low - H8000_0000) and V1P0_THRESH_HIGH_mask
            end If
        else
            read_V1P0_THRESH_HIGH_value = data_low and V1P0_THRESH_HIGH_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_V1P0_THRESH_HIGH_value = &H0
        flag_V1P0_THRESH_HIGH        = &H0
    End Sub
End Class


'' @REGISTER : BRPHY_1G_1PORT_MISC_v1p8_thresh_low
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' V1P0_THRESH_LOW                            [11:0]           get_V1P0_THRESH_LOW
''                                                             set_V1P0_THRESH_LOW
''                                                             read_V1P0_THRESH_LOW
''                                                             write_V1P0_THRESH_LOW
''---------------------------------------------------------------------------------
Class REGISTER_BRPHY_1G_1PORT_MISC_v1p8_thresh_low
    Private write_V1P0_THRESH_LOW_value
    Private read_V1P0_THRESH_LOW_value
    Private flag_V1P0_THRESH_LOW

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

    Property Get get_V1P0_THRESH_LOW
        get_V1P0_THRESH_LOW = read_V1P0_THRESH_LOW_value
    End Property

    Property Let set_V1P0_THRESH_LOW(aData)
        write_V1P0_THRESH_LOW_value = aData
        flag_V1P0_THRESH_LOW        = &H1
    End Property

    Property Get read_V1P0_THRESH_LOW
        read
        read_V1P0_THRESH_LOW = read_V1P0_THRESH_LOW_value
    End Property

    Property Let write_V1P0_THRESH_LOW(aData)
        set_V1P0_THRESH_LOW = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        V1P0_THRESH_LOW_mask = &Hfff
        if data_low > LONG_MAX then
            if V1P0_THRESH_LOW_mask = mask then
                read_V1P0_THRESH_LOW_value = data_low
            else
                read_V1P0_THRESH_LOW_value = (data_low - H8000_0000) and V1P0_THRESH_LOW_mask
            end If
        else
            read_V1P0_THRESH_LOW_value = data_low and V1P0_THRESH_LOW_mask
        end If

    End Sub

    Sub write
        If flag_V1P0_THRESH_LOW = &H0 Then read
        If flag_V1P0_THRESH_LOW = &H0 Then write_V1P0_THRESH_LOW_value = get_V1P0_THRESH_LOW

        regValue = leftShift((write_V1P0_THRESH_LOW_value and &Hfff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        V1P0_THRESH_LOW_mask = &Hfff
        if data_low > LONG_MAX then
            if V1P0_THRESH_LOW_mask = mask then
                read_V1P0_THRESH_LOW_value = data_low
            else
                read_V1P0_THRESH_LOW_value = (data_low - H8000_0000) and V1P0_THRESH_LOW_mask
            end If
        else
            read_V1P0_THRESH_LOW_value = data_low and V1P0_THRESH_LOW_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_V1P0_THRESH_LOW_value = &H0
        flag_V1P0_THRESH_LOW        = &H0
    End Sub
End Class


'' @REGISTER : BRPHY_1G_1PORT_MISC_xtal_osc_ctrl1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' i_pd_drv                                   [15:15]          get_i_pd_drv
''                                                             set_i_pd_drv
''                                                             read_i_pd_drv
''                                                             write_i_pd_drv
''---------------------------------------------------------------------------------
'' i_drv_cur                                  [14:13]          get_i_drv_cur
''                                                             set_i_drv_cur
''                                                             read_i_drv_cur
''                                                             write_i_drv_cur
''---------------------------------------------------------------------------------
'' i_div2_sel                                 [12:12]          get_i_div2_sel
''                                                             set_i_div2_sel
''                                                             read_i_div2_sel
''                                                             write_i_div2_sel
''---------------------------------------------------------------------------------
'' i_d2c_bias                                 [11:9]           get_i_d2c_bias
''                                                             set_i_d2c_bias
''                                                             read_i_d2c_bias
''                                                             write_i_d2c_bias
''---------------------------------------------------------------------------------
'' i_cmos_en_ALL                              [8:8]            get_i_cmos_en_ALL
''                                                             set_i_cmos_en_ALL
''                                                             read_i_cmos_en_ALL
''                                                             write_i_cmos_en_ALL
''---------------------------------------------------------------------------------
'' i_cml_pd_ch                                [7:4]            get_i_cml_pd_ch
''                                                             set_i_cml_pd_ch
''                                                             read_i_cml_pd_ch
''                                                             write_i_cml_pd_ch
''---------------------------------------------------------------------------------
'' i_cml_cur                                  [3:3]            get_i_cml_cur
''                                                             set_i_cml_cur
''                                                             read_i_cml_cur
''                                                             write_i_cml_cur
''---------------------------------------------------------------------------------
'' i_bias                                     [2:0]            get_i_bias
''                                                             set_i_bias
''                                                             read_i_bias
''                                                             write_i_bias
''---------------------------------------------------------------------------------
Class REGISTER_BRPHY_1G_1PORT_MISC_xtal_osc_ctrl1
    Private write_i_pd_drv_value
    Private read_i_pd_drv_value
    Private flag_i_pd_drv
    Private write_i_drv_cur_value
    Private read_i_drv_cur_value
    Private flag_i_drv_cur
    Private write_i_div2_sel_value
    Private read_i_div2_sel_value
    Private flag_i_div2_sel
    Private write_i_d2c_bias_value
    Private read_i_d2c_bias_value
    Private flag_i_d2c_bias
    Private write_i_cmos_en_ALL_value
    Private read_i_cmos_en_ALL_value
    Private flag_i_cmos_en_ALL
    Private write_i_cml_pd_ch_value
    Private read_i_cml_pd_ch_value
    Private flag_i_cml_pd_ch
    Private write_i_cml_cur_value
    Private read_i_cml_cur_value
    Private flag_i_cml_cur
    Private write_i_bias_value
    Private read_i_bias_value
    Private flag_i_bias

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hfe
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_i_pd_drv
        get_i_pd_drv = read_i_pd_drv_value
    End Property

    Property Let set_i_pd_drv(aData)
        write_i_pd_drv_value = aData
        flag_i_pd_drv        = &H1
    End Property

    Property Get read_i_pd_drv
        read
        read_i_pd_drv = read_i_pd_drv_value
    End Property

    Property Let write_i_pd_drv(aData)
        set_i_pd_drv = aData
        write
    End Property

    Property Get get_i_drv_cur
        get_i_drv_cur = read_i_drv_cur_value
    End Property

    Property Let set_i_drv_cur(aData)
        write_i_drv_cur_value = aData
        flag_i_drv_cur        = &H1
    End Property

    Property Get read_i_drv_cur
        read
        read_i_drv_cur = read_i_drv_cur_value
    End Property

    Property Let write_i_drv_cur(aData)
        set_i_drv_cur = aData
        write
    End Property

    Property Get get_i_div2_sel
        get_i_div2_sel = read_i_div2_sel_value
    End Property

    Property Let set_i_div2_sel(aData)
        write_i_div2_sel_value = aData
        flag_i_div2_sel        = &H1
    End Property

    Property Get read_i_div2_sel
        read
        read_i_div2_sel = read_i_div2_sel_value
    End Property

    Property Let write_i_div2_sel(aData)
        set_i_div2_sel = aData
        write
    End Property

    Property Get get_i_d2c_bias
        get_i_d2c_bias = read_i_d2c_bias_value
    End Property

    Property Let set_i_d2c_bias(aData)
        write_i_d2c_bias_value = aData
        flag_i_d2c_bias        = &H1
    End Property

    Property Get read_i_d2c_bias
        read
        read_i_d2c_bias = read_i_d2c_bias_value
    End Property

    Property Let write_i_d2c_bias(aData)
        set_i_d2c_bias = aData
        write
    End Property

    Property Get get_i_cmos_en_ALL
        get_i_cmos_en_ALL = read_i_cmos_en_ALL_value
    End Property

    Property Let set_i_cmos_en_ALL(aData)
        write_i_cmos_en_ALL_value = aData
        flag_i_cmos_en_ALL        = &H1
    End Property

    Property Get read_i_cmos_en_ALL
        read
        read_i_cmos_en_ALL = read_i_cmos_en_ALL_value
    End Property

    Property Let write_i_cmos_en_ALL(aData)
        set_i_cmos_en_ALL = aData
        write
    End Property

    Property Get get_i_cml_pd_ch
        get_i_cml_pd_ch = read_i_cml_pd_ch_value
    End Property

    Property Let set_i_cml_pd_ch(aData)
        write_i_cml_pd_ch_value = aData
        flag_i_cml_pd_ch        = &H1
    End Property

    Property Get read_i_cml_pd_ch
        read
        read_i_cml_pd_ch = read_i_cml_pd_ch_value
    End Property

    Property Let write_i_cml_pd_ch(aData)
        set_i_cml_pd_ch = aData
        write
    End Property

    Property Get get_i_cml_cur
        get_i_cml_cur = read_i_cml_cur_value
    End Property

    Property Let set_i_cml_cur(aData)
        write_i_cml_cur_value = aData
        flag_i_cml_cur        = &H1
    End Property

    Property Get read_i_cml_cur
        read
        read_i_cml_cur = read_i_cml_cur_value
    End Property

    Property Let write_i_cml_cur(aData)
        set_i_cml_cur = aData
        write
    End Property

    Property Get get_i_bias
        get_i_bias = read_i_bias_value
    End Property

    Property Let set_i_bias(aData)
        write_i_bias_value = aData
        flag_i_bias        = &H1
    End Property

    Property Get read_i_bias
        read
        read_i_bias = read_i_bias_value
    End Property

    Property Let write_i_bias(aData)
        set_i_bias = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_i_pd_drv_value = rightShift(data_low, 15) and &H1
        read_i_drv_cur_value = rightShift(data_low, 13) and &H3
        read_i_div2_sel_value = rightShift(data_low, 12) and &H1
        read_i_d2c_bias_value = rightShift(data_low, 9) and &H7
        read_i_cmos_en_ALL_value = rightShift(data_low, 8) and &H1
        read_i_cml_pd_ch_value = rightShift(data_low, 4) and &Hf
        read_i_cml_cur_value = rightShift(data_low, 3) and &H1
        i_bias_mask = &H7
        if data_low > LONG_MAX then
            if i_bias_mask = mask then
                read_i_bias_value = data_low
            else
                read_i_bias_value = (data_low - H8000_0000) and i_bias_mask
            end If
        else
            read_i_bias_value = data_low and i_bias_mask
        end If

    End Sub

    Sub write
        If flag_i_pd_drv = &H0 or flag_i_drv_cur = &H0 or flag_i_div2_sel = &H0 or flag_i_d2c_bias = &H0 or flag_i_cmos_en_ALL = &H0 or flag_i_cml_pd_ch = &H0 or flag_i_cml_cur = &H0 or flag_i_bias = &H0 Then read
        If flag_i_pd_drv = &H0 Then write_i_pd_drv_value = get_i_pd_drv
        If flag_i_drv_cur = &H0 Then write_i_drv_cur_value = get_i_drv_cur
        If flag_i_div2_sel = &H0 Then write_i_div2_sel_value = get_i_div2_sel
        If flag_i_d2c_bias = &H0 Then write_i_d2c_bias_value = get_i_d2c_bias
        If flag_i_cmos_en_ALL = &H0 Then write_i_cmos_en_ALL_value = get_i_cmos_en_ALL
        If flag_i_cml_pd_ch = &H0 Then write_i_cml_pd_ch_value = get_i_cml_pd_ch
        If flag_i_cml_cur = &H0 Then write_i_cml_cur_value = get_i_cml_cur
        If flag_i_bias = &H0 Then write_i_bias_value = get_i_bias

        regValue = leftShift((write_i_pd_drv_value and &H1), 15) + leftShift((write_i_drv_cur_value and &H3), 13) + leftShift((write_i_div2_sel_value and &H1), 12) + leftShift((write_i_d2c_bias_value and &H7), 9) + leftShift((write_i_cmos_en_ALL_value and &H1), 8) + leftShift((write_i_cml_pd_ch_value and &Hf), 4) + leftShift((write_i_cml_cur_value and &H1), 3) + leftShift((write_i_bias_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_i_pd_drv_value = rightShift(data_low, 15) and &H1
        read_i_drv_cur_value = rightShift(data_low, 13) and &H3
        read_i_div2_sel_value = rightShift(data_low, 12) and &H1
        read_i_d2c_bias_value = rightShift(data_low, 9) and &H7
        read_i_cmos_en_ALL_value = rightShift(data_low, 8) and &H1
        read_i_cml_pd_ch_value = rightShift(data_low, 4) and &Hf
        read_i_cml_cur_value = rightShift(data_low, 3) and &H1
        i_bias_mask = &H7
        if data_low > LONG_MAX then
            if i_bias_mask = mask then
                read_i_bias_value = data_low
            else
                read_i_bias_value = (data_low - H8000_0000) and i_bias_mask
            end If
        else
            read_i_bias_value = data_low and i_bias_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_i_pd_drv_value = &H0
        flag_i_pd_drv        = &H0
        write_i_drv_cur_value = &H0
        flag_i_drv_cur        = &H0
        write_i_div2_sel_value = &H0
        flag_i_div2_sel        = &H0
        write_i_d2c_bias_value = &H0
        flag_i_d2c_bias        = &H0
        write_i_cmos_en_ALL_value = &H0
        flag_i_cmos_en_ALL        = &H0
        write_i_cml_pd_ch_value = &H0
        flag_i_cml_pd_ch        = &H0
        write_i_cml_cur_value = &H0
        flag_i_cml_cur        = &H0
        write_i_bias_value = &H0
        flag_i_bias        = &H0
    End Sub
End Class


'' @REGISTER : BRPHY_1G_1PORT_MISC_xtal_osc_ctrl2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' i_cmos_en_ch0                              [2:2]            get_i_cmos_en_ch0
''                                                             set_i_cmos_en_ch0
''                                                             read_i_cmos_en_ch0
''                                                             write_i_cmos_en_ch0
''---------------------------------------------------------------------------------
'' i_power_save                               [1:1]            get_i_power_save
''                                                             set_i_power_save
''                                                             read_i_power_save
''                                                             write_i_power_save
''---------------------------------------------------------------------------------
'' i_xcore_CM_sel                             [0:0]            get_i_xcore_CM_sel
''                                                             set_i_xcore_CM_sel
''                                                             read_i_xcore_CM_sel
''                                                             write_i_xcore_CM_sel
''---------------------------------------------------------------------------------
Class REGISTER_BRPHY_1G_1PORT_MISC_xtal_osc_ctrl2
    Private write_i_cmos_en_ch0_value
    Private read_i_cmos_en_ch0_value
    Private flag_i_cmos_en_ch0
    Private write_i_power_save_value
    Private read_i_power_save_value
    Private flag_i_power_save
    Private write_i_xcore_CM_sel_value
    Private read_i_xcore_CM_sel_value
    Private flag_i_xcore_CM_sel

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

    Property Get get_i_cmos_en_ch0
        get_i_cmos_en_ch0 = read_i_cmos_en_ch0_value
    End Property

    Property Let set_i_cmos_en_ch0(aData)
        write_i_cmos_en_ch0_value = aData
        flag_i_cmos_en_ch0        = &H1
    End Property

    Property Get read_i_cmos_en_ch0
        read
        read_i_cmos_en_ch0 = read_i_cmos_en_ch0_value
    End Property

    Property Let write_i_cmos_en_ch0(aData)
        set_i_cmos_en_ch0 = aData
        write
    End Property

    Property Get get_i_power_save
        get_i_power_save = read_i_power_save_value
    End Property

    Property Let set_i_power_save(aData)
        write_i_power_save_value = aData
        flag_i_power_save        = &H1
    End Property

    Property Get read_i_power_save
        read
        read_i_power_save = read_i_power_save_value
    End Property

    Property Let write_i_power_save(aData)
        set_i_power_save = aData
        write
    End Property

    Property Get get_i_xcore_CM_sel
        get_i_xcore_CM_sel = read_i_xcore_CM_sel_value
    End Property

    Property Let set_i_xcore_CM_sel(aData)
        write_i_xcore_CM_sel_value = aData
        flag_i_xcore_CM_sel        = &H1
    End Property

    Property Get read_i_xcore_CM_sel
        read
        read_i_xcore_CM_sel = read_i_xcore_CM_sel_value
    End Property

    Property Let write_i_xcore_CM_sel(aData)
        set_i_xcore_CM_sel = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_i_cmos_en_ch0_value = rightShift(data_low, 2) and &H1
        read_i_power_save_value = rightShift(data_low, 1) and &H1
        i_xcore_CM_sel_mask = &H1
        if data_low > LONG_MAX then
            if i_xcore_CM_sel_mask = mask then
                read_i_xcore_CM_sel_value = data_low
            else
                read_i_xcore_CM_sel_value = (data_low - H8000_0000) and i_xcore_CM_sel_mask
            end If
        else
            read_i_xcore_CM_sel_value = data_low and i_xcore_CM_sel_mask
        end If

    End Sub

    Sub write
        If flag_i_cmos_en_ch0 = &H0 or flag_i_power_save = &H0 or flag_i_xcore_CM_sel = &H0 Then read
        If flag_i_cmos_en_ch0 = &H0 Then write_i_cmos_en_ch0_value = get_i_cmos_en_ch0
        If flag_i_power_save = &H0 Then write_i_power_save_value = get_i_power_save
        If flag_i_xcore_CM_sel = &H0 Then write_i_xcore_CM_sel_value = get_i_xcore_CM_sel

        regValue = leftShift((write_i_cmos_en_ch0_value and &H1), 2) + leftShift((write_i_power_save_value and &H1), 1) + leftShift((write_i_xcore_CM_sel_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_i_cmos_en_ch0_value = rightShift(data_low, 2) and &H1
        read_i_power_save_value = rightShift(data_low, 1) and &H1
        i_xcore_CM_sel_mask = &H1
        if data_low > LONG_MAX then
            if i_xcore_CM_sel_mask = mask then
                read_i_xcore_CM_sel_value = data_low
            else
                read_i_xcore_CM_sel_value = (data_low - H8000_0000) and i_xcore_CM_sel_mask
            end If
        else
            read_i_xcore_CM_sel_value = data_low and i_xcore_CM_sel_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_i_cmos_en_ch0_value = &H0
        flag_i_cmos_en_ch0        = &H0
        write_i_power_save_value = &H0
        flag_i_power_save        = &H0
        write_i_xcore_CM_sel_value = &H0
        flag_i_xcore_CM_sel        = &H0
    End Sub
End Class


'' @REGISTER : BRPHY_1G_1PORT_MISC_vreg_cntl_1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' BG_ref_voltage_trimming                    [14:11]          get_BG_ref_voltage_trimming
''                                                             set_BG_ref_voltage_trimming
''                                                             read_BG_ref_voltage_trimming
''                                                             write_BG_ref_voltage_trimming
''---------------------------------------------------------------------------------
'' Inrush_current_adjustment                  [10:10]          get_Inrush_current_adjustment
''                                                             set_Inrush_current_adjustment
''                                                             read_Inrush_current_adjustment
''                                                             write_Inrush_current_adjustment
''---------------------------------------------------------------------------------
'' Current_limit_adjustment                   [9:9]            get_Current_limit_adjustment
''                                                             set_Current_limit_adjustment
''                                                             read_Current_limit_adjustment
''                                                             write_Current_limit_adjustment
''---------------------------------------------------------------------------------
'' Leakage_sensing_control                    [8:8]            get_Leakage_sensing_control
''                                                             set_Leakage_sensing_control
''                                                             read_Leakage_sensing_control
''                                                             write_Leakage_sensing_control
''---------------------------------------------------------------------------------
'' Output_voltage_tuning                      [7:4]            get_Output_voltage_tuning
''                                                             set_Output_voltage_tuning
''                                                             read_Output_voltage_tuning
''                                                             write_Output_voltage_tuning
''---------------------------------------------------------------------------------
'' BTCT                                       [3:0]            get_BTCT
''                                                             set_BTCT
''                                                             read_BTCT
''                                                             write_BTCT
''---------------------------------------------------------------------------------
Class REGISTER_BRPHY_1G_1PORT_MISC_vreg_cntl_1
    Private write_BG_ref_voltage_trimming_value
    Private read_BG_ref_voltage_trimming_value
    Private flag_BG_ref_voltage_trimming
    Private write_Inrush_current_adjustment_value
    Private read_Inrush_current_adjustment_value
    Private flag_Inrush_current_adjustment
    Private write_Current_limit_adjustment_value
    Private read_Current_limit_adjustment_value
    Private flag_Current_limit_adjustment
    Private write_Leakage_sensing_control_value
    Private read_Leakage_sensing_control_value
    Private flag_Leakage_sensing_control
    Private write_Output_voltage_tuning_value
    Private read_Output_voltage_tuning_value
    Private flag_Output_voltage_tuning
    Private write_BTCT_value
    Private read_BTCT_value
    Private flag_BTCT

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

    Property Get get_BG_ref_voltage_trimming
        get_BG_ref_voltage_trimming = read_BG_ref_voltage_trimming_value
    End Property

    Property Let set_BG_ref_voltage_trimming(aData)
        write_BG_ref_voltage_trimming_value = aData
        flag_BG_ref_voltage_trimming        = &H1
    End Property

    Property Get read_BG_ref_voltage_trimming
        read
        read_BG_ref_voltage_trimming = read_BG_ref_voltage_trimming_value
    End Property

    Property Let write_BG_ref_voltage_trimming(aData)
        set_BG_ref_voltage_trimming = aData
        write
    End Property

    Property Get get_Inrush_current_adjustment
        get_Inrush_current_adjustment = read_Inrush_current_adjustment_value
    End Property

    Property Let set_Inrush_current_adjustment(aData)
        write_Inrush_current_adjustment_value = aData
        flag_Inrush_current_adjustment        = &H1
    End Property

    Property Get read_Inrush_current_adjustment
        read
        read_Inrush_current_adjustment = read_Inrush_current_adjustment_value
    End Property

    Property Let write_Inrush_current_adjustment(aData)
        set_Inrush_current_adjustment = aData
        write
    End Property

    Property Get get_Current_limit_adjustment
        get_Current_limit_adjustment = read_Current_limit_adjustment_value
    End Property

    Property Let set_Current_limit_adjustment(aData)
        write_Current_limit_adjustment_value = aData
        flag_Current_limit_adjustment        = &H1
    End Property

    Property Get read_Current_limit_adjustment
        read
        read_Current_limit_adjustment = read_Current_limit_adjustment_value
    End Property

    Property Let write_Current_limit_adjustment(aData)
        set_Current_limit_adjustment = aData
        write
    End Property

    Property Get get_Leakage_sensing_control
        get_Leakage_sensing_control = read_Leakage_sensing_control_value
    End Property

    Property Let set_Leakage_sensing_control(aData)
        write_Leakage_sensing_control_value = aData
        flag_Leakage_sensing_control        = &H1
    End Property

    Property Get read_Leakage_sensing_control
        read
        read_Leakage_sensing_control = read_Leakage_sensing_control_value
    End Property

    Property Let write_Leakage_sensing_control(aData)
        set_Leakage_sensing_control = aData
        write
    End Property

    Property Get get_Output_voltage_tuning
        get_Output_voltage_tuning = read_Output_voltage_tuning_value
    End Property

    Property Let set_Output_voltage_tuning(aData)
        write_Output_voltage_tuning_value = aData
        flag_Output_voltage_tuning        = &H1
    End Property

    Property Get read_Output_voltage_tuning
        read
        read_Output_voltage_tuning = read_Output_voltage_tuning_value
    End Property

    Property Let write_Output_voltage_tuning(aData)
        set_Output_voltage_tuning = aData
        write
    End Property

    Property Get get_BTCT
        get_BTCT = read_BTCT_value
    End Property

    Property Let set_BTCT(aData)
        write_BTCT_value = aData
        flag_BTCT        = &H1
    End Property

    Property Get read_BTCT
        read
        read_BTCT = read_BTCT_value
    End Property

    Property Let write_BTCT(aData)
        set_BTCT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_BG_ref_voltage_trimming_value = rightShift(data_low, 11) and &Hf
        read_Inrush_current_adjustment_value = rightShift(data_low, 10) and &H1
        read_Current_limit_adjustment_value = rightShift(data_low, 9) and &H1
        read_Leakage_sensing_control_value = rightShift(data_low, 8) and &H1
        read_Output_voltage_tuning_value = rightShift(data_low, 4) and &Hf
        BTCT_mask = &Hf
        if data_low > LONG_MAX then
            if BTCT_mask = mask then
                read_BTCT_value = data_low
            else
                read_BTCT_value = (data_low - H8000_0000) and BTCT_mask
            end If
        else
            read_BTCT_value = data_low and BTCT_mask
        end If

    End Sub

    Sub write
        If flag_BG_ref_voltage_trimming = &H0 or flag_Inrush_current_adjustment = &H0 or flag_Current_limit_adjustment = &H0 or flag_Leakage_sensing_control = &H0 or flag_Output_voltage_tuning = &H0 or flag_BTCT = &H0 Then read
        If flag_BG_ref_voltage_trimming = &H0 Then write_BG_ref_voltage_trimming_value = get_BG_ref_voltage_trimming
        If flag_Inrush_current_adjustment = &H0 Then write_Inrush_current_adjustment_value = get_Inrush_current_adjustment
        If flag_Current_limit_adjustment = &H0 Then write_Current_limit_adjustment_value = get_Current_limit_adjustment
        If flag_Leakage_sensing_control = &H0 Then write_Leakage_sensing_control_value = get_Leakage_sensing_control
        If flag_Output_voltage_tuning = &H0 Then write_Output_voltage_tuning_value = get_Output_voltage_tuning
        If flag_BTCT = &H0 Then write_BTCT_value = get_BTCT

        regValue = leftShift((write_BG_ref_voltage_trimming_value and &Hf), 11) + leftShift((write_Inrush_current_adjustment_value and &H1), 10) + leftShift((write_Current_limit_adjustment_value and &H1), 9) + leftShift((write_Leakage_sensing_control_value and &H1), 8) + leftShift((write_Output_voltage_tuning_value and &Hf), 4) + leftShift((write_BTCT_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_BG_ref_voltage_trimming_value = rightShift(data_low, 11) and &Hf
        read_Inrush_current_adjustment_value = rightShift(data_low, 10) and &H1
        read_Current_limit_adjustment_value = rightShift(data_low, 9) and &H1
        read_Leakage_sensing_control_value = rightShift(data_low, 8) and &H1
        read_Output_voltage_tuning_value = rightShift(data_low, 4) and &Hf
        BTCT_mask = &Hf
        if data_low > LONG_MAX then
            if BTCT_mask = mask then
                read_BTCT_value = data_low
            else
                read_BTCT_value = (data_low - H8000_0000) and BTCT_mask
            end If
        else
            read_BTCT_value = data_low and BTCT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_BG_ref_voltage_trimming_value = &H0
        flag_BG_ref_voltage_trimming        = &H0
        write_Inrush_current_adjustment_value = &H0
        flag_Inrush_current_adjustment        = &H0
        write_Current_limit_adjustment_value = &H0
        flag_Current_limit_adjustment        = &H0
        write_Leakage_sensing_control_value = &H0
        flag_Leakage_sensing_control        = &H0
        write_Output_voltage_tuning_value = &H0
        flag_Output_voltage_tuning        = &H0
        write_BTCT_value = &H0
        flag_BTCT        = &H0
    End Sub
End Class


'' @REGISTER : BRPHY_1G_1PORT_MISC_vreg_cntl_2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' pwrdn                                      [5:5]            get_pwrdn
''                                                             set_pwrdn
''                                                             read_pwrdn
''                                                             write_pwrdn
''---------------------------------------------------------------------------------
'' vregcntlen                                 [4:4]            get_vregcntlen
''                                                             set_vregcntlen
''                                                             read_vregcntlen
''                                                             write_vregcntlen
''---------------------------------------------------------------------------------
'' Zero_position_adjustment                   [3:2]            get_Zero_position_adjustment
''                                                             set_Zero_position_adjustment
''                                                             read_Zero_position_adjustment
''                                                             write_Zero_position_adjustment
''---------------------------------------------------------------------------------
'' LSA                                        [1:0]            get_LSA
''                                                             set_LSA
''                                                             read_LSA
''                                                             write_LSA
''---------------------------------------------------------------------------------
Class REGISTER_BRPHY_1G_1PORT_MISC_vreg_cntl_2
    Private write_pwrdn_value
    Private read_pwrdn_value
    Private flag_pwrdn
    Private write_vregcntlen_value
    Private read_vregcntlen_value
    Private flag_vregcntlen
    Private write_Zero_position_adjustment_value
    Private read_Zero_position_adjustment_value
    Private flag_Zero_position_adjustment
    Private write_LSA_value
    Private read_LSA_value
    Private flag_LSA

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

    Property Get get_pwrdn
        get_pwrdn = read_pwrdn_value
    End Property

    Property Let set_pwrdn(aData)
        write_pwrdn_value = aData
        flag_pwrdn        = &H1
    End Property

    Property Get read_pwrdn
        read
        read_pwrdn = read_pwrdn_value
    End Property

    Property Let write_pwrdn(aData)
        set_pwrdn = aData
        write
    End Property

    Property Get get_vregcntlen
        get_vregcntlen = read_vregcntlen_value
    End Property

    Property Let set_vregcntlen(aData)
        write_vregcntlen_value = aData
        flag_vregcntlen        = &H1
    End Property

    Property Get read_vregcntlen
        read
        read_vregcntlen = read_vregcntlen_value
    End Property

    Property Let write_vregcntlen(aData)
        set_vregcntlen = aData
        write
    End Property

    Property Get get_Zero_position_adjustment
        get_Zero_position_adjustment = read_Zero_position_adjustment_value
    End Property

    Property Let set_Zero_position_adjustment(aData)
        write_Zero_position_adjustment_value = aData
        flag_Zero_position_adjustment        = &H1
    End Property

    Property Get read_Zero_position_adjustment
        read
        read_Zero_position_adjustment = read_Zero_position_adjustment_value
    End Property

    Property Let write_Zero_position_adjustment(aData)
        set_Zero_position_adjustment = aData
        write
    End Property

    Property Get get_LSA
        get_LSA = read_LSA_value
    End Property

    Property Let set_LSA(aData)
        write_LSA_value = aData
        flag_LSA        = &H1
    End Property

    Property Get read_LSA
        read
        read_LSA = read_LSA_value
    End Property

    Property Let write_LSA(aData)
        set_LSA = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_pwrdn_value = rightShift(data_low, 5) and &H1
        read_vregcntlen_value = rightShift(data_low, 4) and &H1
        read_Zero_position_adjustment_value = rightShift(data_low, 2) and &H3
        LSA_mask = &H3
        if data_low > LONG_MAX then
            if LSA_mask = mask then
                read_LSA_value = data_low
            else
                read_LSA_value = (data_low - H8000_0000) and LSA_mask
            end If
        else
            read_LSA_value = data_low and LSA_mask
        end If

    End Sub

    Sub write
        If flag_pwrdn = &H0 or flag_vregcntlen = &H0 or flag_Zero_position_adjustment = &H0 or flag_LSA = &H0 Then read
        If flag_pwrdn = &H0 Then write_pwrdn_value = get_pwrdn
        If flag_vregcntlen = &H0 Then write_vregcntlen_value = get_vregcntlen
        If flag_Zero_position_adjustment = &H0 Then write_Zero_position_adjustment_value = get_Zero_position_adjustment
        If flag_LSA = &H0 Then write_LSA_value = get_LSA

        regValue = leftShift((write_pwrdn_value and &H1), 5) + leftShift((write_vregcntlen_value and &H1), 4) + leftShift((write_Zero_position_adjustment_value and &H3), 2) + leftShift((write_LSA_value and &H3), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_pwrdn_value = rightShift(data_low, 5) and &H1
        read_vregcntlen_value = rightShift(data_low, 4) and &H1
        read_Zero_position_adjustment_value = rightShift(data_low, 2) and &H3
        LSA_mask = &H3
        if data_low > LONG_MAX then
            if LSA_mask = mask then
                read_LSA_value = data_low
            else
                read_LSA_value = (data_low - H8000_0000) and LSA_mask
            end If
        else
            read_LSA_value = data_low and LSA_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_pwrdn_value = &H0
        flag_pwrdn        = &H0
        write_vregcntlen_value = &H0
        flag_vregcntlen        = &H0
        write_Zero_position_adjustment_value = &H0
        flag_Zero_position_adjustment        = &H0
        write_LSA_value = &H0
        flag_LSA        = &H0
    End Sub
End Class


'' @REGISTER : BRPHY_1G_1PORT_MISC_prod_ctrl0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' RO_EN                                      [11:0]           get_RO_EN
''                                                             set_RO_EN
''                                                             read_RO_EN
''                                                             write_RO_EN
''---------------------------------------------------------------------------------
Class REGISTER_BRPHY_1G_1PORT_MISC_prod_ctrl0
    Private write_RO_EN_value
    Private read_RO_EN_value
    Private flag_RO_EN

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

    Property Get get_RO_EN
        get_RO_EN = read_RO_EN_value
    End Property

    Property Let set_RO_EN(aData)
        write_RO_EN_value = aData
        flag_RO_EN        = &H1
    End Property

    Property Get read_RO_EN
        read
        read_RO_EN = read_RO_EN_value
    End Property

    Property Let write_RO_EN(aData)
        set_RO_EN = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        RO_EN_mask = &Hfff
        if data_low > LONG_MAX then
            if RO_EN_mask = mask then
                read_RO_EN_value = data_low
            else
                read_RO_EN_value = (data_low - H8000_0000) and RO_EN_mask
            end If
        else
            read_RO_EN_value = data_low and RO_EN_mask
        end If

    End Sub

    Sub write
        If flag_RO_EN = &H0 Then read
        If flag_RO_EN = &H0 Then write_RO_EN_value = get_RO_EN

        regValue = leftShift((write_RO_EN_value and &Hfff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        RO_EN_mask = &Hfff
        if data_low > LONG_MAX then
            if RO_EN_mask = mask then
                read_RO_EN_value = data_low
            else
                read_RO_EN_value = (data_low - H8000_0000) and RO_EN_mask
            end If
        else
            read_RO_EN_value = data_low and RO_EN_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_RO_EN_value = &H0
        flag_RO_EN        = &H0
    End Sub
End Class


'' @REGISTER : BRPHY_1G_1PORT_MISC_prod_ctrl1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' RO_SEL                                     [11:0]           get_RO_SEL
''                                                             set_RO_SEL
''                                                             read_RO_SEL
''                                                             write_RO_SEL
''---------------------------------------------------------------------------------
Class REGISTER_BRPHY_1G_1PORT_MISC_prod_ctrl1
    Private write_RO_SEL_value
    Private read_RO_SEL_value
    Private flag_RO_SEL

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

    Property Get get_RO_SEL
        get_RO_SEL = read_RO_SEL_value
    End Property

    Property Let set_RO_SEL(aData)
        write_RO_SEL_value = aData
        flag_RO_SEL        = &H1
    End Property

    Property Get read_RO_SEL
        read
        read_RO_SEL = read_RO_SEL_value
    End Property

    Property Let write_RO_SEL(aData)
        set_RO_SEL = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        RO_SEL_mask = &Hfff
        if data_low > LONG_MAX then
            if RO_SEL_mask = mask then
                read_RO_SEL_value = data_low
            else
                read_RO_SEL_value = (data_low - H8000_0000) and RO_SEL_mask
            end If
        else
            read_RO_SEL_value = data_low and RO_SEL_mask
        end If

    End Sub

    Sub write
        If flag_RO_SEL = &H0 Then read
        If flag_RO_SEL = &H0 Then write_RO_SEL_value = get_RO_SEL

        regValue = leftShift((write_RO_SEL_value and &Hfff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        RO_SEL_mask = &Hfff
        if data_low > LONG_MAX then
            if RO_SEL_mask = mask then
                read_RO_SEL_value = data_low
            else
                read_RO_SEL_value = (data_low - H8000_0000) and RO_SEL_mask
            end If
        else
            read_RO_SEL_value = data_low and RO_SEL_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_RO_SEL_value = &H0
        flag_RO_SEL        = &H0
    End Sub
End Class


'' @REGISTER : BRPHY_1G_1PORT_MISC_adccal_enable
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PRBS_EN_OV                                 [6:6]            get_PRBS_EN_OV
''                                                             set_PRBS_EN_OV
''                                                             read_PRBS_EN_OV
''                                                             write_PRBS_EN_OV
''---------------------------------------------------------------------------------
'' ADCCAL_DIS_IN_100M                         [5:5]            get_ADCCAL_DIS_IN_100M
''                                                             set_ADCCAL_DIS_IN_100M
''                                                             read_ADCCAL_DIS_IN_100M
''                                                             write_ADCCAL_DIS_IN_100M
''---------------------------------------------------------------------------------
'' PHYC_ADCCAL_DIS                            [4:4]            get_PHYC_ADCCAL_DIS
''                                                             set_PHYC_ADCCAL_DIS
''                                                             read_PHYC_ADCCAL_DIS
''                                                             write_PHYC_ADCCAL_DIS
''---------------------------------------------------------------------------------
'' LGAIN_CAL_EN                               [3:3]            get_LGAIN_CAL_EN
''                                                             set_LGAIN_CAL_EN
''                                                             read_LGAIN_CAL_EN
''                                                             write_LGAIN_CAL_EN
''---------------------------------------------------------------------------------
'' OFFSET_CAL_EN                              [2:2]            get_OFFSET_CAL_EN
''                                                             set_OFFSET_CAL_EN
''                                                             read_OFFSET_CAL_EN
''                                                             write_OFFSET_CAL_EN
''---------------------------------------------------------------------------------
'' GAIN_CAL_EN                                [1:1]            get_GAIN_CAL_EN
''                                                             set_GAIN_CAL_EN
''                                                             read_GAIN_CAL_EN
''                                                             write_GAIN_CAL_EN
''---------------------------------------------------------------------------------
'' FGCAL_EN                                   [0:0]            get_FGCAL_EN
''                                                             set_FGCAL_EN
''                                                             read_FGCAL_EN
''                                                             write_FGCAL_EN
''---------------------------------------------------------------------------------
Class REGISTER_BRPHY_1G_1PORT_MISC_adccal_enable
    Private write_PRBS_EN_OV_value
    Private read_PRBS_EN_OV_value
    Private flag_PRBS_EN_OV
    Private write_ADCCAL_DIS_IN_100M_value
    Private read_ADCCAL_DIS_IN_100M_value
    Private flag_ADCCAL_DIS_IN_100M
    Private write_PHYC_ADCCAL_DIS_value
    Private read_PHYC_ADCCAL_DIS_value
    Private flag_PHYC_ADCCAL_DIS
    Private write_LGAIN_CAL_EN_value
    Private read_LGAIN_CAL_EN_value
    Private flag_LGAIN_CAL_EN
    Private write_OFFSET_CAL_EN_value
    Private read_OFFSET_CAL_EN_value
    Private flag_OFFSET_CAL_EN
    Private write_GAIN_CAL_EN_value
    Private read_GAIN_CAL_EN_value
    Private flag_GAIN_CAL_EN
    Private write_FGCAL_EN_value
    Private read_FGCAL_EN_value
    Private flag_FGCAL_EN

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

    Property Get get_PRBS_EN_OV
        get_PRBS_EN_OV = read_PRBS_EN_OV_value
    End Property

    Property Let set_PRBS_EN_OV(aData)
        write_PRBS_EN_OV_value = aData
        flag_PRBS_EN_OV        = &H1
    End Property

    Property Get read_PRBS_EN_OV
        read
        read_PRBS_EN_OV = read_PRBS_EN_OV_value
    End Property

    Property Let write_PRBS_EN_OV(aData)
        set_PRBS_EN_OV = aData
        write
    End Property

    Property Get get_ADCCAL_DIS_IN_100M
        get_ADCCAL_DIS_IN_100M = read_ADCCAL_DIS_IN_100M_value
    End Property

    Property Let set_ADCCAL_DIS_IN_100M(aData)
        write_ADCCAL_DIS_IN_100M_value = aData
        flag_ADCCAL_DIS_IN_100M        = &H1
    End Property

    Property Get read_ADCCAL_DIS_IN_100M
        read
        read_ADCCAL_DIS_IN_100M = read_ADCCAL_DIS_IN_100M_value
    End Property

    Property Let write_ADCCAL_DIS_IN_100M(aData)
        set_ADCCAL_DIS_IN_100M = aData
        write
    End Property

    Property Get get_PHYC_ADCCAL_DIS
        get_PHYC_ADCCAL_DIS = read_PHYC_ADCCAL_DIS_value
    End Property

    Property Let set_PHYC_ADCCAL_DIS(aData)
        write_PHYC_ADCCAL_DIS_value = aData
        flag_PHYC_ADCCAL_DIS        = &H1
    End Property

    Property Get read_PHYC_ADCCAL_DIS
        read
        read_PHYC_ADCCAL_DIS = read_PHYC_ADCCAL_DIS_value
    End Property

    Property Let write_PHYC_ADCCAL_DIS(aData)
        set_PHYC_ADCCAL_DIS = aData
        write
    End Property

    Property Get get_LGAIN_CAL_EN
        get_LGAIN_CAL_EN = read_LGAIN_CAL_EN_value
    End Property

    Property Let set_LGAIN_CAL_EN(aData)
        write_LGAIN_CAL_EN_value = aData
        flag_LGAIN_CAL_EN        = &H1
    End Property

    Property Get read_LGAIN_CAL_EN
        read
        read_LGAIN_CAL_EN = read_LGAIN_CAL_EN_value
    End Property

    Property Let write_LGAIN_CAL_EN(aData)
        set_LGAIN_CAL_EN = aData
        write
    End Property

    Property Get get_OFFSET_CAL_EN
        get_OFFSET_CAL_EN = read_OFFSET_CAL_EN_value
    End Property

    Property Let set_OFFSET_CAL_EN(aData)
        write_OFFSET_CAL_EN_value = aData
        flag_OFFSET_CAL_EN        = &H1
    End Property

    Property Get read_OFFSET_CAL_EN
        read
        read_OFFSET_CAL_EN = read_OFFSET_CAL_EN_value
    End Property

    Property Let write_OFFSET_CAL_EN(aData)
        set_OFFSET_CAL_EN = aData
        write
    End Property

    Property Get get_GAIN_CAL_EN
        get_GAIN_CAL_EN = read_GAIN_CAL_EN_value
    End Property

    Property Let set_GAIN_CAL_EN(aData)
        write_GAIN_CAL_EN_value = aData
        flag_GAIN_CAL_EN        = &H1
    End Property

    Property Get read_GAIN_CAL_EN
        read
        read_GAIN_CAL_EN = read_GAIN_CAL_EN_value
    End Property

    Property Let write_GAIN_CAL_EN(aData)
        set_GAIN_CAL_EN = aData
        write
    End Property

    Property Get get_FGCAL_EN
        get_FGCAL_EN = read_FGCAL_EN_value
    End Property

    Property Let set_FGCAL_EN(aData)
        write_FGCAL_EN_value = aData
        flag_FGCAL_EN        = &H1
    End Property

    Property Get read_FGCAL_EN
        read
        read_FGCAL_EN = read_FGCAL_EN_value
    End Property

    Property Let write_FGCAL_EN(aData)
        set_FGCAL_EN = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_PRBS_EN_OV_value = rightShift(data_low, 6) and &H1
        read_ADCCAL_DIS_IN_100M_value = rightShift(data_low, 5) and &H1
        read_PHYC_ADCCAL_DIS_value = rightShift(data_low, 4) and &H1
        read_LGAIN_CAL_EN_value = rightShift(data_low, 3) and &H1
        read_OFFSET_CAL_EN_value = rightShift(data_low, 2) and &H1
        read_GAIN_CAL_EN_value = rightShift(data_low, 1) and &H1
        FGCAL_EN_mask = &H1
        if data_low > LONG_MAX then
            if FGCAL_EN_mask = mask then
                read_FGCAL_EN_value = data_low
            else
                read_FGCAL_EN_value = (data_low - H8000_0000) and FGCAL_EN_mask
            end If
        else
            read_FGCAL_EN_value = data_low and FGCAL_EN_mask
        end If

    End Sub

    Sub write
        If flag_PRBS_EN_OV = &H0 or flag_ADCCAL_DIS_IN_100M = &H0 or flag_PHYC_ADCCAL_DIS = &H0 or flag_LGAIN_CAL_EN = &H0 or flag_OFFSET_CAL_EN = &H0 or flag_GAIN_CAL_EN = &H0 or flag_FGCAL_EN = &H0 Then read
        If flag_PRBS_EN_OV = &H0 Then write_PRBS_EN_OV_value = get_PRBS_EN_OV
        If flag_ADCCAL_DIS_IN_100M = &H0 Then write_ADCCAL_DIS_IN_100M_value = get_ADCCAL_DIS_IN_100M
        If flag_PHYC_ADCCAL_DIS = &H0 Then write_PHYC_ADCCAL_DIS_value = get_PHYC_ADCCAL_DIS
        If flag_LGAIN_CAL_EN = &H0 Then write_LGAIN_CAL_EN_value = get_LGAIN_CAL_EN
        If flag_OFFSET_CAL_EN = &H0 Then write_OFFSET_CAL_EN_value = get_OFFSET_CAL_EN
        If flag_GAIN_CAL_EN = &H0 Then write_GAIN_CAL_EN_value = get_GAIN_CAL_EN
        If flag_FGCAL_EN = &H0 Then write_FGCAL_EN_value = get_FGCAL_EN

        regValue = leftShift((write_PRBS_EN_OV_value and &H1), 6) + leftShift((write_ADCCAL_DIS_IN_100M_value and &H1), 5) + leftShift((write_PHYC_ADCCAL_DIS_value and &H1), 4) + leftShift((write_LGAIN_CAL_EN_value and &H1), 3) + leftShift((write_OFFSET_CAL_EN_value and &H1), 2) + leftShift((write_GAIN_CAL_EN_value and &H1), 1) + leftShift((write_FGCAL_EN_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_PRBS_EN_OV_value = rightShift(data_low, 6) and &H1
        read_ADCCAL_DIS_IN_100M_value = rightShift(data_low, 5) and &H1
        read_PHYC_ADCCAL_DIS_value = rightShift(data_low, 4) and &H1
        read_LGAIN_CAL_EN_value = rightShift(data_low, 3) and &H1
        read_OFFSET_CAL_EN_value = rightShift(data_low, 2) and &H1
        read_GAIN_CAL_EN_value = rightShift(data_low, 1) and &H1
        FGCAL_EN_mask = &H1
        if data_low > LONG_MAX then
            if FGCAL_EN_mask = mask then
                read_FGCAL_EN_value = data_low
            else
                read_FGCAL_EN_value = (data_low - H8000_0000) and FGCAL_EN_mask
            end If
        else
            read_FGCAL_EN_value = data_low and FGCAL_EN_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PRBS_EN_OV_value = &H0
        flag_PRBS_EN_OV        = &H0
        write_ADCCAL_DIS_IN_100M_value = &H0
        flag_ADCCAL_DIS_IN_100M        = &H0
        write_PHYC_ADCCAL_DIS_value = &H0
        flag_PHYC_ADCCAL_DIS        = &H0
        write_LGAIN_CAL_EN_value = &H0
        flag_LGAIN_CAL_EN        = &H0
        write_OFFSET_CAL_EN_value = &H0
        flag_OFFSET_CAL_EN        = &H0
        write_GAIN_CAL_EN_value = &H0
        flag_GAIN_CAL_EN        = &H0
        write_FGCAL_EN_value = &H0
        flag_FGCAL_EN        = &H0
    End Sub
End Class


'' @REGISTER : BRPHY_1G_1PORT_MISC_otp_p1588_rd_ctl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' FETCH_INHIBIT                              [15:15]          get_FETCH_INHIBIT
''                                                             set_FETCH_INHIBIT
''                                                             read_FETCH_INHIBIT
''                                                             write_FETCH_INHIBIT
''---------------------------------------------------------------------------------
'' FETCH_FAIL                                 [9:9]            get_FETCH_FAIL
''                                                             set_FETCH_FAIL
''                                                             read_FETCH_FAIL
''                                                             write_FETCH_FAIL
''---------------------------------------------------------------------------------
'' FETCH_COMPLETE                             [8:8]            get_FETCH_COMPLETE
''                                                             set_FETCH_COMPLETE
''                                                             read_FETCH_COMPLETE
''                                                             write_FETCH_COMPLETE
''---------------------------------------------------------------------------------
'' WATCHDOG_DIS                               [7:7]            get_WATCHDOG_DIS
''                                                             set_WATCHDOG_DIS
''                                                             read_WATCHDOG_DIS
''                                                             write_WATCHDOG_DIS
''---------------------------------------------------------------------------------
'' FETCH_RESTART                              [6:6]            get_FETCH_RESTART
''                                                             set_FETCH_RESTART
''                                                             read_FETCH_RESTART
''                                                             write_FETCH_RESTART
''---------------------------------------------------------------------------------
'' OTP_ADDR_START                             [5:0]            get_OTP_ADDR_START
''                                                             set_OTP_ADDR_START
''                                                             read_OTP_ADDR_START
''                                                             write_OTP_ADDR_START
''---------------------------------------------------------------------------------
Class REGISTER_BRPHY_1G_1PORT_MISC_otp_p1588_rd_ctl
    Private write_FETCH_INHIBIT_value
    Private read_FETCH_INHIBIT_value
    Private flag_FETCH_INHIBIT
    Private write_FETCH_FAIL_value
    Private read_FETCH_FAIL_value
    Private flag_FETCH_FAIL
    Private write_FETCH_COMPLETE_value
    Private read_FETCH_COMPLETE_value
    Private flag_FETCH_COMPLETE
    Private write_WATCHDOG_DIS_value
    Private read_WATCHDOG_DIS_value
    Private flag_WATCHDOG_DIS
    Private write_FETCH_RESTART_value
    Private read_FETCH_RESTART_value
    Private flag_FETCH_RESTART
    Private write_OTP_ADDR_START_value
    Private read_OTP_ADDR_START_value
    Private flag_OTP_ADDR_START

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

    Property Get get_FETCH_INHIBIT
        get_FETCH_INHIBIT = read_FETCH_INHIBIT_value
    End Property

    Property Let set_FETCH_INHIBIT(aData)
        write_FETCH_INHIBIT_value = aData
        flag_FETCH_INHIBIT        = &H1
    End Property

    Property Get read_FETCH_INHIBIT
        read
        read_FETCH_INHIBIT = read_FETCH_INHIBIT_value
    End Property

    Property Let write_FETCH_INHIBIT(aData)
        set_FETCH_INHIBIT = aData
        write
    End Property

    Property Get get_FETCH_FAIL
        get_FETCH_FAIL = read_FETCH_FAIL_value
    End Property

    Property Let set_FETCH_FAIL(aData)
        write_FETCH_FAIL_value = aData
        flag_FETCH_FAIL        = &H1
    End Property

    Property Get read_FETCH_FAIL
        read
        read_FETCH_FAIL = read_FETCH_FAIL_value
    End Property

    Property Let write_FETCH_FAIL(aData)
        set_FETCH_FAIL = aData
        write
    End Property

    Property Get get_FETCH_COMPLETE
        get_FETCH_COMPLETE = read_FETCH_COMPLETE_value
    End Property

    Property Let set_FETCH_COMPLETE(aData)
        write_FETCH_COMPLETE_value = aData
        flag_FETCH_COMPLETE        = &H1
    End Property

    Property Get read_FETCH_COMPLETE
        read
        read_FETCH_COMPLETE = read_FETCH_COMPLETE_value
    End Property

    Property Let write_FETCH_COMPLETE(aData)
        set_FETCH_COMPLETE = aData
        write
    End Property

    Property Get get_WATCHDOG_DIS
        get_WATCHDOG_DIS = read_WATCHDOG_DIS_value
    End Property

    Property Let set_WATCHDOG_DIS(aData)
        write_WATCHDOG_DIS_value = aData
        flag_WATCHDOG_DIS        = &H1
    End Property

    Property Get read_WATCHDOG_DIS
        read
        read_WATCHDOG_DIS = read_WATCHDOG_DIS_value
    End Property

    Property Let write_WATCHDOG_DIS(aData)
        set_WATCHDOG_DIS = aData
        write
    End Property

    Property Get get_FETCH_RESTART
        get_FETCH_RESTART = read_FETCH_RESTART_value
    End Property

    Property Let set_FETCH_RESTART(aData)
        write_FETCH_RESTART_value = aData
        flag_FETCH_RESTART        = &H1
    End Property

    Property Get read_FETCH_RESTART
        read
        read_FETCH_RESTART = read_FETCH_RESTART_value
    End Property

    Property Let write_FETCH_RESTART(aData)
        set_FETCH_RESTART = aData
        write
    End Property

    Property Get get_OTP_ADDR_START
        get_OTP_ADDR_START = read_OTP_ADDR_START_value
    End Property

    Property Let set_OTP_ADDR_START(aData)
        write_OTP_ADDR_START_value = aData
        flag_OTP_ADDR_START        = &H1
    End Property

    Property Get read_OTP_ADDR_START
        read
        read_OTP_ADDR_START = read_OTP_ADDR_START_value
    End Property

    Property Let write_OTP_ADDR_START(aData)
        set_OTP_ADDR_START = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_FETCH_INHIBIT_value = rightShift(data_low, 15) and &H1
        read_FETCH_FAIL_value = rightShift(data_low, 9) and &H1
        read_FETCH_COMPLETE_value = rightShift(data_low, 8) and &H1
        read_WATCHDOG_DIS_value = rightShift(data_low, 7) and &H1
        read_FETCH_RESTART_value = rightShift(data_low, 6) and &H1
        OTP_ADDR_START_mask = &H3f
        if data_low > LONG_MAX then
            if OTP_ADDR_START_mask = mask then
                read_OTP_ADDR_START_value = data_low
            else
                read_OTP_ADDR_START_value = (data_low - H8000_0000) and OTP_ADDR_START_mask
            end If
        else
            read_OTP_ADDR_START_value = data_low and OTP_ADDR_START_mask
        end If

    End Sub

    Sub write
        If flag_FETCH_INHIBIT = &H0 or flag_FETCH_FAIL = &H0 or flag_FETCH_COMPLETE = &H0 or flag_WATCHDOG_DIS = &H0 or flag_FETCH_RESTART = &H0 or flag_OTP_ADDR_START = &H0 Then read
        If flag_FETCH_INHIBIT = &H0 Then write_FETCH_INHIBIT_value = get_FETCH_INHIBIT
        If flag_FETCH_FAIL = &H0 Then write_FETCH_FAIL_value = get_FETCH_FAIL
        If flag_FETCH_COMPLETE = &H0 Then write_FETCH_COMPLETE_value = get_FETCH_COMPLETE
        If flag_WATCHDOG_DIS = &H0 Then write_WATCHDOG_DIS_value = get_WATCHDOG_DIS
        If flag_FETCH_RESTART = &H0 Then write_FETCH_RESTART_value = get_FETCH_RESTART
        If flag_OTP_ADDR_START = &H0 Then write_OTP_ADDR_START_value = get_OTP_ADDR_START

        regValue = leftShift((write_FETCH_INHIBIT_value and &H1), 15) + leftShift((write_FETCH_FAIL_value and &H1), 9) + leftShift((write_FETCH_COMPLETE_value and &H1), 8) + leftShift((write_WATCHDOG_DIS_value and &H1), 7) + leftShift((write_FETCH_RESTART_value and &H1), 6) + leftShift((write_OTP_ADDR_START_value and &H3f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_FETCH_INHIBIT_value = rightShift(data_low, 15) and &H1
        read_FETCH_FAIL_value = rightShift(data_low, 9) and &H1
        read_FETCH_COMPLETE_value = rightShift(data_low, 8) and &H1
        read_WATCHDOG_DIS_value = rightShift(data_low, 7) and &H1
        read_FETCH_RESTART_value = rightShift(data_low, 6) and &H1
        OTP_ADDR_START_mask = &H3f
        if data_low > LONG_MAX then
            if OTP_ADDR_START_mask = mask then
                read_OTP_ADDR_START_value = data_low
            else
                read_OTP_ADDR_START_value = (data_low - H8000_0000) and OTP_ADDR_START_mask
            end If
        else
            read_OTP_ADDR_START_value = data_low and OTP_ADDR_START_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_FETCH_INHIBIT_value = &H0
        flag_FETCH_INHIBIT        = &H0
        write_FETCH_FAIL_value = &H0
        flag_FETCH_FAIL        = &H0
        write_FETCH_COMPLETE_value = &H0
        flag_FETCH_COMPLETE        = &H0
        write_WATCHDOG_DIS_value = &H0
        flag_WATCHDOG_DIS        = &H0
        write_FETCH_RESTART_value = &H0
        flag_FETCH_RESTART        = &H0
        write_OTP_ADDR_START_value = &H0
        flag_OTP_ADDR_START        = &H0
    End Sub
End Class


'' @REGISTER : BRPHY_1G_1PORT_MISC_otp_p1588_icv1_0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' OTP_P1588_ICV1_15_0                        [15:0]           get_OTP_P1588_ICV1_15_0
''                                                             set_OTP_P1588_ICV1_15_0
''                                                             read_OTP_P1588_ICV1_15_0
''                                                             write_OTP_P1588_ICV1_15_0
''---------------------------------------------------------------------------------
Class REGISTER_BRPHY_1G_1PORT_MISC_otp_p1588_icv1_0
    Private write_OTP_P1588_ICV1_15_0_value
    Private read_OTP_P1588_ICV1_15_0_value
    Private flag_OTP_P1588_ICV1_15_0

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

    Property Get get_OTP_P1588_ICV1_15_0
        get_OTP_P1588_ICV1_15_0 = read_OTP_P1588_ICV1_15_0_value
    End Property

    Property Let set_OTP_P1588_ICV1_15_0(aData)
        write_OTP_P1588_ICV1_15_0_value = aData
        flag_OTP_P1588_ICV1_15_0        = &H1
    End Property

    Property Get read_OTP_P1588_ICV1_15_0
        read
        read_OTP_P1588_ICV1_15_0 = read_OTP_P1588_ICV1_15_0_value
    End Property

    Property Let write_OTP_P1588_ICV1_15_0(aData)
        set_OTP_P1588_ICV1_15_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        OTP_P1588_ICV1_15_0_mask = &Hffff
        if data_low > LONG_MAX then
            if OTP_P1588_ICV1_15_0_mask = mask then
                read_OTP_P1588_ICV1_15_0_value = data_low
            else
                read_OTP_P1588_ICV1_15_0_value = (data_low - H8000_0000) and OTP_P1588_ICV1_15_0_mask
            end If
        else
            read_OTP_P1588_ICV1_15_0_value = data_low and OTP_P1588_ICV1_15_0_mask
        end If

    End Sub

    Sub write
        If flag_OTP_P1588_ICV1_15_0 = &H0 Then read
        If flag_OTP_P1588_ICV1_15_0 = &H0 Then write_OTP_P1588_ICV1_15_0_value = get_OTP_P1588_ICV1_15_0

        regValue = leftShift((write_OTP_P1588_ICV1_15_0_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        OTP_P1588_ICV1_15_0_mask = &Hffff
        if data_low > LONG_MAX then
            if OTP_P1588_ICV1_15_0_mask = mask then
                read_OTP_P1588_ICV1_15_0_value = data_low
            else
                read_OTP_P1588_ICV1_15_0_value = (data_low - H8000_0000) and OTP_P1588_ICV1_15_0_mask
            end If
        else
            read_OTP_P1588_ICV1_15_0_value = data_low and OTP_P1588_ICV1_15_0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_OTP_P1588_ICV1_15_0_value = &H0
        flag_OTP_P1588_ICV1_15_0        = &H0
    End Sub
End Class


'' @REGISTER : BRPHY_1G_1PORT_MISC_otp_p1588_icv1_1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' OTP_P1588_ICV1_31_16                       [15:0]           get_OTP_P1588_ICV1_31_16
''                                                             set_OTP_P1588_ICV1_31_16
''                                                             read_OTP_P1588_ICV1_31_16
''                                                             write_OTP_P1588_ICV1_31_16
''---------------------------------------------------------------------------------
Class REGISTER_BRPHY_1G_1PORT_MISC_otp_p1588_icv1_1
    Private write_OTP_P1588_ICV1_31_16_value
    Private read_OTP_P1588_ICV1_31_16_value
    Private flag_OTP_P1588_ICV1_31_16

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

    Property Get get_OTP_P1588_ICV1_31_16
        get_OTP_P1588_ICV1_31_16 = read_OTP_P1588_ICV1_31_16_value
    End Property

    Property Let set_OTP_P1588_ICV1_31_16(aData)
        write_OTP_P1588_ICV1_31_16_value = aData
        flag_OTP_P1588_ICV1_31_16        = &H1
    End Property

    Property Get read_OTP_P1588_ICV1_31_16
        read
        read_OTP_P1588_ICV1_31_16 = read_OTP_P1588_ICV1_31_16_value
    End Property

    Property Let write_OTP_P1588_ICV1_31_16(aData)
        set_OTP_P1588_ICV1_31_16 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        OTP_P1588_ICV1_31_16_mask = &Hffff
        if data_low > LONG_MAX then
            if OTP_P1588_ICV1_31_16_mask = mask then
                read_OTP_P1588_ICV1_31_16_value = data_low
            else
                read_OTP_P1588_ICV1_31_16_value = (data_low - H8000_0000) and OTP_P1588_ICV1_31_16_mask
            end If
        else
            read_OTP_P1588_ICV1_31_16_value = data_low and OTP_P1588_ICV1_31_16_mask
        end If

    End Sub

    Sub write
        If flag_OTP_P1588_ICV1_31_16 = &H0 Then read
        If flag_OTP_P1588_ICV1_31_16 = &H0 Then write_OTP_P1588_ICV1_31_16_value = get_OTP_P1588_ICV1_31_16

        regValue = leftShift((write_OTP_P1588_ICV1_31_16_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        OTP_P1588_ICV1_31_16_mask = &Hffff
        if data_low > LONG_MAX then
            if OTP_P1588_ICV1_31_16_mask = mask then
                read_OTP_P1588_ICV1_31_16_value = data_low
            else
                read_OTP_P1588_ICV1_31_16_value = (data_low - H8000_0000) and OTP_P1588_ICV1_31_16_mask
            end If
        else
            read_OTP_P1588_ICV1_31_16_value = data_low and OTP_P1588_ICV1_31_16_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_OTP_P1588_ICV1_31_16_value = &H0
        flag_OTP_P1588_ICV1_31_16        = &H0
    End Sub
End Class


'' @REGISTER : BRPHY_1G_1PORT_MISC_otp_p1588_icv1_2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' OTP_P1588_ICV1_47_32                       [15:0]           get_OTP_P1588_ICV1_47_32
''                                                             set_OTP_P1588_ICV1_47_32
''                                                             read_OTP_P1588_ICV1_47_32
''                                                             write_OTP_P1588_ICV1_47_32
''---------------------------------------------------------------------------------
Class REGISTER_BRPHY_1G_1PORT_MISC_otp_p1588_icv1_2
    Private write_OTP_P1588_ICV1_47_32_value
    Private read_OTP_P1588_ICV1_47_32_value
    Private flag_OTP_P1588_ICV1_47_32

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

    Property Get get_OTP_P1588_ICV1_47_32
        get_OTP_P1588_ICV1_47_32 = read_OTP_P1588_ICV1_47_32_value
    End Property

    Property Let set_OTP_P1588_ICV1_47_32(aData)
        write_OTP_P1588_ICV1_47_32_value = aData
        flag_OTP_P1588_ICV1_47_32        = &H1
    End Property

    Property Get read_OTP_P1588_ICV1_47_32
        read
        read_OTP_P1588_ICV1_47_32 = read_OTP_P1588_ICV1_47_32_value
    End Property

    Property Let write_OTP_P1588_ICV1_47_32(aData)
        set_OTP_P1588_ICV1_47_32 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        OTP_P1588_ICV1_47_32_mask = &Hffff
        if data_low > LONG_MAX then
            if OTP_P1588_ICV1_47_32_mask = mask then
                read_OTP_P1588_ICV1_47_32_value = data_low
            else
                read_OTP_P1588_ICV1_47_32_value = (data_low - H8000_0000) and OTP_P1588_ICV1_47_32_mask
            end If
        else
            read_OTP_P1588_ICV1_47_32_value = data_low and OTP_P1588_ICV1_47_32_mask
        end If

    End Sub

    Sub write
        If flag_OTP_P1588_ICV1_47_32 = &H0 Then read
        If flag_OTP_P1588_ICV1_47_32 = &H0 Then write_OTP_P1588_ICV1_47_32_value = get_OTP_P1588_ICV1_47_32

        regValue = leftShift((write_OTP_P1588_ICV1_47_32_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        OTP_P1588_ICV1_47_32_mask = &Hffff
        if data_low > LONG_MAX then
            if OTP_P1588_ICV1_47_32_mask = mask then
                read_OTP_P1588_ICV1_47_32_value = data_low
            else
                read_OTP_P1588_ICV1_47_32_value = (data_low - H8000_0000) and OTP_P1588_ICV1_47_32_mask
            end If
        else
            read_OTP_P1588_ICV1_47_32_value = data_low and OTP_P1588_ICV1_47_32_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_OTP_P1588_ICV1_47_32_value = &H0
        flag_OTP_P1588_ICV1_47_32        = &H0
    End Sub
End Class


'' @REGISTER : BRPHY_1G_1PORT_MISC_otp_p1588_icv1_3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' OTP_P1588_ICV1_63_48                       [15:0]           get_OTP_P1588_ICV1_63_48
''                                                             set_OTP_P1588_ICV1_63_48
''                                                             read_OTP_P1588_ICV1_63_48
''                                                             write_OTP_P1588_ICV1_63_48
''---------------------------------------------------------------------------------
Class REGISTER_BRPHY_1G_1PORT_MISC_otp_p1588_icv1_3
    Private write_OTP_P1588_ICV1_63_48_value
    Private read_OTP_P1588_ICV1_63_48_value
    Private flag_OTP_P1588_ICV1_63_48

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

    Property Get get_OTP_P1588_ICV1_63_48
        get_OTP_P1588_ICV1_63_48 = read_OTP_P1588_ICV1_63_48_value
    End Property

    Property Let set_OTP_P1588_ICV1_63_48(aData)
        write_OTP_P1588_ICV1_63_48_value = aData
        flag_OTP_P1588_ICV1_63_48        = &H1
    End Property

    Property Get read_OTP_P1588_ICV1_63_48
        read
        read_OTP_P1588_ICV1_63_48 = read_OTP_P1588_ICV1_63_48_value
    End Property

    Property Let write_OTP_P1588_ICV1_63_48(aData)
        set_OTP_P1588_ICV1_63_48 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        OTP_P1588_ICV1_63_48_mask = &Hffff
        if data_low > LONG_MAX then
            if OTP_P1588_ICV1_63_48_mask = mask then
                read_OTP_P1588_ICV1_63_48_value = data_low
            else
                read_OTP_P1588_ICV1_63_48_value = (data_low - H8000_0000) and OTP_P1588_ICV1_63_48_mask
            end If
        else
            read_OTP_P1588_ICV1_63_48_value = data_low and OTP_P1588_ICV1_63_48_mask
        end If

    End Sub

    Sub write
        If flag_OTP_P1588_ICV1_63_48 = &H0 Then read
        If flag_OTP_P1588_ICV1_63_48 = &H0 Then write_OTP_P1588_ICV1_63_48_value = get_OTP_P1588_ICV1_63_48

        regValue = leftShift((write_OTP_P1588_ICV1_63_48_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        OTP_P1588_ICV1_63_48_mask = &Hffff
        if data_low > LONG_MAX then
            if OTP_P1588_ICV1_63_48_mask = mask then
                read_OTP_P1588_ICV1_63_48_value = data_low
            else
                read_OTP_P1588_ICV1_63_48_value = (data_low - H8000_0000) and OTP_P1588_ICV1_63_48_mask
            end If
        else
            read_OTP_P1588_ICV1_63_48_value = data_low and OTP_P1588_ICV1_63_48_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_OTP_P1588_ICV1_63_48_value = &H0
        flag_OTP_P1588_ICV1_63_48        = &H0
    End Sub
End Class


'' @REGISTER : BRPHY_1G_1PORT_MISC_otp_p1588_icv1_4
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' OTP_P1588_ICV1_79_64                       [15:0]           get_OTP_P1588_ICV1_79_64
''                                                             set_OTP_P1588_ICV1_79_64
''                                                             read_OTP_P1588_ICV1_79_64
''                                                             write_OTP_P1588_ICV1_79_64
''---------------------------------------------------------------------------------
Class REGISTER_BRPHY_1G_1PORT_MISC_otp_p1588_icv1_4
    Private write_OTP_P1588_ICV1_79_64_value
    Private read_OTP_P1588_ICV1_79_64_value
    Private flag_OTP_P1588_ICV1_79_64

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

    Property Get get_OTP_P1588_ICV1_79_64
        get_OTP_P1588_ICV1_79_64 = read_OTP_P1588_ICV1_79_64_value
    End Property

    Property Let set_OTP_P1588_ICV1_79_64(aData)
        write_OTP_P1588_ICV1_79_64_value = aData
        flag_OTP_P1588_ICV1_79_64        = &H1
    End Property

    Property Get read_OTP_P1588_ICV1_79_64
        read
        read_OTP_P1588_ICV1_79_64 = read_OTP_P1588_ICV1_79_64_value
    End Property

    Property Let write_OTP_P1588_ICV1_79_64(aData)
        set_OTP_P1588_ICV1_79_64 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        OTP_P1588_ICV1_79_64_mask = &Hffff
        if data_low > LONG_MAX then
            if OTP_P1588_ICV1_79_64_mask = mask then
                read_OTP_P1588_ICV1_79_64_value = data_low
            else
                read_OTP_P1588_ICV1_79_64_value = (data_low - H8000_0000) and OTP_P1588_ICV1_79_64_mask
            end If
        else
            read_OTP_P1588_ICV1_79_64_value = data_low and OTP_P1588_ICV1_79_64_mask
        end If

    End Sub

    Sub write
        If flag_OTP_P1588_ICV1_79_64 = &H0 Then read
        If flag_OTP_P1588_ICV1_79_64 = &H0 Then write_OTP_P1588_ICV1_79_64_value = get_OTP_P1588_ICV1_79_64

        regValue = leftShift((write_OTP_P1588_ICV1_79_64_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        OTP_P1588_ICV1_79_64_mask = &Hffff
        if data_low > LONG_MAX then
            if OTP_P1588_ICV1_79_64_mask = mask then
                read_OTP_P1588_ICV1_79_64_value = data_low
            else
                read_OTP_P1588_ICV1_79_64_value = (data_low - H8000_0000) and OTP_P1588_ICV1_79_64_mask
            end If
        else
            read_OTP_P1588_ICV1_79_64_value = data_low and OTP_P1588_ICV1_79_64_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_OTP_P1588_ICV1_79_64_value = &H0
        flag_OTP_P1588_ICV1_79_64        = &H0
    End Sub
End Class


'' @REGISTER : BRPHY_1G_1PORT_MISC_otp_p1588_icv1_5
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' OTP_P1588_ICV1_95_80                       [15:0]           get_OTP_P1588_ICV1_95_80
''                                                             set_OTP_P1588_ICV1_95_80
''                                                             read_OTP_P1588_ICV1_95_80
''                                                             write_OTP_P1588_ICV1_95_80
''---------------------------------------------------------------------------------
Class REGISTER_BRPHY_1G_1PORT_MISC_otp_p1588_icv1_5
    Private write_OTP_P1588_ICV1_95_80_value
    Private read_OTP_P1588_ICV1_95_80_value
    Private flag_OTP_P1588_ICV1_95_80

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

    Property Get get_OTP_P1588_ICV1_95_80
        get_OTP_P1588_ICV1_95_80 = read_OTP_P1588_ICV1_95_80_value
    End Property

    Property Let set_OTP_P1588_ICV1_95_80(aData)
        write_OTP_P1588_ICV1_95_80_value = aData
        flag_OTP_P1588_ICV1_95_80        = &H1
    End Property

    Property Get read_OTP_P1588_ICV1_95_80
        read
        read_OTP_P1588_ICV1_95_80 = read_OTP_P1588_ICV1_95_80_value
    End Property

    Property Let write_OTP_P1588_ICV1_95_80(aData)
        set_OTP_P1588_ICV1_95_80 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        OTP_P1588_ICV1_95_80_mask = &Hffff
        if data_low > LONG_MAX then
            if OTP_P1588_ICV1_95_80_mask = mask then
                read_OTP_P1588_ICV1_95_80_value = data_low
            else
                read_OTP_P1588_ICV1_95_80_value = (data_low - H8000_0000) and OTP_P1588_ICV1_95_80_mask
            end If
        else
            read_OTP_P1588_ICV1_95_80_value = data_low and OTP_P1588_ICV1_95_80_mask
        end If

    End Sub

    Sub write
        If flag_OTP_P1588_ICV1_95_80 = &H0 Then read
        If flag_OTP_P1588_ICV1_95_80 = &H0 Then write_OTP_P1588_ICV1_95_80_value = get_OTP_P1588_ICV1_95_80

        regValue = leftShift((write_OTP_P1588_ICV1_95_80_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        OTP_P1588_ICV1_95_80_mask = &Hffff
        if data_low > LONG_MAX then
            if OTP_P1588_ICV1_95_80_mask = mask then
                read_OTP_P1588_ICV1_95_80_value = data_low
            else
                read_OTP_P1588_ICV1_95_80_value = (data_low - H8000_0000) and OTP_P1588_ICV1_95_80_mask
            end If
        else
            read_OTP_P1588_ICV1_95_80_value = data_low and OTP_P1588_ICV1_95_80_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_OTP_P1588_ICV1_95_80_value = &H0
        flag_OTP_P1588_ICV1_95_80        = &H0
    End Sub
End Class


'' @REGISTER : BRPHY_1G_1PORT_MISC_otp_p1588_icv1_6
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' OTP_P1588_ICV1_111_96                      [15:0]           get_OTP_P1588_ICV1_111_96
''                                                             set_OTP_P1588_ICV1_111_96
''                                                             read_OTP_P1588_ICV1_111_96
''                                                             write_OTP_P1588_ICV1_111_96
''---------------------------------------------------------------------------------
Class REGISTER_BRPHY_1G_1PORT_MISC_otp_p1588_icv1_6
    Private write_OTP_P1588_ICV1_111_96_value
    Private read_OTP_P1588_ICV1_111_96_value
    Private flag_OTP_P1588_ICV1_111_96

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H12e
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_OTP_P1588_ICV1_111_96
        get_OTP_P1588_ICV1_111_96 = read_OTP_P1588_ICV1_111_96_value
    End Property

    Property Let set_OTP_P1588_ICV1_111_96(aData)
        write_OTP_P1588_ICV1_111_96_value = aData
        flag_OTP_P1588_ICV1_111_96        = &H1
    End Property

    Property Get read_OTP_P1588_ICV1_111_96
        read
        read_OTP_P1588_ICV1_111_96 = read_OTP_P1588_ICV1_111_96_value
    End Property

    Property Let write_OTP_P1588_ICV1_111_96(aData)
        set_OTP_P1588_ICV1_111_96 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        OTP_P1588_ICV1_111_96_mask = &Hffff
        if data_low > LONG_MAX then
            if OTP_P1588_ICV1_111_96_mask = mask then
                read_OTP_P1588_ICV1_111_96_value = data_low
            else
                read_OTP_P1588_ICV1_111_96_value = (data_low - H8000_0000) and OTP_P1588_ICV1_111_96_mask
            end If
        else
            read_OTP_P1588_ICV1_111_96_value = data_low and OTP_P1588_ICV1_111_96_mask
        end If

    End Sub

    Sub write
        If flag_OTP_P1588_ICV1_111_96 = &H0 Then read
        If flag_OTP_P1588_ICV1_111_96 = &H0 Then write_OTP_P1588_ICV1_111_96_value = get_OTP_P1588_ICV1_111_96

        regValue = leftShift((write_OTP_P1588_ICV1_111_96_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        OTP_P1588_ICV1_111_96_mask = &Hffff
        if data_low > LONG_MAX then
            if OTP_P1588_ICV1_111_96_mask = mask then
                read_OTP_P1588_ICV1_111_96_value = data_low
            else
                read_OTP_P1588_ICV1_111_96_value = (data_low - H8000_0000) and OTP_P1588_ICV1_111_96_mask
            end If
        else
            read_OTP_P1588_ICV1_111_96_value = data_low and OTP_P1588_ICV1_111_96_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_OTP_P1588_ICV1_111_96_value = &H0
        flag_OTP_P1588_ICV1_111_96        = &H0
    End Sub
End Class


'' @REGISTER : BRPHY_1G_1PORT_MISC_otp_p1588_icv1_7
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' OTP_P1588_ICV1_127_112                     [15:0]           get_OTP_P1588_ICV1_127_112
''                                                             set_OTP_P1588_ICV1_127_112
''                                                             read_OTP_P1588_ICV1_127_112
''                                                             write_OTP_P1588_ICV1_127_112
''---------------------------------------------------------------------------------
Class REGISTER_BRPHY_1G_1PORT_MISC_otp_p1588_icv1_7
    Private write_OTP_P1588_ICV1_127_112_value
    Private read_OTP_P1588_ICV1_127_112_value
    Private flag_OTP_P1588_ICV1_127_112

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

    Property Get get_OTP_P1588_ICV1_127_112
        get_OTP_P1588_ICV1_127_112 = read_OTP_P1588_ICV1_127_112_value
    End Property

    Property Let set_OTP_P1588_ICV1_127_112(aData)
        write_OTP_P1588_ICV1_127_112_value = aData
        flag_OTP_P1588_ICV1_127_112        = &H1
    End Property

    Property Get read_OTP_P1588_ICV1_127_112
        read
        read_OTP_P1588_ICV1_127_112 = read_OTP_P1588_ICV1_127_112_value
    End Property

    Property Let write_OTP_P1588_ICV1_127_112(aData)
        set_OTP_P1588_ICV1_127_112 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        OTP_P1588_ICV1_127_112_mask = &Hffff
        if data_low > LONG_MAX then
            if OTP_P1588_ICV1_127_112_mask = mask then
                read_OTP_P1588_ICV1_127_112_value = data_low
            else
                read_OTP_P1588_ICV1_127_112_value = (data_low - H8000_0000) and OTP_P1588_ICV1_127_112_mask
            end If
        else
            read_OTP_P1588_ICV1_127_112_value = data_low and OTP_P1588_ICV1_127_112_mask
        end If

    End Sub

    Sub write
        If flag_OTP_P1588_ICV1_127_112 = &H0 Then read
        If flag_OTP_P1588_ICV1_127_112 = &H0 Then write_OTP_P1588_ICV1_127_112_value = get_OTP_P1588_ICV1_127_112

        regValue = leftShift((write_OTP_P1588_ICV1_127_112_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        OTP_P1588_ICV1_127_112_mask = &Hffff
        if data_low > LONG_MAX then
            if OTP_P1588_ICV1_127_112_mask = mask then
                read_OTP_P1588_ICV1_127_112_value = data_low
            else
                read_OTP_P1588_ICV1_127_112_value = (data_low - H8000_0000) and OTP_P1588_ICV1_127_112_mask
            end If
        else
            read_OTP_P1588_ICV1_127_112_value = data_low and OTP_P1588_ICV1_127_112_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_OTP_P1588_ICV1_127_112_value = &H0
        flag_OTP_P1588_ICV1_127_112        = &H0
    End Sub
End Class


'' @REGISTER : BRPHY_1G_1PORT_MISC_otp_p1588_icv2_0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' OTP_P1588_ICV2_15_0                        [15:0]           get_OTP_P1588_ICV2_15_0
''                                                             set_OTP_P1588_ICV2_15_0
''                                                             read_OTP_P1588_ICV2_15_0
''                                                             write_OTP_P1588_ICV2_15_0
''---------------------------------------------------------------------------------
Class REGISTER_BRPHY_1G_1PORT_MISC_otp_p1588_icv2_0
    Private write_OTP_P1588_ICV2_15_0_value
    Private read_OTP_P1588_ICV2_15_0_value
    Private flag_OTP_P1588_ICV2_15_0

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

    Property Get get_OTP_P1588_ICV2_15_0
        get_OTP_P1588_ICV2_15_0 = read_OTP_P1588_ICV2_15_0_value
    End Property

    Property Let set_OTP_P1588_ICV2_15_0(aData)
        write_OTP_P1588_ICV2_15_0_value = aData
        flag_OTP_P1588_ICV2_15_0        = &H1
    End Property

    Property Get read_OTP_P1588_ICV2_15_0
        read
        read_OTP_P1588_ICV2_15_0 = read_OTP_P1588_ICV2_15_0_value
    End Property

    Property Let write_OTP_P1588_ICV2_15_0(aData)
        set_OTP_P1588_ICV2_15_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        OTP_P1588_ICV2_15_0_mask = &Hffff
        if data_low > LONG_MAX then
            if OTP_P1588_ICV2_15_0_mask = mask then
                read_OTP_P1588_ICV2_15_0_value = data_low
            else
                read_OTP_P1588_ICV2_15_0_value = (data_low - H8000_0000) and OTP_P1588_ICV2_15_0_mask
            end If
        else
            read_OTP_P1588_ICV2_15_0_value = data_low and OTP_P1588_ICV2_15_0_mask
        end If

    End Sub

    Sub write
        If flag_OTP_P1588_ICV2_15_0 = &H0 Then read
        If flag_OTP_P1588_ICV2_15_0 = &H0 Then write_OTP_P1588_ICV2_15_0_value = get_OTP_P1588_ICV2_15_0

        regValue = leftShift((write_OTP_P1588_ICV2_15_0_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        OTP_P1588_ICV2_15_0_mask = &Hffff
        if data_low > LONG_MAX then
            if OTP_P1588_ICV2_15_0_mask = mask then
                read_OTP_P1588_ICV2_15_0_value = data_low
            else
                read_OTP_P1588_ICV2_15_0_value = (data_low - H8000_0000) and OTP_P1588_ICV2_15_0_mask
            end If
        else
            read_OTP_P1588_ICV2_15_0_value = data_low and OTP_P1588_ICV2_15_0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_OTP_P1588_ICV2_15_0_value = &H0
        flag_OTP_P1588_ICV2_15_0        = &H0
    End Sub
End Class


'' @REGISTER : BRPHY_1G_1PORT_MISC_otp_p1588_icv2_1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' OTP_P1588_ICV2_31_16                       [15:0]           get_OTP_P1588_ICV2_31_16
''                                                             set_OTP_P1588_ICV2_31_16
''                                                             read_OTP_P1588_ICV2_31_16
''                                                             write_OTP_P1588_ICV2_31_16
''---------------------------------------------------------------------------------
Class REGISTER_BRPHY_1G_1PORT_MISC_otp_p1588_icv2_1
    Private write_OTP_P1588_ICV2_31_16_value
    Private read_OTP_P1588_ICV2_31_16_value
    Private flag_OTP_P1588_ICV2_31_16

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

    Property Get get_OTP_P1588_ICV2_31_16
        get_OTP_P1588_ICV2_31_16 = read_OTP_P1588_ICV2_31_16_value
    End Property

    Property Let set_OTP_P1588_ICV2_31_16(aData)
        write_OTP_P1588_ICV2_31_16_value = aData
        flag_OTP_P1588_ICV2_31_16        = &H1
    End Property

    Property Get read_OTP_P1588_ICV2_31_16
        read
        read_OTP_P1588_ICV2_31_16 = read_OTP_P1588_ICV2_31_16_value
    End Property

    Property Let write_OTP_P1588_ICV2_31_16(aData)
        set_OTP_P1588_ICV2_31_16 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        OTP_P1588_ICV2_31_16_mask = &Hffff
        if data_low > LONG_MAX then
            if OTP_P1588_ICV2_31_16_mask = mask then
                read_OTP_P1588_ICV2_31_16_value = data_low
            else
                read_OTP_P1588_ICV2_31_16_value = (data_low - H8000_0000) and OTP_P1588_ICV2_31_16_mask
            end If
        else
            read_OTP_P1588_ICV2_31_16_value = data_low and OTP_P1588_ICV2_31_16_mask
        end If

    End Sub

    Sub write
        If flag_OTP_P1588_ICV2_31_16 = &H0 Then read
        If flag_OTP_P1588_ICV2_31_16 = &H0 Then write_OTP_P1588_ICV2_31_16_value = get_OTP_P1588_ICV2_31_16

        regValue = leftShift((write_OTP_P1588_ICV2_31_16_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        OTP_P1588_ICV2_31_16_mask = &Hffff
        if data_low > LONG_MAX then
            if OTP_P1588_ICV2_31_16_mask = mask then
                read_OTP_P1588_ICV2_31_16_value = data_low
            else
                read_OTP_P1588_ICV2_31_16_value = (data_low - H8000_0000) and OTP_P1588_ICV2_31_16_mask
            end If
        else
            read_OTP_P1588_ICV2_31_16_value = data_low and OTP_P1588_ICV2_31_16_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_OTP_P1588_ICV2_31_16_value = &H0
        flag_OTP_P1588_ICV2_31_16        = &H0
    End Sub
End Class


'' @REGISTER : BRPHY_1G_1PORT_MISC_otp_p1588_icv2_2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' OTP_P1588_ICV2_47_32                       [15:0]           get_OTP_P1588_ICV2_47_32
''                                                             set_OTP_P1588_ICV2_47_32
''                                                             read_OTP_P1588_ICV2_47_32
''                                                             write_OTP_P1588_ICV2_47_32
''---------------------------------------------------------------------------------
Class REGISTER_BRPHY_1G_1PORT_MISC_otp_p1588_icv2_2
    Private write_OTP_P1588_ICV2_47_32_value
    Private read_OTP_P1588_ICV2_47_32_value
    Private flag_OTP_P1588_ICV2_47_32

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

    Property Get get_OTP_P1588_ICV2_47_32
        get_OTP_P1588_ICV2_47_32 = read_OTP_P1588_ICV2_47_32_value
    End Property

    Property Let set_OTP_P1588_ICV2_47_32(aData)
        write_OTP_P1588_ICV2_47_32_value = aData
        flag_OTP_P1588_ICV2_47_32        = &H1
    End Property

    Property Get read_OTP_P1588_ICV2_47_32
        read
        read_OTP_P1588_ICV2_47_32 = read_OTP_P1588_ICV2_47_32_value
    End Property

    Property Let write_OTP_P1588_ICV2_47_32(aData)
        set_OTP_P1588_ICV2_47_32 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        OTP_P1588_ICV2_47_32_mask = &Hffff
        if data_low > LONG_MAX then
            if OTP_P1588_ICV2_47_32_mask = mask then
                read_OTP_P1588_ICV2_47_32_value = data_low
            else
                read_OTP_P1588_ICV2_47_32_value = (data_low - H8000_0000) and OTP_P1588_ICV2_47_32_mask
            end If
        else
            read_OTP_P1588_ICV2_47_32_value = data_low and OTP_P1588_ICV2_47_32_mask
        end If

    End Sub

    Sub write
        If flag_OTP_P1588_ICV2_47_32 = &H0 Then read
        If flag_OTP_P1588_ICV2_47_32 = &H0 Then write_OTP_P1588_ICV2_47_32_value = get_OTP_P1588_ICV2_47_32

        regValue = leftShift((write_OTP_P1588_ICV2_47_32_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        OTP_P1588_ICV2_47_32_mask = &Hffff
        if data_low > LONG_MAX then
            if OTP_P1588_ICV2_47_32_mask = mask then
                read_OTP_P1588_ICV2_47_32_value = data_low
            else
                read_OTP_P1588_ICV2_47_32_value = (data_low - H8000_0000) and OTP_P1588_ICV2_47_32_mask
            end If
        else
            read_OTP_P1588_ICV2_47_32_value = data_low and OTP_P1588_ICV2_47_32_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_OTP_P1588_ICV2_47_32_value = &H0
        flag_OTP_P1588_ICV2_47_32        = &H0
    End Sub
End Class


'' @REGISTER : BRPHY_1G_1PORT_MISC_otp_p1588_icv2_3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' OTP_P1588_ICV2_63_48                       [15:0]           get_OTP_P1588_ICV2_63_48
''                                                             set_OTP_P1588_ICV2_63_48
''                                                             read_OTP_P1588_ICV2_63_48
''                                                             write_OTP_P1588_ICV2_63_48
''---------------------------------------------------------------------------------
Class REGISTER_BRPHY_1G_1PORT_MISC_otp_p1588_icv2_3
    Private write_OTP_P1588_ICV2_63_48_value
    Private read_OTP_P1588_ICV2_63_48_value
    Private flag_OTP_P1588_ICV2_63_48

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

    Property Get get_OTP_P1588_ICV2_63_48
        get_OTP_P1588_ICV2_63_48 = read_OTP_P1588_ICV2_63_48_value
    End Property

    Property Let set_OTP_P1588_ICV2_63_48(aData)
        write_OTP_P1588_ICV2_63_48_value = aData
        flag_OTP_P1588_ICV2_63_48        = &H1
    End Property

    Property Get read_OTP_P1588_ICV2_63_48
        read
        read_OTP_P1588_ICV2_63_48 = read_OTP_P1588_ICV2_63_48_value
    End Property

    Property Let write_OTP_P1588_ICV2_63_48(aData)
        set_OTP_P1588_ICV2_63_48 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        OTP_P1588_ICV2_63_48_mask = &Hffff
        if data_low > LONG_MAX then
            if OTP_P1588_ICV2_63_48_mask = mask then
                read_OTP_P1588_ICV2_63_48_value = data_low
            else
                read_OTP_P1588_ICV2_63_48_value = (data_low - H8000_0000) and OTP_P1588_ICV2_63_48_mask
            end If
        else
            read_OTP_P1588_ICV2_63_48_value = data_low and OTP_P1588_ICV2_63_48_mask
        end If

    End Sub

    Sub write
        If flag_OTP_P1588_ICV2_63_48 = &H0 Then read
        If flag_OTP_P1588_ICV2_63_48 = &H0 Then write_OTP_P1588_ICV2_63_48_value = get_OTP_P1588_ICV2_63_48

        regValue = leftShift((write_OTP_P1588_ICV2_63_48_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        OTP_P1588_ICV2_63_48_mask = &Hffff
        if data_low > LONG_MAX then
            if OTP_P1588_ICV2_63_48_mask = mask then
                read_OTP_P1588_ICV2_63_48_value = data_low
            else
                read_OTP_P1588_ICV2_63_48_value = (data_low - H8000_0000) and OTP_P1588_ICV2_63_48_mask
            end If
        else
            read_OTP_P1588_ICV2_63_48_value = data_low and OTP_P1588_ICV2_63_48_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_OTP_P1588_ICV2_63_48_value = &H0
        flag_OTP_P1588_ICV2_63_48        = &H0
    End Sub
End Class


'' @REGISTER : BRPHY_1G_1PORT_MISC_otp_p1588_icv2_4
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' OTP_P1588_ICV2_79_64                       [15:0]           get_OTP_P1588_ICV2_79_64
''                                                             set_OTP_P1588_ICV2_79_64
''                                                             read_OTP_P1588_ICV2_79_64
''                                                             write_OTP_P1588_ICV2_79_64
''---------------------------------------------------------------------------------
Class REGISTER_BRPHY_1G_1PORT_MISC_otp_p1588_icv2_4
    Private write_OTP_P1588_ICV2_79_64_value
    Private read_OTP_P1588_ICV2_79_64_value
    Private flag_OTP_P1588_ICV2_79_64

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

    Property Get get_OTP_P1588_ICV2_79_64
        get_OTP_P1588_ICV2_79_64 = read_OTP_P1588_ICV2_79_64_value
    End Property

    Property Let set_OTP_P1588_ICV2_79_64(aData)
        write_OTP_P1588_ICV2_79_64_value = aData
        flag_OTP_P1588_ICV2_79_64        = &H1
    End Property

    Property Get read_OTP_P1588_ICV2_79_64
        read
        read_OTP_P1588_ICV2_79_64 = read_OTP_P1588_ICV2_79_64_value
    End Property

    Property Let write_OTP_P1588_ICV2_79_64(aData)
        set_OTP_P1588_ICV2_79_64 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        OTP_P1588_ICV2_79_64_mask = &Hffff
        if data_low > LONG_MAX then
            if OTP_P1588_ICV2_79_64_mask = mask then
                read_OTP_P1588_ICV2_79_64_value = data_low
            else
                read_OTP_P1588_ICV2_79_64_value = (data_low - H8000_0000) and OTP_P1588_ICV2_79_64_mask
            end If
        else
            read_OTP_P1588_ICV2_79_64_value = data_low and OTP_P1588_ICV2_79_64_mask
        end If

    End Sub

    Sub write
        If flag_OTP_P1588_ICV2_79_64 = &H0 Then read
        If flag_OTP_P1588_ICV2_79_64 = &H0 Then write_OTP_P1588_ICV2_79_64_value = get_OTP_P1588_ICV2_79_64

        regValue = leftShift((write_OTP_P1588_ICV2_79_64_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        OTP_P1588_ICV2_79_64_mask = &Hffff
        if data_low > LONG_MAX then
            if OTP_P1588_ICV2_79_64_mask = mask then
                read_OTP_P1588_ICV2_79_64_value = data_low
            else
                read_OTP_P1588_ICV2_79_64_value = (data_low - H8000_0000) and OTP_P1588_ICV2_79_64_mask
            end If
        else
            read_OTP_P1588_ICV2_79_64_value = data_low and OTP_P1588_ICV2_79_64_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_OTP_P1588_ICV2_79_64_value = &H0
        flag_OTP_P1588_ICV2_79_64        = &H0
    End Sub
End Class


'' @REGISTER : BRPHY_1G_1PORT_MISC_otp_p1588_icv2_5
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' OTP_P1588_ICV2_95_80                       [15:0]           get_OTP_P1588_ICV2_95_80
''                                                             set_OTP_P1588_ICV2_95_80
''                                                             read_OTP_P1588_ICV2_95_80
''                                                             write_OTP_P1588_ICV2_95_80
''---------------------------------------------------------------------------------
Class REGISTER_BRPHY_1G_1PORT_MISC_otp_p1588_icv2_5
    Private write_OTP_P1588_ICV2_95_80_value
    Private read_OTP_P1588_ICV2_95_80_value
    Private flag_OTP_P1588_ICV2_95_80

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

    Property Get get_OTP_P1588_ICV2_95_80
        get_OTP_P1588_ICV2_95_80 = read_OTP_P1588_ICV2_95_80_value
    End Property

    Property Let set_OTP_P1588_ICV2_95_80(aData)
        write_OTP_P1588_ICV2_95_80_value = aData
        flag_OTP_P1588_ICV2_95_80        = &H1
    End Property

    Property Get read_OTP_P1588_ICV2_95_80
        read
        read_OTP_P1588_ICV2_95_80 = read_OTP_P1588_ICV2_95_80_value
    End Property

    Property Let write_OTP_P1588_ICV2_95_80(aData)
        set_OTP_P1588_ICV2_95_80 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        OTP_P1588_ICV2_95_80_mask = &Hffff
        if data_low > LONG_MAX then
            if OTP_P1588_ICV2_95_80_mask = mask then
                read_OTP_P1588_ICV2_95_80_value = data_low
            else
                read_OTP_P1588_ICV2_95_80_value = (data_low - H8000_0000) and OTP_P1588_ICV2_95_80_mask
            end If
        else
            read_OTP_P1588_ICV2_95_80_value = data_low and OTP_P1588_ICV2_95_80_mask
        end If

    End Sub

    Sub write
        If flag_OTP_P1588_ICV2_95_80 = &H0 Then read
        If flag_OTP_P1588_ICV2_95_80 = &H0 Then write_OTP_P1588_ICV2_95_80_value = get_OTP_P1588_ICV2_95_80

        regValue = leftShift((write_OTP_P1588_ICV2_95_80_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        OTP_P1588_ICV2_95_80_mask = &Hffff
        if data_low > LONG_MAX then
            if OTP_P1588_ICV2_95_80_mask = mask then
                read_OTP_P1588_ICV2_95_80_value = data_low
            else
                read_OTP_P1588_ICV2_95_80_value = (data_low - H8000_0000) and OTP_P1588_ICV2_95_80_mask
            end If
        else
            read_OTP_P1588_ICV2_95_80_value = data_low and OTP_P1588_ICV2_95_80_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_OTP_P1588_ICV2_95_80_value = &H0
        flag_OTP_P1588_ICV2_95_80        = &H0
    End Sub
End Class


'' @REGISTER : BRPHY_1G_1PORT_MISC_otp_p1588_icv2_6
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' OTP_P1588_ICV2_111_96                      [15:0]           get_OTP_P1588_ICV2_111_96
''                                                             set_OTP_P1588_ICV2_111_96
''                                                             read_OTP_P1588_ICV2_111_96
''                                                             write_OTP_P1588_ICV2_111_96
''---------------------------------------------------------------------------------
Class REGISTER_BRPHY_1G_1PORT_MISC_otp_p1588_icv2_6
    Private write_OTP_P1588_ICV2_111_96_value
    Private read_OTP_P1588_ICV2_111_96_value
    Private flag_OTP_P1588_ICV2_111_96

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H13e
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_OTP_P1588_ICV2_111_96
        get_OTP_P1588_ICV2_111_96 = read_OTP_P1588_ICV2_111_96_value
    End Property

    Property Let set_OTP_P1588_ICV2_111_96(aData)
        write_OTP_P1588_ICV2_111_96_value = aData
        flag_OTP_P1588_ICV2_111_96        = &H1
    End Property

    Property Get read_OTP_P1588_ICV2_111_96
        read
        read_OTP_P1588_ICV2_111_96 = read_OTP_P1588_ICV2_111_96_value
    End Property

    Property Let write_OTP_P1588_ICV2_111_96(aData)
        set_OTP_P1588_ICV2_111_96 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        OTP_P1588_ICV2_111_96_mask = &Hffff
        if data_low > LONG_MAX then
            if OTP_P1588_ICV2_111_96_mask = mask then
                read_OTP_P1588_ICV2_111_96_value = data_low
            else
                read_OTP_P1588_ICV2_111_96_value = (data_low - H8000_0000) and OTP_P1588_ICV2_111_96_mask
            end If
        else
            read_OTP_P1588_ICV2_111_96_value = data_low and OTP_P1588_ICV2_111_96_mask
        end If

    End Sub

    Sub write
        If flag_OTP_P1588_ICV2_111_96 = &H0 Then read
        If flag_OTP_P1588_ICV2_111_96 = &H0 Then write_OTP_P1588_ICV2_111_96_value = get_OTP_P1588_ICV2_111_96

        regValue = leftShift((write_OTP_P1588_ICV2_111_96_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        OTP_P1588_ICV2_111_96_mask = &Hffff
        if data_low > LONG_MAX then
            if OTP_P1588_ICV2_111_96_mask = mask then
                read_OTP_P1588_ICV2_111_96_value = data_low
            else
                read_OTP_P1588_ICV2_111_96_value = (data_low - H8000_0000) and OTP_P1588_ICV2_111_96_mask
            end If
        else
            read_OTP_P1588_ICV2_111_96_value = data_low and OTP_P1588_ICV2_111_96_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_OTP_P1588_ICV2_111_96_value = &H0
        flag_OTP_P1588_ICV2_111_96        = &H0
    End Sub
End Class


'' @REGISTER : BRPHY_1G_1PORT_MISC_otp_p1588_icv2_7
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' OTP_P1588_ICV2_127_112                     [15:0]           get_OTP_P1588_ICV2_127_112
''                                                             set_OTP_P1588_ICV2_127_112
''                                                             read_OTP_P1588_ICV2_127_112
''                                                             write_OTP_P1588_ICV2_127_112
''---------------------------------------------------------------------------------
Class REGISTER_BRPHY_1G_1PORT_MISC_otp_p1588_icv2_7
    Private write_OTP_P1588_ICV2_127_112_value
    Private read_OTP_P1588_ICV2_127_112_value
    Private flag_OTP_P1588_ICV2_127_112

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

    Property Get get_OTP_P1588_ICV2_127_112
        get_OTP_P1588_ICV2_127_112 = read_OTP_P1588_ICV2_127_112_value
    End Property

    Property Let set_OTP_P1588_ICV2_127_112(aData)
        write_OTP_P1588_ICV2_127_112_value = aData
        flag_OTP_P1588_ICV2_127_112        = &H1
    End Property

    Property Get read_OTP_P1588_ICV2_127_112
        read
        read_OTP_P1588_ICV2_127_112 = read_OTP_P1588_ICV2_127_112_value
    End Property

    Property Let write_OTP_P1588_ICV2_127_112(aData)
        set_OTP_P1588_ICV2_127_112 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        OTP_P1588_ICV2_127_112_mask = &Hffff
        if data_low > LONG_MAX then
            if OTP_P1588_ICV2_127_112_mask = mask then
                read_OTP_P1588_ICV2_127_112_value = data_low
            else
                read_OTP_P1588_ICV2_127_112_value = (data_low - H8000_0000) and OTP_P1588_ICV2_127_112_mask
            end If
        else
            read_OTP_P1588_ICV2_127_112_value = data_low and OTP_P1588_ICV2_127_112_mask
        end If

    End Sub

    Sub write
        If flag_OTP_P1588_ICV2_127_112 = &H0 Then read
        If flag_OTP_P1588_ICV2_127_112 = &H0 Then write_OTP_P1588_ICV2_127_112_value = get_OTP_P1588_ICV2_127_112

        regValue = leftShift((write_OTP_P1588_ICV2_127_112_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        OTP_P1588_ICV2_127_112_mask = &Hffff
        if data_low > LONG_MAX then
            if OTP_P1588_ICV2_127_112_mask = mask then
                read_OTP_P1588_ICV2_127_112_value = data_low
            else
                read_OTP_P1588_ICV2_127_112_value = (data_low - H8000_0000) and OTP_P1588_ICV2_127_112_mask
            end If
        else
            read_OTP_P1588_ICV2_127_112_value = data_low and OTP_P1588_ICV2_127_112_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_OTP_P1588_ICV2_127_112_value = &H0
        flag_OTP_P1588_ICV2_127_112        = &H0
    End Sub
End Class


'' @REGISTER : BRPHY_1G_1PORT_MISC_otp_p1588_icv3_0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' OTP_P1588_ICV3_15_0                        [15:0]           get_OTP_P1588_ICV3_15_0
''                                                             set_OTP_P1588_ICV3_15_0
''                                                             read_OTP_P1588_ICV3_15_0
''                                                             write_OTP_P1588_ICV3_15_0
''---------------------------------------------------------------------------------
Class REGISTER_BRPHY_1G_1PORT_MISC_otp_p1588_icv3_0
    Private write_OTP_P1588_ICV3_15_0_value
    Private read_OTP_P1588_ICV3_15_0_value
    Private flag_OTP_P1588_ICV3_15_0

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

    Property Get get_OTP_P1588_ICV3_15_0
        get_OTP_P1588_ICV3_15_0 = read_OTP_P1588_ICV3_15_0_value
    End Property

    Property Let set_OTP_P1588_ICV3_15_0(aData)
        write_OTP_P1588_ICV3_15_0_value = aData
        flag_OTP_P1588_ICV3_15_0        = &H1
    End Property

    Property Get read_OTP_P1588_ICV3_15_0
        read
        read_OTP_P1588_ICV3_15_0 = read_OTP_P1588_ICV3_15_0_value
    End Property

    Property Let write_OTP_P1588_ICV3_15_0(aData)
        set_OTP_P1588_ICV3_15_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        OTP_P1588_ICV3_15_0_mask = &Hffff
        if data_low > LONG_MAX then
            if OTP_P1588_ICV3_15_0_mask = mask then
                read_OTP_P1588_ICV3_15_0_value = data_low
            else
                read_OTP_P1588_ICV3_15_0_value = (data_low - H8000_0000) and OTP_P1588_ICV3_15_0_mask
            end If
        else
            read_OTP_P1588_ICV3_15_0_value = data_low and OTP_P1588_ICV3_15_0_mask
        end If

    End Sub

    Sub write
        If flag_OTP_P1588_ICV3_15_0 = &H0 Then read
        If flag_OTP_P1588_ICV3_15_0 = &H0 Then write_OTP_P1588_ICV3_15_0_value = get_OTP_P1588_ICV3_15_0

        regValue = leftShift((write_OTP_P1588_ICV3_15_0_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        OTP_P1588_ICV3_15_0_mask = &Hffff
        if data_low > LONG_MAX then
            if OTP_P1588_ICV3_15_0_mask = mask then
                read_OTP_P1588_ICV3_15_0_value = data_low
            else
                read_OTP_P1588_ICV3_15_0_value = (data_low - H8000_0000) and OTP_P1588_ICV3_15_0_mask
            end If
        else
            read_OTP_P1588_ICV3_15_0_value = data_low and OTP_P1588_ICV3_15_0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_OTP_P1588_ICV3_15_0_value = &H0
        flag_OTP_P1588_ICV3_15_0        = &H0
    End Sub
End Class


'' @REGISTER : BRPHY_1G_1PORT_MISC_otp_p1588_icv3_1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' OTP_P1588_ICV3_31_16                       [15:0]           get_OTP_P1588_ICV3_31_16
''                                                             set_OTP_P1588_ICV3_31_16
''                                                             read_OTP_P1588_ICV3_31_16
''                                                             write_OTP_P1588_ICV3_31_16
''---------------------------------------------------------------------------------
Class REGISTER_BRPHY_1G_1PORT_MISC_otp_p1588_icv3_1
    Private write_OTP_P1588_ICV3_31_16_value
    Private read_OTP_P1588_ICV3_31_16_value
    Private flag_OTP_P1588_ICV3_31_16

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

    Property Get get_OTP_P1588_ICV3_31_16
        get_OTP_P1588_ICV3_31_16 = read_OTP_P1588_ICV3_31_16_value
    End Property

    Property Let set_OTP_P1588_ICV3_31_16(aData)
        write_OTP_P1588_ICV3_31_16_value = aData
        flag_OTP_P1588_ICV3_31_16        = &H1
    End Property

    Property Get read_OTP_P1588_ICV3_31_16
        read
        read_OTP_P1588_ICV3_31_16 = read_OTP_P1588_ICV3_31_16_value
    End Property

    Property Let write_OTP_P1588_ICV3_31_16(aData)
        set_OTP_P1588_ICV3_31_16 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        OTP_P1588_ICV3_31_16_mask = &Hffff
        if data_low > LONG_MAX then
            if OTP_P1588_ICV3_31_16_mask = mask then
                read_OTP_P1588_ICV3_31_16_value = data_low
            else
                read_OTP_P1588_ICV3_31_16_value = (data_low - H8000_0000) and OTP_P1588_ICV3_31_16_mask
            end If
        else
            read_OTP_P1588_ICV3_31_16_value = data_low and OTP_P1588_ICV3_31_16_mask
        end If

    End Sub

    Sub write
        If flag_OTP_P1588_ICV3_31_16 = &H0 Then read
        If flag_OTP_P1588_ICV3_31_16 = &H0 Then write_OTP_P1588_ICV3_31_16_value = get_OTP_P1588_ICV3_31_16

        regValue = leftShift((write_OTP_P1588_ICV3_31_16_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        OTP_P1588_ICV3_31_16_mask = &Hffff
        if data_low > LONG_MAX then
            if OTP_P1588_ICV3_31_16_mask = mask then
                read_OTP_P1588_ICV3_31_16_value = data_low
            else
                read_OTP_P1588_ICV3_31_16_value = (data_low - H8000_0000) and OTP_P1588_ICV3_31_16_mask
            end If
        else
            read_OTP_P1588_ICV3_31_16_value = data_low and OTP_P1588_ICV3_31_16_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_OTP_P1588_ICV3_31_16_value = &H0
        flag_OTP_P1588_ICV3_31_16        = &H0
    End Sub
End Class


'' @REGISTER : BRPHY_1G_1PORT_MISC_otp_p1588_icv3_2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' OTP_P1588_ICV3_47_32                       [15:0]           get_OTP_P1588_ICV3_47_32
''                                                             set_OTP_P1588_ICV3_47_32
''                                                             read_OTP_P1588_ICV3_47_32
''                                                             write_OTP_P1588_ICV3_47_32
''---------------------------------------------------------------------------------
Class REGISTER_BRPHY_1G_1PORT_MISC_otp_p1588_icv3_2
    Private write_OTP_P1588_ICV3_47_32_value
    Private read_OTP_P1588_ICV3_47_32_value
    Private flag_OTP_P1588_ICV3_47_32

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

    Property Get get_OTP_P1588_ICV3_47_32
        get_OTP_P1588_ICV3_47_32 = read_OTP_P1588_ICV3_47_32_value
    End Property

    Property Let set_OTP_P1588_ICV3_47_32(aData)
        write_OTP_P1588_ICV3_47_32_value = aData
        flag_OTP_P1588_ICV3_47_32        = &H1
    End Property

    Property Get read_OTP_P1588_ICV3_47_32
        read
        read_OTP_P1588_ICV3_47_32 = read_OTP_P1588_ICV3_47_32_value
    End Property

    Property Let write_OTP_P1588_ICV3_47_32(aData)
        set_OTP_P1588_ICV3_47_32 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        OTP_P1588_ICV3_47_32_mask = &Hffff
        if data_low > LONG_MAX then
            if OTP_P1588_ICV3_47_32_mask = mask then
                read_OTP_P1588_ICV3_47_32_value = data_low
            else
                read_OTP_P1588_ICV3_47_32_value = (data_low - H8000_0000) and OTP_P1588_ICV3_47_32_mask
            end If
        else
            read_OTP_P1588_ICV3_47_32_value = data_low and OTP_P1588_ICV3_47_32_mask
        end If

    End Sub

    Sub write
        If flag_OTP_P1588_ICV3_47_32 = &H0 Then read
        If flag_OTP_P1588_ICV3_47_32 = &H0 Then write_OTP_P1588_ICV3_47_32_value = get_OTP_P1588_ICV3_47_32

        regValue = leftShift((write_OTP_P1588_ICV3_47_32_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        OTP_P1588_ICV3_47_32_mask = &Hffff
        if data_low > LONG_MAX then
            if OTP_P1588_ICV3_47_32_mask = mask then
                read_OTP_P1588_ICV3_47_32_value = data_low
            else
                read_OTP_P1588_ICV3_47_32_value = (data_low - H8000_0000) and OTP_P1588_ICV3_47_32_mask
            end If
        else
            read_OTP_P1588_ICV3_47_32_value = data_low and OTP_P1588_ICV3_47_32_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_OTP_P1588_ICV3_47_32_value = &H0
        flag_OTP_P1588_ICV3_47_32        = &H0
    End Sub
End Class


'' @REGISTER : BRPHY_1G_1PORT_MISC_otp_p1588_icv3_3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' OTP_P1588_ICV3_63_48                       [15:0]           get_OTP_P1588_ICV3_63_48
''                                                             set_OTP_P1588_ICV3_63_48
''                                                             read_OTP_P1588_ICV3_63_48
''                                                             write_OTP_P1588_ICV3_63_48
''---------------------------------------------------------------------------------
Class REGISTER_BRPHY_1G_1PORT_MISC_otp_p1588_icv3_3
    Private write_OTP_P1588_ICV3_63_48_value
    Private read_OTP_P1588_ICV3_63_48_value
    Private flag_OTP_P1588_ICV3_63_48

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

    Property Get get_OTP_P1588_ICV3_63_48
        get_OTP_P1588_ICV3_63_48 = read_OTP_P1588_ICV3_63_48_value
    End Property

    Property Let set_OTP_P1588_ICV3_63_48(aData)
        write_OTP_P1588_ICV3_63_48_value = aData
        flag_OTP_P1588_ICV3_63_48        = &H1
    End Property

    Property Get read_OTP_P1588_ICV3_63_48
        read
        read_OTP_P1588_ICV3_63_48 = read_OTP_P1588_ICV3_63_48_value
    End Property

    Property Let write_OTP_P1588_ICV3_63_48(aData)
        set_OTP_P1588_ICV3_63_48 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        OTP_P1588_ICV3_63_48_mask = &Hffff
        if data_low > LONG_MAX then
            if OTP_P1588_ICV3_63_48_mask = mask then
                read_OTP_P1588_ICV3_63_48_value = data_low
            else
                read_OTP_P1588_ICV3_63_48_value = (data_low - H8000_0000) and OTP_P1588_ICV3_63_48_mask
            end If
        else
            read_OTP_P1588_ICV3_63_48_value = data_low and OTP_P1588_ICV3_63_48_mask
        end If

    End Sub

    Sub write
        If flag_OTP_P1588_ICV3_63_48 = &H0 Then read
        If flag_OTP_P1588_ICV3_63_48 = &H0 Then write_OTP_P1588_ICV3_63_48_value = get_OTP_P1588_ICV3_63_48

        regValue = leftShift((write_OTP_P1588_ICV3_63_48_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        OTP_P1588_ICV3_63_48_mask = &Hffff
        if data_low > LONG_MAX then
            if OTP_P1588_ICV3_63_48_mask = mask then
                read_OTP_P1588_ICV3_63_48_value = data_low
            else
                read_OTP_P1588_ICV3_63_48_value = (data_low - H8000_0000) and OTP_P1588_ICV3_63_48_mask
            end If
        else
            read_OTP_P1588_ICV3_63_48_value = data_low and OTP_P1588_ICV3_63_48_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_OTP_P1588_ICV3_63_48_value = &H0
        flag_OTP_P1588_ICV3_63_48        = &H0
    End Sub
End Class


'' @REGISTER : BRPHY_1G_1PORT_MISC_otp_p1588_icv3_4
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' OTP_P1588_ICV3_79_64                       [15:0]           get_OTP_P1588_ICV3_79_64
''                                                             set_OTP_P1588_ICV3_79_64
''                                                             read_OTP_P1588_ICV3_79_64
''                                                             write_OTP_P1588_ICV3_79_64
''---------------------------------------------------------------------------------
Class REGISTER_BRPHY_1G_1PORT_MISC_otp_p1588_icv3_4
    Private write_OTP_P1588_ICV3_79_64_value
    Private read_OTP_P1588_ICV3_79_64_value
    Private flag_OTP_P1588_ICV3_79_64

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

    Property Get get_OTP_P1588_ICV3_79_64
        get_OTP_P1588_ICV3_79_64 = read_OTP_P1588_ICV3_79_64_value
    End Property

    Property Let set_OTP_P1588_ICV3_79_64(aData)
        write_OTP_P1588_ICV3_79_64_value = aData
        flag_OTP_P1588_ICV3_79_64        = &H1
    End Property

    Property Get read_OTP_P1588_ICV3_79_64
        read
        read_OTP_P1588_ICV3_79_64 = read_OTP_P1588_ICV3_79_64_value
    End Property

    Property Let write_OTP_P1588_ICV3_79_64(aData)
        set_OTP_P1588_ICV3_79_64 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        OTP_P1588_ICV3_79_64_mask = &Hffff
        if data_low > LONG_MAX then
            if OTP_P1588_ICV3_79_64_mask = mask then
                read_OTP_P1588_ICV3_79_64_value = data_low
            else
                read_OTP_P1588_ICV3_79_64_value = (data_low - H8000_0000) and OTP_P1588_ICV3_79_64_mask
            end If
        else
            read_OTP_P1588_ICV3_79_64_value = data_low and OTP_P1588_ICV3_79_64_mask
        end If

    End Sub

    Sub write
        If flag_OTP_P1588_ICV3_79_64 = &H0 Then read
        If flag_OTP_P1588_ICV3_79_64 = &H0 Then write_OTP_P1588_ICV3_79_64_value = get_OTP_P1588_ICV3_79_64

        regValue = leftShift((write_OTP_P1588_ICV3_79_64_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        OTP_P1588_ICV3_79_64_mask = &Hffff
        if data_low > LONG_MAX then
            if OTP_P1588_ICV3_79_64_mask = mask then
                read_OTP_P1588_ICV3_79_64_value = data_low
            else
                read_OTP_P1588_ICV3_79_64_value = (data_low - H8000_0000) and OTP_P1588_ICV3_79_64_mask
            end If
        else
            read_OTP_P1588_ICV3_79_64_value = data_low and OTP_P1588_ICV3_79_64_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_OTP_P1588_ICV3_79_64_value = &H0
        flag_OTP_P1588_ICV3_79_64        = &H0
    End Sub
End Class


'' @REGISTER : BRPHY_1G_1PORT_MISC_otp_p1588_icv3_5
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' OTP_P1588_ICV3_95_80                       [15:0]           get_OTP_P1588_ICV3_95_80
''                                                             set_OTP_P1588_ICV3_95_80
''                                                             read_OTP_P1588_ICV3_95_80
''                                                             write_OTP_P1588_ICV3_95_80
''---------------------------------------------------------------------------------
Class REGISTER_BRPHY_1G_1PORT_MISC_otp_p1588_icv3_5
    Private write_OTP_P1588_ICV3_95_80_value
    Private read_OTP_P1588_ICV3_95_80_value
    Private flag_OTP_P1588_ICV3_95_80

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

    Property Get get_OTP_P1588_ICV3_95_80
        get_OTP_P1588_ICV3_95_80 = read_OTP_P1588_ICV3_95_80_value
    End Property

    Property Let set_OTP_P1588_ICV3_95_80(aData)
        write_OTP_P1588_ICV3_95_80_value = aData
        flag_OTP_P1588_ICV3_95_80        = &H1
    End Property

    Property Get read_OTP_P1588_ICV3_95_80
        read
        read_OTP_P1588_ICV3_95_80 = read_OTP_P1588_ICV3_95_80_value
    End Property

    Property Let write_OTP_P1588_ICV3_95_80(aData)
        set_OTP_P1588_ICV3_95_80 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        OTP_P1588_ICV3_95_80_mask = &Hffff
        if data_low > LONG_MAX then
            if OTP_P1588_ICV3_95_80_mask = mask then
                read_OTP_P1588_ICV3_95_80_value = data_low
            else
                read_OTP_P1588_ICV3_95_80_value = (data_low - H8000_0000) and OTP_P1588_ICV3_95_80_mask
            end If
        else
            read_OTP_P1588_ICV3_95_80_value = data_low and OTP_P1588_ICV3_95_80_mask
        end If

    End Sub

    Sub write
        If flag_OTP_P1588_ICV3_95_80 = &H0 Then read
        If flag_OTP_P1588_ICV3_95_80 = &H0 Then write_OTP_P1588_ICV3_95_80_value = get_OTP_P1588_ICV3_95_80

        regValue = leftShift((write_OTP_P1588_ICV3_95_80_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        OTP_P1588_ICV3_95_80_mask = &Hffff
        if data_low > LONG_MAX then
            if OTP_P1588_ICV3_95_80_mask = mask then
                read_OTP_P1588_ICV3_95_80_value = data_low
            else
                read_OTP_P1588_ICV3_95_80_value = (data_low - H8000_0000) and OTP_P1588_ICV3_95_80_mask
            end If
        else
            read_OTP_P1588_ICV3_95_80_value = data_low and OTP_P1588_ICV3_95_80_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_OTP_P1588_ICV3_95_80_value = &H0
        flag_OTP_P1588_ICV3_95_80        = &H0
    End Sub
End Class


'' @REGISTER : BRPHY_1G_1PORT_MISC_otp_p1588_icv3_6
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' OTP_P1588_ICV3_111_96                      [15:0]           get_OTP_P1588_ICV3_111_96
''                                                             set_OTP_P1588_ICV3_111_96
''                                                             read_OTP_P1588_ICV3_111_96
''                                                             write_OTP_P1588_ICV3_111_96
''---------------------------------------------------------------------------------
Class REGISTER_BRPHY_1G_1PORT_MISC_otp_p1588_icv3_6
    Private write_OTP_P1588_ICV3_111_96_value
    Private read_OTP_P1588_ICV3_111_96_value
    Private flag_OTP_P1588_ICV3_111_96

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H14e
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_OTP_P1588_ICV3_111_96
        get_OTP_P1588_ICV3_111_96 = read_OTP_P1588_ICV3_111_96_value
    End Property

    Property Let set_OTP_P1588_ICV3_111_96(aData)
        write_OTP_P1588_ICV3_111_96_value = aData
        flag_OTP_P1588_ICV3_111_96        = &H1
    End Property

    Property Get read_OTP_P1588_ICV3_111_96
        read
        read_OTP_P1588_ICV3_111_96 = read_OTP_P1588_ICV3_111_96_value
    End Property

    Property Let write_OTP_P1588_ICV3_111_96(aData)
        set_OTP_P1588_ICV3_111_96 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        OTP_P1588_ICV3_111_96_mask = &Hffff
        if data_low > LONG_MAX then
            if OTP_P1588_ICV3_111_96_mask = mask then
                read_OTP_P1588_ICV3_111_96_value = data_low
            else
                read_OTP_P1588_ICV3_111_96_value = (data_low - H8000_0000) and OTP_P1588_ICV3_111_96_mask
            end If
        else
            read_OTP_P1588_ICV3_111_96_value = data_low and OTP_P1588_ICV3_111_96_mask
        end If

    End Sub

    Sub write
        If flag_OTP_P1588_ICV3_111_96 = &H0 Then read
        If flag_OTP_P1588_ICV3_111_96 = &H0 Then write_OTP_P1588_ICV3_111_96_value = get_OTP_P1588_ICV3_111_96

        regValue = leftShift((write_OTP_P1588_ICV3_111_96_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        OTP_P1588_ICV3_111_96_mask = &Hffff
        if data_low > LONG_MAX then
            if OTP_P1588_ICV3_111_96_mask = mask then
                read_OTP_P1588_ICV3_111_96_value = data_low
            else
                read_OTP_P1588_ICV3_111_96_value = (data_low - H8000_0000) and OTP_P1588_ICV3_111_96_mask
            end If
        else
            read_OTP_P1588_ICV3_111_96_value = data_low and OTP_P1588_ICV3_111_96_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_OTP_P1588_ICV3_111_96_value = &H0
        flag_OTP_P1588_ICV3_111_96        = &H0
    End Sub
End Class


'' @REGISTER : BRPHY_1G_1PORT_MISC_otp_p1588_icv3_7
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' OTP_P1588_ICV3_127_112                     [15:0]           get_OTP_P1588_ICV3_127_112
''                                                             set_OTP_P1588_ICV3_127_112
''                                                             read_OTP_P1588_ICV3_127_112
''                                                             write_OTP_P1588_ICV3_127_112
''---------------------------------------------------------------------------------
Class REGISTER_BRPHY_1G_1PORT_MISC_otp_p1588_icv3_7
    Private write_OTP_P1588_ICV3_127_112_value
    Private read_OTP_P1588_ICV3_127_112_value
    Private flag_OTP_P1588_ICV3_127_112

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

    Property Get get_OTP_P1588_ICV3_127_112
        get_OTP_P1588_ICV3_127_112 = read_OTP_P1588_ICV3_127_112_value
    End Property

    Property Let set_OTP_P1588_ICV3_127_112(aData)
        write_OTP_P1588_ICV3_127_112_value = aData
        flag_OTP_P1588_ICV3_127_112        = &H1
    End Property

    Property Get read_OTP_P1588_ICV3_127_112
        read
        read_OTP_P1588_ICV3_127_112 = read_OTP_P1588_ICV3_127_112_value
    End Property

    Property Let write_OTP_P1588_ICV3_127_112(aData)
        set_OTP_P1588_ICV3_127_112 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        OTP_P1588_ICV3_127_112_mask = &Hffff
        if data_low > LONG_MAX then
            if OTP_P1588_ICV3_127_112_mask = mask then
                read_OTP_P1588_ICV3_127_112_value = data_low
            else
                read_OTP_P1588_ICV3_127_112_value = (data_low - H8000_0000) and OTP_P1588_ICV3_127_112_mask
            end If
        else
            read_OTP_P1588_ICV3_127_112_value = data_low and OTP_P1588_ICV3_127_112_mask
        end If

    End Sub

    Sub write
        If flag_OTP_P1588_ICV3_127_112 = &H0 Then read
        If flag_OTP_P1588_ICV3_127_112 = &H0 Then write_OTP_P1588_ICV3_127_112_value = get_OTP_P1588_ICV3_127_112

        regValue = leftShift((write_OTP_P1588_ICV3_127_112_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        OTP_P1588_ICV3_127_112_mask = &Hffff
        if data_low > LONG_MAX then
            if OTP_P1588_ICV3_127_112_mask = mask then
                read_OTP_P1588_ICV3_127_112_value = data_low
            else
                read_OTP_P1588_ICV3_127_112_value = (data_low - H8000_0000) and OTP_P1588_ICV3_127_112_mask
            end If
        else
            read_OTP_P1588_ICV3_127_112_value = data_low and OTP_P1588_ICV3_127_112_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_OTP_P1588_ICV3_127_112_value = &H0
        flag_OTP_P1588_ICV3_127_112        = &H0
    End Sub
End Class


'' @REGISTER : BRPHY_1G_1PORT_MISC_otp_p1588_icv4_0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' OTP_P1588_ICV4_15_0                        [15:0]           get_OTP_P1588_ICV4_15_0
''                                                             set_OTP_P1588_ICV4_15_0
''                                                             read_OTP_P1588_ICV4_15_0
''                                                             write_OTP_P1588_ICV4_15_0
''---------------------------------------------------------------------------------
Class REGISTER_BRPHY_1G_1PORT_MISC_otp_p1588_icv4_0
    Private write_OTP_P1588_ICV4_15_0_value
    Private read_OTP_P1588_ICV4_15_0_value
    Private flag_OTP_P1588_ICV4_15_0

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

    Property Get get_OTP_P1588_ICV4_15_0
        get_OTP_P1588_ICV4_15_0 = read_OTP_P1588_ICV4_15_0_value
    End Property

    Property Let set_OTP_P1588_ICV4_15_0(aData)
        write_OTP_P1588_ICV4_15_0_value = aData
        flag_OTP_P1588_ICV4_15_0        = &H1
    End Property

    Property Get read_OTP_P1588_ICV4_15_0
        read
        read_OTP_P1588_ICV4_15_0 = read_OTP_P1588_ICV4_15_0_value
    End Property

    Property Let write_OTP_P1588_ICV4_15_0(aData)
        set_OTP_P1588_ICV4_15_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        OTP_P1588_ICV4_15_0_mask = &Hffff
        if data_low > LONG_MAX then
            if OTP_P1588_ICV4_15_0_mask = mask then
                read_OTP_P1588_ICV4_15_0_value = data_low
            else
                read_OTP_P1588_ICV4_15_0_value = (data_low - H8000_0000) and OTP_P1588_ICV4_15_0_mask
            end If
        else
            read_OTP_P1588_ICV4_15_0_value = data_low and OTP_P1588_ICV4_15_0_mask
        end If

    End Sub

    Sub write
        If flag_OTP_P1588_ICV4_15_0 = &H0 Then read
        If flag_OTP_P1588_ICV4_15_0 = &H0 Then write_OTP_P1588_ICV4_15_0_value = get_OTP_P1588_ICV4_15_0

        regValue = leftShift((write_OTP_P1588_ICV4_15_0_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        OTP_P1588_ICV4_15_0_mask = &Hffff
        if data_low > LONG_MAX then
            if OTP_P1588_ICV4_15_0_mask = mask then
                read_OTP_P1588_ICV4_15_0_value = data_low
            else
                read_OTP_P1588_ICV4_15_0_value = (data_low - H8000_0000) and OTP_P1588_ICV4_15_0_mask
            end If
        else
            read_OTP_P1588_ICV4_15_0_value = data_low and OTP_P1588_ICV4_15_0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_OTP_P1588_ICV4_15_0_value = &H0
        flag_OTP_P1588_ICV4_15_0        = &H0
    End Sub
End Class


'' @REGISTER : BRPHY_1G_1PORT_MISC_otp_p1588_icv4_1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' OTP_P1588_ICV4_31_16                       [15:0]           get_OTP_P1588_ICV4_31_16
''                                                             set_OTP_P1588_ICV4_31_16
''                                                             read_OTP_P1588_ICV4_31_16
''                                                             write_OTP_P1588_ICV4_31_16
''---------------------------------------------------------------------------------
Class REGISTER_BRPHY_1G_1PORT_MISC_otp_p1588_icv4_1
    Private write_OTP_P1588_ICV4_31_16_value
    Private read_OTP_P1588_ICV4_31_16_value
    Private flag_OTP_P1588_ICV4_31_16

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

    Property Get get_OTP_P1588_ICV4_31_16
        get_OTP_P1588_ICV4_31_16 = read_OTP_P1588_ICV4_31_16_value
    End Property

    Property Let set_OTP_P1588_ICV4_31_16(aData)
        write_OTP_P1588_ICV4_31_16_value = aData
        flag_OTP_P1588_ICV4_31_16        = &H1
    End Property

    Property Get read_OTP_P1588_ICV4_31_16
        read
        read_OTP_P1588_ICV4_31_16 = read_OTP_P1588_ICV4_31_16_value
    End Property

    Property Let write_OTP_P1588_ICV4_31_16(aData)
        set_OTP_P1588_ICV4_31_16 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        OTP_P1588_ICV4_31_16_mask = &Hffff
        if data_low > LONG_MAX then
            if OTP_P1588_ICV4_31_16_mask = mask then
                read_OTP_P1588_ICV4_31_16_value = data_low
            else
                read_OTP_P1588_ICV4_31_16_value = (data_low - H8000_0000) and OTP_P1588_ICV4_31_16_mask
            end If
        else
            read_OTP_P1588_ICV4_31_16_value = data_low and OTP_P1588_ICV4_31_16_mask
        end If

    End Sub

    Sub write
        If flag_OTP_P1588_ICV4_31_16 = &H0 Then read
        If flag_OTP_P1588_ICV4_31_16 = &H0 Then write_OTP_P1588_ICV4_31_16_value = get_OTP_P1588_ICV4_31_16

        regValue = leftShift((write_OTP_P1588_ICV4_31_16_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        OTP_P1588_ICV4_31_16_mask = &Hffff
        if data_low > LONG_MAX then
            if OTP_P1588_ICV4_31_16_mask = mask then
                read_OTP_P1588_ICV4_31_16_value = data_low
            else
                read_OTP_P1588_ICV4_31_16_value = (data_low - H8000_0000) and OTP_P1588_ICV4_31_16_mask
            end If
        else
            read_OTP_P1588_ICV4_31_16_value = data_low and OTP_P1588_ICV4_31_16_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_OTP_P1588_ICV4_31_16_value = &H0
        flag_OTP_P1588_ICV4_31_16        = &H0
    End Sub
End Class


'' @REGISTER : BRPHY_1G_1PORT_MISC_otp_p1588_icv4_2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' OTP_P1588_ICV4_47_32                       [15:0]           get_OTP_P1588_ICV4_47_32
''                                                             set_OTP_P1588_ICV4_47_32
''                                                             read_OTP_P1588_ICV4_47_32
''                                                             write_OTP_P1588_ICV4_47_32
''---------------------------------------------------------------------------------
Class REGISTER_BRPHY_1G_1PORT_MISC_otp_p1588_icv4_2
    Private write_OTP_P1588_ICV4_47_32_value
    Private read_OTP_P1588_ICV4_47_32_value
    Private flag_OTP_P1588_ICV4_47_32

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

    Property Get get_OTP_P1588_ICV4_47_32
        get_OTP_P1588_ICV4_47_32 = read_OTP_P1588_ICV4_47_32_value
    End Property

    Property Let set_OTP_P1588_ICV4_47_32(aData)
        write_OTP_P1588_ICV4_47_32_value = aData
        flag_OTP_P1588_ICV4_47_32        = &H1
    End Property

    Property Get read_OTP_P1588_ICV4_47_32
        read
        read_OTP_P1588_ICV4_47_32 = read_OTP_P1588_ICV4_47_32_value
    End Property

    Property Let write_OTP_P1588_ICV4_47_32(aData)
        set_OTP_P1588_ICV4_47_32 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        OTP_P1588_ICV4_47_32_mask = &Hffff
        if data_low > LONG_MAX then
            if OTP_P1588_ICV4_47_32_mask = mask then
                read_OTP_P1588_ICV4_47_32_value = data_low
            else
                read_OTP_P1588_ICV4_47_32_value = (data_low - H8000_0000) and OTP_P1588_ICV4_47_32_mask
            end If
        else
            read_OTP_P1588_ICV4_47_32_value = data_low and OTP_P1588_ICV4_47_32_mask
        end If

    End Sub

    Sub write
        If flag_OTP_P1588_ICV4_47_32 = &H0 Then read
        If flag_OTP_P1588_ICV4_47_32 = &H0 Then write_OTP_P1588_ICV4_47_32_value = get_OTP_P1588_ICV4_47_32

        regValue = leftShift((write_OTP_P1588_ICV4_47_32_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        OTP_P1588_ICV4_47_32_mask = &Hffff
        if data_low > LONG_MAX then
            if OTP_P1588_ICV4_47_32_mask = mask then
                read_OTP_P1588_ICV4_47_32_value = data_low
            else
                read_OTP_P1588_ICV4_47_32_value = (data_low - H8000_0000) and OTP_P1588_ICV4_47_32_mask
            end If
        else
            read_OTP_P1588_ICV4_47_32_value = data_low and OTP_P1588_ICV4_47_32_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_OTP_P1588_ICV4_47_32_value = &H0
        flag_OTP_P1588_ICV4_47_32        = &H0
    End Sub
End Class


'' @REGISTER : BRPHY_1G_1PORT_MISC_otp_p1588_icv4_3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' OTP_P1588_ICV4_63_48                       [15:0]           get_OTP_P1588_ICV4_63_48
''                                                             set_OTP_P1588_ICV4_63_48
''                                                             read_OTP_P1588_ICV4_63_48
''                                                             write_OTP_P1588_ICV4_63_48
''---------------------------------------------------------------------------------
Class REGISTER_BRPHY_1G_1PORT_MISC_otp_p1588_icv4_3
    Private write_OTP_P1588_ICV4_63_48_value
    Private read_OTP_P1588_ICV4_63_48_value
    Private flag_OTP_P1588_ICV4_63_48

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

    Property Get get_OTP_P1588_ICV4_63_48
        get_OTP_P1588_ICV4_63_48 = read_OTP_P1588_ICV4_63_48_value
    End Property

    Property Let set_OTP_P1588_ICV4_63_48(aData)
        write_OTP_P1588_ICV4_63_48_value = aData
        flag_OTP_P1588_ICV4_63_48        = &H1
    End Property

    Property Get read_OTP_P1588_ICV4_63_48
        read
        read_OTP_P1588_ICV4_63_48 = read_OTP_P1588_ICV4_63_48_value
    End Property

    Property Let write_OTP_P1588_ICV4_63_48(aData)
        set_OTP_P1588_ICV4_63_48 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        OTP_P1588_ICV4_63_48_mask = &Hffff
        if data_low > LONG_MAX then
            if OTP_P1588_ICV4_63_48_mask = mask then
                read_OTP_P1588_ICV4_63_48_value = data_low
            else
                read_OTP_P1588_ICV4_63_48_value = (data_low - H8000_0000) and OTP_P1588_ICV4_63_48_mask
            end If
        else
            read_OTP_P1588_ICV4_63_48_value = data_low and OTP_P1588_ICV4_63_48_mask
        end If

    End Sub

    Sub write
        If flag_OTP_P1588_ICV4_63_48 = &H0 Then read
        If flag_OTP_P1588_ICV4_63_48 = &H0 Then write_OTP_P1588_ICV4_63_48_value = get_OTP_P1588_ICV4_63_48

        regValue = leftShift((write_OTP_P1588_ICV4_63_48_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        OTP_P1588_ICV4_63_48_mask = &Hffff
        if data_low > LONG_MAX then
            if OTP_P1588_ICV4_63_48_mask = mask then
                read_OTP_P1588_ICV4_63_48_value = data_low
            else
                read_OTP_P1588_ICV4_63_48_value = (data_low - H8000_0000) and OTP_P1588_ICV4_63_48_mask
            end If
        else
            read_OTP_P1588_ICV4_63_48_value = data_low and OTP_P1588_ICV4_63_48_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_OTP_P1588_ICV4_63_48_value = &H0
        flag_OTP_P1588_ICV4_63_48        = &H0
    End Sub
End Class


'' @REGISTER : BRPHY_1G_1PORT_MISC_otp_p1588_icv4_4
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' OTP_P1588_ICV4_79_64                       [15:0]           get_OTP_P1588_ICV4_79_64
''                                                             set_OTP_P1588_ICV4_79_64
''                                                             read_OTP_P1588_ICV4_79_64
''                                                             write_OTP_P1588_ICV4_79_64
''---------------------------------------------------------------------------------
Class REGISTER_BRPHY_1G_1PORT_MISC_otp_p1588_icv4_4
    Private write_OTP_P1588_ICV4_79_64_value
    Private read_OTP_P1588_ICV4_79_64_value
    Private flag_OTP_P1588_ICV4_79_64

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

    Property Get get_OTP_P1588_ICV4_79_64
        get_OTP_P1588_ICV4_79_64 = read_OTP_P1588_ICV4_79_64_value
    End Property

    Property Let set_OTP_P1588_ICV4_79_64(aData)
        write_OTP_P1588_ICV4_79_64_value = aData
        flag_OTP_P1588_ICV4_79_64        = &H1
    End Property

    Property Get read_OTP_P1588_ICV4_79_64
        read
        read_OTP_P1588_ICV4_79_64 = read_OTP_P1588_ICV4_79_64_value
    End Property

    Property Let write_OTP_P1588_ICV4_79_64(aData)
        set_OTP_P1588_ICV4_79_64 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        OTP_P1588_ICV4_79_64_mask = &Hffff
        if data_low > LONG_MAX then
            if OTP_P1588_ICV4_79_64_mask = mask then
                read_OTP_P1588_ICV4_79_64_value = data_low
            else
                read_OTP_P1588_ICV4_79_64_value = (data_low - H8000_0000) and OTP_P1588_ICV4_79_64_mask
            end If
        else
            read_OTP_P1588_ICV4_79_64_value = data_low and OTP_P1588_ICV4_79_64_mask
        end If

    End Sub

    Sub write
        If flag_OTP_P1588_ICV4_79_64 = &H0 Then read
        If flag_OTP_P1588_ICV4_79_64 = &H0 Then write_OTP_P1588_ICV4_79_64_value = get_OTP_P1588_ICV4_79_64

        regValue = leftShift((write_OTP_P1588_ICV4_79_64_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        OTP_P1588_ICV4_79_64_mask = &Hffff
        if data_low > LONG_MAX then
            if OTP_P1588_ICV4_79_64_mask = mask then
                read_OTP_P1588_ICV4_79_64_value = data_low
            else
                read_OTP_P1588_ICV4_79_64_value = (data_low - H8000_0000) and OTP_P1588_ICV4_79_64_mask
            end If
        else
            read_OTP_P1588_ICV4_79_64_value = data_low and OTP_P1588_ICV4_79_64_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_OTP_P1588_ICV4_79_64_value = &H0
        flag_OTP_P1588_ICV4_79_64        = &H0
    End Sub
End Class


'' @REGISTER : BRPHY_1G_1PORT_MISC_otp_p1588_icv4_5
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' OTP_P1588_ICV4_95_80                       [15:0]           get_OTP_P1588_ICV4_95_80
''                                                             set_OTP_P1588_ICV4_95_80
''                                                             read_OTP_P1588_ICV4_95_80
''                                                             write_OTP_P1588_ICV4_95_80
''---------------------------------------------------------------------------------
Class REGISTER_BRPHY_1G_1PORT_MISC_otp_p1588_icv4_5
    Private write_OTP_P1588_ICV4_95_80_value
    Private read_OTP_P1588_ICV4_95_80_value
    Private flag_OTP_P1588_ICV4_95_80

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

    Property Get get_OTP_P1588_ICV4_95_80
        get_OTP_P1588_ICV4_95_80 = read_OTP_P1588_ICV4_95_80_value
    End Property

    Property Let set_OTP_P1588_ICV4_95_80(aData)
        write_OTP_P1588_ICV4_95_80_value = aData
        flag_OTP_P1588_ICV4_95_80        = &H1
    End Property

    Property Get read_OTP_P1588_ICV4_95_80
        read
        read_OTP_P1588_ICV4_95_80 = read_OTP_P1588_ICV4_95_80_value
    End Property

    Property Let write_OTP_P1588_ICV4_95_80(aData)
        set_OTP_P1588_ICV4_95_80 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        OTP_P1588_ICV4_95_80_mask = &Hffff
        if data_low > LONG_MAX then
            if OTP_P1588_ICV4_95_80_mask = mask then
                read_OTP_P1588_ICV4_95_80_value = data_low
            else
                read_OTP_P1588_ICV4_95_80_value = (data_low - H8000_0000) and OTP_P1588_ICV4_95_80_mask
            end If
        else
            read_OTP_P1588_ICV4_95_80_value = data_low and OTP_P1588_ICV4_95_80_mask
        end If

    End Sub

    Sub write
        If flag_OTP_P1588_ICV4_95_80 = &H0 Then read
        If flag_OTP_P1588_ICV4_95_80 = &H0 Then write_OTP_P1588_ICV4_95_80_value = get_OTP_P1588_ICV4_95_80

        regValue = leftShift((write_OTP_P1588_ICV4_95_80_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        OTP_P1588_ICV4_95_80_mask = &Hffff
        if data_low > LONG_MAX then
            if OTP_P1588_ICV4_95_80_mask = mask then
                read_OTP_P1588_ICV4_95_80_value = data_low
            else
                read_OTP_P1588_ICV4_95_80_value = (data_low - H8000_0000) and OTP_P1588_ICV4_95_80_mask
            end If
        else
            read_OTP_P1588_ICV4_95_80_value = data_low and OTP_P1588_ICV4_95_80_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_OTP_P1588_ICV4_95_80_value = &H0
        flag_OTP_P1588_ICV4_95_80        = &H0
    End Sub
End Class


'' @REGISTER : BRPHY_1G_1PORT_MISC_otp_p1588_icv4_6
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' OTP_P1588_ICV4_111_96                      [15:0]           get_OTP_P1588_ICV4_111_96
''                                                             set_OTP_P1588_ICV4_111_96
''                                                             read_OTP_P1588_ICV4_111_96
''                                                             write_OTP_P1588_ICV4_111_96
''---------------------------------------------------------------------------------
Class REGISTER_BRPHY_1G_1PORT_MISC_otp_p1588_icv4_6
    Private write_OTP_P1588_ICV4_111_96_value
    Private read_OTP_P1588_ICV4_111_96_value
    Private flag_OTP_P1588_ICV4_111_96

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H15e
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_OTP_P1588_ICV4_111_96
        get_OTP_P1588_ICV4_111_96 = read_OTP_P1588_ICV4_111_96_value
    End Property

    Property Let set_OTP_P1588_ICV4_111_96(aData)
        write_OTP_P1588_ICV4_111_96_value = aData
        flag_OTP_P1588_ICV4_111_96        = &H1
    End Property

    Property Get read_OTP_P1588_ICV4_111_96
        read
        read_OTP_P1588_ICV4_111_96 = read_OTP_P1588_ICV4_111_96_value
    End Property

    Property Let write_OTP_P1588_ICV4_111_96(aData)
        set_OTP_P1588_ICV4_111_96 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        OTP_P1588_ICV4_111_96_mask = &Hffff
        if data_low > LONG_MAX then
            if OTP_P1588_ICV4_111_96_mask = mask then
                read_OTP_P1588_ICV4_111_96_value = data_low
            else
                read_OTP_P1588_ICV4_111_96_value = (data_low - H8000_0000) and OTP_P1588_ICV4_111_96_mask
            end If
        else
            read_OTP_P1588_ICV4_111_96_value = data_low and OTP_P1588_ICV4_111_96_mask
        end If

    End Sub

    Sub write
        If flag_OTP_P1588_ICV4_111_96 = &H0 Then read
        If flag_OTP_P1588_ICV4_111_96 = &H0 Then write_OTP_P1588_ICV4_111_96_value = get_OTP_P1588_ICV4_111_96

        regValue = leftShift((write_OTP_P1588_ICV4_111_96_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        OTP_P1588_ICV4_111_96_mask = &Hffff
        if data_low > LONG_MAX then
            if OTP_P1588_ICV4_111_96_mask = mask then
                read_OTP_P1588_ICV4_111_96_value = data_low
            else
                read_OTP_P1588_ICV4_111_96_value = (data_low - H8000_0000) and OTP_P1588_ICV4_111_96_mask
            end If
        else
            read_OTP_P1588_ICV4_111_96_value = data_low and OTP_P1588_ICV4_111_96_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_OTP_P1588_ICV4_111_96_value = &H0
        flag_OTP_P1588_ICV4_111_96        = &H0
    End Sub
End Class


'' @REGISTER : BRPHY_1G_1PORT_MISC_otp_p1588_icv4_7
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' OTP_P1588_ICV4_127_112                     [15:0]           get_OTP_P1588_ICV4_127_112
''                                                             set_OTP_P1588_ICV4_127_112
''                                                             read_OTP_P1588_ICV4_127_112
''                                                             write_OTP_P1588_ICV4_127_112
''---------------------------------------------------------------------------------
Class REGISTER_BRPHY_1G_1PORT_MISC_otp_p1588_icv4_7
    Private write_OTP_P1588_ICV4_127_112_value
    Private read_OTP_P1588_ICV4_127_112_value
    Private flag_OTP_P1588_ICV4_127_112

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

    Property Get get_OTP_P1588_ICV4_127_112
        get_OTP_P1588_ICV4_127_112 = read_OTP_P1588_ICV4_127_112_value
    End Property

    Property Let set_OTP_P1588_ICV4_127_112(aData)
        write_OTP_P1588_ICV4_127_112_value = aData
        flag_OTP_P1588_ICV4_127_112        = &H1
    End Property

    Property Get read_OTP_P1588_ICV4_127_112
        read
        read_OTP_P1588_ICV4_127_112 = read_OTP_P1588_ICV4_127_112_value
    End Property

    Property Let write_OTP_P1588_ICV4_127_112(aData)
        set_OTP_P1588_ICV4_127_112 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        OTP_P1588_ICV4_127_112_mask = &Hffff
        if data_low > LONG_MAX then
            if OTP_P1588_ICV4_127_112_mask = mask then
                read_OTP_P1588_ICV4_127_112_value = data_low
            else
                read_OTP_P1588_ICV4_127_112_value = (data_low - H8000_0000) and OTP_P1588_ICV4_127_112_mask
            end If
        else
            read_OTP_P1588_ICV4_127_112_value = data_low and OTP_P1588_ICV4_127_112_mask
        end If

    End Sub

    Sub write
        If flag_OTP_P1588_ICV4_127_112 = &H0 Then read
        If flag_OTP_P1588_ICV4_127_112 = &H0 Then write_OTP_P1588_ICV4_127_112_value = get_OTP_P1588_ICV4_127_112

        regValue = leftShift((write_OTP_P1588_ICV4_127_112_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        OTP_P1588_ICV4_127_112_mask = &Hffff
        if data_low > LONG_MAX then
            if OTP_P1588_ICV4_127_112_mask = mask then
                read_OTP_P1588_ICV4_127_112_value = data_low
            else
                read_OTP_P1588_ICV4_127_112_value = (data_low - H8000_0000) and OTP_P1588_ICV4_127_112_mask
            end If
        else
            read_OTP_P1588_ICV4_127_112_value = data_low and OTP_P1588_ICV4_127_112_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_OTP_P1588_ICV4_127_112_value = &H0
        flag_OTP_P1588_ICV4_127_112        = &H0
    End Sub
End Class


'' @REGISTER : BRPHY_1G_1PORT_MISC_otp_p1588_rd_status
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' OTP_key7_ECC_DED_flag                      [15:15]          get_OTP_key7_ECC_DED_flag
''                                                             set_OTP_key7_ECC_DED_flag
''                                                             read_OTP_key7_ECC_DED_flag
''                                                             write_OTP_key7_ECC_DED_flag
''---------------------------------------------------------------------------------
'' OTP_key7_ECC_ERROR_FLAG                    [14:14]          get_OTP_key7_ECC_ERROR_FLAG
''                                                             set_OTP_key7_ECC_ERROR_FLAG
''                                                             read_OTP_key7_ECC_ERROR_FLAG
''                                                             write_OTP_key7_ECC_ERROR_FLAG
''---------------------------------------------------------------------------------
'' OTP_key6_ECC_DED_flag                      [13:13]          get_OTP_key6_ECC_DED_flag
''                                                             set_OTP_key6_ECC_DED_flag
''                                                             read_OTP_key6_ECC_DED_flag
''                                                             write_OTP_key6_ECC_DED_flag
''---------------------------------------------------------------------------------
'' OTP_key6_ECC_ERROR_FLAG                    [12:12]          get_OTP_key6_ECC_ERROR_FLAG
''                                                             set_OTP_key6_ECC_ERROR_FLAG
''                                                             read_OTP_key6_ECC_ERROR_FLAG
''                                                             write_OTP_key6_ECC_ERROR_FLAG
''---------------------------------------------------------------------------------
'' OTP_key5_ECC_DED_flag                      [11:11]          get_OTP_key5_ECC_DED_flag
''                                                             set_OTP_key5_ECC_DED_flag
''                                                             read_OTP_key5_ECC_DED_flag
''                                                             write_OTP_key5_ECC_DED_flag
''---------------------------------------------------------------------------------
'' OTP_key5_ECC_ERROR_FLAG                    [10:10]          get_OTP_key5_ECC_ERROR_FLAG
''                                                             set_OTP_key5_ECC_ERROR_FLAG
''                                                             read_OTP_key5_ECC_ERROR_FLAG
''                                                             write_OTP_key5_ECC_ERROR_FLAG
''---------------------------------------------------------------------------------
'' OTP_key4_ECC_DED_flag                      [9:9]            get_OTP_key4_ECC_DED_flag
''                                                             set_OTP_key4_ECC_DED_flag
''                                                             read_OTP_key4_ECC_DED_flag
''                                                             write_OTP_key4_ECC_DED_flag
''---------------------------------------------------------------------------------
'' OTP_key4_ECC_ERROR_FLAG                    [8:8]            get_OTP_key4_ECC_ERROR_FLAG
''                                                             set_OTP_key4_ECC_ERROR_FLAG
''                                                             read_OTP_key4_ECC_ERROR_FLAG
''                                                             write_OTP_key4_ECC_ERROR_FLAG
''---------------------------------------------------------------------------------
'' OTP_key3_ECC_DED_flag                      [7:7]            get_OTP_key3_ECC_DED_flag
''                                                             set_OTP_key3_ECC_DED_flag
''                                                             read_OTP_key3_ECC_DED_flag
''                                                             write_OTP_key3_ECC_DED_flag
''---------------------------------------------------------------------------------
'' OTP_key3_ECC_ERROR_FLAG                    [6:6]            get_OTP_key3_ECC_ERROR_FLAG
''                                                             set_OTP_key3_ECC_ERROR_FLAG
''                                                             read_OTP_key3_ECC_ERROR_FLAG
''                                                             write_OTP_key3_ECC_ERROR_FLAG
''---------------------------------------------------------------------------------
'' OTP_key2_ECC_DED_flag                      [5:5]            get_OTP_key2_ECC_DED_flag
''                                                             set_OTP_key2_ECC_DED_flag
''                                                             read_OTP_key2_ECC_DED_flag
''                                                             write_OTP_key2_ECC_DED_flag
''---------------------------------------------------------------------------------
'' OTP_key2_ECC_ERROR_FLAG                    [4:4]            get_OTP_key2_ECC_ERROR_FLAG
''                                                             set_OTP_key2_ECC_ERROR_FLAG
''                                                             read_OTP_key2_ECC_ERROR_FLAG
''                                                             write_OTP_key2_ECC_ERROR_FLAG
''---------------------------------------------------------------------------------
'' OTP_key1_ECC_DED_flag                      [3:3]            get_OTP_key1_ECC_DED_flag
''                                                             set_OTP_key1_ECC_DED_flag
''                                                             read_OTP_key1_ECC_DED_flag
''                                                             write_OTP_key1_ECC_DED_flag
''---------------------------------------------------------------------------------
'' OTP_key1_ECC_ERROR_FLAG                    [2:2]            get_OTP_key1_ECC_ERROR_FLAG
''                                                             set_OTP_key1_ECC_ERROR_FLAG
''                                                             read_OTP_key1_ECC_ERROR_FLAG
''                                                             write_OTP_key1_ECC_ERROR_FLAG
''---------------------------------------------------------------------------------
'' OTP_key0_ECC_DED_flag                      [1:1]            get_OTP_key0_ECC_DED_flag
''                                                             set_OTP_key0_ECC_DED_flag
''                                                             read_OTP_key0_ECC_DED_flag
''                                                             write_OTP_key0_ECC_DED_flag
''---------------------------------------------------------------------------------
'' OTP_key0_ECC_ERROR_FLAG                    [0:0]            get_OTP_key0_ECC_ERROR_FLAG
''                                                             set_OTP_key0_ECC_ERROR_FLAG
''                                                             read_OTP_key0_ECC_ERROR_FLAG
''                                                             write_OTP_key0_ECC_ERROR_FLAG
''---------------------------------------------------------------------------------
Class REGISTER_BRPHY_1G_1PORT_MISC_otp_p1588_rd_status
    Private write_OTP_key7_ECC_DED_flag_value
    Private read_OTP_key7_ECC_DED_flag_value
    Private flag_OTP_key7_ECC_DED_flag
    Private write_OTP_key7_ECC_ERROR_FLAG_value
    Private read_OTP_key7_ECC_ERROR_FLAG_value
    Private flag_OTP_key7_ECC_ERROR_FLAG
    Private write_OTP_key6_ECC_DED_flag_value
    Private read_OTP_key6_ECC_DED_flag_value
    Private flag_OTP_key6_ECC_DED_flag
    Private write_OTP_key6_ECC_ERROR_FLAG_value
    Private read_OTP_key6_ECC_ERROR_FLAG_value
    Private flag_OTP_key6_ECC_ERROR_FLAG
    Private write_OTP_key5_ECC_DED_flag_value
    Private read_OTP_key5_ECC_DED_flag_value
    Private flag_OTP_key5_ECC_DED_flag
    Private write_OTP_key5_ECC_ERROR_FLAG_value
    Private read_OTP_key5_ECC_ERROR_FLAG_value
    Private flag_OTP_key5_ECC_ERROR_FLAG
    Private write_OTP_key4_ECC_DED_flag_value
    Private read_OTP_key4_ECC_DED_flag_value
    Private flag_OTP_key4_ECC_DED_flag
    Private write_OTP_key4_ECC_ERROR_FLAG_value
    Private read_OTP_key4_ECC_ERROR_FLAG_value
    Private flag_OTP_key4_ECC_ERROR_FLAG
    Private write_OTP_key3_ECC_DED_flag_value
    Private read_OTP_key3_ECC_DED_flag_value
    Private flag_OTP_key3_ECC_DED_flag
    Private write_OTP_key3_ECC_ERROR_FLAG_value
    Private read_OTP_key3_ECC_ERROR_FLAG_value
    Private flag_OTP_key3_ECC_ERROR_FLAG
    Private write_OTP_key2_ECC_DED_flag_value
    Private read_OTP_key2_ECC_DED_flag_value
    Private flag_OTP_key2_ECC_DED_flag
    Private write_OTP_key2_ECC_ERROR_FLAG_value
    Private read_OTP_key2_ECC_ERROR_FLAG_value
    Private flag_OTP_key2_ECC_ERROR_FLAG
    Private write_OTP_key1_ECC_DED_flag_value
    Private read_OTP_key1_ECC_DED_flag_value
    Private flag_OTP_key1_ECC_DED_flag
    Private write_OTP_key1_ECC_ERROR_FLAG_value
    Private read_OTP_key1_ECC_ERROR_FLAG_value
    Private flag_OTP_key1_ECC_ERROR_FLAG
    Private write_OTP_key0_ECC_DED_flag_value
    Private read_OTP_key0_ECC_DED_flag_value
    Private flag_OTP_key0_ECC_DED_flag
    Private write_OTP_key0_ECC_ERROR_FLAG_value
    Private read_OTP_key0_ECC_ERROR_FLAG_value
    Private flag_OTP_key0_ECC_ERROR_FLAG

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

    Property Get get_OTP_key7_ECC_DED_flag
        get_OTP_key7_ECC_DED_flag = read_OTP_key7_ECC_DED_flag_value
    End Property

    Property Let set_OTP_key7_ECC_DED_flag(aData)
        write_OTP_key7_ECC_DED_flag_value = aData
        flag_OTP_key7_ECC_DED_flag        = &H1
    End Property

    Property Get read_OTP_key7_ECC_DED_flag
        read
        read_OTP_key7_ECC_DED_flag = read_OTP_key7_ECC_DED_flag_value
    End Property

    Property Let write_OTP_key7_ECC_DED_flag(aData)
        set_OTP_key7_ECC_DED_flag = aData
        write
    End Property

    Property Get get_OTP_key7_ECC_ERROR_FLAG
        get_OTP_key7_ECC_ERROR_FLAG = read_OTP_key7_ECC_ERROR_FLAG_value
    End Property

    Property Let set_OTP_key7_ECC_ERROR_FLAG(aData)
        write_OTP_key7_ECC_ERROR_FLAG_value = aData
        flag_OTP_key7_ECC_ERROR_FLAG        = &H1
    End Property

    Property Get read_OTP_key7_ECC_ERROR_FLAG
        read
        read_OTP_key7_ECC_ERROR_FLAG = read_OTP_key7_ECC_ERROR_FLAG_value
    End Property

    Property Let write_OTP_key7_ECC_ERROR_FLAG(aData)
        set_OTP_key7_ECC_ERROR_FLAG = aData
        write
    End Property

    Property Get get_OTP_key6_ECC_DED_flag
        get_OTP_key6_ECC_DED_flag = read_OTP_key6_ECC_DED_flag_value
    End Property

    Property Let set_OTP_key6_ECC_DED_flag(aData)
        write_OTP_key6_ECC_DED_flag_value = aData
        flag_OTP_key6_ECC_DED_flag        = &H1
    End Property

    Property Get read_OTP_key6_ECC_DED_flag
        read
        read_OTP_key6_ECC_DED_flag = read_OTP_key6_ECC_DED_flag_value
    End Property

    Property Let write_OTP_key6_ECC_DED_flag(aData)
        set_OTP_key6_ECC_DED_flag = aData
        write
    End Property

    Property Get get_OTP_key6_ECC_ERROR_FLAG
        get_OTP_key6_ECC_ERROR_FLAG = read_OTP_key6_ECC_ERROR_FLAG_value
    End Property

    Property Let set_OTP_key6_ECC_ERROR_FLAG(aData)
        write_OTP_key6_ECC_ERROR_FLAG_value = aData
        flag_OTP_key6_ECC_ERROR_FLAG        = &H1
    End Property

    Property Get read_OTP_key6_ECC_ERROR_FLAG
        read
        read_OTP_key6_ECC_ERROR_FLAG = read_OTP_key6_ECC_ERROR_FLAG_value
    End Property

    Property Let write_OTP_key6_ECC_ERROR_FLAG(aData)
        set_OTP_key6_ECC_ERROR_FLAG = aData
        write
    End Property

    Property Get get_OTP_key5_ECC_DED_flag
        get_OTP_key5_ECC_DED_flag = read_OTP_key5_ECC_DED_flag_value
    End Property

    Property Let set_OTP_key5_ECC_DED_flag(aData)
        write_OTP_key5_ECC_DED_flag_value = aData
        flag_OTP_key5_ECC_DED_flag        = &H1
    End Property

    Property Get read_OTP_key5_ECC_DED_flag
        read
        read_OTP_key5_ECC_DED_flag = read_OTP_key5_ECC_DED_flag_value
    End Property

    Property Let write_OTP_key5_ECC_DED_flag(aData)
        set_OTP_key5_ECC_DED_flag = aData
        write
    End Property

    Property Get get_OTP_key5_ECC_ERROR_FLAG
        get_OTP_key5_ECC_ERROR_FLAG = read_OTP_key5_ECC_ERROR_FLAG_value
    End Property

    Property Let set_OTP_key5_ECC_ERROR_FLAG(aData)
        write_OTP_key5_ECC_ERROR_FLAG_value = aData
        flag_OTP_key5_ECC_ERROR_FLAG        = &H1
    End Property

    Property Get read_OTP_key5_ECC_ERROR_FLAG
        read
        read_OTP_key5_ECC_ERROR_FLAG = read_OTP_key5_ECC_ERROR_FLAG_value
    End Property

    Property Let write_OTP_key5_ECC_ERROR_FLAG(aData)
        set_OTP_key5_ECC_ERROR_FLAG = aData
        write
    End Property

    Property Get get_OTP_key4_ECC_DED_flag
        get_OTP_key4_ECC_DED_flag = read_OTP_key4_ECC_DED_flag_value
    End Property

    Property Let set_OTP_key4_ECC_DED_flag(aData)
        write_OTP_key4_ECC_DED_flag_value = aData
        flag_OTP_key4_ECC_DED_flag        = &H1
    End Property

    Property Get read_OTP_key4_ECC_DED_flag
        read
        read_OTP_key4_ECC_DED_flag = read_OTP_key4_ECC_DED_flag_value
    End Property

    Property Let write_OTP_key4_ECC_DED_flag(aData)
        set_OTP_key4_ECC_DED_flag = aData
        write
    End Property

    Property Get get_OTP_key4_ECC_ERROR_FLAG
        get_OTP_key4_ECC_ERROR_FLAG = read_OTP_key4_ECC_ERROR_FLAG_value
    End Property

    Property Let set_OTP_key4_ECC_ERROR_FLAG(aData)
        write_OTP_key4_ECC_ERROR_FLAG_value = aData
        flag_OTP_key4_ECC_ERROR_FLAG        = &H1
    End Property

    Property Get read_OTP_key4_ECC_ERROR_FLAG
        read
        read_OTP_key4_ECC_ERROR_FLAG = read_OTP_key4_ECC_ERROR_FLAG_value
    End Property

    Property Let write_OTP_key4_ECC_ERROR_FLAG(aData)
        set_OTP_key4_ECC_ERROR_FLAG = aData
        write
    End Property

    Property Get get_OTP_key3_ECC_DED_flag
        get_OTP_key3_ECC_DED_flag = read_OTP_key3_ECC_DED_flag_value
    End Property

    Property Let set_OTP_key3_ECC_DED_flag(aData)
        write_OTP_key3_ECC_DED_flag_value = aData
        flag_OTP_key3_ECC_DED_flag        = &H1
    End Property

    Property Get read_OTP_key3_ECC_DED_flag
        read
        read_OTP_key3_ECC_DED_flag = read_OTP_key3_ECC_DED_flag_value
    End Property

    Property Let write_OTP_key3_ECC_DED_flag(aData)
        set_OTP_key3_ECC_DED_flag = aData
        write
    End Property

    Property Get get_OTP_key3_ECC_ERROR_FLAG
        get_OTP_key3_ECC_ERROR_FLAG = read_OTP_key3_ECC_ERROR_FLAG_value
    End Property

    Property Let set_OTP_key3_ECC_ERROR_FLAG(aData)
        write_OTP_key3_ECC_ERROR_FLAG_value = aData
        flag_OTP_key3_ECC_ERROR_FLAG        = &H1
    End Property

    Property Get read_OTP_key3_ECC_ERROR_FLAG
        read
        read_OTP_key3_ECC_ERROR_FLAG = read_OTP_key3_ECC_ERROR_FLAG_value
    End Property

    Property Let write_OTP_key3_ECC_ERROR_FLAG(aData)
        set_OTP_key3_ECC_ERROR_FLAG = aData
        write
    End Property

    Property Get get_OTP_key2_ECC_DED_flag
        get_OTP_key2_ECC_DED_flag = read_OTP_key2_ECC_DED_flag_value
    End Property

    Property Let set_OTP_key2_ECC_DED_flag(aData)
        write_OTP_key2_ECC_DED_flag_value = aData
        flag_OTP_key2_ECC_DED_flag        = &H1
    End Property

    Property Get read_OTP_key2_ECC_DED_flag
        read
        read_OTP_key2_ECC_DED_flag = read_OTP_key2_ECC_DED_flag_value
    End Property

    Property Let write_OTP_key2_ECC_DED_flag(aData)
        set_OTP_key2_ECC_DED_flag = aData
        write
    End Property

    Property Get get_OTP_key2_ECC_ERROR_FLAG
        get_OTP_key2_ECC_ERROR_FLAG = read_OTP_key2_ECC_ERROR_FLAG_value
    End Property

    Property Let set_OTP_key2_ECC_ERROR_FLAG(aData)
        write_OTP_key2_ECC_ERROR_FLAG_value = aData
        flag_OTP_key2_ECC_ERROR_FLAG        = &H1
    End Property

    Property Get read_OTP_key2_ECC_ERROR_FLAG
        read
        read_OTP_key2_ECC_ERROR_FLAG = read_OTP_key2_ECC_ERROR_FLAG_value
    End Property

    Property Let write_OTP_key2_ECC_ERROR_FLAG(aData)
        set_OTP_key2_ECC_ERROR_FLAG = aData
        write
    End Property

    Property Get get_OTP_key1_ECC_DED_flag
        get_OTP_key1_ECC_DED_flag = read_OTP_key1_ECC_DED_flag_value
    End Property

    Property Let set_OTP_key1_ECC_DED_flag(aData)
        write_OTP_key1_ECC_DED_flag_value = aData
        flag_OTP_key1_ECC_DED_flag        = &H1
    End Property

    Property Get read_OTP_key1_ECC_DED_flag
        read
        read_OTP_key1_ECC_DED_flag = read_OTP_key1_ECC_DED_flag_value
    End Property

    Property Let write_OTP_key1_ECC_DED_flag(aData)
        set_OTP_key1_ECC_DED_flag = aData
        write
    End Property

    Property Get get_OTP_key1_ECC_ERROR_FLAG
        get_OTP_key1_ECC_ERROR_FLAG = read_OTP_key1_ECC_ERROR_FLAG_value
    End Property

    Property Let set_OTP_key1_ECC_ERROR_FLAG(aData)
        write_OTP_key1_ECC_ERROR_FLAG_value = aData
        flag_OTP_key1_ECC_ERROR_FLAG        = &H1
    End Property

    Property Get read_OTP_key1_ECC_ERROR_FLAG
        read
        read_OTP_key1_ECC_ERROR_FLAG = read_OTP_key1_ECC_ERROR_FLAG_value
    End Property

    Property Let write_OTP_key1_ECC_ERROR_FLAG(aData)
        set_OTP_key1_ECC_ERROR_FLAG = aData
        write
    End Property

    Property Get get_OTP_key0_ECC_DED_flag
        get_OTP_key0_ECC_DED_flag = read_OTP_key0_ECC_DED_flag_value
    End Property

    Property Let set_OTP_key0_ECC_DED_flag(aData)
        write_OTP_key0_ECC_DED_flag_value = aData
        flag_OTP_key0_ECC_DED_flag        = &H1
    End Property

    Property Get read_OTP_key0_ECC_DED_flag
        read
        read_OTP_key0_ECC_DED_flag = read_OTP_key0_ECC_DED_flag_value
    End Property

    Property Let write_OTP_key0_ECC_DED_flag(aData)
        set_OTP_key0_ECC_DED_flag = aData
        write
    End Property

    Property Get get_OTP_key0_ECC_ERROR_FLAG
        get_OTP_key0_ECC_ERROR_FLAG = read_OTP_key0_ECC_ERROR_FLAG_value
    End Property

    Property Let set_OTP_key0_ECC_ERROR_FLAG(aData)
        write_OTP_key0_ECC_ERROR_FLAG_value = aData
        flag_OTP_key0_ECC_ERROR_FLAG        = &H1
    End Property

    Property Get read_OTP_key0_ECC_ERROR_FLAG
        read
        read_OTP_key0_ECC_ERROR_FLAG = read_OTP_key0_ECC_ERROR_FLAG_value
    End Property

    Property Let write_OTP_key0_ECC_ERROR_FLAG(aData)
        set_OTP_key0_ECC_ERROR_FLAG = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_OTP_key7_ECC_DED_flag_value = rightShift(data_low, 15) and &H1
        read_OTP_key7_ECC_ERROR_FLAG_value = rightShift(data_low, 14) and &H1
        read_OTP_key6_ECC_DED_flag_value = rightShift(data_low, 13) and &H1
        read_OTP_key6_ECC_ERROR_FLAG_value = rightShift(data_low, 12) and &H1
        read_OTP_key5_ECC_DED_flag_value = rightShift(data_low, 11) and &H1
        read_OTP_key5_ECC_ERROR_FLAG_value = rightShift(data_low, 10) and &H1
        read_OTP_key4_ECC_DED_flag_value = rightShift(data_low, 9) and &H1
        read_OTP_key4_ECC_ERROR_FLAG_value = rightShift(data_low, 8) and &H1
        read_OTP_key3_ECC_DED_flag_value = rightShift(data_low, 7) and &H1
        read_OTP_key3_ECC_ERROR_FLAG_value = rightShift(data_low, 6) and &H1
        read_OTP_key2_ECC_DED_flag_value = rightShift(data_low, 5) and &H1
        read_OTP_key2_ECC_ERROR_FLAG_value = rightShift(data_low, 4) and &H1
        read_OTP_key1_ECC_DED_flag_value = rightShift(data_low, 3) and &H1
        read_OTP_key1_ECC_ERROR_FLAG_value = rightShift(data_low, 2) and &H1
        read_OTP_key0_ECC_DED_flag_value = rightShift(data_low, 1) and &H1
        OTP_key0_ECC_ERROR_FLAG_mask = &H1
        if data_low > LONG_MAX then
            if OTP_key0_ECC_ERROR_FLAG_mask = mask then
                read_OTP_key0_ECC_ERROR_FLAG_value = data_low
            else
                read_OTP_key0_ECC_ERROR_FLAG_value = (data_low - H8000_0000) and OTP_key0_ECC_ERROR_FLAG_mask
            end If
        else
            read_OTP_key0_ECC_ERROR_FLAG_value = data_low and OTP_key0_ECC_ERROR_FLAG_mask
        end If

    End Sub

    Sub write
        If flag_OTP_key7_ECC_DED_flag = &H0 or flag_OTP_key7_ECC_ERROR_FLAG = &H0 or flag_OTP_key6_ECC_DED_flag = &H0 or flag_OTP_key6_ECC_ERROR_FLAG = &H0 or flag_OTP_key5_ECC_DED_flag = &H0 or flag_OTP_key5_ECC_ERROR_FLAG = &H0 or flag_OTP_key4_ECC_DED_flag = &H0 or flag_OTP_key4_ECC_ERROR_FLAG = &H0 or flag_OTP_key3_ECC_DED_flag = &H0 or flag_OTP_key3_ECC_ERROR_FLAG = &H0 or flag_OTP_key2_ECC_DED_flag = &H0 or flag_OTP_key2_ECC_ERROR_FLAG = &H0 or flag_OTP_key1_ECC_DED_flag = &H0 or flag_OTP_key1_ECC_ERROR_FLAG = &H0 or flag_OTP_key0_ECC_DED_flag = &H0 or flag_OTP_key0_ECC_ERROR_FLAG = &H0 Then read
        If flag_OTP_key7_ECC_DED_flag = &H0 Then write_OTP_key7_ECC_DED_flag_value = get_OTP_key7_ECC_DED_flag
        If flag_OTP_key7_ECC_ERROR_FLAG = &H0 Then write_OTP_key7_ECC_ERROR_FLAG_value = get_OTP_key7_ECC_ERROR_FLAG
        If flag_OTP_key6_ECC_DED_flag = &H0 Then write_OTP_key6_ECC_DED_flag_value = get_OTP_key6_ECC_DED_flag
        If flag_OTP_key6_ECC_ERROR_FLAG = &H0 Then write_OTP_key6_ECC_ERROR_FLAG_value = get_OTP_key6_ECC_ERROR_FLAG
        If flag_OTP_key5_ECC_DED_flag = &H0 Then write_OTP_key5_ECC_DED_flag_value = get_OTP_key5_ECC_DED_flag
        If flag_OTP_key5_ECC_ERROR_FLAG = &H0 Then write_OTP_key5_ECC_ERROR_FLAG_value = get_OTP_key5_ECC_ERROR_FLAG
        If flag_OTP_key4_ECC_DED_flag = &H0 Then write_OTP_key4_ECC_DED_flag_value = get_OTP_key4_ECC_DED_flag
        If flag_OTP_key4_ECC_ERROR_FLAG = &H0 Then write_OTP_key4_ECC_ERROR_FLAG_value = get_OTP_key4_ECC_ERROR_FLAG
        If flag_OTP_key3_ECC_DED_flag = &H0 Then write_OTP_key3_ECC_DED_flag_value = get_OTP_key3_ECC_DED_flag
        If flag_OTP_key3_ECC_ERROR_FLAG = &H0 Then write_OTP_key3_ECC_ERROR_FLAG_value = get_OTP_key3_ECC_ERROR_FLAG
        If flag_OTP_key2_ECC_DED_flag = &H0 Then write_OTP_key2_ECC_DED_flag_value = get_OTP_key2_ECC_DED_flag
        If flag_OTP_key2_ECC_ERROR_FLAG = &H0 Then write_OTP_key2_ECC_ERROR_FLAG_value = get_OTP_key2_ECC_ERROR_FLAG
        If flag_OTP_key1_ECC_DED_flag = &H0 Then write_OTP_key1_ECC_DED_flag_value = get_OTP_key1_ECC_DED_flag
        If flag_OTP_key1_ECC_ERROR_FLAG = &H0 Then write_OTP_key1_ECC_ERROR_FLAG_value = get_OTP_key1_ECC_ERROR_FLAG
        If flag_OTP_key0_ECC_DED_flag = &H0 Then write_OTP_key0_ECC_DED_flag_value = get_OTP_key0_ECC_DED_flag
        If flag_OTP_key0_ECC_ERROR_FLAG = &H0 Then write_OTP_key0_ECC_ERROR_FLAG_value = get_OTP_key0_ECC_ERROR_FLAG

        regValue = leftShift((write_OTP_key7_ECC_DED_flag_value and &H1), 15) + leftShift((write_OTP_key7_ECC_ERROR_FLAG_value and &H1), 14) + leftShift((write_OTP_key6_ECC_DED_flag_value and &H1), 13) + leftShift((write_OTP_key6_ECC_ERROR_FLAG_value and &H1), 12) + leftShift((write_OTP_key5_ECC_DED_flag_value and &H1), 11) + leftShift((write_OTP_key5_ECC_ERROR_FLAG_value and &H1), 10) + leftShift((write_OTP_key4_ECC_DED_flag_value and &H1), 9) + leftShift((write_OTP_key4_ECC_ERROR_FLAG_value and &H1), 8) + leftShift((write_OTP_key3_ECC_DED_flag_value and &H1), 7) + leftShift((write_OTP_key3_ECC_ERROR_FLAG_value and &H1), 6) + leftShift((write_OTP_key2_ECC_DED_flag_value and &H1), 5) + leftShift((write_OTP_key2_ECC_ERROR_FLAG_value and &H1), 4) + leftShift((write_OTP_key1_ECC_DED_flag_value and &H1), 3) + leftShift((write_OTP_key1_ECC_ERROR_FLAG_value and &H1), 2) + leftShift((write_OTP_key0_ECC_DED_flag_value and &H1), 1) + leftShift((write_OTP_key0_ECC_ERROR_FLAG_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_OTP_key7_ECC_DED_flag_value = rightShift(data_low, 15) and &H1
        read_OTP_key7_ECC_ERROR_FLAG_value = rightShift(data_low, 14) and &H1
        read_OTP_key6_ECC_DED_flag_value = rightShift(data_low, 13) and &H1
        read_OTP_key6_ECC_ERROR_FLAG_value = rightShift(data_low, 12) and &H1
        read_OTP_key5_ECC_DED_flag_value = rightShift(data_low, 11) and &H1
        read_OTP_key5_ECC_ERROR_FLAG_value = rightShift(data_low, 10) and &H1
        read_OTP_key4_ECC_DED_flag_value = rightShift(data_low, 9) and &H1
        read_OTP_key4_ECC_ERROR_FLAG_value = rightShift(data_low, 8) and &H1
        read_OTP_key3_ECC_DED_flag_value = rightShift(data_low, 7) and &H1
        read_OTP_key3_ECC_ERROR_FLAG_value = rightShift(data_low, 6) and &H1
        read_OTP_key2_ECC_DED_flag_value = rightShift(data_low, 5) and &H1
        read_OTP_key2_ECC_ERROR_FLAG_value = rightShift(data_low, 4) and &H1
        read_OTP_key1_ECC_DED_flag_value = rightShift(data_low, 3) and &H1
        read_OTP_key1_ECC_ERROR_FLAG_value = rightShift(data_low, 2) and &H1
        read_OTP_key0_ECC_DED_flag_value = rightShift(data_low, 1) and &H1
        OTP_key0_ECC_ERROR_FLAG_mask = &H1
        if data_low > LONG_MAX then
            if OTP_key0_ECC_ERROR_FLAG_mask = mask then
                read_OTP_key0_ECC_ERROR_FLAG_value = data_low
            else
                read_OTP_key0_ECC_ERROR_FLAG_value = (data_low - H8000_0000) and OTP_key0_ECC_ERROR_FLAG_mask
            end If
        else
            read_OTP_key0_ECC_ERROR_FLAG_value = data_low and OTP_key0_ECC_ERROR_FLAG_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_OTP_key7_ECC_DED_flag_value = &H0
        flag_OTP_key7_ECC_DED_flag        = &H0
        write_OTP_key7_ECC_ERROR_FLAG_value = &H0
        flag_OTP_key7_ECC_ERROR_FLAG        = &H0
        write_OTP_key6_ECC_DED_flag_value = &H0
        flag_OTP_key6_ECC_DED_flag        = &H0
        write_OTP_key6_ECC_ERROR_FLAG_value = &H0
        flag_OTP_key6_ECC_ERROR_FLAG        = &H0
        write_OTP_key5_ECC_DED_flag_value = &H0
        flag_OTP_key5_ECC_DED_flag        = &H0
        write_OTP_key5_ECC_ERROR_FLAG_value = &H0
        flag_OTP_key5_ECC_ERROR_FLAG        = &H0
        write_OTP_key4_ECC_DED_flag_value = &H0
        flag_OTP_key4_ECC_DED_flag        = &H0
        write_OTP_key4_ECC_ERROR_FLAG_value = &H0
        flag_OTP_key4_ECC_ERROR_FLAG        = &H0
        write_OTP_key3_ECC_DED_flag_value = &H0
        flag_OTP_key3_ECC_DED_flag        = &H0
        write_OTP_key3_ECC_ERROR_FLAG_value = &H0
        flag_OTP_key3_ECC_ERROR_FLAG        = &H0
        write_OTP_key2_ECC_DED_flag_value = &H0
        flag_OTP_key2_ECC_DED_flag        = &H0
        write_OTP_key2_ECC_ERROR_FLAG_value = &H0
        flag_OTP_key2_ECC_ERROR_FLAG        = &H0
        write_OTP_key1_ECC_DED_flag_value = &H0
        flag_OTP_key1_ECC_DED_flag        = &H0
        write_OTP_key1_ECC_ERROR_FLAG_value = &H0
        flag_OTP_key1_ECC_ERROR_FLAG        = &H0
        write_OTP_key0_ECC_DED_flag_value = &H0
        flag_OTP_key0_ECC_DED_flag        = &H0
        write_OTP_key0_ECC_ERROR_FLAG_value = &H0
        flag_OTP_key0_ECC_ERROR_FLAG        = &H0
    End Sub
End Class


'' @REGISTER : BRPHY_1G_1PORT_MISC_wr_disable_protect_status_0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' write_protection_status                    [0:0]            get_write_protection_status
''                                                             set_write_protection_status
''                                                             read_write_protection_status
''                                                             write_write_protection_status
''---------------------------------------------------------------------------------
Class REGISTER_BRPHY_1G_1PORT_MISC_wr_disable_protect_status_0
    Private write_write_protection_status_value
    Private read_write_protection_status_value
    Private flag_write_protection_status

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

    Property Get get_write_protection_status
        get_write_protection_status = read_write_protection_status_value
    End Property

    Property Let set_write_protection_status(aData)
        write_write_protection_status_value = aData
        flag_write_protection_status        = &H1
    End Property

    Property Get read_write_protection_status
        read
        read_write_protection_status = read_write_protection_status_value
    End Property

    Property Let write_write_protection_status(aData)
        set_write_protection_status = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        write_protection_status_mask = &H1
        if data_low > LONG_MAX then
            if write_protection_status_mask = mask then
                read_write_protection_status_value = data_low
            else
                read_write_protection_status_value = (data_low - H8000_0000) and write_protection_status_mask
            end If
        else
            read_write_protection_status_value = data_low and write_protection_status_mask
        end If

    End Sub

    Sub write
        If flag_write_protection_status = &H0 Then read
        If flag_write_protection_status = &H0 Then write_write_protection_status_value = get_write_protection_status

        regValue = leftShift((write_write_protection_status_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        write_protection_status_mask = &H1
        if data_low > LONG_MAX then
            if write_protection_status_mask = mask then
                read_write_protection_status_value = data_low
            else
                read_write_protection_status_value = (data_low - H8000_0000) and write_protection_status_mask
            end If
        else
            read_write_protection_status_value = data_low and write_protection_status_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_write_protection_status_value = &H0
        flag_write_protection_status        = &H0
    End Sub
End Class


'' @REGISTER : BRPHY_1G_1PORT_MISC_wr_en_protect_status_0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' write_protection_status                    [0:0]            get_write_protection_status
''                                                             set_write_protection_status
''                                                             read_write_protection_status
''                                                             write_write_protection_status
''---------------------------------------------------------------------------------
Class REGISTER_BRPHY_1G_1PORT_MISC_wr_en_protect_status_0
    Private write_write_protection_status_value
    Private read_write_protection_status_value
    Private flag_write_protection_status

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

    Property Get get_write_protection_status
        get_write_protection_status = read_write_protection_status_value
    End Property

    Property Let set_write_protection_status(aData)
        write_write_protection_status_value = aData
        flag_write_protection_status        = &H1
    End Property

    Property Get read_write_protection_status
        read
        read_write_protection_status = read_write_protection_status_value
    End Property

    Property Let write_write_protection_status(aData)
        set_write_protection_status = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        write_protection_status_mask = &H1
        if data_low > LONG_MAX then
            if write_protection_status_mask = mask then
                read_write_protection_status_value = data_low
            else
                read_write_protection_status_value = (data_low - H8000_0000) and write_protection_status_mask
            end If
        else
            read_write_protection_status_value = data_low and write_protection_status_mask
        end If

    End Sub

    Sub write
        If flag_write_protection_status = &H0 Then read
        If flag_write_protection_status = &H0 Then write_write_protection_status_value = get_write_protection_status

        regValue = leftShift((write_write_protection_status_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        write_protection_status_mask = &H1
        if data_low > LONG_MAX then
            if write_protection_status_mask = mask then
                read_write_protection_status_value = data_low
            else
                read_write_protection_status_value = (data_low - H8000_0000) and write_protection_status_mask
            end If
        else
            read_write_protection_status_value = data_low and write_protection_status_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_write_protection_status_value = &H0
        flag_write_protection_status        = &H0
    End Sub
End Class


'' @REGISTER : BRPHY_1G_1PORT_MISC_addr_start_prot_0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ADDR_START_PROT                            [15:0]           get_ADDR_START_PROT
''                                                             set_ADDR_START_PROT
''                                                             read_ADDR_START_PROT
''                                                             write_ADDR_START_PROT
''---------------------------------------------------------------------------------
Class REGISTER_BRPHY_1G_1PORT_MISC_addr_start_prot_0
    Private write_ADDR_START_PROT_value
    Private read_ADDR_START_PROT_value
    Private flag_ADDR_START_PROT

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

    Property Get get_ADDR_START_PROT
        get_ADDR_START_PROT = read_ADDR_START_PROT_value
    End Property

    Property Let set_ADDR_START_PROT(aData)
        write_ADDR_START_PROT_value = aData
        flag_ADDR_START_PROT        = &H1
    End Property

    Property Get read_ADDR_START_PROT
        read
        read_ADDR_START_PROT = read_ADDR_START_PROT_value
    End Property

    Property Let write_ADDR_START_PROT(aData)
        set_ADDR_START_PROT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ADDR_START_PROT_mask = &Hffff
        if data_low > LONG_MAX then
            if ADDR_START_PROT_mask = mask then
                read_ADDR_START_PROT_value = data_low
            else
                read_ADDR_START_PROT_value = (data_low - H8000_0000) and ADDR_START_PROT_mask
            end If
        else
            read_ADDR_START_PROT_value = data_low and ADDR_START_PROT_mask
        end If

    End Sub

    Sub write
        If flag_ADDR_START_PROT = &H0 Then read
        If flag_ADDR_START_PROT = &H0 Then write_ADDR_START_PROT_value = get_ADDR_START_PROT

        regValue = leftShift((write_ADDR_START_PROT_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ADDR_START_PROT_mask = &Hffff
        if data_low > LONG_MAX then
            if ADDR_START_PROT_mask = mask then
                read_ADDR_START_PROT_value = data_low
            else
                read_ADDR_START_PROT_value = (data_low - H8000_0000) and ADDR_START_PROT_mask
            end If
        else
            read_ADDR_START_PROT_value = data_low and ADDR_START_PROT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ADDR_START_PROT_value = &H0
        flag_ADDR_START_PROT        = &H0
    End Sub
End Class


'' @REGISTER : BRPHY_1G_1PORT_MISC_addr_end_prot_0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ADDR_END_PROT                              [15:0]           get_ADDR_END_PROT
''                                                             set_ADDR_END_PROT
''                                                             read_ADDR_END_PROT
''                                                             write_ADDR_END_PROT
''---------------------------------------------------------------------------------
Class REGISTER_BRPHY_1G_1PORT_MISC_addr_end_prot_0
    Private write_ADDR_END_PROT_value
    Private read_ADDR_END_PROT_value
    Private flag_ADDR_END_PROT

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

    Property Get get_ADDR_END_PROT
        get_ADDR_END_PROT = read_ADDR_END_PROT_value
    End Property

    Property Let set_ADDR_END_PROT(aData)
        write_ADDR_END_PROT_value = aData
        flag_ADDR_END_PROT        = &H1
    End Property

    Property Get read_ADDR_END_PROT
        read
        read_ADDR_END_PROT = read_ADDR_END_PROT_value
    End Property

    Property Let write_ADDR_END_PROT(aData)
        set_ADDR_END_PROT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ADDR_END_PROT_mask = &Hffff
        if data_low > LONG_MAX then
            if ADDR_END_PROT_mask = mask then
                read_ADDR_END_PROT_value = data_low
            else
                read_ADDR_END_PROT_value = (data_low - H8000_0000) and ADDR_END_PROT_mask
            end If
        else
            read_ADDR_END_PROT_value = data_low and ADDR_END_PROT_mask
        end If

    End Sub

    Sub write
        If flag_ADDR_END_PROT = &H0 Then read
        If flag_ADDR_END_PROT = &H0 Then write_ADDR_END_PROT_value = get_ADDR_END_PROT

        regValue = leftShift((write_ADDR_END_PROT_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ADDR_END_PROT_mask = &Hffff
        if data_low > LONG_MAX then
            if ADDR_END_PROT_mask = mask then
                read_ADDR_END_PROT_value = data_low
            else
                read_ADDR_END_PROT_value = (data_low - H8000_0000) and ADDR_END_PROT_mask
            end If
        else
            read_ADDR_END_PROT_value = data_low and ADDR_END_PROT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ADDR_END_PROT_value = &H0
        flag_ADDR_END_PROT        = &H0
    End Sub
End Class


'' @REGISTER : BRPHY_1G_1PORT_MISC_gmii_rx_fifo_ctl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' GMII_RX_FIFO_Control                       [15:0]           get_GMII_RX_FIFO_Control
''                                                             set_GMII_RX_FIFO_Control
''                                                             read_GMII_RX_FIFO_Control
''                                                             write_GMII_RX_FIFO_Control
''---------------------------------------------------------------------------------
Class REGISTER_BRPHY_1G_1PORT_MISC_gmii_rx_fifo_ctl
    Private write_GMII_RX_FIFO_Control_value
    Private read_GMII_RX_FIFO_Control_value
    Private flag_GMII_RX_FIFO_Control

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

    Property Get get_GMII_RX_FIFO_Control
        get_GMII_RX_FIFO_Control = read_GMII_RX_FIFO_Control_value
    End Property

    Property Let set_GMII_RX_FIFO_Control(aData)
        write_GMII_RX_FIFO_Control_value = aData
        flag_GMII_RX_FIFO_Control        = &H1
    End Property

    Property Get read_GMII_RX_FIFO_Control
        read
        read_GMII_RX_FIFO_Control = read_GMII_RX_FIFO_Control_value
    End Property

    Property Let write_GMII_RX_FIFO_Control(aData)
        set_GMII_RX_FIFO_Control = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        GMII_RX_FIFO_Control_mask = &Hffff
        if data_low > LONG_MAX then
            if GMII_RX_FIFO_Control_mask = mask then
                read_GMII_RX_FIFO_Control_value = data_low
            else
                read_GMII_RX_FIFO_Control_value = (data_low - H8000_0000) and GMII_RX_FIFO_Control_mask
            end If
        else
            read_GMII_RX_FIFO_Control_value = data_low and GMII_RX_FIFO_Control_mask
        end If

    End Sub

    Sub write
        If flag_GMII_RX_FIFO_Control = &H0 Then read
        If flag_GMII_RX_FIFO_Control = &H0 Then write_GMII_RX_FIFO_Control_value = get_GMII_RX_FIFO_Control

        regValue = leftShift((write_GMII_RX_FIFO_Control_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        GMII_RX_FIFO_Control_mask = &Hffff
        if data_low > LONG_MAX then
            if GMII_RX_FIFO_Control_mask = mask then
                read_GMII_RX_FIFO_Control_value = data_low
            else
                read_GMII_RX_FIFO_Control_value = (data_low - H8000_0000) and GMII_RX_FIFO_Control_mask
            end If
        else
            read_GMII_RX_FIFO_Control_value = data_low and GMII_RX_FIFO_Control_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_GMII_RX_FIFO_Control_value = &H0
        flag_GMII_RX_FIFO_Control        = &H0
    End Sub
End Class


'' @REGISTER : BRPHY_1G_1PORT_MISC_gmii_rx_dll_ctl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' GMII_RX_DLL_Control                        [15:0]           get_GMII_RX_DLL_Control
''                                                             set_GMII_RX_DLL_Control
''                                                             read_GMII_RX_DLL_Control
''                                                             write_GMII_RX_DLL_Control
''---------------------------------------------------------------------------------
Class REGISTER_BRPHY_1G_1PORT_MISC_gmii_rx_dll_ctl
    Private write_GMII_RX_DLL_Control_value
    Private read_GMII_RX_DLL_Control_value
    Private flag_GMII_RX_DLL_Control

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H16e
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_GMII_RX_DLL_Control
        get_GMII_RX_DLL_Control = read_GMII_RX_DLL_Control_value
    End Property

    Property Let set_GMII_RX_DLL_Control(aData)
        write_GMII_RX_DLL_Control_value = aData
        flag_GMII_RX_DLL_Control        = &H1
    End Property

    Property Get read_GMII_RX_DLL_Control
        read
        read_GMII_RX_DLL_Control = read_GMII_RX_DLL_Control_value
    End Property

    Property Let write_GMII_RX_DLL_Control(aData)
        set_GMII_RX_DLL_Control = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        GMII_RX_DLL_Control_mask = &Hffff
        if data_low > LONG_MAX then
            if GMII_RX_DLL_Control_mask = mask then
                read_GMII_RX_DLL_Control_value = data_low
            else
                read_GMII_RX_DLL_Control_value = (data_low - H8000_0000) and GMII_RX_DLL_Control_mask
            end If
        else
            read_GMII_RX_DLL_Control_value = data_low and GMII_RX_DLL_Control_mask
        end If

    End Sub

    Sub write
        If flag_GMII_RX_DLL_Control = &H0 Then read
        If flag_GMII_RX_DLL_Control = &H0 Then write_GMII_RX_DLL_Control_value = get_GMII_RX_DLL_Control

        regValue = leftShift((write_GMII_RX_DLL_Control_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        GMII_RX_DLL_Control_mask = &Hffff
        if data_low > LONG_MAX then
            if GMII_RX_DLL_Control_mask = mask then
                read_GMII_RX_DLL_Control_value = data_low
            else
                read_GMII_RX_DLL_Control_value = (data_low - H8000_0000) and GMII_RX_DLL_Control_mask
            end If
        else
            read_GMII_RX_DLL_Control_value = data_low and GMII_RX_DLL_Control_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_GMII_RX_DLL_Control_value = &H0
        flag_GMII_RX_DLL_Control        = &H0
    End Sub
End Class


'' @REGISTER : BRPHY_1G_1PORT_MISC_gmii_rx_dll_ctl_phase
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DLL_clock_phase                            [3:0]            get_DLL_clock_phase
''                                                             set_DLL_clock_phase
''                                                             read_DLL_clock_phase
''                                                             write_DLL_clock_phase
''---------------------------------------------------------------------------------
Class REGISTER_BRPHY_1G_1PORT_MISC_gmii_rx_dll_ctl_phase
    Private write_DLL_clock_phase_value
    Private read_DLL_clock_phase_value
    Private flag_DLL_clock_phase

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

    Property Get get_DLL_clock_phase
        get_DLL_clock_phase = read_DLL_clock_phase_value
    End Property

    Property Let set_DLL_clock_phase(aData)
        write_DLL_clock_phase_value = aData
        flag_DLL_clock_phase        = &H1
    End Property

    Property Get read_DLL_clock_phase
        read
        read_DLL_clock_phase = read_DLL_clock_phase_value
    End Property

    Property Let write_DLL_clock_phase(aData)
        set_DLL_clock_phase = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DLL_clock_phase_mask = &Hf
        if data_low > LONG_MAX then
            if DLL_clock_phase_mask = mask then
                read_DLL_clock_phase_value = data_low
            else
                read_DLL_clock_phase_value = (data_low - H8000_0000) and DLL_clock_phase_mask
            end If
        else
            read_DLL_clock_phase_value = data_low and DLL_clock_phase_mask
        end If

    End Sub

    Sub write
        If flag_DLL_clock_phase = &H0 Then read
        If flag_DLL_clock_phase = &H0 Then write_DLL_clock_phase_value = get_DLL_clock_phase

        regValue = leftShift((write_DLL_clock_phase_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DLL_clock_phase_mask = &Hf
        if data_low > LONG_MAX then
            if DLL_clock_phase_mask = mask then
                read_DLL_clock_phase_value = data_low
            else
                read_DLL_clock_phase_value = (data_low - H8000_0000) and DLL_clock_phase_mask
            end If
        else
            read_DLL_clock_phase_value = data_low and DLL_clock_phase_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DLL_clock_phase_value = &H0
        flag_DLL_clock_phase        = &H0
    End Sub
End Class


'' @REGISTER : BRPHY_1G_1PORT_MISC_pin_strap_status
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PIN_STRAP_STATUS                           [15:0]           get_PIN_STRAP_STATUS
''                                                             set_PIN_STRAP_STATUS
''                                                             read_PIN_STRAP_STATUS
''                                                             write_PIN_STRAP_STATUS
''---------------------------------------------------------------------------------
Class REGISTER_BRPHY_1G_1PORT_MISC_pin_strap_status
    Private write_PIN_STRAP_STATUS_value
    Private read_PIN_STRAP_STATUS_value
    Private flag_PIN_STRAP_STATUS

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

    Property Get get_PIN_STRAP_STATUS
        get_PIN_STRAP_STATUS = read_PIN_STRAP_STATUS_value
    End Property

    Property Let set_PIN_STRAP_STATUS(aData)
        write_PIN_STRAP_STATUS_value = aData
        flag_PIN_STRAP_STATUS        = &H1
    End Property

    Property Get read_PIN_STRAP_STATUS
        read
        read_PIN_STRAP_STATUS = read_PIN_STRAP_STATUS_value
    End Property

    Property Let write_PIN_STRAP_STATUS(aData)
        set_PIN_STRAP_STATUS = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PIN_STRAP_STATUS_mask = &Hffff
        if data_low > LONG_MAX then
            if PIN_STRAP_STATUS_mask = mask then
                read_PIN_STRAP_STATUS_value = data_low
            else
                read_PIN_STRAP_STATUS_value = (data_low - H8000_0000) and PIN_STRAP_STATUS_mask
            end If
        else
            read_PIN_STRAP_STATUS_value = data_low and PIN_STRAP_STATUS_mask
        end If

    End Sub

    Sub write
        If flag_PIN_STRAP_STATUS = &H0 Then read
        If flag_PIN_STRAP_STATUS = &H0 Then write_PIN_STRAP_STATUS_value = get_PIN_STRAP_STATUS

        regValue = leftShift((write_PIN_STRAP_STATUS_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PIN_STRAP_STATUS_mask = &Hffff
        if data_low > LONG_MAX then
            if PIN_STRAP_STATUS_mask = mask then
                read_PIN_STRAP_STATUS_value = data_low
            else
                read_PIN_STRAP_STATUS_value = (data_low - H8000_0000) and PIN_STRAP_STATUS_mask
            end If
        else
            read_PIN_STRAP_STATUS_value = data_low and PIN_STRAP_STATUS_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PIN_STRAP_STATUS_value = &H0
        flag_PIN_STRAP_STATUS        = &H0
    End Sub
End Class


'' @REGISTER : BRPHY_1G_1PORT_MISC_spare_end_addr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SPARE_END_ADDR                             [15:0]           get_SPARE_END_ADDR
''                                                             set_SPARE_END_ADDR
''                                                             read_SPARE_END_ADDR
''                                                             write_SPARE_END_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_BRPHY_1G_1PORT_MISC_spare_end_addr
    Private write_SPARE_END_ADDR_value
    Private read_SPARE_END_ADDR_value
    Private flag_SPARE_END_ADDR

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H53e
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_SPARE_END_ADDR
        get_SPARE_END_ADDR = read_SPARE_END_ADDR_value
    End Property

    Property Let set_SPARE_END_ADDR(aData)
        write_SPARE_END_ADDR_value = aData
        flag_SPARE_END_ADDR        = &H1
    End Property

    Property Get read_SPARE_END_ADDR
        read
        read_SPARE_END_ADDR = read_SPARE_END_ADDR_value
    End Property

    Property Let write_SPARE_END_ADDR(aData)
        set_SPARE_END_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SPARE_END_ADDR_mask = &Hffff
        if data_low > LONG_MAX then
            if SPARE_END_ADDR_mask = mask then
                read_SPARE_END_ADDR_value = data_low
            else
                read_SPARE_END_ADDR_value = (data_low - H8000_0000) and SPARE_END_ADDR_mask
            end If
        else
            read_SPARE_END_ADDR_value = data_low and SPARE_END_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_SPARE_END_ADDR = &H0 Then read
        If flag_SPARE_END_ADDR = &H0 Then write_SPARE_END_ADDR_value = get_SPARE_END_ADDR

        regValue = leftShift((write_SPARE_END_ADDR_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SPARE_END_ADDR_mask = &Hffff
        if data_low > LONG_MAX then
            if SPARE_END_ADDR_mask = mask then
                read_SPARE_END_ADDR_value = data_low
            else
                read_SPARE_END_ADDR_value = (data_low - H8000_0000) and SPARE_END_ADDR_mask
            end If
        else
            read_SPARE_END_ADDR_value = data_low and SPARE_END_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SPARE_END_ADDR_value = &H0
        flag_SPARE_END_ADDR        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class BRPHY_1G_1PORT_MISC_INSTANCE

    Public top_misc_register_1
    Public test_select_mode
    Public tpin_sel_15_00
    Public tpin_sel_18_16
    Public tpin_reg_15_00
    Public tpin_reg_18_16
    Public tpout_reg_15_00
    Public tpout_reg_18_16
    Public rgmii_control
    Public rgmii_control2
    Public rgmii_rx_char_pattern
    Public rgmii_tx_char_pattern_cmp
    Public rgmii_tx_char_pattern
    Public swreg_cntl_rgmii_sgmii_sel
    Public sgmii_aux_ctl
    Public sgmii_hw_rst_dly_val
    Public sgmii_mdio_rst_dly_val
    Public sgmii_pll_rst_dly_val
    Public sgmii_base_page
    Public sgmii_aux_status
    Public sgmii_tmux
    Public led_intr_ctl
    Public man_pga_ctl
    Public vtmon_ana_cntrl
    Public vtmon_cntrl
    Public temp_data
    Public temp_thresh_high
    Public temp_thresh_low
    Public v1p0_data
    Public v1p0_thresh_high
    Public v1p0_thresh_low
    Public v3p3_2p5_data
    Public v3p3_2p5_thresh_high
    Public v3p3_2p5_thresh_low
    Public vtmon_intr
    Public v1p8_data
    Public v1p8_thresh_high
    Public v1p8_thresh_low
    Public xtal_osc_ctrl1
    Public xtal_osc_ctrl2
    Public vreg_cntl_1
    Public vreg_cntl_2
    Public prod_ctrl0
    Public prod_ctrl1
    Public adccal_enable
    Public otp_p1588_rd_ctl
    Public otp_p1588_icv1_0
    Public otp_p1588_icv1_1
    Public otp_p1588_icv1_2
    Public otp_p1588_icv1_3
    Public otp_p1588_icv1_4
    Public otp_p1588_icv1_5
    Public otp_p1588_icv1_6
    Public otp_p1588_icv1_7
    Public otp_p1588_icv2_0
    Public otp_p1588_icv2_1
    Public otp_p1588_icv2_2
    Public otp_p1588_icv2_3
    Public otp_p1588_icv2_4
    Public otp_p1588_icv2_5
    Public otp_p1588_icv2_6
    Public otp_p1588_icv2_7
    Public otp_p1588_icv3_0
    Public otp_p1588_icv3_1
    Public otp_p1588_icv3_2
    Public otp_p1588_icv3_3
    Public otp_p1588_icv3_4
    Public otp_p1588_icv3_5
    Public otp_p1588_icv3_6
    Public otp_p1588_icv3_7
    Public otp_p1588_icv4_0
    Public otp_p1588_icv4_1
    Public otp_p1588_icv4_2
    Public otp_p1588_icv4_3
    Public otp_p1588_icv4_4
    Public otp_p1588_icv4_5
    Public otp_p1588_icv4_6
    Public otp_p1588_icv4_7
    Public otp_p1588_rd_status
    Public wr_disable_protect_status_0
    Public wr_en_protect_status_0
    Public addr_start_prot_0
    Public addr_end_prot_0
    Public gmii_rx_fifo_ctl
    Public gmii_rx_dll_ctl
    Public gmii_rx_dll_ctl_phase
    Public pin_strap_status
    Public spare_end_addr


    Public default function Init(aBaseAddr)
        Set top_misc_register_1 = (New REGISTER_BRPHY_1G_1PORT_MISC_top_misc_register_1)(aBaseAddr, 16)
        Set test_select_mode = (New REGISTER_BRPHY_1G_1PORT_MISC_test_select_mode)(aBaseAddr, 16)
        Set tpin_sel_15_00 = (New REGISTER_BRPHY_1G_1PORT_MISC_tpin_sel_15_00)(aBaseAddr, 16)
        Set tpin_sel_18_16 = (New REGISTER_BRPHY_1G_1PORT_MISC_tpin_sel_18_16)(aBaseAddr, 16)
        Set tpin_reg_15_00 = (New REGISTER_BRPHY_1G_1PORT_MISC_tpin_reg_15_00)(aBaseAddr, 16)
        Set tpin_reg_18_16 = (New REGISTER_BRPHY_1G_1PORT_MISC_tpin_reg_18_16)(aBaseAddr, 16)
        Set tpout_reg_15_00 = (New REGISTER_BRPHY_1G_1PORT_MISC_tpout_reg_15_00)(aBaseAddr, 16)
        Set tpout_reg_18_16 = (New REGISTER_BRPHY_1G_1PORT_MISC_tpout_reg_18_16)(aBaseAddr, 16)
        Set rgmii_control = (New REGISTER_BRPHY_1G_1PORT_MISC_rgmii_control)(aBaseAddr, 16)
        Set rgmii_control2 = (New REGISTER_BRPHY_1G_1PORT_MISC_rgmii_control2)(aBaseAddr, 16)
        Set rgmii_rx_char_pattern = (New REGISTER_BRPHY_1G_1PORT_MISC_rgmii_rx_char_pattern)(aBaseAddr, 16)
        Set rgmii_tx_char_pattern_cmp = (New REGISTER_BRPHY_1G_1PORT_MISC_rgmii_tx_char_pattern_cmp)(aBaseAddr, 16)
        Set rgmii_tx_char_pattern = (New REGISTER_BRPHY_1G_1PORT_MISC_rgmii_tx_char_pattern)(aBaseAddr, 16)
        Set swreg_cntl_rgmii_sgmii_sel = (New REGISTER_BRPHY_1G_1PORT_MISC_swreg_cntl_rgmii_sgmii_sel)(aBaseAddr, 16)
        Set sgmii_aux_ctl = (New REGISTER_BRPHY_1G_1PORT_MISC_sgmii_aux_ctl)(aBaseAddr, 16)
        Set sgmii_hw_rst_dly_val = (New REGISTER_BRPHY_1G_1PORT_MISC_sgmii_hw_rst_dly_val)(aBaseAddr, 16)
        Set sgmii_mdio_rst_dly_val = (New REGISTER_BRPHY_1G_1PORT_MISC_sgmii_mdio_rst_dly_val)(aBaseAddr, 16)
        Set sgmii_pll_rst_dly_val = (New REGISTER_BRPHY_1G_1PORT_MISC_sgmii_pll_rst_dly_val)(aBaseAddr, 16)
        Set sgmii_base_page = (New REGISTER_BRPHY_1G_1PORT_MISC_sgmii_base_page)(aBaseAddr, 16)
        Set sgmii_aux_status = (New REGISTER_BRPHY_1G_1PORT_MISC_sgmii_aux_status)(aBaseAddr, 16)
        Set sgmii_tmux = (New REGISTER_BRPHY_1G_1PORT_MISC_sgmii_tmux)(aBaseAddr, 16)
        Set led_intr_ctl = (New REGISTER_BRPHY_1G_1PORT_MISC_led_intr_ctl)(aBaseAddr, 16)
        Set man_pga_ctl = (New REGISTER_BRPHY_1G_1PORT_MISC_man_pga_ctl)(aBaseAddr, 16)
        Set vtmon_ana_cntrl = (New REGISTER_BRPHY_1G_1PORT_MISC_vtmon_ana_cntrl)(aBaseAddr, 16)
        Set vtmon_cntrl = (New REGISTER_BRPHY_1G_1PORT_MISC_vtmon_cntrl)(aBaseAddr, 16)
        Set temp_data = (New REGISTER_BRPHY_1G_1PORT_MISC_temp_data)(aBaseAddr, 16)
        Set temp_thresh_high = (New REGISTER_BRPHY_1G_1PORT_MISC_temp_thresh_high)(aBaseAddr, 16)
        Set temp_thresh_low = (New REGISTER_BRPHY_1G_1PORT_MISC_temp_thresh_low)(aBaseAddr, 16)
        Set v1p0_data = (New REGISTER_BRPHY_1G_1PORT_MISC_v1p0_data)(aBaseAddr, 16)
        Set v1p0_thresh_high = (New REGISTER_BRPHY_1G_1PORT_MISC_v1p0_thresh_high)(aBaseAddr, 16)
        Set v1p0_thresh_low = (New REGISTER_BRPHY_1G_1PORT_MISC_v1p0_thresh_low)(aBaseAddr, 16)
        Set v3p3_2p5_data = (New REGISTER_BRPHY_1G_1PORT_MISC_v3p3_2p5_data)(aBaseAddr, 16)
        Set v3p3_2p5_thresh_high = (New REGISTER_BRPHY_1G_1PORT_MISC_v3p3_2p5_thresh_high)(aBaseAddr, 16)
        Set v3p3_2p5_thresh_low = (New REGISTER_BRPHY_1G_1PORT_MISC_v3p3_2p5_thresh_low)(aBaseAddr, 16)
        Set vtmon_intr = (New REGISTER_BRPHY_1G_1PORT_MISC_vtmon_intr)(aBaseAddr, 16)
        Set v1p8_data = (New REGISTER_BRPHY_1G_1PORT_MISC_v1p8_data)(aBaseAddr, 16)
        Set v1p8_thresh_high = (New REGISTER_BRPHY_1G_1PORT_MISC_v1p8_thresh_high)(aBaseAddr, 16)
        Set v1p8_thresh_low = (New REGISTER_BRPHY_1G_1PORT_MISC_v1p8_thresh_low)(aBaseAddr, 16)
        Set xtal_osc_ctrl1 = (New REGISTER_BRPHY_1G_1PORT_MISC_xtal_osc_ctrl1)(aBaseAddr, 16)
        Set xtal_osc_ctrl2 = (New REGISTER_BRPHY_1G_1PORT_MISC_xtal_osc_ctrl2)(aBaseAddr, 16)
        Set vreg_cntl_1 = (New REGISTER_BRPHY_1G_1PORT_MISC_vreg_cntl_1)(aBaseAddr, 16)
        Set vreg_cntl_2 = (New REGISTER_BRPHY_1G_1PORT_MISC_vreg_cntl_2)(aBaseAddr, 16)
        Set prod_ctrl0 = (New REGISTER_BRPHY_1G_1PORT_MISC_prod_ctrl0)(aBaseAddr, 16)
        Set prod_ctrl1 = (New REGISTER_BRPHY_1G_1PORT_MISC_prod_ctrl1)(aBaseAddr, 16)
        Set adccal_enable = (New REGISTER_BRPHY_1G_1PORT_MISC_adccal_enable)(aBaseAddr, 16)
        Set otp_p1588_rd_ctl = (New REGISTER_BRPHY_1G_1PORT_MISC_otp_p1588_rd_ctl)(aBaseAddr, 16)
        Set otp_p1588_icv1_0 = (New REGISTER_BRPHY_1G_1PORT_MISC_otp_p1588_icv1_0)(aBaseAddr, 16)
        Set otp_p1588_icv1_1 = (New REGISTER_BRPHY_1G_1PORT_MISC_otp_p1588_icv1_1)(aBaseAddr, 16)
        Set otp_p1588_icv1_2 = (New REGISTER_BRPHY_1G_1PORT_MISC_otp_p1588_icv1_2)(aBaseAddr, 16)
        Set otp_p1588_icv1_3 = (New REGISTER_BRPHY_1G_1PORT_MISC_otp_p1588_icv1_3)(aBaseAddr, 16)
        Set otp_p1588_icv1_4 = (New REGISTER_BRPHY_1G_1PORT_MISC_otp_p1588_icv1_4)(aBaseAddr, 16)
        Set otp_p1588_icv1_5 = (New REGISTER_BRPHY_1G_1PORT_MISC_otp_p1588_icv1_5)(aBaseAddr, 16)
        Set otp_p1588_icv1_6 = (New REGISTER_BRPHY_1G_1PORT_MISC_otp_p1588_icv1_6)(aBaseAddr, 16)
        Set otp_p1588_icv1_7 = (New REGISTER_BRPHY_1G_1PORT_MISC_otp_p1588_icv1_7)(aBaseAddr, 16)
        Set otp_p1588_icv2_0 = (New REGISTER_BRPHY_1G_1PORT_MISC_otp_p1588_icv2_0)(aBaseAddr, 16)
        Set otp_p1588_icv2_1 = (New REGISTER_BRPHY_1G_1PORT_MISC_otp_p1588_icv2_1)(aBaseAddr, 16)
        Set otp_p1588_icv2_2 = (New REGISTER_BRPHY_1G_1PORT_MISC_otp_p1588_icv2_2)(aBaseAddr, 16)
        Set otp_p1588_icv2_3 = (New REGISTER_BRPHY_1G_1PORT_MISC_otp_p1588_icv2_3)(aBaseAddr, 16)
        Set otp_p1588_icv2_4 = (New REGISTER_BRPHY_1G_1PORT_MISC_otp_p1588_icv2_4)(aBaseAddr, 16)
        Set otp_p1588_icv2_5 = (New REGISTER_BRPHY_1G_1PORT_MISC_otp_p1588_icv2_5)(aBaseAddr, 16)
        Set otp_p1588_icv2_6 = (New REGISTER_BRPHY_1G_1PORT_MISC_otp_p1588_icv2_6)(aBaseAddr, 16)
        Set otp_p1588_icv2_7 = (New REGISTER_BRPHY_1G_1PORT_MISC_otp_p1588_icv2_7)(aBaseAddr, 16)
        Set otp_p1588_icv3_0 = (New REGISTER_BRPHY_1G_1PORT_MISC_otp_p1588_icv3_0)(aBaseAddr, 16)
        Set otp_p1588_icv3_1 = (New REGISTER_BRPHY_1G_1PORT_MISC_otp_p1588_icv3_1)(aBaseAddr, 16)
        Set otp_p1588_icv3_2 = (New REGISTER_BRPHY_1G_1PORT_MISC_otp_p1588_icv3_2)(aBaseAddr, 16)
        Set otp_p1588_icv3_3 = (New REGISTER_BRPHY_1G_1PORT_MISC_otp_p1588_icv3_3)(aBaseAddr, 16)
        Set otp_p1588_icv3_4 = (New REGISTER_BRPHY_1G_1PORT_MISC_otp_p1588_icv3_4)(aBaseAddr, 16)
        Set otp_p1588_icv3_5 = (New REGISTER_BRPHY_1G_1PORT_MISC_otp_p1588_icv3_5)(aBaseAddr, 16)
        Set otp_p1588_icv3_6 = (New REGISTER_BRPHY_1G_1PORT_MISC_otp_p1588_icv3_6)(aBaseAddr, 16)
        Set otp_p1588_icv3_7 = (New REGISTER_BRPHY_1G_1PORT_MISC_otp_p1588_icv3_7)(aBaseAddr, 16)
        Set otp_p1588_icv4_0 = (New REGISTER_BRPHY_1G_1PORT_MISC_otp_p1588_icv4_0)(aBaseAddr, 16)
        Set otp_p1588_icv4_1 = (New REGISTER_BRPHY_1G_1PORT_MISC_otp_p1588_icv4_1)(aBaseAddr, 16)
        Set otp_p1588_icv4_2 = (New REGISTER_BRPHY_1G_1PORT_MISC_otp_p1588_icv4_2)(aBaseAddr, 16)
        Set otp_p1588_icv4_3 = (New REGISTER_BRPHY_1G_1PORT_MISC_otp_p1588_icv4_3)(aBaseAddr, 16)
        Set otp_p1588_icv4_4 = (New REGISTER_BRPHY_1G_1PORT_MISC_otp_p1588_icv4_4)(aBaseAddr, 16)
        Set otp_p1588_icv4_5 = (New REGISTER_BRPHY_1G_1PORT_MISC_otp_p1588_icv4_5)(aBaseAddr, 16)
        Set otp_p1588_icv4_6 = (New REGISTER_BRPHY_1G_1PORT_MISC_otp_p1588_icv4_6)(aBaseAddr, 16)
        Set otp_p1588_icv4_7 = (New REGISTER_BRPHY_1G_1PORT_MISC_otp_p1588_icv4_7)(aBaseAddr, 16)
        Set otp_p1588_rd_status = (New REGISTER_BRPHY_1G_1PORT_MISC_otp_p1588_rd_status)(aBaseAddr, 16)
        Set wr_disable_protect_status_0 = (New REGISTER_BRPHY_1G_1PORT_MISC_wr_disable_protect_status_0)(aBaseAddr, 16)
        Set wr_en_protect_status_0 = (New REGISTER_BRPHY_1G_1PORT_MISC_wr_en_protect_status_0)(aBaseAddr, 16)
        Set addr_start_prot_0 = (New REGISTER_BRPHY_1G_1PORT_MISC_addr_start_prot_0)(aBaseAddr, 16)
        Set addr_end_prot_0 = (New REGISTER_BRPHY_1G_1PORT_MISC_addr_end_prot_0)(aBaseAddr, 16)
        Set gmii_rx_fifo_ctl = (New REGISTER_BRPHY_1G_1PORT_MISC_gmii_rx_fifo_ctl)(aBaseAddr, 16)
        Set gmii_rx_dll_ctl = (New REGISTER_BRPHY_1G_1PORT_MISC_gmii_rx_dll_ctl)(aBaseAddr, 16)
        Set gmii_rx_dll_ctl_phase = (New REGISTER_BRPHY_1G_1PORT_MISC_gmii_rx_dll_ctl_phase)(aBaseAddr, 16)
        Set pin_strap_status = (New REGISTER_BRPHY_1G_1PORT_MISC_pin_strap_status)(aBaseAddr, 16)
        Set spare_end_addr = (New REGISTER_BRPHY_1G_1PORT_MISC_spare_end_addr)(aBaseAddr, 16)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set BRPHY_1G_1PORT_MISC = CreateObject("System.Collections.ArrayList")
BRPHY_1G_1PORT_MISC.Add ((New BRPHY_1G_1PORT_MISC_INSTANCE)(&H49034000))


