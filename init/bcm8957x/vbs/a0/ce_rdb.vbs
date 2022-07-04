

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


'' @REGISTER : CE_control_0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' CERSTN_FORCE_DEASSERT                      [15:15]          get_CERSTN_FORCE_DEASSERT
''                                                             set_CERSTN_FORCE_DEASSERT
''                                                             read_CERSTN_FORCE_DEASSERT
''                                                             write_CERSTN_FORCE_DEASSERT
''---------------------------------------------------------------------------------
'' CERSTN_FORCE_ASSERT                        [14:14]          get_CERSTN_FORCE_ASSERT
''                                                             set_CERSTN_FORCE_ASSERT
''                                                             read_CERSTN_FORCE_ASSERT
''                                                             write_CERSTN_FORCE_ASSERT
''---------------------------------------------------------------------------------
'' FULL_LMS_UPT                               [13:13]          get_FULL_LMS_UPT
''                                                             set_FULL_LMS_UPT
''                                                             read_FULL_LMS_UPT
''                                                             write_FULL_LMS_UPT
''---------------------------------------------------------------------------------
'' MU_OVERRIDE                                [12:12]          get_MU_OVERRIDE
''                                                             set_MU_OVERRIDE
''                                                             read_MU_OVERRIDE
''                                                             write_MU_OVERRIDE
''---------------------------------------------------------------------------------
'' CE_GAIN_LGEAR                              [11:11]          get_CE_GAIN_LGEAR
''                                                             set_CE_GAIN_LGEAR
''                                                             read_CE_GAIN_LGEAR
''                                                             write_CE_GAIN_LGEAR
''---------------------------------------------------------------------------------
'' GAIN_HI_MU_CTL                             [10:9]           get_GAIN_HI_MU_CTL
''                                                             set_GAIN_HI_MU_CTL
''                                                             read_GAIN_HI_MU_CTL
''                                                             write_GAIN_HI_MU_CTL
''---------------------------------------------------------------------------------
'' GAIN_LO_MU_CTL                             [8:7]            get_GAIN_LO_MU_CTL
''                                                             set_GAIN_LO_MU_CTL
''                                                             read_GAIN_LO_MU_CTL
''                                                             write_GAIN_LO_MU_CTL
''---------------------------------------------------------------------------------
'' CELGEAR                                    [6:6]            get_CELGEAR
''                                                             set_CELGEAR
''                                                             read_CELGEAR
''                                                             write_CELGEAR
''---------------------------------------------------------------------------------
'' HI_MU_CTL                                  [5:4]            get_HI_MU_CTL
''                                                             set_HI_MU_CTL
''                                                             read_HI_MU_CTL
''                                                             write_HI_MU_CTL
''---------------------------------------------------------------------------------
'' LO_MU_CTL                                  [3:2]            get_LO_MU_CTL
''                                                             set_LO_MU_CTL
''                                                             read_LO_MU_CTL
''                                                             write_LO_MU_CTL
''---------------------------------------------------------------------------------
'' FREEZE_FORCE_DEASSERT                      [1:1]            get_FREEZE_FORCE_DEASSERT
''                                                             set_FREEZE_FORCE_DEASSERT
''                                                             read_FREEZE_FORCE_DEASSERT
''                                                             write_FREEZE_FORCE_DEASSERT
''---------------------------------------------------------------------------------
'' FREEZE_FORCE_ASSERT                        [0:0]            get_FREEZE_FORCE_ASSERT
''                                                             set_FREEZE_FORCE_ASSERT
''                                                             read_FREEZE_FORCE_ASSERT
''                                                             write_FREEZE_FORCE_ASSERT
''---------------------------------------------------------------------------------
Class REGISTER_CE_control_0
    Private write_CERSTN_FORCE_DEASSERT_value
    Private read_CERSTN_FORCE_DEASSERT_value
    Private flag_CERSTN_FORCE_DEASSERT
    Private write_CERSTN_FORCE_ASSERT_value
    Private read_CERSTN_FORCE_ASSERT_value
    Private flag_CERSTN_FORCE_ASSERT
    Private write_FULL_LMS_UPT_value
    Private read_FULL_LMS_UPT_value
    Private flag_FULL_LMS_UPT
    Private write_MU_OVERRIDE_value
    Private read_MU_OVERRIDE_value
    Private flag_MU_OVERRIDE
    Private write_CE_GAIN_LGEAR_value
    Private read_CE_GAIN_LGEAR_value
    Private flag_CE_GAIN_LGEAR
    Private write_GAIN_HI_MU_CTL_value
    Private read_GAIN_HI_MU_CTL_value
    Private flag_GAIN_HI_MU_CTL
    Private write_GAIN_LO_MU_CTL_value
    Private read_GAIN_LO_MU_CTL_value
    Private flag_GAIN_LO_MU_CTL
    Private write_CELGEAR_value
    Private read_CELGEAR_value
    Private flag_CELGEAR
    Private write_HI_MU_CTL_value
    Private read_HI_MU_CTL_value
    Private flag_HI_MU_CTL
    Private write_LO_MU_CTL_value
    Private read_LO_MU_CTL_value
    Private flag_LO_MU_CTL
    Private write_FREEZE_FORCE_DEASSERT_value
    Private read_FREEZE_FORCE_DEASSERT_value
    Private flag_FREEZE_FORCE_DEASSERT
    Private write_FREEZE_FORCE_ASSERT_value
    Private read_FREEZE_FORCE_ASSERT_value
    Private flag_FREEZE_FORCE_ASSERT

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

    Property Get get_CERSTN_FORCE_DEASSERT
        get_CERSTN_FORCE_DEASSERT = read_CERSTN_FORCE_DEASSERT_value
    End Property

    Property Let set_CERSTN_FORCE_DEASSERT(aData)
        write_CERSTN_FORCE_DEASSERT_value = aData
        flag_CERSTN_FORCE_DEASSERT        = &H1
    End Property

    Property Get read_CERSTN_FORCE_DEASSERT
        read
        read_CERSTN_FORCE_DEASSERT = read_CERSTN_FORCE_DEASSERT_value
    End Property

    Property Let write_CERSTN_FORCE_DEASSERT(aData)
        set_CERSTN_FORCE_DEASSERT = aData
        write
    End Property

    Property Get get_CERSTN_FORCE_ASSERT
        get_CERSTN_FORCE_ASSERT = read_CERSTN_FORCE_ASSERT_value
    End Property

    Property Let set_CERSTN_FORCE_ASSERT(aData)
        write_CERSTN_FORCE_ASSERT_value = aData
        flag_CERSTN_FORCE_ASSERT        = &H1
    End Property

    Property Get read_CERSTN_FORCE_ASSERT
        read
        read_CERSTN_FORCE_ASSERT = read_CERSTN_FORCE_ASSERT_value
    End Property

    Property Let write_CERSTN_FORCE_ASSERT(aData)
        set_CERSTN_FORCE_ASSERT = aData
        write
    End Property

    Property Get get_FULL_LMS_UPT
        get_FULL_LMS_UPT = read_FULL_LMS_UPT_value
    End Property

    Property Let set_FULL_LMS_UPT(aData)
        write_FULL_LMS_UPT_value = aData
        flag_FULL_LMS_UPT        = &H1
    End Property

    Property Get read_FULL_LMS_UPT
        read
        read_FULL_LMS_UPT = read_FULL_LMS_UPT_value
    End Property

    Property Let write_FULL_LMS_UPT(aData)
        set_FULL_LMS_UPT = aData
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

    Property Get get_CE_GAIN_LGEAR
        get_CE_GAIN_LGEAR = read_CE_GAIN_LGEAR_value
    End Property

    Property Let set_CE_GAIN_LGEAR(aData)
        write_CE_GAIN_LGEAR_value = aData
        flag_CE_GAIN_LGEAR        = &H1
    End Property

    Property Get read_CE_GAIN_LGEAR
        read
        read_CE_GAIN_LGEAR = read_CE_GAIN_LGEAR_value
    End Property

    Property Let write_CE_GAIN_LGEAR(aData)
        set_CE_GAIN_LGEAR = aData
        write
    End Property

    Property Get get_GAIN_HI_MU_CTL
        get_GAIN_HI_MU_CTL = read_GAIN_HI_MU_CTL_value
    End Property

    Property Let set_GAIN_HI_MU_CTL(aData)
        write_GAIN_HI_MU_CTL_value = aData
        flag_GAIN_HI_MU_CTL        = &H1
    End Property

    Property Get read_GAIN_HI_MU_CTL
        read
        read_GAIN_HI_MU_CTL = read_GAIN_HI_MU_CTL_value
    End Property

    Property Let write_GAIN_HI_MU_CTL(aData)
        set_GAIN_HI_MU_CTL = aData
        write
    End Property

    Property Get get_GAIN_LO_MU_CTL
        get_GAIN_LO_MU_CTL = read_GAIN_LO_MU_CTL_value
    End Property

    Property Let set_GAIN_LO_MU_CTL(aData)
        write_GAIN_LO_MU_CTL_value = aData
        flag_GAIN_LO_MU_CTL        = &H1
    End Property

    Property Get read_GAIN_LO_MU_CTL
        read
        read_GAIN_LO_MU_CTL = read_GAIN_LO_MU_CTL_value
    End Property

    Property Let write_GAIN_LO_MU_CTL(aData)
        set_GAIN_LO_MU_CTL = aData
        write
    End Property

    Property Get get_CELGEAR
        get_CELGEAR = read_CELGEAR_value
    End Property

    Property Let set_CELGEAR(aData)
        write_CELGEAR_value = aData
        flag_CELGEAR        = &H1
    End Property

    Property Get read_CELGEAR
        read
        read_CELGEAR = read_CELGEAR_value
    End Property

    Property Let write_CELGEAR(aData)
        set_CELGEAR = aData
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

    Property Get get_FREEZE_FORCE_DEASSERT
        get_FREEZE_FORCE_DEASSERT = read_FREEZE_FORCE_DEASSERT_value
    End Property

    Property Let set_FREEZE_FORCE_DEASSERT(aData)
        write_FREEZE_FORCE_DEASSERT_value = aData
        flag_FREEZE_FORCE_DEASSERT        = &H1
    End Property

    Property Get read_FREEZE_FORCE_DEASSERT
        read
        read_FREEZE_FORCE_DEASSERT = read_FREEZE_FORCE_DEASSERT_value
    End Property

    Property Let write_FREEZE_FORCE_DEASSERT(aData)
        set_FREEZE_FORCE_DEASSERT = aData
        write
    End Property

    Property Get get_FREEZE_FORCE_ASSERT
        get_FREEZE_FORCE_ASSERT = read_FREEZE_FORCE_ASSERT_value
    End Property

    Property Let set_FREEZE_FORCE_ASSERT(aData)
        write_FREEZE_FORCE_ASSERT_value = aData
        flag_FREEZE_FORCE_ASSERT        = &H1
    End Property

    Property Get read_FREEZE_FORCE_ASSERT
        read
        read_FREEZE_FORCE_ASSERT = read_FREEZE_FORCE_ASSERT_value
    End Property

    Property Let write_FREEZE_FORCE_ASSERT(aData)
        set_FREEZE_FORCE_ASSERT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_CERSTN_FORCE_DEASSERT_value = rightShift(data_low, 15) and &H1
        read_CERSTN_FORCE_ASSERT_value = rightShift(data_low, 14) and &H1
        read_FULL_LMS_UPT_value = rightShift(data_low, 13) and &H1
        read_MU_OVERRIDE_value = rightShift(data_low, 12) and &H1
        read_CE_GAIN_LGEAR_value = rightShift(data_low, 11) and &H1
        read_GAIN_HI_MU_CTL_value = rightShift(data_low, 9) and &H3
        read_GAIN_LO_MU_CTL_value = rightShift(data_low, 7) and &H3
        read_CELGEAR_value = rightShift(data_low, 6) and &H1
        read_HI_MU_CTL_value = rightShift(data_low, 4) and &H3
        read_LO_MU_CTL_value = rightShift(data_low, 2) and &H3
        read_FREEZE_FORCE_DEASSERT_value = rightShift(data_low, 1) and &H1
        FREEZE_FORCE_ASSERT_mask = &H1
        if data_low > LONG_MAX then
            if FREEZE_FORCE_ASSERT_mask = mask then
                read_FREEZE_FORCE_ASSERT_value = data_low
            else
                read_FREEZE_FORCE_ASSERT_value = (data_low - H8000_0000) and FREEZE_FORCE_ASSERT_mask
            end If
        else
            read_FREEZE_FORCE_ASSERT_value = data_low and FREEZE_FORCE_ASSERT_mask
        end If

    End Sub

    Sub write
        If flag_CERSTN_FORCE_DEASSERT = &H0 or flag_CERSTN_FORCE_ASSERT = &H0 or flag_FULL_LMS_UPT = &H0 or flag_MU_OVERRIDE = &H0 or flag_CE_GAIN_LGEAR = &H0 or flag_GAIN_HI_MU_CTL = &H0 or flag_GAIN_LO_MU_CTL = &H0 or flag_CELGEAR = &H0 or flag_HI_MU_CTL = &H0 or flag_LO_MU_CTL = &H0 or flag_FREEZE_FORCE_DEASSERT = &H0 or flag_FREEZE_FORCE_ASSERT = &H0 Then read
        If flag_CERSTN_FORCE_DEASSERT = &H0 Then write_CERSTN_FORCE_DEASSERT_value = get_CERSTN_FORCE_DEASSERT
        If flag_CERSTN_FORCE_ASSERT = &H0 Then write_CERSTN_FORCE_ASSERT_value = get_CERSTN_FORCE_ASSERT
        If flag_FULL_LMS_UPT = &H0 Then write_FULL_LMS_UPT_value = get_FULL_LMS_UPT
        If flag_MU_OVERRIDE = &H0 Then write_MU_OVERRIDE_value = get_MU_OVERRIDE
        If flag_CE_GAIN_LGEAR = &H0 Then write_CE_GAIN_LGEAR_value = get_CE_GAIN_LGEAR
        If flag_GAIN_HI_MU_CTL = &H0 Then write_GAIN_HI_MU_CTL_value = get_GAIN_HI_MU_CTL
        If flag_GAIN_LO_MU_CTL = &H0 Then write_GAIN_LO_MU_CTL_value = get_GAIN_LO_MU_CTL
        If flag_CELGEAR = &H0 Then write_CELGEAR_value = get_CELGEAR
        If flag_HI_MU_CTL = &H0 Then write_HI_MU_CTL_value = get_HI_MU_CTL
        If flag_LO_MU_CTL = &H0 Then write_LO_MU_CTL_value = get_LO_MU_CTL
        If flag_FREEZE_FORCE_DEASSERT = &H0 Then write_FREEZE_FORCE_DEASSERT_value = get_FREEZE_FORCE_DEASSERT
        If flag_FREEZE_FORCE_ASSERT = &H0 Then write_FREEZE_FORCE_ASSERT_value = get_FREEZE_FORCE_ASSERT

        regValue = leftShift((write_CERSTN_FORCE_DEASSERT_value and &H1), 15) + leftShift((write_CERSTN_FORCE_ASSERT_value and &H1), 14) + leftShift((write_FULL_LMS_UPT_value and &H1), 13) + leftShift((write_MU_OVERRIDE_value and &H1), 12) + leftShift((write_CE_GAIN_LGEAR_value and &H1), 11) + leftShift((write_GAIN_HI_MU_CTL_value and &H3), 9) + leftShift((write_GAIN_LO_MU_CTL_value and &H3), 7) + leftShift((write_CELGEAR_value and &H1), 6) + leftShift((write_HI_MU_CTL_value and &H3), 4) + leftShift((write_LO_MU_CTL_value and &H3), 2) + leftShift((write_FREEZE_FORCE_DEASSERT_value and &H1), 1) + leftShift((write_FREEZE_FORCE_ASSERT_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_CERSTN_FORCE_DEASSERT_value = rightShift(data_low, 15) and &H1
        read_CERSTN_FORCE_ASSERT_value = rightShift(data_low, 14) and &H1
        read_FULL_LMS_UPT_value = rightShift(data_low, 13) and &H1
        read_MU_OVERRIDE_value = rightShift(data_low, 12) and &H1
        read_CE_GAIN_LGEAR_value = rightShift(data_low, 11) and &H1
        read_GAIN_HI_MU_CTL_value = rightShift(data_low, 9) and &H3
        read_GAIN_LO_MU_CTL_value = rightShift(data_low, 7) and &H3
        read_CELGEAR_value = rightShift(data_low, 6) and &H1
        read_HI_MU_CTL_value = rightShift(data_low, 4) and &H3
        read_LO_MU_CTL_value = rightShift(data_low, 2) and &H3
        read_FREEZE_FORCE_DEASSERT_value = rightShift(data_low, 1) and &H1
        FREEZE_FORCE_ASSERT_mask = &H1
        if data_low > LONG_MAX then
            if FREEZE_FORCE_ASSERT_mask = mask then
                read_FREEZE_FORCE_ASSERT_value = data_low
            else
                read_FREEZE_FORCE_ASSERT_value = (data_low - H8000_0000) and FREEZE_FORCE_ASSERT_mask
            end If
        else
            read_FREEZE_FORCE_ASSERT_value = data_low and FREEZE_FORCE_ASSERT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_CERSTN_FORCE_DEASSERT_value = &H0
        flag_CERSTN_FORCE_DEASSERT        = &H0
        write_CERSTN_FORCE_ASSERT_value = &H0
        flag_CERSTN_FORCE_ASSERT        = &H0
        write_FULL_LMS_UPT_value = &H0
        flag_FULL_LMS_UPT        = &H0
        write_MU_OVERRIDE_value = &H0
        flag_MU_OVERRIDE        = &H0
        write_CE_GAIN_LGEAR_value = &H0
        flag_CE_GAIN_LGEAR        = &H0
        write_GAIN_HI_MU_CTL_value = &H0
        flag_GAIN_HI_MU_CTL        = &H0
        write_GAIN_LO_MU_CTL_value = &H0
        flag_GAIN_LO_MU_CTL        = &H0
        write_CELGEAR_value = &H0
        flag_CELGEAR        = &H0
        write_HI_MU_CTL_value = &H0
        flag_HI_MU_CTL        = &H0
        write_LO_MU_CTL_value = &H0
        flag_LO_MU_CTL        = &H0
        write_FREEZE_FORCE_DEASSERT_value = &H0
        flag_FREEZE_FORCE_DEASSERT        = &H0
        write_FREEZE_FORCE_ASSERT_value = &H0
        flag_FREEZE_FORCE_ASSERT        = &H0
    End Sub
End Class


'' @REGISTER : CE_ce_gain_lsb
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
Class REGISTER_CE_ce_gain_lsb
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


'' @REGISTER : CE_ce_gain_msb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COEFF_MSB                                  [3:0]            get_COEFF_MSB
''                                                             set_COEFF_MSB
''                                                             read_COEFF_MSB
''                                                             write_COEFF_MSB
''---------------------------------------------------------------------------------
Class REGISTER_CE_ce_gain_msb
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
        COEFF_MSB_mask = &Hf
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

        regValue = leftShift((write_COEFF_MSB_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COEFF_MSB_mask = &Hf
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


'' @REGISTER : CE_coeff_00_lsb
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
Class REGISTER_CE_coeff_00_lsb
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


'' @REGISTER : CE_coeff_00_msb
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
Class REGISTER_CE_coeff_00_msb
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


'' @REGISTER : CE_coeff_01_lsb
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
Class REGISTER_CE_coeff_01_lsb
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


'' @REGISTER : CE_coeff_01_msb
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
Class REGISTER_CE_coeff_01_msb
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


'' @REGISTER : CE_coeff_02_lsb
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
Class REGISTER_CE_coeff_02_lsb
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


'' @REGISTER : CE_coeff_02_msb
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
Class REGISTER_CE_coeff_02_msb
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


'' @REGISTER : CE_coeff_03_lsb
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
Class REGISTER_CE_coeff_03_lsb
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


'' @REGISTER : CE_coeff_03_msb
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
Class REGISTER_CE_coeff_03_msb
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


'' @REGISTER : CE_coeff_04_lsb
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
Class REGISTER_CE_coeff_04_lsb
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


'' @REGISTER : CE_coeff_04_msb
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
Class REGISTER_CE_coeff_04_msb
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


'' @REGISTER : CE_coeff_05_lsb
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
Class REGISTER_CE_coeff_05_lsb
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


'' @REGISTER : CE_coeff_05_msb
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
Class REGISTER_CE_coeff_05_msb
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


'' @REGISTER : CE_coeff_06_lsb
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
Class REGISTER_CE_coeff_06_lsb
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


'' @REGISTER : CE_coeff_06_msb
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
Class REGISTER_CE_coeff_06_msb
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


'' @REGISTER : CE_coeff_07_lsb
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
Class REGISTER_CE_coeff_07_lsb
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


'' @REGISTER : CE_coeff_07_msb
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
Class REGISTER_CE_coeff_07_msb
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


'' @REGISTER : CE_coeff_08_lsb
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
Class REGISTER_CE_coeff_08_lsb
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


'' @REGISTER : CE_coeff_08_msb
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
Class REGISTER_CE_coeff_08_msb
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


'' @REGISTER : CE_coeff_09_lsb
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
Class REGISTER_CE_coeff_09_lsb
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


'' @REGISTER : CE_coeff_09_msb
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
Class REGISTER_CE_coeff_09_msb
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


'' @REGISTER : CE_coeff_10_lsb
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
Class REGISTER_CE_coeff_10_lsb
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


'' @REGISTER : CE_coeff_10_msb
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
Class REGISTER_CE_coeff_10_msb
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


'' @REGISTER : CE_coeff_11_lsb
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
Class REGISTER_CE_coeff_11_lsb
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


'' @REGISTER : CE_coeff_11_msb
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
Class REGISTER_CE_coeff_11_msb
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


'' @REGISTER : CE_coeff_12_lsb
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
Class REGISTER_CE_coeff_12_lsb
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


'' @REGISTER : CE_coeff_12_msb
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
Class REGISTER_CE_coeff_12_msb
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


'' @REGISTER : CE_coeff_13_lsb
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
Class REGISTER_CE_coeff_13_lsb
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


'' @REGISTER : CE_coeff_13_msb
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
Class REGISTER_CE_coeff_13_msb
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


'' @REGISTER : CE_coeff_14_lsb
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
Class REGISTER_CE_coeff_14_lsb
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


'' @REGISTER : CE_coeff_14_msb
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
Class REGISTER_CE_coeff_14_msb
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


'' @REGISTER : CE_coeff_15_lsb
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
Class REGISTER_CE_coeff_15_lsb
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


'' @REGISTER : CE_coeff_15_msb
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
Class REGISTER_CE_coeff_15_msb
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


'' @REGISTER : CE_coeff_16_lsb
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
Class REGISTER_CE_coeff_16_lsb
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


'' @REGISTER : CE_coeff_16_msb
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
Class REGISTER_CE_coeff_16_msb
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


'' @REGISTER : CE_coeff_17_lsb
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
Class REGISTER_CE_coeff_17_lsb
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


'' @REGISTER : CE_coeff_17_msb
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
Class REGISTER_CE_coeff_17_msb
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


'' @REGISTER : CE_coeff_18_lsb
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
Class REGISTER_CE_coeff_18_lsb
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


'' @REGISTER : CE_coeff_18_msb
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
Class REGISTER_CE_coeff_18_msb
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


'' @REGISTER : CE_coeff_19_lsb
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
Class REGISTER_CE_coeff_19_lsb
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


'' @REGISTER : CE_coeff_19_msb
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
Class REGISTER_CE_coeff_19_msb
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


'' @REGISTER : CE_coeff_20_lsb
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
Class REGISTER_CE_coeff_20_lsb
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


'' @REGISTER : CE_coeff_20_msb
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
Class REGISTER_CE_coeff_20_msb
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


'' @REGISTER : CE_coeff_21_lsb
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
Class REGISTER_CE_coeff_21_lsb
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


'' @REGISTER : CE_coeff_21_msb
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
Class REGISTER_CE_coeff_21_msb
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


'' @REGISTER : CE_coeff_22_lsb
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
Class REGISTER_CE_coeff_22_lsb
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


'' @REGISTER : CE_coeff_22_msb
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
Class REGISTER_CE_coeff_22_msb
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


'' @REGISTER : CE_coeff_23_lsb
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
Class REGISTER_CE_coeff_23_lsb
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


'' @REGISTER : CE_coeff_23_msb
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
Class REGISTER_CE_coeff_23_msb
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


'' @REGISTER : CE_coeff_24_lsb
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
Class REGISTER_CE_coeff_24_lsb
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


'' @REGISTER : CE_coeff_24_msb
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
Class REGISTER_CE_coeff_24_msb
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


'' @REGISTER : CE_coeff_25_lsb
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
Class REGISTER_CE_coeff_25_lsb
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


'' @REGISTER : CE_coeff_25_msb
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
Class REGISTER_CE_coeff_25_msb
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


'' @REGISTER : CE_coeff_26_lsb
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
Class REGISTER_CE_coeff_26_lsb
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


'' @REGISTER : CE_coeff_26_msb
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
Class REGISTER_CE_coeff_26_msb
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


'' @REGISTER : CE_coeff_27_lsb
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
Class REGISTER_CE_coeff_27_lsb
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


'' @REGISTER : CE_coeff_27_msb
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
Class REGISTER_CE_coeff_27_msb
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


'' @REGISTER : CE_coeff_28_lsb
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
Class REGISTER_CE_coeff_28_lsb
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


'' @REGISTER : CE_coeff_28_msb
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
Class REGISTER_CE_coeff_28_msb
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


'' @REGISTER : CE_coeff_29_lsb
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
Class REGISTER_CE_coeff_29_lsb
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


'' @REGISTER : CE_coeff_29_msb
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
Class REGISTER_CE_coeff_29_msb
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


'' @REGISTER : CE_coeff_30_lsb
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
Class REGISTER_CE_coeff_30_lsb
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


'' @REGISTER : CE_coeff_30_msb
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
Class REGISTER_CE_coeff_30_msb
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


'' @REGISTER : CE_coeff_31_lsb
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
Class REGISTER_CE_coeff_31_lsb
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


'' @REGISTER : CE_coeff_31_msb
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
Class REGISTER_CE_coeff_31_msb
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




'***********************************

' Regset Instance

'***********************************

Class CE_INSTANCE

    Public control_0
    Public ce_gain_lsb
    Public ce_gain_msb
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
        Set control_0 = (New REGISTER_CE_control_0)(aBaseAddr, 16)
        Set ce_gain_lsb = (New REGISTER_CE_ce_gain_lsb)(aBaseAddr, 16)
        Set ce_gain_msb = (New REGISTER_CE_ce_gain_msb)(aBaseAddr, 16)
        Set coeff_00_lsb = (New REGISTER_CE_coeff_00_lsb)(aBaseAddr, 16)
        Set coeff_00_msb = (New REGISTER_CE_coeff_00_msb)(aBaseAddr, 16)
        Set coeff_01_lsb = (New REGISTER_CE_coeff_01_lsb)(aBaseAddr, 16)
        Set coeff_01_msb = (New REGISTER_CE_coeff_01_msb)(aBaseAddr, 16)
        Set coeff_02_lsb = (New REGISTER_CE_coeff_02_lsb)(aBaseAddr, 16)
        Set coeff_02_msb = (New REGISTER_CE_coeff_02_msb)(aBaseAddr, 16)
        Set coeff_03_lsb = (New REGISTER_CE_coeff_03_lsb)(aBaseAddr, 16)
        Set coeff_03_msb = (New REGISTER_CE_coeff_03_msb)(aBaseAddr, 16)
        Set coeff_04_lsb = (New REGISTER_CE_coeff_04_lsb)(aBaseAddr, 16)
        Set coeff_04_msb = (New REGISTER_CE_coeff_04_msb)(aBaseAddr, 16)
        Set coeff_05_lsb = (New REGISTER_CE_coeff_05_lsb)(aBaseAddr, 16)
        Set coeff_05_msb = (New REGISTER_CE_coeff_05_msb)(aBaseAddr, 16)
        Set coeff_06_lsb = (New REGISTER_CE_coeff_06_lsb)(aBaseAddr, 16)
        Set coeff_06_msb = (New REGISTER_CE_coeff_06_msb)(aBaseAddr, 16)
        Set coeff_07_lsb = (New REGISTER_CE_coeff_07_lsb)(aBaseAddr, 16)
        Set coeff_07_msb = (New REGISTER_CE_coeff_07_msb)(aBaseAddr, 16)
        Set coeff_08_lsb = (New REGISTER_CE_coeff_08_lsb)(aBaseAddr, 16)
        Set coeff_08_msb = (New REGISTER_CE_coeff_08_msb)(aBaseAddr, 16)
        Set coeff_09_lsb = (New REGISTER_CE_coeff_09_lsb)(aBaseAddr, 16)
        Set coeff_09_msb = (New REGISTER_CE_coeff_09_msb)(aBaseAddr, 16)
        Set coeff_10_lsb = (New REGISTER_CE_coeff_10_lsb)(aBaseAddr, 16)
        Set coeff_10_msb = (New REGISTER_CE_coeff_10_msb)(aBaseAddr, 16)
        Set coeff_11_lsb = (New REGISTER_CE_coeff_11_lsb)(aBaseAddr, 16)
        Set coeff_11_msb = (New REGISTER_CE_coeff_11_msb)(aBaseAddr, 16)
        Set coeff_12_lsb = (New REGISTER_CE_coeff_12_lsb)(aBaseAddr, 16)
        Set coeff_12_msb = (New REGISTER_CE_coeff_12_msb)(aBaseAddr, 16)
        Set coeff_13_lsb = (New REGISTER_CE_coeff_13_lsb)(aBaseAddr, 16)
        Set coeff_13_msb = (New REGISTER_CE_coeff_13_msb)(aBaseAddr, 16)
        Set coeff_14_lsb = (New REGISTER_CE_coeff_14_lsb)(aBaseAddr, 16)
        Set coeff_14_msb = (New REGISTER_CE_coeff_14_msb)(aBaseAddr, 16)
        Set coeff_15_lsb = (New REGISTER_CE_coeff_15_lsb)(aBaseAddr, 16)
        Set coeff_15_msb = (New REGISTER_CE_coeff_15_msb)(aBaseAddr, 16)
        Set coeff_16_lsb = (New REGISTER_CE_coeff_16_lsb)(aBaseAddr, 16)
        Set coeff_16_msb = (New REGISTER_CE_coeff_16_msb)(aBaseAddr, 16)
        Set coeff_17_lsb = (New REGISTER_CE_coeff_17_lsb)(aBaseAddr, 16)
        Set coeff_17_msb = (New REGISTER_CE_coeff_17_msb)(aBaseAddr, 16)
        Set coeff_18_lsb = (New REGISTER_CE_coeff_18_lsb)(aBaseAddr, 16)
        Set coeff_18_msb = (New REGISTER_CE_coeff_18_msb)(aBaseAddr, 16)
        Set coeff_19_lsb = (New REGISTER_CE_coeff_19_lsb)(aBaseAddr, 16)
        Set coeff_19_msb = (New REGISTER_CE_coeff_19_msb)(aBaseAddr, 16)
        Set coeff_20_lsb = (New REGISTER_CE_coeff_20_lsb)(aBaseAddr, 16)
        Set coeff_20_msb = (New REGISTER_CE_coeff_20_msb)(aBaseAddr, 16)
        Set coeff_21_lsb = (New REGISTER_CE_coeff_21_lsb)(aBaseAddr, 16)
        Set coeff_21_msb = (New REGISTER_CE_coeff_21_msb)(aBaseAddr, 16)
        Set coeff_22_lsb = (New REGISTER_CE_coeff_22_lsb)(aBaseAddr, 16)
        Set coeff_22_msb = (New REGISTER_CE_coeff_22_msb)(aBaseAddr, 16)
        Set coeff_23_lsb = (New REGISTER_CE_coeff_23_lsb)(aBaseAddr, 16)
        Set coeff_23_msb = (New REGISTER_CE_coeff_23_msb)(aBaseAddr, 16)
        Set coeff_24_lsb = (New REGISTER_CE_coeff_24_lsb)(aBaseAddr, 16)
        Set coeff_24_msb = (New REGISTER_CE_coeff_24_msb)(aBaseAddr, 16)
        Set coeff_25_lsb = (New REGISTER_CE_coeff_25_lsb)(aBaseAddr, 16)
        Set coeff_25_msb = (New REGISTER_CE_coeff_25_msb)(aBaseAddr, 16)
        Set coeff_26_lsb = (New REGISTER_CE_coeff_26_lsb)(aBaseAddr, 16)
        Set coeff_26_msb = (New REGISTER_CE_coeff_26_msb)(aBaseAddr, 16)
        Set coeff_27_lsb = (New REGISTER_CE_coeff_27_lsb)(aBaseAddr, 16)
        Set coeff_27_msb = (New REGISTER_CE_coeff_27_msb)(aBaseAddr, 16)
        Set coeff_28_lsb = (New REGISTER_CE_coeff_28_lsb)(aBaseAddr, 16)
        Set coeff_28_msb = (New REGISTER_CE_coeff_28_msb)(aBaseAddr, 16)
        Set coeff_29_lsb = (New REGISTER_CE_coeff_29_lsb)(aBaseAddr, 16)
        Set coeff_29_msb = (New REGISTER_CE_coeff_29_msb)(aBaseAddr, 16)
        Set coeff_30_lsb = (New REGISTER_CE_coeff_30_lsb)(aBaseAddr, 16)
        Set coeff_30_msb = (New REGISTER_CE_coeff_30_msb)(aBaseAddr, 16)
        Set coeff_31_lsb = (New REGISTER_CE_coeff_31_lsb)(aBaseAddr, 16)
        Set coeff_31_msb = (New REGISTER_CE_coeff_31_msb)(aBaseAddr, 16)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set CE = CreateObject("System.Collections.ArrayList")
CE.Add ((New CE_INSTANCE)(&H49031400))


