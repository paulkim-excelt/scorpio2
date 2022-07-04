

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


'' @REGISTER : EIP165S_EIP_165S_32_BRCM_EIP_165_GENERAL_eip165_debug
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ENABLE_DEBUG                               [0:0]            get_ENABLE_DEBUG
''                                                             set_ENABLE_DEBUG
''                                                             read_ENABLE_DEBUG
''                                                             write_ENABLE_DEBUG
''---------------------------------------------------------------------------------
'' SELE_SOUR                                  [10:1]           get_SELE_SOUR
''                                                             set_SELE_SOUR
''                                                             read_SELE_SOUR
''                                                             write_SELE_SOUR
''---------------------------------------------------------------------------------
'' SATU_CNTR                                  [16:16]          get_SATU_CNTR
''                                                             set_SATU_CNTR
''                                                             read_SATU_CNTR
''                                                             write_SATU_CNTR
''---------------------------------------------------------------------------------
'' AUTO_CNTR_RESE                             [17:17]          get_AUTO_CNTR_RESE
''                                                             set_AUTO_CNTR_RESE
''                                                             read_AUTO_CNTR_RESE
''                                                             write_AUTO_CNTR_RESE
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_165S_32_BRCM_EIP_165_GENERAL_eip165_debug
    Private write_ENABLE_DEBUG_value
    Private read_ENABLE_DEBUG_value
    Private flag_ENABLE_DEBUG
    Private write_SELE_SOUR_value
    Private read_SELE_SOUR_value
    Private flag_SELE_SOUR
    Private write_SATU_CNTR_value
    Private read_SATU_CNTR_value
    Private flag_SATU_CNTR
    Private write_AUTO_CNTR_RESE_value
    Private read_AUTO_CNTR_RESE_value
    Private flag_AUTO_CNTR_RESE

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H20ff0
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ENABLE_DEBUG
        get_ENABLE_DEBUG = read_ENABLE_DEBUG_value
    End Property

    Property Let set_ENABLE_DEBUG(aData)
        write_ENABLE_DEBUG_value = aData
        flag_ENABLE_DEBUG        = &H1
    End Property

    Property Get read_ENABLE_DEBUG
        read
        read_ENABLE_DEBUG = read_ENABLE_DEBUG_value
    End Property

    Property Let write_ENABLE_DEBUG(aData)
        set_ENABLE_DEBUG = aData
        write
    End Property

    Property Get get_SELE_SOUR
        get_SELE_SOUR = read_SELE_SOUR_value
    End Property

    Property Let set_SELE_SOUR(aData)
        write_SELE_SOUR_value = aData
        flag_SELE_SOUR        = &H1
    End Property

    Property Get read_SELE_SOUR
        read
        read_SELE_SOUR = read_SELE_SOUR_value
    End Property

    Property Let write_SELE_SOUR(aData)
        set_SELE_SOUR = aData
        write
    End Property

    Property Get get_SATU_CNTR
        get_SATU_CNTR = read_SATU_CNTR_value
    End Property

    Property Let set_SATU_CNTR(aData)
        write_SATU_CNTR_value = aData
        flag_SATU_CNTR        = &H1
    End Property

    Property Get read_SATU_CNTR
        read
        read_SATU_CNTR = read_SATU_CNTR_value
    End Property

    Property Let write_SATU_CNTR(aData)
        set_SATU_CNTR = aData
        write
    End Property

    Property Get get_AUTO_CNTR_RESE
        get_AUTO_CNTR_RESE = read_AUTO_CNTR_RESE_value
    End Property

    Property Let set_AUTO_CNTR_RESE(aData)
        write_AUTO_CNTR_RESE_value = aData
        flag_AUTO_CNTR_RESE        = &H1
    End Property

    Property Get read_AUTO_CNTR_RESE
        read
        read_AUTO_CNTR_RESE = read_AUTO_CNTR_RESE_value
    End Property

    Property Let write_AUTO_CNTR_RESE(aData)
        set_AUTO_CNTR_RESE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ENABLE_DEBUG_mask = &H1
        if data_low > LONG_MAX then
            if ENABLE_DEBUG_mask = mask then
                read_ENABLE_DEBUG_value = data_low
            else
                read_ENABLE_DEBUG_value = (data_low - H8000_0000) and ENABLE_DEBUG_mask
            end If
        else
            read_ENABLE_DEBUG_value = data_low and ENABLE_DEBUG_mask
        end If
        read_SELE_SOUR_value = rightShift(data_low, 1) and &H3ff
        read_SATU_CNTR_value = rightShift(data_low, 16) and &H1
        read_AUTO_CNTR_RESE_value = rightShift(data_low, 17) and &H1

    End Sub

    Sub write
        If flag_ENABLE_DEBUG = &H0 or flag_SELE_SOUR = &H0 or flag_SATU_CNTR = &H0 or flag_AUTO_CNTR_RESE = &H0 Then read
        If flag_ENABLE_DEBUG = &H0 Then write_ENABLE_DEBUG_value = get_ENABLE_DEBUG
        If flag_SELE_SOUR = &H0 Then write_SELE_SOUR_value = get_SELE_SOUR
        If flag_SATU_CNTR = &H0 Then write_SATU_CNTR_value = get_SATU_CNTR
        If flag_AUTO_CNTR_RESE = &H0 Then write_AUTO_CNTR_RESE_value = get_AUTO_CNTR_RESE

        regValue = leftShift((write_ENABLE_DEBUG_value and &H1), 0) + leftShift((write_SELE_SOUR_value and &H3ff), 1) + leftShift((write_SATU_CNTR_value and &H1), 16) + leftShift((write_AUTO_CNTR_RESE_value and &H1), 17)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ENABLE_DEBUG_mask = &H1
        if data_low > LONG_MAX then
            if ENABLE_DEBUG_mask = mask then
                read_ENABLE_DEBUG_value = data_low
            else
                read_ENABLE_DEBUG_value = (data_low - H8000_0000) and ENABLE_DEBUG_mask
            end If
        else
            read_ENABLE_DEBUG_value = data_low and ENABLE_DEBUG_mask
        end If
        read_SELE_SOUR_value = rightShift(data_low, 1) and &H3ff
        read_SATU_CNTR_value = rightShift(data_low, 16) and &H1
        read_AUTO_CNTR_RESE_value = rightShift(data_low, 17) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ENABLE_DEBUG_value = &H0
        flag_ENABLE_DEBUG        = &H0
        write_SELE_SOUR_value = &H0
        flag_SELE_SOUR        = &H0
        write_SATU_CNTR_value = &H0
        flag_SATU_CNTR        = &H0
        write_AUTO_CNTR_RESE_value = &H0
        flag_AUTO_CNTR_RESE        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_165S_32_BRCM_EIP_165_GENERAL_eip165_options
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SATU_CNTR                                  [0:0]            get_SATU_CNTR
''                                                             set_SATU_CNTR
''                                                             read_SATU_CNTR
''                                                             write_SATU_CNTR
''---------------------------------------------------------------------------------
'' AUTO_CNTR_RESE1                            [1:1]            get_AUTO_CNTR_RESE1
''                                                             set_AUTO_CNTR_RESE1
''                                                             read_AUTO_CNTR_RESE1
''                                                             write_AUTO_CNTR_RESE1
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_165S_32_BRCM_EIP_165_GENERAL_eip165_options
    Private write_SATU_CNTR_value
    Private read_SATU_CNTR_value
    Private flag_SATU_CNTR
    Private write_AUTO_CNTR_RESE1_value
    Private read_AUTO_CNTR_RESE1_value
    Private flag_AUTO_CNTR_RESE1

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H20ff8
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_SATU_CNTR
        get_SATU_CNTR = read_SATU_CNTR_value
    End Property

    Property Let set_SATU_CNTR(aData)
        write_SATU_CNTR_value = aData
        flag_SATU_CNTR        = &H1
    End Property

    Property Get read_SATU_CNTR
        read
        read_SATU_CNTR = read_SATU_CNTR_value
    End Property

    Property Let write_SATU_CNTR(aData)
        set_SATU_CNTR = aData
        write
    End Property

    Property Get get_AUTO_CNTR_RESE1
        get_AUTO_CNTR_RESE1 = read_AUTO_CNTR_RESE1_value
    End Property

    Property Let set_AUTO_CNTR_RESE1(aData)
        write_AUTO_CNTR_RESE1_value = aData
        flag_AUTO_CNTR_RESE1        = &H1
    End Property

    Property Get read_AUTO_CNTR_RESE1
        read
        read_AUTO_CNTR_RESE1 = read_AUTO_CNTR_RESE1_value
    End Property

    Property Let write_AUTO_CNTR_RESE1(aData)
        set_AUTO_CNTR_RESE1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SATU_CNTR_mask = &H1
        if data_low > LONG_MAX then
            if SATU_CNTR_mask = mask then
                read_SATU_CNTR_value = data_low
            else
                read_SATU_CNTR_value = (data_low - H8000_0000) and SATU_CNTR_mask
            end If
        else
            read_SATU_CNTR_value = data_low and SATU_CNTR_mask
        end If
        read_AUTO_CNTR_RESE1_value = rightShift(data_low, 1) and &H1

    End Sub

    Sub write
        If flag_SATU_CNTR = &H0 or flag_AUTO_CNTR_RESE1 = &H0 Then read
        If flag_SATU_CNTR = &H0 Then write_SATU_CNTR_value = get_SATU_CNTR
        If flag_AUTO_CNTR_RESE1 = &H0 Then write_AUTO_CNTR_RESE1_value = get_AUTO_CNTR_RESE1

        regValue = leftShift((write_SATU_CNTR_value and &H1), 0) + leftShift((write_AUTO_CNTR_RESE1_value and &H1), 1)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SATU_CNTR_mask = &H1
        if data_low > LONG_MAX then
            if SATU_CNTR_mask = mask then
                read_SATU_CNTR_value = data_low
            else
                read_SATU_CNTR_value = (data_low - H8000_0000) and SATU_CNTR_mask
            end If
        else
            read_SATU_CNTR_value = data_low and SATU_CNTR_mask
        end If
        read_AUTO_CNTR_RESE1_value = rightShift(data_low, 1) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SATU_CNTR_value = &H0
        flag_SATU_CNTR        = &H0
        write_AUTO_CNTR_RESE1_value = &H0
        flag_AUTO_CNTR_RESE1        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_165S_32_BRCM_EIP_165_GENERAL_eip165_version
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' EIP_NUMBER                                 [7:0]            get_EIP_NUMBER
''                                                             set_EIP_NUMBER
''                                                             read_EIP_NUMBER
''                                                             write_EIP_NUMBER
''---------------------------------------------------------------------------------
'' ENC                                        [15:8]           get_ENC
''                                                             set_ENC
''                                                             read_ENC
''                                                             write_ENC
''---------------------------------------------------------------------------------
'' PATCH_LEVEL                                [19:16]          get_PATCH_LEVEL
''                                                             set_PATCH_LEVEL
''                                                             read_PATCH_LEVEL
''                                                             write_PATCH_LEVEL
''---------------------------------------------------------------------------------
'' MINO_VERS                                  [23:20]          get_MINO_VERS
''                                                             set_MINO_VERS
''                                                             read_MINO_VERS
''                                                             write_MINO_VERS
''---------------------------------------------------------------------------------
'' MAJO_VERS                                  [27:24]          get_MAJO_VERS
''                                                             set_MAJO_VERS
''                                                             read_MAJO_VERS
''                                                             write_MAJO_VERS
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_165S_32_BRCM_EIP_165_GENERAL_eip165_version
    Private write_EIP_NUMBER_value
    Private read_EIP_NUMBER_value
    Private flag_EIP_NUMBER
    Private write_ENC_value
    Private read_ENC_value
    Private flag_ENC
    Private write_PATCH_LEVEL_value
    Private read_PATCH_LEVEL_value
    Private flag_PATCH_LEVEL
    Private write_MINO_VERS_value
    Private read_MINO_VERS_value
    Private flag_MINO_VERS
    Private write_MAJO_VERS_value
    Private read_MAJO_VERS_value
    Private flag_MAJO_VERS

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H20ffc
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_EIP_NUMBER
        get_EIP_NUMBER = read_EIP_NUMBER_value
    End Property

    Property Let set_EIP_NUMBER(aData)
        write_EIP_NUMBER_value = aData
        flag_EIP_NUMBER        = &H1
    End Property

    Property Get read_EIP_NUMBER
        read
        read_EIP_NUMBER = read_EIP_NUMBER_value
    End Property

    Property Let write_EIP_NUMBER(aData)
        set_EIP_NUMBER = aData
        write
    End Property

    Property Get get_ENC
        get_ENC = read_ENC_value
    End Property

    Property Let set_ENC(aData)
        write_ENC_value = aData
        flag_ENC        = &H1
    End Property

    Property Get read_ENC
        read
        read_ENC = read_ENC_value
    End Property

    Property Let write_ENC(aData)
        set_ENC = aData
        write
    End Property

    Property Get get_PATCH_LEVEL
        get_PATCH_LEVEL = read_PATCH_LEVEL_value
    End Property

    Property Let set_PATCH_LEVEL(aData)
        write_PATCH_LEVEL_value = aData
        flag_PATCH_LEVEL        = &H1
    End Property

    Property Get read_PATCH_LEVEL
        read
        read_PATCH_LEVEL = read_PATCH_LEVEL_value
    End Property

    Property Let write_PATCH_LEVEL(aData)
        set_PATCH_LEVEL = aData
        write
    End Property

    Property Get get_MINO_VERS
        get_MINO_VERS = read_MINO_VERS_value
    End Property

    Property Let set_MINO_VERS(aData)
        write_MINO_VERS_value = aData
        flag_MINO_VERS        = &H1
    End Property

    Property Get read_MINO_VERS
        read
        read_MINO_VERS = read_MINO_VERS_value
    End Property

    Property Let write_MINO_VERS(aData)
        set_MINO_VERS = aData
        write
    End Property

    Property Get get_MAJO_VERS
        get_MAJO_VERS = read_MAJO_VERS_value
    End Property

    Property Let set_MAJO_VERS(aData)
        write_MAJO_VERS_value = aData
        flag_MAJO_VERS        = &H1
    End Property

    Property Get read_MAJO_VERS
        read
        read_MAJO_VERS = read_MAJO_VERS_value
    End Property

    Property Let write_MAJO_VERS(aData)
        set_MAJO_VERS = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        EIP_NUMBER_mask = &Hff
        if data_low > LONG_MAX then
            if EIP_NUMBER_mask = mask then
                read_EIP_NUMBER_value = data_low
            else
                read_EIP_NUMBER_value = (data_low - H8000_0000) and EIP_NUMBER_mask
            end If
        else
            read_EIP_NUMBER_value = data_low and EIP_NUMBER_mask
        end If
        read_ENC_value = rightShift(data_low, 8) and &Hff
        read_PATCH_LEVEL_value = rightShift(data_low, 16) and &Hf
        read_MINO_VERS_value = rightShift(data_low, 20) and &Hf
        read_MAJO_VERS_value = rightShift(data_low, 24) and &Hf

    End Sub

    Sub write
        If flag_EIP_NUMBER = &H0 or flag_ENC = &H0 or flag_PATCH_LEVEL = &H0 or flag_MINO_VERS = &H0 or flag_MAJO_VERS = &H0 Then read
        If flag_EIP_NUMBER = &H0 Then write_EIP_NUMBER_value = get_EIP_NUMBER
        If flag_ENC = &H0 Then write_ENC_value = get_ENC
        If flag_PATCH_LEVEL = &H0 Then write_PATCH_LEVEL_value = get_PATCH_LEVEL
        If flag_MINO_VERS = &H0 Then write_MINO_VERS_value = get_MINO_VERS
        If flag_MAJO_VERS = &H0 Then write_MAJO_VERS_value = get_MAJO_VERS

        regValue = leftShift((write_EIP_NUMBER_value and &Hff), 0) + leftShift((write_ENC_value and &Hff), 8) + leftShift((write_PATCH_LEVEL_value and &Hf), 16) + leftShift((write_MINO_VERS_value and &Hf), 20) + leftShift((write_MAJO_VERS_value and &Hf), 24)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        EIP_NUMBER_mask = &Hff
        if data_low > LONG_MAX then
            if EIP_NUMBER_mask = mask then
                read_EIP_NUMBER_value = data_low
            else
                read_EIP_NUMBER_value = (data_low - H8000_0000) and EIP_NUMBER_mask
            end If
        else
            read_EIP_NUMBER_value = data_low and EIP_NUMBER_mask
        end If
        read_ENC_value = rightShift(data_low, 8) and &Hff
        read_PATCH_LEVEL_value = rightShift(data_low, 16) and &Hf
        read_MINO_VERS_value = rightShift(data_low, 20) and &Hf
        read_MAJO_VERS_value = rightShift(data_low, 24) and &Hf

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_EIP_NUMBER_value = &H0
        flag_EIP_NUMBER        = &H0
        write_ENC_value = &H0
        flag_ENC        = &H0
        write_PATCH_LEVEL_value = &H0
        flag_PATCH_LEVEL        = &H0
        write_MINO_VERS_value = &H0
        flag_MINO_VERS        = &H0
        write_MAJO_VERS_value = &H0
        flag_MAJO_VERS        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class EIP165S_EIP_165S_32_BRCM_EIP_165_GENERAL_INSTANCE

    Public eip165_debug
    Public eip165_options
    Public eip165_version


    Public default function Init(aBaseAddr)
        Set eip165_debug = (New REGISTER_EIP165S_EIP_165S_32_BRCM_EIP_165_GENERAL_eip165_debug)(aBaseAddr, 32)
        Set eip165_options = (New REGISTER_EIP165S_EIP_165S_32_BRCM_EIP_165_GENERAL_eip165_options)(aBaseAddr, 32)
        Set eip165_version = (New REGISTER_EIP165S_EIP_165S_32_BRCM_EIP_165_GENERAL_eip165_version)(aBaseAddr, 32)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set EIP165S_EIP_165S_32_BRCM_EIP_165_GENERAL = CreateObject("System.Collections.ArrayList")
EIP165S_EIP_165S_32_BRCM_EIP_165_GENERAL.Add ((New EIP165S_EIP_165S_32_BRCM_EIP_165_GENERAL_INSTANCE)(&H4d010000))
EIP165S_EIP_165S_32_BRCM_EIP_165_GENERAL.Add ((New EIP165S_EIP_165S_32_BRCM_EIP_165_GENERAL_INSTANCE)(&H4d110000))
EIP165S_EIP_165S_32_BRCM_EIP_165_GENERAL.Add ((New EIP165S_EIP_165S_32_BRCM_EIP_165_GENERAL_INSTANCE)(&H4d210000))
EIP165S_EIP_165S_32_BRCM_EIP_165_GENERAL.Add ((New EIP165S_EIP_165S_32_BRCM_EIP_165_GENERAL_INSTANCE)(&H4d310000))
EIP165S_EIP_165S_32_BRCM_EIP_165_GENERAL.Add ((New EIP165S_EIP_165S_32_BRCM_EIP_165_GENERAL_INSTANCE)(&H4d410000))
EIP165S_EIP_165S_32_BRCM_EIP_165_GENERAL.Add ((New EIP165S_EIP_165S_32_BRCM_EIP_165_GENERAL_INSTANCE)(&H4d510000))


