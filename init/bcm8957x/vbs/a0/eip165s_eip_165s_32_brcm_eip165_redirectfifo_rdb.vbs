

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


'' @REGISTER : EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO_redir_debug_ctrl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TRUNCATE_EN                                [0:0]            get_TRUNCATE_EN
''                                                             set_TRUNCATE_EN
''                                                             read_TRUNCATE_EN
''                                                             write_TRUNCATE_EN
''---------------------------------------------------------------------------------
'' HEAD_DROP                                  [1:1]            get_HEAD_DROP
''                                                             set_HEAD_DROP
''                                                             read_HEAD_DROP
''                                                             write_HEAD_DROP
''---------------------------------------------------------------------------------
'' MAX_FRM_SIZE                               [8:2]            get_MAX_FRM_SIZE
''                                                             set_MAX_FRM_SIZE
''                                                             read_MAX_FRM_SIZE
''                                                             write_MAX_FRM_SIZE
''---------------------------------------------------------------------------------
'' input_en                                   [9:9]            get_input_en
''                                                             set_input_en
''                                                             read_input_en
''                                                             write_input_en
''---------------------------------------------------------------------------------
'' OUTPUT_EN                                  [10:10]          get_OUTPUT_EN
''                                                             set_OUTPUT_EN
''                                                             read_OUTPUT_EN
''                                                             write_OUTPUT_EN
''---------------------------------------------------------------------------------
'' INPUT_STOPS                                [11:11]          get_INPUT_STOPS
''                                                             set_INPUT_STOPS
''                                                             read_INPUT_STOPS
''                                                             write_INPUT_STOPS
''---------------------------------------------------------------------------------
'' OUTPUT_STOPS                               [12:12]          get_OUTPUT_STOPS
''                                                             set_OUTPUT_STOPS
''                                                             read_OUTPUT_STOPS
''                                                             write_OUTPUT_STOPS
''---------------------------------------------------------------------------------
'' full                                       [16:16]          get_full
''                                                             set_full
''                                                             read_full
''                                                             write_full
''---------------------------------------------------------------------------------
'' WRIT_POIN                                  [24:18]          get_WRIT_POIN
''                                                             set_WRIT_POIN
''                                                             read_WRIT_POIN
''                                                             write_WRIT_POIN
''---------------------------------------------------------------------------------
'' READ_POINTER                               [31:25]          get_READ_POINTER
''                                                             set_READ_POINTER
''                                                             read_READ_POINTER
''                                                             write_READ_POINTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO_redir_debug_ctrl
    Private write_TRUNCATE_EN_value
    Private read_TRUNCATE_EN_value
    Private flag_TRUNCATE_EN
    Private write_HEAD_DROP_value
    Private read_HEAD_DROP_value
    Private flag_HEAD_DROP
    Private write_MAX_FRM_SIZE_value
    Private read_MAX_FRM_SIZE_value
    Private flag_MAX_FRM_SIZE
    Private write_input_en_value
    Private read_input_en_value
    Private flag_input_en
    Private write_OUTPUT_EN_value
    Private read_OUTPUT_EN_value
    Private flag_OUTPUT_EN
    Private write_INPUT_STOPS_value
    Private read_INPUT_STOPS_value
    Private flag_INPUT_STOPS
    Private write_OUTPUT_STOPS_value
    Private read_OUTPUT_STOPS_value
    Private flag_OUTPUT_STOPS
    Private write_full_value
    Private read_full_value
    Private flag_full
    Private write_WRIT_POIN_value
    Private read_WRIT_POIN_value
    Private flag_WRIT_POIN
    Private write_READ_POINTER_value
    Private read_READ_POINTER_value
    Private flag_READ_POINTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H20a00
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_TRUNCATE_EN
        get_TRUNCATE_EN = read_TRUNCATE_EN_value
    End Property

    Property Let set_TRUNCATE_EN(aData)
        write_TRUNCATE_EN_value = aData
        flag_TRUNCATE_EN        = &H1
    End Property

    Property Get read_TRUNCATE_EN
        read
        read_TRUNCATE_EN = read_TRUNCATE_EN_value
    End Property

    Property Let write_TRUNCATE_EN(aData)
        set_TRUNCATE_EN = aData
        write
    End Property

    Property Get get_HEAD_DROP
        get_HEAD_DROP = read_HEAD_DROP_value
    End Property

    Property Let set_HEAD_DROP(aData)
        write_HEAD_DROP_value = aData
        flag_HEAD_DROP        = &H1
    End Property

    Property Get read_HEAD_DROP
        read
        read_HEAD_DROP = read_HEAD_DROP_value
    End Property

    Property Let write_HEAD_DROP(aData)
        set_HEAD_DROP = aData
        write
    End Property

    Property Get get_MAX_FRM_SIZE
        get_MAX_FRM_SIZE = read_MAX_FRM_SIZE_value
    End Property

    Property Let set_MAX_FRM_SIZE(aData)
        write_MAX_FRM_SIZE_value = aData
        flag_MAX_FRM_SIZE        = &H1
    End Property

    Property Get read_MAX_FRM_SIZE
        read
        read_MAX_FRM_SIZE = read_MAX_FRM_SIZE_value
    End Property

    Property Let write_MAX_FRM_SIZE(aData)
        set_MAX_FRM_SIZE = aData
        write
    End Property

    Property Get get_input_en
        get_input_en = read_input_en_value
    End Property

    Property Let set_input_en(aData)
        write_input_en_value = aData
        flag_input_en        = &H1
    End Property

    Property Get read_input_en
        read
        read_input_en = read_input_en_value
    End Property

    Property Let write_input_en(aData)
        set_input_en = aData
        write
    End Property

    Property Get get_OUTPUT_EN
        get_OUTPUT_EN = read_OUTPUT_EN_value
    End Property

    Property Let set_OUTPUT_EN(aData)
        write_OUTPUT_EN_value = aData
        flag_OUTPUT_EN        = &H1
    End Property

    Property Get read_OUTPUT_EN
        read
        read_OUTPUT_EN = read_OUTPUT_EN_value
    End Property

    Property Let write_OUTPUT_EN(aData)
        set_OUTPUT_EN = aData
        write
    End Property

    Property Get get_INPUT_STOPS
        get_INPUT_STOPS = read_INPUT_STOPS_value
    End Property

    Property Let set_INPUT_STOPS(aData)
        write_INPUT_STOPS_value = aData
        flag_INPUT_STOPS        = &H1
    End Property

    Property Get read_INPUT_STOPS
        read
        read_INPUT_STOPS = read_INPUT_STOPS_value
    End Property

    Property Let write_INPUT_STOPS(aData)
        set_INPUT_STOPS = aData
        write
    End Property

    Property Get get_OUTPUT_STOPS
        get_OUTPUT_STOPS = read_OUTPUT_STOPS_value
    End Property

    Property Let set_OUTPUT_STOPS(aData)
        write_OUTPUT_STOPS_value = aData
        flag_OUTPUT_STOPS        = &H1
    End Property

    Property Get read_OUTPUT_STOPS
        read
        read_OUTPUT_STOPS = read_OUTPUT_STOPS_value
    End Property

    Property Let write_OUTPUT_STOPS(aData)
        set_OUTPUT_STOPS = aData
        write
    End Property

    Property Get get_full
        get_full = read_full_value
    End Property

    Property Let set_full(aData)
        write_full_value = aData
        flag_full        = &H1
    End Property

    Property Get read_full
        read
        read_full = read_full_value
    End Property

    Property Let write_full(aData)
        set_full = aData
        write
    End Property

    Property Get get_WRIT_POIN
        get_WRIT_POIN = read_WRIT_POIN_value
    End Property

    Property Let set_WRIT_POIN(aData)
        write_WRIT_POIN_value = aData
        flag_WRIT_POIN        = &H1
    End Property

    Property Get read_WRIT_POIN
        read
        read_WRIT_POIN = read_WRIT_POIN_value
    End Property

    Property Let write_WRIT_POIN(aData)
        set_WRIT_POIN = aData
        write
    End Property

    Property Get get_READ_POINTER
        get_READ_POINTER = read_READ_POINTER_value
    End Property

    Property Let set_READ_POINTER(aData)
        write_READ_POINTER_value = aData
        flag_READ_POINTER        = &H1
    End Property

    Property Get read_READ_POINTER
        read
        read_READ_POINTER = read_READ_POINTER_value
    End Property

    Property Let write_READ_POINTER(aData)
        set_READ_POINTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TRUNCATE_EN_mask = &H1
        if data_low > LONG_MAX then
            if TRUNCATE_EN_mask = mask then
                read_TRUNCATE_EN_value = data_low
            else
                read_TRUNCATE_EN_value = (data_low - H8000_0000) and TRUNCATE_EN_mask
            end If
        else
            read_TRUNCATE_EN_value = data_low and TRUNCATE_EN_mask
        end If
        read_HEAD_DROP_value = rightShift(data_low, 1) and &H1
        read_MAX_FRM_SIZE_value = rightShift(data_low, 2) and &H7f
        read_input_en_value = rightShift(data_low, 9) and &H1
        read_OUTPUT_EN_value = rightShift(data_low, 10) and &H1
        read_INPUT_STOPS_value = rightShift(data_low, 11) and &H1
        read_OUTPUT_STOPS_value = rightShift(data_low, 12) and &H1
        read_full_value = rightShift(data_low, 16) and &H1
        read_WRIT_POIN_value = rightShift(data_low, 18) and &H7f
        read_READ_POINTER_value = rightShift(data_low, 25) and &H7f

    End Sub

    Sub write
        If flag_TRUNCATE_EN = &H0 or flag_HEAD_DROP = &H0 or flag_MAX_FRM_SIZE = &H0 or flag_input_en = &H0 or flag_OUTPUT_EN = &H0 or flag_INPUT_STOPS = &H0 or flag_OUTPUT_STOPS = &H0 or flag_full = &H0 or flag_WRIT_POIN = &H0 or flag_READ_POINTER = &H0 Then read
        If flag_TRUNCATE_EN = &H0 Then write_TRUNCATE_EN_value = get_TRUNCATE_EN
        If flag_HEAD_DROP = &H0 Then write_HEAD_DROP_value = get_HEAD_DROP
        If flag_MAX_FRM_SIZE = &H0 Then write_MAX_FRM_SIZE_value = get_MAX_FRM_SIZE
        If flag_input_en = &H0 Then write_input_en_value = get_input_en
        If flag_OUTPUT_EN = &H0 Then write_OUTPUT_EN_value = get_OUTPUT_EN
        If flag_INPUT_STOPS = &H0 Then write_INPUT_STOPS_value = get_INPUT_STOPS
        If flag_OUTPUT_STOPS = &H0 Then write_OUTPUT_STOPS_value = get_OUTPUT_STOPS
        If flag_full = &H0 Then write_full_value = get_full
        If flag_WRIT_POIN = &H0 Then write_WRIT_POIN_value = get_WRIT_POIN
        If flag_READ_POINTER = &H0 Then write_READ_POINTER_value = get_READ_POINTER

        regValue = leftShift((write_TRUNCATE_EN_value and &H1), 0) + leftShift((write_HEAD_DROP_value and &H1), 1) + leftShift((write_MAX_FRM_SIZE_value and &H7f), 2) + leftShift((write_input_en_value and &H1), 9) + leftShift((write_OUTPUT_EN_value and &H1), 10) + leftShift((write_INPUT_STOPS_value and &H1), 11) + leftShift((write_OUTPUT_STOPS_value and &H1), 12) + leftShift((write_full_value and &H1), 16) + leftShift((write_WRIT_POIN_value and &H7f), 18) + leftShift((write_READ_POINTER_value and &H7f), 25)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TRUNCATE_EN_mask = &H1
        if data_low > LONG_MAX then
            if TRUNCATE_EN_mask = mask then
                read_TRUNCATE_EN_value = data_low
            else
                read_TRUNCATE_EN_value = (data_low - H8000_0000) and TRUNCATE_EN_mask
            end If
        else
            read_TRUNCATE_EN_value = data_low and TRUNCATE_EN_mask
        end If
        read_HEAD_DROP_value = rightShift(data_low, 1) and &H1
        read_MAX_FRM_SIZE_value = rightShift(data_low, 2) and &H7f
        read_input_en_value = rightShift(data_low, 9) and &H1
        read_OUTPUT_EN_value = rightShift(data_low, 10) and &H1
        read_INPUT_STOPS_value = rightShift(data_low, 11) and &H1
        read_OUTPUT_STOPS_value = rightShift(data_low, 12) and &H1
        read_full_value = rightShift(data_low, 16) and &H1
        read_WRIT_POIN_value = rightShift(data_low, 18) and &H7f
        read_READ_POINTER_value = rightShift(data_low, 25) and &H7f

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TRUNCATE_EN_value = &H0
        flag_TRUNCATE_EN        = &H0
        write_HEAD_DROP_value = &H0
        flag_HEAD_DROP        = &H0
        write_MAX_FRM_SIZE_value = &H0
        flag_MAX_FRM_SIZE        = &H0
        write_input_en_value = &H0
        flag_input_en        = &H0
        write_OUTPUT_EN_value = &H0
        flag_OUTPUT_EN        = &H0
        write_INPUT_STOPS_value = &H0
        flag_INPUT_STOPS        = &H0
        write_OUTPUT_STOPS_value = &H0
        flag_OUTPUT_STOPS        = &H0
        write_full_value = &H0
        flag_full        = &H0
        write_WRIT_POIN_value = &H0
        flag_WRIT_POIN        = &H0
        write_READ_POINTER_value = &H0
        flag_READ_POINTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO_redir_debug_depth
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MAX_COUNT                                  [8:3]            get_MAX_COUNT
''                                                             set_MAX_COUNT
''                                                             read_MAX_COUNT
''                                                             write_MAX_COUNT
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO_redir_debug_depth
    Private write_MAX_COUNT_value
    Private read_MAX_COUNT_value
    Private flag_MAX_COUNT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H20a04
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MAX_COUNT
        get_MAX_COUNT = read_MAX_COUNT_value
    End Property

    Property Let set_MAX_COUNT(aData)
        write_MAX_COUNT_value = aData
        flag_MAX_COUNT        = &H1
    End Property

    Property Get read_MAX_COUNT
        read
        read_MAX_COUNT = read_MAX_COUNT_value
    End Property

    Property Let write_MAX_COUNT(aData)
        set_MAX_COUNT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_MAX_COUNT_value = rightShift(data_low, 3) and &H3f

    End Sub

    Sub write
        If flag_MAX_COUNT = &H0 Then read
        If flag_MAX_COUNT = &H0 Then write_MAX_COUNT_value = get_MAX_COUNT

        regValue = leftShift((write_MAX_COUNT_value and &H3f), 3)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_MAX_COUNT_value = rightShift(data_low, 3) and &H3f

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MAX_COUNT_value = &H0
        flag_MAX_COUNT        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO_redir_debug_nosa_ctr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DROP_FRAM                                  [7:0]            get_DROP_FRAM
''                                                             set_DROP_FRAM
''                                                             read_DROP_FRAM
''                                                             write_DROP_FRAM
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO_redir_debug_nosa_ctr
    Private write_DROP_FRAM_value
    Private read_DROP_FRAM_value
    Private flag_DROP_FRAM

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H20a3c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_DROP_FRAM
        get_DROP_FRAM = read_DROP_FRAM_value
    End Property

    Property Let set_DROP_FRAM(aData)
        write_DROP_FRAM_value = aData
        flag_DROP_FRAM        = &H1
    End Property

    Property Get read_DROP_FRAM
        read
        read_DROP_FRAM = read_DROP_FRAM_value
    End Property

    Property Let write_DROP_FRAM(aData)
        set_DROP_FRAM = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DROP_FRAM_mask = &Hff
        if data_low > LONG_MAX then
            if DROP_FRAM_mask = mask then
                read_DROP_FRAM_value = data_low
            else
                read_DROP_FRAM_value = (data_low - H8000_0000) and DROP_FRAM_mask
            end If
        else
            read_DROP_FRAM_value = data_low and DROP_FRAM_mask
        end If

    End Sub

    Sub write
        If flag_DROP_FRAM = &H0 Then read
        If flag_DROP_FRAM = &H0 Then write_DROP_FRAM_value = get_DROP_FRAM

        regValue = leftShift((write_DROP_FRAM_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DROP_FRAM_mask = &Hff
        if data_low > LONG_MAX then
            if DROP_FRAM_mask = mask then
                read_DROP_FRAM_value = data_low
            else
                read_DROP_FRAM_value = (data_low - H8000_0000) and DROP_FRAM_mask
            end If
        else
            read_DROP_FRAM_value = data_low and DROP_FRAM_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DROP_FRAM_value = &H0
        flag_DROP_FRAM        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO_redir_debug_sa_0_ctr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DROP_FRAM                                  [7:0]            get_DROP_FRAM
''                                                             set_DROP_FRAM
''                                                             read_DROP_FRAM
''                                                             write_DROP_FRAM
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO_redir_debug_sa_0_ctr
    Private write_DROP_FRAM_value
    Private read_DROP_FRAM_value
    Private flag_DROP_FRAM

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H20a40
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_DROP_FRAM
        get_DROP_FRAM = read_DROP_FRAM_value
    End Property

    Property Let set_DROP_FRAM(aData)
        write_DROP_FRAM_value = aData
        flag_DROP_FRAM        = &H1
    End Property

    Property Get read_DROP_FRAM
        read
        read_DROP_FRAM = read_DROP_FRAM_value
    End Property

    Property Let write_DROP_FRAM(aData)
        set_DROP_FRAM = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DROP_FRAM_mask = &Hff
        if data_low > LONG_MAX then
            if DROP_FRAM_mask = mask then
                read_DROP_FRAM_value = data_low
            else
                read_DROP_FRAM_value = (data_low - H8000_0000) and DROP_FRAM_mask
            end If
        else
            read_DROP_FRAM_value = data_low and DROP_FRAM_mask
        end If

    End Sub

    Sub write
        If flag_DROP_FRAM = &H0 Then read
        If flag_DROP_FRAM = &H0 Then write_DROP_FRAM_value = get_DROP_FRAM

        regValue = leftShift((write_DROP_FRAM_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DROP_FRAM_mask = &Hff
        if data_low > LONG_MAX then
            if DROP_FRAM_mask = mask then
                read_DROP_FRAM_value = data_low
            else
                read_DROP_FRAM_value = (data_low - H8000_0000) and DROP_FRAM_mask
            end If
        else
            read_DROP_FRAM_value = data_low and DROP_FRAM_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DROP_FRAM_value = &H0
        flag_DROP_FRAM        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO_redir_debug_sa_1_ctr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DROP_FRAM                                  [7:0]            get_DROP_FRAM
''                                                             set_DROP_FRAM
''                                                             read_DROP_FRAM
''                                                             write_DROP_FRAM
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO_redir_debug_sa_1_ctr
    Private write_DROP_FRAM_value
    Private read_DROP_FRAM_value
    Private flag_DROP_FRAM

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H20a44
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_DROP_FRAM
        get_DROP_FRAM = read_DROP_FRAM_value
    End Property

    Property Let set_DROP_FRAM(aData)
        write_DROP_FRAM_value = aData
        flag_DROP_FRAM        = &H1
    End Property

    Property Get read_DROP_FRAM
        read
        read_DROP_FRAM = read_DROP_FRAM_value
    End Property

    Property Let write_DROP_FRAM(aData)
        set_DROP_FRAM = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DROP_FRAM_mask = &Hff
        if data_low > LONG_MAX then
            if DROP_FRAM_mask = mask then
                read_DROP_FRAM_value = data_low
            else
                read_DROP_FRAM_value = (data_low - H8000_0000) and DROP_FRAM_mask
            end If
        else
            read_DROP_FRAM_value = data_low and DROP_FRAM_mask
        end If

    End Sub

    Sub write
        If flag_DROP_FRAM = &H0 Then read
        If flag_DROP_FRAM = &H0 Then write_DROP_FRAM_value = get_DROP_FRAM

        regValue = leftShift((write_DROP_FRAM_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DROP_FRAM_mask = &Hff
        if data_low > LONG_MAX then
            if DROP_FRAM_mask = mask then
                read_DROP_FRAM_value = data_low
            else
                read_DROP_FRAM_value = (data_low - H8000_0000) and DROP_FRAM_mask
            end If
        else
            read_DROP_FRAM_value = data_low and DROP_FRAM_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DROP_FRAM_value = &H0
        flag_DROP_FRAM        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO_redir_debug_sa_2_ctr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DROP_FRAM                                  [7:0]            get_DROP_FRAM
''                                                             set_DROP_FRAM
''                                                             read_DROP_FRAM
''                                                             write_DROP_FRAM
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO_redir_debug_sa_2_ctr
    Private write_DROP_FRAM_value
    Private read_DROP_FRAM_value
    Private flag_DROP_FRAM

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H20a48
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_DROP_FRAM
        get_DROP_FRAM = read_DROP_FRAM_value
    End Property

    Property Let set_DROP_FRAM(aData)
        write_DROP_FRAM_value = aData
        flag_DROP_FRAM        = &H1
    End Property

    Property Get read_DROP_FRAM
        read
        read_DROP_FRAM = read_DROP_FRAM_value
    End Property

    Property Let write_DROP_FRAM(aData)
        set_DROP_FRAM = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DROP_FRAM_mask = &Hff
        if data_low > LONG_MAX then
            if DROP_FRAM_mask = mask then
                read_DROP_FRAM_value = data_low
            else
                read_DROP_FRAM_value = (data_low - H8000_0000) and DROP_FRAM_mask
            end If
        else
            read_DROP_FRAM_value = data_low and DROP_FRAM_mask
        end If

    End Sub

    Sub write
        If flag_DROP_FRAM = &H0 Then read
        If flag_DROP_FRAM = &H0 Then write_DROP_FRAM_value = get_DROP_FRAM

        regValue = leftShift((write_DROP_FRAM_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DROP_FRAM_mask = &Hff
        if data_low > LONG_MAX then
            if DROP_FRAM_mask = mask then
                read_DROP_FRAM_value = data_low
            else
                read_DROP_FRAM_value = (data_low - H8000_0000) and DROP_FRAM_mask
            end If
        else
            read_DROP_FRAM_value = data_low and DROP_FRAM_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DROP_FRAM_value = &H0
        flag_DROP_FRAM        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO_redir_debug_sa_3_ctr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DROP_FRAM                                  [7:0]            get_DROP_FRAM
''                                                             set_DROP_FRAM
''                                                             read_DROP_FRAM
''                                                             write_DROP_FRAM
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO_redir_debug_sa_3_ctr
    Private write_DROP_FRAM_value
    Private read_DROP_FRAM_value
    Private flag_DROP_FRAM

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H20a4c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_DROP_FRAM
        get_DROP_FRAM = read_DROP_FRAM_value
    End Property

    Property Let set_DROP_FRAM(aData)
        write_DROP_FRAM_value = aData
        flag_DROP_FRAM        = &H1
    End Property

    Property Get read_DROP_FRAM
        read
        read_DROP_FRAM = read_DROP_FRAM_value
    End Property

    Property Let write_DROP_FRAM(aData)
        set_DROP_FRAM = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DROP_FRAM_mask = &Hff
        if data_low > LONG_MAX then
            if DROP_FRAM_mask = mask then
                read_DROP_FRAM_value = data_low
            else
                read_DROP_FRAM_value = (data_low - H8000_0000) and DROP_FRAM_mask
            end If
        else
            read_DROP_FRAM_value = data_low and DROP_FRAM_mask
        end If

    End Sub

    Sub write
        If flag_DROP_FRAM = &H0 Then read
        If flag_DROP_FRAM = &H0 Then write_DROP_FRAM_value = get_DROP_FRAM

        regValue = leftShift((write_DROP_FRAM_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DROP_FRAM_mask = &Hff
        if data_low > LONG_MAX then
            if DROP_FRAM_mask = mask then
                read_DROP_FRAM_value = data_low
            else
                read_DROP_FRAM_value = (data_low - H8000_0000) and DROP_FRAM_mask
            end If
        else
            read_DROP_FRAM_value = data_low and DROP_FRAM_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DROP_FRAM_value = &H0
        flag_DROP_FRAM        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO_redir_debug_sa_4_ctr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DROP_FRAM                                  [7:0]            get_DROP_FRAM
''                                                             set_DROP_FRAM
''                                                             read_DROP_FRAM
''                                                             write_DROP_FRAM
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO_redir_debug_sa_4_ctr
    Private write_DROP_FRAM_value
    Private read_DROP_FRAM_value
    Private flag_DROP_FRAM

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H20a50
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_DROP_FRAM
        get_DROP_FRAM = read_DROP_FRAM_value
    End Property

    Property Let set_DROP_FRAM(aData)
        write_DROP_FRAM_value = aData
        flag_DROP_FRAM        = &H1
    End Property

    Property Get read_DROP_FRAM
        read
        read_DROP_FRAM = read_DROP_FRAM_value
    End Property

    Property Let write_DROP_FRAM(aData)
        set_DROP_FRAM = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DROP_FRAM_mask = &Hff
        if data_low > LONG_MAX then
            if DROP_FRAM_mask = mask then
                read_DROP_FRAM_value = data_low
            else
                read_DROP_FRAM_value = (data_low - H8000_0000) and DROP_FRAM_mask
            end If
        else
            read_DROP_FRAM_value = data_low and DROP_FRAM_mask
        end If

    End Sub

    Sub write
        If flag_DROP_FRAM = &H0 Then read
        If flag_DROP_FRAM = &H0 Then write_DROP_FRAM_value = get_DROP_FRAM

        regValue = leftShift((write_DROP_FRAM_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DROP_FRAM_mask = &Hff
        if data_low > LONG_MAX then
            if DROP_FRAM_mask = mask then
                read_DROP_FRAM_value = data_low
            else
                read_DROP_FRAM_value = (data_low - H8000_0000) and DROP_FRAM_mask
            end If
        else
            read_DROP_FRAM_value = data_low and DROP_FRAM_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DROP_FRAM_value = &H0
        flag_DROP_FRAM        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO_redir_debug_sa_5_ctr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DROP_FRAM                                  [7:0]            get_DROP_FRAM
''                                                             set_DROP_FRAM
''                                                             read_DROP_FRAM
''                                                             write_DROP_FRAM
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO_redir_debug_sa_5_ctr
    Private write_DROP_FRAM_value
    Private read_DROP_FRAM_value
    Private flag_DROP_FRAM

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H20a54
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_DROP_FRAM
        get_DROP_FRAM = read_DROP_FRAM_value
    End Property

    Property Let set_DROP_FRAM(aData)
        write_DROP_FRAM_value = aData
        flag_DROP_FRAM        = &H1
    End Property

    Property Get read_DROP_FRAM
        read
        read_DROP_FRAM = read_DROP_FRAM_value
    End Property

    Property Let write_DROP_FRAM(aData)
        set_DROP_FRAM = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DROP_FRAM_mask = &Hff
        if data_low > LONG_MAX then
            if DROP_FRAM_mask = mask then
                read_DROP_FRAM_value = data_low
            else
                read_DROP_FRAM_value = (data_low - H8000_0000) and DROP_FRAM_mask
            end If
        else
            read_DROP_FRAM_value = data_low and DROP_FRAM_mask
        end If

    End Sub

    Sub write
        If flag_DROP_FRAM = &H0 Then read
        If flag_DROP_FRAM = &H0 Then write_DROP_FRAM_value = get_DROP_FRAM

        regValue = leftShift((write_DROP_FRAM_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DROP_FRAM_mask = &Hff
        if data_low > LONG_MAX then
            if DROP_FRAM_mask = mask then
                read_DROP_FRAM_value = data_low
            else
                read_DROP_FRAM_value = (data_low - H8000_0000) and DROP_FRAM_mask
            end If
        else
            read_DROP_FRAM_value = data_low and DROP_FRAM_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DROP_FRAM_value = &H0
        flag_DROP_FRAM        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO_redir_debug_sa_6_ctr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DROP_FRAM                                  [7:0]            get_DROP_FRAM
''                                                             set_DROP_FRAM
''                                                             read_DROP_FRAM
''                                                             write_DROP_FRAM
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO_redir_debug_sa_6_ctr
    Private write_DROP_FRAM_value
    Private read_DROP_FRAM_value
    Private flag_DROP_FRAM

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H20a58
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_DROP_FRAM
        get_DROP_FRAM = read_DROP_FRAM_value
    End Property

    Property Let set_DROP_FRAM(aData)
        write_DROP_FRAM_value = aData
        flag_DROP_FRAM        = &H1
    End Property

    Property Get read_DROP_FRAM
        read
        read_DROP_FRAM = read_DROP_FRAM_value
    End Property

    Property Let write_DROP_FRAM(aData)
        set_DROP_FRAM = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DROP_FRAM_mask = &Hff
        if data_low > LONG_MAX then
            if DROP_FRAM_mask = mask then
                read_DROP_FRAM_value = data_low
            else
                read_DROP_FRAM_value = (data_low - H8000_0000) and DROP_FRAM_mask
            end If
        else
            read_DROP_FRAM_value = data_low and DROP_FRAM_mask
        end If

    End Sub

    Sub write
        If flag_DROP_FRAM = &H0 Then read
        If flag_DROP_FRAM = &H0 Then write_DROP_FRAM_value = get_DROP_FRAM

        regValue = leftShift((write_DROP_FRAM_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DROP_FRAM_mask = &Hff
        if data_low > LONG_MAX then
            if DROP_FRAM_mask = mask then
                read_DROP_FRAM_value = data_low
            else
                read_DROP_FRAM_value = (data_low - H8000_0000) and DROP_FRAM_mask
            end If
        else
            read_DROP_FRAM_value = data_low and DROP_FRAM_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DROP_FRAM_value = &H0
        flag_DROP_FRAM        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO_redir_debug_sa_7_ctr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DROP_FRAM                                  [7:0]            get_DROP_FRAM
''                                                             set_DROP_FRAM
''                                                             read_DROP_FRAM
''                                                             write_DROP_FRAM
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO_redir_debug_sa_7_ctr
    Private write_DROP_FRAM_value
    Private read_DROP_FRAM_value
    Private flag_DROP_FRAM

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H20a5c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_DROP_FRAM
        get_DROP_FRAM = read_DROP_FRAM_value
    End Property

    Property Let set_DROP_FRAM(aData)
        write_DROP_FRAM_value = aData
        flag_DROP_FRAM        = &H1
    End Property

    Property Get read_DROP_FRAM
        read
        read_DROP_FRAM = read_DROP_FRAM_value
    End Property

    Property Let write_DROP_FRAM(aData)
        set_DROP_FRAM = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DROP_FRAM_mask = &Hff
        if data_low > LONG_MAX then
            if DROP_FRAM_mask = mask then
                read_DROP_FRAM_value = data_low
            else
                read_DROP_FRAM_value = (data_low - H8000_0000) and DROP_FRAM_mask
            end If
        else
            read_DROP_FRAM_value = data_low and DROP_FRAM_mask
        end If

    End Sub

    Sub write
        If flag_DROP_FRAM = &H0 Then read
        If flag_DROP_FRAM = &H0 Then write_DROP_FRAM_value = get_DROP_FRAM

        regValue = leftShift((write_DROP_FRAM_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DROP_FRAM_mask = &Hff
        if data_low > LONG_MAX then
            if DROP_FRAM_mask = mask then
                read_DROP_FRAM_value = data_low
            else
                read_DROP_FRAM_value = (data_low - H8000_0000) and DROP_FRAM_mask
            end If
        else
            read_DROP_FRAM_value = data_low and DROP_FRAM_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DROP_FRAM_value = &H0
        flag_DROP_FRAM        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO_redir_debug_sa_8_ctr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DROP_FRAM                                  [7:0]            get_DROP_FRAM
''                                                             set_DROP_FRAM
''                                                             read_DROP_FRAM
''                                                             write_DROP_FRAM
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO_redir_debug_sa_8_ctr
    Private write_DROP_FRAM_value
    Private read_DROP_FRAM_value
    Private flag_DROP_FRAM

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H20a60
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_DROP_FRAM
        get_DROP_FRAM = read_DROP_FRAM_value
    End Property

    Property Let set_DROP_FRAM(aData)
        write_DROP_FRAM_value = aData
        flag_DROP_FRAM        = &H1
    End Property

    Property Get read_DROP_FRAM
        read
        read_DROP_FRAM = read_DROP_FRAM_value
    End Property

    Property Let write_DROP_FRAM(aData)
        set_DROP_FRAM = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DROP_FRAM_mask = &Hff
        if data_low > LONG_MAX then
            if DROP_FRAM_mask = mask then
                read_DROP_FRAM_value = data_low
            else
                read_DROP_FRAM_value = (data_low - H8000_0000) and DROP_FRAM_mask
            end If
        else
            read_DROP_FRAM_value = data_low and DROP_FRAM_mask
        end If

    End Sub

    Sub write
        If flag_DROP_FRAM = &H0 Then read
        If flag_DROP_FRAM = &H0 Then write_DROP_FRAM_value = get_DROP_FRAM

        regValue = leftShift((write_DROP_FRAM_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DROP_FRAM_mask = &Hff
        if data_low > LONG_MAX then
            if DROP_FRAM_mask = mask then
                read_DROP_FRAM_value = data_low
            else
                read_DROP_FRAM_value = (data_low - H8000_0000) and DROP_FRAM_mask
            end If
        else
            read_DROP_FRAM_value = data_low and DROP_FRAM_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DROP_FRAM_value = &H0
        flag_DROP_FRAM        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO_redir_debug_sa_9_ctr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DROP_FRAM                                  [7:0]            get_DROP_FRAM
''                                                             set_DROP_FRAM
''                                                             read_DROP_FRAM
''                                                             write_DROP_FRAM
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO_redir_debug_sa_9_ctr
    Private write_DROP_FRAM_value
    Private read_DROP_FRAM_value
    Private flag_DROP_FRAM

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H20a64
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_DROP_FRAM
        get_DROP_FRAM = read_DROP_FRAM_value
    End Property

    Property Let set_DROP_FRAM(aData)
        write_DROP_FRAM_value = aData
        flag_DROP_FRAM        = &H1
    End Property

    Property Get read_DROP_FRAM
        read
        read_DROP_FRAM = read_DROP_FRAM_value
    End Property

    Property Let write_DROP_FRAM(aData)
        set_DROP_FRAM = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DROP_FRAM_mask = &Hff
        if data_low > LONG_MAX then
            if DROP_FRAM_mask = mask then
                read_DROP_FRAM_value = data_low
            else
                read_DROP_FRAM_value = (data_low - H8000_0000) and DROP_FRAM_mask
            end If
        else
            read_DROP_FRAM_value = data_low and DROP_FRAM_mask
        end If

    End Sub

    Sub write
        If flag_DROP_FRAM = &H0 Then read
        If flag_DROP_FRAM = &H0 Then write_DROP_FRAM_value = get_DROP_FRAM

        regValue = leftShift((write_DROP_FRAM_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DROP_FRAM_mask = &Hff
        if data_low > LONG_MAX then
            if DROP_FRAM_mask = mask then
                read_DROP_FRAM_value = data_low
            else
                read_DROP_FRAM_value = (data_low - H8000_0000) and DROP_FRAM_mask
            end If
        else
            read_DROP_FRAM_value = data_low and DROP_FRAM_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DROP_FRAM_value = &H0
        flag_DROP_FRAM        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO_redir_debug_sa_10_ctr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DROP_FRAM                                  [7:0]            get_DROP_FRAM
''                                                             set_DROP_FRAM
''                                                             read_DROP_FRAM
''                                                             write_DROP_FRAM
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO_redir_debug_sa_10_ctr
    Private write_DROP_FRAM_value
    Private read_DROP_FRAM_value
    Private flag_DROP_FRAM

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H20a68
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_DROP_FRAM
        get_DROP_FRAM = read_DROP_FRAM_value
    End Property

    Property Let set_DROP_FRAM(aData)
        write_DROP_FRAM_value = aData
        flag_DROP_FRAM        = &H1
    End Property

    Property Get read_DROP_FRAM
        read
        read_DROP_FRAM = read_DROP_FRAM_value
    End Property

    Property Let write_DROP_FRAM(aData)
        set_DROP_FRAM = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DROP_FRAM_mask = &Hff
        if data_low > LONG_MAX then
            if DROP_FRAM_mask = mask then
                read_DROP_FRAM_value = data_low
            else
                read_DROP_FRAM_value = (data_low - H8000_0000) and DROP_FRAM_mask
            end If
        else
            read_DROP_FRAM_value = data_low and DROP_FRAM_mask
        end If

    End Sub

    Sub write
        If flag_DROP_FRAM = &H0 Then read
        If flag_DROP_FRAM = &H0 Then write_DROP_FRAM_value = get_DROP_FRAM

        regValue = leftShift((write_DROP_FRAM_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DROP_FRAM_mask = &Hff
        if data_low > LONG_MAX then
            if DROP_FRAM_mask = mask then
                read_DROP_FRAM_value = data_low
            else
                read_DROP_FRAM_value = (data_low - H8000_0000) and DROP_FRAM_mask
            end If
        else
            read_DROP_FRAM_value = data_low and DROP_FRAM_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DROP_FRAM_value = &H0
        flag_DROP_FRAM        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO_redir_debug_sa_11_ctr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DROP_FRAM                                  [7:0]            get_DROP_FRAM
''                                                             set_DROP_FRAM
''                                                             read_DROP_FRAM
''                                                             write_DROP_FRAM
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO_redir_debug_sa_11_ctr
    Private write_DROP_FRAM_value
    Private read_DROP_FRAM_value
    Private flag_DROP_FRAM

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H20a6c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_DROP_FRAM
        get_DROP_FRAM = read_DROP_FRAM_value
    End Property

    Property Let set_DROP_FRAM(aData)
        write_DROP_FRAM_value = aData
        flag_DROP_FRAM        = &H1
    End Property

    Property Get read_DROP_FRAM
        read
        read_DROP_FRAM = read_DROP_FRAM_value
    End Property

    Property Let write_DROP_FRAM(aData)
        set_DROP_FRAM = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DROP_FRAM_mask = &Hff
        if data_low > LONG_MAX then
            if DROP_FRAM_mask = mask then
                read_DROP_FRAM_value = data_low
            else
                read_DROP_FRAM_value = (data_low - H8000_0000) and DROP_FRAM_mask
            end If
        else
            read_DROP_FRAM_value = data_low and DROP_FRAM_mask
        end If

    End Sub

    Sub write
        If flag_DROP_FRAM = &H0 Then read
        If flag_DROP_FRAM = &H0 Then write_DROP_FRAM_value = get_DROP_FRAM

        regValue = leftShift((write_DROP_FRAM_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DROP_FRAM_mask = &Hff
        if data_low > LONG_MAX then
            if DROP_FRAM_mask = mask then
                read_DROP_FRAM_value = data_low
            else
                read_DROP_FRAM_value = (data_low - H8000_0000) and DROP_FRAM_mask
            end If
        else
            read_DROP_FRAM_value = data_low and DROP_FRAM_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DROP_FRAM_value = &H0
        flag_DROP_FRAM        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO_redir_debug_sa_12_ctr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DROP_FRAM                                  [7:0]            get_DROP_FRAM
''                                                             set_DROP_FRAM
''                                                             read_DROP_FRAM
''                                                             write_DROP_FRAM
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO_redir_debug_sa_12_ctr
    Private write_DROP_FRAM_value
    Private read_DROP_FRAM_value
    Private flag_DROP_FRAM

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H20a70
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_DROP_FRAM
        get_DROP_FRAM = read_DROP_FRAM_value
    End Property

    Property Let set_DROP_FRAM(aData)
        write_DROP_FRAM_value = aData
        flag_DROP_FRAM        = &H1
    End Property

    Property Get read_DROP_FRAM
        read
        read_DROP_FRAM = read_DROP_FRAM_value
    End Property

    Property Let write_DROP_FRAM(aData)
        set_DROP_FRAM = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DROP_FRAM_mask = &Hff
        if data_low > LONG_MAX then
            if DROP_FRAM_mask = mask then
                read_DROP_FRAM_value = data_low
            else
                read_DROP_FRAM_value = (data_low - H8000_0000) and DROP_FRAM_mask
            end If
        else
            read_DROP_FRAM_value = data_low and DROP_FRAM_mask
        end If

    End Sub

    Sub write
        If flag_DROP_FRAM = &H0 Then read
        If flag_DROP_FRAM = &H0 Then write_DROP_FRAM_value = get_DROP_FRAM

        regValue = leftShift((write_DROP_FRAM_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DROP_FRAM_mask = &Hff
        if data_low > LONG_MAX then
            if DROP_FRAM_mask = mask then
                read_DROP_FRAM_value = data_low
            else
                read_DROP_FRAM_value = (data_low - H8000_0000) and DROP_FRAM_mask
            end If
        else
            read_DROP_FRAM_value = data_low and DROP_FRAM_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DROP_FRAM_value = &H0
        flag_DROP_FRAM        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO_redir_debug_sa_13_ctr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DROP_FRAM                                  [7:0]            get_DROP_FRAM
''                                                             set_DROP_FRAM
''                                                             read_DROP_FRAM
''                                                             write_DROP_FRAM
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO_redir_debug_sa_13_ctr
    Private write_DROP_FRAM_value
    Private read_DROP_FRAM_value
    Private flag_DROP_FRAM

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H20a74
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_DROP_FRAM
        get_DROP_FRAM = read_DROP_FRAM_value
    End Property

    Property Let set_DROP_FRAM(aData)
        write_DROP_FRAM_value = aData
        flag_DROP_FRAM        = &H1
    End Property

    Property Get read_DROP_FRAM
        read
        read_DROP_FRAM = read_DROP_FRAM_value
    End Property

    Property Let write_DROP_FRAM(aData)
        set_DROP_FRAM = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DROP_FRAM_mask = &Hff
        if data_low > LONG_MAX then
            if DROP_FRAM_mask = mask then
                read_DROP_FRAM_value = data_low
            else
                read_DROP_FRAM_value = (data_low - H8000_0000) and DROP_FRAM_mask
            end If
        else
            read_DROP_FRAM_value = data_low and DROP_FRAM_mask
        end If

    End Sub

    Sub write
        If flag_DROP_FRAM = &H0 Then read
        If flag_DROP_FRAM = &H0 Then write_DROP_FRAM_value = get_DROP_FRAM

        regValue = leftShift((write_DROP_FRAM_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DROP_FRAM_mask = &Hff
        if data_low > LONG_MAX then
            if DROP_FRAM_mask = mask then
                read_DROP_FRAM_value = data_low
            else
                read_DROP_FRAM_value = (data_low - H8000_0000) and DROP_FRAM_mask
            end If
        else
            read_DROP_FRAM_value = data_low and DROP_FRAM_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DROP_FRAM_value = &H0
        flag_DROP_FRAM        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO_redir_debug_sa_14_ctr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DROP_FRAM                                  [7:0]            get_DROP_FRAM
''                                                             set_DROP_FRAM
''                                                             read_DROP_FRAM
''                                                             write_DROP_FRAM
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO_redir_debug_sa_14_ctr
    Private write_DROP_FRAM_value
    Private read_DROP_FRAM_value
    Private flag_DROP_FRAM

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H20a78
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_DROP_FRAM
        get_DROP_FRAM = read_DROP_FRAM_value
    End Property

    Property Let set_DROP_FRAM(aData)
        write_DROP_FRAM_value = aData
        flag_DROP_FRAM        = &H1
    End Property

    Property Get read_DROP_FRAM
        read
        read_DROP_FRAM = read_DROP_FRAM_value
    End Property

    Property Let write_DROP_FRAM(aData)
        set_DROP_FRAM = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DROP_FRAM_mask = &Hff
        if data_low > LONG_MAX then
            if DROP_FRAM_mask = mask then
                read_DROP_FRAM_value = data_low
            else
                read_DROP_FRAM_value = (data_low - H8000_0000) and DROP_FRAM_mask
            end If
        else
            read_DROP_FRAM_value = data_low and DROP_FRAM_mask
        end If

    End Sub

    Sub write
        If flag_DROP_FRAM = &H0 Then read
        If flag_DROP_FRAM = &H0 Then write_DROP_FRAM_value = get_DROP_FRAM

        regValue = leftShift((write_DROP_FRAM_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DROP_FRAM_mask = &Hff
        if data_low > LONG_MAX then
            if DROP_FRAM_mask = mask then
                read_DROP_FRAM_value = data_low
            else
                read_DROP_FRAM_value = (data_low - H8000_0000) and DROP_FRAM_mask
            end If
        else
            read_DROP_FRAM_value = data_low and DROP_FRAM_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DROP_FRAM_value = &H0
        flag_DROP_FRAM        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO_redir_debug_sa_15_ctr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DROP_FRAM                                  [7:0]            get_DROP_FRAM
''                                                             set_DROP_FRAM
''                                                             read_DROP_FRAM
''                                                             write_DROP_FRAM
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO_redir_debug_sa_15_ctr
    Private write_DROP_FRAM_value
    Private read_DROP_FRAM_value
    Private flag_DROP_FRAM

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H20a7c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_DROP_FRAM
        get_DROP_FRAM = read_DROP_FRAM_value
    End Property

    Property Let set_DROP_FRAM(aData)
        write_DROP_FRAM_value = aData
        flag_DROP_FRAM        = &H1
    End Property

    Property Get read_DROP_FRAM
        read
        read_DROP_FRAM = read_DROP_FRAM_value
    End Property

    Property Let write_DROP_FRAM(aData)
        set_DROP_FRAM = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DROP_FRAM_mask = &Hff
        if data_low > LONG_MAX then
            if DROP_FRAM_mask = mask then
                read_DROP_FRAM_value = data_low
            else
                read_DROP_FRAM_value = (data_low - H8000_0000) and DROP_FRAM_mask
            end If
        else
            read_DROP_FRAM_value = data_low and DROP_FRAM_mask
        end If

    End Sub

    Sub write
        If flag_DROP_FRAM = &H0 Then read
        If flag_DROP_FRAM = &H0 Then write_DROP_FRAM_value = get_DROP_FRAM

        regValue = leftShift((write_DROP_FRAM_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DROP_FRAM_mask = &Hff
        if data_low > LONG_MAX then
            if DROP_FRAM_mask = mask then
                read_DROP_FRAM_value = data_low
            else
                read_DROP_FRAM_value = (data_low - H8000_0000) and DROP_FRAM_mask
            end If
        else
            read_DROP_FRAM_value = data_low and DROP_FRAM_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DROP_FRAM_value = &H0
        flag_DROP_FRAM        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO_redir_debug_sa_16_ctr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DROP_FRAM                                  [7:0]            get_DROP_FRAM
''                                                             set_DROP_FRAM
''                                                             read_DROP_FRAM
''                                                             write_DROP_FRAM
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO_redir_debug_sa_16_ctr
    Private write_DROP_FRAM_value
    Private read_DROP_FRAM_value
    Private flag_DROP_FRAM

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H20a80
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_DROP_FRAM
        get_DROP_FRAM = read_DROP_FRAM_value
    End Property

    Property Let set_DROP_FRAM(aData)
        write_DROP_FRAM_value = aData
        flag_DROP_FRAM        = &H1
    End Property

    Property Get read_DROP_FRAM
        read
        read_DROP_FRAM = read_DROP_FRAM_value
    End Property

    Property Let write_DROP_FRAM(aData)
        set_DROP_FRAM = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DROP_FRAM_mask = &Hff
        if data_low > LONG_MAX then
            if DROP_FRAM_mask = mask then
                read_DROP_FRAM_value = data_low
            else
                read_DROP_FRAM_value = (data_low - H8000_0000) and DROP_FRAM_mask
            end If
        else
            read_DROP_FRAM_value = data_low and DROP_FRAM_mask
        end If

    End Sub

    Sub write
        If flag_DROP_FRAM = &H0 Then read
        If flag_DROP_FRAM = &H0 Then write_DROP_FRAM_value = get_DROP_FRAM

        regValue = leftShift((write_DROP_FRAM_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DROP_FRAM_mask = &Hff
        if data_low > LONG_MAX then
            if DROP_FRAM_mask = mask then
                read_DROP_FRAM_value = data_low
            else
                read_DROP_FRAM_value = (data_low - H8000_0000) and DROP_FRAM_mask
            end If
        else
            read_DROP_FRAM_value = data_low and DROP_FRAM_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DROP_FRAM_value = &H0
        flag_DROP_FRAM        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO_redir_debug_sa_17_ctr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DROP_FRAM                                  [7:0]            get_DROP_FRAM
''                                                             set_DROP_FRAM
''                                                             read_DROP_FRAM
''                                                             write_DROP_FRAM
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO_redir_debug_sa_17_ctr
    Private write_DROP_FRAM_value
    Private read_DROP_FRAM_value
    Private flag_DROP_FRAM

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H20a84
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_DROP_FRAM
        get_DROP_FRAM = read_DROP_FRAM_value
    End Property

    Property Let set_DROP_FRAM(aData)
        write_DROP_FRAM_value = aData
        flag_DROP_FRAM        = &H1
    End Property

    Property Get read_DROP_FRAM
        read
        read_DROP_FRAM = read_DROP_FRAM_value
    End Property

    Property Let write_DROP_FRAM(aData)
        set_DROP_FRAM = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DROP_FRAM_mask = &Hff
        if data_low > LONG_MAX then
            if DROP_FRAM_mask = mask then
                read_DROP_FRAM_value = data_low
            else
                read_DROP_FRAM_value = (data_low - H8000_0000) and DROP_FRAM_mask
            end If
        else
            read_DROP_FRAM_value = data_low and DROP_FRAM_mask
        end If

    End Sub

    Sub write
        If flag_DROP_FRAM = &H0 Then read
        If flag_DROP_FRAM = &H0 Then write_DROP_FRAM_value = get_DROP_FRAM

        regValue = leftShift((write_DROP_FRAM_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DROP_FRAM_mask = &Hff
        if data_low > LONG_MAX then
            if DROP_FRAM_mask = mask then
                read_DROP_FRAM_value = data_low
            else
                read_DROP_FRAM_value = (data_low - H8000_0000) and DROP_FRAM_mask
            end If
        else
            read_DROP_FRAM_value = data_low and DROP_FRAM_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DROP_FRAM_value = &H0
        flag_DROP_FRAM        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO_redir_debug_sa_18_ctr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DROP_FRAM                                  [7:0]            get_DROP_FRAM
''                                                             set_DROP_FRAM
''                                                             read_DROP_FRAM
''                                                             write_DROP_FRAM
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO_redir_debug_sa_18_ctr
    Private write_DROP_FRAM_value
    Private read_DROP_FRAM_value
    Private flag_DROP_FRAM

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H20a88
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_DROP_FRAM
        get_DROP_FRAM = read_DROP_FRAM_value
    End Property

    Property Let set_DROP_FRAM(aData)
        write_DROP_FRAM_value = aData
        flag_DROP_FRAM        = &H1
    End Property

    Property Get read_DROP_FRAM
        read
        read_DROP_FRAM = read_DROP_FRAM_value
    End Property

    Property Let write_DROP_FRAM(aData)
        set_DROP_FRAM = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DROP_FRAM_mask = &Hff
        if data_low > LONG_MAX then
            if DROP_FRAM_mask = mask then
                read_DROP_FRAM_value = data_low
            else
                read_DROP_FRAM_value = (data_low - H8000_0000) and DROP_FRAM_mask
            end If
        else
            read_DROP_FRAM_value = data_low and DROP_FRAM_mask
        end If

    End Sub

    Sub write
        If flag_DROP_FRAM = &H0 Then read
        If flag_DROP_FRAM = &H0 Then write_DROP_FRAM_value = get_DROP_FRAM

        regValue = leftShift((write_DROP_FRAM_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DROP_FRAM_mask = &Hff
        if data_low > LONG_MAX then
            if DROP_FRAM_mask = mask then
                read_DROP_FRAM_value = data_low
            else
                read_DROP_FRAM_value = (data_low - H8000_0000) and DROP_FRAM_mask
            end If
        else
            read_DROP_FRAM_value = data_low and DROP_FRAM_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DROP_FRAM_value = &H0
        flag_DROP_FRAM        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO_redir_debug_sa_19_ctr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DROP_FRAM                                  [7:0]            get_DROP_FRAM
''                                                             set_DROP_FRAM
''                                                             read_DROP_FRAM
''                                                             write_DROP_FRAM
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO_redir_debug_sa_19_ctr
    Private write_DROP_FRAM_value
    Private read_DROP_FRAM_value
    Private flag_DROP_FRAM

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H20a8c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_DROP_FRAM
        get_DROP_FRAM = read_DROP_FRAM_value
    End Property

    Property Let set_DROP_FRAM(aData)
        write_DROP_FRAM_value = aData
        flag_DROP_FRAM        = &H1
    End Property

    Property Get read_DROP_FRAM
        read
        read_DROP_FRAM = read_DROP_FRAM_value
    End Property

    Property Let write_DROP_FRAM(aData)
        set_DROP_FRAM = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DROP_FRAM_mask = &Hff
        if data_low > LONG_MAX then
            if DROP_FRAM_mask = mask then
                read_DROP_FRAM_value = data_low
            else
                read_DROP_FRAM_value = (data_low - H8000_0000) and DROP_FRAM_mask
            end If
        else
            read_DROP_FRAM_value = data_low and DROP_FRAM_mask
        end If

    End Sub

    Sub write
        If flag_DROP_FRAM = &H0 Then read
        If flag_DROP_FRAM = &H0 Then write_DROP_FRAM_value = get_DROP_FRAM

        regValue = leftShift((write_DROP_FRAM_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DROP_FRAM_mask = &Hff
        if data_low > LONG_MAX then
            if DROP_FRAM_mask = mask then
                read_DROP_FRAM_value = data_low
            else
                read_DROP_FRAM_value = (data_low - H8000_0000) and DROP_FRAM_mask
            end If
        else
            read_DROP_FRAM_value = data_low and DROP_FRAM_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DROP_FRAM_value = &H0
        flag_DROP_FRAM        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO_redir_debug_sa_20_ctr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DROP_FRAM                                  [7:0]            get_DROP_FRAM
''                                                             set_DROP_FRAM
''                                                             read_DROP_FRAM
''                                                             write_DROP_FRAM
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO_redir_debug_sa_20_ctr
    Private write_DROP_FRAM_value
    Private read_DROP_FRAM_value
    Private flag_DROP_FRAM

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H20a90
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_DROP_FRAM
        get_DROP_FRAM = read_DROP_FRAM_value
    End Property

    Property Let set_DROP_FRAM(aData)
        write_DROP_FRAM_value = aData
        flag_DROP_FRAM        = &H1
    End Property

    Property Get read_DROP_FRAM
        read
        read_DROP_FRAM = read_DROP_FRAM_value
    End Property

    Property Let write_DROP_FRAM(aData)
        set_DROP_FRAM = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DROP_FRAM_mask = &Hff
        if data_low > LONG_MAX then
            if DROP_FRAM_mask = mask then
                read_DROP_FRAM_value = data_low
            else
                read_DROP_FRAM_value = (data_low - H8000_0000) and DROP_FRAM_mask
            end If
        else
            read_DROP_FRAM_value = data_low and DROP_FRAM_mask
        end If

    End Sub

    Sub write
        If flag_DROP_FRAM = &H0 Then read
        If flag_DROP_FRAM = &H0 Then write_DROP_FRAM_value = get_DROP_FRAM

        regValue = leftShift((write_DROP_FRAM_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DROP_FRAM_mask = &Hff
        if data_low > LONG_MAX then
            if DROP_FRAM_mask = mask then
                read_DROP_FRAM_value = data_low
            else
                read_DROP_FRAM_value = (data_low - H8000_0000) and DROP_FRAM_mask
            end If
        else
            read_DROP_FRAM_value = data_low and DROP_FRAM_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DROP_FRAM_value = &H0
        flag_DROP_FRAM        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO_redir_debug_sa_21_ctr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DROP_FRAM                                  [7:0]            get_DROP_FRAM
''                                                             set_DROP_FRAM
''                                                             read_DROP_FRAM
''                                                             write_DROP_FRAM
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO_redir_debug_sa_21_ctr
    Private write_DROP_FRAM_value
    Private read_DROP_FRAM_value
    Private flag_DROP_FRAM

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H20a94
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_DROP_FRAM
        get_DROP_FRAM = read_DROP_FRAM_value
    End Property

    Property Let set_DROP_FRAM(aData)
        write_DROP_FRAM_value = aData
        flag_DROP_FRAM        = &H1
    End Property

    Property Get read_DROP_FRAM
        read
        read_DROP_FRAM = read_DROP_FRAM_value
    End Property

    Property Let write_DROP_FRAM(aData)
        set_DROP_FRAM = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DROP_FRAM_mask = &Hff
        if data_low > LONG_MAX then
            if DROP_FRAM_mask = mask then
                read_DROP_FRAM_value = data_low
            else
                read_DROP_FRAM_value = (data_low - H8000_0000) and DROP_FRAM_mask
            end If
        else
            read_DROP_FRAM_value = data_low and DROP_FRAM_mask
        end If

    End Sub

    Sub write
        If flag_DROP_FRAM = &H0 Then read
        If flag_DROP_FRAM = &H0 Then write_DROP_FRAM_value = get_DROP_FRAM

        regValue = leftShift((write_DROP_FRAM_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DROP_FRAM_mask = &Hff
        if data_low > LONG_MAX then
            if DROP_FRAM_mask = mask then
                read_DROP_FRAM_value = data_low
            else
                read_DROP_FRAM_value = (data_low - H8000_0000) and DROP_FRAM_mask
            end If
        else
            read_DROP_FRAM_value = data_low and DROP_FRAM_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DROP_FRAM_value = &H0
        flag_DROP_FRAM        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO_redir_debug_sa_22_ctr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DROP_FRAM                                  [7:0]            get_DROP_FRAM
''                                                             set_DROP_FRAM
''                                                             read_DROP_FRAM
''                                                             write_DROP_FRAM
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO_redir_debug_sa_22_ctr
    Private write_DROP_FRAM_value
    Private read_DROP_FRAM_value
    Private flag_DROP_FRAM

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H20a98
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_DROP_FRAM
        get_DROP_FRAM = read_DROP_FRAM_value
    End Property

    Property Let set_DROP_FRAM(aData)
        write_DROP_FRAM_value = aData
        flag_DROP_FRAM        = &H1
    End Property

    Property Get read_DROP_FRAM
        read
        read_DROP_FRAM = read_DROP_FRAM_value
    End Property

    Property Let write_DROP_FRAM(aData)
        set_DROP_FRAM = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DROP_FRAM_mask = &Hff
        if data_low > LONG_MAX then
            if DROP_FRAM_mask = mask then
                read_DROP_FRAM_value = data_low
            else
                read_DROP_FRAM_value = (data_low - H8000_0000) and DROP_FRAM_mask
            end If
        else
            read_DROP_FRAM_value = data_low and DROP_FRAM_mask
        end If

    End Sub

    Sub write
        If flag_DROP_FRAM = &H0 Then read
        If flag_DROP_FRAM = &H0 Then write_DROP_FRAM_value = get_DROP_FRAM

        regValue = leftShift((write_DROP_FRAM_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DROP_FRAM_mask = &Hff
        if data_low > LONG_MAX then
            if DROP_FRAM_mask = mask then
                read_DROP_FRAM_value = data_low
            else
                read_DROP_FRAM_value = (data_low - H8000_0000) and DROP_FRAM_mask
            end If
        else
            read_DROP_FRAM_value = data_low and DROP_FRAM_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DROP_FRAM_value = &H0
        flag_DROP_FRAM        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO_redir_debug_sa_23_ctr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DROP_FRAM                                  [7:0]            get_DROP_FRAM
''                                                             set_DROP_FRAM
''                                                             read_DROP_FRAM
''                                                             write_DROP_FRAM
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO_redir_debug_sa_23_ctr
    Private write_DROP_FRAM_value
    Private read_DROP_FRAM_value
    Private flag_DROP_FRAM

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H20a9c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_DROP_FRAM
        get_DROP_FRAM = read_DROP_FRAM_value
    End Property

    Property Let set_DROP_FRAM(aData)
        write_DROP_FRAM_value = aData
        flag_DROP_FRAM        = &H1
    End Property

    Property Get read_DROP_FRAM
        read
        read_DROP_FRAM = read_DROP_FRAM_value
    End Property

    Property Let write_DROP_FRAM(aData)
        set_DROP_FRAM = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DROP_FRAM_mask = &Hff
        if data_low > LONG_MAX then
            if DROP_FRAM_mask = mask then
                read_DROP_FRAM_value = data_low
            else
                read_DROP_FRAM_value = (data_low - H8000_0000) and DROP_FRAM_mask
            end If
        else
            read_DROP_FRAM_value = data_low and DROP_FRAM_mask
        end If

    End Sub

    Sub write
        If flag_DROP_FRAM = &H0 Then read
        If flag_DROP_FRAM = &H0 Then write_DROP_FRAM_value = get_DROP_FRAM

        regValue = leftShift((write_DROP_FRAM_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DROP_FRAM_mask = &Hff
        if data_low > LONG_MAX then
            if DROP_FRAM_mask = mask then
                read_DROP_FRAM_value = data_low
            else
                read_DROP_FRAM_value = (data_low - H8000_0000) and DROP_FRAM_mask
            end If
        else
            read_DROP_FRAM_value = data_low and DROP_FRAM_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DROP_FRAM_value = &H0
        flag_DROP_FRAM        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO_redir_debug_sa_24_ctr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DROP_FRAM                                  [7:0]            get_DROP_FRAM
''                                                             set_DROP_FRAM
''                                                             read_DROP_FRAM
''                                                             write_DROP_FRAM
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO_redir_debug_sa_24_ctr
    Private write_DROP_FRAM_value
    Private read_DROP_FRAM_value
    Private flag_DROP_FRAM

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H20aa0
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_DROP_FRAM
        get_DROP_FRAM = read_DROP_FRAM_value
    End Property

    Property Let set_DROP_FRAM(aData)
        write_DROP_FRAM_value = aData
        flag_DROP_FRAM        = &H1
    End Property

    Property Get read_DROP_FRAM
        read
        read_DROP_FRAM = read_DROP_FRAM_value
    End Property

    Property Let write_DROP_FRAM(aData)
        set_DROP_FRAM = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DROP_FRAM_mask = &Hff
        if data_low > LONG_MAX then
            if DROP_FRAM_mask = mask then
                read_DROP_FRAM_value = data_low
            else
                read_DROP_FRAM_value = (data_low - H8000_0000) and DROP_FRAM_mask
            end If
        else
            read_DROP_FRAM_value = data_low and DROP_FRAM_mask
        end If

    End Sub

    Sub write
        If flag_DROP_FRAM = &H0 Then read
        If flag_DROP_FRAM = &H0 Then write_DROP_FRAM_value = get_DROP_FRAM

        regValue = leftShift((write_DROP_FRAM_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DROP_FRAM_mask = &Hff
        if data_low > LONG_MAX then
            if DROP_FRAM_mask = mask then
                read_DROP_FRAM_value = data_low
            else
                read_DROP_FRAM_value = (data_low - H8000_0000) and DROP_FRAM_mask
            end If
        else
            read_DROP_FRAM_value = data_low and DROP_FRAM_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DROP_FRAM_value = &H0
        flag_DROP_FRAM        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO_redir_debug_sa_25_ctr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DROP_FRAM                                  [7:0]            get_DROP_FRAM
''                                                             set_DROP_FRAM
''                                                             read_DROP_FRAM
''                                                             write_DROP_FRAM
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO_redir_debug_sa_25_ctr
    Private write_DROP_FRAM_value
    Private read_DROP_FRAM_value
    Private flag_DROP_FRAM

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H20aa4
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_DROP_FRAM
        get_DROP_FRAM = read_DROP_FRAM_value
    End Property

    Property Let set_DROP_FRAM(aData)
        write_DROP_FRAM_value = aData
        flag_DROP_FRAM        = &H1
    End Property

    Property Get read_DROP_FRAM
        read
        read_DROP_FRAM = read_DROP_FRAM_value
    End Property

    Property Let write_DROP_FRAM(aData)
        set_DROP_FRAM = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DROP_FRAM_mask = &Hff
        if data_low > LONG_MAX then
            if DROP_FRAM_mask = mask then
                read_DROP_FRAM_value = data_low
            else
                read_DROP_FRAM_value = (data_low - H8000_0000) and DROP_FRAM_mask
            end If
        else
            read_DROP_FRAM_value = data_low and DROP_FRAM_mask
        end If

    End Sub

    Sub write
        If flag_DROP_FRAM = &H0 Then read
        If flag_DROP_FRAM = &H0 Then write_DROP_FRAM_value = get_DROP_FRAM

        regValue = leftShift((write_DROP_FRAM_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DROP_FRAM_mask = &Hff
        if data_low > LONG_MAX then
            if DROP_FRAM_mask = mask then
                read_DROP_FRAM_value = data_low
            else
                read_DROP_FRAM_value = (data_low - H8000_0000) and DROP_FRAM_mask
            end If
        else
            read_DROP_FRAM_value = data_low and DROP_FRAM_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DROP_FRAM_value = &H0
        flag_DROP_FRAM        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO_redir_debug_sa_26_ctr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DROP_FRAM                                  [7:0]            get_DROP_FRAM
''                                                             set_DROP_FRAM
''                                                             read_DROP_FRAM
''                                                             write_DROP_FRAM
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO_redir_debug_sa_26_ctr
    Private write_DROP_FRAM_value
    Private read_DROP_FRAM_value
    Private flag_DROP_FRAM

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H20aa8
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_DROP_FRAM
        get_DROP_FRAM = read_DROP_FRAM_value
    End Property

    Property Let set_DROP_FRAM(aData)
        write_DROP_FRAM_value = aData
        flag_DROP_FRAM        = &H1
    End Property

    Property Get read_DROP_FRAM
        read
        read_DROP_FRAM = read_DROP_FRAM_value
    End Property

    Property Let write_DROP_FRAM(aData)
        set_DROP_FRAM = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DROP_FRAM_mask = &Hff
        if data_low > LONG_MAX then
            if DROP_FRAM_mask = mask then
                read_DROP_FRAM_value = data_low
            else
                read_DROP_FRAM_value = (data_low - H8000_0000) and DROP_FRAM_mask
            end If
        else
            read_DROP_FRAM_value = data_low and DROP_FRAM_mask
        end If

    End Sub

    Sub write
        If flag_DROP_FRAM = &H0 Then read
        If flag_DROP_FRAM = &H0 Then write_DROP_FRAM_value = get_DROP_FRAM

        regValue = leftShift((write_DROP_FRAM_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DROP_FRAM_mask = &Hff
        if data_low > LONG_MAX then
            if DROP_FRAM_mask = mask then
                read_DROP_FRAM_value = data_low
            else
                read_DROP_FRAM_value = (data_low - H8000_0000) and DROP_FRAM_mask
            end If
        else
            read_DROP_FRAM_value = data_low and DROP_FRAM_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DROP_FRAM_value = &H0
        flag_DROP_FRAM        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO_redir_debug_sa_27_ctr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DROP_FRAM                                  [7:0]            get_DROP_FRAM
''                                                             set_DROP_FRAM
''                                                             read_DROP_FRAM
''                                                             write_DROP_FRAM
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO_redir_debug_sa_27_ctr
    Private write_DROP_FRAM_value
    Private read_DROP_FRAM_value
    Private flag_DROP_FRAM

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H20aac
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_DROP_FRAM
        get_DROP_FRAM = read_DROP_FRAM_value
    End Property

    Property Let set_DROP_FRAM(aData)
        write_DROP_FRAM_value = aData
        flag_DROP_FRAM        = &H1
    End Property

    Property Get read_DROP_FRAM
        read
        read_DROP_FRAM = read_DROP_FRAM_value
    End Property

    Property Let write_DROP_FRAM(aData)
        set_DROP_FRAM = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DROP_FRAM_mask = &Hff
        if data_low > LONG_MAX then
            if DROP_FRAM_mask = mask then
                read_DROP_FRAM_value = data_low
            else
                read_DROP_FRAM_value = (data_low - H8000_0000) and DROP_FRAM_mask
            end If
        else
            read_DROP_FRAM_value = data_low and DROP_FRAM_mask
        end If

    End Sub

    Sub write
        If flag_DROP_FRAM = &H0 Then read
        If flag_DROP_FRAM = &H0 Then write_DROP_FRAM_value = get_DROP_FRAM

        regValue = leftShift((write_DROP_FRAM_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DROP_FRAM_mask = &Hff
        if data_low > LONG_MAX then
            if DROP_FRAM_mask = mask then
                read_DROP_FRAM_value = data_low
            else
                read_DROP_FRAM_value = (data_low - H8000_0000) and DROP_FRAM_mask
            end If
        else
            read_DROP_FRAM_value = data_low and DROP_FRAM_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DROP_FRAM_value = &H0
        flag_DROP_FRAM        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO_redir_debug_sa_28_ctr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DROP_FRAM                                  [7:0]            get_DROP_FRAM
''                                                             set_DROP_FRAM
''                                                             read_DROP_FRAM
''                                                             write_DROP_FRAM
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO_redir_debug_sa_28_ctr
    Private write_DROP_FRAM_value
    Private read_DROP_FRAM_value
    Private flag_DROP_FRAM

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H20ab0
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_DROP_FRAM
        get_DROP_FRAM = read_DROP_FRAM_value
    End Property

    Property Let set_DROP_FRAM(aData)
        write_DROP_FRAM_value = aData
        flag_DROP_FRAM        = &H1
    End Property

    Property Get read_DROP_FRAM
        read
        read_DROP_FRAM = read_DROP_FRAM_value
    End Property

    Property Let write_DROP_FRAM(aData)
        set_DROP_FRAM = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DROP_FRAM_mask = &Hff
        if data_low > LONG_MAX then
            if DROP_FRAM_mask = mask then
                read_DROP_FRAM_value = data_low
            else
                read_DROP_FRAM_value = (data_low - H8000_0000) and DROP_FRAM_mask
            end If
        else
            read_DROP_FRAM_value = data_low and DROP_FRAM_mask
        end If

    End Sub

    Sub write
        If flag_DROP_FRAM = &H0 Then read
        If flag_DROP_FRAM = &H0 Then write_DROP_FRAM_value = get_DROP_FRAM

        regValue = leftShift((write_DROP_FRAM_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DROP_FRAM_mask = &Hff
        if data_low > LONG_MAX then
            if DROP_FRAM_mask = mask then
                read_DROP_FRAM_value = data_low
            else
                read_DROP_FRAM_value = (data_low - H8000_0000) and DROP_FRAM_mask
            end If
        else
            read_DROP_FRAM_value = data_low and DROP_FRAM_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DROP_FRAM_value = &H0
        flag_DROP_FRAM        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO_redir_debug_sa_29_ctr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DROP_FRAM                                  [7:0]            get_DROP_FRAM
''                                                             set_DROP_FRAM
''                                                             read_DROP_FRAM
''                                                             write_DROP_FRAM
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO_redir_debug_sa_29_ctr
    Private write_DROP_FRAM_value
    Private read_DROP_FRAM_value
    Private flag_DROP_FRAM

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H20ab4
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_DROP_FRAM
        get_DROP_FRAM = read_DROP_FRAM_value
    End Property

    Property Let set_DROP_FRAM(aData)
        write_DROP_FRAM_value = aData
        flag_DROP_FRAM        = &H1
    End Property

    Property Get read_DROP_FRAM
        read
        read_DROP_FRAM = read_DROP_FRAM_value
    End Property

    Property Let write_DROP_FRAM(aData)
        set_DROP_FRAM = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DROP_FRAM_mask = &Hff
        if data_low > LONG_MAX then
            if DROP_FRAM_mask = mask then
                read_DROP_FRAM_value = data_low
            else
                read_DROP_FRAM_value = (data_low - H8000_0000) and DROP_FRAM_mask
            end If
        else
            read_DROP_FRAM_value = data_low and DROP_FRAM_mask
        end If

    End Sub

    Sub write
        If flag_DROP_FRAM = &H0 Then read
        If flag_DROP_FRAM = &H0 Then write_DROP_FRAM_value = get_DROP_FRAM

        regValue = leftShift((write_DROP_FRAM_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DROP_FRAM_mask = &Hff
        if data_low > LONG_MAX then
            if DROP_FRAM_mask = mask then
                read_DROP_FRAM_value = data_low
            else
                read_DROP_FRAM_value = (data_low - H8000_0000) and DROP_FRAM_mask
            end If
        else
            read_DROP_FRAM_value = data_low and DROP_FRAM_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DROP_FRAM_value = &H0
        flag_DROP_FRAM        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO_redir_debug_sa_30_ctr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DROP_FRAM                                  [7:0]            get_DROP_FRAM
''                                                             set_DROP_FRAM
''                                                             read_DROP_FRAM
''                                                             write_DROP_FRAM
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO_redir_debug_sa_30_ctr
    Private write_DROP_FRAM_value
    Private read_DROP_FRAM_value
    Private flag_DROP_FRAM

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H20ab8
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_DROP_FRAM
        get_DROP_FRAM = read_DROP_FRAM_value
    End Property

    Property Let set_DROP_FRAM(aData)
        write_DROP_FRAM_value = aData
        flag_DROP_FRAM        = &H1
    End Property

    Property Get read_DROP_FRAM
        read
        read_DROP_FRAM = read_DROP_FRAM_value
    End Property

    Property Let write_DROP_FRAM(aData)
        set_DROP_FRAM = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DROP_FRAM_mask = &Hff
        if data_low > LONG_MAX then
            if DROP_FRAM_mask = mask then
                read_DROP_FRAM_value = data_low
            else
                read_DROP_FRAM_value = (data_low - H8000_0000) and DROP_FRAM_mask
            end If
        else
            read_DROP_FRAM_value = data_low and DROP_FRAM_mask
        end If

    End Sub

    Sub write
        If flag_DROP_FRAM = &H0 Then read
        If flag_DROP_FRAM = &H0 Then write_DROP_FRAM_value = get_DROP_FRAM

        regValue = leftShift((write_DROP_FRAM_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DROP_FRAM_mask = &Hff
        if data_low > LONG_MAX then
            if DROP_FRAM_mask = mask then
                read_DROP_FRAM_value = data_low
            else
                read_DROP_FRAM_value = (data_low - H8000_0000) and DROP_FRAM_mask
            end If
        else
            read_DROP_FRAM_value = data_low and DROP_FRAM_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DROP_FRAM_value = &H0
        flag_DROP_FRAM        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO_redir_debug_sa_31_ctr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DROP_FRAM                                  [7:0]            get_DROP_FRAM
''                                                             set_DROP_FRAM
''                                                             read_DROP_FRAM
''                                                             write_DROP_FRAM
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO_redir_debug_sa_31_ctr
    Private write_DROP_FRAM_value
    Private read_DROP_FRAM_value
    Private flag_DROP_FRAM

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H20abc
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_DROP_FRAM
        get_DROP_FRAM = read_DROP_FRAM_value
    End Property

    Property Let set_DROP_FRAM(aData)
        write_DROP_FRAM_value = aData
        flag_DROP_FRAM        = &H1
    End Property

    Property Get read_DROP_FRAM
        read
        read_DROP_FRAM = read_DROP_FRAM_value
    End Property

    Property Let write_DROP_FRAM(aData)
        set_DROP_FRAM = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DROP_FRAM_mask = &Hff
        if data_low > LONG_MAX then
            if DROP_FRAM_mask = mask then
                read_DROP_FRAM_value = data_low
            else
                read_DROP_FRAM_value = (data_low - H8000_0000) and DROP_FRAM_mask
            end If
        else
            read_DROP_FRAM_value = data_low and DROP_FRAM_mask
        end If

    End Sub

    Sub write
        If flag_DROP_FRAM = &H0 Then read
        If flag_DROP_FRAM = &H0 Then write_DROP_FRAM_value = get_DROP_FRAM

        regValue = leftShift((write_DROP_FRAM_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DROP_FRAM_mask = &Hff
        if data_low > LONG_MAX then
            if DROP_FRAM_mask = mask then
                read_DROP_FRAM_value = data_low
            else
                read_DROP_FRAM_value = (data_low - H8000_0000) and DROP_FRAM_mask
            end If
        else
            read_DROP_FRAM_value = data_low and DROP_FRAM_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DROP_FRAM_value = &H0
        flag_DROP_FRAM        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO_INSTANCE

    Public redir_debug_ctrl
    Public redir_debug_depth
    Public redir_debug_nosa_ctr
    Public redir_debug_sa_0_ctr
    Public redir_debug_sa_1_ctr
    Public redir_debug_sa_2_ctr
    Public redir_debug_sa_3_ctr
    Public redir_debug_sa_4_ctr
    Public redir_debug_sa_5_ctr
    Public redir_debug_sa_6_ctr
    Public redir_debug_sa_7_ctr
    Public redir_debug_sa_8_ctr
    Public redir_debug_sa_9_ctr
    Public redir_debug_sa_10_ctr
    Public redir_debug_sa_11_ctr
    Public redir_debug_sa_12_ctr
    Public redir_debug_sa_13_ctr
    Public redir_debug_sa_14_ctr
    Public redir_debug_sa_15_ctr
    Public redir_debug_sa_16_ctr
    Public redir_debug_sa_17_ctr
    Public redir_debug_sa_18_ctr
    Public redir_debug_sa_19_ctr
    Public redir_debug_sa_20_ctr
    Public redir_debug_sa_21_ctr
    Public redir_debug_sa_22_ctr
    Public redir_debug_sa_23_ctr
    Public redir_debug_sa_24_ctr
    Public redir_debug_sa_25_ctr
    Public redir_debug_sa_26_ctr
    Public redir_debug_sa_27_ctr
    Public redir_debug_sa_28_ctr
    Public redir_debug_sa_29_ctr
    Public redir_debug_sa_30_ctr
    Public redir_debug_sa_31_ctr


    Public default function Init(aBaseAddr)
        Set redir_debug_ctrl = (New REGISTER_EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO_redir_debug_ctrl)(aBaseAddr, 32)
        Set redir_debug_depth = (New REGISTER_EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO_redir_debug_depth)(aBaseAddr, 32)
        Set redir_debug_nosa_ctr = (New REGISTER_EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO_redir_debug_nosa_ctr)(aBaseAddr, 32)
        Set redir_debug_sa_0_ctr = (New REGISTER_EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO_redir_debug_sa_0_ctr)(aBaseAddr, 32)
        Set redir_debug_sa_1_ctr = (New REGISTER_EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO_redir_debug_sa_1_ctr)(aBaseAddr, 32)
        Set redir_debug_sa_2_ctr = (New REGISTER_EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO_redir_debug_sa_2_ctr)(aBaseAddr, 32)
        Set redir_debug_sa_3_ctr = (New REGISTER_EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO_redir_debug_sa_3_ctr)(aBaseAddr, 32)
        Set redir_debug_sa_4_ctr = (New REGISTER_EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO_redir_debug_sa_4_ctr)(aBaseAddr, 32)
        Set redir_debug_sa_5_ctr = (New REGISTER_EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO_redir_debug_sa_5_ctr)(aBaseAddr, 32)
        Set redir_debug_sa_6_ctr = (New REGISTER_EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO_redir_debug_sa_6_ctr)(aBaseAddr, 32)
        Set redir_debug_sa_7_ctr = (New REGISTER_EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO_redir_debug_sa_7_ctr)(aBaseAddr, 32)
        Set redir_debug_sa_8_ctr = (New REGISTER_EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO_redir_debug_sa_8_ctr)(aBaseAddr, 32)
        Set redir_debug_sa_9_ctr = (New REGISTER_EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO_redir_debug_sa_9_ctr)(aBaseAddr, 32)
        Set redir_debug_sa_10_ctr = (New REGISTER_EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO_redir_debug_sa_10_ctr)(aBaseAddr, 32)
        Set redir_debug_sa_11_ctr = (New REGISTER_EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO_redir_debug_sa_11_ctr)(aBaseAddr, 32)
        Set redir_debug_sa_12_ctr = (New REGISTER_EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO_redir_debug_sa_12_ctr)(aBaseAddr, 32)
        Set redir_debug_sa_13_ctr = (New REGISTER_EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO_redir_debug_sa_13_ctr)(aBaseAddr, 32)
        Set redir_debug_sa_14_ctr = (New REGISTER_EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO_redir_debug_sa_14_ctr)(aBaseAddr, 32)
        Set redir_debug_sa_15_ctr = (New REGISTER_EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO_redir_debug_sa_15_ctr)(aBaseAddr, 32)
        Set redir_debug_sa_16_ctr = (New REGISTER_EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO_redir_debug_sa_16_ctr)(aBaseAddr, 32)
        Set redir_debug_sa_17_ctr = (New REGISTER_EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO_redir_debug_sa_17_ctr)(aBaseAddr, 32)
        Set redir_debug_sa_18_ctr = (New REGISTER_EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO_redir_debug_sa_18_ctr)(aBaseAddr, 32)
        Set redir_debug_sa_19_ctr = (New REGISTER_EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO_redir_debug_sa_19_ctr)(aBaseAddr, 32)
        Set redir_debug_sa_20_ctr = (New REGISTER_EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO_redir_debug_sa_20_ctr)(aBaseAddr, 32)
        Set redir_debug_sa_21_ctr = (New REGISTER_EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO_redir_debug_sa_21_ctr)(aBaseAddr, 32)
        Set redir_debug_sa_22_ctr = (New REGISTER_EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO_redir_debug_sa_22_ctr)(aBaseAddr, 32)
        Set redir_debug_sa_23_ctr = (New REGISTER_EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO_redir_debug_sa_23_ctr)(aBaseAddr, 32)
        Set redir_debug_sa_24_ctr = (New REGISTER_EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO_redir_debug_sa_24_ctr)(aBaseAddr, 32)
        Set redir_debug_sa_25_ctr = (New REGISTER_EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO_redir_debug_sa_25_ctr)(aBaseAddr, 32)
        Set redir_debug_sa_26_ctr = (New REGISTER_EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO_redir_debug_sa_26_ctr)(aBaseAddr, 32)
        Set redir_debug_sa_27_ctr = (New REGISTER_EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO_redir_debug_sa_27_ctr)(aBaseAddr, 32)
        Set redir_debug_sa_28_ctr = (New REGISTER_EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO_redir_debug_sa_28_ctr)(aBaseAddr, 32)
        Set redir_debug_sa_29_ctr = (New REGISTER_EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO_redir_debug_sa_29_ctr)(aBaseAddr, 32)
        Set redir_debug_sa_30_ctr = (New REGISTER_EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO_redir_debug_sa_30_ctr)(aBaseAddr, 32)
        Set redir_debug_sa_31_ctr = (New REGISTER_EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO_redir_debug_sa_31_ctr)(aBaseAddr, 32)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO = CreateObject("System.Collections.ArrayList")
EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO.Add ((New EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO_INSTANCE)(&H4d010000))
EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO.Add ((New EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO_INSTANCE)(&H4d110000))
EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO.Add ((New EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO_INSTANCE)(&H4d210000))
EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO.Add ((New EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO_INSTANCE)(&H4d310000))
EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO.Add ((New EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO_INSTANCE)(&H4d410000))
EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO.Add ((New EIP165S_EIP_165S_32_BRCM_EIP165_REDIRECTFIFO_INSTANCE)(&H4d510000))


