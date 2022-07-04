

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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_OPTIONS_VERSION_tcam_count_options2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' NUM_TCAM                                   [13:0]           get_NUM_TCAM
''                                                             set_NUM_TCAM
''                                                             read_NUM_TCAM
''                                                             write_NUM_TCAM
''---------------------------------------------------------------------------------
'' DW                                         [23:16]          get_DW
''                                                             set_DW
''                                                             read_DW
''                                                             write_DW
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_OPTIONS_VERSION_tcam_count_options2
    Private write_NUM_TCAM_value
    Private read_NUM_TCAM_value
    Private flag_NUM_TCAM
    Private write_DW_value
    Private read_DW_value
    Private flag_DW

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H44f4
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_NUM_TCAM
        get_NUM_TCAM = read_NUM_TCAM_value
    End Property

    Property Let set_NUM_TCAM(aData)
        write_NUM_TCAM_value = aData
        flag_NUM_TCAM        = &H1
    End Property

    Property Get read_NUM_TCAM
        read
        read_NUM_TCAM = read_NUM_TCAM_value
    End Property

    Property Let write_NUM_TCAM(aData)
        set_NUM_TCAM = aData
        write
    End Property

    Property Get get_DW
        get_DW = read_DW_value
    End Property

    Property Let set_DW(aData)
        write_DW_value = aData
        flag_DW        = &H1
    End Property

    Property Get read_DW
        read
        read_DW = read_DW_value
    End Property

    Property Let write_DW(aData)
        set_DW = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        NUM_TCAM_mask = &H3fff
        if data_low > LONG_MAX then
            if NUM_TCAM_mask = mask then
                read_NUM_TCAM_value = data_low
            else
                read_NUM_TCAM_value = (data_low - H8000_0000) and NUM_TCAM_mask
            end If
        else
            read_NUM_TCAM_value = data_low and NUM_TCAM_mask
        end If
        read_DW_value = rightShift(data_low, 16) and &Hff

    End Sub

    Sub write
        If flag_NUM_TCAM = &H0 or flag_DW = &H0 Then read
        If flag_NUM_TCAM = &H0 Then write_NUM_TCAM_value = get_NUM_TCAM
        If flag_DW = &H0 Then write_DW_value = get_DW

        regValue = leftShift((write_NUM_TCAM_value and &H3fff), 0) + leftShift((write_DW_value and &Hff), 16)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        NUM_TCAM_mask = &H3fff
        if data_low > LONG_MAX then
            if NUM_TCAM_mask = mask then
                read_NUM_TCAM_value = data_low
            else
                read_NUM_TCAM_value = (data_low - H8000_0000) and NUM_TCAM_mask
            end If
        else
            read_NUM_TCAM_value = data_low and NUM_TCAM_mask
        end If
        read_DW_value = rightShift(data_low, 16) and &Hff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_NUM_TCAM_value = &H0
        flag_NUM_TCAM        = &H0
        write_DW_value = &H0
        flag_DW        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_OPTIONS_VERSION_tcam_count_options
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' NTPC                                       [4:0]            get_NTPC
''                                                             set_NTPC
''                                                             read_NTPC
''                                                             write_NTPC
''---------------------------------------------------------------------------------
'' NTOC                                       [7:5]            get_NTOC
''                                                             set_NTOC
''                                                             read_NTOC
''                                                             write_NTOC
''---------------------------------------------------------------------------------
'' NGPC                                       [12:8]           get_NGPC
''                                                             set_NGPC
''                                                             read_NGPC
''                                                             write_NGPC
''---------------------------------------------------------------------------------
'' NGOC                                       [15:13]          get_NGOC
''                                                             set_NGOC
''                                                             read_NGOC
''                                                             write_NGOC
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_OPTIONS_VERSION_tcam_count_options
    Private write_NTPC_value
    Private read_NTPC_value
    Private flag_NTPC
    Private write_NTOC_value
    Private read_NTOC_value
    Private flag_NTOC
    Private write_NGPC_value
    Private read_NGPC_value
    Private flag_NGPC
    Private write_NGOC_value
    Private read_NGOC_value
    Private flag_NGOC

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H44f8
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_NTPC
        get_NTPC = read_NTPC_value
    End Property

    Property Let set_NTPC(aData)
        write_NTPC_value = aData
        flag_NTPC        = &H1
    End Property

    Property Get read_NTPC
        read
        read_NTPC = read_NTPC_value
    End Property

    Property Let write_NTPC(aData)
        set_NTPC = aData
        write
    End Property

    Property Get get_NTOC
        get_NTOC = read_NTOC_value
    End Property

    Property Let set_NTOC(aData)
        write_NTOC_value = aData
        flag_NTOC        = &H1
    End Property

    Property Get read_NTOC
        read
        read_NTOC = read_NTOC_value
    End Property

    Property Let write_NTOC(aData)
        set_NTOC = aData
        write
    End Property

    Property Get get_NGPC
        get_NGPC = read_NGPC_value
    End Property

    Property Let set_NGPC(aData)
        write_NGPC_value = aData
        flag_NGPC        = &H1
    End Property

    Property Get read_NGPC
        read
        read_NGPC = read_NGPC_value
    End Property

    Property Let write_NGPC(aData)
        set_NGPC = aData
        write
    End Property

    Property Get get_NGOC
        get_NGOC = read_NGOC_value
    End Property

    Property Let set_NGOC(aData)
        write_NGOC_value = aData
        flag_NGOC        = &H1
    End Property

    Property Get read_NGOC
        read
        read_NGOC = read_NGOC_value
    End Property

    Property Let write_NGOC(aData)
        set_NGOC = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        NTPC_mask = &H1f
        if data_low > LONG_MAX then
            if NTPC_mask = mask then
                read_NTPC_value = data_low
            else
                read_NTPC_value = (data_low - H8000_0000) and NTPC_mask
            end If
        else
            read_NTPC_value = data_low and NTPC_mask
        end If
        read_NTOC_value = rightShift(data_low, 5) and &H7
        read_NGPC_value = rightShift(data_low, 8) and &H1f
        read_NGOC_value = rightShift(data_low, 13) and &H7

    End Sub

    Sub write
        If flag_NTPC = &H0 or flag_NTOC = &H0 or flag_NGPC = &H0 or flag_NGOC = &H0 Then read
        If flag_NTPC = &H0 Then write_NTPC_value = get_NTPC
        If flag_NTOC = &H0 Then write_NTOC_value = get_NTOC
        If flag_NGPC = &H0 Then write_NGPC_value = get_NGPC
        If flag_NGOC = &H0 Then write_NGOC_value = get_NGOC

        regValue = leftShift((write_NTPC_value and &H1f), 0) + leftShift((write_NTOC_value and &H7), 5) + leftShift((write_NGPC_value and &H1f), 8) + leftShift((write_NGOC_value and &H7), 13)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        NTPC_mask = &H1f
        if data_low > LONG_MAX then
            if NTPC_mask = mask then
                read_NTPC_value = data_low
            else
                read_NTPC_value = (data_low - H8000_0000) and NTPC_mask
            end If
        else
            read_NTPC_value = data_low and NTPC_mask
        end If
        read_NTOC_value = rightShift(data_low, 5) and &H7
        read_NGPC_value = rightShift(data_low, 8) and &H1f
        read_NGOC_value = rightShift(data_low, 13) and &H7

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_NTPC_value = &H0
        flag_NTPC        = &H0
        write_NTOC_value = &H0
        flag_NTOC        = &H0
        write_NGPC_value = &H0
        flag_NGPC        = &H0
        write_NGOC_value = &H0
        flag_NGOC        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_OPTIONS_VERSION_tcam_count_version
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_OPTIONS_VERSION_tcam_count_version
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
        offset = &H44fc
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

Class EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_OPTIONS_VERSION_INSTANCE

    Public tcam_count_options2
    Public tcam_count_options
    Public tcam_count_version


    Public default function Init(aBaseAddr)
        Set tcam_count_options2 = (New REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_OPTIONS_VERSION_tcam_count_options2)(aBaseAddr, 32)
        Set tcam_count_options = (New REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_OPTIONS_VERSION_tcam_count_options)(aBaseAddr, 32)
        Set tcam_count_version = (New REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_OPTIONS_VERSION_tcam_count_version)(aBaseAddr, 32)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_OPTIONS_VERSION = CreateObject("System.Collections.ArrayList")
EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_OPTIONS_VERSION.Add ((New EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_OPTIONS_VERSION_INSTANCE)(&H4d010000))
EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_OPTIONS_VERSION.Add ((New EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_OPTIONS_VERSION_INSTANCE)(&H4d110000))
EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_OPTIONS_VERSION.Add ((New EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_OPTIONS_VERSION_INSTANCE)(&H4d210000))
EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_OPTIONS_VERSION.Add ((New EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_OPTIONS_VERSION_INSTANCE)(&H4d310000))
EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_OPTIONS_VERSION.Add ((New EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_OPTIONS_VERSION_INSTANCE)(&H4d410000))
EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_OPTIONS_VERSION.Add ((New EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_OPTIONS_VERSION_INSTANCE)(&H4d510000))


