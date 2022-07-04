

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


'' @REGISTER : EC_control_0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ECRSTN_FORCE_DEASSERT                      [11:11]          get_ECRSTN_FORCE_DEASSERT
''                                                             set_ECRSTN_FORCE_DEASSERT
''                                                             read_ECRSTN_FORCE_DEASSERT
''                                                             write_ECRSTN_FORCE_DEASSERT
''---------------------------------------------------------------------------------
'' ECRSTN_FORCE_ASSERT                        [10:10]          get_ECRSTN_FORCE_ASSERT
''                                                             set_ECRSTN_FORCE_ASSERT
''                                                             read_ECRSTN_FORCE_ASSERT
''                                                             write_ECRSTN_FORCE_ASSERT
''---------------------------------------------------------------------------------
'' ENABLE_FFE_FORCE_DEASSERT                  [9:9]            get_ENABLE_FFE_FORCE_DEASSERT
''                                                             set_ENABLE_FFE_FORCE_DEASSERT
''                                                             read_ENABLE_FFE_FORCE_DEASSERT
''                                                             write_ENABLE_FFE_FORCE_DEASSERT
''---------------------------------------------------------------------------------
'' ENABLE_FFE_FORCE_ASSERT                    [8:8]            get_ENABLE_FFE_FORCE_ASSERT
''                                                             set_ENABLE_FFE_FORCE_ASSERT
''                                                             read_ENABLE_FFE_FORCE_ASSERT
''                                                             write_ENABLE_FFE_FORCE_ASSERT
''---------------------------------------------------------------------------------
'' MU_OVERRIDE                                [7:7]            get_MU_OVERRIDE
''                                                             set_MU_OVERRIDE
''                                                             read_MU_OVERRIDE
''                                                             write_MU_OVERRIDE
''---------------------------------------------------------------------------------
'' MU_CTL                                     [6:6]            get_MU_CTL
''                                                             set_MU_CTL
''                                                             read_MU_CTL
''                                                             write_MU_CTL
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
Class REGISTER_EC_control_0
    Private write_ECRSTN_FORCE_DEASSERT_value
    Private read_ECRSTN_FORCE_DEASSERT_value
    Private flag_ECRSTN_FORCE_DEASSERT
    Private write_ECRSTN_FORCE_ASSERT_value
    Private read_ECRSTN_FORCE_ASSERT_value
    Private flag_ECRSTN_FORCE_ASSERT
    Private write_ENABLE_FFE_FORCE_DEASSERT_value
    Private read_ENABLE_FFE_FORCE_DEASSERT_value
    Private flag_ENABLE_FFE_FORCE_DEASSERT
    Private write_ENABLE_FFE_FORCE_ASSERT_value
    Private read_ENABLE_FFE_FORCE_ASSERT_value
    Private flag_ENABLE_FFE_FORCE_ASSERT
    Private write_MU_OVERRIDE_value
    Private read_MU_OVERRIDE_value
    Private flag_MU_OVERRIDE
    Private write_MU_CTL_value
    Private read_MU_CTL_value
    Private flag_MU_CTL
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

    Property Get get_ECRSTN_FORCE_DEASSERT
        get_ECRSTN_FORCE_DEASSERT = read_ECRSTN_FORCE_DEASSERT_value
    End Property

    Property Let set_ECRSTN_FORCE_DEASSERT(aData)
        write_ECRSTN_FORCE_DEASSERT_value = aData
        flag_ECRSTN_FORCE_DEASSERT        = &H1
    End Property

    Property Get read_ECRSTN_FORCE_DEASSERT
        read
        read_ECRSTN_FORCE_DEASSERT = read_ECRSTN_FORCE_DEASSERT_value
    End Property

    Property Let write_ECRSTN_FORCE_DEASSERT(aData)
        set_ECRSTN_FORCE_DEASSERT = aData
        write
    End Property

    Property Get get_ECRSTN_FORCE_ASSERT
        get_ECRSTN_FORCE_ASSERT = read_ECRSTN_FORCE_ASSERT_value
    End Property

    Property Let set_ECRSTN_FORCE_ASSERT(aData)
        write_ECRSTN_FORCE_ASSERT_value = aData
        flag_ECRSTN_FORCE_ASSERT        = &H1
    End Property

    Property Get read_ECRSTN_FORCE_ASSERT
        read
        read_ECRSTN_FORCE_ASSERT = read_ECRSTN_FORCE_ASSERT_value
    End Property

    Property Let write_ECRSTN_FORCE_ASSERT(aData)
        set_ECRSTN_FORCE_ASSERT = aData
        write
    End Property

    Property Get get_ENABLE_FFE_FORCE_DEASSERT
        get_ENABLE_FFE_FORCE_DEASSERT = read_ENABLE_FFE_FORCE_DEASSERT_value
    End Property

    Property Let set_ENABLE_FFE_FORCE_DEASSERT(aData)
        write_ENABLE_FFE_FORCE_DEASSERT_value = aData
        flag_ENABLE_FFE_FORCE_DEASSERT        = &H1
    End Property

    Property Get read_ENABLE_FFE_FORCE_DEASSERT
        read
        read_ENABLE_FFE_FORCE_DEASSERT = read_ENABLE_FFE_FORCE_DEASSERT_value
    End Property

    Property Let write_ENABLE_FFE_FORCE_DEASSERT(aData)
        set_ENABLE_FFE_FORCE_DEASSERT = aData
        write
    End Property

    Property Get get_ENABLE_FFE_FORCE_ASSERT
        get_ENABLE_FFE_FORCE_ASSERT = read_ENABLE_FFE_FORCE_ASSERT_value
    End Property

    Property Let set_ENABLE_FFE_FORCE_ASSERT(aData)
        write_ENABLE_FFE_FORCE_ASSERT_value = aData
        flag_ENABLE_FFE_FORCE_ASSERT        = &H1
    End Property

    Property Get read_ENABLE_FFE_FORCE_ASSERT
        read
        read_ENABLE_FFE_FORCE_ASSERT = read_ENABLE_FFE_FORCE_ASSERT_value
    End Property

    Property Let write_ENABLE_FFE_FORCE_ASSERT(aData)
        set_ENABLE_FFE_FORCE_ASSERT = aData
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

    Property Get get_MU_CTL
        get_MU_CTL = read_MU_CTL_value
    End Property

    Property Let set_MU_CTL(aData)
        write_MU_CTL_value = aData
        flag_MU_CTL        = &H1
    End Property

    Property Get read_MU_CTL
        read
        read_MU_CTL = read_MU_CTL_value
    End Property

    Property Let write_MU_CTL(aData)
        set_MU_CTL = aData
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
        read_ECRSTN_FORCE_DEASSERT_value = rightShift(data_low, 11) and &H1
        read_ECRSTN_FORCE_ASSERT_value = rightShift(data_low, 10) and &H1
        read_ENABLE_FFE_FORCE_DEASSERT_value = rightShift(data_low, 9) and &H1
        read_ENABLE_FFE_FORCE_ASSERT_value = rightShift(data_low, 8) and &H1
        read_MU_OVERRIDE_value = rightShift(data_low, 7) and &H1
        read_MU_CTL_value = rightShift(data_low, 6) and &H1
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
        If flag_ECRSTN_FORCE_DEASSERT = &H0 or flag_ECRSTN_FORCE_ASSERT = &H0 or flag_ENABLE_FFE_FORCE_DEASSERT = &H0 or flag_ENABLE_FFE_FORCE_ASSERT = &H0 or flag_MU_OVERRIDE = &H0 or flag_MU_CTL = &H0 or flag_HI_MU_CTL = &H0 or flag_LO_MU_CTL = &H0 or flag_FREEZE_FORCE_DEASSERT = &H0 or flag_FREEZE_FORCE_ASSERT = &H0 Then read
        If flag_ECRSTN_FORCE_DEASSERT = &H0 Then write_ECRSTN_FORCE_DEASSERT_value = get_ECRSTN_FORCE_DEASSERT
        If flag_ECRSTN_FORCE_ASSERT = &H0 Then write_ECRSTN_FORCE_ASSERT_value = get_ECRSTN_FORCE_ASSERT
        If flag_ENABLE_FFE_FORCE_DEASSERT = &H0 Then write_ENABLE_FFE_FORCE_DEASSERT_value = get_ENABLE_FFE_FORCE_DEASSERT
        If flag_ENABLE_FFE_FORCE_ASSERT = &H0 Then write_ENABLE_FFE_FORCE_ASSERT_value = get_ENABLE_FFE_FORCE_ASSERT
        If flag_MU_OVERRIDE = &H0 Then write_MU_OVERRIDE_value = get_MU_OVERRIDE
        If flag_MU_CTL = &H0 Then write_MU_CTL_value = get_MU_CTL
        If flag_HI_MU_CTL = &H0 Then write_HI_MU_CTL_value = get_HI_MU_CTL
        If flag_LO_MU_CTL = &H0 Then write_LO_MU_CTL_value = get_LO_MU_CTL
        If flag_FREEZE_FORCE_DEASSERT = &H0 Then write_FREEZE_FORCE_DEASSERT_value = get_FREEZE_FORCE_DEASSERT
        If flag_FREEZE_FORCE_ASSERT = &H0 Then write_FREEZE_FORCE_ASSERT_value = get_FREEZE_FORCE_ASSERT

        regValue = leftShift((write_ECRSTN_FORCE_DEASSERT_value and &H1), 11) + leftShift((write_ECRSTN_FORCE_ASSERT_value and &H1), 10) + leftShift((write_ENABLE_FFE_FORCE_DEASSERT_value and &H1), 9) + leftShift((write_ENABLE_FFE_FORCE_ASSERT_value and &H1), 8) + leftShift((write_MU_OVERRIDE_value and &H1), 7) + leftShift((write_MU_CTL_value and &H1), 6) + leftShift((write_HI_MU_CTL_value and &H3), 4) + leftShift((write_LO_MU_CTL_value and &H3), 2) + leftShift((write_FREEZE_FORCE_DEASSERT_value and &H1), 1) + leftShift((write_FREEZE_FORCE_ASSERT_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ECRSTN_FORCE_DEASSERT_value = rightShift(data_low, 11) and &H1
        read_ECRSTN_FORCE_ASSERT_value = rightShift(data_low, 10) and &H1
        read_ENABLE_FFE_FORCE_DEASSERT_value = rightShift(data_low, 9) and &H1
        read_ENABLE_FFE_FORCE_ASSERT_value = rightShift(data_low, 8) and &H1
        read_MU_OVERRIDE_value = rightShift(data_low, 7) and &H1
        read_MU_CTL_value = rightShift(data_low, 6) and &H1
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
        write_ECRSTN_FORCE_DEASSERT_value = &H0
        flag_ECRSTN_FORCE_DEASSERT        = &H0
        write_ECRSTN_FORCE_ASSERT_value = &H0
        flag_ECRSTN_FORCE_ASSERT        = &H0
        write_ENABLE_FFE_FORCE_DEASSERT_value = &H0
        flag_ENABLE_FFE_FORCE_DEASSERT        = &H0
        write_ENABLE_FFE_FORCE_ASSERT_value = &H0
        flag_ENABLE_FFE_FORCE_ASSERT        = &H0
        write_MU_OVERRIDE_value = &H0
        flag_MU_OVERRIDE        = &H0
        write_MU_CTL_value = &H0
        flag_MU_CTL        = &H0
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


'' @REGISTER : EC_spare_end_addr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SPARE_REGISTER                             [15:0]           get_SPARE_REGISTER
''                                                             set_SPARE_REGISTER
''                                                             read_SPARE_REGISTER
''                                                             write_SPARE_REGISTER
''---------------------------------------------------------------------------------
Class REGISTER_EC_spare_end_addr
    Private write_SPARE_REGISTER_value
    Private read_SPARE_REGISTER_value
    Private flag_SPARE_REGISTER

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

    Property Get get_SPARE_REGISTER
        get_SPARE_REGISTER = read_SPARE_REGISTER_value
    End Property

    Property Let set_SPARE_REGISTER(aData)
        write_SPARE_REGISTER_value = aData
        flag_SPARE_REGISTER        = &H1
    End Property

    Property Get read_SPARE_REGISTER
        read
        read_SPARE_REGISTER = read_SPARE_REGISTER_value
    End Property

    Property Let write_SPARE_REGISTER(aData)
        set_SPARE_REGISTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SPARE_REGISTER_mask = &Hffff
        if data_low > LONG_MAX then
            if SPARE_REGISTER_mask = mask then
                read_SPARE_REGISTER_value = data_low
            else
                read_SPARE_REGISTER_value = (data_low - H8000_0000) and SPARE_REGISTER_mask
            end If
        else
            read_SPARE_REGISTER_value = data_low and SPARE_REGISTER_mask
        end If

    End Sub

    Sub write
        If flag_SPARE_REGISTER = &H0 Then read
        If flag_SPARE_REGISTER = &H0 Then write_SPARE_REGISTER_value = get_SPARE_REGISTER

        regValue = leftShift((write_SPARE_REGISTER_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SPARE_REGISTER_mask = &Hffff
        if data_low > LONG_MAX then
            if SPARE_REGISTER_mask = mask then
                read_SPARE_REGISTER_value = data_low
            else
                read_SPARE_REGISTER_value = (data_low - H8000_0000) and SPARE_REGISTER_mask
            end If
        else
            read_SPARE_REGISTER_value = data_low and SPARE_REGISTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SPARE_REGISTER_value = &H0
        flag_SPARE_REGISTER        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class EC_INSTANCE

    Public control_0
    Public spare_end_addr


    Public default function Init(aBaseAddr)
        Set control_0 = (New REGISTER_EC_control_0)(aBaseAddr, 16)
        Set spare_end_addr = (New REGISTER_EC_spare_end_addr)(aBaseAddr, 16)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set EC = CreateObject("System.Collections.ArrayList")
EC.Add ((New EC_INSTANCE)(&H49031000))


