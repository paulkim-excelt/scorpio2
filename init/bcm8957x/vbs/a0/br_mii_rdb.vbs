

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


'' @REGISTER : BR_MII_mii_ctrl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' RESET                                      [15:15]          get_RESET
''                                                             set_RESET
''                                                             read_RESET
''                                                             write_RESET
''---------------------------------------------------------------------------------
'' POWER_DOWN                                 [11:11]          get_POWER_DOWN
''                                                             set_POWER_DOWN
''                                                             read_POWER_DOWN
''                                                             write_POWER_DOWN
''---------------------------------------------------------------------------------
'' ISOLATE                                    [10:10]          get_ISOLATE
''                                                             set_ISOLATE
''                                                             read_ISOLATE
''                                                             write_ISOLATE
''---------------------------------------------------------------------------------
Class REGISTER_BR_MII_mii_ctrl
    Private write_RESET_value
    Private read_RESET_value
    Private flag_RESET
    Private write_POWER_DOWN_value
    Private read_POWER_DOWN_value
    Private flag_POWER_DOWN
    Private write_ISOLATE_value
    Private read_ISOLATE_value
    Private flag_ISOLATE

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

    Property Get get_RESET
        get_RESET = read_RESET_value
    End Property

    Property Let set_RESET(aData)
        write_RESET_value = aData
        flag_RESET        = &H1
    End Property

    Property Get read_RESET
        read
        read_RESET = read_RESET_value
    End Property

    Property Let write_RESET(aData)
        set_RESET = aData
        write
    End Property

    Property Get get_POWER_DOWN
        get_POWER_DOWN = read_POWER_DOWN_value
    End Property

    Property Let set_POWER_DOWN(aData)
        write_POWER_DOWN_value = aData
        flag_POWER_DOWN        = &H1
    End Property

    Property Get read_POWER_DOWN
        read
        read_POWER_DOWN = read_POWER_DOWN_value
    End Property

    Property Let write_POWER_DOWN(aData)
        set_POWER_DOWN = aData
        write
    End Property

    Property Get get_ISOLATE
        get_ISOLATE = read_ISOLATE_value
    End Property

    Property Let set_ISOLATE(aData)
        write_ISOLATE_value = aData
        flag_ISOLATE        = &H1
    End Property

    Property Get read_ISOLATE
        read
        read_ISOLATE = read_ISOLATE_value
    End Property

    Property Let write_ISOLATE(aData)
        set_ISOLATE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_RESET_value = rightShift(data_low, 15) and &H1
        read_POWER_DOWN_value = rightShift(data_low, 11) and &H1
        read_ISOLATE_value = rightShift(data_low, 10) and &H1

    End Sub

    Sub write
        If flag_RESET = &H0 or flag_POWER_DOWN = &H0 or flag_ISOLATE = &H0 Then read
        If flag_RESET = &H0 Then write_RESET_value = get_RESET
        If flag_POWER_DOWN = &H0 Then write_POWER_DOWN_value = get_POWER_DOWN
        If flag_ISOLATE = &H0 Then write_ISOLATE_value = get_ISOLATE

        regValue = leftShift((write_RESET_value and &H1), 15) + leftShift((write_POWER_DOWN_value and &H1), 11) + leftShift((write_ISOLATE_value and &H1), 10)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_RESET_value = rightShift(data_low, 15) and &H1
        read_POWER_DOWN_value = rightShift(data_low, 11) and &H1
        read_ISOLATE_value = rightShift(data_low, 10) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_RESET_value = &H0
        flag_RESET        = &H0
        write_POWER_DOWN_value = &H0
        flag_POWER_DOWN        = &H0
        write_ISOLATE_value = &H0
        flag_ISOLATE        = &H0
    End Sub
End Class


'' @REGISTER : BR_MII_mii_stat
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' Capability                                 [14:9]           get_Capability
''                                                             set_Capability
''                                                             read_Capability
''                                                             write_Capability
''---------------------------------------------------------------------------------
'' EXTENDED_STAT                              [8:6]            get_EXTENDED_STAT
''                                                             set_EXTENDED_STAT
''                                                             read_EXTENDED_STAT
''                                                             write_EXTENDED_STAT
''---------------------------------------------------------------------------------
'' LDS_complete                               [5:5]            get_LDS_complete
''                                                             set_LDS_complete
''                                                             read_LDS_complete
''                                                             write_LDS_complete
''---------------------------------------------------------------------------------
'' LNK_STAT                                   [2:2]            get_LNK_STAT
''                                                             set_LNK_STAT
''                                                             read_LNK_STAT
''                                                             write_LNK_STAT
''---------------------------------------------------------------------------------
'' JABBER_DETECT                              [1:1]            get_JABBER_DETECT
''                                                             set_JABBER_DETECT
''                                                             read_JABBER_DETECT
''                                                             write_JABBER_DETECT
''---------------------------------------------------------------------------------
'' EXTENDED_CAPABILITY                        [0:0]            get_EXTENDED_CAPABILITY
''                                                             set_EXTENDED_CAPABILITY
''                                                             read_EXTENDED_CAPABILITY
''                                                             write_EXTENDED_CAPABILITY
''---------------------------------------------------------------------------------
Class REGISTER_BR_MII_mii_stat
    Private write_Capability_value
    Private read_Capability_value
    Private flag_Capability
    Private write_EXTENDED_STAT_value
    Private read_EXTENDED_STAT_value
    Private flag_EXTENDED_STAT
    Private write_LDS_complete_value
    Private read_LDS_complete_value
    Private flag_LDS_complete
    Private write_LNK_STAT_value
    Private read_LNK_STAT_value
    Private flag_LNK_STAT
    Private write_JABBER_DETECT_value
    Private read_JABBER_DETECT_value
    Private flag_JABBER_DETECT
    Private write_EXTENDED_CAPABILITY_value
    Private read_EXTENDED_CAPABILITY_value
    Private flag_EXTENDED_CAPABILITY

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

    Property Get get_Capability
        get_Capability = read_Capability_value
    End Property

    Property Let set_Capability(aData)
        write_Capability_value = aData
        flag_Capability        = &H1
    End Property

    Property Get read_Capability
        read
        read_Capability = read_Capability_value
    End Property

    Property Let write_Capability(aData)
        set_Capability = aData
        write
    End Property

    Property Get get_EXTENDED_STAT
        get_EXTENDED_STAT = read_EXTENDED_STAT_value
    End Property

    Property Let set_EXTENDED_STAT(aData)
        write_EXTENDED_STAT_value = aData
        flag_EXTENDED_STAT        = &H1
    End Property

    Property Get read_EXTENDED_STAT
        read
        read_EXTENDED_STAT = read_EXTENDED_STAT_value
    End Property

    Property Let write_EXTENDED_STAT(aData)
        set_EXTENDED_STAT = aData
        write
    End Property

    Property Get get_LDS_complete
        get_LDS_complete = read_LDS_complete_value
    End Property

    Property Let set_LDS_complete(aData)
        write_LDS_complete_value = aData
        flag_LDS_complete        = &H1
    End Property

    Property Get read_LDS_complete
        read
        read_LDS_complete = read_LDS_complete_value
    End Property

    Property Let write_LDS_complete(aData)
        set_LDS_complete = aData
        write
    End Property

    Property Get get_LNK_STAT
        get_LNK_STAT = read_LNK_STAT_value
    End Property

    Property Let set_LNK_STAT(aData)
        write_LNK_STAT_value = aData
        flag_LNK_STAT        = &H1
    End Property

    Property Get read_LNK_STAT
        read
        read_LNK_STAT = read_LNK_STAT_value
    End Property

    Property Let write_LNK_STAT(aData)
        set_LNK_STAT = aData
        write
    End Property

    Property Get get_JABBER_DETECT
        get_JABBER_DETECT = read_JABBER_DETECT_value
    End Property

    Property Let set_JABBER_DETECT(aData)
        write_JABBER_DETECT_value = aData
        flag_JABBER_DETECT        = &H1
    End Property

    Property Get read_JABBER_DETECT
        read
        read_JABBER_DETECT = read_JABBER_DETECT_value
    End Property

    Property Let write_JABBER_DETECT(aData)
        set_JABBER_DETECT = aData
        write
    End Property

    Property Get get_EXTENDED_CAPABILITY
        get_EXTENDED_CAPABILITY = read_EXTENDED_CAPABILITY_value
    End Property

    Property Let set_EXTENDED_CAPABILITY(aData)
        write_EXTENDED_CAPABILITY_value = aData
        flag_EXTENDED_CAPABILITY        = &H1
    End Property

    Property Get read_EXTENDED_CAPABILITY
        read
        read_EXTENDED_CAPABILITY = read_EXTENDED_CAPABILITY_value
    End Property

    Property Let write_EXTENDED_CAPABILITY(aData)
        set_EXTENDED_CAPABILITY = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_Capability_value = rightShift(data_low, 9) and &H3f
        read_EXTENDED_STAT_value = rightShift(data_low, 6) and &H7
        read_LDS_complete_value = rightShift(data_low, 5) and &H1
        read_LNK_STAT_value = rightShift(data_low, 2) and &H1
        read_JABBER_DETECT_value = rightShift(data_low, 1) and &H1
        EXTENDED_CAPABILITY_mask = &H1
        if data_low > LONG_MAX then
            if EXTENDED_CAPABILITY_mask = mask then
                read_EXTENDED_CAPABILITY_value = data_low
            else
                read_EXTENDED_CAPABILITY_value = (data_low - H8000_0000) and EXTENDED_CAPABILITY_mask
            end If
        else
            read_EXTENDED_CAPABILITY_value = data_low and EXTENDED_CAPABILITY_mask
        end If

    End Sub

    Sub write
        If flag_Capability = &H0 or flag_EXTENDED_STAT = &H0 or flag_LDS_complete = &H0 or flag_LNK_STAT = &H0 or flag_JABBER_DETECT = &H0 or flag_EXTENDED_CAPABILITY = &H0 Then read
        If flag_Capability = &H0 Then write_Capability_value = get_Capability
        If flag_EXTENDED_STAT = &H0 Then write_EXTENDED_STAT_value = get_EXTENDED_STAT
        If flag_LDS_complete = &H0 Then write_LDS_complete_value = get_LDS_complete
        If flag_LNK_STAT = &H0 Then write_LNK_STAT_value = get_LNK_STAT
        If flag_JABBER_DETECT = &H0 Then write_JABBER_DETECT_value = get_JABBER_DETECT
        If flag_EXTENDED_CAPABILITY = &H0 Then write_EXTENDED_CAPABILITY_value = get_EXTENDED_CAPABILITY

        regValue = leftShift((write_Capability_value and &H3f), 9) + leftShift((write_EXTENDED_STAT_value and &H7), 6) + leftShift((write_LDS_complete_value and &H1), 5) + leftShift((write_LNK_STAT_value and &H1), 2) + leftShift((write_JABBER_DETECT_value and &H1), 1) + leftShift((write_EXTENDED_CAPABILITY_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_Capability_value = rightShift(data_low, 9) and &H3f
        read_EXTENDED_STAT_value = rightShift(data_low, 6) and &H7
        read_LDS_complete_value = rightShift(data_low, 5) and &H1
        read_LNK_STAT_value = rightShift(data_low, 2) and &H1
        read_JABBER_DETECT_value = rightShift(data_low, 1) and &H1
        EXTENDED_CAPABILITY_mask = &H1
        if data_low > LONG_MAX then
            if EXTENDED_CAPABILITY_mask = mask then
                read_EXTENDED_CAPABILITY_value = data_low
            else
                read_EXTENDED_CAPABILITY_value = (data_low - H8000_0000) and EXTENDED_CAPABILITY_mask
            end If
        else
            read_EXTENDED_CAPABILITY_value = data_low and EXTENDED_CAPABILITY_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_Capability_value = &H0
        flag_Capability        = &H0
        write_EXTENDED_STAT_value = &H0
        flag_EXTENDED_STAT        = &H0
        write_LDS_complete_value = &H0
        flag_LDS_complete        = &H0
        write_LNK_STAT_value = &H0
        flag_LNK_STAT        = &H0
        write_JABBER_DETECT_value = &H0
        flag_JABBER_DETECT        = &H0
        write_EXTENDED_CAPABILITY_value = &H0
        flag_EXTENDED_CAPABILITY        = &H0
    End Sub
End Class


'' @REGISTER : BR_MII_phy_id_msb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' OUI_MSB                                    [15:0]           get_OUI_MSB
''                                                             set_OUI_MSB
''                                                             read_OUI_MSB
''                                                             write_OUI_MSB
''---------------------------------------------------------------------------------
Class REGISTER_BR_MII_phy_id_msb
    Private write_OUI_MSB_value
    Private read_OUI_MSB_value
    Private flag_OUI_MSB

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

    Property Get get_OUI_MSB
        get_OUI_MSB = read_OUI_MSB_value
    End Property

    Property Let set_OUI_MSB(aData)
        write_OUI_MSB_value = aData
        flag_OUI_MSB        = &H1
    End Property

    Property Get read_OUI_MSB
        read
        read_OUI_MSB = read_OUI_MSB_value
    End Property

    Property Let write_OUI_MSB(aData)
        set_OUI_MSB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        OUI_MSB_mask = &Hffff
        if data_low > LONG_MAX then
            if OUI_MSB_mask = mask then
                read_OUI_MSB_value = data_low
            else
                read_OUI_MSB_value = (data_low - H8000_0000) and OUI_MSB_mask
            end If
        else
            read_OUI_MSB_value = data_low and OUI_MSB_mask
        end If

    End Sub

    Sub write
        If flag_OUI_MSB = &H0 Then read
        If flag_OUI_MSB = &H0 Then write_OUI_MSB_value = get_OUI_MSB

        regValue = leftShift((write_OUI_MSB_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        OUI_MSB_mask = &Hffff
        if data_low > LONG_MAX then
            if OUI_MSB_mask = mask then
                read_OUI_MSB_value = data_low
            else
                read_OUI_MSB_value = (data_low - H8000_0000) and OUI_MSB_mask
            end If
        else
            read_OUI_MSB_value = data_low and OUI_MSB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_OUI_MSB_value = &H0
        flag_OUI_MSB        = &H0
    End Sub
End Class


'' @REGISTER : BR_MII_phy_id_lsb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' OUI_LSB                                    [15:10]          get_OUI_LSB
''                                                             set_OUI_LSB
''                                                             read_OUI_LSB
''                                                             write_OUI_LSB
''---------------------------------------------------------------------------------
'' MODEL                                      [9:4]            get_MODEL
''                                                             set_MODEL
''                                                             read_MODEL
''                                                             write_MODEL
''---------------------------------------------------------------------------------
'' REVISION                                   [3:0]            get_REVISION
''                                                             set_REVISION
''                                                             read_REVISION
''                                                             write_REVISION
''---------------------------------------------------------------------------------
Class REGISTER_BR_MII_phy_id_lsb
    Private write_OUI_LSB_value
    Private read_OUI_LSB_value
    Private flag_OUI_LSB
    Private write_MODEL_value
    Private read_MODEL_value
    Private flag_MODEL
    Private write_REVISION_value
    Private read_REVISION_value
    Private flag_REVISION

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

    Property Get get_OUI_LSB
        get_OUI_LSB = read_OUI_LSB_value
    End Property

    Property Let set_OUI_LSB(aData)
        write_OUI_LSB_value = aData
        flag_OUI_LSB        = &H1
    End Property

    Property Get read_OUI_LSB
        read
        read_OUI_LSB = read_OUI_LSB_value
    End Property

    Property Let write_OUI_LSB(aData)
        set_OUI_LSB = aData
        write
    End Property

    Property Get get_MODEL
        get_MODEL = read_MODEL_value
    End Property

    Property Let set_MODEL(aData)
        write_MODEL_value = aData
        flag_MODEL        = &H1
    End Property

    Property Get read_MODEL
        read
        read_MODEL = read_MODEL_value
    End Property

    Property Let write_MODEL(aData)
        set_MODEL = aData
        write
    End Property

    Property Get get_REVISION
        get_REVISION = read_REVISION_value
    End Property

    Property Let set_REVISION(aData)
        write_REVISION_value = aData
        flag_REVISION        = &H1
    End Property

    Property Get read_REVISION
        read
        read_REVISION = read_REVISION_value
    End Property

    Property Let write_REVISION(aData)
        set_REVISION = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_OUI_LSB_value = rightShift(data_low, 10) and &H3f
        read_MODEL_value = rightShift(data_low, 4) and &H3f
        REVISION_mask = &Hf
        if data_low > LONG_MAX then
            if REVISION_mask = mask then
                read_REVISION_value = data_low
            else
                read_REVISION_value = (data_low - H8000_0000) and REVISION_mask
            end If
        else
            read_REVISION_value = data_low and REVISION_mask
        end If

    End Sub

    Sub write
        If flag_OUI_LSB = &H0 or flag_MODEL = &H0 or flag_REVISION = &H0 Then read
        If flag_OUI_LSB = &H0 Then write_OUI_LSB_value = get_OUI_LSB
        If flag_MODEL = &H0 Then write_MODEL_value = get_MODEL
        If flag_REVISION = &H0 Then write_REVISION_value = get_REVISION

        regValue = leftShift((write_OUI_LSB_value and &H3f), 10) + leftShift((write_MODEL_value and &H3f), 4) + leftShift((write_REVISION_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_OUI_LSB_value = rightShift(data_low, 10) and &H3f
        read_MODEL_value = rightShift(data_low, 4) and &H3f
        REVISION_mask = &Hf
        if data_low > LONG_MAX then
            if REVISION_mask = mask then
                read_REVISION_value = data_low
            else
                read_REVISION_value = (data_low - H8000_0000) and REVISION_mask
            end If
        else
            read_REVISION_value = data_low and REVISION_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_OUI_LSB_value = &H0
        flag_OUI_LSB        = &H0
        write_MODEL_value = &H0
        flag_MODEL        = &H0
        write_REVISION_value = &H0
        flag_REVISION        = &H0
    End Sub
End Class


'' @REGISTER : BR_MII_lds_adv_ability_bp
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
Class REGISTER_BR_MII_lds_adv_ability_bp

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

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low

    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
    End Sub
End Class


'' @REGISTER : BR_MII_lds_adv_control
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
Class REGISTER_BR_MII_lds_adv_control

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

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low

    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
    End Sub
End Class


'' @REGISTER : BR_MII_lds_ability
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
Class REGISTER_BR_MII_lds_ability

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

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low

    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
    End Sub
End Class


'' @REGISTER : BR_MII_lds_lp_ability_bp
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
Class REGISTER_BR_MII_lds_lp_ability_bp

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

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low

    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
    End Sub
End Class


'' @REGISTER : BR_MII_lds_lp_msg_nxtp
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
Class REGISTER_BR_MII_lds_lp_msg_nxtp

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

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low

    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
    End Sub
End Class


'' @REGISTER : BR_MII_lds_lp_ability_nxtp
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
Class REGISTER_BR_MII_lds_lp_ability_nxtp

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H12
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low

    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
    End Sub
End Class


'' @REGISTER : BR_MII_lds_lds_exp
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
Class REGISTER_BR_MII_lds_lds_exp

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

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low

    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
    End Sub
End Class


'' @REGISTER : BR_MII_lre_extended_stat
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LOCAL_RECEIVE_STATUS                       [9:9]            get_LOCAL_RECEIVE_STATUS
''                                                             set_LOCAL_RECEIVE_STATUS
''                                                             read_LOCAL_RECEIVE_STATUS
''                                                             write_LOCAL_RECEIVE_STATUS
''---------------------------------------------------------------------------------
'' REMOTE_RECEIVE_STATUS                      [8:8]            get_REMOTE_RECEIVE_STATUS
''                                                             set_REMOTE_RECEIVE_STATUS
''                                                             read_REMOTE_RECEIVE_STATUS
''                                                             write_REMOTE_RECEIVE_STATUS
''---------------------------------------------------------------------------------
'' IDLE_ERROR_CNTR                            [7:0]            get_IDLE_ERROR_CNTR
''                                                             set_IDLE_ERROR_CNTR
''                                                             read_IDLE_ERROR_CNTR
''                                                             write_IDLE_ERROR_CNTR
''---------------------------------------------------------------------------------
Class REGISTER_BR_MII_lre_extended_stat
    Private write_LOCAL_RECEIVE_STATUS_value
    Private read_LOCAL_RECEIVE_STATUS_value
    Private flag_LOCAL_RECEIVE_STATUS
    Private write_REMOTE_RECEIVE_STATUS_value
    Private read_REMOTE_RECEIVE_STATUS_value
    Private flag_REMOTE_RECEIVE_STATUS
    Private write_IDLE_ERROR_CNTR_value
    Private read_IDLE_ERROR_CNTR_value
    Private flag_IDLE_ERROR_CNTR

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H16
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_LOCAL_RECEIVE_STATUS
        get_LOCAL_RECEIVE_STATUS = read_LOCAL_RECEIVE_STATUS_value
    End Property

    Property Let set_LOCAL_RECEIVE_STATUS(aData)
        write_LOCAL_RECEIVE_STATUS_value = aData
        flag_LOCAL_RECEIVE_STATUS        = &H1
    End Property

    Property Get read_LOCAL_RECEIVE_STATUS
        read
        read_LOCAL_RECEIVE_STATUS = read_LOCAL_RECEIVE_STATUS_value
    End Property

    Property Let write_LOCAL_RECEIVE_STATUS(aData)
        set_LOCAL_RECEIVE_STATUS = aData
        write
    End Property

    Property Get get_REMOTE_RECEIVE_STATUS
        get_REMOTE_RECEIVE_STATUS = read_REMOTE_RECEIVE_STATUS_value
    End Property

    Property Let set_REMOTE_RECEIVE_STATUS(aData)
        write_REMOTE_RECEIVE_STATUS_value = aData
        flag_REMOTE_RECEIVE_STATUS        = &H1
    End Property

    Property Get read_REMOTE_RECEIVE_STATUS
        read
        read_REMOTE_RECEIVE_STATUS = read_REMOTE_RECEIVE_STATUS_value
    End Property

    Property Let write_REMOTE_RECEIVE_STATUS(aData)
        set_REMOTE_RECEIVE_STATUS = aData
        write
    End Property

    Property Get get_IDLE_ERROR_CNTR
        get_IDLE_ERROR_CNTR = read_IDLE_ERROR_CNTR_value
    End Property

    Property Let set_IDLE_ERROR_CNTR(aData)
        write_IDLE_ERROR_CNTR_value = aData
        flag_IDLE_ERROR_CNTR        = &H1
    End Property

    Property Get read_IDLE_ERROR_CNTR
        read
        read_IDLE_ERROR_CNTR = read_IDLE_ERROR_CNTR_value
    End Property

    Property Let write_IDLE_ERROR_CNTR(aData)
        set_IDLE_ERROR_CNTR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LOCAL_RECEIVE_STATUS_value = rightShift(data_low, 9) and &H1
        read_REMOTE_RECEIVE_STATUS_value = rightShift(data_low, 8) and &H1
        IDLE_ERROR_CNTR_mask = &Hff
        if data_low > LONG_MAX then
            if IDLE_ERROR_CNTR_mask = mask then
                read_IDLE_ERROR_CNTR_value = data_low
            else
                read_IDLE_ERROR_CNTR_value = (data_low - H8000_0000) and IDLE_ERROR_CNTR_mask
            end If
        else
            read_IDLE_ERROR_CNTR_value = data_low and IDLE_ERROR_CNTR_mask
        end If

    End Sub

    Sub write
        If flag_LOCAL_RECEIVE_STATUS = &H0 or flag_REMOTE_RECEIVE_STATUS = &H0 or flag_IDLE_ERROR_CNTR = &H0 Then read
        If flag_LOCAL_RECEIVE_STATUS = &H0 Then write_LOCAL_RECEIVE_STATUS_value = get_LOCAL_RECEIVE_STATUS
        If flag_REMOTE_RECEIVE_STATUS = &H0 Then write_REMOTE_RECEIVE_STATUS_value = get_REMOTE_RECEIVE_STATUS
        If flag_IDLE_ERROR_CNTR = &H0 Then write_IDLE_ERROR_CNTR_value = get_IDLE_ERROR_CNTR

        regValue = leftShift((write_LOCAL_RECEIVE_STATUS_value and &H1), 9) + leftShift((write_REMOTE_RECEIVE_STATUS_value and &H1), 8) + leftShift((write_IDLE_ERROR_CNTR_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LOCAL_RECEIVE_STATUS_value = rightShift(data_low, 9) and &H1
        read_REMOTE_RECEIVE_STATUS_value = rightShift(data_low, 8) and &H1
        IDLE_ERROR_CNTR_mask = &Hff
        if data_low > LONG_MAX then
            if IDLE_ERROR_CNTR_mask = mask then
                read_IDLE_ERROR_CNTR_value = data_low
            else
                read_IDLE_ERROR_CNTR_value = (data_low - H8000_0000) and IDLE_ERROR_CNTR_mask
            end If
        else
            read_IDLE_ERROR_CNTR_value = data_low and IDLE_ERROR_CNTR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LOCAL_RECEIVE_STATUS_value = &H0
        flag_LOCAL_RECEIVE_STATUS        = &H0
        write_REMOTE_RECEIVE_STATUS_value = &H0
        flag_REMOTE_RECEIVE_STATUS        = &H0
        write_IDLE_ERROR_CNTR_value = &H0
        flag_IDLE_ERROR_CNTR        = &H0
    End Sub
End Class


'' @REGISTER : BR_MII_xctl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
Class REGISTER_BR_MII_xctl

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

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low

    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
    End Sub
End Class


'' @REGISTER : BR_MII_xstat
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
Class REGISTER_BR_MII_xstat

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1a
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low

    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
    End Sub
End Class


'' @REGISTER : BR_MII_rec
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
Class REGISTER_BR_MII_rec

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

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low

    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
    End Sub
End Class


'' @REGISTER : BR_MII_fcsc
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
Class REGISTER_BR_MII_fcsc

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

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low

    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
    End Sub
End Class


'' @REGISTER : BR_MII_rnokc
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
Class REGISTER_BR_MII_rnokc

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

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low

    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
    End Sub
End Class


'' @REGISTER : BR_MII_dsprw
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
Class REGISTER_BR_MII_dsprw

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

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low

    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
    End Sub
End Class


'' @REGISTER : BR_MII_dspctl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
Class REGISTER_BR_MII_dspctl

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

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low

    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
    End Sub
End Class


'' @REGISTER : BR_MII_dspaddr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
Class REGISTER_BR_MII_dspaddr

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

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low

    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
    End Sub
End Class


'' @REGISTER : BR_MII_auxctl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
Class REGISTER_BR_MII_auxctl

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

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low

    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
    End Sub
End Class


'' @REGISTER : BR_MII_auxstat
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
Class REGISTER_BR_MII_auxstat

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

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low

    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
    End Sub
End Class


'' @REGISTER : BR_MII_ints
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
Class REGISTER_BR_MII_ints

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

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low

    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
    End Sub
End Class


'' @REGISTER : BR_MII_intm
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
Class REGISTER_BR_MII_intm

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

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low

    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
    End Sub
End Class


'' @REGISTER : BR_MII_cled
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
Class REGISTER_BR_MII_cled

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

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low

    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
    End Sub
End Class


'' @REGISTER : BR_MII_msseed
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
Class REGISTER_BR_MII_msseed

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

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low

    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
    End Sub
End Class


'' @REGISTER : BR_MII_ptest0_rdbaddr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
Class REGISTER_BR_MII_ptest0_rdbaddr

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

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low

    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
    End Sub
End Class


'' @REGISTER : BR_MII_ptest1_rdbrw
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
Class REGISTER_BR_MII_ptest1_rdbrw

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

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low

    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class BR_MII_INSTANCE

    Public mii_ctrl
    Public mii_stat
    Public phy_id_msb
    Public phy_id_lsb
    Public lds_adv_ability_bp
    Public lds_adv_control
    Public lds_ability
    Public lds_lp_ability_bp
    Public lds_lp_msg_nxtp
    Public lds_lp_ability_nxtp
    Public lds_lds_exp
    Public lre_extended_stat
    Public xctl
    Public xstat
    Public rec
    Public fcsc
    Public rnokc
    Public dsprw
    Public dspctl
    Public dspaddr
    Public auxctl
    Public auxstat
    Public ints
    Public intm
    Public cled
    Public msseed
    Public ptest0_rdbaddr
    Public ptest1_rdbrw


    Public default function Init(aBaseAddr)
        Set mii_ctrl = (New REGISTER_BR_MII_mii_ctrl)(aBaseAddr, 16)
        Set mii_stat = (New REGISTER_BR_MII_mii_stat)(aBaseAddr, 16)
        Set phy_id_msb = (New REGISTER_BR_MII_phy_id_msb)(aBaseAddr, 16)
        Set phy_id_lsb = (New REGISTER_BR_MII_phy_id_lsb)(aBaseAddr, 16)
        Set lds_adv_ability_bp = (New REGISTER_BR_MII_lds_adv_ability_bp)(aBaseAddr, 16)
        Set lds_adv_control = (New REGISTER_BR_MII_lds_adv_control)(aBaseAddr, 16)
        Set lds_ability = (New REGISTER_BR_MII_lds_ability)(aBaseAddr, 16)
        Set lds_lp_ability_bp = (New REGISTER_BR_MII_lds_lp_ability_bp)(aBaseAddr, 16)
        Set lds_lp_msg_nxtp = (New REGISTER_BR_MII_lds_lp_msg_nxtp)(aBaseAddr, 16)
        Set lds_lp_ability_nxtp = (New REGISTER_BR_MII_lds_lp_ability_nxtp)(aBaseAddr, 16)
        Set lds_lds_exp = (New REGISTER_BR_MII_lds_lds_exp)(aBaseAddr, 16)
        Set lre_extended_stat = (New REGISTER_BR_MII_lre_extended_stat)(aBaseAddr, 16)
        Set xctl = (New REGISTER_BR_MII_xctl)(aBaseAddr, 16)
        Set xstat = (New REGISTER_BR_MII_xstat)(aBaseAddr, 16)
        Set rec = (New REGISTER_BR_MII_rec)(aBaseAddr, 16)
        Set fcsc = (New REGISTER_BR_MII_fcsc)(aBaseAddr, 16)
        Set rnokc = (New REGISTER_BR_MII_rnokc)(aBaseAddr, 16)
        Set dsprw = (New REGISTER_BR_MII_dsprw)(aBaseAddr, 16)
        Set dspctl = (New REGISTER_BR_MII_dspctl)(aBaseAddr, 16)
        Set dspaddr = (New REGISTER_BR_MII_dspaddr)(aBaseAddr, 16)
        Set auxctl = (New REGISTER_BR_MII_auxctl)(aBaseAddr, 16)
        Set auxstat = (New REGISTER_BR_MII_auxstat)(aBaseAddr, 16)
        Set ints = (New REGISTER_BR_MII_ints)(aBaseAddr, 16)
        Set intm = (New REGISTER_BR_MII_intm)(aBaseAddr, 16)
        Set cled = (New REGISTER_BR_MII_cled)(aBaseAddr, 16)
        Set msseed = (New REGISTER_BR_MII_msseed)(aBaseAddr, 16)
        Set ptest0_rdbaddr = (New REGISTER_BR_MII_ptest0_rdbaddr)(aBaseAddr, 16)
        Set ptest1_rdbrw = (New REGISTER_BR_MII_ptest1_rdbrw)(aBaseAddr, 16)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set BR_MII = CreateObject("System.Collections.ArrayList")
BR_MII.Add ((New BR_MII_INSTANCE)(&H4a4fffc0))
BR_MII.Add ((New BR_MII_INSTANCE)(&H494fffc0))
BR_MII.Add ((New BR_MII_INSTANCE)(&H498fffc0))
BR_MII.Add ((New BR_MII_INSTANCE)(&H49cfffc0))
BR_MII.Add ((New BR_MII_INSTANCE)(&H4a0fffc0))


