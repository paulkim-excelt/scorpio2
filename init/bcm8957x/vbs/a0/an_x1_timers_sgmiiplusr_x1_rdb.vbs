

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


'' @REGISTER : AN_X1_TIMERS_SGMIIPLUSR_X1_cl37_restart
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' C37RTP                                     [15:0]           get_C37RTP
''                                                             set_C37RTP
''                                                             read_C37RTP
''                                                             write_C37RTP
''---------------------------------------------------------------------------------
Class REGISTER_AN_X1_TIMERS_SGMIIPLUSR_X1_cl37_restart
    Private write_C37RTP_value
    Private read_C37RTP_value
    Private flag_C37RTP

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

    Property Get get_C37RTP
        get_C37RTP = read_C37RTP_value
    End Property

    Property Let set_C37RTP(aData)
        write_C37RTP_value = aData
        flag_C37RTP        = &H1
    End Property

    Property Get read_C37RTP
        read
        read_C37RTP = read_C37RTP_value
    End Property

    Property Let write_C37RTP(aData)
        set_C37RTP = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        C37RTP_mask = &Hffff
        if data_low > LONG_MAX then
            if C37RTP_mask = mask then
                read_C37RTP_value = data_low
            else
                read_C37RTP_value = (data_low - H8000_0000) and C37RTP_mask
            end If
        else
            read_C37RTP_value = data_low and C37RTP_mask
        end If

    End Sub

    Sub write
        If flag_C37RTP = &H0 Then read
        If flag_C37RTP = &H0 Then write_C37RTP_value = get_C37RTP

        regValue = leftShift((write_C37RTP_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        C37RTP_mask = &Hffff
        if data_low > LONG_MAX then
            if C37RTP_mask = mask then
                read_C37RTP_value = data_low
            else
                read_C37RTP_value = (data_low - H8000_0000) and C37RTP_mask
            end If
        else
            read_C37RTP_value = data_low and C37RTP_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_C37RTP_value = &H0
        flag_C37RTP        = &H0
    End Sub
End Class


'' @REGISTER : AN_X1_TIMERS_SGMIIPLUSR_X1_cl37_ack
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' cl37_ack_timer_period                      [15:0]           get_cl37_ack_timer_period
''                                                             set_cl37_ack_timer_period
''                                                             read_cl37_ack_timer_period
''                                                             write_cl37_ack_timer_period
''---------------------------------------------------------------------------------
Class REGISTER_AN_X1_TIMERS_SGMIIPLUSR_X1_cl37_ack
    Private write_cl37_ack_timer_period_value
    Private read_cl37_ack_timer_period_value
    Private flag_cl37_ack_timer_period

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

    Property Get get_cl37_ack_timer_period
        get_cl37_ack_timer_period = read_cl37_ack_timer_period_value
    End Property

    Property Let set_cl37_ack_timer_period(aData)
        write_cl37_ack_timer_period_value = aData
        flag_cl37_ack_timer_period        = &H1
    End Property

    Property Get read_cl37_ack_timer_period
        read
        read_cl37_ack_timer_period = read_cl37_ack_timer_period_value
    End Property

    Property Let write_cl37_ack_timer_period(aData)
        set_cl37_ack_timer_period = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        cl37_ack_timer_period_mask = &Hffff
        if data_low > LONG_MAX then
            if cl37_ack_timer_period_mask = mask then
                read_cl37_ack_timer_period_value = data_low
            else
                read_cl37_ack_timer_period_value = (data_low - H8000_0000) and cl37_ack_timer_period_mask
            end If
        else
            read_cl37_ack_timer_period_value = data_low and cl37_ack_timer_period_mask
        end If

    End Sub

    Sub write
        If flag_cl37_ack_timer_period = &H0 Then read
        If flag_cl37_ack_timer_period = &H0 Then write_cl37_ack_timer_period_value = get_cl37_ack_timer_period

        regValue = leftShift((write_cl37_ack_timer_period_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        cl37_ack_timer_period_mask = &Hffff
        if data_low > LONG_MAX then
            if cl37_ack_timer_period_mask = mask then
                read_cl37_ack_timer_period_value = data_low
            else
                read_cl37_ack_timer_period_value = (data_low - H8000_0000) and cl37_ack_timer_period_mask
            end If
        else
            read_cl37_ack_timer_period_value = data_low and cl37_ack_timer_period_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_cl37_ack_timer_period_value = &H0
        flag_cl37_ack_timer_period        = &H0
    End Sub
End Class


'' @REGISTER : AN_X1_TIMERS_SGMIIPLUSR_X1_cl37_error
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' cl37_error_timer_period                    [15:0]           get_cl37_error_timer_period
''                                                             set_cl37_error_timer_period
''                                                             read_cl37_error_timer_period
''                                                             write_cl37_error_timer_period
''---------------------------------------------------------------------------------
Class REGISTER_AN_X1_TIMERS_SGMIIPLUSR_X1_cl37_error
    Private write_cl37_error_timer_period_value
    Private read_cl37_error_timer_period_value
    Private flag_cl37_error_timer_period

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

    Property Get get_cl37_error_timer_period
        get_cl37_error_timer_period = read_cl37_error_timer_period_value
    End Property

    Property Let set_cl37_error_timer_period(aData)
        write_cl37_error_timer_period_value = aData
        flag_cl37_error_timer_period        = &H1
    End Property

    Property Get read_cl37_error_timer_period
        read
        read_cl37_error_timer_period = read_cl37_error_timer_period_value
    End Property

    Property Let write_cl37_error_timer_period(aData)
        set_cl37_error_timer_period = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        cl37_error_timer_period_mask = &Hffff
        if data_low > LONG_MAX then
            if cl37_error_timer_period_mask = mask then
                read_cl37_error_timer_period_value = data_low
            else
                read_cl37_error_timer_period_value = (data_low - H8000_0000) and cl37_error_timer_period_mask
            end If
        else
            read_cl37_error_timer_period_value = data_low and cl37_error_timer_period_mask
        end If

    End Sub

    Sub write
        If flag_cl37_error_timer_period = &H0 Then read
        If flag_cl37_error_timer_period = &H0 Then write_cl37_error_timer_period_value = get_cl37_error_timer_period

        regValue = leftShift((write_cl37_error_timer_period_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        cl37_error_timer_period_mask = &Hffff
        if data_low > LONG_MAX then
            if cl37_error_timer_period_mask = mask then
                read_cl37_error_timer_period_value = data_low
            else
                read_cl37_error_timer_period_value = (data_low - H8000_0000) and cl37_error_timer_period_mask
            end If
        else
            read_cl37_error_timer_period_value = data_low and cl37_error_timer_period_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_cl37_error_timer_period_value = &H0
        flag_cl37_error_timer_period        = &H0
    End Sub
End Class


'' @REGISTER : AN_X1_TIMERS_SGMIIPLUSR_X1_cl73_break_link
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' tx_disable_timer_period                    [15:0]           get_tx_disable_timer_period
''                                                             set_tx_disable_timer_period
''                                                             read_tx_disable_timer_period
''                                                             write_tx_disable_timer_period
''---------------------------------------------------------------------------------
Class REGISTER_AN_X1_TIMERS_SGMIIPLUSR_X1_cl73_break_link
    Private write_tx_disable_timer_period_value
    Private read_tx_disable_timer_period_value
    Private flag_tx_disable_timer_period

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

    Property Get get_tx_disable_timer_period
        get_tx_disable_timer_period = read_tx_disable_timer_period_value
    End Property

    Property Let set_tx_disable_timer_period(aData)
        write_tx_disable_timer_period_value = aData
        flag_tx_disable_timer_period        = &H1
    End Property

    Property Get read_tx_disable_timer_period
        read
        read_tx_disable_timer_period = read_tx_disable_timer_period_value
    End Property

    Property Let write_tx_disable_timer_period(aData)
        set_tx_disable_timer_period = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        tx_disable_timer_period_mask = &Hffff
        if data_low > LONG_MAX then
            if tx_disable_timer_period_mask = mask then
                read_tx_disable_timer_period_value = data_low
            else
                read_tx_disable_timer_period_value = (data_low - H8000_0000) and tx_disable_timer_period_mask
            end If
        else
            read_tx_disable_timer_period_value = data_low and tx_disable_timer_period_mask
        end If

    End Sub

    Sub write
        If flag_tx_disable_timer_period = &H0 Then read
        If flag_tx_disable_timer_period = &H0 Then write_tx_disable_timer_period_value = get_tx_disable_timer_period

        regValue = leftShift((write_tx_disable_timer_period_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        tx_disable_timer_period_mask = &Hffff
        if data_low > LONG_MAX then
            if tx_disable_timer_period_mask = mask then
                read_tx_disable_timer_period_value = data_low
            else
                read_tx_disable_timer_period_value = (data_low - H8000_0000) and tx_disable_timer_period_mask
            end If
        else
            read_tx_disable_timer_period_value = data_low and tx_disable_timer_period_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_tx_disable_timer_period_value = &H0
        flag_tx_disable_timer_period        = &H0
    End Sub
End Class


'' @REGISTER : AN_X1_TIMERS_SGMIIPLUSR_X1_cl73_error
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' cl73_error_timer_period                    [15:0]           get_cl73_error_timer_period
''                                                             set_cl73_error_timer_period
''                                                             read_cl73_error_timer_period
''                                                             write_cl73_error_timer_period
''---------------------------------------------------------------------------------
Class REGISTER_AN_X1_TIMERS_SGMIIPLUSR_X1_cl73_error
    Private write_cl73_error_timer_period_value
    Private read_cl73_error_timer_period_value
    Private flag_cl73_error_timer_period

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

    Property Get get_cl73_error_timer_period
        get_cl73_error_timer_period = read_cl73_error_timer_period_value
    End Property

    Property Let set_cl73_error_timer_period(aData)
        write_cl73_error_timer_period_value = aData
        flag_cl73_error_timer_period        = &H1
    End Property

    Property Get read_cl73_error_timer_period
        read
        read_cl73_error_timer_period = read_cl73_error_timer_period_value
    End Property

    Property Let write_cl73_error_timer_period(aData)
        set_cl73_error_timer_period = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        cl73_error_timer_period_mask = &Hffff
        if data_low > LONG_MAX then
            if cl73_error_timer_period_mask = mask then
                read_cl73_error_timer_period_value = data_low
            else
                read_cl73_error_timer_period_value = (data_low - H8000_0000) and cl73_error_timer_period_mask
            end If
        else
            read_cl73_error_timer_period_value = data_low and cl73_error_timer_period_mask
        end If

    End Sub

    Sub write
        If flag_cl73_error_timer_period = &H0 Then read
        If flag_cl73_error_timer_period = &H0 Then write_cl73_error_timer_period_value = get_cl73_error_timer_period

        regValue = leftShift((write_cl73_error_timer_period_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        cl73_error_timer_period_mask = &Hffff
        if data_low > LONG_MAX then
            if cl73_error_timer_period_mask = mask then
                read_cl73_error_timer_period_value = data_low
            else
                read_cl73_error_timer_period_value = (data_low - H8000_0000) and cl73_error_timer_period_mask
            end If
        else
            read_cl73_error_timer_period_value = data_low and cl73_error_timer_period_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_cl73_error_timer_period_value = &H0
        flag_cl73_error_timer_period        = &H0
    End Sub
End Class


'' @REGISTER : AN_X1_TIMERS_SGMIIPLUSR_X1_cl73_dme_lock
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PDLTP                                      [15:0]           get_PDLTP
''                                                             set_PDLTP
''                                                             read_PDLTP
''                                                             write_PDLTP
''---------------------------------------------------------------------------------
Class REGISTER_AN_X1_TIMERS_SGMIIPLUSR_X1_cl73_dme_lock
    Private write_PDLTP_value
    Private read_PDLTP_value
    Private flag_PDLTP

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

    Property Get get_PDLTP
        get_PDLTP = read_PDLTP_value
    End Property

    Property Let set_PDLTP(aData)
        write_PDLTP_value = aData
        flag_PDLTP        = &H1
    End Property

    Property Get read_PDLTP
        read
        read_PDLTP = read_PDLTP_value
    End Property

    Property Let write_PDLTP(aData)
        set_PDLTP = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PDLTP_mask = &Hffff
        if data_low > LONG_MAX then
            if PDLTP_mask = mask then
                read_PDLTP_value = data_low
            else
                read_PDLTP_value = (data_low - H8000_0000) and PDLTP_mask
            end If
        else
            read_PDLTP_value = data_low and PDLTP_mask
        end If

    End Sub

    Sub write
        If flag_PDLTP = &H0 Then read
        If flag_PDLTP = &H0 Then write_PDLTP_value = get_PDLTP

        regValue = leftShift((write_PDLTP_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PDLTP_mask = &Hffff
        if data_low > LONG_MAX then
            if PDLTP_mask = mask then
                read_PDLTP_value = data_low
            else
                read_PDLTP_value = (data_low - H8000_0000) and PDLTP_mask
            end If
        else
            read_PDLTP_value = data_low and PDLTP_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PDLTP_value = &H0
        flag_PDLTP        = &H0
    End Sub
End Class


'' @REGISTER : AN_X1_TIMERS_SGMIIPLUSR_X1_link_up
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' cl73_link_up_timer_period                  [15:0]           get_cl73_link_up_timer_period
''                                                             set_cl73_link_up_timer_period
''                                                             read_cl73_link_up_timer_period
''                                                             write_cl73_link_up_timer_period
''---------------------------------------------------------------------------------
Class REGISTER_AN_X1_TIMERS_SGMIIPLUSR_X1_link_up
    Private write_cl73_link_up_timer_period_value
    Private read_cl73_link_up_timer_period_value
    Private flag_cl73_link_up_timer_period

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

    Property Get get_cl73_link_up_timer_period
        get_cl73_link_up_timer_period = read_cl73_link_up_timer_period_value
    End Property

    Property Let set_cl73_link_up_timer_period(aData)
        write_cl73_link_up_timer_period_value = aData
        flag_cl73_link_up_timer_period        = &H1
    End Property

    Property Get read_cl73_link_up_timer_period
        read
        read_cl73_link_up_timer_period = read_cl73_link_up_timer_period_value
    End Property

    Property Let write_cl73_link_up_timer_period(aData)
        set_cl73_link_up_timer_period = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        cl73_link_up_timer_period_mask = &Hffff
        if data_low > LONG_MAX then
            if cl73_link_up_timer_period_mask = mask then
                read_cl73_link_up_timer_period_value = data_low
            else
                read_cl73_link_up_timer_period_value = (data_low - H8000_0000) and cl73_link_up_timer_period_mask
            end If
        else
            read_cl73_link_up_timer_period_value = data_low and cl73_link_up_timer_period_mask
        end If

    End Sub

    Sub write
        If flag_cl73_link_up_timer_period = &H0 Then read
        If flag_cl73_link_up_timer_period = &H0 Then write_cl73_link_up_timer_period_value = get_cl73_link_up_timer_period

        regValue = leftShift((write_cl73_link_up_timer_period_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        cl73_link_up_timer_period_mask = &Hffff
        if data_low > LONG_MAX then
            if cl73_link_up_timer_period_mask = mask then
                read_cl73_link_up_timer_period_value = data_low
            else
                read_cl73_link_up_timer_period_value = (data_low - H8000_0000) and cl73_link_up_timer_period_mask
            end If
        else
            read_cl73_link_up_timer_period_value = data_low and cl73_link_up_timer_period_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_cl73_link_up_timer_period_value = &H0
        flag_cl73_link_up_timer_period        = &H0
    End Sub
End Class


'' @REGISTER : AN_X1_TIMERS_SGMIIPLUSR_X1_link_fail_inhibit_timer_cl72
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LFITC72P                                   [15:0]           get_LFITC72P
''                                                             set_LFITC72P
''                                                             read_LFITC72P
''                                                             write_LFITC72P
''---------------------------------------------------------------------------------
Class REGISTER_AN_X1_TIMERS_SGMIIPLUSR_X1_link_fail_inhibit_timer_cl72
    Private write_LFITC72P_value
    Private read_LFITC72P_value
    Private flag_LFITC72P

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

    Property Get get_LFITC72P
        get_LFITC72P = read_LFITC72P_value
    End Property

    Property Let set_LFITC72P(aData)
        write_LFITC72P_value = aData
        flag_LFITC72P        = &H1
    End Property

    Property Get read_LFITC72P
        read
        read_LFITC72P = read_LFITC72P_value
    End Property

    Property Let write_LFITC72P(aData)
        set_LFITC72P = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LFITC72P_mask = &Hffff
        if data_low > LONG_MAX then
            if LFITC72P_mask = mask then
                read_LFITC72P_value = data_low
            else
                read_LFITC72P_value = (data_low - H8000_0000) and LFITC72P_mask
            end If
        else
            read_LFITC72P_value = data_low and LFITC72P_mask
        end If

    End Sub

    Sub write
        If flag_LFITC72P = &H0 Then read
        If flag_LFITC72P = &H0 Then write_LFITC72P_value = get_LFITC72P

        regValue = leftShift((write_LFITC72P_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LFITC72P_mask = &Hffff
        if data_low > LONG_MAX then
            if LFITC72P_mask = mask then
                read_LFITC72P_value = data_low
            else
                read_LFITC72P_value = (data_low - H8000_0000) and LFITC72P_mask
            end If
        else
            read_LFITC72P_value = data_low and LFITC72P_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LFITC72P_value = &H0
        flag_LFITC72P        = &H0
    End Sub
End Class


'' @REGISTER : AN_X1_TIMERS_SGMIIPLUSR_X1_link_fail_inhibit_timer_not_cl72
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LFITN72P                                   [15:0]           get_LFITN72P
''                                                             set_LFITN72P
''                                                             read_LFITN72P
''                                                             write_LFITN72P
''---------------------------------------------------------------------------------
Class REGISTER_AN_X1_TIMERS_SGMIIPLUSR_X1_link_fail_inhibit_timer_not_cl72
    Private write_LFITN72P_value
    Private read_LFITN72P_value
    Private flag_LFITN72P

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

    Property Get get_LFITN72P
        get_LFITN72P = read_LFITN72P_value
    End Property

    Property Let set_LFITN72P(aData)
        write_LFITN72P_value = aData
        flag_LFITN72P        = &H1
    End Property

    Property Get read_LFITN72P
        read
        read_LFITN72P = read_LFITN72P_value
    End Property

    Property Let write_LFITN72P(aData)
        set_LFITN72P = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LFITN72P_mask = &Hffff
        if data_low > LONG_MAX then
            if LFITN72P_mask = mask then
                read_LFITN72P_value = data_low
            else
                read_LFITN72P_value = (data_low - H8000_0000) and LFITN72P_mask
            end If
        else
            read_LFITN72P_value = data_low and LFITN72P_mask
        end If

    End Sub

    Sub write
        If flag_LFITN72P = &H0 Then read
        If flag_LFITN72P = &H0 Then write_LFITN72P_value = get_LFITN72P

        regValue = leftShift((write_LFITN72P_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LFITN72P_mask = &Hffff
        if data_low > LONG_MAX then
            if LFITN72P_mask = mask then
                read_LFITN72P_value = data_low
            else
                read_LFITN72P_value = (data_low - H8000_0000) and LFITN72P_mask
            end If
        else
            read_LFITN72P_value = data_low and LFITN72P_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LFITN72P_value = &H0
        flag_LFITN72P        = &H0
    End Sub
End Class


'' @REGISTER : AN_X1_TIMERS_SGMIIPLUSR_X1_pd_sd_timer
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' pd_sd_timer_period                         [15:0]           get_pd_sd_timer_period
''                                                             set_pd_sd_timer_period
''                                                             read_pd_sd_timer_period
''                                                             write_pd_sd_timer_period
''---------------------------------------------------------------------------------
Class REGISTER_AN_X1_TIMERS_SGMIIPLUSR_X1_pd_sd_timer
    Private write_pd_sd_timer_period_value
    Private read_pd_sd_timer_period_value
    Private flag_pd_sd_timer_period

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

    Property Get get_pd_sd_timer_period
        get_pd_sd_timer_period = read_pd_sd_timer_period_value
    End Property

    Property Let set_pd_sd_timer_period(aData)
        write_pd_sd_timer_period_value = aData
        flag_pd_sd_timer_period        = &H1
    End Property

    Property Get read_pd_sd_timer_period
        read
        read_pd_sd_timer_period = read_pd_sd_timer_period_value
    End Property

    Property Let write_pd_sd_timer_period(aData)
        set_pd_sd_timer_period = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pd_sd_timer_period_mask = &Hffff
        if data_low > LONG_MAX then
            if pd_sd_timer_period_mask = mask then
                read_pd_sd_timer_period_value = data_low
            else
                read_pd_sd_timer_period_value = (data_low - H8000_0000) and pd_sd_timer_period_mask
            end If
        else
            read_pd_sd_timer_period_value = data_low and pd_sd_timer_period_mask
        end If

    End Sub

    Sub write
        If flag_pd_sd_timer_period = &H0 Then read
        If flag_pd_sd_timer_period = &H0 Then write_pd_sd_timer_period_value = get_pd_sd_timer_period

        regValue = leftShift((write_pd_sd_timer_period_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pd_sd_timer_period_mask = &Hffff
        if data_low > LONG_MAX then
            if pd_sd_timer_period_mask = mask then
                read_pd_sd_timer_period_value = data_low
            else
                read_pd_sd_timer_period_value = (data_low - H8000_0000) and pd_sd_timer_period_mask
            end If
        else
            read_pd_sd_timer_period_value = data_low and pd_sd_timer_period_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_pd_sd_timer_period_value = &H0
        flag_pd_sd_timer_period        = &H0
    End Sub
End Class


'' @REGISTER : AN_X1_TIMERS_SGMIIPLUSR_X1_cl72_max_wait_timer
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' C72MWTP                                    [15:0]           get_C72MWTP
''                                                             set_C72MWTP
''                                                             read_C72MWTP
''                                                             write_C72MWTP
''---------------------------------------------------------------------------------
Class REGISTER_AN_X1_TIMERS_SGMIIPLUSR_X1_cl72_max_wait_timer
    Private write_C72MWTP_value
    Private read_C72MWTP_value
    Private flag_C72MWTP

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

    Property Get get_C72MWTP
        get_C72MWTP = read_C72MWTP_value
    End Property

    Property Let set_C72MWTP(aData)
        write_C72MWTP_value = aData
        flag_C72MWTP        = &H1
    End Property

    Property Get read_C72MWTP
        read
        read_C72MWTP = read_C72MWTP_value
    End Property

    Property Let write_C72MWTP(aData)
        set_C72MWTP = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        C72MWTP_mask = &Hffff
        if data_low > LONG_MAX then
            if C72MWTP_mask = mask then
                read_C72MWTP_value = data_low
            else
                read_C72MWTP_value = (data_low - H8000_0000) and C72MWTP_mask
            end If
        else
            read_C72MWTP_value = data_low and C72MWTP_mask
        end If

    End Sub

    Sub write
        If flag_C72MWTP = &H0 Then read
        If flag_C72MWTP = &H0 Then write_C72MWTP_value = get_C72MWTP

        regValue = leftShift((write_C72MWTP_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        C72MWTP_mask = &Hffff
        if data_low > LONG_MAX then
            if C72MWTP_mask = mask then
                read_C72MWTP_value = data_low
            else
                read_C72MWTP_value = (data_low - H8000_0000) and C72MWTP_mask
            end If
        else
            read_C72MWTP_value = data_low and C72MWTP_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_C72MWTP_value = &H0
        flag_C72MWTP        = &H0
    End Sub
End Class


'' @REGISTER : AN_X1_TIMERS_SGMIIPLUSR_X1_cl72_wait_timer
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' cl72_wait_timer_period                     [8:0]            get_cl72_wait_timer_period
''                                                             set_cl72_wait_timer_period
''                                                             read_cl72_wait_timer_period
''                                                             write_cl72_wait_timer_period
''---------------------------------------------------------------------------------
Class REGISTER_AN_X1_TIMERS_SGMIIPLUSR_X1_cl72_wait_timer
    Private write_cl72_wait_timer_period_value
    Private read_cl72_wait_timer_period_value
    Private flag_cl72_wait_timer_period

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

    Property Get get_cl72_wait_timer_period
        get_cl72_wait_timer_period = read_cl72_wait_timer_period_value
    End Property

    Property Let set_cl72_wait_timer_period(aData)
        write_cl72_wait_timer_period_value = aData
        flag_cl72_wait_timer_period        = &H1
    End Property

    Property Get read_cl72_wait_timer_period
        read
        read_cl72_wait_timer_period = read_cl72_wait_timer_period_value
    End Property

    Property Let write_cl72_wait_timer_period(aData)
        set_cl72_wait_timer_period = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        cl72_wait_timer_period_mask = &H1ff
        if data_low > LONG_MAX then
            if cl72_wait_timer_period_mask = mask then
                read_cl72_wait_timer_period_value = data_low
            else
                read_cl72_wait_timer_period_value = (data_low - H8000_0000) and cl72_wait_timer_period_mask
            end If
        else
            read_cl72_wait_timer_period_value = data_low and cl72_wait_timer_period_mask
        end If

    End Sub

    Sub write
        If flag_cl72_wait_timer_period = &H0 Then read
        If flag_cl72_wait_timer_period = &H0 Then write_cl72_wait_timer_period_value = get_cl72_wait_timer_period

        regValue = leftShift((write_cl72_wait_timer_period_value and &H1ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        cl72_wait_timer_period_mask = &H1ff
        if data_low > LONG_MAX then
            if cl72_wait_timer_period_mask = mask then
                read_cl72_wait_timer_period_value = data_low
            else
                read_cl72_wait_timer_period_value = (data_low - H8000_0000) and cl72_wait_timer_period_mask
            end If
        else
            read_cl72_wait_timer_period_value = data_low and cl72_wait_timer_period_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_cl72_wait_timer_period_value = &H0
        flag_cl72_wait_timer_period        = &H0
    End Sub
End Class


'' @REGISTER : AN_X1_TIMERS_SGMIIPLUSR_X1_ignore_link_timer
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ignore_link_timer_period                   [15:0]           get_ignore_link_timer_period
''                                                             set_ignore_link_timer_period
''                                                             read_ignore_link_timer_period
''                                                             write_ignore_link_timer_period
''---------------------------------------------------------------------------------
Class REGISTER_AN_X1_TIMERS_SGMIIPLUSR_X1_ignore_link_timer
    Private write_ignore_link_timer_period_value
    Private read_ignore_link_timer_period_value
    Private flag_ignore_link_timer_period

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

    Property Get get_ignore_link_timer_period
        get_ignore_link_timer_period = read_ignore_link_timer_period_value
    End Property

    Property Let set_ignore_link_timer_period(aData)
        write_ignore_link_timer_period_value = aData
        flag_ignore_link_timer_period        = &H1
    End Property

    Property Get read_ignore_link_timer_period
        read
        read_ignore_link_timer_period = read_ignore_link_timer_period_value
    End Property

    Property Let write_ignore_link_timer_period(aData)
        set_ignore_link_timer_period = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ignore_link_timer_period_mask = &Hffff
        if data_low > LONG_MAX then
            if ignore_link_timer_period_mask = mask then
                read_ignore_link_timer_period_value = data_low
            else
                read_ignore_link_timer_period_value = (data_low - H8000_0000) and ignore_link_timer_period_mask
            end If
        else
            read_ignore_link_timer_period_value = data_low and ignore_link_timer_period_mask
        end If

    End Sub

    Sub write
        If flag_ignore_link_timer_period = &H0 Then read
        If flag_ignore_link_timer_period = &H0 Then write_ignore_link_timer_period_value = get_ignore_link_timer_period

        regValue = leftShift((write_ignore_link_timer_period_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ignore_link_timer_period_mask = &Hffff
        if data_low > LONG_MAX then
            if ignore_link_timer_period_mask = mask then
                read_ignore_link_timer_period_value = data_low
            else
                read_ignore_link_timer_period_value = (data_low - H8000_0000) and ignore_link_timer_period_mask
            end If
        else
            read_ignore_link_timer_period_value = data_low and ignore_link_timer_period_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ignore_link_timer_period_value = &H0
        flag_ignore_link_timer_period        = &H0
    End Sub
End Class


'' @REGISTER : AN_X1_TIMERS_SGMIIPLUSR_X1_dme_page_timer
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' cl73_page_test_max_timer                   [13:7]           get_cl73_page_test_max_timer
''                                                             set_cl73_page_test_max_timer
''                                                             read_cl73_page_test_max_timer
''                                                             write_cl73_page_test_max_timer
''---------------------------------------------------------------------------------
'' cl73_page_test_min_timer                   [6:0]            get_cl73_page_test_min_timer
''                                                             set_cl73_page_test_min_timer
''                                                             read_cl73_page_test_min_timer
''                                                             write_cl73_page_test_min_timer
''---------------------------------------------------------------------------------
Class REGISTER_AN_X1_TIMERS_SGMIIPLUSR_X1_dme_page_timer
    Private write_cl73_page_test_max_timer_value
    Private read_cl73_page_test_max_timer_value
    Private flag_cl73_page_test_max_timer
    Private write_cl73_page_test_min_timer_value
    Private read_cl73_page_test_min_timer_value
    Private flag_cl73_page_test_min_timer

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

    Property Get get_cl73_page_test_max_timer
        get_cl73_page_test_max_timer = read_cl73_page_test_max_timer_value
    End Property

    Property Let set_cl73_page_test_max_timer(aData)
        write_cl73_page_test_max_timer_value = aData
        flag_cl73_page_test_max_timer        = &H1
    End Property

    Property Get read_cl73_page_test_max_timer
        read
        read_cl73_page_test_max_timer = read_cl73_page_test_max_timer_value
    End Property

    Property Let write_cl73_page_test_max_timer(aData)
        set_cl73_page_test_max_timer = aData
        write
    End Property

    Property Get get_cl73_page_test_min_timer
        get_cl73_page_test_min_timer = read_cl73_page_test_min_timer_value
    End Property

    Property Let set_cl73_page_test_min_timer(aData)
        write_cl73_page_test_min_timer_value = aData
        flag_cl73_page_test_min_timer        = &H1
    End Property

    Property Get read_cl73_page_test_min_timer
        read
        read_cl73_page_test_min_timer = read_cl73_page_test_min_timer_value
    End Property

    Property Let write_cl73_page_test_min_timer(aData)
        set_cl73_page_test_min_timer = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_cl73_page_test_max_timer_value = rightShift(data_low, 7) and &H7f
        cl73_page_test_min_timer_mask = &H7f
        if data_low > LONG_MAX then
            if cl73_page_test_min_timer_mask = mask then
                read_cl73_page_test_min_timer_value = data_low
            else
                read_cl73_page_test_min_timer_value = (data_low - H8000_0000) and cl73_page_test_min_timer_mask
            end If
        else
            read_cl73_page_test_min_timer_value = data_low and cl73_page_test_min_timer_mask
        end If

    End Sub

    Sub write
        If flag_cl73_page_test_max_timer = &H0 or flag_cl73_page_test_min_timer = &H0 Then read
        If flag_cl73_page_test_max_timer = &H0 Then write_cl73_page_test_max_timer_value = get_cl73_page_test_max_timer
        If flag_cl73_page_test_min_timer = &H0 Then write_cl73_page_test_min_timer_value = get_cl73_page_test_min_timer

        regValue = leftShift((write_cl73_page_test_max_timer_value and &H7f), 7) + leftShift((write_cl73_page_test_min_timer_value and &H7f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_cl73_page_test_max_timer_value = rightShift(data_low, 7) and &H7f
        cl73_page_test_min_timer_mask = &H7f
        if data_low > LONG_MAX then
            if cl73_page_test_min_timer_mask = mask then
                read_cl73_page_test_min_timer_value = data_low
            else
                read_cl73_page_test_min_timer_value = (data_low - H8000_0000) and cl73_page_test_min_timer_mask
            end If
        else
            read_cl73_page_test_min_timer_value = data_low and cl73_page_test_min_timer_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_cl73_page_test_max_timer_value = &H0
        flag_cl73_page_test_max_timer        = &H0
        write_cl73_page_test_min_timer_value = &H0
        flag_cl73_page_test_min_timer        = &H0
    End Sub
End Class


'' @REGISTER : AN_X1_TIMERS_SGMIIPLUSR_X1_sgmii_cl73_timer_type_sgmiiplusr_x1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' sgmii_timer                                [15:0]           get_sgmii_timer
''                                                             set_sgmii_timer
''                                                             read_sgmii_timer
''                                                             write_sgmii_timer
''---------------------------------------------------------------------------------
Class REGISTER_AN_X1_TIMERS_SGMIIPLUSR_X1_sgmii_cl73_timer_type_sgmiiplusr_x1
    Private write_sgmii_timer_value
    Private read_sgmii_timer_value
    Private flag_sgmii_timer

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

    Property Get get_sgmii_timer
        get_sgmii_timer = read_sgmii_timer_value
    End Property

    Property Let set_sgmii_timer(aData)
        write_sgmii_timer_value = aData
        flag_sgmii_timer        = &H1
    End Property

    Property Get read_sgmii_timer
        read
        read_sgmii_timer = read_sgmii_timer_value
    End Property

    Property Let write_sgmii_timer(aData)
        set_sgmii_timer = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        sgmii_timer_mask = &Hffff
        if data_low > LONG_MAX then
            if sgmii_timer_mask = mask then
                read_sgmii_timer_value = data_low
            else
                read_sgmii_timer_value = (data_low - H8000_0000) and sgmii_timer_mask
            end If
        else
            read_sgmii_timer_value = data_low and sgmii_timer_mask
        end If

    End Sub

    Sub write
        If flag_sgmii_timer = &H0 Then read
        If flag_sgmii_timer = &H0 Then write_sgmii_timer_value = get_sgmii_timer

        regValue = leftShift((write_sgmii_timer_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        sgmii_timer_mask = &Hffff
        if data_low > LONG_MAX then
            if sgmii_timer_mask = mask then
                read_sgmii_timer_value = data_low
            else
                read_sgmii_timer_value = (data_low - H8000_0000) and sgmii_timer_mask
            end If
        else
            read_sgmii_timer_value = data_low and sgmii_timer_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_sgmii_timer_value = &H0
        flag_sgmii_timer        = &H0
    End Sub
End Class


'' @REGISTER : AN_X1_TIMERS_SGMIIPLUSR_X1_blockaddress
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' BlockAddress                               [14:4]           get_BlockAddress
''                                                             set_BlockAddress
''                                                             read_BlockAddress
''                                                             write_BlockAddress
''---------------------------------------------------------------------------------
Class REGISTER_AN_X1_TIMERS_SGMIIPLUSR_X1_blockaddress
    Private write_BlockAddress_value
    Private read_BlockAddress_value
    Private flag_BlockAddress

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

    Property Get get_BlockAddress
        get_BlockAddress = read_BlockAddress_value
    End Property

    Property Let set_BlockAddress(aData)
        write_BlockAddress_value = aData
        flag_BlockAddress        = &H1
    End Property

    Property Get read_BlockAddress
        read
        read_BlockAddress = read_BlockAddress_value
    End Property

    Property Let write_BlockAddress(aData)
        set_BlockAddress = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_BlockAddress_value = rightShift(data_low, 4) and &H7ff

    End Sub

    Sub write
        If flag_BlockAddress = &H0 Then read
        If flag_BlockAddress = &H0 Then write_BlockAddress_value = get_BlockAddress

        regValue = leftShift((write_BlockAddress_value and &H7ff), 4)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_BlockAddress_value = rightShift(data_low, 4) and &H7ff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_BlockAddress_value = &H0
        flag_BlockAddress        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class AN_X1_TIMERS_SGMIIPLUSR_X1_INSTANCE

    Public cl37_restart
    Public cl37_ack
    Public cl37_error
    Public cl73_break_link
    Public cl73_error
    Public cl73_dme_lock
    Public link_up
    Public link_fail_inhibit_timer_cl72
    Public link_fail_inhibit_timer_not_cl72
    Public pd_sd_timer
    Public cl72_max_wait_timer
    Public cl72_wait_timer
    Public ignore_link_timer
    Public dme_page_timer
    Public sgmii_cl73_timer_type_sgmiiplusr_x1
    Public blockaddress


    Public default function Init(aBaseAddr)
        Set cl37_restart = (New REGISTER_AN_X1_TIMERS_SGMIIPLUSR_X1_cl37_restart)(aBaseAddr, 16)
        Set cl37_ack = (New REGISTER_AN_X1_TIMERS_SGMIIPLUSR_X1_cl37_ack)(aBaseAddr, 16)
        Set cl37_error = (New REGISTER_AN_X1_TIMERS_SGMIIPLUSR_X1_cl37_error)(aBaseAddr, 16)
        Set cl73_break_link = (New REGISTER_AN_X1_TIMERS_SGMIIPLUSR_X1_cl73_break_link)(aBaseAddr, 16)
        Set cl73_error = (New REGISTER_AN_X1_TIMERS_SGMIIPLUSR_X1_cl73_error)(aBaseAddr, 16)
        Set cl73_dme_lock = (New REGISTER_AN_X1_TIMERS_SGMIIPLUSR_X1_cl73_dme_lock)(aBaseAddr, 16)
        Set link_up = (New REGISTER_AN_X1_TIMERS_SGMIIPLUSR_X1_link_up)(aBaseAddr, 16)
        Set link_fail_inhibit_timer_cl72 = (New REGISTER_AN_X1_TIMERS_SGMIIPLUSR_X1_link_fail_inhibit_timer_cl72)(aBaseAddr, 16)
        Set link_fail_inhibit_timer_not_cl72 = (New REGISTER_AN_X1_TIMERS_SGMIIPLUSR_X1_link_fail_inhibit_timer_not_cl72)(aBaseAddr, 16)
        Set pd_sd_timer = (New REGISTER_AN_X1_TIMERS_SGMIIPLUSR_X1_pd_sd_timer)(aBaseAddr, 16)
        Set cl72_max_wait_timer = (New REGISTER_AN_X1_TIMERS_SGMIIPLUSR_X1_cl72_max_wait_timer)(aBaseAddr, 16)
        Set cl72_wait_timer = (New REGISTER_AN_X1_TIMERS_SGMIIPLUSR_X1_cl72_wait_timer)(aBaseAddr, 16)
        Set ignore_link_timer = (New REGISTER_AN_X1_TIMERS_SGMIIPLUSR_X1_ignore_link_timer)(aBaseAddr, 16)
        Set dme_page_timer = (New REGISTER_AN_X1_TIMERS_SGMIIPLUSR_X1_dme_page_timer)(aBaseAddr, 16)
        Set sgmii_cl73_timer_type_sgmiiplusr_x1 = (New REGISTER_AN_X1_TIMERS_SGMIIPLUSR_X1_sgmii_cl73_timer_type_sgmiiplusr_x1)(aBaseAddr, 16)
        Set blockaddress = (New REGISTER_AN_X1_TIMERS_SGMIIPLUSR_X1_blockaddress)(aBaseAddr, 16)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set AN_X1_TIMERS_SGMIIPLUSR_X1 = CreateObject("System.Collections.ArrayList")
AN_X1_TIMERS_SGMIIPLUSR_X1.Add ((New AN_X1_TIMERS_SGMIIPLUSR_X1_INSTANCE)(&H4aed24a0))


