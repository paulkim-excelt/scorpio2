

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


'' @REGISTER : FFE_control_0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' FFERSTN_FORCE_DEASSERT                     [14:14]          get_FFERSTN_FORCE_DEASSERT
''                                                             set_FFERSTN_FORCE_DEASSERT
''                                                             read_FFERSTN_FORCE_DEASSERT
''                                                             write_FFERSTN_FORCE_DEASSERT
''---------------------------------------------------------------------------------
'' FFERSTN_FORCE_ASSERT                       [13:13]          get_FFERSTN_FORCE_ASSERT
''                                                             set_FFERSTN_FORCE_ASSERT
''                                                             read_FFERSTN_FORCE_ASSERT
''                                                             write_FFERSTN_FORCE_ASSERT
''---------------------------------------------------------------------------------
'' MU_OVERRIDE                                [12:12]          get_MU_OVERRIDE
''                                                             set_MU_OVERRIDE
''                                                             read_MU_OVERRIDE
''                                                             write_MU_OVERRIDE
''---------------------------------------------------------------------------------
'' FFELGEAR                                   [11:11]          get_FFELGEAR
''                                                             set_FFELGEAR
''                                                             read_FFELGEAR
''                                                             write_FFELGEAR
''---------------------------------------------------------------------------------
'' HI_MU_CTL                                  [10:9]           get_HI_MU_CTL
''                                                             set_HI_MU_CTL
''                                                             read_HI_MU_CTL
''                                                             write_HI_MU_CTL
''---------------------------------------------------------------------------------
'' LO_MU_CTL                                  [8:7]            get_LO_MU_CTL
''                                                             set_LO_MU_CTL
''                                                             read_LO_MU_CTL
''                                                             write_LO_MU_CTL
''---------------------------------------------------------------------------------
'' LMS_LKG_SEL                                [6:5]            get_LMS_LKG_SEL
''                                                             set_LMS_LKG_SEL
''                                                             read_LMS_LKG_SEL
''                                                             write_LMS_LKG_SEL
''---------------------------------------------------------------------------------
'' LMS_LKG_EN                                 [4:4]            get_LMS_LKG_EN
''                                                             set_LMS_LKG_EN
''                                                             read_LMS_LKG_EN
''                                                             write_LMS_LKG_EN
''---------------------------------------------------------------------------------
'' LMS_UPDT_CTL                               [3:3]            get_LMS_UPDT_CTL
''                                                             set_LMS_UPDT_CTL
''                                                             read_LMS_UPDT_CTL
''                                                             write_LMS_UPDT_CTL
''---------------------------------------------------------------------------------
'' POST_CURSOR_SEL                            [2:2]            get_POST_CURSOR_SEL
''                                                             set_POST_CURSOR_SEL
''                                                             read_POST_CURSOR_SEL
''                                                             write_POST_CURSOR_SEL
''---------------------------------------------------------------------------------
'' GAMMA_SEL                                  [1:1]            get_GAMMA_SEL
''                                                             set_GAMMA_SEL
''                                                             read_GAMMA_SEL
''                                                             write_GAMMA_SEL
''---------------------------------------------------------------------------------
'' MAIN_TAP_SEL                               [0:0]            get_MAIN_TAP_SEL
''                                                             set_MAIN_TAP_SEL
''                                                             read_MAIN_TAP_SEL
''                                                             write_MAIN_TAP_SEL
''---------------------------------------------------------------------------------
Class REGISTER_FFE_control_0
    Private write_FFERSTN_FORCE_DEASSERT_value
    Private read_FFERSTN_FORCE_DEASSERT_value
    Private flag_FFERSTN_FORCE_DEASSERT
    Private write_FFERSTN_FORCE_ASSERT_value
    Private read_FFERSTN_FORCE_ASSERT_value
    Private flag_FFERSTN_FORCE_ASSERT
    Private write_MU_OVERRIDE_value
    Private read_MU_OVERRIDE_value
    Private flag_MU_OVERRIDE
    Private write_FFELGEAR_value
    Private read_FFELGEAR_value
    Private flag_FFELGEAR
    Private write_HI_MU_CTL_value
    Private read_HI_MU_CTL_value
    Private flag_HI_MU_CTL
    Private write_LO_MU_CTL_value
    Private read_LO_MU_CTL_value
    Private flag_LO_MU_CTL
    Private write_LMS_LKG_SEL_value
    Private read_LMS_LKG_SEL_value
    Private flag_LMS_LKG_SEL
    Private write_LMS_LKG_EN_value
    Private read_LMS_LKG_EN_value
    Private flag_LMS_LKG_EN
    Private write_LMS_UPDT_CTL_value
    Private read_LMS_UPDT_CTL_value
    Private flag_LMS_UPDT_CTL
    Private write_POST_CURSOR_SEL_value
    Private read_POST_CURSOR_SEL_value
    Private flag_POST_CURSOR_SEL
    Private write_GAMMA_SEL_value
    Private read_GAMMA_SEL_value
    Private flag_GAMMA_SEL
    Private write_MAIN_TAP_SEL_value
    Private read_MAIN_TAP_SEL_value
    Private flag_MAIN_TAP_SEL

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

    Property Get get_FFERSTN_FORCE_DEASSERT
        get_FFERSTN_FORCE_DEASSERT = read_FFERSTN_FORCE_DEASSERT_value
    End Property

    Property Let set_FFERSTN_FORCE_DEASSERT(aData)
        write_FFERSTN_FORCE_DEASSERT_value = aData
        flag_FFERSTN_FORCE_DEASSERT        = &H1
    End Property

    Property Get read_FFERSTN_FORCE_DEASSERT
        read
        read_FFERSTN_FORCE_DEASSERT = read_FFERSTN_FORCE_DEASSERT_value
    End Property

    Property Let write_FFERSTN_FORCE_DEASSERT(aData)
        set_FFERSTN_FORCE_DEASSERT = aData
        write
    End Property

    Property Get get_FFERSTN_FORCE_ASSERT
        get_FFERSTN_FORCE_ASSERT = read_FFERSTN_FORCE_ASSERT_value
    End Property

    Property Let set_FFERSTN_FORCE_ASSERT(aData)
        write_FFERSTN_FORCE_ASSERT_value = aData
        flag_FFERSTN_FORCE_ASSERT        = &H1
    End Property

    Property Get read_FFERSTN_FORCE_ASSERT
        read
        read_FFERSTN_FORCE_ASSERT = read_FFERSTN_FORCE_ASSERT_value
    End Property

    Property Let write_FFERSTN_FORCE_ASSERT(aData)
        set_FFERSTN_FORCE_ASSERT = aData
        write
    End Property

    Property Get get_MU_OVERRIDE
        get_MU_OVERRIDE = read_MU_OVERRIDE_value
    End Property

    Property Let set_MU_OVERRIDE(aData)
        write_MU_OVERRIDE_value = aData
        flag_MU_OVERRIDE        = &H1
    End Property

    Property Get read_MU_OVERRIDE
        read
        read_MU_OVERRIDE = read_MU_OVERRIDE_value
    End Property

    Property Let write_MU_OVERRIDE(aData)
        set_MU_OVERRIDE = aData
        write
    End Property

    Property Get get_FFELGEAR
        get_FFELGEAR = read_FFELGEAR_value
    End Property

    Property Let set_FFELGEAR(aData)
        write_FFELGEAR_value = aData
        flag_FFELGEAR        = &H1
    End Property

    Property Get read_FFELGEAR
        read
        read_FFELGEAR = read_FFELGEAR_value
    End Property

    Property Let write_FFELGEAR(aData)
        set_FFELGEAR = aData
        write
    End Property

    Property Get get_HI_MU_CTL
        get_HI_MU_CTL = read_HI_MU_CTL_value
    End Property

    Property Let set_HI_MU_CTL(aData)
        write_HI_MU_CTL_value = aData
        flag_HI_MU_CTL        = &H1
    End Property

    Property Get read_HI_MU_CTL
        read
        read_HI_MU_CTL = read_HI_MU_CTL_value
    End Property

    Property Let write_HI_MU_CTL(aData)
        set_HI_MU_CTL = aData
        write
    End Property

    Property Get get_LO_MU_CTL
        get_LO_MU_CTL = read_LO_MU_CTL_value
    End Property

    Property Let set_LO_MU_CTL(aData)
        write_LO_MU_CTL_value = aData
        flag_LO_MU_CTL        = &H1
    End Property

    Property Get read_LO_MU_CTL
        read
        read_LO_MU_CTL = read_LO_MU_CTL_value
    End Property

    Property Let write_LO_MU_CTL(aData)
        set_LO_MU_CTL = aData
        write
    End Property

    Property Get get_LMS_LKG_SEL
        get_LMS_LKG_SEL = read_LMS_LKG_SEL_value
    End Property

    Property Let set_LMS_LKG_SEL(aData)
        write_LMS_LKG_SEL_value = aData
        flag_LMS_LKG_SEL        = &H1
    End Property

    Property Get read_LMS_LKG_SEL
        read
        read_LMS_LKG_SEL = read_LMS_LKG_SEL_value
    End Property

    Property Let write_LMS_LKG_SEL(aData)
        set_LMS_LKG_SEL = aData
        write
    End Property

    Property Get get_LMS_LKG_EN
        get_LMS_LKG_EN = read_LMS_LKG_EN_value
    End Property

    Property Let set_LMS_LKG_EN(aData)
        write_LMS_LKG_EN_value = aData
        flag_LMS_LKG_EN        = &H1
    End Property

    Property Get read_LMS_LKG_EN
        read
        read_LMS_LKG_EN = read_LMS_LKG_EN_value
    End Property

    Property Let write_LMS_LKG_EN(aData)
        set_LMS_LKG_EN = aData
        write
    End Property

    Property Get get_LMS_UPDT_CTL
        get_LMS_UPDT_CTL = read_LMS_UPDT_CTL_value
    End Property

    Property Let set_LMS_UPDT_CTL(aData)
        write_LMS_UPDT_CTL_value = aData
        flag_LMS_UPDT_CTL        = &H1
    End Property

    Property Get read_LMS_UPDT_CTL
        read
        read_LMS_UPDT_CTL = read_LMS_UPDT_CTL_value
    End Property

    Property Let write_LMS_UPDT_CTL(aData)
        set_LMS_UPDT_CTL = aData
        write
    End Property

    Property Get get_POST_CURSOR_SEL
        get_POST_CURSOR_SEL = read_POST_CURSOR_SEL_value
    End Property

    Property Let set_POST_CURSOR_SEL(aData)
        write_POST_CURSOR_SEL_value = aData
        flag_POST_CURSOR_SEL        = &H1
    End Property

    Property Get read_POST_CURSOR_SEL
        read
        read_POST_CURSOR_SEL = read_POST_CURSOR_SEL_value
    End Property

    Property Let write_POST_CURSOR_SEL(aData)
        set_POST_CURSOR_SEL = aData
        write
    End Property

    Property Get get_GAMMA_SEL
        get_GAMMA_SEL = read_GAMMA_SEL_value
    End Property

    Property Let set_GAMMA_SEL(aData)
        write_GAMMA_SEL_value = aData
        flag_GAMMA_SEL        = &H1
    End Property

    Property Get read_GAMMA_SEL
        read
        read_GAMMA_SEL = read_GAMMA_SEL_value
    End Property

    Property Let write_GAMMA_SEL(aData)
        set_GAMMA_SEL = aData
        write
    End Property

    Property Get get_MAIN_TAP_SEL
        get_MAIN_TAP_SEL = read_MAIN_TAP_SEL_value
    End Property

    Property Let set_MAIN_TAP_SEL(aData)
        write_MAIN_TAP_SEL_value = aData
        flag_MAIN_TAP_SEL        = &H1
    End Property

    Property Get read_MAIN_TAP_SEL
        read
        read_MAIN_TAP_SEL = read_MAIN_TAP_SEL_value
    End Property

    Property Let write_MAIN_TAP_SEL(aData)
        set_MAIN_TAP_SEL = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_FFERSTN_FORCE_DEASSERT_value = rightShift(data_low, 14) and &H1
        read_FFERSTN_FORCE_ASSERT_value = rightShift(data_low, 13) and &H1
        read_MU_OVERRIDE_value = rightShift(data_low, 12) and &H1
        read_FFELGEAR_value = rightShift(data_low, 11) and &H1
        read_HI_MU_CTL_value = rightShift(data_low, 9) and &H3
        read_LO_MU_CTL_value = rightShift(data_low, 7) and &H3
        read_LMS_LKG_SEL_value = rightShift(data_low, 5) and &H3
        read_LMS_LKG_EN_value = rightShift(data_low, 4) and &H1
        read_LMS_UPDT_CTL_value = rightShift(data_low, 3) and &H1
        read_POST_CURSOR_SEL_value = rightShift(data_low, 2) and &H1
        read_GAMMA_SEL_value = rightShift(data_low, 1) and &H1
        MAIN_TAP_SEL_mask = &H1
        if data_low > LONG_MAX then
            if MAIN_TAP_SEL_mask = mask then
                read_MAIN_TAP_SEL_value = data_low
            else
                read_MAIN_TAP_SEL_value = (data_low - H8000_0000) and MAIN_TAP_SEL_mask
            end If
        else
            read_MAIN_TAP_SEL_value = data_low and MAIN_TAP_SEL_mask
        end If

    End Sub

    Sub write
        If flag_FFERSTN_FORCE_DEASSERT = &H0 or flag_FFERSTN_FORCE_ASSERT = &H0 or flag_MU_OVERRIDE = &H0 or flag_FFELGEAR = &H0 or flag_HI_MU_CTL = &H0 or flag_LO_MU_CTL = &H0 or flag_LMS_LKG_SEL = &H0 or flag_LMS_LKG_EN = &H0 or flag_LMS_UPDT_CTL = &H0 or flag_POST_CURSOR_SEL = &H0 or flag_GAMMA_SEL = &H0 or flag_MAIN_TAP_SEL = &H0 Then read
        If flag_FFERSTN_FORCE_DEASSERT = &H0 Then write_FFERSTN_FORCE_DEASSERT_value = get_FFERSTN_FORCE_DEASSERT
        If flag_FFERSTN_FORCE_ASSERT = &H0 Then write_FFERSTN_FORCE_ASSERT_value = get_FFERSTN_FORCE_ASSERT
        If flag_MU_OVERRIDE = &H0 Then write_MU_OVERRIDE_value = get_MU_OVERRIDE
        If flag_FFELGEAR = &H0 Then write_FFELGEAR_value = get_FFELGEAR
        If flag_HI_MU_CTL = &H0 Then write_HI_MU_CTL_value = get_HI_MU_CTL
        If flag_LO_MU_CTL = &H0 Then write_LO_MU_CTL_value = get_LO_MU_CTL
        If flag_LMS_LKG_SEL = &H0 Then write_LMS_LKG_SEL_value = get_LMS_LKG_SEL
        If flag_LMS_LKG_EN = &H0 Then write_LMS_LKG_EN_value = get_LMS_LKG_EN
        If flag_LMS_UPDT_CTL = &H0 Then write_LMS_UPDT_CTL_value = get_LMS_UPDT_CTL
        If flag_POST_CURSOR_SEL = &H0 Then write_POST_CURSOR_SEL_value = get_POST_CURSOR_SEL
        If flag_GAMMA_SEL = &H0 Then write_GAMMA_SEL_value = get_GAMMA_SEL
        If flag_MAIN_TAP_SEL = &H0 Then write_MAIN_TAP_SEL_value = get_MAIN_TAP_SEL

        regValue = leftShift((write_FFERSTN_FORCE_DEASSERT_value and &H1), 14) + leftShift((write_FFERSTN_FORCE_ASSERT_value and &H1), 13) + leftShift((write_MU_OVERRIDE_value and &H1), 12) + leftShift((write_FFELGEAR_value and &H1), 11) + leftShift((write_HI_MU_CTL_value and &H3), 9) + leftShift((write_LO_MU_CTL_value and &H3), 7) + leftShift((write_LMS_LKG_SEL_value and &H3), 5) + leftShift((write_LMS_LKG_EN_value and &H1), 4) + leftShift((write_LMS_UPDT_CTL_value and &H1), 3) + leftShift((write_POST_CURSOR_SEL_value and &H1), 2) + leftShift((write_GAMMA_SEL_value and &H1), 1) + leftShift((write_MAIN_TAP_SEL_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_FFERSTN_FORCE_DEASSERT_value = rightShift(data_low, 14) and &H1
        read_FFERSTN_FORCE_ASSERT_value = rightShift(data_low, 13) and &H1
        read_MU_OVERRIDE_value = rightShift(data_low, 12) and &H1
        read_FFELGEAR_value = rightShift(data_low, 11) and &H1
        read_HI_MU_CTL_value = rightShift(data_low, 9) and &H3
        read_LO_MU_CTL_value = rightShift(data_low, 7) and &H3
        read_LMS_LKG_SEL_value = rightShift(data_low, 5) and &H3
        read_LMS_LKG_EN_value = rightShift(data_low, 4) and &H1
        read_LMS_UPDT_CTL_value = rightShift(data_low, 3) and &H1
        read_POST_CURSOR_SEL_value = rightShift(data_low, 2) and &H1
        read_GAMMA_SEL_value = rightShift(data_low, 1) and &H1
        MAIN_TAP_SEL_mask = &H1
        if data_low > LONG_MAX then
            if MAIN_TAP_SEL_mask = mask then
                read_MAIN_TAP_SEL_value = data_low
            else
                read_MAIN_TAP_SEL_value = (data_low - H8000_0000) and MAIN_TAP_SEL_mask
            end If
        else
            read_MAIN_TAP_SEL_value = data_low and MAIN_TAP_SEL_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_FFERSTN_FORCE_DEASSERT_value = &H0
        flag_FFERSTN_FORCE_DEASSERT        = &H0
        write_FFERSTN_FORCE_ASSERT_value = &H0
        flag_FFERSTN_FORCE_ASSERT        = &H0
        write_MU_OVERRIDE_value = &H0
        flag_MU_OVERRIDE        = &H0
        write_FFELGEAR_value = &H0
        flag_FFELGEAR        = &H0
        write_HI_MU_CTL_value = &H0
        flag_HI_MU_CTL        = &H0
        write_LO_MU_CTL_value = &H0
        flag_LO_MU_CTL        = &H0
        write_LMS_LKG_SEL_value = &H0
        flag_LMS_LKG_SEL        = &H0
        write_LMS_LKG_EN_value = &H0
        flag_LMS_LKG_EN        = &H0
        write_LMS_UPDT_CTL_value = &H0
        flag_LMS_UPDT_CTL        = &H0
        write_POST_CURSOR_SEL_value = &H0
        flag_POST_CURSOR_SEL        = &H0
        write_GAMMA_SEL_value = &H0
        flag_GAMMA_SEL        = &H0
        write_MAIN_TAP_SEL_value = &H0
        flag_MAIN_TAP_SEL        = &H0
    End Sub
End Class


'' @REGISTER : FFE_freeze_force_assert_15_00
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' FREEZE_FORCE_ASSERT_15_00                  [15:0]           get_FREEZE_FORCE_ASSERT_15_00
''                                                             set_FREEZE_FORCE_ASSERT_15_00
''                                                             read_FREEZE_FORCE_ASSERT_15_00
''                                                             write_FREEZE_FORCE_ASSERT_15_00
''---------------------------------------------------------------------------------
Class REGISTER_FFE_freeze_force_assert_15_00
    Private write_FREEZE_FORCE_ASSERT_15_00_value
    Private read_FREEZE_FORCE_ASSERT_15_00_value
    Private flag_FREEZE_FORCE_ASSERT_15_00

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

    Property Get get_FREEZE_FORCE_ASSERT_15_00
        get_FREEZE_FORCE_ASSERT_15_00 = read_FREEZE_FORCE_ASSERT_15_00_value
    End Property

    Property Let set_FREEZE_FORCE_ASSERT_15_00(aData)
        write_FREEZE_FORCE_ASSERT_15_00_value = aData
        flag_FREEZE_FORCE_ASSERT_15_00        = &H1
    End Property

    Property Get read_FREEZE_FORCE_ASSERT_15_00
        read
        read_FREEZE_FORCE_ASSERT_15_00 = read_FREEZE_FORCE_ASSERT_15_00_value
    End Property

    Property Let write_FREEZE_FORCE_ASSERT_15_00(aData)
        set_FREEZE_FORCE_ASSERT_15_00 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        FREEZE_FORCE_ASSERT_15_00_mask = &Hffff
        if data_low > LONG_MAX then
            if FREEZE_FORCE_ASSERT_15_00_mask = mask then
                read_FREEZE_FORCE_ASSERT_15_00_value = data_low
            else
                read_FREEZE_FORCE_ASSERT_15_00_value = (data_low - H8000_0000) and FREEZE_FORCE_ASSERT_15_00_mask
            end If
        else
            read_FREEZE_FORCE_ASSERT_15_00_value = data_low and FREEZE_FORCE_ASSERT_15_00_mask
        end If

    End Sub

    Sub write
        If flag_FREEZE_FORCE_ASSERT_15_00 = &H0 Then read
        If flag_FREEZE_FORCE_ASSERT_15_00 = &H0 Then write_FREEZE_FORCE_ASSERT_15_00_value = get_FREEZE_FORCE_ASSERT_15_00

        regValue = leftShift((write_FREEZE_FORCE_ASSERT_15_00_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        FREEZE_FORCE_ASSERT_15_00_mask = &Hffff
        if data_low > LONG_MAX then
            if FREEZE_FORCE_ASSERT_15_00_mask = mask then
                read_FREEZE_FORCE_ASSERT_15_00_value = data_low
            else
                read_FREEZE_FORCE_ASSERT_15_00_value = (data_low - H8000_0000) and FREEZE_FORCE_ASSERT_15_00_mask
            end If
        else
            read_FREEZE_FORCE_ASSERT_15_00_value = data_low and FREEZE_FORCE_ASSERT_15_00_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_FREEZE_FORCE_ASSERT_15_00_value = &H0
        flag_FREEZE_FORCE_ASSERT_15_00        = &H0
    End Sub
End Class


'' @REGISTER : FFE_freeze_force_assert_31_16
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' FREEZE_FORCE_ASSERT_31_16                  [15:0]           get_FREEZE_FORCE_ASSERT_31_16
''                                                             set_FREEZE_FORCE_ASSERT_31_16
''                                                             read_FREEZE_FORCE_ASSERT_31_16
''                                                             write_FREEZE_FORCE_ASSERT_31_16
''---------------------------------------------------------------------------------
Class REGISTER_FFE_freeze_force_assert_31_16
    Private write_FREEZE_FORCE_ASSERT_31_16_value
    Private read_FREEZE_FORCE_ASSERT_31_16_value
    Private flag_FREEZE_FORCE_ASSERT_31_16

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

    Property Get get_FREEZE_FORCE_ASSERT_31_16
        get_FREEZE_FORCE_ASSERT_31_16 = read_FREEZE_FORCE_ASSERT_31_16_value
    End Property

    Property Let set_FREEZE_FORCE_ASSERT_31_16(aData)
        write_FREEZE_FORCE_ASSERT_31_16_value = aData
        flag_FREEZE_FORCE_ASSERT_31_16        = &H1
    End Property

    Property Get read_FREEZE_FORCE_ASSERT_31_16
        read
        read_FREEZE_FORCE_ASSERT_31_16 = read_FREEZE_FORCE_ASSERT_31_16_value
    End Property

    Property Let write_FREEZE_FORCE_ASSERT_31_16(aData)
        set_FREEZE_FORCE_ASSERT_31_16 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        FREEZE_FORCE_ASSERT_31_16_mask = &Hffff
        if data_low > LONG_MAX then
            if FREEZE_FORCE_ASSERT_31_16_mask = mask then
                read_FREEZE_FORCE_ASSERT_31_16_value = data_low
            else
                read_FREEZE_FORCE_ASSERT_31_16_value = (data_low - H8000_0000) and FREEZE_FORCE_ASSERT_31_16_mask
            end If
        else
            read_FREEZE_FORCE_ASSERT_31_16_value = data_low and FREEZE_FORCE_ASSERT_31_16_mask
        end If

    End Sub

    Sub write
        If flag_FREEZE_FORCE_ASSERT_31_16 = &H0 Then read
        If flag_FREEZE_FORCE_ASSERT_31_16 = &H0 Then write_FREEZE_FORCE_ASSERT_31_16_value = get_FREEZE_FORCE_ASSERT_31_16

        regValue = leftShift((write_FREEZE_FORCE_ASSERT_31_16_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        FREEZE_FORCE_ASSERT_31_16_mask = &Hffff
        if data_low > LONG_MAX then
            if FREEZE_FORCE_ASSERT_31_16_mask = mask then
                read_FREEZE_FORCE_ASSERT_31_16_value = data_low
            else
                read_FREEZE_FORCE_ASSERT_31_16_value = (data_low - H8000_0000) and FREEZE_FORCE_ASSERT_31_16_mask
            end If
        else
            read_FREEZE_FORCE_ASSERT_31_16_value = data_low and FREEZE_FORCE_ASSERT_31_16_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_FREEZE_FORCE_ASSERT_31_16_value = &H0
        flag_FREEZE_FORCE_ASSERT_31_16        = &H0
    End Sub
End Class


'' @REGISTER : FFE_freeze_force_deassert_15_00
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' FREEZE_FORCE_DEASSERT_15_00                [15:0]           get_FREEZE_FORCE_DEASSERT_15_00
''                                                             set_FREEZE_FORCE_DEASSERT_15_00
''                                                             read_FREEZE_FORCE_DEASSERT_15_00
''                                                             write_FREEZE_FORCE_DEASSERT_15_00
''---------------------------------------------------------------------------------
Class REGISTER_FFE_freeze_force_deassert_15_00
    Private write_FREEZE_FORCE_DEASSERT_15_00_value
    Private read_FREEZE_FORCE_DEASSERT_15_00_value
    Private flag_FREEZE_FORCE_DEASSERT_15_00

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

    Property Get get_FREEZE_FORCE_DEASSERT_15_00
        get_FREEZE_FORCE_DEASSERT_15_00 = read_FREEZE_FORCE_DEASSERT_15_00_value
    End Property

    Property Let set_FREEZE_FORCE_DEASSERT_15_00(aData)
        write_FREEZE_FORCE_DEASSERT_15_00_value = aData
        flag_FREEZE_FORCE_DEASSERT_15_00        = &H1
    End Property

    Property Get read_FREEZE_FORCE_DEASSERT_15_00
        read
        read_FREEZE_FORCE_DEASSERT_15_00 = read_FREEZE_FORCE_DEASSERT_15_00_value
    End Property

    Property Let write_FREEZE_FORCE_DEASSERT_15_00(aData)
        set_FREEZE_FORCE_DEASSERT_15_00 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        FREEZE_FORCE_DEASSERT_15_00_mask = &Hffff
        if data_low > LONG_MAX then
            if FREEZE_FORCE_DEASSERT_15_00_mask = mask then
                read_FREEZE_FORCE_DEASSERT_15_00_value = data_low
            else
                read_FREEZE_FORCE_DEASSERT_15_00_value = (data_low - H8000_0000) and FREEZE_FORCE_DEASSERT_15_00_mask
            end If
        else
            read_FREEZE_FORCE_DEASSERT_15_00_value = data_low and FREEZE_FORCE_DEASSERT_15_00_mask
        end If

    End Sub

    Sub write
        If flag_FREEZE_FORCE_DEASSERT_15_00 = &H0 Then read
        If flag_FREEZE_FORCE_DEASSERT_15_00 = &H0 Then write_FREEZE_FORCE_DEASSERT_15_00_value = get_FREEZE_FORCE_DEASSERT_15_00

        regValue = leftShift((write_FREEZE_FORCE_DEASSERT_15_00_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        FREEZE_FORCE_DEASSERT_15_00_mask = &Hffff
        if data_low > LONG_MAX then
            if FREEZE_FORCE_DEASSERT_15_00_mask = mask then
                read_FREEZE_FORCE_DEASSERT_15_00_value = data_low
            else
                read_FREEZE_FORCE_DEASSERT_15_00_value = (data_low - H8000_0000) and FREEZE_FORCE_DEASSERT_15_00_mask
            end If
        else
            read_FREEZE_FORCE_DEASSERT_15_00_value = data_low and FREEZE_FORCE_DEASSERT_15_00_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_FREEZE_FORCE_DEASSERT_15_00_value = &H0
        flag_FREEZE_FORCE_DEASSERT_15_00        = &H0
    End Sub
End Class


'' @REGISTER : FFE_freeze_force_deassert_31_16
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' FREEZE_FORCE_DEASSERT_31_16                [15:0]           get_FREEZE_FORCE_DEASSERT_31_16
''                                                             set_FREEZE_FORCE_DEASSERT_31_16
''                                                             read_FREEZE_FORCE_DEASSERT_31_16
''                                                             write_FREEZE_FORCE_DEASSERT_31_16
''---------------------------------------------------------------------------------
Class REGISTER_FFE_freeze_force_deassert_31_16
    Private write_FREEZE_FORCE_DEASSERT_31_16_value
    Private read_FREEZE_FORCE_DEASSERT_31_16_value
    Private flag_FREEZE_FORCE_DEASSERT_31_16

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

    Property Get get_FREEZE_FORCE_DEASSERT_31_16
        get_FREEZE_FORCE_DEASSERT_31_16 = read_FREEZE_FORCE_DEASSERT_31_16_value
    End Property

    Property Let set_FREEZE_FORCE_DEASSERT_31_16(aData)
        write_FREEZE_FORCE_DEASSERT_31_16_value = aData
        flag_FREEZE_FORCE_DEASSERT_31_16        = &H1
    End Property

    Property Get read_FREEZE_FORCE_DEASSERT_31_16
        read
        read_FREEZE_FORCE_DEASSERT_31_16 = read_FREEZE_FORCE_DEASSERT_31_16_value
    End Property

    Property Let write_FREEZE_FORCE_DEASSERT_31_16(aData)
        set_FREEZE_FORCE_DEASSERT_31_16 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        FREEZE_FORCE_DEASSERT_31_16_mask = &Hffff
        if data_low > LONG_MAX then
            if FREEZE_FORCE_DEASSERT_31_16_mask = mask then
                read_FREEZE_FORCE_DEASSERT_31_16_value = data_low
            else
                read_FREEZE_FORCE_DEASSERT_31_16_value = (data_low - H8000_0000) and FREEZE_FORCE_DEASSERT_31_16_mask
            end If
        else
            read_FREEZE_FORCE_DEASSERT_31_16_value = data_low and FREEZE_FORCE_DEASSERT_31_16_mask
        end If

    End Sub

    Sub write
        If flag_FREEZE_FORCE_DEASSERT_31_16 = &H0 Then read
        If flag_FREEZE_FORCE_DEASSERT_31_16 = &H0 Then write_FREEZE_FORCE_DEASSERT_31_16_value = get_FREEZE_FORCE_DEASSERT_31_16

        regValue = leftShift((write_FREEZE_FORCE_DEASSERT_31_16_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        FREEZE_FORCE_DEASSERT_31_16_mask = &Hffff
        if data_low > LONG_MAX then
            if FREEZE_FORCE_DEASSERT_31_16_mask = mask then
                read_FREEZE_FORCE_DEASSERT_31_16_value = data_low
            else
                read_FREEZE_FORCE_DEASSERT_31_16_value = (data_low - H8000_0000) and FREEZE_FORCE_DEASSERT_31_16_mask
            end If
        else
            read_FREEZE_FORCE_DEASSERT_31_16_value = data_low and FREEZE_FORCE_DEASSERT_31_16_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_FREEZE_FORCE_DEASSERT_31_16_value = &H0
        flag_FREEZE_FORCE_DEASSERT_31_16        = &H0
    End Sub
End Class


'' @REGISTER : FFE_coeff_00_lsb
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
Class REGISTER_FFE_coeff_00_lsb
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


'' @REGISTER : FFE_coeff_00_msb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COEFF_MSB                                  [8:0]            get_COEFF_MSB
''                                                             set_COEFF_MSB
''                                                             read_COEFF_MSB
''                                                             write_COEFF_MSB
''---------------------------------------------------------------------------------
Class REGISTER_FFE_coeff_00_msb
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
        COEFF_MSB_mask = &H1ff
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

        regValue = leftShift((write_COEFF_MSB_value and &H1ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_MSB_mask = &H1ff
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


'' @REGISTER : FFE_coeff_01_lsb
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
Class REGISTER_FFE_coeff_01_lsb
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


'' @REGISTER : FFE_coeff_01_msb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COEFF_MSB                                  [8:0]            get_COEFF_MSB
''                                                             set_COEFF_MSB
''                                                             read_COEFF_MSB
''                                                             write_COEFF_MSB
''---------------------------------------------------------------------------------
Class REGISTER_FFE_coeff_01_msb
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
        COEFF_MSB_mask = &H1ff
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

        regValue = leftShift((write_COEFF_MSB_value and &H1ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_MSB_mask = &H1ff
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


'' @REGISTER : FFE_coeff_02_lsb
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
Class REGISTER_FFE_coeff_02_lsb
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


'' @REGISTER : FFE_coeff_02_msb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COEFF_MSB                                  [8:0]            get_COEFF_MSB
''                                                             set_COEFF_MSB
''                                                             read_COEFF_MSB
''                                                             write_COEFF_MSB
''---------------------------------------------------------------------------------
Class REGISTER_FFE_coeff_02_msb
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
        COEFF_MSB_mask = &H1ff
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

        regValue = leftShift((write_COEFF_MSB_value and &H1ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_MSB_mask = &H1ff
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


'' @REGISTER : FFE_coeff_03_lsb
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
Class REGISTER_FFE_coeff_03_lsb
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


'' @REGISTER : FFE_coeff_03_msb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COEFF_MSB                                  [8:0]            get_COEFF_MSB
''                                                             set_COEFF_MSB
''                                                             read_COEFF_MSB
''                                                             write_COEFF_MSB
''---------------------------------------------------------------------------------
Class REGISTER_FFE_coeff_03_msb
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
        COEFF_MSB_mask = &H1ff
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

        regValue = leftShift((write_COEFF_MSB_value and &H1ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_MSB_mask = &H1ff
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


'' @REGISTER : FFE_coeff_04_lsb
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
Class REGISTER_FFE_coeff_04_lsb
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


'' @REGISTER : FFE_coeff_04_msb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COEFF_MSB                                  [8:0]            get_COEFF_MSB
''                                                             set_COEFF_MSB
''                                                             read_COEFF_MSB
''                                                             write_COEFF_MSB
''---------------------------------------------------------------------------------
Class REGISTER_FFE_coeff_04_msb
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
        COEFF_MSB_mask = &H1ff
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

        regValue = leftShift((write_COEFF_MSB_value and &H1ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_MSB_mask = &H1ff
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


'' @REGISTER : FFE_coeff_05_lsb
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
Class REGISTER_FFE_coeff_05_lsb
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


'' @REGISTER : FFE_coeff_05_msb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COEFF_MSB                                  [8:0]            get_COEFF_MSB
''                                                             set_COEFF_MSB
''                                                             read_COEFF_MSB
''                                                             write_COEFF_MSB
''---------------------------------------------------------------------------------
Class REGISTER_FFE_coeff_05_msb
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
        COEFF_MSB_mask = &H1ff
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

        regValue = leftShift((write_COEFF_MSB_value and &H1ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_MSB_mask = &H1ff
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


'' @REGISTER : FFE_coeff_06_lsb
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
Class REGISTER_FFE_coeff_06_lsb
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


'' @REGISTER : FFE_coeff_06_msb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COEFF_MSB                                  [8:0]            get_COEFF_MSB
''                                                             set_COEFF_MSB
''                                                             read_COEFF_MSB
''                                                             write_COEFF_MSB
''---------------------------------------------------------------------------------
Class REGISTER_FFE_coeff_06_msb
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
        COEFF_MSB_mask = &H1ff
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

        regValue = leftShift((write_COEFF_MSB_value and &H1ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_MSB_mask = &H1ff
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


'' @REGISTER : FFE_coeff_07_lsb
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
Class REGISTER_FFE_coeff_07_lsb
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


'' @REGISTER : FFE_coeff_07_msb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COEFF_MSB                                  [8:0]            get_COEFF_MSB
''                                                             set_COEFF_MSB
''                                                             read_COEFF_MSB
''                                                             write_COEFF_MSB
''---------------------------------------------------------------------------------
Class REGISTER_FFE_coeff_07_msb
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
        COEFF_MSB_mask = &H1ff
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

        regValue = leftShift((write_COEFF_MSB_value and &H1ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_MSB_mask = &H1ff
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


'' @REGISTER : FFE_coeff_08_lsb
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
Class REGISTER_FFE_coeff_08_lsb
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


'' @REGISTER : FFE_coeff_08_msb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COEFF_MSB                                  [8:0]            get_COEFF_MSB
''                                                             set_COEFF_MSB
''                                                             read_COEFF_MSB
''                                                             write_COEFF_MSB
''---------------------------------------------------------------------------------
Class REGISTER_FFE_coeff_08_msb
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
        COEFF_MSB_mask = &H1ff
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

        regValue = leftShift((write_COEFF_MSB_value and &H1ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_MSB_mask = &H1ff
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


'' @REGISTER : FFE_coeff_09_lsb
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
Class REGISTER_FFE_coeff_09_lsb
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


'' @REGISTER : FFE_coeff_09_msb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COEFF_MSB                                  [8:0]            get_COEFF_MSB
''                                                             set_COEFF_MSB
''                                                             read_COEFF_MSB
''                                                             write_COEFF_MSB
''---------------------------------------------------------------------------------
Class REGISTER_FFE_coeff_09_msb
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
        COEFF_MSB_mask = &H1ff
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

        regValue = leftShift((write_COEFF_MSB_value and &H1ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_MSB_mask = &H1ff
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


'' @REGISTER : FFE_coeff_10_lsb
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
Class REGISTER_FFE_coeff_10_lsb
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


'' @REGISTER : FFE_coeff_10_msb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COEFF_MSB                                  [8:0]            get_COEFF_MSB
''                                                             set_COEFF_MSB
''                                                             read_COEFF_MSB
''                                                             write_COEFF_MSB
''---------------------------------------------------------------------------------
Class REGISTER_FFE_coeff_10_msb
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
        COEFF_MSB_mask = &H1ff
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

        regValue = leftShift((write_COEFF_MSB_value and &H1ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_MSB_mask = &H1ff
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


'' @REGISTER : FFE_coeff_11_lsb
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
Class REGISTER_FFE_coeff_11_lsb
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


'' @REGISTER : FFE_coeff_11_msb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COEFF_MSB                                  [8:0]            get_COEFF_MSB
''                                                             set_COEFF_MSB
''                                                             read_COEFF_MSB
''                                                             write_COEFF_MSB
''---------------------------------------------------------------------------------
Class REGISTER_FFE_coeff_11_msb
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
        COEFF_MSB_mask = &H1ff
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

        regValue = leftShift((write_COEFF_MSB_value and &H1ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_MSB_mask = &H1ff
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


'' @REGISTER : FFE_coeff_12_lsb
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
Class REGISTER_FFE_coeff_12_lsb
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


'' @REGISTER : FFE_coeff_12_msb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COEFF_MSB                                  [8:0]            get_COEFF_MSB
''                                                             set_COEFF_MSB
''                                                             read_COEFF_MSB
''                                                             write_COEFF_MSB
''---------------------------------------------------------------------------------
Class REGISTER_FFE_coeff_12_msb
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
        COEFF_MSB_mask = &H1ff
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

        regValue = leftShift((write_COEFF_MSB_value and &H1ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_MSB_mask = &H1ff
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


'' @REGISTER : FFE_coeff_13_lsb
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
Class REGISTER_FFE_coeff_13_lsb
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


'' @REGISTER : FFE_coeff_13_msb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COEFF_MSB                                  [8:0]            get_COEFF_MSB
''                                                             set_COEFF_MSB
''                                                             read_COEFF_MSB
''                                                             write_COEFF_MSB
''---------------------------------------------------------------------------------
Class REGISTER_FFE_coeff_13_msb
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
        COEFF_MSB_mask = &H1ff
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

        regValue = leftShift((write_COEFF_MSB_value and &H1ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_MSB_mask = &H1ff
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


'' @REGISTER : FFE_coeff_14_lsb
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
Class REGISTER_FFE_coeff_14_lsb
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


'' @REGISTER : FFE_coeff_14_msb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COEFF_MSB                                  [8:0]            get_COEFF_MSB
''                                                             set_COEFF_MSB
''                                                             read_COEFF_MSB
''                                                             write_COEFF_MSB
''---------------------------------------------------------------------------------
Class REGISTER_FFE_coeff_14_msb
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
        COEFF_MSB_mask = &H1ff
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

        regValue = leftShift((write_COEFF_MSB_value and &H1ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_MSB_mask = &H1ff
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


'' @REGISTER : FFE_coeff_15_lsb
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
Class REGISTER_FFE_coeff_15_lsb
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


'' @REGISTER : FFE_coeff_15_msb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COEFF_MSB                                  [8:0]            get_COEFF_MSB
''                                                             set_COEFF_MSB
''                                                             read_COEFF_MSB
''                                                             write_COEFF_MSB
''---------------------------------------------------------------------------------
Class REGISTER_FFE_coeff_15_msb
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
        COEFF_MSB_mask = &H1ff
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

        regValue = leftShift((write_COEFF_MSB_value and &H1ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_MSB_mask = &H1ff
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


'' @REGISTER : FFE_coeff_16_lsb
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
Class REGISTER_FFE_coeff_16_lsb
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


'' @REGISTER : FFE_coeff_16_msb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COEFF_MSB                                  [8:0]            get_COEFF_MSB
''                                                             set_COEFF_MSB
''                                                             read_COEFF_MSB
''                                                             write_COEFF_MSB
''---------------------------------------------------------------------------------
Class REGISTER_FFE_coeff_16_msb
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
        COEFF_MSB_mask = &H1ff
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

        regValue = leftShift((write_COEFF_MSB_value and &H1ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_MSB_mask = &H1ff
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


'' @REGISTER : FFE_coeff_17_lsb
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
Class REGISTER_FFE_coeff_17_lsb
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


'' @REGISTER : FFE_coeff_17_msb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COEFF_MSB                                  [8:0]            get_COEFF_MSB
''                                                             set_COEFF_MSB
''                                                             read_COEFF_MSB
''                                                             write_COEFF_MSB
''---------------------------------------------------------------------------------
Class REGISTER_FFE_coeff_17_msb
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
        COEFF_MSB_mask = &H1ff
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

        regValue = leftShift((write_COEFF_MSB_value and &H1ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_MSB_mask = &H1ff
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


'' @REGISTER : FFE_coeff_18_lsb
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
Class REGISTER_FFE_coeff_18_lsb
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


'' @REGISTER : FFE_coeff_18_msb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COEFF_MSB                                  [8:0]            get_COEFF_MSB
''                                                             set_COEFF_MSB
''                                                             read_COEFF_MSB
''                                                             write_COEFF_MSB
''---------------------------------------------------------------------------------
Class REGISTER_FFE_coeff_18_msb
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
        COEFF_MSB_mask = &H1ff
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

        regValue = leftShift((write_COEFF_MSB_value and &H1ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_MSB_mask = &H1ff
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


'' @REGISTER : FFE_coeff_19_lsb
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
Class REGISTER_FFE_coeff_19_lsb
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


'' @REGISTER : FFE_coeff_19_msb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COEFF_MSB                                  [8:0]            get_COEFF_MSB
''                                                             set_COEFF_MSB
''                                                             read_COEFF_MSB
''                                                             write_COEFF_MSB
''---------------------------------------------------------------------------------
Class REGISTER_FFE_coeff_19_msb
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
        COEFF_MSB_mask = &H1ff
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

        regValue = leftShift((write_COEFF_MSB_value and &H1ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_MSB_mask = &H1ff
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


'' @REGISTER : FFE_coeff_20_lsb
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
Class REGISTER_FFE_coeff_20_lsb
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


'' @REGISTER : FFE_coeff_20_msb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COEFF_MSB                                  [8:0]            get_COEFF_MSB
''                                                             set_COEFF_MSB
''                                                             read_COEFF_MSB
''                                                             write_COEFF_MSB
''---------------------------------------------------------------------------------
Class REGISTER_FFE_coeff_20_msb
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
        COEFF_MSB_mask = &H1ff
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

        regValue = leftShift((write_COEFF_MSB_value and &H1ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_MSB_mask = &H1ff
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


'' @REGISTER : FFE_coeff_21_lsb
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
Class REGISTER_FFE_coeff_21_lsb
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


'' @REGISTER : FFE_coeff_21_msb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COEFF_MSB                                  [8:0]            get_COEFF_MSB
''                                                             set_COEFF_MSB
''                                                             read_COEFF_MSB
''                                                             write_COEFF_MSB
''---------------------------------------------------------------------------------
Class REGISTER_FFE_coeff_21_msb
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
        COEFF_MSB_mask = &H1ff
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

        regValue = leftShift((write_COEFF_MSB_value and &H1ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_MSB_mask = &H1ff
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


'' @REGISTER : FFE_coeff_22_lsb
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
Class REGISTER_FFE_coeff_22_lsb
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


'' @REGISTER : FFE_coeff_22_msb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COEFF_MSB                                  [8:0]            get_COEFF_MSB
''                                                             set_COEFF_MSB
''                                                             read_COEFF_MSB
''                                                             write_COEFF_MSB
''---------------------------------------------------------------------------------
Class REGISTER_FFE_coeff_22_msb
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
        COEFF_MSB_mask = &H1ff
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

        regValue = leftShift((write_COEFF_MSB_value and &H1ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_MSB_mask = &H1ff
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


'' @REGISTER : FFE_coeff_23_lsb
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
Class REGISTER_FFE_coeff_23_lsb
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


'' @REGISTER : FFE_coeff_23_msb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COEFF_MSB                                  [8:0]            get_COEFF_MSB
''                                                             set_COEFF_MSB
''                                                             read_COEFF_MSB
''                                                             write_COEFF_MSB
''---------------------------------------------------------------------------------
Class REGISTER_FFE_coeff_23_msb
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
        COEFF_MSB_mask = &H1ff
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

        regValue = leftShift((write_COEFF_MSB_value and &H1ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_MSB_mask = &H1ff
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


'' @REGISTER : FFE_coeff_24_lsb
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
Class REGISTER_FFE_coeff_24_lsb
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


'' @REGISTER : FFE_coeff_24_msb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COEFF_MSB                                  [8:0]            get_COEFF_MSB
''                                                             set_COEFF_MSB
''                                                             read_COEFF_MSB
''                                                             write_COEFF_MSB
''---------------------------------------------------------------------------------
Class REGISTER_FFE_coeff_24_msb
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
        offset = &H82
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
        COEFF_MSB_mask = &H1ff
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

        regValue = leftShift((write_COEFF_MSB_value and &H1ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_MSB_mask = &H1ff
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


'' @REGISTER : FFE_coeff_25_lsb
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
Class REGISTER_FFE_coeff_25_lsb
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


'' @REGISTER : FFE_coeff_25_msb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COEFF_MSB                                  [8:0]            get_COEFF_MSB
''                                                             set_COEFF_MSB
''                                                             read_COEFF_MSB
''                                                             write_COEFF_MSB
''---------------------------------------------------------------------------------
Class REGISTER_FFE_coeff_25_msb
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
        offset = &H86
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
        COEFF_MSB_mask = &H1ff
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

        regValue = leftShift((write_COEFF_MSB_value and &H1ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_MSB_mask = &H1ff
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


'' @REGISTER : FFE_coeff_26_lsb
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
Class REGISTER_FFE_coeff_26_lsb
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


'' @REGISTER : FFE_coeff_26_msb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COEFF_MSB                                  [8:0]            get_COEFF_MSB
''                                                             set_COEFF_MSB
''                                                             read_COEFF_MSB
''                                                             write_COEFF_MSB
''---------------------------------------------------------------------------------
Class REGISTER_FFE_coeff_26_msb
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
        offset = &H8a
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
        COEFF_MSB_mask = &H1ff
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

        regValue = leftShift((write_COEFF_MSB_value and &H1ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_MSB_mask = &H1ff
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


'' @REGISTER : FFE_coeff_27_lsb
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
Class REGISTER_FFE_coeff_27_lsb
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


'' @REGISTER : FFE_coeff_27_msb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COEFF_MSB                                  [8:0]            get_COEFF_MSB
''                                                             set_COEFF_MSB
''                                                             read_COEFF_MSB
''                                                             write_COEFF_MSB
''---------------------------------------------------------------------------------
Class REGISTER_FFE_coeff_27_msb
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
        offset = &H8e
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
        COEFF_MSB_mask = &H1ff
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

        regValue = leftShift((write_COEFF_MSB_value and &H1ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_MSB_mask = &H1ff
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


'' @REGISTER : FFE_coeff_28_lsb
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
Class REGISTER_FFE_coeff_28_lsb
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


'' @REGISTER : FFE_coeff_28_msb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COEFF_MSB                                  [8:0]            get_COEFF_MSB
''                                                             set_COEFF_MSB
''                                                             read_COEFF_MSB
''                                                             write_COEFF_MSB
''---------------------------------------------------------------------------------
Class REGISTER_FFE_coeff_28_msb
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
        offset = &H92
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
        COEFF_MSB_mask = &H1ff
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

        regValue = leftShift((write_COEFF_MSB_value and &H1ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_MSB_mask = &H1ff
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


'' @REGISTER : FFE_coeff_29_lsb
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
Class REGISTER_FFE_coeff_29_lsb
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


'' @REGISTER : FFE_coeff_29_msb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COEFF_MSB                                  [8:0]            get_COEFF_MSB
''                                                             set_COEFF_MSB
''                                                             read_COEFF_MSB
''                                                             write_COEFF_MSB
''---------------------------------------------------------------------------------
Class REGISTER_FFE_coeff_29_msb
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
        offset = &H96
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
        COEFF_MSB_mask = &H1ff
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

        regValue = leftShift((write_COEFF_MSB_value and &H1ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_MSB_mask = &H1ff
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


'' @REGISTER : FFE_coeff_30_lsb
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
Class REGISTER_FFE_coeff_30_lsb
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


'' @REGISTER : FFE_coeff_30_msb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COEFF_MSB                                  [8:0]            get_COEFF_MSB
''                                                             set_COEFF_MSB
''                                                             read_COEFF_MSB
''                                                             write_COEFF_MSB
''---------------------------------------------------------------------------------
Class REGISTER_FFE_coeff_30_msb
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
        offset = &H9a
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
        COEFF_MSB_mask = &H1ff
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

        regValue = leftShift((write_COEFF_MSB_value and &H1ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_MSB_mask = &H1ff
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


'' @REGISTER : FFE_coeff_31_lsb
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
Class REGISTER_FFE_coeff_31_lsb
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


'' @REGISTER : FFE_coeff_31_msb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COEFF_MSB                                  [8:0]            get_COEFF_MSB
''                                                             set_COEFF_MSB
''                                                             read_COEFF_MSB
''                                                             write_COEFF_MSB
''---------------------------------------------------------------------------------
Class REGISTER_FFE_coeff_31_msb
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
        offset = &H9e
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
        COEFF_MSB_mask = &H1ff
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

        regValue = leftShift((write_COEFF_MSB_value and &H1ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_MSB_mask = &H1ff
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


'' @REGISTER : FFE_spare_end_addr
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
Class REGISTER_FFE_spare_end_addr
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

Class FFE_INSTANCE

    Public control_0
    Public freeze_force_assert_15_00
    Public freeze_force_assert_31_16
    Public freeze_force_deassert_15_00
    Public freeze_force_deassert_31_16
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
    Public spare_end_addr


    Public default function Init(aBaseAddr)
        Set control_0 = (New REGISTER_FFE_control_0)(aBaseAddr, 16)
        Set freeze_force_assert_15_00 = (New REGISTER_FFE_freeze_force_assert_15_00)(aBaseAddr, 16)
        Set freeze_force_assert_31_16 = (New REGISTER_FFE_freeze_force_assert_31_16)(aBaseAddr, 16)
        Set freeze_force_deassert_15_00 = (New REGISTER_FFE_freeze_force_deassert_15_00)(aBaseAddr, 16)
        Set freeze_force_deassert_31_16 = (New REGISTER_FFE_freeze_force_deassert_31_16)(aBaseAddr, 16)
        Set coeff_00_lsb = (New REGISTER_FFE_coeff_00_lsb)(aBaseAddr, 16)
        Set coeff_00_msb = (New REGISTER_FFE_coeff_00_msb)(aBaseAddr, 16)
        Set coeff_01_lsb = (New REGISTER_FFE_coeff_01_lsb)(aBaseAddr, 16)
        Set coeff_01_msb = (New REGISTER_FFE_coeff_01_msb)(aBaseAddr, 16)
        Set coeff_02_lsb = (New REGISTER_FFE_coeff_02_lsb)(aBaseAddr, 16)
        Set coeff_02_msb = (New REGISTER_FFE_coeff_02_msb)(aBaseAddr, 16)
        Set coeff_03_lsb = (New REGISTER_FFE_coeff_03_lsb)(aBaseAddr, 16)
        Set coeff_03_msb = (New REGISTER_FFE_coeff_03_msb)(aBaseAddr, 16)
        Set coeff_04_lsb = (New REGISTER_FFE_coeff_04_lsb)(aBaseAddr, 16)
        Set coeff_04_msb = (New REGISTER_FFE_coeff_04_msb)(aBaseAddr, 16)
        Set coeff_05_lsb = (New REGISTER_FFE_coeff_05_lsb)(aBaseAddr, 16)
        Set coeff_05_msb = (New REGISTER_FFE_coeff_05_msb)(aBaseAddr, 16)
        Set coeff_06_lsb = (New REGISTER_FFE_coeff_06_lsb)(aBaseAddr, 16)
        Set coeff_06_msb = (New REGISTER_FFE_coeff_06_msb)(aBaseAddr, 16)
        Set coeff_07_lsb = (New REGISTER_FFE_coeff_07_lsb)(aBaseAddr, 16)
        Set coeff_07_msb = (New REGISTER_FFE_coeff_07_msb)(aBaseAddr, 16)
        Set coeff_08_lsb = (New REGISTER_FFE_coeff_08_lsb)(aBaseAddr, 16)
        Set coeff_08_msb = (New REGISTER_FFE_coeff_08_msb)(aBaseAddr, 16)
        Set coeff_09_lsb = (New REGISTER_FFE_coeff_09_lsb)(aBaseAddr, 16)
        Set coeff_09_msb = (New REGISTER_FFE_coeff_09_msb)(aBaseAddr, 16)
        Set coeff_10_lsb = (New REGISTER_FFE_coeff_10_lsb)(aBaseAddr, 16)
        Set coeff_10_msb = (New REGISTER_FFE_coeff_10_msb)(aBaseAddr, 16)
        Set coeff_11_lsb = (New REGISTER_FFE_coeff_11_lsb)(aBaseAddr, 16)
        Set coeff_11_msb = (New REGISTER_FFE_coeff_11_msb)(aBaseAddr, 16)
        Set coeff_12_lsb = (New REGISTER_FFE_coeff_12_lsb)(aBaseAddr, 16)
        Set coeff_12_msb = (New REGISTER_FFE_coeff_12_msb)(aBaseAddr, 16)
        Set coeff_13_lsb = (New REGISTER_FFE_coeff_13_lsb)(aBaseAddr, 16)
        Set coeff_13_msb = (New REGISTER_FFE_coeff_13_msb)(aBaseAddr, 16)
        Set coeff_14_lsb = (New REGISTER_FFE_coeff_14_lsb)(aBaseAddr, 16)
        Set coeff_14_msb = (New REGISTER_FFE_coeff_14_msb)(aBaseAddr, 16)
        Set coeff_15_lsb = (New REGISTER_FFE_coeff_15_lsb)(aBaseAddr, 16)
        Set coeff_15_msb = (New REGISTER_FFE_coeff_15_msb)(aBaseAddr, 16)
        Set coeff_16_lsb = (New REGISTER_FFE_coeff_16_lsb)(aBaseAddr, 16)
        Set coeff_16_msb = (New REGISTER_FFE_coeff_16_msb)(aBaseAddr, 16)
        Set coeff_17_lsb = (New REGISTER_FFE_coeff_17_lsb)(aBaseAddr, 16)
        Set coeff_17_msb = (New REGISTER_FFE_coeff_17_msb)(aBaseAddr, 16)
        Set coeff_18_lsb = (New REGISTER_FFE_coeff_18_lsb)(aBaseAddr, 16)
        Set coeff_18_msb = (New REGISTER_FFE_coeff_18_msb)(aBaseAddr, 16)
        Set coeff_19_lsb = (New REGISTER_FFE_coeff_19_lsb)(aBaseAddr, 16)
        Set coeff_19_msb = (New REGISTER_FFE_coeff_19_msb)(aBaseAddr, 16)
        Set coeff_20_lsb = (New REGISTER_FFE_coeff_20_lsb)(aBaseAddr, 16)
        Set coeff_20_msb = (New REGISTER_FFE_coeff_20_msb)(aBaseAddr, 16)
        Set coeff_21_lsb = (New REGISTER_FFE_coeff_21_lsb)(aBaseAddr, 16)
        Set coeff_21_msb = (New REGISTER_FFE_coeff_21_msb)(aBaseAddr, 16)
        Set coeff_22_lsb = (New REGISTER_FFE_coeff_22_lsb)(aBaseAddr, 16)
        Set coeff_22_msb = (New REGISTER_FFE_coeff_22_msb)(aBaseAddr, 16)
        Set coeff_23_lsb = (New REGISTER_FFE_coeff_23_lsb)(aBaseAddr, 16)
        Set coeff_23_msb = (New REGISTER_FFE_coeff_23_msb)(aBaseAddr, 16)
        Set coeff_24_lsb = (New REGISTER_FFE_coeff_24_lsb)(aBaseAddr, 16)
        Set coeff_24_msb = (New REGISTER_FFE_coeff_24_msb)(aBaseAddr, 16)
        Set coeff_25_lsb = (New REGISTER_FFE_coeff_25_lsb)(aBaseAddr, 16)
        Set coeff_25_msb = (New REGISTER_FFE_coeff_25_msb)(aBaseAddr, 16)
        Set coeff_26_lsb = (New REGISTER_FFE_coeff_26_lsb)(aBaseAddr, 16)
        Set coeff_26_msb = (New REGISTER_FFE_coeff_26_msb)(aBaseAddr, 16)
        Set coeff_27_lsb = (New REGISTER_FFE_coeff_27_lsb)(aBaseAddr, 16)
        Set coeff_27_msb = (New REGISTER_FFE_coeff_27_msb)(aBaseAddr, 16)
        Set coeff_28_lsb = (New REGISTER_FFE_coeff_28_lsb)(aBaseAddr, 16)
        Set coeff_28_msb = (New REGISTER_FFE_coeff_28_msb)(aBaseAddr, 16)
        Set coeff_29_lsb = (New REGISTER_FFE_coeff_29_lsb)(aBaseAddr, 16)
        Set coeff_29_msb = (New REGISTER_FFE_coeff_29_msb)(aBaseAddr, 16)
        Set coeff_30_lsb = (New REGISTER_FFE_coeff_30_lsb)(aBaseAddr, 16)
        Set coeff_30_msb = (New REGISTER_FFE_coeff_30_msb)(aBaseAddr, 16)
        Set coeff_31_lsb = (New REGISTER_FFE_coeff_31_lsb)(aBaseAddr, 16)
        Set coeff_31_msb = (New REGISTER_FFE_coeff_31_msb)(aBaseAddr, 16)
        Set spare_end_addr = (New REGISTER_FFE_spare_end_addr)(aBaseAddr, 16)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set FFE = CreateObject("System.Collections.ArrayList")
FFE.Add ((New FFE_INSTANCE)(&H49030c00))


