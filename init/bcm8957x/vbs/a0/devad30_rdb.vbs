

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


'' @REGISTER : DEVAD30_strap_register_1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' RESERVED_15_14                             [15:14]          get_RESERVED_15_14
''                                                             set_RESERVED_15_14
''                                                             read_RESERVED_15_14
''                                                             write_RESERVED_15_14
''---------------------------------------------------------------------------------
'' TC10_POWER_DOWN_RESET_SELECT               [13:13]          get_TC10_POWER_DOWN_RESET_SELECT
''                                                             set_TC10_POWER_DOWN_RESET_SELECT
''                                                             read_TC10_POWER_DOWN_RESET_SELECT
''                                                             write_TC10_POWER_DOWN_RESET_SELECT
''---------------------------------------------------------------------------------
'' RESERVED_12_0                              [12:0]           get_RESERVED_12_0
''                                                             set_RESERVED_12_0
''                                                             read_RESERVED_12_0
''                                                             write_RESERVED_12_0
''---------------------------------------------------------------------------------
Class REGISTER_DEVAD30_strap_register_1
    Private write_RESERVED_15_14_value
    Private read_RESERVED_15_14_value
    Private flag_RESERVED_15_14
    Private write_TC10_POWER_DOWN_RESET_SELECT_value
    Private read_TC10_POWER_DOWN_RESET_SELECT_value
    Private flag_TC10_POWER_DOWN_RESET_SELECT
    Private write_RESERVED_12_0_value
    Private read_RESERVED_12_0_value
    Private flag_RESERVED_12_0

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

    Property Get get_RESERVED_15_14
        get_RESERVED_15_14 = read_RESERVED_15_14_value
    End Property

    Property Let set_RESERVED_15_14(aData)
        write_RESERVED_15_14_value = aData
        flag_RESERVED_15_14        = &H1
    End Property

    Property Get read_RESERVED_15_14
        read
        read_RESERVED_15_14 = read_RESERVED_15_14_value
    End Property

    Property Let write_RESERVED_15_14(aData)
        set_RESERVED_15_14 = aData
        write
    End Property

    Property Get get_TC10_POWER_DOWN_RESET_SELECT
        get_TC10_POWER_DOWN_RESET_SELECT = read_TC10_POWER_DOWN_RESET_SELECT_value
    End Property

    Property Let set_TC10_POWER_DOWN_RESET_SELECT(aData)
        write_TC10_POWER_DOWN_RESET_SELECT_value = aData
        flag_TC10_POWER_DOWN_RESET_SELECT        = &H1
    End Property

    Property Get read_TC10_POWER_DOWN_RESET_SELECT
        read
        read_TC10_POWER_DOWN_RESET_SELECT = read_TC10_POWER_DOWN_RESET_SELECT_value
    End Property

    Property Let write_TC10_POWER_DOWN_RESET_SELECT(aData)
        set_TC10_POWER_DOWN_RESET_SELECT = aData
        write
    End Property

    Property Get get_RESERVED_12_0
        get_RESERVED_12_0 = read_RESERVED_12_0_value
    End Property

    Property Let set_RESERVED_12_0(aData)
        write_RESERVED_12_0_value = aData
        flag_RESERVED_12_0        = &H1
    End Property

    Property Get read_RESERVED_12_0
        read
        read_RESERVED_12_0 = read_RESERVED_12_0_value
    End Property

    Property Let write_RESERVED_12_0(aData)
        set_RESERVED_12_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_RESERVED_15_14_value = rightShift(data_low, 14) and &H3
        read_TC10_POWER_DOWN_RESET_SELECT_value = rightShift(data_low, 13) and &H1
        RESERVED_12_0_mask = &H1fff
        if data_low > LONG_MAX then
            if RESERVED_12_0_mask = mask then
                read_RESERVED_12_0_value = data_low
            else
                read_RESERVED_12_0_value = (data_low - H8000_0000) and RESERVED_12_0_mask
            end If
        else
            read_RESERVED_12_0_value = data_low and RESERVED_12_0_mask
        end If

    End Sub

    Sub write
        If flag_RESERVED_15_14 = &H0 or flag_TC10_POWER_DOWN_RESET_SELECT = &H0 or flag_RESERVED_12_0 = &H0 Then read
        If flag_RESERVED_15_14 = &H0 Then write_RESERVED_15_14_value = get_RESERVED_15_14
        If flag_TC10_POWER_DOWN_RESET_SELECT = &H0 Then write_TC10_POWER_DOWN_RESET_SELECT_value = get_TC10_POWER_DOWN_RESET_SELECT
        If flag_RESERVED_12_0 = &H0 Then write_RESERVED_12_0_value = get_RESERVED_12_0

        regValue = leftShift((write_RESERVED_15_14_value and &H3), 14) + leftShift((write_TC10_POWER_DOWN_RESET_SELECT_value and &H1), 13) + leftShift((write_RESERVED_12_0_value and &H1fff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_RESERVED_15_14_value = rightShift(data_low, 14) and &H3
        read_TC10_POWER_DOWN_RESET_SELECT_value = rightShift(data_low, 13) and &H1
        RESERVED_12_0_mask = &H1fff
        if data_low > LONG_MAX then
            if RESERVED_12_0_mask = mask then
                read_RESERVED_12_0_value = data_low
            else
                read_RESERVED_12_0_value = (data_low - H8000_0000) and RESERVED_12_0_mask
            end If
        else
            read_RESERVED_12_0_value = data_low and RESERVED_12_0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_RESERVED_15_14_value = &H0
        flag_RESERVED_15_14        = &H0
        write_TC10_POWER_DOWN_RESET_SELECT_value = &H0
        flag_TC10_POWER_DOWN_RESET_SELECT        = &H0
        write_RESERVED_12_0_value = &H0
        flag_RESERVED_12_0        = &H0
    End Sub
End Class


'' @REGISTER : DEVAD30_strap_register_2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' RESERVED_15                                [15:15]          get_RESERVED_15
''                                                             set_RESERVED_15
''                                                             read_RESERVED_15
''                                                             write_RESERVED_15
''---------------------------------------------------------------------------------
'' AFE_PLL_FORCED_ON                          [14:14]          get_AFE_PLL_FORCED_ON
''                                                             set_AFE_PLL_FORCED_ON
''                                                             read_AFE_PLL_FORCED_ON
''                                                             write_AFE_PLL_FORCED_ON
''---------------------------------------------------------------------------------
'' Strap_register_bits_unused13_6             [13:6]           get_Strap_register_bits_unused13_6
''                                                             set_Strap_register_bits_unused13_6
''                                                             read_Strap_register_bits_unused13_6
''                                                             write_Strap_register_bits_unused13_6
''---------------------------------------------------------------------------------
'' Autospeed_enable_default                   [5:5]            get_Autospeed_enable_default
''                                                             set_Autospeed_enable_default
''                                                             read_Autospeed_enable_default
''                                                             write_Autospeed_enable_default
''---------------------------------------------------------------------------------
'' Master_slave_default                       [4:4]            get_Master_slave_default
''                                                             set_Master_slave_default
''                                                             read_Master_slave_default
''                                                             write_Master_slave_default
''---------------------------------------------------------------------------------
'' Auto_neg_en_default                        [3:3]            get_Auto_neg_en_default
''                                                             set_Auto_neg_en_default
''                                                             read_Auto_neg_en_default
''                                                             write_Auto_neg_en_default
''---------------------------------------------------------------------------------
'' Ability_1000base_t1                        [2:2]            get_Ability_1000base_t1
''                                                             set_Ability_1000base_t1
''                                                             read_Ability_1000base_t1
''                                                             write_Ability_1000base_t1
''---------------------------------------------------------------------------------
'' Ability_100base_t1                         [1:1]            get_Ability_100base_t1
''                                                             set_Ability_100base_t1
''                                                             read_Ability_100base_t1
''                                                             write_Ability_100base_t1
''---------------------------------------------------------------------------------
'' Auto_neg_imp                               [0:0]            get_Auto_neg_imp
''                                                             set_Auto_neg_imp
''                                                             read_Auto_neg_imp
''                                                             write_Auto_neg_imp
''---------------------------------------------------------------------------------
Class REGISTER_DEVAD30_strap_register_2
    Private write_RESERVED_15_value
    Private read_RESERVED_15_value
    Private flag_RESERVED_15
    Private write_AFE_PLL_FORCED_ON_value
    Private read_AFE_PLL_FORCED_ON_value
    Private flag_AFE_PLL_FORCED_ON
    Private write_Strap_register_bits_unused13_6_value
    Private read_Strap_register_bits_unused13_6_value
    Private flag_Strap_register_bits_unused13_6
    Private write_Autospeed_enable_default_value
    Private read_Autospeed_enable_default_value
    Private flag_Autospeed_enable_default
    Private write_Master_slave_default_value
    Private read_Master_slave_default_value
    Private flag_Master_slave_default
    Private write_Auto_neg_en_default_value
    Private read_Auto_neg_en_default_value
    Private flag_Auto_neg_en_default
    Private write_Ability_1000base_t1_value
    Private read_Ability_1000base_t1_value
    Private flag_Ability_1000base_t1
    Private write_Ability_100base_t1_value
    Private read_Ability_100base_t1_value
    Private flag_Ability_100base_t1
    Private write_Auto_neg_imp_value
    Private read_Auto_neg_imp_value
    Private flag_Auto_neg_imp

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

    Property Get get_RESERVED_15
        get_RESERVED_15 = read_RESERVED_15_value
    End Property

    Property Let set_RESERVED_15(aData)
        write_RESERVED_15_value = aData
        flag_RESERVED_15        = &H1
    End Property

    Property Get read_RESERVED_15
        read
        read_RESERVED_15 = read_RESERVED_15_value
    End Property

    Property Let write_RESERVED_15(aData)
        set_RESERVED_15 = aData
        write
    End Property

    Property Get get_AFE_PLL_FORCED_ON
        get_AFE_PLL_FORCED_ON = read_AFE_PLL_FORCED_ON_value
    End Property

    Property Let set_AFE_PLL_FORCED_ON(aData)
        write_AFE_PLL_FORCED_ON_value = aData
        flag_AFE_PLL_FORCED_ON        = &H1
    End Property

    Property Get read_AFE_PLL_FORCED_ON
        read
        read_AFE_PLL_FORCED_ON = read_AFE_PLL_FORCED_ON_value
    End Property

    Property Let write_AFE_PLL_FORCED_ON(aData)
        set_AFE_PLL_FORCED_ON = aData
        write
    End Property

    Property Get get_Strap_register_bits_unused13_6
        get_Strap_register_bits_unused13_6 = read_Strap_register_bits_unused13_6_value
    End Property

    Property Let set_Strap_register_bits_unused13_6(aData)
        write_Strap_register_bits_unused13_6_value = aData
        flag_Strap_register_bits_unused13_6        = &H1
    End Property

    Property Get read_Strap_register_bits_unused13_6
        read
        read_Strap_register_bits_unused13_6 = read_Strap_register_bits_unused13_6_value
    End Property

    Property Let write_Strap_register_bits_unused13_6(aData)
        set_Strap_register_bits_unused13_6 = aData
        write
    End Property

    Property Get get_Autospeed_enable_default
        get_Autospeed_enable_default = read_Autospeed_enable_default_value
    End Property

    Property Let set_Autospeed_enable_default(aData)
        write_Autospeed_enable_default_value = aData
        flag_Autospeed_enable_default        = &H1
    End Property

    Property Get read_Autospeed_enable_default
        read
        read_Autospeed_enable_default = read_Autospeed_enable_default_value
    End Property

    Property Let write_Autospeed_enable_default(aData)
        set_Autospeed_enable_default = aData
        write
    End Property

    Property Get get_Master_slave_default
        get_Master_slave_default = read_Master_slave_default_value
    End Property

    Property Let set_Master_slave_default(aData)
        write_Master_slave_default_value = aData
        flag_Master_slave_default        = &H1
    End Property

    Property Get read_Master_slave_default
        read
        read_Master_slave_default = read_Master_slave_default_value
    End Property

    Property Let write_Master_slave_default(aData)
        set_Master_slave_default = aData
        write
    End Property

    Property Get get_Auto_neg_en_default
        get_Auto_neg_en_default = read_Auto_neg_en_default_value
    End Property

    Property Let set_Auto_neg_en_default(aData)
        write_Auto_neg_en_default_value = aData
        flag_Auto_neg_en_default        = &H1
    End Property

    Property Get read_Auto_neg_en_default
        read
        read_Auto_neg_en_default = read_Auto_neg_en_default_value
    End Property

    Property Let write_Auto_neg_en_default(aData)
        set_Auto_neg_en_default = aData
        write
    End Property

    Property Get get_Ability_1000base_t1
        get_Ability_1000base_t1 = read_Ability_1000base_t1_value
    End Property

    Property Let set_Ability_1000base_t1(aData)
        write_Ability_1000base_t1_value = aData
        flag_Ability_1000base_t1        = &H1
    End Property

    Property Get read_Ability_1000base_t1
        read
        read_Ability_1000base_t1 = read_Ability_1000base_t1_value
    End Property

    Property Let write_Ability_1000base_t1(aData)
        set_Ability_1000base_t1 = aData
        write
    End Property

    Property Get get_Ability_100base_t1
        get_Ability_100base_t1 = read_Ability_100base_t1_value
    End Property

    Property Let set_Ability_100base_t1(aData)
        write_Ability_100base_t1_value = aData
        flag_Ability_100base_t1        = &H1
    End Property

    Property Get read_Ability_100base_t1
        read
        read_Ability_100base_t1 = read_Ability_100base_t1_value
    End Property

    Property Let write_Ability_100base_t1(aData)
        set_Ability_100base_t1 = aData
        write
    End Property

    Property Get get_Auto_neg_imp
        get_Auto_neg_imp = read_Auto_neg_imp_value
    End Property

    Property Let set_Auto_neg_imp(aData)
        write_Auto_neg_imp_value = aData
        flag_Auto_neg_imp        = &H1
    End Property

    Property Get read_Auto_neg_imp
        read
        read_Auto_neg_imp = read_Auto_neg_imp_value
    End Property

    Property Let write_Auto_neg_imp(aData)
        set_Auto_neg_imp = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_RESERVED_15_value = rightShift(data_low, 15) and &H1
        read_AFE_PLL_FORCED_ON_value = rightShift(data_low, 14) and &H1
        read_Strap_register_bits_unused13_6_value = rightShift(data_low, 6) and &Hff
        read_Autospeed_enable_default_value = rightShift(data_low, 5) and &H1
        read_Master_slave_default_value = rightShift(data_low, 4) and &H1
        read_Auto_neg_en_default_value = rightShift(data_low, 3) and &H1
        read_Ability_1000base_t1_value = rightShift(data_low, 2) and &H1
        read_Ability_100base_t1_value = rightShift(data_low, 1) and &H1
        Auto_neg_imp_mask = &H1
        if data_low > LONG_MAX then
            if Auto_neg_imp_mask = mask then
                read_Auto_neg_imp_value = data_low
            else
                read_Auto_neg_imp_value = (data_low - H8000_0000) and Auto_neg_imp_mask
            end If
        else
            read_Auto_neg_imp_value = data_low and Auto_neg_imp_mask
        end If

    End Sub

    Sub write
        If flag_RESERVED_15 = &H0 or flag_AFE_PLL_FORCED_ON = &H0 or flag_Strap_register_bits_unused13_6 = &H0 or flag_Autospeed_enable_default = &H0 or flag_Master_slave_default = &H0 or flag_Auto_neg_en_default = &H0 or flag_Ability_1000base_t1 = &H0 or flag_Ability_100base_t1 = &H0 or flag_Auto_neg_imp = &H0 Then read
        If flag_RESERVED_15 = &H0 Then write_RESERVED_15_value = get_RESERVED_15
        If flag_AFE_PLL_FORCED_ON = &H0 Then write_AFE_PLL_FORCED_ON_value = get_AFE_PLL_FORCED_ON
        If flag_Strap_register_bits_unused13_6 = &H0 Then write_Strap_register_bits_unused13_6_value = get_Strap_register_bits_unused13_6
        If flag_Autospeed_enable_default = &H0 Then write_Autospeed_enable_default_value = get_Autospeed_enable_default
        If flag_Master_slave_default = &H0 Then write_Master_slave_default_value = get_Master_slave_default
        If flag_Auto_neg_en_default = &H0 Then write_Auto_neg_en_default_value = get_Auto_neg_en_default
        If flag_Ability_1000base_t1 = &H0 Then write_Ability_1000base_t1_value = get_Ability_1000base_t1
        If flag_Ability_100base_t1 = &H0 Then write_Ability_100base_t1_value = get_Ability_100base_t1
        If flag_Auto_neg_imp = &H0 Then write_Auto_neg_imp_value = get_Auto_neg_imp

        regValue = leftShift((write_RESERVED_15_value and &H1), 15) + leftShift((write_AFE_PLL_FORCED_ON_value and &H1), 14) + leftShift((write_Strap_register_bits_unused13_6_value and &Hff), 6) + leftShift((write_Autospeed_enable_default_value and &H1), 5) + leftShift((write_Master_slave_default_value and &H1), 4) + leftShift((write_Auto_neg_en_default_value and &H1), 3) + leftShift((write_Ability_1000base_t1_value and &H1), 2) + leftShift((write_Ability_100base_t1_value and &H1), 1) + leftShift((write_Auto_neg_imp_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_RESERVED_15_value = rightShift(data_low, 15) and &H1
        read_AFE_PLL_FORCED_ON_value = rightShift(data_low, 14) and &H1
        read_Strap_register_bits_unused13_6_value = rightShift(data_low, 6) and &Hff
        read_Autospeed_enable_default_value = rightShift(data_low, 5) and &H1
        read_Master_slave_default_value = rightShift(data_low, 4) and &H1
        read_Auto_neg_en_default_value = rightShift(data_low, 3) and &H1
        read_Ability_1000base_t1_value = rightShift(data_low, 2) and &H1
        read_Ability_100base_t1_value = rightShift(data_low, 1) and &H1
        Auto_neg_imp_mask = &H1
        if data_low > LONG_MAX then
            if Auto_neg_imp_mask = mask then
                read_Auto_neg_imp_value = data_low
            else
                read_Auto_neg_imp_value = (data_low - H8000_0000) and Auto_neg_imp_mask
            end If
        else
            read_Auto_neg_imp_value = data_low and Auto_neg_imp_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_RESERVED_15_value = &H0
        flag_RESERVED_15        = &H0
        write_AFE_PLL_FORCED_ON_value = &H0
        flag_AFE_PLL_FORCED_ON        = &H0
        write_Strap_register_bits_unused13_6_value = &H0
        flag_Strap_register_bits_unused13_6        = &H0
        write_Autospeed_enable_default_value = &H0
        flag_Autospeed_enable_default        = &H0
        write_Master_slave_default_value = &H0
        flag_Master_slave_default        = &H0
        write_Auto_neg_en_default_value = &H0
        flag_Auto_neg_en_default        = &H0
        write_Ability_1000base_t1_value = &H0
        flag_Ability_1000base_t1        = &H0
        write_Ability_100base_t1_value = &H0
        flag_Ability_100base_t1        = &H0
        write_Auto_neg_imp_value = &H0
        flag_Auto_neg_imp        = &H0
    End Sub
End Class


'' @REGISTER : DEVAD30_strap_register_3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' Strap_register_bits_for_customer           [15:0]           get_Strap_register_bits_for_customer
''                                                             set_Strap_register_bits_for_customer
''                                                             read_Strap_register_bits_for_customer
''                                                             write_Strap_register_bits_for_customer
''---------------------------------------------------------------------------------
Class REGISTER_DEVAD30_strap_register_3
    Private write_Strap_register_bits_for_customer_value
    Private read_Strap_register_bits_for_customer_value
    Private flag_Strap_register_bits_for_customer

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

    Property Get get_Strap_register_bits_for_customer
        get_Strap_register_bits_for_customer = read_Strap_register_bits_for_customer_value
    End Property

    Property Let set_Strap_register_bits_for_customer(aData)
        write_Strap_register_bits_for_customer_value = aData
        flag_Strap_register_bits_for_customer        = &H1
    End Property

    Property Get read_Strap_register_bits_for_customer
        read
        read_Strap_register_bits_for_customer = read_Strap_register_bits_for_customer_value
    End Property

    Property Let write_Strap_register_bits_for_customer(aData)
        set_Strap_register_bits_for_customer = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        Strap_register_bits_for_customer_mask = &Hffff
        if data_low > LONG_MAX then
            if Strap_register_bits_for_customer_mask = mask then
                read_Strap_register_bits_for_customer_value = data_low
            else
                read_Strap_register_bits_for_customer_value = (data_low - H8000_0000) and Strap_register_bits_for_customer_mask
            end If
        else
            read_Strap_register_bits_for_customer_value = data_low and Strap_register_bits_for_customer_mask
        end If

    End Sub

    Sub write
        If flag_Strap_register_bits_for_customer = &H0 Then read
        If flag_Strap_register_bits_for_customer = &H0 Then write_Strap_register_bits_for_customer_value = get_Strap_register_bits_for_customer

        regValue = leftShift((write_Strap_register_bits_for_customer_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        Strap_register_bits_for_customer_mask = &Hffff
        if data_low > LONG_MAX then
            if Strap_register_bits_for_customer_mask = mask then
                read_Strap_register_bits_for_customer_value = data_low
            else
                read_Strap_register_bits_for_customer_value = (data_low - H8000_0000) and Strap_register_bits_for_customer_mask
            end If
        else
            read_Strap_register_bits_for_customer_value = data_low and Strap_register_bits_for_customer_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_Strap_register_bits_for_customer_value = &H0
        flag_Strap_register_bits_for_customer        = &H0
    End Sub
End Class


'' @REGISTER : DEVAD30_strap_register_4
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' Strap_register_bits_for_customer           [15:0]           get_Strap_register_bits_for_customer
''                                                             set_Strap_register_bits_for_customer
''                                                             read_Strap_register_bits_for_customer
''                                                             write_Strap_register_bits_for_customer
''---------------------------------------------------------------------------------
Class REGISTER_DEVAD30_strap_register_4
    Private write_Strap_register_bits_for_customer_value
    Private read_Strap_register_bits_for_customer_value
    Private flag_Strap_register_bits_for_customer

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

    Property Get get_Strap_register_bits_for_customer
        get_Strap_register_bits_for_customer = read_Strap_register_bits_for_customer_value
    End Property

    Property Let set_Strap_register_bits_for_customer(aData)
        write_Strap_register_bits_for_customer_value = aData
        flag_Strap_register_bits_for_customer        = &H1
    End Property

    Property Get read_Strap_register_bits_for_customer
        read
        read_Strap_register_bits_for_customer = read_Strap_register_bits_for_customer_value
    End Property

    Property Let write_Strap_register_bits_for_customer(aData)
        set_Strap_register_bits_for_customer = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        Strap_register_bits_for_customer_mask = &Hffff
        if data_low > LONG_MAX then
            if Strap_register_bits_for_customer_mask = mask then
                read_Strap_register_bits_for_customer_value = data_low
            else
                read_Strap_register_bits_for_customer_value = (data_low - H8000_0000) and Strap_register_bits_for_customer_mask
            end If
        else
            read_Strap_register_bits_for_customer_value = data_low and Strap_register_bits_for_customer_mask
        end If

    End Sub

    Sub write
        If flag_Strap_register_bits_for_customer = &H0 Then read
        If flag_Strap_register_bits_for_customer = &H0 Then write_Strap_register_bits_for_customer_value = get_Strap_register_bits_for_customer

        regValue = leftShift((write_Strap_register_bits_for_customer_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        Strap_register_bits_for_customer_mask = &Hffff
        if data_low > LONG_MAX then
            if Strap_register_bits_for_customer_mask = mask then
                read_Strap_register_bits_for_customer_value = data_low
            else
                read_Strap_register_bits_for_customer_value = (data_low - H8000_0000) and Strap_register_bits_for_customer_mask
            end If
        else
            read_Strap_register_bits_for_customer_value = data_low and Strap_register_bits_for_customer_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_Strap_register_bits_for_customer_value = &H0
        flag_Strap_register_bits_for_customer        = &H0
    End Sub
End Class


'' @REGISTER : DEVAD30_strap_register_5
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' Strap_register_bits_for_customer           [15:0]           get_Strap_register_bits_for_customer
''                                                             set_Strap_register_bits_for_customer
''                                                             read_Strap_register_bits_for_customer
''                                                             write_Strap_register_bits_for_customer
''---------------------------------------------------------------------------------
Class REGISTER_DEVAD30_strap_register_5
    Private write_Strap_register_bits_for_customer_value
    Private read_Strap_register_bits_for_customer_value
    Private flag_Strap_register_bits_for_customer

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

    Property Get get_Strap_register_bits_for_customer
        get_Strap_register_bits_for_customer = read_Strap_register_bits_for_customer_value
    End Property

    Property Let set_Strap_register_bits_for_customer(aData)
        write_Strap_register_bits_for_customer_value = aData
        flag_Strap_register_bits_for_customer        = &H1
    End Property

    Property Get read_Strap_register_bits_for_customer
        read
        read_Strap_register_bits_for_customer = read_Strap_register_bits_for_customer_value
    End Property

    Property Let write_Strap_register_bits_for_customer(aData)
        set_Strap_register_bits_for_customer = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        Strap_register_bits_for_customer_mask = &Hffff
        if data_low > LONG_MAX then
            if Strap_register_bits_for_customer_mask = mask then
                read_Strap_register_bits_for_customer_value = data_low
            else
                read_Strap_register_bits_for_customer_value = (data_low - H8000_0000) and Strap_register_bits_for_customer_mask
            end If
        else
            read_Strap_register_bits_for_customer_value = data_low and Strap_register_bits_for_customer_mask
        end If

    End Sub

    Sub write
        If flag_Strap_register_bits_for_customer = &H0 Then read
        If flag_Strap_register_bits_for_customer = &H0 Then write_Strap_register_bits_for_customer_value = get_Strap_register_bits_for_customer

        regValue = leftShift((write_Strap_register_bits_for_customer_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        Strap_register_bits_for_customer_mask = &Hffff
        if data_low > LONG_MAX then
            if Strap_register_bits_for_customer_mask = mask then
                read_Strap_register_bits_for_customer_value = data_low
            else
                read_Strap_register_bits_for_customer_value = (data_low - H8000_0000) and Strap_register_bits_for_customer_mask
            end If
        else
            read_Strap_register_bits_for_customer_value = data_low and Strap_register_bits_for_customer_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_Strap_register_bits_for_customer_value = &H0
        flag_Strap_register_bits_for_customer        = &H0
    End Sub
End Class


'' @REGISTER : DEVAD30_strap_register_6
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' Strap_register_bits_for_customer           [15:0]           get_Strap_register_bits_for_customer
''                                                             set_Strap_register_bits_for_customer
''                                                             read_Strap_register_bits_for_customer
''                                                             write_Strap_register_bits_for_customer
''---------------------------------------------------------------------------------
Class REGISTER_DEVAD30_strap_register_6
    Private write_Strap_register_bits_for_customer_value
    Private read_Strap_register_bits_for_customer_value
    Private flag_Strap_register_bits_for_customer

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

    Property Get get_Strap_register_bits_for_customer
        get_Strap_register_bits_for_customer = read_Strap_register_bits_for_customer_value
    End Property

    Property Let set_Strap_register_bits_for_customer(aData)
        write_Strap_register_bits_for_customer_value = aData
        flag_Strap_register_bits_for_customer        = &H1
    End Property

    Property Get read_Strap_register_bits_for_customer
        read
        read_Strap_register_bits_for_customer = read_Strap_register_bits_for_customer_value
    End Property

    Property Let write_Strap_register_bits_for_customer(aData)
        set_Strap_register_bits_for_customer = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        Strap_register_bits_for_customer_mask = &Hffff
        if data_low > LONG_MAX then
            if Strap_register_bits_for_customer_mask = mask then
                read_Strap_register_bits_for_customer_value = data_low
            else
                read_Strap_register_bits_for_customer_value = (data_low - H8000_0000) and Strap_register_bits_for_customer_mask
            end If
        else
            read_Strap_register_bits_for_customer_value = data_low and Strap_register_bits_for_customer_mask
        end If

    End Sub

    Sub write
        If flag_Strap_register_bits_for_customer = &H0 Then read
        If flag_Strap_register_bits_for_customer = &H0 Then write_Strap_register_bits_for_customer_value = get_Strap_register_bits_for_customer

        regValue = leftShift((write_Strap_register_bits_for_customer_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        Strap_register_bits_for_customer_mask = &Hffff
        if data_low > LONG_MAX then
            if Strap_register_bits_for_customer_mask = mask then
                read_Strap_register_bits_for_customer_value = data_low
            else
                read_Strap_register_bits_for_customer_value = (data_low - H8000_0000) and Strap_register_bits_for_customer_mask
            end If
        else
            read_Strap_register_bits_for_customer_value = data_low and Strap_register_bits_for_customer_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_Strap_register_bits_for_customer_value = &H0
        flag_Strap_register_bits_for_customer        = &H0
    End Sub
End Class


'' @REGISTER : DEVAD30_tc10_control_register_1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' tc10_disable                               [15:15]          get_tc10_disable
''                                                             set_tc10_disable
''                                                             read_tc10_disable
''                                                             write_tc10_disable
''---------------------------------------------------------------------------------
'' go2stndby                                  [14:14]          get_go2stndby
''                                                             set_go2stndby
''                                                             read_go2stndby
''                                                             write_go2stndby
''---------------------------------------------------------------------------------
'' spare                                      [13:13]          get_spare
''                                                             set_spare
''                                                             read_spare
''                                                             write_spare
''---------------------------------------------------------------------------------
'' psd_wake_clr_cfg                           [12:12]          get_psd_wake_clr_cfg
''                                                             set_psd_wake_clr_cfg
''                                                             read_psd_wake_clr_cfg
''                                                             write_psd_wake_clr_cfg
''---------------------------------------------------------------------------------
'' tc10_sftw_dis                              [11:11]          get_tc10_sftw_dis
''                                                             set_tc10_sftw_dis
''                                                             read_tc10_sftw_dis
''                                                             write_tc10_sftw_dis
''---------------------------------------------------------------------------------
'' tc10_intr_enable                           [10:10]          get_tc10_intr_enable
''                                                             set_tc10_intr_enable
''                                                             read_tc10_intr_enable
''                                                             write_tc10_intr_enable
''---------------------------------------------------------------------------------
'' tc10_intr_mask                             [9:4]            get_tc10_intr_mask
''                                                             set_tc10_intr_mask
''                                                             read_tc10_intr_mask
''                                                             write_tc10_intr_mask
''---------------------------------------------------------------------------------
'' loc_wakeup_req                             [3:3]            get_loc_wakeup_req
''                                                             set_loc_wakeup_req
''                                                             read_loc_wakeup_req
''                                                             write_loc_wakeup_req
''---------------------------------------------------------------------------------
'' sleepabort_req                             [2:2]            get_sleepabort_req
''                                                             set_sleepabort_req
''                                                             read_sleepabort_req
''                                                             write_sleepabort_req
''---------------------------------------------------------------------------------
'' sleep_req                                  [1:1]            get_sleep_req
''                                                             set_sleep_req
''                                                             read_sleep_req
''                                                             write_sleep_req
''---------------------------------------------------------------------------------
'' go2sleep_auto                              [0:0]            get_go2sleep_auto
''                                                             set_go2sleep_auto
''                                                             read_go2sleep_auto
''                                                             write_go2sleep_auto
''---------------------------------------------------------------------------------
Class REGISTER_DEVAD30_tc10_control_register_1
    Private write_tc10_disable_value
    Private read_tc10_disable_value
    Private flag_tc10_disable
    Private write_go2stndby_value
    Private read_go2stndby_value
    Private flag_go2stndby
    Private write_spare_value
    Private read_spare_value
    Private flag_spare
    Private write_psd_wake_clr_cfg_value
    Private read_psd_wake_clr_cfg_value
    Private flag_psd_wake_clr_cfg
    Private write_tc10_sftw_dis_value
    Private read_tc10_sftw_dis_value
    Private flag_tc10_sftw_dis
    Private write_tc10_intr_enable_value
    Private read_tc10_intr_enable_value
    Private flag_tc10_intr_enable
    Private write_tc10_intr_mask_value
    Private read_tc10_intr_mask_value
    Private flag_tc10_intr_mask
    Private write_loc_wakeup_req_value
    Private read_loc_wakeup_req_value
    Private flag_loc_wakeup_req
    Private write_sleepabort_req_value
    Private read_sleepabort_req_value
    Private flag_sleepabort_req
    Private write_sleep_req_value
    Private read_sleep_req_value
    Private flag_sleep_req
    Private write_go2sleep_auto_value
    Private read_go2sleep_auto_value
    Private flag_go2sleep_auto

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

    Property Get get_tc10_disable
        get_tc10_disable = read_tc10_disable_value
    End Property

    Property Let set_tc10_disable(aData)
        write_tc10_disable_value = aData
        flag_tc10_disable        = &H1
    End Property

    Property Get read_tc10_disable
        read
        read_tc10_disable = read_tc10_disable_value
    End Property

    Property Let write_tc10_disable(aData)
        set_tc10_disable = aData
        write
    End Property

    Property Get get_go2stndby
        get_go2stndby = read_go2stndby_value
    End Property

    Property Let set_go2stndby(aData)
        write_go2stndby_value = aData
        flag_go2stndby        = &H1
    End Property

    Property Get read_go2stndby
        read
        read_go2stndby = read_go2stndby_value
    End Property

    Property Let write_go2stndby(aData)
        set_go2stndby = aData
        write
    End Property

    Property Get get_spare
        get_spare = read_spare_value
    End Property

    Property Let set_spare(aData)
        write_spare_value = aData
        flag_spare        = &H1
    End Property

    Property Get read_spare
        read
        read_spare = read_spare_value
    End Property

    Property Let write_spare(aData)
        set_spare = aData
        write
    End Property

    Property Get get_psd_wake_clr_cfg
        get_psd_wake_clr_cfg = read_psd_wake_clr_cfg_value
    End Property

    Property Let set_psd_wake_clr_cfg(aData)
        write_psd_wake_clr_cfg_value = aData
        flag_psd_wake_clr_cfg        = &H1
    End Property

    Property Get read_psd_wake_clr_cfg
        read
        read_psd_wake_clr_cfg = read_psd_wake_clr_cfg_value
    End Property

    Property Let write_psd_wake_clr_cfg(aData)
        set_psd_wake_clr_cfg = aData
        write
    End Property

    Property Get get_tc10_sftw_dis
        get_tc10_sftw_dis = read_tc10_sftw_dis_value
    End Property

    Property Let set_tc10_sftw_dis(aData)
        write_tc10_sftw_dis_value = aData
        flag_tc10_sftw_dis        = &H1
    End Property

    Property Get read_tc10_sftw_dis
        read
        read_tc10_sftw_dis = read_tc10_sftw_dis_value
    End Property

    Property Let write_tc10_sftw_dis(aData)
        set_tc10_sftw_dis = aData
        write
    End Property

    Property Get get_tc10_intr_enable
        get_tc10_intr_enable = read_tc10_intr_enable_value
    End Property

    Property Let set_tc10_intr_enable(aData)
        write_tc10_intr_enable_value = aData
        flag_tc10_intr_enable        = &H1
    End Property

    Property Get read_tc10_intr_enable
        read
        read_tc10_intr_enable = read_tc10_intr_enable_value
    End Property

    Property Let write_tc10_intr_enable(aData)
        set_tc10_intr_enable = aData
        write
    End Property

    Property Get get_tc10_intr_mask
        get_tc10_intr_mask = read_tc10_intr_mask_value
    End Property

    Property Let set_tc10_intr_mask(aData)
        write_tc10_intr_mask_value = aData
        flag_tc10_intr_mask        = &H1
    End Property

    Property Get read_tc10_intr_mask
        read
        read_tc10_intr_mask = read_tc10_intr_mask_value
    End Property

    Property Let write_tc10_intr_mask(aData)
        set_tc10_intr_mask = aData
        write
    End Property

    Property Get get_loc_wakeup_req
        get_loc_wakeup_req = read_loc_wakeup_req_value
    End Property

    Property Let set_loc_wakeup_req(aData)
        write_loc_wakeup_req_value = aData
        flag_loc_wakeup_req        = &H1
    End Property

    Property Get read_loc_wakeup_req
        read
        read_loc_wakeup_req = read_loc_wakeup_req_value
    End Property

    Property Let write_loc_wakeup_req(aData)
        set_loc_wakeup_req = aData
        write
    End Property

    Property Get get_sleepabort_req
        get_sleepabort_req = read_sleepabort_req_value
    End Property

    Property Let set_sleepabort_req(aData)
        write_sleepabort_req_value = aData
        flag_sleepabort_req        = &H1
    End Property

    Property Get read_sleepabort_req
        read
        read_sleepabort_req = read_sleepabort_req_value
    End Property

    Property Let write_sleepabort_req(aData)
        set_sleepabort_req = aData
        write
    End Property

    Property Get get_sleep_req
        get_sleep_req = read_sleep_req_value
    End Property

    Property Let set_sleep_req(aData)
        write_sleep_req_value = aData
        flag_sleep_req        = &H1
    End Property

    Property Get read_sleep_req
        read
        read_sleep_req = read_sleep_req_value
    End Property

    Property Let write_sleep_req(aData)
        set_sleep_req = aData
        write
    End Property

    Property Get get_go2sleep_auto
        get_go2sleep_auto = read_go2sleep_auto_value
    End Property

    Property Let set_go2sleep_auto(aData)
        write_go2sleep_auto_value = aData
        flag_go2sleep_auto        = &H1
    End Property

    Property Get read_go2sleep_auto
        read
        read_go2sleep_auto = read_go2sleep_auto_value
    End Property

    Property Let write_go2sleep_auto(aData)
        set_go2sleep_auto = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_tc10_disable_value = rightShift(data_low, 15) and &H1
        read_go2stndby_value = rightShift(data_low, 14) and &H1
        read_spare_value = rightShift(data_low, 13) and &H1
        read_psd_wake_clr_cfg_value = rightShift(data_low, 12) and &H1
        read_tc10_sftw_dis_value = rightShift(data_low, 11) and &H1
        read_tc10_intr_enable_value = rightShift(data_low, 10) and &H1
        read_tc10_intr_mask_value = rightShift(data_low, 4) and &H3f
        read_loc_wakeup_req_value = rightShift(data_low, 3) and &H1
        read_sleepabort_req_value = rightShift(data_low, 2) and &H1
        read_sleep_req_value = rightShift(data_low, 1) and &H1
        go2sleep_auto_mask = &H1
        if data_low > LONG_MAX then
            if go2sleep_auto_mask = mask then
                read_go2sleep_auto_value = data_low
            else
                read_go2sleep_auto_value = (data_low - H8000_0000) and go2sleep_auto_mask
            end If
        else
            read_go2sleep_auto_value = data_low and go2sleep_auto_mask
        end If

    End Sub

    Sub write
        If flag_tc10_disable = &H0 or flag_go2stndby = &H0 or flag_spare = &H0 or flag_psd_wake_clr_cfg = &H0 or flag_tc10_sftw_dis = &H0 or flag_tc10_intr_enable = &H0 or flag_tc10_intr_mask = &H0 or flag_loc_wakeup_req = &H0 or flag_sleepabort_req = &H0 or flag_sleep_req = &H0 or flag_go2sleep_auto = &H0 Then read
        If flag_tc10_disable = &H0 Then write_tc10_disable_value = get_tc10_disable
        If flag_go2stndby = &H0 Then write_go2stndby_value = get_go2stndby
        If flag_spare = &H0 Then write_spare_value = get_spare
        If flag_psd_wake_clr_cfg = &H0 Then write_psd_wake_clr_cfg_value = get_psd_wake_clr_cfg
        If flag_tc10_sftw_dis = &H0 Then write_tc10_sftw_dis_value = get_tc10_sftw_dis
        If flag_tc10_intr_enable = &H0 Then write_tc10_intr_enable_value = get_tc10_intr_enable
        If flag_tc10_intr_mask = &H0 Then write_tc10_intr_mask_value = get_tc10_intr_mask
        If flag_loc_wakeup_req = &H0 Then write_loc_wakeup_req_value = get_loc_wakeup_req
        If flag_sleepabort_req = &H0 Then write_sleepabort_req_value = get_sleepabort_req
        If flag_sleep_req = &H0 Then write_sleep_req_value = get_sleep_req
        If flag_go2sleep_auto = &H0 Then write_go2sleep_auto_value = get_go2sleep_auto

        regValue = leftShift((write_tc10_disable_value and &H1), 15) + leftShift((write_go2stndby_value and &H1), 14) + leftShift((write_spare_value and &H1), 13) + leftShift((write_psd_wake_clr_cfg_value and &H1), 12) + leftShift((write_tc10_sftw_dis_value and &H1), 11) + leftShift((write_tc10_intr_enable_value and &H1), 10) + leftShift((write_tc10_intr_mask_value and &H3f), 4) + leftShift((write_loc_wakeup_req_value and &H1), 3) + leftShift((write_sleepabort_req_value and &H1), 2) + leftShift((write_sleep_req_value and &H1), 1) + leftShift((write_go2sleep_auto_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_tc10_disable_value = rightShift(data_low, 15) and &H1
        read_go2stndby_value = rightShift(data_low, 14) and &H1
        read_spare_value = rightShift(data_low, 13) and &H1
        read_psd_wake_clr_cfg_value = rightShift(data_low, 12) and &H1
        read_tc10_sftw_dis_value = rightShift(data_low, 11) and &H1
        read_tc10_intr_enable_value = rightShift(data_low, 10) and &H1
        read_tc10_intr_mask_value = rightShift(data_low, 4) and &H3f
        read_loc_wakeup_req_value = rightShift(data_low, 3) and &H1
        read_sleepabort_req_value = rightShift(data_low, 2) and &H1
        read_sleep_req_value = rightShift(data_low, 1) and &H1
        go2sleep_auto_mask = &H1
        if data_low > LONG_MAX then
            if go2sleep_auto_mask = mask then
                read_go2sleep_auto_value = data_low
            else
                read_go2sleep_auto_value = (data_low - H8000_0000) and go2sleep_auto_mask
            end If
        else
            read_go2sleep_auto_value = data_low and go2sleep_auto_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_tc10_disable_value = &H0
        flag_tc10_disable        = &H0
        write_go2stndby_value = &H0
        flag_go2stndby        = &H0
        write_spare_value = &H0
        flag_spare        = &H0
        write_psd_wake_clr_cfg_value = &H0
        flag_psd_wake_clr_cfg        = &H0
        write_tc10_sftw_dis_value = &H0
        flag_tc10_sftw_dis        = &H0
        write_tc10_intr_enable_value = &H0
        flag_tc10_intr_enable        = &H0
        write_tc10_intr_mask_value = &H0
        flag_tc10_intr_mask        = &H0
        write_loc_wakeup_req_value = &H0
        flag_loc_wakeup_req        = &H0
        write_sleepabort_req_value = &H0
        flag_sleepabort_req        = &H0
        write_sleep_req_value = &H0
        flag_sleep_req        = &H0
        write_go2sleep_auto_value = &H0
        flag_go2sleep_auto        = &H0
    End Sub
End Class


'' @REGISTER : DEVAD30_tc10_status_register_1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' unused                                     [15:11]          get_unused
''                                                             set_unused
''                                                             read_unused
''                                                             write_unused
''---------------------------------------------------------------------------------
'' slp_wup_state                              [10:8]           get_slp_wup_state
''                                                             set_slp_wup_state
''                                                             read_slp_wup_state
''                                                             write_slp_wup_state
''---------------------------------------------------------------------------------
'' wurfail_lat                                [7:7]            get_wurfail_lat
''                                                             set_wurfail_lat
''                                                             read_wurfail_lat
''                                                             write_wurfail_lat
''---------------------------------------------------------------------------------
'' afe_wvwake_lat                             [6:6]            get_afe_wvwake_lat
''                                                             set_afe_wvwake_lat
''                                                             read_afe_wvwake_lat
''                                                             write_afe_wvwake_lat
''---------------------------------------------------------------------------------
'' wakeup_lat                                 [5:5]            get_wakeup_lat
''                                                             set_wakeup_lat
''                                                             read_wakeup_lat
''                                                             write_wakeup_lat
''---------------------------------------------------------------------------------
'' inhibit                                    [4:4]            get_inhibit
''                                                             set_inhibit
''                                                             read_inhibit
''                                                             write_inhibit
''---------------------------------------------------------------------------------
'' inhibit_lat                                [3:3]            get_inhibit_lat
''                                                             set_inhibit_lat
''                                                             read_inhibit_lat
''                                                             write_inhibit_lat
''---------------------------------------------------------------------------------
'' sleep_lat                                  [2:2]            get_sleep_lat
''                                                             set_sleep_lat
''                                                             read_sleep_lat
''                                                             write_sleep_lat
''---------------------------------------------------------------------------------
'' sleepfail_lat                              [1:1]            get_sleepfail_lat
''                                                             set_sleepfail_lat
''                                                             read_sleepfail_lat
''                                                             write_sleepfail_lat
''---------------------------------------------------------------------------------
'' afe_wvmdi_lat                              [0:0]            get_afe_wvmdi_lat
''                                                             set_afe_wvmdi_lat
''                                                             read_afe_wvmdi_lat
''                                                             write_afe_wvmdi_lat
''---------------------------------------------------------------------------------
Class REGISTER_DEVAD30_tc10_status_register_1
    Private write_unused_value
    Private read_unused_value
    Private flag_unused
    Private write_slp_wup_state_value
    Private read_slp_wup_state_value
    Private flag_slp_wup_state
    Private write_wurfail_lat_value
    Private read_wurfail_lat_value
    Private flag_wurfail_lat
    Private write_afe_wvwake_lat_value
    Private read_afe_wvwake_lat_value
    Private flag_afe_wvwake_lat
    Private write_wakeup_lat_value
    Private read_wakeup_lat_value
    Private flag_wakeup_lat
    Private write_inhibit_value
    Private read_inhibit_value
    Private flag_inhibit
    Private write_inhibit_lat_value
    Private read_inhibit_lat_value
    Private flag_inhibit_lat
    Private write_sleep_lat_value
    Private read_sleep_lat_value
    Private flag_sleep_lat
    Private write_sleepfail_lat_value
    Private read_sleepfail_lat_value
    Private flag_sleepfail_lat
    Private write_afe_wvmdi_lat_value
    Private read_afe_wvmdi_lat_value
    Private flag_afe_wvmdi_lat

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

    Property Get get_unused
        get_unused = read_unused_value
    End Property

    Property Let set_unused(aData)
        write_unused_value = aData
        flag_unused        = &H1
    End Property

    Property Get read_unused
        read
        read_unused = read_unused_value
    End Property

    Property Let write_unused(aData)
        set_unused = aData
        write
    End Property

    Property Get get_slp_wup_state
        get_slp_wup_state = read_slp_wup_state_value
    End Property

    Property Let set_slp_wup_state(aData)
        write_slp_wup_state_value = aData
        flag_slp_wup_state        = &H1
    End Property

    Property Get read_slp_wup_state
        read
        read_slp_wup_state = read_slp_wup_state_value
    End Property

    Property Let write_slp_wup_state(aData)
        set_slp_wup_state = aData
        write
    End Property

    Property Get get_wurfail_lat
        get_wurfail_lat = read_wurfail_lat_value
    End Property

    Property Let set_wurfail_lat(aData)
        write_wurfail_lat_value = aData
        flag_wurfail_lat        = &H1
    End Property

    Property Get read_wurfail_lat
        read
        read_wurfail_lat = read_wurfail_lat_value
    End Property

    Property Let write_wurfail_lat(aData)
        set_wurfail_lat = aData
        write
    End Property

    Property Get get_afe_wvwake_lat
        get_afe_wvwake_lat = read_afe_wvwake_lat_value
    End Property

    Property Let set_afe_wvwake_lat(aData)
        write_afe_wvwake_lat_value = aData
        flag_afe_wvwake_lat        = &H1
    End Property

    Property Get read_afe_wvwake_lat
        read
        read_afe_wvwake_lat = read_afe_wvwake_lat_value
    End Property

    Property Let write_afe_wvwake_lat(aData)
        set_afe_wvwake_lat = aData
        write
    End Property

    Property Get get_wakeup_lat
        get_wakeup_lat = read_wakeup_lat_value
    End Property

    Property Let set_wakeup_lat(aData)
        write_wakeup_lat_value = aData
        flag_wakeup_lat        = &H1
    End Property

    Property Get read_wakeup_lat
        read
        read_wakeup_lat = read_wakeup_lat_value
    End Property

    Property Let write_wakeup_lat(aData)
        set_wakeup_lat = aData
        write
    End Property

    Property Get get_inhibit
        get_inhibit = read_inhibit_value
    End Property

    Property Let set_inhibit(aData)
        write_inhibit_value = aData
        flag_inhibit        = &H1
    End Property

    Property Get read_inhibit
        read
        read_inhibit = read_inhibit_value
    End Property

    Property Let write_inhibit(aData)
        set_inhibit = aData
        write
    End Property

    Property Get get_inhibit_lat
        get_inhibit_lat = read_inhibit_lat_value
    End Property

    Property Let set_inhibit_lat(aData)
        write_inhibit_lat_value = aData
        flag_inhibit_lat        = &H1
    End Property

    Property Get read_inhibit_lat
        read
        read_inhibit_lat = read_inhibit_lat_value
    End Property

    Property Let write_inhibit_lat(aData)
        set_inhibit_lat = aData
        write
    End Property

    Property Get get_sleep_lat
        get_sleep_lat = read_sleep_lat_value
    End Property

    Property Let set_sleep_lat(aData)
        write_sleep_lat_value = aData
        flag_sleep_lat        = &H1
    End Property

    Property Get read_sleep_lat
        read
        read_sleep_lat = read_sleep_lat_value
    End Property

    Property Let write_sleep_lat(aData)
        set_sleep_lat = aData
        write
    End Property

    Property Get get_sleepfail_lat
        get_sleepfail_lat = read_sleepfail_lat_value
    End Property

    Property Let set_sleepfail_lat(aData)
        write_sleepfail_lat_value = aData
        flag_sleepfail_lat        = &H1
    End Property

    Property Get read_sleepfail_lat
        read
        read_sleepfail_lat = read_sleepfail_lat_value
    End Property

    Property Let write_sleepfail_lat(aData)
        set_sleepfail_lat = aData
        write
    End Property

    Property Get get_afe_wvmdi_lat
        get_afe_wvmdi_lat = read_afe_wvmdi_lat_value
    End Property

    Property Let set_afe_wvmdi_lat(aData)
        write_afe_wvmdi_lat_value = aData
        flag_afe_wvmdi_lat        = &H1
    End Property

    Property Get read_afe_wvmdi_lat
        read
        read_afe_wvmdi_lat = read_afe_wvmdi_lat_value
    End Property

    Property Let write_afe_wvmdi_lat(aData)
        set_afe_wvmdi_lat = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_unused_value = rightShift(data_low, 11) and &H1f
        read_slp_wup_state_value = rightShift(data_low, 8) and &H7
        read_wurfail_lat_value = rightShift(data_low, 7) and &H1
        read_afe_wvwake_lat_value = rightShift(data_low, 6) and &H1
        read_wakeup_lat_value = rightShift(data_low, 5) and &H1
        read_inhibit_value = rightShift(data_low, 4) and &H1
        read_inhibit_lat_value = rightShift(data_low, 3) and &H1
        read_sleep_lat_value = rightShift(data_low, 2) and &H1
        read_sleepfail_lat_value = rightShift(data_low, 1) and &H1
        afe_wvmdi_lat_mask = &H1
        if data_low > LONG_MAX then
            if afe_wvmdi_lat_mask = mask then
                read_afe_wvmdi_lat_value = data_low
            else
                read_afe_wvmdi_lat_value = (data_low - H8000_0000) and afe_wvmdi_lat_mask
            end If
        else
            read_afe_wvmdi_lat_value = data_low and afe_wvmdi_lat_mask
        end If

    End Sub

    Sub write
        If flag_unused = &H0 or flag_slp_wup_state = &H0 or flag_wurfail_lat = &H0 or flag_afe_wvwake_lat = &H0 or flag_wakeup_lat = &H0 or flag_inhibit = &H0 or flag_inhibit_lat = &H0 or flag_sleep_lat = &H0 or flag_sleepfail_lat = &H0 or flag_afe_wvmdi_lat = &H0 Then read
        If flag_unused = &H0 Then write_unused_value = get_unused
        If flag_slp_wup_state = &H0 Then write_slp_wup_state_value = get_slp_wup_state
        If flag_wurfail_lat = &H0 Then write_wurfail_lat_value = get_wurfail_lat
        If flag_afe_wvwake_lat = &H0 Then write_afe_wvwake_lat_value = get_afe_wvwake_lat
        If flag_wakeup_lat = &H0 Then write_wakeup_lat_value = get_wakeup_lat
        If flag_inhibit = &H0 Then write_inhibit_value = get_inhibit
        If flag_inhibit_lat = &H0 Then write_inhibit_lat_value = get_inhibit_lat
        If flag_sleep_lat = &H0 Then write_sleep_lat_value = get_sleep_lat
        If flag_sleepfail_lat = &H0 Then write_sleepfail_lat_value = get_sleepfail_lat
        If flag_afe_wvmdi_lat = &H0 Then write_afe_wvmdi_lat_value = get_afe_wvmdi_lat

        regValue = leftShift((write_unused_value and &H1f), 11) + leftShift((write_slp_wup_state_value and &H7), 8) + leftShift((write_wurfail_lat_value and &H1), 7) + leftShift((write_afe_wvwake_lat_value and &H1), 6) + leftShift((write_wakeup_lat_value and &H1), 5) + leftShift((write_inhibit_value and &H1), 4) + leftShift((write_inhibit_lat_value and &H1), 3) + leftShift((write_sleep_lat_value and &H1), 2) + leftShift((write_sleepfail_lat_value and &H1), 1) + leftShift((write_afe_wvmdi_lat_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_unused_value = rightShift(data_low, 11) and &H1f
        read_slp_wup_state_value = rightShift(data_low, 8) and &H7
        read_wurfail_lat_value = rightShift(data_low, 7) and &H1
        read_afe_wvwake_lat_value = rightShift(data_low, 6) and &H1
        read_wakeup_lat_value = rightShift(data_low, 5) and &H1
        read_inhibit_value = rightShift(data_low, 4) and &H1
        read_inhibit_lat_value = rightShift(data_low, 3) and &H1
        read_sleep_lat_value = rightShift(data_low, 2) and &H1
        read_sleepfail_lat_value = rightShift(data_low, 1) and &H1
        afe_wvmdi_lat_mask = &H1
        if data_low > LONG_MAX then
            if afe_wvmdi_lat_mask = mask then
                read_afe_wvmdi_lat_value = data_low
            else
                read_afe_wvmdi_lat_value = (data_low - H8000_0000) and afe_wvmdi_lat_mask
            end If
        else
            read_afe_wvmdi_lat_value = data_low and afe_wvmdi_lat_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_unused_value = &H0
        flag_unused        = &H0
        write_slp_wup_state_value = &H0
        flag_slp_wup_state        = &H0
        write_wurfail_lat_value = &H0
        flag_wurfail_lat        = &H0
        write_afe_wvwake_lat_value = &H0
        flag_afe_wvwake_lat        = &H0
        write_wakeup_lat_value = &H0
        flag_wakeup_lat        = &H0
        write_inhibit_value = &H0
        flag_inhibit        = &H0
        write_inhibit_lat_value = &H0
        flag_inhibit_lat        = &H0
        write_sleep_lat_value = &H0
        flag_sleep_lat        = &H0
        write_sleepfail_lat_value = &H0
        flag_sleepfail_lat        = &H0
        write_afe_wvmdi_lat_value = &H0
        flag_afe_wvmdi_lat        = &H0
    End Sub
End Class


'' @REGISTER : DEVAD30_spare_end_addr
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
Class REGISTER_DEVAD30_spare_end_addr
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

Class DEVAD30_INSTANCE

    Public strap_register_1
    Public strap_register_2
    Public strap_register_3
    Public strap_register_4
    Public strap_register_5
    Public strap_register_6
    Public tc10_control_register_1
    Public tc10_status_register_1
    Public spare_end_addr


    Public default function Init(aBaseAddr)
        Set strap_register_1 = (New REGISTER_DEVAD30_strap_register_1)(aBaseAddr, 16)
        Set strap_register_2 = (New REGISTER_DEVAD30_strap_register_2)(aBaseAddr, 16)
        Set strap_register_3 = (New REGISTER_DEVAD30_strap_register_3)(aBaseAddr, 16)
        Set strap_register_4 = (New REGISTER_DEVAD30_strap_register_4)(aBaseAddr, 16)
        Set strap_register_5 = (New REGISTER_DEVAD30_strap_register_5)(aBaseAddr, 16)
        Set strap_register_6 = (New REGISTER_DEVAD30_strap_register_6)(aBaseAddr, 16)
        Set tc10_control_register_1 = (New REGISTER_DEVAD30_tc10_control_register_1)(aBaseAddr, 16)
        Set tc10_status_register_1 = (New REGISTER_DEVAD30_tc10_status_register_1)(aBaseAddr, 16)
        Set spare_end_addr = (New REGISTER_DEVAD30_spare_end_addr)(aBaseAddr, 16)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set DEVAD30 = CreateObject("System.Collections.ArrayList")
DEVAD30.Add ((New DEVAD30_INSTANCE)(&H493c0000))


