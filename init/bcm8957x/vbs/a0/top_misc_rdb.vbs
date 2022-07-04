

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


'' @REGISTER : TOP_MISC_spare_reg_0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SPARE_REG                                  [15:0]           get_SPARE_REG
''                                                             set_SPARE_REG
''                                                             read_SPARE_REG
''                                                             write_SPARE_REG
''---------------------------------------------------------------------------------
Class REGISTER_TOP_MISC_spare_reg_0
    Private write_SPARE_REG_value
    Private read_SPARE_REG_value
    Private flag_SPARE_REG

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

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SPARE_REG_mask = &Hffff
        if data_low > LONG_MAX then
            if SPARE_REG_mask = mask then
                read_SPARE_REG_value = data_low
            else
                read_SPARE_REG_value = (data_low - H8000_0000) and SPARE_REG_mask
            end If
        else
            read_SPARE_REG_value = data_low and SPARE_REG_mask
        end If

    End Sub

    Sub write
        If flag_SPARE_REG = &H0 Then read
        If flag_SPARE_REG = &H0 Then write_SPARE_REG_value = get_SPARE_REG

        regValue = leftShift((write_SPARE_REG_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SPARE_REG_mask = &Hffff
        if data_low > LONG_MAX then
            if SPARE_REG_mask = mask then
                read_SPARE_REG_value = data_low
            else
                read_SPARE_REG_value = (data_low - H8000_0000) and SPARE_REG_mask
            end If
        else
            read_SPARE_REG_value = data_low and SPARE_REG_mask
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
    End Sub
End Class


'' @REGISTER : TOP_MISC_spare_reg_1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SPARE_REG                                  [15:0]           get_SPARE_REG
''                                                             set_SPARE_REG
''                                                             read_SPARE_REG
''                                                             write_SPARE_REG
''---------------------------------------------------------------------------------
Class REGISTER_TOP_MISC_spare_reg_1
    Private write_SPARE_REG_value
    Private read_SPARE_REG_value
    Private flag_SPARE_REG

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

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SPARE_REG_mask = &Hffff
        if data_low > LONG_MAX then
            if SPARE_REG_mask = mask then
                read_SPARE_REG_value = data_low
            else
                read_SPARE_REG_value = (data_low - H8000_0000) and SPARE_REG_mask
            end If
        else
            read_SPARE_REG_value = data_low and SPARE_REG_mask
        end If

    End Sub

    Sub write
        If flag_SPARE_REG = &H0 Then read
        If flag_SPARE_REG = &H0 Then write_SPARE_REG_value = get_SPARE_REG

        regValue = leftShift((write_SPARE_REG_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SPARE_REG_mask = &Hffff
        if data_low > LONG_MAX then
            if SPARE_REG_mask = mask then
                read_SPARE_REG_value = data_low
            else
                read_SPARE_REG_value = (data_low - H8000_0000) and SPARE_REG_mask
            end If
        else
            read_SPARE_REG_value = data_low and SPARE_REG_mask
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
    End Sub
End Class


'' @REGISTER : TOP_MISC_afe_ovr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TH_POLE                                    [8:8]            get_TH_POLE
''                                                             set_TH_POLE
''                                                             read_TH_POLE
''                                                             write_TH_POLE
''---------------------------------------------------------------------------------
'' TRIMHYB                                    [7:4]            get_TRIMHYB
''                                                             set_TRIMHYB
''                                                             read_TRIMHYB
''                                                             write_TRIMHYB
''---------------------------------------------------------------------------------
'' TRIMDAC                                    [3:0]            get_TRIMDAC
''                                                             set_TRIMDAC
''                                                             read_TRIMDAC
''                                                             write_TRIMDAC
''---------------------------------------------------------------------------------
Class REGISTER_TOP_MISC_afe_ovr
    Private write_TH_POLE_value
    Private read_TH_POLE_value
    Private flag_TH_POLE
    Private write_TRIMHYB_value
    Private read_TRIMHYB_value
    Private flag_TRIMHYB
    Private write_TRIMDAC_value
    Private read_TRIMDAC_value
    Private flag_TRIMDAC

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

    Property Get get_TH_POLE
        get_TH_POLE = read_TH_POLE_value
    End Property

    Property Let set_TH_POLE(aData)
        write_TH_POLE_value = aData
        flag_TH_POLE        = &H1
    End Property

    Property Get read_TH_POLE
        read
        read_TH_POLE = read_TH_POLE_value
    End Property

    Property Let write_TH_POLE(aData)
        set_TH_POLE = aData
        write
    End Property

    Property Get get_TRIMHYB
        get_TRIMHYB = read_TRIMHYB_value
    End Property

    Property Let set_TRIMHYB(aData)
        write_TRIMHYB_value = aData
        flag_TRIMHYB        = &H1
    End Property

    Property Get read_TRIMHYB
        read
        read_TRIMHYB = read_TRIMHYB_value
    End Property

    Property Let write_TRIMHYB(aData)
        set_TRIMHYB = aData
        write
    End Property

    Property Get get_TRIMDAC
        get_TRIMDAC = read_TRIMDAC_value
    End Property

    Property Let set_TRIMDAC(aData)
        write_TRIMDAC_value = aData
        flag_TRIMDAC        = &H1
    End Property

    Property Get read_TRIMDAC
        read
        read_TRIMDAC = read_TRIMDAC_value
    End Property

    Property Let write_TRIMDAC(aData)
        set_TRIMDAC = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TH_POLE_value = rightShift(data_low, 8) and &H1
        read_TRIMHYB_value = rightShift(data_low, 4) and &Hf
        TRIMDAC_mask = &Hf
        if data_low > LONG_MAX then
            if TRIMDAC_mask = mask then
                read_TRIMDAC_value = data_low
            else
                read_TRIMDAC_value = (data_low - H8000_0000) and TRIMDAC_mask
            end If
        else
            read_TRIMDAC_value = data_low and TRIMDAC_mask
        end If

    End Sub

    Sub write
        If flag_TH_POLE = &H0 or flag_TRIMHYB = &H0 or flag_TRIMDAC = &H0 Then read
        If flag_TH_POLE = &H0 Then write_TH_POLE_value = get_TH_POLE
        If flag_TRIMHYB = &H0 Then write_TRIMHYB_value = get_TRIMHYB
        If flag_TRIMDAC = &H0 Then write_TRIMDAC_value = get_TRIMDAC

        regValue = leftShift((write_TH_POLE_value and &H1), 8) + leftShift((write_TRIMHYB_value and &Hf), 4) + leftShift((write_TRIMDAC_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TH_POLE_value = rightShift(data_low, 8) and &H1
        read_TRIMHYB_value = rightShift(data_low, 4) and &Hf
        TRIMDAC_mask = &Hf
        if data_low > LONG_MAX then
            if TRIMDAC_mask = mask then
                read_TRIMDAC_value = data_low
            else
                read_TRIMDAC_value = (data_low - H8000_0000) and TRIMDAC_mask
            end If
        else
            read_TRIMDAC_value = data_low and TRIMDAC_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TH_POLE_value = &H0
        flag_TH_POLE        = &H0
        write_TRIMHYB_value = &H0
        flag_TRIMHYB        = &H0
        write_TRIMDAC_value = &H0
        flag_TRIMDAC        = &H0
    End Sub
End Class


'' @REGISTER : TOP_MISC_test_reg0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' RDB_CK25_ENABLE                            [8:4]            get_RDB_CK25_ENABLE
''                                                             set_RDB_CK25_ENABLE
''                                                             read_RDB_CK25_ENABLE
''                                                             write_RDB_CK25_ENABLE
''---------------------------------------------------------------------------------
'' FAST_MDIO_EN_SOFT                          [3:3]            get_FAST_MDIO_EN_SOFT
''                                                             set_FAST_MDIO_EN_SOFT
''                                                             read_FAST_MDIO_EN_SOFT
''                                                             write_FAST_MDIO_EN_SOFT
''---------------------------------------------------------------------------------
'' DLLBYPASS_MODE_SOFT                        [2:2]            get_DLLBYPASS_MODE_SOFT
''                                                             set_DLLBYPASS_MODE_SOFT
''                                                             read_DLLBYPASS_MODE_SOFT
''                                                             write_DLLBYPASS_MODE_SOFT
''---------------------------------------------------------------------------------
'' TESTTMPL_MODE_SOFT                         [1:1]            get_TESTTMPL_MODE_SOFT
''                                                             set_TESTTMPL_MODE_SOFT
''                                                             read_TESTTMPL_MODE_SOFT
''                                                             write_TESTTMPL_MODE_SOFT
''---------------------------------------------------------------------------------
'' IDDQ_TEST_MODE_SOFT                        [0:0]            get_IDDQ_TEST_MODE_SOFT
''                                                             set_IDDQ_TEST_MODE_SOFT
''                                                             read_IDDQ_TEST_MODE_SOFT
''                                                             write_IDDQ_TEST_MODE_SOFT
''---------------------------------------------------------------------------------
Class REGISTER_TOP_MISC_test_reg0
    Private write_RDB_CK25_ENABLE_value
    Private read_RDB_CK25_ENABLE_value
    Private flag_RDB_CK25_ENABLE
    Private write_FAST_MDIO_EN_SOFT_value
    Private read_FAST_MDIO_EN_SOFT_value
    Private flag_FAST_MDIO_EN_SOFT
    Private write_DLLBYPASS_MODE_SOFT_value
    Private read_DLLBYPASS_MODE_SOFT_value
    Private flag_DLLBYPASS_MODE_SOFT
    Private write_TESTTMPL_MODE_SOFT_value
    Private read_TESTTMPL_MODE_SOFT_value
    Private flag_TESTTMPL_MODE_SOFT
    Private write_IDDQ_TEST_MODE_SOFT_value
    Private read_IDDQ_TEST_MODE_SOFT_value
    Private flag_IDDQ_TEST_MODE_SOFT

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

    Property Get get_RDB_CK25_ENABLE
        get_RDB_CK25_ENABLE = read_RDB_CK25_ENABLE_value
    End Property

    Property Let set_RDB_CK25_ENABLE(aData)
        write_RDB_CK25_ENABLE_value = aData
        flag_RDB_CK25_ENABLE        = &H1
    End Property

    Property Get read_RDB_CK25_ENABLE
        read
        read_RDB_CK25_ENABLE = read_RDB_CK25_ENABLE_value
    End Property

    Property Let write_RDB_CK25_ENABLE(aData)
        set_RDB_CK25_ENABLE = aData
        write
    End Property

    Property Get get_FAST_MDIO_EN_SOFT
        get_FAST_MDIO_EN_SOFT = read_FAST_MDIO_EN_SOFT_value
    End Property

    Property Let set_FAST_MDIO_EN_SOFT(aData)
        write_FAST_MDIO_EN_SOFT_value = aData
        flag_FAST_MDIO_EN_SOFT        = &H1
    End Property

    Property Get read_FAST_MDIO_EN_SOFT
        read
        read_FAST_MDIO_EN_SOFT = read_FAST_MDIO_EN_SOFT_value
    End Property

    Property Let write_FAST_MDIO_EN_SOFT(aData)
        set_FAST_MDIO_EN_SOFT = aData
        write
    End Property

    Property Get get_DLLBYPASS_MODE_SOFT
        get_DLLBYPASS_MODE_SOFT = read_DLLBYPASS_MODE_SOFT_value
    End Property

    Property Let set_DLLBYPASS_MODE_SOFT(aData)
        write_DLLBYPASS_MODE_SOFT_value = aData
        flag_DLLBYPASS_MODE_SOFT        = &H1
    End Property

    Property Get read_DLLBYPASS_MODE_SOFT
        read
        read_DLLBYPASS_MODE_SOFT = read_DLLBYPASS_MODE_SOFT_value
    End Property

    Property Let write_DLLBYPASS_MODE_SOFT(aData)
        set_DLLBYPASS_MODE_SOFT = aData
        write
    End Property

    Property Get get_TESTTMPL_MODE_SOFT
        get_TESTTMPL_MODE_SOFT = read_TESTTMPL_MODE_SOFT_value
    End Property

    Property Let set_TESTTMPL_MODE_SOFT(aData)
        write_TESTTMPL_MODE_SOFT_value = aData
        flag_TESTTMPL_MODE_SOFT        = &H1
    End Property

    Property Get read_TESTTMPL_MODE_SOFT
        read
        read_TESTTMPL_MODE_SOFT = read_TESTTMPL_MODE_SOFT_value
    End Property

    Property Let write_TESTTMPL_MODE_SOFT(aData)
        set_TESTTMPL_MODE_SOFT = aData
        write
    End Property

    Property Get get_IDDQ_TEST_MODE_SOFT
        get_IDDQ_TEST_MODE_SOFT = read_IDDQ_TEST_MODE_SOFT_value
    End Property

    Property Let set_IDDQ_TEST_MODE_SOFT(aData)
        write_IDDQ_TEST_MODE_SOFT_value = aData
        flag_IDDQ_TEST_MODE_SOFT        = &H1
    End Property

    Property Get read_IDDQ_TEST_MODE_SOFT
        read
        read_IDDQ_TEST_MODE_SOFT = read_IDDQ_TEST_MODE_SOFT_value
    End Property

    Property Let write_IDDQ_TEST_MODE_SOFT(aData)
        set_IDDQ_TEST_MODE_SOFT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_RDB_CK25_ENABLE_value = rightShift(data_low, 4) and &H1f
        read_FAST_MDIO_EN_SOFT_value = rightShift(data_low, 3) and &H1
        read_DLLBYPASS_MODE_SOFT_value = rightShift(data_low, 2) and &H1
        read_TESTTMPL_MODE_SOFT_value = rightShift(data_low, 1) and &H1
        IDDQ_TEST_MODE_SOFT_mask = &H1
        if data_low > LONG_MAX then
            if IDDQ_TEST_MODE_SOFT_mask = mask then
                read_IDDQ_TEST_MODE_SOFT_value = data_low
            else
                read_IDDQ_TEST_MODE_SOFT_value = (data_low - H8000_0000) and IDDQ_TEST_MODE_SOFT_mask
            end If
        else
            read_IDDQ_TEST_MODE_SOFT_value = data_low and IDDQ_TEST_MODE_SOFT_mask
        end If

    End Sub

    Sub write
        If flag_RDB_CK25_ENABLE = &H0 or flag_FAST_MDIO_EN_SOFT = &H0 or flag_DLLBYPASS_MODE_SOFT = &H0 or flag_TESTTMPL_MODE_SOFT = &H0 or flag_IDDQ_TEST_MODE_SOFT = &H0 Then read
        If flag_RDB_CK25_ENABLE = &H0 Then write_RDB_CK25_ENABLE_value = get_RDB_CK25_ENABLE
        If flag_FAST_MDIO_EN_SOFT = &H0 Then write_FAST_MDIO_EN_SOFT_value = get_FAST_MDIO_EN_SOFT
        If flag_DLLBYPASS_MODE_SOFT = &H0 Then write_DLLBYPASS_MODE_SOFT_value = get_DLLBYPASS_MODE_SOFT
        If flag_TESTTMPL_MODE_SOFT = &H0 Then write_TESTTMPL_MODE_SOFT_value = get_TESTTMPL_MODE_SOFT
        If flag_IDDQ_TEST_MODE_SOFT = &H0 Then write_IDDQ_TEST_MODE_SOFT_value = get_IDDQ_TEST_MODE_SOFT

        regValue = leftShift((write_RDB_CK25_ENABLE_value and &H1f), 4) + leftShift((write_FAST_MDIO_EN_SOFT_value and &H1), 3) + leftShift((write_DLLBYPASS_MODE_SOFT_value and &H1), 2) + leftShift((write_TESTTMPL_MODE_SOFT_value and &H1), 1) + leftShift((write_IDDQ_TEST_MODE_SOFT_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_RDB_CK25_ENABLE_value = rightShift(data_low, 4) and &H1f
        read_FAST_MDIO_EN_SOFT_value = rightShift(data_low, 3) and &H1
        read_DLLBYPASS_MODE_SOFT_value = rightShift(data_low, 2) and &H1
        read_TESTTMPL_MODE_SOFT_value = rightShift(data_low, 1) and &H1
        IDDQ_TEST_MODE_SOFT_mask = &H1
        if data_low > LONG_MAX then
            if IDDQ_TEST_MODE_SOFT_mask = mask then
                read_IDDQ_TEST_MODE_SOFT_value = data_low
            else
                read_IDDQ_TEST_MODE_SOFT_value = (data_low - H8000_0000) and IDDQ_TEST_MODE_SOFT_mask
            end If
        else
            read_IDDQ_TEST_MODE_SOFT_value = data_low and IDDQ_TEST_MODE_SOFT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_RDB_CK25_ENABLE_value = &H0
        flag_RDB_CK25_ENABLE        = &H0
        write_FAST_MDIO_EN_SOFT_value = &H0
        flag_FAST_MDIO_EN_SOFT        = &H0
        write_DLLBYPASS_MODE_SOFT_value = &H0
        flag_DLLBYPASS_MODE_SOFT        = &H0
        write_TESTTMPL_MODE_SOFT_value = &H0
        flag_TESTTMPL_MODE_SOFT        = &H0
        write_IDDQ_TEST_MODE_SOFT_value = &H0
        flag_IDDQ_TEST_MODE_SOFT        = &H0
    End Sub
End Class


'' @REGISTER : TOP_MISC_test_reg1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LSI_TEST_MODE_SOFT                         [11:11]          get_LSI_TEST_MODE_SOFT
''                                                             set_LSI_TEST_MODE_SOFT
''                                                             read_LSI_TEST_MODE_SOFT
''                                                             write_LSI_TEST_MODE_SOFT
''---------------------------------------------------------------------------------
'' GPHY_TEST_MODE                             [10:6]           get_GPHY_TEST_MODE
''                                                             set_GPHY_TEST_MODE
''                                                             read_GPHY_TEST_MODE
''                                                             write_GPHY_TEST_MODE
''---------------------------------------------------------------------------------
'' TEST_SLICE_SEL                             [5:3]            get_TEST_SLICE_SEL
''                                                             set_TEST_SLICE_SEL
''                                                             read_TEST_SLICE_SEL
''                                                             write_TEST_SLICE_SEL
''---------------------------------------------------------------------------------
'' TEST_BUS_SEL                               [2:0]            get_TEST_BUS_SEL
''                                                             set_TEST_BUS_SEL
''                                                             read_TEST_BUS_SEL
''                                                             write_TEST_BUS_SEL
''---------------------------------------------------------------------------------
Class REGISTER_TOP_MISC_test_reg1
    Private write_LSI_TEST_MODE_SOFT_value
    Private read_LSI_TEST_MODE_SOFT_value
    Private flag_LSI_TEST_MODE_SOFT
    Private write_GPHY_TEST_MODE_value
    Private read_GPHY_TEST_MODE_value
    Private flag_GPHY_TEST_MODE
    Private write_TEST_SLICE_SEL_value
    Private read_TEST_SLICE_SEL_value
    Private flag_TEST_SLICE_SEL
    Private write_TEST_BUS_SEL_value
    Private read_TEST_BUS_SEL_value
    Private flag_TEST_BUS_SEL

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

    Property Get get_LSI_TEST_MODE_SOFT
        get_LSI_TEST_MODE_SOFT = read_LSI_TEST_MODE_SOFT_value
    End Property

    Property Let set_LSI_TEST_MODE_SOFT(aData)
        write_LSI_TEST_MODE_SOFT_value = aData
        flag_LSI_TEST_MODE_SOFT        = &H1
    End Property

    Property Get read_LSI_TEST_MODE_SOFT
        read
        read_LSI_TEST_MODE_SOFT = read_LSI_TEST_MODE_SOFT_value
    End Property

    Property Let write_LSI_TEST_MODE_SOFT(aData)
        set_LSI_TEST_MODE_SOFT = aData
        write
    End Property

    Property Get get_GPHY_TEST_MODE
        get_GPHY_TEST_MODE = read_GPHY_TEST_MODE_value
    End Property

    Property Let set_GPHY_TEST_MODE(aData)
        write_GPHY_TEST_MODE_value = aData
        flag_GPHY_TEST_MODE        = &H1
    End Property

    Property Get read_GPHY_TEST_MODE
        read
        read_GPHY_TEST_MODE = read_GPHY_TEST_MODE_value
    End Property

    Property Let write_GPHY_TEST_MODE(aData)
        set_GPHY_TEST_MODE = aData
        write
    End Property

    Property Get get_TEST_SLICE_SEL
        get_TEST_SLICE_SEL = read_TEST_SLICE_SEL_value
    End Property

    Property Let set_TEST_SLICE_SEL(aData)
        write_TEST_SLICE_SEL_value = aData
        flag_TEST_SLICE_SEL        = &H1
    End Property

    Property Get read_TEST_SLICE_SEL
        read
        read_TEST_SLICE_SEL = read_TEST_SLICE_SEL_value
    End Property

    Property Let write_TEST_SLICE_SEL(aData)
        set_TEST_SLICE_SEL = aData
        write
    End Property

    Property Get get_TEST_BUS_SEL
        get_TEST_BUS_SEL = read_TEST_BUS_SEL_value
    End Property

    Property Let set_TEST_BUS_SEL(aData)
        write_TEST_BUS_SEL_value = aData
        flag_TEST_BUS_SEL        = &H1
    End Property

    Property Get read_TEST_BUS_SEL
        read
        read_TEST_BUS_SEL = read_TEST_BUS_SEL_value
    End Property

    Property Let write_TEST_BUS_SEL(aData)
        set_TEST_BUS_SEL = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LSI_TEST_MODE_SOFT_value = rightShift(data_low, 11) and &H1
        read_GPHY_TEST_MODE_value = rightShift(data_low, 6) and &H1f
        read_TEST_SLICE_SEL_value = rightShift(data_low, 3) and &H7
        TEST_BUS_SEL_mask = &H7
        if data_low > LONG_MAX then
            if TEST_BUS_SEL_mask = mask then
                read_TEST_BUS_SEL_value = data_low
            else
                read_TEST_BUS_SEL_value = (data_low - H8000_0000) and TEST_BUS_SEL_mask
            end If
        else
            read_TEST_BUS_SEL_value = data_low and TEST_BUS_SEL_mask
        end If

    End Sub

    Sub write
        If flag_LSI_TEST_MODE_SOFT = &H0 or flag_GPHY_TEST_MODE = &H0 or flag_TEST_SLICE_SEL = &H0 or flag_TEST_BUS_SEL = &H0 Then read
        If flag_LSI_TEST_MODE_SOFT = &H0 Then write_LSI_TEST_MODE_SOFT_value = get_LSI_TEST_MODE_SOFT
        If flag_GPHY_TEST_MODE = &H0 Then write_GPHY_TEST_MODE_value = get_GPHY_TEST_MODE
        If flag_TEST_SLICE_SEL = &H0 Then write_TEST_SLICE_SEL_value = get_TEST_SLICE_SEL
        If flag_TEST_BUS_SEL = &H0 Then write_TEST_BUS_SEL_value = get_TEST_BUS_SEL

        regValue = leftShift((write_LSI_TEST_MODE_SOFT_value and &H1), 11) + leftShift((write_GPHY_TEST_MODE_value and &H1f), 6) + leftShift((write_TEST_SLICE_SEL_value and &H7), 3) + leftShift((write_TEST_BUS_SEL_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LSI_TEST_MODE_SOFT_value = rightShift(data_low, 11) and &H1
        read_GPHY_TEST_MODE_value = rightShift(data_low, 6) and &H1f
        read_TEST_SLICE_SEL_value = rightShift(data_low, 3) and &H7
        TEST_BUS_SEL_mask = &H7
        if data_low > LONG_MAX then
            if TEST_BUS_SEL_mask = mask then
                read_TEST_BUS_SEL_value = data_low
            else
                read_TEST_BUS_SEL_value = (data_low - H8000_0000) and TEST_BUS_SEL_mask
            end If
        else
            read_TEST_BUS_SEL_value = data_low and TEST_BUS_SEL_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LSI_TEST_MODE_SOFT_value = &H0
        flag_LSI_TEST_MODE_SOFT        = &H0
        write_GPHY_TEST_MODE_value = &H0
        flag_GPHY_TEST_MODE        = &H0
        write_TEST_SLICE_SEL_value = &H0
        flag_TEST_SLICE_SEL        = &H0
        write_TEST_BUS_SEL_value = &H0
        flag_TEST_BUS_SEL        = &H0
    End Sub
End Class


'' @REGISTER : TOP_MISC_top_global_reset_reg
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TOP_MII_REG_SOFT_RST                       [15:15]          get_TOP_MII_REG_SOFT_RST
''                                                             set_TOP_MII_REG_SOFT_RST
''                                                             read_TOP_MII_REG_SOFT_RST
''                                                             write_TOP_MII_REG_SOFT_RST
''---------------------------------------------------------------------------------
Class REGISTER_TOP_MISC_top_global_reset_reg
    Private write_TOP_MII_REG_SOFT_RST_value
    Private read_TOP_MII_REG_SOFT_RST_value
    Private flag_TOP_MII_REG_SOFT_RST

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

    Property Get get_TOP_MII_REG_SOFT_RST
        get_TOP_MII_REG_SOFT_RST = read_TOP_MII_REG_SOFT_RST_value
    End Property

    Property Let set_TOP_MII_REG_SOFT_RST(aData)
        write_TOP_MII_REG_SOFT_RST_value = aData
        flag_TOP_MII_REG_SOFT_RST        = &H1
    End Property

    Property Get read_TOP_MII_REG_SOFT_RST
        read
        read_TOP_MII_REG_SOFT_RST = read_TOP_MII_REG_SOFT_RST_value
    End Property

    Property Let write_TOP_MII_REG_SOFT_RST(aData)
        set_TOP_MII_REG_SOFT_RST = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TOP_MII_REG_SOFT_RST_value = rightShift(data_low, 15) and &H1

    End Sub

    Sub write
        If flag_TOP_MII_REG_SOFT_RST = &H0 Then read
        If flag_TOP_MII_REG_SOFT_RST = &H0 Then write_TOP_MII_REG_SOFT_RST_value = get_TOP_MII_REG_SOFT_RST

        regValue = leftShift((write_TOP_MII_REG_SOFT_RST_value and &H1), 15)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TOP_MII_REG_SOFT_RST_value = rightShift(data_low, 15) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TOP_MII_REG_SOFT_RST_value = &H0
        flag_TOP_MII_REG_SOFT_RST        = &H0
    End Sub
End Class


'' @REGISTER : TOP_MISC_interrupt_status_reg
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ENERGY_DET                                 [11:7]           get_ENERGY_DET
''                                                             set_ENERGY_DET
''                                                             read_ENERGY_DET
''                                                             write_ENERGY_DET
''---------------------------------------------------------------------------------
'' SLICE_INTERRUPT                            [4:0]            get_SLICE_INTERRUPT
''                                                             set_SLICE_INTERRUPT
''                                                             read_SLICE_INTERRUPT
''                                                             write_SLICE_INTERRUPT
''---------------------------------------------------------------------------------
Class REGISTER_TOP_MISC_interrupt_status_reg
    Private write_ENERGY_DET_value
    Private read_ENERGY_DET_value
    Private flag_ENERGY_DET
    Private write_SLICE_INTERRUPT_value
    Private read_SLICE_INTERRUPT_value
    Private flag_SLICE_INTERRUPT

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

    Property Get get_ENERGY_DET
        get_ENERGY_DET = read_ENERGY_DET_value
    End Property

    Property Let set_ENERGY_DET(aData)
        write_ENERGY_DET_value = aData
        flag_ENERGY_DET        = &H1
    End Property

    Property Get read_ENERGY_DET
        read
        read_ENERGY_DET = read_ENERGY_DET_value
    End Property

    Property Let write_ENERGY_DET(aData)
        set_ENERGY_DET = aData
        write
    End Property

    Property Get get_SLICE_INTERRUPT
        get_SLICE_INTERRUPT = read_SLICE_INTERRUPT_value
    End Property

    Property Let set_SLICE_INTERRUPT(aData)
        write_SLICE_INTERRUPT_value = aData
        flag_SLICE_INTERRUPT        = &H1
    End Property

    Property Get read_SLICE_INTERRUPT
        read
        read_SLICE_INTERRUPT = read_SLICE_INTERRUPT_value
    End Property

    Property Let write_SLICE_INTERRUPT(aData)
        set_SLICE_INTERRUPT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ENERGY_DET_value = rightShift(data_low, 7) and &H1f
        SLICE_INTERRUPT_mask = &H1f
        if data_low > LONG_MAX then
            if SLICE_INTERRUPT_mask = mask then
                read_SLICE_INTERRUPT_value = data_low
            else
                read_SLICE_INTERRUPT_value = (data_low - H8000_0000) and SLICE_INTERRUPT_mask
            end If
        else
            read_SLICE_INTERRUPT_value = data_low and SLICE_INTERRUPT_mask
        end If

    End Sub

    Sub write
        If flag_ENERGY_DET = &H0 or flag_SLICE_INTERRUPT = &H0 Then read
        If flag_ENERGY_DET = &H0 Then write_ENERGY_DET_value = get_ENERGY_DET
        If flag_SLICE_INTERRUPT = &H0 Then write_SLICE_INTERRUPT_value = get_SLICE_INTERRUPT

        regValue = leftShift((write_ENERGY_DET_value and &H1f), 7) + leftShift((write_SLICE_INTERRUPT_value and &H1f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ENERGY_DET_value = rightShift(data_low, 7) and &H1f
        SLICE_INTERRUPT_mask = &H1f
        if data_low > LONG_MAX then
            if SLICE_INTERRUPT_mask = mask then
                read_SLICE_INTERRUPT_value = data_low
            else
                read_SLICE_INTERRUPT_value = (data_low - H8000_0000) and SLICE_INTERRUPT_mask
            end If
        else
            read_SLICE_INTERRUPT_value = data_low and SLICE_INTERRUPT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ENERGY_DET_value = &H0
        flag_ENERGY_DET        = &H0
        write_SLICE_INTERRUPT_value = &H0
        flag_SLICE_INTERRUPT        = &H0
    End Sub
End Class


'' @REGISTER : TOP_MISC_tc10_afe_clr_test_reg
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PSD_CNT                                    [15:13]          get_PSD_CNT
''                                                             set_PSD_CNT
''                                                             read_PSD_CNT
''                                                             write_PSD_CNT
''---------------------------------------------------------------------------------
'' START_SIGNAL                               [12:12]          get_START_SIGNAL
''                                                             set_START_SIGNAL
''                                                             read_START_SIGNAL
''                                                             write_START_SIGNAL
''---------------------------------------------------------------------------------
'' Sleep_mode                                 [11:8]           get_Sleep_mode
''                                                             set_Sleep_mode
''                                                             read_Sleep_mode
''                                                             write_Sleep_mode
''---------------------------------------------------------------------------------
'' WAKE_VIA_MDI                               [7:4]            get_WAKE_VIA_MDI
''                                                             set_WAKE_VIA_MDI
''                                                             read_WAKE_VIA_MDI
''                                                             write_WAKE_VIA_MDI
''---------------------------------------------------------------------------------
'' WVM_STATE                                  [3:0]            get_WVM_STATE
''                                                             set_WVM_STATE
''                                                             read_WVM_STATE
''                                                             write_WVM_STATE
''---------------------------------------------------------------------------------
Class REGISTER_TOP_MISC_tc10_afe_clr_test_reg
    Private write_PSD_CNT_value
    Private read_PSD_CNT_value
    Private flag_PSD_CNT
    Private write_START_SIGNAL_value
    Private read_START_SIGNAL_value
    Private flag_START_SIGNAL
    Private write_Sleep_mode_value
    Private read_Sleep_mode_value
    Private flag_Sleep_mode
    Private write_WAKE_VIA_MDI_value
    Private read_WAKE_VIA_MDI_value
    Private flag_WAKE_VIA_MDI
    Private write_WVM_STATE_value
    Private read_WVM_STATE_value
    Private flag_WVM_STATE

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

    Property Get get_PSD_CNT
        get_PSD_CNT = read_PSD_CNT_value
    End Property

    Property Let set_PSD_CNT(aData)
        write_PSD_CNT_value = aData
        flag_PSD_CNT        = &H1
    End Property

    Property Get read_PSD_CNT
        read
        read_PSD_CNT = read_PSD_CNT_value
    End Property

    Property Let write_PSD_CNT(aData)
        set_PSD_CNT = aData
        write
    End Property

    Property Get get_START_SIGNAL
        get_START_SIGNAL = read_START_SIGNAL_value
    End Property

    Property Let set_START_SIGNAL(aData)
        write_START_SIGNAL_value = aData
        flag_START_SIGNAL        = &H1
    End Property

    Property Get read_START_SIGNAL
        read
        read_START_SIGNAL = read_START_SIGNAL_value
    End Property

    Property Let write_START_SIGNAL(aData)
        set_START_SIGNAL = aData
        write
    End Property

    Property Get get_Sleep_mode
        get_Sleep_mode = read_Sleep_mode_value
    End Property

    Property Let set_Sleep_mode(aData)
        write_Sleep_mode_value = aData
        flag_Sleep_mode        = &H1
    End Property

    Property Get read_Sleep_mode
        read
        read_Sleep_mode = read_Sleep_mode_value
    End Property

    Property Let write_Sleep_mode(aData)
        set_Sleep_mode = aData
        write
    End Property

    Property Get get_WAKE_VIA_MDI
        get_WAKE_VIA_MDI = read_WAKE_VIA_MDI_value
    End Property

    Property Let set_WAKE_VIA_MDI(aData)
        write_WAKE_VIA_MDI_value = aData
        flag_WAKE_VIA_MDI        = &H1
    End Property

    Property Get read_WAKE_VIA_MDI
        read
        read_WAKE_VIA_MDI = read_WAKE_VIA_MDI_value
    End Property

    Property Let write_WAKE_VIA_MDI(aData)
        set_WAKE_VIA_MDI = aData
        write
    End Property

    Property Get get_WVM_STATE
        get_WVM_STATE = read_WVM_STATE_value
    End Property

    Property Let set_WVM_STATE(aData)
        write_WVM_STATE_value = aData
        flag_WVM_STATE        = &H1
    End Property

    Property Get read_WVM_STATE
        read
        read_WVM_STATE = read_WVM_STATE_value
    End Property

    Property Let write_WVM_STATE(aData)
        set_WVM_STATE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_PSD_CNT_value = rightShift(data_low, 13) and &H7
        read_START_SIGNAL_value = rightShift(data_low, 12) and &H1
        read_Sleep_mode_value = rightShift(data_low, 8) and &Hf
        read_WAKE_VIA_MDI_value = rightShift(data_low, 4) and &Hf
        WVM_STATE_mask = &Hf
        if data_low > LONG_MAX then
            if WVM_STATE_mask = mask then
                read_WVM_STATE_value = data_low
            else
                read_WVM_STATE_value = (data_low - H8000_0000) and WVM_STATE_mask
            end If
        else
            read_WVM_STATE_value = data_low and WVM_STATE_mask
        end If

    End Sub

    Sub write
        If flag_PSD_CNT = &H0 or flag_START_SIGNAL = &H0 or flag_Sleep_mode = &H0 or flag_WAKE_VIA_MDI = &H0 or flag_WVM_STATE = &H0 Then read
        If flag_PSD_CNT = &H0 Then write_PSD_CNT_value = get_PSD_CNT
        If flag_START_SIGNAL = &H0 Then write_START_SIGNAL_value = get_START_SIGNAL
        If flag_Sleep_mode = &H0 Then write_Sleep_mode_value = get_Sleep_mode
        If flag_WAKE_VIA_MDI = &H0 Then write_WAKE_VIA_MDI_value = get_WAKE_VIA_MDI
        If flag_WVM_STATE = &H0 Then write_WVM_STATE_value = get_WVM_STATE

        regValue = leftShift((write_PSD_CNT_value and &H7), 13) + leftShift((write_START_SIGNAL_value and &H1), 12) + leftShift((write_Sleep_mode_value and &Hf), 8) + leftShift((write_WAKE_VIA_MDI_value and &Hf), 4) + leftShift((write_WVM_STATE_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_PSD_CNT_value = rightShift(data_low, 13) and &H7
        read_START_SIGNAL_value = rightShift(data_low, 12) and &H1
        read_Sleep_mode_value = rightShift(data_low, 8) and &Hf
        read_WAKE_VIA_MDI_value = rightShift(data_low, 4) and &Hf
        WVM_STATE_mask = &Hf
        if data_low > LONG_MAX then
            if WVM_STATE_mask = mask then
                read_WVM_STATE_value = data_low
            else
                read_WVM_STATE_value = (data_low - H8000_0000) and WVM_STATE_mask
            end If
        else
            read_WVM_STATE_value = data_low and WVM_STATE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PSD_CNT_value = &H0
        flag_PSD_CNT        = &H0
        write_START_SIGNAL_value = &H0
        flag_START_SIGNAL        = &H0
        write_Sleep_mode_value = &H0
        flag_Sleep_mode        = &H0
        write_WAKE_VIA_MDI_value = &H0
        flag_WAKE_VIA_MDI        = &H0
        write_WVM_STATE_value = &H0
        flag_WVM_STATE        = &H0
    End Sub
End Class


'' @REGISTER : TOP_MISC_an_tx_amp_cntrl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' an_100bt1_abist_out                        [15:12]          get_an_100bt1_abist_out
''                                                             set_an_100bt1_abist_out
''                                                             read_an_100bt1_abist_out
''                                                             write_an_100bt1_abist_out
''---------------------------------------------------------------------------------
'' an_100bt1_bias_trim                        [11:8]           get_an_100bt1_bias_trim
''                                                             set_an_100bt1_bias_trim
''                                                             read_an_100bt1_bias_trim
''                                                             write_an_100bt1_bias_trim
''---------------------------------------------------------------------------------
'' an_BR_abist_out                            [7:4]            get_an_BR_abist_out
''                                                             set_an_BR_abist_out
''                                                             read_an_BR_abist_out
''                                                             write_an_BR_abist_out
''---------------------------------------------------------------------------------
'' an_BR_bias_trim                            [3:0]            get_an_BR_bias_trim
''                                                             set_an_BR_bias_trim
''                                                             read_an_BR_bias_trim
''                                                             write_an_BR_bias_trim
''---------------------------------------------------------------------------------
Class REGISTER_TOP_MISC_an_tx_amp_cntrl
    Private write_an_100bt1_abist_out_value
    Private read_an_100bt1_abist_out_value
    Private flag_an_100bt1_abist_out
    Private write_an_100bt1_bias_trim_value
    Private read_an_100bt1_bias_trim_value
    Private flag_an_100bt1_bias_trim
    Private write_an_BR_abist_out_value
    Private read_an_BR_abist_out_value
    Private flag_an_BR_abist_out
    Private write_an_BR_bias_trim_value
    Private read_an_BR_bias_trim_value
    Private flag_an_BR_bias_trim

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

    Property Get get_an_100bt1_abist_out
        get_an_100bt1_abist_out = read_an_100bt1_abist_out_value
    End Property

    Property Let set_an_100bt1_abist_out(aData)
        write_an_100bt1_abist_out_value = aData
        flag_an_100bt1_abist_out        = &H1
    End Property

    Property Get read_an_100bt1_abist_out
        read
        read_an_100bt1_abist_out = read_an_100bt1_abist_out_value
    End Property

    Property Let write_an_100bt1_abist_out(aData)
        set_an_100bt1_abist_out = aData
        write
    End Property

    Property Get get_an_100bt1_bias_trim
        get_an_100bt1_bias_trim = read_an_100bt1_bias_trim_value
    End Property

    Property Let set_an_100bt1_bias_trim(aData)
        write_an_100bt1_bias_trim_value = aData
        flag_an_100bt1_bias_trim        = &H1
    End Property

    Property Get read_an_100bt1_bias_trim
        read
        read_an_100bt1_bias_trim = read_an_100bt1_bias_trim_value
    End Property

    Property Let write_an_100bt1_bias_trim(aData)
        set_an_100bt1_bias_trim = aData
        write
    End Property

    Property Get get_an_BR_abist_out
        get_an_BR_abist_out = read_an_BR_abist_out_value
    End Property

    Property Let set_an_BR_abist_out(aData)
        write_an_BR_abist_out_value = aData
        flag_an_BR_abist_out        = &H1
    End Property

    Property Get read_an_BR_abist_out
        read
        read_an_BR_abist_out = read_an_BR_abist_out_value
    End Property

    Property Let write_an_BR_abist_out(aData)
        set_an_BR_abist_out = aData
        write
    End Property

    Property Get get_an_BR_bias_trim
        get_an_BR_bias_trim = read_an_BR_bias_trim_value
    End Property

    Property Let set_an_BR_bias_trim(aData)
        write_an_BR_bias_trim_value = aData
        flag_an_BR_bias_trim        = &H1
    End Property

    Property Get read_an_BR_bias_trim
        read
        read_an_BR_bias_trim = read_an_BR_bias_trim_value
    End Property

    Property Let write_an_BR_bias_trim(aData)
        set_an_BR_bias_trim = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_an_100bt1_abist_out_value = rightShift(data_low, 12) and &Hf
        read_an_100bt1_bias_trim_value = rightShift(data_low, 8) and &Hf
        read_an_BR_abist_out_value = rightShift(data_low, 4) and &Hf
        an_BR_bias_trim_mask = &Hf
        if data_low > LONG_MAX then
            if an_BR_bias_trim_mask = mask then
                read_an_BR_bias_trim_value = data_low
            else
                read_an_BR_bias_trim_value = (data_low - H8000_0000) and an_BR_bias_trim_mask
            end If
        else
            read_an_BR_bias_trim_value = data_low and an_BR_bias_trim_mask
        end If

    End Sub

    Sub write
        If flag_an_100bt1_abist_out = &H0 or flag_an_100bt1_bias_trim = &H0 or flag_an_BR_abist_out = &H0 or flag_an_BR_bias_trim = &H0 Then read
        If flag_an_100bt1_abist_out = &H0 Then write_an_100bt1_abist_out_value = get_an_100bt1_abist_out
        If flag_an_100bt1_bias_trim = &H0 Then write_an_100bt1_bias_trim_value = get_an_100bt1_bias_trim
        If flag_an_BR_abist_out = &H0 Then write_an_BR_abist_out_value = get_an_BR_abist_out
        If flag_an_BR_bias_trim = &H0 Then write_an_BR_bias_trim_value = get_an_BR_bias_trim

        regValue = leftShift((write_an_100bt1_abist_out_value and &Hf), 12) + leftShift((write_an_100bt1_bias_trim_value and &Hf), 8) + leftShift((write_an_BR_abist_out_value and &Hf), 4) + leftShift((write_an_BR_bias_trim_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_an_100bt1_abist_out_value = rightShift(data_low, 12) and &Hf
        read_an_100bt1_bias_trim_value = rightShift(data_low, 8) and &Hf
        read_an_BR_abist_out_value = rightShift(data_low, 4) and &Hf
        an_BR_bias_trim_mask = &Hf
        if data_low > LONG_MAX then
            if an_BR_bias_trim_mask = mask then
                read_an_BR_bias_trim_value = data_low
            else
                read_an_BR_bias_trim_value = (data_low - H8000_0000) and an_BR_bias_trim_mask
            end If
        else
            read_an_BR_bias_trim_value = data_low and an_BR_bias_trim_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_an_100bt1_abist_out_value = &H0
        flag_an_100bt1_abist_out        = &H0
        write_an_100bt1_bias_trim_value = &H0
        flag_an_100bt1_bias_trim        = &H0
        write_an_BR_abist_out_value = &H0
        flag_an_BR_abist_out        = &H0
        write_an_BR_bias_trim_value = &H0
        flag_an_BR_bias_trim        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class TOP_MISC_INSTANCE

    Public spare_reg_0
    Public spare_reg_1
    Public afe_ovr
    Public test_reg0
    Public test_reg1
    Public top_global_reset_reg
    Public interrupt_status_reg
    Public tc10_afe_clr_test_reg
    Public an_tx_amp_cntrl


    Public default function Init(aBaseAddr)
        Set spare_reg_0 = (New REGISTER_TOP_MISC_spare_reg_0)(aBaseAddr, 16)
        Set spare_reg_1 = (New REGISTER_TOP_MISC_spare_reg_1)(aBaseAddr, 16)
        Set afe_ovr = (New REGISTER_TOP_MISC_afe_ovr)(aBaseAddr, 16)
        Set test_reg0 = (New REGISTER_TOP_MISC_test_reg0)(aBaseAddr, 16)
        Set test_reg1 = (New REGISTER_TOP_MISC_test_reg1)(aBaseAddr, 16)
        Set top_global_reset_reg = (New REGISTER_TOP_MISC_top_global_reset_reg)(aBaseAddr, 16)
        Set interrupt_status_reg = (New REGISTER_TOP_MISC_interrupt_status_reg)(aBaseAddr, 16)
        Set tc10_afe_clr_test_reg = (New REGISTER_TOP_MISC_tc10_afe_clr_test_reg)(aBaseAddr, 16)
        Set an_tx_amp_cntrl = (New REGISTER_TOP_MISC_an_tx_amp_cntrl)(aBaseAddr, 16)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set TOP_MISC = CreateObject("System.Collections.ArrayList")
TOP_MISC.Add ((New TOP_MISC_INSTANCE)(&H4a4f3000))


