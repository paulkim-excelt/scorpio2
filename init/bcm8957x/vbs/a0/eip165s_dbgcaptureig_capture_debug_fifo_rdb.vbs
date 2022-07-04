

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


'' @REGISTER : EIP165S_DBGCAPTUREIG_CAPTURE_DEBUG_FIFO_capt_debug_ctrl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MAX_FRM_SIZE                               [8:2]            get_MAX_FRM_SIZE
''                                                             set_MAX_FRM_SIZE
''                                                             read_MAX_FRM_SIZE
''                                                             write_MAX_FRM_SIZE
''---------------------------------------------------------------------------------
'' FULL                                       [16:16]          get_FULL
''                                                             set_FULL
''                                                             read_FULL
''                                                             write_FULL
''---------------------------------------------------------------------------------
'' WRIT_POIN                                  [24:18]          get_WRIT_POIN
''                                                             set_WRIT_POIN
''                                                             read_WRIT_POIN
''                                                             write_WRIT_POIN
''---------------------------------------------------------------------------------
'' FRAME_COUNT                                [31:25]          get_FRAME_COUNT
''                                                             set_FRAME_COUNT
''                                                             read_FRAME_COUNT
''                                                             write_FRAME_COUNT
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_DBGCAPTUREIG_CAPTURE_DEBUG_FIFO_capt_debug_ctrl
    Private write_MAX_FRM_SIZE_value
    Private read_MAX_FRM_SIZE_value
    Private flag_MAX_FRM_SIZE
    Private write_FULL_value
    Private read_FULL_value
    Private flag_FULL
    Private write_WRIT_POIN_value
    Private read_WRIT_POIN_value
    Private flag_WRIT_POIN
    Private write_FRAME_COUNT_value
    Private read_FRAME_COUNT_value
    Private flag_FRAME_COUNT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H20200
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

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

    Property Get get_FULL
        get_FULL = read_FULL_value
    End Property

    Property Let set_FULL(aData)
        write_FULL_value = aData
        flag_FULL        = &H1
    End Property

    Property Get read_FULL
        read
        read_FULL = read_FULL_value
    End Property

    Property Let write_FULL(aData)
        set_FULL = aData
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

    Property Get get_FRAME_COUNT
        get_FRAME_COUNT = read_FRAME_COUNT_value
    End Property

    Property Let set_FRAME_COUNT(aData)
        write_FRAME_COUNT_value = aData
        flag_FRAME_COUNT        = &H1
    End Property

    Property Get read_FRAME_COUNT
        read
        read_FRAME_COUNT = read_FRAME_COUNT_value
    End Property

    Property Let write_FRAME_COUNT(aData)
        set_FRAME_COUNT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_MAX_FRM_SIZE_value = rightShift(data_low, 2) and &H7f
        read_FULL_value = rightShift(data_low, 16) and &H1
        read_WRIT_POIN_value = rightShift(data_low, 18) and &H7f
        read_FRAME_COUNT_value = rightShift(data_low, 25) and &H7f

    End Sub

    Sub write
        If flag_MAX_FRM_SIZE = &H0 or flag_FULL = &H0 or flag_WRIT_POIN = &H0 or flag_FRAME_COUNT = &H0 Then read
        If flag_MAX_FRM_SIZE = &H0 Then write_MAX_FRM_SIZE_value = get_MAX_FRM_SIZE
        If flag_FULL = &H0 Then write_FULL_value = get_FULL
        If flag_WRIT_POIN = &H0 Then write_WRIT_POIN_value = get_WRIT_POIN
        If flag_FRAME_COUNT = &H0 Then write_FRAME_COUNT_value = get_FRAME_COUNT

        regValue = leftShift((write_MAX_FRM_SIZE_value and &H7f), 2) + leftShift((write_FULL_value and &H1), 16) + leftShift((write_WRIT_POIN_value and &H7f), 18) + leftShift((write_FRAME_COUNT_value and &H7f), 25)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_MAX_FRM_SIZE_value = rightShift(data_low, 2) and &H7f
        read_FULL_value = rightShift(data_low, 16) and &H1
        read_WRIT_POIN_value = rightShift(data_low, 18) and &H7f
        read_FRAME_COUNT_value = rightShift(data_low, 25) and &H7f

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MAX_FRM_SIZE_value = &H0
        flag_MAX_FRM_SIZE        = &H0
        write_FULL_value = &H0
        flag_FULL        = &H0
        write_WRIT_POIN_value = &H0
        flag_WRIT_POIN        = &H0
        write_FRAME_COUNT_value = &H0
        flag_FRAME_COUNT        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_DBGCAPTUREIG_CAPTURE_DEBUG_FIFO_capt_debug_enable
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' enable                                     [0:0]            get_enable
''                                                             set_enable
''                                                             read_enable
''                                                             write_enable
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_DBGCAPTUREIG_CAPTURE_DEBUG_FIFO_capt_debug_enable
    Private write_enable_value
    Private read_enable_value
    Private flag_enable

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H20204
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_enable
        get_enable = read_enable_value
    End Property

    Property Let set_enable(aData)
        write_enable_value = aData
        flag_enable        = &H1
    End Property

    Property Get read_enable
        read
        read_enable = read_enable_value
    End Property

    Property Let write_enable(aData)
        set_enable = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        enable_mask = &H1
        if data_low > LONG_MAX then
            if enable_mask = mask then
                read_enable_value = data_low
            else
                read_enable_value = (data_low - H8000_0000) and enable_mask
            end If
        else
            read_enable_value = data_low and enable_mask
        end If

    End Sub

    Sub write
        If flag_enable = &H0 Then read
        If flag_enable = &H0 Then write_enable_value = get_enable

        regValue = leftShift((write_enable_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        enable_mask = &H1
        if data_low > LONG_MAX then
            if enable_mask = mask then
                read_enable_value = data_low
            else
                read_enable_value = (data_low - H8000_0000) and enable_mask
            end If
        else
            read_enable_value = data_low and enable_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_enable_value = &H0
        flag_enable        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_DBGCAPTUREIG_CAPTURE_DEBUG_FIFO_capt_debug_buf_ovf_cntr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DROP_FRAM                                  [15:0]           get_DROP_FRAM
''                                                             set_DROP_FRAM
''                                                             read_DROP_FRAM
''                                                             write_DROP_FRAM
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_DBGCAPTUREIG_CAPTURE_DEBUG_FIFO_capt_debug_buf_ovf_cntr
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
        offset = &H20240
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
        DROP_FRAM_mask = &Hffff
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

        regValue = leftShift((write_DROP_FRAM_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DROP_FRAM_mask = &Hffff
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


'' @REGISTER : EIP165S_DBGCAPTUREIG_CAPTURE_DEBUG_FIFO_capt_debug_err_cntr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DROP_FRAM                                  [15:0]           get_DROP_FRAM
''                                                             set_DROP_FRAM
''                                                             read_DROP_FRAM
''                                                             write_DROP_FRAM
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_DBGCAPTUREIG_CAPTURE_DEBUG_FIFO_capt_debug_err_cntr
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
        offset = &H20244
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
        DROP_FRAM_mask = &Hffff
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

        regValue = leftShift((write_DROP_FRAM_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DROP_FRAM_mask = &Hffff
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

Class EIP165S_DBGCAPTUREIG_CAPTURE_DEBUG_FIFO_INSTANCE

    Public capt_debug_ctrl
    Public capt_debug_enable
    Public capt_debug_buf_ovf_cntr
    Public capt_debug_err_cntr


    Public default function Init(aBaseAddr)
        Set capt_debug_ctrl = (New REGISTER_EIP165S_DBGCAPTUREIG_CAPTURE_DEBUG_FIFO_capt_debug_ctrl)(aBaseAddr, 32)
        Set capt_debug_enable = (New REGISTER_EIP165S_DBGCAPTUREIG_CAPTURE_DEBUG_FIFO_capt_debug_enable)(aBaseAddr, 32)
        Set capt_debug_buf_ovf_cntr = (New REGISTER_EIP165S_DBGCAPTUREIG_CAPTURE_DEBUG_FIFO_capt_debug_buf_ovf_cntr)(aBaseAddr, 32)
        Set capt_debug_err_cntr = (New REGISTER_EIP165S_DBGCAPTUREIG_CAPTURE_DEBUG_FIFO_capt_debug_err_cntr)(aBaseAddr, 32)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set EIP165S_DBGCAPTUREIG_CAPTURE_DEBUG_FIFO = CreateObject("System.Collections.ArrayList")
EIP165S_DBGCAPTUREIG_CAPTURE_DEBUG_FIFO.Add ((New EIP165S_DBGCAPTUREIG_CAPTURE_DEBUG_FIFO_INSTANCE)(&H4d010000))
EIP165S_DBGCAPTUREIG_CAPTURE_DEBUG_FIFO.Add ((New EIP165S_DBGCAPTUREIG_CAPTURE_DEBUG_FIFO_INSTANCE)(&H4d110000))
EIP165S_DBGCAPTUREIG_CAPTURE_DEBUG_FIFO.Add ((New EIP165S_DBGCAPTUREIG_CAPTURE_DEBUG_FIFO_INSTANCE)(&H4d210000))
EIP165S_DBGCAPTUREIG_CAPTURE_DEBUG_FIFO.Add ((New EIP165S_DBGCAPTUREIG_CAPTURE_DEBUG_FIFO_INSTANCE)(&H4d310000))
EIP165S_DBGCAPTUREIG_CAPTURE_DEBUG_FIFO.Add ((New EIP165S_DBGCAPTUREIG_CAPTURE_DEBUG_FIFO_INSTANCE)(&H4d410000))
EIP165S_DBGCAPTUREIG_CAPTURE_DEBUG_FIFO.Add ((New EIP165S_DBGCAPTUREIG_CAPTURE_DEBUG_FIFO_INSTANCE)(&H4d510000))


